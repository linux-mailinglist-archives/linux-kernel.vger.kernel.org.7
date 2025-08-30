Return-Path: <linux-kernel+bounces-792833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24855B3C98E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B953B2A2D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 08:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8596A2522A8;
	Sat, 30 Aug 2025 08:58:39 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECF3C2EF;
	Sat, 30 Aug 2025 08:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756544319; cv=none; b=AlZsc9eg5XLvwwQC2pWWSDbvJm/u/W6hn8P5Cj7NqECGcXNMfw6tcmz4+bkNGHUkyKziImkUJhV9mMDoYKKE9ObZSDN//nfa7xIzz4lH8T8Fw/uS8+7zn6qdwR/2ojG80huu1Aw8q7gLO4ZGPOriVxa/N9ffOVNGSe9n3/gnXZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756544319; c=relaxed/simple;
	bh=PA84nX4l0f38mDFbwbHe5PP7Ik1oQfWB+wP05jwozY0=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=a7Vy3H9RmuIy8Buqwf8LtRcVfexY3fQ7I++AKbg52f2NYZvZ5rsHWW+pPDMi7jQy3EH9ZFUw44opbiD7xWk3nQ/1mfIb2UiAHeVNqd7qaRtrWQrKoywFftVjUsY/tfzxCx37MzwA43JY94ZZB/Nk0AYw096OOdX2yI/KkAopFAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cDTZD297fz5BNRd;
	Sat, 30 Aug 2025 16:58:28 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 57U8wG4H060376;
	Sat, 30 Aug 2025 16:58:16 +0800 (+08)
	(envelope-from wang.yaxin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 30 Aug 2025 16:58:18 +0800 (CST)
Date: Sat, 30 Aug 2025 16:58:18 +0800 (CST)
X-Zmail-TransId: 2afa68b2bd2aae2-05402
X-Mailer: Zmail v1.0
Message-ID: <20250830165818597ycQqMyAK7UIDMwrEArw1C@zte.com.cn>
In-Reply-To: <2025083016571123360dlV3pxVqfCY35MOQnma@zte.com.cn>
References: 2025083016571123360dlV3pxVqfCY35MOQnma@zte.com.cn
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
        <qiu.yutan@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDEvNCB2M10gRG9jcy96aF9DTjogVHJhbnNsYXRlIG1wdGNwLXN5c2N0bC5yc3QgdG8gU2ltcGxpZmllZCBDaGluZXNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 57U8wG4H060376
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yaxin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Sat, 30 Aug 2025 16:58:28 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B2BD34.000/4cDTZD297fz5BNRd

From: Sun yuxi <sun.yuxi@zte.com.cn>

translate the "mptcp-sysctl.rst" into Simplified Chinese.

Update the translation through commit fa3ee9dd8067
("mptcp: sysctl: add available_path_managers")

Signed-off-by: Sun yuxi <sun.yuxi@zte.com.cn>
---
v2->v3:
1. add reviewer tag

 .../translations/zh_CN/networking/index.rst   |   2 +-
 .../zh_CN/networking/mptcp-sysctl.rst         | 139 ++++++++++++++++++
 2 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/networking/mptcp-sysctl.rst

diff --git a/Documentation/translations/zh_CN/networking/index.rst b/Documentation/translations/zh_CN/networking/index.rst
index bb0edcffd144..6e1c1df4a980 100644
--- a/Documentation/translations/zh_CN/networking/index.rst
+++ b/Documentation/translations/zh_CN/networking/index.rst
@@ -27,6 +27,7 @@
    xfrm_proc
    netmem
    alias
+   mptcp-sysctl

 Todolist:

@@ -96,7 +97,6 @@ Todolist:
 *   mctp
 *   mpls-sysctl
 *   mptcp
-*   mptcp-sysctl
 *   multiqueue
 *   multi-pf-netdev
 *   net_cachelines/index
diff --git a/Documentation/translations/zh_CN/networking/mptcp-sysctl.rst b/Documentation/translations/zh_CN/networking/mptcp-sysctl.rst
new file mode 100644
index 000000000000..0b1b9ed7c647
--- /dev/null
+++ b/Documentation/translations/zh_CN/networking/mptcp-sysctl.rst
@@ -0,0 +1,139 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/networking/mptcp-sysctl.rst
+
+:翻译:
+
+   孙渔喜 Sun yuxi <sun.yuxi@zte.com.cn>
+
+================
+MPTCP Sysfs 变量
+================
+
+/proc/sys/net/mptcp/* Variables
+===============================
+
+add_addr_timeout - INTEGER (秒)
+	设置ADD_ADDR控制消息的重传超时时间。当MPTCP对端未确认
+	先前的ADD_ADDR消息时，将在该超时时间后重新发送。
+
+	默认值与TCP_RTO_MAX相同。此为每个命名空间的sysctl参数。
+
+	默认值：120
+
+allow_join_initial_addr_port - BOOLEAN
+	控制是否允许对端向初始子流使用的IP地址和端口号发送加入
+	请求（1表示允许）。此参数会设置连接时发送给对端的标志位，
+	并决定是否接受此类加入请求。
+
+	通过ADD_ADDR通告的地址不受此参数影响。
+
+	此为每个命名空间的sysctl参数。
+
+	默认值：1
+
+available_path_managers - STRING
+	显示已注册的可用路径管理器选项。可能有更多路径管理器可用
+	但尚未加载。
+
+available_schedulers - STRING
+	显示已注册的可用调度器选项。可能有更多数据包调度器可用
+	但尚未加载。
+
+blackhole_timeout - INTEGER (秒)
+	当发生MPTCP防火墙黑洞问题时，初始禁用活跃MPTCP套接字上MPTCP
+	功能的时间（秒）。如果在重新启用MPTCP后立即检测到更多黑洞问题，
+	此时间段将呈指数增长；当黑洞问题消失时，将重置为初始值。
+
+	设置为0可禁用黑洞检测功能。此为每个命名空间的sysctl参数。
+
+	默认值：3600
+
+checksum_enabled - BOOLEAN
+	控制是否启用DSS校验和功能。
+
+	当值为非零时可启用DSS校验和。此为每个命名空间的sysctl参数。
+
+	默认值：0
+
+close_timeout - INTEGER (seconds)
+	设置"先断后连"超时时间：在未调用close或shutdown系统调用时，
+	MPTCP套接字将在最后一个子流移除后保持当前状态达到该时长，才
+	会转为TCP_CLOSE状态。
+
+	默认值与TCP_TIMEWAIT_LEN相同。此为每个命名空间的sysctl参数。
+
+	默认值：60
+
+enabled - BOOLEAN
+	控制是否允许创建MPTCP套接字。
+
+	当值为1时允许创建MPTCP套接字。此为每个命名空间的sysctl参数。
+
+	默认值：1（启用）
+
+path_manager - STRING
+	设置用于每个新MPTCP套接字的默认路径管理器名称。内核路径管理将
+	根据通过MPTCP netlink API配置的每个命名空间值来控制子流连接
+	和地址通告。用户空间路径管理将每个MPTCP连接的子流连接决策和地
+	址通告交由特权用户空间程序控制，代价是需要更多netlink流量来
+	传播所有相关事件和命令。
+
+	此为每个命名空间的sysctl参数。
+
+	* "kernel"		  - 内核路径管理器
+	* "userspace"	   - 用户空间路径管理器
+
+	默认值："kernel"
+
+pm_type - INTEGER
+	设置用于每个新MPTCP套接字的默认路径管理器类型。内核路径管理将
+	根据通过MPTCP netlink API配置的每个命名空间值来控制子流连接
+	和地址通告。用户空间路径管理将每个MPTCP连接的子流连接决策和地
+	址通告交由特权用户空间程序控制，代价是需要更多netlink流量来
+	传播所有相关事件和命令。
+
+	此为每个命名空间的sysctl参数。
+
+	自v6.15起已弃用，请改用path_manager参数。
+
+	* 0 - 内核路径管理器
+	* 1 - 用户空间路径管理器
+
+	默认值：0
+
+scheduler - STRING
+	选择所需的调度器类型。
+
+	支持选择不同的数据包调度器。此为每个命名空间的sysctl参数。
+
+	默认值："default"
+
+stale_loss_cnt - INTEGER
+	用于判定子流失效（stale）的MPTCP层重传间隔次数阈值。当指定
+	子流在连续多个重传间隔内既无数据传输又有待处理数据时，将被标
+	记为失效状态。失效子流将被数据包调度器忽略。
+	设置较低的stale_loss_cnt值可实现快速主备切换，较高的值则能
+	最大化边缘场景（如高误码率链路或对端暂停数据处理等异常情况）
+	的链路利用率。
+
+	此为每个命名空间的sysctl参数。
+
+	默认值：4
+
+syn_retrans_before_tcp_fallback - INTEGER
+	在回退到 TCP（即丢弃 MPTCP 选项）之前，SYN + MP_CAPABLE
+	报文的重传次数。换句话说，如果所有报文在传输过程中都被丢弃，
+	那么将会：
+
+	* 首次SYN携带MPTCP支持选项
+	* 按本参数值重传携带MPTCP选项的SYN包
+	* 后续重传将不再携带MPTCP支持选项
+
+	0 表示首次重传即丢弃MPTCP选项。
+	>=128 表示所有SYN重传均保留MPTCP选项设置过低的值可能增加
+	MPTCP黑洞误判几率。此为每个命名空间的sysctl参数。
+
+	默认值：2
-- 
2.25.1

