Ext.define('App.view.team.TeamConfigBlock', {
    extend: 'Ext.container.Container',
    alias: 'widget.teamconfigblock',
    cls: 'teamconfig-block',
    padding: 20,

    initComponent: function () {
        var me = this;

        Ext.apply(me, {
            items: me.getItems()
        });

        me.callParent(arguments);
    },

    getItems: function() {
        var me = this,
            items = [];

        if (!me.teamConfig.currentTeam) {
            items.push(me.getCreateTeamBtn());
        }

        items.push(me.getUsersInvitesGrid());

        return items;
    },

    getCreateTeamBtn: function() {
        return {
            xtype: 'button',
            text: t('app.create_team_btn'),
            itemId: 'createTeamButton',
            cls: 'create-team-button'
        };
    },

    getUsersInvitesGrid: function() {
        var me = this,
            columns = [];

        columns.push({
            header: t('app.invites.columns.team'),
            dataIndex: 'team_name',
            menuDisabled: true,
            draggable: false,
            sortable: false,
            width: 200
        });

        columns.push({
            header: t('app.invites.columns.author'),
            dataIndex: 'author_name',
            menuDisabled: true,
            draggable: false,
            sortable: false,
            width: 250
        });

        columns.push({
            header: t('app.invites.columns.time'),
            dataIndex: 'request_time',
            menuDisabled: true,
            draggable: false,
            sortable: false,
            flex: 1,
            renderer: function(value, opt, model) {
                return Ext.Date.format(new Date(parseInt(value)), 'Y-m-d');
            }
        })
        return {
            xtype: 'grid',
            width: '100%',
            margin: '30 0 0 0',
            title: t('app.users.invites.title'),
            emptyText: t('app.users.invites.empty_text'),
            store: Ext.create('Ext.data.Store', {
                model: 'App.model.InviteModel',
                data: me.teamConfig.invites
            }),
            columns: [
                ,
                ,

            ]
        };
    }
});
