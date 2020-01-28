# circleci_rspec_parser
circleci + artifacts = Which rspec files have the most test failures?

# Usage

1. [Get a CircleCI token](https://circleci.com/docs/api/#authentication) for your account.
2. Run the script. Note that all env vars are mandatory _except_ BUILD_NUMBER,
   which will default to `latest` if left empty.

`$ CIRCLE_TOKEN=your_token_here USERNAME=your_circleci_org_username PROJECT_NAME=your_circleci_org_project_name BUILD_NUMBER=build_to_inspect ruby build_failing_csv.rb`

3. Inspect the CSV created.


# License

[WTFPL](http://www.wtfpl.net/)
