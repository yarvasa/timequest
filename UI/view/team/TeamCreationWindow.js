Ext.define('App.view.team.TeamCreationWindow', {
    extend: 'Ext.window.Window',
    alias: 'widget.teamcreationwindow',
    cls: 'teamconfig-block',
    modal: true,
    autoShow: true,
    width: 500,
    //height: 500,

    initComponent: function () {
        var me = this;

        Ext.apply(me, {
            items: [{
                xtype: 'container',
                layout: {
                    type: 'vbox',
                    align: 'stretch'
                },
                padding: 20,
                items: me.getItems()
            }],
            bbar: [
                '->',
                {
                    xtype: 'button',
                    itemId: 'createTeam',
                    width: 490,
                    text: t('app.team.create_button')
                }
            ]
        });

        me.callParent(arguments);
    },

    getItems: function() {
        var me = this,
            items = [];

        items.push({
            xtype: 'textfield',
            itemId: 'teamName',
            emptyText: t('app.team.name.empty_text'),
            fieldLabel: t('app.team.name.label'),
            labelAlign: 'top'
        });

        return items;
    }
});
