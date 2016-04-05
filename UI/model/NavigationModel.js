Ext.define('App.model.NavigationModel', {
    extend: 'Ext.data.Model',
    fields: [
        {
            name: 'text',
            convert: function (value, model) {
                return t('app.navigation.' + model.get('action'));
            }
        },
        { name: 'icon' },
        { name: 'action' }
    ],

    proxy: {
        type: 'memory'
    }
});