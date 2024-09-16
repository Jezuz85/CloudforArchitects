# Variables
$resourceGroupName = "rgvisualStudio"
$location = "EastUS2"
$appServicePlanName = "app-service-plan-ecommerce"
$appServiceName = "app-service-ecomerce"
$sku = "S1"  # Escala SKU para el App Service Plan
$runtimeStack = "DOTNETCORE|8.0"  # Stack de ejecución para .NET 8
$operatingSystem = "Windows"

# Iniciar sesión en Azure
Connect-AzAccount

# Crear el grupo de recursos si no existe
if (-Not (Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroupName -Location $location
}

# Crear el App Service Plan
New-AzAppServicePlan -Name $appServicePlanName `
                     -Location $location `
                     -ResourceGroupName $resourceGroupName `
                     -Sku $sku `
                     -OperatingSystem $operatingSystem

# Crear la aplicación web (App Service)
New-AzWebApp -Name $appServiceName `
             -Location $location `
             -AppServicePlan $appServicePlanName `
             -ResourceGroupName $resourceGroupName `
             -RuntimeStack $runtimeStack

Write-Host "App Service '$appServiceName' creado exitosamente en el App Service Plan '$appServicePlanName'."
