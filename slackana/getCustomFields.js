const RELEASES_BOARD_ID = '1158888069243985';
const RT_UX_IMPROVEMENT = '161850064078682';
const RT_FEATURE = '1161850064078679';

const asana = require('asana');

const client = asana.Client
    .create()
    .useAccessToken('1/1198981708667240:129780dde6890793187e312586dc3d5b');

client.users.me()
    .then(user => {
        dueWorkspaceGid = user.workspaces[0].gid;
        return client.customFields.getCustomFieldsForWorkspace(dueWorkspaceGid);
    })
    .then(result => {
        console.log("GET CUSTOM FIELDS");
        // console.log(result.data);
        releaseTypeCustomField = result.data.filter(customField => customField.gid === '1161850064078678');
        console.log(releaseTypeCustomField[0].enum_options);
    })