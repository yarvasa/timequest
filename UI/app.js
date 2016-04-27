Ext.Loader.setConfig({
    disableCaching: true
});

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
        'Utils',
        'enums.UsersInTeamStatus'
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