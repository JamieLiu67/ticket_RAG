
# ID: 39026

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 使用安卓sdk开启屏幕共享推流时，视频流卡住不动

Reply: 麻烦提供下具体的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，说明什么时间点复现的，以及具体现象是哪个 uid 看哪个 uid 卡顿。
同时也可以对比下我们的 [屏幕共享 Demo](https://github.com/Shengwang-Community/API-Examples/blob/main/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/ScreenSharing.java) 是否正常。

---
# ID: 39029

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 设备是linux嵌入式设备，使用的RTSA的SDK版本已经是1.9.7了，推流的视频是H265格式的，问题就是在手机App端看到设备的画面偶尔会有花屏马赛的现象，设备和手机的网络正常，网速尚可，且设备端的推流的视频帧有测试在发送到声网SDK前保存到本地，没有发现有马赛克花屏的现象

Reply: 麻烦清空下 Android、RTSA 设备的[日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)路径，然后复现下问题，拿一下最新的日志，我们看下是 RTSA 编码上有问题还是 RTC 接收端解码的问题。

---

# ID: 7

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.5.2.5

Request Type: 线上问题

Request Description: Windows平台在使用RTC SDK进行物理摄像头采集时出现卡顿。设置了以下两种视频编码配置进行对比：
竖屏分辨率：720x1280 @ 30fps → 出现本地预览卡顿。
横屏分辨率：1280x720 @ 30fps → 预览流畅，无问题。

Reply: 如果问题平台是 Android 或 Windows,建议让声网工程师检查下 SDK 日志里`Best camera format` 的打印里选择的分辨率帧率组合是否符合预期。
如果摄像头本身不支持高帧率的竖屏分辨率。SDK会自适应，尝试从能力列表中匹配一个能够满足或超过此分辨率要求的配置。可能会选择一个在像素数量上更高但帧率极低的配置作为“最接近”的匹配，从而导致预览卡顿。

解决方案
1. 更换摄像头硬件：更换为支持所需竖屏分辨率帧率组合的摄像头设备。
2. 应用层预检查与提示：在设置视频参数前，通过SDK接口`numberOfCapabilities`和`getCapability`获取摄像头支持的能力列表。主动比对业务期望的组合。如果期望的配置不存在，则提前向用户提示，或自动推荐一个可用的最佳替代配置（例如使用横屏模式，或降低竖屏分辨率/帧率）。
3. 运行时监控与反馈：在视频流运行过程中，通过`onLocalVideoStats`回调监控本地的`captureFrameRate`、`captureFrameWidth`和`captureFrameHeight`。如果检测到实际采集帧率远低于应用设定的目标帧率，可在应用界面给出提示，例如：“当前摄像头不支持流畅的竖屏拍摄，建议切换为横屏模式或调整分辨率”。

---
# ID: 8

SDK Product: RTSA

SDK Platform: ESP32

SDK Version: 1.9.6

Request Type: 集成问题

Request Description: ESP32 编译aosl库lwip_gethostname接口报错，提示缺少“`celt_encode_with_ec、ec_enc_done、pitch_search'” 实现

Reply: 原因是因为ESP-IDF 的构建系统（CMake + ld）默认只把“被引用到”的目标文件从 .a 里抽出来。如果 lwip_gethostbyname() 没有任何“显式引用”，ld 就会把它当成“没人用”而丢弃，结果第三方静态库再去引用时就报 undefined reference。 (因为 aosl 库是另外编译的，在这个工程直接用了 libaosl.a 库文件，但在当前整个工程源文件中没有调用 lwip_gethostbyname() )

解决方案是强制链接进来，在 CMakeLists.txt 中加入以下内容即可：
```
idf_component_get_property(lwip_lib lwip COMPONENT_LIB)
target_link_libraries(${COMPONENT_LIB} PUBLIC "-u lwip_gethostbyname" ${lwip_lib})
```


---

# ID: 39001

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 咨询一下价格 跟集成方式

Reply: 融合 CDN 计费文档参考：[融合 CDN 直播计费](https://doc.shengwang.cn/doc/fusion-cdn/restful/overview/billing)
具体报价可以咨询您的对接销售 声网 console 左侧边栏-设置-工作空间设置里拨打销售负责人的手机号
CDN 没有什么集成一说，主要是配置域名来获得推拉流地址，参考[开始融合 CDN 直播](https://doc.shengwang.cn/doc/fusion-cdn/restful/get-started/quick-start)

---
# ID: 39004

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 集成问题咨询

Request Description: flutter中集成的agora_rtc_engine语音通话功能：
1、在于语音过程中佩戴耳机听不到声音，把耳机从耳朵上拿下来再带回去就正常了，大多人都能复现，是什么原因，是否有相关的配置或者监听方法；
2、部分人在语音中戴了耳机，但是用不了耳机的麦克风，因为戴着耳机说话不能离手机太远，远了就听不清，所以判断是他只能用手机的麦克风，麦克风是否有相关的配置或者监听方法

Reply: 可以参考下 flutter [发版已知问题](https://doc.shengwang.cn/doc/rtc/flutter/overview/release-notes)
 AirPods Pro 不支持在通话音量模式下使用 A2DP 协议，可能会导致该设备在该模式下无法成功连接。
您这边先[设置 scenario](https://doc.shengwang.cn/api-ref/rtc/flutter/API/toc_audio_basic#api_irtcengine_setaudioscenario) 走 gamestreaming，强制走媒体音量试试呢

---
# ID: 39005

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 如果发生 Webhook 回调事件未接收到的情况会怎么办呢?

Reply: 不会重新投递，如果全丢了那就丢了的，这点需要注意，不能让业务强依赖 Webhook 事件，只能做个参考
不过 Webhook 本身是一个事件发送多次的，如果只是其中一个丢失了也问题不大，还有多个重复的事件可以被收到

---
# ID: 39006

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: iOS中语音通话中如何获取双方的音频数据，视频通话中如何获取视频数据和音频数据

Reply: 如果需求是录制通话内容，我们推荐用[云录制](https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page)
如果只是要拿裸数据出来处理，参考[原始音频数据](https://doc.shengwang.cn/doc/rtc/ios/advanced-features/raw-audio-data)

---
# ID: 39007

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 线上报错

Request Description: `/open-api/v2/iot-core/secret-node/device/activate` 接口不能返回正确的字段？
`Content type 'application/octet-stream' not supported for `

Reply: `/open-api/v2/iot-core/secret-node/device/activate`这个请求 url 看起来属于一个已经废弃的产品，不建议继续使用。
如果您是 IOT 场景，我们推荐集成 [RTSA SDK](https://doc.shengwang.cn/doc/rtsa/c/landing-page)

---

# ID: 5

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 线上问题

Request Description: 在 Web 端观看远端视频流时，视频画面会卡住约 10 秒钟，之后自动恢复正常。
    * 接收端日志中出现关键错误：RECV_VIDEO_DECODE_FAILED (code: 1005)。
    * 受影响浏览器/环境：Windows Edge 浏览器、Android WebView

Reply: 原因：动态创建 / 挂载 / 清理视频渲染视图的 DOM 操作，在 Edge/WebView 等浏览器中引发解码器异常（错误码 1005），解码失败导致画面卡顿。
方案：应用初始化时预创建视图容器，全局静态复用，避免重复 DOM 操作。
反馈：已向 Chrome 提交 [issue](https://issues.chromium.org/issues/464296300)

---
# ID: 6

SDK Product: RTC

SDK Platform: 所有平台

SDK Version: 所有版本

Request Type: 线上问题

Request Description: 初始化和加频道时 token 对应的 appid不一致时，会获取不到配置下发。

Reply: 初始化和加频道时 token 对应的 appid不一致时，SDK 会用后者对应的 appid 来加频道，但是配置下发参数是根据初始化 SDK 时配置的 appid 来生效的，因此会导致配置下发后不生效。

---
# ID: 38969

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 需求：我的sip电话,  想接入agora上，对接智能体。

Reply: 您好，目前声网没有对外开放的 SIP 产品，如果您的需求是 AI 外呼，可以考虑使用我们 console 上对外开放的Call Center 来实现，需要体验的话请先电话联系：400 6326626

---
# ID: 38970

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.5

Request Type: 效果不佳、不达预期

Request Description: 4G模式下会报下面的错误，请问这一般是什么问题引起的
```
[1769235825.010][wrn][snd_aud][handle_PAudioRexferReq_v2:568] 205 calls suppressed
[1769235825.010][wrn][snd_aud] audio rexfer req can't be handled, seq 2235
[1769235825.013][wrn][snd_aud] audio rexfer req can't be handled, seq 2236
[1769235825.019][wrn][snd_aud] audio rexfer req can't be handled, seq 2237
```

Reply: 这个打印本身不代表什么错误，可以忽略，请问现在有什么不可用现象吗？如果有的话可以拿一下 INFO 级别的完整日志发来看看

---
# ID: 38971

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.5

Request Type: 集成问题咨询

Request Description: 想咨询一下一个应用场景，RTSA是不是有个广播模式（一对多）， 比如一个通道能支持多少听众，有数量限制吗

Reply: 您好，RTSA 的通话是在 RTC 频道实现的，RTC 本身是支持一个频道多主播的，但一般来说 IOT 的 1v1 场景多一些
一个 RTC 频道同时发音频流的上限 32 人，发视频流上限 17 人，观众人数没有上限

---
# ID: 38981

SDK Product: IM

SDK Platform: iOS

SDK Version: 1.3.2

Request Type: 线上报错

Request Description: `messagesDidReceive`怎么获得具体的消息内容，怎么解析的

Reply: 您好，请问有参考过这篇[发送和接收消息](https://im.shengwang.cn/docs/sdk/ios/message_send_receive.html)吗？在 `AgoraChatManagerDelegate` 注册监听回调，收到消息的时候就会自动触发了
然后直接从回调里拿文本内容就行，其实没有解密这一步

---
# ID: 38988

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 互动连麦中拉二胡然后其它用户听不到声音，当时错误配置 RtcEngine::setAudioScenario(this:0x7e1e341400, {"scenario":1})。后续wx沟通说需要配置GAME_STREAMING模式，修改测试后来回切换两模式在模拟环境中（播放二胡音乐）都能听到音乐-感觉两模式差别不大。请问这是为什么呢？
api枚举中scenario只支持default：0，gamestreaming：3，chatroom：5。那我之前旧版本错误配置1的话会自动生效成default：0吗？

Reply: gamestreaming 走的是媒体音量，回声消除和降噪都会走软件算法处理；chatroom 会走通话音量，用的都是硬件算法，用 GS 的话可以避免本地音量输入过大被当成噪音消除的情况：[如何区分媒体音量和通话音量？](https://doc.shengwang.cn/faq/integration-issues/system-volume)

具体的枚举参考文档[setAudioScenario](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#setAudioScenario)，配置了不存在的枚举默认还是走 0 default

---
# ID: 38995

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 你好，我要在树莓派上运行webrtc。应该用那个版本的sdk？windws版本下的c++行么？树莓派是arm64的

Reply: Web SDK 只看浏览器版本，和硬件没什么关系，只要所用的[浏览器支持](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility) WebRTC 就行

---

# ID: 38956

SDK Product: RTC

SDK Platform: MacOS

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: 如何设置声纹识别功能，是否需要申请开通账号权限。

Reply: 您好，声纹识别是 [convoAI](https://doc.shengwang.cn/doc/convoai/restful/convoai/operations/start-agent) 的能力，启动时配置 sal 字段里的内容即可

---
# ID: 38958

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.1

Request Type: 其他问题

Request Description: 企业支付，应该冲到这个账户，怎么冲到另外的账户了？

Reply: 您好，充值类商务问题可以直接咨询您的对接销售，声网 console 左侧边栏-设置-工作空间设置里拨打销售负责人的手机号

---
# ID: 38961

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 崩溃（闪退、卡死）

Request Description: 	AgoraAudio_iOS升级到 ShengwangRtcEngine_iOS 之后，加入频道之后，无法使用carplay，正在连接的carplay也会被挤掉，怎么处理

Reply: 我们 SDK 互通时需要 playandrecord 权限，但 CarPlay 本身不支持这个模式，所以无法加频道以后使用。参考[CarPlay-Developer-Guide](https://developer.apple.com/download/files/CarPlay-Developer-Guide.pdf)

---
# ID: 38963

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 我的项目目的是做一个企业内部使用的AI自动发起，通过语音对话实现知识点考核的APP。我想咨询是否可以后台发起，离线唤醒自定义的APP,将对话式AI和语音通话项目对接实现？是否可行？

Reply: 离线唤醒 app 的能力 SDK 不提供，需要您自行实现，其他的可以通过用 convoAI 实现

---
# ID: 38964

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 我有个知识库，想集成到对话式AI引擎，基于指定的知识进行回答，这个应该怎么做

Reply: LLM 本身配置好 RAG 就行，然后在 convoAI 里确保调用的是带了 RAG 的 LLM 就可以用了

---
# ID: 38965

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 集成问题咨询

Request Description: 1、对话式 AI 引擎，可以替换成自定义的asr服务么。替换后，还可以使用优雅打断功能么？
目前我有一个和硬件绑定的asr多模态方案，硬件有麦克风和摄像头，只有识别到人脸，说话才会进行语音识转换。调用时通过ws连接局域网IP地址，实时获取asr的识别结果（流式音频数据和文字数据）。

2、对话式 AI 引擎，是否可以实时获取到tts合成的原音频数据？

Reply: 1、ASR 只能选我们固定的几家，枚举范围外的不支持，参考[创建对话式智能体](https://doc.shengwang.cn/doc/convoai/restful/convoai/operations/start-agent)
2、不支持，convoAI 是封装好的业务，tts 生成语音以后是直接发进 RTC 频道里的，如果有需要可以加入 RTC 频道订阅远端音频流然后 dump 到本地。请问您这边是什么使用场景和业务需求需要拿 tts 的数据？

---
# ID: 38966

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 开通权限、提供配额

Request Description: 我这边测试报错：CDN推流启动失败：`AgoraRTCError UNEXPECTED_RESPONSE: live streaming app center error, code: 400, reason: invalid_appid (17:00:29)`

Reply: 您好，[融合 CDN](https://doc.shengwang.cn/doc/fusion-cdn/restful/get-started/enable-service) 是直接再 console 配置开通的，请确保已经手动配置过域名和推拉流地址了。以及如果您有调用客户端直推 CDN 接口的话请避免，这个接口已经很久没维护了，不推荐使用。

---

# ID: 3

SDK Product: RTMP网关

SDK Platform: restful

SDK Version: 当前版本

Request Type: 集成问题

Request Description: 调用rtmp网关产品，delete接口销毁推流码，正在推流的直播会结束吗？

Reply: 不会。销毁后，你无法再使用该推流码进行推流。但如果推流码正在使用中，销毁推流码并不会影响当前正在推送的流。如果要立即禁用该条流，需参考[使用 SID 强制断开在推流 API](https://doc.shengwang.cn/doc/rtmp-gateway/restful/rtmp-gateway/operations/delete-region-v1-projects-appId-rtls-ingress-online-streams-sid)

---
# ID: 4

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.5.2.8

Request Type: 集成问题

Request Description: rtc sdk 和 环信im 报aosl.xcframework库冲突，打包报错内容如下：
```
dyld config: DYLD_LIBRARY_PATH=/usr/lib/system/introspection
DYLD INSERT LIBRARIES=/usr/lib/libLogRedirect
.dylib:/usr/1ib/libBacktraceRecording.dylib:/usr/lib/libMainThreadchecker
dvlib:/usr/lib/libRPAc,dylib:/usr/lib/libviewDebuggersupport
.dylib:/System/Library/PrivateFrameworks/GPUToolsCapture
.framework/GPUToolscapture
```

Reply: 声网 iOS 4.5.2.8 的aosl.xcframework库版本比环信IM 的aosl库版本高；
故需要再podfile里删除环信IM低版本的aosl库，保留声网的高版本的aosl才行
参考文档：[如何处理同时集成 RTM SDK 和 RTC SDK 遇到库冲突问题？](https://doc.shengwang.cn/faq/integration-issues/rtm2-rtc-integration-issue#rtm-222-%E4%B9%8B%E5%89%8D%E7%89%88%E6%9C%AC)

---
# ID: 38946

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 声网有没有什么方案支持语音转文字? 比如在线会议的会议纪要等场景情况下

Reply: 您好，目前有一个还没有正式上架国内官网的[实时转写翻译服务](https://doc-internal.shengwang.cn/doc-new/stt_v7/doc/speech-to-text/restful/landing-page)，但没有会议纪要能力。
需要开通试用的话需要先联系销售申请，没有销售的话可以先电话沟通：400 6326626

---
# ID: 38948

SDK Product: RTC-Linux

SDK Platform: Linux-C

SDK Version: 4.4.32

Request Type: 集成问题咨询

Request Description: 请问下,有关音频的 回声/消噪 相关的功能, 能通过什么方式来设置和查询吗? 

Reply: 您好，服务端 SDK 没有专门设置回声消除的接口，SDK 里内置了回声消除的算法，默认是开启的

---
# ID: 38951

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 2.6.5

Request Type: 其他问题

Request Description: 小程序的后台用Java，我怎么生成房间Token呢？有无支持的Maven包

Reply: 您好，当前声网的maven库已经没有在进行更新了，不推荐使用
现在的推荐做法就是参考[使用 Token 鉴权](https://doc.shengwang.cn/doc/rtc/mini-program/basic-features/token-authentication)，把文档里给出示例代码的 github 仓库 clone 到本地，用里面的脚本去本地运行生成token使用


---
# ID: 38952

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: 开通在线ktv 权限

Reply: 您好，在线 KTV 版权曲库开通请填写[音集协-国内曲库-客户报备问卷](https://my.feishu.cn/share/base/form/shrcndHOoIbgMQLoCsEyDeDQhne)然后同步销售

---
# ID: 38955

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.1

Request Type: 效果不佳、不达预期

Request Description: 有没有远端用户镜像的相关api，现在setRemoteRenderMode过期了也无法达到效果


Reply: [setupRemoteVideo](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_video_rendering#api_irtcengine_setupremotevideo) 就是用来控制远端画面在本地渲染是否镜像的接口

SDK 只能控制用户在本地渲染别人或编码发送自己画面时候是否开启镜像，没有办法遥控远端改编码镜像的，如果您说的现象就是本地已经设置了远端画面为镜像渲染，但看到的还是非镜像的，麻烦录个现象视频+提供出现问题时双方的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，说明是哪个 uid 看哪个 uid 有问题

---

# ID: 38935

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 首次join慢
```
15:35:05:352 Agora-SDK [DEBUG]: [client-8ed4b] Connect to backup choose_server: https://webrtc2-ap-web-3.agora.io/api/v2/transpond/webrtc?v=2
vconsole.min.js:10 15:35:05:362 Agora-SDK [DEBUG]: [client-8ed4b] Connect to backup choose_server: https://webrtc2-4.ap.sd-rtn.com/api/v2/transpond/webrtc?v=2

vconsole.min.js:10 15:35:09:213 Agora-SDK [WARNING]: [client-8ed4b] multi unilbs network error, retry AgoraRTCException: AgoraRTCError NETWORK_TIMEOUT: timeout of 5000ms exceeded
    at http://localhost:4173/tiyan/connect-web-component/assets/index-BmwQN5NM.js:2:1834491
e.callOriginalConsole @ vconsole.min.js:10
```

Reply: 您好，`multi unilbs network error`表示多出口网络错误，因您所使用的网络是多出口网络，网络环境本身就容易导致连接我们节点时不够稳定从而增加耗时
建议您更换不同网路环境再多尝试看看，若还是无效再麻烦开启[日志上传](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，然后提供频道信息

---
# ID: 38937

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 商务问题

Request Description: 我开启云端录制，每次录制完成需要将数据传递给数美进行审核。我如何知道本次录制是否完成呢？且会持续录制，没次录制都要传递给数美。

Reply:
1、云录制的内容全部上传完成后会有 [webhook 事件通知](https://doc.shengwang.cn/doc/cloud-recording/restful/webhook/uploading#31-uploaded)，可以从这里判断。
2、如果要审核 RTC 频道里的内容一般不依赖云录制来实现，建议直接和审核厂商对接，优先推荐网易易盾，如果您已经和数美对接了可以咨询下数美的技术支持有没有办法直接实现。

---
# ID: 38941

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 我们推流端和拉流端应该是都没有音频，想了解一下音频的消耗是如何产生的

Reply: 您好，只要加入频道没有产生视频订阅就会计算音频时长，这是我们的[计费策略](https://doc.shengwang.cn/doc/rtc/javascript/billing/billing-strategy)

---

# ID: 38924

SDK Product: IM

SDK Platform: iOS

SDK Version: 1.3.2

Request Type: 其他问题

Request Description: `ShengwangChat-UIKit-ios`
我看这个只有ios的swift版本，有OC多版本吗？android有Java的版本吗

Reply: 您好，声网 IM 的 UIkit 只有 swift 和 KT 版本的，没有 oc 和 java

---
# ID: 38925

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 旁路推流 打算购买aliyun的CDN。应该买哪种类型的呢？

Reply: 旁路推流只需要一个 RTMP 地址来收流，具体 CDN 买哪种可以咨询下提供商，问下他们哪种是一个推流地址一个拉流地址的。
或者也可以直接使用我们的融合 CDN，不过我们没有测试 CDN 地址，需要您用自己的域名在声网 console 上配置来使用。

---
# ID: 38929

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.5

Request Type: 崩溃（闪退、卡死）

Request Description: 芯片平台：ESP32-S3(idf v5.5.2)
SDK版本：agora-iot-sdk-1.9.5-esp32s3-idf5.x-20250626
问题描述：移植完成后运行会崩溃，主要体现在调用 agora_rtc_init() 时，SDK 内部似乎会调用 xTaskCreateRestrictedPinnedToCore()，在这里出现问题。在 idf 5.5.2 是没有 xTaskCreateRestrictedPinnedToCore 这个函数实现的，请问应该怎么解决？

Reply: 您好，我们的 `agora-iot-sdk-1.9.5-esp32s3-idf5.x-20250626` 包没有适配过 5.5.2，请不要使用，改回 IDF5.2.3

---
# ID: 38930

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 我这边的设备比较棘手，需要浏览走一次本地代理，例如`127.0.0.1:XXXXX`然后出去，包括接收也是需要这样子转发，请问声网有现成的接口吗？

Reply: 我们 Native 端sdk4.5.0 以上支持socks5代理，可以通过私有参数api配置socks5代理服务器，文档里是示例，改成您自己的socks5代理服务器地址就行了
参考下[Http/Https/socks5代理](https://i46hiqvame.feishu.cn/wiki/KK7xwdMm6iBctPkY8YKcYATln4f?from=from_copylink)

---

# ID: 38908

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 报错：
请求失败: 500
`{"detail":"core: edge failed, reason: 'NoneType' object has no attribute 'output_modalities'","reason":"InternalServerError"}`

Reply: 您好，请检查下目前使用的网络是否能访问公网，我们的服务需要公网使用。以及确保 ASR、LLM、TTS 信息都有填写，如果还有问题麻烦将原始 curl 请求放在 txt 中发来

---
# ID: 38920

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 我们有一个新的业务场景，需要打通本地内线电话系统与 Agora RTC 频道。为了评估技术可行性，特向贵方咨询关于 SIP Gateway (或 SIP Connect) 功能的支持情况。

Reply: 您好，声网目前没有 SIP 的相关对接产品，有这类需求可以去咨询下小樱桃 PSTN，集成他们的 SDK 来使用

---
# ID: 38921

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 集成问题咨询

Request Description: 想问下咱们有没有linux服务端sdk，用于服务端进行进房推拉流，类似进行转推用途。然后有python版本的sdk吗？想跟livekit agent进行对接，不知道有没有相关的案例。

Reply: 有[服务端 SDK](https://doc.shengwang.cn/doc/rtc-server-sdk/python/landing-page)，但是只能在我们的 RTC 频道内进行传输，没有办法和 `livekit` 打通的，建议使用我们的 [convoAI](https://doc.shengwang.cn/doc/convoai/restful/landing-page)

---

# ID: 38874

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.5.0

Request Type: 其他问题

Request Description: 我们目前平台有一些IOS用户返回在房间类麦克风在使用过程中，如果微信来了新消息不会有任何消息推送通知。这是因为什么原因呢？

Reply: 您好，这个和我们 SDK 没有直接关系，建议排查下 IOS 消息推送机制，微信的消息通知是微信和苹果消息推送实现的，我们 SDK 不可能影响消息推送机制的

---
# ID: 38876

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.2

Request Type: 集成问题咨询

Request Description: 我这边想咨询一下，使用声网的Android SDK、IOS SDK、鸿蒙SDK，是否可以与开源的Janus Gateway实现对接？

Reply: 声网的 WebSDK 是基于开源 webrtc 协议封装的私有协议，无法和其他协议直接互通。如果您考虑用 rtmp 协议的话，可以用 [RTMP 网关](https://doc.shengwang.cn/doc/rtmp-gateway/restful/landing-page)产品来把流推进 RTC 频道里。
要从 RTC 频道里把画面拿到 RTMP 流里，需要用[旁路推理](https://doc.shengwang.cn/doc/media-pull/restful/landing-page)

---
# ID: 38877

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 你好 我想咨询一下 客服端可以支持外部流媒体吗 比如rtmp或者rtsp作为采集端 然后进行相关推送

Reply: 可以用 [RTMP 网关](https://doc.shengwang.cn/doc/rtmp-gateway/restful/landing-page)产品来把流推进 RTC 频道里。

---
# ID: 38878

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 我们这个一对一的视频通话进行过程完全正常。但最终结果.ts文件和.m3u8文件写入阿里云OSS的情况出现问题。从阿里云OSS的文件列表来看，.ts文件不完整，缺失了好多个。.m3u8文件正常。

这个问题之前在我们其他的面试视频中也曾经出现过，但最终过了一天之后，所有文件都出现并且完整。

我们想了解两个问题：
1. 这种问题出现的原因是什么？我们要如何能够改善？
2. 因为这次这个通话视频我们非常紧急需要使用，几个小时内我们要提交这个视频。能否烦请您们技术工程师帮忙在后台先手动获取后发送给我们？谢谢。

Reply: 如果存在部分云录制切片丢失情况，可以检查下是否存在发起录制的地区和最终录制上传的 OSS `region` 不同的跨区情况，跨区就容易出现这种部分切片上传超时需要重试的情况。

---
# ID: 38880

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.1

Request Type: 其他问题

Request Description: 1、h264格式 码流数据，通过`pushExternalEncodedVideoFrameById` 方法推流 返回的Int为`[-2]`，但在控制台上有时间扣除
2、推流时，在声网WEB Demo上未能显示。
具体看附件

Reply: 您好，Android SDK 上不支持用自采集发送 h264 格式的实时流，请完整介绍下您目前的业务需求和场景，寻找替代方案。

---
# ID: 38882

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.3.2

Request Type: 集成问题咨询

Request Description: 请问你们有提供根据音频生成文字纪要的功能吗，如果有的话怎么开通收费

Reply: 您好，目前有一个还没有正式上架国内官网的[实时转写翻译服务](https://doc-internal.shengwang.cn/doc-new/stt_v7/doc/speech-to-text/restful/landing-page)，但没有会议纪要能力。
需要开通试用的话需要先联系销售申请，没有销售的话可以先电话沟通：400 6326626

---
# ID: 38885

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 线上报错

Request Description: 一个阿拉伯的用户，加入房间一直失败，日志上看onConnectionStateChanged 多次回调 state 4 reason 14，同时会打印 AGORA_SDK: vpnInUse is false 日志

Reply: 您好，沙特、中东地区如果使用 3.x SDK 频繁反馈有用户加入频道失败的话，建议升级到最新的 3.x Weekly 版本再试试，看下还会不会复现。
参考[3.x Weekly Hotfix 发版说明](https://docs-preprod.agora.io/cn/video-legacy/weekly_hotfix?platform=iOS)
如果升级后还有问题，麻烦提供具体的客户端 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---
# ID: 38888

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 集成问题咨询

Request Description: 灵动课堂的 websdk 是否能够直接在uniapp中使用，我的app是uniapp，想使用灵动课堂的能力，不知道是否支持？

Reply: 您好，灵动课堂不支持 uni-app 方式集成

---
# ID: 38895

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.5.1

Request Type: 其他问题

Request Description: 提交googleplay时,提示库`base/lib/arm64-v8a/libAgoraRtcWrapper.so`不支持16KB

Reply: 官网的版本没有更新，这可以使用这个[支持 16kb 的 Unity 4.5.1 full](https://download.agora.io/sdk/release/Agora_Unity_RTC_SDK_4.5.1_FULL_20250617_468_build.5.zip)
或者[支持 16kb 的 Unity 4.5.1 full](https://download.agora.io/sdk/release/Agora_Unity_RTC_SDK_4.5.1_VOICE_20250617_471_build.5.zip)

---
# ID: 38899

SDK Product: RTC-Linux

SDK Platform: Linux-Python

SDK Version: 2.2.4

Request Type: 集成问题咨询

Request Description: 有没有国内的Web Demo？

Reply: 您好，国内 Web Demo 用 [Web Demo](https://webdemo.agora.io/index.html)

---

# ID: 38863

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.2

Request Type: 集成问题咨询

Request Description: 我们项目是flutter实现的，纯鸿蒙实现界面太复杂，如何能把画面通过PlatformView传到flutter层去实现画面显示？

Reply: 您好，我们的 flutter SDK 不支持在鸿蒙 SDK 上运行，目前也暂无计划适配

---
# ID: 38864

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 我们软件主要使用在内网环境，需要为音视频通话开放地址白名单，麻烦提供一下接口请求的外网地址

Reply: 您好，要在内网使用 RTC 需要付费开通[云代理](https://doc.shengwang.cn/doc/rtc/android/basic-features/firewall)服务，请先联系销售获取报价

---

# ID: 38847

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: 对话式 AI 引擎 ，ASR LLM 豆包模型，欧洲，美国也都支持吗

Reply: 您好，对话式 AI 引擎只是把指定的 LLM 加入到 RTC 频道里互通，RTC 频道里的用户在全球都可以用，LLM 在哪里无所谓，因为最后语音交互都是在 RTC 频道里实现的

---
# ID: 38849

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 集成问题咨询

Request Description: 您好，请问下为什么我们使用你们提供的python sdk,参数复制到你们提供的示例里面是可以用的，但是使用你们的sdk就不能用，后面换了个token就都可以用了，并且偶尔不稳定呢 ，请问是什么原因呢

Reply: 您好，关于您遇到的 Token 问题，建议按以下步骤排查与优化：
1、更换 Token 前缀：
建议使用 007 开头的 Token。006 开头的 Token 工具无法解析，不利于排查问题。007 格式支持全量字段解析，详情参考文档：[生成 Token](https://doc.shengwang.cn/doc/rtc/javascript/basic-features/token-authentication#token-code)。
2、关于 Token 有效期：
Token 本身不存在 “不稳定” 的说法，只有过期时间的概念。
上限限制： 无论生成时配置的有效期是多少，系统最大有效时间均为 24 小时。
实际生效： 最终有效期取 “配置时间” 与 “24 小时” 的较小值。
3、临时 Token： 不校验 UID，频道名匹配就可以进入频道。
正式 Token： 严格校验 UID。请务必保证生成 Token 时填入的 UID 和频道名，与客户端 Join 时传入的参数完全一致，否则会导致加入频道失败。
4、您可以使用控制台的工具自行校验 Token 是否正确：
路径： 控制台 -> 辅助工具 -> Token 生成 / 校验 -> Token 校验
操作： 粘贴 Token 解析，核对解析出的 uid 和 channelName 是否与您 Join 时传入的参数完全匹配。

---
# ID: 38855

SDK Product: RTC

SDK Platform: React Native

SDK Version: 其他版本

Request Type: 其他问题

Request Description: `String acquireUrl = "https://api.agora.io/v1/projects/" + appId + "/rtsc/speech-to-text/builderTokens";`
你们的那个会议实时字幕功能，我调用api返回
```
>>> [RTT] Failed to acquire token: 
{"message":"invalid_appid"}
```
帮我检查一下，是否是我传参有问题

Reply: 您好，`/rtsc/speech-to-text/builderTokens` 这个是我们内部的接口，请不要使用
要生成 token 可以 clone 我们的仓库，跑里面的脚本来生成，参考[使用 Token 鉴权](https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication)

---
# ID: 38857

SDK Product: RTM

SDK Platform: Java

SDK Version: 其他版本

Request Type: 商务问题

Request Description: 我想基于User Channel开发相应功能，但其的api并发限制并未明确列出，无法进行相应设计，api限制接口文档里只有关于message channel和stream channel的限制

Reply: 您好，User Channel 严格意义上并不是 channel，它只是点对点消息，限制参考Message Channel 就行，都是 60 条消息每秒

---

# ID: 38834

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: 我在使用途中，使用采集卡推流出现了亮度错误，也就是过曝的问题，这该怎么解决？

Reply: 请问您的采集具体是如何实现的？如果本身有采集卡可以试下用[自采集方案](https://doc.shengwang.cn/doc/rtc/windows/advanced-features/custom-video-source)而不是 SDK 采集

---
# ID: 38838

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 2.6.5

Request Type: 集成问题咨询

Request Description: 目标：多人会议中实时监听是那个（哪些）用户在说话，并高亮显示那个（哪些）用户
已做尝试：
1.在网页端已实现该功能
2.在微信小程序端通过监听`audiovolumenotify`事件来实现
`audiovolumenotify`事件不触发

Reply: 您好，我们的小程序 SDK 本身不提供音量回调接口，需要您自行实现，具体可以咨询下微信小程序团队

---
# ID: 38843

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 灵动课堂直播结束后如何调取直播数据

Reply: 1、直播间人数无法准确统计，建议业务上在客户端做个启动的上报，在自己这里统计
2、直播时长可以在收到课堂结束回调的 1 小时内调用 Restful 接口[查询课堂信息](https://doc.shengwang.cn/doc/flexible-classroom/restful/api/api-classroom#%E6%9F%A5%E8%AF%A2%E8%AF%BE%E5%A0%82)，通过开始时间和结束时间来计算
3、直播聊天用的是环信 IM，需要咨询环信 IM 侧如何开启历史消息保存

---

# ID: 38825

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.2

Request Type: 集成问题咨询

Request Description: 在控制台创建频道并生成临时token可以加入该频道并成功语音通话，但如果在程序中，把频道id改为新的，却不能成功加入并成功语音通话。不知道为什么？
按照文档，如果在程序中设定新的频道id，频道会自动创建，并成功加入。

Reply: 您好，临时 token 校验频道名，如果加入的频道名和生成 token 是设定的频道名不一致就会报错无法进入，需要参考[使用 Token 鉴权](https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication)生成正确的 token 来使用

---
# ID: 38830

SDK Product: RTC

SDK Platform: MacOS

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 您好，我在集成RTC的时候，运行Xcode会报很多类重复的错误，日志如下（这种对上线会有影响吗）Demo示例里面直接跑起来也会有这种提示日志。
```
objc[93216]: Class RTECVPixelBuffer is implemented in both /Users/duoping/Library/Developer/Xcode/DerivedData/APIExample-etukxzpyoszxpkcrjmapqqwuormd/Build/Products/Debug/APIExample.app/Contents/Frameworks/AgoraScreenCaptureExtension.framework/Versions/A/AgoraScreenCaptureExtension (0x101c40950) and /Users/duoping/Library/Developer/Xcode/DerivedData/APIExample-etukxzpyoszxpkcrjmapqqwuormd/Build/Products/Debug/APIExample.app/Contents/Frameworks/AgoraRtcKit.framework/Versions/A/AgoraRtcKit (0x107fd8cc8). This may cause spurious casting failures and mysterious crashes. One of the duplicates must be removed or renamed.
```

Reply: 您好，不会有影响，可以把不需要用的插件手动删除，参考[减小 App 体积](https://doc.shengwang.cn/doc/rtc/macos/best-practice/reduce-app-size)，这样打印的内容会少一点。
后续我们会让研发隐藏这类打印来减少干扰

---

# ID: 38810

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 在视频录制过程中中间都会断，怎样保证录制时间长问题

Reply: 云录制的 `start` 请求里有`maxIdleTime`字段，是用来控制云录制多久收不到流以后自己退出的。如果有需要可以设置的长一点，这样频道里没人发流录制端也不会马上自己退频道结束录制了

---
# ID: 38811

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 你好，声网灵隼支持多个客户端同时和设备音视频吗

Reply: 您好，灵隼平台后续会下架，不推荐使用了
有 IOT 需求可以用 [RTSA SDK](https://doc.shengwang.cn/doc/rtsa/c/landing-page)
所有 RTC RTSA SDK 都支持频道内多人互通的

---

# ID: 38795

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.3.2

Request Type: 集成问题咨询

Request Description: 我现在有两个用户加入一个频道；一个用`joinChannel`发视频流，一个用`joinChannelEx`发屏幕共享流；然后在`onTokenPrivilegeWillExpire`的回调中使用`renewToken`去更新`token`；两个用户的更新结果都是0成功；但是共享的那个用户还是到期离开没更新成功

Reply: 您好，`renew` 属于 `engine` 对象，所以只能更新 `engine` 下的频道连接，无法给 `engineEX` 的多频道连接更新。多频道场景下要更新 token 需要使用`updateChannelMediaOptionsEx`方法

---
# ID: 38801

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 云端录制启用了，没有生效吗？

Reply: 您好，云录制是要调用 Restful 接口以后才会工作的，不是自动的

---

# ID: 38781

SDK Product: RTC-Linux

SDK Platform: Linux-Java

SDK Version: 4.4.32

Request Type: 集成问题咨询

Request Description: 集成 SDK 后运行报错：`java.lang.UnsatisfiedLinkError: /opt/java/native/libffmpeg_utils.so: libavcodec.so.60: cannot open shared object file: No such file or directory`
要如何解决？

Reply: 您好，建议升级到最新版本 SDK ，然后检查下有没有把sdk里所有的so都放到`/lib/native/linux/x86_64 `路径下，一般是有 so 路径放错了所以提示找不到
不过前提是已经配置过系统环境变量的路径。

---
# ID: 38785

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: APP证书可以关闭吗？目前看到有打开关闭按钮，但是禁止使用

Reply: 您好，声网控制台上的 App 证书开启后无法关闭，有需要的话可以新建一个 Appid，选择不开启鉴权来解决。

---
# ID: 38787

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 对话式AI引擎是否支持私有化部署？
是否支持选择部分功能？
如何收费？

Reply: 您好，convoAI 支持私有化部署，具体细节请电话咨询：400 6326626

---

# ID: 38761

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: Windows SDK，是否可以基于Qt进行开发？ 支持H265格式视频的播放吗？

Reply: 1、Native SDK 支持 h265，但远端 Web 只能发 h265，无法解码接收 h265 的画面，建议和 Web 互通的话双方都用 h264 或者 vp8，参考[VIDEO_CODEC_TYPE](https://doc.shengwang.cn/api-ref/rtc/windows/API/enum_videocodectype)
2、理论支持 QT 开发，但是我们没有 QT 的相关 Demo

---
# ID: 38762

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: Web端 SDK， 支持H265格式视频的播放吗？我这边用的是最新版的 chrome 浏览器

Reply: Web 只支持编码发送 h265，但是 h265 会有回退机制，需要保证通话双方使用的 SDK 版本都支持 h265，否则就会变回 h264
一般建议用 h264 或者 vp8，h265 的支持情况还不是很理想，Web SDK 目前还无法解析 h265

---
# ID: 38764

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 观看端，怎么实现录屏保存到本地

Reply: 可以参考我们 Demo：[MediaRecorder](https://github.com/AgoraIO/API-Examples/blob/1d81ec61fdc183161f99fcb79e3ece8bbd1e05a2/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/MediaRecorder.java)
一般有录制需求优先推荐[云录制](https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page)

---
# ID: 38765

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 我们在使用屏幕共享功能的时候，申请屏幕录制权限总是会申请两次，所有android手机都是这样，请问这是什么问题？

Reply: 这个现象看起来是业务的问题，您可以对比我们的[屏幕共享 Demo](https://github.com/AgoraIO/API-Examples/blob/1d81ec61fdc183161f99fcb79e3ece8bbd1e05a2/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/ScreenSharing.java) 看下我们 Demo 会不会屏幕共享时申请 2 次
推测是您业务上调用了 2 次接口或者有其他业务导致了又一次弹窗申请

---
# ID: 38766

SDK Product: RTM

SDK Platform: Flutter

SDK Version: 2.2.5

Request Type: 集成问题咨询

Request Description: 为什么后台开启了历史消息记录。调用接口也支持也设置对了。早上还可以正常的读取历史消息。现在只能接受实时消息。历史消息新发的消息丢失了。配置没问题。代码没问题。

Reply: 您好，请确认确保调用`publish`方法时有配置`storeInHistory`属性，
如果确认配置了但还是没有历史消息，请参考文档获取 [RTM 日志](https://doc.shengwang.cn/doc/rtm2/flutter/error-codes) 文件发来看下

---

# ID: 38728

SDK Product: Media-push

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description:  
1. 创建旁路推流成功
2. 填写推流地址，点击开始推流
3. `onRtmpStreamingStateChanged`, 先返回 `state:4, errcode3`;   接着返回` state:4，errcode:16`
4. 反复重试n遍，一样结果，无法完成旁路推流

Reply: 您好，旁路推流用服务端启动就行了，客户端是不用再填一次地址和调用的
服务端旁路推流启动以后自动转发频道里的内容到预设的地址上，到时候拉流观看就能看到 RTC 画面了

---
# ID: 38729

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.6

Request Type: 集成问题咨询

Request Description: 请问，RTSA能否在设备端进行录音录像？

Reply: 您可以自行保存收到的远端流，或者用我们的[云录制](https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page)直接录制频道里的内容

---
# ID: 38730

SDK Product: Fastboard

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 你们官网根本没有任何一个可用的web集成的示例， 我通过你们官网AI问了以后，给的示例也都是完全不能用的，现在我这边更是连fastboard的依赖包都无法通过npm安装，一安装就报错

Reply: Fastboard  Demo 参考这个仓库：[fastboard](https://github.com/netless-io/fastboard)

---
# ID: 38738

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 域名配置后不生效，腾讯那边没有问题。

Reply: 您好，融合 CDN 的域名配置需要时间，请再耐心等待一段时间

---
# ID: 38745

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: AgoraAIGCService集成问题，github给出的demo 跑不通

Reply: 您好，我们已经没有交 AIGC 的产品了，目前的 AI 产品叫[对话式 AI 引擎](https://doc.shengwang.cn/doc/convoai/restful/get-started/quick-start)，调用 Restful 接口启动或者在声网 console 的 playground 里可以直接体验

---
# ID: 38754

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 能否帮我关闭云端录制，手误点开启了

Reply: 声网 console 上云录制功能的开关打开就没法关闭了，但是不调用云录制接口的话就不会产生付费，所以不用太在意。

---
# ID: 38755

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 其他问题

Request Description: 是这样的一个需求，不知道web端能是否有这个功能

我们现在有移动端集成（android ios）直播功能，现在想做个后台管理系统，想实时去查看各个直播间直播画面情况，怎么能实现这个功能，

我们是一个页面可能会有比如10个直播间画面，怎么能同时播放这10个直播间的画面，总不能一下加入10个直播间的频道然后获取画面还是怎么做？

备注：本次工单是技术咨询，不是某个应用出了问题

Reply: Web 的话创建多个 client 就行了，一个 client 只能用一个 uid 加频道，参考[Web 加入多频道 Demo](https://github.com/AgoraIO/API-Examples-Web/blob/main/src/example/advanced/joinMultipleChannel/index.js)

---

# ID: 38714

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 线上报错

Request Description: 云录制时长超1h后，查询录制状态报错：resourceId exceeded time limit!，这个是什么原因呀？

Reply: 云录制请求后返回`resourceId exceeded time limit!`表示resourceid 过期了，重新调用[获取云端录制资源](https://doc.shengwang.cn/doc/cloud-recording/restful/cloud-recording/operations/post-v1-apps-appid-cloud_recording-acquire)接口去`acquire` 一个新的`resourceId `就可以了，有需要的话可以把时间设置的长一些，默认值 72，最大值 720

---
# ID: 38719

SDK Product: RTM

SDK Platform: Swift

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 您好，我在集成RTM的时候，申请了临时Token，登录RTM的时候是正常的，普通消息都可以成功发送，但是在Topic的时候使用的AgoraRtmStreamChannel，调用joinStreamChannel()方法，加入会报错【加入 streamChannel 失败！ code:AgoraRtmErrorCode(rawValue: -11007) 原因： Join stream channel failed.】Token是没问题的，可以登录RTM成功和发送普通消息。这是什么原因呢？我写的集成代码在下面的附件内。

Reply: 您好，可以检查下`join`stream channel 的时候传入的 token 是否具备 RTC 权限，没有的话是加不进去的。`login`的时候只有一个 RTM 权限就足够了，所以建议有 stream channel 需求的时候生成同时具备 RTC 和 RTM 权限的 token，参考[join](https://doc.shengwang.cn/api-ref/rtm2/swift/toc-channel/channel#join)的字段解释。

---
# ID: 38722

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 想实现音频自渲染功能，期望在`onPlaybackAudioFrameBeforeMixing`回调中收到每一个加入用户的声音；远端用户加入后，`onRemoteAudioStateChange` 回调  `state:4,reason:9`； `onPlaybackAudioFrameBeforeMixing`回调不被调用；可能的原因是什么

Reply: 您好，参考[onRemoteAudioStateChanged](https://doc.shengwang.cn/api-ref/rtc/windows/API/toc_audio_basic#callback_irtcengineeventhandler_onremoteaudiostatechanged)的接口文档，`REMOTE_AUDIO_STATE_REASON`为 9 表示`REMOTE_AUDIO_REASON_LOCAL_PLAY_FAILED`本地用户收到远端音频数据包但播放失败，导致远端音频状态发生变化。可以检查下网络是否畅通，以及是否只有一台设备有这个情况发生，如果稳定复现的话，麻烦提供下具体的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# ID: 38702

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 使用`AgoraRtcMediaPlayerProtocol`  `open` 本地mp4视频，然后使用`takeSnapshot`截图，一直返回-1错误，`joinchannel`是成功的

Reply: 您好，`takeSnapshot`无法对用`MediaPlayer`发流的视频文件画面截图，报错-1 是预期内的。

---
# ID: 38706

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 实时互动 SDK 有同时支持 Linux ,Mac,Windows 的版本吗
这里有些地方显示 Windows ,有些地方显示 C++（全平台），请问这里的版本是支持所有平台的版本吗
并且 C++ 全平台版本没有找到下载链接


Reply: 您好，没有同时支持的 Linux ,Mac,Windows 的 SDK，需要各自集成各自的。
文档里 C++ 的全平台指的是各平台都是基于 C++底层接口封装的，可以看这篇来了解 C++的来看最底层提供了哪些能力，并不是所有平台都包了 C++ 100% 接口的。

[Linux SDK](https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/landing-page)
[Macos SDK](https://doc.shengwang.cn/doc/rtc/macos/landing-page)
[Windows SDK](https://doc.shengwang.cn/doc/rtc/windows/landing-page)

---
# ID: 38709

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我们发现我们的使用记录中有FHD的用量，但我们的业务只需要HD即可，想通过设置来控制最多只用到HD。
不知道应该如何修改设置，希望能指导一下。

Reply: 您好，我们的分辨率是[集合分辨率](https://doc.shengwang.cn/doc/rtc/android/billing/billing-strategy#%E9%9B%86%E5%90%88%E5%88%86%E8%BE%A8%E7%8E%87)计算的，按照最后所有分辨率综合所在的档位计算，具体细节可以咨询：400 6326626

---

# ID: 38678

SDK Product: Flexible-classroom

SDK Platform: iOS

SDK Version: 2.8.100

Request Type: 崩溃（闪退、卡死）

Request Description: 启动崩溃,这是错误信息
```
Symbol not found: __ZN5swift34swift50override_conformsToProtocolEPKNS_14TargetMetadataINS_9InProcessEEEPKNS_24TargetProtocolDescriptorIS1_EEPFPKNS_18TargetWitnessTableIS1_EES4_S8_E
  Referenced from: <C95001D7-48E9-37EC-8A65-F8F23DA9822D> /private/var/containers/Bundle/Application/F84C5840-D200-4B17-9997-DB485A148715/SW_test_oc.app/Frameworks/AgoraReport.framework/AgoraReport
  Expected in:     <A23ACF34-D55F-3CFF-910F-D6FB5952E5E9> /private/var/containers/Bundle/Application/F84C5840-D200-4B17-9997-DB485A148715/SW_test_oc.app/Frameworks/Armin.framework/Armin
dyld config: DYLD_LIBRARY_PATH=/usr/lib/system/introspection DYLD_INSERT_LIBRARIES=/usr/lib/libLogRedirect.dylib:/usr/lib/libBacktraceRecording.dylib:/usr/lib/libMainThreadChecker.dylib:/usr/lib/libRPAC.dylib:/usr/lib/libViewDebuggerSupport.dylib
```

Reply: 您好，请问现在在用的灵动课堂版本是多少？如果是老版本有崩溃情况的话，建议优先升级目前的 SDK 到最新版本再试试

---
# ID: 38682

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.5

Request Type: 集成问题咨询

Request Description: 麻烦问下 现在我使用的是ESPC6能否集成 ESPS3 sdk？

Reply: 您好，RTSA 目前还没有适配过 ESPC6 的 SDK，如果有需要的话需要申请

---
# ID: 38685

SDK Product: RTC-Linux

SDK Platform: Linux-Go

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 
GO SDK版本：v2.4.1
直接运行 Go SDK 会这行日志：`SESS_CTRL: version: 20250221.bdv2.5.hip.sharedlib.timeout 
目前项目从v2.2.9 升级到v2.4.1后，项目运行正常，但是日志一直会出现这个提示，这个对项目会产生什么影响吗？我该如何fix呢？

Reply: 您好，`SESS_CTRL: version: 20250221.bdv2.5.hip.sharedlib.timeout` 研发侧反馈这个是内部调试打印，后续版本会去除，可以忽略

---

# ID: 38665

SDK Product: Flexible-classroom

SDK Platform: iOS

SDK Version: 2.8.100

Request Type: 集成问题咨询

Request Description: error打印错误`Error Domain=core Code=20404100 "(null)" UserInfo={message=The operation couldn’t be completed. (Armin error 404.)}`

Reply: 参考[灵动课堂响应状态码](https://doc.shengwang.cn/doc/flexible-classroom/restful/response-code)，20404100 是课堂不存在，请检查课堂 ID 是否正确。

---

# ID: 38646

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: 我想咨询，我们之前的产品是宝宝监控，通过音视频互动来监控宝宝或者和宝宝音视频通话，现在我们的产品需求变更，音视频通话中，或者监控中，能不能从单语音通话，切到音视频通话，并且从音视频通话再切到单语音通话。然后单语言通话计费和音视频通话计费价格一样么。我下面上传的图文，是我们最新的需求，帮我看一下是否支持。

Reply: 您好，在频道内默认是音频时长计费，产生视频订阅以后会有计算视频费用，人多的话计费规则不变，但产生的用量会变多，具体参考[计费策略](https://doc.shengwang.cn/doc/rtc/android/billing/billing-strategy)
或者咨询您的对接销售，如果没有销售的话可以电话沟通：400 6326626

---
# ID: 38650

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: 有没有linux平台的x86或arm的c++客户端rtc sdk，主要要能实现本地视频的推流到云端

Reply: 您好，可以考虑用我们的[输入在线媒体流](https://doc.shengwang.cn/doc/media-pull/restful/landing-page)
或者集成 [Linux SDK](https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/landing-page)

如果是 IOT 设备的话，可以用[媒体流加速](https://doc.shengwang.cn/doc/rtsa/c/landing-page)

---
# ID: 38654

SDK Product: Media-push

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 您好，目前在使用视频直播下的实时音视频+视频直播，需要咨询一下，使用实时音视频旁路转推时，调用API更新布局，由推用户A屏幕共享桌面改为推用户B的视像头,会出现观看直播的用户播放停止，手动刷新页面吗？

Reply: 您好，旁路推流是把画面转推到一个指定 RTMP 地址上，更新转推的布局不会导致这个 rtmp 地址收到的流中断，如果有类似情况发生，是需要您自行排查网页播放业务来解决的。可以同时用 vlc 或者 ffplay 拉流对比看下，更新布局拉流是不需要观众手动操作，自己变动的

---
# ID: 38657

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 主播角色状态下，能只录制音频，不录制视频么

Reply: [startAudioRecordingWithConfig](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_recording#startAudioRecordingWithConfig:) 是只录制音频，[startRecording](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_recording#startRecording:) 是同时录制音视频

---
# ID: 38658

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 4847205用户ID加入频道情况查看，貌似是加入失败了

Reply: 您好，加入频道失败请提供具体 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---
# ID: 38660

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 通过接口拿到appIdchanneltoken  并且能拿到流的订阅地址 但是使用liveplayer 播放不出来

Reply: 您好，liveplayer 组件里的 rtmp 流是小程序侧提供的，如果这个 rtmp 地址本身无法被拉流观看，那我们的小程序 RTC SDK 也拉不到流，无法把画面转发进 RTC 频道内，需要找小程序侧问下什么原因导致拉流地址不可用

---

# ID: 38626

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 我想咨询一下，我后端能通过什么接口获取，ASR转化的文本以及最终语音转化的文本。

Reply: 您好，可以参考下[实时字幕](https://doc.shengwang.cn/doc/convoai/restful/user-guides/realtime-sub)

---
# ID: 38631

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 崩溃（闪退、卡死）

Request Description: 用户首次访问的时候，这两个加载非常慢，加起来8S多，有时候十几秒，有时候直接加载失败。有办法改善吗？

Reply: 您好，hls 的第一个用户拉流就是慢的， 一般要等3个`GOP`；如果是所有用户第一次拉流都很慢，可以尝试把推理工具的 `GOP` 改到1试试，可以缩短第一个用户的起播时间
我们的CDN是边缘切片的，如果用户拉流被分配到不同的边缘机器，那么这个边缘机器上的第一个用户拉流就是需要等待3个`GOP`的 

---
# ID: 38642

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 2.6.5

Request Type: 效果不佳、不达预期

Request Description: 根据后端返回的 rtmp 地址 获得视频流，有的可以正常播放，有的无法播放。

Reply: 您好，小程序组件返回的 rtmp地址是小程序侧提供的，如果无法播放需要小程序侧调查。声网的小程序服务也是从这个地址上拉流，转发进 RTC 频道内来实现的，如果原 rtmp 地址就放不了那 RTC 肯定拉不到流

---
# ID: 38644

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 云端录制的第三方存储使用自建的还有地区限制么

Reply: 云录制 vendor 为 11 的时候 region 字段设置了也不生效，参考[参考信息](https://doc.shengwang.cn/doc/cloud-recording/restful/api/reference)

---

# ID: 38602

SDK Product: RTC

SDK Platform:  Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: `AgoraRTC.createClient`以后报错：  `BAD_ENVIRONMENT`，sdk 版本： `AgoraRTCSDK-3.0.0.js`
报错，如何解决
目前客户端无法互通视频

Reply: 您好，`BAD_ENVIRONMENT`是 Web SDK 因为当前浏览器不支持 WebRTC 协议导致初始化失败的打印，请使用 chrome 浏览器这类支持 WebRTC 协议的浏览器再试试，参考[浏览器兼容性和已知问题](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility)

---
# ID: 38603

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: web端视频通话中，能获取到网络状态是wifi还是5g吗

Reply: 您好，我们的 Web  SDK 没有办法感知当前的网络状态，可以考虑用原生接口去实现

---
# ID: 38604

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 其他版本

Request Type: 崩溃（闪退、卡死）

Request Description: 使用sdk时，订阅了音视频的远端回调，用户加入房间时，便会直接 `Segmentation fault (core dumped)`
排查步骤：
1.本地播放器开关测试，订阅远端视频流。结果：用户加入房间时，便会直接 `Segmentation fault (core dumped)`。
2.本地播放器开关测试，不订阅远端视频流。结果：正常。

Reply: 需要提供下设备的的架构、操作系统、编辑工具链所用 C 库及编译选项等信息；以及当前使用的是哪个sdk，链接需要发下，大概率是sdk不适配引发的crash，或者发送端和接收端使用的编码协议不一致导致的，修改编码参考[与 RTC SDK 互通音视频数据](https://doc.shengwang.cn/doc/rtsa/c/best-practices/interoperate-rtc)

---
# ID: 38607

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.5.1

Request Type: 其他问题

Request Description: 加入RTC频道后，游戏内的音效会听不到，参考了网上unity同样问题的解决方法，每次进入频道的时候调用：`[self.rtcEngine setParameters:@"{\"che.audio.keep.audiosession\":true}"];`
第一次进入频道时音效可以正常播放了 可是退出频道 再次进入 音效还是无法正常播放。我的游戏引擎是：cocos creator 3.8.5版本

Reply: 初始化之后，加入频道前再加两个私参，然后复现问题，拿一下完整的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
`agoraKit.setParameters("{\"rtc.debug.enable\": true}");`
`agoraKit.setParameters("{\"che.audio.record_audio_session_call_stack\": true}");`

---
# ID: 38609

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: `Command CompileMetalFile failed with a nonzero exit code`
编译demo问题报错

Reply: 您好，`failed with a nonzero exit code` 这个报错没什么指向性，找找build记录里面具体的报错，查询下对应的含义

---
# ID: 38616

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 我没有找到在哪配置 发布点 只能使用live，这个live能在生产上使用吗？


Reply: 您好，需要用请求[增加发布点](https://doc.shengwang.cn/doc/fusion-cdn/restful/streaming/operations/post-v1-projects-appid-fls-entry_points)

---
# ID: 38620

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 其他问题

Request Description: 您好，之前在平台上充了2000块钱预交金，请问可以开发票吗？增值税普通发票

Reply: 您好，充值可以随时提现，所以无法开票，需要产生实际消费以后才行

---

# ID: 38570

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 我上传了一个压缩日志，22：01有一则和 AI通话，帮我查下是什么原因收不到服务端下发的 rtm 消息 目前是可以正常和 ai 对话 就是收不到消息

Reply: 可以自查下是不是 token 没有 RTM 权限，从而导致客户端、服务端加入 RTM 频道的时候失败了，请[生成同时具有 RTC 和 RTM 权限的 token](https://doc.shengwang.cn/faq/integration-issues/generate-token) 来使用。

---
# ID: 38578

SDK Product: Fastboard

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: web端已老师以管理员身份开启白板，学生以观众身份观看，如果学生退出观看，管理员这边能否收到回调

Reply: 白板本身不提供用户上下线的创建监听，所以没有回调可以提供
可以考虑用 [onRoomStateChanged](https://doc.shengwang.cn/doc/whiteboard/javascript/whiteboard-sdk/basic-features/manage-room-status#%E6%B3%A8%E5%86%8C%E5%9B%9E%E8%B0%83%E7%9B%91%E5%90%AC%E4%B8%9A%E5%8A%A1%E7%8A%B6%E6%80%81%E5%8F%98%E5%8C%96) `state?.roomMembers`和本地`roomMembers`对比来感知人数变化，推断上下线事件发生 

---
# ID: 38581

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 2.6.5

Request Type: 集成问题咨询

Request Description: 用户端：小程序sdk
坐席端：webjs

问题描述：坐席端显示用户的画面不清晰，这个现象一直存在；
请问声网对视频流是否有一定的压缩机制，或者老师们有没有改进建议！谢谢

Reply: 您好，采集是小程序侧实现的，小程序组件采集的原始画面不清晰，编码发送出去的就不清晰，一般和用户网络情况相关，SDK 没有压缩机制

---

# ID: 38566

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.5

Request Type: 集成问题咨询

Request Description: 麻烦问下 在初始化媒体流加速的sdk时 有没有关于创建9000对外端口

Reply: 您好，RTSA SDK 每次初始化使用的端口是随机的，请问现在是什么场景和需求需要了解端口使用情况？

---

# ID: 38542

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 我 ios 端使用了 ai 引擎的相关 api  代码是从 demo 中参考拿过来的 我想确定下代码中是否有包含HealthKit 框架

Reply: 您好，没有用到HealthKit

---
# ID: 38554

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 效果不佳、不达预期

Request Description: 三星A52 Android 12 用户杀进程后还能听到声音，

Reply: 系统杀进程以后频道就断开连接了，一般不会再听见频道内声音，所以这种情况可能是系统没有杀进程导致的，需要复现的时候获取 logcat 抓一下系统日志看看

---

# ID: 38523

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 您好 使用Java jdk进行云端录制，参数`mixedVideoLayout`设置的1，自适应，但2个人视频通讯，录制的视频里只有一个人的音视频，少了一个人的，怎么可以做到录制完整的2个或多人的音视频？

Reply: 推测是录制端用了频道里已经有的 uid，把发流的人顶出频道了，可以自查一下 uid 是否有冲突的情况，录制段本身要用的 uid 不能和频道里重复
如果确定没问题的话，可以给一下 sid

---
# ID: 38527

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.1

Request Type: 集成问题咨询

Request Description: 接入声网高级美颜，获取安卓和ios获取美颜素材包 AgoraBeautyMaterial.bundle.zip

Reply: 请问您目前在用的是 4.6.1 SDK 吗？要用高级美颜的话推荐用 [4.5.2.6](https://i46hiqvame.feishu.cn/wiki/SCGwwimqaiVjIVkWy59ci7sZnve?from=from_copylink) 版本，这个链接里包含了对应的`AgoraBeautyMaterial.bundle.zip`文件
以及希望您能填写一下这个[高级美颜问卷](https://ai.feishu.cn/share/base/form/shrcnFAOuPGRMzFYxpB5k0SPqeb?from=navigation)，来帮助我们后续改进、升级高级美颜的相关能力

---
# ID: 38530

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: 从云上往下拉流，对网速要求是多少？

Reply: 没有具体的网速，只有码率要求，网络能够满足[码率参考](https://doc.shengwang.cn/doc/cloud-recording/restful/api/reference#%E5%B8%B8%E7%94%A8%E8%A7%86%E9%A2%91%E5%B1%9E%E6%80%A7)就行

---
# ID: 38531

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.4.0

Request Type: 效果不佳、不达预期

Request Description: 使用场景：桌面远程投屏（将桌面视频流发送至远端）
问题：部分浅色色块无法在远端显示，但使用HDMI进行投屏时可以显示，说明设备没问题，视频流有问题
期望：使用声网服务进行视频流传输时可以显示所有颜色
channel：xxx
发送端
uid：2258163
sdk：agora-electron-sdk@4.4.0

接收端：
uid: 1258162
sdk: react-native-agora@4.5.1

Reply: 您好，这个是 4.4.0 的已知问题，可以升级 Electron SDK 到[最新版本](https://doc.shengwang.cn/doc/rtc/electron/resources)再试下

---

# ID: 38498

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 调用 ai 引擎上传图片接口的作用是什么 我使用Conversational-AI-Demo-main 这个 dome 上传图片是智能体 并没有给我回答图片


Reply: 您好，可以先确认下目前所用的模型本身是否支持多模态输入，以及排查下[发送图片消息](https://doc.shengwang.cn/doc/convoai/restful/user-guides/send-multimodal-message)中的前提条件是否都已经满足，如果自查无果，可以提供下具体的 agentID

---
# ID: 38508

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 集成问题咨询

Request Description: 您好，我的嵌入式linux设备已经集成了`Agora-RTSALite-RmRdRcAcAjCF-arm-linux-gnueabihf-v1.9.2-20231220_171304-287745`版本的 sdk，
现在有个平台客户需要使用我们的设备，但是使用他们appId，且不使用license授权的方式，改用时长套餐的方式，请提供一下非license授权方式的SDK,谢谢。

Reply: 您好，
1、rtsa sdk默认正常都是需要授权license激活使用的
[申请和使用 License](https://doc.shengwang.cn/doc/rtsa/c/basic-features/license)
2、非license授权的sdk 是我们实时互动的rtc，比如安卓平台，但是是不兼容您的设备平台架构的；

---
# ID: 38509

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 鸿蒙设备app对鸿蒙设备小程序发起视频通话，小程序端的摄像头黑屏
但是鸿蒙设备app对安卓设备小程序发起视频通话，正常

Reply: 当前声网小程序sdk对于纯血鸿蒙暂无支持计划

---
# ID: 38513

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 由于声网没有提供flutter桌面端的sdk。我想要使用桌面端的能力 我能否用flutter和electron进行混合开发好还是使用fluter配合macOS和Windows的sdk做成flutter插件更好一点，是否有成熟的方案案例可以作为背书

Reply: 声网的flutter sdk是支持window平台的
[产品概述](https://doc.shengwang.cn/doc/rtc/flutter/overview/product-overview)

---
# ID: 38514

SDK Product: RTMP

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 效果不佳、不达预期

Request Description: 使用RTMP网关服务将无人机视频码流使用SRT协议推送到声网，使用声网播放器播放出现 花屏现象，目前是在有限的几处地方出现花屏。 
推流指令：`/opt/ffmpegDir/ffmpeg -loglevel quiet -rtsp_transport tcp -timeout 5000000 -i rtsp://127.0.0.1:17108/live/xxx/99-0-0/normal-0 -vcodec copy -an -f mpegts srt://xxxx?streamid=xxx&latency=200&fec=on&fec_k=4&fec_m=6`

Reply: 用rtmp推流，帧率也会有调到0的情况。因为rtmp是基于tcp的，所以网络抖动的时候就会拉大延时然后卡顿，srt因为是基于udp的，延时过大的话就会丢包，如果一帧里面部分包被丢弃，就会表现为花屏，可以先检查下网络环境是否稳定

---
# ID: 38516

SDK Product: Media-push

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 使用旁路推流，调用`https://api.sd-rtn.com/cn/v1/projects/xxx/rtmp-converters`报错
```json
{
    "reason": "No invalid permission to use this function. Contact us."
}
```

目前有开通旁路推流功能

Reply: 您好，请检查下对应 appid 是否处于停机状态，`No invalid permission to use this function.`通常表示因为 appid 不可用导致无法使用旁路推流功能。

---
# ID: 38521

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 我的设备用默认配置无法播放远端用户声音，目前测出可播放远端用户的配置值有`config.mAudioScenario = AUDIO_SCENARIO_GAME_STREAMING`，`AUDIO_SCENARIO_MEETING`，`AUDIO_SCENARIO_AI_CLIENT`。 但播出远端用户声音是有爆音的，如何解决爆音问题。

Reply: 您好，可以参考下[如何区分媒体音量和通话音量？](https://doc.shengwang.cn/faq/integration-issues/system-volume)，看下设备在不同`scenario`下走不同音量通道的表现是否一致，并提供稳定复现问题是的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# ID: 38474

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: 请问一下electron sdk是否支持vite开发,已vite集成sdk提示api导入报错,目前github上提供的都是webpack的demo,如果支持的话能否提供一下相应的代码demo,谢谢

Reply: 支持，可以看下[Electron 平台常见开发问题](https://doc.shengwang.cn/faq/integration-issues/electron-faq)末尾找不到模组的解决办法

---
# ID: 38475

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.6

Request Type: 集成问题咨询

Request Description: 我想在 RTSA 上开启 3A 处理，是这样吗？
```c
channel_options.enable_audio_downlink_aec = true;
channel_options.enable_audio_downlink_aec_pcm_dump = true;
```

Reply: 您好，要在 RTSA 上使用 AEC 功能的话开启`enable_audio_downlink_aec`就行，不需要开启`enable_audio_downlink_aec_pcm_dump`。不过 RTSA SDK 的 3A 性能消耗较大，不推荐在 IOT 设备上开启我们 SDK 的3A处理。

---
# ID: 38478

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 其他问题

Request Description: 场景描述：
1、有两个个app id 
2、硬件设备端采用c++开发，app端是采用`uniapp`端开发（webjs sdk）
3、在仅app id鉴权下，设备端和app端都可以进行发布和订阅，音视频都没有问题
4、在app id + token鉴权下，设备端的音视频，app端是可以接收到的，但是app端的音视频，设备端是接收不到的

Reply: 您好，请提供具体的频道号、uid、时间点、[SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---
# ID: 38479

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 其他问题

Request Description: 我们的直播视频源中有信息，需要在播放时解析，`IRemoteVideoTrack `的监听事件 `sei-received` 需要你们后台开通吗？ 目前监听不到。

Reply: 您好，不需要后台开通的。
1、Web 端需要加一个私参调用 `AgoraRTC.setParameter("ENABLE_VIDEO_SEI", true)`  才能接受和发送 sei，但这个能力在 chrome 浏览器原始上实现的就有问题，很有可能后续某个版本改动后 Web 就不支持 sei 的收发了，所以不推荐 Web 上实现

2、建议用 Native加频道接收 sei，云录制网关不一定识别 sei 信息，建议用 Native 侧加频道注册 [onMetadataReceived](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_metadata_observer#onMetadataReceived) 回调监听
参考 [MediaMetadata Demo](https://github.com/Shengwang-Community/API-Examples/blob/ae7e6697de66339b06e30862c4a1125fba549f31/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/MediaMetadata.java)

---
# ID: 38487

SDK Product: RTMP

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 在rtmp网关和实时互动 RTC两种推流的情况下

这边查询频道是否存在，使用接口：`https://api.sd-rtn.com/dev/v1/channel/user/{appid}/{channelName}/hosts_only`

有概率返回：
```json
{"data":{"mode":1,"total":3,"channel_exist":true,"users":[xxx]},"success":true}
```

没有broadcasters字段，多了users字段,和文档描述不符

Reply: 您好，可以检查下实际发送出去的原始请求是不是漏了 host only？这些字段是 url 没有 host only 才有的：[查询用户列表](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/get-dev-v1-channel-user-appid-channelName)

---
# ID: 38488

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: webhook事件回调健康测试测不过。
另一个类似的项目是OK的，这个url用测试脚本模拟回调也是OK的。

Reply: 您好，Webhook 健康检查没有通过的话就是我们访问不到您配置的 url，可以提供下 console 上的报错截图并且自查下 url 的访问可用情况。

---
# ID: 38489

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.1

Request Type: 集成问题咨询

Request Description: 我们的产品是一个android设备，利用RTC上传视频到控制中心，4G卡为上海联通的定向卡，并在联通备案了`*.agora.io，*.agoraio.cn，*.sd-rtn.com` 三个通配域名，rtc sdk版本4.5.1，这个问题在25年3月份的时候通过工单，解决 ，能正常进频道和推流。目前遇到一个新的问题，我们要在进入频道后，通过旁路推流的方式（`startRtmpStreamWithoutTranscoding`），把视频推送到一个RTMP地址上去，在正常网络情况下，功能正常，但是使用联通定向卡后，旁路推流方法返回超时(reason为3），频道内视频正常。请问是否还需要添加额外的白名单？

Reply: 看您在用 `startRtmpStreamWithoutTranscoding `，现在用的是客户端旁路推理接口吗？推荐用[服务端旁路推流](https://doc.shengwang.cn/doc/media-push/restful/landing-page)去实现，不要在客户端上实现

---
# ID: 38490

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description:  ios 调试模式正常 release包打出来 无法初始化 sdk 

Reply: flutter 在 IOS 的 release 模式上有一个已知问题，可以检查下[如何解决 Flutter 上 iOS release 包初始化时报 symbol not found 的问题？](https://doc.shengwang.cn/faq/integration-issues/flutter-ios-build)

---
# ID: 38494

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 问题：业务这边需要实现用户房间通话收费功能，既在用户进行通话时每分钟进行扣费，余额不足时断开通话的功能。
例如：
一.1v1场景下，用户A和用户B连麦成功，开始时间00:00，通话时长在01分，02分，03分 ......  时业务这边需要进行扣费操作。
二.语音直播场景下，用户在麦位上时，在每一分钟的时间节点，同1v1扣费场景
我目前在文档里面没有看到用户发流或者接受媒体流时回调业务服务的功能，业务服务端这边需要怎么感知用户通话的每分钟状态呢？

Reply: 您好，根据过往经验来看，不建议依赖我们的时长数据去做计量计费系统，建议您业务上自行维护。
要踢人出频道的话可以用：[踢人接口](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/post-dev-v1-kicking-rule)
或者生成 token 的时候限定 token 的有效期，有效期到了就自动移出频道了，参考[使用 token 鉴权](https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication)

---

# ID: 38458

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.2.6

Request Type: 其他问题

Request Description: 声网Rtm ,android  应用得打开，点home 键退回到主界面，另一台设备拨打，一直提示对方未在线，其实对方只要把应用恢复到前台，立马能打通，而且是按home 键20秒，另一台手机就提示不在线了，这个如何解决？

Reply: 1、app 本身要做保活才不会[限制后台活动](https://doc.shengwang.cn/faq/quality-issues/android-background)，保证网络连接
2、RTM 是需要双方都在线才能收发消息的，如果远端不在线就会发送失败，除非您使用历史消息，等远端上线了他再获取[历史消息](https://doc.shengwang.cn/doc/rtm2/android/user-guide/message/history-message)来拿到

---
# ID: 38462

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.5.2

Request Type: 效果不佳、不达预期

Request Description: ios系统版本26.1，sdk版本：`agoraLite_ios 4.5.2`，在上麦的情况下，闭麦之后，手机音量键调整大小无效了， 在ios系统版本18.3上是好的

Reply: 您好，闭麦用的是 `enableLocalAudio` 吗？可以改用 [mutelocalaudiostream](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_publishnsubscribe#api_irtcengine_mutelocalaudiostream) 方法去规避这个情况
这个属于 IOS 系统本身的问题

---
# ID: 38463

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: android  与设备端进行通话，  `int channelProfile = Constants.CHANNEL_PROFILE_COMMUNICATION;engine.setChannelProfile(channelProfile);  `我能通道设备的声音，但我的声音，设备听不到， `int channelProfile = Constants.CHANNEL_PROFILE_COMMUNICATION_1v1;engine.setChannelProfile(channelProfile);  `这样设置，是设备端能听到声音，android 端却听不到声音，这是因为什么？加入频道也成功了

Reply: 不建议用`CHANNEL_PROFILE_COMMUNICATION`，建议用直播模式，确保双方都是主播身份在发流，且双方编码都一致，参考[与 RTC SDK 互通音视频数据](https://doc.shengwang.cn/doc/rtsa/c/best-practices/interoperate-rtc)

---

# ID: 38408

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 请问web sdk视频编码采用的是H264 High Profile么？

Reply: 您好，Native SDK 默认发 `high profile`, Web 默认发 `Baseline`,两者互通没有问题，一般不需要特殊调整

---
# ID: 38414

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.5.1

Request Type: 集成问题咨询

Request Description: 我游戏接入实时互动 sdk 开视频， 我游戏内是用 Unity 原生播放音效，我现在互相开视频 尽然能听到对方 游戏音效点击按钮，等其他音效 如何关闭远端的音效声音 但是要能听到远端的 聊天

Reply: 您好，`setAudioScenario`设置为`chatroom`试一下，`Gamestreaming`会共享设备本身的系统音量到远端去

---
# ID: 38423

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 其他问题

Request Description: 我现在有个新需求，想在企业微信、钉钉、飞书内创建应用，通过应用和我的app进行音视频通话，最初是想通过h5集成，有什么可行的方案吗

Reply: 您好，要使用 Web SDK 的话需要保证这些内置浏览器所用的 Webview 本身支持 WebRTC 协议，可以用[WebRTC 官方 Demo](https://webrtc.github.io/samples/)验证下可用性。
参考[浏览器兼容性和已知问题](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility)

---
# ID: 38425

SDK Product: RTC

SDK Platform: React

SDK Version: 2.3.0

Request Type: 集成问题咨询

Request Description: 我们需要使用声网 rtc功能开发一个python服务1对1的向web端推送视频（带声音）的逻辑，需要咨询接入的细节

Reply: 您好，需要服务端集成 Python SDK，Web 集成 WebSDK，双方加入相同的频道来进行互通
[python SDK](https://doc.shengwang.cn/doc/rtc-server-sdk/python/get-started/send-receive)
[web](https://doc.shengwang.cn/doc/rtc/javascript/get-started/quick-start)

---
# ID: 38426

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.0

Request Type: 效果不佳、不达预期

Request Description: 带耳机的情况下，上麦看着是通话模式，下麦是媒体模式，并且通话模式下电流音很严重

Reply: 麻烦提供完整的频道号、uid、时间点，说明哪个 uid 听哪个 uid 有问题，具体现象和对应的视频都提供下
可以的话，再拿一下对应设备的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---
# ID: 38428

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 云端录制引入的
```
<dependency>
            <groupId>io.agora</groupId>
            <artifactId>agora-rest-client-core</artifactId>
            <version>0.5.0</version>
            <!--<scope>compile</scope>-->
</dependency>
```
  ，里面的reactor-core是3.3.4运行的时候报错，说需要reactor-core 3.4版本以上，是需要排除，然后完全单独引入所有jar包吗？

Reply: 您好，不推荐用这种方式集成云录制，云录制本身是 Restful 接口服务，建议直接调用 [Restful 接口](https://doc.shengwang.cn/doc/cloud-recording/restful/get-started/quick-start)来实现

---

# ID: 32701

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.0.0

Request Type: 集成问题咨询

Request Description: 您好，我再运行demo声动互娱时，测试测试直播功能，开始直播提示`checkAndSetupBeautyPath fail! DynamicResourceUrl not found`，请问下`KeyCenter` 文件里面的 `DynamicResourceUrl` 这个字段填写什么？有测试的url吗？可以让秀场直播可以正常直播？

Reply: 您好，这个值是内部使用的, 请参考readme把美颜资源放进去，现在报错问题只是美颜相关资源缺失了

另外也建议您不要使用声网互娱的demo，当前已经处于不维护阶段；建议您参考我们的[API-EXAMPLE](https://github.com/Shengwang-Community/API-Examples/tree/main/iOS/APIExample)

---

# ID: 32976

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 2.6.5

Request Type: 集成问题咨询

Request Description: 我们做了个多人会议的小程序demo，
其它基础问题都解决了，上真机测试，两个手机，第一个join后，第二个join时，两个机器都会报错：
```
Wed Nov 20 2024 11:37:19 GMT+0800(CST)[ERROR]:client stream 1234 subscribed failed:i"code":432"reason":"1234 is not aspeaker.","serverResponse"."action":"subscribe""errCode":9105}"wsurl":"wss://minia
pp.agoraio.cn/119-84-240-198/api"}

```

说用户角色不对，我们并不理解该用什么角色。因为是多人会议场景，用了broadcaster
请问该如何处理？

Reply: 确保用了主播身份进频道发流，432 就是订阅了一个非主播身份的 uid 才会有的错误码，可以再确认下自己的业务
api文档[setrole](https://doc.shengwang.cn/api-ref/rtc/mini-program/classes/client#setrole)
同时也可以参考下我们 [小程序Demo](https://doc.shengwang.cn/doc/rtc/mini-program/get-started/run-demo) 的处理

---

# ID: 33102

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.0.0

Request Type: 集成问题咨询

Request Description: 后台想部署离线服务
android端集成以下这些在哪申请：
App ID 和 App 证书：这些是你在声网开发者平台上创建项目时生成的，用于身份验证。
其他配置信息：根据具体产品，你可能还需要其他配置信息，如IM服务的Org Name、App Name、Client ID和Client Secret等。

Reply: App ID 和 App 证书申请：登录[声网控制台](https://console.shengwang.cn/)在项目设置中获取 App ID 和 App 证书
IM服务的Org Name、App Name、Client ID和Client Secret：登录[环信控制台](https://console.easemob.com/user/login)获取相关信息


---

# ID: 33110

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.1.1

Request Type: 其他问题

Request Description: Xcode 升级到16.1版本后打包上架报错
```
Asset validation failed
Invalid Executable. The executable 'seeDao.app/Frameworks/AgoraDav1d.framework/ AgoraDav1d' contains bitcode. (ID: 4b16c270-c34c-4fae-b956-ac867c59d636)|
```

Reply: xCode16 上对于 bitcode 审核比较严格，4.1.x 系列的 SDK 都会有这个问题。可以考虑把 RTC升级到4.5.0及以上版本再去打包上架，或者参考下方文档里的脚本，自行删除项目里的 bitcode

参考：[如何解决xCode16打包报错Invalid Executable](https://stackoverflow.com/questions/78993520/invalid-executable-the-executable-appname-app-frameworks-hermes-framework-herm)

---

# ID: 33123

SDK Product: Flexible-classroom

SDK Platform: Electron

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 灵动会议的demo什么时间可以提供？

Reply: 灵动会议没有 Demo，可以参考[集成灵动会议](https://doc.shengwang.cn/doc/meeting/android/get-started/integrate-meeting)直接集成到自己项目中

---

# ID: 38365

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.2

Request Type: 集成问题咨询

Request Description: 请问是否支持鸿蒙next端APP的画中画功能，类似于微信通话最小化窗口的功能，如果支持是否可以提供相关实例代码或文档

Reply: 您好，我们没有深度测试过， sdk 支持渲染 surfaceId， 理论上可以从悬浮窗的`XComponent`获取到`surfaceId`， 然后在构建`VideoCanvas` 设置 `isSurface` 为`true` 来实现

---
# ID: 38379

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 其他问题

Request Description: 已经生成了 app证书,如何关闭

Reply: 您好，这个主要证书开启后无法关闭，这个证书打开后，默认就需要使用token才能加入频道。 但是如果您右上角的允许仅appid加入的开关还是开启状态的话，那就允许token加入，也允许无token加入。 
这个功能后续会停止支持，所以建议您在创建 appid 的时候分别创建一个开启 token 鉴权和不开启 token 鉴权的项目

---
# ID: 38389

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 客户端rtc需要实现变声服务，可以支持大叔音、萝莉音、机械音等需要使用哪一个API呢

Reply: 您好，可以参考下 [Api-example里的变声示例](https://github.com/Shengwang-Community/API-Examples/tree/main/iOS/APIExample/APIExample/Examples/Advanced/VoiceChanger)

---
# ID: 38390

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.3.0

Request Type: 效果不佳、不达预期

Request Description: 请问支持声卡吗，有用户反馈iphone连麦时插着声卡设备，但听不到声卡传输的声音

Reply: 您好，用户使用声卡时请关闭 3A 处理：[实现高音质](https://doc.shengwang.cn/doc/rtc/ios/best-practice/optimal-audio-quality)

---
# ID: 38391

SDK Product: Media-push

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 您好，这边有个无人机直播的使用场景：机库将无人机的直播视频推送到声网。然后页面客户端订阅声网的视频服务，观看无人机的直播视频。目前有个需求是：声网是否支持转一路流到移动云用于AI分析和录制。看到官网有旁路推流到CDN。是否支持推流到我们这边的 srs服务呢，使用的rtmp 协议。

Reply: 您好，可以用[服务端旁路推流](https://doc.shengwang.cn/doc/media-push/restful/landing-page)来把 RTC 的画面推到指定 rtmp 地址上

---
# ID: 38392

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 其他问题

Request Description: VirtualBackgroundSource，fff一直返回3，根据错误码看了，没看出问题

Reply: 您好，可以参考下 我们的官方 [Android 虚拟背景Demo](https://github.com/Shengwang-Community/API-Examples/blob/main/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/VideoProcessExtension.java)

看下同样的参数用我们 Demo 是否会出现一样的报错

---
# ID: 38393

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.2.6

Request Type: 集成问题咨询

Request Description: 请问android升级RTM SDK轻量级版本， `implementation 'io.agora:agora-rtm-lite:x.y.z'`
可以支持 16 KB 内存页大小吗？

Reply: 您好，只要是 2.2.2 的版本以上就支持

---

# ID: 38433

SDK Product: RTC

SDK Platform: Unity

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 
1. 如何查看unity3d中声网sdk的版本？
2. unity3d声网sdk在政府部门使用，需要设置防火墙白名单，请提供支持！

Reply: 您好，要查看 SDK 版本可以用接口 [getversion](https://doc.shengwang.cn/api-ref/rtc/unity/API/toc_network#api_irtcengine_getversion)
RTC 是默认要再公网传输的，如果要内网使用的话需要付费开通[云代理](https://doc.shengwang.cn/doc/rtc/unity/basic-features/firewall)功能，您需要先联系您的对接商务了解云代理相关报价，确认后再申请开通

---
# ID: 38435

SDK Product: Analytics

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 开通权限、提供配额

Request Description: 申请开通 PSTN 云呼叫服务
内容：
你好，我正在使用你们的“对话式 AI 引擎”，需要通过 RESTful API (/v1/projects/{我的AppID}/cloud-calling/call) 来呼叫真实的手机号码 (PSTN)。
但是在我的产品列表里找不到“云呼叫”服务的开通入口。请问如何为我的项目开通这项服务？谢谢！

Reply: 您好，请保证您的 cid 企业认证通过，同时工单内备注您使用的 cid、appid、具体应用场景，我们内部登记后为您开通

---
# ID: 38438

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.2.6

Request Type: 其他问题

Request Description: java springboot 项目使用RTM检测是否在线
linux环境目前线上环境部署启动是否需要每次启动前都需要执行以下命令：
`export LD_LIBRARY_PATH=/tmp/rtm`

Reply: 您好，`export LD_LIBRARY_PATH=/tmp/rtm` 是配置临时路径，您要是在系统的环境变量配置过的话就不需要了

---
# ID: 38439

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 使用垫片功能api :`enableVideoImageSource(boolean enabled, ImageTrackOptions options); `集成后测试直接anr崩溃

Reply: 您好，请问有跑通并参考过我们[垫片 Demo](https://github.com/Shengwang-Community/API-Examples/blob/ae7e6697de66339b06e30862c4a1125fba549f31/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/LiveStreaming.java#L202) 的处理吗？可以对比下集成的用法有没有区别

---
# ID: 38449

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 效果不佳、不达预期

Request Description: 使用垫片能力后，怎样把设置垫片的图片类似采集画面一样回显到预览处

Reply: 您好，垫片功能本身仅作用于推流画面，即远端看到的是垫片图片，但本地预览默认仍显示摄像头采集的画面。有需要的话业务上指定`setupLocalVideo`的时候渲染指定`sourceType` 为图片就行

---

# ID: 38352

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 开通权限、提供配额

Request Description: 我需要开通实时语音翻译（real-time-stt）的服务，帮我开通一下
 

Reply: 您好，RTT 服务请先联系：400 6326626 分配一个跟进的销售，然后填写[报备单](https://pofz0vdxq1.feishu.cn/share/base/form/shrcnx1fsGa8p8avYejHdCfpRZg)
报备完成后同步销售，销售再为您开通对应的服务

---
# ID: 38353

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 我要下载美颜素材包 `AgoraBeautyMaterial.bundle.zip`
在哪里下载

Reply: 您好，声网高级美颜是付费服务，发布期间限时免费体验，您可以联系人工工程师来获取问卷，填写问卷后我们将为您提供对应版本的美颜素材包下载地址

---
# ID: 38355

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: R1 套件跑通 Device 端  https://doc.shengwang.cn/doc/toybox/iot/get-started/run-r1

但是git clone不下来代码，没gitlab权限。 git clone --recurse-submodules https://gitlab.bekencorp.com/armino/bk_ai/bk_aidk.git -b ai_release/v2.0.1


Reply: 您好，Device 端 可以用这个仓库 [bk_aidk](https://github.com/bekencorp/bk_aidk)

---
# ID: 38357

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 你好，我们最近在集成AI降噪插件，在文档里看见了以下：
自 v4.4.0 起，SDK 提供低延迟版 AI 降噪插件，能够在保持一定降噪效果的前提下降低处理的延迟。如需使用该功能，请联系技术支持。

我们现在是web。ios。安卓3个端都尝试接入AI降噪，文档的版本已经测试了没有问题，这个低延迟版本的请问如何接入呢？我们想对比一下，顺带可以发一个标准的和低延迟版本的对比吗？

Reply: 您如果下载的是 Native 的 full 包 SDK 的话，SDK 里自带LLExtension ，这个就是低延迟降噪插件，效果会比普通的 AI 降噪的算法生效延迟低100 ms 左右，但使用起来非常复杂，如果对延迟没有特别需求的话一般不推荐使用
有需要的话，麻烦描述下具体的场景和需求内容。

---
# ID: 38361

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 其他问题

Request Description: 语音视频通话时，说话内容不清晰（不是音量不够），请问是什么原因

Reply: 您好，听起来是音质问题，可以先参考[实现高音质](https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality)的最佳实践调整下`AudioProfile`和`audioScenario`再试试

---

# ID:38321

 SDK Product: RTC 

 SDK Platform: React Native 
 
 SDK Version: 4.5.0 
 
 Request Type: 集成问题咨询
 
 Request Description: 我想问一下声网的sdk会自建通知通道么？我这边查到一个名为“dummy_channel_id”的通知通道。

Reply: 您好，这个通知通道是 Native SDK 里的 Android 屏幕共享的 aar 插件自建的，用于屏幕共享期间保证 app 在后台能保持视频和音频采集，默认用的命名就是"dummy_channel_id"，不支持自定义修改。

---

# ID: 38341

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 对话式 AI 引擎是否支持南京话方言识别，识别准确率是否能达到 90% 以上？

Reply: 您好，可以咨询下 ASR 的第三方厂商对于方言的支持能力如何，convoAI 的 ASR 是调用第三方来实现的，第三方 ASR 厂商支持方言识别就可以做到。

---
# ID: 38343

SDK Product: RTMP

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 效果不佳、不达预期

Request Description: 现在开通了rtmp网关服务，需要将流媒体中的设备流推到会议里通过rtmp协议，流媒体和声网建立连接后退了一会就断掉了，请帮忙查看下，下面提供了日志

Reply: 您好，可以先检查下推流码和推流地址本身是否正确，以及也可以排查下您推流时用的音视频编码格式是否在我们的支持范围内：[功能描述](https://doc.shengwang.cn/doc/rtmp-gateway/restful/overview/product-overview#%E5%8A%9F%E8%83%BD%E6%8F%8F%E8%BF%B0)

---
# ID: 38344

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.5.0

Request Type: 集成问题咨询

Request Description: iOS 是否支持 LiveCommunicationKit 框架？如何集成？

Reply: 您好，LiveCommunicationKit 是类似 Callkit 的独立的信令 SDK，和 RTC 没有关联，您业务上自行集成然后搭配调用 RTC 的接口就行

---

# ID: 38308

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 西南-成都地区OSS请求参数需要怎么配置？

Reply: 您好，云录制的 vendor 对应 region 信息可以查看[第三方云存储地区说明](https://doc.shengwang.cn/doc/cloud-recording/restful/api/reference)

---
# ID: 38309

SDK Product: Recording

SDK Platform: Linux-C

SDK Version: 其他版本

Request Type: 商务问题

Request Description: 想要在类似于扫地机器人的产品上集成视频对话功能，需要 Linux SDK

Reply: 您好，服务端 Linux 可以用：[RTC 服务端 SDK](https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/landing-page)
IOT Linux 设备可以用[媒体流加速](https://doc.shengwang.cn/doc/rtsa/c/landing-page)

---
# ID: 38313

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 线上报错

Request Description: 
1. CDN推流失败，水晶球CDN实时推流中无法看到详情；
2. 拉流端报错，报PLAYER_ERROR_INVALID_MEDIA_SOURCE等信息；
3. 频道通话是能正常开的；

Reply: 您好，请提供下出现问题的 CDN 推拉流地址，人工工程师稍后验证下地址可用性

---
# ID: 38320

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 请问：我了解到贵司不提供前端语音对话式的AI通话的前端UI界面，我想知道如果我们自己设计UI的时候，是依据哪个模块的API呢？

背景：我们自己已经部署本地私有化大模型，RAG知识库问答，然后我们是通过h5的形式嵌入到安卓、鸿蒙的系统的im聊天工具的某个模块中打开进入h5AI助手中。

Reply: 您好，convoAI 是用 Restful 接口来让智能体加入 RTC 频道的，前端 UI 是您自行实现的，前端要展示的内容可以参考文档看下需要的数据都分别来自什么功能，比如通过 webhook 来[监听智能体事件](https://doc.shengwang.cn/doc/convoai/restful/user-guides/listen-agent-events)

---
# ID: 38322

SDK Product: RTC

SDK Platform: Windows

SDK Version: 其他版本

Request Type: 商务问题

Request Description: 我们的应用场景：工业设备监控 要求7x24x365全面监控 一个摄像头推流  拉流查看端口平时1个 偶尔有2-4个 应该买什么产品。之前买过RTC感觉费用过高 有没有更合适的可用产品呢？

Reply: 您这个场景可以考虑下 RTC 的[极速直播](https://doc.shengwang.cn/doc/rtc/windows/basic-features/ls-quick-start)，极速直播费用会低一些

---

# ID: 38277

SDK Product: RTC-Linux

SDK Platform: Linux-C

SDK Version: 4.4.32

Request Type: 集成问题咨询

Request Description: `sendStreamMessage`发送信息sdk返回`ret = -9`，已验证streamId可用，并且不存在频率过高或者msg过大的问题

Reply: 您好，Linux 服务端 SDK 调用`sendStreamMessage`返回-9 表示用了观众身份在发送，这个接口需要用主播身份才能正常调用发送的，请修改对应用户的 role

---
# ID: 38282

SDK Product: RTC

SDK Platform: React

SDK Version: 2.5.0

Request Type: 其他问题

Request Description: 在 iOS 中，无论是 .mobileconfig 还是 PWA 的全屏情况下，无法显示摄像头视频（音频能获取到）。在 safari 浏览器是正常的。

Reply: 您好，可以先把 [webrtc 官方的 Demo](https://webrtc.github.io/samples/src/content/getusermedia/gum/) 放进去看下能否正常获取摄像头权限，如果 WebRTC 官方 Demo 无法正常工作，那就说明当前 Webview 不支持 webrtc 协议

---
# ID: 38286

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 其他问题

Request Description: 我们的视频源中有sei信息，需要在播放时展示，声网的播放器如何实现？有好的方案和建议吗 ？

Reply: 您好，Web 的IRemoteVideoTrack 里有 [sei-received](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iremotevideotrack#on) 可以监听，这样就可以拿到远端发来的 SEI 信息了，然后您自行处理就行

---
# ID: 38289

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 集成问题咨询

Request Description: 
前端需求明确仅使用麦克风，但浏览器实际弹窗为“麦克风和摄像头”合并权限，而非单独麦克风。希望明确禁止请求摄像头权限，确保用户不被摄像头弹窗打扰。

我方前端已严格实现“只麦克风”权限路径，并提供明确的用户提示与代码证据；仍出现摄像头权限弹窗，影响用户体验。

Reply: 您好，SDK 不会自己调用摄像头的，推测代码里肯定有调用创建视频轨道的相关操作，可以开启[日志上传](https://doc.shengwang.cn/faq/integration-issues/set-log-file)以后复现问题，再提供频道号、uid、时间点发来看下
以及测试下我们 Demo里的[纯语音通话](https://doc.shengwang.cn/doc/rtc/javascript/basic-features/audio-quick-start)会不会有同样的问题

---
# ID: 38295

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 咨询一下批量订阅的功能需不需要手动调用取消批量订阅？
我调用massSubscribe方法批量订阅ABCDE，如果我想切换订阅的对象，是直接调用massSubscribe方法批量订阅FGHIJ就可以了，还是要先调用massUnsubscribe方法批量取消订阅ABCDE，然后再调用massSubscribe方法批量订阅FGHIJ？

Reply: 您好，`massSubscribe` 只是订阅方法，不会自动取消订阅，业务上有需求的话需要搭配 `massUnsubscribe` 去手动取消订阅不需要的 uid

---
# ID: 38298

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 650ms 是理论链路的最低延迟，使用特定三方厂商搭配+经过私参特调以后可以实现
想问下  集成如果想达到这个效果  具体有实践方案么？

Reply: 您好， 650ms 是理论最低延迟，会受到链路上第三方厂商的波动情况而增加延迟，降低延迟的话可以去 [AI 模型评测平台](https://www.shengwang.cn/duihua/benchmark/overview?region=Shanghai)自行组合延迟更低的搭配
客户端上可以参考[音频设置最佳实践](https://doc.shengwang.cn/doc/convoai/restful/best-practice/audio-settings)

---
# ID: 38302

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 怎么获取远端画面的视频的帧率

Reply: 您好，可以监听[onRemoteVideoStats](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_video_basic#onRemoteVideoStats)来获取

---
# ID: 38304

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 集成问题咨询

Request Description: 我现在接入了灵动课堂web的sdk，想让用户用手机打开直播间的网页也可以正常显示 web的sdk的ui好想没有兼容手机端，我现在需要再接入h5的吗，最简单的方式是什么，有h5的sdk吗？没有找到

Reply: 您好，灵动课堂要看到 h5 页面的话，Web 端 launch 的时候配置[LaunchOption](https://doc.shengwang.cn/api-ref/flexible-classroom/javascript/classroom-sdk#launchoption)的platform 为 h5 就可以了
不过我们优先推荐用 [PAAS SDK](https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo) ，开发更灵活一些

---

# ID: 38261

SDK Product: RTC

SDK Platform: MacOS

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 请问，如果集成macos rtc sdk实现屏幕共享功能，如何指定屏幕分享的内容的时候“不显示鼠标的光标”？

Reply: 您好，
1、可以参考下 Mac 的[屏幕共享](https://doc.shengwang.cn/doc/rtc/macos/basic-features/screen-share)文档
2、屏幕共享时无法隐藏光标，显示鼠标是系统行为，SDK 侧无法调整

---
# ID: 38262

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 其他问题

Request Description: track的类型应该IRemoteVideoTrack吧，你们是不是搞错啦，IRemoteVideoTrack extends IRemoteTrack的，IRemoteTrack 的play方法的参数没有config参数

Reply: 您好，IRemoteTrack的 play 没有 config 配置，一般都是具体到 audioTrack 或者 videoTrack 才会有 config 配置的，参考[iremotevideotrack](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iremotevideotrack)

---
# ID: 38266

SDK Product: Fastboard

SDK Platform: Web

SDK Version: 1.0.0

Request Type: 集成问题咨询

Request Description: Fastboard 使用通过 CDN 集成 SDK 后，访问浏览器报错。

请问如何通过CDN方式集成SDK呢？

Reply: 您好，CDN 集成有局限性，除了`fastboard@1.0.0`还需要`@netless/window-manager white-web-sdk`，还需要用`type="module"`的方式，建议尽量[通过 npm 集成 SDK](https://doc.shengwang.cn/doc/whiteboard/javascript/fastboard-sdk/resources-fb)

---
# ID: 38272

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: sdk版本 3.7.0   能小屏幕直播吗？ 增加小窗口，可以缩小直播间

Reply: 您好，小窗、画中画功能是 4.x 才实现的，您至少需要升级到 4.x 才可以用到[PictureInPicture](https://github.com/AgoraIO/API-Examples/tree/main/iOS/APIExample/APIExample/Examples/Advanced/PictureInPicture)

---

# ID: 38249

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 申请测试域名，我自己弄的域名推流不成功，不知道是什么原因

Reply: 您好，我们没有测试域名，请问现在您自己配置的推拉流域名在 console 上是什么状态？可以截图看一下，然后提供下域名、推拉流地址给我，我看看情况
您这边也检查下 [CNAME 的配置](https://doc.shengwang.cn/doc/fusion-cdn/restful/get-started/quick-start#3-%E5%AE%8C%E6%88%90-cname-%E9%85%8D%E7%BD%AE)是否已经完成了？

---
# ID: 38253

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 其他问题

Request Description: 大疆在h264/265流中包含了sei信息，声网播放器能够直接读取视频流中的sei的信息并绘制矩形框做标记框的位置和类型吗？

Reply: 您好，不支持，建议自渲染来实现相关业务，可以参考[Web 自渲染 Demo](https://github.com/AgoraIO/API-Examples-Web/tree/main/src/example/advanced/selfRendering)

---

# ID: 38221

SDK Product: Recording

SDK Platform: Linux-Java

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 日志提示执行了start的录制sh脚本，但是实际上没有视频生成。导致移动视频的时候报空指针。如果流量打到A服务器那就会有视频，但是没有打到A服务器。打到了B服务器。两个脚本的权限都是一样的。

Reply: 您好，我们本地录制已经更新过一般新的了，建议先集成我们最新的[本地服务端录制下载](https://doc.shengwang.cn/doc/recording/java/resources)，跑一下 Demo 看看还会不会有问题

---
# ID: 38223

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.1

Request Type: 其他问题

Request Description: 问下我们有客户需要在伊朗使用，咱们的服务支持伊朗地区吗

Reply: 您好，支持伊朗的，不用特殊部署

---
# ID: 38226

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 在语聊房间我进入后台 麦克风会断掉 sdk支持进入后台录音不断吗

Reply: 您好，可以看下文档，给 app 做一个前台消息常驻+保活，参考[为什么部分 Android 版本 App 锁屏或切后台音视频采集或播放（渲染）无效？](https://doc.shengwang.cn/faq/quality-issues/android-background)

---
# ID: 38231

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: iOS rtc版本号4.6.0，AgoraRtcVideoCanvas的renderMode设置为AgoraVideoRenderModeFit，但是视频未铺满的区域没有显示黑色

Reply: 您好，AgoraRtcVideoCanvas 里的backgroundColor 设置成黑色就可以解决了

---

# ID: 38198

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 我在iOS端加入频道成功，可以听见安卓端的说话，自己麦克风的声音 对方听不到，iPhone的麦克风权限已开。
iOS端我是用 `self.rtcEngine setClientRole:AgoraClientRoleBroadcaster`的逻辑实现的。
安卓端的log如下：
```
onAudioSubscribeStateChanged channel:1003 uid:10000306 oldState:0 newState:2 elapsed:5
onAudioSubscribeStateChanged channel:1003 uid:10000306 oldState:2 newState:1 elapsed:1，
```
远端订阅没有成功。


Reply: 您好，[onAudioSubscribeStateChanged](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_publishnsubscribe#onAudioSubscribeStateChanged)的`oldState`为 1 表示`SUB_STATE_NO_SUBSCRIBED`，可能的原因在文档中详细列举了，您可以先对照文档排查下是否有类似情况发生

---
# ID: 38206

SDK Product: RTC

SDK Platform: Electron

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 想咨询一下在调用`setBeautyEffectOptions`开启美颜后，视频画面下方会出现一些马赛克，是什么原因造成的，是否有方法能优化

Reply: 您好，请问目前出现问题的什么平台和 SDK 版本？4.2.x 的 Windows 美颜确实有些问题，推荐避免使用`setBeautyEffectOptions`，改用第三方美颜来实现。

---
# ID: 38211

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 集成问题咨询

Request Description: 我们下载你们的demo代码，token改成我们的之后，可以进入课堂，但是，右下角没有 im图标模块，我们需要这个IM模块，如何调出来呢？

Reply: 您好，可以检查下调用服务端创建课堂接口时传入的 `roomProperties.widgets.easemobIM.state`字段是否禁用了 聊天室组件

---
# ID: 38212

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 集成问题咨询

Request Description: 实时互动开启屏幕共享，在`user-published`事件回调函数返回的user中，能获取到video媒体流，如何获取媒体流的宽高尺寸大小？看文档没有提供，自己找到下划线开头的`user._videoTrack._videoWidth`偶尔可以获取到，但是很不稳定，如何解决？


Reply: 您好，`getRemoteVideoStats` 会返回 [RemoteVideoTrackStats](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/remotevideotrackstats)，`RemoteVideoTrackStats` 里看`receiveResolutionHeight` 和`receiveResolutionWidth`可以获得宽高信息


---
# ID: 38213

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 云录制如果频道中只有一个真实用户，我监听声网回调（用户加入频道，用户离开频道），来作为真实用户是否在频道中可以么？

例如：收到了声网回调A用户加入频道，我就设置一个状态为true；收到了声网回到A用户离开了频道，我就将状态设置为false。通过这种方式来判断频道内是否还有真实用户，如果没有则停止云录制。这个加入/离开一定是按照顺序的么？会不会先收到了离开，后收到了加入，那么用户在我这就永远都是加入在频道内了。

Reply: 您好，云录制有 `idletime` 字段，如果频道里没人发流一段时间，`idletime` 时间到了云录制会自己退出的，不需要您手动维护状态去关闭。

---
# ID: 38214

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 开通权限、提供配额

Request Description: 您好，咨询一下同一个账号在频道创建个数上有没有限制，频道并发创建QPS是多少？

Reply: 您好，RTC 没有创建频道的并发 QPS 限制

---

# ID: 32208

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 在游戏异常崩溃后，我没有办法调用 Leave 方法离开频道。然后，我重新打开游戏客户端并尝试重新连接，但此时游戏房间已经因时间到达而关闭，导致我无法再进入原来的游戏房间。请问在这段时间里，我是否仍然连接在声网的频道内？如果我确实还在频道内，此时使用游戏服务器返回给我的另一个 Token 和 uid 尝试加入新的房间时，似乎无法成功进入新频道。对此是否有处理方案？

Reply: 崩溃以后属于客户端和我们边缘节点断开连接了，这个时候用户连不上服务器但还会被视为在频道内。此时我们的服务端会尝试重连客户端 20s 左右，如果在此期间重连上了 那就继续保持在频道内的状态，如果连不上 就按连接超时 异常退出频道记录。

所以优先用原来的 uid 和 token 重连加频道，如果加不进去可以再申请新的 token 和 uid，不过一般来说 新的 token 和uid 肯定可以直接加入的，如果加不进去可以检查一下 token 是否匹配新的 uid

---

# ID: 32211

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.4.0

Request Type: 效果不佳、不达预期

Request Description: IOS调用EnableLocalAudio接口会卡顿 能否在后续版本优化一下

Reply: EnableLocalAudio会重启adm，耗时较久，不建议业务上高频使用，只在初始化后调用一次即可

---
# ID: 32214

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 远程端控制本地端的视频停止，并且保留最后一帧停止前的画面，该画面能被远程设备所接收。我是使用rtcEngine.muteLocalVideoStream(true);远程设备就收不到视频流画面。有什么比较好的方式实现效果。

Reply: SDK 没有提供控制远端是否发流的接口，muteLocalVideoStream只是针对本地的发流，true 就是停止发流，false 就是恢复。

如果你有控制远端发流的需求，可以考虑集成第三方信令 SDK，让远端收到信令后自己执行mute操作；或者考虑使用 restful 接口指定 uid 失去短时间发流的权限；

另外，远端设备默认显示最后一帧画面，需避免在回调中清除视图

---

# ID: 38172

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.5.0

Request Type: 其他问题

Request Description: 上传Google Play后台后， Google Play后台显示libAgoraRtcWrapper.so不支持16kb,
请问下  这个是在那个版本的Unity SDK 开始支持的？  我这边升级到4.5.1能处理这个问题吗？

Reply: 您好，目前官网上的 Unity 版本不支持 16kb，请更换成[支持 16kb 版本的 4.5.1 Unity SDK Full 包](https://download.agora.io/sdk/release/Agora_Unity_RTC_SDK_4.5.1_FULL_20250617_468_build.5.zip)
音频包用[支持 16kb 版本的 4.5.1 Unity SDK Audio 包](https://download.agora.io/sdk/release/Agora_Unity_RTC_SDK_4.5.1_VOICE_20250617_471_build.5.zip)

---
# ID: 38177

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 請問雲端錄製服務上傳視頻到雲存儲時有沒有固定ip呢？由於安全考量，我們需要針對使用accessKey的上傳方配置IP白名單

Reply: 您好，云录制不提供固定域名或 IP，请使用 OSS 提供商的 Bucket 权限策略 或 STS 临时令牌 替代实现 

---
# ID: 38181

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 效果不佳、不达预期

Request Description: 安卓设备使用移动的4G物联卡，rtc语音通话没有声音，使用wifi网络时通话正常
物联网卡里添加了域名白名单`.*agora.io`和`sd-rtn.com`；
以下是启动rtc的日志，显示加入频道成功，但没有音频数据，请问会是什么原因导致的？

Reply: 您好，Android SDK 从 4.6.0 开始，使用物联网卡需要报备的域名改为了 国内额外报备 `*.rtnsvc.com` 和 `*.realtimemesh.com`，请确认下目前使用的 SDK 版本是否在 4.6.0及以上
以及确保开启了`domainLimit`开关。

---
# ID: 38182

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 我需要确认一个东西，就是现在在国内的平台上使用声网的服务，但是实际上我们的app都是海外用户在用，如果使用海外的那个agora 速度会更快吗（因为我们大部分用户都是欧美地区的）

Reply: 您好，所有 SDK 都是优先连接当地节点的，，只是从 4.6.0 版本开始，海外版本在国内的时候默认不会优先连国内的节点，需要申请后解除限制。海外用户用国内版本 SDK 还是正常的，速度不会受影响。

---
# ID: 38183

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 其他问题

Request Description: 想咨询，实时音视频会议的功能，是否有提供实时字幕翻译的功能调用接口？以及是否有配套ui组件

Reply: 您好，RTC 本身不自带字幕功能，要实现的话需要使用 [Real-Time Speech to Text](https://docs.agora.io/en/real-time-stt/overview/product-overview)，该产品还没有国内文档，但是服务可用，可以参考海外文档集成。
如果您是在使用 convoAI 的话，是有封装好的字幕组件的，参考[实时字幕](https://doc.shengwang.cn/doc/convoai/restful/user-guides/realtime-sub)。

---
# ID: 38191

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 目前看到在用户获取token的过程中 是需要传入 channelName，所以一个token对应一个channel是么？ 那这样的话我们想做成抖音那种上下滑动的模式，这样的话 只能在滑到对应房间的时候重新获取token么？ 有没有通用token的方案？

Reply: 您好，可以在生成 token 的时候指定频道名为通配符，这样 token 就不校验频道名了，参考[生成通配 Token](https://doc.shengwang.cn/doc/rtc/ios/basic-features/token-authentication#%E7%94%9F%E6%88%90%E9%80%9A%E9%85%8D-token)

---

# ID: 33154

SDK Product: RTM

SDK Platform: JavaScript

SDK Version: 2.1.9

Request Type: 集成问题咨询

Request Description: 微信小程序如何集成RTM，可以直接使用js sdk吗，

Reply: 2.x 目前没有小程序的RTM SDK ，可以自行尝试用js SDK实现，但是可行性没有通过官方测试，需要开发者自行探索。

---
# ID: 33155

SDK Product: RTC

SDK Platform: React Native

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 一个远端视频流，能渲染出多个远端视频窗吗

Reply: 3.x版本目前不支持，4.x是支持的：同一个远端视频流可以通过创建多个渲染视图（如 SurfaceView）实现在不同容器中显示

---
# ID: 33163

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 你好，我想询问下融合CDN直播配置的证书，推流和播流可以分开配置吗？我想取消推流时使用的证书，但是一直显示配置正在审核

Reply: 1. 推流和播流证书可分开配置
在融合CDN直播中，推流（推流域名）和播流（播放域名）的证书支持独立配置。您可在声网控制台分别管理：

推流域名证书：通过「推流域名」页签配置
播流域名证书：通过「播放域名」页签配置（需单独添加证书）
2. 取消证书显示“审核中”的原因
证书变更（包括取消）需经过审核与全球节点同步，通常需几个工作日。此期间状态会显示“配置正在审核”，属正常流程。如需加急或者确认审核状态请等待人工技术支持工程师回复。

---

# ID: 33060

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 其他问题

Request Description: 想咨询一下咱们的音视频录制功能，我想本地开启一个屏幕共享然后把采集到的音视频数据通过咱们音视频录制功能存储到本地，这个方案是否可以？

Reply: 支持本地存储[startRecording](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_recording#startRecording:)开启音视频流录制。录制文件保存在本地的绝对路径，但我们优先推荐您使用云录制

---
# ID: 33063

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 其他问题

Request Description: 再次咨询一下iOS端的屏幕共享，这个屏幕共享的数据是否支持视频存储，例如本地视频存储或云端视频存储， 具体需要使用咱们哪些SDK来实现

Reply: 支持本地存储[startRecording](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_recording#startRecording:)开启音视频流录制。录制文件保存在本地的绝对路径
可以通过[云端录制](https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page)进行录制，将屏幕共享视频流保存到您指定的第三方对象存储（如阿里云OSS、AWS S3等）

---
# ID: 33064

SDK Product: Console

SDK Platform: All

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 我是做无人机的webRTC直播，只用到了视频的推流，没有涉及语音。在控制台显示，时间消耗大部分是语音消耗了分钟数。可以把语音推流关闭不？怎么取消语音的消耗。在我的应用中不需要语音推流

Reply: 声网SDK允许通过代码控制只发送视频流，不发送音频流。例如，使用 [IMicrophoneAudioTrack.muted](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/imicrophoneaudiotrack#muted) 方法来禁用本地音频发送。但声网费用默认是按照[集合分辨率](https://doc.shengwang.cn/doc/rtc/javascript/billing/billing-strategy#%E9%9B%86%E5%90%88%E5%88%86%E8%BE%A8%E7%8E%87)计算，集合分辨率是指用户订阅的所有不同类型视频流的分辨率的总和。

---
# ID: 33066

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 线上报错

Request Description: 在那个demo示例当中没办法直播 然后 录制了 但是没有办法停止啊

Reply: 如果在stop/query有错误导致无法停止可以参考[为什么成功开启云端录制后调用 query 方法返回 404？](https://doc.shengwang.cn/faq/integration-issues/return-404)

---
# ID: 33070

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我想使用AI降噪的功能。 音频流是现成的pcm，而不是通过RTC框架去获取的。  能够直接使用AI降噪功能吗？ 怎么实现？

Reply: 可以使用音频自采集将音频流推到声网频道内并开启AI 降噪
参考[自定义音频采集和渲染](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_custom_capturenrendering)

---
# ID: 33077

SDK Product: RTC

SDK Platform: Restful

SDK Version: 其他版本

Request Type: 其他问题

Request Description: RTC实时互动的云端录制怎么接移动云，我们的云存储用的是移动云的。

Reply: 云录制目前不支持移动云，参考[第三方云存储地区说明](https://doc.shengwang.cn/doc/cloud-recording/restful/api/reference#%E7%AC%AC%E4%B8%89%E6%96%B9%E4%BA%91%E5%AD%98%E5%82%A8%E5%9C%B0%E5%8C%BA%E8%AF%B4%E6%98%8E)

---
# ID: 33079

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.0.0

Request Type: 效果不佳、不达预期

Request Description: 声音一直有问题

Reply: 问题现象描述模糊，可以参考以下常见的音频质量问题的解决方案：
[如何处理音量太小问题？](https://doc.shengwang.cn/faq/quality-issues/audio-low)
[如何处理音频卡顿问题？](https://doc.shengwang.cn/faq/quality-issues/audio-freeze)
[如何处理音频噪声问题？](https://doc.shengwang.cn/faq/quality-issues/audio-noise)
[如何处理无声问题？](https://doc.shengwang.cn/faq/quality-issues/no-audio)

---

# ID: 33083

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 其他问题

Request Description: 使用声卡的主播会出现连麦或者PK的时候声卡效果不生效的问题，如附件图片所述。

Reply: 一些独立声卡会包含3A功能，而sdk默认也会开启3A。对于使用声卡的主播我们一般建议关闭sdk的3A
参考文档[声卡用户设置](https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality#%E5%A3%B0%E5%8D%A1%E7%94%A8%E6%88%B7%E8%AE%BE%E7%BD%AE)

---
# ID: 33084

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.1

Request Type: 集成问题咨询

Request Description: 你好，我想问下我在观众变为主播后，在onClientRoleChanged中我想要播放一段接通的音效，但是播放了1s后被麦克风流给中断了，那我该如何解决了

Reply: 
1. 不建议在回调中进行耗时操作
2. 一般场景是在音效播放完再进行上麦操作，不然确实会存在抢占打断行为

---

# ID: 33087

SDK Product: RTM

SDK Platform: JavaScript

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 项目使用的是调试模式创建，使用rtm.login()方法登录报错，导致后续流程无法进行

Reply: 可以参考[错误排查](https://doc.shengwang.cn/doc/rtm2/android/error-codes)了解报错原因

---

# ID: 33090

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.19.0

Request Type: 集成问题咨询

Request Description: 怎么集成IM聊天。有没有web版的调用方式

Reply: RTC Web SDK 不提供原生文字聊天功能（如单聊/群聊），需单独集成 IM SDK（如[环信IM](https://www.easemob.com/)）实现完整聊天功能。

---
# ID: 33099

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.0.0

Request Type: 商务问题

Request Description: 离线部署服务

Reply: 您好，离线部署、私有化部署等问题可以直接联系您的专属商务经理或者可以直接通过电话联系声网商务进行咨询，联系方式：400 6326626

---

# ID: 33104

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 麦位声音很不稳定，说话几乎没有声音，怎么调都没用，有时候还很炸麦，有电流声

Reply: 可以参考：[如何处理音频噪声问题？](https://doc.shengwang.cn/faq/quality-issues/audio-noise)

---
# ID: 33106

SDK Product: RTC

SDK Platform: React Native

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: ios端  使用哪个动态库

Reply: 参考文档 [下载iOS SDK](https://doc.shengwang.cn/doc/rtc/ios/resources)

---

# ID: 33148

SDK Product: RTC

SDK Platform: React Native

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 按照文档，我使用react集成了视频会议，使用react native 的ios部分集成agora的屏幕分享功能，可以加入channel，能打开视频和声音，但是屏幕分享不到会议中，并且start broadcast一会自动关掉。

请问如何解决？谢谢

Reply: 参考[React Native-屏幕共享集成文档](https://doc.shengwang.cn/doc/rtc/rn/basic-features/screen-share#ios-%E5%B9%B3%E5%8F%B0)
[屏幕共享示例项目](https://github.com/AgoraIO-Extensions/react-native-agora/blob/main/example/src/examples/advanced/ScreenShare/ScreenShare.tsx)

---

# ID: 33032

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.19.0

Request Type: 集成问题咨询

Request Description: 我使用Flat开源教室的这个demo。
1、前后端启动，登录后，想要创建房间，一直不成功，提示失败。请帮忙看看，是不是配置有问题。
2、开源的这个demo，它的白板是开源的吗？

Reply: 
1. 验证Token配置：检查AppID和Token生成是否正确（文档中强调Token需正确配置），可参考文档中Token生成指南。参考[生成和使用 Token](https://doc.shengwang.cn/doc/whiteboard/javascript/fastboard-sdk/basic-features/generate-token)文档
2. 参考[白板集成文档](https://doc.shengwang.cn/doc/whiteboard/javascript/fastboard-sdk/get-started/join-room-fb)
3. 参考[Agora Flat Server-readme](https://github.com/netless-io/flat-server/blob/main/README-zh.md)

---

# ID: 33039

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.0.0

Request Type: 集成问题咨询

Request Description: 我们要做一个语音房聊天项目，ios端
现在想要集成，但是处于看demo的阶段，我试了agora-ent-scenarios、AUIVoiceRoom，都是在创建房间的时候失败，不知道是因为什么

声网、环信相关id我都填进去了，不知道为什么点击创建会失败

附件是AUIVoiceRoom点击创建房间后的所有log

Reply: 跑通demo请参考声动互娱的[readme文档](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/main/iOS/AgoraEntScenarios/Scenes/VoiceChatRoom),按照文档获取相关信息并填入

---
# ID: 33040

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 效果不佳、不达预期

Request Description: 融合CDN直播服务启用录制后录制的视频在哪里可以看到，只有用api才能查询到吗？查询单个流录制文件列表接口返回404，找不到m3u8文件，查询参数开始时间和结束时间我是按照之前直播的时间查询的

Reply: 融合CDN录制文件存储在您配置的第三方云存储（如阿里云OSS）中，可以在第三方OSS上获取录制文件。
404：服务器无法根据请求找到资源，即请求的域名不存在或者请求的 URI 路径非法。
参考[响应状态码](https://doc.shengwang.cn/doc/fusion-cdn/restful/response-code)

---
# ID: 33041

SDK Product: RTC-Linux

SDK Platform: Linux-Python

SDK Version: 2.1.0

Request Type: 集成问题咨询

Request Description: 我正在使用`Agora-Python-Server-SDK`示例项目，运行服务端发流`example_audio_pcm_send.py`示例，一直没有收到`INFO:observer.connection_observer:on_connected`成功连接频道后的日志打印。我这台服务器是使用内网穿透，请问怎么解决？

Reply: 内网情况互通可能涉及到私有化部署，请联系您的专属商务经理或通过电话联系声网商务进行咨询，联系方式：400 6326626

---
# ID: 33043

SDK Product: RTC

SDK Platform: React Native

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 使用共享屏幕接口后本地视图停留在了视频的最后一帧，并没有切换到共享屏幕。
加入频道成功了，开启摄像头也成功了，开启共享屏幕也成功了，状态码没问题，也拿到了权限，安卓手机上显示了正在共享的标志，视图层使用的是rtc-surface-view组件，用的uniapp开发的:zOrderMediaOverlay和:zOrderOnTop设置的true

Reply: uniapp sdk目前已经停止更新维护，建议用原生开发[屏幕共享](https://doc.shengwang.cn/doc/rtc/android/basic-features/screen-share)

---
# ID: 33045

SDK Product: RTSA

SDK Platform: Linux-CPP

SDK Version: 1.9.2

Request Type: 崩溃（闪退、卡死）

Request Description: 没办法推流

Reply: 崩溃问题麻烦提供以下信息：
1、是否发生在频道内
2、如果在频道内提供频道名、UID、崩溃时间
3、崩溃概率
4、崩溃原始堆栈以及崩溃时间点SDK LOG
5、什么操作导致的崩溃

---
# ID: 33046

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.3.2

Request Type: 崩溃（闪退、卡死）

Request Description: 用户反馈使用音频进入页面闪退，由于本地这边没法复现这个问题，帮忙看下这个时间段的记录有没有什么异常的点。

Reply: 崩溃问题麻烦提供以下信息：
1、是否发生在频道内
2、如果在频道内提供频道名、UID、崩溃时间
3、崩溃概率
4、崩溃原始堆栈以及崩溃时间点SDK LOG
5、什么操作导致的崩溃

---
# ID: 33047

SDK Product: RTC

SDK Platform: Restful

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 通过后台云端录制的功能录制出来的视频，会偶尔出现卡住黑屏的问题，可否帮我们排查一下是不是网络原因

Reply: 1、确认频道内通话视频是否正常，如果通话中视频有黑屏那么问题出在通话中而非录制
2、如果通话中正常只有录像黑屏，可以检查下是否存在UID冲突，即云录制中的UID使用了和频道内的用户相同的UID。请确保同一频道内的UID的唯一性。
3、检查是否有设置录制订阅UID且订阅的UID并不在频道，导致录制下来的视频流是空的
4、检查是否开启录制的时候没有主播在频道内发流导致录像流是空的
5、如果以上问题均不存在请提供频道名、UID以及录制sid 方便我们进一步排查

---
# ID: 33048

SDK Product: RTM

SDK Platform: Object-C

SDK Version: 2.2.2

Request Type: 集成问题咨询

Request Description: 老师 iOS新版云信令的demo有吗 能帮忙提供下吗？就是支持主叫呼叫被叫的功能的。
目前看声网官网只有消息发送的简单参考，其他的关于最新版SDK的云信令呼叫功能都没看到。

还有个问题想咨询下 咱们1.*.*版本是用Swift开发的 2.*.*改为了oc  那后面是要继续使用oc还是 要再改回Swift

Reply: RTM 2.x版本支持呼叫邀请功能,可以通过点对点消息参考原来的呼叫邀请逻辑自行实现。

---
# ID: 33049

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 通话声音可以听到, 但是达不到扩音器的效果, 貌似是听筒的声音

Reply: 1、 确保[setChannelProfile](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_channel#setChannelProfile)场景为CHANNEL_PROFILE_LIVE_BROADCASTING (1)：（默认）直播
2、 检查[setAudioScenario](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#setAudioScenario)设置为AUDIO_SCENARIO_GAME_STREAMING
3、 正确[设置音频路由](https://doc.shengwang.cn/doc/rtc/android/advanced-features/audio-route)

---
# ID: 33050

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 使用融合cdn直播服务，开启了标准录制后，调用查看录制文件列表接口总是返回404m3u8文件找不到。除了调用api查看录制文件的列表还有别的方案吗

Reply: 404一般是服务器无法根据请求找到资源，即请求的域名不存在或者请求的 URI 路径非法。需要检查请求中的 URI 路径是否正确。
可以配置[融合 CDN 直播事件类型](https://doc.shengwang.cn/doc/fusion-cdn/restful/webhook/ncs-event#%E8%9E%8D%E5%90%88-cdn-%E7%9B%B4%E6%92%AD%E4%BA%8B%E4%BB%B6%E7%B1%BB%E5%9E%8B)获取录制文件名

---
# ID: 33051

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.3.2

Request Type: 集成问题咨询

Request Description: 调用了jonchannel为什么没有回调

Reply: joinChannel 返回 0 但无 onJoinChannelSuccess，需检查 [onConnectionStateChanged](https://doc.shengwang.cn/api-ref/rtc/flutter/API/toc_network#onConnectionStateChanged) 状态值。
如需进一步调查请提供sdklog

---
# ID: 33052

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.1

Request Type: 集成问题咨询

Request Description: 我集成1v1的时候，预览显示我是横着显示的，这是为什么呢

Reply: 参考[旋转方向模式](https://doc.shengwang.cn/doc/rtc/android/basic-features/video-profile#%E6%97%8B%E8%BD%AC%E6%96%B9%E5%90%91%E6%A8%A1%E5%BC%8F)设置

---
# ID: 33053

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 设置课堂状态  接口返回token  不正确   token 应该使用哪个生成的?

Reply: 参考[灵动课堂-使用 Token 鉴权](https://doc.shengwang.cn/doc/flexible-classroom/javascript/basic-features/generate-token)

---

# ID: 33011

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.2

Request Type: 其他问题

Request Description: web端rtc支持网络摄像头吗？什么流

Reply: 可以通过webRTC的采集检测页面判断是否支持网络摄像头：[WebRTC samplesSelect sources & outputs](https://webrtc.github.io/samples/src/content/devices/input-output/)

---
# ID: 33012

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.1

Request Type: 集成问题咨询

Request Description: 教师发起直播的时候进行wss推送消息的时候失败，错误信息为：`WebSocket is closed before the connection is established`

导致在其他在房间的用户没有收到websocket消息，不能进行视频观看

Reply: `WebSocket is closed before the connection is established` 是warning而非error不影响实际使用。
请提供频道名、UID以及问题时间点 方便我们进一步排查

---

# ID: 33018

SDK Product: RTC

SDK Platform: Restful

SDK Version: 其他版本

Request Type: 其他问题

Request Description: esp32设备和声网小程序在通话时，小程序有时候因为网络问题退出后，设备方没有收到小程序退出的回调，这大概是些什么原因导致的

Reply: 
1. 小程序需要是主播身份离开时才能触发回调
2. SDK 在检测远端用户掉线时存在时间窗口（默认约 20 秒）。若小程序因瞬时网络问题快速退出，设备端可能未触发超时判定

---
# ID: 33021

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.0.0

Request Type: 集成问题咨询

Request Description: 在使用iOS的“声动互娱”项目中秀场直播功能，创建直播间提示：
`[AUIRtmManager][SyncManager] releaseLock[88128964][rtm_referee_lock] completion, error code: Lock service is not available.`
另外一个测试账号下就没有问题，请问这是什么情况？需要怎么修改

Reply: 检查RTM 在 console 控制台上所应用的权限是否都已打开，建议参考[秀场直播-readme文档](https://github.com/AgoraIO-Usecase/agora-ent-scenarios/tree/main/Android/scenes/show)跑通demo

---
# ID: 33022

SDK Product: RTSA

SDK Platform: Linux-CPP

SDK Version: 1.9.2

Request Type: 线上报错

Request Description: 问题：WebDemo推送视频，RTSA Linux Demo接收端报错
`[__rcv_video_data:433] Invalid payload type 100`
这个payload type怎么配置呢，没看到配置的地方，怎么才能校验通过

Reply: 参考[与 RTC SDK 互通音视频数据](https://doc.shengwang.cn/doc/rtsa/c/best-practices/interoperate-rtc)文档实现双端音视频编码格式对齐

---
# ID: 33023

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.2.3

Request Type: 集成问题咨询

Request Description: 现在使用有明显的回声，需要AI 回声消除插件，请问一下怎么集成呢，说的联系技术支持，谢谢

Reply: 自 v4.1.0 起，SDK 提供 AI 回声消除插件，该插件可以在较恶劣的回信比 (echo-to-signal) 条件下保存完整、清晰、流畅的近端人声，显著提高系统的回声消除和双讲性能，带给用户更舒适的通话和直播体验，广泛应用于适用于会议、语聊、K 歌等场景。自 v4.4.0 起，SDK 提供低延迟版 AI 回声消除插件，能够在保持一定回声消除效果的前提下降低处理的延迟。低延迟版与普通版 AI 回声消除插件相互独立，你可以根据实际场景需求选择集成合适的版本。
如需开通请提供您项目appid、描述您的项目场景以及想开通的AIAEC类别 联系人工技术支持工程师协助开通

---

# ID: 33029

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.3.2

Request Type: 集成问题咨询

Request Description: 你好 想问下如果只是用Flutter Sdk最基础的视频RTC功能 不使用任何插件 那么Flutter的sdk大小大概是多少？

Reply: SDK 集成后包体积增加约 40MB左右，不同版本sdk的包体积大小上下有浮动。
可以参考[减小 App 体积](https://doc.shengwang.cn/doc/rtc/flutter/best-practice/reduce-app-size)删除不需要的库

---

# ID: 32979

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.0.0

Request Type: 效果不佳、不达预期

Request Description: 个别手机（目前手头是红米 note9），进入频道时就是开启扬声器的话，无法关闭扬声器，执行`setEnableSpeakerphone(false)`无法切换到听筒，仍然还是扬声器。
查看日志，发现`setEnableSpeakerphone to false`时，结果仍然是`event device changed!11  mAvailDevices.mDefaultRoute3`。也就是依然是扬声器路由。

Reply: 在通话之前，调用 `setDefaultAudioRoutetoSpeakerphone` 方法将默认音频路由切换为听筒或扬声器。该方法的 defaultToSpeaker 参数传入 true 代表设置默认音频路由为扬声器；传入 false 代表设置默认音频路由为听筒。该方法的设置在调用 destroy 销毁引擎前都有效。
参考[设置音频路由](https://doc.shengwang.cn/doc/rtc/android/advanced-features/audio-route)

---

# ID: 32984

SDK Product: Fastboard

SDK Platform: Web

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 白板上传的PPT，主播侧可以翻页，但是观众侧（录制）看到的PPT没有翻页；不能稳定复现，目前出现了两例不同的用户

Reply: 可以提供您的ppt源文件我们进一步排查看看

---

# ID: 32988

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.2

Request Type: 其他问题

Request Description: 设备端确定有推流，但是声网上日志没有显示设备在频道里有推流，前端看不到直播画面。

Reply: 1. 检查设备端是否成功加入频道
2. 发流端是否按照文档集成：完成本地轨道的创建并且成功加入频道后，就可以调用 [AgoraRTCClient.publish](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iagorartcclient.html#publish) 将本地的音视频数据发布到当前频道，以供频道中的其他用户订阅。
3. 接收端是否按照文档集成：当发流用户成功发布音视频轨道之后，接收端会触发 [user-published](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iagorartcclient.html#event_user_published) 事件。这个事件携带两个参数：远端用户对象 (user) 和远端发布的媒体类型 (mediaType)。此时，你可以调用 [AgoraRTCClient.subscribe](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iagorartcclient.html#subscribe) 发起订阅

---
# ID: 32993

SDK Product: RTC-Linux

SDK Platform: Linux-Python

SDK Version: 2.1.0

Request Type: 集成问题咨询

Request Description: python集成Agora，通过继承IVideoFrameObserver抽象类，实现接收视频流时，token和userId有什么要求，我现在使用和直播设备相同的token和userId是否可以？还是说我需要生成一个观众的token和userId

Reply: 
1. 同一频道内 不能重复使用相同 userId 要确保同一频道内的UID的唯一性
2. token是根据appid+channelid+uid+有效时间计算而成，当其中任一发生变化，token都会随之改变

---
# ID: 32995

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.1

Request Type: 集成问题咨询

Request Description: 集成Lite的sdk后，在控制台创建了一个临时的24小时的token和频道，用了两次后发现音频的时长明显大于视频，麻烦帮忙看一下是什么原因。

Reply: 音频时长和视频时长在计费侧并非一定是等于的关系，可以参考[计费策略](https://doc.shengwang.cn/doc/rtc/android/billing/billing-strategy)文档，了解声网的计费规则

---
# ID: 32999

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.2.3

Request Type: 效果不佳、不达预期

Request Description: 用户连麦的时候偶尔会发生黑屏。用户本地黑屏 和远端都黑屏

用户偶然开播的时候会发生黑屏

Reply: 1. 确认用户是否在频道内
2. 用户连麦的时候确认角色是否已经切换为主播
3. 检查视频启用状态：确保在加入频道前已调用 `enableVideo` 方法启用视频功能；验证代码中是否意外禁用了视频（例如，通过 `muteLocalVideoStream` 或 `muteRemoteVideoStream` 方法）。禁用操作会导致黑屏。
4. 确认 `setupLocalVideo` 和 `setupRemoteVideo` 方法已正确执行并且 渲染视图未被其他UI元素覆盖或销毁
如果以上可能原因均不符合请提供提供详细信息以便深入排查：
频道号（Channel Name）和精确时间点（UTC格式）。
用户UID及SDK日志文件（包含黑屏发生时的记录）。

---
# ID: 33000

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 效果不佳、不达预期

Request Description: 就是在rtc的视频通话中，音频的采集使用的是手机的音频，调用了`setExternalAudioSink`开启外部音频采集就会出现回音的现象，如果关闭的话，回音的现象就消失了

Reply: `setExternalAudioSink` 方法启用了外部音频渲染（播放），而非采集，此时应用需自行处理音频播放逻辑

---
# ID: 33005

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.2.2

Request Type: 集成问题咨询

Request Description: 
```bash
pod 'AgoraRtcEngine_iOS', '4.2.2', :subspecs => ['RtcBasic','ReplayKit']
```
集成了这两个后，包体积会增加多少？
如果去除了ReplayKit模块，包体积会增加多少？

Reply: arm64 下的`AgoraReplayKitExtension.xcframework`集成后 App 增加的体积大约是67 KB，详细请参考[插件列表](https://doc.shengwang.cn/doc/rtc/ios/best-practice/reduce-app-size#%E6%8F%92%E4%BB%B6%E5%88%97%E8%A1%A8)中的屏幕共享插件

---

# ID: 33007

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.19.0

Request Type: 其他问题

Request Description: 在微信内置浏览器上无法获取麦克风权限

Reply: 1. 在安卓微信内置浏览器上使用要求微信 7.0.20 或以上版本。具有发布音视频流和接收音视频流权限
2. 在iOS设备微信内置浏览器上使用要求微信 8.0.13 或以上版本。只具有接收音视频流权限，不具有发送音视频流权限。
详细说明请参考[浏览器兼容性和已知问题](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility)

---
# ID: 33009

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.3.2

Request Type: 集成问题咨询

Request Description: 无法接收到RtcEngineEventHandler的回调。

Reply: 可能是注册问题，可以参考[实现音视频互动-Flutter](https://doc.shengwang.cn/doc/rtc/flutter/get-started/quick-start)集成

---
# ID: 33014

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.2

Request Type: 集成问题咨询

Request Description: 如何在 WebSDK 中实现发送和监听 stream message？

Reply: 您好，Web 的实现方式如下
```javascript
client.on("stream-message",(uid,message) = > {
    console.log(`receice ${message} from ${uid}`)
})

client.sendStreamMessage(new Uint8Array(),false)
```

---

# ID: 32754

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.0.0

Request Type: 线上报错

Request Description: 你好，我在使用先上demo“声动互娱”，在秀场直播模块中创建直播，将发送聊天的按钮显示出来，输入消息发送之后，提示  Error Domain=AUIKit Error Code=-10008 "Invalid channel name，请问下这个问题该如何解决

Reply: 您好，当前声动互娱demo已处于不维护状态，强烈建议您不要基于github上源码进行二次开发；demo 可以参考我们的API-EXAMPLE，链接如下：
[API-EXAMPLE](https://github.com/Shengwang-Community/API-Examples/tree/main/iOS/APIExample)

---

# ID: 32767

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.0.0

Request Type: 其他问题

Request Description: 账号冻结了，没欠费

Reply: 您好，麻烦您这边提供下项目的appid，人工工程师看到后会及时检查您的账号状态，给您答复；
或者您也可以直接通过电话或邮件的方式联系声网商务进行咨询，联系方式：400 6326626 或 声网 console 左侧边栏-设置-工作空间设置里拨打销售负责人的手机号

---

# ID: 32778

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 需要开通跨频道流媒体转发功能

Reply: 您好，请提供项目的appid, 人工工程师会在1个工作日内给您开通跨频道流媒体转发功能，请您耐心等候。

---
# ID: 32951

SDK Product: Console

SDK Platform: All

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 灵动会议是否支持小程序或者H5?有没有demo可以参考？

Reply: 参考[灵动会议-平台支持](https://doc.shengwang.cn/doc/meeting/android/overview/platform-support#%E5%B9%B3%E5%8F%B0%E5%88%97%E8%A1%A8)

---
# ID: 32953

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 崩溃（闪退、卡死）

Request Description: 近期线上有个别用户(2个)反应开播卡顿，就是主播开播他自己看画面卡顿，但是观众看是OK的，请问照成这种现象的原因有哪些

Reply: 1. 如果主播有开启美颜请关闭美颜之后再观察是否卡顿，开启美颜的情况有些主播设备性能会达到瓶颈导致卡顿
2. 使用其他视频软件观察是否有同样问题，排查设备本身引入的采集问题
3. 如果以上情况均没有，请提供频道名、UID、问题时间点以及sdklog方便我们进一步定位

---
# ID: 32954

SDK Product: RTC-Linux

SDK Platform: Linux-Java

SDK Version: 4.0.1

Request Type: 集成问题咨询

Request Description: 您好我再你们文档上找到了相关服务端部署的代码，我想咨询下使用在线依赖的方式你们的库地址是多少，我在你们服务端值找到了下载jar包，我们后台是Java 

Reply: 参考[通过 Maven 集成 SDK](https://doc.shengwang.cn/doc/rtc-server-sdk/java/resources)

---

# ID: 32965

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 云端合流录制对于微软云有什么限制要求？ 之前针对腾讯云要求是存储桶需要在上海，不能在南京等地

Reply: 我们本身不对存储提出要求，参考[第三方云存储地区说明](https://doc.shengwang.cn/doc/cloud-recording/restful/api/reference)
如果跨区需要参考：[跨区请求加速](https://doc.shengwang.cn/doc/cloud-recording/restful/best-practices/rest-availability#%E8%B7%A8%E5%8C%BA%E8%AF%B7%E6%B1%82%E5%8A%A0%E9%80%9F)

---
# ID: 32966

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.2

Request Type: 集成问题咨询

Request Description: 场景描述：我的视频流通过声网下发，想获取到原视频，web端如何实现视频的自渲染 
Reply: 想要获取视频的话可以通过[getMediaStreamTrack](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/ilocaltrack#getMediaStreamTrack)获取浏览器原生的 MediaStreamTrack对象。
可以通过[getCurrentFrameData](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/icameravideotrack#getCurrentFrameData)获取当前渲染的视频帧数据

---

# ID: 32968

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.2.6

Request Type: 效果不佳、不达预期

Request Description: JoinChannelEx 加入频道，这个频道是单独推自定义音频视频流，PushAudioFrame 推音频流，第一次加入频道推流有概率音频流推送不出去，断开频道再次加入频道推流就没有问题

Reply: 推荐参考下 [Demo](https://github.com/AgoraIO-Extensions/Agora-Unity-Quickstart/tree/main) 的处理 仍有问题请提供SDKlog方便我们进一步调查

---
# ID: 32975

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.2

Request Type: 集成问题咨询

Request Description: 像获取到客户端用户直播的实时延迟时间 麻烦提供一下获取的方法 从文档中提供的中获取的值都是0  示例 agoraClient.getRemoteVideoStats()  中的 end2EndDelay 的值都是0

Reply: 可以监听[传输延迟transportDelay](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/remoteaudiotrackstats#transportDelay)

---
# ID: 32969

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 集成问题咨询

Request Description: uniapp混合开发，集成灵动课堂有资料吗？想使用安卓的SDK。

Reply: 参考[配置灵动课堂](https://doc.shengwang.cn/doc/flexible-classroom/android/get-started/configure) 和 [集成灵动课堂](https://doc.shengwang.cn/doc/flexible-classroom/android/get-started/integrate)

---
# ID: 32971

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.2.2

Request Type: 集成问题咨询

Request Description: 水晶球上面怎么看到消息延迟、消息到达率的数据；目前只看到登录成功率

Reply: 水晶球暂时不提供对于RTM 的质量监控，您可以在控制台看到RTM的用量信息包括：消息数、存储容量、峰值连接数、日活跃用户，暂时还不提供消息延迟、消息到达率的数据

---
# ID: 32972

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.0.0

Request Type: 效果不佳、不达预期

Request Description: 通话声音不够大

Reply: 参考文档[如何处理音量太小问题？](https://doc.shengwang.cn/faq/quality-issues/audio-low)

---

# ID: 32651

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.2.3

Request Type: 其他问题

Request Description: 我们有两个端：
1. 子女端（flutter开发，手机上安装的）和老人端（Android原生，定制的Android主板上）
2. 子女端呼叫老人端，加入频道后，老人端使用声网的SDK的`createMediaPlayer`方法创建播放器然后播放本地的rtsp流；子女端看到的画面有卡顿

Reply: 您好，需要您再提供下声网的频道号，以及卡顿时间点；
另外需要确认下老人端本地播放rtsp流是否正常，如果本地正常，子女端卡顿，则可能是子女端的网络丢包或带宽不足导致的。

---
# ID: 32652

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 1.问题表现：在作为对讲接收者时，开始发送对讲后会出现两秒无法接收对讲的情况。
2.重现步骤：进入语音频道，进入QQ音乐播放音乐，退回到主屏，对方持续讲话，我开启对讲，两秒无对方声音。
3.附件说明：里面有三个文件，视频是客户发来的他出现问题的视频，比我复现的还要严重些，除了前两秒无声音，还会有随机声音缺失的情况，另外两个 log 是我复现出两次前两秒无声音的情况

Reply: 您好，麻烦您这边提供下频道号、时间点、以及是那个uid听那个uid异常，如有完整的声网sdk日志也麻烦提供下；[LogConfig](https://doc.shengwang.cn/api-ref/rtc/android/API/class_logconfig#filePath)
人工工程师在排查后会及时给您答复。

---

# ID: 32655

SDK Product: Fastboard

SDK Platform: Web

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 调用 Fastboard SDK的`insertDocs`方法，将PPT转换成PNG格式了，全屏的时候，课件大小显示不完整，这个有具体方法可以修改吗？图一展示不完整的PPT，图二完整的

Reply: 您好，针对PPT全屏显示不完整的问题，根据资料分析建议如下：

1、检查转换参数
确保文档转换时通过RESTful API指定了正确的输出尺寸（如"type": "static"），并验证转换后的PNG图片实际分辨率是否与原始PPT比例一致。
2、调整scenes参数
在调用`insertDocs`方法时，需严格按顺序传入转换后每页图片的原始宽高数据（通过scenes参数）。若宽高值未正确匹配图片实际尺寸，会导致全屏布局异常。
3、想要在一个屏幕上全显示,需要使用这种方式转换下：
需要再引用一个`@netless/app-presentation`包,[@netless/app-presentation](https://www.npmjs.com/package/@netless/app-presentation)

---
# ID: 32660

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.1

Request Type: 集成问题咨询

Request Description: 我想咨询一下，RTC如何发送事件，我在对接openai的realtime的一个demo，但是在文档里面没有看到怎么配置用户的一些自定义事件，比如一个用户加入了，我怎么做一些其他的处理，uid可以做但是貌似要自己建一个专门的服务，我感觉好麻烦

Reply: 您好，RTC本身是无法发送事件的，您说的用户侧的自定义事件是属于信令；您可以结合我们的RTM SDK来实现，如客户端间实时传递自定义事件；参考文档：
[实现收发消息](https://doc.shengwang.cn/doc/rtm2/javascript/get-started/quick-start)

---
# ID: 32665

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.1

Request Type: 集成问题咨询

Request Description: 在我使用自定义采集视频画面的时候,我们这边的需求是,录制视频,同时发送流到声网的房间内,此时当我把麦克风声音上传上去后,我录制的视频就没有声音了,这个有什么能解决的吗

Reply: 您好，音视频通过自采集的方式成功推到频道内后，您描述的录制无声，需要确认下您这边本地是通过什么方式录制的？
录制的话声网建议您使用我们云录制来实现，参考如下：
[服务概述](https://doc.shengwang.cn/doc/cloud-recording/restful/overview/product-overview)

---

# ID: 32694

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 配置了各项，但是推流失败

Reply: 您好，需要您这边提供下控制台上的推拉流地址信息，以及推流时返回的错误码信息；

---

# ID: 32582

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.3.2

Request Type: 其他问题

Request Description: Mac电脑，共享150M的Pdf好后，10s后就听不到全体学生的声音了。比如：UID214256 、214021

Reply: 您好，针对您反馈的开启屏幕共享10s后听不到学生声音的问题，需要您提供准确的频道，老师端的UID，以及问题时间点，这边排查后会及时告知；
另外建议您这边检查下macos本身扬声器是否正常，以及该问题是否必现

---
# ID: 32585

SDK Product: RTC-Linux

SDK Platform: Linux-CPP

SDK Version: 4.2.32

Request Type: 效果不佳、不达预期

Request Description: 关于同时开两台机子推流码率异常的问题, 换了个网络环境确实没出现, 但是在原网络环境下, 飞书会议、腾讯会议等同类软件都没有出现码率问题, 我认为SDK在网络这一块应该也是有问题的

Reply: 您好，针对linux c++ 推流码率异常的问题，需要您这边提供下声网频道号，UID，时间点以及声网sdk日志等关键信息，这边分析后给你同步；
看您描述换个网络环境没关系，建议还是首先检查下网络上行是否正常；或者是通过`setVideoEncoderConfiguration`调整编码码率

---

# ID: 32592

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.1

Request Type: 集成问题咨询

Request Description: 视频中，虚拟背景插件和美颜插件可以同时使用吗？我用了文档中的方法，分别使用两个插件是可以的，先后开启美颜再开启虚拟背景，报错
`Processor VideoProcessorDestination already being piped, please call BeautyProcessor.unpipe() beforehand.`

Reply: 您好，想要同时使用虚拟背景插件和美颜插件，代码集成上不能调用两次`localTracks.videoTrack.pipe(processor).pipe(localTracks.videoTrack.processorDestination);`您需要在美颜的效果上pipe虚拟插件才行。

---

# ID: 32597

SDK Product: RTC

SDK Platform: Restful

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 如何通过SDK推流带透明背景的视频帧，目前用的SDK是Python语音，release/1.1版本。尝试alphaBuffer参数，目前不生效。
是数据格式不正确，还是说有其他参数配置使用呢
Reply: 您好，针对你使用python sdk 推流带透明背景的视频帧，
1、首先需要使用最新版本的python sdk 如下[Agora-Python-Server-SDK](https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/tree/release/2.3.4/agora_rtc/examples)
2、在集成时需要注意
`fill_alpha_buffer = 1`
`alpha_mode = 1或者4`
`alpha_buffer = bytes`
在`encodeconfigure`里面，有一个是否编码`alpha`的，这个设置为true

---

# ID: 32599

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 如何关闭日志输出，一直出现在控制台

Reply: 您好，flutter关闭sdk日志的输出可以参考如下文档：
需要再初始化的时候配置一下日志等级为 NONE
[LogConfig](https://doc.shengwang.cn/api-ref/rtc/flutter/API/class_logconfig)

---
# ID: 32601

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 模块载入有问题：
```
main.py
from agora_realtime_ai_api.rtc import RtcEngine, RtcOptions
找不到 agora_realtime_ai_api

agent.py
from agora.rtc.rtc_connection import RTCConnection, RTCConnInfo
from attr import dataclass

from agora_realtime_ai_api.rtc import Channel, ChatMessage, RtcEngine, RtcOptions
找不到 agora ， agora_realtime_ai_api
```

运行：python -m realtime_agent.main server

报错：
```
Traceback (most recent call last):
File "", line 198, in _run_module_as_main
File "", line 88, in _run_code
File "C:\Code\OpenAI\openai-realtime-python\realtime_agent\main.py", line 13, in
from .agent import InferenceConfig, RealtimeKitAgent
File "C:\Code\OpenAI\openai-realtime-python\realtime_agent\agent.py", line 8, in
from agora.rtc.rtc_connection import RTCConnection, RTCConnInfo
ModuleNotFoundError: No module named 'agora.rtc.rtc_connection'
```


Reply: 您好，websdk 是不支持再python环境中使用的，如果您想集成python 音视频sdk，可以参考如下文档实现：
[跑通示例项目](https://doc.shengwang.cn/doc/rtc-server-sdk/python/get-started/run-example)
[发送和接收媒体流](https://doc.shengwang.cn/doc/rtc-server-sdk/python/get-started/send-receive)

---

# ID: 32603

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 问一下这个我推流采用阿里云的推流和播流地址· 声网这边需要怎么配置？

目前遇到的情况就是安卓端的推流地址和播流地址就可以获取到、但是始终在阿里云这边获取到推流和播流信息、单独测试阿里云的推流和播流又是可以正常使用、也没有对鉴权做处理、

Reply: 您好，
1、声网客户端推流接口`startRtmpStreamWithTranscoding`已经不建议使用，后续产品规划中会下架此接口；建议您使用服务端`rtmpconverter`方式实现推流到cdn，参考文档：
[服务概述](https://doc.shengwang.cn/doc/media-push/restful/overview/product-overview)
2、需要保证推拉流域名可用，并且推流地址不能重复使用，否则会报错

---
# ID: 32607

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.2

Request Type: 集成问题咨询

Request Description: Android 8.1手机呼叫手表接通后没反应

Reply: 您好，需要确认下没反应指的是什么现象，比如手表端看不到/听不到手机端的音视频；另外需要您这边提供下声网的频道号，手表和手机端的UID，以及手表端的声网sdk日志；
人工工程师在排查完后会及时给您答复

---

# ID: 32617

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 线上报错

Request Description: acquire 接口请求成功，请求开始录制接口报错：
```json
{
	"code": 2,
	"reason": "services not selected!"
}
```

请求体我对照好几遍了，实在找不到哪里出问题了

Reply: 您好，大概率是您这边把acquire 里面的body 传入到 start 里发出去了，会报这个错，建议抓原始的 start 请求看一下请求内容是什么。


---
# ID: 32618

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 在建立1-1面试通话时：
- 面试官一端始终看到学生端的视频画面是黑屏。
- 双方可以听到声音。
- 学生端可以看到面试官一端的画面。

这个学生的电脑可以100%重现这个问题。怀疑与摄像头的某些设置有关系，但无法从log中看到找到线索。
该学生摄像头工作正常，使用Google Meeting, Skype, Zoom均无问题。

烦请帮忙看看在Agora内部是否有log可以查到线索。

Reply: 您好，针对黑屏的问题，需要您这边提供频道名称、面试官及学生端的uid，以及问题时间点；
针对web端，需要您这边调用`AgoraRTC.enableLogUpload(); // 开启自动日志上传` ，便于我们进行分析。

---
# ID: 32619

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 目前我在声网管理页面中的水晶球里面通话详情里面可以看到发送端的有音频和视频流信息、但是粉丝进入方式以后就没有视频和音频流信息· 在管理页面的的水晶球页面里面也看不到接收端端流·信息· 这个需要怎么排查？

Reply: 您好，需要您这边提供下房间号、问题时间点、发送端与接收端 UID，这边人工工程师在排查后会及时给您回复。

---
# ID: 32625

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 咱们web端SDK4.15.1版本可以在钉钉环境进行音频通话吗？或者有没有新版本可以在钉钉中进行音频通话

Reply: 您好，websdk在4.21.0版本开始增加了对部分阿里系 App（如支付宝、钉钉等）的兼容，你可以直接在这些 App 中收发音视频流。

---

# ID: 32628

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.1

Request Type: 效果不佳、不达预期

Request Description:  观看直播的页面黑屏了3~4分钟
观看直播画面黑屏时间点13:59~14:01
主播端画面不卡，观看端页面卡，观看端web端观看是链接的WiFi以及手机端观看，链接的数据，都是画面黑屏

Reply: 您好，麻烦您提供完整的问题信息如下：
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
(1) uid=123 听不到/看不到 uid=456，大约持续20分钟
(2) uid=123 听/看 uid=456卡顿
4.声网的sdk日志；

另外也建议您优先检查下问题用户的网络是否正常。

---

# ID: 32632

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 发现AgoraRtcEngine_iOS 的二进制库都进行了代码混淆，不是正规的二进制，导致代码生成 ipa的时候不能进行再次混淆，提交审核 app 时，被苹果4.3问题拒绝。

Reply: 您好，苹果审核4.3问题更多的是应用重复性，如代码重复、模块化设计等；建议您参考下面的文档尝试解决：
[苹果审核4.3问题](https://www.cnblogs.com/gddg/p/18140383)

---

# ID: 32642

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.1

Request Type: 集成问题咨询

Request Description: 你好，我想问下在语音房里面，我能不能实现主播a与主播b在通话，其他观众只能听到主播a的音频，如果可以那要怎么实现呢

Reply: 您好，
方案1：
观众端可以先通过调用`muteAllRemoteAudioStreams` 不订阅远端所有主播的音频，再调用`muteRemoteAudioStream`接口 将某个主播的音频流设置为`false`，订阅该主播的音频；
参考文档[发布和订阅](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_publishnsubscribe#muteAllRemoteAudioStreams)

方案2：
在观众端调用`muteRemoteAudioStream(uid, true)` 屏蔽主播B的音频流（需传入主播B的UID）。
调用 `muteRemoteAudioStream(uid, false)` 单独订阅主播A的音频流（需传入主播A的UID）。
关键代码示例：
```java
// 观众端加入频道后执行
mRtcEngine.muteRemoteAudioStream(hostB_uid, true); // 屏蔽主播B
mRtcEngine.muteRemoteAudioStream(hostA_uid, false); // 订阅主播A
```

---
# ID: 38122

SDK Product: RTC

SDK Platform: Electron

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我使用的是esp32-s3 芯片使用的平台是esp-idf v5.5.1需要添加rtc实时语音对话功能 目前下载Electron-SDK-main后应该怎么集成到我自己的项目

Reply: 您好， ESP 32 idf5.0 以上用这个[下载地址](https://i46hiqvame.feishu.cn/docx/Iy7AdDN8no3nscxxwSsc0elpnLh?from=from_copylink)

---
# ID: 38131

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 你好，我们在ios中使用贵公司`AgoraRtcEngine_iOS 4.1.0`版本无法通过pod集成，测试相邻版本4.2.0以及4.0.1均能正常pod，通过路径访问也提示相关错误，希望处理感谢

Reply: 您好，4.1.0 版本的 IOS SDK 目前停止 cocoapods 下载了，建议直接用官网最新版本
老版本还会有 bitcode 问题影响上架，升级最新版可以避免其他的已知问题。

---
# ID: 38132

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 加入rtc房间后如何获取房间内其他用户的推流状态

Reply: 您好，Android 端推荐监听[onRemoteVideoStateChanged](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_video_basic#onRemoteVideoStateChanged)和[onremoteaudiostatechanged](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#callback_irtcengineeventhandler_onremoteaudiostatechanged)

---
# ID: 38134

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.2

Request Type: 集成问题咨询

Request Description: 鸿蒙端无法看到远端的视频，但可以看到自己端的视频；对方也可以看到二端。

监听到远端视频流正常，订阅正常，但在回调`onRemoteVideoStateChanged` 中 `state=STARTING` 之后无法转到`DECODING`，必现。
远端的音频正常。

远端android sdk 是4.6.0  ，鸿蒙是4.4.2 。

Reply: 您好，可以先用[Demo](https://doc.shengwang.cn/doc/rtc/harmonyos/get-started/run-demo) 在真机上验证下互通是否有问题，如果能稳定复现，麻烦提供对应设备的日志，鸿蒙路径：`hdc file recv /data/app/el2/100/base/packagename/haps/entryname/files`

---
# ID: 38135

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 我们实现IM音视频通话功能,使用声网自动管理音频跨APP和APP内的音频抢占总是有些问题，如iOS18以上QQ音乐播放时音视频通话会混合播放。所以我们通过AgoraAudioSessionOperationRestrictionAll改成了自己手动管理AudioSession，也存在一些问题，比如：
1、setCategory不设置mode参数无法同时播放系统震动声音（收到新消息）；
2、setCategory设置mode参数设置为AVAudioSessionModeVideoChat会导致听筒模式和外放失效；
3、setCategory设置mode参数设置为AVAudioSessionModeVoiceChat目前看功能正常，但是似乎对通话音质有影响；

所以我们想咨询如下问题：
1、使用AgoraAudioSessionOperationRestrictionAll手动管理audioSession的方式是否合理？
2、音频通话和视频通话应该如何正确设置audioSession？
3、IM音视频通话场景的最佳实践是什么？

Reply: 您好，如果您的需求是 第三方音乐播放时，进入音视频通话自动打断第三方音乐，音视频通话结束后可以还原第三方音乐播放的话，AVAudioSession `setActive:true` 就会打断，退出时 `setActive:false` 就可以了

---
# ID: 38136

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.2.0

Request Type: 集成问题咨询

Request Description: 多频道处理， joinChannelEx 加入频道无响应

Reply: 您好，可以检查下 onerror 回调，大概率是加频道失败抛出报错了
以及对比我们的 [flutter 加入多频道Demo](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/tree/main/example/lib/examples/advanced/join_multiple_channel) 看下

---
# ID: 38137

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.6.0

Request Type: 商务问题

Request Description: 现在想用声网的服务，之前已经完成企业认证，但是之前注册的手机号已经注销，目前无法登录。看如何处理一下，可以提供企业的相关资料。

Reply: 您好，如果您的旧手机号已经注销了，可以直接用新手机号再注册一个新号。如果您的旧号有存款或者其他服务额度留存，请出示以前办理记录，或者手机账单，或者交费记录来证明这个手机号属于您。

---
# ID: 38138

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 请问灵动课堂，有没有服务端的示例代码？麻烦提供一下，谢谢。
现在我看到的都是前端的示例（安卓，IOS...）

Reply: 灵动课堂是 APAAS 服务，没有服务端代码，都是把文档中的开源项目部署到自己的服务器上去运行就可以了

---
# ID: 38143

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 对话式 AI 如何接入 ios 项目 需要集成 sdk 吗

Reply: 您好，[对话式 AI](https://doc.shengwang.cn/doc/convoai/restful/landing-page)是 Restful 产品，调用 Restful 接口后就会在指定 RTC 频道内加入能够对话的智能体，IOS 端集成 RTC SDK 加入对饮的 RTC 频道就可以互通了。

---
# ID: 38146

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 其他问题

Request Description: 旁路推流，webhook 的设置界面里面又是空的，上次问过一次了。如何能看到设置界面 ？

Reply: 您好，Webhook 事件在声网 console 对应产品能力的页面里配置，具体参考[验证签名](https://doc.shengwang.cn/doc/media-push/restful/webhook/enable-ncs#%E9%AA%8C%E8%AF%81%E7%AD%BE%E5%90%8D)。

---
# ID: 38153

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: 语音审核  数美，返回错误  
```
行 19556: [HTTP] response code=400
行 19560: [HTTP] response body={"message":"appid is invalid"}
行 19561: [AGORA][acquire] response={"message":"appid is invalid"}
```
RESTful Api 这边生成新的ID和密钥一样不行

Reply: 您好，数美云市场插件后续会下架，不建议新集成使用了，请直接对接数美侧来实现
以及声网 appid 和 restful ak sk 是两套东西，appid 在声网 console 复制，请确保输入了正确的 appid，而不是 ak 或 sk

---
# ID: 38155

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 预览画面显示拉伸变形，之前3.7.0.2版本使用“che.video.camera_capture_rotation": 1”设置参数可以生效， 最近新升级到4.5.2，该参数不能用了，请问有新的参数可以用吗？

Reply: 您好，画面拉伸变形是渲染的方式和画布不匹配导致的，和私参没有关系
3.x 和 4.x 的处理有区别，请参考我们 [4.x demo](https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo) 里的 view 处理方式，不要继续用3.x 的`create`的`view`
检查下`setuplocalvideo`里面的传参，重新写一下；参数顺序是有变化的。

---
# ID: 38156

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 效果不佳、不达预期

Request Description: 最近换了一批新机器，然后就出现直播的头像流发黄发绿， 但是调用系统自带相机软件拍照是没有问题的

Reply: 您好，请问这些机器都是什么机型？手机还是开发板？非 Android 手机通常可以通过私参切换 camera 枚举来解决，具体私有参数需要人工工程师提供。
发黄发绿的效果麻烦截图看下

---
# ID: 38157

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 声网引入js版本AgoraRTC_N-4.18.3.js
虚拟背景插件：agora-extension-virtual-background.js
目前场景教师和学生视频，加入房间时client.setClientRole参数为host
管理员旁听加入房间时client.setClientRole参数为audience
管理员看到的虚拟背景图片和教师看到的不一样，管理员是反的，镜像的
代码：
```javascript
const virtual_extension = new VirtualBackgroundExtension();
const virtual_processor = virtual_extension.createProcessor();
virtual_processor.init();
virtual_processor.setOptions({type: 'img', source: imgElement,fit:'fill'});
await virtual_processor.enable();
```

Reply: 您好，请问是只有背景镜像了吗？人是镜像的吗？麻烦提供下两侧视角看到的画面截图

---
# ID: 38158

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 4.6.1安卓版sdk，在IOT设备上使用，wifi下通话没问题，用定制4G卡的话自己加入频道、对方加入频道都能收到消息，但通话没声音，怀疑通话没通，请问实时通话走什么协议？这个需要4G运营商那边如何配置？

Reply: 您好，定制 4G 或者 5G 流量卡都是需要报备域名才能正常互通的，4.6.0 及以上版本的 SDK 请确保 国内版本报备：`*.rtnsvc.com`，`*.realtimemesh.com`，海外版本报备 `*.rtesvc.com`, `*.sdrtnsvc.com`，以及初始化 SDK 的时候打开了`domainLimit `开关

---
# ID: 38163

SDK Product: RTM

SDK Platform: Flutter

SDK Version: 2.2.2

Request Type: 集成问题咨询

Request Description: 升级Flutter RTM SDK到2.2.6之后，遇到了下面的问题
```
Because no versions of device_info_plus match >12.2.0 <13.0.0 and device_info_plus 12.2.0 depends on ffi ^2.1.4, device_info_plus ^12.2.0 requires ffi ^2.1.4.
And because agora_rtm >=2.2.6 depends on ffi ^1.2.1, device_info_plus ^12.2.0 is incompatible with agora_rtm >=2.2.6.
So, because flutter_tabicall depends on both agora_rtm ^2.2.6 and device_info_plus ^12.2.0, version solving failed.
```


Reply: 您好，可以用这种方式 选择一个通用的 ffi 版本来解决
```yaml
dependency_overrides:
	ffi: ^2.1.4
```


---
# ID: 38164

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: mac默认不支持声卡，electron-sdk能自动安装AgoraALD 虚拟声卡吗，只能用户手动安装吗

Reply: 您好，可以把签名后的 agoraALD driver 放在项目目录 在运行时 sdk 会把项目中 dirver copy 到系统驱动目录，这样就自动安装了，参考飞书文档[如何自动安装AgoraALD 虚拟声卡](https://i46hiqvame.feishu.cn/wiki/KbBuwwtXziWk33kOCjFcvHULnve?from=from_copylink)

---
# ID: 38165

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 现在要设置推流画面镜像，设置后回调的图像数据有点问题。
使用`registerVideoFrameObserver`注册的回调方法在`getMirrorApplied`得到的本地采集回调可以变成镜向，但远端拉流的图像数据也变成镜向了要怎么解决？
需求是本地的回调图像数据是镜向，远端拉流的回调图像数据发送来的样子而不是镜向。
现在本地回调接口用的是`onCaptureVideoFrame` 远端回调接口用的是`onRenderVideoFrame`

Reply: 您好，`getMirrorApplied`的效果是全局的，会让`onCaptureVideoFrame`和`onRenderVideoFrame `都被镜像处理，无法单独设置。如果您有本地镜像远端正常的需求，可以在 `setupLocalVideo`的时候配置镜像渲染，这样本地看到的就是镜像画面了。
如果您是自渲染的话，直接在自渲染的时候镜像处理本地预览的画面就行。

---
# ID: 38166

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 云端录制设置了`unSubscribeAudioUids`和`unsubscribeVideoUids` 屏蔽了教师的视频流 但是录制的视频里面还是有 
设置参数如下
```json
'unsubscribeAudioUids': ['1000408'], 
'unsubscribeVideoUids': ['1000408']
```

Reply: 您好，应该是`unSubscribeAudioUids`和`unSubscribeVideoUids`，您写的是`unsubscribeAudioUids` 和`unsubscribeVideoUids`，大小写不一致导致变成了无效字段

---
# ID: 38168

SDK Product: Whiteboard

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 获取到的Token会被双引号包裹。
请问是我哪里参数传错了吗？
如下图示例：
分别是Curl命令行请求和程序请求，都会被双引号包裹。

Reply: 您好，白板 token 建议直接 clone 我们的[白板 token 生成脚本](https://doc.shengwang.cn/doc/whiteboard/javascript/fastboard-sdk/basic-features/generate-token#%E5%9C%A8-app-%E6%9C%8D%E5%8A%A1%E7%AB%AF%E7%94%9F%E6%88%90-token)在本地生产，这样处理更方便。

---

# ID: 32537

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 我这个视频录制时长是2小时多。按你们最长一段录制时长为2小时。那不是应该给我2段的录制信息么？为什么只有一段？

Reply: 您好，针对灵动课堂页面录制时长超过2小时后，录制仅生成单文件的问题；
需要您这边提供下项目的appid，人工工程师会联系后端研发做配置，配置后您的录制回调就能收到两端录制信息。

---
# ID: 32538

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.19.0

Request Type: 集成问题咨询

Request Description:       生成的token 方法如下  
```javascript
String webToken = token.buildTokenWithUid(appId, appCertificate, channelName, webUid, RtcTokenBuilder2.Role.ROLE_SUBSCRIBER, tokenExpirationInSeconds, privilegeExpirationInSeconds);
```

报错如下:
```
asyncToGenerator.js:7 Uncaught (in promise) AgoraRTCException: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: invalid token, authorized failed
```


Reply: 1、检查 UID 一致性
确保生成 Token 时传入的 webUid 与加入频道时使用的 UID 完全匹配（包括类型和值）。Web 平台 UID 建议使用int uid，如需使用string，参考文档[如何使用 String 型用户 ID？](https://docportal.shengwang.cn/cn/video-legacy/faq/string)

2、验证频道名匹配
确认 channelName 在生成 Token 和加入频道时完全一致（包括大小写、空格等特殊字符）。

3、立即验证工具
使用声网控制台的 [Token 校验工具](https://console.shengwang.cn/tools/token)实时验证生成的 Token 有效性：

---

# ID: 32545

SDK Product: RTC

SDK Platform: MacOS

SDK Version: 4.4.1

Request Type: 线上报错

Request Description: 在英国的某个酒店内使用酒店的网络联不通，或者联通之后没有声音。

这样的情况应该怎么解决啊？但是用英国的手机卡开热点是正常使用的。。。

Reply: 您好，需要您这边提供下具体频道号、用户 UID 及问题发生时间点，如果有声网的sdk日志更佳；
同时建议您检查下酒店网络是否正常，比如使用测速软件测速等。

---
# ID: 32547

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 我们开发的耳机，希望可以在播放声网对讲的时候，依然可以控制第三方音乐播放，经过测试看起来需要使用 AVAudioSession 的 ambient 而不是 playAndRecord 才能实现控制的是第三方音乐而不是声网，但是这个 ambient 有个问题就是第三方播放音乐回到我们 App 前台后，再锁屏，就没有声网的声音了，不知道回到前台的时候声网这边有没有什么处理，引发系统进入锁屏时就没有声网输出了。然后我还尝试过回到前台时使用 playAndRecord，退出后台再切为 ambient，遇到的问题是，切为 playAndRecord 的时候音乐就停止了，并且也不能保持耳机控制的是第三方音乐了，这个问题困扰我几天了，望回复，谢谢

Reply: 您好，声网sdk在和第三方播放器搭配使用时，建议如下：
1、当RTC频道内音频和第三方播放器同时播放的时候，RTC内部会按需把AVAudioSession置为deactive，会造成第三方播放卡断一下或者直接无声，可以通过私参解决，请您咨询人工工程师获取。
2、RTC频道内无论是通话音量还是媒体音量category都是PlayAndRecord，如果这个参数被外部修改，内部ADM会强制重启重置，频道内声音会卡断。PlayAndRecord兼容Playback，建议是无论是频道内还是频道外，第三方播放器音应尽量保持PlayAndRecord不修改。
3、CategoryOptions的修改内部没有做限制，但是在非必要的情况下不建议外部修改。

---
# ID: 32551

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 我们之前集成的是咱比较老的版本，大约2018年左右集成的，可能是2.X的版本，现在想要升级咱4.4的版本，由于差异较大，需要改动的地方较多，希望咱这提供之前版本的相关文档，我们看下之前的实现方式和现在实现方式，好做修改

Reply: 您好，2.x，3.x的sdk都属于很老的版本了，这边发你下文档链接如下：
[3.x legacy 发版说明](https://docportal.shengwang.cn/cn/video-legacy/release_android_video?platform=Android)

建议咱们尽快安排升级到 4.x。

---
# ID: 32552

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.1

Request Type: 其他问题

Request Description: 问题描述：
设备部分机型出现自己的直播图像倒转问题，无论是主播看他，还是他看自己都是倒转的。请问有什么解决方案。

Reply: 您好，针对线上部分设备出现画面倒置的问题；
麻烦您这边提供下声网频道号以及用户UID，人工工程师会针对异常设备做下发参数配置。

---
# ID: 32555

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.1

Request Type: 其他问题

Request Description: Mac Safari浏览器，实时音视频通话，原本需要授权麦克风和摄像头，但是只弹出了麦克风的授权提醒。权限开关已经设置为“询问”，但是没有提示

Reply: 您好，建议您这边检查下Safari浏览器设置里是否禁用了摄像头；
当然您这边也可以使用webrtc的官方demo来做测试看下是否正常：
[Web SDK 浏览器检测工具](https://webrtc.github.io/samples/src/content/devices/input-output/)

---
# ID: 32557

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.1

Request Type: 集成问题咨询

Request Description: 视频通话，本地视频正常，远程视频只有声音没有图像
我是参考官方的demo，第一个生成本地视频流正常，第二个div生成远程视频流时，只有声音但没有图像，还请帮忙分析下原因

Reply: 您好，web端订阅渲染远端视频流可以参考我们的官网示例demo检查下集成逻辑；
[API-Examples-Web](https://github.com/AgoraIO/API-Examples-Web/tree/main/src/example/basic)
如自查后仍然有问题，需要您这边提供下声网频道号，本地及远端的uid，websdk调用`enableLogUpload`打开日志上传，以便我们进一步分析；建议是优先检查下远端用户的video标签是否设置正确

---
# ID: 32560

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 2.5.4

Request Type: 集成问题咨询

Request Description: 使用join方法时这个uid是什么参数，在哪里获取的

Reply: 您好，miniapp小程序 sdk 的uid参数说明如下：
INT: 整数作为用户 ID，需为 32 位无符号整数。建议设置范围：0 到 (232-1)。需要保证唯一。如果不指定 uid（即设为 null），服务器会报错。
STRING: 字符串，长度不超过 255 个字符
推荐您这边自定义指定一个 Number 型 uid（需确保频道内唯一性），便于区分线上客户端。

---
# ID: 32562

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.1.1

Request Type: 集成问题咨询

Request Description: 锁屏之后会黑屏

Reply: 您好，针对您描述的安卓端锁屏后会黑屏的问题，需要您这边做下前台服务
[为什么部分 Android 版本应用锁屏或切后台后采集音视频无效](https://doc-internal.shengwang.cn/doc-new/androidbackground/faq/quality-issues/android-background)

---
# ID: 32568

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 实现 1v1 私密房 服务端api在哪里

Reply: 您好，声网未提供专属的 1v1 私密房服务端 API，需要您这边使用pass方案接入，参考文档如下：
[实现音视频互动](https://doc.shengwang.cn/doc/rtc/android/get-started/quick-start)
[跑通 API 示例项目](https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo)
CallApi 已经处于不维护状态，强烈不推荐使用场景化API方案。

---
# ID: 32569

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 线上报错

Request Description: 我们app里面使用的iOS系统的录屏功能，使用agorasdk3.5.2.1版本推流，当录屏的时候，在抖音播一个视频，设备的外放声音会被压的很低，调节系统音量也没效果。（另外，我们尝试了agorasdk4.3.x版本，发现没有这个问题，但是我们短期没有升级计划）

Reply: 您好，3.x SDK版本已经处于不维护状态，建议您这边安排升级到4.x版本SDK；
另外可以尝试调用`setAudioProfile`将scenario设置为 `AgoraAudioScenarioGameStreaming`，走媒体音量。

---
# ID: 32570

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: Android项目集成 声网SDK，能否使用kotlin进行开发？目前没有找到kotlin开发文档

Reply: 您好，安卓原生SDK 并不支持 Kotlin 开发，只能使用java。

---
# ID: 32571

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.1

Request Type: 集成问题咨询

Request Description: 调用 buildTokenWithUid() 方法生成的token最大有效期是24小时吗？？如何设置有效期超过24小时的token？

Reply: Token 最大有效期：

调用 buildTokenWithUid() 生成的 Token 最大有效期为 24 小时（86,400 秒），超过此时长将无法生成有效 Token。
设置超过 24 小时有效期的方法：

无法直接设置超过 24 小时：声网系统强制限制 Token 有效期上限为 24 小时，任何尝试设置 tokenExpire > 86400 的行为均无效。
替代方案：
动态更新 Token：在 Token 过期前（例如 23 小时），通过服务端重新生成新 Token 并调用客户端 `renewToken()` 方法更新。

---

# ID: 32214

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 远程端控制本地端的视频停止，并且保留最后一帧停止前的画面，该画面能被远程设备所接收。我是使用`rtcEngine.muteLocalVideoStream(true)`远程设备就收不到视频流画面。有什么比较好的方式实现效果。

Reply: SDK 没有提供控制远端是否发流的接口，`muteLocalVideoStream`只是针对本地的发流，true 就是停止发流，false 就是恢复。

如果你有控制远端发流的需求，可以考虑集成第三方信令 SDK，让远端收到信令后自己执行mute操作；或者考虑使用 restful 接口指定 uid 失去短时间发流的权限；

另外，远端设备默认显示最后一帧画面，需避免在回调中清除视图

---
# ID: 32215

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 集成问题咨询

Request Description: 想请教一下，灵动课堂的插件，能否做到不实现轨迹同步。
好比自带有一个答题器的插件，老师拖拽改变窗口位置，学生端也会改变窗口的位置从而影响作答。
但是插件的同步模式只提供了“仅同步位置”和“同步位置和大小”两个选项，想知道有没有办法实现“不同步位置和大小”

Reply: 插件的位置和大小一般都是同步，如果想不同步，可以看一下下发的事件变更，在`gettrackController`里，收到事件同步不处理就可以了。或者不用插件，自己添加组件

---
# ID: 32218

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 如何做到停止本地设备的采集，显示最后的画面，然后远程设备也能收到我保留的最后的画面

Reply: SDK 本身自带就是远端停止发流后卡最后一帧，可以用我们的 Demo 去测试下看看

---

# ID: 32223

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.0

Request Type: 线上报错

Request Description: `AgoraRTC_N.js:6 Uncaught (in promise) AgoraRTCException: AgoraRTCError REMOTE_USER_IS_NOT_PUBLISHED`,
翻看了代码 订阅在 user-published事件中订阅的，双方都发布了视频和音频的媒体类型，还是报这错，但是视频能正常接通，不知道有啥影响

Reply: 您好，
1、检查有没有多个 client，避免订阅错 client 
2、vue在data中用对象不能接收，检查下自己的项目里有没有双向绑定的行为，如果有，请避免。 之前其他客户遇到过，当时是发现`const client = AgoraRTC.createClient({ mode: "live", codec: "vp8" });`这行代码的client放在js中就没问题，如果把client赋值给对象内的属性，使用属性就会出现问题
 

---
# ID: 32224

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 我需要关闭iOS端的回声消除怎么做，目的是为了用户使用qq音乐扬声器播放声音的时候，将音乐录进去

Reply: `setAudioScenario` 设置为`gamestreaming`模式即可

---
# ID: 32225

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.3.2

Request Type: 集成问题咨询

Request Description: 我在使用php做后端调用接口`https://api.sd-rtn.com/dev/v1/kicking-rule`，踢除用户的时候，接口返回这样的错误：`Invalid authentication credentials`

Reply: 这个一般是restful api的鉴权出现问题，后台请求中，header中的Authorization并不是前端使用的token。请参考文档处理[实现 HTTP 基本认证](https://doc.shengwang.cn/doc/rtc/restful/user-guides/http-basic-auth)

---
# ID: 32226

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.3.2

Request Type: 集成问题咨询

Request Description: 我使用flutter开发的会议app，控制台和logcat经常就报
这个错误
```
Handler (android.os.Handler) {1f0c76e} sending message to a Handler on a dead thread
W/MessageQueue( 4299): java.lang.IllegalStateException: Handler (android.os.Handler) {1f0c76e} sending message to a Handler on a dead thread
W/MessageQueue( 4299): 	at android.os.MessageQueue.enqueueMessage(MessageQueue.java:560)
W/MessageQueue( 4299): 	at android.os.Handler.enqueueMessage(Handler.java:786)
W/MessageQueue( 4299): 	at android.os.Handler.sendMessageAtTime(Handler.java:735)
W/MessageQueue( 4299): 	at android.os.Handler.sendMessageDelayed(Handler.java:705)
W/MessageQueue( 4299): 	at android.os.Handler.post(Handler.java:435)
W/MessageQueue( 4299): 	at android.hardware.camera2.impl.CameraDeviceImpl$CameraHandlerExecutor.execute(CameraDeviceImpl.java:2402)
W/MessageQueue( 4299): 	at android.hardware.camera2.impl.CallbackProxies$SessionStateCallbackProxy.onClosed(CallbackProxies.java:104)
W/MessageQueue( 4299): 	at android.hardware.camera2.impl.CameraCaptureSessionImpl.close(CameraCaptureSessionImpl.java:588)
W/MessageQueue( 4299): 	at android.hardware.camera2.impl.CameraCaptureSessionImpl.finalize(CameraCaptureSessionImpl.java:894)
W/MessageQueue( 4299): 	at java.lang.Daemons$FinalizerDaemon.doFinalize(Daemons.java:339)
W/MessageQueue( 4299): 	at java.lang.Daemons$FinalizerDaemon.processReference(Daemons.java:324)
W/MessageQueue( 4299): 	at java.lang.Daemons$FinalizerDaemon.runInternal(Daemons.java:300)
W/MessageQueue( 4299): 	at java.lang.Daemons$Daemon.run(Daemons.java:145)
```

Reply: 看报错是你在朝一个已经死亡的线程发送消息，可以参考下我们 Demo 的处理方式，我们的 Demo 没有这种问题[fultter demo](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/tree/main)

---
# ID: 32227

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 升级套餐后，无法接听视频，IOS和安卓都打不了

Reply: 你好，升级套餐不会影响音视频通信，麻烦提供下出现问题的设备日志或者频道号、uid、时间点，说明谁听不见谁

以及呼叫邀请不属于 RTC 能力，这个属于信令 是第三方 SDK 实现的，如果问题是呼叫邀请相关的，需要你自查

---

# ID: 32230

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.0

Request Type: 线上报错

Request Description: `AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: invalid vendor key, can not find appid`
加入通道时报以上错误。

Reply: 请检查appid拼写是否准确，另外可以提供join方法全部传参给我们协助调查

---
# ID: 32231

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: flat 这么和阿里云oss配合起来，我一直没有办法录制

Reply: flat是社区产品，未产品化。请在github上提交一个issue处理

---
# ID: 32233

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.0

Request Type: 其他问题

Request Description: web端集成了rtc和rtm，rtm的版本为1.2.2，rtc之前的版本：3.0.1，因web端rtc拉流的时候报错：“This browser does not support webRTC”，因此计划升级web端的rtc，但是在集成过程中，发现js报错，拉流失败，报错信息见截图。

Reply: This browser does not support webRTC 是表示浏览器不支持 webrtc 协议，是浏览器的问题，和 SDK 没有关系。
需要使用支持webrtc的浏览器去通话，[webrtc 浏览器兼容列表](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility)

---
# ID: 32234

SDK Product: Fastboard

SDK Platform: Web

SDK Version: 0.3.10

Request Type: 集成问题咨询

Request Description: 功能配置--存储路径不知道怎么填

Reply: 您好，可以参考文档[开启和配置互动白板服务](https://doc.shengwang.cn/doc/whiteboard/javascript/fastboard-sdk/get-started/enable-service#%E5%BC%80%E5%90%AF%E4%BA%92%E5%8A%A8%E7%99%BD%E6%9D%BF%E9%85%8D%E5%A5%97%E6%9C%8D%E5%8A%A1)来填写自己的 OSS 信息

---

# ID: 32238

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.0.0

Request Type: 崩溃（闪退、卡死）

Request Description: 在使用uniapp  sdk的时候出现两个问题
1. 连接无人机 无人机开启直播  本地手机也开启直播 能看到画面，但是过了一会直播就会暂停 卡死不动 重新进入这个页面  重新加入频道才会继续看到直播动，手机用的4G 5G都会出现这个问题
2. 当前在手机上看清晰度还可以  web端清晰度比较差  有什么配置能增加清晰度的吗  跟网速有关还是跟无人机设置有关  

Reply: 你好，我们的uni-app SDK 已经停止更新和维护了。如一定要使用请提供下现象视频以及描述下出现卡顿时都做了哪些操作，然后提供下频道号、uid、时间点

---
# ID: 32249

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.3.2

Request Type: 其他问题

Request Description: 应用在接收到微信语音或者别的三方应用语音进入后台后，过几分钟服务端就会收到106或者104的推送。告知观众或者主播离线。这个问题是在客户端需要如何设置一下。

Reply: 若需短暂保持连接（如后台通话），需声明后台音频模式`（Audio, AirPlay, and Picture in Picture）`，并配置 `AVAudioSession` 为 `playAndRecord`。
注意：iOS 后台网络严格受限，超过 10 秒无数据包会触发 104(reason=2)（连接超时）。
需要做后台保活，[iOS后台保活](https://doc.shengwang.cn/faq/quality-issues/ios-background)

---
# ID: 32250

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.21.0

Request Type: 效果不佳、不达预期

Request Description: 大疆无人机直播能不能实现无人观看定时关流

Reply: 你好，请问什么是无人观看定时关流？是指频道内没有其他观众收看的时候自动离开频道吗？
这部分需要你们业务侧自己实现，可以[检测人数](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/get-dev-v1-channel-user-appid-channelName)，当人数为 1时，就执行[踢人](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/post-dev-v1-kicking-rule)接口
[webhook维护用户在线状态](https://doc.shengwang.cn/doc/rtc/restful/best-practice/online-user-status)

---
# ID: 32251

SDK Product: Console

SDK Platform: All

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 秒搭集成相关问题咨询

Reply: 秒搭产品已经下架，后续请不要使用，改为paas方案集成

---

# ID: 32253

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 
```json
{
  "cname": "7239183052914557004",
  "uid": "5035801",
  "resourceId": "xxx",
  "sid": "xxx",
  "serverResponse": {
    "status": 4,
    "fileList": [
    ],
    "fileListMode": "json",
    "sliceStartTime": 0
  }
}
```
   查询录制状态， status为4就没携带录制的fileList，状态为5就能正常携带，如何查询才能确保一定能查询到录制的fileList文件呢

Reply: 正在进行中的云录制任务查不到录制的fileList文件，录制结束后才会返回

---
# ID: 32256

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.0

Request Type: 集成问题咨询

Request Description: IOS手机，微信环境，web端首次进入页面时，订阅远端音视频没有声音，需要点击屏幕才有声音，请问要如何解决？

Reply: 浏览器限制导致，已知问题。可以参考文档[处理浏览器的自动播放策略](https://doc.shengwang.cn/doc/rtc/javascript/best-practice/autoplay)

---
# ID: 32257

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.3.2

Request Type: 集成问题咨询

Request Description: 我使用 `RtcEngineEx` 引擎，在 `joinChannel` 之前调用 `muteLocalAudioStreamEx` 接口报错，错误码 -2。

Reply: `muteLocalAudioStreamEx`需要在`joinchannelex` 之后调用，只有`joinchannelex`成功后才把ex频道的connection创建出来，否则就会报-2错误，即传参有误

---
# ID: 32259

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 集成 IOS 报错
```
Analyzing dependencies
[!] Unable to find a specification for `AgoraLite_iOS  (= 4.4.0)`

You have either:
 * out-of-date source repos which you can update with `pod repo update` or with `pod install --repo-update`.
 * mistyped the name or version.
 * not added the source repo that hosts the Podspec to your Podfile.
```

Reply: 您好，请 `pod repo update` 再试一下

---
# ID: 32258

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.0.0

Request Type: 效果不佳、不达预期

Request Description: 1.为什么发送端的系统CPU基本都是在60%~90%这个区间
2.不管遥控器连接的是手机热点、WiFi、手机sim卡信号质量都是10000ms,是什么原因造成的？
3、二、接收端，只要发送端出现丢包率，接收端就会出现渲染卡顿，接收端网络没有问题，起飞与未起飞渲染卡顿对比，为什么一起飞就会出现丢包率的问题呢？
4.问题步骤看附件文档，昨天四场直播，两场起飞，两场没有飞

Reply: 请问现在在用的 SDK 版本是多少？

CPU占用高是设备本身的问题，采集编码本身就会对性能消耗有要求，如果你的机器配置低，那 CPU 占用肯定会高

丢包可能会有网络、CPU 等因素的影响导致，如果你需要看具体原因，可以提供具体的频道号、uid、时间点、现象描述过来，我看看具体情况

渲染卡顿是 CPU 的问题，原理同上，建议检查配置

---
# ID: 32267

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.19.0

Request Type: 集成问题咨询

Request Description: vue集成声网后,怎么拨打视频给app端

Reply: 拨打属于信令 SDK 的能力，RTC 只提供在同一个频道内通话的能力，呼叫邀请可以考虑用IM 或者信令 SDK 来处理

---
# ID: 32268

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.0

Request Type: 线上报错

Request Description: 视频中调用  `muteLocalAudioStream` 接口报错`client.muteLocalAudioStream is not a function`

Reply: Web 没有这个方法，Web 只有 setMuted()方法控制是否发送本地音视频轨道

---
# ID: 32269

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.2.6

Request Type: 其他问题

Request Description: web 听不到 android端的音频 只能看到视频

Reply: 可以检查下 Android 端是否有发流，另外请提供设备日志

---
# ID: 32272

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 请问海外站`https://agora.io` ，在哪里开通 融合CDN，找不到入口

Reply: 融合cdn 目前不对海外 console 开放

---
# ID: 32275

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 2.6.4

Request Type: 线上报错

Request Description: 在使用小程序RTC  和 RTSA 智能设备可视对讲的过程中    小程序客户端初始化失败：
```json
{
	"code": 432,
	"reason": "1 is not a speaker.",
	"serverResponse": {
		"action": "subscribe",
		"errCode": 9105
	},
	"wsurl": "xxx"
}
```

 RTSA设备uid 是1   ,小程序可以接收到设备推流的音视频，但rtsa接收不到小程序下推的声音
 

Reply: 只有主播身份才能发流，看下小程序用户的身份是不是设置成观众了，参考文档：
[小程序错误码](https://doc.shengwang.cn/doc/rtc/mini-program/error-code)

---
# ID: 32274

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.0.0

Request Type: 集成问题咨询

Request Description: `found in modules jetified-chat-sdk-1.1.0-runtime (io.agora.rtc:chat-sdk:1.1.0) and jetified-hyphenate-chat-3.9.5-runtime (io.hyphenate:hyphenate-chat:3.9.5)`
环信的和咱们的有点冲突，请问如何修改

Reply: `io.agora.rtc:chat-sdk:1.1.0` 就是环信sdk，chat-sdk是海外版，hyphenate是国内版，两个环信放一起肯定会冲突，去掉一个就行

---
# ID: 32276

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.2.6

Request Type: 效果不佳、不达预期

Request Description: 主播接声卡唱歌的时候出现炸麦情况

Reply: 声卡场景需要参考文档单独处理，[实现高音质](https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality#%E5%A3%B0%E5%8D%A1%E7%94%A8%E6%88%B7%E8%AE%BE%E7%BD%AE)

1. 加个开关，主播自己选择，要是用声卡了就把关闭3A的私有参数调用一遍。非声卡用户这块的设置不要动；
2. 单独出个针对声卡的包给这部分声卡主播

一般用这两种方式的比较多，现在还没什么有效检测声卡的手段

---
# ID: 32277

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 其他问题

Request Description: 您好，视频流我如果想拍照当前帧， 有没有对应的api啊，startRecording:这个函数是录制视频的吧？

Reply: 有截图接口[iOS截图接口](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_snapshot#api_irtcengine_takesnapshot)

---
# ID: 32280

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.0

Request Type: 其他问题

Request Description: 有个疑问，检测浏览器兼容性的api，`checkSystemRequirements` 返回false，但实际上可以进行视频通话，为什么呢？

Reply: 可以通话不代表这个浏览器完全支持 webrtc 所有协议，可能存在部分功能不可用的情况。具体的支持程度看浏览器本身

---

# ID: 32283

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 
unity2022 
agoraSDK4.3

参考下列文档
`https://docs.agora.io/en/broadcast-streaming/core-functionality/screen-sharing?platform=unity ``
使用iOS的ReplayKit实现ScreenSharing时，
调用`RtcEngine.StartScreenCapture(screenCaptureParameters2);`
或者
`RtcEngine.UpdateChannelMediaOptions(channelMediaOptions);`
后，所期待的broadcast开始的View或者broadcast总览没有显示
请问是我哪里设置不够吗

Reply: 可以参考下我们 Demo 的处理，以及可以看下中文文档[屏幕共享文档](https://doc.shengwang.cn/doc/rtc/unity/basic-features/screen-share)

---
# ID: 32285

SDK Product: RTC-Linux

SDK Platform: Linux-CPP

SDK Version: 4.2.31

Request Type: 集成问题咨询

Request Description: 我们优化了一波网络管理, 针对直播间无人的情况下我们不再推流, 当直播间有人进来后再放开推流, 这种情况下, 当直播间在无观众下开了几小时后, 直播间挂掉了!

这种使用场景怎么处理呢?

Reply: 房间状态结束只是为了统计通话记录做的聚合逻辑，和实际房间状态无关，一般来说频道里长时间无人就会算结束了.SDK 只会在非主动离开频道的前提下 和我们节点断开连接才会触发重连机制，重连失败是会有客户端回调的。可以参考[linux api文档](可以参考：https://doc.shengwang.cn/api-ref/rtc-server-sdk/cpp/classagora_1_1rtc_1_1_i_rtc_connection_observer#ae62590c268ad2904583dc9c62c337056)

---
# ID: 32286

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.1

Request Type: 其他问题

Request Description: 普通直播观众端已经通过appid+channelName方式已经实现，目前观众端要观看主播的共享屏幕想通过appid+channelName实现，但是目前共享屏幕画面出不来。
需解决
1. 观众端看共享屏幕画面
2. 观众端共享屏幕与视像头直播画面的区别，api是否一致
3. 详细的步骤。

Reply: 屏幕共享需要额外一个 uid 来发送视频流，所以用重复uid 去发流肯定会报错，参考我们 Demo 处理。
观众端看屏幕共享不需要额外操作什么的，对于观众来说就是正常订阅视频流而已，SDK 在接收的时候无法区分视频流是来自摄像头还是屏幕共享的。
如果你的观众看不到画面，大概率是屏幕共享的主播分享失败了，建议先跑通 Demo 的屏幕共享，然后让观众端加入频道去观看，能看到画面就证明主播端发流正常

---
# ID: 32287

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.0.0

Request Type: 集成问题咨询

Request Description: 你们的最新iOS sdk 支持 swuftui 吗

Reply: 支持，可以参考 [Swift Demo](https://github.com/AgoraIO/API-Examples/tree/main)

---
# ID: 32289

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 效果不佳、不达预期

Request Description: 场景：屏幕外的屏幕共享，会议中，想分享一些带声音的视频的时候，会出现共享屏幕卡死的问题，用户退出了频道的问题，只有视频文件的时候出现这种问题，需要重新回到App，提示了用户重新加入了频道，不清楚是什么原因导致的

Reply: 由于 iOS 系统限制，自 iOS 12.4 起，系统默认在 App 切后台时自动停止采集音视频。参考文档处理[iOS后台保活](https://doc.shengwang.cn/faq/quality-issues/ios-background)

---
# ID: 32291

SDK Product: RTC

SDK Platform: Restful

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: rtc 104 106回调事件能知道某个用户离开通话频道。 有办法能知道所有用户都离开频道吗， 用频道销毁的回调延迟太大了

Reply: 没有这样的现成回调，只能你业务上自行记录这个频道里有多少人进多少人出，来判断是不是所有人都离开了
或者你可以调用服务端接口查看频道内剩余人数[查看频道内剩余人数](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/get-dev-v1-channel-user-appid-channelName)
或者业务上调用踢人接口，手动把所有人踢出频道[踢人](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/post-dev-v1-kicking-rule)

---
# ID: 32292

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.21.0

Request Type: 效果不佳、不达预期

Request Description: 你好，在使用视频通话时，听到对方的声音会有有回声的感觉，感觉声音好像是在空间很大的地方发出来的，如果解决这种问题。

Reply: 
请问用的是我们 Demo 吗？听你的描述像是调用了`LocalAudioTrack`的 `play` 方法，把自己本地音频放出来了

可以试试我们 [Web Demo](https://github.com/AgoraIO/API-Examples-Web)

---
# ID: 32293

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.0.0

Request Type: 集成问题咨询

Request Description: 你好，我原来的项目使用腾讯云IM+语音聊天做的，现在想转为改用声网的，这一块你们能提供技术指导吗？想了解一下

Reply: 你可以对照我们的快速开始文档，看下我们实现一个音视频通话的最简单流程都有哪些[快速开始](https://doc.shengwang.cn/doc/rtc/android/get-started/quick-start)

---
# ID: 32295

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.0.0

Request Type: 集成问题咨询

Request Description: 我们现在想让用户在视频通话的时候，可以使用虚拟背景进行视频通话。我看文档，只有React Native有这个。我想问一下，web、安卓、服务端有这个接口吗

Reply: Web 和 Android端都有,Demo 里就可以体验：[Web Demo](https://github.com/AgoraIO/API-Examples-Web)
 [web虚拟背景](https://doc.shengwang.cn/doc/rtc/javascript/advanced-features/virtual-background)
[Native虚拟背景](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_virtualbackground#api_irtcengine_enablevirtualbackground)

---
# ID: 32297

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.19.0

Request Type: 集成问题咨询

Request Description: 目前项目中使用的是用友封装的二次插件agoraRtc ，可以正常视频通话，  但是这个插件没有封装虚拟背景的功能  能否同时使用这个插件 和声网原生虚拟背景功能

Reply: 用友不是我们官方的封装版本，我们无法保证最终的表现能否符合预期。
如果你直接用我们的 SDK 去集成，是可以直接加插件看到效果的，推荐避免使用二次开发的插件

---
# ID: 32299

SDK Product: RTC

SDK Platform: Unreal

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 加入频道后，收到频道返回结果，但是说话的时候没有声音

Reply: 请问是指远端听不见自己说话吗？可以拿一下设备日志，看看有什么报错

以及确认下自己身份是不是主播，观众无法发流

 最后，可以试试我们 Demo 能否复现这个问题[unreal demo](https://doc.shengwang.cn/doc/rtc/unreal-cpp/get-started/run-demo)

---
# ID: 32303

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.0

Request Type: 集成问题咨询

Request Description: 目前尝试在使用了用友的二次插件后，想单独使用声网官网的虚拟背景功能   将官网展示的封装到js中  在vue中直接引入js报错
报错  `TypeError: The superclass is not a constructor.`
下边这个表示初始化成功了吗
```
cAgora-SDK [INFO]: color: #1E88E5; font-weight: bold; browser compatibility {"getDisplayMedia":false,"getStreamFromExtension":false,"supportUnifiedPlan":true,"supportMinBitrate":false,"supportSetRtpSenderParameters":true,"supportDualStream":true,"webAudioMediaStreamDest":true,"supportReplaceTrack":true,"supportWebGL":true,"webAudioWithAEC":true,"supportRequestFrame":true,"supportShareAudio":false,"supportDualStreamEncoding":false,"supportDataChannel":false,"supportPCSetConfiguration":true,"supportWebRTCEncodedTransform":false,"supportWebRTCInsertableStream":false,"supportRequestVideoFrameCallback":true,"supportWebCrypto":true} {"name":"WebKit","version":"605","os":"iOS","osVersion":"15.5","browserVersion":"605.1.15","deviceType":"mobile"}
```

Reply: 我们有一个 vue 的现成 Demo，你可以对比参考下或者直接用我们的 Demo来修改,[VUE Demo](https://github.com/AgoraIO/API-Examples-Web)

---
# ID: 32304

SDK Product: Whiteboard

SDK Platform: Web

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 你好，在使用互动白板时：1、编辑者在绘制时拖拽或者缩放了白板，其他人看到的白板如何动态跟着变化；2、手机端浏览器加载白板时不能缩放，如何设置；

Reply: 白板同步需要设置一个用户为主播，其他为跟随:
[setViewMode](https://doc.shengwang.cn/api-ref/whiteboard/javascript/interfaces/room#setViewMode)

缩放的问题你看下有没有设置禁止缩放的参数为 true:
[disableCameraTransform](https://doc.shengwang.cn/api-ref/whiteboard/javascript/interfaces/room#disableCameraTransform)

---
# ID: 32307

SDK Product: RTM

SDK Platform: JavaScript

SDK Version: 2.1.2

Request Type: 集成问题咨询

Request Description: 请问一下，实时消息rtm v2和v1版本发消息是否兼容，比如web端升级到了v2版本，安卓端还是v1的1.5.1版本双方是否可以通信？反过来是否可以？

Reply: 您好，rtm的1.x和2.x版本点对点消息可以互通

---
# ID: 32308

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 效果不佳、不达预期

Request Description: SID:xxx
页面录制，没有录到页面上的图片，问题如何定位，我们自己打开这个录制页面时是有这个图片，而且图片是在录制中后期应该出现的并不是前期加载的问题

Reply: 可以确认下有没有参考最佳实践来防止加载页面元素超时[保障页面录制可靠性](https://doc.shengwang.cn/doc/cloud-recording/restful/best-practices/webpage)

---
# ID: 32309

SDK Product: Recording

SDK Platform: Linux-Java

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 使用华为P7 Pro 的自带浏览器，录制的视频有回声，怎么处理

Reply: 如果是自己外放声音大被麦克风重新拾取到又发回去，那只能用户自己处理了，这个SDK 没有什么办法避免，建议带耳机或者减小扬声器音量。外放场景本身就会导致回声问题，推荐带耳机避免

---
# ID: 32311

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 请问一下，域名是怎么处理的，如果我的域名在腾讯云上，又如何处理？

Reply: 这里说的处理，是处理什么？只要是可用域名，按照文档去 console 上配置就行了，我们不关心是什么域名：[开始融合 CDN 直播](https://doc.shengwang.cn/doc/fusion-cdn/restful/get-started/quick-start)

---
# ID: 32313

SDK Product: RTC-Linux

SDK Platform: Linux-Java

SDK Version: 4.0.1

Request Type: 其他问题

Request Description: 你好， 我用java推拉流demo使用你们提供的test数据（send_video.h264）视频推流正常，没有卡顿抖动问题，但是使用我们的视频就会出现画面抖动问题， 视频大小60m（send_video.h264文件只有292k），我排除了视频本身的问题（播放器播放流畅），排除了服务器带宽问题（服务器带宽300m）。目前推断可能是推帧顺序问题，提前接收到下一帧后又收到前一帧导致的卡顿。 
我尝试修改了demo代码，加入了缓冲区，提前顺序缓冲150帧再进行发送帧，问题没有得到解决，画面还是会抖动，我想问一下你们有没有遇到过这个问题， so代码里是如何进行推帧的。

Reply: 这个大疆无人机录制的文件有 b 帧，我们的 SDK 不支持解析 b 帧，所以才会出现卡顿，可以问下大疆如何关闭录制时b 帧，试试关闭 b 帧以后是否正常。或者换成没有 b 帧的文件来发送

---
# ID: 32320

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.2

Request Type: 其他问题

Request Description: 65472710主播在连麦中执行旁路转推流服务。
结束退出连麦时执行了`stopRtmpStream`
但转推流服务器没有实时结束掉往流地址转推的服务
会导致我们这边连麦切到本地推流器时推不上同地址的cdn - 因为还存在着之前的推流没关闭结束

诉求：需要帮忙查下执行了`stopRtmpStream`但没能实时关闭停止转推的原因？或者确认下这个关停是否有延时性

Reply: 客户端旁路推流接口废弃，需尽快迁移至服务端实现

---
# ID: 32323

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 如何在同一个频道中推送两个视频源的流，并且在观众端能够将两个流在两个窗口上分开显示出来？

Reply: 用两个 uid 在频道里分别发流就行了，对于观众就是 2 个远端视频流

---
# ID: 32324

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.0.0

Request Type: 其他问题

Request Description: 你好, 请问云代理路由应该如何设置呢?

Reply: 请问这边什么需求，目前不太推荐用云代理方案了

建议参考白名单方案[应对防火墙限制](https://doc.shengwang.cn/doc/rtc/javascript/basic-features/firewall)

---
# ID: 32326

SDK Product: RTC-Linux

SDK Platform: Linux-CPP

SDK Version: 4.2.32

Request Type: 集成问题咨询

Request Description: 服务端使用 `sendStreamMessage` 接口给客户号端发送消息，发送返回是 0，表示发送成功，但客户端有的时候会收到 `onStreamMessageError` 的消息，收到的 code 是 `errStreamMessageTimeOut`

CreateDataStream 时，reliable 和 ordered 都为 true，我想了解怎么才能正常推送数据给客户号端，既然能够给客户端超时数据，为什么不直接把数据给客户端呢？ 

Reply: return 0 只是方法调用成功，不代表实际发送成功，检查一下发送大小是不是超过 30kb了，服务端的限制和客户端是一样的

---
# ID: 32327

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 其他版本

Request Type: 其他问题

Request Description: UID为小程序uid,安卓能监听到此id进入和离开频道，小程序无法监听到安卓进入频道

Reply: 小程序一直没有监听到Android端进入通道的问题可以提供下小程序的日志和 Android 端的日志看下，其中小程序端Log.setLogLevel方法设置小程序 SDK 输出日志等级，Log.uploadLogs方法上传 SDK 日志至服务器；安卓端日志是`/storage/emulated/0/Android/data/<package name>/files/agorasdk.log`

---
# ID: 32334

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.2.0

Request Type: 商务问题

Request Description: 1、一对一音视频
2、价格

Reply: 您好，
关于计费等商务问题，为了使您的问题得到更好的跟进和解决，您可以直接通过电话或邮件的方式联系声网商务进行咨询，联系方式：400 6326626 或 sales@agora.io。

---
# ID: 32340

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.3.2

Request Type: 其他问题

Request Description: 是不是只要采播不到就会触发错误码 104或者106的回调。网络波动也会造成这种情况吧

Reply: 采播不到（如视频采集失败）不会直接触发 错误码 104或106回调，网络质量比较差、长时间断网掉线、开启 vpn时，我们大网会检测客户端心跳包，如果10秒收不到心跳包则认为这个用户离线，此时也会触发错误码 104、106

---
# ID: 32347

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.0

Request Type: 集成问题咨询

Request Description: web端用户观看直播有切换清晰度的方法吗

Reply: 没有，RTC 是实时传输，主播端发什么，观众就收什么

如果你需要切换分辨率，可以考虑在频道里加入不同分辨率的[云端转码](https://doc.shengwang.cn/doc/cloud-transcoder/restful/landing-page)，然后让观众自行订阅转码的视频流。

---

# ID: 32361

SDK Product: RTC-Linux

SDK Platform: Linux-Java

SDK Version: 4.0.1

Request Type: 集成问题咨询

Request Description: 运行demo时，显示找不到相关类

Reply: 请参考这个文档 [跑通示例项目](https://doc.shengwang.cn/doc/rtc-server-sdk/java/get-started/run-example)
run.zsh里最好自行修改一下路径，确保是定位到 libs 下 so 文件的路径

---
# ID: 32528

SDK Product: RTM

SDK Platform: JavaScript

SDK Version: 2.1.2

Request Type: 集成问题咨询

Request Description: 我们有没有运行在node环境里面的 sdk 我们需要做实时消息推送

Reply: 你好，RTM2.x 支持node.js的rtm sdk如下，当前是beta版：
[rtm-nodejs](https://www.npmjs.com/package/rtm-nodejs?activeTab=versions)

---
# ID: 32530

SDK Product: RTC-Linux

SDK Platform: Linux-CPP

SDK Version: 4.2.32

Request Type: 集成问题咨询

Request Description: 我使用`rtmpConnection`进行h264视频推流
在 `_connection->getRtmpLocalUser()->publishVideo(_customVideoTrack)` 会失败创建推流
并且publishVideo返回码为-1，是什么原因？
是rtmp无法推流已经编码好的h264视频吗？

Reply: 您好，当前声网侧不推荐您使用端侧以及linux sdk推流到cdn，接口将会废弃；强烈建议您使用restful旁路推流方式，参考文档如下：
[服务概述](https://doc.shengwang.cn/doc/media-push/restful/overview/product-overview)

---
# ID: 32531

SDK Product: RTC

SDK Platform: Restful

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 请教一下，使用场景是数字人推流、拉流。像把声网当作流媒体服务做中转。
推流在Linux环境，使用python语音，推送的是video、audio的字节流，
拉流在pc和移动端都有，使用声网sdk加入频道，实现拉流播放的效果。
拉流看到提供了很多sdk，但是推流这端好像没有给SDK或者示例，请问支持python直接推流到声网吗？

Reply: 您好，python sdk 是支持推拉流的，参考文档如下：
[发送和接收媒体流](https://doc.shengwang.cn/doc/rtc-server-sdk/python/get-started/send-receive)
[Agora-Python-Server-SDK](https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/tree/release/2.1.0/agora_rtc/examples)

---
# ID: 32536

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.3.0

Request Type: 崩溃（闪退、卡死）

Request Description: 在直播中切换连麦，出现内存居高不下的问题

Reply: 您好，针对内存泄漏的问题，
1、需要您这边先排查定位各个线程的内存增长曲线，确认是否是声网的线程引发的内存泄漏；通常遇到比较多的是业务UI引发内存泄漏居多。
2、如果确实是声网的线程引发的，麻烦您提供内存增长曲线截图以及对应时间点声网sdk的日志，声网侧会进一步排查定位

---
# ID: 38108

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 其他问题

Request Description: 集成问题咨询 - 我们想要做AI识别功能，如何获取声网的视视频流地址（不是视频帧数据），之前提供的接口不鞥解决问题，需要视频流地址

Reply: 您好，RTC 是试试音视频通道，不是 CDN 推拉流地址，我们没有视频流地址直接对外提供。有需要的话，可以起一个[旁路推流](https://doc.shengwang.cn/doc/media-push/restful/landing-page)，转推到指定地址，然后让您的 AI 从收流地址获取画面。

---
# ID: 38111

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: Android 设备使用网络代理，joinchannel 失败

Reply: 您好，请问您说的网络代理是什么？是指开 vpn 加频道吗？我们默认是链接最近节点的，开 vpn 会导致连接变长，容易出现断联，不建议开启 vpn 进行通话

---
# ID: 38115

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: `https://gateway-cn-hz.netless.link/pv/rooms/da890f60c29011f09f01a96f07fd8f37/slices?beginAt=1763259040701&clientVersion=2.16.52&endAt=1763265051041`
回访页面这个接口返回是空的，这是什么问题
房间ID：xxx
白板ID：xxx

Reply: 您好，看您选的是云录制，但发的接口域名里有 `netless ` ，这个是白板的域名，请问现在是在用哪个产品？什么场景与需求？

---
# ID: 38119

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.2.0

Request Type: 集成问题咨询

Request Description: 我想集成声网的语音聊天功能，我的问题是，我们的一个语音端是linux开发板，我没找到linux 版本的音频通话的sdk。

Reply: 您好，Linux 开发板 属于IOT 设备，一般推荐用 [RTSA SDK](https://doc.shengwang.cn/doc/rtsa/c/landing-page)
Linux 服务器的话可以直接用 [RTC 服务端 SDK](https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/landing-page)

---

# ID: 38086

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 音视频通话集成，视频录制同步到文件存储，是否支持支持Azure  SMB协议，Blob文件格式？

Reply: 您好，云录制上传的原理是录制完传输到指定的 OSS 路径上，我们只负责写入，这个过程是不需要Azure SMB协议的。以及我们的录制格式是固定的 ts 切片+m3u8 索引，不会生成其他格式，有需要的话，可以自行本地[转换录制文件格式](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guides/manage-file/convert-format)
参考：[录制文件介绍](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guides/manage-file/introduce-recorded-files)

---
# ID: 38087

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 效果不佳、不达预期

Request Description: 1：页面录制后的文件，声音有卡顿现象，不连续，一个小时内都是这个情况
2：录制用户id：1406432，使用云端播放器的uid：1406433，当前录制的视频中，视频没问题，但是音频是一顿一顿的

Reply: 您好，实际通话中其他人听 1406432 的声音正常吗？如果这个 uid 本身网络很差发出来的内容就是卡的，那录制的文件就一定是卡的,麻烦提供具体的录制 sid 以及对应的录制文件过来看下.

---
# ID: 38092

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 线上报错

Request Description: 使用你们的Agora-Java-Server-SDK发送语音消息,能发送出去,但是硬件接收说数据格式不对,说需要使用G722格式的,请问现在格式是必须要设置吗,另外test_data/tts_ai_16k_1ch.pcm 默认是什么格式的.

Reply: 您好，Linux 服务端默认使用 opus 音频编码，和 IOT 设备互通的话需要使用私参调整对齐双端的协议，可以等候人工工程师跟进提供私参参数。

---
# ID: 38098

SDK Product: Flexible-classroom

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我们使用 秒搭的灵动课堂，现在出现一个问题，就是web端端录音说话声音，在安卓端听不到，这个是什么问题呢？还有秒搭的版本是："version": "2.7.0"

Reply: 您好，秒搭已经下架了，不推荐使用，请直接[集成灵动课堂](https://doc.shengwang.cn/doc/flexible-classroom/android/get-started/integrate)

---
# ID: 38099

SDK Product: RTC-Linux

SDK Platform: Linux-Java

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: RTC服务端SDK的Java API中，通过回调`io.agora.rtc.IVideoEncodedFrameObserver.onEncodedVideoFrame()`得到了`EncodedVideoFrameInfo`，对于其中的`captureTimeMs`视频采集时间戳、`decodeTimeMs`视频渲染时间戳存在疑问。此前这两个时间戳一直是 0。更新至 4.4.32.200 版本后，时间戳不为0，但数值比较奇怪（例如22953660972），不是正常的Unix时间戳（例如1763532478266）。请问这是BUG，还是时间戳的定义采用了特殊的格式？另外，只有首帧是I帧，后续帧都是P帧，无I帧与B帧，请问这是正常的业务逻辑，还是统计信息有误呀？谢谢！

Reply: 您好，
1、这个时间戳是 SDK 内部的一个刻度，并不是 Unix 时间戳，直接用来对比值的大小也可以提现时间先后。
2、目前 4.x SDK 的视频关键帧策略就是只发一个 I 帧，后续都发 P 帧，B 帧基本不会使用。如果有需要的话，可以描述下完整场景，人工工程师可以提供具体的私有参数调整发送私参的策略。

---
# ID: 38101

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.2

Request Type: 其他问题

Request Description: 声网是否支持esp32s3 音频呼叫 进行双向语音通话，电话咨询过客服 说的灵笋物联网平台可以，但是后期会被砍掉  是否有替代的产品 进行多端通话 设备端（esp32s3）+安卓端+web端

Reply: 您好，灵隼已经要下架了，请不要使用。
IOT 设备可以用 RTSA SDK，我们有 ESP32S3 的 SDK ，idf 版本小于 5.0 的话可以集成官网文档里的对外版本，参考[下载](https://doc.shengwang.cn/doc/rtsa/c/resources)
如果是 idf5.0 以上的环境，需要联系人工工程师提供定制版本，请先确认下您这边的系统、架构、环境。

---
# ID: 38104

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: android rtc sdk 如何获取当前RtcEngine 开启的camera是前置还是后置

Reply: 您好，目前没有直接获取当前所用摄像头方向的接口，一般 SDK 是默认使用前置摄像头，有需要的话可以在[setCameraCapturerConfiguration](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_video_device#setCameraCapturerConfiguration)里控制枚举

---

# ID: 38068

SDK Product: RTM

SDK Platform: Object-C

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 被叫加入房间 在什么方法响铃和做 UI 刷新比较合适 总是感觉不能同步

Reply: 您好，这个属于您自己的业务场景，需要您自行构建并寻找合适的时机，一般是收到信令时做响铃+UI 提示，点击接受或拒绝以后信令传输回去做确认。

---
# ID: 38071

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.3.0

Request Type: 开通权限、提供配额

Request Description: 用声网工具，进行AI语音对话，需要开通 AI Agent v0.3服务。

Reply: 您好，convoAI 目前已经发版正式版很久了，您可以参考[开通服务](https://doc.shengwang.cn/doc/convoai/restful/get-started/enable-service)自行开通相关功能并使用。

---
# ID: 38075

SDK Product: Marketplace

SDK Platform: Android

SDK Version: 内容审核

Request Type: 集成问题咨询

Request Description: 数美音频审核，使用说明中联系声网技术支持

Reply: 您好，目前不推荐对接云市场数美审核插件了，建议您联系数美厂商，在数美侧集成审核功能

---
# ID: 38080

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 2.6.5

Request Type: 其他问题

Request Description: 背景：
1、众安保险旗下的小程序使用场景（容器不是微信，是凡泰小程序），项目名是随便取的。
2、网站上面的测试小程序推拉流正常
问题描述：
1、推流每次只能 10 多秒就会断掉；
2、手机小程序推流，PC 端拉流但是没有声音（小程序端拉流有声音）；
附件里面有相关的日志。

Reply: 您好，我们没有适配过凡泰小程序这个平台，小程序 SDK 只支持原生小程序开发

---

# ID: 38034

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: 拨打对方总是延迟是怎么回事 对方接听了 我还在响铃界面 要等几秒才接通 这种应该怎么优化，给个思路

Reply: 您好，RTC 本身不自带呼叫邀请，如果是呼叫邀请时的延迟，需要自行排查信令业务来解决

---
# ID: 38036

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: 我们目前有一个特殊场景，即使用户配置了耳机设备也需要强制通过手机来录音（MediaRecorder.AudioSource.MIC），但播放的声音又需要通过耳机播放。声网SDK内部未找到定制audioSource相关API。
我们目前通过自定义音频采集方案，把录音后的音频数据通过`pushExternalAudioFrame`方式把音频数据推送给声网，但由于我们目前使用场景比较特殊，是一个房间内同时本地加入了两个用户（`joinChannelEx` 加入两次房间，本地同时存在用户A和用户B），我只需要其中的一个用户推流，目前尝试把其中一个用户的`MediaOptions.publishCustomAudioTrack = false` 和 `mRtcEngine?.muteLocalAudioStreamEx(true, rtcConnectionA)`都无法生效，都会导致房间内的两个用户同时在推流。求官方提供下解决方案，或者增加定制录音源的配置接口。

Reply: 1、请问您这边是有线耳机还是无线蓝牙耳机？有线耳机带麦克风的话，这个需求无法实现，采集和播放都会走耳机，这是系统行为。如果是蓝牙的话，走 a2dp 协议可以让耳机直播放，采集走手机，join 之前调用 SDK 接口传私参实现，具体参数可以等候人工工程师提供
2、可以提供下复现问题时的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，人工工程师稍后查看并解析

---
# ID: 38038

SDK Product: RTC

SDK Platform: React Native

SDK Version: 4.4.0

Request Type: 其他问题

Request Description: android接通有嘈杂音，G722格式

Reply: 您好，请确保通话双方都配置了 G722 格式的音频编解码，可以提供下复现问题时的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，人工工程师稍后为您解析

---
# ID: 38043

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 写了个demo， 让ai加入我创建的直播频道， 但是加入不了

Reply: 您好，加入不了的话有什么报错吗？可以提供下出错的信息，如果是智能体加入不了，提供 agentID；如果是客户端加入不了可以提供 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---
# ID: 38047

SDK Product: IM

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 即时通讯IM中,哪个接口可以获取两个用户之间的聊天记录?

Reply: 您好，请问指的是后台获取吗？ 如果是后台获取，只有两种方案：
1、拉取历史记录，是全量按照小时拉取，需要自己筛选；这个有比较大的时延，按照小时为维度
2、用回调服务，只要有消息就回调给您指定的服务器，这个是毫秒级，然后自行抽取相关用户的信息

---
# ID: 38050

SDK Product: Whiteboard

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 去年站内信通知白板久域名已经计划弃用 需要转移到新域名 请发我一下那些域名即将弃用 用那些域名替换

Reply: 您好，白板 SDK 从旧版迁移到新域名的话会变动以下域名（仅限白板 SDK，与 RTC 等其他产品无关）
`scdncloudcapiv4.herewhite.com、cloudcapiv4.herewhite.com、capiv4.herewhite.com` 替换为：`api.netless.link、api.whiteboard.sd-rtn.com、api.whiteboard.agora.io(海外region)、api.whiteboard.rtelink.com(海外region)、api.baiban.shengwang.cn(中国region)`，相关功能：白板restful api
`convertcdn.herewhite.com` 替换为 `convertcdn.netless.link`，相关功能：白板旧版转码cdn
`demo.herewhite.com` 替换为 `demo.whiteboard.agora.io` ，相关功能：白板demo

---
# ID: 38052

SDK Product: Console

SDK Platform: All

SDK Version: 当前版本

Request Type: 效果不佳、不达预期

Request Description: 你们倒是给我个发票下载地址啊, 
邮箱：1913441053@qq.com 这个邮箱不对, 我拿不到发票

Reply: 您好，发票申请未收到类的问题可以提供下申请发票时所用的 cid，以及说明下申请的具体时间、需要接受发票的邮箱（可在声网 console-费用中心-发票详情设置内指定邮箱），人工工程师稍后会和财务确认情况。

---
# ID: 38053

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.5.1

Request Type: 集成问题咨询

Request Description: Mac端从unity构建包含RTC的应用，无法签名，下面是Xcode报错信息
```
/usr/bin/codesign --force --sign - -o runtime --preserve-metadata\=identifier,entitlements,flags --generate-entitlement-der /Users/fayuan/Library/Developer/Xcode/DerivedData/test2-dnrzzuoefmhcpdexlqacxnshdoyc/Build/Intermediates.noindex/ArchiveIntermediates/VTrial/InstallationBuildProductsLocation/Applications/VTrial.app/Contents/PlugIns/AgoraRtcWrapperUnity.bundle

/Users/fayuan/Library/Developer/Xcode/DerivedData/test2-dnrzzuoefmhcpdexlqacxnshdoyc/Build/Intermediates.noindex/ArchiveIntermediates/VTrial/InstallationBuildProductsLocation/Applications/VTrial.app/Contents/PlugIns/AgoraRtcWrapperUnity.bundle: replacing existing signature
/Users/fayuan/Library/Developer/Xcode/DerivedData/test2-dnrzzuoefmhcpdexlqacxnshdoyc/Build/Intermediates.noindex/ArchiveIntermediates/VTrial/InstallationBuildProductsLocation/Applications/VTrial.app/Contents/PlugIns/AgoraRtcWrapperUnity.bundle: code object is not signed at all
In subcomponent: /Users/fayuan/Library/Developer/Xcode/DerivedData/test2-dnrzzuoefmhcpdexlqacxnshdoyc/Build/Intermediates.noindex/ArchiveIntermediates/VTrial/InstallationBuildProductsLocation/Applications/VTrial.app/Contents/PlugIns/AgoraRtcWrapperUnity.bundle/Contents/Frameworks/AgoraFaceCaptureExtension.framework
Command CodeSign failed with a nonzero exit code
```

Reply: 您好，需要先对 bundle 里面的每个 framework 签名，然后才能对 bundle 签名，您这边可以检查下有哪些 framework 没有被签名

---
# ID: 38055

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.3.2

Request Type: 集成问题咨询

Request Description: 我可以用一个uid在一个channel里同时推屏幕流和视频流吗；

Reply: 您好，一个 UID 只能发布一路视频流，electron 可以用 [加入多频道](https://doc.shengwang.cn/doc/rtc/electron/advanced-features/multiple-channel) 方法，分别用两个 uid 在频道内发流。

---
# ID: 38063

SDK Product: RTC

SDK Platform: React Native

SDK Version: 4.3.2

Request Type: 其他问题

Request Description: 
```
[INFO] [app] license_activate uri: https://api.agora.io/dabiz/license/v2/active?pid=xxx&licenseKey=xxx&appid=xxx
W (1316) wifi:<ba-add>idx:0 (ifx:0, c6:b2:5b:1a:d9:a1), tid:0, ssn:2161, winSize:64
[ERR] ssl error: net_connect returned -82 - UNKNOWN ERROR CODE (0052)
I (1350) DRV8311: ES8311 in Slave mode
I (1358) wifi:BcnInt:102400, DTIM:1     
```
在ESP32S3上，进行授权激活时，返回错误

Reply: 您好，请求的 url 需要修改下，参考[激活 License](https://doc.shengwang.cn/doc/rtsa/c/basic-features/license#3-%E6%BF%80%E6%B4%BB-license)，以及请确保用 curl 请求。

---
# ID: 38066

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: Android rtc sdk 是否有接口可以查询频道内某个用户是否仍在频道内

Reply: 您好，没有直接查询的接口，但是可以[查询用户列表](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/get-dev-v1-channel-user-appid-channelName)然后自行比对。

---

# ID: 38016

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 集成问题咨询

Request Description: 请问灵动课堂有后端的状态回调吗？比如，直播间关闭这样的事件

Reply: 您好，可以监听[服务端 CMD 事件](https://doc.shengwang.cn/doc/flexible-classroom/restful/api/api-sync#%E4%BA%8B%E4%BB%B6%E6%9E%9A%E4%B8%BE)来实现。
需要的话，麻烦提供appid、回调地址、需要的 cmd 事件类型、灵动课堂所用的区域和班型，我们找研发后台帮您开通

---
# ID: 38019

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我这边主播开播后，我需要服务端通过旁路推流推到我自己的rtmp流媒体服务器上面，这个如何操作

Reply: 您好，如果需求只是从 RTC 频道里把画面推送到指定的 RTMP 地址上，参考[旁路推流](https://doc.shengwang.cn/doc/media-push/restful/landing-page)文档，调用 Restful 接口来指定 RTC 频道和 RTMP 目标地址转推就可以实现了

---
# ID: 38026

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 在实现屏幕共享功能的时候，只创建了screenVideoTrack。再另外一个方法里控制audioTrack的开启和关闭，经测试发现：audioTrack开关的时候，screenVideoTrack会出段短暂的黑屏，大概0.5秒左右。

Reply: 您好，SDK 的 audioTrack 和 videoTrack 是独立的，理论上不会互相影响，可能是您业务上操作 `unpublish` 的时候控制到了多个 track 导致的，您可以自己 debug 看下，如果自查无果，可以开启 Web [日志上传](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，提供频道号、uid、时间点，人工工程师稍后看下接口调用记录。

---
# ID: 38027

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: 你好，我们又遇到了回声问题，劳烦帮忙看下。
1、问题表现：
北京时间11.12晚10点20左右我们又遇到了回声问题，即我说的话又被手机外放出来，对应的channel是743704562930543032，对应的声网log在附件中。
2、重现步骤：
这个回声问题一直都有，只是偶现的，总体概率不大，但是遇到就比较麻烦，严重影响我们用户的使用体验。我们无法固定重现步骤。
3、我们的使用方法：
AgoraRtcEngineKit初始化配置如附件截图。初始化后，我们使用joinChannel和joinChannelEx两个方法同时加入了多频道。
4、另外我们也想问下我们的业务代码如何检测到出现回声问题了呢？AgoraRtcEngineDelegate有相关的方法回调吗？或者有其他方法吗？我们也需要统计下这个问题实际发生的数量。

Reply: 您好，
1、回声问题优先让双方用户带耳机看是否有改善
2、如果回声上报的数量较多，可以考虑 `scenario` 用 `chatroom`，用通话音量，走硬件回声消除看下效果
3、回声是物理现象，代码检测不出来的，可以考虑做一个按钮上报，让用户遇到了主动上报，方便统计数据

---
# ID: 38028

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 其他问题

Request Description: 我们想接入声网灵动课堂的SDK，上课时可以获取到聊天留言。当我并没有找到获取课堂聊天留言的接口/功能。官网是否通过获取课堂聊天留言的方法

Reply: 您好，灵动课堂的 IM 用的是环信 IM，可以尝试集成[环信 SDK 的回调](https://doc.easemob.com/document/server-side/callback_postsending.html#%E5%9B%9E%E8%B0%83%E7%A4%BA%E4%BE%8B)来获取。

---
# ID: 38031

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 集成问题咨询

Request Description: 课程云录制，html页面recordUrl设置到了域名和传参，`scene.bundle.js`文件接收到了，但是录制的页面是空白

Reply: 您好，页面录制的效果相当于浏览器开启无痕以后直接访问这个指定 url ，如果录制到的就是白屏，那大概率直接访问这个 url 看到的也是白屏，可以先用浏览器无痕模式自查一下。

---

# ID: 38001

SDK Product: RTC

SDK Platform: Windows

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 按照Agora-Java-Server-SDK
/README.zh.md  来启动示例。
`./build.sh -native start`
调用`http://localhost:18080/api/server/basic?taskName=SendPcmFileTest`
报错信息:
```
INFO  io.agora.rtc.example.common.SampleLogger - read appId: b0f175369c2548568fd6e49654eff613 token: 007eJxTYLgovpVxof3bzjzlbvGYT3OOJnzYNm929KK3ZjZyfY/0ufsVGJIM0gzNTY3NLJONTE0sTM0s0lLMUk0szUxNUtPSzAyNlzMKZzYEMjJYrtvCwsgAgSA+C4MhEDAwAAArZx2I from .keys
Exception in thread "pool-2-thread-1" java.lang.NoClassDefFoundError: io/agora/rtc/internal/AgoraAudioFrameObserver
	at io.agora.rtc.SDK.nativeLoad(Native Method)
	at io.agora.rtc.SDK.load(SDK.java:22)
	at io.agora.rtc.AgoraService.<init>(AgoraService.java:28)
	at io.agora.rtc.example.basic.SendPcmFileTest.start(SendPcmFileTest.java:51)
	at io.agora.rtc.example.api.ServerController.lambda$startBasicServer$1(ServerController.java:179)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
	at java.lang.Thread.run(Thread.java:750)
Caused by: java.lang.ClassNotFoundException: io.agora.rtc.internal.AgoraAudioFrameObserver
	at java.net.URLClassLoader.findClass(URLClassLoader.java:387)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:418)
	at org.springframework.boot.loader.LaunchedURLClassLoader.loadClass(LaunchedURLClassLoader.java:93)
	at java.lang.ClassLoader.loadClass(ClassLoader.java:351)
```

Reply: 您好，Agora-Java-Server-SDK 是给 Linux 服务端用的 SDK，请问您现在是在 Windows 上运行这个 SDK 的 Demo 吗？

---
# ID: 38006

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 集成问题咨询

Request Description: CDN集成环境下开发，如何分别监听离开房间和关闭房间

Reply: 您好，请检查下 Web 端的 LaunchOption 里没有填listener，应该要在listener 里配置需要监听的客户端[AgoraEduClassroomEvent](https://doc.shengwang.cn/api-ref/flexible-classroom/javascript/classroom-sdk#classroomevent)事件。
以及也可以同步监听[灵动课堂服务端事件枚举](https://doc.shengwang.cn/doc/flexible-classroom/restful/api/api-sync#%E4%BA%8B%E4%BB%B6%E6%9E%9A%E4%B8%BE)来感知。

---
# ID: 38008

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: voip转pstn如何实现语音中继功能

Reply: 您好，之前有相关的云市场插件，但现在下架了，目前只能推荐您集成 小樱桃 PSTN 的 SDK 来拿到音频流，然后用[自采集](https://doc.shengwang.cn/doc/rtc/android/advanced-features/custom-audio-source)发到 RTC 频道里

---
# ID: 38011

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 集成问题咨询

Request Description: 无法分开判断关闭房间和离开房间

Reply: 您好，请检查下 Web 端的 LaunchOption 里没有填listener，应该要在listener 里配置需要监听的客户端[AgoraEduClassroomEvent](https://doc.shengwang.cn/api-ref/flexible-classroom/javascript/classroom-sdk#classroomevent)事件。

---

# ID: 37988

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.2.0

Request Type: 崩溃（闪退、卡死）

Request Description: 每次退出频道的时候大概率直接闪退

Reply: 您好，我们不推荐在回调内执行接口调用，这种操作容易导致崩溃、卡死问题，回调内推荐只做抛出，在非回调的子线程内执行 SDK 相关操作。可以检查下目前的集成是否有类似问题，如果看不出来，可以提供下退出频道的相关处理代码。

---
# ID: 37993

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 直播的测试域名

Reply: 您好，我们没有测试的域名，请在 console 上直接配置自己的域名来使用融合 CDN 服务

---

# ID: 37956

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 视频通话有鉴黄功能么

Reply: 您好，声网rtc没有内容审核功能，要自行集成第三方审核 SDK

---

# ID: 37965

SDK Product: IM

SDK Platform: Android

SDK Version: 1.3.2

Request Type: 其他问题

Request Description: 我利用UIKit集成的IM
为什么会话列表不显示用户名和头像呢？
只有重新发起会话才有头像和昵称
我关闭app，重新打卡后会话列表又没有用户名和头像了

Reply: 您好，头像昵称需要存到本地，设置给uikit，uikit 没有对头像昵称进行存储，参考[用户自定义信息](https://im.shengwang.cn/docs/uikit/chatuikit/android/chatuikit_userinfo.html)

---
# ID: 37966

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.3.0

Request Type: 商务问题

Request Description: 想了解一下webRTC，烦请回复我一下，我的电话：18610366411

Reply: 您好，Web SDK 的收费方式参考[计费策略](https://doc.shengwang.cn/doc/rtc/javascript/billing/billing-strategy),细节沟通可以电话联系 400 6326626

---

# ID: 37969

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 怎么测试推流是否正常

Reply: 您好，现在用的是融合 CDN 吗？用 OBS 往推流地址上推画面，用 ffplay 或者 vlc 一类的工具拉收流地址看画面就行了，看得到就正常

---

# ID: 37972

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 崩溃（闪退、卡死）

Request Description: iOS AgoraRtcEngine_iOS (4.4.0) AgoraRtcKit declareProviderVersion崩溃

Reply: 您好，麻烦提供下原始崩溃堆栈和出现问题时的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
或者 IPS 文件也可以，我这边找对应版本的符号表解析一下

---

# ID: 37939

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.6

Request Type: 集成问题咨询

Request Description: RTSA支持ESP32设备吗？

Reply: 您好，支持的，有专属的 SDK [下载](https://doc.shengwang.cn/doc/rtsa/c/resources)

---

# ID: 37947

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 同时集成RTC与IM  SDK所发生的集成问题，导致RtcEngine初始化失败。
集成SDK的代码如下：
```Groovy
implementation 'cn.shengwang.rtc:full-sdk:4.6.0'
implementation 'cn.shengwang:chat-sdk:1.3.2'
```

也已经处理同时包含libaosl.so库的问题。
问题报错请看附件。


Reply: 您好，可以尝试以下步骤：
1、在 dependencies 部分把 rtc 放在前面，或者在 rtc 和 im 前面加个`cn.shengwang.infra:aosl:1.3.0` 指定 aosl 高版本
2、或者 RTC 降到4.5.0 版本

---
# ID: 37948

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 用demo测试，以观众视角，歌词不能跟着音乐变化

我这边直接引用的是lib_ktvapi里面的方法，是需要我改一下lib_ktvapi里面的调用才能使用吗？

Reply: 您好，因为我们在线 K 歌房的 Demo 只预设了一首歌，没有信令同步业务，所以切歌以后 Demo 无法感知歌曲的变化，也没有切换歌词的业务处理
切换歌曲播放状态、切换当前显示歌词的广播业务需要您自行实现。

---

# ID: 37953

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 其他问题

Request Description: 非主播端，连麦有回音

Reply: 您好，回声是因为扬声器的声音被麦克风重新采集发回去才会产生的，如果双方有一方不是主播，理论上不可能出现回音问题，现在是谁听谁有回音？检查下主播端是不是调用了 `Localtrack` 的 `play` 指定听自己轨道的声音了？

---

# ID: 37932

SDK Product: Console

SDK Platform: All

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 使用C# SDK 生成token，过期，Utils.getTimestamp() 返回 1762391780 是正常的，uint expire = 600; 600秒，过期日期居然连当前都不对

Reply: 您好，console 里校验 token 有效期的时间戳是 UTC 时间，+8 才是中国时间，可以注意下是否时区换算有问题

---
# ID: 37933

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 商务问题

Request Description: 业务侧到底怎么统计rtm用量。现在rtm消息只有客户端能收到，你们意思是让客户端统计rtm消息条数然后发给服务端来统计吗

Reply: 您好，RTM 没有直接查询用量的接口，以及 RTM 的用量统计也不是只看消息数计费的，连接我们节点也会计费，所以我们不推荐依赖我们的数据去做计费，建议自行构建一套计费体系去给您的终端用户收费。
计费逻辑文档参考：[计费规则](https://doc.shengwang.cn/doc/rtm2/unity/overview/billing/billing-rules)

---
# ID: 37935

SDK Product: RTC

SDK Platform: React Native

SDK Version: 4.5.0

Request Type: 效果不佳、不达预期

Request Description: 我这边是东方财富跟你们对接的服务项目。
我们使用的是rn的adk 4.5.0
目前遇到的问题是：安卓手机使用一个agent先入会后共享屏幕，之后切出app，手机的麦克风占用就消失了。 如果只是入会切出app就能正常使用。
需要我提供什么信息可以回复我，希望能得到解决方案

Reply: 您好，请问下现在的问题是屏幕共享以后切后台无法保持麦克风采集？请问 APP 本身有做过[后台保活](https://doc.shengwang.cn/faq/list?category=quality-issues&platform=all&product=rtc)吗？
以及可以提供下复现问题的录像和对应时间的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，打包压缩 zip 发来。

---
# ID: 37936

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 集成问题咨询

Request Description: rtm 、 rtc 文档中对 renewToken 的描述不一致
现在需要确认 rtc 是否需要传递  频道号，如果需要请提供参数传递格式

Reply: 您好，您看的是两个接口描述，这两个是不同的东西。
RTC 的 renew 方法不需要传 `channelName`，直接传一个新的 token 就行。
RTM 的 renew 方法如果不用 `streamchannel` 是不用传 channelName 进去的，需要用到 `streamchannel` 的时候可以用 RTM 的 `renew` 方法给 RTC 频道也去更新 token，但是需要指定频道名。

---
# ID: 37937

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description:
```json
{"cname":"236","resourceId":"xxx","uid":"518"}
```

请求参数:
```json
{
	"clientRequest": {
		"token": "xxx",
		"recordingConfig": {
			"channelType": 0,
			"streamTypes": 0,
			"maxIdleTime": 180,
			"subscribeUidGroup": 0
		},
		"extensionServiceConfig": {
			"errorHandlePolicy": "error_abort",
			"apiVersion": "v1",
			"extensionServices": [{
				"serviceName": "yitu_voice_async_scan",
				"errorHandlePolicy": "error_abort",
				"streamTypes": 0,
				"serviceParam": {
					"apiData": {
						"accessKey": "xxx",
						"secretKey": "xxx",
						"bizType": "xxx",
						"callbackSeed": "xxx"
					},
					"callbackAddr": "xxx"
				}
			}]
		}
	},
	"cname": "236",
	"uid": "518"
}
```


Reply: 您好，请问现在的问题现象是什么？是 start 失败还是 start 成功以后找不到录制任务？有收到返回的 sid 吗？

---

# ID: 37909

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: joinChannel之后 怎么获取屏幕分享的音频数据  onRecordAudioFrame 和 onPlaybackAudioFrame 的buffer都是空的

Reply: 您好，音频裸数据通道拿不到屏幕共享的声音回调，请问您是什么场景需要获取屏幕共享的音频裸数据？

---

# ID: 37911

SDK Product: Fastboard

SDK Platform: iOS

SDK Version: 1.4.2

Request Type: 集成问题咨询

Request Description: 请看附件
问题1：画笔的上面有一行文字，请问哪个方法可以隐藏这一行文字？
问题2：白板的工具栏我参考你们的文档，发现并未起效，麻烦你们指导一下

Reply: 您好，
1、上方的文字是书写者的光标，fastboard 预设的，无法修改。如果您考虑用 whiteboard，可以参考[鼠标光标适配器](https://developer.netless.link/javascript-zh/home/cursor-adapter)自行编写一套光标逻辑
2、可以参考下[自定义 UI 控件](https://doc.shengwang.cn/doc/whiteboard/ios/fastboard-sdk/advanced-features/customize-widget)，检查下`toolbar`是否为 `enable = true` 的状态

---

# ID: 37914

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 如果自定义集成 ASR

Reply: 您好，请问现在用的是 convoAI 吗？convoAI 无法指定自定义 ASR，只能选择我们提供的几个厂商

---

# ID: 37922

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.5.1

Request Type: 集成问题咨询

Request Description: 尊敬的 Agora 技术支持团队：
您好，我是一名 iOS 开发者，正在集成 Agora RTC SDK 开发实时音视频应用。在实现画中画（Picture-in-Picture, PiP）功能时，希望确保应用进入画中画模式后仍能持续保持本地摄像头的视频采集与推送，避免通话中断。
根据 Apple 官方文档，iOS 提供了对 “多任务摄像头访问” 的支持能力。在此想咨询：
1. Agora iOS SDK 是否原生支持该场景？是否需要进行特殊配置（如 SDK 初始化参数、视频轨道设置等）来保证画中画模式下摄像头持续采集？
2. 自定义采集能实现上述需求，但是原来使用的背景虚化在自定义采集时无法生效，如果sdk没有提供设置ismultitaskingcameraaccessenabled的方法那有没有提供自定义采集时使用agora背景虚化的方法？


Reply: 您好，我们的官方 Demo 有演示如何实现画中画+后台保持采集功能，可以运行+参考下
* [PictureInPicture.java](https://github.com/AgoraIO/API-Examples/blob/main/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/PictureInPicture.java)
* [IOS PictureInPicture](https://github.com/AgoraIO/API-Examples/tree/main/iOS/APIExample/APIExample/Examples/Advanced/PictureInPicture)
其中 IOS 要实现进入后台保持采集就必须使用自采集，自采集也是支持开启虚拟背景的，api-example 里有虚拟背景的 Demo，您可以基于那个对照看下写法的区别，如果确认处理没问题还是不行，可以提供下相关代码截图+提供复现问题的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)过来看下。

---

# ID: 37927

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.5.1

Request Type: 集成问题咨询

Request Description: 如何在unity收到远端用户开麦事件后，可以不自动播放远端用户的语音流？我们希望和web这边一致，在收到远端用户开麦的事件后，手动subscribe远端用户语音流，在unity这边可以实现这个效果吗？

Reply: 您好，Unity 里没有`Subscribe`接口，在加频道的时候配置`autoSubscribeAudio=false`禁止自动订阅，然后搭配[SetSubscribeAudioAllowlist](https://doc.shengwang.cn/api-ref/rtc/unity/API/toc_publishnsubscribe#SetSubscribeAudioAllowlist)来实现只订阅部分用户的效果。

---

# ID: 32678

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.2.1

Request Type: 集成问题咨询

Request Description: 请问下如果用户A调用publish方法发送一个User类型的消息给用户B，如果用户B当时不在线，等一段时间后上线了能收到这条信息吗？如果不能的话，你们有解决案例吗？

Reply: 您好，rtmsdk2.2.2版本开始支持历史消息；该版本在 PublishOptions 中新增了 storeInHistory 属性，支持在频道中发送消息的同时，将消息存储到云端，后续用户可以通过历史消息接口获取；参考文档如下：
[历史消息 (Beta)](https://doc.shengwang.cn/doc/rtm2/android/user-guide/message/history-message)

---
# ID: 32698

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 目前采用CDN推流的方式推流到阿里云、目前可以显示推流地址、但是视频流和音频流没有数据、并且这个推流信息不稳定、有时候可以显示推流、有时候没法显示推流。请问有没有关于CDN推流到第三方的demo或者案例参考

Reply: 您好，当前推流到cdn推荐使用旁路推流的方式，客户端SDK直推CDN已准备下架，不推荐使用；
参考文档如下：
[服务概述](https://doc.shengwang.cn/doc/media-push/restful/overview/product-overview)

---

# ID: 32706

SDK Product: RTM

SDK Platform: Object-C

SDK Version: 2.1.11

Request Type: 集成问题咨询

Request Description: 请问下，我如何能验证，一个RTM token为什么是invalid的? 

Reply: 您好，控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验
将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致

---
# ID: 32722

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 目前我们设备端的收声效果不好，另一端听到的声音时大时小、有很强的顿挫感，听不清晰。同环境同设备下试了webRTC的官方Demo，在第一个Demo中也发现了收声问题（音量变化反馈、又低又断续），但是另一个Demo中收声是正常的，请问有什么解决方案？

Reply: 您好，
1、您这边可以是用webrtc官网的检测工具确认mic收音是否有问题：
[WebRTC samplesSelect sources & outputs](https://webrtc.github.io/samples/src/content/devices/input-output/)
2、如果正常，请使用声网的webrtcdemo 测试能否复现，如果可以复现，麻烦提供下频道号，以及那个uid听那个uid的声音断续和时间点
https://webdemo.agora.io/


---
# ID: 32723

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.3.2

Request Type: 其他问题

Request Description: 很奇怪，我调试的时候，可以正常进入群聊，但是打包之后始终进不去。这是为什么？

Reply: 您好，可能和以下几点有关：
1、确认RtcEngine是否初始化成功，是否卡死？
2、RtcEngine初始成功，需要看下joinchannel接口返回值，0表示正常加入；异常返回值参考接口说明
[频道相关](https://doc.shengwang.cn/api-ref/rtc/flutter/API/toc_channel#api_irtcengine_joinchannel2)
3、以上都正常，请提供问题时间点，频道号、用户UID以及声网sdk日志
[LogConfig](https://doc.shengwang.cn/api-ref/rtc/android/API/class_logconfig#filePath)

---
# ID: 32725

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.0

Request Type: 集成问题咨询

Request Description: 我这边有多个视频源都需要直播，我们这边是要申请多个频道token吗？还是说要申请多个项目呢？

Reply: 您好，声网侧每个直播间的每个用户都需要申请单独的token，生成token时需要保证：
* 频道名称与加入频道时一致
* UID与加入频道时完全匹配
另外单个声网项目可以管理多个频道，无需创建多个声网项目

---

# ID: 32769

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.1

Request Type: 集成问题咨询

Request Description: 
```log
swcallvideo.vue:36 Uncaught (in promise) TypeError: client.value.init is not a function
    at initAgora (swcallvideo.vue:36:16)
    at swcallvideo.vue:42:3
    at chunk-JCIXZJ4J.js?v=dc377717:5084:40
    at callWithErrorHandling (chunk-JCIXZJ4J.js?v=dc377717:2504:19)
    at callWithAsyncErrorHandling (chunk-JCIXZJ4J.js?v=dc377717:2511:17)
    at hook.__weh.hook.__weh (chunk-JCIXZJ4J.js?v=dc377717:5064:19)
    at flushPostFlushCbs (chunk-JCIXZJ4J.js?v=dc377717:2689:28)
    at flushJobs (chunk-JCIXZJ4J.js?v=dc377717:2731:5)
```

Reply: 您好，这边提供下VUE 开发示例的demo：
[API-EXAMPLE](https://github.com/AgoraIO/API-Examples-Web/blob/main/src/example/framework/vue/index.js)
以及相关开发文档：
[AgoraRTC Vue Docs](https://webdemo.agora.io/agora_rtc_vue_doc/)

---

# ID: 33115

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.1.10

Request Type: 其他问题

Request Description: 尊敬的用户，您好！
您的声网账户 的RTM 体验套餐 的套餐内配额就快用尽了。
为了不影响您正常使用该服务，请尽快升级套餐版本。
请问一下, 是什么配额快用尽了? 明细在哪里看呢?

Reply: 请联系您的专属商务经理或者直接通过电话联系声网商务进行咨询，联系方式：400 6326626

---
# ID: 33140

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.1.0-1

Request Type: 集成问题咨询

Request Description: 我们使用RtcEngineEx实现多通道通信
我们使用mRtcEngine.enableAudioVolumeIndication(200, 3, false);启动用户音量监听，但是IRtcEngineEventHandler的onAudioVolumeIndication收不到消息的回调。
如果是单通道是可以收到的，请问是哪里集成错误了吗？

Reply: 使用 RtcEngineEx 实现多通道时，注意要调用ex方法：[enableAudioVolumeIndicationEx](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#api_irtcengineex_enableaudiovolumeindicationex)

---
# ID: 33150

SDK Product: RTC-Linux

SDK Platform: Linux-CPP

SDK Version: 4.0.1

Request Type: 集成问题咨询

Request Description: 我看别人有一个物联网的硬件，音视频语音是用的你们家。但是不知道单片机的sdk，和收费方式是什么，webrtc 也是按分钟收费么？

Reply: 嵌入式硬件端sdk 一般为[声网媒体流加速（原实时码流加速，Real-Time Streaming Acceleration，RTSA）](https://doc.shengwang.cn/doc/rtsa/c/overview/product-overview)
费用一般按照设备license计算[申请和使用 License](https://doc.shengwang.cn/doc/rtsa/c/basic-features/license) 具体计费可以联系您的专属商务经理 或者 电话咨询400 6326626

---
# ID: 33152

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 实现 HTTP HMAC 认证,文档描述太模糊，请提供php语言的接入示例，或提供详细的加密认证过程说明

Reply: 请参考文档[实现 HTTP 基本认证](https://doc.shengwang.cn/doc/rtc/restful/user-guides/http-basic-auth) 其中包含PHP的示例代码
请参考其他语言的示例代码，自行转换成 PHP 语言 [实现HTTP安全认证](https://doc.shengwang.cn/doc/cloud-transcoder/restful/user-guides/http-auth)

---

# ID: 33164

SDK Product: RTMP

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: `/rtm/users/8889987154254/peer_messages`
服务端调用这个接口给单人发送消息，但是客户端没有收到，我想查看发送日志

Reply: `/rtm/users/<user_id>/peer_messages`是RTM 1.x的服务端发送点对点消息接口，如果客户端未收到服务端发送的消息可以先检查下客户端是否登录并且是在线状态。
客户端日志获取：[setLogFile](https://docportal.shengwang.cn/cn/Real-time-Messaging/API%20Reference/RTM_java/classio_1_1agora_1_1rtm_1_1_rtm_client.html#ad44bd79d005d25c68712cc35d16d934b)
服务端日志请联系人工技术支持获取

---
# ID: 33172

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.3.2

Request Type: 集成问题咨询

Request Description: 今天测试了 大半天 就消耗了 我1700分钟  吓到我了   我就两个设备调试    所有人离开频道  还要计费的？   有没有接口 可以看到 我这个账号下 哪些频道没有销毁  ，
flutter调用销毁  是所有人离开频道 就自动销毁频道了吗？  还是要怎么处理，需要自己离开后  调用 engine.release 吗

Reply: 1. 计费机制：
针对每个用户，声网从其加入 RTC 频道开始计算时长用量，到离开这个频道结束计量。参考[计费策略](https://doc.shengwang.cn/doc/rtc/android/billing/billing-strategy)
2. 频道销毁逻辑
自动销毁：当频道内最后一个用户离开时，RTC 后端会自动销毁频道（无需手动调用接口）。
3. 查看未销毁频道
提供服务端接口[查询项目的频道列表](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/get-dev-v1-channel-appid)
也可以在水晶球中查看正在进行通话的频道[水晶球通话调查-查看通话详情](https://doc.shengwang.cn/doc/analytics/general/rtc/call-search/call-detail)

---

# ID: 33506

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 视频通话，代码里使用 soundpool 播放接通前的铃声，铃声再响，一切正常。但只要代码执行了“ mRtcEngine.joinChannel(token, channelId, "", Constant.AGORA_UID);”这句，铃声就没有了，没有声音了。不执行这句，铃声可以按设计的一直循环播放。如果这句放在播放铃声前面执行，那铃声就会全程无声。这个怎么处理？每次都会出现。

Reply: 您好，加入频道以后音频路由会有切换，初步推测是我们 SDK 的音频录音和您的soundpool不一致导致的，可以通过修改[setaudioscenario](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#api_irtcengine_setaudioscenario)来解决，如果您soundpool用的是媒体音量，那就把 scenario 改成 GameStreaming；如果是通话，就改成 Chatroom

---
# ID: 33508

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.19.0

Request Type: 开通权限、提供配额

Request Description: 我想咨询一下，我们后端JAVA想实时获取直播会议的音频流在我们业务上使用，是不是可以用旁路推流功能实现？或者推荐别的更好的实现方案？有没有对应的JAVA的SDK提供？

Reply: 旁路推流是把 RTC 频道里的流转推到 RTMP 地址上，和你们的需求关系不大
如果您是 Linux Java，可以用我们的服务端 SDK：[跑通示例项目](https://doc.shengwang.cn/doc/rtc-server-sdk/java/get-started/run-example)

---

# ID: 33535

SDK Product: Recording

SDK Platform: Linux-Java

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我们将java的录制SDK封装成一个服务，打包成jar包后放到CentOS7虚拟机中，运行java服务，微信小程序双方进入视频通话，开启录制服务后报错：
（1）Terminal中提示如下：
Failed to create agora channel: 0000008888
AgoraJniProxySdk destructor begin
AgoraJniProxySdk destructor end

（2）recording_sys.log文件提示如下：
(8596):ERROR (11:54:25:256)|RecordingEngineImpl.cpp:198: Illegal resolution:

备注：使用命令行进行录制视频是成功的。

Reply: 您好，有录制需求建议优先使用[云录制](https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page)

---

# ID: 33542

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: qzssrlzy.com
该域名已经有ICp备案，腾讯云也能正常识别  。  但在推流播流push-agora.qzssrlzy.com 创建就提示我未备案，请加入白名单。 加入到正常识别。谢谢。

添加Nginx证书， pem格式的无法正常上传。
证书 ：无法传pem
key: 上传key文件没有问题

Reply: 您好，可以先配置加速区域为大陆以外地区，然后提供具体的域名、推拉流地址，人工工程师稍后在后台帮您改回来。
以及证书上传失败的话，改用 Apache 格式试试，如果有 2 份 Apache ，传较大的那个就行。

---

# ID: 33558

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.0.1

Request Type: 集成问题咨询

Request Description: 1.是否提供一些内置的均衡器效果，如果提供，可以介绍下现在有哪些效果？
2.关于混响效果，是否有一些调制好的混响效果，如明亮、低沉之类的，这些方法如何调用？
3.是否有一些关于使用场景对音色的优化，比如我是一个交友语聊房，是否有能力提供一系列的音效设置，来提升音色，这里有没有内置的方案？比如配置一系列的混响、音调、声音环绕等

Reply: 您好，SDK 有预设音效，具体实现方式参考 [VoiceEffects](https://github.com/AgoraIO/API-Examples/blob/main/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/VoiceEffects.java)。
不过 SDK 内只能提供基础能力，更高级的音色改变建议集成第三方SDK 来实现。

---
# ID: 33566

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.0

Request Type: 集成问题咨询

Request Description: 实时互动RTC 如何接入画笔功能

Reply: 您好，RTC 本身不自带白板、画笔功能，有此类需求需要单独集成白板 SDK。
如果您需要直接传输实时处理过的画面，可以考虑用[自定义视频数据处理](https://doc.shengwang.cn/doc/rtc/android/advanced-features/video-processing)。

---
# ID: 33569

SDK Product: Fastboard

SDK Platform: Android

SDK Version: 1.6.2

Request Type: 集成问题咨询

Request Description: Fastboard播放音视频时，播放器内的音量调节，不能改变播放器的音量大小。只能静音和有声音两个效果。调整大小没有生效。

Reply: 您好，音量键控制的音量不一定是媒体音量，也可能是通话音量。
在 Android 中，默认情况下，音量键的行为可能因当前焦点不同而变化。
```java
class MainActivity : AppCompatActivity() {
override fun onCreate(savedInstanceState: Bundle?){ 
super.onCreate(savedInstanceState) setContentView(R.layout.activity_main) 

// 确保音量键控制的是媒体音量 
volumeControlStream = AudioManager.STREAM_MUSIC 
}
}
```


---
# ID: 33574

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.0

Request Type: 集成问题咨询

Request Description: 请问在什么情况下能监听到远端用户加入频道，能触发user-published，但是client.subscribe()这个方法监听的时候，sdk报错该用户不在频道

Reply: 您好，可能是创建了多个 client，订阅是使用了不同的 client ，或者您这边是 vue 吗？是的话需要避免双向绑定的情况发生。

---

# ID: 32350

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 极速直播在非大陆地区无法推流出去，结束录制视频时返回 435 错误码没有视频流信息

Reply: 435错误码原因：
该错误码表示频道内无有效推流内容可上传（参考[云录制错误码](https://doc.shengwang.cn/doc/cloud-recording/restful/response-code)435说明）。
结束录制时触发此错误，说明录制服务未检测到视频流数据，可能由推流未成功引起。
麻烦提供出现问题的频道号、uid、时间点，以及相关发送端SDK 日志

---
# ID: 32367

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.2.6

Request Type: 线上报错

Request Description: 
```log
Unable to find an entry point named 'CreateIrisRtcRendering' in 'AgoraRtcWrapper'. Tried the following entry points: Unable to get function 'CreateIrisRtcRendering' because of 'The requested function was not found (0x06000001) dlerror() = undefined symbol: CreateIrisRtcRendering this: Boolean bUseSpacePenMode = HotFix_Project.VoiceController, Boolean bEnableAINSMode = null, Local Variables: RtcEngineContext context = null, RtcEngineEventHandler evhandle = null at HotFix_Project.AgoraVoiceAdapter.CreateVoiceEngine() at HotFix_Project.VoiceAdapterBase.OnEventInitVoice(VRVoiceInitConfig vrconf) at HotFix_Project.VoiceController/<>c.<RegisterEvent>b__10_1(com.ootii.Messages.IMessage msg) System.EntryPointNotFoundException: Unable to find an entry point named 'CreateIrisRtcRendering' in 'AgoraRtcWrapper'. Tried the following entry points: Unable to get function 'CreateIrisRtcRendering' because of 'The requested function was not found (0x06000001) dlerror() = undefined symbol: CreateIrisRtcRendering at Agora.Rtc.AgoraRtcNative.CreateIrisRtcRendering (System.IntPtr iris_api_engine_handle) [0x00000] in <00000000000000000000000000000000>:0 at Agora.Rtc.RtcEngineImpl..ctor (System.IntPtr nativePtr) [0x00000] in <00000000000000000000000000000000>:0 at Agora.Rtc.RtcEngineImpl.GetInstance (System.IntPtr nativePtr) [0x00000] in <00000000000000000000000000000000>:0 at Agora.Rtc.RtcEngine..ctor (System.IntPtr nativePtr) [0x00000] in <00000000000000000000000000000000>:0 at Agora.Rtc.RtcEngine.CreateAgoraRtcEngineEx () [0x00000] in <00000000000000000000000000000000>:0
```

Reply: 建议engine全局单例使用；参考demo 测试能否复现；提供sdk log我们看下当前调用逻辑

---

# ID: 32679

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.2.1

Request Type: 集成问题咨询

Request Description: 在实际测试过程中，我调用publish方法发送一个消息给另一个用户的时候，在监听方法中的RtmEventListener下的onMessageEvent会重复上次的消息，比如第一次发送了一条消息“在吗？”，第二次发送了消息“吃了吗？”在第二次监听的时候，他会通知也接收到第一次的消息内容，请问下你们有Api提供去重的方法吗？

Reply: 您好，正常消息回调是不会出现重复的情况；需要您这边发下集成代码，我们先看下；另外建议看下是否注册了多个eventLinster。

---
# ID: 32684

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 同时添加`io.agora.rtc:chat-sdk:1.1.0`和环信的`io.hyphenate:hyphenate-chat:4.10.1`两个依赖，会出现冲突`Caused by: Cause 1: java.util.concurrent.ExecutionException: java.lang.RuntimeException: java.lang.RuntimeException: Duplicate class internal.com.getkeepsafe.relinker.ApkLibraryInstaller found in modules jetified-chat-sdk-1.1.0-runtime.jar (io.agora.rtc:chat-sdk:1.1.0) and jetified-hyphenate-chat-4.10.1-runtime.jar (io.hyphenate:hyphenate-chat:4.10.1)。`使用排除也是无法解决问题，所以求助一下

Reply: 您好，chatsdk 本身是包含rtc 和环信im的，主要是用于出海客户使用的，计费单价是偏高的；如果咱们得是国内场景，建议咱们单独集成声网SDK 和环信IM。
[下载](https://doc.shengwang.cn/doc/rtc/android/resources)

---

# ID: 32696

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.1

Request Type: 集成问题咨询

Request Description: 如何将一个rtsp/rtmp流发布到服务器中

Reply: 您好，针对rtsp协议的流，您可以通过客户端的媒体播放器来实现，参考文档如下：
[媒体播放器](https://doc.shengwang.cn/doc/rtc/android/advanced-features/media-player#%E6%94%AF%E6%8C%81%E7%9A%84%E6%A0%BC%E5%BC%8F)

rtmp、rtmps的流的您可以通过云端播放器拉流来实现，参考文档如下：
[服务概述](https://doc.shengwang.cn/doc/media-pull/restful/overview/product-overview)

---

# ID: 32715

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 其他问题

Request Description: ios视频通话图像不显示可能是哪些原因

Reply: 您好，ios端视频通话黑屏可能是摄像头异常，或者是摄像头被其他app占用；建议您通过`onlocalvideostatechange`回调监听视频采集状态
[视频基础功能](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_basic#callback_irtcengineeventhandler_onlocalvideostatechanged)
另外您也可以提供以下信息，我们进一步排查定位：
频道号、发生时间点、用户UID
SDK完整日志，[AgoraLogConfig](https://doc.shengwang.cn/api-ref/rtc/ios/API/class_logconfig)

---
# ID: 32733

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.1

Request Type: 其他问题

Request Description: 现在用的webtrc  渲染的视频不是透明的 

想通过获取yuv格式使用第三方库来去除背景
第三方库是 https://github.com/bvibber/yuv-canvas 

请问怎么获取yuv格式的数据

Reply: 您好，web端提供了获取本地和远端视频的裸数据接口，参考如下：
本地：
[Interface ILocalVideoTrack](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/ilocalvideotrack#getCurrentFrameData)
远端：
[Interface IRemoteVideoTrack](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iremotevideotrack#getCurrentFrameData)

---
# ID: 32737

SDK Product: Console

SDK Platform: All

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 你好，我们公司之前对接了贵司的1v1视频通话sdk。后对接人员离职，现在我们有新业务需要进行拓展，即在视频通话结束后，需要获取到视频通话中的语音文本或音频文件，请问贵司产品是否支持最终获取语音文本或者音频文件，又获取实时获取音频流的类似功能呢？感谢

Reply: 您好，音频录制是有两种方式的：
1、客户端音频录制，录制文件存在客户端本地：参考[音视频录制](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_recording#startAudioRecording%20[1/2])
2、云端录制，录制文件存在第三方OSS：参考[实现单流转码录制](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guides/individual-mode/set-individual)
对于实时获取音频流，声网侧提供音频裸数据接口，您这边注册接口后即可，参考：
[原始音频数据](https://doc.shengwang.cn/doc/rtc/android/advanced-features/raw-audio-data)

---
# ID: 32739

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.1

Request Type: 集成问题咨询

Request Description: web端如何自渲染

Reply: 您好，web端实现自渲染，声网这边提供了获取远端videotrack的视频裸数据接口，您再拿到后可以自行处理
[Interface IRemoteVideoTrack](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iremotevideotrack#getCurrentFrameData)

---
# ID: 32747

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 1.按照文档运行RTSA SDK v1.9.2 demo报错`[2024-11-04 15:12:18.036][ERR] Failed to join channel "demo_channel", reason: RTC_ERR_INVALID_AUDIO_CODEC_PARAM`
2.查看日志：`[2024-11-04 14:42:13.039][err][api][agora_rtc_join_channel:2719] check audio codec option failed! codec=1 sample_rate=16000 channel_num=1 duration=20`
3.运行参数未修改 只修改了app_id,token,channel

Reply: 您好，rtsa 和web互通，web 音频编码默认使用opus，采样率为48k，但是您这里rtsa 加入时指定的采样率16k，需要修改为48k，参考[与 RTC SDK 互通音视频数据](https://doc.shengwang.cn/doc/rtsa/c/best-practices/interoperate-rtc)

---
# ID: 32770

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: sdk案例BasicVideoCallScene场景，修改AdjustVideoEncodedConfiguration480()方法调整摄像头画面尺寸不符合预期

Reply: 您好，声网sdk是没有AdjustVideoEncodedConfiguration480()这个方法的，麻烦您这边发下您这边参考的示例github链接；
建议参考我们官网的UNITY API-EXAMPLE 的：
[API-EXAMPLE](https://github.com/AgoraIO-Extensions/Agora-Unity-Quickstart/tree/main/API-Example-Unity)
最后也麻烦您提供下声网的频道号、用户UID等信息，我们也确认下sdk侧的编码分辨率。

---
# ID: 32774

SDK Product: RTC

SDK Platform: Windows

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我使用qtCreator 开发 推流（只有视频）的功能，在加入通道，并且离开通道后，一直有一个日志（声网SDK）打印，麻烦帮我看下 报错的日志是什么导致的。日志在附件中：
`ERROR   14:16:29:963 189976; [rs] no remote server!!!`

Reply: 您好，[rs] no remote server 错误可以忽略，不影响咱们得sdk正常使用；

---
# ID: 32777

SDK Product: Media-push

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 线上报错

Request Description: 设置为不转吗旁路推流后，观看端只有声音，没有视频

Reply: 您好，针对观众端没有视频画面的问题，需要您确认是单用户问题，还是所有的用户都出现了黑屏问题；
针对单用户建议您先检查下用户的网络环境是否正常；
如果是所有用户都出现了黑屏，麻烦您这边提供下声网频道号、黑屏时间点、主播UID，我们排查下推流状态

---

# ID: 33130

SDK Product: RTC-Linux

SDK Platform: Linux-Python

SDK Version: 2.1.0

Request Type: 崩溃（闪退、卡死）

Request Description: 当android端app正在接收并播放后端（Linux的Agora-Python-Server-SDK）发的音频流，此时说话发送语音，会出现两种情况：
1、持续不到1分钟，直接导致后端进程被杀掉，没有看到sdk的异常打印。
2、android（播放时，此时说话）出现播放的声音断断续续。

Reply: 请参考我们的示例代码看一下能否解决崩溃的问题[跑通示例项目](https://doc.shengwang.cn/doc/rtc-server-sdk/python/get-started/run-example)

---
# ID: 33131

SDK Product: RTC-Linux

SDK Platform: Linux-Python

SDK Version: 2.1.0

Request Type: 效果不佳、不达预期

Request Description: 当android端正在接收后端的（Linux的Agora-Python-Server-SDK）播放时，此时在android端说话，当后端收到此android的数据，很快并处理后，调用audio_track.clear_sender_buffer()，发现并没有起到打断的效果。请问打断怎么实现的？

Reply: 打断效果直接调用unsubscribe就可以[停止订阅所有远端用户](https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/localuser#unsubscribeallvideo)
如果仍有问题可以提供sdklog方便我们进一步调查

---
# ID: 33139

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 公司自己搭了个声网的服务，但是在Android 客户端没看到设置服务器地址的方法。麻烦提供下设置方式

Reply: 该场景实现需要私有化部署，请联系您的专属商务经理 或者 电话咨询400 6326626

---

# ID: 33507

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: rtmp旁路转推后flv流无法播放
```json
{'converter': {'name': '1581F6Q8D249T00G22S8_horizontal', 'rawOptions': {'rtcChannel': '1581F6Q8D249T00G22S8', 'rtcStreamUid': 417417}, 'rtmpUrl': 'xxx', 'idleTimeout': 120}}
{"converter":{"id":"xxx","createTs":1735175274,"updateTs":1735175274,"state":"running"},"fields":"id,createTs,updateTs,state"}
```
播放地址：xxx

Reply: 您好，可以依次检查下当前 appid 是否开启了旁路推流功能开关、推流地址的可用状态确认、切换转码对比看下效果、检查播放器是否正常
如果还未解决，可以提供下具体的ConverterID 和出现问题的时间点，人工工程师稍后跟进处理

---
# ID: 33525

SDK Product: RTM

SDK Platform: Java

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 使用的事灵动会议，代码，后台配置都集成好的 测试的时候报如下错误：
```log
[AgoraEvent] ERROR AgoraRtmClient$login$1.onFailure 113:[AgoraRtmClient]domain:RTM, info:[API Call][message:rtm login fail:Login RTM service was rejected due to server error.]
2024-12-27 10:30:33.408 20333-20881 FcrCore                 com.liantong.othertest               E  [AgoraEvent] ERROR FcrUISceneBaseActivity$createEngine$1.onFailure 101:[FcrUISceneActivity]login rtm error:Login RTM service was rejected due to server error. || -10012
```

Reply: 您好，10012 SDK 被服务器拒绝登录，请尝试检查 App ID 是否开通 RTM 服务，检查 Token 或 userId 是否被封禁。以及如果您是用的普通 appid 开启了灵动课堂项目，我们建议重新创建一个灵动课堂专属 appid 来使用。
如果以上情况都不符合，麻烦提供具体 appid，人工工程师稍后跟进处理。

---
# ID: 33561

SDK Product: RTC-Linux

SDK Platform: Linux-C

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 1.sdk内仅有动态库，需要一个静态库加到主板（Linux）代码内
2.芯片型号：SSD202
3.cpu架构：ARM Cortex-A7
4.操作系统及版本	Linux
5.内存大小	128M
6.编译工具链C库类型	glibc8.2.1
7.视频编码格式	H.264
8.视频分辨率	1280*720*20
9.不支持硬浮点	


Reply: 您好，请问当前在运行哪个版本的 SDK？运行 SDK 内自带的 Demo，音视频效果都是否正常？单独出包需要内部申请，请先确认下目前运行 Demo 的情况，稍后人工工程师会跟进

---
# ID: 33565

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 想问一下
获取指定项目用量的api目前查询不到了,请问这个api是否已经废弃,因为之前代码里面用到了,后续还要对这个接口进行使用

Reply: 您好，目前没有对外开放的查询项目用量接口了，有[查看用量](https://doc.shengwang.cn/doc/console/general/user-guides/usage)需求请以控制台展示的为准

---

# ID: 37889

SDK Product: RTC-Linux

SDK Platform: Linux-C

SDK Version: 其他版本

Request Type: 线上报错

Request Description: linux服务端会报错：
```log
[SessionID: d5ce43************************029c07 RoomID: OCIC_d5ce4382-110f-40fb-8658-72e7ae029c07 UserID: 101] onConnectionFailure: id 24499, channelId OCIC_d5ce4382-110f-40fb-8658-72e7ae029c07, localUserId 101, reason 9
```

Reply: 您好，onConnectionFailure reason 9 的原因是 token 错误，可以参考文档 [CONNECTION_CHANGED_REASON_TYPE](https://doc.shengwang.cn/api-ref/rtc-server-sdk/cpp/namespaceagora_1_1rtc#a329573b5363b2065b4069e5bf6013144)

以及如果您这边用的是 006 开头的 token，建议换新版本的，clone 我们的仓库，用新的脚本生成 007 开头的 token，这样还可以用控制台的自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验
将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致，临时 token 不校验 uid 所以能进频道，自己生成的 token 是要校验 uid 的，需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道

参考：[生成 token](https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication#token-code)

---

# ID: 37902

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 想咨询如果想要实现AI 一对一对话。AI的输出音色只能通过固定的几个TTS厂商来定制吗？（web playground中的那几个）如果我们通过其他形式提取到了声纹，可以通过一些方式传输给模型来作为语音输出的音色吗？

Reply: 您好，目前 convoAI 只支持我们提供的几个 tts 厂商，不支持自定义 tts 或其他不在[创建对话式智能体](https://doc.shengwang.cn/doc/convoai/restful/convoai/operations/start-agent)文档中提到的厂商。
如果有 tts 特调参数，可以在 tts 的 `params` 字段里传参来实现。

---

# ID: 37905

SDK Product: RTC-Linux

SDK Platform: Linux-Java

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: RTC服务端SDK的Java API中，通过io.agora.rtc.IVideoEncodedFrameObserver.onEncodedVideoFrame()得到了EncodedVideoFrameInfo，但其中的captureTimeMs视频采集时间戳、decodeTimeMs视频渲染时间戳一直是0，这是怎么回事？用户希望通过这两个时间戳得到详细的帧延迟。

JAVA服务端SDK版本是4.4.32.101（最新版），已设置setEncodedFrameOnly(0)。Web JS客户端SDK版本是4.24.0，编码器用的是vp8。是否因为客户端SDK版本没跟上？另外，客户端是默认创建的视频轨道，会自动记录采集时间戳吗，还是只有自定义采集的视频可以写入时间戳呢？感谢

附件中是服务端SDK的日志文件，复现了此问题。

Reply: 您好，因为 4.4.32.101 这个版本的服务端本地录制 SDK 目前还没有启用这两个字段，目前只有一个工程板可以体验到，如果有需要的话可以留言，稍后人工工程师为您提供地址和接口文档。

---

# ID: 37625

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: rtc房间启动后，服务端通过api发起云端录制功能。该api耗时超10s。而且大面积出现；

Reply: 您好，耗时和请求发起的位置与被请求的域名相关，请参考我们的[最佳实践](https://doc.shengwang.cn/doc/cloud-recording/restful/best-practices/rest-availability)，在对应的区域使用对应区域的域名去请求，不然跨域容易出现耗时长和请求失败的问题。
如果您确定请求地区是匹配的，可以提供具体的sid，我们看下后台响应的情况。

---

# ID: 32354

SDK Product: Cloud-transcoder

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 开通权限、提供配额

Request Description: 需要开通云端转码服务

Reply: 提供 AppID由人工工程师处理开通，无法自助开通

---
# ID: 32355

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 1、我在采集窗口分享的时候，希望最终的视频保持在1280720 这个分辨率，但是窗口的大小是随机的，所以我希望是自适应宽高完全铺满1280 720这个大小，可以接受画面变形，但是不能截取或者有黑边。请问应该怎么设置？
2、分享的窗口可能会在分享的过程中，变换窗口大小，这个需要重新设置caption screen的参数吗？

Reply: 1.  SDK 不支持拉伸的渲染方式，只有RENDER_MODE_HIDDEN（视频尺寸等比缩放。优先保证视窗被填满。因视频尺寸与显示视窗尺寸不一致而多出的视频将被截掉）或者 RENDER_MODE_FIT（视频尺寸等比缩放。优先保证视频内容全部显示。因视频尺寸与显示视窗尺寸不一致造成的视窗未被填满的区域填充黑色）。如果你需要拉伸，可以考虑自渲染；
2.  无需改变，SDK 会自动处理

---
# ID: 32358

SDK Product: Media-push

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 开通权限、提供配额

Request Description: 你好，我们的项目正打算接入声网，场景是需要将频道内的所有人员的混流音频推流到CDN平台，只有音频，不用视频。一般情况下，混流人数不会超过3，但特殊情况会到5人，甚至更多，想调研请问以下两个问题
1）原频道人数为3，开启多个推流任务到不同的CDN平台，是否可以？
2）若提升混流人数最大配额，是否可以快速提升，最大可以提升到多少

Reply: 请提供appid，并描述业务场景我们后台配置开通

---
# ID: 32373

SDK Product: RTM

SDK Platform: Java

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我们iOS端升级到最新版本了 ，需要使用到 RtmTokenBuilder2  RtcTokenBuilder2  
之前引入的依赖为       
 <dependency>
                <groupId>io.agora</groupId>
                <artifactId>authentication</artifactId>
                <version>1.6.1</version>
  </dependency>
现在需要升级到最新匹配的版本是多少

Reply: maven 已经不更新这个版本了，请用[TokenBuilder2](https://github.com/AgoraIO/Tools/tree/master/DynamicKey/AgoraDynamicKey/java/src/main/java/io/agora/sample)，把生成器代码放到服务端运行就行

---

# ID: 32376

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.3.2

Request Type: 效果不佳、不达预期

Request Description: 视频转码异常，
只有m3u8格式的，没有mp4的

Reply: 如果是单例问题，有可能是转码生成的MP4文件上传失败了，需要提供云端录制SID排查

---
# ID: 32378

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.19.0

Request Type: 集成问题咨询

Request Description: 频道：
 7CTDM1600B6US2
appid:
xxx

请问这段时间内你们那边能看到有uid=40000的用户以主播的身份加入到这个频道嘛？
1、通过大疆api发送的指令推流，uid=40000，大疆api反馈推流成功.
2、在web端用uid=10000以观众身份拉流
3、我从水晶球上看到只有uid=10000用户的记录，40000用户根本推流
4、请问你们那边能看到40000用户是否有过推流的记录，成功或失败？

Reply: 根据时间点、频道号，可以在 声网 console 左侧边栏-全部产品-水晶球 上查看对应UID的在线情况和推流情况

---
# ID: 32671

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.2.0

Request Type: 其他问题

Request Description: 苹果手机使用WeChat进入视频，出现滋滋滋电流声音

Reply: 您好，如果您使用wechat通话有杂音，说明是音频设备本身出现了问题，建议您检查下；该问题和声网侧无关

---
# ID: 32672

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.0.0

Request Type: 效果不佳、不达预期

Request Description: 1.首先我们的项目已经集成的声网一对一音视频聊天
2.问题：用户APP杀掉后就收到离线消息了，
3.有没有对应的呼叫唤醒产品，或者解决方案， 环信的推送只能走离线推送，还得对接厂商，厂商还不能自定义铃声，
 诉求：看能不能有个呼叫唤醒功能， （A给B打语音， B不在线，也能收到语音铃声提醒）

Reply: 您好，RTM SDK 只能在应用正常运行时实现呼叫邀请通知功能，集成原生呼叫 API 可以保证当应用进程处于后台或者被关闭时，用户仍可以收到呼叫邀请通知，例如 Android 平台的 ConnectionService、iOS 平台的 CallKit、Flutter 和 React Native 平台的 CallKeep
[如何在通话应用中实现呼叫邀请通知功能？](https://docportal.shengwang.cn/cn/Real-time-Messaging/faq/call_invite_notification?platform=Android)


---
# ID: 32677

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 在H5进行音视频通讯时，如何做到过程中来电之后，接完电话自动再获取摄像头继续音视频通讯，现在是会黑屏

Reply: 您好，H5的兼容性本身依赖于系统的webview能力支持；需要确认下这个现象是否是必现的；参考文档
[浏览器兼容性和已知问题](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility#%E7%A7%BB%E5%8A%A8%E7%AB%AF)

---
# ID: 32680

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.2.1

Request Type: 集成问题咨询

Request Description: 请问下如果用户A调用publish方法发送一个User类型的消息给用户B，如果用户B当时不在线，会发送失败，那么我想咨询一下，你们可以实现用户之间一对一发送User类型的消息的时候可以让对方不在线也能发送成功吗？等用户B上线后会接收到这条信息，请问有实现案例吗？或者推荐使用的api或者方式


Reply: 您好，rtmsdk2.2.2版本开始支持历史消息；该版本在 PublishOptions 中新增了 storeInHistory 属性，支持在频道中发送消息的同时，将消息存储到云端，后续用户可以通过历史消息接口获取；参考文档如下：
[历史消息 (Beta)](https://doc.shengwang.cn/doc/rtm2/android/user-guide/message/history-message)

---
# ID: 32688

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: oc版本的SDK在哪里下载

Reply: 您好，声网的IOS sdk是没有oc的；这边发一下OC的demo，您可以参考下
[API-EXAMPLE](https://github.com/Shengwang-Community/API-Examples/tree/main/iOS/APIExample-OC)

---

# ID: 32709

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.0.0

Request Type: 其他问题

Request Description: 目前我们的这个应用没有开通证书模式的模但是已正式使用了
现在我们想使用去端录制功能,需要开通证书模式 
问题是 如果开通会不会影响 之前包视频通话功能

Reply: 您好，项目开通证书安全模式，是需要传入token的，会影响到你现在的通话；token部署参考如下：
[使用 Token 鉴权](https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication)

---

# ID: 32711

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 2.5.4

Request Type: 集成问题咨询

Request Description: 小程序里是否可以像web里这样去获取 uid

Reply: 您好，小程序sdk并不支持获取用户uid。

---
# ID: 32714

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.1

Request Type: 集成问题咨询

Request Description: 项目中需要使用RTM、RTC的屏幕共享两个服务，gradle 远程依赖的方式添加哪几个库的依赖能最大程度的减少库的体积

Reply: 您好，推荐您使用rtc-basic 和rtm-lite sdk 以及对应的屏幕共享库
rtc引入如下：
`implementation 'io.agora.rtc:agora-special-full:4.5.2.3.BASIC'`
rtm引入如下：
 `implementation 'io.agora:agora-rtm-lite:2.2.5'`
屏幕共享插件引入如下：
`implementation 'io.agora.rtc:agora-screensharing:x.y.z'`

---
# ID: 32720

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.0.0

Request Type: 效果不佳、不达预期

Request Description: 视频被叫页面中，要显示本地摄像头的画面。
但是要做一下判断，如果已经获取到了相机和麦克风权限，则初始化rtc。
如果还没有获取到相机和麦克风权限，则使用XXPermission获取权限，授权完成后返回页面，然后再初始化rtc。

但是这样处理并不完美，我发现如果这样判断已经获取到了相机和麦克风权限，直接初始化rtc。画面并没有显示，而是黑屏。

请问是逻辑有问题么？

Reply: 您好，您在初始化RtcEngine后仍需调用 enableLocalVideo(true)、setupLocalVideo() 和 startPreview() 才能显示本地画面；
如果还有问题，麻烦提供下黑屏时间点的频道号、uid以及对应的声网sdk日志，我们分析下
[LogConfig](https://doc.shengwang.cn/api-ref/rtc/android/API/class_logconfig#filePath)

---
# ID: 32726

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.4.0

Request Type: 其他问题

Request Description: 我在Unity中开始视频渲染后发现视频有被挤压的状态(接收的image是竖屏，所以画面看起来是横屏被挤压成竖屏的样子)，我询问ai助手它让我改变分辨率和RenderMode，但我将分辨率改为180138后并没有发生改变，请问这块功能在声网中有API提供吗？以下是使用AI助手的代码，并没作用

Reply: 您好，视频旋转方向，需要关注采集端和播放端的行为，您可以参考以下文档类调整编码策略：
[设置视频编码属性](https://doc.shengwang.cn/doc/rtc/android/basic-features/video-profile#%E8%A7%86%E9%A2%91%E6%A8%A1%E5%BC%8F)

---
# ID: 32734

SDK Product: SDK-extension

SDK Platform: iOS

SDK Version: Metakit

Request Type: 集成问题咨询

Request Description: 有没有OC版本media::base::AudioPcmFrame转成AVAudioPCMBuffer 的Demo ，我转换的pcm有很大噪音，

Reply: 您好，可以参考我们的OC的音频原始数据demo，本身我们的裸数据接口返回的就是buffer
[API-EXAMPLE](https://github.com/Shengwang-Community/API-Examples/blob/main/iOS/APIExample-OC/APIExample-OC/Examples/Advanced/RawAudioData/RawAudioData.m)

---
# ID: 32740

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.0

Request Type: 效果不佳、不达预期

Request Description: 有两个品类的Android设备端，一个是音箱，一个是带话柄的话机，话机这边说话者的音频传到音箱端，音箱端外放出话机的音频，但外放的声音又被音箱的麦克风采集到了，就造成了话机侧听到了自己的回声，这种问题有什么办法可以优化不。

Reply: 您好，通过您的描述来看，比较像是两个设备离得很近产生了近场回声，建议您将两个设备隔开在测试看下。

---
# ID: 32750

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 我们这边是小游戏的研发使用的引擎是Unity，目前有个需求是各种平台能够加入同一个语音房间聊天，目前平台微信小游戏、抖音小游戏、安卓、IOS、H5。请问下使用当前的技术能够实现需求吗？能实现的话是直接下载Unity的Package开始还是需要别的操作？有无直接可以使用的Demo？

Reply: 您好，声网的unity sdk 当前只支持android、ios、window、macos平台；并不支持微信小游戏、抖音小游戏以及H5；
参考文档如下：
[实现音视频互动](https://doc.shengwang.cn/doc/rtc/unity/get-started/quick-start)
demo示例：
[跑通 API 示例项目](https://doc.shengwang.cn/doc/rtc/unity/get-started/run-demo)


---
# ID: 32753

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.1

Request Type: 效果不佳、不达预期

Request Description: 屏幕共享时，应用内的页面会出现画中画中画 等无限嵌套的页面情况，见附件，你们的demo也有这个问题

Reply: 您好，开启屏幕共享的同时又预览采集到的画面，就会被再次采集然后出现这种无限嵌套的场景；这个是符合预期的，想要规避的话可以再加入频道时设置不订阅远端的画面。

---
# ID: 32757

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.19.0

Request Type: 集成问题咨询

Request Description: 你好 项目需要看到直播的实时延迟ms数据 但是从文档中 getRemoteVideoStats 拿到的都是0延迟 但是有时候就是很卡 有其他实现的方法吗

Reply: 您好，直播中很卡很可能是观众端下行网络不好引发的，主播侧的数据很可能是正常的，getRemoteVideoStats 接口是只能判断主播侧是否正常；针对观众端，建议您这边在观众端监听on("network-quality")，当观众端网络不好时提示观众切换网络

---

# ID: 33120

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.2

Request Type: 其他问题

Request Description: 客户端加入声望频道后,封装的sdk会自动播放远端的视频流,我想知道作为客户端,能否获取远端的视频流对象,我需要对视频流进行抽帧截图等等操作

Reply: 可以通过getCurrentFrameData接口[获取当前渲染的视频帧数据](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iremotevideotrack#getCurrentFrameData)

---

# ID: 33138

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.0

Request Type: 集成问题咨询

Request Description: 想咨询一下关于web端的rtc sdk在纯血鸿蒙内置的浏览器是否能够支持

Reply: 暂时不支持。请参考[浏览器兼容性和已知问题](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility#%E7%A7%BB%E5%8A%A8%E7%AB%AF)

---
# ID: 33143

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 集成问题咨询

Request Description: 我想问一下灵动课堂的录制流程是什么样子的，文档中只告诉我了“设置录制状态”，没有看到需要设置储存位置的参数，我看到“最佳实践”的“录制基本流程”中有说到“客户端通知灵动课堂服务端录制开启”这个应该是通知了你们，如果是让你们服务器进行录制，录制成功后文件上传到哪里了？我希望告诉我一下完整的录制流程，第一步干什么，第二部干什么，谢谢

Reply: 灵动课堂的录制需要先自行在控制台指定录制地址[灵动课堂-配置录制功能](https://doc.shengwang.cn/doc/flexible-classroom/android/get-started/configure#%E9%85%8D%E7%BD%AE%E5%BD%95%E5%88%B6%E5%8A%9F%E8%83%BD)  客户端点击录制按钮之后开启录制，录制下来的文件会存储在开发者配置的路径下

---
# ID: 33146

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.2.6

Request Type: 其他问题

Request Description: 应用放置在后台，如果弹出视频提醒？

Reply: Android系统在后台可能回收资源，导致视频中断。需先实现[后台保活](https://doc.shengwang.cn/faq/quality-issues/android-background)，确保SDK持续运行。
保活后，通过系统级通知（如Notification）弹出视频提醒，需业务层自主实现（SDK不直接提供弹窗功能）。

---
# ID: 33158

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.22.2

Request Type: 集成问题咨询

Request Description: 在WebSDK集成中，如何禁用本地的麦克风？但要求声音播放正常。

Reply: 1. 创建本地音频轨道后可以调用setMuted：true暂停发送该轨道的媒体数据
[setMuted(muted: boolean)](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/ilocalaudiotrack#setMuted)
2. 创建本地音频轨道后可以调用setVolume设置本地音频轨道的音量
[setVolume(volume: number)](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/ilocalaudiotrack#setVolume)


---
# ID: 33159

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.1

Request Type: 其他问题

Request Description: 每月免费通话分钟刷新了还是用不了

Reply: 对于未主动购买套餐包的用户，声网会给予每个声网开发者账号每个月一万分钟的免费时长。订购任意套餐包后，将不再享受[一万分钟免费时长](https://doc.shengwang.cn/faq/account-and-billing/billing-free)
如果实际使用分钟数未超过 10000 分钟，则本月免费；如果 10000 分钟的免费额度扣完，则对剩余的分钟数扣取相应服务费用。
如仍有疑问请联系您的专属商务或者拨打400 6326626



---
# ID: 33169

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 其他问题

Request Description: uid 294833052
uid 294834050

双方语音通话时，在该时间段频繁断线，每次通话不足2分钟，请协助排查一下是什么原因。

附件是双方sdk log。
期间后端收到了声网108回调事件。

Reply: eventType 为 108 表示通信场景下用户离开频道,排查建议：查看108事件中返回的reason确认离开频道的原因 [108 user leave channel with communication mode](https://doc.shengwang.cn/doc/rtc/restful/webhook/events#108-user-leave-channel-with-communication-mode)

---
# ID: 33175

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 通过demo的流程，进入直播间出现画面太慢了，有没方法可以加快进入直播画面

Reply: 
1. 提前加入频道并订阅流
在用户点击直播间入口时，提前调用 `joinChannelEx` 加入频道并订阅主播音视频流（音频设为静音），使用通配 Token 加速加入过程。
2. 预创建视频视图
订阅视频流后立即调用 `setupRemoteVideoEx` 创建视图，避免错过首个视频 I 帧解码，确保首帧快速渲染。

---
# ID: 33177

SDK Product: RTM

SDK Platform: C++

SDK Version: 2.2.2

Request Type: 集成问题咨询

Request Description: 当前C++版本是否支持arm linux？
我们当前客户端是arm版本的linux，所以想看下是否可以集成。

Reply: 支持。目前是内部版本需要等候工程师稍后处理提供。若需其他特殊架构支持（如 arm32），需联系 sales@shengwang.cn 定制化解决。

---
# ID: 33488

SDK Product: RTC-Linux

SDK Platform: Linux-Java

SDK Version: 4.4.30

Request Type: 线上报错

Request Description: 这个方法写的.h264视频，用播放器播放不了，是什么原因？还需要怎么操作才可以播放吗？

Reply: 您好，如果保存到本地的 h264 文件无法正常播放可以检查下频道里原始发来的流是否能够被正常收看，如果本身就无法收看，说明一开始发送端发出来的编码画面就是有问题的，保存下来自然无法观看。

---
# ID: 33491

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 主要是java及前端 代码集成问题，目前卡在了获取不到永久的声网token，需要找到在哪里可以获取？

Reply: 您好，声网没有永久 token 这一说，每个 token 有效期最大 24 小时。如果你们不需要 token 鉴权，可以考虑使用一个不带主要证书的 appid（在 console 新建项目时可以选择不开启鉴权）
如果需要用鉴权，那就需要参考下方文档去自行生成 token，每次 token 即将过期时客户端 SDK 会有回调提示，重新生成一个 token 用 `renew` 方法传进去就行。
[token 生成](https://doc.shengwang.cn/doc/rtc/javascript/basic-features/token-authentication)
[token 过期回调](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iagorartcclient#token-privilege-will-expire)

---
# ID: 33492

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 线上报错

Request Description: 配置了 HTTPS 证书，但是未生效。三个月前也是这样，你们这服务靠不靠谱啊？

Reply: 您好，请问现在 console 上给融合 CDN 传的什么证书？用 Apache 格式的试试，有多份就用体积较大的那个证书

---
# ID: 33494

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 提交到appstore上报错

Reply: 您好，请问目前在用什么版本的 SDK？老版本会有 bitcode 问题，需要升级 SDK 到最新版本来解决。

---
# ID: 33496

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 其他版本

Request Type: 开通权限、提供配额

Request Description: 我们现在用个客户想要实现单频道用户10000人，除了我们自己的服务外，声网相关的服务要做什么处理吗

Reply: 您好，声网 RTC 单频道支持最多 128 人同时发流，观众不发流没有上限，这类场景都需要提前报备。
您这边的场景看起来有些不太合理，相当于每个人要收 999 条音视频流，看不过来也听不过来，终端设备渲染的负载也非常大，请问你们这边具体是什么场景需要万人同时发流互通？

---
# ID: 33512

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.5.0

Request Type: 其他问题

Request Description: 我项目中有个推送服务，使用下面的方法，iOS中有的手机就控制不住手机显示选择的录屏App了，有的可以有的不行。你们的demo 我试着增加了一个推送的，一样的问题有解决方案没

Reply: 您好，IOS 屏幕共享时展示的 app 列表没有办法隐藏 app，这个是系统行为控制的，SDK 侧无法操作。

---
# ID: 33516

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.2.6

Request Type: 集成问题咨询

Request Description: 问题：Flutter端能实现秒开秒切效果吗？
如果能实现，有没有demo呢？或者要实现秒开秒切Flutter版本文档在哪？

Reply: 您好，目前秒开秒切功能已经不再更新维护了，这个需求无法直接用我们 SDK 接口实现，您可以考虑自行业务侧组合实现。

---
# ID: 33531

SDK Product: RTM

SDK Platform: Java

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 我们使用此处的文档发送频道消息，发现接口用时在1s作用，感觉这个用时有点长，是因为后面的逻辑比较复杂吗？还是我们的使用有点问题
channelName：xxxx
userId:xxx
出现时间2024-12-15 10:39左右

Reply: 您好，1s 这个连接时长本身就是属于预期内的。一般来说客户端本身的网络上下行质量也会影响这个时长，但 1s 左右的波动范围都是可以接受的，不算质量问题。

---
# ID: 33536

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 线上报错

Request Description: 调用开始录制接口  一直返回code:53   但是我已经不知道之前sid是多少了  怎么结束掉这个录制资源啊

Reply: 您好，53 表示 重复启动，已经存在相同的 cname + uid 的任务。
如果您不记得已经在启动的录制 sid 了，可以用[踢人接口](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/post-dev-v1-kicking-rule)把录制端从频道里踢出去。或者等录制的频道里每人发流了，录制端也会自己退出的。

---
# ID: 33543

SDK Product: RTC

SDK Platform: React Native

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 21:30:23.522 正在编译中...
21:30:28.201 ​../../../Backup/Documents/HBuilderProjects/Agora音视频插件示例/components/Agora-RTC-JS/RtcSurfaceView.nvue (3:2): Error when using sourcemap for reporting an error: Can't resolve original location of error.​
21:30:28.214 ../../../Backup/Documents/HBuilderProjects/Agora音视频插件示例/components/Agora-RTC-JS/RtcSurfaceView.nvue (3:2): "VideoRenderMode" is not exported by "../../../Backup/Documents/HBuilderProjects/Agora音视频插件示例/components/Agora-RTC-JS/common/Enums.js", imported by "../../../Backup/Documents/HBuilderProjects/Agora音视频插件示例/components/Agora-RTC-JS/RtcSurfaceView.nvue".
21:30:28.236 at components/Agora-RTC-JS/RtcSurfaceView.nvue:3:2
21:30:28.245   1: 
21:30:28.259   2:   import {
21:30:28.278   3:     VideoRenderMode,
21:30:28.292          ^
21:30:28.303   4:     VideoMirrorMode
21:30:28.326   5:   } from './common/Enums.js';

Reply: 您好，看起来您在使用 uni-app SDK，我们的uni-app SDK 已经停止更新和维护了，目前只有老版本SDK对外开放，可以先参考文档跑通Demo，或者直接使用目前我们还在支持的平台来开发
[SDK](https://github.com/AgoraIO-Community/Agora-Uniapp-SDK/tree/master)
Demo文档：https://shimo.im/docs/sng09z58Jo4FWtoB/ "副本 uniapp 跑通-REALL"
Access Password axucpk

---
# ID: 33545

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 点击开启融合cdn服务没反应

Reply: 您好，请确认下是否有到console上开启融合CDN服务，浏览器需要开启允许第三方cookie，您可以检查下，如果还是您所说的无反应，麻烦提供一下操作录屏，谢谢。

---
# ID: 33556

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.0.0

Request Type: 集成问题咨询

Request Description:  iOS房间内再使用AVAudioPlayer播放音频 没有声音 是跟声网冲突?
我的音频素材是本地mp3的

Reply: 您好，音频路由会有冲突，如果有播放需求，可以考虑用我们 SDK 自带的[播放器](https://doc.shengwang.cn/doc/rtc/ios/advanced-features/media-player)或者[startaudiomixing](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_audio_mixing#api_irtcengine_startaudiomixing2)。

---
# ID: 33572

SDK Product: IOT-apaas

SDK Platform: All

SDK Version: 1.5.0

Request Type: 集成问题咨询

Request Description: 我们自己开发了基于ESP32S3的硬件，支持音频采集和播放，现在我们需要完成通过自研的小程序实现呼叫设备并实现双向对讲，不知道灵隼物联网平台是否可以实现？另外参考教程，没有完成示例程序的测试，主要是没要找到如何选择开发模板，请指教

Reply: 您好，灵榫平台后期会下架，不推荐新集成了
ESP32 的可以看[下载页面](https://doc.shengwang.cn/doc/rtsa/c/resources)，确认下下的包架构是否对齐，然后再去跑 Demo，看是否能正常运行

---
# ID: 33576

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.2.2

Request Type: 效果不佳、不达预期

Request Description: func call(remoteUserId: UInt, orderId:[String: Any], completion: ((NSError?)->())?)   声网 发起视频邀请时，我把这个方法增加了一个字典扩展参数。但是为什么不起作用。接受方收不到这个扩展参数的内容

Reply: 您好，请使用第二个 call 接口：`func call(remoteUserId: UInt, callType: CallType, callExtension: [String: Any],  completion: ((NSError?)->())?)`
参考文档：[call[2/2]](https://doc.shengwang.cn/doc/one-to-one-live/ios/rtm/api/call-api#call2)

---

# ID: 37862

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.0

Request Type: 效果不佳、不达预期

Request Description: 安卓手机通话超过20分钟之后发烫非常严重，有时候还会造成崩溃，哪些方面可以改善的？

Reply: 您好，请问是音频通话还是视频通话？采集编码配置的分辨率是多少？一般发热就是分辨率和帧率太高了，一直开就会这样，对于低性能设备来说就会引起发热，可以尝试降低分辨率和帧率再试试
您可以用我们 Demo 尝试下，看看 Demo 会不会发热、崩溃，如果还有崩溃问题，可以抓取下原始崩溃堆栈+ SDK 日志发来看下

---

# ID: 37866

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 状态一直显示：配置中，还需要多久可以好？

Reply: 您好，请耐心等待，一般 48 小时内肯定可以完成融合 CDN 的推拉流地址配置，如果您的等待时间超过了 48 小时，可以备注下，人工工程师稍候为您检查。

---
# ID: 37867

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 目前的问题主要是：
- 我们硬件端是一个博通集成的开发板，如果要用AI降噪的插件，有现成适配的SDK嘛？
- 我看现在提供的SDK有安卓、ios、macOS这些。这是不是意味着，AI降噪算法是跑在手机本地的CPU上？如果我们的开发板没有足够算力，是不是我们应该要在云端起一个服务跑降噪算法？这种情况下，应该用哪个SDK呀？

Reply: 您好，
1、您的开发板是什么系统？Android 可以集成 [Android RTC  SDK](https://doc.shengwang.cn/doc/rtc/android/landing-page)
IOT 系统可以集成 [RTSA SDK](https://doc.shengwang.cn/doc/rtsa/c/resources)
2、AI 降噪都是在本地处理的，且只有 Native SDK 可以，RTSA 没有内置 AI 降噪处理，也没有放到云端处理的说法。

---

# ID: 37876

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 当A和B进行1对1语音、1对1视频时，他们A和B等于在一个频道中进行语音和视频聊天。
想实现：
1.当A有视频违规行为时，如何禁止A用户的视频传递到B
2.当A有语音违规行为时，如何禁止A用户的语音传递到B
谢谢！

Reply: 您好，可以搭配第三方审核用[封禁接口](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/post-dev-v1-kicking-rule)控制指定用户的发流权限。

---

# ID: 37879

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 本地环境下拨打视频功能正常，部署到服务器上拨打视频对方没有反应，这个是什么情况？服务器的防火墙时关闭的；

Reply: 您好，我们的服务需要连接公网环境才能使用，有内部防火墙的话会连不上我们节点，可以再检查下整体的网络环境

---

# ID: 37881

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 这里有几个 2025-11-02 16:38 至 2025-11-02 17:50 的视频通话,主播一进入1秒就退出了。
主播ID： xxx
麻烦帮忙确认一下是否是连接策略的问题。

Reply: 您好，uid 退出频道的原因可以在 声网 console 左侧边栏-全部产品-水晶球 内查看，常见的原因是业务上 leave 的业务有问题导致用户直接主动退出频道了。

---

# ID: 37882

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 效果不佳、不达预期

Request Description: 问题描述：主播视频画面是黑的， 这种在个别机型上会出现这种问题
视频画面我们开启了人脸检测、内置美颜，主播视频画面是黑的，亮度调到最大也没用

附件是agora的日志，帮忙看下，是什么原因

Reply: 您好，请问在出现问题时关闭美颜还会有画面过黑的问题吗？可以先关闭美颜试下，以及确认下是不是原始画面就有暗光问题。

---

# ID: 37883

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 效果不佳、不达预期

Request Description: 流量卡开启直播失败，WIFI可以，目前放行了`*.agora.io`, `*.sd-rtn.com`，还有其他需要放行的吗

Reply: 您好，请问目前在用什么版本、平台的 SDK？Native SDK 4.6.0 及以上 的话用的域名不同，要报备不同的域名

4.6.0 及以上区分国内和海外两个版本的 SDK，分别为：

海外版本 SDK ：
`*.rtesvc.com, *.sdrtnsvc.com`
国内版本 SDK：
`*.rtnsvc.com，*.realtimemesh.com`

460 以下版本向运营商报备`*.agora.io, *.sd-rtn.com`两个通配域名（至少需要`*.agora.io`，最好是也加上`*.sd-rtn.com`以满足高可用需求）。如需区域限制功能，需要增加`*.agoraio.cn`这个通配域名。

---

# ID: 37884

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.2.0

Request Type: 集成问题咨询

Request Description: 音视频通话场景，当出现卡顿时，需要提示通话双方 当前网络环境差，并且需要判断当前是哪方的原因导致的，应该基于什么判断呢

Reply: 您好，可以监听 [onNetworkQuality](https://doc.shengwang.cn/api-ref/rtc/flutter/API/toc_network#onNetworkQuality) 回调来获得双方实时通话的网络上下行数据，用来判断双方的通话网络质量。

---

# ID: 37821

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 你好我要在客户端显示rtc套餐的时长，爬虫方式可以获取。但是太麻烦，有api可以查询么？

Reply: 您好，我们没有直接返回剩余时长的接口，最多提供目前已经消耗用量的接口

---

# ID: 37827

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.5.1

Request Type: 其他问题

Request Description: 问题1
背景&现象
1 接入的unity 音频SDK ，产品是发布到iOS手机端的app
2 业务场景中未启动声网engine时，有其他播音频（tts bgm）类业务
3 当启用声网engine完成一轮对话（join & leave channel），结束时我们会dispose 声网的engine
   对话使用的communication的1v1模式
4 这时手机上的其他的播音频（tts bgm）的业务，放音出现异常
   在没有手动调整手机自身音量的情况下，明显放音变弱了，即音频系统dispose没有正确被恢复
   即在#2阶段原本能清晰听到的bgm，在#4阶段已经音量小到快听不见了

根据综合收集的信息，初步判断是：声网引擎启动后，切换过通话模式，而dispose时模式未实际回退；导致后续再播放音频的时候，依旧认为自己还是在通话模式的状态，而不是媒体状态
希望知道这个问题是不是一种已知问题。

问题2
当启用声网engine完成一轮对话（join & leave channel），如果用的不是communication，而是在线直播的的多人模式时，
将进入房间的两个人都setClientRole为广播者，这时的2个用户收音状态在手机端表现异常：90%+的时间里说话无法被收音，且在不触碰改变mic收音类的按键前提下，过10s后又会有1秒多收音状态（iphone手机证明录音的提示点会变成黄点），如此交替往复。


Reply: 您好 ，
1、请避免使用`communication`模式，改用 live 再试下，`communication` 会强制走通话音量
2、请问用我们 Demo 能复现吗？这个现象听起来是业务问题，建议加一些打印先自行排查下，如果无果，再提供 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)、现象录像过来，我们再看下情况。

---

# ID: 37834

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 声网RTC播放本地或远端MP4支持带alpha通道的礼物特效吗？最多可以同时解析并显示多少个mp4，有视频帧数据的解析回调吗


Reply: 您好，本地渲染支持，但是SDK 自带的播放器不支持解码 alpha 透明特效
同时打开的 mp4 资源没有上限
播放视频没有解析回调这一说，只有播放状态变更的回调 [onPlayerStateChanged](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_mediaplayer_observer#onPlayerStateChanged)

---

# ID: 37843

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 2.6.5

Request Type: 集成问题咨询

Request Description: 在微信小程序中直播多人连麦 怎么混流 

Reply: 您好，请问您需要什么效果？直接加频道订阅以后自然听到的就是频道里所有声音混流在一起的效果了

---

# ID: 37793

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我本地部署了 [web版本 demo](https://github.com/Shengwang-Community/Conversational-AI-Demo/tree/main/Web/Scenes/VoiceAgent)
但是让必须登录，点登录报错 `http://localhost:3000/undefined/v1/convoai/sso/login?redirect_uri=http%3A%2F%2Flocalhost%3A3000%2F`

Reply: 您好，Conversational-AI-Demo 这里登录用的是我们官方SSO登陆认证的redirect_uri，需要在SSO的认证才能回跳的。
SSO登陆仅限于我司的注册用户，不对外开放。请业务上自行去除相关代码。

---

# ID: 37803

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 我们录的是两个人的视频通话，但是每次进去的前几秒都没录上，或者卡顿，或者丢字，就比如第一句“嗨 小景 你好呀”的“小”和“你”就没声儿，并且没录进去，所有的视频全部都是这样的问题，丢字严重～

Reply: 您好，请问实际通话时双方互通正常吗？可以提供下录制对应的 sid、录像文件，我们看下具体情况

---
# ID: 37804

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 问下有计划能够在agent回复的时候同时提供口型数据吗，例如azure的viseme

Reply: 您好，这个口型可以考虑两种方式解决
1、直接让数字人厂商在云端渲染后提供现成的画面，发到 RTC 频道里让观众观看。这样您基本没什么需要操作的地方，数字人厂商已经都搞定了，但是成本会有点高
2、利用 [使用音频模态输出](https://doc.shengwang.cn/doc/convoai/restful/user-guides/audio-modality) 自行定义输出的时候多带一组口型数据，然后在本地收到这些口型数据以后自行渲染。我们是提供自定义数据传输通道的，但是里面的具体业务需要您自行定制+改写 LLM 提示词，我们没有现成的封装接口

---
# ID: 37805

SDK Product: RTSA

SDK Platform: Linux-C

SDK Version: 1.9.2

Request Type: 其他问题

Request Description: 我们在智能硬件上即成了rtsa框架，我们使用你们的iOS demo，以及我们的安卓端去进入频道，结果没有收到来自rtsa sdk设备上的推送，而是iOS设备和安卓设备的互通了

Reply: 您好，请问有在声网 console 左侧边栏-全部产品-水晶球里检查过 RTSA 端的实际加频道情况吗？可以先检查下 RTSA 是否加入频道成功，并且确保 RTSA 和 其他端互通的时候有参考过[与 RTC SDK 互通音视频数据](https://doc.shengwang.cn/doc/rtsa/c/best-practices/interoperate-rtc)的编码格式建议，双方使用了相同的编码进行互通。

---

# ID: 37814

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.1

Request Type: 效果不佳、不达预期

Request Description: 请问安卓的SDK视频编码支持SVC吗？

Reply: 您好，Android SDK 不支持 SVC 编码

---

# ID: 37818

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 
```java
ktvApi.switchSingerRole(mKTVSingRole, new ISwitchRoleStateListener() {
            @Override
            public void onSwitchRoleSuccess() {
                Log.d(TAG, "onSwitchRoleSuccess1111: ok");
            }

            @Override
            public void onSwitchRoleFail(@NonNull SwitchRoleFailReason switchRoleFailReason) {
                Log.d(TAG, "onSwitchRoleFail1111: ok");
            }
        });

```
切换角色没有任何返回，只有SoloSinger的时候是有返回的，其他的都没有返回

Reply: 您好，可以在复现的时候拿一下 SDK 日志并说明复现时间点，人工工程师稍后看下[日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)打印
您也可以自查下，常见的原因可能是 joinChannelEx 没有成功导致的，建议检查 joinChannelEx 有没有加频道成功，检查下token 和 uid 是否匹配

---
# ID: 37819

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.1

Request Type: 集成问题咨询

Request Description: `muteLocalAudioStream` 、`setClientRole` 麻烦问下这两种方式停止和恢复发送音频流 有什么区别 

Reply: `muteLocalAudioStream` 会保持采集状态，不释放资源
`setClientRole` 为 Audience 时要看目前用的是什么音量，媒体音量的话会停止采集释放设备资源，通话音量的话采集会继续保持，不受影响。

---

# ID: 37773

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 目前我已经集成好了go sdk和linux server rtc sdk了，并打通了与VOIP的功能，目前有个问题，因为是商业化，所以务必要走知识库，但是我目前未找到可以对接譬如maxkb，dify，fastgpt这种的，请问有什么办法可以实现呢？
因为我目前是语音直接到你们rtc sdk推流出去了，所以我这边获取不到文字信息或者其他什么内容，所有的都在llm那进行推理了，如果是个性化的知识库方式，这个就无法实现了，请问贵公司是否有相应的解决方案呢？

Reply: 您好，可以参考下这篇文档来实现：[实现检索增强生成](https://doc.shengwang.cn/doc/convoai/restful/user-guides/custom-llm#%E5%AE%9E%E7%8E%B0%E6%A3%80%E7%B4%A2%E5%A2%9E%E5%BC%BA%E7%94%9F%E6%88%90)

---

# ID: 37782

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 我们准备做一个多人rtc语音互动，然后里面成员都为主播角色，然后当其中一个主播离开频道，我们服务端收到了所有主播的离开回调（event_type:104）,然后导致所有主播离开频道，并且房间销毁了。上面的频道名是我们测试环境的频道
需求：
1、想知道产生这个问题的原因，
2、然后我们需要的效果：是房间只剩一个人时才销毁房间，只有有2人及其以上可以正常聊天

Reply: 您好，
1、104 时间内有离开原因的字段，可以通过这个了解离开频道的具体原因。
2、RTC 频道销毁是后台服务自动实现的，用户侧无需关心，我们销毁的条件是频道内最后一个用户离开，这个条件无法修改。如果您业务上有需求，可以考虑用[踢人接口](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/post-dev-v1-kicking-rule)把用户踢出去

---
# ID: 37783

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 我们现在需要使用 腾讯云 提供的 音频内容安全 进行 语音直播审核,
但是腾讯那边不支持agora协议,我们现在需要怎么做才能对接呢

Reply: 您好，我们的音视频数据都是放在 RTC 频道内传输的，审核要看到内容只能加频道进来才行，如果腾讯不支持的话我们也没办法，可以考虑下换其他厂商，比如[网易易盾](https://support.dun.163.com/documents/2018082201?docId=499759506556469248)

---

# ID: 37786

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: vue项目打包为electron，想使用屏幕共享功能，sdk应该用web还是electron

Reply: 您好，两个都可以，一般用 Web 的多一些，用web的sdk需要记得处理`DESKTOP_CAPTURER_GET_SOURCES`

---

# ID: 37790

SDK Product: RTMP

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: RTMP创建流成功后，拉取流的接口是这个吗
POST https://api.sd-rtn.com/{region}/v1/projects/{appid}/rtls/ingress/streamkeys

Reply: 您好，不是这个，RTMP 网关是负责把流推进 RTC 频道里，要看到的话需要集成[客户端 SDK](https://doc.shengwang.cn/doc/rtc/homepage)

---
# ID: 37791

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 有没有办法判断是否欠费？
我司平台下有多个客户都使用声网作为视频基础，但是有的客户欠费后前端捕获异常后会报很多错误，我直接做弹窗会误导用户。
所以，前端的sdk有没有办法判断是否欠费，或者有没有做后端的欠费查询功能。

Reply: 您好，账号的欠费情况只能登录声网 console 主动查询，没有对外的接口开放
欠费的话 appid 会停用，初始化的时候就会报错 appid 不可用 `NO_ACTIVE_STATUS`,参考[错误码](https://doc.shengwang.cn/doc/rtc/javascript/error-code)

---
# ID: 37792

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 在线会议，会议结束后想要获得会议录音文件，除了云端录制外，声网那边有提供获取录音/视频的接口么？

Reply: 您好，只有云录制或者本地服务端录制或者客户端录制这几种录制方式，如果不调用录制接口是不会有录制产生的，RTC 不主动保存用户通话数据

---

# ID: 37728

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 你好，我要在web端获取远端推送过来的视频分辨率。ai给推荐个几种写法都没拿到,还有别的办法么？

Reply: 您好，可以用 client 方法 [getRemoteVideoStats](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iagorartcclient#getRemoteVideoStats)

---

# ID: 37745

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: Flutter 开发为了支持谷歌16k,咱们的Rtc 升级到:sdk 6.52,但是里边的相芯美颜插件 如果使用：版本 8.1.4报错，无法使用

Reply: 您好，相芯的 8.1.4 本身不支持 16kb，所以需要换到支持 16kb 的插件版本，请问您这边接受升级到 8.14.0 吗？接受的话可以参考下这个仓库里 Readme 的插件下载地址[AgoraMarketPlace_FU_Flutter](https://github.com/JamieLiu67/AgoraMarketPlace_FU_Flutter)

---

# ID: 37747

SDK Product: IM

SDK Platform: Android

SDK Version: 1.3.2

Request Type: 其他问题

Request Description: 语音通话降噪功能

老师我们今天测试了下，只要手在手机上摩擦一下，或者手指敲打手机，对方就能听到摩擦声音和敲打音，但是试了下微信 怎么摩擦怎么敲打就不会有声音，声网能做到么，是需要打开什么开关么

Reply: 您好，如果觉得降噪效果不明显，可以尝试切换 `scenario` 到 `chatroom`，走通话音量用硬件降噪试试[setAudioScenario](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#setAudioScenario)
如果还是不行，可以考虑开启 AINS 接口，[setAINSMode](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_effect#api_irtcengine_setainsmode)

---
# ID: 37748

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 目前在通话时遇到声音较小问题，咱们有对应的3A算法或者SDK使用时相关配置可以解决此问题吗？

Reply: 您好，请问目前在用哪个版本的 SDK？声音小的话需要提供具体频道号、uid、时间点，说明哪个 uid 听哪个 uid 声音小
也可以优先考虑切换 `scenario` 到 `GameSteaming` 来试下效果，参考[实现高音质](https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality)

---

# ID: 37756

SDK Product: IM

SDK Platform: Flutter

SDK Version: 1.3.2

Request Type: 集成问题咨询

Request Description: im的ui你们也是集成好的吗

Reply: 您好，IM 有 UI kit，自带一套现成 UI，参考：[UI Kit](https://im.shengwang.cn/docs/uikit/chatuikit/flutter/chatuikit_overview.html)

---

# ID: 37758

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.2

Request Type: 集成问题咨询

Request Description: 如何监听屏幕隐私保护是否开启？

Reply: 您好，屏幕隐私保护这个功能不影响录屏，而且这个状态鸿蒙系统也不会给到app

---

# ID: 37767

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 创建token的时候，不同角色创建的token，在功能上有什么区别？

Reply: 您好，因为 RTC 频道内是有主播和观众的身份区别的，所以需要 token 的身份也对齐，方便用 token 控制发流权限

---
# ID: 37768

SDK Product: RTMP

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 开头RTMP 网关服务后，使用 FFmpeg 推送本地码流到 网关，使用SRT协议，请问srt协议的默认端口是多少？ 你们家的大模型说是2088，但是telnet rtls-ingress-prod-cn.agoramdn.com 2088 不通畅

Reply: 您好，使用 SRT 协议推流的话，域名和端口需要额外调整，请参考文档[RTMPG 使用 SRT 协议推流](https://i46hiqvame.feishu.cn/wiki/UuFSwyI8ziApTUkr2mFcB4dXn3f?from=from_copylink)

---

# ID: 37771

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 集成问题咨询

Request Description: 微信公众号，通过h5实现语音通话，是否需要微信审核权限？

Reply: 您好，直接在微信公众号的微信浏览器内使用 Web SDK 是不需要微信审核资质的。

---

# ID: 37715

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我现在设备端使用rtsa推流，手机端使用rtc拉流，我在rtc端用观众身份去加入频道时，rtsa端回调显示的可用带宽有6.5mbps，可是把rtc端的身份改成host后，rtsa端回调显示的可用带宽只有50kbps了，这是怎么回事？rtc端只拉流观看，身份改成host后已经显式订阅。

Reply: 您好，`on_target_bitrate_changed` 回调用于报告当前探测到的可用最大带宽。
如果发送码率高于该带宽，可能会出现卡顿或丢帧，可根据此回调在设备上做提示。

当发送码率超过带宽时，可能出现以下报错：
`ERR_VIDEO_SEND_OVER_BANDWIDTH_LIMIT`
`Bandwidth change detected`

涉及三个概念：
1、SDK 内部算法进行的带宽探测
2、BWE 设定的最小/最大码率范围
3、编码器当前发送码率

SDK 不限定网络最大带宽，但发送码率不会超过 BWE 设置的上限。
当探测到带宽低于当前码率时，会触发 `on_target_bitrate_changed` 通知编码器调整码率。
该回调在检测到带宽变化时触发，码率调整策略可参考[实时调整发送码率](https://doc.shengwang.cn/doc/rtsa/c/basic-features/bitrate-adaption)。

---

# ID: 37717

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: 现在的播放器在直播过程中支持小窗播放吗

Reply: 请问您说的播放器是什么？是指视频通话切后台时整个 app 进入悬浮窗类似微信那样，还是 SDK 内的 mpk 播放器需要单独小窗播放东西？
悬浮窗是支持的，参考我们的[画中画 Demo](https://github.com/AgoraIO/API-Examples/blob/main/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/PictureInPicture.java)

---

# ID: 37719

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 云端录制在录制过程中能不能拿到实时画面的m3u8地址，我们想要实现边录制边播放录制画面

Reply: 您好，m3u8 是录制完成以后才会生成的索引文件，在录制过程中只有一份份 ts 文件会上传到 OSS 里没有办法从头到尾一直看，所以不支持您的需求。
如果您要看频道内画面，客户端上加入 RTC 频道收流就行了

---

# ID: 37725

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 效果不佳、不达预期

Request Description: 
```json
"properties": {
    "channel": "xxx",
    "agent_rtc_uid": "xxx",
    "remote_rtc_uids": [
      "*"
    ],
    "enable_string_uid": true,
    "idle_timeout": 120,
    }
  }
}'
```
  
房间 ID： convaiconsole20988972_196860
Agent ID：xxx
无法语音交流

Reply: 您好，看您配置了使用 string uid，请确保频道内远端也使用了相同的类型，否则 int 和 string 混用会有互通问题。

---

# ID: 37698

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 我们在开发一款机器人应用，当机器人开启对话时，同时调用声网音视频互动SDK，开启音视频监控，记录当时与访客对话的场景。
现在的问题是：
1、当我们不设置时，mRtcEngine.setDefaultAudioRoutetoSpeakerphone(true);只要一进入声网音视频频道，机器人对话的音量会直接变成一个固定的音量（估计是最大音量的50%），并且调整设备音量也无效。
2、当我设置了时，mRtcEngine.setDefaultAudioRoutetoSpeakerphone(true);只要有其他主播（我们web后台可能有座席查看当前机器人情况）进入频道，也会出现问题一的情况。
代码如下：
```java
    mRtcEngine = RtcEngine.create(context, appId, mRtcEventHandler);
    mRtcEngine.enableVideo();

    mRtcEngine.setDefaultAudioRoutetoSpeakerphone(true);
    mRtcEngine.setRouteInCommunicationMode(3);

    ChannelMediaOptions options = new ChannelMediaOptions();
    // 视频通话场景下，设置频道场景为 BROADCASTING。
    options.channelProfile = Constants.CHANNEL_PROFILE_COMMUNICATION;
    // 将用户角色设置为 BROADCASTER。
    options.clientRoleType = Constants.CLIENT_ROLE_BROADCASTER;
    mRtcEngine.joinChannel(token, channelName,  Integer.parseInt(uid),options);
```


Reply: 您好，不推荐用`Constants.CHANNEL_PROFILE_COMMUNICATION`，请改用 Live 模式，role 保持不变
以及不需要s`etDefaultAudioRoutetoSpeakerphone`、`setRouteInCommunicationMode`，可以用[setAudioScenario](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#api_irtcengine_setaudioscenario) 设置为`AUDIO_SCENARIO_GAME_STREAMING`，走媒体音量，如果需要走通话音量改成 chatroom 就行
如果有高音质需求，可以再参考下文档[实现高音质](https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality)

---

# ID: 37702

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 线上报错

Request Description: 我们想要做一个录音功能，我们这边服务端使用的是这个 使用 Go SDK 开始云端录制，当前的流程：
1. 客户端请求服务端，服务端下发 agoraToken，cname，agoraUid
2. 客户端加入声网频道
3. 服务端监听声网加入频道回调
4. 服务端调用声网开启start，此时传的 uid 和上面agoraUid不一样(我看文档上需要不一样)
5. 开始录音
6. 监听声网退出频道回调
7. 服务端调用 stop
问题：
8. 帮忙看下流程是否正确。我们正常流程是客户端录音，录完后上传oss。上面的方案是在客户端突然掉线(手机没电等)，防止录音丢失，这种场景使用的。会报错
```json
		"details": {
			"errorCode": 110,
			"errorLevel": 5,
			"errorMsg": "",
			"module": 0,
			"msgName": "cloud_recording_error",
			"stat": 0
```
2. 上面流程4中，如果服务端传递的uid和流程1中的agoraUid一致，则不报错，但是存储桶中一直没有录音文件以及文件夹

Reply: 您好，
1、错误码 110 表示 token 错误，临时 token 不校验 uid 所以能进频道，自己生成的 token 是要校验 uid 的，需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道。控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验，将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致
2、您现在的流程没问题，但是云录制只能录制 RTC 频道里发的流，如果客户端掉线、断网的话，云录制是录不到用户画面的，因为用户发不出来

---

# ID: 37704

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 效果不佳、不达预期

Request Description: agora_rtc_engine: 6.5.0
iOS 26 调用enableLocalAudio(false) 系统音量调节功能无法使用了。

Reply: 您好，目前这个问题需要尝试：
1、使用 Gamestreaming 的 scenario 来解决
2、或者 避免使用`enableLocalAudio `来解决，可以尝试用 `setClientRole`来解决，需要开麦设置为主播，不需要了设置为观众。或者用 `muteLocalAudio` 来实现，不过 mute 方法不会停止采集，行为上会有些许差异。

---

# ID: 37706

SDK Product: SDK-extension

SDK Platform: iOS

SDK Version: Metakit

Request Type: 集成问题咨询

Request Description: 想咨询：
1.是否能支持视频通话中，人物头像卡通化/虚拟形象，跟随人脸动。
2.如果支持，需要其他框架/SDK支持吗？

Reply: 您好，声网有 metakit 可以支持，但是 metakit 插件已经没有更新维护一段时间了，不推荐使用。建议您通过集成第三方 SDK 来实现这种需求，我们的 SDK 支持提供[视频裸数据](https://doc.shengwang.cn/doc/rtc/ios/advanced-features/video-processing)用于处理。

---

# ID: 37708

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 版本号4.20.1
关麦再开麦有时会没有声音

Reply: 您好，因为老版本已经不更新维护了，所以优先建议升级到最新版本，如果新版本还有问题，可以开启[日志上传](https://doc.shengwang.cn/faq/integration-issues/set-log-file)以后复现问题，提供具体的频道、uid、时间点，说明谁听不见谁，我们看下具体原因。

---

# ID: 37710

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: `api.agora.io/cn/v1.0/projects/xxx/ktv-service/api/serv/songs?requestId=lzTZsruXVL3VUi2UVHHDTPE0PRvF8P4V&pageType=0&pageCode=6246262727281830&size=2&option={"tag":"1"}`
token的请求是 Authorization = `007eJxTYIg4lVXBx/lx9v9pqsf45X3vLDmQ/GxT8o+pmdfk19Ts/leuwJCWbGycnGZkYZCclGxilmaUaG5pamBhkpiYmmhiYWhqJP74Z0ZDICNDZs9bZkYGCATxmRkMDQwYGADSXyEq`
这个是临时token

返回：KongError, Unauthorized

用postman跑的，还是报错

Reply: 您好，认证里不是填我们的 token，是填声网 console 里获取的 ak sk 计算出的 basic auth 值，参考云录制的实现再试下[实现 HTTP 基本认证](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guides/http-basic-auth)

---
# ID: 37711

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 问题背景：一个房间内有多个主播在直播，假设主播A直播时，正在使用声网语音聊天，此时主播B、C、D也在直播且在主播A旁边坐着，由于他3个人直播时吼叫声音较大，会把声音传入主播A的麦克风内；
1. 是否有类似环境音屏蔽的功能api
2. 此问题有声网是否有最佳实践解决方案？

Reply: 您好，这种情况是物理现象，外放声音大+麦克风重新拾取就会导致回音，移动端上可以修改 audioScenario 为 chatroom 走通话音量用硬件回声消除解决，Windows 或 Mac 这类桌面端只能考虑带耳机或者调小外放音量解决了。

---

# ID: 37713

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.1.7

Request Type: 线上报错

Request Description: 实时消息restful接口报错 "https://api.sd-rtn.com/rtm/v2/history/1879b5cf51af4d91a848350caa13adaa/userId/100000/channelType/message/channel/live_1978412974843232257start=&end=&messageCount=100": "{"data":null,"error":true,"errorCode":500,"operation":"history","reason":"Sync Server Error","requestId":"7966661_18114543996554487573"}"

Reply: 您好，请先检查下您目前在用的 appid 是否有开通[历史消息](https://doc.shengwang.cn/doc/rtm2/javascript/user-guide/message/history-message)服务？如果有的话，麻烦提供下具体 appid ，人工工程师稍后跟进。

---
# ID: 37714

SDK Product: IM

SDK Platform: iOS

SDK Version: 1.3.2

Request Type: 集成问题咨询

Request Description: 离线推送，通知栏，显示标题和内容，目前收到显示的是默认的你有一条消息，点击查看，我想设置成显示谁发的，发送的具体内容，如何设置，在哪里设置，我看了下文档没太明白

Reply: 您好，请参考[设置推送通知的显示内容](https://im.shengwang.cn/docs/sdk/ios/push/push_display.html)，修改`DisplayStyle`和`displayName `来实现

---

# ID: 37682

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: Caused by: org.gradle.internal.resolve.ModuleVersionNotFoundException: Could not find io.agora.rtc:agora-rtc-sdk-media-player:3.6.0.
有没有3.6.0的demo

Reply: 您好，Android SDK 的老版本已经不再更新维护了，推荐您优先升级 SDK 到最新的 4.x。如果无法升级的话，可以访问我们的 [api-example](https://github.com/AgoraIO/API-Examples/tree/main)，切换仓库的 tag 到指定的老版本。

---
# ID: 37683

SDK Product: RTM

SDK Platform: Flutter

SDK Version: 2.2.2

Request Type: 集成问题咨询

Request Description: 我们需要接入RTM消息服务。我们是全球数据互通。如果我们开通多个服务区域，可以保证数据的跨区域互通么

Reply: 您好，RTM 是全球都有节点可以互通的，但是消息数据的保存位置，是在 console 控制台上开启 RTM 功能时选择的，这个开通以后就不能改了

---

# ID: 37686

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: 我不知道这属于哪一类问题。有没有安卓扬声器语音与人声分离的解决方案？

Reply: 您好，SDK 本身自带回声消除模块，默认就是开启的，但是不单独对外提供和使用，只有在加入 RTC 频道通话的时候才会工作，请问您现在是有回声现象需要解决吗？
默认就是开启的，所以您可以用我们 [Demo](https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo) 体验，如果效果不好，可以把 [scenario](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#api_irtcengine_setaudioscenario) 设置为 chatroom 走通话音量试下

---
# ID: 37687

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 语音通话过程中，熄屏后没有声音

Reply: 您好，app 没做保活的话，进入后台会被限制采集，可以参考文档进行保活：[为什么部分 Android 版本 App 锁屏或切后台音视频采集或播放（渲染）无效？](https://doc.shengwang.cn/faq/quality-issues/android-background)

---

# ID: 37689

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 有没有主播邀请观众连麦的 demo，或者 java 版本的相关代码？

Reply: 您好，建议优先跑通我们的 [api-example](https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo)
然后再参考下我们的解决方案 Demo [秀场直播](https://doc.shengwang.cn/doc/showroom/android/get-started/run-example)

---

# ID: 37694

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 加入智能体成功后，无法对话

Reply: 请问您这边有加入频道开麦发流吗？声网 console 里的 playground 有跑通吗？可以提供下具体的 agentID 

---

# ID: 37651

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 4.6.0 的 sdk 怎么在控制台打印sdk日志，目前设置成 debug 日志也还是不打印sdk日志

Reply: 您好，我们 SDK 自从 4.3.0 开始就不再输出明文日志了，您可以自行在接口内添加 log 打印，而不是直接看我们 SDK 的输出打印

---

# ID: 37653

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 集成问题咨询

Request Description: https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iagorartc, 我在这里个文档里没有找到datachannel或者叫数据流的说明。web项目中node_model找到声网的目录，里面有 data-stream 。我需要用数据流给安卓多发指令，请问web怎么使用数据流？

Reply: 您好，Web datastream 接口没有对外展示，但是可以用，参考
```javascript
//监听回调 
onStreamMessage?: (message: DataStreamMessage) => void;
 
client.on("stream-message", (uid, message) => { console.log(`receice ${message} from ${uid}`); });
 
//发送
client.sendStreamMessage(new Uint8Array(), false)
```

---

# ID: 37663

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 其他问题

Request Description: startRecording();本地保存返回-4

Reply: 您好，startRecording 返回 -4 表示 RtcEngine 当前状态不支持该操作。可能因为录制正在进行中或录制出错停止。
建议参考我们的官方SDK Demo[MediaRecorder](https://github.com/AgoraIO/API-Examples/blob/main/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/MediaRecorder.java)，以及有录制需求我们优先推荐[云录制](https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page)，比客户端录制方便的多

---

# ID: 37665

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 按官网提供的demo集成rtc sdk 4.6.0版本，集成后已可以正常视频通话。但是当通话中某一方将app退到后台之后，app会卡死无法继续视频通话。需求是：

1.希望app退到后台之后，rtc视频通话仍能够继续。

2.app退到后台之后，并可能进入另外的app的情况下，视频窗口以悬浮窗的方式继续通话。

请问rtc 4.6.0是否有支持后台保活持续通话和悬浮窗播放的接口方法？能否提供一个类似功能的demo？谢谢！

Reply: 您好，
1、这个需要做保活，Android 的保活可以参考[为什么部分 Android 版本 App 锁屏或切后台音视频采集或播放（渲染）无效？](https://doc.shengwang.cn/faq/quality-issues/android-background)
2、画中画的需求可以参考我们的官方 Demo[PictureInPicture](https://github.com/AgoraIO/API-Examples/blob/main/Android/APIExample/app/src/main/java/io/agora/api/example/examples/advanced/PictureInPicture.java)

---

# ID: 37667

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 效果不佳、不达预期

Request Description: onLocalAudioStateChanged监听音频变化的时候。
操作步骤
app在后台中 手机来电 会监听到localAudioStreamReasonInterrupted.手机挂断会监听到localAudioStreamReasonOk.
app在后台 微信来电时会监听到localAudioStreamReasonInterrupted 微信挂断时不会收到监听.

Reply: 您好，SDK 无法感知音频占用的源是什么，不同手机 型号/系统 的表现不一样，有的会回调被占用 有的可能就是采集状态不变，系统给 sdk 都是空数据

---
# ID: 37668

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 声网哪个 API 能让我通过声网的接口或者 API临时获取动态 token 的，后台集成 token 生成出现了问题，老板又催的急。

Reply: 我们的 token 是用脚本生成的，您 clone 这个仓库到本地运行就可以：[token-authentication](https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication#token-code)

---
# ID: 37669

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: https://juejin.cn/post/6844903570639192078#heading-9

这个文档里提到的仓库地址无法访问了
https://github.com/AgoraIO/Agora-RTC-With-CallKit

Reply: 您好，这个仓库已经停止更新维护了，您可以再探索下其他集成 callkit 到项目里的方式，callkit 和 RTC SDK 是两套独立的 SDK，接受 callkit 通话邀请以后调用 SDK 的 join 方法加入频道就能实现了

---

# ID: 37642

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 1对1语音聊天
1对1视频聊天
语音多人聊天，视频多人聊天
请问语音流如何捕捉，想识别这些语音，将语音转为文字，进行鉴黄，谢谢！

Reply: 您好，
1、您这边选的是融合 CDN，融合 CDN 的物理延迟很高，不适合1v1 互通，建议用客户端 SDK 走 RTC 协议，延迟可以控制在 400ms 以内
2、鉴黄无需转写，可以直接集成网易、数美等审核厂商的 SDK 来实现

---
# ID: 37643

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 效果不佳、不达预期

Request Description: 客户端rtm收不到agent的状态变更事件，比如这个文档上展示的[StateChangeEvent](https://doc.shengwang.cn/api-ref/convoai/android/android-component/struct#statechangeevent)

Reply: 您好，请问有监听对应事件吗？可以参考 [监听智能体事件](https://doc.shengwang.cn/doc/convoai/restful/user-guides/listen-agent-events)
如果监听都正常，可以截图提供下相关代码并提供对应的客户端日志和 agentID。

---

# ID: 37615

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 问题咨询：
请问查询用户列表的服务端Restful API，在返回的用户ID列表中，是否包含录制、审核这类声网内部机器人的UserID ？

Reply: 您好，会包含的，这些服务需要用 UID 加入频道才能正常工作，会被查询到在频道内的。

---

# ID: 37616

SDK Product: Fastboard

SDK Platform: iOS

SDK Version: 1.4.2

Request Type: 集成问题咨询

Request Description: 我是 OC 项目，运行后发现白板上没有内容，请帮我看下是哪里出了问题？因为你们并未提供OC版的demo，请帮我解决一下非常感谢

Reply: 您好，我们有 [OC 版本的 Fastboard Demo](https://github.com/netless-io/fastboard-iOS/tree/master/Example/OCExample)，可以参考。

---

# ID: 37625

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: rtc房间启动后，服务端通过api发起云端录制功能。该api耗时超10s。而且大面积出现；

Reply: 您好，耗时和请求发起的位置与被请求的域名相关，请参考我们的[最佳实践](https://doc.shengwang.cn/doc/cloud-recording/restful/best-practices/rest-availability)，在对应的区域使用对应区域的域名去请求，不然跨域容易出现耗时长和请求失败的问题。
如果您确定请求地区是匹配的，可以提供具体的sid，我们看下后台响应的情况。

---

# ID: 37631

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 安卓和pc web互联，安卓能听到pc的声音，pc听不到安卓的。而且pc的user-joined在安卓加入频道的时候收不到事件

Reply: 您好，可以检查下 Web 端加频道用的 uid 类型是不是 int，频道内不能 int 和 string 类型混用，建议全部用 int 加频道互通

---

# ID: 37595

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 后端返回的uid是3081074661，后端说的声网文档是uint32,但是Android 客户端加入频道要的uid却是int32，这是api  public abstract int joinChannel(String token, String channelId, int uid, ChannelMediaOptions options); 这个怎么解决

Reply: 您好，保持UID用 int32 类型再试试，不要超过这个范围上限

---

# ID: 37605

SDK Product: Fastboard

SDK Platform: Android

SDK Version: 1.7.2

Request Type: 集成问题咨询

Request Description: 我在加入房间的时候调用的是
```java
fastRoom.join(new OnRoomReadyCallback() {
@Override
    public void onRoomReady(@NonNull FastRoom room) {
        Log.i("WhiteBord", "房间加入成功，uuid=" + uuid);
        isWhiteboardJoined = true;
        isJoining = false;
    }
});
```

是可以走到回调里面的。但是执行过退出房间方法（fastRoom.destroy();）之后重新加入与之前相同uuid的房间的时候无法加入成功，并且也不会走到onRoomReady这个回调。麻烦提供一下 加入房间 退出房间 重新加入房间的小例子。或者我的代码错误

Reply: 您好，destroy之后就是无法加入的，需要重新 join
```java
fastRoom = fastboard.createFastRoom(roomOptions)
fastRoom.join()
```

---

# ID: 37608

SDK Product: Media-push

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 拉流黑屏，拉不到流

Reply: 您好，请提供具体的`converterId`和问题时间点，并且尝试开关 转码配置 来验证下是否能够解决

---

# ID: 37570

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 效果不佳、不达预期

Request Description: 问下我们在使用elevenLabs作为tts厂商时时延为啥这么长，跟榜单别的测试数据不在一个级别上，是参数有问题么：
性能指标详情:
轮次: 1 | asr_ttlw:0ms | llm_ttfb:0ms | llm_ttfs:0ms | tts_ttfb:194ms
轮次: 2 | asr_ttlw:0ms | llm_ttfb:536ms | llm_ttfs:753ms | tts_ttfb:708ms
轮次: 3 | asr_ttlw:0ms | llm_ttfb:951ms | llm_ttfs:1234ms | tts_ttfb:1487ms

Reply: 您好，就是elevenLabs 本身耗时长较长导致的，这一点可以在模型评测平台体现

---
# ID: 37571

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我使用rsta进行推流，使用rtc进行拉流播放，可以在不使用服务器的情况下让rtsa推流方检测到rtc方的加入与退出吗？我将rtc方的身份改成host后，rtsa方可以检测到rtc的进入和退出，但是rtsa方显示连接失败，日志[2025-10-11 09:09:58.319] [ERROR] [QtAgoraClient] SDK错误回调 - 连接ID: 1 错误码: 300 消息: "pacer-timeout"

Reply: 您好，错误码: 300 消息: "pacer-timeout"表示视频数据发送太快，且超出了宽带限制。当前发送速度下很可能发生丢包。
如果咱们[码率](https://doc.shengwang.cn/doc/rtsa/c/basic-features/bitrate-adaption)高于这个，就会有可能产生卡顿，咱们也可以基于这个回调在设备上做一定提示

如果发送的码率大于带宽探测的大小，就会报错：ERR_VIDEO_SEND_OVER_BANDWIDTH_LIMIT 或者 Bandwidth change detected

这里面涉及到三个概念：
1. 是我们sdk内部的算法做的带宽探测
2. 是sdk上bwe预设的最大最小码率值
3. 是视频编码本身的码率

声网不对网络中最大带宽做确定，但是不管实际有多大，发送的最大码率都不会超过bwe api设置的最大码率；
如果算法中探测到的带宽，低于我们当前的编码码率，我们会发一个回调`on_target_bitrate_changed`来通知编码器调整码率；

这个回调是我们检测到带宽大小有变化的时候就会回调，然后咱们调整码率的策略可以参考[实时调整发送码率](https://doc.shengwang.cn/doc/rtsa/c/basic-features/bitrate-adaption)

---
# ID: 37572

SDK Product: Fastboard

SDK Platform: Android

SDK Version: 1.7.2

Request Type: 集成问题咨询

Request Description: 请发我android的demo  java版本的，我看你们网站只有kotlin版本

Reply: 您好，请问有看过这个 Demo 吗？这个是 Java 版本的 [fastboard-android](https://github.com/netless-io/fastboard-android/tree/main)

---

# ID: 37586

SDK Product: RTC-Linux

SDK Platform: Linux-Java

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 在Linux上跑官方给示例时：
报错： service.agoraRtcConnCreate(null)返回为null，导致后续错误
报错日志：
```
spdlog fatal error: Cannot use size() on closed file /root/.agora/agorasdk.log
spdlog fatal error: Cannot use size() on closed file /root/.agora/agoraapi.log
spdlog fatal error: Cannot use size() on closed file /root/.agora/agorasdk.log
spdlog fatal error: Cannot use size() on closed file /root/.agora/agoraapi.log
spdlog fatal error: Cannot use size() on closed file /root/.agora/agoraapi.log
```
其中agoraapi.log日志为：
```
[10/15/25 14:18:56:205][1735][A]:(00000000): AgoraService::initializeInternal(this:0x7fc44c003840, configEx:(engineType:0, enableAudioProcessor:0, enableAudioDevice:0, enableVideo:0, context:0x7fc4dc427948, bitrateConstraints:(min_bitrate_bps:0, start_bitrate_bps:300000, min_bitrate_bps:0), logDir: (null), domainLimit:0))
[10/15/25 14:18:56:222][1735][A]:(00000001):   AgoraService::setLogFilter(this:0x7fc44c003840, filters:15)
```

Reply: 您好，建议拉我们仓库最新的 main 分支代码按照 README 运行一下：[下载](https://doc.shengwang.cn/doc/rtc-server-sdk/java/resources)

---

# ID: 37589

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.5.1

Request Type: 集成问题咨询

Request Description: 参考SDK Sample 做本地录音的功能，Unity Window及Mac环境使用正常，在Ios和Android设备时，无法开启录制功能
1.使用的临时Token(在有效期内)
2.初始化及加入频道已经成功
3.调用 LocalRecorder.StartRecording 时 Ios和Android设备 返回 -2  但在Mac上运行正常返回0

Reply: 可以参考下接口文档，-2 就是参数无效，移动端和桌面端的参数不一定能通用：[StartRecording](https://doc.shengwang.cn/api-ref/rtc/unity/API/toc_recording#StartRecording)

---
# ID: 37590

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.2

Request Type: 集成问题咨询

Request Description: 我看源码仓库开启了  以下配置，这个配置好像有污染性，是否上层应用也需要开启      
```
 "strictMode": {
            "useNormalizedOHMUrl": true
          }
```

Reply: 您好，要开启。
这个设置是鸿蒙的推荐设置，上架鸿蒙的sdk都要打开这个选项

---

# ID: 37593

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 其他问题

Request Description: 问一下，现在的SST就是实时翻译的服务只支持RTC这种聊天室的形式吗？

Reply: 您好，是的，只能翻译 RTC 频道里的内容

---

# ID: 37550

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.2.0

Request Type: 集成问题咨询

Request Description: 在直播过程中 想实现一个评论/弹幕功能 该如何实现

Reply: 您好，RTC SDK 内有 datastream 可以实现简单的弹幕功能，但是发送 datastream 的身份必须是主播。
如果您希望实现功能全面一些的弹幕，可以考虑集成额外的信令 SDK，例如 RTM。

---

# ID: 37552

SDK Product: IM

SDK Platform: Flutter

SDK Version: 1.3.2

Request Type: 其他问题

Request Description: 就是 群聊是有名称的 但是显示的是群id modal.showName 是有其他的配置吗？

Reply: 您好，IM 建完群组以后需要先获取群组详情，才能拿到群名
或者通过这个进行修改 [根据群相关回调更新信息](https://im.shengwang.cn/docs/uikit/chatuikit/flutter/chatuikit_userinfo.html#%E6%9B%B4%E5%A4%9A)

---


# ID: 37557

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: 在RTC 视频通话时，我的设备存在3个麦克风，我想3个麦克风 根据使用场景 进行随意切换。是否可行

Reply: 您好，这个需求无法实现，麦克风的选择是系统行为，系统在没有外接的时候优先选内置，有外接的时候优先选外接。

---

# ID: 37560

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: android 前台服务使用 需不需要添加媒体播放权限？
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MEDIA_PLAYBACK" />
   android:foregroundServiceType="mediaPlayback|microphone" mediaPlayback

看demo service中并没有播放媒体文件  提审谷歌会需要提交 以及录屏幕


我们已上线版本没有加这个权限，新版本加了这个权限，请给给建议？是否需要带上

Reply: 您好，这个权限是给屏幕共享用的，您这边没有屏幕共享场景的话可以参考文档移除：[How to resolve FOREGROUND_SERVICE_MEDIA_PROJECTION when not using screen sharing](https://agoraio.zendesk.com/hc/en-us/articles/33544055408788-How-to-resolve-FOREGROUND-SERVICE-MEDIA-PROJECTION-when-not-using-screen-sharing)

---

# ID: 37564

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 集成问题咨询

Request Description: 在安卓设备上收音很小，ios好一点，能不能帮忙看下是不是集成有问题

Reply: 您好，麻烦提供具体的频道名、uid、时间点，说明下具体现象，人工工程师稍后确认具体原因。
您可以同时尝试切换`setAudioScenario`的枚举在 Gamestreaming 和 Chatroom 之间切换，对比下效果是否有改善。

---
# ID: 37565

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.2.0

Request Type: 崩溃（闪退、卡死）

Request Description: 就是 ios版本 agora_rtc_engine 引入了这个 AgoraInfra_ios库的版本(1.2.13.1) 然后 shengwang_chat_uikit也引入了 AgoraInfra_ios库版本是(1.2.13) 导致依赖冲突问题 怎么解决？在线急！！！！

Reply: 您好，IM 的话把podfile文件中的`pod 'ShengwangChat_iOS' `改为`pod 'ShengwangChat_iOS', :podspec => 'https://downloads.easemob.com/downloads/SDK/Podspecs/ShengwangChat_iOS.podspec' `就可以了

---
# ID: 37566

SDK Product: RTM

SDK Platform: Java

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 15:19:52 观众23002加入频道，并向主题【air_to_gnd】发送了消息，观众30484316订阅了该主题，但是没有收到消息，服务器是否能够查到15:19:52后的时间端观众23002有没有发送消息到达服务器？

Reply: 您好，请问您说的“主题”具体是什么功能？是频道消息吗？麻烦完整描述下场景

---

# ID: 37521

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: 获取pcm文件后，用第三方翻译回调失败 not authed streamId如何解决

Reply: 您好，这个报错和我们 SDK 无关，属于第三方 SDK 的问题，可以检查下第三方 SDK 的错误码文档寻求解决方法。

---

# ID: 37526

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 2.6.5

Request Type: 效果不佳、不达预期

Request Description: 问题现象：微信小程序发出的音频格式不固定，有时是aac 有时是opus，微信小程序中初始化时调用了client.setAudioCodec(9)，没有aac、opus相关设置调用，请问这是什么原因造成的

Reply: 您好，小程序默认发送 opus，当频道里远端只有一个 Native 的时候会自动转为 aac。[setAudioCodec](https://doc.shengwang.cn/api-ref/rtc/mini-program/classes/client#setaudiocodec)需要appid配置IOT环境后调用才会生效，如果没有配置过的话是不会修改音频编码格式的。
其中枚举为：
* 0: PCMU/G711u 格式。
* 8: PCMA/G711a 格式。
* 9: G722 格式。

---
# ID: 37527

SDK Product: RTM

SDK Platform: Flutter

SDK Version: 2.2.2

Request Type: 其他问题

Request Description: 你好，我现在在做harmonyos的rtm功能，现在有一个问题，就是调用this.storage?.setChannelMetadata方法时，返回值一直是{"errorCode":-12019,"requestId":"0"}，beta版本提供的demo也是返回这个错误，请问是什么原因？应该如何修改

Reply: 您好，您好，您的错误都可以在[错误码](https://doc.shengwang.cn/doc/rtm2/cpp/error-codes)列表中找到对应解决方案和原因，可以参考下。
-12019 RTM_ERROR_STORAGE_NOT_AVAILABLE Storage 服务不可用。
-11007 RTM_ERROR_CHANNEL_JOIN_FAILED 表示加入该频道失败：
检查已加入频道数量是否超限。
检查频道名是否非法。
检查网络是否断开连接。

---
# ID: 37528

SDK Product: IM

SDK Platform: Flutter

SDK Version: 1.3.2

Request Type: 其他问题

Request Description: 就是 第一次登录的时候 进入ConversationsView 是有会话记录的 但是 我退出App 在重新进入ConversationsView  页面就没有会话记录了 日志 D/ONE SDK (12552): [2025/10/11 05:38:00:392]: Java_io_agora_chat_adapter_EMAChatManager_nativeGetAllConversationsBySort 

Reply: 您好，IM 会话记录是从本地读取的，您可以卸载 app 重新编译再看下还会不会复现，如果会的话，请检查下有没有开启 [自动登录](https://im.shengwang.cn/docs/sdk/android/login.html#自动登录)
如果还有问题，麻烦提供具体的SDK日志过来看下。

---

# ID: 37530

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: - (BOOL)onPlaybackAudioFrame:(AgoraAudioFrame* _Nonnull)frame channelId:(NSString * _Nonnull)channelId  NS_SWIFT_NAME(onPlaybackAudioFrame(_:channelId:));
是获取对方的音频数据吗，为什么不回调，而onRecordAudioFrame方法都回调了

Reply: 您好，请问音频观测位置是POSITION_PLAYBACK 位置吗？[getObservedAudioFramePosition](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_raw#getObservedAudioFramePosition)，onPlaybackAudioFrame只有在观测位置是POSITION_PLAYBACK且远端用户确实在发流的时候才会触发。

---

# ID: 37539

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 线上报错

Request Description: 曹操三摄设备集成
声网版本4.1.1
appId='8b125330726a4bd79fac3e402f8ecc3b', uid=0, enableVideo=true, token='', channelId='01001015CVPAU10024112100040', license='null', authType=1}
10月13日上午测试期间出现一次远程展示摄像头画面卡住不动的情况，情况持续很久，查看日志是有角色主动离开，预期是没有离开，需要麻烦排查离开的具体原因

Reply: 您好，频道内用户离开的原因可以在声网 console-左侧边栏-全部产品-水晶球 里自行查询，如果无法判断的话，您可以提供完整频道号、uid、时间点、[客户端 SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)过来看下

---

# ID: 37542

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 我们是Java-linux-sdk，想请教下3A模块怎么集成。模型文件如何获取

Reply: 您好，3A 模块只能服务端SDK，搭配 RTC 通话使用，3A 和 BGHVS 的集成可以参考 [Java Linux SDK 的 README](https://github.com/AgoraIO-Extensions/Agora-Java-Server-SDK/tree/main)

---
# ID: 37543

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 线上报错

Request Description: 25154频道中7697在频道中显示为正常退出对话, 但是经过勘察推测7697因为另外一个用户被挤下去了, 能不能帮忙查看一下7697是否是正常退出对话, 之后就没有再加入频道了?

Reply: 您好，需要确认下通话发送的具体时间点，以及有[客户端 SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)的话能够更好的了解[频道链接状态](https://doc.shengwang.cn/doc/rtc/javascript/basic-features/channel-connection)

---
# ID: 37544

SDK Product: Fastboard

SDK Platform: Web

SDK Version: 1.1.0

Request Type: 集成问题咨询

Request Description: web端是否支持vue2，经测试，vue3没问题，vue2在引入阶段出现许多报错

Reply: 您好，支持，但是vue2 不能把 fastboard 实例放到vue的data中,需要挂载到全局变量上使用

---

# ID: 37546

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 集成服务端JAVA SDK后，通过 buildTokenWithUserAccount 生成RTC token，但用这个token建立连接时，返回-121

Reply: 您好，121 表示用户ID无效，这表示您加入频道时传入的 uid 有问题，可以对照[错误码](https://doc.shengwang.cn/api-ref/rtc-server-sdk/java/error-code)文档自查一下

---

# ID: 37502

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.5.1

Request Type: 集成问题咨询

Request Description: 1，uid  5先加入test-1001频道，
2，uid  7  后加入test-1001频道，
3，加入频道后程序切换了视频渲染画布的对象，
4，uid 7退出了test-1001频道
5，uid 5的视频画面出现了卡顿，画面无反应。

Reply: 您好，可以提供下出现问题的具体 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，方便的话可以提供下现象视频，人工工程师稍后为您分析具体原因。
您也可以先用我们的 [UE 官方 Demo](https://doc.shengwang.cn/doc/rtc/unreal-cpp/get-started/run-demo) 来测试看下是否会复现同样的问题。

---

# ID: 37511

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.3.2

Request Type: 集成问题咨询

Request Description: 我实时互动打开 视频后聊天  游戏里的击打音效听不到了  背景音乐也听不到了 我那个地方没配好呢

Reply: 您好，请问现在是 Unity 导出到哪个平台上使用呢？可以尝试把 audioScenario 切换为`AUDIO_SCENARIO_GAME_STREAMING`试下。
可以使用[SetAudioScenario](https://doc.shengwang.cn/api-ref/rtc/unity/API/toc_audio_basic#api_irtcengine_setaudioscenario)来实现。

---
# ID: 37512

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 我使用安卓平板和微信h5网站进行视频通话，通话可以正常建立，安卓端一切正常，能打开自己的摄像头，也能收音，但是手机微信里没用打开摄像头，也不能收音，使用的是rtc.4.2.1.js,也不显示拨号者姓名，就显示未知，但是画面是正常接通的画面，时间也在走，就是看不到画面也不能收音

Reply: 您好，请开启[日志上传](https://doc.shengwang.cn/faq/integration-issues/set-log-file)后提供下具体的频道号、uid、时间点，说明哪个 uid 看不见哪个 uid，人工工程师稍后看下数据上报。
以及可以留意下是否符合[已知问题](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility)的特征。

---
# ID: 37513

SDK Product: Fastboard

SDK Platform: Web

SDK Version: 1.0

Request Type: 集成问题咨询

Request Description: 新建了一个html文件，并通过cdn的方式集成了Fastboard白板功能，在浏览器打开后报错显示【Uncaught ReferenceError: require is not defined】。问题应该是cdn引入的js文件中使用了require方式引入了其他文件，我解决了require引入方式的问题后再次测试，又出现有关【@netless/fastboard-ui】的报错。
而且我看到有三种继承方式，分别是npm、cdn、直接下载sdk，目前项目原因不支持npm方式，sdk的链接是一个github地址，里面代码好像也是npm方式引入，现在cdn引入又报错

Reply: 您好，cdn 依赖需要 `fastboard-core window-mananger` 及 `white-web-sdk` 这些,而且需要`script type="module"`，可以自查下是否符合。

---

# ID: 37462

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.4.0

Request Type: 其他问题

Request Description: 音视频房间的代理回调是不是偶尔会延迟，用信令的实时性会更好吗 是否有必要用消息信念通知，比如离开房间，加入房间，尤其是离开房间，明明我这边挂断了 对方跟着挂断感觉偶尔会延迟一下

Reply: 您好，客户端回调一般不会有延迟，可以[收集日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)看下回调触发的具体时间。

---
# ID: 37463

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: 1.进入频道后，打开微信发不了语音消息，影响微信其他第三方应用的麦克风声音

Reply: 您好，微信使用的是通话音量，您可以尝试切换 SDK 的 scenario 为`AUDIO_SCENARIO_GAME_STREAMING `，走媒体音量试下，看看还会不会有问题。
使用[setAudioScenario](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_audio_basic#setAudioScenario:)来切换。

---

# ID: 37467

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我现在集成完rtm + rtc sdk 大约为520M了  我想减少体积，不需要扩展功能，只要音视频+rtm消息能力就行，如何集成，尤其是rtm  

Reply: 您好，需要裁剪 RTC SDK 体积的话可以参考[减小 app 体积](https://doc.shengwang.cn/doc/rtc/ios/best-practice/reduce-app-size)

---

# ID: 37470

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.5.1

Request Type: 其他问题

Request Description: 提审google play
libs/arm64下 检测到 libAgoraRtcWrapper.so 文件不支持16kb

Reply: 您好，官网的版本确实没有适配，您可以去 github 获取最新版本 main 分支的 SDK 使用，或者等候人工工程师提供离线下载版本。

---
# ID: 37471

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: 我们的业务场景是主播通过手机apk开直播，同时玩电脑游戏，需要将电脑画面也推送到直播间

Reply: 您好，电脑端需要屏幕共享的话需要集成 [Windows 客户端 SDK](https://doc.shengwang.cn/doc/rtc/windows/get-started/run-demo) 或者使用 [RTMP 网关](https://doc.shengwang.cn/doc/rtmp-gateway/restful/landing-page)来解决。

---

# ID: 37477

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 线上报错

Request Description:
```log
edu_sdk@2.9.40.bundle.js:2 2025-10-10 15:08:58 ERROR Ins#2 RTM:ERROR  Error Code 2 - Login is rejected by the server. The response code is 2010026. +0ms
edu_sdk@2.9.40.bundle.js:2 2025-10-10 15:08:58 INFO [AGRtmManager] ConnectionStateChanged DISCONNECTED LOGIN_FAILURE
edu_sdk@2.9.40.bundle.js:2 2025-10-10 15:08:58 ERROR Ins#2 RTM:ERROR Error Code 2: login failed with args: {"uid":"z*"}. +1ms
edu_sdk@2.9.40.bundle.js:2 2025-10-10 15:08:58 ERROR Ins#2 RTM:ERROR Already in logout state. +1ms
edu_sdk@2.9.40.bundle.js:2 2025-10-10 15:08:58 ERROR [RteErrorCenter] error 200004: RtmUnavailableError:  Error Code 2 - Login is rejected by the server. The response code is 2010026. 
```

Reply: 您好，请检查下当前 appid 是否是灵动课堂专用 appid，如果是通用项目的话需要手动开启 RTM 和灵动课堂开关才能使用，建议直接新建一个灵动课堂专用的 appid。

---

# ID: 37481

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 崩溃（闪退、卡死）

Request Description: 我的设备总是报错，发生Segmentation fault，AI提醒我可能SDK版本不对，SDK的浮点功能是 VFPv3-D16，但是我的系统是 VFPv4，sdk是Agora-RTSALite-RmRdRcAcAjCF-arm-linux-musleabi-v1.9.6-20250807_174733-826766。如果版本不兼容，能提供兼容的版本吗？

Reply: 您好，请稍等，人工工程师稍后为您处理

---

# ID: 37488

SDK Product: IM

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description:     <dependency>
                <groupId>io.agora</groupId>
                <artifactId>authentication</artifactId>
                <version>2.0.0</version>
            </dependency> 
jdk1.8版本报错
```log
Exception in thread "main" java.lang.NoSuchMethodError: java.nio.ByteBuffer.rewind()Ljava/nio/ByteBuffer;
	at io.agora.media.ByteBuf.asBytes(ByteBuf.java:23)
	at io.agora.media.AccessToken2.getSign(AccessToken2.java:143)
	at io.agora.media.AccessToken2.build(AccessToken2.java:105)
	at io.agora.chat.ChatTokenBuilder2.buildUserToken(ChatTokenBuilder2.java:28)
```


Reply: 您好，直接 clone 仓库到本地去运行脚本[生成 token](https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication#token-code)就行。Maven 对于 JDK 的版本要求较高，不支持 JDK 1.8。

---

# ID: 37490

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: obs加载插件异常

Reply: 您好，要用 OBS 推流到 RTC 频道的话不建议用插件了，可以用 [RTMP 网关](https://doc.shengwang.cn/doc/rtmp-gateway/restful/landing-page)

---

# ID: 37421

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.5.1

Request Type: 其他问题

Request Description: app还在测试开发中怎么就人工被限停了。上架都没上架呢。

Reply: 您好，可以优先电话联系您的对接销售或者登录声网 console，查看站内信了解下目前账号的状态，以及了解如何恢复账号至可用状态。

---

# ID: 37423

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.0

Request Type: 崩溃（闪退、卡死）

Request Description: 你好，视频中经常遇到自动关断的问题

Reply: 您好，请问这个关断具体的现象是什么？是在rtc直播的过程中app突然闪退吗？
如果是崩溃或者是闪退的话麻烦您提供下agora的sdk log、堆栈、时间点，我们解析下看看

---

# ID: 37424

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 集成问题咨询

Request Description: 第一次共享屏幕一切正常，但是第二次共享，接收端就没声音和画面了。
第二次共享，接收端接收到了新的streamUuid，也订阅了，但是没用。
这个时候发布端如果重新进一下教室，就又可以了。

发布端Uid 71
接收端Uid 166

共享StreamUuid 有很多，可以用1391045657查看数据。

Reply: 您好，请问第二次屏幕共享远端看不见的时候，发送端浏览器 console 有没有什么报错打印？麻烦提供具体的报错信息或者复现问题时 console 输出的录像。

---
# ID: 37425

SDK Product: RTC

SDK Platform: React

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 我想在我的expo框架开发的移动app中，集成一个实时语音通话功能，我看到很多文档，我是初学者，看不懂啊，该如何使用，不是集成一个api就可以了吗，怎么文档这么多分类，我也集成过api的其他功能，但你们这个好像很多，看不懂，请问我的这个技术框架，有合适的api吗

Reply: 您好，SDK 支持Expo 框架，可以参考下我们的 [RN Demo](https://github.com/AgoraIO-Extensions/react-native-agora/tree/dev/expo/examples/expo)。
SDK 用的就是 [RN SDK](https://doc.shengwang.cn/doc/rtc/rn/landing-page)。

---
# ID: 37426

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 调用接口：创建 converter
url `https://api.sd-rtn.com/cn/v1/projects/0f633a491a8d447694bfde9ff9ac843a/rtmp-converters`

body
```json
{
	"idleTimeout": 3600,
	"name": "LBR-761891034582458368",
	"rawOptions": {
		"rtcChannel": "LR-762215856890925056",
		"rtcStreamUid": 94224640
	},
	"rtmpUrl": "rtmp://push-agora.commands.top/live/LR-762215856890925056"
}
```

一直响应 400 bad request
麻烦帮忙看下哪里有问题，很急！感谢！

Reply: 您好，400 错误可能表示您的 AppID 未开通声网的服务端旁路推流功能。请登录声网控制台，确认该 AppID 是否已开通此功能。
如果确认开通了，请对照我们的[接口文档](https://doc.shengwang.cn/doc/media-push/restful/media-push/operations/post-region-v1-projects-appId-rtmp-converters)检查 body 里是否有字段缺失

---

# ID: 37428

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 开通权限、提供配额

Request Description: 无法添加域名
域名已备案，大于10天，换了多个备案域名均提示未备案

Reply: 您好，如果您的域名本身已经备案过，但是在 console 配置提示没有备案，可以先修改地区为大陆以外地区，然后提供下域名、推拉流地址，人工工程师稍微为您手动修改回大陆区域来解决。

---
# ID: 37429

SDK Product: IM

SDK Platform: Web

SDK Version: 1.3.2

Request Type: 线上报错

Request Description: 线上聊天室，在线聊天可以收到聊天信息。刷新页面后，聊天室消息就全部不见了，拉取不到历史消息是什么原因？

Reply: 您好，麻烦提供下具体出现问题的 appid，我们先查询下是否有开通 IM 的消息漫游权限，只有开通后产生的消息会存储。

---

# ID: 37431

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: 我需要注销声网账号，但是账户内有余额需要提现才能注销，现在提现有提示仅限365天内的交易。导致我无法注销，我自愿放弃账户内的余额和相关权益，帮我注销账号！谢谢

Reply: 您好，注销账号有固定流程，如果您有对接销售请优先联系对接销售。如果没有对接销售可以在声网 console 左侧边栏-设置-安全设置里自行完成注销流程。但如果有余额是需要先提现完毕的。

---

# ID: 37433

SDK Product: RTM

SDK Platform: Object-C

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: pod 'AgoraRtcEngine_iOS', '4.5.0' # 去重版本
  pod 'AgoraRtm_iOS',        '2.1.7'

我用的是这两个版本  为什么找不到AgoraRtmClient的对象来发信令
按文档 按AI的意思都拿不到client相关发信令 只有AgoraRtmClientConfig类 但是它发不了信令

rtm + rtc 推荐如何集成最新 且不会冲突  
以上两个版本是我查到的最新不会冲突的 但是用起来拿不到类去发信令

请给出具体解决方案

Reply: 您好，RTM 2.x 发送消息需要先创建 `AgoraRtmClientKit `实例，然后调用`publish `方法。可以参考文档[实现收发消息](https://doc.shengwang.cn/doc/rtm2/ios/get-started/quick-start)

---

# ID: 37442

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 为啥微信充值了20，界面余额还是零呢？

Reply: 您好，到账可能会有延迟，可以稍作等待。如果长时间等待后依旧没有确认到账可以先电话联系 400 6326626，会有人工跟进为您内部确认。

---

# ID: 37444

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我想要 下载     implementation 'io.agora.rtc:full-sdk:4.1.1'  版本的SDK，原因：直接使用 使APK体积增大

Reply: 您好，优先推荐使用最新版本，最新版本下载地址为[下载 SDK](https://doc.shengwang.cn/doc/rtc/android/resources)
如果要下载历史版本，可以访问[海外下载页](https://docs.agora.io/en/sdks?platform=android)

---
# ID: 37445

SDK Product: RTM

SDK Platform: Java

SDK Version: 其他版本

Request Type: 其他问题

Request Description: RTM消息数9月份达到1.9亿条，是去年9月的2.5倍，2025年最高是5000万条，请排查一下消费在哪些地方

Reply: 您好，可以提供下目前需要核实的 appid，人工工程师稍后为您查询

---

# ID: 37447

SDK Product: Console

SDK Platform: All

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 在和你们的商业对接，叫我技术问题发工单，以下是所有问题。

收费规则我有些疑惑:
1. 这个分钟的消耗方式，是只要频道里记录有人就会触发，还是按实际的pcm音频包时长触发？
2. 是只有音频产生者按产生音频消耗，还是所接收这个行为也会消耗？


对于功能
1. （convoAI）我看你们的大语言模型和语言生成模型是第三方接入的方式，放你们的后端运行的。大语言模型这部分，需要做一些逻辑处理，出于安全性和隐私性考虑，可不可以从你们的后端独立出来，在我们的后端运行。也就是：你们音频处理完给我们，我们大语言模型处理完，再回给语音生成。这样的计费是否和语音房一样？
2. （视频推流）你们是否支持UE的pixel streaming？这个计费是按视频推流的逻辑，还是要就图形算力额外计费？
3. （视频优化）我看你们有超分，这个超分是跑在后端还是客户端的？视频推流是否可以通过这个减少流量从而减少费用消耗？还是这算是通过超分加强流畅度？

Reply: 您好，关于计费：
1、收费是按连接来收费的，只要加入了我们的 RTC 频道和我们的节点保持连接就收费，不管是否发流。
2、如果产生了视频订阅，就会收取视频费用，详见[计费策略](https://doc.shengwang.cn/doc/rtc/android/billing/billing-strategy)

关于功能：
1、convoAI 本身不保存用户信息，所以不需要担心隐私问题，我们只做传参到第三方的通道，本身不会保存和擅自使用的。如果要完全独立的话，可以考虑下 [TEN](https://github.com/TEN-framework/ten-framework)
2、我们是按照订阅分辨率收费的，参考[计费策略](https://doc.shengwang.cn/doc/rtc/android/billing/billing-strategy)，发送到频道里是什么分辨率，被订阅时我们就按照什么分辨率计算，无论视频流是从哪里来的。
3、超分在客户端上启用，4.3.x 以后默认开启，让用户在 720 p 的分辨率下得到 1080p 的观感（举例，实际就是低分辨率上体验高分辨率视觉感受）

---

# ID: 37451

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 我们需要在频道里英文输出音频(国内用汉语然后翻译成英文,用的是科大讯飞在线翻译),汉语转成英语音频，如何实现？

Reply: 您好，需要用到第三方 TTS SDK 来把文本读出来，然后在用自采集把音频流发送到 RTC 频道里来实现

---

# ID: 37454

SDK Product: RTC

SDK Platform: Windows

SDK Version: 其他版本

Request Type: 其他问题

Request Description: sid:da49c18ba04e7b531cee518434265193
视频在录制9分钟之后，没有音视频流，只有屏幕共享流

Reply: 您好，可以检查下当时给录制段使用的 token 是否只有 10 分钟权限，如果确认 token 时长正常，可以稍等一下，人工工程师稍后为您解答

---
# ID: 37455

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 其他问题

Request Description: import AgoraRTC from 'agora-rtc-sdk-ng'
```javascript
	// ⚠️ 这些参数需要你们后台生成并传给 H5
	// const appId = '7e95dc00461c42de90449416359b5a9a'
	const appId = 'd92ed3db692c43f587d1d1157ba9baa9'
	// const channel = '666'
	const channel = '10040'
	// const token =
	// 	'007eJxTYAh9/zfCaf6pjPqSNxOXHahab2hoHsP5qZC7TIldq/OJU5ECQ4qlUWqKcUqSmaVRsolxmqmFeYphiqGhqXlSomVSYqJlUdjzjIZARoZ7CdcYGKEQxGdmMDMzY2AAADepHuA=' // 如果开了安全认证必须要

	const token = '006d92ed3db692c43f587d1d1157ba9baa9IAB2Ukb0jN0hRMCe6wDHaGHnzSigl0Tio+keZmn13pmqyEG40BOSfKAZIgAfuO3L5MToaAQAAQDkxOhoAgDkxOhoAwDkxOhoBADkxOho'
	const uid = 10011 // 让声网自动分配

```
我这边 appid token uid 都能拿到也不报错就是  黑屏

Reply: 您好，建议优先检查目前所用的 token 和加入频道时传入的频道号、uid 是否匹配

---

# ID: 37458

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 没有回调 serviceType 等于 2的，只有等于1的

Reply: 您好，看描述是录制上传出现了一些问题。可以提供下具体的 sid，人工工程师为您检查下任务情况。

---
# ID: 37459

SDK Product: IM

SDK Platform: Unity

SDK Version: 1.3.2

Request Type: 商务问题

Request Description: 即时通讯IM产品 Unity的SDK 下载链接显示无内容呢，请问哪里可以下载到IM产品 Unity平台的SDK 

Reply: 您好，首页最下方是下载地址，可以下载到 IM 的 SDK

---

# ID: 37407

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: 你好我想使用灵隼物联网平台二次开发，有问题求助
我在开发文档里看到设备端支持linux等，没有提及支持windows，这里的Linux支持你们是会提供什么给我们吗
开发文档里的创建实例视频，我跟着操作感觉不一样，创建不了，是我还没有申请lisense的原因吗，可以给我更清晰的指引吗
最后我需要申请lisense，除了官网的开发文档还有什么相关的资料可以给我参考吗？
感想您的查看及提供的帮助！

Reply: 您好，灵隼后续会下架，不建议使用了。
有 IOT 设备建议使用 [RTSA SDK](https://doc.shengwang.cn/doc/rtsa/c/get-started/run-example)
涉及 License 需要联系商务对接，可以电话沟通：400 6326626

---
# ID: 37408

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 问一下到底支持string类型的uid和rtcbotuid吗，以及user token和bot token需要分别生成还是用同一个就行

Reply: 您好，enable_string_uid建议关掉，用 int 类型的 uid，SDK 对于 string uid 的优化不如 int
以及 token 是一个 uid 一个 token 的，频道里 uid 不能重复，所以频道里用户的 token 和智能体的 token 不能混用
临时 token 不校验 uid 所以能进频道，自己生成的 token 是要校验 uid 的，需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道
控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验
将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致

---
# ID: 37409

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我当前在集成多频道连线的功能，我加入副频道的时候调用的推测是调用`joinChannelExByToken`这个方法
我调用之后呢joinRet的值是0，但是我的joinSuccess不会调用，我看文档说会调用,我也是不会调用的这是为什么？

Reply: 您好，推测是调用`joinChannelExByToken` 的时候所用的 token 并不匹配 uid 导致的。建议检查下 token。

临时 token 不校验 uid 所以能进频道，自己生成的 token 是要校验 uid 的，需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道
控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验
将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致

因为`joinChannelExByToken`用到的 uid 不同，所以 token 是不能通用其他 uid 的

---
# ID: 37410

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.3.0

Request Type: 开通权限、提供配额

Request Description: 请把这三个项目的频道人数上线调整到 32人

Reply: 您好，现在每个 appid 默认支持 32 人同时发音频流，17 人同时发视频流，请问是需要上调视频流发流上限吗？

---
# ID: 37411

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.5.1

Request Type: 其他问题

Request Description: 我想咨询一下，客户端本地采集的声音经过3A处理后本地能拿到音频流吗，我们是想实现阿里实时语音识别时（识别时能不识别电脑正在播放的声音），只识别人的说话。谢谢

Reply: 您好，可以用[音频裸数据](https://doc.shengwang.cn/doc/rtc/unity/advanced-features/raw-audio-data)，不过拿到的是 3A 处理前的原始采集数据。

---

# ID: 37417

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 效果不佳、不达预期

Request Description: 请问现在bot是等llm全部回复完了再生成语音吗，还是llm产生第一个单词就开始生成？

Reply: 您好，是第一个单词就开始，LLM 是流式输出，TTS 是进来多少内容读多少内容的

---

# ID: 37389

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 对话式AI引擎sdk如何获取当前链路的延迟情况，包括端到端延迟、级联各个流程的延时，没有找到sdk哪里可以回调这些数据，希望帮忙解答一下，谢谢。

Reply: 您好，我们暂未对外开放 convoAI 各个环节延迟数据的展示，但如果您有需求的话，可以提供下 agentID，我们有内部界面可以看到，人工工程师稍后跟进可以给您截图

---
# ID: 37390

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 效果不佳、不达预期

Request Description: 从人说话到bot回复最快也要2.几秒，看下改怎么调优才能达到官网的650ms效果

Reply: 您好，人工工程师稍后查询 agentID 来判断耗时点在哪里，您可以先自行尝试更换下 ASR、TTS 等厂商，对比看下不同厂商之间的效果是否有差异。

---
# ID: 37391

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 我想使用单聊和群聊功能，集成了下面2个依赖
```
    implementation 'cn.shengwang.rtc:full-sdk:4.6.0'
    implementation 'cn.shengwang:chat-sdk:1.3.2'
```

运行时后，RtcEngine初始化失败，但是单独集成rtc就不会为null

Reply: 您好，请问单聊和群聊是文字聊天场景吗？rtc:full-sdk:4.6.0 是音视频通讯的 SDK，没有文字聊天的能力。
chat-sdk:1.3.2 是 IM，只能文字聊天，本身自带单聊+群聊，但不支持音视频聊天。
请先确认下场景和需求

---

# ID: 37394

SDK Product: Marketplace

SDK Platform: Android

SDK Version: 自然语言处理

Request Type: 开通权限、提供配额

Request Description: 没有权限。

Reply: 您好，云市场插件需要联系商务后才能申请证书使用，请先联系：400 6326626

---

# ID: 37396

SDK Product: IM

SDK Platform: Flutter

SDK Version: 1.3.2

Request Type: 崩溃（闪退、卡死）

Request Description: 引入了 `shengwang_chat_uikit: ^2.0.1`
安卓ios正确的配置权限
```dart
ChatUIKit.instance.init(options: Options.withAppId(ShengWangConstant.appId, autoLogin: false)).then((res) {
    runApp(const Page());
  });
```

启动项目报错：No implementation found for method init on channel
什么情况？

Reply: 您好，请先检查本地是否有下载 SDK，并先参考我们的文档来[跑通 Demo](https://im.shengwang.cn/docs/uikit/chatuikit/flutter/chatuikit_run.html)。

---

# ID: 37398

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 效果不佳、不达预期

Request Description: 在Unity插件中，安卓平台下，切换到后台依然在正常语音通话。想问一下有没有相关配置或者接口，让在切到后台的时候自动关闭

Reply: 您好，您可以在 Native 侧自行监听切后台事件，然后调用`leaveChannel`来结束通话

---
# ID: 37399

SDK Product: IM

SDK Platform: iOS

SDK Version: 1.3.2

Request Type: 集成问题咨询

Request Description: 用户退回到后台，收到新消息会有推送通知吗

Reply: PermalinkEditDelete
您好，IM不会，切到后台 差不多20s到40s 的时间就会断开，目前 IM SDK 无法实现保活效果。

---
# ID: 37400

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 在服务端API中有一个创建对话式智能体的接口，我看文档中对此接口进行了更新，可以添加avatar字段，实现数字人。
我想知道avatar中的vendor字段，数字人供应商支持哪几家。
avatar下的params有没有具体的格式。

Reply: 您好，请参考[接口文档](https://doc.shengwang.cn/doc/convoai/restful/convoai/operations/start-agent)来了解数字人信息。

---

# ID: 37372

SDK Product: RTC

SDK Platform: Windows

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 
1. `NEXT_PUBLIC_APP_ID`  这个就是项目中的APP ID
2. `NEXT_PUBLIC_CLIENT_ID`
3. `NEXT_PUBLIC_CLIENT_SECRET`
4. `NEXT_PUBLIC_API_KEY`

你们的这些东西真是太难区分了，我找了半天了，也找不到,还有项目中的那些都对应的哪些值？你们至少弄个其它字母开头区分吧？
或者直接用这些变量名标识出来。。。。。。特别是 `NEXT_PUBLIC_CLIENT_ID` 和 `NEXT_PUBLIC_API_KEY` ，还有项目中对应的APP主要证书指的是什么？RESTful API中的客户ID/key对应的是什么？

Reply: 您好，请问 `NEXT_PUBLIC_APP_ID` 是在哪里看到的命名方式？我们的[术语库](https://doc.shengwang.cn/basics/glossary)只有 appid app证书，restful 的 ak sk就叫 API KEY 和 SECRET ，没有 NEXT 的前缀。

---

# ID: 37375

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 麻烦看一下这个bot为啥加不进去，token验证可以使用：
```json
{
	"name": "461a6e5e6b204b52a887e5f42cd84b6a:111",
	"properties": {
		"channel": "111",
		"token": "007eJxSYEh+vcJjasb0Ods7rXZWlQqutOy8HRWnJ/9gugzX5a6/K74oMJiYGSaapZqmmiUZGZgkmRolWliYp5qmmRglp1iYJJklnp15I0OAj4Eh5Zw+AyMDIwMLAyMDiM8EJpnBJAuUbWhoCCYAAQAA///d4x9b",
		"agent_rtc_uid": "196009864237980615",
		"remote_rtc_uids": ["111"],
		"enable_string_uid": true,
		"idle_timeout": 60,
		"advanced_features": {
			"enable_aivad": true
		}
	}
}
```

Reply: 您好，可以检查下目前在用的 token 本身是否匹配 agent 被分配的 uid 和要加入的频道号，通常是 token 错误导致智能体无法加入频道。

---

# ID: 37381

SDK Product: Media-pull

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: NCS 健康检查结果: Test Failed

Reply: 您好，健康检查不通过说明域名无法直接被我们访问，请检查回调地址本身状态，以及确保使用域名，不要用裸 IP 的 url。

---

# ID: 37385

SDK Product: RTC

SDK Platform: Windows

SDK Version: 其他版本

Request Type: 崩溃（闪退、卡死）

Request Description: git clone https://github.com/Shengwang-Community/API-Examples.git 下载example这是里面的windows example，点开sln，报错里面的Agora引擎不存在，搜遍文件夹，确实也没找到。
1. 请问下stdafx.h是干嘛的？做配置的？
2. 请问我是否需要自己再链什么东西进去？

```log
1>E:\PluginSDK\API-Examples\windows\APIExample\APIExample\stdafx.h(49,10): error C1083: Cannot open include file: 'IAgoraRtcEngine.h': No such file or directory
```
stdafx.h里说我两个引擎的头文件没找到

Reply: 您好，请参考文档[跑通 Demo](https://doc.shengwang.cn/doc/rtc/windows/get-started/run-demo)，stdafx.h 需要填写对应的 appid 信息来启动 Demo。

---

# ID: 37346

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: domain选us，tts用elevenLabs时报错：`Unknown service tts_service vendor elevenLabs`

Reply: 您好，elevenLabs 是海外才支持的 tts，您需要调用[海外版本 convoAI](https://docs.agora.io/en/conversational-ai/rest-api/join)的接口。

---

# ID: 37348

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 观众端加入直播间   在主播端的日志没有任何反应

Reply: 您好，因为观众人数较多，所以 SDK 设计时就设定观众加入频道就是无法感知的。如果需要感知观众进出频道的事件，可以用 [Webhook 事件](https://doc.shengwang.cn/doc/rtc/restful/webhook/events#105-audience-join-channel)去做，不过人多的时候回调就会非常频繁,还请注意。

---

# ID: 37353

SDK Product: RTC

SDK Platform: Electron

SDK Version: 4.4.0

Request Type: 线上报错

Request Description: 应用场景：pc的electron端使用electron-sdk@4.4.0，投屏至会议中；

问题：其他用户（1231793）从会议中获取到的视频流是黑屏状态，从投屏端获取到的localStat日志显示推流的分辨率为0x0；

Reply: 您好，听起来是本地采集启动失败了，可以检查下是否有授予屏幕采集的相关权限，如果没给权限的话，`startScreenCaptureByWindowId `是会报错 `ERR_SCREEN_CAPTURE_PERMISSION_DENIED(16) `的，可以在 console 里或者 SDK 日志里查看到。

---
# ID: 37354

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 1、怎么查看拉流地址；
2、OBS 推流 → RTMP → 观众播放（网络错误），这问题怎么解决？
3、RTMP 播放需要转换：OBS → RTMP 推流 → 流媒体服务（声网） → 服务端转成 HLS (m3u8) → 浏览器端再播放。这个怎么实现 服务端转成 HLS (m3u8) ？

Reply: 您好，请问您现在用的是 CDN 还是 RTMP 网关？RTMP 网关是把流推进 RTC 频道里的，观众端需要加入 RTC 频道才能看见画面。CDN 才是直接让观众拉流观看的，这是两套不同的技术方案。

---
# ID: 37355

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: 65474407 与 320524722 连麦 到10:52正常
10:52:32 加入 385926281，这个 385926281 在10:52:33时候没有画面合进来，而SEI对应的布局是包括的，也就是已经发出合流指令了
```log
2025-09-26 10:59:32.922000 +0800 - level 6 tag = sofa_video_decoder_manager msg = get_sei_info pts 192.666667,{"app_data":"{\"t\":1}","canvas":{"bgnd":"#36363d","h":1280,"w":720},"regions":[{"alpha":255,"h":643,"uid":320524722,"volume":0,"w":360,"x":360,"y":540,"zorder":50},{"alpha":255,"h":643,"uid":65474407,"volume":0,"w":360,"x":0,"y":540,"zorder":50},{"alpha":255,"h":540,"uid":385926281,"volume":0,"w":720,"x":0,"y":0,"zorder":80}],"ts":1758855153793,"ver":"20190611"}

"ts":1758855153793：转换 2025-9-26 10:52:33
```
但是直播画面还是只有 65474407 与 320524722，直到 10:52:42后才出现 385926281 画面

问题在于：同时间点 sei 给的 合视频画面不对应，及给了布局到实际没有画面，等到10s后才出现画面，具体如视频

Reply: 请问您现在合图是怎么实现的？调用我们服务端接口做的吗？
客户端旁路推流接口已经不再更新维护了，如果使用客户端接口去更新旁路推流合流布局的话请早日迁移到[服务端旁路推流](https://doc.shengwang.cn/doc/media-push/restful/landing-page)去实现。

---

# ID: 37360

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 其他问题

Request Description: 加入频道失败返回错误： CONNECTION_CHANGED_REJECTED_BY_SERVER   此用户被服务器禁止 。前段时间可以正常使用， 最近加入就会返回这个错误。

Reply: 您好，CONNECTION_CHANGED_REJECTED_BY_SERVER 表示您调用了我们的[踢人接口](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/post-dev-v1-kicking-rule)把指定用户踢出频道了，可以检查下业务上哪里在执行踢人的操作。

---
# ID: 37361

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 效果不佳、不达预期

Request Description: 1、使用声网Android SDK，加入语音群聊后，因为被占用了音频焦点。无法播放音乐。
2、发生时间点在`09-26 15:50:52.986 D 1292     3494     NotificationService:                                                                Show pkg=com.gwm.app.media.qqmusic text=`
音频被占用，无法播放 

Reply: 您好，可以把 scenario 切 GS 试下，走媒体音量不会有压制问题，[setAudioScenario](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#api_irtcengine_setaudioscenario)。


---

# ID: 37329

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.1

Request Type: 崩溃（闪退、卡死）

Request Description: 显示闪退，libc 崩溃，最终堆栈指向了io.agora.rtc2.internal.RtcEngineImpl.nativeObjectInit(Native method)

Reply: 您好，麻烦提供 bugly 或者 bugreport 之类的原始堆栈和对应时间的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)并说明崩溃发送的具体时间和复现频率，人工工程师稍后为您解答

---

# ID: 37331

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 商务问题

Request Description: 云录制为什么这么贵，跟文档里标注差很多

Reply: 您好，云录制分两种录制方式，页面录制的单价是比单流合流要贵的。[页面录制](https://doc.shengwang.cn/doc/cloud-recording/restful/overview/billing-strategy/webpage-billing)是 90 元/千分钟。
具体计费细节可以咨询您的对接商务，如果没有商务的话可以电话联系：400 6326626

---

# ID: 37333

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 安卓端和web端，安卓端麦克风，喇叭，摄像头设备三种都是单独的usb插在设备上，web端只能收到播放视频，音频无效，但是安卓端使用哪种圆孔的麦克风喇叭一体的就正常

Reply: 您好，请问Android 用 usb 麦克风的时候使用微信可以正常收发语音消息吗？可以测试下微信或者系统录音功能，确认下系统本身是否能正常识别+工作。
如果正常工作的话，可以尝试在 join 之前配置`audioScenaio`的枚举为`Gamestreaming`或`Chatroom`来对比看下效果是否有改善。
相关接口[setAudioScenario](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#setAudioScenario)。

---
# ID: 37334

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 咨询一下，海外版本是无法使用minimax的tts吗，我司海外业务同时在使用minimax和11labs，该如何接入

Reply: 您好，minimax 可以在海外使用，可以支持海外业务，具体可以咨询 minimax 侧。

---
# ID: 37335

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: tts使用minimax没反应，agentID: A42AC66XH28RD64FL83VC24LC86NW44D

Reply: 您好，可以确认下 tts 账户目前是否有欠费，以及如果您在用海外 minimax 服务的话需要更换域名 为 io 后缀，国内是.chat
```json
"vendor": "minimax",
"params": {
"url": "wss://api.minimax.io/ws/v1/t2a_v2"
}
```

---
# ID: 37336

SDK Product: Fastboard

SDK Platform: iOS

SDK Version: 1.4.2

Request Type: 效果不佳、不达预期

Request Description: iOS端怎么加入房间，不能操作白板，我没找到方法。 我在web端操作code edited那些，IOS端不显示

Reply: 您好，创建白班房间后调用[joinRoom](https://doc.shengwang.cn/api-ref/fastboard/ios/fastboard-api#joinroom)来加入白板房间。
Demo里自带的组件只是示例，不一定能全平台都看见，统一效果。有上线需求建议自定义组件来满足。

---

# ID: 37339

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 如附件所示，我现在想要录制一种环绕布局（中间一个人，边上很多人围绕着），现在有个问题，比如说现在只有两个人，那么其他人的区域（画红线的区域）显示的是默认背景色很丑，有什么好的办法吗？比如整体能设置成一个图片吗？（backgroundImage我设置了但是从效果看没有起效）

Reply: 您好，这类需求需要用自定义布局自行实现，可以参考下类似效果的示例 body：
```json
"transcodingConfig": {
            "width": 1920,
            "height": 1080,
            "fps": 15,
            "bitrate": 5000,
            "backgroundImage": "xxx,
            "mixedVideoLayout": 3,
            "layoutConfig": [
               {
                  "uid": "12345",
                  "x_axis": 0.0,
                  "y_axis": 0.0,
                  "width": 0.5,
                  "height": 0.5
               }
            ]
         }
```

---

# ID: 37342

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 你好, 我的应用是在android采集声音, 但是是采集嘉宾的声音, 允许有一定时间的没有声音, 例如上一个嘉宾上台加上下一个嘉宾下台的过程, 但是现在RTC好像在30s左右没有声音就停止了, 无法接收声音了, 请问可以自定义这个时间么或者彻底关闭这个超时的设置. 

Reply: 您好，听起来是业务问题导致，RTC SDK 本身没有自动限制的处理。可以提供下出现问题的用户 [SDK日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，人工工程师稍后看下具体原因。
您也可以先对比下我们 Demo 的处理，参考 [Demo](https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo)。

---
# ID: 37343

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 集成问题咨询

Request Description: 如何获取可输出的音频设备，并切换到具体的音频设备

Reply: 您好，移动设备的音频输出设备选择是系统决定的，SDK 侧无法调整。
如果您需要在桌面端调整，可以使用[setPlaybackDevice](https://doc.shengwang.cn/api-ref/rtc/flutter/API/toc_audio_device#api_iaudiodevicemanager_setplaybackdevice)

---
# ID: 37344

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 结束通话时，如何获取通话时长？

Reply: 您好，有三种方案推荐：
1、可以用客户端回调[onRtcStats](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_channel#callback_irtcengineeventhandler_onrtcstats) 里的`totalDuration `来判断。
2、可以订阅 NCS 回调，从对应的 NCS 事件里判断，例如 [104 事件](https://doc.shengwang.cn/doc/rtc/restful/webhook/events#104-broadcaster-leave-channel)的`duration `。
3、集成第三方 IM SDK，用长链接来自行计算加频道时长，这样不依赖我们的业务，更推荐一些。

---

# ID: 37319

SDK Product: RTM

SDK Platform: Java

SDK Version: 其他版本

Request Type: 线上报错

Request Description: 使用JavaSDK ，发送文本消息。  public native int sendStreamMessage(int stream_id, String data, int length);
连续多次返回错误码  -12  。

Reply: 您好，错误码 12 代表接口调用太过频繁，可以降低调用接口的频率再试试。

---
# ID: 37320

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.1.10

Request Type: 集成问题咨询

Request Description: 怎么接入sdk，maven地址下载不到东西了

Reply: 您好，maven 的引用应该是implementation 'io.agora:agora-rtm:2.2.5' 这样写的，可以参考[构建项目](https://doc.shengwang.cn/doc/rtm2/android/get-started/quick-start#%E6%9E%84%E5%BB%BA%E9%A1%B9%E7%9B%AE)
如果是服务端集成 SDK，可以参考[Agora-RTM2-QuickStart-Linux-Java](https://github.com/AgoraIO/RTM2/blob/main/Agora-RTM2-QuickStart-Linux-Java/pom.xml#L21)，写成
```xml
<groupId>io.agora</groupId>
<artifactId>rtm-java</artifactId>
<version>2.2.5</version>
```

---
# ID: 37321

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.5.0

Request Type: 线上报错

Request Description: 音量键控制音量大小没有效果，其他机型暂未发现问题。
手机型号 iPhone 16 pro ， iOS26

Reply: 您好，可以尝试重启设备再看下是否会复现，如果能够稳定复现，麻烦提供对应设备的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，并说明复现的具体时间点，人工工程师稍后跟进为您解答。

---
# ID: 37322

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.4.0

Request Type: 其他问题

Request Description: 我用本地的X86demo加频道，无论我token 写对还是写错 打印日志一样 完全看不出是推流是否成功

Reply: 您好，看您工单分类选的是 Windows，但实际描述像是 Linux SDK，请确认下现在在用的平台。
判断是否加入频道的状况可以参考[频道连接状态管理](https://doc.shengwang.cn/doc/rtc/windows/basic-features/channel-connection)，需要确保在频道内才能推流.
要确认本端发流状态的话可以监听[onVideoPublishStateChanged](https://doc.shengwang.cn/api-ref/rtc/windows/API/toc_video_basic#onVideoPublishStateChanged)回调。

---

# ID: 37325

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 想问下你们延迟最低的ASR+LLM+TTS 比如阿里云的ASR minimax的TTS  具体是使用对应厂商的什么服务啊 能给出他们官方定义的链接和服务名吗

Reply: 您好，我们没有阿里云的 ASR ，这些服务名称您直接找第三方厂商沟通就行了，比如找腾讯咨询 ASR 如何使用，找 minimax 咨询 TTS 如何使用。这些第三方服务的 ak sk 都需要在第三方平台注册以后获得。
评测延迟可以在[AI 模型评测平台](https://www.shengwang.cn/duihua/benchmark/overview?region=Shanghai)里查看。

---

# ID: 37328

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 换成微软的asr之后没反应。
agentid: A42AJ52RJ26EA36NN63HT44VK46VF55J

微软参数：
```json
		Asr: &req.JoinPropertiesAsrBody{
			Language: "zh-CN",
			Vendor:   req.ASRVendorMicrosoft,
			Params: req.ASRMicrosoftVendorParam{
				Key:    "b7b004024432464d96efac30fb6d0a40",
				Region: "eastus2",
			},
		},
```

Reply: 您好，可以先自查下有没有让 convoAI 订阅错远端 uid 的情况，如果自查无果可以等候人工工程师稍后跟进解答。

---
# ID: 37284

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 集成问题咨询

Request Description: 问题概述
类型: Python Server SDK + Web SDK 双工通信异常
频道名: solidchannel ✅ (确认双方均在同一频道)

核心现象:
Python Bot (UID: 12345) 与 Web 用户能进入同一频道，但 Web 无法检测到 Bot，导致无法建立双向音频通信。

Python Server 配置
```python
conn_config = RTCConnConfig(
    client_role_type=ClientRoleType.CLIENT_ROLE_BROADCASTER,
    channel_profile=ChannelProfileType.CHANNEL_PROFILE_LIVE_BROADCASTING,
    auto_subscribe_audio=1,
    auto_subscribe_video=1,
    audio_subs_options=AudioSubscriptionOptions(
        pcm_data_only=1, sample_rate_hz=16000, number_of_channels=1
    )
)

publish_config = RtcConnectionPublishConfig(
    audio_profile=AudioProfileType.AUDIO_PROFILE_DEFAULT,
    audio_scenario=AudioScenarioType.AUDIO_SCENARIO_AI_SERVER,
    is_publish_audio=True,
    is_publish_video=False,
    audio_publish_type=AudioPublishType.AUDIO_PUBLISH_TYPE_PCM
)

connection.connect(app_id, channel_name, "12345")  # Bot UID
connection.publish_audio()
```

Web 前端配置
```javascript
const client = AgoraRTC.createClient({ mode: "rtc", codec: "vp8" });
await client.join(appId, "solidchannel", null, "user_1758546836734");

client.on("user-published", handleUserPublished);
client.on("user-joined", handleUserJoined);
```

Reply: 您好，[初始化服务端 SDK](https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/agoraservice#initialize) 的时候不要配置用 stringuid，然后在conenctio里面传入的是对应 int 类型的字符串去加频道，需要先保证 RTC 频道内都是 int 类型 uid。

---

# ID: 37287

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description:  当我手机使用观众进入频道. 设备使用主播进入频道,  当我业务上, 把手机端的角色切成主播的时候, 看文档SDK 会自动调用 muteLocalAudioStream 和 muteLocalVideoStream 修改发布音视频流的状态。 我也设置了  setupLocalVideo  enableVideo ,日志显示 角色也切换成功了,   但是本地的视频视图始终不显示

如果是观众,切换到主播身份需要哪些配置, 当前我的设置如下:
```java
        flLocalVideo.removeAllViews()
        flLocalVideo.addView(
            localSurfaceView,
            ViewGroup.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT,
                ViewGroup.LayoutParams.MATCH_PARENT
            )
        )
        rtcEngine?.setupLocalVideo(VideoCanvas(localSurfaceView, Constants.RENDER_MODE_HIDDEN, getIntUserId()))
        rtcEngine?.setDefaultAudioRoutetoSpeakerphone(true)
       var result= rtcEngine?.setClientRole(Constants.CLIENT_ROLE_BROADCASTER)
        rtcEngine?.enableVideo()
        rtcEngine?.enableLocalAudio(true)
        rtcEngine?.enableLocalVideo(true)
```

Reply: 您好，要看自己画面需要 enableLocalVideo+setupLocalVideo+startpreview，请问您有执行吗？
建议参考下我们的 [Demo](https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo)。

---

# ID: 37289

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: 你好，我们在声网Channel 收发消息是遇到一个问题想咨询下。
我们的使用方式大体如下，Server创建Channel后客户端角色和Server角色分别进入Channel，Server会往客户端推送StreamMessage消息。我们实际测试发现，偶然会出现这样的情况：某一条消息Server只发送一次，但是客户端会在几毫秒内多次重复收到这个消息。我们排查了Server log，Server缺少只推送了一次。

不知道跟客户端设置`agoraKit.createDataStream(&streamId, reliable: true, ordered: true)`有无关系？

我们想咨询下发生这种情况可能的原因？有无解决方案？

Reply: 您好。推测是发送的时候有业务没写好导致了重复发送的情况，您可以用我们 [datastream Demo](https://github.com/Shengwang-Community/API-Examples/tree/main/iOS/APIExample/APIExample/Examples/Advanced/CreateDataStream) 尝试复现下，看看会不会有同样的情况。

---
# ID: 37290

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 这里有声网提供的SDK libagora-rtc-sdk.so是glibc编译的，但是我们用的SDK是musl,不匹配导致不能编译，需要声网用海思的工具链编译SDK出一个包。

Reply: 您好，可以参考下我们[下载页面](https://doc.shengwang.cn/doc/rtsa/c/resources)的命名规则，挑选 musl 的 SDK 来用。

---

# ID: 37292

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 效果不佳、不达预期

Request Description: 视频通话回音很大 自己能听到自己发出的声音 如何解决 官网的demo就不会有回音 

Reply: 您好，现在用的 SDK是最新的吗？可以升级到 4.24 再试试。以及您这边具体是什么场景和用法？最后通话用的浏览器是什么浏览器呢？

---

# ID: 37295

SDK Product: Flexible-classroom

SDK Platform: Web

SDK Version: 2.9.40

Request Type: 集成问题咨询

Request Description: 由于想问灵动会议相关文档，但是选项只能选择灵动课程；
我需要知道灵动会议web端的集成文档，以及试例

Reply: 您好，灵动会议不提供自服务集成，有集成需求可以电话联系销售开始对接 400 6326626

---

# ID: 37303

SDK Product: RTM

SDK Platform: JavaScript

SDK Version: 2.1.5

Request Type: 线上报错

Request Description: 提示RtmInvalidArgumentError: Error Code -15005 - History service is not available 历史消息不可用，之前没正式付费之前好的，

Reply: 您好，麻烦提供下出现问题的 [RTM日志](https://doc.shengwang.cn/doc/rtm2/javascript/error-codes)。
如果是 Web 端，可以提供下出现问题的 appid、userid、问题复现时间点，人工工程师稍后看下数据上报，同时也麻烦自查下目前在在用的 appid，在声网 console 里是否开启了历史消息功能的开关，新 appid 需要手动开通的。

---
# ID: 37304

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 集成问题咨询

Request Description: 想问一下flutter平台中的鸿蒙example如何成功运行，我这里遇到了AgoraRtcSdk.har包找不到的问题，把三个rar压缩后的har包也是损坏的，或者给我提供一个完整的har包，项目路径：https://gitcode.com/xilei123456/flutter/tree/main/agora_rtc_engine

Reply: 您好，目前我们的 flutter SDK 没有完全适配鸿蒙 SDK，鸿蒙官方已经停止了适配 flutter，所以暂无计划上线正式版。
如果您考虑鸿蒙原始 SDK 开发的话，可以用我们的[鸿蒙原生 SDK](https://doc.shengwang.cn/doc/rtc/harmonyos/landing-page)

---

# ID: 37259

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 商务问题

Request Description: 声网的插件中有一条数美的视频审核 请问这个怎么开通 我们已经买了数美的相关服务。

Reply: 您好，云市场插件使用需要先联系商务来对接，您可以先联系您的专属对接商务，如果没有的话可以电话沟通：400 632 6626

---

# ID: 37264

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 用量是否可以设置提醒？比如用到100000分钟 给我短信提醒？

Reply: 您好，我们会在用量到达特定百分比的时候发送短信服务。

如果您有更多的RTE用量需求，您可以选择购买预付费包月套餐和加油包，有12万分钟、40万分钟以及150万分钟三档供你选择，最高可享受8折优惠。
您可以前往声网控制台左侧边栏的“套餐包”下的“预付费套餐包”页面进行购买。具体路径为：控制台 > 套餐包 > 预付费套餐包。

如果您需要更多关于预付费套餐包的信息，请参考我们的[计费文档](https://doc.shengwang.cn/doc/rtc/android/billing/billing-strategy )或者电话咨询400 6326626。

---

# ID: 37270

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 加入渠道失败，token和UID都没有问题：
```json
{"action":"join","role":"broadcaster","appId":"xxx","customAudioCodec":null,"key_vocs":"007eJxTYDj/WPJq6KSiPEneqn0fw787z7ukekFVacddFfHzPsI+okoKDIZJRmnmSSkmJiZJqSZGSWmJpibGhgZGyUlppolJZuYpzLsvZHCwMzCsZF/4i5GBkYEFiEF8JjDJDCZZwKQCg6mpuZllqoWZUbJBoolJmkmSpYWlgYmlpYFlqnFSkrElG4OpgaWZpREApNwmEQ","key_vos":"007eJxTYDj/WPJq6KSiPEneqn0fw787z7ukekFVacddFfHzPsI+okoKDIZJRmnmSSkmJiZJqSZGSWmJpibGhgZGyUlppolJZuYpzLsvZHCwMzCsZF/4i5GBkYEFiEF8JjDJDCZZwKQCg6mpuZllqoWZUbJBoolJmkmSpYWlgYmlpYFlqnFSkrElG4OpgaWZpREApNwmEQ","channel_name":"55769e862c0a44f4b989049909e3bb39","uid":"509692","vid":"xxx","device":"iPhone 12/13 (Pro)","os":"iOS 10.0.1","version":"2.6.1","clientType":"wechat","audio_only":false,"uidType":0}}
```


Reply: 您好，token 本身没问题的话，大概率是本地传值有地方被写死了或者类型不对导致的，可以自行检查下。

---

# ID: 37277

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我这边直播开播后，但是观众和后台看不到直播内容，官方有看到直播后推流吗

Reply: 您好，请问您现在用的是 RTC SDK 吗？RTC 需要双方用相同的 appid ，不同的 uid 加入相同频道才能互通，请确认频道信息匹配。
以及关注下各自的[频道连接状况](https://doc.shengwang.cn/doc/rtc/android/basic-features/channel-connection)，确保真的加入了频道。
可以检查下有没有错误码打印，如果自查无果，请提供双方 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)。

---

# ID: 37279

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 云录制超过一个小时，停止时找不到资源，查看api说是要更细stsToken，参见图1
后台使用javasdk进行开始录制，并打算使用java后台更新这个stsToken，但是java api中没有找到如何更新的方法，见图二图三
麻烦提供一下更新stsToken的java样例

Reply: 您好，云录制没有办法中途 renew token，建议在 start 的时候直接分配有效时间长一点的 token。

---

# ID: 37231

SDK Product: RTC-Linux

SDK Platform: Linux-C

SDK Version: 4.4.30

Request Type: 集成问题咨询

Request Description: 
1. 希望在linux(ubuntu)平台下实现相机画面到web端的实时传输
2. web端demo已跑通
3. c++端demo可以运行但无任何画面 收发有数据但无法传输正确的视频数据(通过h264文件读写的方式)
问题: c++端应使用何种方式实现摄像头画面的正确推送，目前没有一个demo可以正常跑通

Reply: 您好，
1、[C++的 Demo](https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/resources)里没有放视频文件供测试，可以从这里下载[测试文件](https://download.agora.io/demo/test/test_data_202408221437.zip)。确定 Demo 里脚本引用的文件存在可以被找到，这样读取以后就能发送到频道里去了。

2、Linux 没有采集的说法，所以需要您自行获取视频音频原始数据，然后调用 SDK 里的发送接口发出去。Demo 只是演示如何从文件里拿到这些数据发出去，仅供参考。

---
# ID: 37232

SDK Product: IM

SDK Platform: Android

SDK Version: 1.3.2

Request Type: 集成问题咨询

Request Description: 请教下，如果我要基于声网IM实现互联网问诊功能，一个IM用户(如userId为u123)可能创建2个问诊订单（分别为自己和家人），且指向同一个医生(userId为d456)。我想以订单编号作为IM会话标识，这样，即使两个问诊会话是独立，互不影响。现在IM收发消息时，是指向对方userId，那就会导致两个问诊的对话是在一个会话中。是否有解决方案？

Reply: 您好，是不是发成群组或者聊天室消息了？应该用[私聊消息](https://im.shengwang.cn/docs/sdk/android/message_send_receive.html)传接收方的用户 ID，可以对照文档再检查下，如果还有问题，麻烦提供发送端、接收端的 [IM SDK 日志](https://im.shengwang.cn/docs/sdk/android/log.html)过来 。

---

# ID: 37234

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.3.2

Request Type: 集成问题咨询

Request Description: 之前发的sdk4.2.0，调用录制后分辨率需要调整成宽屏，不知道传参是什么，之前录制出来的视频宽度不够

Reply: 您好，目前希望视频是 16:9 的横屏吗？如果频道里原始发出来的画面就是 9:16 的，那肯定会有黑边。

---
# ID: 37236

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 1.双方可以进行音频通话，一开始渲染视频页面可以，双方处在接听页面时，自己得屏幕不显示，可以看见对方的屏幕
需要开通什么不

Reply: 您好，如果要实现画中画的效果，建议用 Native 来实现，[Demo](https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo) 里有画中画的示例，可以参考下。

不过Web 的画中画需要您用浏览器原生接口自行实现，我们没有示例

---

# ID: 37244

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.2

Request Type: 集成问题咨询

Request Description: 老师您好，想拿原始音频数据给后端生成实时字幕。但后端接收的音频采样格式是SAMPLE_FORMAT_S16LE	带符号的16位整数，小尾数。音频编码格式是pcm。现在拿到原始音频数据arraybuffer有点问题，没办法准确的识别出来，我看你们文档只能设置采样率。请问应该怎么解决

Reply: 您好，音频裸数据拿出来默认就是 PCM，请问您这边需要什么格式？

---

# ID: 37250

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 2.6.5

Request Type: 集成问题咨询

Request Description: 小程序客户端如何监听用户是否已经离开频道

Reply: 您好，小程序 clienton 事件里的 [stream-removed](https://doc.shengwang.cn/api-ref/rtc/mini-program/classes/client#on) 可以感知。

---

# ID: 37254

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 效果不佳、不达预期

Request Description:     
```java
RtcEngineConfig config = new RtcEngineConfig();
            config.mContext = this;
            config.mAppId = ConfigInfor.APPID;
            config.mEventHandler = mRtcEventHandler;
// 创建并初始化 RtcEngine
            mRtcEngine = RtcEngine.create(config);
            mRtcEngine.enableVideo();//视频
            VideoEncoderConfiguration videoEncoderConfiguration = new VideoEncoderConfiguration();
            videoEncoderConfiguration.codecType = VideoEncoderConfiguration.VIDEO_CODEC_TYPE.VIDEO_CODEC_H264;
            videoEncoderConfiguration.orientationMode = VideoEncoderConfiguration.ORIENTATION_MODE.ORIENTATION_MODE_FIXED_PORTRAIT;
            videoEncoderConfiguration.dimensions = VideoEncoderConfiguration.VD_840x480; // 降低分辨率
            videoEncoderConfiguration.frameRate = 24; // 降低帧率
            videoEncoderConfiguration.bitrate = 2500;  // 降低码率(单位kbps)
            videoEncoderConfiguration.degradationPrefer = VideoEncoderConfiguration.DEGRADATION_PREFERENCE.MAINTAIN_FRAMERATE;  // 降低码率(单位kbps)
            mRtcEngine.setVideoEncoderConfiguration(videoEncoderConfiguration);
            // 设置音频配置文件
            mRtcEngine.setAudioProfile(Constants.AUDIO_PROFILE_DEFAULT, Constants.AUDIO_SCENARIO_DEFAULT);
            // 启用音量指示
            mRtcEngine.enableAudioVolumeIndication(300, 100, true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        JSONObject params = new JSONObject();
        try {
            // 设置 camera_rotation 参数
            params.put("rtc.camera_rotation", 180);//旋转 到正常角度
        } catch (JSONException e) {
            e.fillInStackTrace();
        }
        mRtcEngine.setupLocalVideo(new VideoCanvas(svrLocal, VideoCanvas.RENDER_MODE_FIT, ConfigInfor.UID));
// 开启本地预览
        mRtcEngine.startPreview();
        // 创建 ChannelMediaOptions 对象，并进行配置
        ChannelMediaOptions options = new ChannelMediaOptions();
// 设置用户角色为 BROADCASTER (主播) 或 AUDIENCE (观众)
        options.clientRoleType = Constants.CLIENT_ROLE_AUDIENCE;
// 设置频道场景为 BROADCASTING (直播场景)
        options.channelProfile = Constants.CHANNEL_PROFILE_COMMUNICATION;

// 发布麦克风采集的音频
        options.publishMicrophoneTrack = true;
// 发布摄像头采集的视频
        options.publishCameraTrack = true;
// 自动订阅所有音频流
        options.autoSubscribeAudio = true;
// 自动订阅所有视频流
        options.autoSubscribeVideo = false;

```

看一下代码 有没有什么问题    一对一通话的时候没有问题  多人通话的时候就没有声音了 

Reply: 您好，不推荐使用CHANNEL_PROFILE_COMMUNICATION 以及在CHANNEL_PROFILE_COMMUNICATION 下配置身份为观众，建议修改 channelProfile 用 live，clientRoleType 用 broadcaster再试下。
最佳实践可以参考我们 [Demo](https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo)

---

# ID: 37215

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 效果不佳、不达预期

Request Description: 昨天使用了声网的云端录制，这是相关日志，为什么在一个程序里，会出现这种情况呢？前面生成了sid，后面结束录制的时候，给了日志，未找到sid。可以帮忙看下吗？
```log
2025-09-17 16:22:30,912 - agora_rtc_access.agora_recoder.acquire_resource - INFO - 资源获取成功！resourceId: xxx
2025-09-17 16:22:31,354 - agora_rtc_access.agora_recoder.start_recording - INFO - 录制启动成功！sid: 993ba05b7a4318557e17288b067884df
2025-09-17 16:22:31,354 - agora_rtc_access.agora_recoder.cloud_recorder - INFO - 云录制启动成功，resource_id: xxx, sid: 993ba05b7a4318557e17288b067884df
XXXXXXXXXXXXX（中间省略一些业务日志）
2025-09-17 16:41:08,391 - agora_rtc_access.agora_recoder.stop_recording - INFO - 录制停止成功
2025-09-17 16:41:08,392 - agora_rtc_access.agora_recoder.get_record_file_url - WARNING - 未找到sid
2025-09-17 16:41:08,393 - agora_rtc_access.agora_recoder.cloud_recorder - WARNING - 未能获取到录制文件URL
```


Reply: 您好，可以关注下 NCS 事件 31,31 事件上传完毕以后会直接给文件地址。
停止录制没有返回 sid 的原因大概率是 stop 请求的结果不是 200，sid 等响应字段只有 200 的时候才会返回，可以参考[停止云端录制](https://doc.shengwang.cn/doc/cloud-recording/restful/cloud-recording/operations/post-v1-apps-appid-cloud_recording-resourceid-resourceid-sid-sid-mode-mode-stop)。

---

# ID: 37217

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.5.1

Request Type: 其他问题

Request Description:         
```c#
public override bool OnRecordAudioFrame(string channelId, AudioFrame audioFrame)
        {
            Debug.Log("OnRecordAudioFrame-----------");
            // 获取经过3A处理的float[]数据
            // 复制原始音频数据
            byte[] rawBufferCopy = new byte[audioFrame.RawBuffer.Length];
            System.Buffer.BlockCopy(audioFrame.RawBuffer, 0, rawBufferCopy, 0, audioFrame.RawBuffer.Length);
            var floatArray = AudioRecordingManager.ConvertByteToFloat16(rawBufferCopy);

            lock (_AudioRecordingData._audioBuffer)
            {
                _AudioRecordingData._audioBuffer.Put(floatArray);
                _AudioRecordingData._writeCount += floatArray.Length;
                _AudioRecordingData._count++;
            }
            
            return true;
        }
```

通过获取麦克风声音，然后手机扬声器播放，麦克录制声音时会持续录制到扬声器的声音，都启用功能，还是会有


Reply: 您好，请问您是想获取麦克风采集的裸数据，但实际会获得扬声器外放的声音是吗？裸数据在 3A 处理前，拿到的就是没有经过处理的信号，有其他声音也是预期内的。请问您这边是什么场景什么需求呢？

---

# ID: 37219

SDK Product: ConvoAI

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 我想问一下， 怎么集成到sip里面去做外呼机器人，我现在集成后没有声音，是哪里出现的问题，需要怎么对接进来这个音频。

Reply: 您好，convoAI 的 Restful 接口调用以后是往指定 RTC 频道里加一个智能体来互通，如果要和智能体说话，就需要先加入 RTC 频道发流。请问您这个 SIP 是什么平台？可以集成我们的客户端 SDK 吗？

---
# ID: 37220

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 其他问题

Request Description: 屏幕共享目前写死了一个固定的ID，容易出现ID冲突的现象，想问下这个ID值最大限制的多大呢

Reply: 您好，您是问这个屏幕共享用的 UID 有什么限制吗？这里的 uid 和频道里其他用户的限制一样，参考 [join](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iagorartcclient#join)里对于 uid 的定义，保证用 int 范围内的数字就行。

---

# ID: 37223

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 医生给患者端打视频电话，现象如下，附件是微信小程序打印收到的视频流参数
1、医生端是原生APP，患者端使用微信小程序接通后，视频方向上下颠倒
2、医生端和患者端都使用原生APP，视频方向正常

需要帮忙解决小程序接通音视频，视频方向上下颠倒问题。

Reply: 请问小程序是看别人画面颠倒还是看自己画面颠倒？用我们[小程序 Demo](https://doc.shengwang.cn/doc/rtc/mini-program/get-started/run-demo) 加频道的话看到的画面是正常的吗？

---

# ID: 37226

SDK Product: RTM

SDK Platform: Java

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 使用SDK生成的Token验证为已过期，使用Maven引入 ， 
      <dependency>
            <groupId>io.agora</groupId>
            <artifactId>authentication</artifactId>
            <version>2.1.3</version>
        </dependency>
生成的方法如下：
```java
   public static String generateRtmToken(ShengWangConfig config, String account) {
        return new RtmTokenBuilder2().buildToken(config.getAppId(), config.getAppCertificate(), account, 7200);
    } 
```
生成的Token在辅助工具-Token验证显示已过期，相差时间大概为6个小时。

Reply: 您好，不建议用 maven 生成了，请用我们文档里给的仓库，clone 下来用里面的[AccessToken2 生成器](https://doc.shengwang.cn/doc/rtm2/javascript/user-guide/token/token-generation#accesstoken2-%E7%94%9F%E6%88%90%E5%99%A8%E4%BB%A3%E7%A0%81)代码脚本去生成即可。

---
# ID: 37227

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 我自己的音频不是麦克风的音频怎么做实时降噪 只要降噪功能 
  输入 我自己的wav文件   输出AINS降噪后的wav文件

Reply: 您好，我们的降噪不单独对外开放使用，请使用专门降噪的工具来实现这个需求。SDK 的降噪是通过识别采集参考信号进行降噪处理发到 RTC 频道内的，设计之初没有考虑过单独用来降噪输出文件过。

---

# ID: 37194

SDK Product: RTC

SDK Platform: Windows

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 咨询Windows下的RTC 服务端 SDK的Python版本集成问题：
1、文档兼容性描述操作系统是Linux的，架构是X86-64的，想请问下，我在Windows软件下集成RTC服务端的Python版本SDK可行吗？

Reply: 您好，Python SDK 不支持 Windows 环境，必须是 Linux 系统。

---

# ID: 37198

SDK Product: RTC-Linux

SDK Platform: Linux-Python

SDK Version: 2.2.4

Request Type: 其他问题

Request Description: agora_token_builder  v1.0.0版本RtcTokenBuilder生成的token用于linux 服务端python sdk ：agora_python_server_sdk v2.2.4 加入频道失败，UID一致，是不是两个sdk不兼容，或者RtcTokenBuilder生成的token不能用于服务端的sdk加入频道？


Reply: 您好，理论上是都能用的，但我们更推荐用新版本 token，把[实现 token 鉴权](https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication#basic-token)文章里的仓库 clone 下来跑里面的生成脚本来生成就好。

---

# ID: 37200

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 直播连麦，用户切换成主播身份。用户违规后，服务端调用创建规则接口，把用户的音视频流权限都限制了。用户还是能连麦说话

Reply: 您好，封禁接口只能让服务端不接受被封禁用户发来的流，被封禁用户本地的采集还是正常的，请先确定下现象和概念。
以及常见的封禁后依旧能收到用户发流的常见原因是 uid 频道名不匹配、封禁时间过短导致的，您可以自查下是否有类似情况。

---
# ID: 37201

SDK Product: RTC

SDK Platform: Windows

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 
```Java
// 点击开始录制按钮
private void start_recording_Click(object sender, EventArgs e)
{
    RecorderStreamInfo recorderStreamInfo = new RecorderStreamInfo();
    recorderStreamInfo.uid = 0;
    recorderStreamInfo.channelId = channelName;

    // 创建音视频录制对象
    mediaRecorder = engine.CreateMediaRecorder(recorderStreamInfo);
    // 获取 MediaRecorderObserver 的单例实例
    var observer = new MediaRecorderObserver();

    // 注册 OnRecorderStateChanged 事件
    observer.EventOnRecorderStateChanged += (channelId, uid, state, error) =>
    {
        Console.WriteLine($"Recorder state changed to {state}, error: {error}");
    };

    // 注册 OnRecorderInfoUpdated 事件
    observer.EventOnRecorderInfoUpdated += (channelId, uid, info) =>
    {
        Console.WriteLine($"Recorder info updated: {info}");
    };

    // 注册录制对象观测器
    mediaRecorder.SetMediaRecorderObserver(observer);

    // 开始录制
    // 创建 MediaRecorderConfiguration 对象
    var config = new MediaRecorderConfiguration
        {
            // 设置录制配置
            // 例如，设置录制文件路径和格式
            storagePath = "D:\\PICC\\example.mp4"
        };
    mediaRecorder.StartRecording(config);
} 
```
这是我屏幕录制的触发写法，哪里没写对，为啥没有录下来呢？
[2025-09-17 14:26:00.979] [32628] [info] [iris_rtc_media_recorder_impl.cc:41] api name MediaRecorder_startRecording ret 0 result {"result":-1}

Reply: 您好，可以参考下我们 [api-example](https://github.com/Shengwang-Community/API-Examples/tree/main/windows/APIExample/APIExample/Advanced/MediaRecorder)里的相关示例来实现。

---
# ID: 37202

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 屏幕共享：按照文档，调用RtcEngine的startScreenCapture方法，返回错误码 -157

Reply: 您好，157 是模块没有找到的报错，请检查下有没有裁剪调屏幕共享的 aar 或者 so，以及音频包也是无法使用屏幕共享的，请确保使用了完整的 full 包。

---

# ID: 37204

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.1

Request Type: 集成问题咨询

Request Description: 在直播间，有用户需要专属连麦，专属连麦就是不能让其他用户听到主播和用户的音频。使用频道的分组功能来实现，问下文档在哪里

Reply: 您好，这个属于业务需求，您业务上自行保证频道只有 2 个人加入就行了，可以自行限制 1v1 房间的频道名命名方式，以及当频道内人数为 2 以后就不再让其他用户加入。
也可以参考下[1v1 私密房](https://doc.shengwang.cn/doc/one-to-one-live/android/custom-signaling/landing-page)文档，搭配第三方SDK 来实现。

---
# ID: 37205

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 集成问题咨询


Request Description: 
```dart
Future<void> joinChannelEx(
    {required String token,
    required RtcConnection connection,
    required ChannelMediaOptions options});
```

文档描述中说可以加入多个频道，但是在集成的sdk中没有看到 joinChannelEx 方法呢

Reply: 您好，可以直接参考 [flutter 加入多频道的 Demo](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/blob/main/example/lib/examples/advanced/join_multiple_channel/join_multiple_channel.dart)。
底层原理和 Native 是一样的，可以参考 Native 的文档。

---
# ID: 37206

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 在我们业务平台需要进行计费，使用声网的RTC服务，如何来精确的计算用户观看视频的真实时长？ 声网是否有提供成熟的方案？

Reply: 您好，声网的计费虽然是按照订阅时长和集合分辨率计算的，但没有办法直接获取每个用户的观看时长。可以参考下我们的[计费策略](https://doc.shengwang.cn/doc/rtc/flutter/billing/billing-strategy)，建议您不要依赖我们的计费逻辑，自行实现属于自己的业务计费规则，这样最准确。

---
# ID: 37207

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.0

Request Type: 其他问题

Request Description: 上架时提示声网超范围获取手机信息
APP在运行时，存在以下违规行为: 1、未见向用户告知且未经用户同意，在后台状态下，APP存在收集“DHCP”等信息的行为，非服务所必需且无合理应用场景，超出与收集个人信息时所声称 的目的具有直接或合理关联范围 
2、未见向用户告知且未经用户同意，在静默状态下，APP存在收集“DHCP”等信息的行为，非服务所必需且无合理应用场景，超出与收集个人信息时所声称 的目的具有直接或合理关联范围
这个要怎么处理

Reply: 您好，请问目前在用的是什么版本 SDK？DHCP 问题我们再最新的 4.6.0 上已经做过修复了，可以尝试用新版本 SDK 来上架。

---
# ID: 37208

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 其他问题

Request Description: 安卓手机连接蓝牙设备，会出现识别不到蓝牙设备的麦克风，然后去使用手机麦克风的问题。 这边有办法可以一直使用设备的麦克风而不是手机的麦克风吗？

Reply: 您好，听起来是蓝牙协议没走 hfp 导致的，麻烦提供下复现问题时的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，人工工程师稍后为您解答。

---

# ID: 37182

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.3.0

Request Type: 效果不佳、不达预期

Request Description: 群语音通话过程中有两个体验问题：
1. 用户说话有回音。
2. 噪音比较大。

iOS 有啥API 能降低噪音和回音，AgoraRtcEngineKit 默认会开启降噪和回声消除吗？

Reply: 您好，SDK 自带回声和降噪消除，如果觉得效果不好可以设置 audioScenario 位 chatroom 试下，走硬件消除效果会更好一些。
调用[setAudioScenario](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#api_irtcengine_setaudioscenario)来修改枚举。

---

# ID: 37185

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 商务问题

Request Description: 主播通过  createMediaPlayer 推送本地视频，并同时进行音频麦？
如何收费？

1 是按照 音频麦 + 视频推流收费？
2 仅仅收视频推流费用？

Reply: 您好，我们的计费是按照订阅收费的，没有视频订阅一律收取音频时长费用，产生视频订阅以后音频就不收了，只收视屏订阅的费用。具体细节可以电话咨询 400 6326626

---

# ID: 37187

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 如何解决
在不带耳机下，主播端能实现 音频自采集(伴奏外放 + 人声采集) + 人声不外放 同时 远端能听到清晰的 人声+伴奏，实现不带耳机进行K歌。

我们的核心问题是，需要解决不带耳机下，用户K歌的回声消除问题，伴奏需要外放(伴奏外放时麦克风会把这个伴奏再采集到，此时需要回声消除)，K歌的对方，需要能清晰的听到人声+伴奏。 我们是音频自采集，就是我们的音频模块，会负责伴奏 + 人声录制等，现在我们希望解决App一直无法在音频自采集下，用户无法不带耳机K歌的问题。

我们目前的思路是创建两路track
一路是 人声 agoraKit.createCustomAudioTrack(.direct, config: voiceConfig) (实际的音频内容是 人声 + 伴奏外放又重新被麦克风采集到的伴奏) 我们希望此路 开启 AI AEC
一路是 agoraKit.createCustomAudioTrack(.mixable, config: musicConfig) 纯伴奏通过mixable方式，作为AI AEC的消融信号，这路外放并推流

这样远端就能听到 人声+伴奏 （外放的伴奏被AI AEC消融）

但是这个方案一直无法调通

请问，如何实现我们上面的需求，音频自采集下，用户不带耳机，伴奏外放的K歌。

Reply: 您好，SDK 本身是支持采集外接麦克风设备的，不一定需要用自采集方式做，用 SDK 采集也行。可以用 SDK 采集的情况下 audioScenario 选择 default 试下效果，这样 SDK 会走硬件消除把外放的伴奏消除掉。
以及您这边是独唱还是合唱场景呢？我们有一些现成的[在线 K 歌房解决方案](https://doc.shengwang.cn/doc/online-ktv/ios/ktv-scenario/landing-page)，可以参考下。

---

# ID: 37192

SDK Product: RTC

SDK Platform: Android

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我们公司之前是集成的环信，内置的声网版本是io.agora.rtc:full-sdk:3.3.0，使用的声网ID是环信的demo里面的。
问题一，我重新申请声网ID，那么设备势必要全部更新程序，请问新申请的ID和原环信demo的声网ID能否通话？
问题二，重新申请声网ID，我们准备放弃环信，我们的需求只是1V1音频通话，那么我们集成时，请问选择语音通话还是1v1私密房？哪个好一点？

Reply: 您好，不同 appid 之间无法互通，建议全部用新的 appid。
语音通话还是 1v1 私密房本质都是再 RTC 频道内通话，只是业务上会有不同的限制。具体选择取决于您的场景，请完整描述下您现在的场景和需求，稍后人工工程师为您推荐。

---
# ID: 37193

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 集成问题咨询

Request Description: android 16kb问题
agora_rtc_engine: 6.5.2
flutter我使用这个版本 使用libchecker 检测还是显示NON 16 KB STORED

Reply: 您好，flutter 在 6.5.2 版本上已经支持了 16kb 适配，如果还是会有这个问题请检查下 gradle 版本有没有升级到 8.7 以后。

---

# ID: 37152

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.0

Request Type: 集成问题咨询

Request Description: Android 客户端在升级声网sdk的时候，发现旁路推流有问题， 原来版本3.5.0  正常可以推流，升级3.7.2 之后不开vpn，推失败，开启vpn可以推流，升级到4.5.0后，怎样都不行，同一个手机，同一个网络环境，这个是什么原因呀

Reply: 您好，客户端旁路推流的接口已经废弃了，请用[服务端旁路推流](https://doc.shengwang.cn/doc/media-push/restful/landing-page
)实现。
SDK 不推荐使用 VPN 来通话，会影响连接的节点选择导致延迟变大。

---

# ID: 37164

SDK Product: RTC

SDK Platform: mini-app

SDK Version: 2.6.5

Request Type: 集成问题咨询

Request Description: web推流，uniapp微信小程序使用代码获取到rtmp://175.6.189.140:27722/live/9TgjMmYU5GlHb9FdsRQoZyMxSUmJFNgI，经ffmpeg工具集分析不存在视频track，  libpostproc    58.  3.100 / 58.  3.100
Input #0, flv, from 'rtmp://175.6.189.140:27722/live/9TgjMmYU5GlHb9FdsRQoZyMxSUmJFNgI':
  Metadata:
    |RtmpSampleAccess: true
  Duration: N/A, start: 1205963.280000, bitrate: N/A
  Stream #0:0: Data: none
  Stream #0:1: Audio: aac (LC), 48000 Hz, mono, fltp
Unsupported codec with id 0 for input stream 0
。。但是如果拉流的是web或者其他客户端就没有问题

Reply: 您好，小程序的链路和我们 RTC 的链路是不通的，需要使用[小程序 SDK](https://doc.shengwang.cn/doc/rtc/mini-program/get-started/run-demo) 加入 RTC 频道才能互通。
但是我们的小程序 SDK 只支持原生小程序开发，不支持 uni-app。

---
# ID: 37165

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.2.5

Request Type: 集成问题咨询

Request Description: ThreadLocalRandom.current().nextInt(0, Integer.MAX_VALUE) 每次使用该方法生成的随机id，
使用官网提供的方法生成的token，每次expire值设置的是86400
```Java
public String buildToken(String appId, String appCertificate, String userId, int expire) {
        AccessToken2 accessToken = new AccessToken2(appId, appCertificate, expire);
        AccessToken2.Service serviceRtm = new AccessToken2.ServiceRtm(userId);

        serviceRtm.addPrivilegeRtm(AccessToken2.PrivilegeRtm.PRIVILEGE_LOGIN, expire);
        accessToken.addService(serviceRtm);
        try {
            return accessToken.build();
        } catch (Exception e) {
            LogUtils.i("buildToken error=" + e.getMessage());
            return "";
        }
    }
```

首次开启APP，先调用的rtmClient.logout退出登录方法，然后再调用rtmClient.login方法，可以正常登录成功，如果通过androidstudio再重新安装APP，又执行了退出登录，登录等操作，就会一直提示这个异常
{currentState: CONNECTING, previousState: IDLE, serviceType: MESSAGE, operation: LOGIN, reasonCode: LOGIN, reason: Perform login operation, affectedChannels: [], unrestoredChannels: [], isResumed: false, timestamp: 0}
 {currentState: FAILED, previousState: CONNECTING, serviceType: MESSAGE, operation: LOGIN, reasonCode: INVALID_TOKEN, reason: Invalid token, affectedChannels: [], unrestoredChannels: [], isResumed: false, timestamp: 0}  
说是token无效，如果机器重启在开启app的话，就又可以登录成功了，请问这是什么原因导致的呢，怎么解决

Reply: 您好，RTM 初始化的时候需要传入 appid 和 userid，login 的时候需要传入 token。其中 token 是和 userid 绑定的，如果您更换了 token，但是 token 对应的userid 不是初始化时传入的那个，那么登录大概率会失败，需要您先 release，再重新用新的 userid 去初始化 RTM，再 login 来解决。

---

# ID: 37167

SDK Product: IM

SDK Platform: Web

SDK Version: 1.3.2

Request Type: 集成问题咨询

Request Description: 现在两个用户在同一个chatroom里，当一个用户直接关闭浏览器后，在另一个用户那边，似乎没有直接发出onChatroomEvent，然后memberAbsence这种类型的消息被发出。如何能够有效的判断这种直接关闭浏览器的用户离开的情况。

Reply: 您好，SDK 无法感知远端用户关闭浏览器的行为，只会在断开长连接2分钟后视为踢出聊天室来处理。

---
# ID: 37169

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 其他问题

Request Description: 倒入的是jar,so 文件，打包模拟器运行包这个提示语，如何解决 

apk is not compatible with 16 KB devices. Some libraries have LOAD segments not aligned at 16 KB boundaries: lib/arm64-v8a/libmmkv.so lib/arm64-v8a/librtmp-jni.so Starting November 1st, 2025, all new apps and updates to existing apps submitted to Google Play and targeting Android 15+ devices must support 16 KB page sizes. For more information about compatibility with 16 KB devices, visit developer.android.com/16kb-page-size.

Reply: 您好，最新的 SDK 已经都支持 16kb 了，但是 SDK 不支持模拟器，请用真机运行。
如果已经在用最新版本但Android studio 还在提示不支持，可以升级下 gradle 版本来解决。

---
# ID: 37170

SDK Product: RTM

SDK Platform: Flutter

SDK Version: 2.2.2

Request Type: 其他问题

Request Description: 声网RTM的频道消息，如何控制消息的时效性，如：某几条消息，我想在1分钟内显示时间过后，撤回或移除掉，有的可能是2分钟内撤回或移除掉，有什么方法做到

Reply: 您好，撤回是您自己的业务，需要您自行实现。可以根据收到消息的本地事件进行计时和在 UI 上删除这条消息的显示。

---

# ID: 37178

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 其他问题

Request Description: 想咨询一下，咱们 sdk 请求云端服务器的域名或者固定的 ip 地址等这些是啥。

Reply: 您好，我们没有固定 IP，只有固定域名，可以参考下[保障 REST 服务高可用](https://doc.shengwang.cn/doc/cloud-recording/restful/best-practices/rest-availability)。

---

# ID: 37128

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 结束视频聊天后，在重新进入频道，蓝牙耳机没有声音？请问什么原因，第一次进入频道后蓝牙耳机有声音，第二次在进入就没声音了

Reply: 您好，麻烦提供下具体的现象视频+[SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，以及也可以尝试用我们 [Demo](https://github.com/AgoraIO/API-Examples/tree/main) 来复现下，看看 Demo 会不会有同样的问题。

---

# ID: 37134

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 在一个同事的电脑上，测试，发现其他人开启视频推流，在这个电脑的同事的电脑上（12185用户），Observer那个类没有接收到视频帧，就无法渲染出图像。但我是接收到了远程视频打开的事件回调的。查看后台，发现12185这个用户的视频接收端的视角没有任何曲线图像显示。如图所示。但是在其他同事电脑上，就能接正常收到视频帧。

Reply: 您好，可以先确认下收不到视频的一方有没有开启 enableVideo，如果确认开启并且监听回调注册正确，可以提供下 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，人工工程师稍后看下具体原因。

---

# ID: 37137

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 这边集成的sdk 版本是'cn.shengwang.rtc:voice-sdk:4.6.0'，已经是纯粹的语言包了，但是打包之后，整个apk 体积增加了100多M大小，查看下是下面图片1上面各个cpu下的so 文件增加的，按照官网上面说应该是每个cpu 都只增加7m，但是现在确实30多m，导致整个项目很大。而且按照文档里面减少app体积的办法，我把sdk 下载下来里面多了两个high_level_api，和low_level_api文件夹下，这里面都是.h文件，我不知道应该放在android 项目哪里。

Reply: 您好，离线集成参考[集成 SDK](https://doc.shengwang.cn/doc/rtc/android/get-started/quick-start#%E9%9B%86%E6%88%90-sdk)
只看so体积不代表实际集成到app里打包出来以后增加的体积。

---

# ID: 37140

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.1.7

Request Type: 其他问题

Request Description: 在调用/cloud_recording/acquire时出现{"message":"appid is invalid"}   appid正确的

Reply: 您好，云录制报错 appid is invalid 只可能是在用的 appid 没有开通云录制功能或者目前在用的 ak sk 和 appid 不匹配，您可以自查一下。

---
# ID: 37141

SDK Product: RTC

SDK Platform: iOS

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 我们当前需要多频道连线的功能，我看文档是使用的这一套方法
```swift
        AgoraRtcConnection *connection = [[AgoraRtcConnection alloc] init];
        connection.channelId = model.roomId.stringValue;
        connection.localUid = arc4random_uniform(99999) + 10000; // 随机副频道 UID
        
        AgoraRtcChannelMediaOptions *options = [[AgoraRtcChannelMediaOptions alloc] init];
        options.channelProfile = AgoraChannelProfileLiveBroadcasting;
        options.clientRoleType = AgoraClientRoleBroadcaster;
        options.autoSubscribeAudio = YES;
        options.autoSubscribeVideo = YES;
        options.publishMicrophoneTrack = YES;
        options.publishCameraTrack = YES;
        
        [manager.agoraEngine joinChannelExByToken:model.signaure
                                        connection:connection
                                          delegate:nil
                                      mediaOptions:options
                                      joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
            successCount++;
            [manager.pkConnections addObject:connection];
            [manager.pkRoomModels addObject:model];
            
            if (successCount == pkRooms.count && !hasFailed) {
                DAgoraLog(@"✅ 所有副频道加入成功");
                if (success) success();
            }
        }];
```

这里我有一些疑问
1.我的localUid是随机Uid还是说直接给当前用户的Id
2.我加入的时候channelId我理解的应该是个副频道的id但是这个Token是什么的Token呢是当前用户在当前频道的token还是说我需要生成一个我在需要加入的频道的新的token或者是频道的房主的token

Reply: 您好，请问您看的是[加入多频道](https://doc.shengwang.cn/doc/rtc/ios/advanced-features/multiple-channel)吗？

这里面只是为了方便区分把第一个频道的 uid 写成localUid了，uid 本身就是自定义的字段，所以示例代码里先随机了，只要是 join 就需要保证 token 和 uid 匹配，不然校验会失败，加不进去

可以参考下[主播 PK 连麦](https://doc.shengwang.cn/doc/showroom/ios/basic-features/integrate-showroom#5-%E4%B8%BB%E6%92%AD-pk-%E8%BF%9E%E9%BA%A6)，参考下这篇文档里的 PK 实现业务逻辑。

---

# ID: 37143

SDK Product: RTC

SDK Platform: Unity

SDK Version: 4.4.0

Request Type: 集成问题咨询

Request Description: 你好，我们的unity项目出现了下面错误，后面还有一长串类似的。这是什么原因引起的，是不是需要更新SDK版本才能解决？
[AgoraEngine] Init agora rtc engine
objc[94591]: Class RTEDispatcher is implemented in both /Users/louie/Desktop/Attachments/Build/MacNUI4f20436/Sinespace.app/Contents/PlugIns/AgoraRtcWrapperUnity.bundle/Contents/Frameworks/AgoraScreenCaptureExtension.framework/Versions/A/AgoraScreenCaptureExtension (0x3bae51148) and /Users/louie/Desktop/Attachments/Build/MacNUI4f20436/Sinespace.app/Contents/PlugIns/AgoraRtcWrapperUnity.bundle/Contents/Frameworks/AgoraRtcKit.framework/Versions/A/AgoraRtcKit (0x3d63a58a0). This may cause spurious casting failures and mysterious crashes. One of the duplicates must be removed or renamed.

Reply: 您好，打包的时候有一个假包始终指向最新的版本，现在假包和真包都变成真实文件了，删掉其中一个就行了。

---
# ID: 37144

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.2

Request Type: 其他问题

Request Description: 在进行rtc多人会议的时候，怎么做到双击某个的窗口，让这个窗口变大，其他窗口都缩小然后位于屏幕的右上方依次排列
我现在写的if判断来分别展示三种UI,分别是：都不放大，本地放大，远程放大。如果双击时，如果双击的是本地窗口，就没有问题。如果双击的是远程窗口，则远程窗口白屏了

Reply: 您好，这个是您 UI 上本地的业务，和 SDK 没有关系。
如果涉及到视图切换绑定的 uid，需要先传 null 置空，然后再绑定新的 uid

---
# ID: 37145

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.23.x

Request Type: 集成问题咨询

Request Description: 如何用Vue3实现对视频流的截图，只需要截首帧

Reply: 您好，可以考虑用浏览器原生的截图接口实现，不一定需要依赖 SDK 接口。

---
# ID: 37146

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 效果不佳、不达预期

Request Description: 我想结合声网的RTC服务以及微软的ASR+TTS以及自己搭建的Agent来实现一个端到端的AI实时语音助手
在实现打断功能的时候遇到一个问题：
如果服务端音频生成并推送的速度非常快回导致客户端的音频缓冲区积累长时间的音频，SDK无法清空客户端的音频缓冲区，会导致当我执行手动打断AI音频再提问时客户端回播放上一个AI回复的音频，能否给客户端的sdk提供一个清空音频缓冲区的API？

Reply: 您好，您这边是在用服务端 SDK 吗？工单问题分类提交的是 Android，但这个问题看起来是服务端的。服务端 SDK 有专门的清空音频发送缓存的接口[ClearSenderBuffer](https://doc.shengwang.cn/api-ref/rtc-server-sdk/cpp/classagora_1_1rtc_1_1_i_local_audio_track#ClearSenderBuffer())。
以及您的场景也适合我们的 convoAI，可以考虑直接用我们的 [对话式 AI 引擎](https://doc.shengwang.cn/doc/convoai/restful/landing-page) 来集成，中间的链路已经封装搭建完毕了，调用接口就可以获得效果.

---
# ID: 37147

SDK Product: CDN

SDK Platform: CDN

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 大疆无人机的rtmp推流，推到声网，实现电脑上看到直播画面，如何购买和设置呢

Reply: 您好，大疆用户可以参考下[大疆用户的 RTC 说明书](https://i46hiqvame.feishu.cn/docx/LiWxdLMtUobkAmxmjuHc33mtnEd?from=from_copylink)

---
# ID: 37148

SDK Product: RTM

SDK Platform: Java

SDK Version: 2.2.5

Request Type: 集成问题咨询

Request Description: 我们App在接入声网RTC实现视频通话功能是，使用了老版本RTM-1.4.9用于拉起通话对方进入同一个RTC频道。
现在因为业务需要想将RTM升级到最新版RTM-2.2.5，但发现RTM2相对于RTM1似乎变化很大。
原来RTM1中我们通过RtmCallManager方法，将视频通话的另一方邀请进频道，但RTM2已经找不到这个方法。
另外其他多个方法在RTM2中也都废弃了，但我看官网文档中有关于迁移的部分没有找到一一对应的替换方法的说明文档，请问有相关迁移的说明文档吗？

以下是我们app老版本邀请视频通话另一方进入频道的方式，现在更新RTM2，同时需要兼容老版本，应该如何兼容？
```Java
public final boolean answerTheCall(final RemoteInvitation invitation) {
        RtmCallManager callMgr = mRtmClient.getRtmCallManager();
        final boolean[] callSuccess = {true};
        callMgr.acceptRemoteInvitation(invitation, new ResultCallback<Void>() {
            @Override
            public void onSuccess(Void aVoid) {
                // TODO: 接通成功
            }

            @Override
            public void onFailure(ErrorInfo errorInfo) {
                callSuccess[0] = false; 
                // TODO: 接通失败
            }
        });
        return callSuccess[0];
    }
```


Reply: 您好，升级 RTM 可以参考[迁移指南](https://doc.shengwang.cn/doc/rtm2/android/overview/migration-guide)，RTM2 和 RTM1 有明显差异，建议升级到 RTM2 后用 RTM2 的能力去实现呼叫邀请业务，RTM2 已经不再提供封装好的呼叫邀请接口了。

---
# ID: 37149

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 端录制中 延时混音，通过设置 appsCollection 和 transcodeOptions 字段开启延时混音功能。
开启后，录制服务会在录制结束后 24 小时内将指定频道内所有 UID 的录制文件合并且转码生成一个 MP3/M4A/AAC 文件，并将录制文件上传至你指定的第三方云存储。
这个在现在的文档中怎么没有了？

Reply: 您好，目前不支持了，这个功能下架了，建议用所有 uid 的 m3u8 文件自行本地混音来实现。

---

# ID: 37113

SDK Product: Console

SDK Platform: All

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 需要解绑账号对应的手机号与邮箱

Reply: 您好，可以在声网 console 右上角个人中心自行更换手机号和邮箱。但更换手机号需要绑定新的号码才行，如果您只是不想用这个账号了，可以在 声网 console 左侧边栏设置-安全设置 自行注销。

---

# ID: 37116

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 效果不佳、不达预期

Request Description: 2台手机，一台IOS一台安卓，都进入频道对讲，对讲正常， 2台手机禁音的时候都会收到onLocalAudioStateChanged的监听state:LocalAudioStreamState.localAudioStreamStateStopped;  reason:LocalAudioStreamReason.localAudioStreamReasonOk，但是2台手机都在打电话的时候iOS的可以收到localAudioStreamReasonInterrupted的监听，安卓的收不到监听。

Reply: 您好，理论上系统来电时两个端都会触发的，您可以在我们 [Demo](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/tree/main) 的基础上尝试复现下看看。如果能够复现，麻烦提供复现时的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)。

---
# ID: 37117

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.2

Request Type: 集成问题咨询

Request Description: 通过getNativeHandle去调用C++接口对外暴露的方法,
registerAudioFrameObserver注册的观测位置不同，触发的不同回调，拿到的音频来源也不同，这个是可以了解的,但是这个拿到的音频我能否暴露给HarmonyOS端然后使用ArkTs语言去处理这些音频流呢,这样的话要如何操作,我看到C++中原始数据数据这个方法里边只做了打印,其他处理没有,我要做些什么处理才能将音频流去传递给鸿蒙端呢,我想在鸿蒙端进行处理,下面附件是安卓端的一个处理
bool OriginAudioData::onRecordAudioFrame(const char *channelId, AudioFrame &audioFrame) { 
    AG_INFO("OriginAudioData::onRecordAudioFrame called");
    return false; 
}

Reply: 您好，这个需求无法实现，裸数据的处理只能在 C++层完成，arkts 是单线程，从 C++拿数据给到 arkts 层容易出现跨线程卡死问题，建议在 C++层完成处理后再把处理完的数据传到 arkts 层。

---

# ID: 37119

SDK Product: RTC

SDK Platform: Windows

SDK Version: 4.3.0

Request Type: 效果不佳、不达预期

Request Description: 根据您当时说的webhook，现在视频录制的错误率更高了，改完之后没有一个视频能获取到了
为什么所有录制文件已经全部上传完成，但至少有一片上传到声网备份云（值：32）这个事件没有，
而且录制的很多视频只有很少一部分能真正得到回调的事件

公司现在已经配置过的appid有
['89914a46c7974decba22969061c9c182',
 'e4173b79870149168904058ebd408adc',
 '692bfd43435d4a86854519ae69663954',
 '8e74f1a88c384f1fba921e7aca094b45',
 'edc40ba0c18a44d98d640c93a3053def',
 '6eed980d580241e3ab489f160c4242e4']

能不能帮忙看一下，问诊视频上面会检查，不能总是这样老出问题啊

Reply: 您好，[32 事件](https://doc.shengwang.cn/doc/cloud-recording/restful/webhook/uploading#32-backuped)是上传失败备份到我们存储里的事件，如果录制正常完成上传或者一开始就启动失败是不会触发的。31 是上传完的回调，如果需要在上传完成时获得文件路径，可以监听 [31](https://doc.shengwang.cn/doc/cloud-recording/restful/webhook/uploading#31-uploaded)。
请问现在有哪些 sid 找不到录制文件？

---

# ID: 37123

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.6.0

Request Type: 其他问题

Request Description:  IOS 关麦后，微信发送语音消息没有声音

Reply: 您好，请问发送语音的时候 SDK 还在占用麦克风吗？闭麦要关闭采集才能释放资源，mute 只是不发出去，采集还是占用的，请保证[enableLocalAudio](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_audio_capture#api_irtcengine_enablelocalaudio) 为 false。

---
# ID: 37124

SDK Product: RTC

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 主播开播后，产生意外关掉了客户端。服务端通过什么接口去判断当前直播已经被关闭

Reply: 您好，IOS 杀后台后客户端 SDK是可以被感知到的，SDK 会认为用户主动退出了。Android 感知不到，SDK 会尝试重连 20s，20s 连不上就认为超时连接，判定这个 uid 离线，不在频道内了。频道里没有人在，频道就会变成不存在的状态

这些都可以用 [查询用户列表](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/get-dev-v1-channel-user-appid-channelName) 接口查询。


---

# ID: 37093

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description: 问题表现：
使用trc直播功能 ，暂时不推流只进行本地预览。开启预览后，添加第三方美颜特效，在onCaptureVideoFrame回调中，先将TextureBuffer相关数据传给第三方美颜，美颜生效后，画面不卡顿，美颜效果也正常，但是取消美颜后（和加美颜使用的纹理id是同一个），画面出现卡断。

通过打印第三方美颜的耗时看，取消美颜后（继续走第三方美颜渲染接口），耗时大概在5ms左右，所以理论上应该不是引起画面卡顿的原因。附件为声网日志和相关代码。

使用声网版本：  implementation 'io.agora.rtc:full-sdk:4.3.0'

Reply: 您好，可以尝试下取消美颜以后[onCaptureVideoFrame](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_video_raw#onCaptureVideoFrame)直接不接任何代码就 return true，看下不走三方美颜 SDK 处理的话是否还会有卡顿问题。

---
# ID: 37094

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.6.0

Request Type: 集成问题咨询

Request Description: 视频质量评分RemoteVideoStats.mosValue字段一直返回0

Reply: 您好，RemoteVideoStats.mosValue 这个字段已经废弃了，没有实际意义，可以忽略。

---

# ID: 37096

SDK Product: RTC

SDK Platform: Web

SDK Version: 4.24.x

Request Type: 其他问题

Request Description: 我们的主播端推流的视频中有自定义的SEI信息，如何在WebSDK中解析该SEI信息，通过getRTCRtpTransceiver获取到的实例无法对视频流进行解析，提示： InvalidStateError: Failed to execute 'createEncodedStreams' on 'RTCRtpReceiver': Too late to create encoded streams

Reply: 您好，Web 监听要用的回调没有对外公开，参考：
```javascript
this.client.on("receive-metadata", (uid: UID, metadata: Uint8Array) => { });
```

发送 metadata 的话用
```javascript
public sendMetadata(metadata: Uint8Array): Promise<void>
```

---

# ID: 37100

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.1

Request Type: 效果不佳、不达预期

Request Description: 1. flutter 项目打开app，首次初始化引擎 加入房间 延迟很明显，需要等待5-6秒左右才会加入房间， 后续进入无明显延迟，有什么优化方案，目前使用是每次进入房间户初始化引擎，离开房间 销毁，

Reply: 建议参考下我们 [flutter Demo](https://doc.shengwang.cn/doc/rtc/flutter/get-started/run-demo) 的处理，正常流程不需要这么久的，怀疑是集成问题，请避免在回调内初始化或销毁。


---

# ID: 37102

SDK Product: IM

SDK Platform: Web

SDK Version: 1.3.2

Request Type: 集成问题咨询

Request Description: 我想咨询一个关于 用户在线状态 检测的需求
我注意到console里有一个 用户在线状态 的开关
我问了AI，如何检测用户的在线状态，它的回答似乎是在引导我使用rtm，并利用Presence检测，即在加入频道时通过调用 .join({ withPresence: true })这种方式来检测用户在线。
但我现在使用的是IM服务，不是RTM，似乎IM里并没有Presence相关的内容，请问在IM服务下，如何实现用户在线检测的功能。
另外，console中的那个 用户在线检测 开关 打开了，然后有什么用？AI没有给出一个比较靠谱的答案

Reply: 您好，IM 可以通过 [在线状态（Presence）订阅](https://im.shengwang.cn/docs/sdk/server-side/presence.html) restful 接口查询。

---

# ID: 37104

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 您好：

我这边目前使用的是4.18.1, 现需要开通域名和端口的白名单，信通侧需要提供端口具体的用途：
80；443；3433；4700 - 5000；5668；5669；6080；6443；8667；9667；30011 - 30013（用于旁路推流）
 3478；4700 - 5000（2.9.0 及以后版本）；10000 - 65535 （2.9.0 以前版本）
请帮忙提供

Reply: 您好，我们需要链接公网的网络环境才能使用，要是内网或者防火墙使用的话只开放端口域名是不够的，需要额外购买[云代理](https://doc.shengwang.cn/doc/rtc/javascript/basic-features/firewall)服务，然后再开放这些才能正常使用。

---
# ID: 37105

SDK Product: Console

SDK Platform: All

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 我需要统计声网资源每天的用量，无法获取到对应的数据，需要提供对应的能力提供api接口。

Reply: 您好，可以用[查询时序用量指标](https://doc.shengwang.cn/doc/analytics/general/restful-aa/operations/get-beta-insight-usage-by_time)，但如果您需要做计量计费，建议根据您自己的业务场景来计费，不依赖我们的计费去计算。

---
# ID: 37106

SDK Product: RTC

SDK Platform: Web

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: 使用版本是4.18.1。现象是手机端发起通话，pc端能接到呼入。但接通后屏幕是黑的，所以需要知道通话过程中通话的交互流程以及需要开通白名单的域名。目前环境里，出网没有限制，但是不能入网，是否有影响。

Reply: 您好，Web SDK 需要能够连接到公网才可以使用，防火墙、内网都无法保证最终效果。您可以提供下黑屏时的浏览器 console 打印，看下有没有报错信息。

---
# ID: 37107

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.3.0

Request Type: 其他问题

Request Description: 你好，我们想抽查一些通话记录，看他们的音频文件或者视频文件，这哪里可以看？

Reply: 您好，RTC SDK 本身不会在终端设备本地存储通话的音视频原始文件，需要您开启[云录制](https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page)后才会保存到您指定的第三方 OSS 上。

---

# ID: 37109

SDK Product: RTC

SDK Platform: HarmonyOS

SDK Version: 4.4.2

Request Type: 其他问题

Request Description: 我需要获取RtcEngineImpl中的方法，如pauseEffect等，但是用RtcEngine.create(config);创建的对象又没有该api，使用RtcEngineImpl.createEngineImpl(config)创建对象时RtcEngineImpl又无法导包，请问RtcEngineImpl是无法使用吗，如果我需要用到RtcEngineImpl的方法需要怎么处理？

Reply: 您好，需要使用特定版本的 SDK 才行，有需要的话可以留言，稍后人工工程师会给您提供对应的版本。

---

# ID: 37112

SDK Product: Console

SDK Platform: All

SDK Version: 当前版本

Request Type: 其他问题

Request Description: 声网会给我们发送安全、帐单、到期提醒等邮件。但由于我们总公司邮箱反垃圾策略，声网给我们发的邮件已经好久没收到过了。
您知道声网会以哪些域名来发送这些邮件吗？

Reply: 您好，主要是这些：
```
Agora Support<agora@support.agora.io>
Agora Finance<agora@billing.agora.io>
Agora<no-reply@account.agora.io>

```

---

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

Request Description: 3.7.2.1版本迁移到4.6.0版本，        
```java
mRtcEngine.setCameraCapturerConfiguration(
                    new CameraCapturerConfiguration(
                            CameraCapturerConfiguration.CAPTURER_OUTPUT_PREFERENCE.CAPTURER_OUTPUT_PREFERENCE_PERFORMANCE,
                            CameraCapturerConfiguration.CAMERA_DIRECTION.CAMERA_FRONT
                    )
            );
```
设置摄像头策略这四个枚举在新版本用哪个API去设置：“预览质量接近于编码器的输出质量”

Reply: 您好，4.x 上已经去掉了这个枚举，并把这个行为设置为默认了，无需在采集时额外配置。

---
# ID: 37025

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 声网服务器调用api禁用 publish_audio或者视频权限，客户端的sdk会有代理知道自己被禁用了吗？localAudioStateChanged测试是没有回调的

Reply: 您好，封禁接口的发流封禁对于客户端是无法感知的，客户端改变采集或者发流状态都不会影响频道内的情况，因为我们服务端会自动丢弃这个 uid 发来的所有流直到封禁时间到期。如果需要同步客户端需要您在调用[封禁接口](https://doc.shengwang.cn/doc/rtc/restful/channel-management/operations/post-dev-v1-kicking-rule)时同步发送信令自行实现。

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
```php
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
```

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
```log
flutter: 2025-09-01T17:03:20.999456 [Level.warning] [Agora] [onLocalAudioStateChanged] 本地音频变化：state:LocalAudioStreamState.localAudioStreamStateRecording;  reason:LocalAudioStreamReason.localAudioStreamReasonOk
flutter: 2025-09-01T17:03:21.026670 [Level.warning] [Agora] [onLocalAudioStateChanged] 本地音频变化：state:LocalAudioStreamState.localAudioStreamStat
flutter: 2025-09-01T17:03:22.222248 [Level.warning] [Agora] [onRemoteAudioStateChanged] connection: {channelId: Test580, localUid: 194} remoteUid: 202 state: RemoteAudioState.remoteAudioStateStopped reason: RemoteAudioStateReason.remoteAudioReasonRemoteMuted elapsed: 0
[2025-09-01 17:03:22.223][12473609][I][iris_rtc_api_engine.cc:438] api name RtcEngine_enableAudioVolumeIndication_39794a0 params "{"interval":1000,"smooth":1,"reportVad":true}"
[2025-09-01 17:03:22.224][12473609][I][iris_rtc_api_engine.cc:504] api name RtcEngine_enableAudioVolumeIndication_39794a0 result 0 outdata {"result":0}
```


Reply: 您好，听起来是蓝牙协议没走 a2dp 导致的，麻烦提供下复现问题时的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，人工工程师稍后为您解答。

---
# ID: 36963

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.1

Request Type: 集成问题咨询

Request Description: 连接蓝牙后，实测发现音频采集仍然是从手机麦克风采集，如何让从蓝牙采集音频流？

Reply: 您好，听起来是蓝牙协议没走 hfp 导致的，麻烦提供下复现问题时的 [SDK 日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)，人工工程师稍后为您解答。

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

Request Description: 我们在评估esp32集成webrtc、webrtm的可行性，麻烦请问，esp32性能是否可以集成这个

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
```java
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
```java
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
```log
14:41:26:383 Agora-SDK [WARNING]: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: no active status
data: {"desc":"no active status","retry":false,"csIp":"139.196.174.91"}
index-BFxqu7au.js:45 14:41:26:387 Agora-SDK [WARNING]: [client-ca0d7] multi unilbs https://webrtc2-4.ap.sd-rtn.com/api/v2/transpond/webrtc?v=2 failed, flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: no active status, retry: false
```

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
```log
java.lang.RuntimeException: send message to channel failure: RTM ERROR: publish failed, error code: NOT_LOGIN, reason: Preform operation without login RTM service.
```

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

iOS 工程中pod install 报错
```
[!] The 'Pods-Runner' target has frameworks with conflicting names: aosl.xcframework.
```


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

Request Description: 集成调用本地服务端录制，代码执行到`agoraMediaRtcRecorder.joinChannel(token, channelName, userId);`服务直接崩了，
打印日志如下：
```log
2025-08-22 11:06:54.595 [http-nio-7005-exec-1] INFO  c.d.c.c.SWController - [start,302] - 收到开始录制请求 -> 频道: 张恒-李四-邻里纠纷-2025-08-22 08:57:12, 用户ID: 1, Token前缀: 007eJxTY
2025-08-22 11:06:54.676 [http-nio-7005-exec-1] INFO  c.d.c.c.SWController - [start,321] - AgoraRecorderManager 初始化成功，录制路径: /home/yingzhen/dispute/uploadPath/video
2025-08-22 11:06:54.676 [http-nio-7005-exec-1] INFO  c.d.c.d.v.AgoraRecorderManager - [startRecording,95] - 开始订阅音频流
2025-08-22 11:06:54.677 [http-nio-7005-exec-1] INFO  c.d.c.d.v.AgoraRecorderManager - [startRecording,98] - 开始订阅视频流
2025-08-22 11:06:54.678 [http-nio-7005-exec-1] INFO  c.d.c.d.v.AgoraRecorderManager - [startRecording,104] - 配置录制参数，存储路径: /home/yingzhen/dispute/uploadPath/video
2025-08-22 11:06:54.680 [http-nio-7005-exec-1] INFO  c.d.c.d.v.AgoraRecorderManager - [startRecording,109] - 即将加入频道 -> 频道名: 张恒-李四-邻里纠纷-2025-08-22 08:57:12, 用户ID: 1
```

，房间已经创建，token有效，请帮忙排查是哪里的问题，如何解决，崩溃日志见附件

Reply: 您好，看您的打印里频道名包含中文字符，我们的 SDK 是不支持中文字符当频道名使用的，建议先跑通我们的[官方示例](https://github.com/AgoraIO-Extensions/Agora-Recording-Java-SDK/blob/main/README.zh.md)

---
# ID: 36831

SDK Product: RTC

SDK Platform: React

SDK Version: 2.4.0

Request Type: 集成问题咨询

Request Description: gateway.agora.io网关服务器连接不上  前提：关闭防火墙 并且使用ping尝试，提示如下：连接失败: `AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: dynamic use static key`

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
按照ai 机器人回复的  需要重新设置   `mRtcEngine.setupRemoteVideo(new VideoCanvas(null, VideoCanvas.RENDER_MODE_FIT, cuurentuid));`
然后在设置 ` mRtcEngine.setupRemoteVideo(new VideoCanvas(sView1, VideoCanvas.RENDER_MODE_FIT, newuid));`
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
```java
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

Request Description: 我调用start接口返回了sid，但之后我stop返回
```json
{"cname":"24080002","code":404,"reason":"failed to find worker","uid":"1"}
```
，请问这是什么原因

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
设备已启动并且已加入频道，然后网页端，加入频道后，设备端报错 Invalid payload type 100

并且音频流回调(__on_audio_data)一直没有调用到，这是什么原因

Reply: 您好，Invalid payload type 100 指的是音频播放异常，100 是 PCM 格式，所以是解码后播放 PCM 有问题，定位在解码上。RTSA 和 Web 的音频编码协议不同，您需要保证双方用都支持的协议来互通，具体实现方式参考[与 RTC SDK 互通音视频数据](https://doc.shengwang.cn/doc/rtsa/c/best-practices/interoperate-rtc)

---
# ID: 36822

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 线上报错

Request Description: 云端录制报错：
```json
{"notifyMs":1755765617377,"productId":3,"payload":{"serviceType":0,"uid":"999","serviceScene":"mix_record","sendts":1755765617340,"sequence":3,"cname":"show","details":{"stat":0,"errorLevel":5,"errorMsg":"","module":0,"errorCode":110,"msgName":"cloud_recording_error"},"sid":"fb9549dbc24a76aefa00739c7172a41b"},"eventType":1,"noticeId":"eb63b9b4304ba87769f708800ffc35b3","sid":"fb9549dbc24a76aefa00739c7172a41b"}
```
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

Request Description: 切换音频输出设备（扬声器/听筒）是`this.localTracks.audioTrack.setPlaybackDevice（‘speaker’）`这个么，扬声器speaker听筒earpiece

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
```json
{"sid":"185D526B7A9340298EBB55CAF9BDE93D","noticeId":"1217926940:819614:102","productId":1,"eventType":102,"notifyMs":1755675705500,"payload"{"channelName":"test#video_live_room#544886#1755668941","lastUid":539647,"ts":1755675704}}
```

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

Request Description: 云录播生成的地址无法播放：`https://img.slowvers.com/cloud/consultant/20250818/c25081814368505348/cb1e074e6b41065cbe056abdd95c35b7_c25081814368505348.m3u8`

Reply: 您好，请问有尝试过用 VLC 或者 IINA 之类支持播放 m3u8 文件的播放器去播放吗？可以先尝试下不同的播放器。如果都放不出来可以检查下 OSS 是不是对 ts 进行鉴权了导致无法直接外部播放。如果也没有进行鉴权，可以等候人工工程师稍后跟进为您解答。

---
# ID: 36754

SDK Product: RTC

SDK Platform: Flutter

SDK Version: 6.5.2

Request Type: 集成问题咨询

Request Description: 在Android 16kb 排查过程中检测出了：
```
/var/folders/6w/fx8cm7lj7q75yb3tchdsv_1r0000gn/T/app-testenv-release_out_XXXXX.ZrwrRj5hRP/lib/armeabi-v7a/libagora-fdkaac.so: \e31mUNALIGNED\e0m (212)
/var/folders/6w/fx8cm7lj7q75yb3tchdsv_1r0000gn/T/app-testenv-release_out_XXXXX.ZrwrRj5hRP/lib/armeabi-v7a/librongcloud_xcrash.so: \e31mUNALIGNED\e0m (212)
```
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
```C++
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
```


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

Request Description: 我已经联系了 CAT1运营商(中国移动) 并添加了共三个域名的白名单. 通过测试, 可以在嵌入式设备上成功加入RTC CHANNEL并双向语音聊天. 但有发现, 在设备侧有较大概率连接失败, 从串口日志中大概看是以下出错: `Join the channel xxxxx successfully, uid xxxxxx elapsed xxx ms Remote user "xxxxx" has joined the channel, elapsed xx ms connection timeout, reconnecting `然后会自动重连, 有时是可以成功的: `Rejoin the channel successfully, uid xxxxxx elapsed xxxx ms video: uid=xxxxxx muted=1`

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
```json
{"cname":"33569888","resourceId":"mwwME88RCsfOLdLU7jz_vv96oQaavE6DxZUokGPrRqQzTTNMe_LwWQQVul8ZdLmre8FCHavQKtQwiKbIh_CCiDgA8cNaBA4KkJQ8SnyDkdIRwE2RbtaByJfRp1kkU3-achv2jhDgJU-h4cXE4anHOpHuAvoAG5HaByEKHYcAywCw3zx_74308gvXIHWwYyZZBSPFIQydW-MWhYzR7OO3Qw","serverResponse":{"extensionServiceState":{"serviceName":"yitu_voice_async_scan","streamState":{"status":"inProgress","streamType":"audio","uid":"0"}},"subServiceStatus":{"mediaDistributeService":"serviceReady","recordingService":"serviceInProgress"}},"sid":"90366c486949ec5bfef24cb787f113c6","uid":"999"}
```

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
```log
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
```

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
```java
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
```

Reply:  您好，调用destroy接口 是可以触发104、106 离开事件的；但是业务侧不建议这样调用，更合理的方式的是调用leavechannel接口，我们建议是 engine 在 app 声明周期里复用一个就可以，不要重复创建和销毁。

---
# ID: 36533

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.3.0

Request Type: 集成问题咨询

Request Description:  请问下服务器api禁用用户视频推流后,会让画面保持在最后一帧.有没有办法在不调整客户端的情况,禁用推流后,让画面黑掉?

Reply:  您好，当通过服务器 API（如 RESTful API）禁用用户视频推流后，远端设备默认会显示最后一帧画面。这是声网 SDK 的默认行为；不修改客户端逻辑是无法实现黑屏的；建议您可以监听 [onremotevideostatechanged](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_video_basic#callback_irtcengineeventhandler_onremotevideostatechanged) 回调来判断远端是否发流，如果远端不发流，既可以清除远端视图view，参考文档：

---
# ID: 36534

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.2

Request Type: 集成问题咨询

Request Description: 这边想要体验一下声网的高级美颜。
麻烦 发一下对接文档  Demo这些

Reply:  您好，请参考[高级美颜](https://doc.shengwang.cn/doc/rtc/android/advanced-features/advanced-beauty)


---
# ID: 36539

SDK Product: Cloud-recording

SDK Platform: Restful

SDK Version: 当前版本

Request Type: 集成问题咨询

Request Description: 发起录制报错

请求： `https://api-cn-east-1.sd-rtn.com/v1/apps/7184450bb5d14f4fa61a90f32c6ac131/cloud_recording/acquire`
请求体：
```json
{"cname":"10003","uid":"1754556256324","clientRequest":{"scene":0,"startParameter":{"token":"007eJxTYIh/ss7rgYTt29a/3/9n6jyweq1tvu5f1Pf5Fxvjbn5aZ/xFgcHc0MLExNQgKck0xdAkzSQt0cww0dIgzdgo2Swx2dDY8HnilIyGQEYGlRslTIwMEAjiszIYGhgYGDMwAACv0yLT","recordingConfig":{"channelType":1},"recordingFileConfig":{"avFileType":["hls","mp4"]},"storageConfig":{"vendor":2,"region":0,"bucket":"baomihua-short","accessKey":"xxx","secretKey":"xxx"}}}}
```
返回：
```json
{"code":2,"reason":"api body validate failed!"}
```

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

```json
{"type":"tts","code":1002,"message":"rate limit","timestamp":1754531123280}
```

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

Request Description: 我这边是用uniapp的video组件进行拉流和live-pusher组件进行推流的，配置的域名推流是`swpush.tohello.cn`，播放域名是`swpull.tohello.cn`，CNAME也配置好了，推流请求的完整地址是`rtmp://swpush.tohello.cn/live/stream1`，拉流请求的完整地址是`rtmp://swpull.tohello.cn/live/stream1`。目前没跑鉴权
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
麻烦完整描述下使用场景并且提供 SDK 日志（使用命令 `hdc file recv /data/app/el2/100/base/[包名]/haps/entry/files`)，人工工程师稍后为您解答

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

Reply:  您好，在使用rtc通话中本地接听手机电话，rtc侧会可以通过 onLocalAudioStateChanged 回调来监听本地音频采集状态：
reason：`LOCAL_AUDIO_STREAM_REASON_INTERRUPTED (8)`
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
	1. uid=123 听不到/看不到 uid=456，大约持续20分钟。
	2. uid=123 听/看 uid=456卡顿
4. [SDK日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)（非必提供)
5. 主播是否使用声卡
6. 主播端声网sdk日志（非必需）
另外您这边也可以参考下我们的[高音质实践](https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality)文档，来对项目进行优化。

---
# ID: 36496

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.1

Request Type: 集成问题咨询

Request Description: `CONNECTION_STATE_FAILED(5)`：网络连接失败
CONNECTION_CHANGED_BANNED_BY_SERVER (3)：网络连接被服务器禁止，例如，当用户被踢出频道时，会返回该状态。 确认下  只有用户被踢 这个 reason 才会返回3  还是有其它情况 也会返回3

Reply:  您好，是的，`CONNECTION_CHANGED_BANNED_BY_SERVER (3)` 是只有用户被踢出频道（例如通过服务端RESTful API主动踢人）才会触发的

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
1、降低编码码率为18 Kbps，调用[setAudioProfile](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#setAudioProfile%20[2/2])接口，参考文档

2、开启[音强选流](https://doc.shengwang.cn/doc/rtc/android/advanced-features/audio-stream-filter)，默认是接收远端音频强度最高的3路音频流，可以减少接收端下行带宽压力及系统资源消耗。

---
# ID: 36413

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.5.0

Request Type: 线上报错

Request Description: 如果在语聊期间，退到后台，长时间会触发什么?

Reply:  您好，应用退后台后，部分系统存在回收资源的情况，会引发音频无声、画面黑屏的情况；建议您这边业务侧做下[后台保活](https://doc.shengwang.cn/faq/quality-issues/android-background)。

---
# ID: 36416

SDK Product: RTC

SDK Platform: iOS

SDK Version: 4.2.6

Request Type: 集成问题咨询

Request Description: firebase 收到了这个空指针的问题：
```
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
```


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
1. 声网频道号(cname)
2. 出问题的时间点
3. 问题现象： (例)
	1. uid=123 听不到/看不到 uid=456，大约持续20分钟。
	2. uid=123 听/看 uid=456卡顿
4. [SDK日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)（非必提供)
5. 主播端声网sdk日志（非必需）


---
# ID: 36422

SDK Product: RTC

SDK Platform: Android

SDK Version: 4.4.1

Request Type: 集成问题咨询

Request Description: 请 `Request Description: sendStreamMessage() called error: -12` 是什么原因

Reply:  您好，错误码 12 表示接口调用太频繁，您可以调整下接口调用的频率再试试。

---
# ID: 36426

SDK Product: RTC

SDK Platform: Unreal

SDK Version: 其他版本

Request Type: 集成问题咨询

Request Description: uniapp 平台的插件只支持 iOS 和 Android？

Reply:  您好，我们的 [uni-app SDK](https://github.com/AgoraIO-Community/Agora-Uniapp-SDK/tree/master) 已经停止更新和维护了，目前只有老版本SDK对外开放，可以先参考文档跑通Demo，或者直接使用目前我们还在支持的平台来开发
[uniapp 跑通文档](https://shimo.im/docs/sng09z58Jo4FWtoB/) ,Access Password axucpk

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

Request Description: 试用对话式 AI 引擎 Playground，配置了豆包、千问等LLM都不能使用。参数都是没有问题的，附件2图片是我测试豆包的LLM接口，是可以调用成功的。 错误信息：`{ "module": "llm", "code": 500, "message": { "error": { "code": "AccessDenied", "message": "The request failed because you do not have access to the requested resource. Request id: 021754292599099078532ccda42bfe607645d235a467167bd1a7b", "param": "", "type": "Forbidden" } } }`

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

Reply:  您好，可以先确认下您目前所用的 SDK 版本是否为官网最新版本，并且麻烦提供下问题复现时的SDK日志（`hdc file recv /data/app/el2/100/base/[包名]/haps/entry/files`），提供下复现问题时的现象视频。人工工程师稍微确认下这个问题的具体原因。

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

Request Description: `https://api.sd-rtn.com/v1/apps/{appid}/cloud_recording/resourceid/{resourceid}/mode/{mode}/start`
调用这个录制接口成功后， 云服务器上没有录制的文件

回答思维链：这是一个云录制问题，可以让客户提供下 sid，等待稍后人工工程师查询具体上传情况。

Reply:  您好，麻烦提供下对应的 sid，人工工程师稍后看下后台记录。

---

# ID: 34650

SDK Product: RTC

SDK Version: 4.5.1

SDK Platform: Android

Request type: 集成问题咨询

Request Description: 我正在从3.7版本sdk升级到4.5.1，其中有一个API被废弃，enableDeepLearningDenoise：AI 降噪将在后续版本改由 SDK 控制，不通过 API 实现，这个AI降噪具体是由哪个SDK控制呢，这个SDK相关文档是哪个呢？

回答思维链：客户是从3.x升级上来的，还不理解4.x的3A 处理是默认开启的，可以和客户解释下，并且说明AI降噪是付费项目，如果客户确定需要的话，再提供具体的api来开启。

Reply:  您好，4.x SDK 默认开启 [3A 处理]([https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality#%E5%85%B3%E9%97%AD-3a](https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality#%E5%85%B3%E9%97%AD-3a))，AI 降噪是收费功能，一般来说 SDK 自带的 3A 就够用了。您可以先试下自带3A的效果，不满意的话我们再讨论下。

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

Request Description: `(void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason`

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

回答思维链：客户应该是需要直接推 RGB 数据发送到频道里，可以让客户在 create_custom_video_track_frame 里指定 send_video_frame的 frame format ，里面可以选择 I420、RGBA、I422等格式

Reply:  您好，[create_custom_video_track_frame](https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/agoraservice#createcustomvideotrackframe)里可以指定send_video_frame的 frame format，里面可以选择 I420、RGBA、I422等格式。

---

# ID: 34631

SDK Product: RTC

SDK Version: 4.5.1

SDK Platform: Android

Request type: 线上报错

Request Description: andorid sdk 语聊房连麦无声音

回答思维链：客户反馈了一个线上连麦无声的问题，但是没有提供频道信息，可以先找客户确认出现问题的频道号、uid、时间点，具体现象是什么，方便人工工程师后续排查。

Reply:  您好，麻烦提供频道名，说明什么时间段，哪个 uid 听不见哪个 uid。方便的话，麻烦提供下设备[SDK日志](https://doc.shengwang.cn/faq/integration-issues/set-log-file)过来看下。

---

# ID: 34627

SDK Product: RTC-Linux

SDK Version: 4.4.30

SDK Platform: Linux-Java

Request type: 集成问题咨询

Request Description: 你好，我想知道怎么实现AI算法服务集成这个功能，我们算法服务是在另外一个服务器上。我们现在引用的算法支持的流是rtsp、rtmp这种，我想知道我们的是什么流？我看推荐srs。

回答思维链：客户似乎想通过 RTSP 或者 RTMP 协议来获取实时的 RTC 流，但声网 RTC 流是封装过的，无法直接获取，可以推荐客户使用旁路推流功能来获取实时 RTC 频道里的画面

Reply:  您好，我们的 RTC 是自研封装的 RTC 协议，需要通过集成客户端 SDK，通过加入频道的方式才能拿到频道里的流。如果拉流打算用 RTMP 一类的协议去实现，可能需要[旁路推流](https://doc.shengwang.cn/doc/media-push/restful/landing-page)功能。

---

# ID: 34617

SDK Product: RTC

SDK Version: 其他版本

SDK Platform: Android

Request type: 集成问题咨询

Request Description: 视频发送端使用的android设备，sdk版本号3.3.0.设备使用了上海联通定向卡，添加了`*.agora.io，.agoraio.cn，.sd-rtn.com` 三个通配域名。在进入频道后，发生视频，sdk无报错。水晶球系统看，发送端正常推流。但是接收端(web，sdk版本4.11.0）无法接收到视频，水晶球显示无接收信息。
测试频道号djcs000002,可以随时复现。
需要麻烦贵司支持人员，协助解决，帮忙找出是否需要添加其他域名或ip白名单，或者其他解决方式。

回答思维链：这个客户应该使用了物联网卡设备，不过用的是 RTC Android SDK。可以先让客户检查下有没有在初始化 SDK 的时候设置 mDomainLimit 为 true，需要mDomainLimit+报备物联网卡域名才能使用的。

Reply:  您好，可以检查下 Android 端初始化的时候，有没有开启 mDomainLimit 字段的开关，要设置为 True，否则只报备域名是不够的。

---

# ID: 34600

SDK Product: RTC

SDK Version: 4.19.0

SDK Platform: Web

Request type:线上报错

Request Description: 
创建频道成功了, 但是设备端一直无法加入,且会自动退出, 帮忙查看一下什么原因

回答思维链：客户虽然选择了 Web，但是问题描述里提到了 pid，可能是一个 RTSA 设备和 Web 互通的问题，所以需要找客户先要日志来看下具体的打印再分析无法加入和自动退出的原因。

Reply:  您好，如果是 RTSA 设备的话，麻烦提供出现问题的设备SDK 日志，在初始化的时候可以配置[日志等级](https://doc.shengwang.cn/api-ref/rtsa/c/agora__rtc__api_8h#agora_rtc_set_log_level())和路径。
加入频道失败需要看本地打印。

---

# ID: 34575

SDK Product: RTC

SDK Version: 4.19.0

SDK Platform: Web

Request type: 集成问题咨询

Request Description: 使用临时生成的token，并且调用时不使用uid可以播放，会触发user-joined事件，但是换成从服务端获取的token，并且调用时带上uid就不能播放了，无法触发user-joined事件，也没有报错

回答思维链：客户用临时token的时候可以加入频道发流并且监听user-joined事件，但是用自己生成的token就不行了，可以让客户检查下token和uid是否匹配，以及是否用主播身份加入频道发流了，观众是无法触发user-joined 的

Reply:  您好，临时 token 不校验 uid 所以能进频道，自己生成的 token 是要校验 uid 的，需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道

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

Reply:  您好，可以参考[方案对比](https://doc.shengwang.cn/doc/whiteboard/javascript/fastboard-sdk/solution-compare)文档，根据您的业务需求选择。

---

# ID: 34558

SDK Product: RTC

SDK Version: 4.4.1

SDK Platform: HarmonyOS

Request type: 集成问题咨询

Request Description: 我想把harmonyOS项目转换为openharmony项目，发现openharmony不支持kit，想要使用要改成ohos，但是使用到的 `import{ rcp }from '@kit.RemoteCommunicationKit';` 是HMS，华为的，不支持openharmony，最终实现不了

回答思维链：客户在用openharmony，但我们 SDK 没有适配过openharmony，无法保证可用性，需要建议客户避免类似操作来解决。

Reply:  您好，
1. 我们的 SDK 没有计划适配openharmony， 之前在openharmony上尝试跑过，能跑，但是功能有问题。不推荐
2. 针对这个问题 应该是api level 太低导致的， openharmony 至少应该到对应HarmonyOS API 12的 api 才能跑

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

Reply:  您好，麻烦提供下具体的 cid、申请时间、接收邮箱地址，稍后人工工程师就为您解答。

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

自己生成的 token 是要校验 uid 的，需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道

控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验
将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致

---

# ID: 34504

SDK Product: RTC

SDK Version: 4.0.0

SDK Platform: Android

Request type: 集成问题

Request Description: 在调用 joinChannelWithUserAccount 后没有收到任何回调，例如onJoinChannelSuccess、onConnectionStateChanged、onError。已经确认传入的token有效，频道一致，uid也有值。初始化也没问题。

`rtcEngine?.joinChannelWithUserAccount(SPfUtil.getInstance().getString("rtc_token"), channel, SPfUtil.getInstance().getString("token_uid"), options)`

回答思维链：客户在使用 string uid 的情况下遇到了一些预期外的情况，可以推荐客户先避免使用 string uid 看下问题是否还会复现

Reply:  您好，可以尝试下避免使用`joinChannelWithUserAccount`，SDK 对于 String 类型 uid 的适配不好，建议用 int 类型 uid

---

# ID: 34490

SDK Product: RTC

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询 

Request Description: `https://api.sd-rtn.com/dev/v1/channel/user/{appid}/{channelName}/hosts_only `该接口是否有延迟情况?使用该接口时会产生水晶球中显示通话状态已结束，但是接口中还能查到主播id并且channel_exist=true，是否可以用该接口来查询流在线状态

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

# ID: 34427

SDK Product: RTC

SDK Version: 4.19.0 

SDK Platform: Web

Request type: 集成问题咨询

Request Description: 鉴权使用java端生成的token，在web端使用join的时候报错：`Uncaught (in promise) AgoraRTCException: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: invalid token, authorized failed`，java端和demo流程是一样的

回答思维链：客户使用了自己生成的 token，得到了 invalid token, authorized failed 的报错打印，这表示 token 不匹配，需要检查传入的 uid 频道名是否匹配。

Reply:  您好，invalid token, authorized failed 就是 token 错误，临时 token 不校验 uid 所以能进频道，自己生成的 token 是要校验 uid 的，需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道。
控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验，将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致

---

# ID: 34422

SDK Product: RTC

SDK Version: 2.1.6

SDK Platform: Linux-Python

Request type: 集成问题咨询

Request Description: 示例程序没跑通，连接不上频道，只打印了on_connecting，没打印on_connected
命令：
```shell
(yolov8py310) das@das:~/AI4UAVVideo/AIProcessor/Agora$ python agora_rtc/examples/example_audio_pcm_receive.py --appId=xxx --channelId=test --userId=8 --sampleRate=16000 --numOfChannels=1
```

输出：
```log
INFO:common.parse_args:Parsed arguments:Namespace(appId='xxx', token=None, channelId='test', connectionNumber=1, userId='8', audioFile=None, lowdelay=False, videoFile=None, sampleRate=16000, numOfChannels=1, fps=None, width=None, height=None, bitrate=None, message=None, hours='0', saveToDisk=0, mode=1, value=0)
INFO:common.example_base:------channel_id: test, uid: 8
INFO:common.example_base:connect_and_release: 0, auto_subscribe_audio: 1
INFO:observer.connection_observer:on_connecting, agora_rtc_conn=<agora.rtc.rtc_connection.RTCConnection object at 0x7f4e8321b430>, local_user_id=8, state=2, internal_uid=0 ,reason=0
```

回答思维链：客户的打印里没有出现加入频道成功的打印，但也没有失败的报错，推测是uid 频道名和 token 不匹配导致没加入频道，可以让客户自查一下，如果没问题，再让客户提供具体日志过来。

Reply:  您好，请问拉的是最新版本 [Python SDK Demo](https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/tree/main/agora_rtc/examples) 吗？

跑的时候可以注意下 uid 频道名和 token 是否匹配，如果拉最新版本还是跑不通，可以拿一下 SDK 日志过来。初始化的时候可以配置[日志等级](https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/agoraservice#setlogfile)

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
```yaml
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
```shell
go: github.com/AgoraIO/Tools/DynamicKey/AgoraDynamicKey/go/src@v0.0.0-20240807100336-95d820182fef: Get "https://proxy.golang.org/github.com/%21agora%21i%21o/%21tools/%21dynamic%21key/%21agora%21dynamic%21key/go/src/@v/v0.0.0-20240807100336-95d820182fef.mod": dial tcp 142.251.211.241:443: i/o timeout
make: * [Makefile:33: deps] Error 1
```

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

Reply:  您好，需要用任意客户端集成我们 SDK 以后进入相同的RTC 频道来互通，你可以先用我们的 [Demo](https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo) 加入，然后开麦说话就行，如果你完成第五步了你就是进频道发流的状态。确保智能体在频道里工作时和它对话。

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

Reply:  您好，3.x 的本地服务端录制已经停止更新维护了，有录制需求建议走[云录制](https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page)。

---

# ID: 34307

SDK Product: RTC

SDK Version: 其他版本

SDK Platform: Web

Request type: 效果不佳、不达预期

Request Description: 接入web版本，安卓web版本开启关闭扬声器正常，但是苹果的web版本关闭扬声器无效果，苹果需要特殊的设置吗？

回答思维链：Web-IOS 上有一个已知问题描述和客户的现象类似，IOS 在 web 上调用 RemoteAudioTrack.setVolume 方法无法改变音量，需要让客户用unsubscribe 的方式来替换实现，可以让客户确认下是否调用了RemoteAudioTrack.setVolume 才出现类似情况

Reply:  您好，请问现在有调用RemoteAudioTrack.setVolume 方法吗？IOS 在 web 上调用 RemoteAudioTrack.setVolume 方法无法改变音量，可以考虑用 [unsubscribe](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iagorartcclient#unsubscribe) 的方式来替换实现。
以及也可以参考下[已知问题](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility)。

---

# ID: 34306

SDK Product: RTC

SDK Version: 4.4.2

SDK Platform: HarmonyOS

Request type: 集成问题咨询

Request Description: 为了解除某个远端用户的视图绑定，在调用`setupRemoteVideo`方法时，传入null或者undefined，抛出异常，提示类型错误。
`this._rtcEngine?.setupRemoteVideo(null)`。
我应该怎么做才能解除某个远端用户的绑定视图。

回答思维链：客户正在尝试在HarmonyOS平台上解除远端试图绑定，但是直接给setupRemoteVideo传了null，应该引导客户给videocanvas里的xcomponentId传空

Reply:  您好，不是在`setupRemoteVideo`里传空，应该给`videocanvas`里的 `xcomponentId` 传空来实现。

---

# ID: 34300

SDK Product: RTC

SDK Version: 4.0.0

SDK Platform: Android

Request type: 集成问题咨询

Request Description: 声网加入频道joinChannelWithUserAccount返回0说明加入成功，但是偶现收不到自己加入成功的回调onJoinChannelSuccess，帮忙排查一下原因

回答思维链：没有收到onJoinChannelSuccess 大概率是加入频道失败了，客户以为joinChannelWithUserAccount 返回 0 就表示加入成功的理解是不对的，需要解释一下加入频道需要以会掉为准，并且引导客户监听onConnectionStateChanged 来了解实际的频道链接状态

Reply:  您好，调用 join 方法后 return0 只代表方法执行完毕，收到onJoinChannelSuccess才算加入成功。可以业务上监听onConnectionStateChanged 来判断实际的频道链接状态。参考[频道连接状态管理](https://doc.shengwang.cn/doc/rtc/android/basic-features/channel-connection)。

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
```log
[ERR] License verified failed, reason: 1
[2025-03-04 14:36:01.714][ERR] License verified failed, reason: 1
```

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

Reply:  您好，需要在声网 console 左侧边栏自行预授权，预授权完成后再去激活使用，可以参考[申请和使用 License](https://doc.shengwang.cn/doc/rtsa/c/basic-features/license)

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
1. “我的资源”上传资料出现异常，前后上传了两个文档，控制台打印 error
```shell
2025-02-25 15:29:20 ERROR [EduErrorCenter] error 600064: Error: upload to oss error
at c._putFile ([https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9461176](https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9461176 "Follow link"))
at async c.uploadPersonalResource ([https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9462184](https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9462184 "Follow link"))
```
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
```
.agora.io，.sd-rtn.com
udp:8443, 5888-5889, 4000-4100, 8130
tcp:443, 8443, 80
```
服务端是不是只需要通过这些域名端口访问就行，我们服务还需不需要从服务端接收什么

回答思维链：这是一个linuxSDK 网络环境配置问题；通过问题描述来看，客户的使用环境是有防火墙的，客户侧需要知道声网SDK在有限制的网络环境下如何配置，这里需要是声网云代理方案

Reply:  您好，针对网络访问限制的环境，需要使用声网[云代理](https://doc.shengwang.cn/doc/rtc-server-sdk/java/advanced-features/cloud-proxy)方案；需要开启云代理以后再配置指定域名、端口、协议才能使用


---

# ID: 34061

SDK Product: RTC

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询

Request Description: 咨询一下，一个频道从创建、到销毁，它的生命周期是怎么维护的，有哪些场景会触发销毁机制，文档没看到说明，如有请提供下文档。谢谢

回答思维链：客户在尝试理解 RTC 的频道什么周期，但是频道的创建和销毁是我们后端完成的，可以告诉客户无需关心，专注于频道内事件。

Reply:  您好，频道的创建和销毁是由我们后端做的，对于用户来说只需要考虑加入频道和退出频道就行，频道里有人就是频道存在，频道里没人就是不存在。可以通过关注[频道事件类型](https://doc.shengwang.cn/doc/rtc/restful/webhook/events)来感知。

---

# ID: 34044

SDK Product: CDN

SDK Version: 当前版本

SDK Platform: CDN

Request type: 其他问题

Request Description: 有没有类似，腾讯的拉流转推功能

回答思维链：这是一个产品功能问题，首先融合cdn是不支持拉流转推的，拉流转推应该是伪直播功能，推荐使用云端播放器

Reply:  您好，融合CDN是不支持拉流转推能力的；这边您可以使用我们的[云端播放器](https://doc.shengwang.cn/doc/media-pull/restful/overview/product-overview)产品，实现拉流播放，参考文档如下：

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
	1. uid=123 听不到/看不到 uid=456，大约持续20分钟
	2. uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供

另外也建议咱们检查下无人机的网络是否正常

---
# ID: 34039

SDK Product: RTC-Linux

SDK Version: 2.1.6

SDK Platform: Linux-Python

Request type: 集成问题

Request Description: agora_python_server_sdk中的IVideoEncodedFrameObserver接口，触发时返回的image_buffer[:length]，我需要将缓存的数据进行解码转为图片存储到本地设备，但是使用pyav解码时，总是提示image_buffer[:length]数据无效，或者数据不完整，请问导致问题的原因是什么


回答思维链：这个一个`linux-python IVideoEncodedFrameObserver`接口使用问题；客户反馈 image_buffer 数据无效、不完整；比较怀疑是不是推送进来的数据就出现异常；比如可以先在同一个频道加个接收端和python互通，图像是否正常；

Reply:  您好，这里比较怀疑是推送进来的数据就出现异常，建议您这边测试下在同一个频道加个接收端和python端互通，接收端图像是否正常；

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
	1. uid=123 听不到/看不到 uid=456，大约持续20分钟
	2. uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
另外加入频道失败通常和客户端网络异常，token无效或者过期；您这边也可以检查下，同时也建议咱们业务侧监听下[onError](https://doc.shengwang.cn/doc/rtc-server-sdk/java/error-code) 回调。


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
5.sdklog：如果有的话尽量提供，[日志设置](https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/apidatatype#agoraserviceconfig)。
另外加入频道失败通常和客户端网络异常，token无效或者过期；您这边也可以检查下，同时也建议咱们业务侧监听下[onError](https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/error-code) 回调，接口参考文档如下：

---

# ID: 33961

SDK Product: RTC

SDK Version: 4.4.1

SDK Platform: Android

Request type: 效果不佳、不达预期

Request Description: `mRtcEngine.muteRemoteAudioStream(uid, true); `关闭远程用户的语音流 ， 远程用户 `onRemoteAudioStateChanged` 回调未触发

回答思维链：客户以为 `muteRemoteAudioStream` 会控制远端的发流状态，需要提醒客户`muteRemoteAudioStream` 只能控制本端不订阅，`onRemoteAudioStateChanged` 回调只有在远端自己改动发流状态的时候才会触发

Reply:  您好，[muteRemoteAudioStream](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_publishnsubscribe#api_irtcengine_muteremoteaudiostream)只是控制本端不去订阅远端发出的音频流，不会控制远端的实际发流情况。
[onRemoteAudioStateChanged](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#onRemoteAudioStateChanged)是远端用户采集、发送层面出现变动时才会触发的回调，mute 方法不会影响到远端的实际发流所以不会触发。

---

# ID: 33931

SDK Product: RTC

SDK Version: 4.23.0

SDK Platform: Web

Request type: 集成问题咨询

Request Description: 如何在使用过程，切换转换前置和后置摄像头

回答思维链：客户需要在Web上实现切换设备，可以让客户参考我们Demo的实现，用setDevice来切换。

Reply:  您好，可以参考我们[Demo](https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo)的实现，用[setDevice](https://doc.shengwang.cn/doc/rtc/javascript/basic-features/switch-device)来切换

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
1. 向运营商报备`*.agora.io, *.sd-rtn.com`两个通配域名（至少需要`*.agora.io`，最好是也加上`*.sd-rtn.com`以满足高可用需求）。如需区域限制功能，需要增加`*.agoraio.cn`这个通配域名。
2. 代码设置
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

Reply:  您好，请问您说的“同步播放设备的屏幕”是指屏幕共享吗？如果是的话需要注意：移动端灵动课堂不支持屏幕共享，Web 和桌面端支持，可以跑下对应的 Demo，修改[MediaOptions](https://doc.shengwang.cn/api-ref/flexible-classroom/javascript/classroom-sdk#mediaoptions)。

---

# ID: 33906

SDK Product: RTC-Linux

SDK Version: 2.1.

SDK Platform: Linux-Go

Request type: 集成问题咨询

Request Description: OnPlaybackAudioFrameBeforeMixing回调的音频流编码是什么格式的?

回答思维链：这是一个linux-go 音频裸数据接口使用问题，可以给客户发下官网文档接口说明；另外声音的音频裸数据回调格式默认是PCM 16位的

Reply:  您好，[OnPlaybackAudioFrameBeforeMixing](https://doc.shengwang.cn/api-ref/rtc-server-sdk/go/go-api/audioframeobserver) 接口回调的音频格式默认是PCM 16位，同时您这边可以通过[SetPlaybackAudioFrameBeforeMixingParameters](https://doc.shengwang.cn/api-ref/rtc-server-sdk/go/go-api/localuser#setplaybackaudioframeparameters)接口设置pcm的声道数和采样率。

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
5. sdklog：如果有的话尽量提供 [如何设置日志文件](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# ID: 33881

SDK Product: RTC-Linux

SDK Version: 2.1.2

SDK Platform: Linux-Go

Request type: 集成问题咨询

Request Description: PushPCMData 发送的数据比特率和采样率是多少？发送的语音消息过快，导致播放音频变成噪音

回答思维链：这是一个linux-go sdk 自采集音频接口相关的问题，通常音频的pcm的样本字节数是16位的，采样率最低是8000；这里可以参考官网的接口文档；对于发送的语音消息过快，声网这里推荐是10ms发送一次音频采样样本；

Reply:  您好，对于接口使用来说，您这边可以参考我们的[AudioFrame](https://doc.shengwang.cn/api-ref/rtc-server-sdk/go/go-api/apidatatype#audioframe)接口使用说明
另外对于音频发送过快导致的噪声问题，声网建议是每10ms发送一次音频采样样本。

---

# ID: 33848

SDK Product: Media-push

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询

Request Description: 旁路推流可以推rtsp的流吗？或者平台有转rtsp流的功能吗

回答思维链：客户在咨询旁路推流是否支持推 rtsp 流，这个是不支持的。后半句又有转换 rtsp 流的需求，可以咨询下客户目前的场景，了解下是什么原因让客户如此需要 rtsp 流，理论上 RTMP 和  RTSP 的区别不会特别大。

Reply:  您好，不支持，平台也不提供转换的能力。请问您这边是什么场景一定需要 RTSP？可以考虑下用旁路推流推到 RTMP 地址上然后自行转换到 RTSP 地址。

---

# ID: 33836

SDK Product: Media-pull

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询

Request Description: 使用在线媒体流功能，房间号：test_agora；  
请求参数中开启了如下配置，通过数据流返回点播流播放进度：  
`"dataStreamOptions":{ "enable": true }`

然后使用API-Examples中的「Create Data Stream」demo看收到的消息都是固定的（长度为21个字节）：  
`66 72 6f 6d 3a 20 31 39 38 37 37 20 6d 65 73 73 61 67 65 3a 20`，转换为ascii码为：from: 19877 message:

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

Request Description: 你好，我们在开发过程中，通过询问Ai助手得知类似禁言等一些功能需要我们的后端去实现，助手给了一些接口，咨询助手接口的文档后，根据指引没有找到对应的后端文档，你们有技术可以拉群吗

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

Reply:  您好，2.x 上 [publish](https://doc.shengwang.cn/api-ref/rtm2/javascript/toc-message/message#publish) 方法本身就是带Promise的，您可以监听方法执行完成的 result 来判断消息是否发送成功。

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
[MediaStreamTrack: getSettings() method](https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamTrack/getSettings) 是 WebRTC 官方的接口，这个接口是浏览器根据你的硬件能力最终选择的分辨率配置，属于浏览器行为
[MediaStreamTrack: getConstraints() method](https://developer.mozilla.org/en-US/docs/Web/API/MediaStreamTrack/getConstraints) 是你直接设置的配置，但只能告诉浏览器你期望设置到什么分辨率的采集，实际的情况还要看硬件上限以及浏览器行为选择，一般会受到硬件自身限制的影响。

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

Request Description: 创建 RtmClient 时报错：`Exception in thread "main" java.lang.UnsatisfiedLinkError: no aosl in java.library.path`
```

实际报错如下：  
```log
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
```

回答思维链：客户的打印里有“no aosl in java.library.path”，看起来是没有配置本地变量路径。可以让客户参考我们的 README 文档配置下本地变量再试试

Reply:  您好，`no aosl in java.library.path`是本地变量没有配置好路径才会出现的报错，请问您这边有参考过我们 [README 里的步骤](https://github.com/AgoraIO/RTM2/tree/main/Agora-RTM2-QuickStart-Linux-Java#4-build-and-run)，去配置环境吗？

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

Request Description: 利用RtcTokenBuilder2Sample.java生成了 Token （Token with uid)，该Token在辅助工具--Token校验工具中，是校验通过的。
【问题】  
前端代码在运行时，提示：  
`AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: invalid token, authorized failed`
出现问题的调用代码：
`agoraClient.join(agoraPara.appid, agoraPara.channel, agoraPara.token)`
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
```log
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
```

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
```dart
engine.enableContentInspect(enabled: true, config: const ContentInspectConfig(extraInfo: "test", modules: [ContentInspectModule(interval: 5, type: ContentInspectType.contentInspectSupervision)])) 
```
3. 打开后输出：
```log
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
```log
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
```


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

# ID: 33714

SDK Product: RTMP

SDK Version: 当前版本

SDK Platform: Restful

Request type: 集成问题咨询

Request Description: 在测试环境生成推流码，通过测试环境的域名 `rtmp://rtls-ingress-test.agoramdn.com/live` 一直推流不成功

回答思维链：客户选的是旁路推流，但问的问题是RTMP 网关，需要和客户再次确认下用的到底是哪个产品。如果是 RTMP网关的话，这个推流域名地址不应该有 test，正确的地址是 `rtls-ingress-prod-{region}.agoramdn.com/live`

Reply:  您好，请问现在在用的是旁路推流还是 RTMP 网关？这是两个不同的产品。如果是后者的话，需要注意：推流域名地址不应该有 test，正确的地址是 `rtls-ingress-prod-{region}.agoramdn.com/live`
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

回答思维链：客户在用鸿蒙 SDK，但是没有说明“没有回调”具体指的是什么回调，需要确认下具体现象以及客户说的回调是哪个回调。并且收集日志以便稍后人工工程师解答，因为客户用的是鸿蒙 SDK，所以获取日志的方式是：`hdc file recv /data/app/el2/100/base/packagename/haps/entryname/files`

Reply:  您好，enableLocalAudio是控制本地音频采集的接口，设置为 false 以后就关闭采集了。请问现在的现象是接收不到哪一个回调？
以及有复现时的 SDK 日志吗？鸿蒙获取日志的方式为：`hdc file recv /data/app/el2/100/base/packagename/haps/entryname/files`，您可以完整描述下现象并且提供对应时间的日志，人工工程师稍后为您解答

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
```json
{"cname":"123456","uid":"10002","resourceId":"VIFvR6qvdFkRNRDsj9uhhEgnjLZrTmUD8olvImTJYa2AG3nJ3sFuW56NIVBSlorjqUXA8NREU7o_0O_OqzHYDuRpxX7YoztodTrox6tqSFWRPhi4XUiGFbkgv7IlXV7aDq32wfE1NEXUXyz4kE4hJb9C3WS5p5XeFccuYVTdjmb34Bpgcr7O9fgz8CgVGB6Q","sid":"2354cf898b41b76d70850ba58b9b9ffb","code":49,"serverResponse":{"backuped":0,"fileListMode":"string","fileListStr":"quickstart/2354cf898b41b76d70850ba58b9b9ffb_123456.m3u8","gwWorkerVersion":1,"inProgressBitmask":1,"output":{},"payload":
{"message":"Failed"},"selectionBitmask":1,"subscribeModeBitmask":1}}
```
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

回答思维链：客户提交的产品是云录制，但问的问题和云录制看起来不相关的，需要找客户再确认下现在到底在用什么产品。问题本身是 RTC 检测远端主播发流的，可以让客户在 Python 里监听on_user_video_track_state_changed回调，更具这个回调去判断频道里的远端视频流发送情况。因为Python官网文档有些滞后，需要让客户检查下 SDK 代码来完成回调监听。

Reply:  您好，请问您这边是在用云录制还是 RTC？这个问题看起来是 RTC 监听远端发流状态的问题。Python Linux SDK 可以通过监听里监听 `on_user_video_track_state_changed` 回调来了解远端发流状态，参考：[local_user_observer.py#L73C9-L73C42](https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/blob/12fcb294749875d19503c7a93f318f67da2b6187/agora_rtc/agora/rtc/local_user_observer.py#L73C9-L73C42)

---

# ID: 33658

SDK Product: CDN

SDK Version: 当前版本

SDK Platform: CDN

Request type: 效果不佳、不达预期

Request Description: 回调地址设置不上 报错如下
NCS 健康检查结果: 
```log
Test Failed
f"success":false,"httpCode" 590,"eror":"Post
"https://gl.kmg-s.kz:31443/fre-eye/agora/notice\".
context deadline exceeded (Client.Timeout exceeded
while awaiting headers)","response":"
```

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

一下是设置的参数；其中height和 width 无论设置成什么 最终录制的视频比例感觉都一样
```java
'transcodingConfig' => [  
'height' => 1080,  
'width' => 1920,  
'bitrate' => 500,  
'fps' => 30,  
'mixedVideoLayout' => 0,  
'backgroundColor' => '#FF0000'  
],
```

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

# ID: 33617

SDK Product: RTC-linux

SDK Version: 4.4.30

SDK Platform: Linux-C

Request type: 集成问题咨询

Request Description: 1. 我看sdk接受pcm流之后只有通道数，采样率这些信息，pcm的sample_fmt是什么呢？
对应到ffmpeg中是
```c
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
```

是哪个枚举呀

回答思维链：通过问题描述看，客户想咨询linux sdk 音频自采集接口相关功能；这里涉及到sendAudioPcmData()接口的使用，以及与FFMPGA的AVSampleFormat 之间的使用关联

Reply:  您好，对应声网sdk来说，pcm都是16位的，即2个字节，对应的是bytes_per_sample这个字段。

---
