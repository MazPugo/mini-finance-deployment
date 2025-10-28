#!/bin/bash
# Import existing Azure resources into Terraform state
# Run this script from your terraform directory:  ./import_all.sh

SUBSCRIPTION_ID="a0cbe0a4-e585-4e94-b04a-15f8e68d5d7a"
RESOURCE_GROUP="mini-finance-rg"

echo "Importing Azure resources into Terraform state..."
echo "Using subscription: $SUBSCRIPTION_ID"
echo "Using resource group: $RESOURCE_GROUP"
echo "-----------------------------------------------------"

import_resource() {
  local name=$1
  local id=$2

  # Check if resource already exists in state
  if terraform state list | grep -q "$name"; then
    echo "⚠️  $name already exists in state — removing old reference..."
    terraform state rm "$name" >/dev/null
  fi

  echo "📦 Importing $name..."
  terraform import "$name" "$id"
  echo "✅ Imported: $name"
  echo "-----------------------------------------------------"
}

# Imports
import_resource "azurerm_resource_group.rg" \
"/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP"

import_resource "azurerm_virtual_network.vnet" \
"/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Network/virtualNetworks/mini-finance-vnet"

import_resource "azurerm_subnet.subnet" \
"/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Network/virtualNetworks/mini-finance-vnet/subnets/mini-finance-subnet"

import_resource "azurerm_network_security_group.nsg" \
"/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Network/networkSecurityGroups/mini-finance-nsg"

import_resource "azurerm_network_security_rule.ssh" \
"/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Network/networkSecurityGroups/mini-finance-nsg/securityRules/SSH"

import_resource "azurerm_network_security_rule.http" \
"/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Network/networkSecurityGroups/mini-finance-nsg/securityRules/HTTP"

import_resource "azurerm_public_ip.pub" \
"/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.Network/publicIPAddresses/mini-finance-pip"

echo "-----------------------------------------------------"
echo "🎉 All imports completed successfully!"
echo "Next step: run → terraform plan"
