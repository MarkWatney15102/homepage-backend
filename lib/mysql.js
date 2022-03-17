const db = require('mysql2/promise');

module.exports = {
    executeQuery: async function (sql) {
        const connection = await db.createConnection({
            host: '127.0.0.1',
            user: 'root',
            password: '81756010fhj',
            database: 'webspace',
        });

        return [rows, fields] = await connection.execute(sql);
    }
}