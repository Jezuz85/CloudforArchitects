# Variables
$resourceGroupName = "myResourceGroup"
$location = "EastUS"
$namespaceName = "myServiceBusNamespace"
$sku = "Standard" # Puede ser Basic, Standard o Premium

# Iniciar sesión en Azure
Connect-AzAccount

# Crear el grupo de recursos si no existe
if (-Not (Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroupName -Location $location
}

# Crear el namespace de Service Bus
New-AzServiceBusNamespace -ResourceGroupName $resourceGroupName `
                          -NamespaceName $namespaceName `
                          -Location $location `
                          -SkuName $sku

Write-Host "Namespace de Azure Service Bus '$namespaceName' creado exitosamente."
