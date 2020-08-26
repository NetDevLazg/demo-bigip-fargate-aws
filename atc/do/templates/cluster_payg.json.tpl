{
    "$schema": "https://raw.githubusercontent.com/F5Networks/f5-declarative-onboarding/master/src/schema/latest/base.schema.json",
    "schemaVersion": "1.11.1",
    "class": "Device",
    "async": true,
    "label": "External Cluster PAYG",
    "Common": {
        "class": "Tenant",
        "hostname": "${local_host}",
        "dbvars": {
            "class": "DbVariables",
            "ui.advisory.enabled": true,
            "ui.advisory.color": "green",
            "ui.advisory.text": "/Common/hostname"
        },
        "myDns": {
            "class": "DNS",
            "nameServers": [
                "169.254.169.254",
                "${dns_server}"
            ],
            "search": [
                "f5.com",
                "ec2.internal",
                "compute-1.internal"
            ]
        },
        "myNtp": {
            "class": "NTP",
            "servers": [
                "${ntp_server}",
                "0.pool.ntp.org",
                "1.pool.ntp.org"
            ],
            "timezone": "${timezone}"
        },
        "myProvisioning": {
            "class": "Provision",
            "ltm": "nominal",
            "asm": "nominal"
        },
        "configsync": {
            "class": "ConfigSync",
            "configsyncIp": "${local_selfip2}"
        },
        "failoverAddress": {
            "class": "FailoverUnicast",
            "address": "${local_selfip2}"
        },
        "failoverGroup": {
            "class": "DeviceGroup",
            "type": "sync-failover",
            "members": [
                "${host1}",
                "${host2}"
            ],
            "owner": "/Common/failoverGroup/members/0",
            "autoSync": true,
            "saveOnAutoSync": false,
            "networkFailover": true,
            "fullLoadOnSync": false
        },
        "trust": {
            "class": "DeviceTrust",
            "localUsername": "${admin_user}",
            "localPassword": "${admin_password}",
            "remoteHost": "${remote_selfip}",
            "remoteUsername": "${admin_user}",
            "remotePassword": "${admin_password}"
        }    
    }
}