Ext.define('App.view.Navigation', {
    extend: 'Ext.view.View',
    alias: 'widget.navigationview',
    cls: 'navigationview',

    initComponent: function () {
        var me = this;

        Ext.apply(me, {
            store: Ext.create('App.store.NavigationStore'),
            tpl: new Ext.XTemplate(
                '<tpl for=".">',
                '   <div class="navigation-item">',
                '       <span class="navigation-icon" style="background-image: url({icon});"></span>',
                '       <span class="navigation-text">{text}</span>',
                '   </div>',
                '</tpl>',
                {

                }
            ),
            selModel: Ext.create('Ext.selection.DataViewModel', {
                mode: 'SINGLE',
                enableKeyNav: false
            }),
            itemSelector: '.navigation-item',
            disabledCls: 'disabled-navigation-item',
            selectedItemCls: 'selected-navigation-item',
            overItemCls: 'over-navigation-item'
        });

        me.callParent(arguments);
    }
});
