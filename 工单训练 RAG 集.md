# 工单训练 RAG 集

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

答：您好，加入频道频道失败通常是和token有关，比如token无效、过期等；您这边可以登录console—&gt;控制台—&gt;辅助工具—&gt;token生成/校验，先校验下token。

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

{"cname":"aac","uid":"9527","resourceId":"XVrmd0HbPT86imnolU-yyUv2avxihKtozw7koLR197VW3smqtrD5ncJGv4QKvGWEuuUZ6E1D6Vd2zlQ31xAj9JCFWxVS0epGcKOsrovUekMUxn_eRqCbi2vhXuHMup0shyH28yij3H1Fi5Et0LmEoqNDtupLDzIEnB_rIVOTk1opZCLsgH9PDe1duLEpkSlZZk_xHyyUgnszX58_dXaZkGYieAxJGU6G8pwcZQsjfkzkqyoLU2Y5jKWkVLaLqbiT"}

【请求开始录制】
url=[https://api.sd-rtn.com/v1/apps/f09535b02ebc4b7d90e627ef1bcef7b2/cloud_recording/resourceid/XVrmd0HbPT86imnolU-yyUv2avxihKtozw7koLR197VW3smqtrD5ncJGv4QKvGWEuuUZ6E1D6Vd2zlQ31xAj9JCFWxVS0epGcKOsrovUekMUxn_eRqCbi2vhXuHMup0shyH28yij3H1Fi5Et0LmEoqNDtupLDzIEnB_rIVOTk1opZCLsgH9PDe1duLEpkSlZZk_xHyyUgnszX58_dXaZkGYieAxJGU6G8pwcZQsjfkzkqyoLU2Y5jKWkVLaLqbiT/mode/individual/start](https://api.sd-rtn.com/v1/apps/f09535b02ebc4b7d90e627ef1bcef7b2/cloud_recording/resourceid/XVrmd0HbPT86imnolU-yyUv2avxihKtozw7koLR197VW3smqtrD5ncJGv4QKvGWEuuUZ6E1D6Vd2zlQ31xAj9JCFWxVS0epGcKOsrovUekMUxn_eRqCbi2vhXuHMup0shyH28yij3H1Fi5Et0LmEoqNDtupLDzIEnB_rIVOTk1opZCLsgH9PDe1duLEpkSlZZk_xHyyUgnszX58_dXaZkGYieAxJGU6G8pwcZQsjfkzkqyoLU2Y5jKWkVLaLqbiT/mode/individual/start "Follow link")

headers=[Content-Type:application/json; charset=utf-8, Accept:application/json, Authorization:Basic MzQ0NTg2ZTY2MjUxNDNiZTg1MmZhMTYzNWE4ODI3ZDA6ODI1ZTRiZmY4Y2VjNDlkZWE5OTYyZmY3MmM3YzcxYjk=]

body
{"clientRequest":{"recordingConfig":

{"channelType":0,"maxIdleTime":1800,"streamMode":"original","streamTypes":0,"subscribeUidGroup":1,"videoStreamType":0}

,"recordingFileConfig":

{"avFileType":["hls"]}

,"storageConfig":

{"accessKey”:"xxxx","bucket”:"xxxx","fileNamePrefix":["8k","6"],"region":8,"secretKey”:"xxxx+LNv2","vendor":1}

,"token":""},"cname":"aac","uid":"9527"}

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

# **编号：35780**

**SDK Product: RTC**

**SDK Version: 4.2.2**

**SDK Platform: Android**

**Request type: 线上报错**

问：建立连接无法进行通话

回答思维链：看客户问题描述是无法通话，可能是线上无法加入频道，也可能是只有一方加入了频道，现在缺少的信息太多，无法直接分析出问题所在，可以先收集下客户的网络情况和出现问题的设备日志，推进下问题排查进展

答：您好，麻烦按以下模版整理问题，以便我们能第一时间展开问题调查；
1. 声网频道号(cname)：
2. 出问题的时间点：
3. 问题现象： (例)
   (1) uid=123 听不到/看不到 uid=456，大约持续20分钟
   (2) uid=123 听/看 uid=456卡顿
4. 现象录屏:如果有的话尽量提供
5. sdklog：如果有的话尽量提供 [https://doc.shengwang.cn/faq/integration-issues/set-log-file](https://doc.shengwang.cn/faq/integration-issues/set-log-file)

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