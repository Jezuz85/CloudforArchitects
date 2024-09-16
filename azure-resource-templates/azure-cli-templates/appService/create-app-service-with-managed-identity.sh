#!/bin/bash

# Variables
$resourceGroupName="rgvisualStudio"
$location="EastUS2"
$appServicePlanName="app-service-plan-ecommerce"
$appServiceName="app-service-ecomerce-receptor"
$sku="S1"  # Escala SKU para el App Service Plan
$runtimeStack="dotnet:8"  # Stack de ejecución para .NET 8 (LTS)
$osType="Windows"

# Crear el App Service Plan
az appservice plan create \
  --name $appServicePlanName \
  --resource-group $resourceGroupName \
  --location $location \
  --sku $sku

# Crear la aplicación web (App Service)
az webapp create \
  --name $appServiceName \
  --resource-group $resourceGroupName \
  --plan $appServicePlanName \
  --runtime $runtimeStack

# Habilitar la Identidad Administrada Asignada por el Sistema
az webapp identity assign --resource-group $resourceGroupName --name $appServiceName

echo "App Service '$appServiceName' con identidad administrada habilitada creado exitosamente en '$location'."
