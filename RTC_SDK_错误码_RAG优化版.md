
# ERR_OK (0)
错误码: 0  
含义: 无错误发生  
分类: 正常状态  
出现场景: API调用成功时返回

---

# ERR_FAILED (1)  
错误码: 1  
含义: 一般性错误（未指定原因）  
分类: 通用错误  
出现场景: 当发生错误但无法确定具体原因时返回

---

# ERR_INVALID_ARGUMENT (2)
错误码: 2  
含义: 参数无效。例如，特定的频道名称包含非法字符  
分类: 参数错误  
出现场景: 传入的参数不符合要求时返回

---

# ERR_NOT_READY (3)
错误码: 3  
含义: SDK模块未准备就绪  
分类: 初始化错误  
出现场景: SDK未完全初始化时调用API  
解决方案:
- 检查音频设备
- 检查应用程序的完整性  
- 重新初始化RTC引擎

---

# ERR_NOT_SUPPORTED (4)
错误码: 4  
含义: SDK不支持此功能  
分类: 功能限制  
出现场景: 调用不支持的API时返回

---

# ERR_REFUSED (5)
错误码: 5  
含义: 请求被拒绝  
分类: 请求处理错误  
出现场景: 服务端拒绝处理请求时返回

---

# ERR_BUFFER_TOO_SMALL (6)
错误码: 6  
含义: 缓冲区大小不足以存储返回的数据  
分类: 内存错误  
出现场景: 提供的缓冲区空间不够时返回

---

# ERR_NOT_INITIALIZED (7)
错误码: 7  
含义: 在调用此方法之前SDK未初始化  
分类: 初始化错误  
出现场景: 在SDK初始化之前调用API时返回

---

# ERR_INVALID_STATE (8)
错误码: 8  
含义: 状态无效  
分类: 状态错误  
出现场景: 在不合适的状态下调用API时返回

---

# ERR_NO_PERMISSION (9)
错误码: 9  
含义: 无权限。仅供内部使用，不会通过任何方法或回调返回给应用程序  
分类: 权限错误  
出现场景: 内部权限检查失败时使用

---

# ERR_TIMEDOUT (10)
错误码: 10  
含义: API超时。某些API方法需要SDK返回执行结果，如果请求处理时间过长（超过10秒）就会发生此错误  
分类: 超时错误  
出现场景: API调用超时时返回

---

# ERR_CANCELED (11)
错误码: 11  
含义: 请求被取消。仅供内部使用，不会通过任何方法或回调返回给应用程序  
分类: 内部处理错误  
出现场景: 内部请求取消时使用

---

# ERR_TOO_OFTEN (12)
错误码: 12  
含义: 方法调用过于频繁。仅供内部使用，不会通过任何方法或回调返回给应用程序  
分类: 频率限制错误  
出现场景: 调用API频率过高时返回

---

# ERR_BIND_SOCKET (13)
错误码: 13  
含义: SDK无法绑定网络套接字。仅供内部使用，不会通过任何方法或回调返回给应用程序  
分类: 网络错误  
出现场景: 网络套接字绑定失败时使用

---

# ERR_NET_DOWN (14)
错误码: 14  
含义: 网络不可用。仅供内部使用，不会通过任何方法或回调返回给应用程序  
分类: 网络错误  
出现场景: 网络连接中断时使用

---

# ERR_JOIN_CHANNEL_REJECTED (17)
错误码: 17  
含义: 加入频道的请求被拒绝。通常在用户已经在频道中，仍然调用加入频道的方法时发生，例如joinChannel()  
分类: 频道操作错误  
出现场景: 重复加入频道时返回

---

# ERR_LEAVE_CHANNEL_REJECTED (18)
错误码: 18  
含义: 离开频道的请求被拒绝。通常在用户已经离开频道，仍然调用离开频道的方法时发生，例如leaveChannel()  
分类: 频道操作错误  
出现场景: 重复离开频道时返回

---

# ERR_ALREADY_IN_USE (19)
错误码: 19  
含义: 资源已被占用，无法重复使用  
分类: 资源冲突错误  
出现场景: 尝试使用已被占用的资源时返回

---

# ERR_ABORTED (20)
错误码: 20  
含义: SDK因请求过多而放弃处理。仅供内部使用，不会通过任何方法或回调返回给应用程序  
分类: 内部处理错误  
出现场景: 请求队列过载时使用

---

# ERR_INIT_NET_ENGINE (21)
错误码: 21  
含义: 在Windows上，特定的防火墙设置可能导致SDK初始化失败并崩溃  
分类: 网络初始化错误  
出现场景: Windows防火墙阻止SDK网络初始化时返回  
平台: Windows

---

# ERR_RESOURCE_LIMITED (22)
错误码: 22  
含义: 应用程序使用过多系统资源，SDK无法分配任何资源  
分类: 资源限制错误  
出现场景: 系统资源不足时返回

---

# ERR_INVALID_APP_ID (101)
错误码: 101  
含义: App ID无效，通常是因为App ID的数据格式不正确  
分类: 配置错误  
出现场景: 使用错误格式的App ID初始化SDK时返回  
解决方案:
- 检查App ID的数据格式
- 确保使用正确的App ID初始化Agora服务

---

# ERR_INVALID_CHANNEL_NAME (102)
错误码: 102  
含义: 指定的频道名称无效。请尝试使用有效的频道名称重新加入频道  
分类: 参数错误  
出现场景: 使用无效频道名称加入频道时返回

---

# ERR_NO_SERVER_RESOURCES (103)
错误码: 103  
含义: 在指定区域获取服务器资源失败。请在调用initialize时尝试指定另一个区域  
分类: 服务器资源错误  
出现场景: 指定区域服务器资源不足时返回

---

# ERR_TOKEN_EXPIRED (109)
错误码: 109  
含义: Token已过期  
分类: 认证错误  
出现场景: 使用过期Token加入频道时返回  
详细原因:
- Token授权超时：Token生成后必须在24小时内使用
- Token权限过期：Token设置的权限时间戳已过期  
解决方案:
- 在服务器上生成新的Token
- 重新尝试加入频道

---

# ERR_INVALID_TOKEN (110)
错误码: 110  
含义: Token无效  
分类: 认证错误  
出现场景: 使用无效Token时返回  
常见原因:
- 项目已启用App Certificate但未提供Token
- 项目未启用App Certificate但提供了Token  
- 生成Token时使用的App ID、用户ID和频道名称与实际使用时不匹配  
解决方案:
- 检查项目是否启用了App Certificate
- 确保Token生成参数与使用时一致

---

# ERR_CONNECTION_INTERRUPTED (111)
错误码: 111  
含义: 网络连接中断。仅适用于Agora Web SDK  
分类: 网络错误  
出现场景: Web SDK网络连接中断时返回  
平台: Web SDK

---

# ERR_CONNECTION_LOST (112)
错误码: 112  
含义: 网络连接丢失。仅适用于Agora Web SDK  
分类: 网络错误  
出现场景: Web SDK网络连接丢失时返回  
平台: Web SDK

---

# ERR_NOT_IN_CHANNEL (113)
错误码: 113  
含义: 调用sendStreamMessage()方法时用户不在频道中  
分类: 状态错误  
出现场景: 未加入频道时发送数据流消息返回

---

# ERR_SIZE_TOO_LARGE (114)
错误码: 114  
含义: 调用sendStreamMessage()方法时数据大小超过1024字节  
分类: 数据大小限制错误  
出现场景: 发送的流消息数据过大时返回

---

# ERR_BITRATE_LIMIT (115)
错误码: 115  
含义: 调用sendStreamMessage()方法时发送数据的比特率超过6 Kbps限制  
分类: 比特率限制错误  
出现场景: 数据流发送速率过快时返回

---

