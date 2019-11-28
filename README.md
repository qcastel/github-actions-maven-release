# github action maven release

The GitHub Action for Maven releases wraps the Maven CLI to enable Maven release to be run by a bot.
You can use this action for auto-releasing your java artefacts each time you commit into master.

The release will allow you to setup a GPG key for your bot.

# Usage

## Maven release

For a simple repo with not much protection and private dependency, you can do:

```
 - name: Release
      uses: qcastel/github-actions-maven/actions/release@master
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

```
 - name: Release
      uses: qcastel/github-actions-maven/actions/release@master
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
      uses: qcastel/github-actions-maven/actions/release@master
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
      uses: qcastel/github-actions-maven/actions/release@master
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

We welcome contributions! If your usecase is slightly different than us, just suggest a RFE or contribute to this repo directly.

# License
The Dockerfile and associated scripts and documentation in this project are released under the MIT License.

