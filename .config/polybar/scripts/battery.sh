#!/bin/bash

# Function to safely read battery info
read_battery_info() {
    local bat=$1
    local bat_path="/sys/class/power_supply/$bat"
    
    # Check if battery exists
    if [[ ! -d "$bat_path" ]]; then
        return 1
    fi
    
    local status=$(cat "$bat_path/status" 2>/dev/null)
    
    # Try capacity file first (percentage directly available)
    if [[ -f "$bat_path/capacity" ]]; then
        local capacity=$(cat "$bat_path/capacity" 2>/dev/null)
        local energy_full=0
        
        # Try to get design capacity for weighting
        if [[ -f "$bat_path/energy_full_design" ]]; then
            energy_full=$(cat "$bat_path/energy_full_design" 2>/dev/null)
        elif [[ -f "$bat_path/charge_full_design" ]]; then
            energy_full=$(cat "$bat_path/charge_full_design" 2>/dev/null)
        fi
        
        echo "$capacity $energy_full $status"
        return 0
    fi
    
    # No capacity file - calculate from energy_now/energy_full or charge_now/charge_full
    local now=0
    local full=0
    
    if [[ -f "$bat_path/energy_now" ]] && [[ -f "$bat_path/energy_full" ]]; then
        now=$(cat "$bat_path/energy_now" 2>/dev/null)
        full=$(cat "$bat_path/energy_full" 2>/dev/null)
    elif [[ -f "$bat_path/energy_now" ]] && [[ -f "$bat_path/energy_full_design" ]]; then
        now=$(cat "$bat_path/energy_now" 2>/dev/null)
        full=$(cat "$bat_path/energy_full_design" 2>/dev/null)
    elif [[ -f "$bat_path/charge_now" ]] && [[ -f "$bat_path/charge_full" ]]; then
        now=$(cat "$bat_path/charge_now" 2>/dev/null)
        full=$(cat "$bat_path/charge_full" 2>/dev/null)
    elif [[ -f "$bat_path/charge_now" ]] && [[ -f "$bat_path/charge_full_design" ]]; then
        now=$(cat "$bat_path/charge_now" 2>/dev/null)
        full=$(cat "$bat_path/charge_full_design" 2>/dev/null)
    fi
    
    # Calculate percentage
    if [[ -n "$now" ]] && [[ -n "$full" ]] && [[ "$full" -gt 0 ]]; then
        local capacity=$(( (now * 100) / full ))
        echo "$capacity $full $status"
        return 0
    fi
    
    return 1
}

# Read BAT0
bat0_info=$(read_battery_info "BAT0")
if [[ $? -ne 0 ]]; then
    echo "Error: BAT0 not found"
    exit 1
fi

read bat0_capacity bat0_energy bat0_status <<< "$bat0_info"
bat0_wh=$((bat0_energy / 1000000))

# Try to read BAT1
bat1_info=$(read_battery_info "BAT1")
if [[ $? -eq 0 ]]; then
    read bat1_capacity bat1_energy bat1_status <<< "$bat1_info"
    bat1_wh=$((bat1_energy / 1000000))
    
    # Calculate weighted average with both batteries
    weight1=24
    weight2=72
    
    if [[ "$bat0_wh" -le 25 && "$bat1_wh" -le 25 ]]; then
        average=$(( (bat0_capacity + bat1_capacity) / 2 ))
    else
        total_weight=$((weight1 + weight2))
        average=$(( (bat0_capacity * weight1 + bat1_capacity * weight2) / total_weight ))
    fi
    
    # Check if either battery is charging
    if [[ "$bat0_status" == "Charging" || "$bat1_status" == "Charging" ]]; then
        charging=true
    else
        charging=false
    fi
else
    # Only BAT0 exists or BAT1 not readable, use BAT0 capacity directly
    average=$bat0_capacity
    
    if [[ "$bat0_status" == "Charging" ]]; then
        charging=true
    else
        charging=false
    fi
fi

# Output
if [ "$charging" == true ]; then
    echo "+$average%"
else
    echo "$average%"
fi
