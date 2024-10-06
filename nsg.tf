#To create a network security group 
resource "azurerm_network_security_group" "nsg1" {
    name = "nsg1"
    resource_group_name = "${var.rgn}"
    location = "${var.location_name}"
    depends_on = [azurerm_subnet.subnet2]


    security_rule {
        name                        = "Allow_Inbound_VM1_80"
        priority                    = 100
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "80"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
    }

    security_rule {
        name                        = "Allow_Inbound_VM1_443"
        priority                    = 120
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "443"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
    }

    security_rule {
        name                        = "Allow_Inbound_appgateway_ports"
        priority                    = 140
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "65200-65535"                        #These ports needs to keep open for azure infrastructure communication
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
    }
}

#To associate the Network security group to nic1
resource "azurerm_network_interface_security_group_association" "nsg_associ1" {
    network_interface_id = "${azurerm_network_interface.nic1.id}"
    network_security_group_id = "${azurerm_network_security_group.nsg1.id}" 
}

#To associate the Network security group to nic2
resource "azurerm_network_interface_security_group_association" "nsg_associ2" {
    network_interface_id = "${azurerm_network_interface.nic2.id}"
    network_security_group_id = "${azurerm_network_security_group.nsg1.id}"
}

#To associate the Network security group to subnet2
resource "azurerm_subnet_network_security_group_association" "nsg_associ3" {
    subnet_id = "${azurerm_subnet.subnet2.id}"
    network_security_group_id = "${azurerm_network_security_group.nsg1.id}"
}