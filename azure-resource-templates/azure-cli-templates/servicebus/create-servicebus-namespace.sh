#!/bin/bash

# Variables
resourceGroupName="myResourceGroup"
location="EastUS"
namespaceName="myServiceBusNamespace"
sku="Standard"  # Puede ser Basic, Standard o Premium

# Crear el grupo de recursos si no existe
az group create --name $resourceGroupName --location $location

# Crear el namespace de Azure Service Bus
az servicebus namespace create \
  --resource-group $resourceGroupName \
  --name $namespaceName \
  --location $location \
  --sku $sku

echo "Namespace de Azure Service Bus '$namespaceName' creado exitosamente."
