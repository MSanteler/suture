require "suture/interprets_results"

module Suture
  class InterpretsResultsTest < Minitest::Test
    def setup
      @subject = InterpretsResults.new
    end

    def test_success_is_a_no_op
      test_result = Value::TestResults.new([])

      result = @subject.interpret(test_result)

      assert_equal nil, result
    end

    def test_fail_and_all_ran
      test_result = Value::TestResults.new([{:passed => false, :ran => true}])

      expected_error = assert_raises(Suture::Error::VerificationFailed) {
        @subject.interpret(test_result)
      }
    end
  end
end
