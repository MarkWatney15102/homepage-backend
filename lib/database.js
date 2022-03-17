const mysql = require('mysql');

module.exports = {
    connection: null,
    getDatabase: function () {
        this.connection = mysql.createConnection({
            host: '127.0.0.1',
            user: 'root',
            password: '',
            database: 'webspace',
            port: '3306'
        });
        
        this.connection.connect(error => {
            if (error) throw error;
            console.log("Successfully connected to the database.");
        });
    
        return this.connection;
    },
    killConnection: function () {
        this.connection.destroy();
    }
}