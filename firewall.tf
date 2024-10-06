#To create azure firewall 
resource "azurerm_firewall" "Vnet_firewall" {
  name                = "Vnet_firewall"
  location            = "${var.location_name}"
  resource_group_name = "${var.rgn}"
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id = "${azurerm_firewall_policy.fe.id}"    #Assign azure policy to azure firewall
  depends_on = [azurerm_firewall_policy.fe, azurerm_firewall_policy_rule_collection_group.fr]

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.AzureFirewallSubnet.id
    public_ip_address_id = azurerm_public_ip.firewall_public_ip.id
  }
}

#To create a azure firewall policy
resource "azurerm_firewall_policy" "fe" {
  name                = "fe"
  location            = "${var.location_name}"
  resource_group_name = "${var.rgn}"
  depends_on = [azurerm_virtual_network.Vnet1]
}

#To create a network rule and associate it to firewall policy
 resource "azurerm_firewall_policy_rule_collection_group" "fr" {
  name               = "fr"
  firewall_policy_id = "${azurerm_firewall_policy.fe.id}"        #Assign network rules to azure policy 
  priority           = 100  
  depends_on = [azurerm_firewall_policy.fe]                       

  network_rule_collection {
    name     = "network_rule_collection1"
    priority = 110
    action   = "Allow"
    rule {
      name                  = "network_rule_collection1_rule1"
      protocols             = ["TCP"]
      source_addresses      = ["*"]
      destination_addresses = ["*"]
      destination_ports     = ["80"]
    }
  }
 }

  
  