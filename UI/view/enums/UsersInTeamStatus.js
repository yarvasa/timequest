Ext.define('App.view.enums.UsersInTeamStatus', {
    alternateClassName: 'App.UsersInTeamStatus',

    statics: {
        HUMAN: 'HUMAN',
        CAPTAIN: 'CAPTAIN',

        getMessage: function(value) {
            return t('app.users_in_team.status.' + value.toLowerCase());
        }
    }
});
