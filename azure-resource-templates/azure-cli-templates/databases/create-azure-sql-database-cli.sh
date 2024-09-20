# Crear una base de datos SQL en Azure mediante Azure CLI

# Variables
resourceGroup="rgvisualStudio"
location="centralus"
serverName="jezus85"
adminUser="JezuzAdmin"
adminPassword="YourStrongPassword123"  # Cambia esta contraseña
databaseName="bd_Designlabs"
performanceTier="GP_S_Gen5_1"
computeModel="Serverless"
backupRedundancy="Local"

# Crear un grupo de recursos
az group create --name $resourceGroup --location $location

# Crear un servidor SQL
az sql server create --name $serverName \
  --resource-group $resourceGroup \
  --location $location \
  --admin-user $adminUser \
  --admin-password $adminPassword

# Configurar las reglas de firewall para permitir el acceso desde la IP actual
az sql server firewall-rule create --resource-group $resourceGroup \
  --server $serverName --name AllowMyIP --start-ip-address $(curl ifconfig.me) --end-ip-address $(curl ifconfig.me)

# Crear la base de datos SQL con el nivel de servicio y redundancia especificada
az sql db create --resource-group $resourceGroup \
  --server $serverName \
  --name $databaseName \
  --service-objective $performanceTier \
  --compute-model $computeModel \
  --backup-storage-redundancy $backupRedundancy
