workspace {

    model {
        user = person "Usuario" "Usuario que puede acceder a la información del transporte público"
        conductorUser = person "Conductor" "Dará información GPS y actualizará el proceso de su ruta"
        
        firebase = softwaresystem "Firebase" "Almacena toda la información de la aplicación y gestiona el login/registe/Passwork-Backup del usuario." "Existing System"
        googleMaps = softwaresystem "Google Maps" "Directions API - Maps JavaScript API" "Existing System"
        
        enterprise "Aplicación 'Busity'" {
            softwareSystem = softwareSystem "Sistema Busity" "Pueden visualizar la información del transporte público (Estaciones/Rutas/Buses)" {
                webapp = container "Aplicación Web" "Template HTML responsivo para Web y Móvil." "Responsive HTML Template - Angular/Ionic" 
                webRender = container "Aplicación Angular/Ionic" "Proporciona toda la funcionalidad del Sistema de Conferencias por Internet a los Usuarios por medio de un Navegador de Internet" "Angular/Ionic" {
                    tags Webrender
                }
                mobileRender = container "Aplicación Ionic 6" "Proporciona un conjunto de funciones para todos los usuarios dependiendo su Rol, disponible para S.O Android y iOS" "Ionic 6" {
                    tags Mobilerender
                }
                
                HttpClient = container "Aplicación" "Conecta con toda las funcionalidades del sistema de gestión de conferencias." "Software System"{
                    
                    authCont = component "Sign In/Sign Up/Reset Controlador" "Los usuarios pueden registrarse, inicar sesión o cambiar la contraseña en la aplicación Busity" "TypeScript"
                    MapaCont = component "Mapa Controlador" "Controla toda la funcionalidad que se encuentra dentro del componente de mapa" "TypeScript"
                    RutaCont = component "Rutas Controlador" "Controla todas las rutas de las diferentes coperativas y las carga en la página" "TypeScript"
                    EstFavCont = component "Estaciones favoritas Controlador" "Controla todas las estaciones favoritas del usuario." "TypeScript"
                    PerfilCont = component "Perfil usuario Controlador" "Controla todos los datos del usuario como reset, edit del usuario." "TypeScript"
                    authService = component "Auth Service" "Maneja todos los servicios de autenticación del usuario como Login,Register,ResetPassword,etc del usuario." "TypeScript"
                    dataService = component "Data Service" "Maneja todos las peticiones get/post/update/delete de la aplicación." "TypeScript"
                    GoogleMapsService = component "Google Maps Service" "Maneja el llamado a los APIs de GoogleMaps." "TypeScript"
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
        webRender -> HttpClient "Llamadas HttpClient por: " "TypeScript"
        mobileRender -> HttpClient "Llamadas HttpClient por: " "TypeScript"
        HttpClient -> firebase "Lee y escribe de Firebase"
        HttpClient -> googleMaps "Consulta Direcciones y Utiliza API para renderizar el Mapa"
        
        # relationships to/from components
        webRender -> authCont "Makes HttpClient calls to" "TypeScript"
        mobileRender -> authCont "Makes HttpClient calls to" "TypeScript"
        webRender -> MapaCont "Makes HttpClient calls to" "TypeScript"
        mobileRender -> MapaCont "Makes HttpClient calls to" "TypeScript"
        webRender -> RutaCont "Makes HttpClient calls to" "TypeScript"
        mobileRender -> RutaCont "Makes HttpClient calls to" "TypeScript"
        webRender -> EstFavCont "Makes HttpClient calls to" "TypeScript"
        mobileRender -> EstFavCont "Makes HttpClient calls to" "TypeScript"
        webRender -> PerfilCont "Makes HttpClient calls to" "TypeScript"
        mobileRender -> PerfilCont "Makes HttpClient calls to" "TypeScript"
        authCont -> authService "usa"
        authCont -> dataService "usa"
        MapaCont -> dataService "usa"
        MapaCont -> GoogleMapsService "usa"
        RutaCont -> dataService "usa"
        EstFavCont -> dataService "usa"
        PerfilCont -> dataService "usa"
        PerfilCont -> authService "usa"
        authService -> firebase "Lee de"
        dataService -> firebase "Lee y escribe dede"
        GoogleMapsService -> googleMaps "usa"
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
        component HttpClient "SistemadeConferenciaC3" "Sistema de conferencias C3 Components" {
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