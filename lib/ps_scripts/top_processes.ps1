[System.IO.Ports.SerialPort]::GetPortNames()

$port = New-Object System.IO.Ports.SerialPort COM4,115200,None,8,one
$port.Open();

$topProcesses = Get-WmiObject -Class Win32_PerfFormattedData_PerfProc_Process |
                Where-Object {$_.name -ne "_Total" -and $_.name -ne "Idle"} |
                Sort-Object -Property PercentProcessorTime -Descending |
                Select-Object -First 5 -Property Name, PercentProcessorTime

$jsonDatos = @{
    "top5" = $topProcesses
};

$bytes = [System.Text.Encoding]::UTF8.GetBytes($jsonDatos)
$port.Write($bytes);
Write-Output $port.ReadLine();

$port.Close();