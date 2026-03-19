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

私参说明：SDK默认texture采集，但小部分机型存在兼容性问题，尤其是学习机，开发板等低端设备，会遇到无采集，花屏，绿屏等问题需要指定yuv格式采集规避；规避采集异常问题时优先使用camera1尝试，若不能解决问题，再尝试yuv采集。

# che.video.android_camera_lowPower
模块：采集
平台：Android
类型：Boolean
写法：`setParameters("{\"che.video.android_camera_lowPower\": true}")`
默认值：false
值说明:
- `true`:  低功耗采集
- `false`: 降噪模式采集

私参说明：SDK默认降噪模式采集，打开了自动人脸对焦，自动白平衡，templaveType为录制模式，硬件降噪开启。线上出现过机型后置摄像头对焦呼吸现象，打开低功耗采集，关闭高级采集参数后规避了问题。

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

私参说明：SDK默认采集非镜像画面，仅在本地预览对前置摄像头画面进行渲染镜像。为满足本地和接收端画面镜像一致，或美颜算法依赖镜像输入，通常需要在getMirrorApplied根据摄像头方向做处理，可考虑用私参配置镜像，更加灵活，且能避免额外的数据处理，节约性能消耗。

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

# rtc.video.android.custom_displayRotation
模块：采集
平台：Android
类型：Number
写法：`setParameters("{\"rtc.video.android.custom_displayRotation\": 0}")`
默认值：0
值说明:
- `0`：竖直方向

私参说明：SDK默认自动获取设备的系统角度，但可能出现获取角度错误的问题，导致摄像头画面旋转异常，若APP固定方向的，比如固定竖直模式，可通过配置私有参数强制设定方向，确保画面方向正确。该参数从4.6.2/4.5.2.4版本开始支持。

# rtc.camera_rotation
模块：采集
平台：Native
类型：Number
写法：`setParameters("{\"rtc.camera_rotation\": 180}")`
默认值：auto

