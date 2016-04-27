Ext.define('App.view.team.TeamConfigBlock', {
    extend: 'Ext.container.Container',
    alias: 'widget.teamconfigblock',
    autoScroll: true,
    cls: 'teamconfig-block',
    //padding: 20,

    initComponent: function () {
        var me = this;

        Ext.apply(me, {
            items: [
                {
                    xtype: 'container',
                    items: me.getItems()
                }
            ]
        });

        me.callParent(arguments);
    },

    getItems: function() {
        var me = this,
            items = [];

        items.push({
            xtype: 'button',
            text: t('app.team.refresh'),
            action: 'refresh-data-team',
            cls: 'refresh-button'
        });

        if (!me.teamConfig.currentTeam) {
            items.push(me.getCreateTeamBtn());
        } else {
            items.push(App.Utils.getInfoBlock({
                cls: 'only-vertical-border',
                margin: '0 0 15 0',
                text: Ext.String.format(
                    t('app.team.in_team'),
                    me.teamConfig.currentTeam.teamName
                )
            }));

            items.push({
                xtype: 'button',
                itemId: 'leaveTeam',
                margin: '0 0 15 20',
                text: t('app.team.leave_team')
            });

            if (me.teamConfig.usersInTeam && me.teamConfig.usersInTeam.length) {
                items.push(me.getUsersInTeamGrid());
            }

            items.push(App.Utils.getInfoBlock({
                cls: 'only-vertical-border',
                margin: '0 0 -1 0',
                text: t('app.invites.not_available_reason')
            }));
        }

        items.push(me.getUsersInvitesGrid());

        return items;
    },

    getCreateTeamBtn: function() {
        return {
            xtype: 'button',
            margin: '0 0 20 0',
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
            resizable: false,
            flex: 1
        });

        columns.push({
            header: t('app.invites.columns.author'),
            dataIndex: 'author_name',
            menuDisabled: true,
            draggable: false,
            resizable: false,
            sortable: false,
            flex: 1
        });

        columns.push({
            header: t('app.invites.columns.time'),
            dataIndex: 'request_time',
            menuDisabled: true,
            draggable: false,
            sortable: false,
            resizable: false,
            width: 118,
            renderer: function(value, opt, model) {
                return Ext.Date.format(new Date(parseInt(value)), 'Y-m-d');
            }
        });

        columns.push({
            xtype: 'actioncolumn',
            width: 50,
            menuDisabled: true,
            draggable: false,
            sortable: false,
            resizable: false,
            items: [
                {
                    iconCls: 'accept-invite-button ' + (!!me.teamConfig.currentTeam ? 'hidden' : ''),
                    tooltip: t('app.invites.accept.tooltip'),
                    handler: function(view, rowIndex, colIndex, item, e, record) {
                        me.fireEvent('onAcceptInviteClick', view, rowIndex, colIndex, item, e, record);
                    }
                },
                {
                    iconCls: 'decline-invite-button',
                    tooltip: t('app.invites.decline.tooltip'),
                    handler: function(view, rowIndex, colIndex, item, e, record) {
                        me.fireEvent('onDeclineInviteClick', view, rowIndex, colIndex, item, e, record);
                    }
                }
            ]
        });

        return {
            xtype: 'grid',
            autoScroll: true,
            cls: 'user-invites-grid',
            title: t('app.users.invites.title'),
            emptyText: t('app.users.invites.empty_text'),
            store: Ext.create('Ext.data.Store', {
                model: 'App.model.InviteModel',
                data: me.teamConfig.invites
            }),
            columns: columns
        };
    },

    getUsersInTeamGrid: function() {
        var me = this,
            columns = [];

        columns.push({
            header: t('app.users_in_team.column.user'),
            dataIndex: 'username',
            menuDisabled: true,
            draggable: false,
            sortable: false,
            resizable: false,
            flex: 1,
            renderer: function (value, opt, model) {
                return '<a class="link-to-profile" target="_blank" href="' + model.get('profile') + '">' +
                            value
                       '</a>';
            }
        });

        columns.push({
            header: t('app.users_in_team.column.status'),
            dataIndex: 'status',
            menuDisabled: true,
            draggable: false,
            resizable: false,
            sortable: false,
            width: 150,
            renderer: function (value, opt, model) {
                return App.UsersInTeamStatus.getMessage(value);
            }
        });

        return {
            xtype: 'grid',
            autoScroll: true,
            margin: '0 0 30 0',
            cls: 'user-in-team-grid',
            title: t('app.users_in_team.title'),
            store: Ext.create('Ext.data.Store', {
                model: 'App.model.UsersInTeamModel',
                data: me.teamConfig.usersInTeam
            }),
            columns: columns
        };
    }
});
