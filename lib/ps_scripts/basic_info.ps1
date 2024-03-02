[System.IO.Ports.SerialPort]::GetPortNames()

$port = New-Object System.IO.Ports.SerialPort COM4,115200,None,8,one
$port.Open();

$totalMmeory = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -Property TotalVisibleMemorySize
$freeMemory = Get-WmiObject -Class Win32_OperatingSystem | Select-Object -Property FreePhysicalMemory
$processorInfo = Get-WmiObject -Class Win32_Processor | Select-Object -Property LoadPercentage

$dataMem = Out-String -InputObject $totalMmeory
$res1 = $dataMem -split "\n"

$dataMemLibre = Out-String -InputObject $freeMemory
$res2 = $dataMemLibre -split "\n"
$dataProccesorLoad = Out-String -InputObject $processorInfo
$res3 = $dataProccesorLoad -split "\n"

$memoriaUsada = (([int64]$res1[3].Trim() / 1024) - ([int64]$res2[3].Trim() / 1024))

$jsonDatos = @{
    "memoria_total" = ($res1[3].Trim() / 1024)
    "memoria_disponible" = ($res2[3].Trim() / 1024)
    "memoria_uso" = $memoriaUsada
    # "top_eventos" = @{"data" = $topProcesses} | ConvertTo-Json -Compress
    "carga_cpu" = $res3[3].Trim()
    #"proce" = $topProcesses
} | ConvertTo-Json -Compress

Write-Output $jsonDatos
$bytes = [System.Text.Encoding]::UTF8.GetBytes($jsonDatos)
$port.Write($bytes);
Write-Output $port.ReadLine();
# Start-Sleep -Seconds 2
$port.Close();