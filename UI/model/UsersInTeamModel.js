Ext.define('App.model.UsersInTeamModel', {
    extend: 'Ext.data.Model',
    fields: [
        { name: 'id' },
        { name: 'id_user' },
        { name: 'username' },
        { name: 'profile' },
        { name: 'status' }
    ],

    proxy: {
        type: 'memory'
    }
});