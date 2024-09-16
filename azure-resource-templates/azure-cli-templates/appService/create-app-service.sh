#!/bin/bash

# Variables
resourceGroupName="rgvisualStudio"
location="EastUS2"
appServicePlanName="app-service-plan-ecommerce"
appServiceName="app-service-ecomerce"
sku="S1"  # Escala SKU para el App Service Plan
runtimeStack="DOTNETCORE:8.0"  # Stack de ejecución para .NET 8 (LTS)
osType="Windows"

# Crear el grupo de recursos si no existe
az group create --name $resourceGroupName --location $location

# Crear el App Service Plan
az appservice plan create \
  --name $appServicePlanName \
  --resource-group $resourceGroupName \
  --location $location \
  --sku $sku \
  --is-linux false

# Crear la aplicación web (App Service)
az webapp create \
  --name $appServiceName \
  --resource-group $resourceGroupName \
  --plan $appServicePlanName \
  --runtime $runtimeStack

echo "App Service '$appServiceName' creado exitosamente en el App Service Plan '$appServicePlanName'."
