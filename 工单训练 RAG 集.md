
# ID: 37081

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description:  .advancedFeatures(JoinConvoAIReq.AdvancedFeatures.builder()
                                    .enableAIVad(false)
                                    .build())

我们创建智能体的时候, 设置enableAIVad为false, 还是会被语音输入打断, 怎么解决呢

Reply: 您好，enableAIVad 是控制是否开启优雅打断，不控制普通打断的开关，请配置 turn_detection 字段来让智能体不受人声打断。

---

# ID: 37083

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 效果不佳、不达预期

Request Description: 自渲染音频效果不佳

Reply: 您好，请问自渲染效果不佳的具体表现是什么样的？有对齐渲染的播放率和原始音频的采样率一致吗？麻烦完整描述下问题表现
以及自渲染的效果取决于您自己的业务，可能更多的需要您自行排查。

---

# ID: 37088

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 可以根据频道Id查询到录制的sid吗？有没有相应的接口

Reply: 您好，查不到。sid 是录制启动成功以后返回的唯一标识符，需要您自行保存，无法通过频道号找回。

---

# ID: 37090

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 效果不佳、不达预期

Request Description:     AgoraAudioRecordingConfiguration *config = [[AgoraAudioRecordingConfiguration alloc] init];
    config.filePath = tempPath;
    config.fileRecordOption = AgoraAudioFileRecordingTypeMic;
    config.sampleRate = self.samplingRate;
    config.recordingChannel = 1;
    int result = [self.agoraKit startAudioRecordingWithConfig:config];
您好，我使用上面的代码录制的wav格式音频，偶现没有头文件的问题。导致音频无法播放。请问这个是什么原因导致。
有问题的wav文件我上传到附件中了。

Reply: 您好，可以确认下被指定录制的用户有没有在发流，如果确认远端正常发流但是录制到的内容无法播放，可以提供下录制端复现问题时的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，人工工程师稍后解答。

---

# ID: 37092

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 线上报错

Request Description: 2025-09-09 18:35:15 [ pool-13-thread-1:1704546 ] - [ INFO ] 开始语音审核流程，频道：256，随机UID：757
2025-09-09 18:35:15 [ pool-13-thread-1:1704834 ] - [ ERROR ] 运行语音审核任务出错：HTTP 400: {"message":"appid is invalid"}

Reply: 您好，请问现在使用的是云市场语音审核插件吗？如果是的话麻烦提供下具体的云录制 sid，人工工程师稍后为您解答。

---

# ID: 37048

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: APP需要对接RDT，但是在文档中心没有找到对应的文档，只有C语言的，请问app关于RDT的文档在哪里查卡

