const db = require('mysql2/promise');

module.exports = {
    executeQuery: async function (sql) {
        const connection = await db.createConnection({
            host: '127.0.0.1',
            user: 'root',
            password: '',
            database: 'webspace',
        });

        return [rows, fields] = await connection.execute(sql);
    }
}