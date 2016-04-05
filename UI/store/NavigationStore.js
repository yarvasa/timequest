Ext.define('App.store.NavigationStore', {
    extend: 'Ext.data.Store',
    model: 'App.model.NavigationModel',
    storeId: 'NavigationStore',
    autoLoad: false,
    data: [
        {
            action: 'team',
            icon: 'http://www.iconsearch.ru/uploads/icons/freeapplication/24x24/usergroup.png'
        }
    ],
    proxy: {
        type: 'memory'
    }
});