# ERR_TOO_MANY_DATA_STREAMS (116)
错误码: 116  
含义: 调用createDataStream()方法时创建的数据流过多（超过5个）  
分类: 数据流限制错误  
出现场景: 创建数据流数量超限时返回

---

# ERR_STREAM_MESSAGE_TIMEOUT (117)
错误码: 117  
含义: 数据流传输超时  
分类: 超时错误  
出现场景: 数据流消息发送超时时返回

---

# ERR_SET_CLIENT_ROLE_NOT_AUTHORIZED (119)
错误码: 119  
含义: 切换用户角色失败。请尝试重新加入频道  
分类: 角色切换错误  
出现场景: 用户角色切换权限不足时返回

---

# ERR_DECRYPTION_FAILED (120)
错误码: 120  
含义: 媒体流解密失败。用户可能尝试使用错误的密码加入频道  
分类: 加密解密错误  
出现场景: 媒体流解密失败时返回  
解决方案:
- 检查加密设置
- 尝试重新加入频道

---

# ERR_INVALID_USER_ID (121)
错误码: 121  
含义: 用户ID无效  
分类: 参数错误  
出现场景: 使用无效用户ID时返回

---

# ERR_DATASTREAM_DECRYPTION_FAILED (122)
错误码: 122  
含义: 数据流解密失败。对方可能使用错误的密码加入频道，或未启用数据流加密  
分类: 加密解密错误  
出现场景: 数据流解密失败时返回

---

# ERR_CLIENT_IS_BANNED_BY_SERVER (123)
错误码: 123  
含义: 应用程序被服务器封禁  
分类: 服务器限制错误  
出现场景: 应用被服务端封禁时返回

---

# ERR_ENCRYPTED_STREAM_NOT_ALLOWED_PUBLISH (130)
错误码: 130  
含义: 调用addPublishStreamUrl()方法时启用了加密（CDN直播不支持加密流）  
分类: CDN推流错误  
出现场景: 尝试推送加密流到CDN时返回

---

# ERR_LICENSE_CREDENTIAL_INVALID (131)
错误码: 131  
含义: 许可证凭据无效  
分类: 许可证错误  
出现场景: 许可证验证失败时返回

---

# ERR_INVALID_USER_ACCOUNT (134)
错误码: 134  
含义: 用户账户无效，通常是因为用户账户的数据格式不正确  
分类: 参数错误  
出现场景: 使用无效格式的用户账户时返回

---

# ERR_MODULE_NOT_FOUND (157)
错误码: 157  
含义: 缺少必要的动态库。例如，调用enableDeepLearningDenoise但未将深度学习降噪的动态库集成到项目中  
分类: 模块缺失错误  
出现场景: 调用功能但缺少对应动态库时返回

---

# ERR_CERT_RAW (157)
错误码: 157  
含义: 原始证书错误  
分类: 许可证错误  
模块: 许可证验证

---

# ERR_CERT_JSON_PART (158)
错误码: 158  
含义: 证书JSON部分错误  
分类: 许可证错误  
模块: 许可证验证

---

# ERR_CERT_JSON_INVAL (159)
错误码: 159  
含义: 证书JSON无效  
分类: 许可证错误  
模块: 许可证验证

---

# ERR_CERT_JSON_NOMEM (160)
错误码: 160  
含义: 证书JSON内存不足  
分类: 许可证错误  
模块: 许可证验证

---

# ERR_CERT_CUSTOM (161)
错误码: 161  
含义: 自定义证书错误  
分类: 许可证错误  
模块: 许可证验证

---

# ERR_CERT_CREDENTIAL (162)
错误码: 162  
含义: 证书凭据错误  
分类: 许可证错误  
模块: 许可证验证

---

# ERR_CERT_SIGN (163)
错误码: 163  
含义: 证书签名错误  
分类: 许可证错误  
模块: 许可证验证

---

# ERR_CERT_FAIL (164)
错误码: 164  
含义: 证书验证失败  
分类: 许可证错误  
模块: 许可证验证

---

# ERR_CERT_BUF (165)
错误码: 165  
含义: 证书缓冲区错误  
分类: 许可证错误  
模块: 许可证验证

---

# ERR_CERT_NULL (166)
错误码: 166  
含义: 证书为空  
分类: 许可证错误  
模块: 许可证验证

---

# ERR_CERT_DUEDATE (167)
错误码: 167  
含义: 证书过期  
分类: 许可证错误  
模块: 许可证验证

---

# ERR_CERT_REQUEST (168)
错误码: 168  
含义: 证书请求错误  
分类: 许可证错误  
模块: 许可证验证

---

# ERR_PCMSEND_FORMAT (200)
错误码: 200  
含义: 不支持的PCM格式  
分类: PCM格式错误  
模块: PCM发送  
出现场景: 使用不支持的PCM音频格式时返回

---

# ERR_PCMSEND_BUFFEROVERFLOW (201)
错误码: 201  
含义: 缓冲区溢出，PCM发送速率过快  
分类: PCM缓冲区错误  
模块: PCM发送  
出现场景: PCM数据发送速度超过处理能力时返回

---

# ERR_LOGIN_ALREADY_LOGIN (428)
错误码: 428  
含义: 已经登录  
分类: 登录状态错误  
模块: 信令  
出现场景: 重复登录时返回

---

# ERR_LOAD_MEDIA_ENGINE (1001)
错误码: 1001  
含义: 加载媒体引擎失败  
分类: 媒体引擎错误  
出现场景: 媒体引擎初始化失败时返回

---

# ERR_ADM_GENERAL_ERROR (1005)
错误码: 1005  
含义: 音频设备模块：一般性错误（未指定原因）。检查音频设备是否被其他应用占用，或尝试重新加入频道  
模块: 音频设备模块 (ADM)  
分类: ADM通用错误  
解决方案:
- 检查音频设备是否被其他应用占用
- 尝试重新加入频道

---

# ERR_ADM_INIT_PLAYOUT (1008)
错误码: 1008  
含义: 音频设备模块：初始化播放设备时发生错误  
模块: 音频设备模块 (ADM)  
分类: ADM播放设备错误  
设备类型: 播放设备  
操作类型: 初始化  
出现场景: 播放设备初始化失败时返回

---

# ERR_ADM_START_PLAYOUT (1009)
错误码: 1009  
含义: 音频设备模块：启动播放设备时发生错误  
模块: 音频设备模块 (ADM)  
分类: ADM播放设备错误  
设备类型: 播放设备  
操作类型: 启动  
出现场景: 播放设备启动失败时返回

---

# ERR_ADM_STOP_PLAYOUT (1010)
错误码: 1010  
含义: 音频设备模块：停止播放设备时发生错误  
模块: 音频设备模块 (ADM)  
分类: ADM播放设备错误  
设备类型: 播放设备  
操作类型: 停止  
出现场景: 播放设备停止失败时返回

---

# ERR_ADM_INIT_RECORDING (1011)
错误码: 1011  
含义: 音频设备模块：初始化录音设备时发生错误  
模块: 音频设备模块 (ADM)  
分类: ADM录音设备错误  
设备类型: 录音设备  
操作类型: 初始化  
出现场景: 录音设备初始化失败时返回

---

# ERR_ADM_START_RECORDING (1012)
错误码: 1012  
含义: 音频设备模块：启动录音设备时发生错误  
模块: 音频设备模块 (ADM)  
分类: ADM录音设备错误  
设备类型: 录音设备  
操作类型: 启动  
出现场景: 录音设备启动失败时返回

---

# ERR_ADM_STOP_RECORDING (1013)
错误码: 1013  
含义: 音频设备模块：停止录音设备时发生错误  
模块: 音频设备模块 (ADM)  
分类: ADM录音设备错误  
设备类型: 录音设备  
操作类型: 停止  
出现场景: 录音设备停止失败时返回

---

