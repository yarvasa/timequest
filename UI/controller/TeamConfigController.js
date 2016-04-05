Ext.define('App.controller.TeamConfigController', {
    extend: 'Ext.app.Controller',
    views: [
        'team.TeamConfigBlock'
    ],

    models: [
        'InviteModel'
    ],

    refs: [

    ],

    init: function() {
        var me = this;

        me.listen({
            'component': {

            },
            store: { }
        });
        me.callParent(arguments);
    }
});