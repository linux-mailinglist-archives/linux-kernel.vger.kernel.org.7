Return-Path: <linux-kernel+bounces-768782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55AFB26563
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD009E5F91
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4E02FE048;
	Thu, 14 Aug 2025 12:30:05 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46D62E092F;
	Thu, 14 Aug 2025 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174605; cv=none; b=p167jwvNV0/wqUxsve334037ZSGewdoE2qJ9YUu7o0O1sdfppEuUs0Hz15wkGWTBXkEt0azdupSFdQIgVhdV6gKpK34hHUuiHsmqVWY/McKGLQ6uqqoUpGD2apWFzeYOICGA+mxoUUaXuC/eonwWXr7qR9dlkOkeGOBBleaeQsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174605; c=relaxed/simple;
	bh=4w02E6L5Dsl+ZRIQtNdLdc9+YnIkJwTkXIMWY2Vbx9w=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=X7NTnq7yDBX9FHWCVTRX2XXDYICSBdUU8safmzgSY1NrqDHToZrMA6+rnxdxtBCKliG9eoN0N4XMwVIWMUdQmgb152luil1LBz1Pdt+qo8cH9a8AsLG5skpc5oGeVcLZS6xemfbEmay7kzfK8Aj+kYzhlrZ4Ux6ydFc10Acy5T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4c2l1h6qsbz5Mfgp;
	Thu, 14 Aug 2025 20:30:00 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 57ECTllj093547;
	Thu, 14 Aug 2025 20:29:47 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 14 Aug 2025 20:29:50 +0800 (CST)
Date: Thu, 14 Aug 2025 20:29:50 +0800 (CST)
X-Zmail-TransId: 2afb689dd6beffffffff849-53c5b
X-Mailer: Zmail v1.0
Message-ID: <20250814202950722BAA5h4UtC6XyB2C5YA2pe@zte.com.cn>
In-Reply-To: <20250814201129510XielEwRpr4QXPx_XBtkhv@zte.com.cn>
References: 20250814201129510XielEwRpr4QXPx_XBtkhv@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yaxin@zte.com.cn>
To: <wang.yaxin@zte.com.cn>
Cc: <alexs@kernel.org>, <si.yanteng@linux.dev>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>, <fan.yu9@zte.com.cn>,
        <he.peilin@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <zhang.yunkai@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDMvNCB2Ml0gRG9jcy96aF9DTjogVHJhbnNsYXRlIGdlbmVyaWMtaGRsYy5yc3QgdG8gU2ltcGxpZmllZCBDaGluZXNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 57ECTllj093547
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Thu, 14 Aug 2025 20:30:00 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 689DD6C8.002/4c2l1h6qsbz5Mfgp

From: Sun yuxi <sun.yuxi@zte.com.cn>

translate the "generic-hdlc.rst" into Simplified Chinese.

Update the translation through commit 16128ad8f927
("docs: networking: convert generic-hdlc.txt to ReST")

Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
Signed-off-by: Sun yuxi <sun.yuxi@zte.com.cn>
---
 .../zh_CN/networking/generic-hdlc.rst         | 176 ++++++++++++++++++
 .../translations/zh_CN/networking/index.rst   |   2 +-
 2 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/networking/generic-hdlc.rst

