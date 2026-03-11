# che.video.android_camera_select
模块：采集
平台：Android
类型：Number
写法：`setParameters("{\"che.video.android_camera_select\": 0}")`
默认值：auto
值说明:
- `0`: camera1 API采集
- `1`: camera2 API采集

私参说明：默认情况下，SDK优先选用camera2，但有时存在兼容性问题，比如黑屏，花屏，绿屏，卡顿等需要指定camera1规避；
使用camera1的条件：
- camera2黑名单的设备，比如一加
- camera2功能不支持或等级仅支持HARDWARE_LEVEL_LEGACY
- 私参指定

# rtc.enable_camera_capture_yuv
模块：采集
平台：Android
类型：Boolean
写法：`setParameters("{\"rtc.enable_camera_capture_yuv\": true}")`
默认值：false
值说明:
- `true`: yuv格式采集
- `false`: texture格式采集

私参说明：为节约性能，SDK默认texture采集，但有时会有兼容性问题，尤其是学习机，开发板等低端设备，会遇到无采集，花屏，绿屏等问题需要指定yuv格式采集规避；规避采集异常问题时优先使用camera1尝试，若不能解决问题，再尝试yuv采集。

# rtc.camera_capture_mirror_mode
模块：采集
平台：Androd/iOS
类型：Number
写法：`setParameters("{\"rtc.camera_capture_mirror_mode\": 0}")`
默认值：2
值说明:
- `0`：前置摄像头采集镜像，后置非镜像
- `1`：前置摄像头采集镜像，后置镜像
- `2`：前置摄像头采集非镜像，后置非镜像

私参说明：SDK默认采集非镜像画面，仅在本地预览对前置摄像头画面进行渲染镜像。为满足本地和接收端画面镜像一致，或美颜算法依赖镜像输入，通常需要在getMirrorApplied根据摄像头方向做处理，私参配置会更加灵活，且能避免额外的数据处理，节约性能消耗。

# rtc.camera_capture_format_type
模块：采集
平台：iOS
类型：Number
写法：`setParameters("{\"rtc.camera_capture_mirror_mode\": 1}")`
默认值：0
值说明:
- `0`：NV12格式采集
- `1`：BGRA格式采集

私参说明：SDK默认NV12格式采集，而美颜算法通常需要输入格式为BGRA，建议设置BGRA格式采集，避免额外的数据转换，节约性能消耗。

# rtc.video.ios_camera_switching_behavior_locked
模块：采集
平台：iOS
类型：Boolean
写法：`setParameters("{\"rtc.video.ios_camera_switching_behavior_locked\": true}")`
默认值：true
值说明:
- `true`: 关闭微距切换
- `false`: 打开微距切换

私参说明：iphone自13开始pro/promax机型支持微距拍摄（和超广角一个镜头），16开始下放到标准版机型。系统相机在录像预览时会切换微距和非微距，开始录像时不再切换。SDK老版本默认打开微距切换，whatnot反馈不想要这个效果，SDK自4527/462开始支持私参开关微距切换功能。

# rtc.video.enable_pvc
模块：前处理
平台：Native
类型：Boolean
写法：`setParameters("{\"rtc.video.enable_pvc\": false}")`
默认值：43版本后默认true
值说明:
- `true`: 打开PVC
- `false`: 关闭PVC

私参说明：SDK自4.3版本开始为了在保证画质的同时节约视频码率，默认对180P至720P的分辨率启用PVC。追求画质的场景建议关闭PVC，同时PVC依赖I420链路，关闭后能节约一定的性能。

# rtc.video.enable_regulator_scale
模块：前处理
平台：Native
类型：Boolean
写法：`setParameters("{\"rtc.video.enable_regulator_scale\": true}")`
默认值：false
值说明:
- `true`: 打开裸数据缩放功能
- `false`: 关闭裸数据缩放功能

私参说明：SDK自4.5.2版本开始，为了节约美颜的性能消耗，支持将onCaptureVideoFrame缩放至编码分辨率缩放，默认关闭（开启后本地预览画质受影响）。工作机制是开启后，若采集1080P，编码720P，onCaptureVideoFrame大小为720P。
注：缩放会损伤画质，尤其在缩放比例超过4倍时。根据实际场景决定是否启用功能，若追求画质，建议采集分辨率跟随编码分辨率。

# engine.video.enable_hw_encoder
模块：编码
平台：Native
类型：Boolean
写法：`setParameters("{\"engine.video.enable_hw_encoder\": true}")`
默认值：auto
值说明:
- `true`: 硬编
- `false`: 软编

私参说明：counter146可以看硬编还是软编，需要注意的是当编码输出帧率为0时，该counter值无意义。大多数情况下SDK优先走硬编，但有时有兼容性问题时，尤其是下行无法收流或者解码或者解码花屏时，可以尝试下上行设置软编。
常见的使用软编的情况：
- Android 编码分辨率width<256&&height<256

