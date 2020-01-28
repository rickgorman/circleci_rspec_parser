# circleci_rspec_parser
circleci + artifacts = Which rspec files have the most test failures?

# Usage

1. [Get a CircleCI token](https://circleci.com/docs/api/#authentication) for your account.
2. Run the script:

`$ CIRCLE_TOKEN=your_token_here ruby build_failing_csv.rb`

3. Inspect the CSV created.


# License

[WTFPL](http://www.wtfpl.net/)
