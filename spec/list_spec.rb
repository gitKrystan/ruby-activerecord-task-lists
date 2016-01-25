require "spec_helper"

describe(List) do
  describe('#tasks') do
    it('tells which tasks are in it') do
      test_list = create_test_list()
      first_task = create_test_task(test_list.id())
      second_task = create_test_task(test_list.id())
      expect(test_list.tasks()).to(eq([first_task, second_task]))
    end
  end
end
