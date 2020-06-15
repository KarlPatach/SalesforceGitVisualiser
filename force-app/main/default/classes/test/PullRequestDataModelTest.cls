@isTest
public class PullRequestDataModelTest {

    private static final String MINIMAL_VALID_JSON =
    '['
    + '{'
    +'"id":1245,'
    +'"url":"https://api.github.com",'
    +'"draft":false,'
    +'"number":1010,'
    +'"state":"open",'
    +'"title":"Remove IOException",'
    +'"body":"can contains several chars",'
    +'"created_at":"2020-06-10T14:12:23Z",'
    +'"updated_at":"2020-06-10T14:12:23Z",'
    +'"closed_at":"2020-06-10T14:12:23Z",'
    +'"merged_at":"2020-06-10T14:12:23Z",'
    +'"merged":false,'
    +'"base":{"repo":{"name":"something"}},'
    +'"user":{"login":"juan", "id":343434}'
    +'}'
    +']';


    @isTest
    public static void itShouldHandleEmptyResponse(){
        List<Map<String, Object>> prs = PullRequestDataModel.getPullRequests('[]');
        System.assertEquals(0, prs.size());

        prs = PullRequestDataModel.getPullRequests('');
        System.assertEquals(0, prs.size());

        prs = PullRequestDataModel.getPullRequests(null);
        System.assertEquals(0, prs.size());
    }

    @isTest
    public static void itShouldHandlBasicResponse(){
        List<Map<String, Object>> prs = PullRequestDataModel.getPullRequests(MINIMAL_VALID_JSON);
        System.assertEquals(1, prs.size());
    }

    @isTest
    public static void itShouldHandleCompleteResponse(){
        List<Map<String, Object>> prs = PullRequestDataModel.getPullRequests(COMPLETE_JSON);
        System.assertEquals(1, prs.size());
    }


