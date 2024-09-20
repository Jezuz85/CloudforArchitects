# Crear una base de datos SQL en Azure mediante PowerShell

# Variables
$resourceGroup = "rgvisualStudio"
$location = "Central US"
$serverName = "jezus85"
$adminUser = "JezuzAdmin"
$adminPassword = "YourStrongPassword123" # Cambia esta contraseña
$databaseName = "bd_Designlabs"
$performanceTier = "GP_S_Gen5_1"
$computeModel = "Serverless"
$backupRedundancy = "Local"

# Crear un grupo de recursos
New-AzResourceGroup -Name $resourceGroup -Location $location

# Crear un servidor SQL
New-AzSqlServer -ResourceGroupName $resourceGroup `
    -ServerName $serverName `
    -Location $location `
    -SqlAdministratorCredentials (New-Object System.Management.Automation.PSCredential($adminUser, (ConvertTo-SecureString $adminPassword -AsPlainText -Force)))

# Configurar las reglas de firewall para permitir acceso desde la IP actual
$myIP = (Invoke-RestMethod ifconfig.me)
New-AzSqlServerFirewallRule -ResourceGroupName $resourceGroup `
    -ServerName $serverName `
    -FirewallRuleName "AllowMyIP" `
    -StartIpAddress $myIP `
    -EndIpAddress $myIP

# Crear la base de datos SQL con el nivel de servicio y redundancia especificada
New-AzSqlDatabase -ResourceGroupName $resourceGroup `
    -ServerName $serverName `
    -DatabaseName $databaseName `
    -RequestedServiceObjectiveName $performanceTier `
    -ComputeModel $computeModel `
    -BackupStorageRedundancy $backupRedundancy