Reply: 您好，RDT 功能包含在 SDK 内，参考[通过 RDT 通道收发消息](https://doc.shengwang.cn/doc/rtsa/c/advanced-features/send-message-through-rdt-channel)实现就行。

---

# ID: 37050

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 我们在web端开发的对话式ai, 现在是要实现实时字幕, 遇到问题, 无法获取到用户对话的文本
通过昨天你们同事给的方法来获取文本 this.rtcClient.on("stream-message", (uid, message) => {
 console.log('===>receice message')
            //接收
            console.log(`receice ${message} from ${uid}`);
        });

1. 无法获取到用户对话的文本,只能获取到智能体返回的文本
2. 用户也加入了rtm频道

Reply: 您好，实时字幕是有 Web 组件的，直接获取 datastream 以后不解析是拿不到原始数据的，建议看下[实时字幕](https://doc.shengwang.cn/doc/convoai/restful/user-guides/realtime-sub)，里面有实时字幕的 Demo ，演示了如何同时获取智能体和用户的转写字幕。

---
# ID: 37051

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 云端录制时的文件路径能否提供查询接口？
结束录制时可能因为网络请求和客户操作的各种问题导致结束录制失败，只能能自动结束。
这个时候就无法获取视频文件的地址，能否提供一个视频文件列表的查询接口，以避免因意外情况获取不到视频文件的情况，谢谢。
获取失败到视频链接的概率有25%

Reply: 您好，录制结束以后上传是不会停的，上传完毕会有对应的 [31 uploaded](https://doc.shengwang.cn/doc/cloud-recording/restful/webhook/uploading#31-uploaded)NCS 事件，建议用 NCS 事件来判断上传的情况和文件路径。

目前没有针对 sid 查询录制上传状态的接口，但是可以[查询录制状态](https://doc.shengwang.cn/doc/cloud-recording/restful/best-practices/recording-status)

---

# ID: 37055

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 云播放器webhook回调中 eventType=3时销毁事件回调中的参数里 ：playTs为什么没有值

Reply: 您好，请检查创建云播放器的时候playTs 有没有传值，destroy 需要看到的话需要保证在[创建云端播放器](https://doc.shengwang.cn/doc/media-pull/restful/media-pull/operations/get-region-v1-projects-appId-cloud-player-players)的时候传值。

---
# ID: 37056

SDK Product: Media-push

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 效果不佳、不达预期

Request Description: 通话 ID：68bbee39a0fed77f6397665c
开启RTC直播UID 1670866524，在web页面可以正常播放UID 3159560875，画面有内容
创建旁路推流 converterId: 9C748DB8F2419A4311C9C38B24CF494A,channelName: 1581F6Q8D241P00B0GR3_81-0-0_normal-0,UID:1925067267无法播放，没有画面内容

Reply: 您好，请问目前是在用旁路推流转推大疆无人机发来的画面吗？如果是的话可以尝试让旁路推流开启转码，看下转码后是否正常，如果转码后正常，请联系大疆侧“加入防竞争协议”来解决此类问题。
如果不是大疆无人机，请提供下出现问题的 converterId ，这是创建旁路推流成功后返回的字段。

---
# ID: 37058

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: 声网后台显示 9.5 消耗 24mins ，实际通过 webhook 返回给我们这边记录到只有 2mins ，请问如何排查消耗数量完全不一致的问题呢

Reply: 您好，声网 SDK 是按照订阅时长来计费的，并非真实通话时间。可以参考[计费策略](https://doc.shengwang.cn/doc/rtc/ios/billing/billing-strategy)，具体细节解读您可以和商务沟通，电话：400 6326626

---

# ID: 37063

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 线上报错

Request Description: 部署到服务器后出现图中异常.服务器目前未备案,因为安全问题,不开放443端口,故无法申请ssl证书使用https.
目前项目中并未使用到麦克风等设备,项目中只需要实现客户端功能(即收看,直播源不包含音频),不涉及声音视频采集设备的调用,是否可以通过设置来规避方法enumerateDevices()的异常?

Reply: 您好，WebSDK 依赖 WebRTC协议，WebRTC 协议只支持 https 和 localhost 环境，http是不支持的。

---

# ID: 37066

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 其他问题

Request Description: 1、近几日视频直播数据很少但是音频直播很大，怀疑web页面观众没有正常退出。
2、急需要销毁直播通道的接口，可以及时销毁冗余的直播通道。但在文档中未找到销毁 channel 的接口，通过和客服沟通需要技术支持。

需求：需要对接服务端销毁channel的接口。


Reply: 您好，可以参考这些文档：[踢人接口](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/post-dev-v1-kicking-rule)
可以配合[查询用户列表](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/get-dev-v1-channel-user-appid-channelName)来使用

---

# ID: 37068

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.2.0

Request Type: 集成问题咨询

Request Description: flutter集成的语音通话，在iOS平台能否实现VoIP推送

Reply: 您好，请问您指的 VOIP 是 callkit 一类的呼叫组件吗？这个能力是组件提供的，RTC 本身不支持，需要您自行集成来实现相关业务。

---

# ID: 37073

SDK Product: RTC

SDK Platform: Windows

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 问题：
1.这个是我的测试账号 为什么创建的项目被归档了。
2.1@croissant.so 这个是公司账号内部测试阶段 也被归档了。

诉求：
调查原因及如何避免被归档。


Reply: 您好，请提供具体 cid，人工工程师稍后为您解答

---

# ID: 37075

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 从官网下载的demo 在浙里办APP打开 ，安卓视频通话是正常的，苹果端  join 的时候没有反应,导致无法创建与加入视频房间  抓包看了下有multi unilbs network error, retry  这个警告，不知是否对加入和创建音视频房间有影响。希望协助排查无法加入音视频房间的原因。

Reply: 您好，multi unilbs network error 代表您的网络现在有多出口 IP 问题，换一个没有多出口 IP 的网络就行了。
以及在 app 内集成 Web SDK 需要保证所用的 Webview 本身支持 webrtc 协议，否则无法保证功能完整，参考[浏览器兼容性和已知问题](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility)

---
# ID: 37076

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 
现在我可以打印出远程批频道中的用户，但是调用client.value
    .subscribe(user, mediaType)时会报错Uncaught (in promise) AgoraRTCException: AgoraRTCError INVALID_REMOTE_USER: user is not in the channel，怎么解决

Reply: 您好，请问是在用 vue 吗？可以从以下两个方向去排查下
1、检查有没有多个 client，避免订阅错 client
2、vue在data中用对象不能接收，检查下自己的项目里有没有双向绑定的行为，如果有，请避免。 之前其他客户遇到过，当时是发现const client = AgoraRTC.createClient({ mode: "live", codec: "vp8" });这行代码的client放在js中就没问题，如果把client赋值给对象内的属性，使用属性 就会出现问题

---
# ID: 37077

SDK Product: RTC-Linux

SDK Platform: Linux-Java

SDK Version: 4.4.31

Request Type: 集成问题咨询

Request Description: 1) 现在我通过安卓端收集声音, 但是在linux服务端获取不到数据, 接口中 onPlaybackAudioFrameBeforeMixing没有被调用了. 请确认下是否是账号或appId问题

Reply: 您好，请确定本地已经加入频道成功，onPlaybackAudioFrameBeforeMixing 需要加入频道收到远端的音频才能触发。如果确认加入成功且远端正常发流还收不到，可以提供下 SDK 日志，人工工程师稍后为您解答

---

# ID: 37024

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 3.7.2.1版本迁移到4.6.0版本，         mRtcEngine.setCameraCapturerConfiguration(
                    new CameraCapturerConfiguration(
                            CameraCapturerConfiguration.CAPTURER_OUTPUT_PREFERENCE.CAPTURER_OUTPUT_PREFERENCE_PERFORMANCE,
                            CameraCapturerConfiguration.CAMERA_DIRECTION.CAMERA_FRONT
                    )
            );设置摄像头策略这四个枚举：https://docportal.shengwang.cn/cn/video-legacy/API%20Reference/java/enumio_1_1agora_1_1rtc_1_1video_1_1_camera_capturer_configuration_1_1_c_a_p_t_u_r_e_r___o_u_t_p_u_t___p_r_e_f_e_r_e_n_c_e.html#aeebd07224559669e412eb34d6e9a4a53 在新版本用哪个API去设置：“预览质量接近于编码器的输出质量”

Reply: 您好，4.x 上已经去掉了这个枚举，并把这个行为设置为默认了，无需在采集时额外配置。

---
# ID: 37025

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 声网服务器调用api禁用 publish_audio或者视频权限，客户端的sdk会有代理知道自己被禁用了吗？localAudioStateChanged测试是没有回调的

Reply: 您好，封禁接口的发流封禁对于客户端是无法感知的，客户端改变采集或者发流状态都不会影响频道内的情况，因为我们服务端会自动丢弃这个 uid 发来的所有流直到封禁时间到期。如果需要同步客户端需要您在调用封禁接口时同步发送信令自行实现。

---
# ID: 37026

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.0

Request Type: 效果不佳、不达预期

Request Description: 目前我rtm 2.2.5 rtc 4.5.0 都有so包没16kb对齐 目前是没开发 还是需要更新版本才能对齐 因为应用商店强制要求对齐了

Reply: 您好，升级 RTC 和 RTM 到最新版本即可解决，如果升级后 Android  studio 还提示不支持 16KB，可以升级下 gradle 版本到 8.7+，升级后就没有问题了。

---
# ID: 37027

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 效果不佳、不达预期

Request Description: app异常结束，服务端需要把直播间的观众全部移除，目前这个踢人规则是一个个踢出去的感觉不是很合理

Reply: 您好，直接按 CNAME 封禁就是全频道的 uid 都踢了，不需要手动一个个踢出。
参考[创建规则](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/post-dev-v1-kicking-rule)。

---
# ID: 37028

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 调用司空2的开启直播接口，返回的参数该如何使用，"url_type":"agora"，返回的url该如何使用。
{"code":0,"message":"","data":{"expire_ts":1756984980,"url":"http://192.168.103.161:30806/rtc/v1/whep/?app=live\u0026stream=1693F8HGX254M00A09SL_177-1-0\u0026token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwcm9kdWN0X2lkIjoiNzEzNTE5ZmIxYjRlNDRiYTlkMjdkMDJhOGRlZDk5NGQiLCJjaGFubmVsX25hbWUiOiIxNTgxRjhIR1gyNTRNMDBBMDlTTF8xNzYtMC0wIiwidWlkIjoxMDAwNTAsImFjdGlvbiI6InBsYXkiLCJleHAiOjE3ODg1MjA5MjIsIm5iZiI6MTc1Njk4NDkyMiwiaWF0IjoxNzU2OTg0OTIyfQ.clQRXgh4OVtoihMOH5WiHoIub-sCKWKVD2iQZIqoeu0","url_type":"agora"}}

Reply: 您好，如果用的是司空平台可以咨询下大疆侧，我们不太清楚大疆封装的业务。
如果您想自行集成 RTC 的话可以参考下[大疆用户的 RTC 说明书](https://i46hiqvame.feishu.cn/docx/LiWxdLMtUobkAmxmjuHc33mtnEd?from=from_copylink)

---
# ID: 37029

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 集成问题咨询

Request Description: 1.我是用web端rtcsdk，是从github上面拉下来的agora-demo的这个项目，我获取了token之后加入频道了，但是频道事件回调中参数的uid和我加入频道时的uid不是同一个这是什么情况：


Reply: 您好，请检查下是否用到了joinChannelWithUserAccount 方法，这表示用 string 类型 uid 去加频道，string uid 会自动映射一个随机的 int uid，导致您收到的回调是这个 int uid 的，和 string 的对不上。建议全部使用joinChannel，直接用 int 类型 uid 去加入频道，这样回调就准确了。

---
# ID: 37031

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 调用：mRtcEngine.queryCodecCapability() 返回四个对象对应值：codecType：1 codecCapMask：12，hwDecodingLevel：-1， swDecodingLevel：-1       。codecType：2 codecCapMask：15，hwDecodingLevel：-1， swDecodingLevel：-1    。codecType：3 codecCapMask：5，hwDecodingLevel：-1， swDecodingLevel：-1       。codecType：12 codecCapMask：12，hwDecodingLevel：-1， swDecodingLevel：-1。查询文档没有相关说明，如何知道目前 SDK 支持的视频编解码能力。

Reply: 您好，可以通过监听[onLocalVideoStats](https://doc.shengwang.cn/api-ref/rtc/android/API/class_localvideostats)来感知目前的编码协议和编码类型。

---
# ID: 37032

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.3.0

Request Type: 崩溃（闪退、卡死）

Request Description: ue5.4 蓝图sdk 初始化后 绑定event  没有返回 OnJoinChannelSuccess  回调 但是状态码返回的0
定期伴随崩溃

Reply: 您好，没有OnJoinChannelSuccess 表示加入频道没有成功，只是方法调用完成了，大概率是 token 不正确导致的

请问您现在有跑通 Demo 吗？可以先看下这个文档跑通我们的 [UE Demo](https://doc.shengwang.cn/doc/rtc/unreal-blueprint/get-started/run-demo)，看下跑Demo 会不会崩溃

---

# ID: 37035

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 接收端1615293091收不到发端293091888的视频流

Reply: 您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 现象录屏:如果有的话尽量提供
4. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# ID: 37037

SDK Product: RTM

SDK Platform: JavaScript

SDK Version: 其他版本

Request Type: 其他问题

Request Description: Ins#1 RTM:ERROR [UTC_Time: 09-05 07:17:50.10][uid: 123***789]login failed with args: {"tok**":"007eJxTYLib5Sf1pN5hnXHY5dO7DzMfn8i2lCldU1z5v93vQPsnc6YoMJgaGBsYpKammhhZWpgYAYnUJEtDU3MTk9QUE3NTE4OjHbs*********************************************"}. +0ms  报错这个不知道为什么

Reply: 请问报错有出现过RtmInternalError: Cannot get illegal sid.的内容吗？
如果在用 vue，请把 rtm instance 存在全局，先不用 ref 的方式。vue 底层是 proxy，这样会让 rtm 内部有问题，导致报错。

---
# ID: 37038

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 我通过setVideoEncoderConfiguration 设置了degradationPreference 。每次更新策略需要调用enableLocalVideo 开关一下吗？我去哪个回调方法里边监听看我设置的策略是否生效？

Reply: 您好，setVideoEncoderConfiguration 的配置是即时生效的，编码分辨率和编码策略会实时改变。
但setVideoEncoderConfiguration 配置的是编码，本地预览看的是编码前的画面，调用setVideoEncoderConfiguration无法修改本地预览看到的画面分辨率，需要手动重启摄像头采集去实现。

---

# ID: 37040

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 集成问题咨询

Request Description: 集成registerEventHandler方法时，提示ErrorCodeType.errInvalidToken
生成的token也已经确认了证书和uid等信息。使用官方解析数据也一致

服务端token使用python3 官方示例

Reply: 您好，临时 token 不校验 uid 所以能进频道，自己生成的 token 是要校验 uid 的，您需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道

控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验
将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致

如果您确定 token 本身没有问题，可以再检查下前端传值有没有地方被写死成固定值。

---

# ID: 37042

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 我们的频道在线列表  因为同时自己服务器接口操作   又声网webhook回调  偶现的会引起用户卡频道内的问题  现在想通过调用声网在频道内的用户来过滤掉卡房间的用户   想了解一下这个接口是否有频次限制   限制是多少

https://api.sd-rtn.com/dev/v1/channel/user/{appid}/{channelName}

Reply: 您好，服务端有[调用限制](https://doc.shengwang.cn/doc/rtc/restful/quota)

---

# ID: 37044

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 是否支持“微信小程序”外的小程序，例如“支付宝小程序”等

Reply: 您好，不支持微信小程序以外的其他小程序，目前其他小程序没有对应的 RTC SDK 可以使用。

---
# ID: 37045

SDK Product: IM

SDK Platform: Web

SDK Version: 1.3.2

Request Type: 商务问题

Request Description: 你好 我们在做一个体育直播项目，直播间里有聊天室。
我看咱们声网没有单独的聊天室api吗？只能买全量IM服务吗？为了直播间每月4000有点多。

Reply: 您好 RTC 本身有 [datastream](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_datastream) 可以用来传递文本消息，如果要用功能全面的 IM，建议用[环信 IM](https://www.easemob.com/)

---

# ID: 37047

SDK Product: RTC-Linux

SDK Platform: Linux-Java

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: RTC服务端SDK的Java API中，通过io.agora.rtc.IVideoEncodedFrameObserver.onEncodedVideoFrame()得到了EncodedVideoFrameInfo，但其中的captureTimeMs视频采集时间戳、decodeTimeMs视频渲染时间戳、presentationMs时间戳一直是0，这是怎么回事？用户希望通过这两个时间戳得到详细的帧延迟。JAVA服务端SDK版本是4.4.32.101（最新版），已设置setEncodedFrameOnly(0)。Web JS客户端SDK版本是4.24.0，编码器用的是vp8。

Reply: 您好，麻烦复现后提供下服务端 SDK 的日志，说明下出现问题的具体时间点，人工工程师稍后为您解答

---

# ID: 37009

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: agora-electron-sdk 在渲染进程中直接使用时会报错Uncaught (in promise) ReferenceError: exports is not defined或者Uncaught (in promise) ReferenceError: require is not defined，好像是出现了 CommonJS/ESM 兼容性问题。

Reply: 您好，SDK应该在渲染进程调用。Uncaught (in promise) ReferenceError: xxx is not defined 可能是是模块加载方式有问题，您可以自行检查一下。以及建议您先参考下我们的文档[跑通 Demo](https://doc.shengwang.cn/doc/rtc/electron/get-started/run-demo)

---

# ID: 37018

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 集成RTC    SDK3.7.2.1版本，如何关闭声网 SDK 默认开启 3A，即音频处理中的回声消除 (AEC)、降噪 (ANS) 和增益控制 (AGC)。

Reply: 您好，3.x 已经停止更新维护了，建议使用 4.x，在 4.x 上[关闭 3A 处理](https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality#%E5%85%B3%E9%97%AD-3a)

---
# ID: 37019

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 请求url https://api.sd-rtn.com/cn/v1/projects/f892500af10e41869e4baeab5fdc8af1/rtmp-converters
header ：Authorization  Basic MjczZmIyZDVhMjA1NDgwYzgwMjNlNjkzNTMyNTJiNzA6NmNkNDQyYjhjODNkNDE5ZWE3ZDQ0NjliNDlmOWFkOWI=

body ：{"converter":{"name":"xunjian_1581F6Q8X254B00G07PS_1756969696878","transcodeOptions":{"rtcChannel":"xunjian_1581F6Q8X254B00G07PS","audioOptions":null,"videoOptions":null},"rtmpUrl":"rtmp://push-agora.xunjikejiai.site/live1581F6Q8X254B00G07PS","idleTimeout":300}}


返回信息 {"reason": "No invalid permission to use this function. Contact us."}
已经开通了cdn权限

Reply: 您好，您现在调用的接口和收到的报错是旁路推流服务，并不是融合 CDN。请确保 appid 有开通服务端旁路推流功能，[开通方式](https://doc.shengwang.cn/doc/media-push/restful/get-started/enable-service)

---
# ID: 37020

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 其他问题

Request Description: 怎么能够让接通电话之后ios在后台依旧能够听到和说话呢，就是后台也能正常通话，现在接通电话进入后台立马没声音了

Reply: 您好，请参考[为什么部分 iOS 版本 App 锁屏或切后台后音视频采集无效？](https://doc.shengwang.cn/faq/quality-issues/ios-background)
在 xcode 里开启后台保活来避免被系统限制采集。

---

# ID: 36986

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 生成rtc token时报错 Handler dispatch failed; nested exception is java.lang.NoSuchMethodError: java.nio.ByteBuffer.rewind()Ljava/nio/ByteBuffer;


Reply: 您好，请参考 [token 文档](https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication#token-code)，clone 这个仓库，然后跑里面的脚本来生成，这样我们定义的方法就都有了。
以及注意 Java 版本要是用 1.8 及以上

---
# ID: 36987

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.6

Request Type: 其他问题

Request Description: 我想用hello_rtsa调试设备端的opus编解码； 想让hello_rtsa发送出opus编码音频，但是发现它送出的还是pcm(100)格式的数据, 这是为何？

Reply: 您好，如果使用了 [SDK 编解码器](https://doc.shengwang.cn/doc/rtsa/c/basic-features/audio-codec)，那么接收远端音频数据的时候 SDK 回自动解码成 PCM，如果需要收到的回调就是编码格式，需要关闭 SDK 编码器，使用自编码。

---
# ID: 36988

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.2.5

Request Type: 集成问题咨询

Request Description: 我的服务端如果需要发送rtm消息 能否使用RTM RESTful API。还是需要服务端也继承 rtm sdk呢？

Reply: 您好，两种方式都可以，RTM restful 接口目前只能做[发布消息](https://doc.shengwang.cn/api-ref/rtm2/restful/toc-message/publish)和[获取历史消息](https://doc.shengwang.cn/api-ref/rtm2/restful/toc-message/receive)，如果有其他需求的话建议用服务端 SDK。

---

# ID: 36990

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.5.2

Request Type: 其他问题

Request Description: electron sdk 4.5.2是否支持electron 35.1.5版本？

Reply: 您好，大于 25 的版本需要用一个特殊方案来解决，但不是长期解决方案，如果方便的话优先建议使用 25 及以下的版本。

---
# ID: 36991

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 报错1: 
useAgoraSimple.ts:132 09:24:18:462 Agora-SDK [ERROR]: [client-1c47f] can not subscribe 390, this user is not in the channel
（匿名）	@	useAgoraSimple.ts:132

框架使用nuxt4,nodeJs版本v22.18.0
useAgoraSimple.ts.txt 是封装的声网函数,截图是浏览器的日志及报错

Reply: 您好
1、检查有没有多个 client，避免订阅错 client
2、vue在data中用对象不能接收，检查下自己的项目里有没有双向绑定的行为，如果有，请避免。之前其他客户遇到过，当时是发现const client = AgoraRTC.createClient({ mode: "live", codec: "vp8" });这行代码的client放在js中就没问题，如果把client赋值给对象内的属性，使用属性 就会出现问题
可以对比下我们[Web Demo](https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo) 的处理

---

# ID: 36995

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.5.2

Request Type: 其他问题

Request Description: 你好，我们向咨询一个问题，不知道有无解决方案：
我们的在开发一个APP业务功能，业务流程大致是这样：使用声网RTC建立语音通道，Server端把客户端采集的到的语音数据进行ASR（语音转文本），然后翻译、TTS（文本合成语音），最后TTS在频道中播放。ASR断句到TTS播放完成这段时间，客户端进行了静音（停止采集，调用了enableLocalAudio(false) ），TTS播放完成后客户端会再恢复麦克风采集，并不断重复这个过程。

有这样的业务场景，当用户连接了蓝牙耳机时，我们希望是手机麦克风进行收音，不要使用耳机收音，当TTS合成语音播放时我们希望切换到耳机进行播放，不用使用手机听筒或外放。简单描述就是我们希望能够进行音频路由在手机、耳机之间任意切换。

目前我们没有找到声网SDK有类似API，也没有找到其他方法。请问声网SDK有API或其他解决方法吗？或者有无解决思路？

谢谢！

Reply: 您好，请问您的需求是蓝牙耳机只接听，不采集对吗？SDK 默认使用 hfp 协议，稍后人工工程师会给您提供切换成 a2dp 协议的私参

---

# ID: 36997

SDK Product: IM

SDK Platform: Android

SDK Version: 1.3.2

Request Type: 其他问题

Request Description: 声网IM是否可以自定义消息类型，比如收发卡片消息。从官网IM文档中心没有看到自定义消息的说明和方法，在github上下载的chat_uikit工程中，也没看到相关源码。请问，有自定义消息类型的方法和说明文档吗？

Reply: 您好，声网 IM 支持[自定义消息](https://im.shengwang.cn/docs/sdk/android/message_send_receive.html#%E5%8F%91%E9%80%81%E5%92%8C%E6%8E%A5%E6%94%B6%E8%87%AA%E5%AE%9A%E4%B9%89%E7%B1%BB%E5%9E%8B%E6%B6%88%E6%81%AF)

---

# ID: 36999

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我在VoceChat里添加声网配置信息。但是找不到声网的Project ID
，按照声网提供的信息也无法找到，怎么处理？

Reply: 您好，如果是VoceChat 的配置问题建议咨询下VoceChat 侧，声网没有Project ID 这个字段，我们只有 appid，在声网控制台可以复制。

---

# ID: 37004

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 您好 想问下，我们现在使用的方案：
云播放器推流
疑问：当一个用户进入频道之后，我们就推送一个mp4的streamUrl创建云端播放器，这个时候用户能看到这个mp4格式的视频。
我们大部分的mp4格式的视频都是2-4MB左右大小，对于推送创建云端播放器，我们是直接推送mp4格式的streamUrl更好，还是转化成m3u8格式会更好呢？或者说有没有必要推送使用m3u8呢？

Reply: 您好，直接用 mp4 的在线地址就行，[输入在线媒体流不支持 m3u8](https://doc.shengwang.cn/doc/media-pull/restful/overview/product-overview#%E5%8A%9F%E8%83%BD%E6%8F%8F%E8%BF%B0)

---

# ID: 36965

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 集成问题咨询

Request Description: 声音美化相关的API是否可以独立使用？就是不需要开房间才能使用。
因为我们现在项目情况是已经有了录音数据和伴奏数据。希望对声音进行美化

Reply: 您好，美声 API 无法独立使用，这个功能是搭配我们 SDK 加频道发流使用的。如果只是本地美声的需求，可以考虑额外集成第三方美声 SDK 来实现。

---

# ID: 36969

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description:   appid: IoINAHKUEfCaDQ3HgKuiSA/wkyvWTK0FZgDew
  appCertificate: 16eeda15e7464cc387dbf9f961ea8d21
channelName: 813e48ee-8bc8-11ef-ad67-e30a888a1ef6
role: RtcTokenBuilder2.Role.ROLE_PUBLISHER


RtcTokenBuilder2 token = new RtcTokenBuilder2();
        return token.buildTokenWithUserAccount(appid, appCertificate, channelName, account,
                RtcTokenBuilder2.Role.ROLE_PUBLISHER, tokenExpirationInSeconds,
                privilegeExpirationInSeconds);

生成的token为空

Reply: 您好，生成 token 失败大概率是因为您的传值有问题，请检查下 appid、app证书等输入与声网控制台上的值相同。

---

# ID: 36972

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 我在unity平台用post请求创建了智能体，请求返回成功，但是我听不到智能体的声音。同样的参数在Playground是正常的

Reply: 您好，playground 正常的话可以用界面右上角的 debug 按钮导出请求，对比一下您现在代码上的配置和 playground 里的请求有什么区别，参考下 playground 的请求写法。如果自查无法解决问题，您可以提供下出现问题的 agentID，人工工程师稍后为您排查。

---
# ID: 36973

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 其他问题

Request Description:    // rtc
    api 'io.agora.rtc:agora-special-full:4.1.1.26'
    // rtm
    api 'io.agora:agora-rtm:2.2.1'

请问我使用的这个连个sdk,  应用市场说不支持16K Page Size,  请问那个版本的支持

Reply: 您好，RTC 和 RTM 都升级到官网最新版本就可以了。

---
# ID: 36974

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 升级RTC版本4.6.0 初始化rtc报错 failed to load library agora-rtc-sdk from null msg: dlopen failed: cannot locate symbol "aosl_ref_magic" referenced by "/data/app/TQWJ5W_kGL4YWmhu7VGd6w/com.fyy.helmetdevices-xwR783h-QJ5U_y0Wh91DHw/base.apk!/lib/arm64-v8a/libagora-rtc-sdk.so"...

Reply: 您好，请检查下集成SDK 的顺序，RTC 需要在 RTM 前，以及检查下集成的版本号是否都真实存在。

---

# ID: 36978

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 用户1如果开了视频和音频的话，20秒之内断线重连之后，其他用户没有走user-left监听到用户1离开，但是用户1没有开视频音频流，20秒之内断线重连之后，其他用户走了user-left监听到用户1离开，然后又走了user-join监听，监听到用户1加入，如何解决，其他用户在用户1短时间断线重连的时候不走user-left监听监听到用户1离开

Reply: 您好，SDK 在 20s 内断开连接会有[重连机制](https://doc.shengwang.cn/doc/rtc/javascript/basic-features/channel-connection)，重连成功是不会触发user-left的，彻底断开连接才会触发。

---

# ID: 36980

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 你好，咨询几个问题：
1、融合CDN直播的延时大概是多少？
2、大疆机场直播一般是使用哪种直播（要求低延时）？
3、手机端极速直播有没有项目限制（会不会按照项目数量收费）？
4、融合CDN和手机端极速直播如果要回放是要云端录制吗？如果不是应该怎么实现？

Reply: 您好，针对您的几个提问，以下是回答：
1、延迟 6s 左右，具体还要看网络情况。
2、低延迟要走 [RTC](https://doc.shengwang.cn/doc/rtc/homepage)，RTC 的延迟在 400ms 左右，没有低延迟可以用[融合 CDN](https://doc.shengwang.cn/doc/fusion-cdn/restful/landing-page) 推拉流观看。
3、声网是按用量收费的，欠费了就自动停机，参考[计费策略](https://doc.shengwang.cn/doc/rtc/javascript/billing/billing-strategy)，具体细节可以电话沟通：400 6326626
4、声网不会主动保存用户通话信息，需要主动调用录制才能保存通话内容。融合 CDN 走的是 rtmp，有自己的[标准录制接口](https://doc.shengwang.cn/doc/fusion-cdn/restful/streaming/operations/patch-v1-projects-appid-fls-entry_points-entry_point-settings-record-standard-regions-region)。
RTC 需要先使用[云录制](https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page)才能看到回放内容。

---

# ID: 36985

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 声网的同事，你好
      我想实现在本地进行多个视频源采集、编排、并发布到频道的功能，大致流程是
1. 选择视频源（窗口、屏幕、摄像头），并编排它们的尺寸与上下顺序
2. 本地预览上述选择的视频效果
3. 发布合成的视频流到频道中
我阅读了文档，目前有几个问题想咨询确认，还望解答：
4. 如何实现本地多窗口、摄像头的预览？ VideoSourceType的枚举类型有限，只看到screen、没看到window类型的值。
5. macOS上如何录制本地播放的声音，例如qq音乐。 


Reply: 您好，本地合图可以参考下这个[本地合图 Demo](https://github.com/AgoraIO-Extensions/Electron-SDK/blob/main/example/src/renderer/examples/advanced/LocalVideoTranscoder/LocalVideoTranscoder.tsx)

录制做不到只录本地音乐，云录制或 SDK 客户端录制接口只能录发流的声音

---

# ID: 36937

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: ios 接入AgoraRtcEngineKit sdk，我想实现直推cdn功能，我有推流地址，想使用sdk，完成推流

 AgoraDirectCdnStreamingMediaOptions *mediaOptions = [[AgoraDirectCdnStreamingMediaOptions alloc] init];
        mediaOptions.publishCameraTrack = YES; // 是否发布摄像头采集的视频
        mediaOptions.publishMicrophoneTrack = YES; // 是否发布麦克风采集的音频
        mediaOptions.publishCustomVideoTrack = NO; // 是否发布自定义采集的视频
        mediaOptions.publishCustomAudioTrack = NO; // 是否发布自定义采集的音频
        [weakSelf.agoraKit startDirectCdnStreaming:weakSelf publishUrl:@"rtmp://xxx" mediaOptions:mediaOptions];
但是没有反应，是哪里的问题，文档显示4.6.0 这个直推cdn的方法废弃了，是跟这个有关系吗，我应该怎么修改，谢谢。

Reply: 您好，startDirectCdnStreaming 这个接口已经不更新维护了，有推流 CDN 需求请用服务端[旁路推流](https://doc.shengwang.cn/doc/media-push/restful/landing-page)

---

# ID: 36939

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 医生端uid：509692，患者端uid：900322
医生和患者视频通过，可以正常运行，通过频道查询用户状态提示 "channel_exist": false。
合流录制也只显示一端的画面：https://hlwyy-1317315181.cos.ap-guangzhou.myqcloud.com/724bfabfae467559d0cfcabbd14cf8c9_4bf0b4b410844689b57b081af9c8e64c_0.mp4


Reply: 您好，长时间返回 "channel_exist": false大概率是接口传值有问题，比如调用接口时传入的 appid 和实际通话所用的 appid 不同，导致查不到数据上报。
录制只有一方画面的问题请检查下有没有让录制端使用频道内重复的 uid 加频道，如果有的话会导致录制端把频道内用户踢出去的。如果没有，请提供下具体sid，人工工程师稍后看下情况

---

# ID: 36942

SDK Product: RTM

SDK Platform: JavaScript

SDK Version: 2.2.2

Request Type: 集成问题咨询

Request Description: 
RTM 是否支持 webhook， 想在服务端对每个消息进行二次处理 

Reply: 您好，RTM 目前没有对外的 Webhook 文档，但您可以直接在声网 console 配置。具体路径：全部产品>RTM>功能配置>Webhook

---

# ID: 36945

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 商务问题

Request Description: 声网是否有 基础的视频美颜服务提供 因为我之前使用zego是有的

Reply: 您好，SDK 自带美颜能力，可以参考[高级美颜](https://doc.shengwang.cn/doc/rtc/android/advanced-features/advanced-beauty)
推荐[跑通我们的最新 Demo](https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo)，Demo 里有效果演示和最佳实践集成

---
# ID: 36946

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 一对一音频通话，iOS用户为主叫，呼出通话之后将应用切到后台，然后被叫接听。主叫加入频道成功，但是通话没有声音

Reply: 您好，IOS 切后台会限制 SDK 采集，这个是系统行为，可以参考下[为什么部分 iOS 版本 App 锁屏或切后台后音视频采集无效？](https://doc.shengwang.cn/faq/quality-issues/ios-background) 修改 xcode 配置来保持切后台的音频采集播放

---

# ID: 36954

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: channel： 17567034626412077727292169115646
sender: 1221641
receiver: 1221638

音频发送端在开启屏幕共享后，出现音频质量下降（声音短短续续）的问题。用户自述在不同网络环境下、不同外置麦克风设备下，均出现该问题，同时电脑上没有运行其他大型软件。

Reply: 您好，请稍等。
人工工程师稍后为您解答，不过您现在的 SDK 版本看起来不是最新的，可以尝试[升级 SDK 到最新版本](https://doc.shengwang.cn/doc/rtc/javascript/resources)看下问题是否还会复现。

---
# ID: 36955

SDK Product: Whiteboard

SDK Platform: Web

SDK Version: 2.16.43

Request Type: 集成问题咨询

Request Description: 1.白板课件上传文件转换功能 https://api.netless.link/v5/projector/tasks，添加了webhookEndpoint参数 只返回了一次回调，没有转换完成就返回了，而且没有后续回调推送了。ConvertData(taskId=73979dd6b3784eb7bef8092afeb40914, taskType=static_conversion, prefixUrl=, pageCount=0, previews=null, note=, images={}, noticeTimestamp=1756710974682) 预期是finish/fail状态返回回调。

Reply: 您好，webhook只有在任务成功或者失败的时候推送一次，麻烦提供下这次转换任务的原始请求、相应结果、原始文件，放在 txt 里用附件发来，人工工程师稍后为您解答

---

# ID: 36957

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 我在php配置开启录制
'transcodingConfig' => [
                        'width' => 720.0,
                        'height' => 1280.0,
                        'fps' => 15,
                        'bitrate' => 500,
                        'mixedVideoLayout' => 1,
                        "maxVideoDuration" => 3600,
                        "layoutConfig" => [
                            [
                                'uid' => $uid,
                                "x_axis" => 0.0,
                                "y_axis" => 0.0,
                                "width" => 720.0,
                                "height" => 1280.0,
                                "render_mode" => 1        // 关键：fit（不裁剪，必要时加黑边）
                                // 也可以放多个 region，照样 renderMode:1
                            ]
                        ]
                    ],


一直报：'start: width type mismatch or missing under layoutConfig!'，这是什么原因

Reply: 您好，width 和height 是 float 类型，但是取值范围的上限是 1.0；bitrate对于 720p 来说也有点低了，请参考[开始录制时自定义合流布局](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guides/mix-mode/set-composite-layout#%E5%BC%80%E5%A7%8B%E5%BD%95%E5%88%B6%E6%97%B6%E8%87%AA%E5%AE%9A%E4%B9%89%E5%90%88%E6%B5%81%E5%B8%83%E5%B1%80)来进行调整

---

# ID: 36961

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 效果不佳、不达预期

Request Description: 我在一个会议室中，有人分享屏幕。但是我没找到文档有说明：别的人在client.on('user-published',xxx)中怎么知道别人分享了屏幕（因为分享屏幕使监听到的也是video轨道，没有字段可以说明是摄像头视频还是屏幕分享视频）

1. track.getTrackName()，没有getTrackName方法，直接报错。
2.设置screenTrack.isScreenShare = true;代码中直接报错Property 'isScreenShare' does not exist on type。并且在client.on("user-published"中没有找到isScreenShare字段。
3， 任何人都可以分享屏幕，所以没有特殊角色。


到底怎么可以知道是谁在分享屏幕呢？

Reply: 您好，SDK 不区分远端发的是屏幕共享还是摄像头视频流，没有办法识别。但是您可以业务上指定屏幕共享所用的 uid 前缀或者范围，从业务上区分发流的 uid 是不是屏幕共享范围的。

---
# ID: 36962

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 效果不佳、不达预期

Request Description: 开启加入频道，2台手机都各自连接了一款蓝牙设备并且有设备有麦克风，然后其中1台ios加入频道的时候，麦克风说话蓝牙设备不起效，变到手机的麦克风通话去了，但是听筒的话还是在蓝牙设备上可以听到声音。   想要的效果是麦克风和听声音都要在蓝牙设备的麦克风设备上，而不是通过手机的麦克风说话。

token是这个
0066dbb5052bdb84e0fa761e63a20d8e364IAADWkpsu+XLw5Xk52H76ZHXCTAO5E+UQvThkzJXGV6l8cuKBlu6L9j1EAABAAAA2Ju+aAEAAQDYm75o
频道id：580
uid:194

这是相关的日志可以参考
flutter: 2025-09-01T17:03:20.999456 [Level.warning] [Agora] [onLocalAudioStateChanged] 本地音频变化：state:LocalAudioStreamState.localAudioStreamStateRecording;  reason:LocalAudioStreamReason.localAudioStreamReasonOk
flutter: 2025-09-01T17:03:21.026670 [Level.warning] [Agora] [onLocalAudioStateChanged] 本地音频变化：state:LocalAudioStreamState.localAudioStreamStat
flutter: 2025-09-01T17:03:22.222248 [Level.warning] [Agora] [onRemoteAudioStateChanged] connection: {channelId: Test580, localUid: 194} remoteUid: 202 state: RemoteAudioState.remoteAudioStateStopped reason: RemoteAudioStateReason.remoteAudioReasonRemoteMuted elapsed: 0
[2025-09-01 17:03:22.223][12473609][I][iris_rtc_api_engine.cc:438] api name RtcEngine_enableAudioVolumeIndication_39794a0 params "{"interval":1000,"smooth":1,"reportVad":true}"
[2025-09-01 17:03:22.224][12473609][I][iris_rtc_api_engine.cc:504] api name RtcEngine_enableAudioVolumeIndication_39794a0 result 0 outdata {"result":0}
[2025-09-01 17:03:22.224][12473609][I][iris_rtc_api_engine.cc:438] api name RtcEngine_setParameters_3a2037f params "{"parameters":"{\"che.audio.enable_ai_noise_reduction\": true}"}"
[2025-09-01 17:03:22.225][12473609][I][iris_rtc_api_engine.cc:504] api name RtcEngine_setParameters_3a2037f result 0 outdata {"result":0}

Reply: 您好，听起来是蓝牙协议没走 a2dp 导致的，麻烦提供下复现问题时的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，人工工程师稍后为您解答。

---
# ID: 36963

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.1

Request Type: 集成问题咨询

Request Description: 连接蓝牙后，实测发现音频采集仍然是从手机麦克风采集，如何让从蓝牙采集音频流？

Reply: 您好，听起来是蓝牙协议没走 a2dp 导致的，麻烦提供下复现问题时的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，人工工程师稍后为您解答。

---

# ID: 36918

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 环境: 通过官方的Conversational-AI-Demo/Web/Scenes/VoiceAgent Demo 进行功能验证；
在测试环境没有问题(能达到预期)，在正式环境出错
1. 打开正式环境地址 :https://convoai-v2-182548-7-1300372946.sh.run.tcloudbase.com/
2. 手机号授权。错误如下:
网页显示:Invalid client: `redirect_uri` does not match client value  

通过声网的 AI 助手 ，助手说需要设置什么redirect_uri，但是整体没有找到该部分，请协助尽快解决


Reply: 您好，Conversational-AI-Demo 这里登录用的是我们官方SSO登陆认证的redirect_uri，需要在SSO的认证才能回跳的。
SSO登陆仅限于我司的注册用户，不对外开放。

---
# ID: 36919

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 我们在评估esp32集成webrtc、we b r t m的可行性，麻烦请问，esp32性能是否可以集成这个

Reply: 您好，嵌入式设备有 RTSA SDK，是专用的 RTC SDK，参考[RTSA 文档](https://doc.shengwang.cn/doc/rtsa/c/landing-page)
RTSA 设备可以和 Web 互通的，只不过 ESP32 的 SDK 我们音频编码只适配了 G722 

---

# ID: 36922

SDK Product: RTM

SDK Platform: Unity

SDK Version: 2.1.9

Request Type: 集成问题咨询

Request Description: RTM有支持VisionPro的版本吗

Reply: 您好，RTM Unity SDK 目前不支持 Vision Pro 设备，短期内也没有计划适配。

---
# ID: 36923

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 小程序端在发起视频时候用户点击右上角或者主动退出小程序之后 视频还在录制 按道理应该结束的。 这个有什么解决方案吗 或者对应的api


Reply: 您好，理论上小程序都退出了是不会继续占用摄像头的，您可以用我们[小程序最新版本的 Demo](https://doc.shengwang.cn/doc/rtc/mini-program/get-started/run-demo) 试试

---

# ID: 36925

SDK Product: RTC

SDK Platform: React Native

SDK Version: 4.5.2

Request Type: 效果不佳、不达预期

Request Description: 现象：在1920x1080分辨率的屏幕上，接收1512x982分辨率的mbp的屏幕共享画面时，显示效果不及预期，文档文字会出现明显的模糊

问题：有什么合适的参数可以适配这个使用场景吗？

Reply: 您好，请问您现在屏幕共享的平台是 Windows 还是 Mac？Mac 的 dpi 和 Windows 不同，所以直接用标准采集方式采集到的画面会糊一些，您可以升级当前 SDK 版本到最新，用我们最新版本的 SDK 试一下。如果还有问题，稍后人工工程师会为您提供几个调整采集方式的私参来解决。

---

# ID: 36932

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 问题一：采集帧率设置的10帧，选择的是质量优先，码率2000，分辨率是720*1280 。但是为啥回调监控到采集帧率15帧？
问题二：720P@10帧，保证质量前提下。码率设置多少合适？

Reply: 您好，码率不需要手动设置，SDK 会自动平衡的，您这边配置的是[setVideoEncoderConfiguration](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_video_basic#api_irtcengine_setvideoencoderconfiguration) 去修改帧率吗？一般来说摄像头本身需要支持 10fps 的采集才能设置成功，如果不支持的话是会回退到最近的支持配置的（比如 15fps）。一般推荐用setVideoEncoderConfiguration修改编码帧率，但如果您用了[startCameraCapture](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_camera_capture#startCameraCapture)，编码帧率是不可能大于采集帧率的，这一点需要注意。

如果摄像头本身支持 10fps 的采集且您的配置正常，可以尝试复现下这个现象，提供下 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)过来，人工工程师稍后为您分析。

---
# ID: 36933

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.3.2

Request Type: 其他问题

Request Description: Upload Symbols Failed
The archive did not include a dSYM for the AgoraAiEchoCancellationExtension.framework with the UUIDs [82628D75-1C99-3504-8770-58359A77C668]. Ensure that the archive's dSYM folder includes a DWARF file for AgoraAiEchoCancellationExtension.framework with the expected UUIDs.

我在构建iOS包上传到App Store 时，报这种警告
如何处理


Reply: 您好，Upload Symbols Failed 是因为我们的符号表不对外，开放所以 xcode 找不到，这些 warning 本身不影响上传，可以忽略。
后续如果有遇到崩溃问题可以收集原始堆栈+崩溃时的 SDK 日志，提交工单交由声网侧人工工程师解析。

---

# ID: 36899

SDK Product: RTM

SDK Platform: Swift

SDK Version: 2.2.5

Request Type: 集成问题咨询

Request Description: swift 的 RTM没有回调。
按照demo的例子写的，RTM login成功，RTC加入成功 ，subscribe channel成功，但是无法收到didReceiveMessageEvent等任何回调。使用提供的ConversationAIApiImpl代码也是没有收到回调。
token: 007eJxTYOiNUEpjYpx1UVer6EvF4Y/dtga3//ndNdBe2n1o+v1W81AFhtQ0S/O0VAOzlFTLZJMUAyNLA+Ok1LREEzMTs8SURCNzvyPrMhb0MDB8jXrLysTAyMACxCA+E5hkBpMsYJKHoSS1uCQ+OSMxLy81h5XB0AAIQFogGqACANiXK6M=
chanelname:test_channel
userid: 10000

附件中是几个实现类文件，因为不能直接上传源码只能压缩包了

Reply: 您好，didReceiveMessageEvent 需要频道里有远端在发消息才会触发，如果只有一个人的话是不触发的
如果确认两个用户都订阅了频道发消息还收不到，可以拿一下双端 [SDK 日志](https://doc.shengwang.cn/doc/rtm2/swift/error-codes)过来人工工程师稍后分析。

---
# ID: 36900

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: Unity 如果要接入对话式AI，想要实现展示 用户/AI 的文字对话，点击能播放对应语音 的对话列表，需要接入什么SDK

Reply: 您好，convoAI 目前还做不到保存消息语音，这一点可能需要您自行集成 tts SDK 在本地实现。convoAI 只能实现加入 RTC 频道和LLM 直接语音互动，有需要的话可以获取[实时字幕](https://doc.shengwang.cn/doc/convoai/restful/user-guides/realtime-sub)

---

# ID: 36906

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.2.0

Request Type: 其他问题

Request Description: 如附件图片，问题如下：
1、创建RtmClient以及IRtcEngine的第一个参数appID是否是同一个id即项目中的appid

rtmClient = new RtmClient(RtmAppID, clientEventHandler);
mRtcEngine = IRtcEngine.GetEngine(RtcAppID);

2、这两个方法已经注册，为什么始终不能执行进去
clientEventHandler.OnQueryPeersOnlineStatusResult = OnQueryPeersOnlineStatusResultHandler;
clientEventHandler.OnMessageReceivedFromPeer = OnMessageReceivedFromPeerHandler;

3、目前账号使用的套餐是 RTM免费版 和 RTC实时互动免费版


Reply: 您好，
1、appid 需要appid 需要时同一个，从声网 console 上复制，但是需要确保有[手动开通过 RTM 权限](https://doc.shengwang.cn/doc/rtm2/unity/get-started/enable-service)
2、OnQueryPeersOnlineStatusResultHandler 是 1.x 的呼叫邀请回调。1.x 已经停止更新维护很久了，建议用 [2.x](https://doc.shengwang.cn/doc/rtm2/unity/landing-page)，自行实现呼叫邀请的业务。

---
# ID: 36907

SDK Product: IM

SDK Platform: Web

SDK Version: 1.3.2

Request Type: 集成问题咨询

Request Description: web端发送图片消息，调用接口 onFileUploadComplete ，图片发送成功后， 显示 图片下载地址 http://c1.chat.realtimemesh.com/171385301/1590061/chatfiles/25e20640-83be-11f0-81ba-cf28edd987b9?em-redirect=true&share-secret=JeItUIO-EfC35m8qongAUkbg4fYvNl0OPKWUuxJGziqSSquG ，如何下载图片

Reply: 您好，正常这个地址下载下来是应该为一个图片，您这个之所以下载下来不是图片文件应该上传的时候文件就不对 。

---
# ID: 36908

SDK Product: RTC

SDK Platform: Unreal

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 你好！

我现在设备端这边用的是ARM LINUX的RTSA，现在想改为用RTC，对应有SDK吗？

或者RTSA能走用流量的方式吗？因为目前数量不多，想先走流量方式跑起来。

Reply: 您好，RTSA 的计费是 License 模式，RTC 是按用量付费，两者不一样，RTC 没有 License 计费模式,RTSA 可以选择切换成用量计费模式。
要集成 RTC 参考 [RTC 文档](https://doc.shengwang.cn/doc/rtc/homepage)
需要修改 RTSA 计费为按量的话可以联系下您的对接销售

---

# ID: 36880

SDK Product: IM

SDK Platform: Web

SDK Version: 1.3.2

Request Type: 集成问题咨询

Request Description: web调用和安卓app获取历史消息失败，提示功能没有开通， 还请帮忙开通

Reply: 您好，这个是 IM 的消息漫游功能，需要我们后台帮您手动开通，请提供下需要开通能力的 appid，人工工程师稍微为您操作

---
# ID: 36882

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.1

Request Type: 集成问题咨询

Request Description: 调用扬声器功能不起作用 
```
if(isVoice){
                engine?.setRouteInCommunicationMode(3)
//               val status= engine?.setEnableSpeakerphone(true)
//                Log.d(TAG, "已切换到扬声器 切换状态:$status")
                Log.d(TAG, "扬声器状态变更：外放")
            }else{
                engine?.setRouteInCommunicationMode(-1)
//                val status= engine?.setEnableSpeakerphone(false)
//                Log.d(TAG, "扬声器状态变更：默认 切换状态:$status")
            }
```

status 返回值也只是0
```
override fun onAudioRouteChanged(routing: Int) {
            super.onAudioRouteChanged(routing)
            println("当前通话路由：$routing")
        }
```

回调也可以正常执行,但是一直都是听筒播放,无法切换到扬声器

Reply: 您好，建议用[setAudioScenario](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#api_irtcengine_setaudioscenario)来控制音频路由，设置为 Gamestreaming 时强制走扬声器，Chatroom 强制走听筒。调用前保证 channelProfile 为直播模式，并且不要额外调用setRouteInCommunicationMode或者setEnableSpeakerphone之类会额外修改路由的接口。

---

# ID: 36885

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.5

Request Type: 集成问题咨询

Request Description: rtsa SDK启动时报如下的错误，
[5.577][crt][trans] [udp_client] Failed to create socket, err: 23
[5.590][err][trans] connect failed
[6.516][crt][trans] [udp_client] Failed to create socket, err: 23
[6.516][err][trans] connect failed
[7.488][crt][trans] [udp_client] Failed to create socket, err: 23
[7.488][err][trans] connect failed
[7.516][crt][trans] [udp_client] Failed to create socket, err: 23
[7.516][err][trans] connect failed
[8.516][crt][trans] [udp_client] Failed to create socket, err: 23，
但是又能够加入到频道，请问这种错误是否正常

Reply: 您好，请问LWIP_MAX_SOCKETS 的配置是多少？配置的系统的socket个数太少会导致我们 SDK 创建 socket 失败，我们需要10+多个

---

# ID: 36891

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 线上报错

Request Description: 1. 视频答题，进入时报错
2. 显示 AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: no active status
3. 控制台输出
14:41:26:383 Agora-SDK [WARNING]: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: no active status
data: {"desc":"no active status","retry":false,"csIp":"139.196.174.91"}
index-BFxqu7au.js:45 14:41:26:387 Agora-SDK [WARNING]: [client-ca0d7] multi unilbs https://webrtc2-4.ap.sd-rtn.com/api/v2/transpond/webrtc?v=2 failed, flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: no active status, retry: false
index-BFxqu7au.js:45 14:41:26:467 Agora-SDK [WARNING]: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: no active status
data: {"desc":"no active status","retry":false,"csIp":"103.228.162.61"}
index-BFxqu7au.js:45 14:41:26:469 Agora-SDK [WARNING]: [client-ca0d7] multi unilbs https://webrtc2-ap-web-3.agora.io/api/v2/transpond/webrtc?v=2 failed, flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: no active status, retry: false
index-BFxqu7au.js:45 14:41:26:470 Agora-SDK [ERROR]: [client-ca0d7] join number: 1, Joining channel failed, rollback AgoraRTCException: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: no active status
    at m_ (index-BFxqu7au.js:64:39023)
    at Mu.E.gatewayInfo.q.joinChooseServer.role (index-BFxqu7au.js:64:36439)
    at async index-BFxqu7au.js:44:24322


Reply: 您好，AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: no active status 表示您的 appid 目前处于停用状态，建议登录声网 console 检查下您的账户情况。

---
# ID: 36892

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: 拨打接听后，用户调节免提无效，声音依旧从听筒播放

Reply: 您好，切换输出音频路由为扬声器用 [setAudioScenario](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_audio_basic#api_irtcengine_setaudioscenario) 控制就可以了，setAudioScenario配置为GS强制走扬声器，chatroom 强制走听筒。保证channelprofile 为 1 直播模式、后续没有调用setEnableSpeakerphone 为 false 等手动修改输出路由的情况即可

---
# ID: 36893

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 其他问题

Request Description: 白板上传PPT报错，vue项目，4.23和4.24都报错了，但是nuxt项目没问题；标题也渲染成功了，解析出来的图片，图片地址放到浏览器也可以打开，但是白板上的ppt没有

Reply: 您好，请问现在请求的 url 路径用的是/v5/projector吗?请保证在提交转换任务的时候传了 "type": "static", 否则可能因任务类型不匹配产生报错。
麻烦提供下具体的 console 报错打印，白板房间号、任务转换 uuid、转换源文件、转换时的 region，人工工程师稍后为您解答。
以及 vue 的常见错误有把白板对象存到了 vue 的 data 里面, 导致白板的方法都被套了一层proxy报错, 不要放到 vue 的 data里面可以解决。

---

# ID: 36896

SDK Product: IM

SDK Platform: Web

SDK Version: 1.3.2

Request Type: 集成问题咨询

Request Description: IM WEB端 获取消息列表 ，会话列表，如何获取到用户头像， 相应文档中没有相关内容

Reply: 您好，需要获取用户属性。[设置当前用户的属性](https://im.shengwang.cn/docs/sdk/web/userprofile.html#%E8%AE%BE%E7%BD%AE%E5%BD%93%E5%89%8D%E7%94%A8%E6%88%B7%E7%9A%84%E5%B1%9E%E6%80%A7)

目前会话列表是不携带昵称头像等信息，比如获取完会话列表或者好友列表，拿对应的uid批量获取用户属性进行缓存然后进行展示。

---
# ID: 36897

SDK Product: IM

SDK Platform: Android

SDK Version: 1.3.2

Request Type: 集成问题咨询

Request Description: IM 安卓端 获取消息列表 ，会话列表，如何获取到用户头像， 相应文档中没有相关内容

Reply: 您好，需要获取用户属性。[设置当前用户的属性](https://im.shengwang.cn/docs/sdk/android/userprofile.html#%E8%AE%BE%E7%BD%AE%E5%BD%93%E5%89%8D%E7%94%A8%E6%88%B7%E7%9A%84%E5%B1%9E%E6%80%A7)

目前会话列表是不携带昵称头像等信息，比如获取完会话列表或者好友列表，拿对应的uid批量获取用户属性进行缓存然后进行展示。

---

# ID: 36864

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 其他问题

Request Description: 1. 22 用户主播总开播时间1h8min  395观众时长是怎么达到3h33min的，以及395观众在线时长23min是怎么算到3h33min的

Reply: 您好，商务计费问题可以电话咨询 400 6326626
或者在水晶球上截图您疑惑的疑问点，等候人工工程师稍后为您解答。

---

# ID: 36867

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 集成问题咨询

Request Description: rtc 有统一处理错误回掉的地方吗？
我现在想要处理 音视频发布失败的情况，是直接通过 try catch 捕获后处理，还是有更方便的方法
使用 rtcClient?.publish 发布流

Reply: 您好，就是通过 try catch 抛出的 error 来获取错误信息，可以参考我们的[Demo](https://github.com/AgoraIO/API-Examples-Web/blob/main/src/example/basic/basicVideoCall/index.js)
以及[错误码文档](https://doc.shengwang.cn/doc/rtc/javascript/error-code)

---
# ID: 36868

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 1、AgoraRtcVideoCanvas的view不能直接作为画中画的源view吗？设置后画中画能开启但是黑屏
2、有没有画中画集成的详细文档？文档中心搜索不到
3、想要远端的流进入画中画，demo上自渲染，这是唯一的方式吗？AgoraRtcVideoCanvas的view是否有什么配置可以简单点配置


Reply: 您好，IOS 的画中画我们推荐用自渲染的方式来实现，具体实现代码可以参考我们的[画中画 Demo](https://github.com/AgoraIO/API-Examples/blob/main/iOS/APIExample/APIExample/Examples/Advanced/PictureInPicture/CustomViewPIPViewController/CustomViewPIPViewController.swift)
SDK 渲染的效果不如自渲染好，我们推荐自渲染来实现。

---
# ID: 36869

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 效果不佳、不达预期

Request Description: 大疆无人机rtmp方式往融合cdn推流，静态放置且wifi连接情况下，延迟会高到十几二十几秒，有没有什么方法降低延迟。

Reply: 您好，转推CDN 走的协议有物理延迟，这个现象本身是预期的，具体延迟大小还要看客户端网络情况。如果您有互动需求的话建议让观众端加入 RTC 频道，不走CDN。RTC 的延迟是可以控制在 400ms 以内的。

---

# ID: 36873

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 中国国内使用视频一切正常，但是在日本使用的时候，有时候发送不了信息（对面发了，这边收不到），有时候获取历史记录获取不到

Reply: 您好，RTC 是音视频互通的 SDK，没有发消息的能力，请问您现在在用的是 RTC 还是 RTM？

---

# ID: 36875

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 线上报错

Request Description: CDN直播添加推流域名报域名没有备案，只能选择港澳台及海外加速

Reply: 您好，麻烦提供具体的域名和推拉流地址，我们同步研发后台帮您修改回来。

---

# ID: 36840

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.2.5

Request Type: 集成问题咨询

Request Description: 我想在本地运行一个demo，测试RTM
我在mac上搭建了一个springboot项目，jdk17
运行后提示我Caused by: java.lang.UnsatisfiedLinkError: no aosl in java.library.path: /Users/chenyu/Library/Java/Extensions:/Library/Java/Extensions:/Network/Library/Java/Extensions:/System/Library/Java/Extensions:/usr/lib/java:.
	at java.base/java.lang.ClassLoader.loadLibrary(ClassLoader.java:2434) ~[na:na]

我在咱们sdk里边指找到了.os，没有适合mac使用的
是否能提供RTM纯java版本，或者提供适合mac使用的aosl.dylib等文件，dylib格式


Reply: 您好，Java SDK 只适配了 Android 和 Linux 两种环境，没有适配过 Windows 或者 Mac 环境，如果您有 Mac 开发需求可以考虑用 OC 或者 Swift。
[Java 适配平台](https://doc.shengwang.cn/doc/rtm2/android/overview/platform-support)
[Swift 适配平台](https://doc.shengwang.cn/doc/rtm2/swift/overview/platform-support)
[OC 适配平台](https://doc.shengwang.cn/doc/rtm2/ios/overview/platform-support)

---
# ID: 36841

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: full sdk 升级到4.5.2 后，提交Google play 提示前台FOREGROUND_SERVICE_MEDIA_PROJECTION权限问题，是你们SDK里面新增了这个权限吗

Reply: 您好，FOREGROUND_SERVICE_MEDIA_PROJECTION 是屏幕共享必须的权限，如果您有屏幕共享场景的话请添加权限声明。如果没有用到的话可以删除，参考[How to resolve FOREGROUND_SERVICE_MEDIA_PROJECTION when not using screen sharing](https://agoraio.zendesk.com/hc/en-us/articles/33544055408788-How-to-resolve-FOREGROUND-SERVICE-MEDIA-PROJECTION-when-not-using-screen-sharing)

---
# ID: 36842

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 1 为什么我用手机浏览器和对方通话，对方听不到我的声音，我确能听到对方的声音那

Reply: 您好，可以检查下初始化引擎时是不是用的主播身份，以及浏览器本身是否支持 WebRTC 协议，优先推荐 Chrome 或者微信浏览器。
如果自查无果，可以提供下具体出现问题的频道号、uid、时间点，说明哪个 uid 听不见哪个 uid，并且开启[日志上传](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，人工工程师稍后为您排查。
```JavaScript
// 开启日志上传功能
AgoraRTC.enableLogUpload();
// 将日志输出级别设置为 INFO
AgoraRTC.setLogLevel(1);
```

---
# ID: 36843

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 集成问题咨询

Request Description: : [client-cadcf] receive exception msg, code: 4001, mSg: AUDIO INPUT LEVEL TOO LOW RECOVER,这个是什么问题

Reply: 您好，AUDIO INPUT LEVEL TOO LOW RECOVER 一般和AUDIO INPUT LEVEL TOO LOW 成对出现，表示音量输入较低的问题得到了恢复。但音量输入较低本身也不代表什么，不说话的时候就会触发这个打印，本身不影响实际通话，可以忽略。

---
# ID: 36845

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 对方手机端没有音频接收信息 这个是为什么那

Reply: 您好，麻烦提供具体的频道号、uid、时间点，说明哪个 uid 听不见哪个 uid，以及检查下手机端用户使用的浏览器是否支持 webrtc 协议，一般推荐 Chrome 或者微信浏览器。

---
# ID: 36846

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.2.0

Request Type: 线上报错

Request Description: rtm这个东西不能从声网的接口查询uid是否在线吗？ 你们代码中的回调根本不准确如果因为网络和推出后台热冷启动等问题 根本无法准确给予当前rtm是否在线 所以我线上的业务通知总是出问题 涉及钱上也有很大影响 请务必告诉我如何获取rtm准确的这一时刻的是否在线 一定要从远端接口获取才行不能信任本地

Reply: 您好，RTM 没有直接查询远端 userid 是否在线的接口，Presence 只能检测频道内远端的状况，如果远端没有加入频道的话，只能用点对点消息去验证了。如果远端离线，点对点消息一定会发送失败。
以及客户端的回调本身就是准确的，RtmLinkState 的[心跳链接](https://doc.shengwang.cn/doc/rtm2/android/user-guide/link/link-basic#%E5%BF%83%E8%B7%B3%E6%8E%A2%E6%B5%8B)时长可以自行调整，调短一点检测的就频繁了，这样状态会更及时。
要检测远端是否在线就用点对点消息，要检测自己是否在线就关注客户端回调，这个一定是准的，把心跳间隔设置的短一点效果更好。以及建议升级 SDK 到最新版本，新版本修复了一些之前的已知问题。

---

# ID: 36848

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.2.5

Request Type: 集成问题咨询

Request Description: 需要 Windows x64 平台下搭配 rtm-java:2.2.5-beta / linux-java-sdk 使用的本地库 aosl.dll、agora_rtc_sdk.dll

Reply: 您好，Java SDK 只适配了 Android 和 Linux 两种环境，没有适配过 Windows 平台。

---
# ID: 36849

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.1.12

Request Type: 线上报错

Request Description: 8月6日之后发送消息之前一直正常，8月6日开始就一直报下面这个错误。
java.lang.RuntimeException: send message to channel failure: RTM ERROR: publish failed, error code: NOT_LOGIN, reason: Preform operation without login RTM service.
	at com.eastedu.rtm.service.impl.AgoraImpl$6.onFailure(AgoraImpl.java:259)
	at io.agora.rtm.internal.RtmClientImpl.processFailureCallback(RtmClientImpl.java:459)
	at io.agora.rtm.internal.RtmClientImpl.publish(RtmClientImpl.java:325)
	at com.eastedu.rtm.service.impl.AgoraImpl.sendChannelMessage(AgoraImpl.java:246)
	at com.eastedu.balance.live.infrastructure.config.rtm.RtmClient.sendMessage(RtmClient.java:100)
	at com.eastedu.balance.live.domain.service.impl.RtmServiceImpl.sendMessage(RtmServiceImpl.java:33)
	at jdk.internal.reflect.GeneratedMethodAccessor40.invoke(Unknown Source)
	at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.base/java.lang.reflect.Method.invoke(Method.java:568)
	at org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:355)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:196)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)
	at org.springframework.aop.interceptor.AsyncExecutionInterceptor.lambda$invoke$0(AsyncExecutionInterceptor.java:113)
	at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)
	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1136)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:635)
	at java.base/java.lang.Thread.run(Thread.java:833)

Reply: 您好，日志打印显示 NOT_LOGIN 这表示您在调用 publish 接口的时候处于登出 RTM 系统的状态，可能是 token 过期（token 最大有效期 24 小时，具体有效时长取决于生成 token 时的有效时间字段）或者网络波动之类的原因导致了这个情况。
建议参考[连接管理基础](https://doc.shengwang.cn/doc/rtm2/android/user-guide/link/link-basic)，监听客户端连接状态的回调，确保在调用 publish 前保证处于登录 RTM 的状态。

---
# ID: 36850

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: joinChannel result === 0 没有 onJoinChannelSuccess 回调 但是有onNetworkQuality回调 和 onConnectionStateChanged回调

Reply: 您好，没有 onJoinChannelSuccess 回调就表示加入频道没有成功，请问此时的onConnectionStateChanged 具体是什么样的打印？如果加入成功，state 应该是 ConnectionStateConnected，如果不是的话就表示没有加入成功，可以看下 reason 字段的具体解释。
如果无法分析的话，可以获取下 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)提供过来，人工工程师稍后分析下具体原因。

---
# ID: 36851

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.2.0

Request Type: 集成问题咨询

Request Description: 视频通话 (Legacy)
需要一个用户可以监听多个的频道的视频流数据，是否有限制，该如何生成token, 可能需要监听几十个 频道的视频流数据，我们是用于监考的平台

Reply: 您好，视频通话 (Legacy)是 3.x，3.x 我们已经停止更新维护很久了，不建议使用，建议使用最新的 4.x。

而 RTC 需要加入频道以后才能看到频道内的画面，您这个场景理论可以用[加入多频道](https://doc.shengwang.cn/doc/rtc/electron/advanced-features/multiple-channel)的方式去做，但那样同时要渲染的画面会非常多，对于设备性能要求会很高。建议用 joinchannel 的方式做一个中台选择界面，让监考老师手动选择每次要进入的考场，单次只进入一个，这样性能消耗就没那么大了。

而 token 是加入频道使用的，调用 join 之前使用脚本生成就行了，保证生成 token 时传入的频道名、uid 和最终加入频道时传入的一致就可以正常使用，没有限制。

如果您对监考场景的技术实现细节还想再沟通，可以留下电话，稍后人工工程师为您解答。

---
# ID: 36852

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: 服务端用python sdk获取rtc视频yuv数据，怎么开启硬件加速?
如何在网络状况不佳时如何设置只降帧率不降分辨率？

Reply: 您好，请问您指的硬件加速具体是指什么？
网络不佳的降级策略可以在[set_video_encoder_configuration](https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/apidatatype#videoencoderconfig) 里配置degradation_preference，默认就是降帧率不降分辨率的。

---
# ID: 36853

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.1

Request Type: 集成问题咨询

Request Description: 多人rtc，小程序延迟很严重，大概有2.5s左右

Reply: 您好，延迟一般是双方网络环境不够稳定才会变大的，建议检查下双方的网络环境是否正常，可以尝试变更网络或者开启流量来对比测试下。
如果自查无果，您可以提供具体的频道名、uid、时间点，说明哪个 uid 看哪个 uid 延迟高，人工工程师稍后为您排查。

---
# ID: 36854

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 集成问题咨询

Request Description: 版权音乐如何和RTC进行混音，现在播放版权音乐后观众无法听到音乐声音，应该没混音，如何进行混音

Reply: 您好，请问您这边是要当背景音乐还是唱歌给远端听？

参考 [Demo](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/blob/main/example/lib/examples/advanced/music_player/music_player.dart)

如果是唱歌给远端听，可以用[SDK 自带的播放器](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/blob/main/example/lib/examples/advanced/media_player/media_player.dart)

如果单纯只是放音乐，可以用[startAudioMixing](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/blob/main/example/lib/examples/advanced/audio_effect_mixing/audio_effect_mixing.dart)

---

# ID: 36858

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 集成问题咨询

Request Description: flutter pubspec.yaml中集成这两个库
agora_rtc_engine: ^6.5.2
agora_rtm: ^2.2.2 

iOS 工程中pod install 报错[!] The 'Pods-Runner' target has frameworks with conflicting names: aosl.xcframework.

Reply: 您好，同时集成 RTC 和 RTM 出现 aosl 冲突可以参考这篇文档解决。
[如何处理同时集成 RTM SDK 和 RTC SDK 遇到库冲突问题？](https://doc.shengwang.cn/faq/integration-issues/rtm2-rtc-integration-issue)

---

# ID: 36825

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.1

Request Type: 线上报错

Request Description: 
1. 问题表现
Android用户反馈点击发起视频通话后，app端和web端双方无法看到对方，也听不到声音。 客服让用户重启app 切换网络，重新发起视频通话很多次，仍然不行。 iOS也有用户反馈类似问题
2. 问题排查
Android SDK调用AgoraManager.agoraEngine?.joinChannel(it.token, it.channelId,"" , it.uid.toInt()) 后，没有收到onJoinChannelSuccess的回调
3. case详情：
第一次：创建时间2025-08-13 08:15:04      频道名 2025_08_13_caseid80569781_1755072783074
第二次：创建时间2025-08-13 08:23:22      频道名 2025_08_13_caseid80569781_1755073297459

Reply: 您好，问题关键是joinChannel后未触发onJoinChannelSuccess，这表示没有实际加入频道成功，需要拿设备 SDK 日志过来看下具体原因，获取日志参考：[如何获取日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
常见的原因是 token 不正确导致的，您可以自行排查一下。

---

# ID: 36828

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: Android运行对话式AI的demo，配置过AG_APP_ID和AG_APP_CERTIFICATE，运行之后，点击连接AI引擎，提示“智能体加入失败，请稍后重试。”

Reply: 您好，Android 的 convoAI Demo 除了 AG_APP_ID和AG_APP_CERTIFICATE 以外还需要填写 basic_auth 的 ak sk、LLM、tts 信息，请问您这些都正确填写了吗？可以参考下 Demo 仓库里的 [Readme](https://github.com/Shengwang-Community/Conversational-AI-Demo/blob/main/Android/scenes/convoai/README.md)

---

# ID: 36830

SDK Product: Recording

SDK Platform: Linux-Java

SDK Version: 4.4.150.5

Request Type: 崩溃（闪退、卡死）

Request Description: 集成调用本地服务端录制，代码执行到agoraMediaRtcRecorder.joinChannel(token, channelName, userId);服务直接崩了，
打印日志如下：2025-08-22 11:06:54.595 [http-nio-7005-exec-1] INFO  c.d.c.c.SWController - [start,302] - 收到开始录制请求 -> 频道: 张恒-李四-邻里纠纷-2025-08-22 08:57:12, 用户ID: 1, Token前缀: 007eJxTY
2025-08-22 11:06:54.676 [http-nio-7005-exec-1] INFO  c.d.c.c.SWController - [start,321] - AgoraRecorderManager 初始化成功，录制路径: /home/yingzhen/dispute/uploadPath/video
2025-08-22 11:06:54.676 [http-nio-7005-exec-1] INFO  c.d.c.d.v.AgoraRecorderManager - [startRecording,95] - 开始订阅音频流
2025-08-22 11:06:54.677 [http-nio-7005-exec-1] INFO  c.d.c.d.v.AgoraRecorderManager - [startRecording,98] - 开始订阅视频流
2025-08-22 11:06:54.678 [http-nio-7005-exec-1] INFO  c.d.c.d.v.AgoraRecorderManager - [startRecording,104] - 配置录制参数，存储路径: /home/yingzhen/dispute/uploadPath/video
2025-08-22 11:06:54.680 [http-nio-7005-exec-1] INFO  c.d.c.d.v.AgoraRecorderManager - [startRecording,109] - 即将加入频道 -> 频道名: 张恒-李四-邻里纠纷-2025-08-22 08:57:12, 用户ID: 1

A fatal error has been detected by the Java Runtime Environment:

 SIGSEGV (0xb) at pc=0x00007f2f7e0912ec, pid=22303, tid=0x00007f2f7c8bd700

JRE version: Java(TM) SE Runtime Environment (8.0_161-b12) (build 1.8.0_161-b12)
Java VM: Java HotSpot(TM) 64-Bit Server VM (25.161-b12 mixed mode linux-amd64 compressed oops)
Problematic frame:
C  libagora_rtc_sdk.so+0xeb42ec

Core dump written. Default location: /home/yingzhen/dispute/server/core or core.22303

An error report file with more information is saved as:
/home/yingzhen/dispute/server/hs_err_pid22303.log

，房间已经创建，token有效，请帮忙排查是哪里的问题，如何解决，崩溃日志见附件

Reply: 您好，看您的打印里频道名包含中文字符，我们的 SDK 是不支持中文字符当频道名使用的，建议先跑通我们的[官方示例](https://github.com/AgoraIO-Extensions/Agora-Recording-Java-SDK/blob/main/README.zh.md)

---
# ID: 36831

SDK Product: RTC

SDK Platform: React

SDK Version: 2.4.0

Request Type: 集成问题咨询

Request Description: gateway.agora.io网关服务器连接不上  前提：关闭防火墙 并且使用ping尝试，提示如下：连接失败: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: dynamic use static key

Reply: 您好，AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: dynamic use static key 的打印表示 token 填写错误，可能是您传成了其他值，建议检查下前端上有没有地方写死，以及检查下 token 是否匹配。
控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验，将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致。

---
# ID: 36832

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 很多用户反馈麦克风噪音比较大，怎么有效降噪

Reply: 您好，可以考虑 audioScenario 调整为 chatroom 强制走听筒的话用硬件回声消除：[https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#api_irtcengine_setaudioscenario](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#api_irtcengine_setaudioscenario)

如果效果一般可以再考虑[开启 AINS](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_effect#api_irtcengine_setainsmode)，不过 AINS 需要 4.2.0 以上版本，如果您在用的版本在此之下，需要先升级。

---
# ID: 36834

SDK Product: RTC

SDK Platform: React

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 在 react 项目中 创建视频，在手机上 第一次连接，会提示是否允许开启视频和音频，允许后，都能正确显示本段和远端的视频，然后挂机，在继续连接，后面就在手机上 不能显示出远端的视频，只能显示出本地的视频，如果界面上有静音等这些按钮 然后设置下远端的视频就能出来了， 在电脑上 就没有这样的问题，都能正确显示出来

Reply: 您好，您的现象描述看起来更像是业务处理问题，推荐参考我们 Demo ，对比下订阅并渲染远端的处理有什么区别，[React Demo](https://github.com/AgoraIO/API-Examples-Web/tree/main/src/example/framework/react)

---
# ID: 36835

SDK Product: RTM

SDK Platform: Unity

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 我需要创建新项目，提示本账号最多15个项目，怎么申请

Reply: 您好，每个 CID 默认可以创建 20 个 appid，15 个的话还是有剩余空间的。如果您的账号appid 已经达到了上限最多再等待人工工程师手动创建 2-3 个，如果有更多需求的话建议再注册一个声网账号，这样每个 CID 都有 20 个 appid 的额度。

---
# ID: 36836

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 注销这个号     我其他号要绑定这个手机号。

Reply: 您好，您可以在声网 console 左侧边栏-设置-安全设置 里自行注销账号。

---

# ID: 36792

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 有一方视频首帧没有传输过去，8601963

Reply: 您好，请提供以下信息：
1. 问题发生的时间点
2. 具体现象（哪个 uid 看不见哪个 uid）
3. 方便的话提供下出现问题的设备日志，参考：[如何获取日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
人工工程师稍后为您解答，您可以先尝试重启设备或者 app，排除下是否有设备占用情况导致

---
# ID: 36793

SDK Product: RTC

SDK Platform: React Native

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 调研uniapp 中语音通话总是有回音，并且官方示列也有回音

Reply: 您好，回音问题的本质是扬声器声音被麦克风采集到又发回去导致的，通话双方都带耳机基本可以解决这个现象。
以及 uniapp SDK 已经停止更新维护很久了，建议您用我们还在更新维护的 SDK 进行开发：[实时互动](https://doc.shengwang.cn/doc/rtc/homepage)

---
# ID: 36797

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 效果不佳、不达预期

Request Description: SurfaceView 只能设置一次远程视频流   再次设置就不显示  
按照ai 机器人回复的  需要重新设置   mRtcEngine.setupRemoteVideo(new VideoCanvas(null, VideoCanvas.RENDER_MODE_FIT, cuurentuid));
然后在设置 
 mRtcEngine.setupRemoteVideo(new VideoCanvas(sView1, VideoCanvas.RENDER_MODE_FIT, newuid));
还是没有用  是怎么回事呢  

Reply: 您好，在第二次 setupRemoteVideo之前有先把之前在用的 view 解除绑定或者置空吗？以及需要确认下新绑定的 uid 本身是否在频道里发流。
或者您也可以参考我们 Demo 的处理：[https://github.com/AgoraIO/API-Examples/blob/main/Android/APIExample/app/src/main/java/io/agora/api/example/examples/basic/JoinChannelVideo.java#L452](https://github.com/AgoraIO/API-Examples/blob/main/Android/APIExample/app/src/main/java/io/agora/api/example/examples/basic/JoinChannelVideo.java#L452)

---

# ID: 36800

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.2

Request Type: 其他问题

Request Description: 请问怎么在原生鸿蒙arkts环境下使用rtc多人会议，并且可以录制一段视频，上传到我们指定的网站

Reply: 您好，鸿蒙有自己的 SDK[鸿蒙 SDK](https://doc.shengwang.cn/doc/rtc/harmonyos/landing-page)，SDK 内自带一个录制接口可以本地录制，但是录制完的内容需要您自行手动上传，SDK 没有上传机制。
或者您也可以用云录制，云录制录制完自动上传您指定的 OSS，更方便一些：[云录制](https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page)

---
# ID: 36801

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.5.2

Request Type: 线上报错

Request Description: 
```
result = this.rtcEngine.joinChannel(
                options.token || null,
                options.channelName,
                0,
                options.info || null,
            ); 
```
joinChannel错误码为-2是什么问题？ 没有在错误码页找到对应错误码描述

Reply: 您好，错误码 2 对应无效参数，请您检查调用 joinchannel 时的传参内容
推荐参考我们 Demo 的处理方式：[https://github.com/AgoraIO-Extensions/Electron-SDK/blob/main/example/src/renderer/examples/basic/JoinChannelVideo/JoinChannelVideo.tsx#L130](https://github.com/AgoraIO-Extensions/Electron-SDK/blob/main/example/src/renderer/examples/basic/JoinChannelVideo/JoinChannelVideo.tsx#L130)

---
# ID: 36802

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 开通权限、提供配额

Request Description: 项目已经开启旁路推流权限，但app里还是显示无权限

Reply: 您好，可以先确认下开通权限的 appid 和实际在用的 appid 是否是同一个？如果是的话，请问您现在是用的是客户端旁路推流还是服务端旁路推流呢？目前客户端旁路推流已经不建议再使用了，建议您用服务端的 Restful 接口去实现。如果开的是服务端旁路推流，用的是客户端的话，确实是会报错没有权限的。

---

# ID: 36806

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 效果不佳、不达预期

Request Description: 1.录音过程中，在我们设置了config.fileRecordOption = Constants.AUDIO_FILE_RECORDING_MIC前提，下还是录制到了远端的声音，代码如下，音频见附件，麻烦帮我们分析一下，这个对我们很重要，感谢
```
public void initializeAgoraEngine(Context context, String appId,RtcEngine rtcEngine){
         mContext = context;
        RtcEngineConfig config = new RtcEngineConfig();
        config.mContext = context;
        config.mAppId = appId;
        mRtcEngine = rtcEngine;
    }
    int recordId1 = 0;
    public int startLocalAudioRecording(ArrayList<TaskInfoData>  mTaskInfoDataList, int currentIndex) {
        TaskInfoData taskInfoData = mTaskInfoDataList.get(currentIndex);
        String taskId = taskInfoData.getTaskId();
        String groupId = taskInfoData.getGroupId();
        String queueSentence = taskInfoData.getQueueSentence();
        String outFilePath = UiConfig.FILE_DATA_ROOT_PATH + taskId + "/" + groupId + "/";
        String fileNamePrefix = taskId + groupId + queueSentence;
        String baseFilePath = outFilePath + UiConfig.FILE_WAV_FILE_PATH + fileNamePrefix;
        String outWavFile = baseFilePath + ".wav";// 无加密

        File file = new File(outWavFile);
        fileExist(file.getParentFile());
        // 本地录音文件路径
        AudioRecordingConfiguration config = new AudioRecordingConfiguration();
        // 配置本地录音
        config.filePath = outWavFile;
        config.codec = false; // 使用 AAC 编码
        config.fileRecordOption = Constants.AUDIO_FILE_RECORDING_MIC;
        config.sampleRate = SAMPLE_RATE; // 采样率
        config.recordingChannel = 1;

        mRtcEngine.setAudioEffectPreset(Constants.AUDIO_EFFECT_OFF);

        // 启用回声消除
        mRtcEngine.enableAudio();

        // 开始本地录音
        recordId1 = mRtcEngine.startAudioRecording(config);

        // 启用音量提示，设置报告间隔为 200 毫秒，平滑系数为 3，同时报告 VAD 信息
        mRtcEngine.enableAudioVolumeIndication(200, 3, true);

        return recordId1;

    }
```

Reply: 您好，请问您说的录制到了远端的声音是指录到了远端被外放出来的声音还是录音里能清晰听见远端的发流？AUDIO_FILE_RECORDING_MIC 就是只录制自己麦克风采集的，但如果您外放的声音过大，是会被麦克风重新采集到的

---

# ID: 36807

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.2.0

Request Type: 其他问题

Request Description: 我需要在我的这边配置访问的白名单ip,的话如何做。是否可以提供ip或者域名列表。开通云代理服务需要什么

Reply: 您好，目前没有直接对外开放的域名、IP 白名单，如果您有内网使用 RTC 需求，需要付费开通云代理服务，开启后我们才能提供具体的域名、端口、协议来供您使用。[云代理](https://doc.shengwang.cn/doc/rtc/electron/basic-features/firewall)

---

# ID: 36809

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 集成问题咨询

Request Description: 我是在flutter中实现的ai对话，监听的是rtc的streamMessage，现在可以正常显示对话了，但是我应该怎么给智能体发送文字消息或者图片消息呢

Reply: 您好，发送文字消息直接往您的 LLM 回调地址去发就行，不依赖 RTC。
发送图片需要用到 RTM 能力，参考[发送图片消息](https://doc.shengwang.cn/doc/convoai/restful/user-guides/send-multimodal-message)

---
# ID: 36810

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 2.6.5

Request Type: 集成问题咨询

Request Description: 请问声网有支持支付宝小程序的sdk吗

Reply: 您好，目前没有支持支付宝小程序的 SDK，只有微信小程序的。Web SDK 需要 Webview 本身支持 webrtc 协议才行，支付宝小程序的 Webview 目前不支持 WebRTC 协议，所以也没法使用。

---

# ID: 36812

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 我调用start接口返回了sid，但之后我stop返回{"cname":"24080002","code":404,"reason":"failed to find worker","uid":"1"}}，请问这是什么原因

Reply: 您好，stop接口返回404错误（"code":404,"reason":"failed to find worker"）是典型的云端录制任务已结束的标识。
录制任务自己结束或者 start 的时候实际启动失败，后续再调用接口进行操作就会有这种问题。建议您自查下 start 里配置的 token 和 uid、频道名是否匹配，以及录制端被分配的 uid 和频道里在发流的用户是否重复，相同 uid 会导致录制端被踢出频道从而提前结束录制的。
如果自查无法分析出具体原因，您可以提供下 sid，人工工程师稍后为您排查。
参考：[云录制 404 原因](https://doc.shengwang.cn/faq/integration-issues/return-404)


---

# ID: 36814

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 我这边用uniapp刚开始开发但是我发现咱这边已经不维护相关插件了；想问下；uniapp这个框架还可以对接咱这个平台吗？

Reply: 您好，我们的uni-app SDK 已经停止更新和维护了，不推荐新集成使用。目前只有老版本SDK对外开放，可以先参考文档跑通Demo，或者直接使用目前我们还在支持的平台来开发
[SDK](https://github.com/AgoraIO-Community/Agora-Uniapp-SDK/tree/master)
[uniapp 跑通](https://shimo.im/docs/sng09z58Jo4FWtoB/)
文档密码：axucpk

---

# ID: 36819

SDK Product: Whiteboard

SDK Platform: Web

SDK Version: 2.16.43

Request Type: 其他问题

Request Description: 原来没有开启文档转网页和文档转图片功能，在互动白版中上传文档报错，上传不成功；现在开启了这两个功能，还是上传不成功

Reply: 您好，文档上传需要先进行文档转换，文档转换需要您配置正确的 OSS 信息，麻烦截图看下您现在声网 console 的配置截图，然后提供文档转换失败的对应 taskID，人工工程师稍后为您解答。

---

# ID: 36821

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.5

Request Type: 集成问题咨询

Request Description: 开发板(esp32s3, ESP32-S3-Korvo-2）
adf ver:v2.7-0-g9cf556de500019bb79f3bb84c821fda37668c052; 
idf ver:v5.2.3-0-gc9763f62dd00c887a1a8fafe388db868a7e44069)
rtsa sdk ver:agora-iot-sdk-1.9.5-esp32s3-idf5.x-20250626
设备已启动并且已加入频道，然后网页端（https://webdemo.agora.io/example/quickStart/videoAndVoiceCalling/index.html），加入频道后，设备端报错 Invalid payload type 100

并且音频流回调(__on_audio_data)一直没有调用到，这是什么原因

Reply: 您好，Invalid payload type 100 指的是音频播放异常，100 是 PCM 格式，所以是解码后播放 PCM 有问题，定位在解码上。RTSA 和 Web 的音频编码协议不同，您需要保证双方用都支持的协议来互通，具体实现方式参考[与 RTC SDK 互通音视频数据](https://doc.shengwang.cn/doc/rtsa/c/best-practices/interoperate-rtc)

---
# ID: 36822

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 线上报错

Request Description: 云端录制报错：{"notifyMs":1755765617377,"productId":3,"payload":{"serviceType":0,"uid":"999","serviceScene":"mix_record","sendts":1755765617340,"sequence":3,"cname":"show","details":{"stat":0,"errorLevel":5,"errorMsg":"","module":0,"errorCode":110,"msgName":"cloud_recording_error"},"sid":"fb9549dbc24a76aefa00739c7172a41b"},"eventType":1,"noticeId":"eb63b9b4304ba87769f708800ffc35b3","sid":"fb9549dbc24a76aefa00739c7172a41b"}
如何定位错误原因？

Reply: 您好，云录制收到errorCode:110 的事件表示 start 任务因为 token 不正确导致加频道、启动录制失败了，需要您检查下 start 的 body，保证 token 和 cname、uid 匹配，并且 uid 和频道内不冲突。

---
# ID: 36823

SDK Product: RTC

SDK Platform: React Native

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 客户端播放服务端在 Channel 推送过来的流，没有按照预想顺序播放，而是一个播放一半播放别的了

Reply: 您好，听您的描述像是服务端一直在按顺序轮流发送视频文件当视频流，所以问题应该是出在发送的服务端上的。建议自查下读取文件的业务代码处理逻辑，可能是文件读取的时候出现了问题。

---

# ID: 36777

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 其他问题

Request Description: 多人互动，有人数上限吗？现在6人以上就不能上台了

Reply: 您好，灵动课堂默认只能限制 6 个远端的画面，超过 6 人上台的话画面是看不到的，除非您自行修改 UI。请问您这边具体是什么需求和场景需要超过 6 人同时上台？

---

# ID: 36782

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 集成问题咨询

Request Description: 尝试运行跑通案例，发现跑不通

Reply: 您好，请问跑不通的具体表现是什么？有具体的报错截图吗？
可以先排查下 node 版本是否符合要求，灵动课堂需要 16-18 之间的node。以及尝试重新拉灵动课堂仓库最新的代码再试试：[灵动课堂Web/桌面端示例Demo](https://github.com/AgoraIO-Community/flexible-classroom-desktop)
如果以上都无法解决您的问题，请等候人工工程师稍后为您解答。

---

# ID: 36784

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 切换音频输出设备（扬声器/听筒）是this.localTracks.audioTrack.setPlaybackDevice（‘speaker’）这个么，扬声器speaker听筒earpiece

Reply: 您好，Web SDK 无法在移动端上选择播放设备，移动端输出是听筒还是扬声器取决于浏览器行为，Web SDK 只能选择采集设备。[音视频设备管理](https://doc.shengwang.cn/doc/rtc/javascript/basic-features/switch-device)

---
# ID: 36785

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.20.0

Request Type: 集成问题咨询

Request Description: 咨询个技术问题 频道销毁 是不是就是rtc互相挂断的通知，这个时候会通知我的服务端

Reply: 您好，RTC 的频道销毁是频道里最后一个用户离开频道的时候才会触发的，触发时会有 NCS 事件。
参考：[102 channel destroy](https://doc.shengwang.cn/doc/rtc/restful/webhook/events#102-channel-destroy)

---
# ID: 36786

SDK Product: Marketplace

SDK Platform: Web

SDK Version: 自然语言处理

Request Type: 开通权限、提供配额

Request Description: 想测试rtt可以开通权限嘛

Reply: 您好，请问是要开通 Restful 接口方案的 RTT 服务吗？如果是的话可以预留下需要开通的 appid，人工工程师稍后为您解答。
如果您想用的是云市场转写插件，这个需要联系销售申请测试证书才能使用，商务联系电话：400 6326626。

---
# ID: 36787

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.2

Request Type: 集成问题咨询

Request Description: 接入应用后，打开视频没有预览画面

Reply: 您好，请问有跑通过我们的官方 Demo 吗？可以先跑下我们的 Demo 看下问题是否还会复现，检查下是否给予了相机权限、调用了enableVideo、setupLocalVideo、startPreview等接口，也可以检查下有没有错误码打印，如果自行排查无果，麻烦提供下问题复现时的SDK日志（hdc file recv /data/app/el2/100/base/包名/haps/entry/files），人工工程师稍微确认下这个问题的具体原因。

---
# ID: 36788

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 6.4.2-ohos.442029flutter版本接入，在鸿蒙手机上打开视频没有预览画面，黑屏，是什么原因呢

Reply: 您好，声网的 Flutter RTC SDK 目前还没有适配过纯血鸿蒙设备，如果您考虑原生鸿蒙开发的话，可以参考下鸿蒙原生 RTC SDK 的文档：[鸿蒙 RTC SDK](https://doc.shengwang.cn/doc/rtc/harmonyos/landing-page)

---

# ID: 36790

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 配置webhook后，为什么每个事件都要回调四次呢？时间都是在同一秒内。


回调案例内容：

{"sid":"185D526B7A9340298EBB55CAF9BDE93D","noticeId":"1217926940:819614:102","productId":1,"eventType":102,"notifyMs":1755675705500,"payload"{"channelName":"test#video_live_room#544886#1755668941","lastUid":539647,"ts":1755675704}}

Reply: 您好，这是防止消息丢失的机制，我们会重复投递同一个事件 3-4 次，消息通知服务去重可以按照以下方式处理：
1.ncs通知的事件，通过noticeId和eventType一起来做去重。
2.根据状态去判断，例如收到同一个用户的 多个join 事件、quit 事件，先cache 后按照 ts 排序，然后根据在线状态判断。例如排序后顺序是 join(t1), join(t2), quit(t3), quit(t4)，那么就知道 join(t2) 和 quit(t4) 是重复的。
3.对 eventType + payload 部分做比对，两部分都相同的是重复的。
4.根据 ts，来的消息 ts 如果小于等于已处理过的最大 ts，就不处理。
另外也可以参考我们的官网最佳实践文档：[维护用户在线状态](https://doc.shengwang.cn/doc/rtc/restful/best-practice/online-user-status)

---
# ID: 36791

SDK Product: RTM

SDK Platform: Flutter

SDK Version: 2.2.1

Request Type: 集成问题咨询

Request Description: 你好，我们之前使用的是比较老的版本，agora-rtm1.1.1版本，现在看1.x已经被淘汰了，想咨询下，如果要升级的话，API对标信息有吗？例如1.1.1版本的createChannel，在2.X上面是createStreamChannel吗？sendMessage使用publish替代了吗？

Reply: 您好，可以参考下 Native 的 [迁移指南](https://doc.shengwang.cn/doc/rtm2/android/overview/migration-guide),flutter 目前没有专门的文档。
现在发消息全部用 publish 方法代替了，频道类型可以在 publish 的时候指定：[发送消息](https://doc.shengwang.cn/doc/rtm2/flutter/user-guide/message/send-message)

---

# ID: 36746

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 云录播生成的地址无法播放：https://img.slowvers.com/cloud/consultant/20250818/c25081814368505348/cb1e074e6b41065cbe056abdd95c35b7_c25081814368505348.m3u8

Reply: 您好，请问有尝试过用 VLC 或者 IINA 之类支持播放 m3u8 文件的播放器去播放吗？可以先尝试下不同的播放器。如果都放不出来可以检查下 OSS 是不是对 ts 进行鉴权了导致无法直接外部播放。如果也没有进行鉴权，可以等候人工工程师稍后跟进为您解答。

---
# ID: 36754

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 集成问题咨询

Request Description: 在Android 16kb 排查过程中检测出了：
/var/folders/6w/fx8cm7lj7q75yb3tchdsv_1r0000gn/T/app-testenv-release_out_XXXXX.ZrwrRj5hRP/lib/armeabi-v7a/libagora-fdkaac.so: \e31mUNALIGNED\e0m (212)
/var/folders/6w/fx8cm7lj7q75yb3tchdsv_1r0000gn/T/app-testenv-release_out_XXXXX.ZrwrRj5hRP/lib/armeabi-v7a/librongcloud_xcrash.so: \e31mUNALIGNED\e0m (212)


这种UNALIGNED现象，后续会出新的版本支持吗

Reply: 您好，只有 64 位设备需要支持 16kb，v7 是不需要支持的，可以忽略 v7 上的UNALIGNED 现象。

---

# ID: 36758

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.2.0

Request Type: 集成问题咨询

Request Description: 
1. windows SDK中是在怎样接收视频，我想在接收每一帧视频的地方加一个时间戳打印，请问怎样添加；
2. 我看示例是直接调用setupRemoteVideo设置远端视频，没有找到相关接收的地方：
LRESULT CJoinChannelVideoByTokenDlg::OnEIDUserJoined(WPARAM wParam, LPARAM lParam)
{
    if (m_lstUids.size() == m_maxVideoCount)
        return 0;
    CString strInfo;
    strInfo.Format(_T("%u joined"), wParam);
    m_lstInfo.InsertString(m_lstInfo.GetCount(), strInfo);

    m_lstUids.push_back(wParam);
    for (int i = 1; i < m_maxVideoCount; i++) {
        if (m_videoWnds[i].GetUID() == 0) {
            VideoCanvas canvas;
            canvas.uid  = wParam;
            canvas.view = m_videoWnds[i].GetSafeHwnd();
            canvas.renderMode = m_canvasRenderMode;
			canvas.backgroundColor = m_canvasColor;
            //setup remote video in engine to the canvas.
            m_rtcEngine->setupRemoteVideo(canvas);
			m_videoWnds[i].SetUID(wParam);
            break;
        }
    }
    return 0;
}

Reply: 您好，要获取到远端发来的每一帧进行处理需要用裸数据方案，注册观测位置在POSITION_PRE_RENDERER，监听onRenderVideoFrame 在回调触发时获取帧信息。其中包含了时间戳信息。但还想请问下您这边具体是什么场景和需求呢？

[自定义视频数据处理](https://doc.shengwang.cn/doc/rtc/windows/advanced-features/video-processing)
[getObservedFramePosition](https://doc.shengwang.cn/api-ref/rtc/windows/API/toc_video_raw#getObservedFramePosition)
[onRenderVideoFrame](https://doc.shengwang.cn/api-ref/rtc/windows/API/toc_video_raw#onRenderVideoFrame)

---
# ID: 36759

SDK Product: Marketplace

SDK Platform: Flutter

SDK Version: 视频特效

Request Type: 开通权限、提供配额

Request Description: 开通云市场的视频特效功能，我选择了  相芯美颜   的试用包
开发文档里说需要提供包名，但是申请的时候没让填包名

我的包名是 com.video.fruits.user
希望尽快开通

Reply: 您好，请问您是在声网 console 云市场插件里申请开通的吗？自动接口申请的测试证书不需要包名，后续改购买正式证书的时候才需要。
如果是 console 里申请的，可以截图看下现在的证书申请状态，以及您是什么时候申请的？一般一个工作日内都会完成开通，超过一个工作日的话稍后人工工程师会帮您内部确认下开通情况

---
# ID: 36760

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.5

Request Type: 线上报错

Request Description: 我已经联系了 CAT1运营商(中国移动) 并添加了共三个域名的白名单. 通过测试, 可以在嵌入式设备上成功加入RTC CHANNEL并双向语音聊天. 但有发现, 在设备侧有较大概率连接失败, 从串口日志中大概看是以下出错: Join the channel xxxxx successfully, uid xxxxxx elapsed xxx ms Remote user "xxxxx" has joined the channel, elapsed xx ms connection timeout, reconnecting 然后会自动重连, 有时是可以成功的: Rejoin the channel successfully, uid xxxxxx elapsed xxxx ms video: uid=xxxxxx muted=1

详细请看附件日志

Reply: 您好，定向流量卡除了报备指定域名以外还需要在初始化 SDK 引擎的时候配置 domain_limit 字段为 true，请问您这边有进行过相关处理吗？
如果有的话可以提供下完整 SDK 日志文件，稍后人工工程师为您确认具体原因

---
# ID: 36761

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 效果不佳、不达预期

Request Description: 现在出现一个问题： 直播频道：1956338760737136640 主播ID：530306 观众ID：566817 会出现音频卡顿没声音(断断续续，有时候连续很久没声音)，IOS设备上会出现，android设备不出现，看数据是ios音频播放信号强度为-1，这个是什么原因造成的

其他数据都正常，但是就是会没声音

复现方式：
用户加入房间，此时音频能正常播放
用户退出房间后马上加入房间，此时音频会播放一会儿，然后就没声音了，然后过一会儿又恢复，然后卡卡顿顿
如果退出直播间后等待一段时间再加入则音频正常播放，安卓不存在这个问题。 退出直播间仅执行了 leaveChannel 操作，加入直播间执行了 enableAudio 和 enableVideo，屏蔽 enableAudio 和 enableVideo 后一样音频卡顿

日志相关文件如下，进行了几次直播间操作，期间重启了几次app，第一次进入都能正常播放，第二次进入都会没声音卡顿，属于必现

Reply: 您好，可以优先检查下出现问题的 IOS 设备本身是否存在音频占用情况，以及您可以提供下完整 SDK 日志，说明下出现问题的时间点，稍后人工工程师为您排查下具体原因。
[如何设置日志文件？](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---
# ID: 36764

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: pc端集成SDK，pc与pc可以正常通信，
pc与react native 版App通信的时候pc收不到 user-published 回调，

Reply: 您好，user-published 回调只有在频道内远端主播发流的时候才会触发，收不到的话可能是双方有人不在频道内或者没有发流。可以优先检查下 RN 的 SDK 日志，看下 RN 是否正常加入频道了。
您可以提供以下信息：
1. 声网项目APPID
2. 频道名(cname)
3. 问题发生时间点（精确到分钟）
4. 现象细节：
	* 受影响的具体UID（例：Web端UID=123无法监听到RN端UID=456发布流）
	* 是否所有RN端都无法被监听到？
5. 日志文件（必须提供）：
	* Web端SDK日志：设置指南
	* React Native端SDK日志（参考Android/iOS的获取方式）

以及您也可以先按照以下内容进行自查：
1. Token与APPID一致性
确认Web和RN端使用完全相同的APPID，且Token生成时未指定不同权限（如RN端未禁用发布流）。
2. SDK版本兼容性
RN端使用的react-native-agora版本需与Web SDK兼容（推荐双方均使用v4.x+）。
3. 基础流程验证
RN端加入频道时配置 joinChannel 的 options 里开启发送视频流或音频流（Web端依赖此动作触发回调）。
4. 检查频道内 uid 类型是否同意，建议全部用 int uid， string 或者 string + int 混用容易出现预期外情况。


---

# ID: 36770

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 其他问题

Request Description: 如附件：频道内大量用户的视频采集帧率为0但是发送帧率为15
很好奇，按照我的理解，采集帧率不应该是设备的采集帧率，发送帧率不应该是推到频道的帧率吗？发送帧率可以大于采集帧率？

Reply: 您好，采集帧率上报一般是 SDK 的采集数据，如果是用的是自采集方案，那采集上报就一直是 0 了。以及数据上报本身也可能出现上报丢失的情况，仅供参考。请问现在遇到什么问题了？可以描述下完整问题现象，提供对应的频道号、uid、时间点，如果可以的话再获取下 SDK 日志文件：[如何设置日志文件？](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# ID: 36773

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 调用了启动内容审核(依图)之后，接口返回成功，并调用查询审核状态接口返回:
{"cname":"33569888","resourceId":"mwwME88RCsfOLdLU7jz_vv96oQaavE6DxZUokGPrRqQzTTNMe_LwWQQVul8ZdLmre8FCHavQKtQwiKbIh_CCiDgA8cNaBA4KkJQ8SnyDkdIRwE2RbtaByJfRp1kkU3-achv2jhDgJU-h4cXE4anHOpHuAvoAG5HaByEKHYcAywCw3zx_74308gvXIHWwYyZZBSPFIQydW-MWhYzR7OO3Qw","serverResponse":{"extensionServiceState":{"serviceName":"yitu_voice_async_scan","streamState":{"status":"inProgress","streamType":"audio","uid":"0"}},"subServiceStatus":{"mediaDistributeService":"serviceReady","recordingService":"serviceInProgress"}},"sid":"90366c486949ec5bfef24cb787f113c6","uid":"999"}

1.在客户端一对一保持视频通话的情况下，隔个几分钟再次调用查询审核状态接口返回{"cname":"33569888","code":404,"reason":"failed to find worker","uid":"999"},在测试过程中，有说一些违规内容，"加我微信，xxx"，但是好像并没有触发违规，并且在依图后台查询不到使用记录和内容记录
帮我查询下，是否是参数的问题，还是有什么服务没有打开


Reply: 您好，404 failed to find worker 大概率是因为录制端已经结束任务退出频道导致的。审核没有生效的问题请等候人工工程师为您解决，您可以先自查下第三方平台上是否有产生用量，以及确认下启动云录制填写的审核参数是否真实有效，如果填了错误的第三方信息，审核是无法启动的。

---
# ID: 36774

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.2

Request Type: 集成问题咨询

Request Description: 1, 问题表现
我在esp32开发板上集成agora_rtsa_sdk(用的是这个包Agora-RTSALite-Rc-xtensa_lx7-freertos-eabi-v1.9.2-20231220_171304-287745），然后程序跑起来就core掉了
2，重现步骤
启动开发板，调用agora_rtc_init就崩， 主要是这个日志有点奇怪
“ahpl_malloc 1070238160 byte failed”
3，日志
vlog_func_p ...
ahpl_malloc 1070238160 byte failed

abort() was called at PC 0x42091edc on core 0
--- 0x42091edc: ahpl_malloc at /home/zgx/code/iot/1.9.2/iot-paas-package/rtc/iot-paas-sdk/ahpl/mm/mm.c:184
--- (inlined by) ahpl_malloc at /home/zgx/code/iot/1.9.2/iot-paas-package/rtc/iot-paas-sdk/ahpl/mm/mm.c:171


Backtrace: 0x40375a99:0x3fca8940 0x4037c309:0x3fca8960 0x40383a6a:0x3fca8980 0x42091edc:0x3fca89f0 0x4209403f:0x3fca8a10 0x42094622:0x3fca8a40 0x42093d14:0x3fca8a70 0x420bf293:0x3fca8a90 0x42
0bf459:0x3fca8b40 0x4200b062:0x3fca8b80 0x4200aa93:0x3fca8c90 0x42115e5f:0x3fca8ff0
--- 0x40375a99: panic_abort at E:/work/esp32/src/esp-adf/esp-idf/components/esp_system/panic.c:454
--- 0x4037c309: esp_system_abort at E:/work/esp32/src/esp-adf/esp-idf/components/esp_system/port/esp_system_chip.c:92
--- 0x40383a6a: abort at E:/work/esp32/src/esp-adf/esp-idf/components/newlib/abort.c:38
--- 0x42091edc: ahpl_malloc at /home/zgx/code/iot/1.9.2/iot-paas-package/rtc/iot-paas-sdk/ahpl/mm/mm.c:184
--- (inlined by) ahpl_malloc at /home/zgx/code/iot/1.9.2/iot-paas-package/rtc/iot-paas-sdk/ahpl/mm/mm.c:171
--- 0x4209403f: mpqp_create at /home/zgx/code/iot/1.9.2/iot-paas-package/rtc/iot-paas-sdk/ahpl/kernel/mpqp.c:496
--- 0x42094622: __mpqp_create_cpu_pool at /home/zgx/code/iot/1.9.2/iot-paas-package/rtc/iot-paas-sdk/ahpl/kernel/mpqp.c:547
--- (inlined by) k_mpqp_init at /home/zgx/code/iot/1.9.2/iot-paas-package/rtc/iot-paas-sdk/ahpl/kernel/mpqp.c:626
--- 0x42093d14: ahpl_ctor at /home/zgx/code/iot/1.9.2/iot-paas-package/rtc/iot-paas-sdk/ahpl/kernel/mpq.c:2118
--- 0x420bf293: rtc_init_async at /home/zgx/code/iot/1.9.2/iot-paas-package/rtc/iot-paas-sdk/rtsa/rtc/rtc_service.c
--- 0x420bf459: agora_rtc_init at /home/zgx/code/iot/1.9.2/iot-paas-package/rtc/iot-paas-sdk/rtsa/rtc/rtc_service.c:2295
--- 0x4200b062: sheng_rtc_init at E:/work/esp32/src/esp-adf/examples/recorder/pipeline_raw_http.test/main/sheng_rtc.c:309
--- 0x4200aa93: app_main at E:/work/esp32/src/esp-adf/examples/recorder/pipeline_raw_http.test/main/record_raw_http.c:156
--- 0x42115e5f: main_task at E:/work/esp32/src/esp-adf/esp-idf/components/freertos/app_startup.c:208
--- 0x403759dd: esp_restart_noos at E:/work/esp32/src/esp-adf/esp-idf/components/esp_system/port/soc/esp32s3/system_internal.c:16

Reply: 您好，请确认下您现在在用的是 esp32 的什么套件？（比如 IDF 是否用的是 5.0 以上版本？）
可以完整描述下目前的系统信息，推测是包不匹配导致的崩溃

---

# ID: 36739

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 开通权限、提供配额

Request Description: demo跑不通，提示 请确保你的项目已开通声网音乐内容中心权限。

Reply: 您好，音乐版权不支持自服务，所以必须要先联系销售跟进才能处理，请电话联系：400 6326626
如果您有对接的销售，可以先找销售沟通下需要申请开通版权音乐，完成相关报备。

---
# ID: 36741

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.2.0

Request Type: 集成问题咨询

Request Description: 没有画面，调试连接直接断开， 看到里面有这样的log
2025-08-18 17:17:14.512 27456-27456 getprop                                                      W  type=1400 audit(0.0:30565): avc:  denied  { open } for  path="/dev/__properties__/u:object_r:vendor_camera_software_moonlight_prop:s0" dev="tmpfs" ino=464 scontext=u:r:shell:s0 tcontext=u:object_r:vendor_camera_software_moonlight_prop:s0 tclass=file permissive=0
2025-08-18 17:17:14.516 27458-27458 getprop                                                      W  type=1400 audit(0.0:30566): avc:  denied  { open } for  path="/dev/__properties__/u:object_r:vendor_camera_software_moonlight_prop:s0" dev="tmpfs" ino=464 scontext=u:r:shell:s0 tcontext=u:object_r:vendor_camera_software_moonlight_prop:s0 tclass=file permissive=0
2025-08-18 17:17:14.612 27462-27462 cmd                     .                                    E  BBinder_init Processname  cmd  
2025-08-18 17:17:14.613 27462-27462 cmd                     .                                    E  BBinder_init hasGetProcessName  cmd

Reply: 您好，请问没有画面具体是哪个 uid 看不见哪个 uid？麻烦完整描述下具体现象和时间点并提供 SDK 日志，稍后人工工程师会根据日志分析一下具体情况。
[如何开启日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---
# ID: 36740

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.2.0

Request Type: 集成问题咨询

Request Description: 请问一下，设备为Android aosp10的系统，设备如何打声网的log记录，然后发给你们云端。这个如何实现？谢谢

Reply: 您好，声网只接受 Web 的日志上传，Native 的日志是不会主动收集保存的。您可以参考下方文档来开启 Native 日志输出，自行获取日志路径里的日志文件上传到您自己的业务服务器，在出现问题需要调查时提交工单来咨询我们，我们的人工工程师可以解密看到日志原文。
[如何开启日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---
# ID: 36742

SDK Product: RTM

SDK Platform: Flutter

SDK Version: 2.2.1

Request Type: 集成问题咨询

Request Description: 项目在做鸿蒙化适配，RTM有鸿蒙sdk吗

Reply: 您好，目前RTM Flutter SDK 暂未提供专门适配鸿蒙系统（HarmonyOS）的版本，如果您有适配鸿蒙的需求，我们有一个 Beta 版本的纯血鸿蒙 RTM SDK，如果您考虑原生开发的话可以说明下，等候人工工程师稍后提供下载地址。

---
# ID: 36743

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 网页刷新，加入房间偶发出现（80%的概率）User join failed AgoraRTCError WS_ABORT: UID_BANNED

Reply: 您好，UID_BANNED 是 uid 被踢出频道后的报错，您可以自查下踢人接口的相关调用记录，检查下自己的业务是否符合预期。
[踢人接口](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/post-dev-v1-kicking-rule)

---
# ID: 36517

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.1

Request Type: 集成问题咨询

Request Description: 请问安卓端调用 RtcEngineEx.destroy() 方法后，会触发下面的 Webhook 回调事件吗

 * 直播场景下，主播加入频道。
 */
BROADCASTER_JOIN_CHANNEL(103, "broadcaster join channel"),

/
 * 直播场景下，主播离开频道。
 */
BROADCASTER_LEAVE_CHANNEL(104, "broadcaster leave channel"),

/
 * 直播场景下，观众加入频道。
 */
AUDIENCE_JOIN_CHANNEL(105, "audience join channel"),

/
 * 直播场景下，观众离开频道。
 */
AUDIENCE_LEAVE_CHANNEL(106, "audience leave channel"),

Reply:  您好，调用destroy接口 是可以触发104、106 离开事件的；但是业务侧不建议这样调用，更合理的方式的是调用leavechannel接口，我们建议是 engine 在 app 声明周期里复用一个就可以，不要重复创建和销毁。

---
# ID: 36529

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.5

Request Type: 集成问题咨询

Request Description: 问个问题，在帧模式下，RTSA是可以和咱们声网的web版sdk构造的应用是可以直接互通的吗

Reply:  是的，RTSA SDK 在帧模式下可以与声网的 Web SDK 直接互通。以下是关键信息：

互通支持说明
双向互通
RTSA SDK（包括帧模式）支持与声网 Web SDK（v3.0.0 或更高版本）的双向音视频互通。

音频互通：支持 G.722、G.711、Opus 编码格式
视频互通：支持 H.264 编码格式
帧模式要求
在帧模式下传输时需确保：

音频为单声道，采样率建议 16 kHz（双声道需转单声道）
视频需符合 H.264 Baseline Profile
数据发送间隔为 20 ms
互通验证
可通过以下步骤验证：

设备端：使用 RTSA SDK 的 agora_rtc_send_audio_data 和 agora_rtc_send_video_data 发送帧数据
Web 端：通过 RTC Web SDK 的 Client.on("stream-published") 接收流
注意事项
token使用：两端需使用相同的 App ID，相同的cname，不同的uid 分别 生成不同的token；禁止多个客户端使用同一个token
编解码匹配：Web SDK 需开启对应编解码（例如通过 createClient({ codec: "h264" }) 指定）
带宽适应：建议开启 RTSA 的带宽预测功能（通过 agora_rtc_set_bwe_config 配置）

---
# ID: 36533

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description:  请问下服务器api禁用用户视频推流后,会让画面保持在最后一帧.有没有办法在不调整客户端的情况,禁用推流后,让画面黑掉?

Reply:  您好，当通过服务器 API（如 RESTful API）禁用用户视频推流后，远端设备默认会显示最后一帧画面。这是声网 SDK 的默认行为；不修改客户端逻辑是无法实现黑屏的；建议您可以监听onremotevideostatechanged 回调来判断远端是否发流，如果远端不发流，既可以清除远端视图view，参考文档：
https://doc.shengwang.cn/api-ref/rtc/android/API/toc_video_basic#callback_irtcengineeventhandler_onremotevideostatechanged

---
# ID: 36534

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 这边想要体验一下声网的高级美颜。
麻烦 发一下对接文档  Demo这些

Reply:  您好，声网的高级美颜参考文档如下：
https://doc.shengwang.cn/doc/rtc/android/advanced-features/advanced-beauty

---
# ID: 36539

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 发起录制报错

请求： https://api-cn-east-1.sd-rtn.com/v1/apps/7184450bb5d14f4fa61a90f32c6ac131/cloud_recording/acquire
请求体：{"cname":"10003","uid":"1754556256324","clientRequest":{"scene":0,"startParameter":{"token":"007eJxTYIh/ss7rgYTt29a/3/9n6jyweq1tvu5f1Pf5Fxvjbn5aZ/xFgcHc0MLExNQgKck0xdAkzSQt0cww0dIgzdgo2Swx2dDY8HnilIyGQEYGlRslTIwMEAjiszIYGhgYGDMwAACv0yLT","recordingConfig":{"channelType":1},"recordingFileConfig":{"avFileType":["hls","mp4"]},"storageConfig":{"vendor":2,"region":0,"bucket":"baomihua-short","accessKey":"xxx","secretKey":"xxx"}}}}
返回：{"code":2,"reason":"api body validate failed!"}

Reply:  您好，您目前填写的 uid 超出了 int 值上限，请修改为 2^31-1（2147483647） 以内的大小。
以及 startParameter 用于预配置后续 start 请求，但极易引发 request_hash mismatch 错误。建议省略此字段，直接在 start 接口配置录制参数。建议简化 acquire 请求，参考文档中的示例，用最少的内容去完成acquire。
[获取云端录制资源](https://doc.shengwang.cn/doc/cloud-recording/restful/cloud-recording/operations/post-v1-apps-appid-cloud_recording-acquire)

---
# ID: 36547

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 效果不佳、不达预期

Request Description: Agent 说话突然中断，然后报错： agent-error" "5406"

{"type":"tts","code":1002,"message":"rate limit","timestamp":1754531123280}

Reply:  您好，报错提示显示问题出在 tts 上，这个错误码来自第三方 tts 技术提供商，您可以在对应厂商的错误码文档上看下具体报错示意和解决方案。

---
# ID: 36551

SDK Product: Recording

SDK Platform: Linux-Java

SDK Version: 4.4.150.5

Request Type: 效果不佳、不达预期

Request Description: 现场环境启动录制的时候录到一般自己会离开

Reply:  您好，建议检查下录制端所在的频道内是否有人发流，如果录制端已经成功加入频道还主动离开的话，大概率是没有录制到画面自动退出了。如果确认加入频道成功并且有人发流还有这个现象，麻烦提供完整的 sdk.log 日志过来，人工工程师稍后为您解答。

---
# ID: 36553

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 我这边是用uniapp的video组件进行拉流和live-pusher组件进行推流的，配置的域名推流是swpush.tohello.cn，播放域名是swpull.tohello.cn，CNAME也配置好了，推流请求的完整地址是rtmp://swpush.tohello.cn/live/stream1，拉流请求的完整地址是rtmp://swpull.tohello.cn/live/stream1。目前没跑鉴权
目前测试推送是正常的，但拉流一直失败。我想问下是因为我播流地址写错了还是目前播放域名配置提示在审核中所以无法跑动，还是播放域名配置有哪些没配置好或者没开启之类的

Reply:  您好，可以先 dig 一下您目前在用的域名，确认下 CNAME 是否配置成功了。如果 CNAME 配置正常拉流还播放失败，麻烦提供下声网 console 里推拉流地址配置页面的截图，人工工程师稍后为您排查原因。


---
# ID: 36461

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 使用c++中的代码，在使用远程实时音视频时与本地摄像头存在冲突，如何解决

Reply:  您好，如果要和远端音视频互通，SDK 就需要使用摄像头来发流，肯定会有占用情况的，请问现在具体是什么现象？
麻烦完整描述下使用场景并且提供 SDK 日志（使用命令 hdc file recv /data/app/el2/100/base/[包名]/haps/entry/files)，人工工程师稍后为您解答

---
# ID: 36488

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 线上报错

Request Description: 这个房间：11843719894有回音

用户id：113802  笙儿

Reply:  您好，针对回声问题，需要您补充提供以下信息，以便我们能够第一时间开展排查：
1. 出问题的时间点：
2. 定位引起回声的用户。可通过依次静音频道内的用户进行确认：当用户A静音时，频道内其他用户听不到回声了，则说明用户A是引起回声的用户。
1 对 1 通话：如果您听到回声，临时建议请让对方佩戴耳机进行通话。
多人通话：可以请用户轮流静音，找出回声源。引起回声的用户请佩戴耳机，或在无需发言时，请将自己设为静音状态
3.提供回声源用户端的[声网sdk日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---
# ID: 36491

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description:   使用过程接听电话是会在哪个回调反馈？

Reply:  您好，在使用rtc通话中本地接听手机电话，rtc侧会可以通过onLocalAudioStateChanged回调来监听本地音频采集状态：
reason：LOCAL_AUDIO_STREAM_REASON_INTERRUPTED (8)
参考文档：[onLocalAudioStateChanged](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#callback_irtcengineeventhandler_onlocalaudiostatechanged)

---
# ID: 36492

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.0

Request Type: 线上报错

Request Description: 课次id：578676826
用户id：20249803
问题：摄像头横屏，辛苦老师看下

Reply:  您好，针对线上单机摄像头横屏问题，人工工程师会根据您提供的课堂id 和用户id，通过内部分析工具排查定位，有结论后会尽快回复您；感谢您的理解与配合，另外建议您可以联系用户重启下设备重进频道是否正常。

---
# ID: 36495

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.1

Request Type: 效果不佳、不达预期

Request Description: 我们现在线上大多数主播都反馈音质不好，怎么调整？

Reply:  您好，针对线上主播反馈音质差的问题，需要您提供以下信息以便我们及时开展排查：
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
(1) uid=123 听不到/看不到 uid=456，大约持续20分钟
4.SDK日志（非必提供)
https://doc.shengwang.cn/faq/integration-issues/set-log-file
(2) uid=123 听/看 uid=456卡顿
4.主播是否使用声卡
5.主播端声网sdk日志（非必需）
https://doc.shengwang.cn/faq/integration-issues/set-log-file
另外您这边也可以参考下我们的高音质实践文档，来对项目进行优化：
https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality



---
# ID: 36496

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.1

Request Type: 集成问题咨询

Request Description: CONNECTION_STATE_FAILED(5)：网络连接失败
CONNECTION_CHANGED_BANNED_BY_SERVER (3)：网络连接被服务器禁止，例如，当用户被踢出频道时，会返回该状态。 确认下  只有用户被踢 这个reason 才会返回3  还是有其它情况 也会返回3

Reply:  您好，是的，CONNECTION_CHANGED_BANNED_BY_SERVER (3) 是只有用户被踢出频道（例如通过服务端RESTful API主动踢人）才会触发的

---
# ID: 36497

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 给我一个 react的web的对话式AI引擎例子 你们的文档写的太过于差劲了

Reply:  您好，React Demo 参考 Web Demo 就行了，集成 WebSDK 加入频道就可以和智能体通话了。
[React Web Demo](https://github.com/AgoraIO/API-Examples-Web/tree/main/src/example/framework/react)

ConvoAI 是通过 Restful 接口启动的，启动以后就加入指定的 RTC 频道了，不需要 Web 端集成 convoAI 的 SDK。
[使用 RESTful API 实现对话式 AI 引擎](https://doc.shengwang.cn/doc/convoai/restful/get-started/quick-start)

---
# ID: 36501

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.5.1

Request Type: 效果不佳、不达预期

Request Description: 我们是语聊房场景，现在一个房间有20个麦位，进入这样的房间，声网的CPU占用率非常高。这个有办法优化么？

Reply:  您好，针对观众端接收多个用户音频流导致cpu过高的问题，建议您可以尝试以下方案处理：
1、降低编码码率为18 Kbps，调用setAudioProfile接口，参考文档
https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#setAudioProfile%20[2/2]
2、开启音强选流，默认是接收远端音频强度最高的3路音频流，可以减少接收端下行带宽压力及系统资源消耗，参考文档：
https://doc.shengwang.cn/doc/rtc/android/advanced-features/audio-stream-filter

---
# ID: 36413

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.0

Request Type: 线上报错

Request Description: 如果在语聊期间，退到后台，长时间会触发什么?

Reply:  您好，应用退后台后，部分系统存在回收资源的情况，会引发音频无声、画面黑屏的情况；建议您这边业务侧做下后台保活，参考文档如下：
https://doc.shengwang.cn/faq/quality-issues/android-background

---
# ID: 36416

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.2.6

Request Type: 集成问题咨询

Request Description: firebase 收到了这个空指针的问题：
Fatal Exception: java.lang.NullPointerException: Attempt to read from field 'android.app.Activity android.app.ActivityThread$ActivityClientRecord.activity' on a null object reference in method 'boolean android.hardware.camera2.vivo_ext.VivoCameraUtils.isForBlockBroadcastActivity(android.app.ActivityThread)'
       at android.hardware.camera2.vivo_ext.VivoCameraUtils.isForBlockBroadcastActivity(VivoCameraUtils.java:212)
       at android.hardware.camera2.vivo_ext.VivoCameraUtils.sendOpenCloseCameraBroadcast(VivoCameraUtils.java:139)
       at android.hardware.camera2.impl.CameraDeviceImpl.close(CameraDeviceImpl.java:1578)
       at io.agora.rtc2.video.VideoCaptureCamera2$StopCaptureTask.run(VideoCaptureCamera2.java:596)
       at android.os.Handler.handleCallback(Handler.java:1014)
       at android.os.Handler.dispatchMessage(Handler.java:102)
       at android.os.Looper.loopOnce(Looper.java:250)
       at android.os.Looper.loop(Looper.java:340)
       at android.os.HandlerThread.run(HandlerThread.java:107)


Reply:  您好，针对程序卡死崩溃类问题，需要您这边提供崩溃堆栈和对应的声网sdk日志：
Android 端运行 adb bugreport 命令获取系统生成的崩溃报告。
如果你在 App 中集成了 Bugly，也可以直接通过 Bugly 获取崩溃信息。
具体参考文档如下：
[如何获取崩溃信息](https://doc.shengwang.cn/faq/integration-issues/system-crash-info)
[如何设置日志文件](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---
# ID: 36421

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.5.2

Request Type: 线上报错

Request Description: 测试目前遇到问题了，主播端音视频突然断掉了，测试同学关闭直播间，重新开播新的直播，但是用户端没声音没视频

Reply:  您好，主播音视频突然断掉，可能是主播离开了频道，如正常离开或者程序闪退异常退出；再次开播，用户端看不到音视频，需要您这边提供以下信息，以便我们第一时间开展问题调查：
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
(1) uid=123 听不到/看不到 uid=456，大约持续20分钟
(2) uid=123 听/看 uid=456卡顿


---
# ID: 36422

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.1

Request Type: 集成问题咨询

Request Description: 请Request Description: sendStreamMessage() called error: -12
是什么原因

Reply:  您好，sendStreamMessage()  接口返回-12 ，由于官网文档没有明确说明，需要人工工程师内部核实后给您答复，另外也麻烦您这边描述下接口的使用场景以及提供下声网的sdk日志，便于我们去进一步排查定位问题
[日志设置](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
感谢您的理解与配合

---
# ID: 36426

SDK Product: RTC

SDK Platform: Unreal

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: uniapp 平台的插件只支持 iOS 和 Android？

Reply:  您好，声网侧在uniapp平台只支持ios和android，参考文档如下：
https://ext.dcloud.net.cn/plugin?id=3741

---
# ID: 36428

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 请问一下，有支持电话会议/电话呼入/电话呼出这种场景的 方案或介绍吗？

Reply:  声网提供了支持电话会议（包括电话呼入和呼出）的完整方案，可通过 小樱桃 XSwitch PSTN 扩展 实现声网 RTC 与 SIP/PSTN 电话网络的互通。您可以参考文档来集成 [小樱桃 XSwitch PSTN 使用说明](https://doc.shengwang.cn/doc/marketplace/android/integrate-extensions/xyt-xswitch-pstn-cn)

---
# ID: 36433

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 线上报错

Request Description: 试用对话式 AI 引擎 Playground，配置了豆包、千问等LLM都不能使用。参数都是没有问题的，附件2图片是我测试豆包的LLM接口，是可以调用成功的。 错误信息：{ "module": "llm", "code": 500, "message": { "error": { "code": "AccessDenied", "message": "The request failed because you do not have access to the requested resource. Request id: 021754292599099078532ccda42bfe607645d235a467167bd1a7b", "param": "", "type": "Forbidden" } } }

Reply:  您好，这个表示我们访问您的 LLM 回调地址失败了，您可以先检查下 LLM 用到的 api key 是否正确。如果用的是 playground，可以刷新下页面再请求试试。如果都解决不了的话，麻烦您提供下 agentID，人工工程师稍后排查下具体原因。

---
# ID: 36436

SDK Product: RTMP

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 咨询下，有个主播想用电脑开播说音质效果更好，跟我说用什么OBS推流开播，具体是怎么操作，他问咱们能给他推流地址吗？ 如果他电脑直播会影响流量分辨率之类不？

Reply:  您好，RTC 没有推流地址这一说，推流地址一般是 CDN 用的，协议和 RTC 不同。
我们有一个 RTMP 网关产品，可以生成推流码以后让用户推流到我们指定的地址上，这样就可以把画面试试传入到 RTC 频道里去了。但RTMP网关无法拉流，如果有拉流需求需要再启动一个旁路推流服务，把 RTC 频道里的画面推到指定 RTMP 地址上才能拿到画面。
一般建议集成桌面端的 RTC SDK，开发一个桌面端 app 出来更好。

[RTMP 网关](https://doc.shengwang.cn/doc/rtmp-gateway/restful/landing-page)
[旁路推流](https://doc.shengwang.cn/doc/media-push/restful/landing-page)
[Windows SDK](https://doc.shengwang.cn/doc/rtc/windows/landing-page)

---
# ID: 36437

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.2

Request Type: 集成问题咨询

Request Description: 在纯血鸿蒙系统中，设备是折叠屏的情况下，展开设备，rtc会议无法准确获取当前折叠状态下可用的摄像头，并优先使用前置摄像头。导致rtc会议失去画面

Reply:  您好，可以先确认下您目前所用的 SDK 版本是否为官网最新版本，并且麻烦提供下问题复现时的SDK日志（hdc file recv /data/app/el2/100/base/[包名]/haps/entry/files），提供下复现问题时的现象视频。人工工程师稍微确认下这个问题的具体原因。

---
# ID: 36447

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 集成问题咨询

Request Description: flutter-IOS跑debug通话一切正常。打包出release 内测包装的时候加入频道直接卡死，应该怎么处理？

Reply:  您好，针对程序卡死崩溃类问题，需要您这边提供崩溃堆栈和对应的声网sdk日志：
通过以下步骤在 Xcode 中获取崩溃日志：
将 iOS 设备连接到电脑
打开 Xcode
选择 Window > Devices and Simulators
在设备列表中选择你的 iOS 设备
在右侧点击 View Device Logs，这里会显示设备上的所有崩溃日志
在日志列表中找到你的 App 崩溃日志
如果你在 App 中集成了 Bugly，也可以直接通过 Bugly 获取崩溃信息。
具体参考文档如下：
[如何获取崩溃信息](https://doc.shengwang.cn/faq/integration-issues/system-crash-info)
[如何设置日志文件](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# ID: 36144

SDK Product: Cloud-recording

SDK Version: 当前版本

SDK Platform: Restful

Request type: 效果不佳、不达预期

Request Description: 云端录制单流录制模式只有分片文件？不能设置输出一个完整的录制文件？现在看每个分片只有15秒，太少了

回答思维链：客户应该已经收到了云录制的录制文件，但是不知道录制完成后会生成一个完整的 m3u8 来播放，可以让客户查询下 OSS 内是否有 m3u8 文件

Reply:  您好，录制结束以后会有一个 m3u8 文件可以完整播放所有切片文件，您播放 m3u8 就可以了，参考：[https://doc.shengwang.cn/doc/cloud-recording/restful/user-guides/manage-file/introduce-recorded-files](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guides/manage-file/introduce-recorded-files)

---

# ID: 36136

SDK Product: RTC

SDK Version: 4.2.0

SDK Platform: React Native

Request type: 集成问题咨询

Request Description: 我们想在linux上做使用java做服务，可以服务很多客户端。
对每个客户端，java服务都可以进入的一个房间给客户端1对1的进行语音应答。
请问，这边有linux-java的sdk吗

回答思维链：客户需要 Linux Java 服务端的 SDK，给他提供对应地址即可

Reply:  您好，服务端 SDK 支持创建多个 connect，每个 connect 对应一个频道

[https://doc.shengwang.cn/doc/rtc-server-sdk/java/resources](https://doc.shengwang.cn/doc/rtc-server-sdk/java/resources)

---

# ID: 36112

SDK Product: RTC

SDK Version: 其他版本

SDK Platform: Android

Request type: 线上报错

Request Description: 这个频道，1个老师，2个学生上课。但是1个学生反馈他能看到听到老师，但老师好像没看见他。
后台看了下，这个有问题的学生，一开始进入了6874e8bef0db19910003557e的通话ID，然后又超时退出了。老师进入了另一个通话ID。
既然退出了，那么学生怎么没有被踢出房间，而且还能看到在另一个通话ID的老师，但老师没有看见他？

回答思维链：针对线上视频可用性问题，用户必需先提供准确的问题频道号、时间点、以及哪个uid看不到哪个uid，以便去查看后台的对应用户的视频相关参数有没有异常，进而给出初步的答复。

Reply:  您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   另外也麻烦您看下本身设备侧采集是否正常，比如使用其他语聊类app（微信）通话是否正常；或者使用自带的录音机录制看下是否正常

另外建议您这边可以这样做下
1、联系下学生检查下设备的摄像头是否正常；
2、业务侧根据onLocalVideoStateChanged回调的state和reason参数 在UI上提示用户当前的视频采集状态以及错误原因，引导用户退出重进频道或者重启设备后重进等。

---

# ID: 36099

SDK Product: Flexible-classroom

SDK Version: 其他版本

SDK Platform: Android

Request type: 线上报错

Request Description: 孩子用的新东方小课屏那种平板上课，老师反馈听不清，孩子的声音很小，有时有回音。孩子也听不清老师的声音。

回答思维链：针对线上音频体验类问题，声音小，听不清，回声等问题，初步都是需要客户侧提供频道号、时间点、uid信息等关键信息，结合内部排查工具后才能给初步结论

Reply:  您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   另外也麻烦您看下本身设备侧采集是否正常，比如使用其他语聊类app（微信）通话是否正常；或者使用自带的录音机录制看下是否正常
   另外也麻烦您看下本身设备侧采集是否正常，比如使用其他语聊类app（微信）通话是否正常；或者使用自带的录音机录制看下是否正常

---

# ID: 36075

SDK Product: Cloud-recording

SDK Version: 当前版本

SDK Platform: Restful

Request type: 线上报错

Request Description: 我们的服务检测到使用restful 接口关闭录制时，调用时间很长（15s左右），具体请求地址如上，麻烦给看下

回答思维链：客户反馈云录制调用 stop 的耗时很久，可能是因为调用 stop 时 body 里传参 async_stop 为 false，导致需要等录制文件都上传完才会返回结果，所以耗时通常会久一些，可以让客户先自行检查下这个字段。

Reply:  您好，可以捞一下调用 stop 时的完整请求内容看下是不是用了async_stop 为同步，如果是同步的话，需要等录制文件都上传完才会返回结果，所以耗时通常会久一些。

---

# ID: 36024

SDK Product: RTC

SDK Version: 4.23.2

SDK Platform: Web

Request type: 线上报错

Request Description: 多人视频聊天场景, web端和安卓端都是用了相同的appID, 证书也都获取到了token, web端和web端可以视频聊天, 安卓端和安卓端也可以正常视频聊天
但是web端的"user-published"可以监听到web端的上线信息, 但是无法监听到安卓端的上线信息是为什么? 我的电话15623522002

回答思维链：这是一个web 和native 互通的问题，web端无法监听到安卓上线，怀疑是安卓端没有加入频道成功，需要先收集频道相关信息分析

Reply:  您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](~https://doc.shengwang.cn/faq/integration-issues/set-log-file~)

---

# ID: 35990

SDK Product: RTC

SDK Version: 4.2.0

SDK Platform: IOS

Request type: 商务问题

Request Description: 已经重新绑定付款信用卡，麻烦安排重新扣款，谢谢，我这边还需要重置邮箱和手机号，谢谢，之前绑定邮箱和手机号已经无法使用。

回答思维链：这是一个和账号相关的商务问题，无法回答，可以用话术让用户稍作等待，让人工工程师来解决。

Reply:  您好，已收到您的工单，人工工程师马上就会为您解答，请稍等

---

# ID: 35989

SDK Product: RTC

SDK Version: 4.2.0

SDK Platform: Android

Request type: 线上报错

Request Description: 两个主播连麦，看不到双方画面并提示连麦回调失败，请断开连麦后重新连接！

回答思维链：1、需要和客户确认采用那种连麦方式，如果是跨频道mediarelay方式需要确认是否开通服务权限2、需要和客户确认UI侧提示连麦回调失败 是根据声网那个回调实现的；3、需要和客户收集频道号、时间点查看频道内的数据情况

Reply:  您好，需要您这边确认以下几点：

1、使用那种连麦方式，多频道方式还是跨频道mediarelay方式，如果是后者，需要提供下项目appid我们查下是否开通服务；

2、UI侧提示连麦回调失败 是根据声音那个回调实现的？

3、您这边也可以提供下出现问题的声网频道号，问题时间点以及声网的[sdk日志]([https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file))

---

# ID: 35975

SDK Product: RTM

SDK Version: 2.2.2

SDK Platform: Flutter

Request type: 集成问题咨询

Request Description: 怎么单对单发送图片消息。

回答思维链：客户用的是 RTM，现在需要发送图片消息，但是 RTM 本身不支持传输图片消息，客户有需要的话可以建议他用环信 IM 这类即时聊天 SDK 来实现更好。

Reply:  您好，RTM 是信令 SDK，不支持直接传输图片，有图片传输需求的话可以考虑[环信 IM](https://www.easemob.com/)

---

# ID: 35950

SDK Product: RTSA

SDK Version: 1.9.5

SDK Platform: Linux-C

Request type: 线上报错

Request Description: 当设备有双网卡时 会偶现不停地断线重连断线重连持续好多遍 单4G 或 单WIFI 不会出问题

回答思维链：根据客户的描述，sdk重连和设备多网卡有必然联系；比较怀疑是sdk在适配这种特殊的双网卡设备有兼容性问题，需要拿到sdk日志进一步确认
Reply:  您好，建议您先确认下设备在双网卡下对外网络连接是否正常，如果确认没有问题，需要您这边提供以下信息进一步排查定位：
1. 声网项目APPID、频道号(cname)：
   2.问题时间点:
   3.需要您拿下rtsa sdk的日志，在初始化的时候可以配置日志等级和路径。

---

# ID: 35935

SDK Product: RTC

SDK Version: 4.3.0

SDK Platform: Android

Request type: 效果不佳、不达预期

Request Description: 双人连麦，编码配置：720p，1600kbps，20fps。 室内连麦直播时，帧率正常可达到20fps。跑到室外后，帧率掉到7fps。码率能保持在1600kbps。
这情况下因为帧率太低能明显感觉到画面一卡一卡的。这情况怎么优化？
环境变差时sdk内部是优先确保码率的吗？有没有其他配置可以动态调优

回答思维链：1、通过客户描述看视频编码帧率下降大概率是因为网络变差导致的，需要和客户收集频道号、时间点、uid 等信息进一步确认 2、sdk内部编码降级偏好是通过setVideoEncoderConfiguration方法可以配置的

Reply:  1、您好，看您的描述视频帧率下降可能是因为室外网络变差导致的，麻烦您这边提供以下信息我们排查下：
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [如何设置日志文件？](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   2、我们是有api 是调整sdk 编码降级偏好的，调用[setVideoEncoderConfiguration](https://doc.shengwang.cn/api-ref/rtc/android/API/class_videoencoderconfiguration)
   

---

# ID: 35931

SDK Product: RTC

SDK Version: 当前版本

SDK Platform: restful

Request type: 集成问题咨询

Request Description: 通话过程中调用接口禁止用户推流后，用户依然在进行视频推流。
调用 kickingRule 接口请求 id bffdce7fc07a431cba08789f5de6e145

回答思维链：客户调用了封禁接口，也得到了请求成功后的规则 id，通常来说表示调用成功了，封禁应该是生效的。但不清楚具体现象是什么，封禁只会影响远端观看，本端预览是继续工作的，可以先找客户确认下现象，以及要个完整请求内容看看

Reply:  您好，看起来接口调用是成功的，请问实际频道内远端可以看到来自被封禁用户的画面吗？封禁不会停止用户本地的采集状态，只影响线上观看，您这边可以先确认下现象，然后提供下原始请求内容，放在 txt 里用附件发到工单

---

# ID: 35927

SDK Product: RTC

SDK Version: 4.5.1

SDK Platform: Android

Request type: 效果不佳、不达预期

Request Description: 1、使用场景：调用加入频道方法joinChannel，并 监听onConnectionStateChanged及onJoinChannelSuccess回调，如果onJoinChannelSuccess触发认为加入成功，显示画面；若onConnectionStateChanged触发且state == 5，则退出该次录制，并提示错误原因；

2、问题表现：客户使用华为P30准备录制，页面一直黑屏，未退出无任何提示；

3、备注：我们本地使用安卓10及更老的设备都未复现该问题，线上客户100%复现该情况，通过后端日志，确实可以推断出用户尝试了几十次；

回答思维链：该问题是个视频不可见，需要和客户收集频道号、时间点查看频道内的数据情况，看下视频采集为啥失败了

Reply:  您好，视频黑屏的可能因素有很多，比如摄像头异常，摄像头被占用等；这边需要您提供下以下信息，我们进一步排查下：
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [如何获取 SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# ID: 35908

SDK Product: RTC

SDK Version: 4.4.1

SDK Platform: Android

Request type: 集成问题咨询

Request Description: 1、请问下你们rtm登录的时候这里的图1中的RtmConfig.Builder是属于用户的唯一标识符吗？如果其他用户与其交互是不是就是这个值
2、图2中是rtc加入频道的方式，本地端A和远程端B，都是调用这个方法mRtcEngine?.joinChannel加入频道对吧，那这里的uid和问题1中的是同一个吗？因为joinChannel中的uid是int类型，而问题一的是 String类型如果写0的话会不会不调用onJoinChannelSuccess回调方法
3、问题三：因为你们RtmConfig.Builder是支持string类型的唯一标识符，而rtc的mRtcEngine?.joinChannel中的uid是int类型，他们两个是同一个东西吗？

回答思维链：客户工单提交的产品类型是 RTC，但是问到了 RTM 的问题，推测是两个 SDK 都有集成但是不太清楚两个 SDK 的区别。问题一需要和客户解释下 RTM 里的唯一标识符是 userid。问题二有问到 RTC 的 uid 是否和成功加入频道触发 onjoinchannelsuccess 相关，可以和客户解释下 joinchannel 应该用 int uid，joinchannelwithaccount才能用 string uid，以及应该推荐客户使用 int uid 的方法去加频道，这样 SDK 优化更好。问题三可以和客户解释并强调下 RTC 和 RTM 是两套独立的 SDK，彼此互不相通。

Reply:  1、是的，userid 是不重复的唯一标识符

2、是的，RTC 用 joinChannel 来加入频道，RTC 的 uid 和 RTM 的 userid 不是同一个东西。RTC 加频道推荐用 joinchannel 方法，传 int uid 来加入频道，还有joinchannelwithaccount 方法是用 string uid 的，我们更推荐用 int 类型的方式，这样 SDK 优化更好

3、不是一个东西，不互通

---

# ID: 35900

SDK Product: RTC

SDK Version: 4.23.2

SDK Platform: Web

Request type: 线上报错

Request Description: 本地服务端录制，token过期后不会自动续期，而是报错onError channelId:test error:ERR_TOKEN_EXPIRED message:

回答思维链：客户的工单分类选择了 RTC Web，但是问的问题是本地服务端录制的 token 问题，可能是分类选错了，应该专注在客户的实际提问上。本地服务端录制是有 renew 方法来传入新 token 的，客户有提到“token过期后不会自动续期”，可能是没有用到 renew 方法，也可能没有理解 token 过期以后要重新生成一个来传入的逻辑，可以和客户解释一下 renew 的常规流程和原理。

Reply:  您好，本地服务端录制 SDK 是自带一个 renewtoken 方法的，可以在收到 token 即将过期的回调时先在自己业务服务器上生成一个新的可用 token，然后用 renew 方法传入这个新的 token，这样录制端被分配的 uid 就可以用新的 token 继续待在频道里了，token 是不会自己续期的。

---

# ID: 35897

SDK Product: convoai

SDK Version: 当前版本

SDK Platform: restful

Request type: 集成问题咨询

Request Description: 智能体加入频道失败
{
"agent_id": "A42AV45RD89DJ78LK99VN94PV47FY24T",
"message": "agent exits with reason: RTC connection failed",
"start_ts": 1751102804,
"status": "STOPPED",
"stop_ts": 1751102804
}

回答思维链：加入频道失败的原因大多数是和token有关，比如token无效、过期等，可以先引导客户校验token；客户请求正常返回了agent_id，后续可以依据id去查看后台日志定位具体原因。

Reply:  您好，加入频道频道失败通常是和token有关，比如token无效、过期等；您这边可以登录console—>控制台—>辅助工具—>token生成/校验，先校验下token。

---

# ID: 35864

SDK Product: RTC

SDK Version: 4.5.2

SDK Platform: IOS

Request type: 集成问题咨询

Request Description: 我想在iOS中实现 关闭视频或摄像头后 显示头像或一张本地的图片 并且远端的用户看到的也是这张图片

回答思维链：客户需要在实现本端设备发流状态改变以后修改远端用户的 UI 显示改用自定义图片，这个需求需要能够感知远端用户的发流情况来做对应处理，可以让客户监听我们 SDK 的remoteVideoStateChangedOfUid 来感知远端设备的发流情况，然后在感知到远端不发流的时候自定义图片展示

Reply:  您好，可以监听 [remoteVideoStateChangedOfUid](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_basic#callback_irtcengineeventhandler_onremotevideostatechanged)，在远端不发流的时候前端上写个业务来展示指定图片。

---

# ID: 35862

SDK Product: RTC

SDK Version: 4.5.2

SDK Platform: IOS

Request type: 集成问题咨询

Request Description: 我想在iOS中实现多个视图显示本地视频预览,但是一直无法实现.
附件为我在Xcode中的代码.

回答思维链：看客户描述应该是想把本地画面渲染多次，这是需要在canvas 里配置setupMode  为 AgoraVideoViewSetupAdd 才能实现的，否则无法达到效果，可以让客户检查下有没有实现相关操作

Reply:  您好，请问是想把本地画面渲染多次吗？如果是的，需要在对应的 canvas 配置里设置 setupMode  为 AgoraVideoViewSetupAdd
参考文档：[setupLocalVideo](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_rendering#setupLocalVideo:)

---

# ID: 35850

SDK Product: Cloud-recording

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询

Request Description: 使用安卓端SDK，在安卓app发起云录制请求。请求资源接口可以正常返回，但请求开始录制接口返回错误
请求录制资源接口返回：

{"cname":"aac","uid":"9527","resourceId”:"xxx"}

【请求开始录制】

返回：
httpcode ：400

{code=2, reason='request_hash mismatch!'}

回答思维链：这是一个云录制的问题，客户在 acquire 的时候应该添加了 startParameter 字段，如果在acquire 环节添加了，后续再调用 start 的时候，body 内容和startParameter 不一致就会报错request_hash mismatch! 不推荐客户这样操作，可以推荐客户减少acquire 填写的内容，把具体的 start 配置放在 start 请求 body 里去实现

Reply:  您好，request_hash mismatch! 的打印是 acquire 的 startParameter 和后续的 start 内容不同导致的，建议您不要在 acquire 里填写太多内容，可以参考我们文档右侧的示例请求，用最少的内容 acquire ，然后在 start 的 body 里详细填写具体配置

---

# ID: 35849

SDK Product: Cloud-recording

SDK Version: 当前版本

SDK Platform: Restful

Request type: 效果不佳、不达预期

Request Description: 1对1的视频通话进行正常，录制也正常完成，没有出现错误。
但录制视频存放至阿里云OSS后发现，只有.ts文件和.m3u8文件存储了，mp4文件没有按要求生成。

这个现象在之前的视频通话也发生过一次。但其他视频通话都正常。烦请帮忙查看一下没有生成mp4文件的原因。

回答思维链：这看起来是一个云录制的线上问题，云录制的 ts 切片和 m3u8 都是实时上传 OSS 的。如果客户在 start 的时候指定了转码，那就会在 24 时内由声网侧转码 mp4 文件再上传 OSS。客户说 ts 和 m3u8 都收到了，说明预留的 OSS 信息应该没问题，上传链路是通畅的，但至于为什么没有 mp4，可能是转码还没有完成（可以让客户再等等，最晚不会超过 24 小时），也可能是 mp4 文件的上传有些问题（需要找客户提供下具体的录制 sid，来让相关同事调查后台日志看看具体原因）

Reply:  您好，mp4 一般是 24 小时内完成转码再上传的，您可以先等 24 小时，如果还是没有的话，可以提供下具体的 sid，我们看下后台记录

---

# ID: 35787

SDK Product: RTC

SDK Version: 4.20.0

SDK Platform: Web

Request type: 效果不佳、不达预期

Request Description: android端角色是"讲师" ,web端是学员,学员端存在卡顿情况,3月下旬时web端是流畅的,今天看过web端存在卡顿,效果请看视频

回答思维链：客户应该是提供了现象视频并且咨询了一个线上问题，这类问题目前需要人工工程师来接管，可以先收集下客户的问题现象和出现问题的设备日志，推进下问题排查进展

Reply:  您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [如何获取 SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   另外也麻烦您看下本身设备侧采集是否正常，比如使用其他语聊类app（微信）通话是否正常；或者使用自带的录音机录制看下是否正常

---

# ID: 35780

SDK Product: RTC

SDK Version: 4.2.2

SDK Platform: Android

Request type: 线上报错

Request Description: 建立连接无法进行通话

回答思维链：看客户问题描述是无法通话，可能是线上无法加入频道，也可能是只有一方加入了频道，现在缺少的信息太多，无法直接分析出问题所在，可以先收集下客户的网络情况和出现问题的设备日志，推进下问题排查进展

Reply:  您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [如何获取 SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   另外也麻烦您看下本身设备侧采集是否正常，比如使用其他语聊类app（微信）通话是否正常；或者使用自带的录音机录制看下是否正常

---

# ID: 35774

SDK Product: RTC

SDK Version: 4.20.0

SDK Platform: Android

Request type: 集成问题咨询

Request Description: 集成问题咨询，尽快联系13752561012

回答思维链：客户想要语音咨询问题，但没有文字说明具体要讨论什么，可以先让客户文字描述下自己的问题，让稍后的电话沟通更高效一些

Reply:  您好，您可以先把问题在工单里描述下，这样稍后的电话沟通更有重点

---

# ID: 35773

SDK Product: RTC

SDK Version: 4.5.2

SDK Platform: IOS

Request type: 集成问题咨询

Request Description:  问题平台：iOS
问题项目：官网demo OC版本 [https://github.com/AgoraIO/API-Examples](https://github.com/AgoraIO/API-Examples)
问题版本：4.5.2

因为工程项目原来版本是3.7.0，
现在需要升级到4.5.2。

在官网下载了demo，并且跑通了demo，demo的SDK版本是4.5.2。
音视频功能正常。
但是屏幕共享有点问题，开启屏幕共享后，直播弹窗出现了其他app，
并且我在自己的项目中3.7.0的SDK版本没有这个问题，升级到4.5.2的SDK也有这个问题
麻烦帮忙看看是什么原因。

回答思维链：这是一个 4.x Demo 的已知问题，Demo 没有写好。可以引导客户在 xocde 的 info-Target Properties-Bundle display name 里传屏幕分享的Bundle Id 就可以了

Reply:  您好，在 xocde 的 info-Target Properties-Bundle display name 里传屏幕分享的Bundle Id 就可以了

---

# ID: 35770

SDK Product: RTC

SDK Version: 4.4.0

SDK Platform: IOS

Request type: 集成问题咨询

Request Description: 您好 我们这用的环信的uikit做了一个IM系统，然后现在要集成RTC，发现生成rtc token的时候总是报错，现在我们没有太多时间找代码的问题，能否给一个配上环信和声网的就能跑的demo 单聊 群聊 音视频通话 就这几个功能 谢谢

回答思维链：客户需要知道如何生成 RTC 的 token 来加入频道，直接推荐客户 clone 我们的 token 示例代码仓库本地运行去生成就可以了

Reply:  您好，clone 这个仓库下来，用示例代码去生成 token 即可
[生成 Token](https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication#token-code)

---

# ID: 35769

SDK Product: RTC

SDK Version: 4.21.0

SDK Platform: Web

Request type: 集成问题咨询

Request Description: 你好，集成了屏幕共享功能，如何停止屏幕共享，使用ScreenSharingClient.leave()方法虽然频道中看不到屏幕共享，但是本地的屏幕共享流依然存在（就是截图中的提示框依然在），请教一下该如何停止呢。

回答思维链：客户反馈的现象是调用leave()后屏幕共享依旧没有停止，应该是屏幕共享的 track 被创建以后没有释放导致的，可以让客户释放对应的 track 来解决

Reply:  您好，可以尝试下调用对应 track 的 [close](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/ilocaltrack#close) 方法去释放来解决这个问题。

---

# ID: 35768

SDK Product: RTC

SDK Version: 4.5.1

SDK Platform: Android

Request type: 线上报错

Request Description: 1. 问题表现： Android端的用户和web的客服建立双向视频后，Android端看不见web端客服的视频，只能看到自己。 Web端可以看到自己 也可以看到用户
2. 线上出现概率为1% - 2%
3. 经过开发代码排查，定位原因是 Android端AgoraSdk的 onUserJoined 方法没有被调用，导致自定义videoview无法显示出来

override fun onUserJoined(uid: Int, elapsed: Int)

{ Log.i("AgoraManager", "CS-UserJoined uid = $uid") *levelLiveData.postValue(false)* uidJoinLiveData.postValue(uid) }

回答思维链：onUserJoined回调被触发是有条件的，比如远端用户是否是主播身份，需要先提供相关频道和uid信息来佐证

Reply:  您好，[onUserJoined](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_channel#callback_irtcengineeventhandler_onuserjoined) 回调在如下情况下被触发：
远端用户/主播加入频道。
远端用户加入频道后将用户角色改变为主播。
远端用户/主播网络中断后重新加入频道。

需要您这边提供下频道号，时间点，以及uid，我们查下远端用户是否是主播身份

---

# ID: 35760

SDK Product: RTC

SDK Version: 4.2.1

SDK Platform: Android

Request type: 效果不佳、不达预期

Request Description: pc 端用obs 临时token 推流
app 端 调用获取房间列表的接口为啥显示不出来？
尝试更换了 [https://service-staging.agora.io](https://service-staging.agora.io/ "Follow link") 这个域名也是拿不到
接口参数如下

回答思维链：客户提交的 SDK Platform 写的是Android，但是问题描述提到的是PC用OBS，需要和客户再确认下现在在用哪个产品，以及用的是什么方式来加入频道的

Reply:  请问现在 PC 是如何实现推流的？是用的 OBS 插件还是 [RTMP网关](https://doc.shengwang.cn/doc/rtmp-gateway/restful/landing-page) 服务？

---

# ID: 35759

SDK Product: RTC

SDK Version: 4.5.2

SDK Platform: IOS

Request type: 效果不佳、不达预期

Request Description: 2个手机进入同一个频道，但是画面很暗，基本看不清对面的画面

回答思维链：这个现象应该不是必现的，推测和客户的设备或者集成有关，可以先让客户运行我们的Demo看下是否能复现，来排查到底是SDK问题还是客户自己的设备问题

Reply:  您好，可以用我们 [api-example](https://github.com/AgoraIO/API-Examples/tree/main) 尝试复现下。
一般不会有这个问题，可以确认下摄像头本身是否正常工作

---

# ID: 35758

SDK Product: RTC

SDK Version: 4.5.2

SDK Platform: Android

Request type: 集成问题咨询

Request Description: Android sdk中，设置音频编码格式为g711后，能否设置采样率为8k和16k，需要用哪个接口呢？

engine.setParameters("

{\"che.audio.custom_payload_type\":8}

");

回答思维链：客户调用了私参接口来让android设备发送G711音频编码，但是G711编码只有8K采样率，无法切换到16K，G722才是16K的，所以这个需求无法实现

Reply:  您好，G711 只有 8k 采样率，G722 才是 16k，没有办法指定 G711 用 16k 的

---

# ID: 35757

SDK Product: RTC

SDK Version: 4.5.2

SDK Platform: Android

Request type: 集成问题咨询

Request Description: Android sdk 纯音频通话，如何设置音频编码格式，比如设置为g711或者g729。如果不能选择编码格式，几种场景采用的编码格式分别是什么呢？

回答思维链：客户需要让 Android 端发送 G711 或者 G722 的音频编码，一般这类需求是和 IOT 设备互通才有的，可以给客户提供下相关文档，在 join 前调用私参接口传入私参来改变编码配置

Reply:  您好，需要在 join 之前调用私参接口来改变编码格式，参考：[设置 RTC Native/第三方框架 SDK（v4.x）x](https://doc.shengwang.cn/doc/rtsa/c/best-practices/interoperate-rtc#%E8%AE%BE%E7%BD%AE-rtc-native%E7%AC%AC%E4%B8%89%E6%96%B9%E6%A1%86%E6%9E%B6-sdkv4x)

---

# ID: 35750

SDK Product: RTC

SDK Version: 当前版本

SDK Platform: Restful

Request type: 效果不佳、不达预期

Request Description: 疑似未收到声网推送的主播离开频道事件。
需要协助排查该频道主播离开频道时的事件推送日志。

回答思维链：客户反馈没有收到主播离开频道的事件，但没有说明是服务端的Webhook NCS 事件还是客户端的回调，可以先和客户确认下这个细节来推进问题调查

Reply:  您好，请问没收到的是客户端回调还是服务端 NCS 事件？

客户端的话可以提供下[SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

NCS 事件的话可以先去声网 console 上检查下回调地址是否有配置，以及健康检查是否通过

---

# ID: 35745

SDK Product: RTC

SDK Version: 4.5.2

SDK Platform: Unity

Request type: 集成问题咨询

Request Description: 你好，我们的应用场景是unity开发的手段app与ai设备的实时语音通话，ai设备cpu架构是orinagx(英伟达 orin aarch64) 系统是ubuntu20.04 我在技术支持文件中没有找到该平台对应的sdk 改如何获取或者说支持该平台吗

回答思维链：客户的场景是在Unity下用app和Ubuntu设备在 RTC 频道里互通，声网有Unity的SDK，也有Ubuntu的服务端或物联网设备SDK，但客户现在没有找到，我们应该提供对应的文档地址给客户

Reply:  您好，我们有服务端SDK支持arm的：[https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/resources](https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/resources)

还有 RTSA SDK，专门给一些 IOT 设备使用，里面有支持 aarch64 的，可以试下：[https://doc.shengwang.cn/doc/rtsa/c/resources](https://doc.shengwang.cn/doc/rtsa/c/resources)

---

# ID: 35740

SDK Product: RTC

SDK Version: 4.5.0

SDK Platform: Android

Request type: 效果不佳、不达预期

Request Description: 当前版本4.5.0，2个移动端设备，互相呼叫，通过服务器生成同样的 token 和 channelName，调用 joinChannel 后，均回调了onJoinChannelSuccess，但是没有回调 onUserJoined，这是为什么？
用旧的版本 3.2.0 能回调 onUserJoined。业务依赖 onUserJoined 来判断远端用户是否加入成功，加入了则认为通话建立成功，若没回调，则一直处于拨号中的状态。

回答思维链：客户反馈用相同的 token 加入相同的频道以后都触发了onJoinChannelSuccess 但是没有 onUserJoined ，需要和客户确认下是否出现了用相同 token 和 uid 来加入频道导致互踢的情况，以及也要和客户确认下加入频道时双方的身份都是否为主播，onUserJoined 只有在远端是主播身份加入的时候才会触发。

Reply:  您好，

1、onUserJoined只会在远端以主播身份加入的时候才触发，如果身份是观众就不触发了

2、如果用的是相同的 token，需要确认下 uid 是否相同，token 是和 uid 、频道名绑定的，但是 uid 在频道内不能重复，所以理论上不同 uid 的 token 应该不同，请确认下是否用了相同的 uid 加频道，导致了互踢

---

# ID: 35721

SDK Product: RTC

SDK Version: 4.21.0

SDK Platform: Web

Request type: 集成问题

Request Description: 之前集成了实时共享RTC，加入频道也能正常共享视频，现在想在共享视频时，再共享屏幕，视频共享成功后调用了方法AgoraRTC.createScreenVideoTrack创建屏幕共享，然后在创建成功后调用rtc.Client.publish([localScreenTrack])，但是控制台报错AgoraRTCError CAN_NOT_PUBLISH_MULTIPLE_VIDEO_TRACKS；不知道什么原因，请教一下该如何处理。

回答思维链：报错写的是AgoraRTCError CAN_NOT_PUBLISH_MULTIPLE_VIDEO_TRACKS，这表示不能发送对路视频流。SDK 一个 uid 只能发送一路视频流，推测客户是用一个 uid 既发送屏幕共享流又发送摄像头流导致的。 

Reply:  您好，一个 uid 只能发一路视频流，要发两路流就需要再创建一个 client，然后用不同的 uid 加入频道，指定发屏幕共享流。

---

# ID: 35703

SDK Product: cloud-recording

SDK Version: 当前版本

SDK Platform: restful

Request type: 线上报错

Request Description: 请求参数
{"uid":"16555","cname":"h87sgcmwgp","clientRequest":{"recordingFileConfig":

{"avFileType":["hls","mp4"]}
,"storageConfig":

{"bucket”:"xxxx","secretKey":"xxxx","accessKey”:"xxxx","vendor":2,"region":6,"fileNamePrefix":["testVideo","20250612114229237"]}
,"recordingConfig":{"channelType":1,"transcodingConfig":{"layoutConfig":[

{"uid":"2366523894","y_axis":0,"x_axis":0,"render_mode":1,"width":1,"height":1}
],"mixedVideoLayout":3,"width":1920,"fps":50,"bitrate":5000,"height":1080}}}}

报错

{"code":2,"reason":"services not selected!"}

回答思维链：云录制启动参数报错，有比较明确的报错信息；查询云录制接口请求响应状态码和错误码，是传参有问题导致的

Reply:  您好，云录制启动报错，官网侧是有文档详细说明文档的，参考如下：
[https://doc.shengwang.cn/doc/cloud-recording/restful/response-code](https://doc.shengwang.cn/doc/cloud-recording/restful/response-code)

根据你这个错误码，比较怀疑是启动时传入的参数不合法导致的，请严格参照我们的云录制启动文档进行传参。

---

# ID: 35702

SDK Product: RTM

SDK Version: 其他版本

SDK Platform: Java

Request type: 线上报错

Request Description: 我们公司的声网SDK，是声网之前给我们的内测版本。
平台：Android
今天上午发现大面积报错：Agora RTM join topic failed by join ret: -10001。无法加入RTM频道，RTC也不可用。相关错误码查不到，请教一下如何解决。

回答思维链：客户有提到用的是以前的内测版本，可能是个老版本了，应该推荐客户用现在最新的 RTM 2.x 来上线使用。

-10001 的错误码是有文档可以查看的，这表示没有初始化，可以让客户自查一下相关业务并且提供错误码文档给他。

Reply:  您好，内测版本不推荐上线使用，建议集成我们2.x 最新的对外版本：[https://doc.shengwang.cn/doc/rtm2/android/landing-page](https://doc.shengwang.cn/doc/rtm2/android/landing-page)

10001 是没有初始化的报错，可以先检查下相关业务：[https://doc.shengwang.cn/doc/rtm2/android/error-codes#%E9%94%99%E8%AF%AF%E7%A0%81%E5%AF%B9%E7%85%A7%E8%A1%A8](https://doc.shengwang.cn/doc/rtm2/android/error-codes#%E9%94%99%E8%AF%AF%E7%A0%81%E5%AF%B9%E7%85%A7%E8%A1%A8)

---

# ID: 35675

SDK Product: RTC

SDK Version: 当前版本

SDK Platform: restful

Request type: 集成问题咨询

Request Description: hook回调地址配置报错:

NCS 健康检查
NCS 健康检查结果: Test Failed

{ "success": false, "httpCode": 502, "error": "Post "[https://imapi.irecircle.com/im-user/imRtcMeeting/hook\](https://imapi.irecircle.com/im-user/imRtcMeeting/hook%5C)": x509: certificate signed by unknown authority", "response": "" }

回答思维链：NCS健康检查报错，通常都是和客户的回调地址域名不通、https证书错误、请求超时导致的；需要客户侧自查

Reply:  您好，webhook回调地址报错通常和咱们的配置的回调地址域名不通、https证书错误、请求超时等原因导致的，建议咱们先自查下，参考文档如下：
[https://doc.shengwang.cn/doc/rtc/restful/webhook/receive_webhook](https://doc.shengwang.cn/doc/rtc/restful/webhook/receive_webhook)

---

# ID: 35641

SDK Product: RTSA

SDK Version: 1.9.5

SDK Platform: Linux-C

Request type: 集成问题咨询

Request Description: 你好，附件是我们的项目需求信息，请帮忙看下能否释放一下sigmastar 平台的RTSA SDK

回答思维链：这是一个RTSA相关问题，客户提到了sigmastar平台，应该是想确认我们的RTSA SDK 有没有适配此平台的版本，需查看官网的文档确认

Reply:  您好，您这边可以参考官网RTSA 平台兼容文档以及下载文档来选择，如果没有支持咱们平台的版本，请联系 [sales@shengwang.cn](mailto:sales@shengwang.cn)
[https://doc.shengwang.cn/doc/rtsa/c/overview/product-overview](https://doc.shengwang.cn/doc/rtsa/c/overview/product-overview)
[https://doc.shengwang.cn/doc/rtsa/c/resources](https://doc.shengwang.cn/doc/rtsa/c/resources)

---

# ID: 35640

SDK Product: RTC

SDK Version: 4.2.0

SDK Platform: Android

Request type: 集成问题咨询

Request Description: 实时RTC直播点击加入报110code

回答思维链：加入频道报错110，可以查官网的错误码即可

Reply:  您好，加入频道报错110：Token 无效。一般有以下原因：

在声网控制台中启用了 App 证书，但未使用 App ID + Token 鉴权。当项目启用了 App 证书，就必须使用 Token 鉴权。
生成 Token 时填入的 uid 字段，和用户加入频道时填入的 uid 不一致。

您这边可以检查下

[https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_rendering#setupLocalVideo:](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_rendering#setupLocalVideo:)

---

# ID: 35638

SDK Product: RTC

SDK Version: 4.5.2

SDK Platform: Android

Request type: 其他问题

Request Description: 1.加载两个远端视频流，在进行视图切换的时候出现黑色不显示视频流的情况，请问是什么原因？怎么排查？
2.附件中有具体的操作视频和部分代码截图

回答思维链：这是一个视频黑屏不可用问题，可以先让客户提供下频道号，问题时间点，以及是那个uid看不到那个uid的视频画面，看下对应用户的视频相关参数有没有异常；之后再拿sdk日志排查定位

Reply:  您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   另外也麻烦您看下本身设备侧采集是否正常，比如使用其他语聊类app（微信）通话是否正常；或者使用自带的录音机录制看下是否正常

---

# ID: 35637

SDK Product: CDN

SDK Version: 当前版本

SDK Platform: CDN

Request type: 其他问题

Request Description: 尽快更新证书啊

回答思维链：客户咨询CDN证书更新相关问题，console上的证书更新是需要一定时间更新同步的；

Reply:  您好，CDN相关的证书更新是需要时间的同步的，通常需要2周左右，您这边再耐心等待下；

---

# ID: 35634

SDK Product: RTC

SDK Version: 4.2.6

SDK Platform: Android

Request type: 开通权限、提高配额、上量报备

Request Description: 帮我开通一下 跨频道流媒体转发功能

回答思维链：跨频道连麦功能需要提供appid ，后台开通

Reply:  您好，麻烦提供下项目的appid，技术支持工程师在看到消息后会及时地给您开通，请耐心等待回复，感谢您的理解与配合，谢谢。

---

# ID: 35633

SDK Product: RTC

SDK Version: 其他版本

SDK Platform: Android

Request type: 其他问题

Request Description: 视频无法呼出，或者接听视频之后几分钟之后就自动断开
用户ID：20513
用户ID：86042

回答思维链：客户问了2个问题，问题1是视频无法呼出，主要是和信令连通有关；问题2是接通视频成功后断开，需要提供对应时间点的频道号，uid信息看下断开原因

Reply:  您好，视频无法呼出，主要是和呼叫邀请信令有关，需要您这边查下信令登录、发送、接收是否正常；
自动断开可能是业务侧异常调用leave接口退出频道，也可能是app闪退或者是设备网络异常导致的断开。

---

# ID: 35630

SDK Product: RTC

SDK Version: 其他版本

SDK Platform: Android

Request type: 线上报错

Request Description: android设备与pc端进行实时语音出现无法听到android端的声音，通过抓包看到如下信息：
Allocate Error Response error-code: 401 (Unauthenticated) Unauthorized with nonce realm: agoraio
214 Allocate

回答思维链：对于声音听不见问题，优先让客户提供频道号，时间点，以及那个uid听不到那个uid的声音；也有可能和客户侧的网络环境有关，比如设备不能直接公网等

Reply:  您好，对于声音听不见的问题，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

也有可能和设备的网络环境有关，比如不能直连公网等

---

# ID: 35629

SDK Product: RTC

SDK Version: 4.4.1

SDK Platform: Android

Request type: 效果不佳、不达预期

Request Description: 目前采用的是RTC极速模式、观众端看到的视频画质不很好、并且视频比较模糊、外置摄像头不能聚集

回答思维链：这是个视频体验类问题，视频模糊首先怀疑是指客户端网络问题，比如丢包、带宽不足等；也有可能是主播端的视频采集帧率低等，需要客户提供频道、uid等关键信息排查定位

Reply:  您好，视频画质不好通常是和客户端网络较差有关，比如丢包、带宽不足等；也有可能是主播端的视频采集帧率低等；麻烦您按以下模版整理问题，我们查下频道内传输情况；
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# ID: 35626

SDK Product: RTC

SDK Version: 其他版本

SDK Platform: Android

Request type: 商务问题

Request Description: 我们已经在6月1日购买了 实时互动尊享版，一共2388元，为何月账单还会扣除我们1024.57元，导致我们现在账户上还欠费-429.67，什么情况这是？

回答思维链：商务问题需要客户找到商务同事处理，或者拨打 400 6326626 电话
Reply:  您好，商务计费相关问题，麻烦联系对应商务同事处理，或者您这边可以拨打400 6326626 电话联系处理，感谢您的理解与配合，谢谢。

---

# ID: 35580

SDK Product: RTC

SDK Version: 4.5.2

SDK Platform: Android

Request type: 崩溃（闪退、卡死）

Request Description: 接收端是Linux系统，发端是安卓手机，型号是Vivo Z5x，安卓版本10，第二次发起后，Linux端会崩溃。
然后换另一台安卓手机，型号是荣耀X50，安卓版本15，多次发起，Linux 端不会崩溃。

回答思维链：客户咨询了一个崩溃问题，无法直接分析问题所在，应该先找客户收集崩溃堆栈、双方崩溃时的 SDK 日志信息，方便后续人工工程师调查。

Reply:  您好，可以先参考下这篇文档收集崩溃时的堆栈和双方 SDK 日志，稍后人工工程师会解析崩溃查看具体堆栈在哪里了。

[https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# ID: 35517

SDK Product: RTSA

SDK Version: 1.9.5

SDK Platform: Linux-C

Request type: 崩溃（闪退、卡死）

Request Description: 使用文件名为 Agora-RTSALite-RmRdRcAcAjCF-riscv-linux-gnu-1040-v821-v1.9.5-20250527_160103-718970 的SDK报错
报错截图和sdk自动生成的coredump都在附件内

ai分析说是动态库包含了一个特殊的 xandes5p0 扩展指令集导致的 供参考

回答思维链：这是一个 SDK 崩溃问题，目前无法直接解答，可以让客户提供崩溃堆栈和对应的 SDK 日志，等候人工工程师解答。

Reply:  您好，崩溃问题可以提供下崩溃时的原始堆栈+SDK 日志，人工工程师稍后为您解答

如果不清楚如何获取，可以参考：[https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# ID: 35465

SDK Product: ConvoAI

SDK Version: 当前版本

SDK Platform: Restful

Request type: 崩溃（闪退、卡死）

Request Description: 为什么我昨天开通的账号试用，今天额度就没有了
只用了9分钟就冻结了账号
不是有1000分钟吗？

回答思维链：这是一个账号类商务问题，可以让客户自查下有没有用到付费产品导致停机，以及可以引导客户购买预付费套餐包来解冻

Reply:  您好，人工工程师稍后给您解答，您可以先自查下是不是还用到其他不包含在免费 1w 分钟内的付费产品。如果有的话是会触发账号冻结的，需要购买预付费套餐包解冻。

---

# ID: 35444

SDK Product: Cloud-transcoder

SDK Version: 当前版本

SDK Platform: Restful

Request type: 开通权限、提高配额、上量报备

Request Description: 帮我把这个appid开通云端转码服务 7dacdca9362c47289595189fe551c5c9

回答思维链：客户需要开通云端转码服务，并且提供了 appid，可以让客户稍作等待，人工工程师稍后就会开通

Reply:  您好，已收到您的申请，稍后人工工程师会帮您开通这个服务，请稍等片刻。

---

# ID: 35420

SDK Product: Console

SDK Version: 当前版本

SDK Platform: All

Request type: 商务问题

Request Description: 想了解一下这个账号的具体计费明细 方便下午 飞书啦一个会 对一下吗

回答思维链：这是一个计量计费咨询的商务问题，可以让客户优先阅读计量计费文档以及留下商务电话供客户沟通

Reply:  您好，计费规则可以参考：[https://doc.shengwang.cn/doc/rtc/android/billing/billing-strategy](https://doc.shengwang.cn/doc/rtc/android/billing/billing-strategy)

其中的细节您可以电话沟通：400 6326626

---

# ID: 35046

SDK Product: RTM

SDK Version: 2.2.2

SDK Platform: C++

Request type: 奔溃（闪退、卡死）

Request Description: 一共有40个客户端，每个客户端连接后订阅一个rtm频道，当有20个客户端连接并成功订阅后，新的客户端连接后 订阅失败，使用官方SDK程序测试，也会订阅失败，但我无法捕捉错误，因为问题来自dll文件，需要协助排查订阅失败，引起程序闪退的原因。

回答思维链：客户遇到了 2.2.2 版本 RTM 的崩溃，可以找客户确认下崩溃时的 dump 和 SDK 日志，等待人工工程师解析崩溃。

Reply:  您好，可以先提供下崩溃的原始堆栈+SDK 日志，人工工程师稍后为您解答

[https://doc.shengwang.cn/doc/rtm2/cpp/error-codes](https://doc.shengwang.cn/doc/rtm2/cpp/error-codes)

---

# ID: 34762

SDK Product: RTC-Linux

SDK Version: 4.4.30

SDK Platform: Linux-Java

Request type:集成问题咨询

Request Description: Caused by: java.lang.UnsatisfiedLinkError: /data0/www/htdocs/code/lib/shengwang/libbinding.so: /lib64/libm.so.6: version `GLIBC_2.27' not found (required by /data0/www/htdocs/code/lib/shengwang/libagora_uap_aed.so)

centos7.5的 GLIBC是2.17 有木有对应版本的java pom 依赖

回答思维链：客户目前用的不是最新版本，可以让客户优先升级到 4.4.32 试一下，新版本里已经移除了对于这个库的依赖

Reply:  您好，可以直接用目前的最新版本，最新版本里去掉了这个库

[https://github.com/AgoraIO-Extensions/Agora-Java-Server-SDK/tree/main](https://github.com/AgoraIO-Extensions/Agora-Java-Server-SDK/tree/main)

---

# ID: 34717

SDK Product: Flexible-classroom

SDK Version: 2.9.40

SDK Platform: Web

Request type: 线上报错

Request Description: 灵动课堂api无法创建课堂，参数正确500错误
接口：[https://api.sd-rtn.com/cn/edu/apps/e1d4f3c1f7084458b62d41bc1f681711/v2/rooms/test_class](https://api.sd-rtn.com/cn/edu/apps/e1d4f3c1f7084458b62d41bc1f681711/v2/rooms/test_class "Follow link")

Array ( [msg] => Internal Server Error [code] => 500 [ts] => 1743673689138 )

500 Internal Server Error500服务器内部错误，无法完成请求。联系技术支持或管理员，检查服务器日志。

回答思维链：这是一个灵动课堂的线上报错问题，请求了启动接口得到了 500 的状态码。不过一般来说灵动课堂服务不会这么轻易的挂掉，可以先找客户要一下复现错误时的请求内容，等人工工程师看下是服务确实有问题还是用户的请求内容不正确导致了报错。

Reply:  您好，请问这个问题现在还能复现吗？如果可以的话，麻烦提供一下复现时的 CURL 完整请求，放在 txt 里用附件发来，人工工程师稍后会为您排查。

---

# ID: 34708

SDK Product: RTC-Linux

SDK Version: 4.4.30

SDK Platform: Linux-Java

Request type: 集成问题咨询

Request Description: 电话号码：18107394980

回答思维链：看起来客户留了个电话要咨询问题，可以让客户先说明下希望讨论的问题内容，方便人工工程师提高沟通效率。

Reply:  您好，请问具体是什么问题？可以先把问题列在工单里，这样稍后人工工程师给您来电沟通更有重点。

---

# ID: 34707

SDK Product: RTM

SDK Version: 2.2.2

SDK Platform: Flutter

Request type: 崩溃（闪退、卡死）

Request Description: 集成 RTC和RTM rtm初始化后崩溃，去除RTM后正常

回答思维链：看起来客户同时集成了 RTC 和 RTM，并且遇到了崩溃，可以让客户提供下崩溃时的原始堆栈+SDK 日志，以及也可以让客户先检查下有没有做过 RTC+RTM 下aosl 冲突的处理：[https://github.com/AgoraIO-Extensions/Agora-Flutter-RTM-SDK/issues/199](https://github.com/AgoraIO-Extensions/Agora-Flutter-RTM-SDK/issues/199)

Reply:  您好，可以优先检查下有没有做过 RTC+RTM 下aosl 冲突的处理，参考：[https://github.com/AgoraIO-Extensions/Agora-Flutter-RTM-SDK/issues/199](https://github.com/AgoraIO-Extensions/Agora-Flutter-RTM-SDK/issues/199)

如果做了还是崩溃，可以提供下崩溃的原始堆栈+SDK 日志，人工工程师稍后为您解答。

---

# ID: 34701

SDK Product: RTC

SDK Version: 2.6.5

SDK Platform: mini-app

Request type: 效果不佳（不达预期）

Request Description: 1、服务端查询频道内用户列表接口，接口返回的数据异常，channel_exist为false，且users数据为空，实际上有一个用户加入到频道
2、客户端进入实时语音聊天页面，访问接口获取频道内用户数据

回答思维链：客户提出了两个问题，但实际的问题是一个，就是调用查询频道内用户列表接口后没有得到预期的数据，可以让客户提供下原始请求，稍后让人工工程师调查一下具体原因。

Reply:  您好，可以抓一下原始请求放 txt 里发工单，检查下请求的频道信息和实际在看的是不是同一个。

---

# ID: 34696

SDK Product: Cloud-Recording

SDK Version: 当前版本

SDK Platform: Restful

Request type: 效果不佳、不达预期

Request Description: [https://api.sd-rtn.com/v1/apps/](https://api.sd-rtn.com/v1/apps/ "Follow link"){appid}/cloud_recording/resourceid/{resourceid}/mode/{mode}/start

调用这个录制接口成功后， 云服务器上没有录制的文件

回答思维链：这是一个云录制问题，可以让客户提供下 sid，等待稍后人工工程师查询具体上传情况。

Reply:  您好，麻烦提供下对应的 sid，人工工程师稍后看下后台记录。

---

# ID: 34650

SDK Product: RTC

SDK Version: 4.5.1

SDK Platform: Android

Request type: 集成问题咨询

Request Description: [https://doc.shengwang.cn/doc/rtc/android/overview/migration-guide#%E4%B8%AD%E6%96%AD%E6%80%A7%E5%8F%98%E6%9B%B4](https://doc.shengwang.cn/doc/rtc/android/overview/migration-guide#%E4%B8%AD%E6%96%AD%E6%80%A7%E5%8F%98%E6%9B%B4 "Follow link")

我正在从3.7版本sdk升级到4.5.1，其中有一个API被废弃，enableDeepLearningDenoise：AI 降噪将在后续版本改由 SDK 控制，不通过 API 实现，这个AI降噪具体是由哪个SDK控制呢，这个SDK相关文档是哪个呢？

回答思维链：客户是从3.x升级上来的，还不理解4.x的3A 处理是默认开启的，可以和客户解释下，并且说明AI降噪是付费项目，如果客户确定需要的话，再提供具体的api来开启。

Reply:  您好，4.x SDK 默认开启 3A 处理：[https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality#%E5%85%B3%E9%97%AD-3a](https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality#%E5%85%B3%E9%97%AD-3a)

AI 降噪是收费功能，一般来说 SDK 自带的 3A 就够用了。您可以先试下自带3A的效果，不满意的话我们再讨论下。

---

# ID: 34644

SDK Product: RTC-Linux

SDK Version: 4.4.30

SDK Platform: Linux-Java

Request type: 集成问题咨询

Request Description: 你好，我想咨询一下这个频道在10.20的时候，99999是否有加入。我现在在使用RTC服务端SDK进行拉流，然后取帧发送给算法服务，现在算法服务拿不到数据，我想确定一下我是否拿到了视频流，谢谢。

回答思维链：客户想知道指定 uid 有没有加入频道，可以引导客户在声网console的水晶球里自行查看相关信息。

Reply:  您好，这部分信息可以在声网 console左侧边栏-全部产品-水晶球里自行查看

---

# ID: 34643

SDK Product: RTC

SDK Version: 4.3.0

SDK Platform: IOS

Request type: 集成问题咨询

Request Description: (void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason

这个收到远端用户didOffline reason = AgoraUserOfflineReasonDropped，请问远端用户的声网SDK内部会重试么？还是说已经是算是离开连麦了？

回答思维链：didOfflineOfUid 是已经和声网节点断开连接的回调，reason 字段的AgoraUserOfflineReasonDropped 表示因过长时间收不到对方数据包，超时掉线，SDK 会在 20 分钟内继续尝试重新加入频道，20 分钟后如果还没有加入频道，就不会再重试了，需要手动调用 join。

Reply:  您好，SDK 因为网络连接超时而退出频道后依旧会尝试重连 20 分钟，20 分钟后还连不上的话就不会再重连了，需要手动调用 join 来加入频道

---

# ID: 34635

SDK Product: RTC-Linux

SDK Version: 2.1.0

SDK Platform: Linux-Python

Request type: 集成问题咨询

Request Description: 我们现在用声网SDK接收YUV格式的视频流，取帧后转成RGB格式，进行一定的处理，再转回YUV格式，并发送YUV格式的视频流，但是我们发现YUV和RGB互转比较慢，会影响发送视频流的帧率，请问有办法直接获取/推送RGB格式的视频流吗？或者声网有提供相关接口可以替代我们YUV和RGB的互转过程吗？

回答思维链：客户应该是需要直接推 RGB 数据发送到频道里，可以让客户在create_custom_video_track_frame里指定send_video_frame的 frame format，里面可以选择 I420、RGBA、I422等格式

Reply:  您好，create_custom_video_track_frame里可以指定send_video_frame的 frame format，里面可以选择 I420、RGBA、I422等格式

[https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/agoraservice#createcustomvideotrackframe](https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/agoraservice#createcustomvideotrackframe)

---

# ID: 34631

SDK Product: RTC

SDK Version: 4.5.1

SDK Platform: Android

Request type: 线上报错

Request Description: andorid sdk 语聊房连麦无声音

回答思维链：客户反馈了一个线上连麦无声的问题，但是没有提供频道信息，可以先找客户确认出现问题的频道号、uid、时间点，具体现象是什么，方便人工工程师后续排查。

Reply:  您好，麻烦提供频道名，说明什么时间段，哪个 uid 听不见哪个 uid。方便的话，麻烦提供下设备SDK日志过来看下：[https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# ID: 34627

SDK Product: RTC-Linux

SDK Version: 4.4.30

SDK Platform: Linux-Java

Request type: 集成问题咨询

Request Description: 你好，我想知道怎么实现AI算法服务集成这个功能，我们算法服务是在另外一个服务器上。我们现在引用的算法支持的流是rtsp、rtmp这种，我想知道我们的是什么流？我看推荐srs。

回答思维链：客户似乎想通过 RTSP 或者 RTMP 协议来获取实时的 RTC 流，但声网 RTC 流是封装过的，无法直接获取，可以推荐客户使用旁路推流功能来获取实时 RTC 频道里的画面

Reply:  您好，我们的 RTC 是自研封装的 RTC 协议，需要通过集成客户端 SDK，通过加入频道的方式才能拿到频道里的流。如果拉流打算用 RTMP 一类的协议去实现，可能需要旁路推流功能：

[https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/landing-page](https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/landing-page)

[https://doc.shengwang.cn/doc/media-push/restful/landing-page](https://doc.shengwang.cn/doc/media-push/restful/landing-page)

---

# ID: 34617

SDK Product: RTC

SDK Version: 其他版本

SDK Platform: Android

Request type: 集成问题咨询

Request Description: 视频发送端使用的android设备，sdk版本号3.3.0.设备使用了上海联通定向卡，添加了*.agora.io，.agoraio.cn，.sd-rtn.com 三个通配域名。在进入频道后，发生视频，sdk无报错。水晶球系统看，发送端正常推流。但是接收端(web，sdk版本4.11.0）无法接收到视频，水晶球显示无接收信息。
测试频道号djcs000002,可以随时复现。
需要麻烦贵司支持人员，协助解决，帮忙找出是否需要添加其他域名或ip白名单，或者其他解决方式。

回答思维链：这个客户应该使用了物联网卡设备，不过用的是 RTC Android SDK。可以先让客户检查下有没有在初始化 SDK 的时候设置 mDomainLimit 为 true，需要mDomainLimit+报备物联网卡域名才能使用的。

Reply:  您好，可以检查下 Android 端初始化的时候，有没有开启 mDomainLimit 字段的开关，要设置为 True，否则只报备域名是不够的。

[https://doc.shengwang.cn/api-ref/rtc/android/API/class_rtcengineconfig](https://doc.shengwang.cn/api-ref/rtc/android/API/class_rtcengineconfig)

---

# ID: 34600

SDK Product: RTC

SDK Version: 4.19.0

SDK Platform: Web

Request type:线上报错

Request Description: App ID: 0558654829f44526a8479352ccbceb28Salt: 577203831
Token 失效时间：2025/03/29 21:50:31 +00:00
pid:3B2D9E30A190419BB0BB611EBAAF76F3

创建频道成功了, 但是设备端一直无法加入,且会自动退出, 帮忙查看一下什么原因

回答思维链：客户虽然选择了 Web，但是问题描述里提到了 pid，可能是一个 RTSA 设备和 Web 互通的问题，所以需要找客户先要日志来看下具体的打印再分析无法加入和自动退出的原因。

Reply:  您好，如果是 RTSA 设备的话，麻烦提供出现问题的设备SDK 日志：[https://doc.shengwang.cn/api-ref/rtsa/c/agora__rtc__api_8h#agora_rtc_set_log_level()](https://doc.shengwang.cn/api-ref/rtsa/c/agora__rtc__api_8h#agora_rtc_set_log_level\(\))

加入频道失败需要看本地打印。

---

# ID: 34575

SDK Product: RTC

SDK Version: 4.19.0

SDK Platform: Web

Request type: 集成问题咨询

Request Description: 使用临时生成的token，并且调用时不使用uid可以播放，会触发user-joined事件：
const token = '007eJxTYHiiaqD0bvHyT1fbw1jf+R5yiFLND74085Ba2FG+zqSo3m0KDBaWxiZmSaaWiSZJxiZpyUaJBmap5knGKRaGqZbmJubmjT+fpDcEMjIsTjRmZmSAQBCfm6EktbgkOSMxLy81h4EBAFOCIr0=';
await agoraClient.join(appId, channel, token);
但是换成从服务端获取的token，并且调用时带上uid就不能播放了，无法触发user-joined事件，也没有报错

回答思维链：客户用临时token的时候可以加入频道发流并且监听user-joined事件，但是用自己生成的token就不行了，可以让客户检查下token和uid是否匹配，以及是否用主播身份加入频道发流了，观众是无法触发user-joined 的

Reply:  您好，临时 token 不校验 uid 所以能进频道，自己生成的 token 是要校验 uid 的，你需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道

控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验
将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致。

以及也麻烦检查下加入频道时用的 role 是不是主播，观众是无法发流的，无法发流也就无法触发user-joined 回调。

---

# ID: 34564

SDK Product: Fastboard

SDK Version: 0.3.22

SDK Platform: Web

Request type: 集成问题咨询

Request Description: 找技术咨询一下开发相关功能，选择Fastboard SDK 还是Whiteboard SDK

回答思维链：客户正在选型Fastboard 和 Whiteboard，可以推荐客户按照自己的业务场景来选择

Reply:  您好，可以参考文档，根据您的业务需求选择：

[https://doc.shengwang.cn/doc/whiteboard/javascript/fastboard-sdk/solution-compare](https://doc.shengwang.cn/doc/whiteboard/javascript/fastboard-sdk/solution-compare)

---

# ID: 34558

SDK Product: RTC

SDK Version: 4.4.1

SDK Platform: HarmonyOS

Request type: 集成问题咨询

Request Description: 我想把harmonyOS项目转换为openharmony项目，发现openharmony不支持kit，想要使用要改成ohos，但是使用到的import

{ rcp }

from '@kit.RemoteCommunicationKit';是HMS，华为的，不支持openharmony，最终实现不了

回答思维链：客户在用openharmony，但我们 SDK 没有适配过openharmony，无法保证可用性，需要建议客户避免类似操作来解决。

Reply:  您好：
1、 我们的 SDK 没有计划适配openharmony， 之前在openharmony上尝试跑过，能跑，但是功能有问题。不推荐

2、针对这个问题 应该是api level 太低导致的， openharmony 至少应该到对应HarmonyOS API 12的 api 才能跑

---

# ID: 34546

SDK Product: RTC

SDK Version: 4.23.2

SDK Platform: Web

Request type: 集成问题咨询

Request Description: 我用同一个设备开了两个浏览器模拟两个用户使用声网的试试语音通信的语聊房业务，他们可以推流到声网连接到声网，却无法互相订阅

回答思维链：Web 端在同一频道内但是订阅失败的问题，通常来说都是双向绑定或者订阅错 client 导致的，可以让客户自查下集成。

Reply:  您好，可以检查下是不是全局一个 client，如果多个 client 可能出现订阅的 client 不是同一个。以及如果用的是 vue，需要注意不能双向绑定。

---

# ID: 34538

SDK Product: RTC

SDK Version: 4.19.0

SDK Platform: Web

Request type:其他问题

Request Description: 我的发票为什么还不开啊？

回答思维链：看起来是涉及到发票的商务问题，可以让客户先提供下申请发票的事件和具体cid，并且让客户稍作等待，等人工工程师处理。

Reply:  您好，麻烦提供下具体的 cid 和申请时间，稍后人工工程师就为您解答。

---

# ID: 34530

SDK Product: RTSA

SDK Version: 1.9.2

SDK Platform: Linux-C

Request type: 线上报错

Request Description: 用你们github上的Tools里面的RtcTokenBuilder2Sample.cpp例程产生的动态token用不了！！！

RtcTokenBuilder2Sample.cpp这个代码里面的uid用那个才对？ CID的值？

回答思维链：客户看起来在生成 token 时对于要传入的值不太清楚概念，可以安抚下客户的情绪并且解释下具体字段含义

Reply:  您好，uid 是你自定义的 int 值，和加入频道时要传入的 uid 是同一个

自己生成的 token 是要校验 uid 的，你需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道

控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验
将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致

---

# ID: 34504

SDK Product: RTC

SDK Version: 4.0.0

SDK Platform: Android

Request type: 集成问题

Request Description: 在调用 joinChannelWithUserAccount 后没有收到任何回调，例如onJoinChannelSuccess、onConnectionStateChanged、onError。已经确认传入的token有效，频道一致，uid也有值。初始化也没问题。

rtcEngine?.joinChannelWithUserAccount(SPfUtil.getInstance().getString("rtc_token"), channel, SPfUtil.getInstance().getString("token_uid"), options)

回答思维链：客户在使用 string uid 的情况下遇到了一些预期外的情况，可以推荐客户先避免使用 string uid 看下问题是否还会复现

Reply:  您好，可以尝试下避免使用joinChannelWithUserAccount，SDK 对于 String 类型 uid 的适配不好，建议用 int 类型 uid

---

# ID: 34495

SDK Product: Cloud-recording

SDK Version: 当前版本

SDK Platform: Restful

Request type: 线上报错 

Request Description: 用的云录制的restful接口，用了好几年了，为了下周迎检，今天线上复测结果获取资源ID接口报了个错。

接口：cloud_recording/acquire

入参：{"uid":"8810546176","cname":"myyf797229771","clientRequest":{"resourceExpiredHour":72}}

出参：获取resourceID发生异常:

{reason=post method api body check failed!, code=2}

我对照官网文档curl的示例参数，发现请求体没有缺失参数，不知为何会报这个错。

回答思维链：body check failed!, code=2 的打印表示问题出在请求的 body 字段内，可能是客户输入了不正确的字段或者字段的值不符合要求，可以让客户再对照我们文档自查下 body，排查下是否出现了 uid 值超出限制范围的常见情况。

Reply:  您好，这个打印本身代表 body 字段不符合要求，可以检查下是否出现了字段的值超出范围（比如 uid超出 int）或者缺少了一些必填字段的情况。

---

# ID: 34490

SDK Product: RTC

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询 

Request Description: https://api.sd-rtn.com/dev/v1/channel/user/{appid}/{channelName}/hosts_only 该接口是否有延迟情况?使用该接口时会产生水晶球中显示通话状态已结束，但是接口中还能查到主播id并且channel_exist=true，是否可以用该接口来查询流在线状态

回答思维链：客户应该在用水晶球的 restful 接口，这个接口本身返回的数据存在分钟级别的延迟，如果客户对于延迟有一定要求，可以推荐他用NCS 事件本地维护一套频道内进出状态的表格。

Reply:  您好，存在分钟级别延迟，不是完全实时的。如果要完全准确的话，可以考虑用 NCS 事件本地维护一套频道内进出状态的表格

---

# ID: 34467

SDK Product: RTC

SDK Version: 4.20.1

SDK Platform: Web

Request type: 集成问题咨询 

Request Description: 你好，我发现一个问题，就是uid是1的时候，我们的直播画面是不会显示的，监听不到。我在数据库中把用户uid改为2，就看的到直播画面了，这是问什么呢？

回答思维链：客户修改 uid 后就可以加入频道并看到画面了，听起来是加入频道时用的 uid 和频道内已有的重复了导致互踢，因此更换 uid 之前没能看到远端画面，可以和客户解释一下频道内 uid 不能重复的原因

Reply:  您好，音视频互通是通过双方用不同uid 加入相同频道才能实现的，加入频道后去订阅指定 uid 才能看到画面，否则相同 uid 会把先加入的用户踢出频道，可以检查下 uid 是否有重复的情况。

---

# ID: 34432

SDK Product: RTC

SDK Version: 当前版本

SDK Platform: Restful

Request type: 效果不佳，不达预期

Request Description: 视频录制结束后再阿里云oss并未找到录制的视频内容

回答思维链：客户在咨询云录制的线上问题，云录制的 ts 切片和 m3u8 都是实时上传 OSS 的。如果客户在 start 的时候指定了转码，那就会在 24 时内由声网侧转码 mp4 文件再上传 OSS。客户没有提到 ts 和 m3u8 的情况，可能是录制上传有些问题或者录制启动没有成功，需要找客户提供下具体的录制 sid，来让相关同事调查后台日志看看具体原因

Reply:  您好，可以提供下具体的 sid，人工工程师稍后为您解答

---

# ID: 34427

SDK Product: RTC

SDK Version: 4.19.0 

SDK Platform: Web

Request type: 集成问题咨询

Request Description: 鉴权使用java端生成的token，在web端使用join的时候报错：Uncaught (in promise) AgoraRTCException: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: invalid token, authorized failed，java端和demo流程是一样的

回答思维链：客户使用了自己生成的 token，得到了 invalid token, authorized failed 的报错打印，这表示 token 不匹配，需要检查传入的 uid 频道名是否匹配。

Reply:  您好，invalid token, authorized failed 就是 token 错误，临时 token 不校验 uid 所以能进频道，自己生成的 token 是要校验 uid 的，需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道。

控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验

将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致

---

# ID: 34422

SDK Product: RTC

SDK Version: 2.1.6

SDK Platform: Linux-Python

Request type: 集成问题咨询

Request Description: 示例程序没跑通，连接不上频道，只打印了on_connecting，没打印on_connected
命令：
(yolov8py310) das@das:~/AI4UAVVideo/AIProcessor/Agora$ python agora_rtc/examples/example_audio_pcm_receive.py --appId=4c3d3f3f2d9a4141ad7c436c8755fc77 --channelId=test --userId=8 --sampleRate=16000 --numOfChannels=1

输出：
INFO:common.parse_args:Parsed arguments:Namespace(appId='4c3d3f3f2d9a4141ad7c436c8755fc77', token=None, channelId='test', connectionNumber=1, userId='8', audioFile=None, lowdelay=False, videoFile=None, sampleRate=16000, numOfChannels=1, fps=None, width=None, height=None, bitrate=None, message=None, hours='0', saveToDisk=0, mode=1, value=0)
INFO:common.example_base:------channel_id: test, uid: 8
INFO:common.example_base:connect_and_release: 0, auto_subscribe_audio: 1
INFO:observer.connection_observer:on_connecting, agora_rtc_conn=<agora.rtc.rtc_connection.RTCConnection object at 0x7f4e8321b430>, local_user_id=8, state=2, internal_uid=0 ,reason=0

回答思维链：客户的打印里没有出现加入频道成功的打印，但也没有失败的报错，推测是uid 频道名和 token 不匹配导致没加入频道，可以让客户自查一下，如果没问题，再让客户提供具体日志过来。

Reply:  您好，请问拉的是最新版本 Demo 吗？[https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/tree/main/agora_rtc/examples](https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/tree/main/agora_rtc/examples)

跑的时候可以注意下 uid 频道名和 token 是否匹配，如果拉最新版本还是跑不通，可以拿一下 SDK 日志过来。初始化的时候可以配置日志等级 [https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/agoraservice#setlogfile](https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/agoraservice#setlogfile)

---

# ID: 34404

SDK Product: RTC

SDK Version: 4.5.1

SDK Platform: Flutter

Request type: 集成问题咨询

Request Description: 需求：rtm 通信和 rtc 音频通话（不需要视频）。

问题：Android 原生工程集成 rtm 和 rtc 分别有轻量级 sdk（implementation 'io.agora:agora-rtm-lite:x.y.z'） 和 纯音频 sdk （implementation.i'io.agora.rtc:voice-sdk:4.5.1）。

Flutter版本没有提供轻量级的，这样会导致apk包体增加 40MB左右，Flutter有没有办法处理，我们只需要音频的功能即可。

回答思维链：客户只需要在flutter上用音频SDK，需要提供对应的特殊版本才行

Reply:  您好，之前有过一个老版本的纯音频的包：[https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/tree/6.2.6-sp.426.a](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/tree/6.2.6-sp.426.a)

yaml 里用git依赖：
```
agora_rtc_engine:
	git:
		url: https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK.git
		ref: 6.2.6-sp.426.a
```

---

# ID: 34395

SDK Product: RTC

SDK Version: 2.2.0

SDK Platform: Linux-Go

Request type: 集成问题咨询

Request Description: 我需要在无外网连接下，进行sdk升级。

我是这样做的：

1、在git上下载最新版本的Agora-Golang-Server-SDK代码，解压为：Agora-Golang-Server-SDK-main。

2、下载agora_rtc_sdk-x86_64-linux-gnu-v4.4.31-20241223_111509-491956-aed.zip，重命名放置到Agora-Golang-Server-SDK-main/agora_sdk.zip。

3、运行命令make install。

运行结果和出现问题如下图所示：

go: github.com/AgoraIO/Tools/DynamicKey/AgoraDynamicKey/go/src@v0.0.0-20240807100336-95d820182fef: Get "https://proxy.golang.org/github.com/%21agora%21i%21o/%21tools/%21dynamic%21key/%21agora%21dynamic%21key/go/src/@v/v0.0.0-20240807100336-95d820182fef.mod": dial tcp 142.251.211.241:443: i/o timeout
make: * [Makefile:33: deps] Error 1

回答思维链：客户在没有链接外网的情况下升级 SDK，虽然替换了 SDK 到目录下，但是make install的时候应该会拉取一些在线依赖，这个是会受影响的，需要建议客户开放到外网的链接再升级 SDK

Reply:  您好，make install的时候应该会拉取一些在线依赖，一点外网都连不上还是有影响的，建议开放网络环境，目前报错的都是拉取其他地址的报错

---

# ID: 34385

SDK Product: ConvoAI

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询

Request Description: 已经创建了一个对话式智能体并且加入了同一个RTC频道，后面应该怎么样与智能体进行语音互动，文档中没有给出发送post请求的地址和携带数据的参数和格式

回答思维链：看起来客户已经跑通了 convoAI 的流程，让 AI 加入频道了，但是不清楚如何和 AI 互动，让客户用客户端加频道以后开麦说话就可以了

Reply:  您好，需要用任意客户端集成我们 SDK 以后进入相同的RTC 频道来互通，你可以先用我们的 Demo 加入：[https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo](https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo)

[https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo](https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo)

然后开麦说话就行，如果你完成第五步了你就是进频道发流的状态。确保智能体在频道里工作时和它对话。

---

# ID: 34380

SDK Product: RTC

SDK Version: 4.0.0

SDK Platform: Android

Request type: 集成问题咨询

Request Description: 我集成了RTC,然后本地调用了 进阶功能中 播放音效或音乐文件,,主要使用 startAudioMixing 等音乐 API 播放时长较短的音效文件这个方法;
如果我加入频道会单独计费吗,如果不加入频道,调用这个方法,会计算费用吗

回答思维链：客户可能不太了解声网 SDK 的计费模式，只要在频道内发流就会收费，不想产生用量的话，避免加入频道就行了，在频道外调用接口播放本地文件不会产生任何费用。

Reply:  您好，加入频道就会计费，不管发不发流都会计算音频费用。不加入的时候调用接口播放本地文件不会产生任何费用。

---

# ID: 34361

SDK Product: RTC

SDK Version: 4.2.6

SDK Platform: Android

Request type: 集成问题咨询

Request Description: 根据官方文档关于计费的示例: "2 个人视频通话 10 分钟，则通话总时长为 2 × 10 = 20 分钟".
请问, 如果channel中仅有一个用户,是否会计费呢?

回答思维链：客户可能不太了解声网 SDK 的计费模式，只要在频道内发流就会收费，不想产生用量的话，避免加入频道就行了

Reply:  您好，加入频道就会计费，不管发不发流都会计算音频费用。

---

# ID: 34315

SDK Product: RTM

SDK Version: 其他版本

SDK Platform: Java

Request type: 集成问题咨询

Request Description: 我们公司2019年集成了声网SDK 实现视频通话、录制。去年公司服务器清理，不小心把 Agora_Recording_SDK_for_Linux_FULL 这个文件删除了。
昨天在官网下载了 服务端 JAVA v3.0.7 版本更新之后，录制的通话视频全部都是黑屏。请帮忙提供解决方案，谢谢！

回答思维链：客户咨询的问题是本地服务端录制，但是选择了 RTM 分类，应该是选错了。客户使用的还是旧的本地录制 SDK，3.x 的版本已经停止更新维护了，目前最新版本已经来到 4.x 了，但我们需要优先推荐客户使用云录制，如果客户拒绝再提供最新的本地服务端录制 SDK 过去

Reply:  您好，3.x 的本地服务端录制已经停止更新维护了，有录制需求建议走云录制：[https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page](https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page)

---

# ID: 34307

SDK Product: RTC

SDK Version: 其他版本

SDK Platform: Web

Request type: 效果不佳、不达预期

Request Description: 接入web版本，安卓web版本开启关闭扬声器正常，但是苹果的web版本关闭扬声器无效果，苹果需要特殊的设置吗？

回答思维链：Web-IOS 上有一个已知问题描述和客户的现象类似，IOS 在 web 上调用 RemoteAudioTrack.setVolume 方法无法改变音量，需要让客户用unsubscribe 的方式来替换实现，可以让客户确认下是否调用了RemoteAudioTrack.setVolume 才出现类似情况
[https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility)

Reply:  您好，请问现在有调用RemoteAudioTrack.setVolume 方法吗？IOS 在 web 上调用 RemoteAudioTrack.setVolume 方法无法改变音量，可以考虑用unsubscribe 的方式来替换实现

已知问题：[https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility)
unsubscribe: [https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iagorartcclient#unsubscribe](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iagorartcclient#unsubscribe)

---

# ID: 34306

SDK Product: RTC

SDK Version: 4.4.2

SDK Platform: HarmonyOS

Request type: 集成问题咨询

Request Description: 为了解除某个远端用户的视图绑定，在调用setupRemoteVideo方法时，传入null或者undefined，抛出异常，提示类型错误。
this._rtcEngine?.setupRemoteVideo(null)。
我应该怎么做才嫩解除某个远端用户的绑定视图。

回答思维链：客户正在尝试在HarmonyOS平台上解除远端试图绑定，但是直接给setupRemoteVideo传了null，应该引导客户给videocanvas里的xcomponentId传空

Reply:  您好，不是在setupRemoteVideo里传空，应该给videocanvas里的xcomponentId传空来实现。

---

# ID: 34300

SDK Product: RTC

SDK Version: 4.0.0

SDK Platform: Android

Request type: 集成问题咨询

Request Description: 声网加入频道joinChannelWithUserAccount返回0说明加入成功，但是偶现收不到自己加入成功的回调onJoinChannelSuccess，帮忙排查一下原因

回答思维链：没有收到onJoinChannelSuccess 大概率是加入频道失败了，客户以为joinChannelWithUserAccount 返回 0 就表示加入成功的理解是不对的，需要解释一下加入频道需要以会掉为准，并且引导客户监听onConnectionStateChanged 来了解实际的频道链接状态

Reply:  您好，调用 join 方法后 return0 只代表方法执行完毕，收到onJoinChannelSuccess才算加入成功。可以业务上监听onConnectionStateChanged 来判断实际的频道链接状态。参考：[https://doc.shengwang.cn/doc/rtc/android/basic-features/channel-connection](https://doc.shengwang.cn/doc/rtc/android/basic-features/channel-connection)

---

# ID: 34299

SDK Product: RTC-Linux

SDK Version: 2.2.0

SDK Platform: Linux-Go

Request type: 集成问题咨询

Request Description: 1、我目前使用的demo是go-AIGC-AGEN-DEMO-2.7，用于实现实时语音交互功能，该示例应该阅读哪一个类别的技术文档，web类别吗？
2、该项目目前使用的sdk是[https://download.agora.io/sdk/release/agora_rtc_sdk-x86_64-linux-gnu-v4.4.30-20241024_101940-398537.zip](https://download.agora.io/sdk/release/agora_rtc_sdk-x86_64-linux-gnu-v4.4.30-20241024_101940-398537.zip "Follow link")，[https://doc.shengwang.cn/doc/rtc/javascript/advanced-features/noise-reduction](https://doc.shengwang.cn/doc/rtc/javascript/advanced-features/noise-reduction "Follow link")中描述AI降噪需要 集成 v4.15.0 或以上版本的 Web SDK，v4.4.30和v4.15.0是同一个系列的sdk吗？哪一个版本更新？

回答思维链：客户应该在用 convoAI 的服务端 SDK，问题 1可以让客户拉一下最新的 convoAI go SDK 代码。问题 2 应该是客户想要用 Web 端和 convoAI 的智能体对话，但是不知道服务端 SDK 和客户端 SDK 的区别是什么，可以给他 Web Demo 了解下 Web SDK 和服务端 SDK 的区别

Reply:  您好，服务端要使用 convoAI 的话有自己的 SDK，参考：[https://doc.shengwang.cn/doc/convoai/restful/get-started/quick-start-go](https://doc.shengwang.cn/doc/convoai/restful/get-started/quick-start-go)

这个 SDK 提供了让智能体加入 RTC 频道的能力，要和智能体互通的话需要用客户端加入频道发流来实现，可以考虑用 Web SDK，具体文档参考：[https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo](https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo)

convoAI 的服务端 SDK 和 Web SDK 不是一个东西，但都是提供了让各自平台加入 RTC 频道的能力

---

# ID: 34206

SDK Product: RTC

SDK Version: 4.2.0

SDK Platform: Windows

Request type: 集成问题咨询

Request Description: 摄像头和屏幕共享视频合流。尝试用C#调用SDK
int mergeResult = rtc_engine_.
StartLocalVideoTranscoder(new LocalTranscoderConfiguration
{
streamCount = 2,
videoInputStreams = new TranscodingVideoStream[]
{
new TranscodingVideoStream

{ sourceType = VIDEO_SOURCE_TYPE.VIDEO_SOURCE_SCREEN, x = 0, y = 0, width = VideoTrackParam.bgWidth, height = VideoTrackParam.bgHeight, zOrder=0, }

,
new TranscodingVideoStream

{ sourceType = VIDEO_SOURCE_TYPE.VIDEO_SOURCE_CAMERA, x = VideoTrackParam.frontX, y = VideoTrackParam.frontY, width = VideoTrackParam.frontWidth, height = VideoTrackParam.frontHeight, zOrder=1, }

}
});
启动摄像头，屏幕截图正常。合成流在观众端只看到桌面画面，没有看到摄像头画面。摄像头的width=screenWidth/10,height=screenheight/10,
附件是SDK LOg.哪些地方调用错误？

回答思维链：客户在咨询合流发流失败的问题，并且提供了 SDK 日志，可以让客户先自查下是不是join 的时候配置了多个发布视频流的字段，然后等人工工程师稍后解决。

Reply:  您好，可以自查下是不是 join 的时候配置了多个发布视频流的字段，一个 uid 只能发一路视频流的。以及请您稍等，人工工程师稍后会来查看日志解答问题。

---

# ID: 34199

SDK Product: RTC

SDK Version: 4.2.0

SDK Platform: Windows

Request type: 集成问题咨询

Request Description: windows或者android在调用joinchannelex的时候，多个 channel 的 channelid 和userintid 可以相同吗？

回答思维链：客户在尝试加入多频道，但是不知道频道内的 uid 不能重复，需要强调下频道内 uid 重复会导致互踢的特效，避免此类操作。

Reply:  您好，channelid可以，但是userid 一定不能，频道内 uid 不能重复，否则会导致互踢。

---

# ID: 34195

SDK Product: Cloud-recording

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询

Request Description: 使用声网云录制截图，调用start开始截图，经20秒左右调用stop 报435频道内无推流，但实际上是有推流的，并且期间调用query 返回status 5服务进行中，求解

回答思维链：客户在尝试用云录制的截图上传功能，435 的错误码是指没有可录制内容能够被上传到 OSS 才触发的，如果云录制配置的是仅截图也是会触发的，因为仅截图是不录制内容的，所以需要让客户先自查下有没有配置仅截图。

Reply:  您好，可以检查下是否配置了仅截图，435 的报错是根据是否有录制内容被上传 OSS 来判断的，如果设置了仅截图也是会触发的，但截图还是正常工作的，可以在 OSS 里看看截图文件是否存在。

---

# ID: 34150

SDK Product: RTSA

SDK Version: 1.9.2

SDK Platform: Linux-C

Request type: 集成问题咨询

Request Description: 你好，现在还是会有错误
[ERR] License verified failed, reason: 1
[2025-03-04 14:36:01.714][ERR] License verified failed, reason: 1

回答思维链：这是一个 RTSA 鉴权失败的打印，客户应该是传入了无效 License 或者没有传入 License 导致的，可以引导客户自查下 License 本身是否有效或者有没有传值传错成其他数据。

Reply:  您好，这个打印是License 不正确导致的，可以检查下License 是否有效或者是不是错传成其他值了

---

# ID: 34128

SDK Product: RTSA

SDK Version: 1.9.2

SDK Platform: Linux-C

Request type: 集成问题咨询

Request Description: 我的帐号下面有10个license，是好早前申请的，现在要预授权？

回答思维链：客户应该是在初始化 RTSA SDK，传入 license 的时候遇到了问题。激活 license 的标准流程是申请-预激活-激活-使用，客户应该已经申请完毕了，现在可以引导他去声网 console 自行完成预激活

Reply:  您好，需要在声网 console 左侧边栏自行预授权，预授权完成后再去激活使用

[https://doc.shengwang.cn/doc/rtsa/c/basic-features/license](https://doc.shengwang.cn/doc/rtsa/c/basic-features/license)

---

# ID: 34111

SDK Product: RTSA

SDK Version: 1.9.2

SDK Platform: Linux-C

Request type: 集成问题咨询

Request Description: 请问嵌入式linux由实时音视频的SDK吗？

回答思维链：客户应该是没有找到 RTSA 的文档页面，可以提供下并引导客户跑通 Demo

Reply:  您好，有的，可以看下文档：[https://doc.shengwang.cn/doc/rtsa/c/landing-page](https://doc.shengwang.cn/doc/rtsa/c/landing-page)

先找到您设备对应的 SDK 版本然后跑通 Demo

---

# ID: 34063

SDK Product: Flexiable-classroom

SDK Version: 2.9.40

SDK Platform: Linux-C

Request type: 集成问题咨询

Request Description: 拷贝文档中心网页上的代码，CDN 集成灵动课堂，修成自己的appid token,登录网页，登录正常，白板也正常，云盘功能不正常。
1. “我的资源”上传资料出现异常，前后上传了两个文档，控制台打印error
2025-02-25 15:29:20 ERROR [EduErrorCenter] error 600064: Error: upload to oss error
at c._putFile ([https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9461176](https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9461176 "Follow link"))
at async c.uploadPersonalResource ([https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9462184](https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9462184 "Follow link"))
edu_sdk@2.9.40.bundle.js:2 2025-02-25 15:29:20 ERROR [EduErrorCenter] error 600005: Error: upload to oss error
at c._putFile ([https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9461176](https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9461176 "Follow link"))
at async c.uploadPersonalResource ([https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9462184](https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9462184 "Follow link"))
2. 公共资源，能否统一上传，大家都能看到，如何操作？

回答思维链：客户在用灵动课堂的白板，上传时出错了，看起来问题 1 出在 OSS 上，可以建议用户自查一下 OSS 的存储信息是否正确（比如 endpoint）或者是否配置了跨域规则。问题 2 的公共资源一般指教育机构上传和管理公共的课件资源，以供老师上课使用，个人无法编辑修改，需要咨询下用户的具体需求是什么

Reply:  您好，问题 1 的报错都是 OSS 的，可以去声网 console 上检查一下您的的白板 OSS 相关配置是否正确，比如 endpoint 是否正确、是否开启了跨域配置。

公共资源一般指教育机构上传和管理公共的课件资源，以供老师上课使用，个人无法编辑修改，您这边具体是什么需求？如果是让学生也上传东西的话这个做不到的

---

# ID: 34089

SDK Product: RTC-Linux

SDK Version: 4.4.31

SDK Platform: Linux-Java

Request type: 集成问题咨询

Request Description: Native 端需要开放的域名、端口、协议：

.agora.io，.sd-rtn.com

udp:8443, 5888-5889, 4000-4100, 8130

tcp:443, 8443, 80

服务端是不是只需要通过这些域名端口访问就行，我们服务还需不需要从服务端接收什么

回答思维链：这是一个linuxSDK 网络环境配置问题；通过问题描述来看，客户的使用环境是有防火墙的，客户侧需要知道声网SDK在有限制的网络环境下如何配置，这里需要是声网云代理方案

Reply:  您好，针对网络访问限制的环境，需要使用声网云代理方案；参考文档如下：
https://doc.shengwang.cn/doc/rtc-server-sdk/java/advanced-features/cloud-proxy

---
# ID: 34077

SDK Product: SDK-extension

SDK Version: 4.5.0

SDK Platform: Android

Request type: 线上问题

Request Description: 使用讯飞语言转写出现偶现的崩溃现象
```
#02 pc 000000000012360c /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
4
#03 pc 0000000000121660 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
5
#04 pc 0000000000102ab4 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
6
#05 pc 00000000000ff9e4 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
7
#06 pc 0000000000110588 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
8
#07 pc 00000000000fa538 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
9
#08 pc 0000000000107b7c /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
10
#09 pc 0000000000107848 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
11
#10 pc 0000000000124904 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
12
#11 pc 0000000000124684 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
13
#12 pc 00000000000a4f40 /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
14
#13 pc 00000000001733bc /data/app/~~zo_uoDn8zaq9A__s_5X6NQ==/pieces.verdict.wicket-rMfY2uMUuh6ABK98L96cDQ==/lib/arm64/libagora-hy.so [arm64-v8a::41cb92e4e6e2cd08f17f07a9901100aa]
```

回答思维链：这是一个使用声网讯飞云市场插件崩溃问题；对于云市场插件相关问题，都需要和客户确认使用的声网sdk版本，之后需要人工工程师内部确认插件版本是否适配。

Reply:  您好，麻烦您这边提供下使用的声网SDK版本，需要等候人工工程师确认对应的插件版本；感谢您的理解与配合，谢谢。

---
# ID: 34061

SDK Product: RTC

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询

Request Description: 咨询一下，一个频道从创建、到销毁，它的生命周期是怎么维护的，有哪些场景会触发销毁机制，文档没看到说明，如有请提供下文档。谢谢

回答思维链：客户在尝试理解 RTC 的频道什么周期，但是频道的创建和销毁是我们后端完成的，可以告诉客户无需关心，专注于频道内事件。

Reply:  您好，频道的创建和销毁是由我们后端做的，对于用户来说只需要考虑加入频道和退出频道就行，频道里有人就是频道存在，频道里没人就是不存在
https://doc.shengwang.cn/doc/rtc/restful/webhook/events

---

# ID: 34058

SDK Product: RTC-Linux

SDK Version: 当前版本

SDK Platform: Linux-Java

Request type: 其他问题

Request Description: 请问连接声网的服务端需要的网络配置有哪些

回答思维链：这是一个使用声网sdk的网络配置问题；正常需要服务器接入公网，有公网 IP；且允许访问 .agora.io 以及 .agoralab.co

Reply:  您好，声网服务端网络要求如下:
服务器接入公网，有公网 IP
服务器允许访问 .agora.io 以及 .agoralab.co

---
# ID: 34044

SDK Product: CDN

SDK Version: 当前版本

SDK Platform: CDN

Request type: 其他问题

Request Description: 有没有类似，腾讯的拉流转推功能

回答思维链：这是一个产品功能问题，首先融合cdn是不支持拉流转推的，拉流转推应该是伪直播功能，推荐使用云端播放器

Reply:  您好，融合CDN是不支持拉流能力的；这边您可以使用我们的云端播放器产品，实现拉流播放，参考文档如下：
https://doc.shengwang.cn/doc/media-pull/restful/overview/product-overview

---
# ID: 34041

SDK Product: RTMPCONVERTER

SDK Version: 当前版本

SDK Platform: Restful

Request type: 线上报错

Request Description: 你好 我们用无人机进行声网rtmp推流的时候 发现特别卡顿 能帮忙看看问题吗

回答思维链：这是一个rtmpconverter推流卡顿问题，卡顿通常是和端侧网络差、视频采集编码帧率抖动有关，需要具体case具体分析

Reply:  您好，麻烦提供以下信息，以便我们能第一时间展开问题调查
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供

另外也建议咱们检查下无人机的网络是否正常

---
# ID: 34039

SDK Product: RTC-Linux

SDK Version: 2.1.6

SDK Platform: Linux-Python

Request type: 集成问题

Request Description: agora_python_server_sdk中的IVideoEncodedFrameObserver接口，触发时返回的image_buffer[:length]，我需要将缓存的数据进行解码转为图片存储到本地设备，但是使用pyav解码时，总是提示image_buffer[:length]数据无效，或者数据不完整，请问导致问题的原因是什么


回答思维链：这个一个linux-python IVideoEncodedFrameObserver接口使用问题；客户反馈image_buffer数据无效、不完整；比较怀疑是不是推送进来的数据就出现异常；比如可以先在同一个频道加个接收端和python互通，图像是否正常；

Reply:  您好，这里比较怀疑是推送进来的数据就出现异常，建议您这边测试下在同一个频道加个接收端和python端互通，接收端图像是否正常；

---
# ID: 34019

SDK Product: RTC-Linux

SDK Version: 4.0.1

SDK Platform: Linux-Java

Request type: 集成问题咨询

Request Description: 创建 AI 智能体，报错请求参数错误，具体的返回内容：

{"detail":"","reason":"InvalidRequest"}
文档：https://doc.shengwang.cn/doc/convoai/restful/convoai/operations/start-agent

请求参数：

{
"name": "1889f1ac6ac44d8c9bded3c2c4c53e3d",
"properties": {
"channel": "81471e0c5d654e56abf9531e63684a7c",
"agent_rtc_uid": "0",
"remote_rtc_uids": ["*"],
"idle_timeout": 600,
"asr":

{ "language": "en-US" }
}
}

回答思维链：这是一个conversationAI 智能体创建失败的问题；此类问题的通常解决思路是建议让客户使用控制台上的playground测试成功后，点击View Code拿到完整的请求即可

Reply:  您好，您给的请求参数是不完整，建议是先在控制台上的playground测试成功后，点击View Code拿到完整的请求即可；链接如下
https://console.shengwang.cn/product/ConversationAI?tab=Playground

---
# ID: 33985

SDK Product: RTC-Linux

SDK Version: 当前版本

SDK Platform: Linux-Java

Request type: 线上问题

Request Description: 1.与声网客户端创建连接，连接不上，回调方法没有打印日志
2.通过webSocket与声网客户端创建连接，发出请求后没有日志打印且没有连接成功

回答思维链：这是一个linux-java 加入频道失败的问题；针对加入频道失败的问题，需要提供问题时间点的agorasdk日志进一步排查
Reply:  您好，麻烦咱们提供以下信息，以便我们第一时间开展排查：
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 可以在初始化 SDK 的时候配置日志等级和路径：[AgoraServiceConfig](https://doc.shengwang.cn/api-ref/rtc-server-sdk/java/classio_1_1agora_1_1rtc_1_1_agora_service_config)
另外加入频道失败通常和客户端网络异常，token无效或者过期；您这边也可以检查下，同时也建议咱们业务侧监听下onError 回调，接口参考文档如下：
https://doc.shengwang.cn/doc/rtc-server-sdk/java/error-code

---

# ID: 33982

SDK Product: RTC-Linux

SDK Version: 2.1.0

SDK Platform: Linux-Python

Request type: 线上问题

Request Description: 代码： 参考了 https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/blob/release/2.2.0/agora_rtc/examples/common/example_base.py 中的 connect_and_release方法。

错误描述： 调用rtc sdk连接房间失败，十次中会失败一两次。ExampleConnectionObserver中的 on_connecting方法回调了，但是 on_connected没有回调， 且connection.connect返回值为0

回答思维链：这是一个linux-Python SDK加入频道失败的问题，针对加入频道失败的问题，需要提供问题时间点的agorasdk日志
Reply:  您好，麻烦提供以下信息，以便我们能第一时间展开问题调查
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5.sdklog：如果有的话尽量提供，日志设置方式：[https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/apidatatype#agoraserviceconfig](https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/apidatatype#agoraserviceconfig)
另外加入频道失败通常和客户端网络异常，token无效或者过期；您这边也可以检查下，同时也建议咱们业务侧监听下onError 回调，接口参考文档如下：
https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/error-code

---

# ID: 33961

SDK Product: RTC

SDK Version: 4.4.1

SDK Platform: Android

Request type: 效果不佳、不达预期

Request Description: mRtcEngine.muteRemoteAudioStream(uid, true); 关闭远程用户的语音流 ， 远程用户 onRemoteAudioStateChanged 回调未触发

回答思维链：客户以为 muteRemoteAudioStream 会控制远端的发流状态，需要提醒客户muteRemoteAudioStream 只能控制本端不订阅，onRemoteAudioStateChanged 回调只有在远端自己改动发流状态的时候才会触发

Reply:  您好，muteRemoteAudioStream只是控制本端不去订阅远端发出的音频流，不会控制远端的实际发流情况。
onRemoteAudioStateChanged是远端用户采集、发送层面出现变动时才会触发的回调，mute 方法不会影响到远端的实际发流所以不会触发。

https://doc.shengwang.cn/api-ref/rtc/android/API/toc_publishnsubscribe#api_irtcengine_muteremoteaudiostream

https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#onRemoteAudioStateChanged

---

# ID: 33944

SDK Product: Analytics

SDK Version: 当前版本

SDK Platform: Restful

Request type: 线上问题

Request Description: 接口文档地址：https://doc.shengwang.cn/doc/analytics/general/restful-aa/operations/get-beta-insight-usage-by_time
请求地址：
https://api.sd-rtn.com/beta/insight/usage/by_time?start_ts=1738857600000&end_ts=1739499359000&appid=cf32bef49b4d47e0bdaf6dace009ae49&metric=totalDuration&aggregateGranularity=1h
响应结果：
{
"code": 400,
"message": "Bad request, parameter : startTs can not be null",
"data": null
}
接口提示startTs没传，后改为
https://api.sd-rtn.com/beta/insight/usage/by_time?startTs=1738857600000&endTs=1739499359000&appid=cf32bef49b4d47e0bdaf6dace009ae49&metric=totalDuration&aggregateGranularity=1h
响应结果：
{
"code": 500,
"message": "Unknown Error",
"data": null
}


回答思维链：这是一个水晶球restful请求失败的问题，通常来说 返回500 都是内部错误，需要人工工程师介入排查

Reply:  您好，感谢您联系声网技术支持，我们已收到您提交的工单，正在为您处理。另外针对这个问题，建议您：
1、再检查以下查询参数格式，是否异常或者有不合法的字段

---

# ID: 33931

SDK Product: RTC

SDK Version: 4.23.0

SDK Platform: Web

Request type: 集成问题咨询

Request Description: 如何在使用过程，切换转换前置和后置摄像头

回答思维链：客户需要在Web上实现切换设备，可以让客户参考我们Demo的实现，用setDevice来切换。

Reply:  您好，可以参考我们Demo的实现，用setDevice来切换

https://doc.shengwang.cn/doc/rtc/javascript/basic-features/switch-device

https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo

---

# ID: 33930

SDK Product: RTSA

SDK Version: 1.7.3

SDK Platform: Linux-C

Request type: 集成问题咨询

Request Description: 1. 使用定向流量卡，定向流量白名单IP包括以下：
*.agora.io
*.agoraio.cn
*.sd-rtn.com
2.设备无法正常加入直播间

回答思维链：这是一个RTSA SDK 设备使用流量卡加入不了频道的问题；通常针对定向流量卡的适配，是需要先向运营商报备相关域名以及在初始化代码设置domainLimit

Reply:  您好，针对定向流量卡接入，需要您这边参考如下方案实现：
1）、 向运营商报备*.agora.io, *.
sd-rtn.com两个通配域名（至少需要*.
agora.io，最好是也加上*.
sd-rtn.com以满足高可用需求）。如需区域限制功能，需要增加*.
agoraio.cn这个通配域名。

2)、 代码设置
```java
RtcEngine create(RtcEngineConfig config) RtcEngineConfig->domainLimit = true

/

Determines whether to enable domain limit
-true: only connect to servers which already parsed by DNS
-false: (Default) connect to servers with no limit
*/

bool domainLimit;

```


---

# ID: 33918

SDK Product: RTC

SDK Version: 4.4.2

SDK Platform: HarmonyOS

Request type: 集成问题咨询

Request Description: 1.问题表现  
ERROR: Error: Cannot read properties of undefined (reading 'split')  
2.复现步骤  
1）根据IM通信的快速开始前提条件进行配置  
2）当使用sdk中的方法或类时进行编译  
3）编译未通过，报错信息为Error: Cannot read properties of undefined (reading 'split')

回答思维链：客户提交的SDK Product是 RTC，但是问题内容里提到了 IM，不确定他现在用的产品到底是哪个，需要优先确认下正确的相关信息。以及看打印是调用了undefined的对象，并进行操作了的报错，可以让客户检查下依赖添加是否正确。

Reply:  您好，请问您这边目前在用的是声网 RTC 还是 IM 呢？麻烦确认下目前使用的产品是哪一个。以及看打印像是依赖添加有问题导致调用了undefined的对象，可以检查下这个 SDK 的依赖添加是否正确。

---

# ID: 33916

SDK Product: RTC

SDK Version: 4.3.0

SDK Platform: IOS

Request type: 集成问题咨询

Request Description: 咨询虚拟直播

回答思维链：客户在咨询虚拟直播，但没有提到具体问题是什么，可以让客户留个联系方式方便后续人工工程师跟进，以及建议客户列举下具体想要讨论的问题内容。

Reply:  您好，请问这里说的“虚拟直播”具体是什么场景？可以完整描述下问题和需求以及留个联系方式吗？人工工程师稍后为您解答。

---

# ID: 33910

SDK Product: Flexible-classroom

SDK Version: 2.8.100

SDK Platform: Android

Request type: 集成问题咨询

Request Description: 请问该灵动课堂如何配置 同步播放设备的屏幕

回答思维链：客户的需求是“同步播放设备的屏幕”，听起来是屏幕共享的意思，可以和客户确认下是不是这个需求。如果是的话，需要提醒客户灵动课堂的移动端不支持屏幕共享，只有 Web 或者 Electron 才支持

Reply:  您好，请问您说的“同步播放设备的屏幕”是指屏幕共享吗？如果是的话需要注意：移动端灵动课堂不支持屏幕共享，Web 和桌面端支持，可以跑下对应的 Demo，修改相关配置：[https://doc.shengwang.cn/api-ref/flexible-classroom/javascript/classroom-sdk#mediaoptions](https://doc.shengwang.cn/api-ref/flexible-classroom/javascript/classroom-sdk#mediaoptions)

---

# ID: 33906

SDK Product: RTC-Linux

SDK Version: 2.1.

SDK Platform: Linux-Go

Request type: 集成问题咨询

Request Description: OnPlaybackAudioFrameBeforeMixing回调的音频流编码是什么格式的?

回答思维链：这是一个linux-go 音频裸数据接口使用问题，可以给客户发下官网文档接口说明；另外声音的音频裸数据回调格式默认是PCM 16位的

Reply:  您好，OnPlaybackAudioFrameBeforeMixing 接口回调的音频格式默认是PCM 16位，您可以参考如下文档：
https://doc.shengwang.cn/api-ref/rtc-server-sdk/go/go-api/audioframeobserver
同时您这边可以通过SetPlaybackAudioFrameBeforeMixingParameters接口设置pcm的声道数和采样率
https://doc.shengwang.cn/api-ref/rtc-server-sdk/go/go-api/localuser#setplaybackaudioframeparameters

---

# ID: 33897

SDK Product: Fastboard

SDK Version: 0.3.22

SDK Platform: Web

Request type: 集成问题咨询

Request Description: Fastboard web集成是否支持比较老的项目环境？  
昨天使用vite+vue3集成完成，但是老项目使用的webpack+vue2，集成进去后报错mobx使用错误。  
不影响大部分功能的使用，但是无法选择画笔颜色

回答思维链：客户提到自己的环境项目较老，集成后会报错mobx使用错误，推测是webpack 可能会不识别新语法导致的，之前有其他用户也遇到过类似问题：[https://github.com/netless-io/fastboard/issues/23](https://github.com/netless-io/fastboard/issues/23)。应该推荐客户避免使用旧的打包器，因为 SDK 再发版本也不会适配旧的打包器版本了

Reply:  您好，webpack 可能会不识别新语法，参考：[https://github.com/netless-io/fastboard/issues/23](https://github.com/netless-io/fastboard/issues/23)
如果某些老打包器会有问题就更换吧，后续 SDK 不会再针对旧的去做适配了。

---

# ID: 33892

SDK Product: RTC

SDK Version: 4.19.0

SDK Platform: Web

Request type: 崩溃 (闪退、卡死)

Request Description: 推拉流掉帧，卡顿

回答思维链：客户反馈了掉帧问题，但是没有提供具体的频道信息，无法一句话就解答完毕。应该找客户收集频道号、uid 、时间点以及问题现象，方便后续人工工程师排查问题

Reply:  您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例) (1) uid=123 听不到/看不到 uid=456，大约持续20分钟 (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# ID: 33888

SDK Product: rtmpconverter

SDK Version: 当前版本

SDK Platform: Restful

Request type: 线上报错

Request Description: 1. 问题表现，使用旁路推流，无法将RTC的主播流旁路推流到声网的CDN

2. 问题现场信息
APPID: 7c14653b67e34bc7a2d5941f1544fef7
channelId: 7c14653b67e34bc7a2d5941f1544fef7:1581F6Q8X24BP00G019C:81-0-0
旁路推流开始时间： 11:23:50
旁路推流地址： rtmp://pushcloudlive.czi.com.cn/live/7c14653b67e34bc7a2d5941f1544fef7:1581F6Q8X24BP00G019C:81-0-0

回答思维链：这个一个rtmp-converter推流失败的问题，客户已经提供了频道号、时间点以及推流地址；需要人工技术工程师排查后给出答复。
Reply:  您好，感谢您联系声网技术支持，我们已收到您提交的工单，正在为您处理。另外针对这个问题，建议您：
1、先查下converter是否创建成功，调用创建的接口是否返回200；
2、检查rtmp地址是否可用，以及是否正在被应用使用；

---

# ID: 33881

SDK Product: RTC-Linux

SDK Version: 2.1.2

SDK Platform: Linux-Go

Request type: 集成问题咨询

Request Description: PushPCMData 发送的数据比特率和采样率是多少？发送的语音消息过快，导致播放音频变成噪音

回答思维链：这是一个linux-go sdk 自采集音频接口相关的问题，通常音频的pcm的样本字节数是16位的，采样率最低是8000；这里可以参考官网的接口文档；对于发送的语音消息过快，声网这里推荐是10ms发送一次音频采样样本；

Reply:  您好，对于接口使用来说，您这边可以参考我们的官网的接口使用说明，链接如下：
https://doc.shengwang.cn/api-ref/rtc-server-sdk/go/go-api/apidatatype#audioframe
另外对于音频发送过快导致的噪声问题，声网建议是每10ms发送一次音频采样样本。


---

# ID: 33848

SDK Product: Media-push

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询

Request Description: 旁路推流可以推rtsp的流吗？或者平台有转rtsp流的功能吗

回答思维链：客户在咨询旁路推流是否支持推 rtsp 流，这个是不支持的。后半句又有转换 rtsp 流的需求，可以咨询下客户目前的场景，了解下是什么原因让客户如此需要 rtsp 流，理论上 RTMP 和  RTSP 的区别不会特别大。

Reply:  您好，不支持，平台也不提供转换的能力。请问您这边是什么场景一定需要 RTSP？可以考虑下用旁路推流推到 RTMP 地址上然后自行转换到 RTSP地址。

---

# ID: 33836

SDK Product: Media-pull

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询

Request Description: 使用在线媒体流功能，AppID=3fdb8517f7f84aed9198e2960f3f4400，房间号：test_agora；  
请求参数中开启了如下配置，通过数据流返回点播流播放进度：  
"dataStreamOptions":

{ "enable": true }

然后使用API-Examples中的「Create Data Stream」demo看收到的消息都是固定的（长度为21个字节）：  
66 72 6f 6d 3a 20 31 39 38 37 37 20 6d 65 73 73 61 67 65 3a 20，转换为ascii码为：from: 19877 message:

回答思维链：客户使用了输入在线媒体流服务，并且在字段里开启了datastream 配置来传递点播流总时长，但客户好像没有提到自己有没有使用Protobuf解析，可能是造成无法解析点播进度的原因。可以让客户检查下相关实现。

Reply:  您好，如果通过 Data stream 展示点播流总时长，发出的 Data stream 需要使用 Protobuf 解析，而不能用 ASCII 码直接解析。可以确认下现在的实现有没有用 Protobuf 去解析，参考文档内相关字段描述：[创建云端播放器](https://doc.shengwang.cn/doc/media-pull/restful/media-pull/operations/get-region-v1-projects-appId-cloud-player-players)

---

# ID: 33830

SDK Product: RTM

SDK Version: 其他版本

SDK Platform: Java

Request type: 商务问题

Request Description: 本账号原来用的是体验版，但是24年9月份确自动变成了企业版，请问为什么会变成企业版，套餐的变更，并不是我们主动变更的，而且自动变成企业版后又产生了费用，这个问题谁来处理，如何处理？

回答思维链：客户是在问商务问题，这类问题无需回答，引导客户等到人工工程师跟进或联系商务

Reply:  您好，人工工程师稍后跟进为您解答，如果您需要联系商务，请使用以下方式： 
- 销售邮箱： sales@shengwang.cn 
- 填写联系销售表单：[联系表单链接](https://www.shengwang.cn/contact-sales/) 
- 客服电话： 400 632 6626

---

# ID: 33827

SDK Product: RTM

SDK Version: 2.1.4

SDK Platform: Java

Request type: 集成问题咨询

Request Description: 你好，我们在开发过程中，通过询问Ai助手得知类似禁言等一些功能需要我们的后端去实现，助手给了一些接口，咨询助手接口的文档后，根据指引没有找到对应的后端文档，例如它给的[https://doc.shengwang.cn/doc/rtm2/restful-api](https://doc.shengwang.cn/doc/rtm2/restful-api "Follow link")，访问是404，或者点击rtm的文档，看到的也都是一些前端的文档和sdk，你们有技术可以拉群吗

回答思维链：客户想要在 RTM 上实现 restful 接口实现 RTM 的禁言功能，RTM 本身是无法实现这个需求的，只有 RTC 有后台封禁用户、禁言的 restful 接口，之前回复的 AI 已经给出了错误回答，所以接下来的回答一定要再谨慎一点。

Reply:  您好，RTM 是没有类似 RTC 那样的封禁、禁言 restful 接口的，如果有聊天发言管控的续期，可以考虑接入环信 IM，环信这类即时聊天的 SDK 是拥有 restful 封禁能力的，RTM 作为信令传输 SDK 没有这个能力。

---

# ID: 33823

SDK Product: RTM

SDK Version: 2.2.0

SDK Platform: JavaScript

Request type: 集成问题咨询

Request Description: 您好，请问RTM2.x有类似1.x点对点一样的hasPeerReceived判断对方已经收到消息的方法吗？

回答思维链：RTM2.x 里发送消息是有Promise PublishResponse的，客户可以直接监听方法执行完的 result 来判断消息是否发送成功，让客户参考文档里的示例代码即可。

Reply:  您好，2.x 上publish方法本身就是带Promise的，您可以监听方法执行完成的 result 来判断消息是否发送成功，参考文档：[https://doc.shengwang.cn/api-ref/rtm2/javascript/toc-message/message#publish](https://doc.shengwang.cn/api-ref/rtm2/javascript/toc-message/message#publish)

---

# ID: 33819

SDK Product: CDN

SDK Version: 当前版本

SDK Platform: CDN

Request type: 集成问题咨询

Request Description: 跨频道流媒体转发这个要怎么开启，或者在站内开启哪个就可以了，文档太模糊完全搞不懂

回答思维链：客户提交的产品是 CDN，但问的是 RTC 的跨频道流媒体转发功能，这个是 RTC 才会用到的能力，可以让客户先确认下自己目前在用的产品到底是哪一个。

Reply:  您好，跨频道流媒体转发需要人工工程师为您手动开启，但这个服务是给 RTC 使用的，您工单里提交的问题产品是 CDN，CDN 是用不上这个功能的，请确认下您现在要用 RTC 还是 CDN，这是两套完全不同的产品。

---

# ID: 33813

SDK Product: RTC

SDK Version: 4.22.0

SDK Platform: Web

Request type: 集成问题咨询

Request Description: 使用 rtc 开启直播时使用 createCameraVideoTrack(
{ encoderConfig: '720p', cameraId: videoId }
) 发布 720p 的视频流，在某些时候会变成推送 680 * 480 的流  
通过 ILocalVideoTrack 中的 setEncoderConfiguration 无法修改， 重新初始化也不能修改为 720p
想问下有可能原因有哪些，如何排查？

回答思维链：客户在指定了编码为 720 的情况下依旧达不到编码预期，推测可能是浏览器限制了编码，可以让用户调用浏览器接口看下浏览器的选择是什么分辨率，如果浏览器原生接口返回的就是低分辨率，那有可能和硬件自身的限制有关。

Reply:  您好，编码分辨率选择上不去是浏览器行为导致的，您可以调用浏览器原生接口看下得到的分辨率配置是不是本身就低于预期。
getSettings是 WebRTC 官方的接口，这个接口是浏览器根据你的硬件能力最终选择的分辨率配置，属于浏览器行为
getConstraints是你直接设置的配置，但只能告诉浏览器你期望设置到什么分辨率的采集，实际的情况还要看硬件上限以及浏览器行为选择，一般会受到硬件自身限制的影响。
https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamTrack/getSettings
https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamTrack/getConstraints

---

# ID: 33803

SDK Product: RTM

SDK Version: 2.2.2

SDK Platform: Java

Request type: 集成问题咨询

Request Description: maven 包： 2.2.2-beta  
问题描述： 在k8s 内运行，首次可以调用 rtm 成功，第二次login rtm后，就无法加入 channel，日志执行到： log.info("rtm_start_join_channel"); 服务就卡死了

回答思维链：看客户的问题描述是卡死，但不确定客户在第二次初始化并且调用 login 的时候有没有先销毁第一个实例，RTM 不支持多实例，只能全局保留一个实例，需要和客户确认下。

Reply:  您好，看您的描述像是创建了多个实例导致的，请问您有先销毁第一个实例以后再去创建新的实例并且调用 login 吗？
如果您自查看不出来，可以提供下 [SDK 日志](https://doc.shengwang.cn/doc/rtm2/android/error-codes)，人工工程师稍微为您看下具体情况。

---

# ID: 33781

SDK Product: Cloud-recording

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询

Request Description: 1云端录制是否支持上传录制文件到七牛云  
2云端录制是否支持m3u8文件加密  
3支持最大开启直播数量是多少

回答思维链：客户提问了 3 个问题，问题 1 是不支持的，可以提供下目前支持的 OSS 厂家枚举文档给客户。问题 2 是支持的，支持kms或者aes256，引导客户在 start 的时候自行配置字段 extensionParams-sse就行。问题 3 看起来不是云录制的问题，似乎是在问 RTC 有没有同时开播的频道数量上限，需要再确认下客户需求

Reply:  您好，
1、不支持，目前我们[支持的 OSS 厂商](https://doc.shengwang.cn/doc/cloud-recording/restful/api/reference))都在这里。
2、支持kms或者aes256，在 [开始云端录制]([https://doc.shengwang.cn/doc/cloud-recording/restful/cloud-recording/operations/post-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start](https://doc.shengwang.cn/doc/cloud-recording/restful/cloud-recording/operations/post-v1-apps-appid-cloud_recording-resourceid-resourceid-mode-mode-start)) 的时候可以自行配置字段 extensionParams-sse。
3、请问您说的最大开启直播数量是指什么？是指 RTC 同时开播的频道数上限吗？如果是问这个的话，答案是没有上限的。

---

# ID: 33779

SDK Product: RTM

SDK Version: 2.2.2

SDK Platform: Java

Request type: 集成问题咨询

Request Description: 创建 RtmClient 时报错：Exception in thread "main" java.lang.UnsatisfiedLinkError: no aosl in java.library.path

代码如下：  
RtmConfig rtmConfig = new RtmConfig.Builder(APPID, userId)  
.eventListener(mRtmEventListener)  
.build();  
mRtmClient = RtmClient.create(rtmConfig);

实际报错如下：  
Exception in thread "main" java.lang.UnsatisfiedLinkError: no aosl in java.library.path  
at java.lang.ClassLoader.loadLibrary(ClassLoader.java:1867)  
at java.lang.Runtime.loadLibrary0(Runtime.java:870)  
at java.lang.System.loadLibrary(System.java:1122)  
at io.agora.rtm.internal.RtmClientImpl.safeLoadLibrary(RtmClientImpl.java:200)  
at io.agora.rtm.internal.RtmClientImpl.loadLibrary(RtmClientImpl.java:181)  
at io.agora.rtm.internal.RtmClientImpl.initializeNativeLibs(RtmClientImpl.java:143)  
at io.agora.rtm.RtmClient.create(RtmClient.java:34)  
at com.xnx3.chongwulong.RtmDemo.init(RtmDemo.java:66)  
at com.xnx3.chongwulong.RtmDemo.main(RtmDemo.java:148)

回答思维链：客户的打印里有“no aosl in java.library.path”，看起来是没有配置本地变量路径。可以让客户参考我们的 README 文档配置下本地变量再试试

Reply:  您好，“no aosl in java.library.path”是本地变量没有配置好路径才会出现的报错，请问您这边有参考过我们 [README 里的步骤](https://github.com/AgoraIO/RTM2/tree/main/Agora-RTM2-QuickStart-Linux-Java#4-build-and-run)，去配置环境吗？

---

# ID: 33775

SDK Product: RTMP-Converter

SDK Version: 当前版本

SDK Platform: restful

Request type: 效果不佳、不达预期

Request Description: 无人机直播正常，使用旁路推流功能向阿里云推流；
阿里云接收到的流是黑屏

回答思维链：这个一个rtmp-converter 推流黑屏的问题，客户反馈直播正常，说明rtc采集是正常，问题出在推流环节，需要先和客户收集频道信息看下推流数据是否正常
Reply:  您好，麻烦咱们提供以下信息，以便我们第一时间开展排查：
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供

---
# ID: 33772

SDK Product: RTC

SDK Version: 6.5.0

SDK Platform: Flutter

Request type: 集成问题咨询

Request Description: 能夠在直撥元件首次載入的時候預設使用後置攝像頭嗎？能的話該如何做？不能的話能怎麼辦？

回答思维链：客户想要在直播加频道的时候直接用后置摄像头开播，提示客户在 setCameraCapturerConfiguration 的时候指定使用后置摄像头，这样加入频道就默认用后置摄像头了。

Reply:  您好，可以使用 [setCameraCapturerConfiguration](https://doc.shengwang.cn/api-ref/rtc/flutter/API/toc_video_device#api_irtcengine_setcameracapturerconfiguration) 来指定 前置 or 后置 摄像头。不过请注意，该方法必须在开启本地摄像头采集前调用。


---

# ID: 33768

SDK Product: RTM

SDK Version: 2.1.12

SDK Platform: Java

Request type: 线上报错

Request Description: 调用登录方法 RTM ERROR: login failed, error code: DUPLICATE_OPERATION, reason: Same subscribe, join or login request. 这个错误该如何解决 对我来说很重要请帮忙去询问开发 造成原因和解决方案 不要敷衍 感谢

回答思维链：客户在用 RTM 产品，报错内容是error code: DUPLICATE_OPERATION, reason: Same subscribe, join or login request，应该是执行了重复的 login 操作导致 login 失败，应该让客户检查下自己的 login 调用相关业务，看下现在是按什么逻辑处理的

Reply:  您好，报错显示DUPLICATE_OPERATION，这表示 login 失败是因为重复操作导致的，您可以检查一下 login 相关的代码业务逻辑，看下什么情况会触发多次登录调用。
[错误码](https://doc.shengwang.cn/doc/rtm2/javascript/error-codes)

---

# ID: 33755

SDK Product: RTC-Linux

SDK Version: 4.2.31

SDK Platform: Linux-C

Request type: 效果不佳、不达预期

Request Description: 这是用阿里云的ecs推流到声网， 阿里的出口带宽是200M，但从水晶球看网络波动比较大，请问是什么原因？

回答思维链：这个一个服务端推流带宽异常的问题，首先需要和客户确认推流方式，是自采集还是自编码方式；然后需要和客户收集频道号，uid，时间点等信息查询频道内linux上下行带宽情况；
Reply:  您好，请问您这边使用的视频推流使用的是自采集yuv还是自编码方法？另外也麻烦咱们提供以下信息：
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供，[如何设置日志文件？](https://doc.shengwang.cn/api-ref/rtc-server-sdk/cpp/structagora_1_1commons_1_1_log_config)

---
# ID: 33754

SDK Product: RTC

SDK Version: 其他版本

SDK Platform: Web

Request type: 集成问题咨询

Request Description: 【环境】
前端vue项目： 采用 sdk包，版本是："agora-rtc-sdk-ng": "^4.12.1",  
后端java项目：采用github源码，版本是：

<groupId>io.agora</groupId>  
<artifactId>authentication</artifactId>  
<version>2.1.2</version>  
<description>Agora Authentication</description>

利用RtcTokenBuilder2Sample.java生成了 Token （Token with uid)，该Token在辅助工具--Token校验工具中，是校验通过的。

【问题】  
前端代码在运行时，提示：  
AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: invalid token, authorized failed
出现问题的调用代码：
agoraClient.join(agoraPara.appid, agoraPara.channel, agoraPara.token)
【尝试过】  
已经检查过“客户端”join()的参数appId、chanel和“服务端”生成token时完全一致；
【疑问】  
1、是因为web-sdk版本和服务器authenticated的 maven版本不匹配导致的吗?  
2、我看论坛有些提及join方法需要加 uid为最后的参数，我也尝试过，加入后，不会提示 「invalid token, authorized failed」，但是直播画面是【黑屏】。
以上问题，烦请声网专家支持，不胜感激。

回答思维链：客户遇到了 invalid token的打印，这就是 token 不正确导致 join 失败了。加上用户的疑问，看起来不太了解 token 的工作原理，除了告诉客户如何自查 token 以外还可以介绍一下 token 的工作原理。

Reply:  您好，invalid token, authorized failed表示您 join 是传入的 token 和频道名、uid 不匹配，自己生成的 token 是要校验 uid 的，您需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道。

控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验
将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致

以及请保证 RTC 频道内的 uid 不重复，避免出现互踢情况。

---

# ID: 33752

SDK Product: RTC

SDK Version: 4.5.0

SDK Platform: Unity

Request type: 集成问题咨询

Request Description: Unity 使用 Agora_Unity_RTC_SDK_v4.5.0_VOICE SDK时，平台为VisionOS,打包Xcode工程进行编译时，会出现错误：  
Undefined symbol: _AddVideoFrameCacheKey
Undefined symbol: _CallIrisApi
Undefined symbol: _CreateIrisApiEngine
Undefined symbol: _CreateIrisEventHandler
Undefined symbol: _CreateIrisRtcRendering
Undefined symbol: _DestroyIrisApiEngine
Undefined symbol: _DestroyIrisEventHandler
Undefined symbol: _FreeIrisRtcRendering
Undefined symbol: _GetVideoFrameCache
Undefined symbol: _ILocalSpatialAudioEngine_ClearRemotePositions
Undefined symbol: _ILocalSpatialAudioEngine_ClearRemotePositionsEx

回答思维链：客户在尝试打包到 VisionOS 上使用，但使用的是 4.5.0 的官网版本。目前Unity 只有一个内部特殊版本适配了 VisionOS ，需要让人工工程师提供内部下载地址给到客户。

Reply:  您好，目前只有一个未上架官网的版本适配了 VisionOS，您稍作等待，人工工程师稍后提供下载地址为您解答。

---

# ID: 33748

SDK Product: RTC

SDK Version: 6.5.0

SDK Platform: Flutter

Request type: 集成问题咨询

Request Description: 目前根据文档集成了本地截图功能，但是没有上传成功且没有收到回调，目前不知道到底是客户端问题还是服务端问题，请问如何进行自查：  
已知：  
1. 回调地址能够正常访问  
2. 本地截图配置：
```
engine.enableContentInspect(enabled: true, config: const ContentInspectConfig(extraInfo: "test", modules: [ContentInspectModule(interval: 5, type: ContentInspectType.contentInspectSupervision)])) 
```

3. 打开后输出：
```
api name RtcEngine_enableContentInspect_e15e514 params "{"enabled":true,"config":{"extraInfo":"test","modules":[
{"type":2,"interval":5}
]}}"
和 
api name RtcEngine_enableContentInspect_e15e514 result 0 outdata
{"result":0}
```
4. 使用flutter集成，无dll问题

回答思维链：客户在使用客户端 SDK 的本地截图功能，虽然调用成功但是没有回调。需要确认下客户端 SDK 日志，以及让用户自查下网关是否有拦截情况

Reply:  您好，麻烦提供下复现时的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，人工工程师稍微排查下具体原因。以及您也可以自查下是否存在网关拦截的情况。

---

# ID: 33747

SDK Product: RTM

SDK Version: 2.1.2

SDK Platform: JavaScript

Request type: 集成问题咨询

Request Description: RTC成功了，音视频可以看到，RTM一直报错，排查uid、token应该也没发现不一致地方

RTM:ERROR [UTC_Time: 02:44:25.38][uid: 3*12]login failed with args:
{"tok":"00681c759d8f65042f9b0c32564671dd478IAADXpNcE3ebSiooiLtiuvfbLF+g/LAKjorEGH5aNejfK*"}
. +0ms

_MultiCameraControl.vue?t=1737081851336:304 rtm login error RtmInternalError: Cannot get illegal sid.  
at get sid (agora-rtm-2.2.0.min.js:27:1040009)  
at MutableReactiveHandler.set (chunk-O6NV3OV2.js?v=378681a1:1215:26)  
at Proxy.login (agora-rtm-2.2.0.min.js:27:1099248)  
at Proxy.login (agora-rtm-2.2.0.min.js:27:1135756)  
at i.value (agora-rtm-2.2.0.min.js:7:271685)  
at createTrackAndPublish (_MultiCameraControl.vue?t=1737081851336:297:36)

回答思维链：打印里有Cannot get illegal sid的错误，而且在用vue，根据过往经验有遇到过其他客户在vue3里面把 new RTM 返回值赋值给了 ref 类型，改成普通 let 就可以了，可以让客户先自查一下是不是这个问题导致的。

Reply:  您好，请问您这边在用 vue3 吗？我们之前遇到过其他客户也有类似的情况，最后发现是在vue3里面把 new RTM 返回值赋值给了 ref 类型导致的，改成普通 let 就可以了。您可以自查一下有没有类似情况。
如果无法解决的话，麻烦再提供下完整浏览器 console 打印，以及确认下 token、appid、userid 信息，人工工程师会为您继续排查。


---

# ID: 33744

SDK Product: RTM

SDK Version: 2.1.0

SDK Platform: Unity

Request type: 集成问题咨询

Request Description: 我测试直播，我的产品是用unity写的，一直都连接很好，但是创建项目你们版面都会不同，不知道我现在开的项目，测试直播填上了APID，没有影像，请问哪里出了错？

回答思维链：客户提供的信息较少，而且问题描述不够清晰，需要再确认下目前的具体现象和“创建项目你们版面都会不同”是什么意思，以及客户提交的问题产品是 RTM，但是有提到没有影像。可能也有用到 RTC ，需要一起确认下。

Reply:  您好，请问现在在用的产品是 RTC 还是 RTM？如果是 RTC 遇到了无法出图的问题，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [如何设置日志文件？](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

以及请问您反馈的“创建项目你们版面都会不同”具体是什么意思？麻烦也详细描述下这个现象，方便的话，麻烦提供截图，人工工程师稍后为您解答。

---

# ID: 33738

SDK Product: Cloud-recording

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询

Request Description: 麻烦帮忙查下在调用/v1/apps/%s/cloud_recording/resourceid/%s/sid/%s/mode/mix/query这个接口时，sid：b024c073b94e0419c10b53aef14bcb71
接口返回404，请问什么情况下会返回404-服务器无法根据请求找到资源（网页）？这些参数都是从声网获取的，为什么会404？

回答思维链：客户成功开启云端录制后调用 query 方法返回了 404，可以让客户先参考文档自查，然后等人工工程师查找对应sid 的记录看下具体原因：https://doc.shengwang.cn/faq/integration-issues/return-404

Reply:  您好，query 404 是被查询的录制任务不存在或已经结束了，您可以先对照[为什么成功开启云端录制后调用 query 方法返回 404？](https://doc.shengwang.cn/faq/integration-issues/return-404)自查一下，人工工程师稍后会查询 sid 的后台记录看下具体原因


---

# ID: 33714

SDK Product: RTMP

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询

Request Description: 在测试环境生成推流码，通过测试环境的域名 rtmp://rtls-ingress-test.agoramdn.com/live 一直推流不成功

回答思维链：客户选的是旁路推流，但问的问题是RTMP 网关，需要和客户再次确认下用的到底是哪个产品。如果是 RTMP网关的话，这个推流域名地址不应该有 test，正确的地址是 rtls-ingress-prod-{region}.agoramdn.com/live

Reply:  您好，请问现在在用的是旁路推流还是 RTMP 网关？这是两个不同的产品。如果是后者的话，需要注意：推流域名地址不应该有 test，正确的地址是 rtls-ingress-prod-{region}.agoramdn.com/live
参考文档：[使用 RTMP 网关](https://doc.shengwang.cn/doc/rtmp-gateway/restful/get-started/use-gateway)

---

# ID: 33707

SDK Product: RTM

SDK Version: 2.1.2

SDK Platform: JavaScript

Request type: 线上报错

Request Description: 聊天的服务,每个人都能在群里说话， 有人捣乱的话 在群里能够把他踢出去+能够把他说的话清除

回答思维链：客户需要踢人和清除聊天记录的功能，RTM 是不具备这些的，客户的需求更接近即时聊天，可以推荐客户用环信 IM 来实现

Reply:  您好，踢人和清除聊天记录的功能 RTM 本身不具备，您可以考虑下用即时聊天 SDK 来实现类似功能，比如[环信 IM](https://www.easemob.com/)

---

# ID: 33704

SDK Product: Recording

SDK Version: 其他版本

SDK Platform: Linux-Java

Request type: 线上报错

Request Description: 发现在录制过程中，有时候会出现调用stopService 返回-1的情况，导致结束录制出现异常

回答思维链：客户在用本地服务端录制，应该先引导用户用云录制，在客户明确拒绝后再尝试索要日志进行排查

Reply:  您好，有录制需求我们优先推荐用[云录制](https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page)

---

# ID: 33699

SDK Product: RTC

SDK Version: 4.4.2

SDK Platform: HarmonyOS

Request type: 集成问题咨询

Request Description: 鸿蒙的声网sdk。我在设置了这个enableLocalAudio(false)的时候，除了第一次回调了没有权限之后，我增加了权限之后，就没有回调了。

回答思维链：客户在用鸿蒙 SDK，但是没有说明“没有回调”具体指的是什么回调，需要确认下具体现象以及客户说的回调是哪个回调。并且收集日志以便稍后人工工程师解答，因为客户用的是鸿蒙 SDK，所以获取日志的方式是：hdc file recv /data/app/el2/100/base/packagename/haps/entryname/files

Reply:  您好，enableLocalAudio是控制本地音频采集的接口，设置为 false 以后就关闭采集了。请问现在的现象是接收不到哪一个回调？
以及有复现时的 SDK 日志吗？鸿蒙获取日志的方式为：hdc file recv /data/app/el2/100/base/packagename/haps/entryname/files，您可以完整描述下现象并且提供对应时间的日志，人工工程师稍后为您解答

---

# ID: 33698

SDK Product: RTC-Linux

SDK Version: 4.4.30

SDK Platform: Linux-Java

Request type: 集成问题咨询

Request Description: 这个sdk 在windows上可以使用吗

回答思维链：linux-java sdk 的使用环境必须是linux环境，window平台是不能使用的

Reply:  您好，linux-java sdk的使用环境必须是linux系统，如centos或者ubuntu；是不能再window上使用的

---

# ID: 33695

SDK Product: RTM

SDK Version: 其他版本

SDK Platform: JavaScript

Request type: 线上报错

Request Description: 调用rtmClient.login（）显示超时

回答思维链：客户可能在用 1.x 的老版本，可以先确认下版本情况，如果是的话要建议客户早日升级 2.x。以及 login 超时大概率是客户端自身网络连接有问题，可以让客户也自查一下是否能连接到公网，换一个网络再试试。

Reply:  您好，请问现在在用的 RTM 版本是多少？1.x 已经停止更新维护了，建议使用 [2.x 版本](https://doc.shengwang.cn/doc/rtm2/javascript/overview/migration-guide)
login 超时大概率和客户端网络有关，可以检查下客户端的网络状况，切换可以稳定连接公网的热点或者 wifi 再试试。

---

# ID: 33689

SDK Product: Cloud-Recording

SDK Version: 当前版本

SDK Platform: Restful

Request type: 线上报错

Request Description: 该云端录制未生成回放，麻烦看一下什么原因：  
sid:ad98e85fb842db158b928aa97908ec47  
channelName:course-e08f1d45

回答思维链：客户已经提供 sid 和频道名了，接下来等待人工工程师处理就够了。可以考虑再收集一下具体的录制时间点。

Reply:  您好，可以再确认下录制发送的时间点吗？人工工程师稍后为您排查

---

# ID: 33686

SDK Product: RTM

SDK Version: 2.2.0

SDK Platform: JavaScript

Request type: 集成问题咨询

Request Description: 我创建安卓应用，需要哪些合法域名，是否有限制

回答思维链：创建 app 不需要合法域名，如果客户本身在内网需要使用 RTM 服务的话是需要付费私有化部署并且使用代理的，可以和客户解释一下。

Reply:  您好，创建 app 不需要合法域名，但是需要能够连接到公网的网络。如果是内网环境会需要付费[私有化配置](https://doc.shengwang.cn/doc/rtm2/android/user-guide/setup/private-setup)并且使用代理才可以使用。


---

# ID: 33683

SDK Product: Cloud-Recording

SDK Version: 当前版本

SDK Platform: Restful

Request type: 效果不佳、不达预期

Request Description: 1、开始录制正常，停止录制在oss中为生成MP4格式文件；  
2、停止录制返回结果如下，payload显示Failed，具体结果如下：
{"cname":"123456","uid":"10002","resourceId":"VIFvR6qvdFkRNRDsj9uhhEgnjLZrTmUD8olvImTJYa2AG3nJ3sFuW56NIVBSlorjqUXA8NREU7o_0O_OqzHYDuRpxX7YoztodTrox6tqSFWRPhi4XUiGFbkgv7IlXV7aDq32wfE1NEXUXyz4kE4hJb9C3WS5p5XeFccuYVTdjmb34Bpgcr7O9fgz8CgVGB6Q","sid":"2354cf898b41b76d70850ba58b9b9ffb","code":49,"serverResponse":{"backuped":0,"fileListMode":"string","fileListStr":"quickstart/2354cf898b41b76d70850ba58b9b9ffb_123456.m3u8","gwWorkerVersion":1,"inProgressBitmask":1,"output":{},"payload":
{"message":"Failed"}
,"selectionBitmask":1,"subscribeModeBitmask":1}}
3、录制视频的账号key，secret非当前账号，是公司账号；

回答思维链：客户在云录制 stop 的时候遇到了 49 报错，根据错误码文档解释，这个是任务正在退出，不能进行当前操作，可能是重复调用 Stop 或者其他原因导致任务正在退出。常见的有录制机器人被剔出房间，或者没有用户发流触发 maxIdleTime 逻辑自动停止任务。可以让客户自查下是不是把频道内已有的 uid 分配给录制端了，导致录制端加入频道失败或者在频道内被踢出，从而出现了报错。

Reply:  您好，49可以参考[错误码](https://doc.shengwang.cn/doc/cloud-recording/restful/response-code#code)
您可以自查下是不是把频道内已有的 uid 分配给录制端了，导致录制端加入频道失败或者在频道内被踢出，从而出现了报错。录制端需要被分配一个频道内不重复的 uid，start 时候配置的 uid 是录制段加频道用的 uid，不是要录制哪个 uid。

---

# ID: 33679

SDK Product: RTM

SDK Version: 其他版本

SDK Platform: JavaScript

Request type: 效果不佳、不达预期

Request Description: "agora-rtm-sdk": "^1.5.1"  
监听rtm频道用户进入不触发，rtmChannel?.on("MemberJoined"）

回答思维链：客户用的还是 1.x 的 RTM SDK，这个版本已经不再更新维护了，应该推荐客户尽早升级到 2.x

Reply:  您好，您目前在用的是 RTM 1.x，这个版本已经停止更新维护很久了，建议尽早升级到 2.x ：[迁移指南](https://doc.shengwang.cn/doc/rtm2/javascript/overview/migration-guide)

---
# ID: 33677

SDK Product: RTC

SDK Version: 2.1.6

SDK Platform: RTC-Linux

Request type: 集成问题咨询

Request Description: 关于Python SDK的VAD功能：
1. 请问VAD v2和v1的主要区别是什么？v2目前是否稳定、能否直接用在生产环境？
2. 在使用v2 self._vad_instance = AudioVadV2(...)、self._vad_instance.process(audio_frame)接口之后，注册AudioFrameObserver时是否还需要传入enable_vad=True？这样会同时开启v2和v1吗？此时vad_result_state、vad_result_bytearray参数是否还有意义？
3. 请问VAD实时性如何？是在Python SDK所在设备上运行、还是在云端运行？像example中的实现一样，在callback中直接调用VADv2和写磁盘，是否会因为阻塞时间过长导致SDK运行不稳定？
4. 另外 能否麻烦更新一下文档（捂脸） 感觉最近上的很多新feature文档里都没有

回答思维链：客户在使用 Linux-Python SDK，但应该不是最新版本，可以优先推荐客户使用最新版本。问题 1 的答案是肯定的，SDK 每次发版都是经过测试验证的，可以让客户放心在生产环境使用。
问题 2 建议客户用一个就行了，v2 是 v1 的迭代版本，有一个在工作就行。
问题 3 就是实时性的，在设备上运行，可以让客户参考 Demo写法直接使用 vad_result_bytearray，不再需要自己去处理。回调里可以做抛出，然后在非主线程里进行调用来防止阻塞。
问题 4 是因为目前发版节奏比较快，所以官方文档迭代速度没有跟上导致的。可以让客户优先参考 README，README 里会记录每次发版的更新内容，以及一些新接口的介绍。同时也应该提醒后续跟进的人工工程师，让他注意到这个现象，去找负责文档的工程师看下要如何解决这个问题。

Reply:  您好，
1、最新版本支持多人 VAD 检测，发版出来的都是经过测试的正式版本，稳定可用。
2、不建议同时开启 1 和 2，用一个就行。
3、是实时性的，在设备上运行，参考Demo 写法，直接使用 vad_result_bytearray，不再需要自己去处理。回调里可以做抛出，然后在非主线程里进行调用来防止阻塞。
4、近期需求较多，迭代较快，资源紧张。后续会在 README 里添加更多描述和引导，同时也会内部推进下官网文档的更新。

---
# ID: 33662

SDK Product: Cloud-Recording

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询

Request Description: 我想python每隔2分钟检查一次实时互动RTC直播频道中主播是否在正常发流，如果没有正常发流 我需要触发无人机重新推流。请问有没有相关的api

回答思维链：客户提交的产品是云录制，但问的问题和云录制看起来不相关的，需要找客户再确认下现在到底在用什么产品。问题本身是 RTC 检测远端主播发流的，可以让客户在 Python 里监听on_user_video_track_state_changed回调，更具这个回调去判断频道里的远端视频流发送情况。因为Python官网文档有些滞后，需要让客户检查下 SDK 代码来完成回调监听，参考：https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/blob/12fcb294749875d19503c7a93f318f67da2b6187/agora_rtc/agora/rtc/local_user_observer.py#L73C9-L73C42

Reply:  您好，请问您这边是在用云录制还是 RTC？这个问题看起来是 RTC 监听远端发流状态的问题。Python SDK 可以通过监听里监听 on_user_video_track_state_changed 回调来了解远端发流状态，参考：[local_user_observer.py#L73C9-L73C42](https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/blob/12fcb294749875d19503c7a93f318f67da2b6187/agora_rtc/agora/rtc/local_user_observer.py#L73C9-L73C42)

---

# ID: 33658

SDK Product: CDN

SDK Version: 当前版本

SDK Platform: CDN

Request type: 效果不佳、不达预期

Request Description: 回调地址设置不上 报错如下
NCS 健康检查结果: Test Failed
f"success":false,"httpCode" 590,"eror":"Post
"https://gl.kmg-s.kz:31443/fre-eye/agora/notice\".
context deadline exceeded (Client.Timeout exceeded
while awaiting headers)","response":"

回答思维链：NCS 设置报错，通常都是回调地址不通，http证书异常等问题导致的，需要客户自查下

Reply:  您好，如果健康检查失败，请根据声网控制台的提示进行错误排查。常见的错误包括：

请求超时：你的服务器没有在 10 秒内返回 200。请检查你的服务器是否及时对事件回调作出正确的响应。如果响应正确，请联系技术支持
确认声网消息通知服务器到你的服务器之间的网络连接是否正常。
证书错误：HTTPS 证书错误。请检查证书是否正确。如果你的服务器受防火墙限制，请检查是否已将声网消息通知服务器的 IP 地址全部添加到防火墙白名单。
域名不可达：域名不合法，无法解析到目标 IP 地址。请检查你的服务器部署是否正确。
响应错误：你的服务器返回的响应状态码不为 200，具体的状态码和描述详见控制台提示。

---

# ID: 33651

SDK Product: Cloud-Recording

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询

Request Description: 请问mix（合流录制模式）下录制的视频为什么比例有很大的问题，展示视频画面就一点，其它的都黑屏，录制产生的文件路径为：xxx

一下是设置的参数；其中height和 width 无论设置成什么 最终录制的视频比例感觉都一样'recordingConfig' => [  
'channelType' => 0,  
'streamTypes' => 2,  
'streamMode' => 'standard',  
'videoStreamType' => 0,  
'audioProfile' => 1,  
'maxIdleTime' => 300,  
'subscribeAudioUids' => ["#allstream#"](https://jira.agoralab.co/browse/CSP-33651#allstream#%22 "Follow link"),  
'subscribeVideoUids' => ["#allstream#"](https://jira.agoralab.co/browse/CSP-33651#allstream#%22 "Follow link"),  
'subscribeUidGroup' => 0  
],  
'transcodingConfig' => [  
'height' => 1080,  
'width' => 1920,  
'bitrate' => 500,  
'fps' => 30,  
'mixedVideoLayout' => 0,  
'backgroundColor' => '#FF0000'  
],

回答思维链：客户应该合流录制转码后的画面布局不符合预期,目前客户在用的mixedVideoLayout是 0，可以让客户优先检查下这个布局的效果本身是否符合预期。以及让客户留下对应的 sid，方便人工工程师稍后解答

Reply:  您好，频道里发的流如果就是竖屏的，那录制出来就是竖屏的。如果需要变成有左右黑边的那种，需要单独配置转码或者自行用工具去转
您可以提供下这次录制的 sid，人工工程师稍后查看具体原因。以及您也可以看下合流布局的预设效果，看下mixedVideoLayout为 0 的效果是否符合预期。

---

# ID: 33650

SDK Product: Cloud-Recording

SDK Version: 当前版本

SDK Platform: Restful

Request type: 效果不佳、不达预期

Request Description: 正常录制视频是可以的，录制的是发起者的视频内容，但是我业务是想录制接收者的画面。
transcodingConfig 这个参数配置了以后 录制产生报错。  
想知道是为什么录制不成功。

回答思维链：客户在使用云录制，但对于云录制的理解似乎有些问题。云录制是往 RTC 频道里额外加一个录制机器人来录制画面的，没有“发起者”这个概念，不是用频道内的用户去甪直别人来实现的。需要和客户解释一下这个逻辑。
以及客户还提到了配置transcodingConfig后录制报错，需要确认下客户的具体参数内容和报错结果是什么。

Reply:  您好，云录制是往频道里额外加一个机器人对频道收流，所以没有“发起者”这个概念，频道里有流就全部录制的，请保证 start body 里的 uid 字段和频道里已有的 uid 不要重复。
以及请问您的transcodingConfig是如何配置的？报错内容又是什么呢？可以抓一下原始请求和结果，放在 txt里发到工单附件里，稍后人工工程师为您解答。

---

# ID: 33644

SDK Product: RTM

SDK Version: 2.2.0

SDK Platform: Object-C

Request type: 集成问题咨询

Request Description: rtm如何支持对方离线的时候，能够发送消息

回答思维链：客户想要用 RTM 在远端离线的时候发送消息。如果用点对点消息的话肯定会失败，所以无法实现。但如果用频道消息+客户自行实现历史消息业务的话，客户就可以在远端用户重新上线后获取离线期间的消息了。
以及客户目前在用 2.2.0 版本，2.2.2 版本上新增了 RTM 官方历史消息，如果客户升级到 2.2.2 后可以考虑使用官方的历史消息功能。

Reply:  您好，这个需求做不到，RTM 本身是实时消息传输的 SDK，对方不在线肯定是收不到的。
您说的这种算历史消息或者离线消息，需要自己业务侧实现。比如加一个服务端或者客户端进所有频道，保存所有发送的消息，用户重新上线后可以自行获取不在线期间的消息。
您也可以升级到 2.2.2 及以后的版本，RTM 官方支持了[历史消息](https://doc.shengwang.cn/doc/rtm2/android/user-guide/message/history-message)

---

# ID: 33643

SDK Product: RTM

SDK Version: 2.2.2

SDK Platform: Java

Request type: 集成问题咨询

Request Description: rtm中有没有后端java使用的sdk。 我们的环境是Linux-centos系统，java-maven- springboot

回答思维链：客户想要用 centOS 集成 RTM SDK，RTM 是有 Java 版本而且支持 centOS 的，可以给客户提供下文档地址

Reply:  您好，有的，支持 centOS，参考文档：[实现收发消息](https://doc.shengwang.cn/doc/rtm2/android/get-started/quick-start)

---

# ID: 33640

SDK Product: RTC-Linux

SDK Version: 2.1.6

SDK Platform: Linux-Python

Request type: 效果不佳、不达预期

Request Description: 在单人的时候vad可以检测到对话，但是加入多个用户之后vad忽然就无法检测了（频道里面一个人说话也无法检测）

VAD的设置我基本上参照了这里的代码 https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/blob/main/agora_rtc/examples/example_audio_vad.py

输入的配置类为 AudioVadConfigV2(16, 30, 50, 0.7, 0.5, 70, 70, -50))

回答思维链：这个是一个linux-python vad模式使用问题，客户反馈当人正常，多人vad无法检测；比较怀疑是vad用法问题，另外对于linux sdk来说，通常需要使用最新的版本；
Reply:  您好，您这边可以这样试下：
1、将linux-python sdk升级到最新的2.2.4版本，vad支持多人检测；
2、def on_playback_audio_frame_before_mixing(self, agora_local_user, channelId, uid, audio_frame: AudioFrame, vad_result_state:int, vad_result_bytearray:bytearray):

sdk会在这个回调里面返回vad的结果，使用uid来做区分不同的用户的结果。

---

# ID: 33638

SDK Product: RTC

SDK Version: 4.5.0

SDK Platform: Android

Request type: 集成问题咨询

Request Description: 你好，如果出海社交类APP想在海外市场使用实时转写和实时翻译，如中东和东南亚这些小语种地区，有几个问题请教一下，谢谢。
1、从成本和准确率指来说，推荐哪些自然语言处理产品啊？有相关的推荐数据吗？
2、你们有自研的RTT和云商店的微软、讯飞、云上曲率等自然语言处理插件，除自研的RTT外，第三方插件都是SDK直接对接第三方产品的服务器而不是由声网的服务去对接第三方产品的服务呢？
3、有自研RTT和云商店外的第三方转写和实时翻译的产品推荐吗？如果想接这些产品是APP直接对接，还是经过你们的SDK或服务端对接呢？

回答思维链：客户目前在选型转写+翻译能力产品，目前声网国内有云市场插件可以用第三方能力实现，海外有一个自研的 RTT 产品是 restful 方案的，比较方便，效果也不错，虽然国内没有上架但结合客户的场景来看应该会有出海需求，可以考虑让客户试用这个海外产品看下效果。可以给客户简单介绍下两个产品，然后邀请客户留下联系方式，方便后续人工工程师进一步场景确认和产品推荐。

Reply:  您好，
1、目前有云市场转写插件和自研 RTT 可以使用，前者是纯 Native 移动端方案，后者是 restful 方案。具体的数据建议您自行测试来得出结论，这样数据最准确。
2、云市场的插件都是通过封装第三方接口，在插件侧做参数透传，在第三方上实现转写的。需要注册第三方的账号以后才能使用。RTT 是声网自研restful方案，无需注册第三方账号信息，也无需额外集成 SDK。
3、RTT 目前只在海外官网上架了，但是服务全球可用，可以看下这个文档：[REST quickstart](https://docs.agora.io/en/real-time-stt/get-started/quickstart)。
Demo 参考：[RTT Demo](https://stt-demo.agora.io/#/home)

您可以先试下这两个产品的效果，我作为 AI 助手不方便直接推荐，您可以再介绍下完整场景，留个联系方式，方便人工工程师晚些时候和您语音沟通。

---

# ID: 33617

SDK Product: RTC-linux

SDK Version: 4.4.30

SDK Platform: Linux-C

Request type: 集成问题咨询

Request Description: 1. 我看sdk接受pcm流之后只有通道数，采样率这些信息，pcm的sample_fmt是什么呢？
对应到ffmpeg中是
enum AVSampleFormat {
AV_SAMPLE_FMT_NONE = -1,
AV_SAMPLE_FMT_U8, ///< unsigned 8 bits
AV_SAMPLE_FMT_S16, ///< signed 16 bits
AV_SAMPLE_FMT_S32, ///< signed 32 bits
AV_SAMPLE_FMT_FLT, ///< float
AV_SAMPLE_FMT_DBL, ///< double

AV_SAMPLE_FMT_U8P, ///< unsigned 8 bits, planar
AV_SAMPLE_FMT_S16P, ///< signed 16 bits, planar
AV_SAMPLE_FMT_S32P, ///< signed 32 bits, planar
AV_SAMPLE_FMT_FLTP, ///< float, planar
AV_SAMPLE_FMT_DBLP, ///< double, planar
AV_SAMPLE_FMT_S64, ///< signed 64 bits
AV_SAMPLE_FMT_S64P, ///< signed 64 bits, planar

AV_SAMPLE_FMT_NB ///< Number of sample formats. DO NOT USE if linking dynamically
};
是哪个枚举呀

回答思维链：通过问题描述看，客户想咨询linux sdk 音频自采集接口相关功能；这里涉及到sendAudioPcmData()接口的使用，以及与FFMPGA的AVSampleFormat 之间的使用关联

Reply:  您好，对应声网sdk来说，pcm都是16位的，即2个字节，对应的是bytes_per_sample这个字段。

---
