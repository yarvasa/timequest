Ext.define('App.controller.TeamConfigController', {
    extend: 'Ext.app.Controller',
    views: [
        'team.TeamConfigBlock'
    ],

    models: [
        'InviteModel'
    ],

    refs: [
        {
            ref: 'navigationView',
            selector: 'navigationview'
        }
    ],

    init: function() {
        var me = this;

        me.listen({
            'component': {
                'teamconfigblock': {
                    onDeclineInviteClick: me.onDeclineInviteClick,
                    onAcceptInviteClick: me.onAcceptInviteClick
                },
                'teamconfigblock button[action=refresh-data-team]': {
                    click: me.onRefreshClick
                },
                'teamconfigblock button#leaveTeam': {
                    click: me.onLeaveTeamClick
                }
            },
            store: { }
        });
        me.callParent(arguments);
    },

    onRefreshClick: function(btn) {
        var me = this,
            navigationView = me.getNavigationView();

        navigationView.selModel.deselectAll();
        navigationView.select(navigationView.store.findRecord('action', 'team'));
    },

    onDeclineInviteClick: function(view, rowIndex, colIndex, item, e, record) {
        var me = this;
        App.Utils.confirm(
            Ext.String.format(t('app.invite.decline.confirm'), record.get('team_name')),
            function() {
                Ext.getBody().el.mask(t('app.base.loading'));
                Ext.Ajax.request({
                    url: localUrl + 'team/declineInvite/' + record.get('id'),
                    method: 'GET',
                    success: function(data) {
                        Ext.getBody().el.unmask();

                        try {
                            var response = JSON.parse(data.responseText);
                            if (response.success) {
                                me.onRefreshClick();
                            } else {
                                App.Utils.error(t(response.error));
                            }
                        } catch (e) {
                            App.Utils.error(t('app.error.general'));
                        }
                    },
                    failure: function () {
                        Ext.getBody().el.unmask();
                        App.Utils.error(t('app.error.general'));
                    }
                });
            }
        );
    },

    onAcceptInviteClick: function(view, rowIndex, colIndex, item, e, record) {
        var me = this;

        Ext.getBody().el.mask(t('app.base.loading'));
        Ext.Ajax.request({
            url: localUrl + 'team/acceptInvite/' + record.get('id'),
            method: 'GET',
            success: function(data) {
                Ext.getBody().el.unmask();

                try {
                    var response = JSON.parse(data.responseText);
                    if (response.success) {
                        me.onRefreshClick();
                    } else {
                        App.Utils.error(t(response.error));
                    }
                } catch (e) {
                    App.Utils.error(t('app.error.general'));
                }
            },
            failure: function () {
                Ext.getBody().el.unmask();
                App.Utils.error(t('app.error.general'));
            }
        });
    },

    onLeaveTeamClick: function() {
        var me = this;

        Ext.getBody().el.mask(t('app.base.loading'));
        Ext.Ajax.request({
            url: localUrl + 'team/leaveTeam',
            method: 'GET',
            success: function(data) {
                Ext.getBody().el.unmask();

                try {
                    var response = JSON.parse(data.responseText);
                    if (response.success) {
                        me.onRefreshClick();
                    } else {
                        App.Utils.error(t(response.error));
                    }
                } catch (e) {
                    App.Utils.error(t('app.error.general'));
                }
            },
            failure: function () {
                Ext.getBody().el.unmask();
                App.Utils.error(t('app.error.general'));
            }
        });
    }
});