# rtc.video.low_stream_enable_hw_encoder
模块：编码
平台：Native
类型：Boolean
写法：`setParameters("{\"rtc.video.low_stream_enable_hw_encoder\": true}")`
默认值：440版本开始默认true
值说明:
- `true`: 小流硬编
- `false`: 小流软编

私参说明：为节约性能，440版本开始小流默认硬编，小部分安卓机型存在硬编两路流，帧率低的问题，需要把小流设成软编。

# che.video.enable_auto_fallback_sw_encoder
模块：编码
平台：Native
类型：Boolean
写法：`setParameters("{\"che.video.enable_auto_fallback_sw_encoder\": false}")`
默认值：true
值说明:
- `true`: 编码码率/QP异常时，硬编fallback软编
- `false`: 关闭fallback

私参说明：为避免码率异常波动（如低发、超发）及画质不稳定等问题，SDK 默认启用了从硬编码fallback软编的容错机制。建议非带宽计费客户在高分辨率场景下禁用该 fallback 策略，以节约性能消耗。


# rtc.video.enable_face_beauty
模块：前处理-美颜
平台：Android
类型：Boolean
写法：`setParameters("{\"rtc.video.enable_face_beauty\": true}")`
默认值：true
值说明:
- `true`: 美颜走yuv链路
- `false`: 美颜走texture链路

私参说明：建议需要跑ai模型（高级美颜），走texture链路，基础美颜走yuv或双buffer链路；值为true时基础美颜的磨皮只作用于人脸上，关掉的话会影响一点效果。

# engine.video.enable_hw_decoder
模块：编码
平台：Native
类型：Boolean
写法：`setParameters("{\"engine.video.enable_hw_decoder\": true}")`
默认值：auto
值说明:
- `true`: 硬解
- `false`: 软解

私参说明：counter316可以看硬解还是软解，需要注意的是当解码输出帧率为0时，该counter值无意义。大多数情况下SDK优先走硬解，但有时有兼容性问题时，可以尝试下设置软解。
各平台软硬解的行为：
- Windows：4.3版本及更早版本全走软解；4.4版本开始，前2路视频走硬解，第3路起走软解
- Android：4.3版本及更早版本全走软解，4.4版本开始走硬解
- iOS：硬解

# engine.video.hw_decoder_fallback_config
模块：解码
平台：Native
类型：enabled-Boolean，其余的为int
写法：`setParameters("{\"engine.video.hw_decoder_fallback_config\":{\"enabled\":false}}")`
默认值：true
值说明：
enabled：
- `true`: 开启分辨率低于阈值，解码延时高于阈值等情况下的硬解fallback软解
- `false`: 关闭硬解fallback软解，不影响可用性的fallback

width_thres：非安卓平台分辨率阈值，默认值256
height_thres：非安卓平台分辨率阈值，默认值256
resolution_thres：安卓平台分辨率阈值默认值`240*320=76800`
decode_time_delay_thres_broadcaster：主播角色解码延时阈值，默认2000
decode_time_delay_thres_audience：观众角色解码延时阈值，默认2000

私参说明：
- 440开始，SDK根据分辨率大小判断选择硬解还是软解，小分辨率用软解，大分辨率用硬解，安卓平台阈值为76800，其他平台阈值为65536。
- 安卓端大分辨率场景常会遇到由于硬解延时高自动切换到软解，但软解性能不足的问题。建议大分辨率场景用私参关闭fallback或者显示指定硬解，同时设置硬解输出格式为texture，关闭超分。

# rtc.video.decoder_out_byte_frame
模块：解码
平台：Android
类型：Boolean
写法：`setParameters("{\"rtc.video.decoder_out_byte_frame\": true}")`
默认值：1080P及以下为true,1080P以上为false
值说明:
- `true`: 硬件解码输出格式为yuv
- `false`: 硬件解码输出格式为texture

私参说明：由于默认SDK默认打开超画，硬件解码默认输出为YUV，当需要优化性能时，尤其是大分辨率场景，建议设置解码输出格式为texture，同时关闭超分

# rtc.video.enable_sr
模块：后处理
平台：Native
类型：enabled-Boolean，mode-Number
写法：`setParameters("{\"rtc.video.enable_sr\":{\"enabled\":true,\"mode\":2}}")`
默认值：432版本及之后默认true
值说明：
enabled：
- `true`: 开超分
- `false`: 关超分

mode:
- `2`：对多个远端开超分
- `1`：对远端最大窗口开超分

私参说明：432版本开始，当远端分辨率小于等于1080P时，默认对远端开启超级画质，lite/mini_video包裁剪掉了超分功能，可以通过counter241判断是否开了超分

# rtc.video.sr_type
模块：后处理
平台：Native
类型：Number
写法：`setParameters("{\"rtc.video.sr_type\": 20}")`
默认值：20
值说明:
- `20`: 超级画质
- `3`: 2倍超分
- `7`: 1.33倍超分

私参说明：432版本开始，当远端分辨率小于等于1080P时，默认对远端开启超级画质，lite/mini_video包裁剪掉了超分功能，可以通过counter241判断是否开了超分










