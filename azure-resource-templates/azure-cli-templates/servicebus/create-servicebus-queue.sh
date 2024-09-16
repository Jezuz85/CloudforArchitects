#!/bin/bash

# Variables
resourceGroupName="myResourceGroup"
namespaceName="myServiceBusNamespace"
queueName="myQueue"
maxDeliveryCount=5
lockDuration="PT5M"  # 5 minutos

# Crear la cola en el namespace de Azure Service Bus
az servicebus queue create \
  --resource-group $resourceGroupName \
  --namespace-name $namespaceName \
  --name $queueName \
  --max-delivery-count $maxDeliveryCount \
  --lock-duration $lockDuration

echo "Cola '$queueName' creada exitosamente en el namespace '$namespaceName'."
