Import-Module 'C:\Program Files\Microsoft SDKs\Azure\PowerShell\ServiceManagement\Azure\Azure.psd1'
Import-Module 'C:\Program Files\Microsoft SDKs\Azure\PowerShell\ServiceManagement\Azure\ExpressRoute\ExpressRoute.psd1'
$ShortCircuit = New-Object System.Object
$Select_ExpressRoute_Subscription=select-AzurermSubscription -SubscriptionId "af8229c5-6fad-404a-bda8-0dab2d7ced59"
write-host "Obtaining ExpressRoute Circuit Details .." -ForegroundColor Cyan -NoNewline
$circuits = Get-AzureRmExpressRouteCircuit -ResourceGroupName "Honeywell-Corp-ARM-ExpressRoute-Netbond"
write-host "..Done" -ForegroundColor Cyan
####
##Loop round each ExpressRoute Circuit in the subscription
####
foreach ($i in $circuits.name) {
    ####
    ## Display ExpressRoute circuit details
    ####
    $circuit = Get-AzureRmExpressRouteCircuit -Name $i  -ResourceGroupName "Honeywell-Corp-ARM-ExpressRoute-Netbond"
    write-host "Provider:" $circuit.ServiceProviderProperties.ServiceProviderName.PadRight(15) "Bandwidth:" $circuit.ServiceProviderProperties.BandwidthInMbps "Mbps    Name:" $circuit.name.PadRight(40) "Provisioning State:" $circuit.ProvisioningState.PadRight(15) -ForegroundColor Cyan
    write-host "Sku:" $circuit.Sku.Tier $circuit.Sku.Family.PadRight(15)  "Service Key:" $circuit.ServiceKey $circuit.ServiceKey-ForegroundColor Cyan

   

    $authorizations=Get-AzureRmExpressRouteCircuitAuthorization -ExpressrouteCircuit $circuit 
    if ($authorizations.count -eq 10) {
        write-host "Authorisation Count = " $authorizations.Count "This Circuit is full to capacity" -ForegroundColor Red
        } else {
        write-host "Authorisation Count = " $authorizations.Count -ForegroundColor Cyan
    }
    ####
    ## Loop round each authorisation and display infomation
    ####

    for ($m=0; $m -lt $authorizations.count; $m++) {
 
        Write-Host $authorizations[$m].name.padright(30) $authorizations[$m].ProvisioningState.padright(15)
    }


}