diff --git a/Documentation/translations/zh_CN/networking/generic-hdlc.rst b/Documentation/translations/zh_CN/networking/generic-hdlc.rst
new file mode 100644
index 000000000000..9e493dc9721e
--- /dev/null
+++ b/Documentation/translations/zh_CN/networking/generic-hdlc.rst
@@ -0,0 +1,176 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/networking/generic-hdlc.rst
+
+:翻译:
+
+   孙渔喜 Sun yuxi <sun.yuxi@zte.com.cn>
+
+==========
+通用HDLC层
+==========
+
+Krzysztof Halasa <khc@pm.waw.pl>
+
+
+通用HDLC层当前支持以下协议:
+
+1. 帧中继（支持ANSI、CCITT、Cisco及无LMI模式）
+
+   - 常规（路由）接口和以太网桥接（以太网设备仿真）接口
+     可共享同一条PVC。
+   - 支持ARP（内核暂不支持InARP，但可通过实验性用户空间守护程序实现，
+     下载地址：http://www.kernel.org/pub/linux/utils/net/hdlc/）。
+
+2. 原始HDLC —— 支持IP（IPv4）接口或以太网设备仿真
+3. Cisco HDLC
+4. PPP
+5. X.25（使用X.25协议栈）
+
+通用HDLC仅作为协议驱动 - 必须配合具体硬件的底层驱动
+才能运行。
+
+以太网设备仿真（使用HDLC或帧中继PVC）兼容IEEE 802.1Q（VLAN）和
+802.1D（以太网桥接）。
+
+
+请确保已加载 hdlc.o 和硬件驱动程序。系统将为每个WAN端口创建一个
+"hdlc"网络设备（如hdlc0等）。您需要使用"sethdlc"工具，可从以下
+地址获取：
+
+	http://www.kernel.org/pub/linux/utils/net/hdlc/
+
+编译 sethdlc.c 工具::
+
+	gcc -O2 -Wall -o sethdlc sethdlc.c
+
+请确保使用与您内核版本匹配的 sethdlc 工具。
+
+使用 sethdlc 工具设置物理接口、时钟频率、HDLC 模式，
+若使用帧中继还需添加所需的 PVC。
+通常您需要执行类似以下命令::
+
+	sethdlc hdlc0 clock int rate 128000
+	sethdlc hdlc0 cisco interval 10 timeout 25
+
+或::
+
+	sethdlc hdlc0 rs232 clock ext
+	sethdlc hdlc0 fr lmi ansi
+	sethdlc hdlc0 create 99
+	ifconfig hdlc0 up
+	ifconfig pvc0 localIP pointopoint remoteIP
+
+在帧中继模式下，请先启用主hdlc设备（不分配IP地址），再
+使用pvc设备。
+
+
+接口设置选项：
+
+* v35 | rs232 | x21 | t1 | e1
+    - 当网卡支持软件可选接口时，可为指定端口设置物理接口
+  loopback
+    - 启用硬件环回（仅用于测试）
+* clock ext
+    - RX与TX时钟均使用外部时钟源
+* clock int
+    - RX与TX时钟均使用内部时钟源
+* clock txint
+    - RX时钟使用外部时钟源，TX时钟使用内部时钟源
+* clock txfromrx
+    - RX时钟使用外部时钟源，TX时钟从RX时钟派生
+* rate
+    - 设置时钟速率（仅适用于"int"或"txint"时钟模式）
+
+
+设置协议选项：
+
+* hdlc - 设置原始HDLC模式（仅支持IP协议）
+
+  nrz / nrzi / fm-mark / fm-space / manchester - 传输编码选项
+
+  no-parity / crc16 / crc16-pr0 (预设零值的CRC16) / crc32-itu
+
+  crc16-itu (使用ITU-T多项式的CRC16) / crc16-itu-pr0 - 校验方式选项
+
+* hdlc-eth - 使用HDLC进行以太网设备仿真. 校验和编码方式同上
+  as above.
+
+* cisco - 设置Cisco HDLC模式（支持IP、IPv6和IPX协议）
+
+  interval - 保活数据包发送间隔（秒）
+
+  timeout - 未收到保活数据包的超时时间（秒），超过此时长将判定
+	    链路断开
+
+* ppp - 设置同步PPP模式
+
+* x25 - 设置X.25模式
+
+* fr - 帧中继模式
+
+  lmi ansi / ccitt / cisco / none - LMI(链路管理)类型
+
+  dce - 将帧中继设置为DCE（网络侧）LMI模式（默认为DTE用户侧）。
+
+  此设置与时钟无关！
+
+  - t391 - 链路完整性验证轮询定时器（秒）- 用户侧
+  - t392 - 轮询验证定时器（秒）- 网络侧
+  - n391 - 全状态轮询计数器 - 用户侧
+  - n392 - 错误阈值 - 用户侧和网络侧共用
+  - n393 - 监控事件计数 - 用户侧和网络侧共用
+
+帧中继专用命令:
+
+* create n | delete n - 添加/删除DLCI编号为n的PVC接口。
+  新创建的接口将命名为pvc0、pvc1等。
+
+* create ether n | delete ether n - 添加/删除用于以太网
+  桥接帧的设备设备将命名为pvceth0、pvceth1等。
+
+
+
+
+板卡特定问题
+------------
+
+n2.o 和 c101.o 驱动模块需要参数才能工作::
+
+	insmod n2 hw=io,irq,ram,ports[:io,irq,...]
+
+示例::
+
+	insmod n2 hw=0x300,10,0xD0000,01
+
+或::
+
+	insmod c101 hw=irq,ram[:irq,...]
+
+示例::
+
+	insmod c101 hw=9,0xdc000
+
+若直接编译进内核，这些驱动需要通过内核(命令行)参数配置::
+
+	n2.hw=io,irq,ram,ports:...
+
+或::
+
+	c101.hw=irq,ram:...
+
+
+
+若您的N2、C101或PLX200SYN板卡出现问题，可通过"private"
+命令查看端口数据包描述符环（显示在内核日志中）
+
+	sethdlc hdlc0 private
+
+硬件驱动需使用#define DEBUG_RINGS编译选项构建。
+在提交错误报告时附上这些信息将很有帮助。如在使用过程中遇
+到任何问题，请随时告知。
+
+获取补丁和其他信息，请访问：
+<http://www.kernel.org/pub/linux/utils/net/hdlc/>.
\ No newline at end of file
diff --git a/Documentation/translations/zh_CN/networking/index.rst b/Documentation/translations/zh_CN/networking/index.rst
index e03b5d5d39ee..e0494346fa8c 100644
--- a/Documentation/translations/zh_CN/networking/index.rst
+++ b/Documentation/translations/zh_CN/networking/index.rst
@@ -29,6 +29,7 @@
    alias
    mptcp-sysctl
    skbuff
+   generic-hdlc

 Todolist:

@@ -78,7 +79,6 @@ Todolist:
 *   eql
 *   fib_trie
 *   filter
-*   generic-hdlc
 *   generic_netlink
 *   netlink_spec/index
 *   gen_stats
-- 
2.25.1

