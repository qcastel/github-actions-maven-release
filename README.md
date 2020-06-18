# github action maven release

The GitHub Action for Maven releases wraps the Maven CLI to enable Maven release to be run by a bot.
You can use this action for auto-releasing your java artefacts each time you commit into master.

The release will allow you to setup a GPG key for your bot.

# Usage

## Maven release

For a simple repo with not much protection and private dependency, you can do:

```
 - name: Release
      uses: qcastel/github-actions-maven-release@master
      with:
        release-branch-name: "master"

        git-release-bot-name: "release-bot"
        git-release-bot-email: "release-bot@example.com"

        access-token: ${{ secrets.GITHUB_ACCESS_TOKEN }}
```
You can add some maven options, which is handy for skipping tests:
```
        maven-args: "-Dmaven.javadoc.skip=true -DskipTests -DskipITs -Ddockerfile.skip -DdockerCompose.skip"
```

If you want to setup a GPG key, you can do it by injecting your key via the secrets:

Note: `GITHUB_GPG_KEY` needs to be base64 encoded.
if you haven't setup a GPG key yet, see next section

```
 - name: Release
      uses: qcastel/github-actions-maven-release@master
      with:
        release-branch-name: "master"
        gpg-enabled: "true"
        gpg-key-id: ${{ secrets.GITHUB_GPG_KEY_ID }}
        gpg-key: ${{ secrets.GITHUB_GPG_KEY }}

        git-release-bot-name: "release-bot"
        git-release-bot-email: "release-bot@example.com"

        access-token: ${{ secrets.GITHUB_ACCESS_TOKEN }}
```


If you got a private maven repo to setup in the settings.xml, you can do:
Note: we recommend putting those values in your repo secrets.

```
 - name: Release
      uses: qcastel/github-actions-maven-release@master
      with:
        release-branch-name: "master"

        maven-repo-server-id: ${{ secrets.MVN_REPO_PRIVATE_REPO_USER }}
        maven-repo-server-username: ${{ secrets.MVN_REPO_PRIVATE_REPO_USER }}
        maven-repo-server-password: ${{ secrets.MVN_REPO_PRIVATE_REPO_PASSWORD }}

        git-release-bot-name: "release-bot"
        git-release-bot-email: "release-bot@example.com"

        access-token: ${{ secrets.GITHUB_ACCESS_TOKEN }}
```

Here is an example with all of the options at the same time:

```
 - name: Release
      uses: qcastel/github-actions-maven-release@master
      with:
        release-branch-name: "master"

        gpg-enabled: "true"
        gpg-key-id: ${{ secrets.GITHUB_GPG_KEY_ID }}
        gpg-key: ${{ secrets.GITHUB_GPG_KEY }}

        maven-repo-server-id: ${{ secrets.MVN_REPO_PRIVATE_REPO_USER }}
        maven-repo-server-username: ${{ secrets.MVN_REPO_PRIVATE_REPO_USER }}
        maven-repo-server-password: ${{ secrets.MVN_REPO_PRIVATE_REPO_PASSWORD }}

        maven-args: "-Dmaven.javadoc.skip=true -DskipTests -DskipITs -Ddockerfile.skip -DdockerCompose.skip"

        git-release-bot-name: "release-bot"
        git-release-bot-email: "release-bot@example.com"

        access-token: ${{ secrets.GITHUB_ACCESS_TOKEN }}
```

You may also be in the case where you got more than one maven projects inside the repo. We added an option that will make the release job move to the according directy before running the release:

```
        maven-project-folder: "sub-folder/"
```

We welcome contributions! If your usecase is slightly different than us, just suggest a RFE or contribute to this repo directly.

## Setup the bot gpg key

Setting up a gpg key for your bot is a good security feature. This way, you can enforce sign commits in your repo,
even for your release bot.

![Screenshot-2019-11-28-at-20-47-06.png](https://i.postimg.cc/9F6cxpqm/Screenshot-2019-11-28-at-20-47-06.png)

- Create dedicate github account for your bot and add him into your team for your git repo.
- Create a new GPG key: https://help.github.com/en/github/authenticating-to-github/generating-a-new-gpg-key

This github action needs the key ID and the key base64 encoded.

```$xslt
        gpg-key-id: ${{ secrets.GITHUB_GPG_KEY_ID }}
        gpg-key: ${{ secrets.GITHUB_GPG_KEY }}
```

### Get the KID

You can get the key ID doing the following:

```$xslt
gpg --list-secret-keys --keyid-format LONG

sec   rsa2048/3EFC3104C0088B08 2019-11-28 [SC]
      CBFD9020DAC388A77C68385C3EFC3104C0088B08
uid                 [ultimate] bot-openbanking4-dev (it's the bot openbanking4.dev key) <bot@openbanking4.dev>
ssb   rsa2048/7D1523C9952204C1 2019-11-28 [E]

```
The key ID for my bot is 3EFC3104C0088B08. Add this value into your github secret for this repo, under `GITHUB_GPG_KEY_ID`
PS: the key id is not really a secret but we found more elegant to store it there than in plain text in the github action yml

### Get the GPG private key

Now we need the raw key and base64 encode
```$xslt
gpg --export-secret-keys --armor 3EFC3104C0088B08 | base64
```

Copy the result and add it in your github repo secrets under `GITHUB_GPG_KEY`.

Go the bot account in github and import this GPG key into its profile.


# License
The Dockerfile and associated scripts and documentation in this project are released under the MIT License.

