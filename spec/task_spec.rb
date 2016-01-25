require "spec_helper"

describe(Task) do
  describe('#list') do
    it('tells which list it belongs to') do
      test_list = create_test_list()
      test_task = create_test_task(test_list.id())
      expect(test_task.list()).to(eq(test_list))
    end
  end
end
