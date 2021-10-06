const asana = require('asana');
const slackUtils = require('./slackUtils');

const ASANA_TOKEN = '1/1198981708667240:129780dde6890793187e312586dc3d5b';
const WORKSPACE_ID_DIDUENJOY = '10790441958942';
const PROJECT_ID_DEV_BOARD = '1199902366050738';
const PROJECT_ID_RELEASES_BOARD = '1158888069243985';
const CUSTOM_FIELD_ID_RELEASE_TYPE = '1161850064078678';

const RT_FEATURE = '1161850064078679';
const RT_QUICK_WIN = '1161850064078680';
const RT_ADMIN_FEATURE = '1164116959812851';
const RT_PARTNER_SPECIFIC_FEATURE = '1162657338652762';
const RT_UX_IMPROVEMENT = '1161850064078682';
const RT_WORDING = '1181374025972212';
const RT_PERFORMANCE_IMPROVEMENT = '1161850064078683';
const RT_BUGFIX = '1161850064078681';

const asanaClient = asana.Client
  .create()
  .useAccessToken(ASANA_TOKEN);

var releaseName = "🚀 Nouvelle release — ";

asanaClient.sections.getSectionsForProject(PROJECT_ID_RELEASES_BOARD)
  .then(sectionsResponse => {
    console.log("Fetched sections");
    lastReleaseSection = sectionsResponse.data[2];
    releaseName += lastReleaseSection.name;
    return asanaClient.tasks.getTasksForSection(lastReleaseSection.gid, {
      opt_fields: "name, assignee, due_on, custom_fields, permalink_url"
    });
  })
  .then(tasks => {
    console.log("Fetched tasks");

    featureTasks = tasks.data.filter(task => isTaskOfReleaseType(task, RT_FEATURE));
    quickWinTasks = tasks.data.filter(task => isTaskOfReleaseType(task, RT_QUICK_WIN));
    adminFeatureTasks = tasks.data.filter(task => isTaskOfReleaseType(task, RT_ADMIN_FEATURE));
    partnerSpecificFeatureTasks = tasks.data.filter(task => isTaskOfReleaseType(task, RT_PARTNER_SPECIFIC_FEATURE));
    uxImprovementTasks = tasks.data.filter(task => isTaskOfReleaseType(task, RT_UX_IMPROVEMENT));
    wordingTasks = tasks.data.filter(task => isTaskOfReleaseType(task, RT_WORDING));
    perfImprovementTasks = tasks.data.filter(task => isTaskOfReleaseType(task, RT_PERFORMANCE_IMPROVEMENT));
    bugfixesTasks = tasks.data.filter(task => isTaskOfReleaseType(task, RT_BUGFIX));

    blocks = [];

    blocks.push(slackUtils.createHeaderSection(releaseName));
    blocks.push(slackUtils.createMrkdwnSection("Une nouvelle version vient d'être déployée en production avec les changements suivants."));
    blocks.push(slackUtils.createDividerSection());

    if (featureTasks.length > 0 || quickWinTasks.length > 0 || adminFeatureTasks > 0) {
      blocks.push(slackUtils.createMrkdwnSection("🎁 *NOUVELLES FONCTIONNALITÉS*"));
      blocks.push(slackUtils.createMrkdwnSection(
        formatTasks(featureTasks, "Feature")
        + formatTasks(quickWinTasks, "QuickWin")
        + formatTasks(adminFeatureTasks, "Admin Feature")
        + formatTasks(partnerSpecificFeatureTasks, "Partner Specific Feature")
      ));
      blocks.push(slackUtils.createDividerSection());
    }

    if (uxImprovementTasks.length > 0 || wordingTasks.length > 0) {
      blocks.push(slackUtils.createMrkdwnSection("🔋 *AMÉLIORATIONS*"));
      blocks.push(slackUtils.createMrkdwnSection(
        formatTasks(uxImprovementTasks, "UX")
        + formatTasks(wordingTasks, "Wording")
        + formatTasks(perfImprovementTasks, "Performance Improvement")));
      blocks.push(slackUtils.createDividerSection());
    }

    if (bugfixesTasks.length > 0) {
      blocks.push(slackUtils.createMrkdwnSection("🐞 *CORRECTIONS DE BOGUES*"));
      blocks.push(slackUtils.createMrkdwnSection(formatTasks(bugfixesTasks, "")));
      blocks.push(slackUtils.createDividerSection());
    }

    blocks.push(slackUtils.createContextMrkdwnSection("Le détail des changements est consultable dans la board Asana <https://app.asana.com/0/1158888069243985/list|Releases>."));

    console.log(blocks);
    slackUtils.postMessageToSlack(blocks);
  });


// Utils

function formatTasks(tasks, prefix) {
  res = "";
  tasks.forEach(task => {
    res += `> • `
      + (prefix === "" ? "" : `*${prefix}:* `)
      + `<${task.permalink_url}|` + escapeCharactersForSlack(task.name) + `>\n`;
  });
  return res;
}

function isTaskOfReleaseType(task, releaseType) {
  customFieldReleaseType = task.custom_fields.filter(customField => (customField.gid === CUSTOM_FIELD_ID_RELEASE_TYPE))[0];
  return customFieldReleaseType.enum_value.gid === releaseType;
}

function escapeCharactersForSlack(text) {
  return text.replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;");
}

// Unused

function getWorspaces() {
  asanaClient.workspaces.getWorkspaces()
    .then(response => {
      console.log("Fetched workspaces");
      console.log(response.data);
    });
}

function getProjects() {
  asanaClient.projects.getProjects({ workspace: WORKSPACE_ID_DIDUENJOY })
    .then(response => {
      console.log("Fetched projects");
      console.log(response.data);
    });
}