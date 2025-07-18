# **工单训练 RAG 集**

本篇《工单训练 RAG 集》汇集了近期在声网各类 SDK 产品集成与使用过程中遇到的典型问题及解答。内容涵盖了从技术集成、线上报错、效果优化到商务和权限相关的常见场景，旨在为开发者和技术支持人员提供高效、实用的参考。通过梳理每个工单的提问、分析思路与标准回复，本文帮助读者快速定位问题本质，掌握处理思路，提升工单首次响应与技术支持的专业能力。

---

# **编号：36144**

**SDK Product: Cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 效果不佳、不达预期**

问：云端录制单流录制模式只有分片文件？不能设置输出一个完整的录制文件？现在看每个分片只有15秒，太少了

回答思维链：客户应该已经收到了云录制的录制文件，但是不知道录制完成后会生成一个完整的 m3u8 来播放，可以让客户查询下 OSS 内是否有 m3u8 文件

答：您好，录制结束以后会有一个 m3u8 文件可以完整播放所有切片文件，您播放 m3u8 就可以了，参考：[https://doc.shengwang.cn/doc/cloud-recording/restful/user-guides/manage-file/introduce-recorded-files](https://doc.shengwang.cn/doc/cloud-recording/restful/user-guides/manage-file/introduce-recorded-files)

---

# **编号：36136**

**SDK Product: RTC**

**SDK Version: 4.2.0**

**SDK Platform: React Native**

**Request type: 集成问题咨询**

问：我们想在linux上做使用java做服务，可以服务很多客户端。
对每个客户端，java服务都可以进入的一个房间给客户端1对1的进行语音应答。
请问，这边有linux-java的sdk吗

回答思维链：客户需要 Linux Java 服务端的 SDK，给他提供对应地址即可

答：您好，服务端 SDK 支持创建多个 connect，每个 connect 对应一个频道

[https://doc.shengwang.cn/doc/rtc-server-sdk/java/resources](https://doc.shengwang.cn/doc/rtc-server-sdk/java/resources)

---

# **编号：36112**

**SDK Product: RTC**

**SDK Version: 其他版本**

**SDK Platform: Android**

**Request type: 线上报错**

问：这个频道，1个老师，2个学生上课。但是1个学生反馈他能看到听到老师，但老师好像没看见他。
后台看了下，这个有问题的学生，一开始进入了6874e8bef0db19910003557e的通话ID，然后又超时退出了。老师进入了另一个通话ID。
既然退出了，那么学生怎么没有被踢出房间，而且还能看到在另一个通话ID的老师，但老师没有看见他？

回答思维链：针对线上视频可用性问题，用户必需先提供准确的问题频道号、时间点、以及那个uid看不到那个uid，以便去查看后台的对应用户的视频相关参数有没有异常，进而给出初步的答复。

答：您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
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

# **编号：36099**

**SDK Product: Flexible-classroom**

**SDK Version: 其他版本**

**SDK Platform: Android**

**Request type: 线上报错**

问：孩子用的新东方小课屏那种平板上课，老师反馈听不清，孩子的声音很小，有时有回音。孩子也听不清老师的声音。

回答思维链：针对线上音频体验类问题，声音小，听不清，回声等问题，初步都是需要客户侧提供频道号、时间点、uid信息等关键信息，结合内部排查工具后才能给初步结论

答：您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
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

# **编号：36075**

**SDK Product: Cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 线上报错**

问：我们的服务检测到使用restful 接口关闭录制时，调用时间很长（15s左右），具体请求地址如上，麻烦给看下

回答思维链：客户反馈云录制调用 stop 的耗时很久，可能是因为调用 stop 时 body 里传参 async_stop 为 false，导致需要等录制文件都上传完才会返回结果，所以耗时通常会久一些，可以让客户先自行检查下这个字段。

答：您好，可以捞一下调用 stop 时的完整请求内容看下是不是用了async_stop 为同步，如果是同步的话，需要等录制文件都上传完才会返回结果，所以耗时通常会久一些。

---

# **编号：36024**

**SDK Product: RTC**

**SDK Version: 4.23.2**

**SDK Platform: Web**

**Request type: 线上报错**

问：多人视频聊天场景, web端和安卓端都是用了相同的appID, 证书也都获取到了token, web端和web端可以视频聊天, 安卓端和安卓端也可以正常视频聊天
但是web端的"user-published"可以监听到web端的上线信息, 但是无法监听到安卓端的上线信息是为什么? 我的电话15623522002

回答思维链：这是一个web 和native 互通的问题，web端无法监听到安卓上线，怀疑是安卓端没有加入频道成功，需要先收集频道相关信息分析

答：您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](~https://doc.shengwang.cn/faq/integration-issues/set-log-file~)

---

# **编号：35990**

**SDK Product: RTC**

**SDK Version: 4.2.0**

**SDK Platform: IOS**

**Request type: 商务问题**

问：已经重新绑定付款信用卡，麻烦安排重新扣款，谢谢，我这边还需要重置邮箱和手机号，谢谢，之前绑定邮箱和手机号已经无法使用。

回答思维链：这是一个和账号相关的商务问题，无法回答，可以用话术让用户稍作等待，让人工工程师来解决。

答：您好，已收到您的工单，人工工程师马上就会为您解答，请稍等

---

# **编号：35989**

**SDK Product: RTC**

**SDK Version: 4.2.0**

**SDK Platform: Android**

**Request type: 线上报错**

问：两个主播连麦，看不到双方画面并提示连麦回调失败，请断开连麦后重新连接！

回答思维链：1、需要和客户确认采用那种连麦方式，如果是跨频道mediarelay方式需要确认是否开通服务权限2、需要和客户确认UI侧提示连麦回调失败 是根据声网那个回调实现的；3、需要和客户收集频道号、时间点查看频道内的数据情况

答：您好，需要您这边确认以下几点：

1、使用那种连麦方式，多频道方式还是跨频道mediarelay方式，如果是后者，需要提供下项目appid我们查下是否开通服务；

2、UI侧提示连麦回调失败 是根据声音那个回调实现的？

3、您这边也可以提供下出现问题的声网频道号，问题时间点以及声网的sdk日志（https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file），

---

# **编号：35975**

**SDK Product: RTM**

**SDK Version: 2.2.2**

**SDK Platform: Flutter**

**Request type: 集成问题咨询**

问：怎么单对单发送图片消息。

回答思维链：客户用的是 RTM，现在需要发送图片消息，但是 RTM 本身不支持传输图片消息，客户有需要的话可以建议他用环信 IM 这类即时聊天 SDK 来实现更好。

答：您好，RTM 是信令 SDK，不支持直接传输图片，有图片传输需求的话可以考虑环信 IM：[https://www.easemob.com/](https://www.easemob.com/)

---

# **编号：35950**

**SDK Product: RTSA**

**SDK Version: 1.9.5**

**SDK Platform: Linux-C**

**Request type: 线上报错**

问：当设备有双网卡时 会偶现不停地断线重连断线重连持续好多遍 单4G 或 单WIFI 不会出问题

回答思维链：根据客户的描述，sdk重连和设备多网卡有必然联系；比较怀疑是sdk在适配这种特殊的双网卡设备有兼容性问题，需要拿到sdk日志进一步确认
答：您好，建议您先确认下设备在双网卡下对外网络连接是否正常，如果确认没有问题，需要您这边提供以下信息进一步排查定位：
1. 声网项目APPID、频道号(cname)：
   2.问题时间点:
   3.需要您拿下rtsa sdk的日志，参考文档 [https://doc.shengwang.cn/api-ref/rtsa/c/structlog__config__t#log_path](https://doc.shengwang.cn/api-ref/rtsa/c/structlog__config__t#log_path)

---

# **编号：35935**

**SDK Product: RTC**

**SDK Version: 4.3.0**

**SDK Platform: Android**

**Request type: 效果不佳、不达预期**

问：双人连麦，编码配置：720p，1600kbps，20fps。 室内连麦直播时，帧率正常可达到20fps。跑到室外后，帧率掉到7fps。码率能保持在1600kbps。
这情况下因为帧率太低能明显感觉到画面一卡一卡的。这情况怎么优化？
环境变差时sdk内部是优先确保码率的吗？有没有其他配置可以动态调优

回答思维链：1、通过客户描述看视频编码帧率下降大概率是因为网络变差导致的，需要和客户收集频道号、时间点、uid 等信息进一步确认 2、sdk内部编码降级偏好是通过setVideoEncoderConfiguration方法可以配置的

答：1、您好，看您的描述视频帧率下降可能是因为室外网络变差导致的，麻烦您这边提供以下信息我们排查下：
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   2、我们是有api 是调整sdk 编码降级偏好的，setVideoEncoderConfiguration方法，参考文档如下:
   [https://doc.shengwang.cn/api-ref/rtc/android/API/class_videoencoderconfiguration](https://doc.shengwang.cn/api-ref/rtc/android/API/class_videoencoderconfiguration)

---

# **编号：35931**

**SDK Product: RTC**

**SDK Version: 当前版本**

**SDK Platform: restful**

**Request type: 集成问题咨询**

问：通话过程中调用接口禁止用户推流后，用户依然在进行视频推流。
调用 kickingRule 接口请求 id bffdce7fc07a431cba08789f5de6e145

回答思维链：客户调用了封禁接口，也得到了请求成功后的规则 id，通常来说表示调用成功了，封禁应该是生效的。但不清楚具体现象是什么，封禁只会影响远端观看，本端预览是继续工作的，可以先找客户确认下现象，以及要个完整请求内容看看

答：您好，看起来接口调用是成功的，请问实际频道内远端可以看到来自被封禁用户的画面吗？封禁不会停止用户本地的采集状态，只影响线上观看，您这边可以先确认下现象，然后提供下原始请求内容，放在 txt 里用附件发到工单

---

# **编号：35927**

**SDK Product: RTC**

**SDK Version: 4.5.1**

**SDK Platform: Android**

**Request type: 效果不佳、不达预期**

问：1、使用场景：调用加入频道方法joinChannel，并 监听onConnectionStateChanged及onJoinChannelSuccess回调，如果onJoinChannelSuccess触发认为加入成功，显示画面；若onConnectionStateChanged触发且state == 5，则退出该次录制，并提示错误原因；

2、问题表现：客户使用华为P30准备录制，页面一直黑屏，未退出无任何提示；

3、备注：我们本地使用安卓10及更老的设备都未复现该问题，线上客户100%复现该情况，通过后端日志，确实可以推断出用户尝试了几十次；

回答思维链：该问题是个视频不可见，需要和客户收集频道号、时间点查看频道内的数据情况，看下视频采集为啥失败了

答：您好，视频黑屏的可能因素有很多，比如摄像头异常，摄像头被占用等；这边需要您提供下以下信息，我们进一步排查下：
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# **编号：35908**

**SDK Product: RTC**

**SDK Version: 4.4.1**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：1、请问下你们rtm登录的时候这里的图1中的RtmConfig.Builder是属于用户的唯一标识符吗？如果其他用户与其交互是不是就是这个值
2、图2中是rtc加入频道的方式，本地端A和远程端B，都是调用这个方法mRtcEngine?.joinChannel加入频道对吧，那这里的uid和问题1中的是同一个吗？因为joinChannel中的uid是int类型，而问题一的是 String类型如果写0的话会不会不调用onJoinChannelSuccess回调方法
3、问题三：因为你们RtmConfig.Builder是支持string类型的唯一标识符，而rtc的mRtcEngine?.joinChannel中的uid是int类型，他们两个是同一个东西吗？

回答思维链：客户工单提交的产品类型是 RTC，但是问到了 RTM 的问题，推测是两个 SDK 都有集成但是不太清楚两个 SDK 的区别。问题一需要和客户解释下 RTM 里的唯一标识符是 userid。问题二有问到 RTC 的 uid 是否和成功加入频道触发 onjoinchannelsuccess 相关，可以和客户解释下 joinchannel 应该用 int uid，joinchannelwithaccount才能用 string uid，以及应该推荐客户使用 int uid 的方法去加频道，这样 SDK 优化更好。问题三可以和客户解释并强调下 RTC 和 RTM 是两套独立的 SDK，彼此互不相通。

答：1、是的，userid 是不重复的唯一标识符

2、是的，RTC 用 joinChannel 来加入频道，RTC 的 uid 和 RTM 的 userid 不是同一个东西。RTC 加频道推荐用 joinchannel 方法，传 int uid 来加入频道，还有joinchannelwithaccount 方法是用 string uid 的，我们更推荐用 int 类型的方式，这样 SDK 优化更好

3、不是一个东西，不互通

---

# **编号：35900**

**SDK Product: RTC**

**SDK Version: 4.23.2**

**SDK Platform: Web**

**Request type: 线上报错**

问：本地服务端录制，token过期后不会自动续期，而是报错onError channelId:test error:ERR_TOKEN_EXPIRED message:

回答思维链：客户的工单分类选择了 RTC Web，但是问的问题是本地服务端录制的 token 问题，可能是分类选错了，应该专注在客户的实际提问上。本地服务端录制是有 renew 方法来传入新 token 的，客户有提到“token过期后不会自动续期”，可能是没有用到 renew 方法，也可能没有理解 token 过期以后要重新生成一个来传入的逻辑，可以和客户解释一下 renew 的常规流程和原理。

答：您好，本地服务端录制 SDK 是自带一个 renewtoken 方法的，可以在收到 token 即将过期的回调时先在自己业务服务器上生成一个新的可用 token，然后用 renew 方法传入这个新的 token，这样录制端被分配的 uid 就可以用新的 token 继续待在频道里了，token 是不会自己续期的。

---

# **编号：35897**

**SDK Product: convoai**

**SDK Version: 当前版本**

**SDK Platform: restful**

**Request type: 集成问题咨询**

问：智能体加入频道失败
{
"agent_id": "A42AV45RD89DJ78LK99VN94PV47FY24T",
"message": "agent exits with reason: RTC connection failed",
"start_ts": 1751102804,
"status": "STOPPED",
"stop_ts": 1751102804
}

回答思维链：加入频道失败的原因大多数是和token有关，比如token无效、过期等，可以先引导客户校验token；客户请求正常返回了agent_id，后续可以依据id去查看后台日志定位具体原因。

答：您好，加入频道频道失败通常是和token有关，比如token无效、过期等；您这边可以登录console—>控制台—>辅助工具—>token生成/校验，先校验下token。

---

# **编号：35864**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: IOS**

**Request type: 集成问题咨询**

问：我想在iOS中实现 关闭视频或摄像头后 显示头像或一张本地的图片 并且远端的用户看到的也是这张图片

回答思维链：客户需要在实现本端设备发流状态改变以后修改远端用户的 UI 显示改用自定义图片，这个需求需要能够感知远端用户的发流情况来做对应处理，可以让客户监听我们 SDK 的remoteVideoStateChangedOfUid 来感知远端设备的发流情况，然后在感知到远端不发流的时候自定义图片展示

答：您好，可以监听remoteVideoStateChangedOfUid，在远端不发流的时候前端上写个业务来展示指定图片：[https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_basic#callback_irtcengineeventhandler_onremotevideostatechanged](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_basic#callback_irtcengineeventhandler_onremotevideostatechanged)

---

# **编号：35862**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: IOS**

**Request type: 集成问题咨询**

问：我想在iOS中实现多个视图显示本地视频预览,但是一直无法实现.
附件为我在Xcode中的代码.

回答思维链：看客户描述应该是想把本地画面渲染多次，这是需要在canvas 里配置setupMode  为 AgoraVideoViewSetupAdd 才能实现的，否则无法达到效果，可以让客户检查下有没有实现相关操作

答：您好，请问是想把本地画面渲染多次吗？如果是的，需要在对应的 canvas 配置里设置 setupMode  为 AgoraVideoViewSetupAdd

[https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_rendering#setupLocalVideo:](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_rendering#setupLocalVideo:)

---

# **编号：35850**

**SDK Product: Cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询**

问：使用安卓端SDK，在安卓app发起云录制请求。请求资源接口可以正常返回，但请求开始录制接口返回错误
请求录制资源接口返回：

{"cname":"aac","uid":"9527","resourceId”:"xxx"}

【请求开始录制】

返回：
httpcode ：400

{code=2, reason='request_hash mismatch!'}

回答思维链：这是一个云录制的问题，客户在 acquire 的时候应该添加了 startParameter 字段，如果在acquire 环节添加了，后续再调用 start 的时候，body 内容和startParameter 不一致就会报错request_hash mismatch! 不推荐客户这样操作，可以推荐客户减少acquire 填写的内容，把具体的 start 配置放在 start 请求 body 里去实现

答：您好，request_hash mismatch! 的打印是 acquire 的 startParameter 和后续的 start 内容不同导致的，建议您不要在 acquire 里填写太多内容，可以参考我们文档右侧的示例请求，用最少的内容 acquire ，然后在 start 的 body 里详细填写具体配置

---

# **编号：35849**

**SDK Product: Cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 效果不佳、不达预期**

问：1对1的视频通话进行正常，录制也正常完成，没有出现错误。
但录制视频存放至阿里云OSS后发现，只有.ts文件和.m3u8文件存储了，mp4文件没有按要求生成。

这个现象在之前的视频通话也发生过一次。但其他视频通话都正常。烦请帮忙查看一下没有生成mp4文件的原因。

回答思维链：这看起来是一个云录制的线上问题，云录制的 ts 切片和 m3u8 都是实时上传 OSS 的。如果客户在 start 的时候指定了转码，那就会在 24 时内由声网侧转码 mp4 文件再上传 OSS。客户说 ts 和 m3u8 都收到了，说明预留的 OSS 信息应该没问题，上传链路是通畅的，但至于为什么没有 mp4，可能是转码还没有完成（可以让客户再等等，最晚不会超过 24 小时），也可能是 mp4 文件的上传有些问题（需要找客户提供下具体的录制 sid，来让相关同事调查后台日志看看具体原因）

答：您好，mp4 一般是 24 小时内完成转码再上传的，您可以先等 24 小时，如果还是没有的话，可以提供下具体的 sid，我们看下后台记录

---

# **编号：35787**

**SDK Product: RTC**

**SDK Version: 4.20.0**

**SDK Platform: Web**

**Request type: 效果不佳、不达预期**

问：android端角色是"讲师" ,web端是学员,学员端存在卡顿情况,3月下旬时web端是流畅的,今天看过web端存在卡顿,效果请看视频

回答思维链：客户应该是提供了现象视频并且咨询了一个线上问题，这类问题目前需要人工工程师来接管，可以先收集下客户的问题现象和出现问题的设备日志，推进下问题排查进展

答：您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   另外也麻烦您看下本身设备侧采集是否正常，比如使用其他语聊类app（微信）通话是否正常；或者使用自带的录音机录制看下是否正常

---

# **编号：35780**

**SDK Product: RTC**

**SDK Version: 4.2.2**

**SDK Platform: Android**

**Request type: 线上报错**

问：建立连接无法进行通话

回答思维链：看客户问题描述是无法通话，可能是线上无法加入频道，也可能是只有一方加入了频道，现在缺少的信息太多，无法直接分析出问题所在，可以先收集下客户的网络情况和出现问题的设备日志，推进下问题排查进展

答：您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   另外也麻烦您看下本身设备侧采集是否正常，比如使用其他语聊类app（微信）通话是否正常；或者使用自带的录音机录制看下是否正常

---

# **编号：35774**

**SDK Product: RTC**

**SDK Version: 4.20.0**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：集成问题咨询，尽快联系13752561012

回答思维链：客户想要语音咨询问题，但没有文字说明具体要讨论什么，可以先让客户文字描述下自己的问题，让稍后的电话沟通更高效一些

答：您好，您可以先把问题在工单里描述下，这样稍后的电话沟通更有重点

---

# **编号：35773**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: IOS**

**Request type: 集成问题咨询**

问： 问题平台：iOS
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

答：您好，在 xocde 的 info-Target Properties-Bundle display name 里传屏幕分享的Bundle Id 就可以了

---

# **编号：35770**

**SDK Product: RTC**

**SDK Version: 4.4.0**

**SDK Platform: IOS**

**Request type: 集成问题咨询**

问：您好 我们这用的环信的uikit做了一个IM系统，然后现在要集成RTC，发现生成rtc token的时候总是报错，现在我们没有太多时间找代码的问题，能否给一个配上环信和声网的就能跑的demo 单聊 群聊 音视频通话 就这几个功能 谢谢

回答思维链：客户需要知道如何生成 RTC 的 token 来加入频道，直接推荐客户 clone 我们的 token 示例代码仓库本地运行去生成就可以了

答：您好，clone 这个仓库下来，用示例代码去生成 token 即可

[https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication#token-code](https://doc.shengwang.cn/doc/rtc/android/basic-features/token-authentication#token-code)

---

# **编号：35769**

**SDK Product: RTC**

**SDK Version: 4.21.0**

**SDK Platform: Web**

**Request type: 集成问题咨询**

问：你好，集成了屏幕共享功能，如何停止屏幕共享，使用ScreenSharingClient.leave()方法虽然频道中看不到屏幕共享，但是本地的屏幕共享流依然存在（就是截图中的提示框依然在），请教一下该如何停止呢。

回答思维链：客户反馈的现象是调用leave()后屏幕共享依旧没有停止，应该是屏幕共享的 track 被创建以后没有释放导致的，可以让客户释放对应的 track 来解决

答：您好，可以尝试下调用对应 track 的 close 方法去释放来解决这个问题：[https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/ilocaltrack#close](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/ilocaltrack#close)

---

# **编号：35768**

**SDK Product: RTC**

**SDK Version: 4.5.1**

**SDK Platform: Android**

**Request type: 线上报错**

问：1. 问题表现： Android端的用户和web的客服建立双向视频后，Android端看不见web端客服的视频，只能看到自己。 Web端可以看到自己 也可以看到用户
2. 线上出现概率为1% - 2%
3. 经过开发代码排查，定位原因是 Android端AgoraSdk的 onUserJoined 方法没有被调用，导致自定义videoview无法显示出来

override fun onUserJoined(uid: Int, elapsed: Int)

{ Log.i("AgoraManager", "CS-UserJoined uid = $uid") *levelLiveData.postValue(false)* uidJoinLiveData.postValue(uid) }

回答思维链：onUserJoined回调被触发是有条件的，比如远端用户是否是主播身份，需要先提供相关频道和uid信息来佐证

答：您好，onUserJoined回调在如下情况下被触发：
远端用户/主播加入频道。
远端用户加入频道后将用户角色改变为主播。
远端用户/主播网络中断后重新加入频道。

需要您这边提供下频道号，时间点，以及uid，我们查下远端用户是否是主播身份

[https://doc.shengwang.cn/api-ref/rtc/android/API/toc_channel#callback_irtcengineeventhandler_onuserjoined](https://doc.shengwang.cn/api-ref/rtc/android/API/toc_channel#callback_irtcengineeventhandler_onuserjoined)

---

# **编号：35760**

**SDK Product: RTC**

**SDK Version: 4.2.1**

**SDK Platform: Android**

**Request type: 效果不佳、不达预期**

问：pc 端用obs 临时token 推流
app 端 调用获取房间列表的接口为啥显示不出来？
尝试更换了 [https://service-staging.agora.io](https://service-staging.agora.io/ "Follow link") 这个域名也是拿不到
接口参数如下

回答思维链：客户提交的 SDK Platform 写的是Android，但是问题描述提到的是PC用OBS，需要和客户再确认下现在在用哪个产品，以及用的是什么方式来加入频道的

答：请问现在 PC 是如何实现推流的？是用的 OBS 插件还是 RTMPG 服务？

[https://doc.shengwang.cn/doc/rtmp-gateway/restful/landing-page](https://doc.shengwang.cn/doc/rtmp-gateway/restful/landing-page)

---

# **编号：35759**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: IOS**

**Request type: 效果不佳、不达预期**

问：2个手机进入同一个频道，但是画面很暗，基本看不清对面的画面

回答思维链：这个现象应该不是必现的，推测和客户的设备或者集成有关，可以先让客户运行我们的Demo看下是否能复现，来排查到底是SDK问题还是客户自己的设备问题

答：您好，可以用我们 Demo 尝试复现下：[https://github.com/AgoraIO/API-Examples/tree/main](https://github.com/AgoraIO/API-Examples/tree/main)

一般不会有这个问题，可以确认下摄像头本身是否正常工作

---

# **编号：35758**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：Android sdk中，设置音频编码格式为g711后，能否设置采样率为8k和16k，需要用哪个接口呢？

engine.setParameters("

{\"che.audio.custom_payload_type\":8}

");

回答思维链：客户调用了私参接口来让android设备发送G711音频编码，但是G711编码只有8K采样率，无法切换到16K，G722才是16K的，所以这个需求无法实现

答：您好，G711 只有 8k 采样率，G722 才是 16k，没有办法指定 G711 用 16k 的

---

# **编号：35757**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：Android sdk 纯音频通话，如何设置音频编码格式，比如设置为g711或者g729。如果不能选择编码格式，几种场景采用的编码格式分别是什么呢？

回答思维链：客户需要让 Android 端发送 G711 或者 G722 的音频编码，一般这类需求是和 IOT 设备互通才有的，可以给客户提供下相关文档，在 join 前调用私参接口传入私参来改变编码配置

答：您好，需要在 join 之前调用私参接口来改变编码格式，参考：[https://doc.shengwang.cn/doc/rtsa/c/best-practices/interoperate-rtc#%E8%AE%BE%E7%BD%AE-rtc-native%E7%AC%AC%E4%B8%89%E6%96%B9%E6%A1%86%E6%9E%B6-sdkv4x](https://doc.shengwang.cn/doc/rtsa/c/best-practices/interoperate-rtc#%E8%AE%BE%E7%BD%AE-rtc-native%E7%AC%AC%E4%B8%89%E6%96%B9%E6%A1%86%E6%9E%B6-sdkv4x)

---

# **编号：35750**

**SDK Product: RTC**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 效果不佳、不达预期**

问：疑似未收到声网推送的主播离开频道事件。
需要协助排查该频道主播离开频道时的事件推送日志。

回答思维链：客户反馈没有收到主播离开频道的事件，但没有说明是服务端的Webhook NCS 事件还是客户端的回调，可以先和客户确认下这个细节来推进问题调查

答：您好，请问没收到的是客户端回调还是服务端 NCS 事件？

客户端的话可以提供下 sdk 日志：[https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

NCS 事件的话可以先去声网 console 上检查下回调地址是否有配置，以及健康检查是否通过

---

# **编号：35745**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: Unity**

**Request type: 集成问题咨询**

问：你好，我们的应用场景是unity开发的手段app与ai设备的实时语音通话，ai设备cpu架构是orinagx(英伟达 orin aarch64) 系统是ubuntu20.04 我在技术支持文件中没有找到该平台对应的sdk 改如何获取或者说支持该平台吗

回答思维链：客户的场景是在Unity下用app和Ubuntu设备在 RTC 频道里互通，声网有Unity的SDK，也有Ubuntu的服务端或物联网设备SDK，但客户现在没有找到，我们应该提供对应的文档地址给客户

答：您好，我们有服务端SDK支持arm的：[https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/resources](https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/resources)

还有 RTSA SDK，专门给一些 IOT 设备使用，里面有支持 aarch64 的，可以试下：[https://doc.shengwang.cn/doc/rtsa/c/resources](https://doc.shengwang.cn/doc/rtsa/c/resources)

---

# **编号：35740**

**SDK Product: RTC**

**SDK Version: 4.5.0**

**SDK Platform: Android**

**Request type: 效果不佳、不达预期**

问：当前版本4.5.0，2个移动端设备，互相呼叫，通过服务器生成同样的 token 和 channelName，调用 joinChannel 后，均回调了onJoinChannelSuccess，但是没有回调 onUserJoined，这是为什么？
用旧的版本 3.2.0 能回调 onUserJoined。业务依赖 onUserJoined 来判断远端用户是否加入成功，加入了则认为通话建立成功，若没回调，则一直处于拨号中的状态。

回答思维链：客户反馈用相同的 token 加入相同的频道以后都触发了onJoinChannelSuccess 但是没有 onUserJoined ，需要和客户确认下是否出现了用相同 token 和 uid 来加入频道导致互踢的情况，以及也要和客户确认下加入频道时双方的身份都是否为主播，onUserJoined 只有在远端是主播身份加入的时候才会触发。

答：您好，

1、onUserJoined只会在远端以主播身份加入的时候才触发，如果身份是观众就不触发了

2、如果用的是相同的 token，需要确认下 uid 是否相同，token 是和 uid 、频道名绑定的，但是 uid 在频道内不能重复，所以理论上不同 uid 的 token 应该不同，请确认下是否用了相同的 uid 加频道，导致了互踢

---

# **编号：35721**

**SDK Product: RTC**

**SDK Version: 4.21.0**

**SDK Platform: Web**

**Request type: 集成问题**

问：之前集成了实时共享RTC，加入频道也能正常共享视频，现在想在共享视频时，再共享屏幕，视频共享成功后调用了方法AgoraRTC.createScreenVideoTrack创建屏幕共享，然后在创建成功后调用rtc.Client.publish([localScreenTrack])，但是控制台报错AgoraRTCError CAN_NOT_PUBLISH_MULTIPLE_VIDEO_TRACKS；不知道什么原因，请教一下该如何处理。

回答思维链：报错写的是AgoraRTCError CAN_NOT_PUBLISH_MULTIPLE_VIDEO_TRACKS，这表示不能发送对路视频流。SDK 一个 uid 只能发送一路视频流，推测客户是用一个 uid 既发送屏幕共享流又发送摄像头流导致的。 

答：您好，一个 uid 只能发一路视频流，要发两路流就需要再创建一个 client，然后用不同的 uid 加入频道，指定发屏幕共享流。

---

# **编号：35703**

**SDK Product: cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: restful**

**Request type: 线上报错**

问：请求参数
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

答：您好，云录制启动报错，官网侧是有文档详细说明文档的，参考如下：
[https://doc.shengwang.cn/doc/cloud-recording/restful/response-code](https://doc.shengwang.cn/doc/cloud-recording/restful/response-code)

根据你这个错误码，比较怀疑是启动时传入的参数不合法导致的，请严格参照我们的云录制启动文档进行传参。

---

# **编号：35702**

**SDK Product: RTM**

**SDK Version: 其他版本**

**SDK Platform: Java**

**Request type: 线上报错**

问：我们公司的声网SDK，是声网之前给我们的内测版本。
平台：Android
今天上午发现大面积报错：Agora RTM join topic failed by join ret: -10001。无法加入RTM频道，RTC也不可用。相关错误码查不到，请教一下如何解决。

回答思维链：客户有提到用的是以前的内测版本，可能是个老版本了，应该推荐客户用现在最新的 RTM 2.x 来上线使用。

-10001 的错误码是有文档可以查看的，这表示没有初始化，可以让客户自查一下相关业务并且提供错误码文档给他。

答：您好，内测版本不推荐上线使用，建议集成我们2.x 最新的对外版本：[https://doc.shengwang.cn/doc/rtm2/android/landing-page](https://doc.shengwang.cn/doc/rtm2/android/landing-page)

10001 是没有初始化的报错，可以先检查下相关业务：[https://doc.shengwang.cn/doc/rtm2/android/error-codes#%E9%94%99%E8%AF%AF%E7%A0%81%E5%AF%B9%E7%85%A7%E8%A1%A8](https://doc.shengwang.cn/doc/rtm2/android/error-codes#%E9%94%99%E8%AF%AF%E7%A0%81%E5%AF%B9%E7%85%A7%E8%A1%A8)

---

# **编号：35675**

**SDK Product: RTC**

**SDK Version: 当前版本**

**SDK Platform: restful**

**Request type: 集成问题咨询**

问：hook回调地址配置报错:

NCS 健康检查
NCS 健康检查结果: Test Failed

{ "success": false, "httpCode": 502, "error": "Post "[https://imapi.irecircle.com/im-user/imRtcMeeting/hook\](https://imapi.irecircle.com/im-user/imRtcMeeting/hook%5C)": x509: certificate signed by unknown authority", "response": "" }

回答思维链：NCS健康检查报错，通常都是和客户的回调地址域名不通、https证书错误、请求超时导致的；需要客户侧自查

答：您好，webhook回调地址报错通常和咱们的配置的回调地址域名不通、https证书错误、请求超时等原因导致的，建议咱们先自查下，参考文档如下：
[https://doc.shengwang.cn/doc/rtc/restful/webhook/receive_webhook](https://doc.shengwang.cn/doc/rtc/restful/webhook/receive_webhook)

---

# **编号：35641**

**SDK Product: RTSA**

**SDK Version: 1.9.5**

**SDK Platform: Linux-C**

**Request type: 集成问题咨询**

问：你好，附件是我们的项目需求信息，请帮忙看下能否释放一下sigmastar 平台的RTSA SDK

回答思维链：这是一个RTSA相关问题，客户提到了sigmastar平台，应该是想确认我们的RTSA SDK 有没有适配此平台的版本，需查看官网的文档确认

答：您好，您这边可以参考官网RTSA 平台兼容文档以及下载文档来选择，如果没有支持咱们平台的版本，请联系 [sales@shengwang.cn](mailto:sales@shengwang.cn)
[https://doc.shengwang.cn/doc/rtsa/c/overview/product-overview](https://doc.shengwang.cn/doc/rtsa/c/overview/product-overview)
[https://doc.shengwang.cn/doc/rtsa/c/resources](https://doc.shengwang.cn/doc/rtsa/c/resources)

---

# **编号：35640**

**SDK Product: RTC**

**SDK Version: 4.2.0**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：实时RTC直播点击加入报110code

回答思维链：加入频道报错110，可以查官网的错误码即可

答：您好，加入频道报错110：Token 无效。一般有以下原因：

在声网控制台中启用了 App 证书，但未使用 App ID + Token 鉴权。当项目启用了 App 证书，就必须使用 Token 鉴权。
生成 Token 时填入的 uid 字段，和用户加入频道时填入的 uid 不一致。

您这边可以检查下

[https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_rendering#setupLocalVideo:](https://doc.shengwang.cn/api-ref/rtc/ios/API/toc_video_rendering#setupLocalVideo:)

---

# **编号：35638**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: Android**

**Request type: 其他问题**

问：1.加载两个远端视频流，在进行视图切换的时候出现黑色不显示视频流的情况，请问是什么原因？怎么排查？
2.附件中有具体的操作视频和部分代码截图

回答思维链：这是一个视频黑屏不可用问题，可以先让客户提供下频道号，问题时间点，以及是那个uid看不到那个uid的视频画面，看下对应用户的视频相关参数有没有异常；之后再拿sdk日志排查定位

答：您好，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网项目APPID、频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)
   另外也麻烦您看下本身设备侧采集是否正常，比如使用其他语聊类app（微信）通话是否正常；或者使用自带的录音机录制看下是否正常

---

# **编号：35637**

**SDK Product: CDN**

**SDK Version: 当前版本**

**SDK Platform: CDN**

**Request type: 其他问题**

问：尽快更新证书啊

回答思维链：客户咨询CDN证书更新相关问题，console上的证书更新是需要一定时间更新同步的；

答：您好，CDN相关的证书更新是需要时间的同步的，通常需要2周左右，您这边再耐心等待下；

---

# **编号：35634**

**SDK Product: RTC**

**SDK Version: 4.2.6**

**SDK Platform: Android**

**Request type: 开通权限、提高配额、上量报备**

问：帮我开通一下 跨频道流媒体转发功能

回答思维链：跨频道连麦功能需要提供appid ，后台开通

答：您好，麻烦提供下项目的appid，技术支持工程师在看到消息后会及时地给您开通，请耐心等待回复，感谢您的理解与配合，谢谢。

---

# **编号：35633**

**SDK Product: RTC**

**SDK Version: 其他版本**

**SDK Platform: Android**

**Request type: 其他问题**

问：视频无法呼出，或者接听视频之后几分钟之后就自动断开
用户ID：20513
用户ID：86042

回答思维链：客户问了2个问题，问题1是视频无法呼出，主要是和信令连通有关；问题2是接通视频成功后断开，需要提供对应时间点的频道号，uid信息看下断开原因

答：您好，视频无法呼出，主要是和呼叫邀请信令有关，需要您这边查下信令登录、发送、接收是否正常；
自动断开可能是业务侧异常调用leave接口退出频道，也可能是app闪退或者是设备网络异常导致的断开。

---

# **编号：35630**

**SDK Product: RTC**

**SDK Version: 其他版本**

**SDK Platform: Android**

**Request type: 线上报错**

问：android设备与pc端进行实时语音出现无法听到android端的声音，通过抓包看到如下信息：
Allocate Error Response error-code: 401 (Unauthenticated) Unauthorized with nonce realm: agoraio
214 Allocate

回答思维链：对于声音听不见问题，优先让客户提供频道号，时间点，以及那个uid听不到那个uid的声音；也有可能和客户侧的网络环境有关，比如设备不能直接公网等

答：您好，对于声音听不见的问题，麻烦您按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

也有可能和设备的网络环境有关，比如不能直连公网等

---

# **编号：35629**

**SDK Product: RTC**

**SDK Version: 4.4.1**

**SDK Platform: Android**

**Request type: 效果不佳、不达预期**

问：目前采用的是RTC极速模式、观众端看到的视频画质不很好、并且视频比较模糊、外置摄像头不能聚集

回答思维链：这是个视频体验类问题，视频模糊首先怀疑是指客户端网络问题，比如丢包、带宽不足等；也有可能是主播端的视频采集帧率低等，需要客户提供频道、uid等关键信息排查定位

答：您好，视频画质不好通常是和客户端网络较差有关，比如丢包、带宽不足等；也有可能是主播端的视频采集帧率低等；麻烦您按以下模版整理问题，我们查下频道内传输情况；
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# **编号：35626**

**SDK Product: RTC**

**SDK Version: 其他版本**

**SDK Platform: Android**

**Request type: 商务问题**

问：我们已经在6月1日购买了 实时互动尊享版，一共2388元，为何月账单还会扣除我们1024.57元，导致我们现在账户上还欠费-429.67，什么情况这是？

回答思维链：商务问题需要客户找到商务同事处理，或者拨打 400 6326626 电话
答：您好，商务计费相关问题，麻烦联系对应商务同事处理，或者您这边可以拨打400 6326626 电话联系处理，感谢您的理解与配合，谢谢。

---

# **编号：35580**

**SDK Product: RTC**

**SDK Version: 4.5.2**

**SDK Platform: Android**

**Request type: 崩溃（闪退、卡死）**

问：接收端是Linux系统，发端是安卓手机，型号是Vivo Z5x，安卓版本10，第二次发起后，Linux端会崩溃。
然后换另一台安卓手机，型号是荣耀X50，安卓版本15，多次发起，Linux 端不会崩溃。

回答思维链：客户咨询了一个崩溃问题，无法直接分析问题所在，应该先找客户收集崩溃堆栈、双方崩溃时的 SDK 日志信息，方便后续人工工程师调查。

答：您好，可以先参考下这篇文档收集崩溃时的堆栈和双方 SDK 日志，稍后人工工程师会解析崩溃查看具体堆栈在哪里了。

[https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# **编号：35517**

**SDK Product: RTSA**

**SDK Version: 1.9.5**

**SDK Platform: Linux-C**

**Request type: 崩溃（闪退、卡死）**

问：使用文件名为 Agora-RTSALite-RmRdRcAcAjCF-riscv-linux-gnu-1040-v821-v1.9.5-20250527_160103-718970 的SDK报错
报错截图和sdk自动生成的coredump都在附件内

ai分析说是动态库包含了一个特殊的 xandes5p0 扩展指令集导致的 供参考

回答思维链：这是一个 SDK 崩溃问题，目前无法直接解答，可以让客户提供崩溃堆栈和对应的 SDK 日志，等候人工工程师解答。

答：您好，崩溃问题可以提供下崩溃时的原始堆栈+SDK 日志，人工工程师稍后为您解答

如果不清楚如何获取，可以参考：[https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# **编号：35465**

**SDK Product: Convol AI**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 崩溃（闪退、卡死）**

问：为什么我昨天开通的账号试用，今天额度就没有了
只用了9分钟就冻结了账号
不是有1000分钟吗？

回答思维链：这是一个账号类商务问题，可以让客户自查下有没有用到付费产品导致停机，以及可以引导客户购买预付费套餐包来解冻

答：您好，人工工程师稍后给您解答，您可以先自查下是不是还用到其他不包含在免费 1w 分钟内的付费产品。如果有的话是会触发账号冻结的，需要购买预付费套餐包解冻。

---

# **编号：35444**

**SDK Product: Cloud-transcoder**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 开通权限、提高配额、上量报备**

问：帮我把这个appid开通云端转码服务 7dacdca9362c47289595189fe551c5c9

回答思维链：客户需要开通云端转码服务，并且提供了 appid，可以让客户稍作等待，人工工程师稍后就会开通

答：您好，已收到您的申请，稍后人工工程师会帮您开通这个服务，请稍等片刻。

---

# **编号：35420**

**SDK Product: Console**

**SDK Version: 当前版本**

**SDK Platform: All**

**Request type: 商务问题**

问：想了解一下这个账号的具体计费明细 方便下午 飞书啦一个会 对一下吗

回答思维链：这是一个计量计费咨询的商务问题，可以让客户优先阅读计量计费文档以及留下商务电话供客户沟通

答：您好，计费规则可以参考：[https://doc.shengwang.cn/doc/rtc/android/billing/billing-strategy](https://doc.shengwang.cn/doc/rtc/android/billing/billing-strategy)

其中的细节您可以电话沟通：400 6326626

---

# **编号：35046**

**SDK Product: RTM**

**SDK Version: 2.2.2**

**SDK Platform: C++**

**Request type: 奔溃（闪退、卡死）**

问：一共有40个客户端，每个客户端连接后订阅一个rtm频道，当有20个客户端连接并成功订阅后，新的客户端连接后 订阅失败，使用官方SDK程序测试，也会订阅失败，但我无法捕捉错误，因为问题来自dll文件，需要协助排查订阅失败，引起程序闪退的原因。

回答思维链：客户遇到了 2.2.2 版本 RTM 的崩溃，可以找客户确认下崩溃时的 dump 和 SDK 日志，等待人工工程师解析崩溃。

答：您好，可以先提供下崩溃的原始堆栈+SDK 日志，人工工程师稍后为您解答

[https://doc.shengwang.cn/doc/rtm2/cpp/error-codes](https://doc.shengwang.cn/doc/rtm2/cpp/error-codes)

---

# **编号：34762**

**SDK Product: RTC-Linux**

**SDK Version: 4.4.30**

**SDK Platform: Linux-Java**

**Request type:集成问题咨询**

问：Caused by: java.lang.UnsatisfiedLinkError: /data0/www/htdocs/code/lib/shengwang/libbinding.so: /lib64/libm.so.6: version `GLIBC_2.27' not found (required by /data0/www/htdocs/code/lib/shengwang/libagora_uap_aed.so)

centos7.5的 GLIBC是2.17 有木有对应版本的java pom 依赖

回答思维链：客户目前用的不是最新版本，可以让客户优先升级到 4.4.32 试一下，新版本里已经移除了对于这个库的依赖

答：您好，可以直接用目前的最新版本，最新版本里去掉了这个库

[https://github.com/AgoraIO-Extensions/Agora-Java-Server-SDK/tree/main](https://github.com/AgoraIO-Extensions/Agora-Java-Server-SDK/tree/main)

---

# **编号：34717**

**SDK Product: Flexible-classroom**

**SDK Version: 2.9.40**

**SDK Platform: Web**

**Request type: 线上报错**

问：灵动课堂api无法创建课堂，参数正确500错误
接口：[https://api.sd-rtn.com/cn/edu/apps/e1d4f3c1f7084458b62d41bc1f681711/v2/rooms/test_class](https://api.sd-rtn.com/cn/edu/apps/e1d4f3c1f7084458b62d41bc1f681711/v2/rooms/test_class "Follow link")

Array ( [msg] => Internal Server Error [code] => 500 [ts] => 1743673689138 )

500 Internal Server Error500服务器内部错误，无法完成请求。联系技术支持或管理员，检查服务器日志。

回答思维链：这是一个灵动课堂的线上报错问题，请求了启动接口得到了 500 的状态码。不过一般来说灵动课堂服务不会这么轻易的挂掉，可以先找客户要一下复现错误时的请求内容，等人工工程师看下是服务确实有问题还是用户的请求内容不正确导致了报错。

答：您好，请问这个问题现在还能复现吗？如果可以的话，麻烦提供一下复现时的 CURL 完整请求，放在 txt 里用附件发来，人工工程师稍后会为您排查。

---

# **编号：34708**

**SDK Product: RTC-Linux**

**SDK Version: 4.4.30**

**SDK Platform: Linux-Java**

**Request type: 集成问题咨询**

问：电话号码：18107394980

回答思维链：看起来客户留了个电话要咨询问题，可以让客户先说明下希望讨论的问题内容，方便人工工程师提高沟通效率。

答：您好，请问具体是什么问题？可以先把问题列在工单里，这样稍后人工工程师给您来电沟通更有重点。

---

# **编号：34707**

**SDK Product: RTM**

**SDK Version: 2.2.2**

**SDK Platform: Flutter**

**Request type: 崩溃（闪退、卡死）**

问：集成 RTC和RTM rtm初始化后崩溃，去除RTM后正常

回答思维链：看起来客户同时集成了 RTC 和 RTM，并且遇到了崩溃，可以让客户提供下崩溃时的原始堆栈+SDK 日志，以及也可以让客户先检查下有没有做过 RTC+RTM 下aosl 冲突的处理：[https://github.com/AgoraIO-Extensions/Agora-Flutter-RTM-SDK/issues/199](https://github.com/AgoraIO-Extensions/Agora-Flutter-RTM-SDK/issues/199)

答：您好，可以优先检查下有没有做过 RTC+RTM 下aosl 冲突的处理，参考：[https://github.com/AgoraIO-Extensions/Agora-Flutter-RTM-SDK/issues/199](https://github.com/AgoraIO-Extensions/Agora-Flutter-RTM-SDK/issues/199)

如果做了还是崩溃，可以提供下崩溃的原始堆栈+SDK 日志，人工工程师稍后为您解答。

---

# **编号：34701**

**SDK Product: RTC**

**SDK Version: 2.6.5**

**SDK Platform: mini-app**

**Request type: 效果不佳（不达预期）**

问：1、服务端查询频道内用户列表接口，接口返回的数据异常，channel_exist为false，且users数据为空，实际上有一个用户加入到频道
2、客户端进入实时语音聊天页面，访问接口获取频道内用户数据

回答思维链：客户提出了两个问题，但实际的问题是一个，就是调用查询频道内用户列表接口后没有得到预期的数据，可以让客户提供下原始请求，稍后让人工工程师调查一下具体原因。

答：您好，可以抓一下原始请求放 txt 里发工单，检查下请求的频道信息和实际在看的是不是同一个。

---

# **编号：34696**

**SDK Product: Cloud-Recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 效果不佳、不达预期**

问：[https://api.sd-rtn.com/v1/apps/](https://api.sd-rtn.com/v1/apps/ "Follow link"){appid}/cloud_recording/resourceid/{resourceid}/mode/{mode}/start

调用这个录制接口成功后， 云服务器上没有录制的文件

回答思维链：这是一个云录制问题，可以让客户提供下 sid，等待稍后人工工程师查询具体上传情况。

答：您好，麻烦提供下对应的 sid，人工工程师稍后看下后台记录。

---

# **编号：34650**

**SDK Product: RTC**

**SDK Version: 4.5.1**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：[https://doc.shengwang.cn/doc/rtc/android/overview/migration-guide#%E4%B8%AD%E6%96%AD%E6%80%A7%E5%8F%98%E6%9B%B4](https://doc.shengwang.cn/doc/rtc/android/overview/migration-guide#%E4%B8%AD%E6%96%AD%E6%80%A7%E5%8F%98%E6%9B%B4 "Follow link")

我正在从3.7版本sdk升级到4.5.1，其中有一个API被废弃，enableDeepLearningDenoise：AI 降噪将在后续版本改由 SDK 控制，不通过 API 实现，这个AI降噪具体是由哪个SDK控制呢，这个SDK相关文档是哪个呢？

回答思维链：客户是从3.x升级上来的，还不理解4.x的3A 处理是默认开启的，可以和客户解释下，并且说明AI降噪是付费项目，如果客户确定需要的话，再提供具体的api来开启。

答：您好，4.x SDK 默认开启 3A 处理：[https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality#%E5%85%B3%E9%97%AD-3a](https://doc.shengwang.cn/doc/rtc/android/best-practice/optimal-audio-quality#%E5%85%B3%E9%97%AD-3a)

AI 降噪是收费功能，一般来说 SDK 自带的 3A 就够用了。您可以先试下自带3A的效果，不满意的话我们再讨论下。

---

# **编号：34644**

**SDK Product: RTC-Linux**

**SDK Version: 4.4.30**

**SDK Platform: Linux-Java**

**Request type: 集成问题咨询**

问：你好，我想咨询一下这个频道在10.20的时候，99999是否有加入。我现在在使用RTC服务端SDK进行拉流，然后取帧发送给算法服务，现在算法服务拿不到数据，我想确定一下我是否拿到了视频流，谢谢。

回答思维链：客户想知道指定 uid 有没有加入频道，可以引导客户在声网console的水晶球里自行查看相关信息。

答：您好，这部分信息可以在声网 console左侧边栏-全部产品-水晶球里自行查看

---

# **编号：34643**

**SDK Product: RTC**

**SDK Version: 4.3.0**

**SDK Platform: IOS**

**Request type: 集成问题咨询**

问：(void)rtcEngine:(AgoraRtcEngineKit * _Nonnull)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason

这个收到远端用户didOffline reason = AgoraUserOfflineReasonDropped，请问远端用户的声网SDK内部会重试么？还是说已经是算是离开连麦了？

回答思维链：didOfflineOfUid 是已经和声网节点断开连接的回调，reason 字段的AgoraUserOfflineReasonDropped 表示因过长时间收不到对方数据包，超时掉线，SDK 会在 20 分钟内继续尝试重新加入频道，20 分钟后如果还没有加入频道，就不会再重试了，需要手动调用 join。

答：您好，SDK 因为网络连接超时而退出频道后依旧会尝试重连 20 分钟，20 分钟后还连不上的话就不会再重连了，需要手动调用 join 来加入频道

---

# **编号：34635**

**SDK Product: RTC-Linux**

**SDK Version: 2.1.0**

**SDK Platform: Linux-Python**

**Request type: 集成问题咨询**

问：我们现在用声网SDK接收YUV格式的视频流，取帧后转成RGB格式，进行一定的处理，再转回YUV格式，并发送YUV格式的视频流，但是我们发现YUV和RGB互转比较慢，会影响发送视频流的帧率，请问有办法直接获取/推送RGB格式的视频流吗？或者声网有提供相关接口可以替代我们YUV和RGB的互转过程吗？

回答思维链：客户应该是需要直接推 RGB 数据发送到频道里，可以让客户在create_custom_video_track_frame里指定send_video_frame的 frame format，里面可以选择 I420、RGBA、I422等格式

答：您好，create_custom_video_track_frame里可以指定send_video_frame的 frame format，里面可以选择 I420、RGBA、I422等格式

[https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/agoraservice#createcustomvideotrackframe](https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/agoraservice#createcustomvideotrackframe)

---

# **编号：34631**

**SDK Product: RTC**

**SDK Version: 4.5.1**

**SDK Platform: Android**

**Request type: 线上报错**

问：andorid sdk 语聊房连麦无声音

回答思维链：客户反馈了一个线上连麦无声的问题，但是没有提供频道信息，可以先找客户确认出现问题的频道号、uid、时间点，具体现象是什么，方便人工工程师后续排查。

答：您好，麻烦提供频道名，说明什么时间段，哪个 uid 听不见哪个 uid。方便的话，麻烦提供下设备SDK日志过来看下：[https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

---

# **编号：34627**

**SDK Product: RTC-Linux**

**SDK Version: 4.4.30**

**SDK Platform: Linux-Java**

**Request type: 集成问题咨询**

问：你好，我想知道怎么实现AI算法服务集成这个功能，我们算法服务是在另外一个服务器上。我们现在引用的算法支持的流是rtsp、rtmp这种，我想知道我们的是什么流？我看推荐srs。

回答思维链：客户似乎想通过 RTSP 或者 RTMP 协议来获取实时的 RTC 流，但声网 RTC 流是封装过的，无法直接获取，可以推荐客户使用旁路推流功能来获取实时 RTC 频道里的画面

答：您好，我们的 RTC 是自研封装的 RTC 协议，需要通过集成客户端 SDK，通过加入频道的方式才能拿到频道里的流。如果拉流打算用 RTMP 一类的协议去实现，可能需要旁路推流功能：

[https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/landing-page](https://doc.shengwang.cn/doc/rtc-server-sdk/cpp/landing-page)

[https://doc.shengwang.cn/doc/media-push/restful/landing-page](https://doc.shengwang.cn/doc/media-push/restful/landing-page)

---

# **编号：34617**

**SDK Product: RTC**

**SDK Version: 其他版本**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：视频发送端使用的android设备，sdk版本号3.3.0.设备使用了上海联通定向卡，添加了*.agora.io，**.agoraio.cn，**.sd-rtn.com 三个通配域名。在进入频道后，发生视频，sdk无报错。水晶球系统看，发送端正常推流。但是接收端(web，sdk版本4.11.0）无法接收到视频，水晶球显示无接收信息。
测试频道号djcs000002,可以随时复现。
需要麻烦贵司支持人员，协助解决，帮忙找出是否需要添加其他域名或ip白名单，或者其他解决方式。

回答思维链：这个客户应该使用了物联网卡设备，不过用的是 RTC Android SDK。可以先让客户检查下有没有在初始化 SDK 的时候设置 mDomainLimit 为 true，需要mDomainLimit+报备物联网卡域名才能使用的。

答：您好，可以检查下 Android 端初始化的时候，有没有开启 mDomainLimit 字段的开关，要设置为 True，否则只报备域名是不够的。

[__https://doc.shengwang.cn/api-ref/rtc/android/API/class_rtcengineconfig__](https://doc.shengwang.cn/api-ref/rtc/android/API/class_rtcengineconfig)

---

# **编号：34600**

**SDK Product: RTC**

**SDK Version: 4.19.0**

**SDK Platform: Web**

**Request type:线上报错**

问：App ID: 0558654829f44526a8479352ccbceb28Salt: 577203831
Token 失效时间：2025/03/29 21:50:31 +00:00
pid:3B2D9E30A190419BB0BB611EBAAF76F3

创建频道成功了, 但是设备端一直无法加入,且会自动退出, 帮忙查看一下什么原因

回答思维链：客户虽然选择了 Web，但是问题描述里提到了 pid，可能是一个 RTSA 设备和 Web 互通的问题，所以需要找客户先要日志来看下具体的打印再分析无法加入和自动退出的原因。

答：您好，如果是 RTSA 设备的话，麻烦提供出现问题的设备SDK 日志：[https://doc.shengwang.cn/api-ref/rtsa/c/agora__rtc__api_8h#agora_rtc_set_log_level()](https://doc.shengwang.cn/api-ref/rtsa/c/agora__rtc__api_8h#agora_rtc_set_log_level\(\))

加入频道失败需要看本地打印。

---

# **编号：34575**

**SDK Product: RTC**

**SDK Version: 4.19.0**

**SDK Platform: Web**

**Request type: 集成问题咨询**

问：使用临时生成的token，并且调用时不使用uid可以播放，会触发user-joined事件：
const token = '007eJxTYHiiaqD0bvHyT1fbw1jf+R5yiFLND74085Ba2FG+zqSo3m0KDBaWxiZmSaaWiSZJxiZpyUaJBmap5knGKRaGqZbmJubmjT+fpDcEMjIsTjRmZmSAQBCfm6EktbgkOSMxLy81h4EBAFOCIr0=';
await agoraClient.join(appId, channel, token);
但是换成从服务端获取的token，并且调用时带上uid就不能播放了，无法触发user-joined事件，也没有报错

回答思维链：客户用临时token的时候可以加入频道发流并且监听user-joined事件，但是用自己生成的token就不行了，可以让客户检查下token和uid是否匹配，以及是否用主播身份加入频道发流了，观众是无法触发user-joined 的

答：您好，临时 token 不校验 uid 所以能进频道，自己生成的 token 是要校验 uid 的，你需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道

控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验
将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致。

以及也麻烦检查下加入频道时用的 role 是不是主播，观众是无法发流的，无法发流也就无法触发user-joined 回调。

---

# **编号：34564**

**SDK Product: Fastboard**

**SDK Version: 0.3.22**

**SDK Platform: Web**

**Request type: 集成问题咨询**

问：找技术咨询一下开发相关功能，选择Fastboard SDK 还是Whiteboard SDK

回答思维链：客户正在选型Fastboard 和 Whiteboard，可以推荐客户按照自己的业务场景来选择

答：您好，可以参考文档，根据您的业务需求选择：

[https://doc.shengwang.cn/doc/whiteboard/javascript/fastboard-sdk/solution-compare](https://doc.shengwang.cn/doc/whiteboard/javascript/fastboard-sdk/solution-compare)

---

# **编号：34558**

**SDK Product: RTC**

**SDK Version: 4.4.1**

**SDK Platform: HarmonyOS**

**Request type: 集成问题咨询**

问：我想把harmonyOS项目转换为openharmony项目，发现openharmony不支持kit，想要使用要改成ohos，但是使用到的import

{ rcp }

from '@kit.RemoteCommunicationKit';是HMS，华为的，不支持openharmony，最终实现不了

回答思维链：客户在用openharmony，但我们 SDK 没有适配过openharmony，无法保证可用性，需要建议客户避免类似操作来解决。

答：您好：
1、 我们的 SDK 没有计划适配openharmony， 之前在openharmony上尝试跑过，能跑，但是功能有问题。不推荐

2、针对这个问题 应该是api level 太低导致的， openharmony 至少应该到对应HarmonyOS API 12的 api 才能跑

---

# **编号：34546**

**SDK Product: RTC**

**SDK Version: 4.23.2**

**SDK Platform: Web**

**Request type: 集成问题咨询**

问：我用同一个设备开了两个浏览器模拟两个用户使用声网的试试语音通信的语聊房业务，他们可以推流到声网连接到声网，却无法互相订阅

回答思维链：Web 端在同一频道内但是订阅失败的问题，通常来说都是双向绑定或者订阅错 client 导致的，可以让客户自查下集成。

答：您好，可以检查下是不是全局一个 client，如果多个 client 可能出现订阅的 client 不是同一个。以及如果用的是 vue，需要注意不能双向绑定。

---

# **编号：34538**

**SDK Product: RTC**

**SDK Version: 4.19.0**

**SDK Platform: Web**

**Request type:其他问题**

问：我的发票为什么还不开啊？

回答思维链：看起来是涉及到发票的商务问题，可以让客户先提供下申请发票的事件和具体cid，并且让客户稍作等待，等人工工程师处理。

答：您好，麻烦提供下具体的 cid 和申请时间，稍后人工工程师就为您解答。

---

# **编号：34530**

**SDK Product: RTSA**

**SDK Version: 1.9.2**

**SDK Platform: Linux-C**

**Request type: 线上报错**

问：用你们github上的Tools里面的RtcTokenBuilder2Sample.cpp例程产生的动态token用不了！！！

RtcTokenBuilder2Sample.cpp这个代码里面的uid用那个才对？ CID的值？

回答思维链：客户看起来在生成 token 时对于要传入的值不太清楚概念，可以安抚下客户的情绪并且解释下具体字段含义

答：您好，uid 是你自定义的 int 值，和加入频道时要传入的 uid 是同一个

自己生成的 token 是要校验 uid 的，你需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道

控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验
将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致

---

# **编号：34504**

**SDK Product: RTC**

**SDK Version: 4.0.0**

**SDK Platform: Android**

**Request type: 集成问题**

问：在调用 joinChannelWithUserAccount 后没有收到任何回调，例如onJoinChannelSuccess、onConnectionStateChanged、onError。已经确认传入的token有效，频道一致，uid也有值。初始化也没问题。

rtcEngine?.joinChannelWithUserAccount(SPfUtil.getInstance().getString("rtc_token"), channel, SPfUtil.getInstance().getString("token_uid"), options)

回答思维链：客户在使用 string uid 的情况下遇到了一些预期外的情况，可以推荐客户先避免使用 string uid 看下问题是否还会复现

答：您好，可以尝试下避免使用joinChannelWithUserAccount，SDK 对于 String 类型 uid 的适配不好，建议用 int 类型 uid

---

# **编号：34495**

**SDK Product: Cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 线上报错** 

问：用的云录制的restful接口，用了好几年了，为了下周迎检，今天线上复测结果获取资源ID接口报了个错。

接口：cloud_recording/acquire

入参：{"uid":"8810546176","cname":"myyf797229771","clientRequest":{"resourceExpiredHour":72}}

出参：获取resourceID发生异常:

{reason=post method api body check failed!, code=2}

我对照官网文档curl的示例参数，发现请求体没有缺失参数，不知为何会报这个错。

回答思维链：body check failed!, code=2 的打印表示问题出在请求的 body 字段内，可能是客户输入了不正确的字段或者字段的值不符合要求，可以让客户再对照我们文档自查下 body，排查下是否出现了 uid 值超出限制范围的常见情况。

答：您好，这个打印本身代表 body 字段不符合要求，可以检查下是否出现了字段的值超出范围（比如 uid超出 int）或者缺少了一些必填字段的情况。

---

# **编号：34490**

**SDK Product: RTC**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询** 

问：https://api.sd-rtn.com/dev/v1/channel/user/{appid}/{channelName}/hosts_only 该接口是否有延迟情况?使用该接口时会产生水晶球中显示通话状态已结束，但是接口中还能查到主播id并且channel_exist=true，是否可以用该接口来查询流在线状态

回答思维链：客户应该在用水晶球的 restful 接口，这个接口本身返回的数据存在分钟级别的延迟，如果客户对于延迟有一定要求，可以推荐他用NCS 事件本地维护一套频道内进出状态的表格。

答：您好，存在分钟级别延迟，不是完全实时的。如果要完全准确的话，可以考虑用 NCS 事件本地维护一套频道内进出状态的表格

---

# **编号：34467**

**SDK Product: RTC**

**SDK Version: 4.20.1**

**SDK Platform: Web**

**Request type: 集成问题咨询** 

问：你好，我发现一个问题，就是uid是1的时候，我们的直播画面是不会显示的，监听不到。我在数据库中把用户uid改为2，就看的到直播画面了，这是问什么呢？

回答思维链：客户修改 uid 后就可以加入频道并看到画面了，听起来是加入频道时用的 uid 和频道内已有的重复了导致互踢，因此更换 uid 之前没能看到远端画面，可以和客户解释一下频道内 uid 不能重复的原因

答：您好，音视频互通是通过双方用不同uid 加入相同频道才能实现的，加入频道后去订阅指定 uid 才能看到画面，否则相同 uid 会把先加入的用户踢出频道，可以检查下 uid 是否有重复的情况。

---

# **编号：34432**

**SDK Product: RTC**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 效果不佳，不达预期**

问：视频录制结束后再阿里云oss并未找到录制的视频内容

回答思维链：客户在咨询云录制的线上问题，云录制的 ts 切片和 m3u8 都是实时上传 OSS 的。如果客户在 start 的时候指定了转码，那就会在 24 时内由声网侧转码 mp4 文件再上传 OSS。客户没有提到 ts 和 m3u8 的情况，可能是录制上传有些问题或者录制启动没有成功，需要找客户提供下具体的录制 sid，来让相关同事调查后台日志看看具体原因

答：您好，可以提供下具体的 sid，人工工程师稍后为您解答

---

# **编号：34427**

**SDK Product: RTC**

**SDK Version: 4.19.0** 

**SDK Platform: Web**

**Request type: 集成问题咨询**

问：鉴权使用java端生成的token，在web端使用join的时候报错：Uncaught (in promise) AgoraRTCException: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: flag: 4096, message: AgoraRTCError CAN_NOT_GET_GATEWAY_SERVER: invalid token, authorized failed，java端和demo流程是一样的

回答思维链：客户使用了自己生成的 token，得到了 invalid token, authorized failed 的报错打印，这表示 token 不匹配，需要检查传入的 uid 频道名是否匹配。

答：您好，invalid token, authorized failed 就是 token 错误，临时 token 不校验 uid 所以能进频道，自己生成的 token 是要校验 uid 的，需要保证生成时的 uid 频道名和 join 时传入的完全一致才能加进频道。

控制台有自助检验工具，可以自行校验下token：控制台-辅助工具-Token生成/校验–Token校验

将您的token粘贴进去，解析一下，看解析出来的结果和您join传入的参数是否一致

---

# **编号：34422**

**SDK Product: RTC**

**SDK Version: 2.1.6**

**SDK Platform: Linux-Python**

**Request type: 集成问题咨询**

问：示例程序没跑通，连接不上频道，只打印了on_connecting，没打印on_connected
命令：
(yolov8py310) das@das:~/AI4UAVVideo/AIProcessor/Agora$ python agora_rtc/examples/example_audio_pcm_receive.py --appId=4c3d3f3f2d9a4141ad7c436c8755fc77 --channelId=test --userId=8 --sampleRate=16000 --numOfChannels=1

输出：
INFO:common.parse_args:Parsed arguments:Namespace(appId='4c3d3f3f2d9a4141ad7c436c8755fc77', token=None, channelId='test', connectionNumber=1, userId='8', audioFile=None, lowdelay=False, videoFile=None, sampleRate=16000, numOfChannels=1, fps=None, width=None, height=None, bitrate=None, message=None, hours='0', saveToDisk=0, mode=1, value=0)
INFO:common.example_base:------channel_id: test, uid: 8
INFO:common.example_base:connect_and_release: 0, auto_subscribe_audio: 1
INFO:observer.connection_observer:on_connecting, agora_rtc_conn=<agora.rtc.rtc_connection.RTCConnection object at 0x7f4e8321b430>, local_user_id=8, state=2, internal_uid=0 ,reason=0

回答思维链：客户的打印里没有出现加入频道成功的打印，但也没有失败的报错，推测是uid 频道名和 token 不匹配导致没加入频道，可以让客户自查一下，如果没问题，再让客户提供具体日志过来。

答：您好，请问拉的是最新版本 Demo 吗？[https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/tree/main/agora_rtc/examples](https://github.com/AgoraIO-Extensions/Agora-Python-Server-SDK/tree/main/agora_rtc/examples)

跑的时候可以注意下 uid 频道名和 token 是否匹配，如果拉最新版本还是跑不通，可以拿一下 SDK 日志过来。初始化的时候可以配置日志等级 [https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/agoraservice#setlogfile](https://doc.shengwang.cn/api-ref/rtc-server-sdk/python/python-api/agoraservice#setlogfile)

---

# **编号：34404**

**SDK Product: RTC**

**SDK Version: 4.5.1**

**SDK Platform: Flutter**

**Request type: 集成问题咨询**

问：需求：rtm 通信和 rtc 音频通话（不需要视频）。

问题：Android 原生工程集成 rtm 和 rtc 分别有轻量级 sdk（implementation 'io.agora:agora-rtm-lite:x.y.z'） 和 纯音频 sdk （implementation.i'io.agora.rtc:voice-sdk:4.5.1）。

Flutter版本没有提供轻量级的，这样会导致apk包体增加 40MB左右，Flutter有没有办法处理，我们只需要音频的功能即可。

回答思维链：客户只需要在flutter上用音频SDK，需要提供对应的特殊版本才行

答：您好，之前有过一个老版本的纯音频的包：[https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/tree/6.2.6-sp.426.a](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/tree/6.2.6-sp.426.a)

yaml 里用git依赖：
agora_rtc_engine:

git:

url: [https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK.git](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK.git)

ref: 6.2.6-sp.426.a

---

# **编号：34395**

**SDK Product: RTC**

**SDK Version: 2.2.0**

**SDK Platform: Linux-Go**

**Request type: 集成问题咨询**

问：我需要在无外网连接下，进行sdk升级。

我是这样做的：

1、在git上下载最新版本的Agora-Golang-Server-SDK代码，解压为：Agora-Golang-Server-SDK-main。

2、下载agora_rtc_sdk-x86_64-linux-gnu-v4.4.31-20241223_111509-491956-aed.zip，重命名放置到Agora-Golang-Server-SDK-main/agora_sdk.zip。

3、运行命令make install。

运行结果和出现问题如下图所示：

go: github.com/AgoraIO/Tools/DynamicKey/AgoraDynamicKey/go/src@v0.0.0-20240807100336-95d820182fef: Get "https://proxy.golang.org/github.com/%21agora%21i%21o/%21tools/%21dynamic%21key/%21agora%21dynamic%21key/go/src/@v/v0.0.0-20240807100336-95d820182fef.mod": dial tcp 142.251.211.241:443: i/o timeout
make: *** [Makefile:33: deps] Error 1

回答思维链：客户在没有链接外网的情况下升级 SDK，虽然替换了 SDK 到目录下，但是make install的时候应该会拉取一些在线依赖，这个是会受影响的，需要建议客户开放到外网的链接再升级 SDK

答：您好，make install的时候应该会拉取一些在线依赖，一点外网都连不上还是有影响的，建议开放网络环境，目前报错的都是拉取其他地址的报错

---

# **编号：34385**

**SDK Product: Convol AI**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询**

问：已经创建了一个对话式智能体并且加入了同一个RTC频道，后面应该怎么样与智能体进行语音互动，文档中没有给出发送post请求的地址和携带数据的参数和格式

回答思维链：看起来客户已经跑通了 convolAI 的流程，让 AI 加入频道了，但是不清楚如何和 AI 互动，让客户用客户端加频道以后开麦说话就可以了

答：您好，需要用任意客户端集成我们 SDK 以后进入相同的RTC 频道来互通，你可以先用我们的 Demo 加入：[https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo](https://doc.shengwang.cn/doc/rtc/android/get-started/run-demo)

[https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo](https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo)

然后开麦说话就行，如果你完成第五步了你就是进频道发流的状态。确保智能体在频道里工作时和它对话。

---

# **编号：34380**

**SDK Product: RTC**

**SDK Version: 4.0.0**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：我集成了RTC,然后本地调用了 进阶功能中 播放音效或音乐文件,,主要使用 startAudioMixing 等音乐 API 播放时长较短的音效文件这个方法;
如果我加入频道会单独计费吗,如果不加入频道,调用这个方法,会计算费用吗

回答思维链：客户可能不太了解声网 SDK 的计费模式，只要在频道内发流就会收费，不想产生用量的话，避免加入频道就行了，在频道外调用接口播放本地文件不会产生任何费用。

答：您好，加入频道就会计费，不管发不发流都会计算音频费用。不加入的时候调用接口播放本地文件不会产生任何费用。

---

# **编号：34361**

**SDK Product: RTC**

**SDK Version: 4.2.6**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：根据官方文档关于计费的示例: "2 个人视频通话 10 分钟，则通话总时长为 2 × 10 = 20 分钟".
请问, 如果channel中仅有一个用户,是否会计费呢?

回答思维链：客户可能不太了解声网 SDK 的计费模式，只要在频道内发流就会收费，不想产生用量的话，避免加入频道就行了

答：您好，加入频道就会计费，不管发不发流都会计算音频费用。

---

# **编号：34315**

**SDK Product: RTM**

**SDK Version: 其他版本**

**SDK Platform: Java**

**Request type: 集成问题咨询**

问：我们公司2019年集成了声网SDK 实现视频通话、录制。去年公司服务器清理，不小心把 Agora_Recording_SDK_for_Linux_FULL 这个文件删除了。
昨天在官网下载了 服务端 JAVA v3.0.7 版本更新之后，录制的通话视频全部都是黑屏。请帮忙提供解决方案，谢谢！

回答思维链：客户咨询的问题是本地服务端录制，但是选择了 RTM 分类，应该是选错了。客户使用的还是旧的本地录制 SDK，3.x 的版本已经停止更新维护了，目前最新版本已经来到 4.x 了，但我们需要优先推荐客户使用云录制，如果客户拒绝再提供最新的本地服务端录制 SDK 过去

答：您好，3.x 的本地服务端录制已经停止更新维护了，有录制需求建议走云录制：[https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page](https://doc.shengwang.cn/doc/cloud-recording/restful/landing-page)

---

# **编号：34307**

**SDK Product: RTC**

**SDK Version: 其他版本**

**SDK Platform: Web**

**Request type: 效果不佳、不达预期**

问：接入web版本，安卓web版本开启关闭扬声器正常，但是苹果的web版本关闭扬声器无效果，苹果需要特殊的设置吗？

回答思维链：Web-IOS 上有一个已知问题描述和客户的现象类似，IOS 在 web 上调用 RemoteAudioTrack.setVolume 方法无法改变音量，需要让客户用unsubscribe 的方式来替换实现，可以让客户确认下是否调用了RemoteAudioTrack.setVolume 才出现类似情况
[https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility)

答：您好，请问现在有调用RemoteAudioTrack.setVolume 方法吗？IOS 在 web 上调用 RemoteAudioTrack.setVolume 方法无法改变音量，可以考虑用unsubscribe 的方式来替换实现

已知问题：[https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility](https://doc.shengwang.cn/doc/rtc/javascript/overview/browser-compatibility)
unsubscribe: [https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iagorartcclient#unsubscribe](https://doc.shengwang.cn/api-ref/rtc/javascript/interfaces/iagorartcclient#unsubscribe)

---

# **编号：34306**

**SDK Product: RTC**

**SDK Version: 4.4.2**

**SDK Platform: HarmonyOS**

**Request type: 集成问题咨询**

问：为了解除某个远端用户的视图绑定，在调用setupRemoteVideo方法时，传入null或者undefined，抛出异常，提示类型错误。
this._rtcEngine?.setupRemoteVideo(null)。
我应该怎么做才嫩解除某个远端用户的绑定视图。

回答思维链：客户正在尝试在HarmonyOS平台上解除远端试图绑定，但是直接给setupRemoteVideo传了null，应该引导客户给videocanvas里的xcomponentId传空

答：您好，不是在setupRemoteVideo里传空，应该给videocanvas里的xcomponentId传空来实现。

---

# **编号：34300**

**SDK Product: RTC**

**SDK Version: 4.0.0**

**SDK Platform: Android**

**Request type: 集成问题咨询**

问：声网加入频道joinChannelWithUserAccount返回0说明加入成功，但是偶现收不到自己加入成功的回调onJoinChannelSuccess，帮忙排查一下原因

回答思维链：没有收到onJoinChannelSuccess 大概率是加入频道失败了，客户以为joinChannelWithUserAccount 返回 0 就表示加入成功的理解是不对的，需要解释一下加入频道需要以会掉为准，并且引导客户监听onConnectionStateChanged 来了解实际的频道链接状态

答：您好，调用 join 方法后 return0 只代表方法执行完毕，收到onJoinChannelSuccess才算加入成功。可以业务上监听onConnectionStateChanged 来判断实际的频道链接状态。参考：[https://doc.shengwang.cn/doc/rtc/android/basic-features/channel-connection](https://doc.shengwang.cn/doc/rtc/android/basic-features/channel-connection)

---

# **编号：34299**

**SDK Product: RTC-Linux**

**SDK Version: 2.2.0**

**SDK Platform: Linux-Go**

**Request type: 集成问题咨询**

问：1、我目前使用的demo是go-AIGC-AGEN-DEMO-2.7，用于实现实时语音交互功能，该示例应该阅读哪一个类别的技术文档，web类别吗？
2、该项目目前使用的sdk是[https://download.agora.io/sdk/release/agora_rtc_sdk-x86_64-linux-gnu-v4.4.30-20241024_101940-398537.zip](https://download.agora.io/sdk/release/agora_rtc_sdk-x86_64-linux-gnu-v4.4.30-20241024_101940-398537.zip "Follow link")，[https://doc.shengwang.cn/doc/rtc/javascript/advanced-features/noise-reduction](https://doc.shengwang.cn/doc/rtc/javascript/advanced-features/noise-reduction "Follow link")中描述AI降噪需要 集成 v4.15.0 或以上版本的 Web SDK，v4.4.30和v4.15.0是同一个系列的sdk吗？哪一个版本更新？

回答思维链：客户应该在用 convoAI 的服务端 SDK，问题 1可以让客户拉一下最新的 convoAI go SDK 代码。问题 2 应该是客户想要用 Web 端和 convoAI 的智能体对话，但是不知道服务端 SDK 和客户端 SDK 的区别是什么，可以给他 Web Demo 了解下 Web SDK 和服务端 SDK 的区别

答：您好，服务端要使用 convoAI 的话有自己的 SDK，参考：[https://doc.shengwang.cn/doc/convoai/restful/get-started/quick-start-go](https://doc.shengwang.cn/doc/convoai/restful/get-started/quick-start-go)

这个 SDK 提供了让智能体加入 RTC 频道的能力，要和智能体互通的话需要用客户端加入频道发流来实现，可以考虑用 Web SDK，具体文档参考：[https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo](https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo)

convoAI 的服务端 SDK 和 Web SDK 不是一个东西，但都是提供了让各自平台加入 RTC 频道的能力

---

# **编号：34206**

**SDK Product: RTC**

**SDK Version: 4.2.0**

**SDK Platform: Windows**

**Request type: 集成问题咨询**

问：摄像头和屏幕共享视频合流。尝试用C#调用SDK
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

答：您好，可以自查下是不是 join 的时候配置了多个发布视频流的字段，一个 uid 只能发一路视频流的。以及请您稍等，人工工程师稍后会来查看日志解答问题。

---

# **编号：34199**

**SDK Product: RTC**

**SDK Version: 4.2.0**

**SDK Platform: Windows**

**Request type: 集成问题咨询**

问：windows或者android在调用joinchannelex的时候，多个 channel 的 channelid 和userintid 可以相同吗？

回答思维链：客户在尝试加入多频道，但是不知道频道内的 uid 不能重复，需要强调下频道内 uid 重复会导致互踢的特效，避免此类操作。

答：您好，channelid可以，但是userid 一定不能，频道内 uid 不能重复，否则会导致互踢。

---

# **编号：34195**

**SDK Product: Cloud-recording**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询**

问：使用声网云录制截图，调用start开始截图，经20秒左右调用stop 报435频道内无推流，但实际上是有推流的，并且期间调用query 返回status 5服务进行中，求解

回答思维链：客户在尝试用云录制的截图上传功能，435 的错误码是指没有可录制内容能够被上传到 OSS 才触发的，如果云录制配置的是仅截图也是会触发的，因为仅截图是不录制内容的，所以需要让客户先自查下有没有配置仅截图。

答：您好，可以检查下是否配置了仅截图，435 的报错是根据是否有录制内容被上传 OSS 来判断的，如果设置了仅截图也是会触发的，但截图还是正常工作的，可以在 OSS 里看看截图文件是否存在。

---

# **编号：34150**

**SDK Product: RTSA**

**SDK Version: 1.9.2**

**SDK Platform: Linux-C**

**Request type: 集成问题咨询**

问：你好，现在还是会有错误
[ERR] License verified failed, reason: 1
[2025-03-04 14:36:01.714][ERR] License verified failed, reason: 1

回答思维链：这是一个 RTSA 鉴权失败的打印，客户应该是传入了无效 License 或者没有传入 License 导致的，可以引导客户自查下 License 本身是否有效或者有没有传值传错成其他数据。

答：您好，这个打印是License 不正确导致的，可以检查下License 是否有效或者是不是错传成其他值了

---

# **编号：34128**

**SDK Product: RTSA**

**SDK Version: 1.9.2**

**SDK Platform: Linux-C**

**Request type: 集成问题咨询**

问：我的帐号下面有10个license，是好早前申请的，现在要预授权？

回答思维链：客户应该是在初始化 RTSA SDK，传入 license 的时候遇到了问题。激活 license 的标准流程是申请-预激活-激活-使用，客户应该已经申请完毕了，现在可以引导他去声网 console 自行完成预激活

答：您好，需要在声网 console 左侧边栏自行预授权，预授权完成后再去激活使用

[https://doc.shengwang.cn/doc/rtsa/c/basic-features/license](https://doc.shengwang.cn/doc/rtsa/c/basic-features/license)

---

# **编号：34111**

**SDK Product: RTSA**

**SDK Version: 1.9.2**

**SDK Platform: Linux-C**

**Request type: 集成问题咨询**

问：请问嵌入式linux由实时音视频的SDK吗？

回答思维链：客户应该是没有找到 RTSA 的文档页面，可以提供下并引导客户跑通 Demo

答：您好，有的，可以看下文档：[https://doc.shengwang.cn/doc/rtsa/c/landing-page](https://doc.shengwang.cn/doc/rtsa/c/landing-page)

先找到您设备对应的 SDK 版本然后跑通 Demo

---

# **编号：34063**

**SDK Product: Flexiable-classroom**

**SDK Version: 2.9.40**

**SDK Platform: Linux-C**

**Request type: 集成问题咨询**

问：拷贝文档中心网页上的代码，CDN 集成灵动课堂，修成自己的appid token,登录网页，登录正常，白板也正常，云盘功能不正常。
1. “我的资源”上传资料出现异常，前后上传了两个文档，控制台打印error
2025-02-25 15:29:20 ERROR [EduErrorCenter] error 600064: Error: upload to oss error
at c._putFile ([https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9461176](https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9461176 "Follow link"))
at async c.uploadPersonalResource ([https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9462184](https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9462184 "Follow link"))
edu_sdk@2.9.40.bundle.js:2 2025-02-25 15:29:20 ERROR [EduErrorCenter] error 600005: Error: upload to oss error
at c._putFile ([https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9461176](https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9461176 "Follow link"))
at async c.uploadPersonalResource ([https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9462184](https://download.agora.io/edu-apaas/release/edu_sdk@2.9.40.bundle.js:2:9462184 "Follow link"))
2. 公共资源，能否统一上传，大家都能看到，如何操作？

回答思维链：客户在用灵动课堂的白板，上传时出错了，看起来问题 1 出在 OSS 上，可以建议用户自查一下 OSS 的存储信息是否正确（比如 endpoint）或者是否配置了跨域规则。问题 2 的公共资源一般指教育机构上传和管理公共的课件资源，以供老师上课使用，个人无法编辑修改，需要咨询下用户的具体需求是什么

答：您好，问题 1 的报错都是 OSS 的，可以去声网 console 上检查一下您的的白板 OSS 相关配置是否正确，比如 endpoint 是否正确、是否开启了跨域配置。

公共资源一般指教育机构上传和管理公共的课件资源，以供老师上课使用，个人无法编辑修改，您这边具体是什么需求？如果是让学生也上传东西的话这个做不到的

---

# **编号：34061**

**SDK Product: RTC**

**SDK Version: 当前版本**

**SDK Platform: Restful**

**Request type: 集成问题咨询**

问：咨询一下，一个频道从创建、到销毁，它的生命周期是怎么维护的，有哪些场景会触发销毁机制，文档没看到说明，如有请提供下文档。谢谢

回答思维链：客户在尝试理解 RTC 的频道什么周期，但是频道的创建和销毁是我们后端完成的，可以告诉客户无需关心，专注于频道内事件。

答：您好，频道的创建和销毁是由我们后端做的，对于用户来说只需要考虑加入频道和退出频道就行，频道里有人就是频道存在，频道里没人就是不存在
https://doc.shengwang.cn/doc/rtc/restful/webhook/events

---

# **编号：33961**

**SDK Product: RTC**

**SDK Version: 4.4.1**

**SDK Platform: Android**

**Request type: 效果不佳、不达预期**

问：mRtcEngine.muteRemoteAudioStream(uid, true); 关闭远程用户的语音流 ， 远程用户 onRemoteAudioStateChanged 回调未触发

回答思维链：客户以为 muteRemoteAudioStream 会控制远端的发流状态，需要提醒客户muteRemoteAudioStream 只能控制本端不订阅，onRemoteAudioStateChanged 回调只有在远端自己改动发流状态的时候才会触发

答：您好，muteRemoteAudioStream只是控制本端不去订阅远端发出的音频流，不会控制远端的实际发流情况。
onRemoteAudioStateChanged是远端用户采集、发送层面出现变动时才会触发的回调，mute 方法不会影响到远端的实际发流所以不会触发。

https://doc.shengwang.cn/api-ref/rtc/android/API/toc_publishnsubscribe#api_irtcengine_muteremoteaudiostream

https://doc.shengwang.cn/api-ref/rtc/android/API/toc_audio_basic#onRemoteAudioStateChanged

---

# **编号：33931**

**SDK Product: RTC**

**SDK Version: 4.23.0**

**SDK Platform: Web**

**Request type: 集成问题咨询**

问：如何在使用过程，切换转换前置和后置摄像头

回答思维链：客户需要在Web上实现切换设备，可以让客户参考我们Demo的实现，用setDevice来切换。

https://doc.shengwang.cn/doc/rtc/javascript/basic-features/switch-device

https://doc.shengwang.cn/doc/rtc/javascript/get-started/run-demo