私参说明：SDK默认自动获取设备的系统角度，但可能出现获取角度错误的问题，导致摄像头画面旋转异常，可通过rtc.camera_rotation旋转画面，旋转效果参考内部confluence[私有参数rtc.camera_rotation](https://confluence.agoralab.co/pages/viewpage.action?pageId=886671562)。

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

私参说明：SDK自4.3版本开始为了在保证画质的同时节约视频码率，默认对180P至720P的分辨率启用PVC。lite/mini_video包裁剪掉了PVC功能。追求画质的场景建议关闭PVC，同时PVC依赖I420链路，关闭后能节约性能消耗。

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

# che.video.lowest_dev_score_4_beauty
模块：前处理-美颜
平台：Native
类型：Int
写法：`setParameters("{\"che.video.lowest_dev_score_4_beauty\": 1}")`
默认值：Android/Windows为65分，Mac/iOS为-1分
值说明：设置SDK基础美颜设备分数阈值

私参说明：SDK 默认策略限制设备性能评分低于阈值时禁用基础美颜功能。开发者可通过配置私有参数调整该阈值，从而在低端设备上强制启用美颜，但不保证可用性和效果。

# che.video.lowest_dev_score_4_seg
模块：前处理-虚拟背景
平台：Native
类型：Int
写法：`setParameters("{\"che.video.lowest_dev_score_4_seg\": 1}")`
默认值：Android为70分，Windows为65分，Mac/iOS为-1分
值说明：设置SDK虚拟背景分数阈值

私参说明：SDK 默认策略限制设备性能评分低于阈值时禁用虚拟背景功能。开发者可通过配置私有参数调整该阈值，从而在低端设备上强制启用虚拟背景，但不保证可用性和效果。

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

# che.video.has_intra_request
模块：编码
平台：Native
类型：Boolean
写法：`setParameters("{\"che.video.has_intra_request\": false}")`
默认值：true
值说明:
- `true`: 非周期I帧
- `false`: 周期I帧

私参说明：SDK默认300S一个长周期I帧，响应VOS/端上I帧请求。需要周期I帧的场景，可通过私参启用周期I，默认2S一个，可调用che.video.keyFrameInterval设置业务需求的I帧周期，不建议频率高于1S一个。

# che.video.keyFrameInterval
模块：编码
平台：Native
类型：Int
写法：`setParameters("{\"che.video.keyFrameInterval\": 2}")`
默认值：2
值说明：设置I帧周期

私参说明：启用周期I时，默认2S一个，可调用che.video.keyFrameInterval设置业务需求的I帧周期，不建议频率高于1S一个。

# che.video.videoCodecIndex
模块：编码
平台：Native
类型：Number
写法：`setParameters("{\"che.video.videoCodecIndex\": 1}")`
默认值：auto
值说明：
- `0`：VP8
- `1`： H264
- `2`： H265
- `11`： AV1
- `19`： JPEG

私参说明：可通过che.video.videoCodecIndex设置编码的类型。可通过counter121确认编码类型，需要注意的是counter的枚举值是VP8=1，H264=2，H265=3，AV1=12，JPEG=20。

# rtc.video.h264_hw_min_res_level
模块：编码
平台：Native
类型：Number
写法：`setParameters("{\"rtc.video.h264_hw_min_res_level\": 4}")`
默认值：-1
值说明：
- `-1`：宽或高大于256，H264硬编
- `4`： 360P 15帧及以上H264硬编
- `5`： 360P 24帧及以上H264硬编
- `6`： 540P 15帧及以上H264硬编

私参说明：通常同等分辨率码率时，软编画质高于硬编，若追求画质，接受牺牲一定的性能，可以通过rtc.video.h264_hw_min_res_level提高H264软硬编的分辨率阈值。
 
# che.video.vtenc_default_pixel_format
模块：编码
平台：Mac/IOS
类型：Number
写法：`setParameters("{\"che.video.vtenc_default_pixel_format\": 4}")`
默认值：0
值说明：
- `0`：NV12 fullRange
- `1`： NV12 videoRange
- `2`： YUV fullRange
- `3`： YUV videoRange
- `4`： BGRA

私参说明：设置Mac/IOS硬编默认的编码器格式。屏幕分享和自采集格式/裸数据处理格式为BGRA时，建议通过参数设置4，避免编码器重启，提高编码可用性。

# rtc.video.minbitrate_ratio
模块：编码
平台：Native
类型：String
写法：`setParameters("{\"rtc.video.minbitrate_ratio\": "0.4"}")`
默认值："0"
值说明：设置视频目标码率的最低值

私参说明：该参数类型为String。在特定弱网环境下，若 SDK 估测的目标码率过低，可通过此私有参数设置最低目标码率，其值为当前 Profile 码率的百分比。建议配置为 `"0.4"` 或 `"0.6"`

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


# engine.video.enable_hw_decoder
模块：解码
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
- 安卓端大分辨率场景常会遇到由于硬解延时高自动切换到软解，但软解性能不足的问题。建议大分辨率场景用私参关闭fallback或者显示指定硬解，以节约性能消耗。

# rtc.video.decoder_out_byte_frame
模块：解码
平台：Android
类型：Boolean
写法：`setParameters("{\"rtc.video.decoder_out_byte_frame\": true}")`
默认值：1080P及以下为true,1080P以上为false
值说明:
- `true`: 硬件解码输出格式为yuv
- `false`: 硬件解码输出格式为texture

私参说明：由于默认SDK默认打开超画，SDK硬件解码默认输出为YUV。大分辨率场景需要节约性能消耗时，建议设置解码输出格式为texture，同时关闭超分。

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

私参说明：432版本开始，当远端分辨率小于等于1080P时，默认对远端开启超级画质，lite/mini_video包裁剪掉了超分功能，可以通过counter241判断是否开了超分。

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

私参说明：432版本开始，当远端分辨率小于等于1080P时，默认对远端开启超级画质，lite/mini_video包裁剪掉了超分功能，可以通过counter241判断是否开了超分。

# che.video.exclude_highlight_border_for_magnifier
模块：屏幕分享
平台：Windows
类型：Boolean
写法：`setParameters("{\"che.video.exclude_highlight_border_for_magnifier\": true}")`
默认值：false
值说明:
- `true`: 开启功能
- `false`: 关闭功能

私参说明：Windows发送端屏幕分享开启勾边，接收端可以看见勾边，可以通过这个参数，在屏幕分享放大镜采集模式（屏蔽窗口）时，使勾边不被接收端看到，若没有屏蔽窗口的需求，可以传入一个不存在的窗口开启放大镜采集。

# che.video.screenCaptureMode
模块：屏幕分享
平台：Mac
类型：Number
写法：`setParameters("{\"che.video.screenCaptureMode\": 1}")`
默认值：0
值说明：
- `0`：非高清采集
- `1`： 高清采集

私参说明：苹果 Retina 屏幕采用逻辑分辨率与物理分辨率分离的机制，其中 1 个逻辑点对应 2×2 共 4 个物理像素。SDK 默认基于逻辑分辨率进行采集；若需实现高清屏幕分享，可通过启用私有参数切换至物理像素采集模式。

# che.video.h265_screen_enable
模块：屏幕分享
平台：Native
类型：Boolean
写法：`setParameters("{\"che.video.h265_screen_enable\": true}")`
默认值：auto
值说明:
- `true`: 屏幕分享可H265编码
- `false`: 屏幕分享不可H265编码

私参说明：SDK452版本起，
PC屏幕分享文档模式编码格式默认AV1，gaming模式 默认H265
移动端屏幕分享默认H265

若PC屏幕分享编码格式需要修改成H265，则配置che.video.h265_screen_enable true和che.video.videoCodecIndex 2

若PC屏幕分享编码格式需要修改成H264，则配置che.video.videoCodecIndex  1

# rtc.video.av1_screen_enable
模块：屏幕分享
平台：Native
类型：Boolean
写法：`setParameters("{\"rtc.video.av1_screen_enable\": true}")`
默认值：auto
值说明:
- `true`: 屏幕分享可av1编码
- `false`: 屏幕分享不可av1编码

私参说明：SDK452版本起，
PC屏幕分享文档模式编码格式默认AV1，gaming模式 默认H265，可以通过这个参数设为false，关闭PC端屏幕分享的AV1编码。