# ERR_VDM_CAMERA_NOT_AUTHORIZED (1501)
错误码: 1501  
含义: 视频设备模块：摄像头未授权  
模块: 视频设备模块 (VDM)  
分类: VDM权限错误  
设备类型: 摄像头  
权限要求: 摄像头访问权限  
出现场景: 应用没有摄像头使用权限时返回

---

# UNKNOWN_AUDIO_DEVICE (-1)
错误码: -1
含义: 未知设备类型
分类: 音频设备枚举
出现场景: 设备类型未检测或指针/参数未设置时使用

---

# AUDIO_PLAYOUT_DEVICE (0)
错误码: 0
含义: 播放（输出）设备（扬声器/耳机）
分类: 音频设备枚举
出现场景: 指定/操作播放相关接口时使用

---

# AUDIO_RECORDING_DEVICE (1)
错误码: 1
含义: 录音（输入）设备（麦克风）
分类: 音频设备枚举
出现场景: 指定/操作录音相关接口时使用

---

# AUDIO_APPLICATION_PLAYOUT_DEVICE (2)
错误码: 2
含义: 应用播放设备（用于应用内部播放区分系统默认）
分类: 音频设备枚举
出现场景: 区分系统播放与应用内部播放时使用

---

# AUDIO_LOOPBACK_RECORDING_DEVICE (3)
错误码: 3
含义: loopback 录制设备（录制本地播放数据）
分类: 音频设备枚举
出现场景: 做本地混音或屏幕录制时捕获系统输出音频

---

# DEVICE_EARPIECE (0x1u)
错误码: 1
含义: 听筒
分类: Android 播放设备子类型
出现场景: Android 平台选择或上报当前播放设备路由
平台: Android

---

# DEVICE_SPEAKER (0x2u)
错误码: 2
含义: 扬声器
分类: Android 播放设备子类型
出现场景: Android 平台选择或上报当前播放设备路由
平台: Android

---

# DEVICE_WIRED_HEADSET (0x4u)
错误码: 4
含义: 有线耳机
分类: Android 播放设备子类型
出现场景: Android 平台选择或上报当前播放设备路由
平台: Android

---

# DEVICE_USB_HEADSET (0x4000000u)
错误码: 67108864
含义: USB 耳机
分类: Android 播放设备子类型
出现场景: Android 平台选择或上报当前播放设备路由
平台: Android

---

# AUDIO_MODE_NORMAL (0)
错误码: 0
含义: 常规模式
分类: Android 音频会话模式
出现场景: 设置/检测 Android 音频模式以优化回声/路由
平台: Android

---

# AUDIO_MODE_RING (1)
错误码: 1
含义: 响铃模式
分类: Android 音频会话模式
出现场景: 设置/检测 Android 音频模式以优化回声/路由
平台: Android

---

# AUDIO_MODE_IN_PHONE_CALL (2)
错误码: 2
含义: 通话模式（典型电话）
分类: Android 音频会话模式
出现场景: 设置/检测 Android 音频模式以优化回声/路由
平台: Android

---

# AUDIO_MODE_IN_COMMUNICATION (3)
错误码: 3
含义: 通信模式（VoIP/实时通话）
分类: Android 音频会话模式
出现场景: 设置/检测 Android 音频模式以优化回声/路由
平台: Android

---

# ERROR_AUDIO_DEVICE_OK (0)
错误码: 0
含义: 无错误
分类: ADM（音频设备模块）返回码
出现场景: 音频操作成功

---

# ERROR_AUDIO_DEVICE_FAILED (1)
错误码: 1
含义: 通用失败
分类: ADM 错误
出现场景: 音频操作失败但未给出具体原因
解决方案:
- 检查设备权限与占用

---

# ERROR_AUDIO_DEVICE_NO_PERMISSION (2)
错误码: 2
含义: 无麦克风/音频权限
分类: 权限错误
出现场景: 应用未获得麦克风权限或用户拒绝
解决方案:
- 提示用户授权

---

# ERROR_AUDIO_DEVICE_BUSY (3)
错误码: 3
含义: 设备被占用
分类: 资源冲突
出现场景: 其他应用占用音频设备（例如另一通话应用）
解决方案:
- 提示用户关闭占用应用或重试

---

# ERROR_AUDIO_DEVICE_NO_RECORDING_DEVICE (4)
错误码: 4
含义: 无录音设备可用
分类: 硬件错误
出现场景: 系统无麦克风或被禁用

---

# ERROR_AUDIO_DEVICE_NO_PLAYOUT_DEVICE (5)
错误码: 5
含义: 无播放设备可用
分类: 硬件错误
出现场景: 系统无扬声器/耳机或驱动异常

---

# ERROR_AUDIO_DEVICE_INTERRUPTED (6)
错误码: 6
含义: 音频中断（例如来电、Siri、系统事件）
分类: 运行时中断
出现场景: iOS/Android 音频会话被中断

---

# ERROR_AUDIO_DEVICE_RECORD_INVALID_ID (7)
错误码: 7
含义: 录音设备 ID 无效
分类: 参数错误
出现场景: 尝试使用不存在或已失效的设备 ID

---

# ERROR_AUDIO_DEVICE_PLAYOUT_INVALID_ID (8)
错误码: 8
含义: 播放设备 ID 无效
分类: 参数错误
出现场景: 尝试使用不存在或已失效的播放设备 ID

---

# ERR_ADM_ENQUEUE_RECORDER_BUFFER_ERR (1165)
错误码: 1165
含义: 录音线程运行异常
分类: Android OpenSLES 运行时错误
平台: Android

---

# ERR_ADM_RECORDER_DATA_LEVEL_ERR (1166)
错误码: 1166
含义: 录音数据电平错误（可能采样异常）
分类: Android OpenSLES 运行时错误
平台: Android

---

# ERR_ADM_PLAYER_THREAD_WORKING_ERR (1167)
错误码: 1167
含义: 播放线程运行异常
分类: Android OpenSLES 运行时错误
平台: Android

---

# ERR_ADM_CREATE_AUDIO_MIXER (1171)
错误码: 1171
含义: 音频混音器创建失败
分类: Android OpenSLES 初始化错误
平台: Android

---

# ERR_ADM_IOS_SESSION_ACTIVATE_FAIL (1206)
错误码: 1206
含义: iOS 音频 session 激活失败
分类: iOS AVFAudio 错误
出现场景: AVAudioSession activate 失败（权限/系统限制）
平台: iOS
解决方案:
- 检查 Info.plist 麦克风权限、session 配置

---

# ERR_ADM_IOS_VPIO_INIT_FAIL (1210)
错误码: 1210
含义: iOS VPIO 初始化失败（输入/输出封装层）
分类: iOS AVFAudio 错误
平台: iOS

---

# ERR_ADM_IOS_VPIO_UNINITIALIZE_FAIL (1217)
错误码: 1217
含义: VPIO 卸载失败
分类: iOS AVFAudio 错误
平台: iOS

---

# ERR_ADM_IOS_SESSION_DURATION_ILLEGAL (1026)
错误码: 1026
含义: iOS session duration 非法（通常 sample rate/buffer duration 不合法）
分类: iOS AVFAudio 错误
平台: iOS

---

# ERR_ADM_IOS_SESSION_CATEGORY_NOT_PLAYANDRECORD (1029)
错误码: 1029
含义: session category 非 PlayAndRecord（期望通话/录放需该属性）
分类: iOS AVFAudio 错误
平台: iOS

---

# ERR_ADM_WIN_CORE_NOT_INITIALIZED (1701)
错误码: 1701
含义: Core Audio 未初始化
分类: Windows Core Audio 错误
出现场景: 调用 Core Audio 接口前未完成 init
平台: Windows

---

# ERR_ADM_WIN_CORE_SERVER_SHUT_DOWN (1735)
错误码: 1735
含义: Core Audio 服务已关闭
分类: Windows Core Audio 错误
平台: Windows

---

