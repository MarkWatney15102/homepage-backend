const express = require('express');
const cors = require('cors');
const GitHub = require('github-api');
const bcrypt = require('bcryptjs');
const SqlString = require('sqlstring');
const randomstring = require("randomstring");

const dbConnection = require('./lib/database');
const db = dbConnection.getDatabase();
const user = require('./lib/user');

const app = express();
const port = 43921;

app.use(cors());
app.use(express.json());

app.get('/api/techs', (req, res) => {
    let sql = 'SELECT tt.id, tt.name as techs, (SELECT GROUP_CONCAT(ts.name) FROM techs_sub ts WHERE ts.parrent_id = tt.id) as sub_techs FROM techs_title tt';
    db.query(sql, (err, result) => {
        res.status(200).send({
            success: true,
            data: result
        });
    });
});

app.get('/api/changelog', (req, res) => {
    db.query('SELECT * FROM changelog ORDER BY id DESC', (err, result, fields) => {
        res.status(200).send({
            success: true,
            data: result
        });
    });
});

app.get('/project/docu/:projectId', (req, res) => {
    const { projectId } = req.params;

    if (!projectId) {
        res.status(400).send({ message: "missing project id" });
    }

    db.query('SELECT id, message, timestamp FROM github_repos_documentation WHERE github_id = ' + SqlString.escape(projectId) + ' ORDER BY id DESC' , (err, result, fields) => {
        res.status(200).send({
            success: true,
            data: result
        });
    });
});

app.get('/github/repos', (req, res) => {
    const gh = new GitHub(
        {
            username: "MarkWatney15102",
            password: ">nC-V8ZN;%]~48m$"
        }
    );

    const user = gh.getUser('MarkWatney15102');
    user.listRepos((err, repos) => {
        res.status(200).send({
            message: "somthing went wrong",
            repos: repos
        });
    });
});

app.post('/auth/login', (req, res) => {
    const { username, password } = req.body;

    if (!username || !password) {
        res.status(200).send({
            auth: false,
            message: "missing param"
        });
    } else {
        db.query("SELECT * FROM user WHERE username = " + SqlString.escape(username) + "", (err, result, fields) => {
            const userId = result[0].id;
            const token = randomstring.generate({
                length: 64,
                charset: 'alphabetic'
            });

            db.query("INSERT INTO user_token (user_id, token) VALUES ('" + userId + "', '" + token + "') ON DUPLICATE KEY UPDATE token = '" + token + "'");

            const verify = bcrypt.compareSync(password, result[0].password);
            res.status(200).send({
                auth: verify,
                message: "request was successfull",
                uid: (verify === true) ? userId : '',
                token: (verify === true) ? token : ''
            });
        });
    }
});

app.post('/user/permission', (req, res) => {
    const { permission, userId, userToken } = req.body;

    if (!permission || !userId || !userToken) {
        res.status(200).send({
            success: false,
            access: false
        });
    } else {
        let cleanedUserId = SqlString.escape(userId);
        let cleanedPermission = SqlString.escape(permission);
        user.getUserToken(cleanedUserId).then((token) => {
            let equalToken = false;
            if (token === userToken) {
                equalToken = true;
            }
            user.hasPermission(cleanedPermission, cleanedUserId).then((hasPerm) => {
                res.status(200).send({
                    success: true,
                    access: (equalToken && hasPerm) ? true : false
                });
            });
        });
    }
});

app.post('/changelog/create', (req, res) => {
    const { headline, oldVersion, newVersion, description, save, userId, userToken } = req.body;
    if (!headline || !oldVersion || !newVersion || !description || !save) {
        res.status(200).send({
            success: false,
            access: false,
        });
    } else {
        let cleanedUserId = SqlString.escape(userId);
        let cleanedPermission = SqlString.escape('admin');

        user.getUserToken(cleanedUserId).then((token) => {
            let equalToken = false;
            if (token === userToken) {
                equalToken = true;
            }

            let returnMessage = "Error while creating Changelog";

            user.hasPermission(cleanedPermission, cleanedUserId).then((hasPerm) => {
                if (hasPerm && equalToken && save) {
                    const sql = "INSERT INTO `webspace`.`changelog` (`id`, `headline`, `description`, `old_version`, `new_version`) VALUES (NULL, " + SqlString.escape(headline) + ", " + SqlString.escape(description) + ", " + SqlString.escape(oldVersion) + ", " + SqlString.escape(newVersion) + ");";
                    db.query(sql);
                    
                    returnMessage = "New Changelog entry created"
                }

                res.status(200).send({
                    success: true,
                    message: returnMessage
                });
            });
        });
    }
});

app.listen(port, () => {
    console.log('Listening to Port: ' + port);
})