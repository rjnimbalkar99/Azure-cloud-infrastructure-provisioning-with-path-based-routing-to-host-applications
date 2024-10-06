# To create a resource group
resource "azurerm_resource_group" "rg1" {
    name = "${var.rgn}"
    location = "${var.location_name}"
}

# to create Virtual network
resource "azurerm_virtual_network" "Vnet1" {
    name  = "${var.Vnetn}"
    resource_group_name = "${var.rgn}"
    location = "${var.location_name}"
    address_space = ["10.0.0.0/8"]
    depends_on = [azurerm_resource_group.rg1]
}

# To create a subnet1
resource "azurerm_subnet" "AzureFirewallSubnet" {      #Subnet for Azure firewall
    name = "${var.subn}"
    virtual_network_name = "${var.Vnetn}"
    resource_group_name = "${var.rgn}"
    address_prefixes = ["10.0.1.0/24"]  
    depends_on = [azurerm_virtual_network.Vnet1] 
}

# To create a subnet2
resource "azurerm_subnet" "subnet2" {      #Subnet for load balancer
    name = "${var.subn1}"
    virtual_network_name = "${var.Vnetn}"
    resource_group_name = "${var.rgn}"
    address_prefixes = ["10.0.2.0/24"]  
    depends_on = [azurerm_virtual_network.Vnet1] 
}

# To create a subnet3
resource "azurerm_subnet" "subnet3" {      #Subnet for network interface 1
    name = "${var.subn2}"
    virtual_network_name = "${var.Vnetn}"
    resource_group_name ="${var.rgn}"
    address_prefixes = ["10.0.3.0/24"]  
    depends_on = [azurerm_virtual_network.Vnet1] 
}

# To create a subnet4
resource "azurerm_subnet" "subnet4" {      #Subnet for network interface 2
    name = "${var.subn3}"
    virtual_network_name = "${var.Vnetn}"
    resource_group_name ="${var.rgn}"
    address_prefixes = ["10.0.4.0/24"]  
    depends_on = [azurerm_virtual_network.Vnet1] 
}