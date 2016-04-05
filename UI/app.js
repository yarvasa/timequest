Ext.application({
    appFolder: '/UI',
    name: 'App',
    autoCreateViewport: true,
    models: [
        'NavigationModel'
    ],
    stores: [

    ],
    views:[

    ],
    controllers: [
        'NavigationController',
        'TeamConfigController'
    ],
    requires:[

    ],

    launch: function () {

    }
});