Ext.define('App.controller.NavigationController', {
    extend: 'Ext.app.Controller',
    views: [
        'Navigation'
    ],

    stores: [
        'NavigationStore'
    ],

    refs: [
        {
            ref: 'contentBlock',
            selector: '#contentBlock'
        }
    ],

    init: function() {
        var me = this;

        me.listen({
            'component': {
                'navigationview': {
                    selectionchange: me.onNavigationSelect,
                    afterrender: function(view) {
                        view.select(view.store.getAt(0));
                    }
                }
            },
            store: { }
        });
        me.callParent(arguments);
    },

    onNavigationSelect: function(view, selected, eOpts ) {
        var me = this,
            contentBlock = me.getContentBlock();

        switch (selected[0].get('action')) {
            case 'team':
                contentBlock.removeAll();
                me.addTeamConfigBlock(contentBlock);
                break;
        }
    },

    addTeamConfigBlock: function(contentBlock) {
        var me = this;

        Ext.getBody().el.mask(t('app.base.loading'));
        Ext.Ajax.request({
            url: localUrl + 'team/getCurrentTeamData',
            method: 'POST',
            success: function(data) {
                Ext.getBody().el.unmask();

                var response = JSON.parse(data.responseText);
                if (response.success) {
                    contentBlock.add(Ext.create('App.view.team.TeamConfigBlock', {
                        teamConfig: response.data
                    }));
                }
            },
            failure: function () {
                Ext.getBody().el.unmask();
            }
        });
    }
});