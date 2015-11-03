test: test_spec	test_lint test_integration
test_ci: test_spec test_lint

test_spec:
	chef exec rspec test/unit

test_integration:
	chef exec kitchen test

test_lint: test_lint_ruby	test_lint_chef

test_lint_ruby:
	chef exec rubocop

test_lint_chef:
	chef exec foodcritic -f any .

package:
	chef exec berks vendor cookbooks
	bash package.sh

watch:
	chef exec rubocop