# ERR_ADM_WIN_CORE_PAIR_ERR (1743)
错误码: 1743
含义: 设备配对错误
分类: Windows Core Audio 错误
平台: Windows

---

# ERR_ADM_WIN_CORE_NO_PERMISSION (1742)
错误码: 1742
含义: 无访问权限（Windows 层面）
分类: Windows Core Audio 权限错误
平台: Windows

---

# ERR_ADM_WIN_CORE_REGISTRY_DEVICE (1744)
错误码: 1744
含义: 注册表设备项错误（驱动配置问题）
分类: Windows Core Audio 错误
平台: Windows

---

# ERR_ADM_WIN_CORE_DEVICE_SLIENCE_PACKET (1801)
错误码: 1801
含义: 采集到静音包（可能设备异常）
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_NO_RECORD_DEVICE (1802)
错误码: 1802
含义: 无录音设备
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_RECORDING_UNSUPPORTED_FORMAT (1803)
错误码: 1803
含义: 录制不支持的格式
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_RECORD_IS_OCCUPIED (1804)
错误码: 1804
含义: 录制设备被占用
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_RECORD_DEVICE_INVALIDATED (1805)
错误码: 1805
含义: 录制设备失效
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_CAPTURE_THREAD_CREATE_FAILED (1806)
错误码: 1806
含义: 采集线程创建失败
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_CAPTURE_VOLUME_GETTER_CREATE_FAILED (1807)
错误码: 1807
含义: 音量获取线程创建失败
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_CAPTURE_VOLUME_SETTER_CREATE_FAILED (1808)
错误码: 1808
含义: 音量设置线程创建失败
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_CAPTURE_START_FAILED (1809)
错误码: 1809
含义: 采集启动失败
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_CAPTURE_COM_FAILED (1810)
错误码: 1810
含义: COM 接口调用失败
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_CAPTURE_DEVICE_FAILED (1811)
错误码: 1811
含义: 采集设备失败
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_CAPTURE_DISCONTINUITY (1812)
错误码: 1812
含义: 音频不连续（timestamp 间断）
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_CAPTURE_TIMESTAMP_ERROR (1813)
错误码: 1813
含义: 时间戳错误
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_CAPTURE_STOP_FAILED (1814)
错误码: 1814
含义: 采集停止失败
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_CAPTURE_VOLUME_GETTER_STOP_FAILED (1815)
错误码: 1815
含义: 音量获取停止失败
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_CAPTURE_VOLUME_SETTER_STOP_FAILED (1816)
错误码: 1816
含义: 音量设置停止失败
分类: Windows Core Audio 采集错误
平台: Windows

---

# ERR_ADM_WIN_CORE_NO_PLAYOUT_DEVICE (1901)
错误码: 1901
含义: 无播放设备
分类: Windows Core Audio 播放错误
平台: Windows

---

# ERR_ADM_WIN_CORE_PLAYOUT_UNSUPPORTED_FORMAT (1902)
错误码: 1902
含义: 播放不支持的格式
分类: Windows Core Audio 播放错误
平台: Windows

---

# ERR_ADM_WIN_CORE_RENDER_THREAD_CREATE_FAILED (1903)
错误码: 1903
含义: 播放线程创建失败
分类: Windows Core Audio 播放错误
平台: Windows

---

# ERR_ADM_WIN_CORE_RENDER_START_FAILED (1904)
错误码: 1904
含义: 播放启动失败
分类: Windows Core Audio 播放错误
平台: Windows

---

# ERR_ADM_WIN_CORE_RENDER_COM_FAILED (1905)
错误码: 1905
含义: 播放 COM 调用失败
分类: Windows Core Audio 播放错误
平台: Windows

---

# ERR_ADM_WIN_CORE_RENDER_STOP_FAILED (1906)
错误码: 1906
含义: 播放停止失败
分类: Windows Core Audio 播放错误
平台: Windows

---

# ERR_ADM_WIN_CORE_PLAYOUT_DEVICE_INVALIDATED (1907)
错误码: 1907
含义: 播放设备失效
分类: Windows Core Audio 播放错误
平台: Windows

---

# ERR_ADM_WIN_CORE_LOOPBACK_COM_FAILED (2001)
错误码: 2001
含义: loopback COM 出错
分类: Windows Core Audio Loopback错误
平台: Windows

---

# ERR_ADM_WIN_CORE_NO_LOOPBACK_DEVICE (2002)
错误码: 2002
含义: 无 loopback 设备
分类: Windows Core Audio Loopback错误
平台: Windows

---

# ERR_ADM_WIN_CORE_LOOPBACK_UNSUPPORTED_FORMAT (2003)
错误码: 2003
含义: loopback 不支持格式
分类: Windows Core Audio Loopback错误
平台: Windows

---

# ERR_ADM_WIN_CORE_LOOPBACK_DEVICE_INVALIDATED (2004)
错误码: 2004
含义: loopback 设备失效
分类: Windows Core Audio Loopback错误
平台: Windows

---

# ERR_ADM_WIN_CORE_LOOPBACK_THREAD_CREATE_FAILED (2005)
错误码: 2005
含义: loopback 线程创建失败
分类: Windows Core Audio Loopback错误
平台: Windows

---

# ERR_ADM_WIN_CORE_LOOPBACK_START_FAILED (2006)
错误码: 2006
含义: loopback 启动失败
分类: Windows Core Audio Loopback错误
平台: Windows

---

# WARN_ADM_RECORD_IS_OCCUPIED (1033)
错误码: 1033
含义: 录音设备被占用（警告）
分类: 内部警告

---

# WARN_ADM_GLITCH_STATE (1052)
错误码: 1052
含义: 出现 glitch（抖动、丢包或音频撕裂）状态
分类: 内部警告

---

# WARN_ADM_RECORD_IS_OCCUPIED_INTERNAL (1172)
错误码: 1172
含义: 内部标记的录音被占用警告
分类: 内部警告

---

# WARN_ADM_IOS_SESSION_DEACTIVATE_FAIL (1207)
错误码: 1207
含义: iOS 取消激活 session 失败（警告）
分类: iOS 内部警告
平台: iOS

---

# WARN_ADM_IOS_SESSION_MODE_ILLEGAL (1034)
错误码: 1034
含义: 非法的 iOS session 模式（警告）
分类: iOS 内部警告
平台: iOS

---

# WARN_ADM_IOS_SESSION_MODE_MISMATCH (1035)
错误码: 1035
含义: session 模式不匹配（警告）
分类: iOS 内部警告
平台: iOS

---

# WARN_ADM_IOS_RESTART (1028)
错误码: 1028
含义: iOS 音频子系统需要重启（警告）
分类: iOS 内部警告
平台: iOS

---

# AUDIO_DEVICE_STATE_STOPPED (0)
错误码: 0
含义: 设备已停止
分类: 设备状态
出现场景: SDK 在上报当前设备实际状态或触发状态变更事件时使用

---

# AUDIO_DEVICE_STATE_RECORDING (1)
错误码: 1
含义: 设备正在录音
分类: 设备状态
出现场景: SDK 在上报当前设备实际状态或触发状态变更事件时使用

---

# AUDIO_DEVICE_STATE_PLAYING (2)
错误码: 2
含义: 设备正在播放
分类: 设备状态
出现场景: SDK 在上报当前设备实际状态或触发状态变更事件时使用

---

# AUDIO_DEVICE_STATE_FAILED (3)
错误码: 3
含义: 设备运行失败（错误状态）
分类: 设备状态
出现场景: SDK 在上报当前设备实际状态或触发状态变更事件时使用

---

# AUDIO_DEVICE_STATE_IDLE (0)
错误码: 0
含义: 空闲
分类: 设备状态细分类/标志位
出现场景: 提供更细的设备状态标识（组合使用位掩码）

---

# AUDIO_DEVICE_STATE_ACTIVE (1)
错误码: 1
含义: 激活中
分类: 设备状态细分类/标志位
出现场景: 提供更细的设备状态标识（组合使用位掩码）

