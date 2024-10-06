#To create a application gateway load balancer
resource "azurerm_application_gateway" "ag" {
  name                = "ag"
  resource_group_name = "${var.rgn}"
  location            = "${var.location_name}"
  depends_on = [azurerm_network_interface.nic1, azurerm_network_interface.nic2]
  

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gateway_ip_config"
    subnet_id = "${azurerm_subnet.subnet2.id}"                    #Assign a subnet to application gateway 
  }

  frontend_port {
    name = "fe_port"
    port = 80 
  }

  frontend_ip_configuration {
    name                 = "fe_ip_config"
    public_ip_address_id = "${azurerm_public_ip.ag_public_ip.id}"    #Assign public IP address 
  }

  backend_address_pool {
    name = "web1"
    ip_addresses = [
    "${azurerm_network_interface.nic1.private_ip_address}"     #Assign network interface 1 as target machines for backed pools
    ] 
  }

  backend_address_pool {
    name = "web2"
    ip_addresses = [ 
    "${azurerm_network_interface.nic2.private_ip_address}"     #Assign network interface 2 as target machines for backed pools
    ] 
  }

  backend_http_settings {
    name                  = "backend_http_config-1"
    cookie_based_affinity = "Disabled"
    path                  = "/budget-manager/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  backend_http_settings {
    name                  = "backend_http_config-2"
    cookie_based_affinity = "Disabled"
    path                  = "/profile-card/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "http_listener_config"
    frontend_ip_configuration_name = "fe_ip_config"
    frontend_port_name             = "fe_port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name = "routing_rule_config"
    priority = 9
    rule_type = "PathBasedRouting"
    url_path_map_name = "RoutingPath"
    http_listener_name = "http_listener_config"
  }

  url_path_map {                                                             #Create path based routing rules 
    name = "Routingpath"
    default_backend_address_pool_name = "web1"
    default_backend_http_settings_name = "backend_http_config-1"

    path_rule {
        name = "server1_routing_rule"
        backend_address_pool_name = "web1"
        backend_http_settings_name = "backend_http_config-1"
        paths = ["/budget-manager/*"]
    }

    path_rule {
        name = "server2_routing_rule"
        backend_address_pool_name = "web2"
        backend_http_settings_name = "backend_http_config-2"
        paths = ["/profile-card/*"]

    }
  }
}


