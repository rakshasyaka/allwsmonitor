# Можно проверить на сетевой шаре версию клиента
$clientVersion = 1
$outFile = D:\examp.json

$computername = (gwmi win32_computersystem -ErrorAction SilentlyContinue).name
if($computername -eq $null){
    $wmiWarn  = 1
    $computername = $env:COMPUTERNAME
}


$AppEv = Get-WinEvent -LogName "application"
$SysEv = get-winevent -LogName "system"

# LD -- Last Day
# LogName System
$SysEvLDCrit = Get-WinEvent -FilterHashTable @{LogName='system'; Level=1; StartTime=((get-date).AddDays(-1))} -ErrorAction SilentlyContinue
$SysEvLDErr = Get-WinEvent -FilterHashTable @{LogName='system'; Level=2; StartTime=((get-date).AddDays(-1))} -ErrorAction SilentlyContinue
$SysEvLDWarn = Get-WinEvent -FilterHashTable @{LogName='system'; Level=3; StartTime=((get-date).AddDays(-1))} -ErrorAction SilentlyContinue
$SysEvLD_GroupCrit = $SysEvLDCrit | Group-Object -Property id -NoElement
$SysEvLD_GroupErr = $SysEvLDErr | Group-Object -Property id -NoElement
$SysEvLD_GroupWarn = $SysEvLDWarn | Group-Object -Property id -NoElement
'{' | Out-File $outFile -Append
'"report": {' | Out-File $outFile -Append
'"computer" : ' + $computername + "," | Out-File $outFile -Append
if($SysEvLD_GroupErr -ne $null){
    '"error" : {'
    foreach($event in $SysEvLD_GroupErr){
        '"id" : '+'"'+$event.Name+'",'

        <#
        write-host $event.Name" ; "$event.Count -ForegroundColor Cyan
        $SysEvLDErr | ? {$_.id -eq ($event.Name).Trim()} | select -First 1
        #>
    }
}

if($SysEvLD_GroupCrit -ne $null){
    foreach($event in $SysEvLD_GroupCrit){
        
    }
}