---

# AUDIO_DEVICE_STATE_DISABLED (2)
错误码: 2
含义: 被禁用（例如权限被禁用）
分类: 设备状态细分类/标志位
出现场景: 提供更细的设备状态标识（组合使用位掩码）

---

# AUDIO_DEVICE_STATE_NOT_PRESENT (4)
错误码: 4
含义: 设备不存在
分类: 设备状态细分类/标志位
出现场景: 提供更细的设备状态标识（组合使用位掩码）

---

# AUDIO_DEVICE_STATE_UNPLUGGED (8)
错误码: 8
含义: 设备被拔出
分类: 设备状态细分类/标志位
出现场景: 提供更细的设备状态标识（组合使用位掩码）

---

# AUDIO_DEVICE_STATE_UNRECOMMENDED (16)
错误码: 16
含义: 设备不推荐使用（兼容性问题）
分类: 设备状态细分类/标志位
出现场景: 提供更细的设备状态标识（组合使用位掩码）

---

# ERR_INVALID_VIEW (8)
错误码: 8
含义: 视图（渲染目标）无效
分类: 状态错误
出现场景: 传入的渲染窗口句柄或 view 对象为 null/已销毁

---

# ERR_INVALID_VENDOR_KEY (101)
错误码: 101
含义: 供应商 Key（或 AppID）无效或格式错误
分类: 配置错误
出现场景: 初始化时传入非法 App ID/Key
解决方案:
- 校验 App ID 格式与来源

---

# ERR_NO_AVAILABLE_CHANNEL (103)
错误码: 103
含义: 无可用频道（服务器端资源/路由问题）
分类: 服务器资源错误
出现场景: 申请频道失败或返回无可用资源

---

# ERR_LOOKUP_CHANNEL_TIMEOUT (104)
错误码: 104
含义: 声网节点查询、加入频道超时（DNS解析失败或客户端与节点连接超时）
出现场景: 网络质量比较差、长时间断网掉线（如加入频道时开启了 vpn）、流量和 wifi 模式切换未及时恢复
分类: 超时错误

---

# ERR_LOOKUP_CHANNEL_REJECTED (105)
错误码: 105
含义: 频道查找被拒绝（服务器端或策略）
分类: 请求处理错误

---

# ERR_OPEN_CHANNEL_TIMEOUT (106)
错误码: 106
含义: 加入频道超时（建立信令/媒体通道超时）
出现场景: 网络质量比较差、长时间断网掉线（如加入频道时开启了 vpn）、流量和 wifi 模式切换未及时恢复
分类: 超时错误

---

# ERR_OPEN_CHANNEL_REJECTED (107)
错误码: 107
含义: 加入频道请求被拒绝
分类: 请求处理错误

---

# ERR_START_CALL (1002)
错误码: 1002
含义: 开始通话失败（媒体/通道未准备）
分类: 媒体引擎错误

---

# ERR_START_CAMERA (1003)
错误码: 1003
含义: 启动摄像头失败（权限/设备/驱动）
分类: 视频设备错误

---

# ERR_START_VIDEO_RENDER (1004)
错误码: 1004
含义: 启动视频渲染失败（view 无效/资源分配失败）
分类: 视频引擎错误

---

# ERR_ADM_JAVA_RESOURCE (1006)
错误码: 1006
含义: Java 层资源异常（Android）
分类: ADM通用错误
平台: Android

---

# ERR_ADM_SAMPLE_RATE (1007)
错误码: 1007
含义: 采样率（sample rate）设置错误或不支持
分类: ADM通用错误

---

# ERR_ADM_RUNTIME_PLAYOUT_WARNING (1014)
错误码: 1014
含义: 运行时播放警告（非致命）
分类: ADM播放设备错误
模块: ADM

---

# ERR_ADM_RUNTIME_PLAYOUT_ERROR (1015)
错误码: 1015
含义: 运行时播放错误（致命/需要处理）
分类: ADM播放设备错误
模块: ADM

---

# ERR_ADM_RUNTIME_RECORDING_WARNING (1016)
错误码: 1016
含义: 运行时录音警告
分类: ADM录音设备错误
模块: ADM

---

# ERR_ADM_RUNTIME_RECORDING_ERROR (1017)
错误码: 1017
含义: 运行时录音错误
分类: ADM录音设备错误
模块: ADM

---

# ERR_ADM_RECORD_AUDIO_FAILED (1018)
错误码: 1018
含义: 录音失败（读写/设备错误）
分类: ADM录音设备错误
模块: ADM

---

# ERR_ADM_RECORD_AUDIO_IS_OCCUPIED (1033)
错误码: 1033
含义: 录音设备被占用
分类: ADM录音设备错误
模块: ADM

---

# ERR_ADM_INIT_LOOPBACK (1022)
错误码: 1022
含义: 初始化 loopback 失败
分类: ADM录音设备错误
模块: ADM

---

# ERR_ADM_START_LOOPBACK (1023)
错误码: 1023
含义: 启动 loopback 失败
分类: ADM录音设备错误
模块: ADM

---

# ERR_ADM_STOP_LOOPBACK (1024)
错误码: 1024
含义: 停止 loopback 失败
分类: ADM录音设备错误
模块: ADM

---

# ERR_ADM_NO_PERMISSION (1027)
错误码: 1027
含义: 没有音频权限（iOS/Android 等）
分类: ADM权限错误
模块: ADM

---

