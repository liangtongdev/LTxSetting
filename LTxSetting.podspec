Pod::Spec.new do |s|
  s.name         = "LTxSetting"
  s.version      = "0.0.1"
  s.summary      = "关于/配置管理 "
  s.license      = "MIT"
  s.author             = { "liangtong" => "liangtongdev@163.com" }

  s.homepage     = "https://github.com/liangtongdev/LTxSetting"
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/liangtongdev/LTxSetting.git", :tag => "#{s.version}" }

  s.dependency 'LTxCore'
  s.dependency 'LTxCamera/Scan'
 

  s.default_subspecs = 'LTxSettingForSippr'


  # LTxSettingForSippr
  s.subspec 'LTxSettingForSippr' do |sp|
  # sp.public_header_files = "LTxSetting/LTxSettingForSippr/LTxMessage.h"
  # sp.source_files  =  "LTxSetting/LTxSettingForSippr/LTxMessage.{h,m}"
    sp.dependency 'LTxCamera/Scan'

    # Model
    sp.subspec 'Model' do |ssp|
      ssp.source_files  =  "LTxSetting/LTxSettingForSippr/Model/*.{h,m}"
      ssp.public_header_files = "LTxSetting/LTxSettingForSippr/Model/**/*.h"
    end
    # ViewModel
    sp.subspec 'ViewModel' do |ssp|
      ssp.source_files  =  "LTxSetting/LTxSettingForSippr/ViewModel/*.{h,m}"
      ssp.public_header_files = "LTxSetting/LTxSettingForSippr/ViewModel/**/*.h"
    end
    # Views
    sp.subspec 'Views' do |ssp|
      ssp.source_files  =  "LTxSetting/LTxSettingForSippr/Views/*.{h,m}"
      ssp.resource  =  "LTxSetting/LTxSettingForSippr/Views/*.xib"
      ssp.public_header_files = "LTxSetting/LTxSettingForSippr/Views/**/*.h"
      ssp.dependency 'LTxSetting/LTxSettingForSippr/Model'
    end
    # Controllers
    sp.subspec 'Controllers' do |ssp|
      ssp.source_files  =  "LTxSetting/LTxSettingForSippr/Controllers/*.{h,m}"
      ssp.public_header_files = "LTxSetting/LTxSettingForSippr/Controllers/**/*.h"
      ssp.dependency 'LTxSetting/LTxSettingForSippr/Views'
      ssp.dependency 'LTxSetting/LTxSettingForSippr/ViewModel'
    end
    # Core
    sp.subspec 'Core' do |core|
        core.source_files  =  "LTxSetting/LTxSettingForSippr/LTxSettingForSippr.h"
        core.public_header_files = "LTxSetting/LTxSettingForSippr/LTxSettingForSippr.h"
        core.dependency 'LTxSetting/LTxSettingForSippr/Controllers'
    end
  end

end
