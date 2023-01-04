require 'fastlane/action'
require_relative '../helper/package_submit_helper'

module Fastlane
  module Actions
    class PackageSubmitAction < Action
      def self.run(params)

        local_ipa_path=params[:local_ipa_path]
        local_ipa_name=params[:local_ipa_name]

        UI.message("📄 ===== COS 上传开始 =====")
        Actions.sh("coscmd","upload",local_ipa_path,"ios/"+local_ipa_name)
        UI.message("📄 ===== COS 上传完成 =====")

        endpoint=params[:endpoint]
        app_name=params[:app_name]
        app_version=params[:app_version]
        app_type=params[:app_type]
        app_id=params[:app_id]
        time=params[:time]
        bundle=params[:bundle]
        wechat_webhook=params[:wechat_webhook]
        git_log=params[:git_log]
        ipa_url=params[:ipa_url]

        UI.message("💻 ===== 提交更新信息 =====")
        uri = URI(endPoint)
        req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
        req.body = {
          'appName': app_name,
          'version': app_version,
          'type': app_type,
          'project_id': app_id,
          'time': time,
          'bundle': bundle,
          'webhook': wechat_webhook,
          'git_log': git_log,
          'file_name': local_ipa_name,
          'ipa_url': ipa_url,
        }.to_json
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        res = https.request(req)
        puts "Response #{res.code} #{res.message}: #{res.body}"

        UI.message("💻 ===== 更新信息完成 =====")
      end

      def self.description
        "Upload ipa and associated .plist to specified server."
      end

      def self.authors
        ["Akring"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        ""
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :local_ipa_path,
                                  env_name: "",
                               description: "本地 ipa 文件路径",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :local_ipa_name,
                                  env_name: "",
                               description: "本地 ipa 文件名",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :endpoint,
                                  env_name: "",
                                description: "分发服务器 URL",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :app_name,
                                  env_name: "",
                                description: "应用名称",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :app_version,
                                  env_name: "",
                                description: "应用版本",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :app_type,
                                  env_name: "",
                                description: "应用类型",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :app_id,
                                  env_name: "",
                                description: "分发平台上应用 ID",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :time,
                                  env_name: "",
                                description: "上传时间",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :bundle,
                                  env_name: "",
                                description: "应用 Bundle",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :wechat_webhook,
                                  env_name: "",
                                description: "企业微信 webhook 回调",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :ipa_url,
                                  env_name: "",
                                description: "cos ipa 路径",
                                  optional: false,
                                      type: String),       
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        [:ios].include?(platform)
        true
      end
    end
  end
end
