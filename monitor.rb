# frozen_string_literal: true
require 'win32ole'

wmi = WIN32OLE.connect("winmgmts://")

loop do
  # Get CPU load
  cpu = wmi.ExecQuery("SELECT LoadPercentage FROM Win32_Processor")
  cpu.each do |c|
    puts "CPU Load: #{c.LoadPercentage}%"
  end

  # Get total and available memory
  memory = wmi.ExecQuery("SELECT TotalVisibleMemorySize, FreePhysicalMemory FROM Win32_OperatingSystem")
  memory.each do |m|
    total_memory = m.TotalVisibleMemorySize.to_f / 1024
    free_memory = m.FreePhysicalMemory.to_f / 1024
    used_memory = total_memory - free_memory
    mem_usage_percent = (used_memory / total_memory) * 100
    puts "Total Memory: #{total_memory.round(2)} MB"
    puts "Free Memory: #{free_memory.round(2)} MB"
    puts "Used Memory: #{used_memory.round(2)} MB"
    puts "Memory Usage: #{mem_usage_percent.round(2)}%"
  end
  GC.start
end