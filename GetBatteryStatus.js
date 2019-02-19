const request = require('request');
const { Client } = require('pg');

function loadConfig() {
    console.log('loadConfig()')

    var fs = require('fs');
    return JSON.parse(fs.readFileSync('config.json', 'utf8'));
}

function loadUsers() {
    console.log('loadUsers()');

    client.query('SELECT Username, Password FROM Users')
    .then(res => {
        // TODO: loop for all users
        let user = res.rows[0];
        login(user);
    })
    .catch(e => console.error(e.stack));
}

function login(user) {
    console.log('login()');

    url = 'https://services.renault-ze.com/api/user/login';
    method = 'POST';
    requestbody = user;
    requestTimestamp = new Date().toISOString();
    
    request({
        url: url,
        method: method,
        json: requestbody,
    }, function(error, response, body) {
        
        if (error)
            console.log(error.stack);
        else {
            // Redact the password and activation code before logging
            requestbody.password = '[redacted]';
            body.user.vehicle_details.activation_code = '[redacted]';

            client.query(
                'INSERT INTO ZeServicesLog (username, requesturl, requestmethod, requestbody, requesttimestamp, responsebody, responsetimestamp) VALUES ($1::text, $2::text, $3::text, $4::json, $5::timestamp, $6::json, $7::timestamp)',
                [user.username, url, method, JSON.stringify(requestbody), requestTimestamp, JSON.stringify(body), new Date().toISOString()], 
                (err, res) => {
                    if (err)
                        console.log(err ? err.stack : 'OK');
                    else
                        getBatteryStatus(user.username, body.token, body.user.vehicle_details.VIN);
                }
            );
        }
    });
}

function getBatteryStatus(username, token, vin) {
    console.log('getBatteryStatus()');

    url = 'https://www.services.renault-ze.com/api/vehicle/' + vin + '/battery';
    method = 'GET';
    requestTimestamp = new Date().toISOString();

    request({
        url: url, 
        method: method,
        auth: { 'bearer': token }
    }, function(error, response, body) {
        client.query(
            'INSERT INTO ZeServicesLog (username, requesturl, requestmethod, requestbody, requesttimestamp, responsebody, responsetimestamp) VALUES ($1::text, $2::text, $3::text, $4::json, $5::timestamp, $6::json, $7::timestamp)',
            [username, url, method, null, requestTimestamp, JSON.stringify(body), new Date().toISOString()],
            (err, res) => {
                console.log(err ? err.stack : 'OK');
                client.end();
            }
        );
    });
  }

const config = loadConfig();

const client = new Client(config.databaseConfig);
client.connect();

loadUsers();





