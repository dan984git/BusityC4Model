workspace {

    model {
        user = person "Usuario" "Usuario que puede acceder a la información del transporte público"
        conductorUser = person "Conductor" "Dará información GPS y actualizará el proceso de su ruta"
        
        firebase = softwaresystem "Firebase" "Almacena toda la información de la aplicación y gestiona el login/registe/Passwork-Backup del usuario." "Existing System"
        googleMaps = softwaresystem "Google Maps" "Directions API - Maps JavaScript API" "Existing System"
        
        enterprise "Aplicación 'Busity'" {
            softwareSystem = softwareSystem "Sistema Busity" "Pueden visualizar la información del transporte público (Estaciones/Rutas/Buses)" {
                webapp = container "Aplicación Web" "Template HTML responsivo para Web y Móvil." "Responsive HTML Template - VUE" 
                webRender = container "Aplicación Vue.js" "Proporciona toda la funcionalidad del Sistema de Conferencias por Internet a los Usuarios por medio de un Navegador de Internet" "Vue" {
                    tags Webrender
                }
                mobileRender = container "Aplicación Ionic 6" "Proporciona un conjunto de funciones para todos los usuarios dependiendo su Rol, disponible para S.O Android y iOS" "Ionic 6" {
                    tags Mobilerender
                }
                
                apiGateway = container "Aplicación API" "Conecta con toda las funcionalidades del sistema de gestión de conferencias." "Software System"{
                    
                    signInCont = component "Sign In/Sign Up Controlador" "Los usuarios pueden registrarse o inicar sesión a la aplicación Busity" "Node.js"
                    backUpCont = component "Reset Password Controlador" "Cambio o recuperación de contraseñas" "Node.js"
                    busityCont = component "Controlador de información" "Provee información de los componentes de busity" "Node.js"
                    securityComp = component "Componente de Seguridad" "Provee funcionalidad relacionada a sign in/sign up/changing password/etc"
                    mapComp = component "Componente Mapa" "Renderiza el mapa de Google Maps"
                    ruteComp = component "Componente de Rutas" "Renderiza las rutas usando la información de firebase y el mapa de Google Maps"
                    stationComp = component "Componente de Estaciones" "Renderiza las estaciones usando la información de firebase y el mapa de Google Maps"
                    gpsComp = component "Componente de GPS de Buses" "Renderiza los Buses en el mapa usando la información de firebase y el mapa de Google Maps"
                    preferencesComp = component "Componente de Preferencias" "Renderiza las preferencias de usuario usando información de firebase y el mapa de Google Maps"
                    takeMeComp = component "Componente de Llevame" "Renderiza las direcciones y guías para llegar a un sitio usando el Directions API de Google Maps"
                }
            }
        }
        
        # relationships to/from systemContext
        user -> softwareSystem "Usuario que puede acceder a la información del transporte público"
        conductorUser -> softwareSystem "Dará información GPS y actualizará el proceso de su ruta"
        softwareSystem -> googleMaps "Directions API - Maps JavaScript API"
        softwareSystem -> firebase "Almacena toda la información de la aplicación y gestiona el login/registe/Passwork-Backup del usuario."
        
        # relationships to/from containers
        user -> webapp "Visita busity.com usando" "HTTPS"
        user -> mobileRender "Usuario que puede acceder a la información del transporte público"
        conductorUser -> mobileRender "Dará información GPS y actualizará el proceso de su ruta"
        webapp -> webRender "Entrega al navegador web del cliente"
        webRender -> apiGateway "Llamadas API por: " "JSON/HTTPS"
        mobileRender -> apiGateway "Llamadas API por: " "JSON/HTTPS"
        apiGateway -> firebase "Lee y escribe de Firebase"
        apiGateway -> googleMaps "Consulta Direcciones y Utiliza API para renderizar el Mapa"
        
        # relationships to/from components
        webRender -> signInCont "Makes API calls to" "JSON/HTTPS"
        webRender -> backUpCont "Makes API calls to" "JSON/HTTPS"
        webRender -> busityCont "Makes API calls to" "JSON/HTTPS"
        mobileRender -> signInCont "Makes API calls to" "JSON/HTTPS"
        mobileRender -> backUpCont "Makes API calls to" "JSON/HTTPS" 
        mobileRender -> busityCont "Makes API calls to" "JSON/HTTPS"
        signInCont -> securityComp "Uses"
        backUpCont -> securityComp "Uses"
        securityComp -> firebase "Lee y escribe de"
        busityCont -> mapComp "Uses"
        busityCont -> ruteComp "Uses"
        busityCont -> stationComp "Uses"
        busityCont -> gpsComp "Uses"
        busityCont -> preferencesComp "Uses"
        busityCont -> takeMeComp "Uses"
        mapComp -> firebase "Lee de"
        mapComp -> googleMaps "Usa"
        ruteComp -> firebase "Lee de"
        ruteComp -> googleMaps "Usa"
        stationComp -> firebase "Lee de"
        stationComp -> googleMaps "Usa"
        gpsComp -> firebase "Lee de"
        gpsComp -> googleMaps "Usa"
        preferencesComp -> firebase "Lee de"
        takeMeComp -> googleMaps "Usa"
    }
    
    views {
        systemContext softwareSystem "SistemadeConferenciaC1" "Sistema de conferencias C1 System" {
            include *
            animation {
                user
                conductorUser
                firebase
            }
            autoLayout
        }
        container softwareSystem "SistemadeConferenciaC2" "Sistema de conferencias C2 Containers" {
            include *
            autoLayout
        }
        component apiGateway "SistemadeConferenciaC3" "Sistema de conferencias C3 Components" {
            include *
            autoLayout
        }
        styles {
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Person" {
                shape person
                background #08427b
                color #ffffff
            }
            element "Container" {
                background #1061B0
                color #ffffff
            }
            element "Database" {
                shape Cylinder
                background #1061B0
                color #ffffff
            }
            element "Component" {
                background #63BEF2
                color #ffffff
            }
            element "Webrender" {
                shape WebBrowser
            }
            element "Mobilerender" {
                shape MobileDeviceLandscape
            }
            element "Existing System" {
                background #999999
                color #ffffff
                
            }
        }
    }

}