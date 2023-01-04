describe Fastlane::Actions::PackageSubmitAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The package_submit plugin is working!")

      Fastlane::Actions::PackageSubmitAction.run(nil)
    end
  end
end
