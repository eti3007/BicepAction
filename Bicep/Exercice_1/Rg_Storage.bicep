// https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/best-practices
// https://fr.wikipedia.org/wiki/Camel_case


// Objectif : déployer un resource group et un compte de stockage en bicep en utilisant la notion de module
// lecture :  https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/modules

targetScope = 'subscription'

param location string 
param rgName string
param storageAccountName string
param skuName string
param kindName string


module rgModule 'Rg.bicep' = {
  name: 'deployRgModule'  
  params: {
    rgName : rgName 
    location : location
  } 
}

module storageModule 'Storage.bicep' = {
  name: 'deployStorageModule'
  scope: resourceGroup(rgName) // https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions-scope#resource-group-example
  params: {
    storageAccountName: storageAccountName
    location: location
    skuName: skuName
    kindName: kindName
  }
  dependsOn: [
    rgModule
    // à compléter. cf https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/resource-declaration?tabs=azure-powershell#dependencies
    // il faut un dependsOn car le RG est créé depuis un Module !!
  ]
}

// testez votre code 
// az deployment sub create --location westeurope --template-file ./Bicep/Exercice_1/Rg_Storage.bicep --parameters ./Bicep/Exercice_1/Rg_Storage.parameters.json
// az deployment sub validate --location westeurope --template-file ./Rg_Storage.bicep --parameters ./Rg_Storage.parameters.json
