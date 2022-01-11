#!/bin/sh
if [ $1 == "info" ]
then
	echo "CPU:"
	echo "Mode:      $(cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference)"
	echo "NoTurbo:   $(cat /sys/devices/system/cpu/intel_pstate/no_turbo)"
	echo "Scheme:    $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)"
	echo "Mx-Freq:   $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq | cut -b 1-4)"
	echo "Core0:     $(cat /proc/cpuinfo | awk '/cpu MHz/ {print $4}' | awk 'FNR == 1 {print}' | cut -b 1-6)"
	echo "Core1:     $(cat /proc/cpuinfo | awk '/cpu MHz/ {print $4}' | awk 'FNR == 2 {print}' | cut -b 1-6)"
	echo "Core2:     $(cat /proc/cpuinfo | awk '/cpu MHz/ {print $4}' | awk 'FNR == 3 {print}' | cut -b 1-6)"
	echo "Core3:     $(cat /proc/cpuinfo | awk '/cpu MHz/ {print $4}' | awk 'FNR == 4 {print}' | cut -b 1-6)"
	echo
	echo "BAT:"
	echo "Limit:     $(cat /sys/class/power_supply/BAT0/charge_control_end_threshold)"
	echo "Capacity:  $(cat /sys/class/power_supply/BAT0/capacity)"
	echo "Status:    $(cat /sys/class/power_supply/BAT0/status)"

elif [ $1 == "bat" ]
then
	cat "/sys/class/power_supply/BAT0/uevent"

elif [ $1 == "limit" ]
then
	sudo -S sh -c "echo $2 > /sys/class/power_supply/BAT0/charge_control_end_threshold"

elif [ $1 == "power" ]
then
	sudo -S sh -c "echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo"
	sudo -S sh -c "echo power > /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference"
	sudo -S sh -c "echo power > /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_preference"
	sudo -S sh -c "echo power > /sys/devices/system/cpu/cpu2/cpufreq/energy_performance_preference"
	sudo -S sh -c "echo power > /sys/devices/system/cpu/cpu3/cpufreq/energy_performance_preference"

elif [ $1 == "balance" ]
then
	sudo -S sh -c "echo balance_power > /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference"
	sudo -S sh -c "echo balance_power > /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_preference"
	sudo -S sh -c "echo balance_power > /sys/devices/system/cpu/cpu2/cpufreq/energy_performance_preference"
	sudo -S sh -c "echo balance_power > /sys/devices/system/cpu/cpu3/cpufreq/energy_performance_preference"

elif [ $1 == "performance" ]
then
	sudo -S sh -c "echo 0 > /sys/devices/system/cpu/intel_pstate/no_turbo"	
	sudo -S sh -c "echo performance > /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference"
	sudo -S sh -c "echo performance > /sys/devices/system/cpu/cpu1/cpufreq/energy_performance_preference"
	sudo -S sh -c "echo performance > /sys/devices/system/cpu/cpu2/cpufreq/energy_performance_preference"
	sudo -S sh -c "echo performance > /sys/devices/system/cpu/cpu3/cpufreq/energy_performance_preference"
fi