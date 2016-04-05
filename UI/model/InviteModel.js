Ext.define('App.model.InviteModel', {
    extend: 'Ext.data.Model',
    fields: [
        { name: 'id' },
        { name: 'id_team' },
        { name: 'id_author' },
        { name: 'id_user' },
        { name: 'status' },
        { name: 'request_time' },
        { name: 'team_name' },
        { name: 'author_name' }
    ],

    proxy: {
        type: 'memory'
    }
});