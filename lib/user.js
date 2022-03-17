const database = require('./mysql');

module.exports = {
    getUserToken: async function (userId) {
        const [ rows, field ] = await database.executeQuery("SELECT token FROM user_token WHERE user_id = " + userId);
        
        return rows[0].token;
    },
    hasPermission: async function (permission, userId) {
        let sql = "SELECT p.permission_name as name, up.user_id FROM user_permissions up INNER JOIN permissions p ON up.permission_id = p.id WHERE p.permission_name = " + permission + " AND up.user_id = " + userId;
        const [ rows, field ] = await database.executeQuery(sql);

        if (rows[0]) {
            return (rows[0].name) ? true : false;
        } else {
            return false;
        }
    }
}