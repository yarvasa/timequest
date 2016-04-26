Ext.define('App.view.Viewport', {
    extend: 'Ext.container.Viewport',
    layout: {
        type: 'border'
    },

    initComponent: function () {
        var me = this;

        Ext.apply(me, {
            items: [
                {
                    xtype: 'panel',
                    region: 'west',
                    width: '30%',
                    maxWidth: 270,
                    collapsible: true,
                    items: [
//                        {
//                            xtype: 'component',
//                            cls: 'mini-logo-container'
//                        },
                        {
                            xtype: 'navigationview'
                        }
                    ]
                },
                {
                    xtype: 'panel',
                    region: 'center',
                    cls: 'content-block',
                    itemId: 'contentBlock',
                    autoScroll: true
                }
            ]
        });

        me.callParent(arguments);
    }
});