# ERR_ADM_ANDROID_JNI_JAVA_RESOURCE (1101)
错误码: 1101
含义: Android JNI Java资源错误
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_JNI_INIT_SAMPLE_RATE (1102)
错误码: 1102
含义: Android JNI初始化采样率失败
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_JNI_INIT_MAX_VOLUME (1103)
错误码: 1103
含义: Android JNI初始化最大音量失败
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_JNI_CREATE_RECORD_THREAD (1104)
错误码: 1104
含义: Android JNI创建录音线程失败
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_JNI_CREATE_PLAYBACK_THREAD (1105)
错误码: 1105
含义: Android JNI创建播放线程失败
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_JNI_START_RECORD_THREAD (1106)
错误码: 1106
含义: Android JNI启动录音线程失败
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_JNI_START_PLAYBACK_THREAD (1107)
错误码: 1107
含义: Android JNI启动播放线程失败
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_JNI_NO_RECORD_FREQUENCY (1108)
错误码: 1108
含义: Android JNI无录音频率
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_JNI_NO_PLAYBACK_FREQUENCY (1109)
错误码: 1109
含义: Android JNI无播放频率
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_JNI_JAVA_INIT_PLAYBACK (1110)
错误码: 1110
含义: Android JNI Java初始化播放失败
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_JNI_JAVA_START_RECORD (1111)
错误码: 1111
含义: Android JNI Java启动录音失败
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_JNI_JAVA_START_PLAYBACK (1112)
错误码: 1112
含义: Android JNI Java启动播放失败
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_JNI_JAVA_STOP_RECORD (1113)
错误码: 1113
含义: Android JNI Java停止录音失败
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_JNI_JAVA_STOP_PLAYBACK (1114)
错误码: 1114
含义: Android JNI Java停止播放失败
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_JNI_JAVA_RECORD_ERROR (1115)
错误码: 1115
含义: Android JNI Java录音错误
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_JNI_JAVA_RECORD_RETRY_ERROR (1116)
错误码: 1116
含义: Android JNI Java录音重试错误
分类: Android ADM JNI错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_CREATE_ENGINE (1151)
错误码: 1151
含义: Android OpenSL ES创建引擎失败
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_INIT_SAMPLE_RATE (1152)
错误码: 1152
含义: Android OpenSL ES初始化采样率失败
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_CREATE_AUDIO_RECORDER (1153)
错误码: 1153
含义: Android OpenSL ES创建音频录制器失败
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_REGISTER_AUDIO_RECORDER (1154)
错误码: 1154
含义: Android OpenSL ES注册音频录制器失败
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_ENQUEUE_RECORDER_BUFFER (1155)
错误码: 1155
含义: Android OpenSL ES录制器缓冲区入队失败
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_START_RECORDER_THREAD (1156)
错误码: 1156
含义: Android OpenSL ES启动录制器线程失败
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_CREATE_AUDIO_PLAYER (1157)
错误码: 1157
含义: Android OpenSL ES创建音频播放器失败
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_REGISTER_AUDIO_PLAYER (1158)
错误码: 1158
含义: Android OpenSL ES注册音频播放器失败
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_ENQUEUE_PLAYER_BUFFER (1159)
错误码: 1159
含义: Android OpenSL ES播放器缓冲区入队失败
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_START_PLAYER_THREAD (1160)
错误码: 1160
含义: Android OpenSL ES启动播放器线程失败
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_RECORD_FREQ (1161)
错误码: 1161
含义: Android OpenSL ES录制频率错误
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_PLAYOUT_FREQ (1162)
错误码: 1162
含义: Android OpenSL ES播放频率错误
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_RECORD_ERROR (1163)
错误码: 1163
含义: Android OpenSL ES录制错误
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_PLAYOUT_ERROR (1164)
错误码: 1164
含义: Android OpenSL ES播放错误
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_PLAYOUT_THREAD_UNNORMAL (1165)
错误码: 1165
含义: Android OpenSL ES播放线程异常
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_RECORD_NEARIN_UNNORMAL (1166)
错误码: 1166
含义: Android OpenSL ES录制近端异常
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_PLAYOUT_NEARIN_UNNORMAL (1167)
错误码: 1167
含义: Android OpenSL ES播放近端异常
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_RECORDER_THREAD_WORKING_ERR (1168)
错误码: 1168
含义: Android OpenSL ES录制器线程工作错误
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_RECORDER_DATALEVEL_ERR (1169)
错误码: 1169
含义: Android OpenSL ES录制器数据级别错误
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_PLAYER_THREAD_WORKING_ERR (1170)
错误码: 1170
含义: Android OpenSL ES播放器线程工作错误
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_RECORD_STATE_STOP (1171)
错误码: 1171
含义: Android OpenSL ES录制状态停止
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_RECORD_START_FAILED (1172)
错误码: 1172
含义: Android OpenSL ES录制启动失败
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OPENSL_RECORD_FREEZE (1173)
错误码: 1173
含义: Android OpenSL ES录制冻结
分类: Android ADM OpenSL ES错误
平台: Android
模块: ADM

---

# ERR_ADM_ANDROID_OBOE_ERR_DISCONNECT (1181)
错误码: 1181
含义: Android OBOE断开连接错误
分类: Android ADM OBOE错误
平台: Android
模块: ADM

---

# ERR_ADM_IOS_INPUT_NOT_AVAILABLE (1201)
错误码: 1201
含义: iOS音频输入不可用
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_SIRI_IS_ACTIVATING (1203)
错误码: 1203
含义: iOS Siri正在激活
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_ACTIVATE_SESSION_FAIL (1206)
错误码: 1206
含义: iOS激活音频会话失败
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_DEACTIVATE_SESSION_FAIL (1207)
错误码: 1207
含义: iOS停用音频会话失败
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_CREATE_INSTANCE_FAIL (1208)
错误码: 1208
含义: iOS创建实例失败
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_VPIO_INIT_FAIL (1210)
错误码: 1210
含义: iOS VPIO初始化失败
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_VPIO_STOP_FAIL (1211)
错误码: 1211
含义: iOS VPIO停止失败
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_VPIO_UNINIT_FAIL (1212)
错误码: 1212
含义: iOS VPIO反初始化失败
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_VPIO_REINIT_FAIL (1213)
错误码: 1213
含义: iOS VPIO重新初始化失败
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_VPIO_RESTART_FAIL (1214)
错误码: 1214
含义: iOS VPIO重启失败
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_ENABLE_INPUT_FAIL (1215)
错误码: 1215
含义: iOS启用音频输入失败
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_ENABLE_OUTPUT_FAIL (1216)
错误码: 1216
含义: iOS启用音频输出失败
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_SET_INPUT_FORMAT_FAIL (1217)
错误码: 1217
含义: iOS设置输入格式失败
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_SET_OUTPUT_FORMAT_FAIL (1218)
错误码: 1218
含义: iOS设置输出格式失败
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_SET_RENDER_CALLBACK_FAIL (1219)
错误码: 1219
含义: iOS设置渲染回调失败
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_SET_INPUT_CALLBACK_FAIL (1220)
错误码: 1220
含义: iOS设置输入回调失败
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_IOS_SESSION_SAMPLERATE_ZERO (1221)
错误码: 1221
含义: iOS音频会话采样率为零
分类: iOS ADM错误
平台: iOS
模块: ADM

---

