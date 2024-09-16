# Variables
$resourceGroupName = "myResourceGroup"
$namespaceName = "myServiceBusNamespace"
$queueName = "myQueue"
$maxDeliveryCount = 5
$lockDuration = "PT5M" # 5 minutos

# Crear la cola en el namespace de Service Bus
New-AzServiceBusQueue -ResourceGroupName $resourceGroupName `
                      -Namespace $namespaceName `
                      -QueueName $queueName `
                      -MaxDeliveryCount $maxDeliveryCount `
                      -LockDuration $lockDuration

Write-Host "Cola '$queueName' creada exitosamente en el namespace '$namespaceName'."
