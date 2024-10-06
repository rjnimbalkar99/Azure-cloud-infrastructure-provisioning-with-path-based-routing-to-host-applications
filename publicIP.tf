#To create a static frentend public ip address for application gateway
resource "azurerm_public_ip" "ag_public_ip" {
    name = "ag_public_ip"
    resource_group_name = "${var.rgn}"
    location = "${var.location_name}"
    ip_version = "IPv4"
    allocation_method = "Static"
}

#To create a static frentend public ip address for firewall
resource "azurerm_public_ip" "firewall_public_ip" {
    name = "firewall_public_ip"
    resource_group_name = "${var.rgn}"
    location = "${var.location_name}"
    ip_version = "IPv4"
    allocation_method = "Static"    
}
 