# ERR_ADM_WIN_CORE_INIT (1301)
错误码: 1301
含义: Windows Core Audio初始化失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_TERMINATE (1302)
错误码: 1302
含义: Windows Core Audio终止失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_INIT_RECORDING (1303)
错误码: 1303
含义: Windows Core Audio初始化录音失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_RECORDING_DEVICE_NULL (1304)
错误码: 1304
含义: Windows Core Audio录音设备为空
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_CREATE_CAPTURE_STREAM (1305)
错误码: 1305
含义: Windows Core Audio创建录制流失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_INIT_PLAYOUT (1306)
错误码: 1306
含义: Windows Core Audio初始化播放失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_INIT_PLAYOUT_NULL (1307)
错误码: 1307
含义: Windows Core Audio初始化播放设备为空
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_CREATE_RENDER_STREAM (1308)
错误码: 1308
含义: Windows Core Audio创建渲染流失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_START_RECORDING (1309)
错误码: 1309
含义: Windows Core Audio启动录音失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_DMO_PLAYING (1310)
错误码: 1310
含义: Windows Core Audio DMO播放错误
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_CREATE_REC_THREAD (1311)
错误码: 1311
含义: Windows Core Audio创建录音线程失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_CREATE_VOLGET_THREAD (1312)
错误码: 1312
含义: Windows Core Audio创建音量获取线程失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_CREATE_VOLSET_THREAD (1313)
错误码: 1313
含义: Windows Core Audio创建音量设置线程失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_CAPTURE_NOT_STARTUP (1314)
错误码: 1314
含义: Windows Core Audio录制未启动
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_CLOSE_CAPTURE_THREAD (1315)
错误码: 1315
含义: Windows Core Audio关闭录制线程失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_CLOSE_VOLGET_THREAD (1316)
错误码: 1316
含义: Windows Core Audio关闭音量获取线程失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_CLOSE_VOLSET_THREAD (1317)
错误码: 1317
含义: Windows Core Audio关闭音量设置线程失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_START_PLAYOUT (1318)
错误码: 1318
含义: Windows Core Audio启动播放失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_CREATE_RENDER_THREAD (1319)
错误码: 1319
含义: Windows Core Audio创建渲染线程失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_RENDER_NOT_STARTUP (1320)
错误码: 1320
含义: Windows Core Audio渲染未启动
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_CLOSE_RENDER_THREAD (1321)
错误码: 1321
含义: Windows Core Audio关闭渲染线程失败
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_CORE_SERVICE_NOT_RUNNING (1331)
错误码: 1331
含义: Windows Core Audio服务未运行
分类: Windows Core Audio错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_INIT (1351)
错误码: 1351
含义: Windows WAVE API初始化失败
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_TERMINATE (1352)
错误码: 1352
含义: Windows WAVE API终止失败
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_INIT_RECORDING (1353)
错误码: 1353
含义: Windows WAVE API初始化录音失败
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_INIT_MICROPHONE (1354)
错误码: 1354
含义: Windows WAVE API初始化麦克风失败
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_INIT_PLAYOUT (1355)
错误码: 1355
含义: Windows WAVE API初始化播放失败
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_INIT_SPEAKER (1356)
错误码: 1356
含义: Windows WAVE API初始化扬声器失败
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_START_RECORDING (1357)
错误码: 1357
含义: Windows WAVE API启动录音失败
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_START_PLAYOUT (1358)
错误码: 1358
含义: Windows WAVE API启动播放失败
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_ERROR (1751)
错误码: 1751
含义: Windows WAVE API未指定错误
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_BADDEVICEID (1752)
错误码: 1752
含义: Windows WAVE API设备ID超出范围
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_NOTENABLED (1753)
错误码: 1753
含义: Windows WAVE API驱动程序启用失败
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_ALLOCATED (1754)
错误码: 1754
含义: Windows WAVE API设备已分配
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_INVALHANDLE (1755)
错误码: 1755
含义: Windows WAVE API设备句柄无效
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_NODRIVER (1756)
错误码: 1756
含义: Windows WAVE API无设备驱动程序
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_NOMEM (1757)
错误码: 1757
含义: Windows WAVE API内存分配错误
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_NOTSUPPORTED (1758)
错误码: 1758
含义: Windows WAVE API功能不支持
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_BADERRNUM (1759)
错误码: 1759
含义: Windows WAVE API错误值超出范围
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_INVALFLAG (1760)
错误码: 1760
含义: Windows WAVE API传递的标志无效
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_INVALPARAM (1761)
错误码: 1761
含义: Windows WAVE API传递的参数无效
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_HANDLEBUSY (1762)
错误码: 1762
含义: Windows WAVE API句柄在另一个线程上同时使用
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_INVALIDALIAS (1763)
错误码: 1763
含义: Windows WAVE API指定的别名未找到
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_BADDB (1764)
错误码: 1764
含义: Windows WAVE API注册表数据库错误
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_KEYNOTFOUND (1765)
错误码: 1765
含义: Windows WAVE API注册表键未找到
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_READERROR (1766)
错误码: 1766
含义: Windows WAVE API注册表读取错误
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_WRITEERROR (1767)
错误码: 1767
含义: Windows WAVE API注册表写入错误
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_DELETEERROR (1768)
错误码: 1768
含义: Windows WAVE API注册表删除错误
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_VALNOTFOUND (1769)
错误码: 1769
含义: Windows WAVE API注册表值未找到
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_NODRIVERCB (1770)
错误码: 1770
含义: Windows WAVE API驱动程序不调用DriverCallback
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_MOREDATA (1771)
错误码: 1771
含义: Windows WAVE API有更多数据要返回
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_BADFORMAT (1782)
错误码: 1782
含义: Windows WAVE API格式错误
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_STILLPLAYING (1783)
错误码: 1783
含义: Windows WAVE API仍在播放
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_WAVE_UNPREPARED (1784)
错误码: 1784
含义: Windows WAVE API未准备
分类: Windows WAVE API错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_DSHOW_INIT (1401)
错误码: 1401
含义: Windows DirectShow初始化失败
分类: Windows DirectShow错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_DSHOW_INIT_RECORDING (1402)
错误码: 1402
含义: Windows DirectShow初始化录音失败
分类: Windows DirectShow错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_DSHOW_INIT_PLAYOUT (1403)
错误码: 1403
含义: Windows DirectShow初始化播放失败
分类: Windows DirectShow错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_DSHOW_START_RECORDING (1404)
错误码: 1404
含义: Windows DirectShow启动录音失败
分类: Windows DirectShow错误
平台: Windows
模块: ADM

---

# ERR_ADM_WIN_DSHOW_START_PLAYOUT (1405)
错误码: 1405
含义: Windows DirectShow启动播放失败
分类: Windows DirectShow错误
平台: Windows
模块: ADM

---

# ERR_VDM_WIN_DEVICE_IN_USE (1502)
错误码: 1502
含义: Windows视频设备正在使用中
分类: VDM设备错误
平台: Windows
模块: VDM（视频设备模块）

---

# ERR_VDM_CAMERA_NO_DEVICE (1500)
错误码: 1500
含义: 相机设备不存在
分类: VDM设备错误
模块: VDM（视频设备模块）
出现场景: 没有摄像头或摄像头未被系统识别

---



# ERR_VCM_UNKNOWN_ERROR (1600)
错误码: 1600
含义: 视频编码模块未知错误
分类: VCM通用错误
模块: VCM

---

# ERR_VCM_ENCODER_INIT_ERROR (1601)
错误码: 1601
含义: 编码器初始化失败
分类: VCM编码器错误
模块: VCM

---

# ERR_VCM_ENCODER_ENCODE_ERROR (1602)
错误码: 1602
含义: 编码过程失败
分类: VCM编码器错误
模块: VCM

---

# ERR_VCM_ENCODER_SET_ERROR (1603)
错误码: 1603
含义: 设置编码参数失败
分类: VCM编码器错误
模块: VCM

---

# ERR_AUDIO_MULTI_FRAME_OVERFLOW (1613)
错误码: 1613
含义: 旧多帧音频打包限制（帧大小 > 255）导致溢出
分类: 音频处理错误

---

# WARN_ADM_RECORD_AUDIO_SILENCE (1019)
错误码: 1019
含义: 录音音频静音警告
分类: ADM警告
模块: ADM

---

# WARN_ADM_PLAYOUT_ABNORMAL_FREQUENCY (1020)
错误码: 1020
含义: 播放频率异常警告
分类: ADM警告
模块: ADM

---

# WARN_ADM_RECORD_ABNORMAL_FREQUENCY (1021)
错误码: 1021
含义: 录音频率异常警告
分类: ADM警告
模块: ADM

---

# WARN_ADM_IOS_ADM_INTERRUPTION (1025)
错误码: 1025
含义: iOS ADM中断警告
分类: ADM警告
平台: iOS
模块: ADM

---

# WARN_ADM_IOS_AIRPLAY_TO_SPEAKERPHONE (1026)
错误码: 1026
含义: AirPlay强制切换到扬声器警告
分类: ADM警告
平台: iOS
模块: ADM

---

# WARN_ADM_IOS_REC_PLAY_THREAD_KILLED (1028)
错误码: 1028
含义: iOS录播线程被杀死警告（ADM损坏情况）
分类: ADM警告
平台: iOS
模块: ADM

---

# WARN_ADM_IOS_CATEGORY_NOT_PLAYANDRECORD (1029)
错误码: 1029
含义: iOS音频会话类别意外更改警告（非播放和录音）
分类: ADM警告
平台: iOS
模块: ADM

---

# WARN_ADM_IOS_SAMPLERATE_CHANGE (1030)
错误码: 1030
含义: iOS音频设备采样率意外更改警告
分类: ADM警告
平台: iOS
模块: ADM

---

# WARN_ADM_IOS_SCREEN_CAPTURE_BEGINS (1036)
错误码: 1036
含义: iOS屏幕录制开始警告
分类: ADM警告
平台: iOS
模块: ADM

---

# WARN_ADM_IOS_SCREEN_CAPTURE_ENDS (1037)
错误码: 1037
含义: iOS屏幕录制结束警告
分类: ADM警告
平台: iOS
模块: ADM

---

# WARN_ADM_RECORD_AUDIO_LOWLEVEL (1031)
错误码: 1031
含义: 录音音频级别过低警告（难以听见）
分类: ADM警告
模块: ADM

---

# WARN_ADM_PLAYOUT_AUDIO_LOWLEVEL (1032)
错误码: 1032
含义: 播放音频级别过低警告
分类: ADM警告
模块: ADM

---

# WARN_ADM_IMPROPER_AUDIO_SESSION_MODE (1034)
错误码: 1034
含义: 音频会话模式不当警告
分类: ADM警告
模块: ADM

