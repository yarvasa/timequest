Ext.define('App.controller.TeamCreationController', {
    extend: 'Ext.app.Controller',
    views: [
        'team.TeamCreationWindow'
    ],

    refs: [
        { ref: 'window',    selector: 'teamcreationwindow' },
        { ref: 'teamNameField',     selector: 'teamcreationwindow textfield#teamName' },
        { ref: 'teamConfigBlock',   selector: 'teamconfigblock' }
    ],

    init: function() {
        var me = this;

        me.listen({
            'component': {
                'teamcreationwindow button#createTeam': {
                    click: me.onCreateTeamClick
                }
            },
            store: { }
        });

        me.callParent(arguments);
    },

    onCreateTeamClick: function() {
        var me = this,
            teamName = me.getTeamNameField().getValue();

        if (!teamName) {
            App.Utils.error(t('app.team.empty_name'));
            return;
        }

        me.getWindow().el.mask(t('app.base.loading'));
        Ext.Ajax.request({
            url: localUrl + 'team/createTeam',
            method: 'POST',
            jsonData: {
                teamName: teamName
            },
            success: function(data) {
                me.getWindow().el.unmask();

                try {
                    var response = JSON.parse(data.responseText);
                    if (response.success) {
                        me.getTeamConfigBlock().fireEvent('refreshTeamConfigPage');
                        me.getWindow().close();
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