    private static final String COMPLETE_JSON ='[{'+
    '  "url": "https://api.github.com/repos/apache/lucene-solr/pulls/1564",'+
    '  "id": 432484782,'+
    '  "node_id": "MDExOlB1bGxSZXF1ZXN0NDMyNDg0Nzgy",'+
    '  "html_url": "https://github.com/apache/lucene-solr/pull/1564",'+
    '  "diff_url": "https://github.com/apache/lucene-solr/pull/1564.diff",'+
    '  "patch_url": "https://github.com/apache/lucene-solr/pull/1564.patch",'+
    '  "issue_url": "https://api.github.com/repos/apache/lucene-solr/issues/1564",'+
    '  "number": 1564,'+
    '  "state": "open",'+
    '  "locked": false,'+
    '  "title": "LUCENE-9397: UniformSplit supports encodable fields metadata.",'+
    '  "user": {'+
    '    "login": "bruno-roustant",'+
    '    "id": 33934988,'+
    '    "node_id": "MDQ6VXNlcjMzOTM0OTg4",'+
    '    "avatar_url": "https://avatars3.githubusercontent.com/u/33934988?v=4",'+
    '    "gravatar_id": "",'+
    '    "url": "https://api.github.com/users/bruno-roustant",'+
    '    "html_url": "https://github.com/bruno-roustant",'+
    '    "followers_url": "https://api.github.com/users/bruno-roustant/followers",'+
    '    "following_url": "https://api.github.com/users/bruno-roustant/following{/other_user}",'+
    '    "gists_url": "https://api.github.com/users/bruno-roustant/gists{/gist_id}",'+
    '    "starred_url": "https://api.github.com/users/bruno-roustant/starred{/owner}{/repo}",'+
    '    "subscriptions_url": "https://api.github.com/users/bruno-roustant/subscriptions",'+
    '    "organizations_url": "https://api.github.com/users/bruno-roustant/orgs",'+
    '    "repos_url": "https://api.github.com/users/bruno-roustant/repos",'+
    '    "events_url": "https://api.github.com/users/bruno-roustant/events{/privacy}",'+
    '    "received_events_url": "https://api.github.com/users/bruno-roustant/received_events",'+
    '    "type": "User",'+
    '    "site_admin": false'+
    '  },'+
    '  "body": "",'+
    '  "created_at": "2020-06-10T14:12:23Z",'+
    '  "updated_at": "2020-06-10T14:14:23Z",'+
    '  "closed_at": null,'+
    '  "merged_at": null,'+
    '  "merge_commit_sha": "1b52cc85bf5e57387ed5a0d9a3ae5aab061146cf",'+
    '  "assignee": null,'+
    '  "assignees": ['+
    ''+
    '  ],'+
    '  "requested_reviewers": ['+
    '    {'+
    '      "login": "dsmiley",'+
    '      "id": 377295,'+
    '      "node_id": "MDQ6VXNlcjM3NzI5NQ==",'+
    '      "avatar_url": "https://avatars1.githubusercontent.com/u/377295?v=4",'+
    '      "gravatar_id": "",'+
    '      "url": "https://api.github.com/users/dsmiley",'+
    '      "html_url": "https://github.com/dsmiley",'+
    '      "followers_url": "https://api.github.com/users/dsmiley/followers",'+
    '      "following_url": "https://api.github.com/users/dsmiley/following{/other_user}",'+
    '      "gists_url": "https://api.github.com/users/dsmiley/gists{/gist_id}",'+
    '      "starred_url": "https://api.github.com/users/dsmiley/starred{/owner}{/repo}",'+
    '      "subscriptions_url": "https://api.github.com/users/dsmiley/subscriptions",'+
    '      "organizations_url": "https://api.github.com/users/dsmiley/orgs",'+
    '      "repos_url": "https://api.github.com/users/dsmiley/repos",'+
    '      "events_url": "https://api.github.com/users/dsmiley/events{/privacy}",'+
    '      "received_events_url": "https://api.github.com/users/dsmiley/received_events",'+
    '      "type": "User",'+
    '      "site_admin": false'+
    '    }'+
    '  ],'+
    '  "requested_teams": ['+
    ''+
    '  ],'+
    '  "labels": ['+
    ''+
    '  ],'+
    '  "milestone": null,'+
    '  "draft": false,'+
    '  "commits_url": "https://api.github.com/repos/apache/lucene-solr/pulls/1564/commits",'+
    '  "review_comments_url": "https://api.github.com/repos/apache/lucene-solr/pulls/1564/comments",'+
    '  "review_comment_url": "https://api.github.com/repos/apache/lucene-solr/pulls/comments{/number}",'+
    '  "comments_url": "https://api.github.com/repos/apache/lucene-solr/issues/1564/comments",'+
    '  "statuses_url": "https://api.github.com/repos/apache/lucene-solr/statuses/a41aee5fe64375e64ae2d45158aa9a85c8507df6",'+
    '  "head": {'+
    '    "label": "bruno-roustant:us_fieldmetadata",'+
    '    "ref": "us_fieldmetadata",'+
    '    "sha": "a41aee5fe64375e64ae2d45158aa9a85c8507df6",'+
    '    "user": {'+
    '      "login": "bruno-roustant",'+
    '      "id": 33934988,'+
    '      "node_id": "MDQ6VXNlcjMzOTM0OTg4",'+
    '      "avatar_url": "https://avatars3.githubusercontent.com/u/33934988?v=4",'+
    '      "gravatar_id": "",'+
    '      "url": "https://api.github.com/users/bruno-roustant",'+
    '      "html_url": "https://github.com/bruno-roustant",'+
    '      "followers_url": "https://api.github.com/users/bruno-roustant/followers",'+
    '      "following_url": "https://api.github.com/users/bruno-roustant/following{/other_user}",'+
    '      "gists_url": "https://api.github.com/users/bruno-roustant/gists{/gist_id}",'+
    '      "starred_url": "https://api.github.com/users/bruno-roustant/starred{/owner}{/repo}",'+
    '      "subscriptions_url": "https://api.github.com/users/bruno-roustant/subscriptions",'+
    '      "organizations_url": "https://api.github.com/users/bruno-roustant/orgs",'+
    '      "repos_url": "https://api.github.com/users/bruno-roustant/repos",'+
    '      "events_url": "https://api.github.com/users/bruno-roustant/events{/privacy}",'+
    '      "received_events_url": "https://api.github.com/users/bruno-roustant/received_events",'+
    '      "type": "User",'+
    '      "site_admin": false'+
    '    },'+
    '    "repo": {'+
    '      "id": 135414555,'+
    '      "node_id": "MDEwOlJlcG9zaXRvcnkxMzU0MTQ1NTU=",'+
    '      "name": "lucene-solr",'+
    '      "full_name": "bruno-roustant/lucene-solr",'+
    '      "private": false,'+
    '      "owner": {'+
    '        "login": "bruno-roustant",'+
    '        "id": 33934988,'+
    '        "node_id": "MDQ6VXNlcjMzOTM0OTg4",'+
    '        "avatar_url": "https://avatars3.githubusercontent.com/u/33934988?v=4",'+
    '        "gravatar_id": "",'+
    '        "url": "https://api.github.com/users/bruno-roustant",'+
    '        "html_url": "https://github.com/bruno-roustant",'+
    '        "followers_url": "https://api.github.com/users/bruno-roustant/followers",'+
    '        "following_url": "https://api.github.com/users/bruno-roustant/following{/other_user}",'+
    '        "gists_url": "https://api.github.com/users/bruno-roustant/gists{/gist_id}",'+
    '        "starred_url": "https://api.github.com/users/bruno-roustant/starred{/owner}{/repo}",'+
    '        "subscriptions_url": "https://api.github.com/users/bruno-roustant/subscriptions",'+
    '        "organizations_url": "https://api.github.com/users/bruno-roustant/orgs",'+
    '        "repos_url": "https://api.github.com/users/bruno-roustant/repos",'+
    '        "events_url": "https://api.github.com/users/bruno-roustant/events{/privacy}",'+
    '        "received_events_url": "https://api.github.com/users/bruno-roustant/received_events",'+
    '        "type": "User",'+
    '        "site_admin": false'+
    '      },'+
    '      "html_url": "https://github.com/bruno-roustant/lucene-solr",'+
    '      "description": "Mirror of Apache Lucene + Solr",'+
    '      "fork": true,'+
    '      "url": "https://api.github.com/repos/bruno-roustant/lucene-solr",'+
    '      "forks_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/forks",'+
    '      "keys_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/keys{/key_id}",'+
    '      "collaborators_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/collaborators{/collaborator}",'+
    '      "teams_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/teams",'+
    '      "hooks_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/hooks",'+
    '      "issue_events_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/issues/events{/number}",'+
    '      "events_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/events",'+
    '      "assignees_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/assignees{/user}",'+
    '      "branches_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/branches{/branch}",'+
    '      "tags_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/tags",'+
    '      "blobs_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/git/blobs{/sha}",'+
    '      "git_tags_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/git/tags{/sha}",'+
    '      "git_refs_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/git/refs{/sha}",'+
    '      "trees_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/git/trees{/sha}",'+
    '      "statuses_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/statuses/{sha}",'+
    '      "languages_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/languages",'+
    '      "stargazers_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/stargazers",'+
    '      "contributors_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/contributors",'+
    '      "subscribers_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/subscribers",'+
    '      "subscription_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/subscription",'+
    '      "commits_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/commits{/sha}",'+
    '      "git_commits_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/git/commits{/sha}",'+
    '      "comments_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/comments{/number}",'+
    '      "issue_comment_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/issues/comments{/number}",'+
    '      "contents_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/contents/{+path}",'+
    '      "compare_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/compare/{base}...{head}",'+
    '      "merges_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/merges",'+
    '      "archive_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/{archive_format}{/ref}",'+
    '      "downloads_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/downloads",'+
    '      "issues_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/issues{/number}",'+
    '      "pulls_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/pulls{/number}",'+
    '      "milestones_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/milestones{/number}",'+
    '      "notifications_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/notifications{?since,all,participating}",'+
    '      "labels_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/labels{/name}",'+
    '      "releases_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/releases{/id}",'+
    '      "deployments_url": "https://api.github.com/repos/bruno-roustant/lucene-solr/deployments",'+
    '      "created_at": "2018-05-30T08:45:06Z",'+
    '      "updated_at": "2019-12-10T21:37:46Z",'+
    '      "pushed_at": "2020-06-10T14:09:48Z",'+
    '      "git_url": "git://github.com/bruno-roustant/lucene-solr.git",'+
    '      "ssh_url": "git@github.com:bruno-roustant/lucene-solr.git",'+
    '      "clone_url": "https://github.com/bruno-roustant/lucene-solr.git",'+
    '      "svn_url": "https://github.com/bruno-roustant/lucene-solr",'+
    '      "homepage": null,'+
    '      "size": 426963,'+
    '      "stargazers_count": 0,'+
    '      "watchers_count": 0,'+
    '      "language": "Java",'+
    '      "has_issues": false,'+
    '      "has_projects": true,'+
    '      "has_downloads": true,'+
    '      "has_wiki": false,'+
    '      "has_pages": false,'+
    '      "forks_count": 0,'+
    '      "mirror_url": null,'+
    '      "archived": false,'+
    '      "disabled": false,'+
    '      "open_issues_count": 0,'+
    '      "license": null,'+
    '      "forks": 0,'+
    '      "open_issues": 0,'+
    '      "watchers": 0,'+
    '      "default_branch": "master"'+
    '    }'+
    '  },'+
    '  "base": {'+
    '    "label": "apache:master",'+
    '    "ref": "master",'+
    '    "sha": "53040984f62eedd425c98eb6f60bc54a0e83258b",'+
    '    "user": {'+
    '      "login": "apache",'+
    '      "id": 47359,'+
    '      "node_id": "MDEyOk9yZ2FuaXphdGlvbjQ3MzU5",'+
    '      "avatar_url": "https://avatars0.githubusercontent.com/u/47359?v=4",'+
    '      "gravatar_id": "",'+
    '      "url": "https://api.github.com/users/apache",'+
    '      "html_url": "https://github.com/apache",'+
    '      "followers_url": "https://api.github.com/users/apache/followers",'+
    '      "following_url": "https://api.github.com/users/apache/following{/other_user}",'+
    '      "gists_url": "https://api.github.com/users/apache/gists{/gist_id}",'+
    '      "starred_url": "https://api.github.com/users/apache/starred{/owner}{/repo}",'+
    '      "subscriptions_url": "https://api.github.com/users/apache/subscriptions",'+
    '      "organizations_url": "https://api.github.com/users/apache/orgs",'+
    '      "repos_url": "https://api.github.com/users/apache/repos",'+
    '      "events_url": "https://api.github.com/users/apache/events{/privacy}",'+
    '      "received_events_url": "https://api.github.com/users/apache/received_events",'+
    '      "type": "Organization",'+
    '      "site_admin": false'+
    '    },'+
    '    "repo": {'+
    '      "id": 50229487,'+
    '      "node_id": "MDEwOlJlcG9zaXRvcnk1MDIyOTQ4Nw==",'+
    '      "name": "lucene-solr",'+
    '      "full_name": "apache/lucene-solr",'+
    '      "private": false,'+
    '      "owner": {'+
    '        "login": "apache",'+
    '        "id": 47359,'+
    '        "node_id": "MDEyOk9yZ2FuaXphdGlvbjQ3MzU5",'+
    '        "avatar_url": "https://avatars0.githubusercontent.com/u/47359?v=4",'+
    '        "gravatar_id": "",'+
    '        "url": "https://api.github.com/users/apache",'+
    '        "html_url": "https://github.com/apache",'+
    '        "followers_url": "https://api.github.com/users/apache/followers",'+
    '        "following_url": "https://api.github.com/users/apache/following{/other_user}",'+
    '        "gists_url": "https://api.github.com/users/apache/gists{/gist_id}",'+
    '        "starred_url": "https://api.github.com/users/apache/starred{/owner}{/repo}",'+
    '        "subscriptions_url": "https://api.github.com/users/apache/subscriptions",'+
    '        "organizations_url": "https://api.github.com/users/apache/orgs",'+
    '        "repos_url": "https://api.github.com/users/apache/repos",'+
    '        "events_url": "https://api.github.com/users/apache/events{/privacy}",'+
    '        "received_events_url": "https://api.github.com/users/apache/received_events",'+
    '        "type": "Organization",'+
    '        "site_admin": false'+
    '      },'+
    '      "html_url": "https://github.com/apache/lucene-solr",'+
    '      "description": "Apache Lucene and Solr open-source search software",'+
    '      "fork": false,'+
    '      "url": "https://api.github.com/repos/apache/lucene-solr",'+
    '      "forks_url": "https://api.github.com/repos/apache/lucene-solr/forks",'+
    '      "keys_url": "https://api.github.com/repos/apache/lucene-solr/keys{/key_id}",'+
    '      "collaborators_url": "https://api.github.com/repos/apache/lucene-solr/collaborators{/collaborator}",'+
    '      "teams_url": "https://api.github.com/repos/apache/lucene-solr/teams",'+
    '      "hooks_url": "https://api.github.com/repos/apache/lucene-solr/hooks",'+
    '      "issue_events_url": "https://api.github.com/repos/apache/lucene-solr/issues/events{/number}",'+
    '      "events_url": "https://api.github.com/repos/apache/lucene-solr/events",'+
    '      "assignees_url": "https://api.github.com/repos/apache/lucene-solr/assignees{/user}",'+
    '      "branches_url": "https://api.github.com/repos/apache/lucene-solr/branches{/branch}",'+
    '      "tags_url": "https://api.github.com/repos/apache/lucene-solr/tags",'+
    '      "blobs_url": "https://api.github.com/repos/apache/lucene-solr/git/blobs{/sha}",'+
    '      "git_tags_url": "https://api.github.com/repos/apache/lucene-solr/git/tags{/sha}",'+
    '      "git_refs_url": "https://api.github.com/repos/apache/lucene-solr/git/refs{/sha}",'+
    '      "trees_url": "https://api.github.com/repos/apache/lucene-solr/git/trees{/sha}",'+
    '      "statuses_url": "https://api.github.com/repos/apache/lucene-solr/statuses/{sha}",'+
    '      "languages_url": "https://api.github.com/repos/apache/lucene-solr/languages",'+
    '      "stargazers_url": "https://api.github.com/repos/apache/lucene-solr/stargazers",'+
    '      "contributors_url": "https://api.github.com/repos/apache/lucene-solr/contributors",'+
    '      "subscribers_url": "https://api.github.com/repos/apache/lucene-solr/subscribers",'+
    '      "subscription_url": "https://api.github.com/repos/apache/lucene-solr/subscription",'+
    '      "commits_url": "https://api.github.com/repos/apache/lucene-solr/commits{/sha}",'+
    '      "git_commits_url": "https://api.github.com/repos/apache/lucene-solr/git/commits{/sha}",'+
    '      "comments_url": "https://api.github.com/repos/apache/lucene-solr/comments{/number}",'+
    '      "issue_comment_url": "https://api.github.com/repos/apache/lucene-solr/issues/comments{/number}",'+
    '      "contents_url": "https://api.github.com/repos/apache/lucene-solr/contents/{+path}",'+
    '      "compare_url": "https://api.github.com/repos/apache/lucene-solr/compare/{base}...{head}",'+
    '      "merges_url": "https://api.github.com/repos/apache/lucene-solr/merges",'+
    '      "archive_url": "https://api.github.com/repos/apache/lucene-solr/{archive_format}{/ref}",'+
    '      "downloads_url": "https://api.github.com/repos/apache/lucene-solr/downloads",'+
    '      "issues_url": "https://api.github.com/repos/apache/lucene-solr/issues{/number}",'+
    '      "pulls_url": "https://api.github.com/repos/apache/lucene-solr/pulls{/number}",'+
    '      "milestones_url": "https://api.github.com/repos/apache/lucene-solr/milestones{/number}",'+
    '      "notifications_url": "https://api.github.com/repos/apache/lucene-solr/notifications{?since,all,participating}",'+
    '      "labels_url": "https://api.github.com/repos/apache/lucene-solr/labels{/name}",'+
    '      "releases_url": "https://api.github.com/repos/apache/lucene-solr/releases{/id}",'+
    '      "deployments_url": "https://api.github.com/repos/apache/lucene-solr/deployments",'+
    '      "created_at": "2016-01-23T08:00:06Z",'+
    '      "updated_at": "2020-06-10T16:38:05Z",'+
    '      "pushed_at": "2020-06-10T17:30:04Z",'+
    '      "git_url": "git://github.com/apache/lucene-solr.git",'+
    '      "ssh_url": "git@github.com:apache/lucene-solr.git",'+
    '      "clone_url": "https://github.com/apache/lucene-solr.git",'+
    '      "svn_url": "https://github.com/apache/lucene-solr",'+
    '      "homepage": "https://lucene.apache.org/",'+
    '      "size": 534099,'+
    '      "stargazers_count": 3540,'+
    '      "watchers_count": 3540,'+
    '      "language": "Java",'+
    '      "has_issues": false,'+
    '      "has_projects": true,'+
    '      "has_downloads": true,'+
    '      "has_wiki": false,'+
    '      "has_pages": false,'+
    '      "forks_count": 2425,'+
    '      "mirror_url": null,'+
    '      "archived": false,'+
    '      "disabled": false,'+
    '      "open_issues_count": 278,'+
    '      "license": {'+
    '        "key": "apache-2.0",'+
    '        "name": "Apache License 2.0",'+
    '        "spdx_id": "Apache-2.0",'+
    '        "url": "https://api.github.com/licenses/apache-2.0",'+
    '        "node_id": "MDc6TGljZW5zZTI="'+
    '      },'+
    '      "forks": 2425,'+
    '      "open_issues": 278,'+
    '      "watchers": 3540,'+
    '      "default_branch": "master"'+
    '    }'+
    '  },'+
    '  "_links": {'+
    '    "self": {'+
    '      "href": "https://api.github.com/repos/apache/lucene-solr/pulls/1564"'+
    '    },'+
    '    "html": {'+
    '      "href": "https://github.com/apache/lucene-solr/pull/1564"'+
    '    },'+
    '    "issue": {'+
    '      "href": "https://api.github.com/repos/apache/lucene-solr/issues/1564"'+
    '    },'+
    '    "comments": {'+
    '      "href": "https://api.github.com/repos/apache/lucene-solr/issues/1564/comments"'+
    '    },'+
    '    "review_comments": {'+
    '      "href": "https://api.github.com/repos/apache/lucene-solr/pulls/1564/comments"'+
    '    },'+
    '    "review_comment": {'+
    '      "href": "https://api.github.com/repos/apache/lucene-solr/pulls/comments{/number}"'+
    '    },'+
    '    "commits": {'+
    '      "href": "https://api.github.com/repos/apache/lucene-solr/pulls/1564/commits"'+
    '    },'+
    '    "statuses": {'+
    '      "href": "https://api.github.com/repos/apache/lucene-solr/statuses/a41aee5fe64375e64ae2d45158aa9a85c8507df6"'+
    '    }'+
    '  },'+
    '  "author_association": "CONTRIBUTOR",'+
    '  "merged": false,'+
    '  "mergeable": false,'+
    '  "rebaseable": false,'+
    '  "mergeable_state": "dirty",'+
    '  "merged_by": null,'+
    '  "comments": 0,'+
    '  "review_comments": 0,'+
    '  "maintainer_can_modify": true,'+
    '  "commits": 1,'+
    '  "additions": 97,'+
    '  "deletions": 36,'+
    '  "changed_files": 11'+
    '}]';

}