---

# WARN_ADM_MISMATCH_AUDIO_SESSION_MODE (1035)
错误码: 1035
含义: 音频会话模式不匹配警告
分类: ADM警告
模块: ADM

---

# WARN_ADM_WINDOWS_NO_DATA_READY_EVENT (1040)
错误码: 1040
含义: Windows无录制/渲染数据就绪事件警告
分类: ADM警告
平台: Windows
模块: ADM

---

# WARN_ADM_MAC_NO_DATA_READY_EVENT (1041)
错误码: 1041
含义: macOS无录制/渲染数据就绪事件警告
分类: ADM警告
平台: macOS
模块: ADM

---

# WARN_ADM_INCONSISTENT_RECPLAY_DEVICE (1042)
错误码: 1042
含义: 使用不一致的录制/播放设备警告（例如：内置麦克风 vs DisplayPort）
分类: ADM警告
模块: ADM

---

# WARN_ADM_MAC_FORMAT_CONVERTER_FAILED (1043)
错误码: 1043
含义: macOS格式转换器失败警告
分类: ADM警告
平台: macOS
模块: ADM

---

# WARN_ADM_MAC_RECORDING_FORMAT_CHANGED (1044)
错误码: 1044
含义: macOS录音格式更改警告
分类: ADM警告
平台: macOS
模块: ADM

---

# WARN_ADM_MAC_PLAYOUT_FORMAT_CHANGED (1045)
错误码: 1045
含义: macOS播放格式更改警告
分类: ADM警告
平台: macOS
模块: ADM

---

# WARN_ADM_MISMATCH_SAMPLE_RATE (1050)
错误码: 1050
含义: 采样率不匹配警告
分类: ADM警告
模块: ADM

---

# WARN_APM_HOWLING_STATE (1051)
错误码: 1051
含义: 啸叫状态警告
分类: APM警告
模块: APM

---

# WARN_APM_RESIDUAL_ECHO (1053)
错误码: 1053
含义: 残余回声警告
分类: APM警告
模块: APM

---

# WARN_APM_AINS_CLOSED (1054)
错误码: 1054
含义: AINS（AI噪声抑制）关闭警告
分类: APM警告
模块: APM

---

# WARN_APM_AEC_DELAY_NON_CAUSAL (1070)
错误码: 1070
含义: AEC延迟非因果警告
分类: APM AEC警告
模块: APM

---

# WARN_APM_AEC_SYS_UNRECOVERABLE (1071)
错误码: 1071
含义: AEC系统不可恢复警告
分类: APM AEC警告
模块: APM

---

# WARN_APM_AEC_HARDWARE_FAILURE (1080)
错误码: 1080
含义: AEC硬件故障警告
分类: APM AEC警告
模块: APM

---

# WARN_APM_AEC_REVERBERANT_ENVIRONMENT (1081)
错误码: 1081
含义: AEC混响环境警告
分类: APM AEC警告
模块: APM

---

# WARN_APM_AEC_UNDESIRABLE_FEEDBACK (1082)
错误码: 1082
含义: AEC不良反馈警告
分类: APM AEC警告
模块: APM

---

# WARN_ADM_IOS_SET_PLAYANDRECORD_FAIL (1204)
错误码: 1204
含义: iOS设置播放和录音模式失败警告
分类: ADM警告
平台: iOS
模块: ADM

---

# WARN_ADM_IOS_SET_VOICECHAT_FAIL (1205)
错误码: 1205
含义: iOS设置语音聊天模式失败警告
分类: ADM警告
平台: iOS
模块: ADM

---

# WARN_ADM_IOS_SET_SESSION_MODE_FAIL (1224)
错误码: 1224
含义: iOS设置会话模式失败警告
分类: ADM警告
平台: iOS
模块: ADM

---

# WARN_ADM_IOS_SET_SPEAKER_STATUS_FAIL (1225)
错误码: 1225
含义: iOS设置扬声器状态失败警告
分类: ADM警告
平台: iOS
模块: ADM

---

# WARN_ADM_IOS_SET_PREFERRED_SAMPLE_RATE_FAIL (1226)
错误码: 1226
含义: iOS设置首选采样率失败警告
分类: ADM警告
平台: iOS
模块: ADM

---

# WARN_ADM_IOS_SET_PREFERRED_BUFFER_DURATION_FAIL (1227)
错误码: 1227
含义: iOS设置首选缓冲区持续时间失败警告
分类: ADM警告
平台: iOS
模块: ADM

---

# WARN_ADM_WIN_CORE_NO_RECORDING_DEVICE (1322)
错误码: 1322
含义: Windows Core Audio无录音设备警告
分类: ADM警告
平台: Windows
模块: ADM

---

# WARN_ADM_WIN_CORE_NO_PLAYOUT_DEVICE (1323)
错误码: 1323
含义: Windows Core Audio无播放设备警告
分类: ADM警告
平台: Windows
模块: ADM

---

# WARN_ADM_WIN_CORE_IMPROPER_CAPTURE_RELEASE (1324)
错误码: 1324
含义: Windows Core Audio不当的录制释放警告
分类: ADM警告
平台: Windows
模块: ADM

---

# WARN_ADM_WIN_CORE_CAPTURE_ABNORMAL (1325)
错误码: 1325
含义: Windows Core Audio录制异常警告
分类: ADM警告
平台: Windows
模块: ADM

---

# WARN_ADM_WIN_CORE_CAPTURE_CHANNEL_MASK (1326)
错误码: 1326
含义: Windows Core Audio录制通道掩码警告
分类: ADM警告
平台: Windows
模块: ADM

---

# WARN_ADM_WIN_CORE_RENDER_CHANNEL_MASK (1327)
错误码: 1327
含义: Windows Core Audio渲染通道掩码警告
分类: ADM警告
平台: Windows
模块: ADM

---

# WARN_ADM_WIN_CORE_CAPTURE_CHANNEL_MASK_CENTER (1328)
错误码: 1328
含义: Windows Core Audio录制通道掩码中心警告
分类: ADM警告
平台: Windows
模块: ADM

---

# WARN_ADM_WIN_CORE_CAPTURE_CHANNEL_MASK_ZERO (1329)
错误码: 1329
含义: Windows Core Audio录制通道掩码为零警告
分类: ADM警告
平台: Windows
模块: ADM

---

# WARN_ADM_WIN_CORE_CAPTURE_CHANNEL_MASK_NONE (1330)
错误码: 1330
含义: Windows Core Audio录制通道掩码为空警告
分类: ADM警告
平台: Windows
模块: ADM

---

# WARN_ADM_WIN_CORE_SILENT_MIN_VOLUME (1333)
错误码: 1333
含义: Windows Core Audio静音最小音量警告
分类: ADM警告
平台: Windows
模块: ADM

---

# WARN_ADM_WIN_CORE_RECORDING_DEVICE_INVALID (1334)
错误码: 1334
含义: Windows Core Audio录音设备无效警告
分类: ADM警告
平台: Windows
模块: ADM

---

# WARN_ADM_WIN_CORE_PLAYOUT_DEVICE_INVALID (1335)
错误码: 1335
含义: Windows Core Audio播放设备无效警告
分类: ADM警告
平台: Windows
模块: ADM

---

# WARN_SUPER_RESOLUTION_STREAM_OVER_LIMITATION (1610)
错误码: 1610
含义: 原始流过度约束无法应用超分辨率警告
分类: 超分辨率警告

---

# WARN_SUPER_RESOLUTION_USER_COUNT_OVER_LIMITATION (1611)
错误码: 1611
含义: 指定超分辨率的远程用户数超过最大支持数警告
分类: 超分辨率警告

---

# WARN_SUPER_RESOLUTION_DEVICE_NOT_SUPPORTED (1612)
错误码: 1612
含义: 设备不支持超分辨率警告
分类: 超分辨率警告

---