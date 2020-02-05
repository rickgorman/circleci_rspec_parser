# circleci_rspec_parser
Which rspec files have the most test failures?

# Usage

1. [Get a CircleCI token](https://circleci.com/docs/api/#authentication) for your account.
2. `bundle install`
2. Run the script. Note that all env vars are mandatory _except_ for:
   * `BUILD_NUMBER` => defaults to `latest`
   * `VCS_NAME` => defaults to `github`
   which will default to `latest` if left empty.

`CIRCLE_TOKEN=<your_token_here> USERNAME=<your_circleci_org_username> PROJECT_NAME=<your_circleci_org_project_name> VCS_NAME=<github/other> BUILD_NUMBER=<build_to_inspect> BRANCH=<branch_name> ruby build_failing_csv.rb`

3. A csv named `rspec_errors_by_filename.csv` is created.


# License

[WTFPL](http://www.wtfpl.net/)
