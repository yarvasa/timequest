Ext.define('App.view.Utils', {
    alternateClassName: 'App.Utils',

    statics: {
        getInfoBlock: function(params) {
            return {
                xtype: 'component',
                cls: 'info-block ' + (params.cls || ''),
                html: params.text,
                width: params.width,
                margin: params.margin
            };
        },

        confirm: function(message, callback) {
            var win = Ext.create('Ext.window.Window', {
                modal: true,
                width: 400,
                height: 150,
                autoShow: true,
                items: [{
                    xtype: 'component',
                    padding: 20,
                    html: message
                }],
                bbar: [
                    '->',
                    {
                        xtype: 'button',
                        text: t('app.base.yes'),
                        width: 100,
                        handler: function() {
                            callback && callback();
                            win.close();
                        }
                    },
                    {
                        xtype: 'button',
                        text: t('app.base.no'),
                        width: 100,
                        handler: function() {
                            win.close();
                        }
                    }
                ]
            });
        },

        error: function(message) {
            var win = Ext.create('Ext.window.Window', {
                modal: true,
                width: 400,
                height: 150,
                autoShow: true,
                cls: 'error-window',
                items: [{
                    xtype: 'component',
                    padding: 20,
                    html: message
                }],
                bbar: [
                    '->',
                    {
                        xtype: 'button',
                        text: t('app.base.ok'),
                        width: 390,
                        handler: function() {
                            win.close();
                        }
                    }
                ]
            });
        }
    }
});
