Return-Path: <linux-kernel+bounces-830209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A71B99100
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D308319C6927
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D038E2D6619;
	Wed, 24 Sep 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="Cr5PzZ0e"
Received: from mail-m49216.qiye.163.com (mail-m49216.qiye.163.com [45.254.49.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4EB2D6E52;
	Wed, 24 Sep 2025 09:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705538; cv=none; b=o+fwmc/BVW63bJ1m2IdgyeKhQ20zpySTrRwD8BIMxHQYAlLEsWuoDftw8d2jno+dprF/bHP1acZ8yjpKBfmVkcqLZjDekqhLWAXfEDTTguvSA3slcSfKRJjGCSzNpuuXBtm6U64dl8siXJuZPy7Jq7iyV89TvbrU3MgYuI3pTQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705538; c=relaxed/simple;
	bh=asByUnYndxGWQSTcN6eJ9nWYjGYh8kqbP7hJ6jPn6EA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eZIuQL4Drpmkbr6NLAhdW/vhoL7qp3OMb0gRiN94WsapwAtp+QJvSN2IwCU3EfmU87CGQSE2yMLFFBFFmlv5lJOnErCOM8vPddto9US7IOe9IgUdljUX7uzqBTtb2N1HnbNkdCjm83gduO3GK7MkJlud7za/IMtChi8S3rUUfZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=Cr5PzZ0e; arc=none smtp.client-ip=45.254.49.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Received: from fedora.localdomain (unknown [123.53.39.124])
	by smtp.qiye.163.com (Hmail) with ESMTP id 23e5d25cb;
	Wed, 24 Sep 2025 16:43:19 +0800 (GMT+08:00)
From: Shuo Zhao <zhaoshuo@cqsoftware.com.cn>
To: alexs@kernel.org,
	si.yanteng@linux.dev,
	corbet@lwn.net
Cc: dzm91@hust.edu.cn,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuo Zhao <zhaoshuo@cqsoftware.com.cn>
Subject: [PATCH v2] docs/zh_CN: Add security SCTP Chinese translation
Date: Wed, 24 Sep 2025 16:43:16 +0800
Message-ID: <20250924084317.49051-1-zhaoshuo@cqsoftware.com.cn>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a997ae430ab09d0kunm3c84dfde5e427d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZQh8eVk8ZHhlCH0tOH0lISFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSUhVTkhVSEJVSklPWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=Cr5PzZ0eg5LMrUJOeg7Nl65Wp6Bk+48N7dK82nX0S/llZDdLJfEPA6Q1L0LcKoUzgZkWEi+po4i2qEqn0LK+j/gqndG/1+QhJfPTm/DjECLcZoK5qlsnGn9Y4N2qrKm0ipXp1Wss7G+aJh928cBOKSE5ZEvrdkeMS3NnpJsQo2Y=; c=relaxed/relaxed; s=default; d=cqsoftware.com.cn; v=1;
	bh=QE5oBSSJlGhEhN/DAzjtRwRdpPP9y8WFG4x8Hb19bjo=;
	h=date:mime-version:subject:message-id:from;

Translate .../security/SCTP.rst into Chinese.

Update the translation through commit da51bbcdbace
("Docs: typos/spelling")

Signed-off-by: Shuo Zhao <zhaoshuo@cqsoftware.com.cn>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>
---

v2:

Add reviewer Yanteng Si.

 .../translations/zh_CN/security/SCTP.rst      | 317 ++++++++++++++++++
 .../translations/zh_CN/security/index.rst     |   2 +-
 2 files changed, 318 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/security/SCTP.rst

diff --git a/Documentation/translations/zh_CN/security/SCTP.rst b/Documentation/translations/zh_CN/security/SCTP.rst
new file mode 100644
index 000000000000..f2774b0d66b5
--- /dev/null
+++ b/Documentation/translations/zh_CN/security/SCTP.rst
@@ -0,0 +1,317 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/security/SCTP.rst
+
+:翻译:
+ 赵硕 Shuo Zhao <zhaoshuo@cqsoftware.com.cn>
+
+====
+SCTP
+====
+
+SCTP的LSM支持
+=============
+
+安全钩子
+--------
+
+对于安全模块支持，已经实现了三个特定于SCTP的钩子::
+
+	security_sctp_assoc_request()
+	security_sctp_bind_connect()
+	security_sctp_sk_clone()
+	security_sctp_assoc_established()
+
+这些钩子的用法在下面的 `SCTP的SELinux支持`_ 一章中描述SELinux的实现。
+
+
+security_sctp_assoc_request()
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+将关联INIT数据包的 ``@asoc`` 和 ``@chunk->skb`` 传递给安全模块。
+成功时返回 0，失败时返回错误。
+::
+
+	@asoc - 指向sctp关联结构的指针。
+	@skb - 指向包含关联数据包skbuff的指针。
+
+
+security_sctp_bind_connect()
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+将一个或多个IPv4/IPv6地址传递给安全模块进行基于 ``@optname`` 的验证，
+这将导致是绑定还是连接服务，如下面的权限检查表所示。成功时返回 0，失败
+时返回错误。
+::
+
+	@sk      - 指向sock结构的指针。
+	@optname - 需要验证的选项名称。
+	@address - 一个或多个IPv4 / IPv6地址。
+	@addrlen - 地址的总长度。使用sizeof(struct sockaddr_in)或
+			   sizeof(struct sockaddr_in6)来计算每个ipv4或ipv6地址。
+
+  ------------------------------------------------------------------
+  |                     BIND 类型检查                               |
+  |       @optname             |         @address contains         |
+  |----------------------------|-----------------------------------|
+  | SCTP_SOCKOPT_BINDX_ADD     | 一个或多个 ipv4 / ipv6 地址         |
+  | SCTP_PRIMARY_ADDR          | 单个 ipv4 or ipv6 地址             |
+  | SCTP_SET_PEER_PRIMARY_ADDR | 单个 ipv4 or ipv6 地址             |
+  ------------------------------------------------------------------
+
+  ------------------------------------------------------------------
+  |                   CONNECT 类型检查                              |
+  |       @optname             |         @address contains         |
+  |----------------------------|-----------------------------------|
+  | SCTP_SOCKOPT_CONNECTX      | 一个或多个 ipv4 / ipv6 地址         |
+  | SCTP_PARAM_ADD_IP          | 一个或多个 ipv4 / ipv6 地址         |
+  | SCTP_SENDMSG_CONNECT       | 单个 ipv4 or ipv6 地址             |
+  | SCTP_PARAM_SET_PRIMARY     | 单个 ipv4 or ipv6 地址             |
+  ------------------------------------------------------------------
+
+条目 ``@optname`` 的摘要如下::
+
+	SCTP_SOCKOPT_BINDX_ADD - 允许在（可选地）调用 bind(3) 后，关联额外
+							 的绑定地址。
+							 sctp_bindx(3) 用于在套接字上添加一组绑定地址。
+
+	SCTP_SOCKOPT_CONNECTX - 允许分配多个地址以连接到对端（多宿主）。
+							sctp_connectx(3) 使用多个目标地址在SCTP
+							套接字上发起连接。
+
+	SCTP_SENDMSG_CONNECT  - 通过sendmsg(2)或sctp_sendmsg(3)在新关联上
+							发起连接。
+
+	SCTP_PRIMARY_ADDR     - 设置本地主地址。
+
+	SCTP_SET_PEER_PRIMARY_ADDR - 请求远程对端将某个地址设置为其主地址。
+
+	SCTP_PARAM_ADD_IP          - 在启用动态地址重配置时使用。
+	SCTP_PARAM_SET_PRIMARY     - 如下所述，启用重新配置功能。
+
+
+为了支持动态地址重新配置，必须在两个端点上启用以下
+参数（或使用适当的 **setsockopt**\(2)）::
+
+	/proc/sys/net/sctp/addip_enable
+	/proc/sys/net/sctp/addip_noauth_enable
+
+当相应的 ``@optname`` 存在时，以下的 *_PARAM_* 参数会
+通过ASCONF块发送到对端::
+
+		  @optname                      ASCONF Parameter
+		 ----------                    ------------------
+	SCTP_SOCKOPT_BINDX_ADD     ->   SCTP_PARAM_ADD_IP
+	SCTP_SET_PEER_PRIMARY_ADDR ->   SCTP_PARAM_SET_PRIMARY
+
+
+security_sctp_sk_clone()
+~~~~~~~~~~~~~~~~~~~~~~~~
+每当通过 **accept**\(2)创建一个新的套接字（即TCP类型的套接字），或者当
+一个套接字被‘剥离’时如用户空间调用 **sctp_peeloff**\(3)，会调用此函数。
+::
+
+	@asoc -  指向当前sctp关联结构的指针。
+	@sk - 指向当前套接字结构的指针。
+	@newsk - 指向新的套接字结构的指针。
+
+
+security_sctp_assoc_established()
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+当收到COOKIE ACK时调用，对于客户端，对端的secid将被保存
+到 ``@asoc->peer_secid`` 中::
+
+	@asoc - 指向sctp关联结构的指针。
+	@skb - 指向COOKIE ACK数据包的skbuff指针。
+
+
+用于关联建立的安全钩子
+----------------------
+
+下图展示了在建立关联时 ``security_sctp_bind_connect()``、 ``security_sctp_assoc_request()``
+和 ``security_sctp_assoc_established()`` 的使用。
+::
+
+      SCTP 端点 "A"                                 SCTP 端点 "Z"
+      =============                                 =============
+    sctp_sf_do_prm_asoc()
+ 关联的设置可以通过connect(2),
+ sctp_connectx(3),sendmsg(2)
+ or sctp_sendmsg(3)来发起。
+ 这将导致调用security_sctp_bind_connect()
+ 发起与SCTP对端端点"Z"的关联。
+         INIT --------------------------------------------->
+                                                   sctp_sf_do_5_1B_init()
+                                                 响应一个INIT数据块。
+                                             SCTP对端端点"A"正在请求一个临时关联。
+                                             如果是首次关联，调用security_sctp_assoc_request()
+                                             来设置对等方标签。
+                                             如果不是首次关联，检查是否被允许。
+                                             如果允许，则发送:
+          <----------------------------------------------- INIT ACK
+          |
+          |                                  否则，生成审计事件并默默丢弃该数据包。
+          |
+    COOKIE ECHO ------------------------------------------>
+                                                  sctp_sf_do_5_1D_ce()
+                                             响应一个COOKIE ECHO数据块。
+                                             确认该cookie并创建一个永久关联。
+                                             调用security_sctp_assoc_request()
+                                             执行与INIT数据块响应相同的操作。
+          <------------------------------------------- COOKIE ACK
+          |                                               |
+    sctp_sf_do_5_1E_ca                                    |
+ 调用security_sctp_assoc_established()                    |
+ 来设置对方标签                                           |
+          |                                               |
+          |                               如果是SCTP_SOCKET_TCP或是剥离的套接
+          |                               字，会调用 security_sctp_sk_clone()
+          |                               来克隆新的套接字。
+          |                                               |
+         建立                                            建立
+          |                                               |
+    ------------------------------------------------------------------
+    |                            关联建立                            |
+    ------------------------------------------------------------------
+
+
+SCTP的SELinux支持
+=================
+
+安全钩子
+--------
+
+上面的 `SCTP的LSM支持`_ 章节描述了以下SCTP安全钩子，SELinux的细节
+说明如下::
+
+	security_sctp_assoc_request()
+	security_sctp_bind_connect()
+	security_sctp_sk_clone()
+	security_sctp_assoc_established()
+
+
+security_sctp_assoc_request()
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+将关联INIT数据包的 ``@asoc`` 和 ``@chunk->skb`` 传递给安全模块。
+成功时返回 0，失败时返回错误。
+::
+
+    @asoc - 指向sctp关联结构的指针。
+    @skb - 指向关联数据包skbuff的指针。
+
+安全模块执行以下操作:
+	 如果这是 ``@asoc->base.sk`` 上的首次关联，则将对端的sid设置
+	 为 ``@skb`` 中的值。这将确保只有一个对端sid分配给可能支持多个
+	 关联的 ``@asoc->base.sk``。
+
+	 否则验证 ``@asoc->base.sk peer sid`` 是否与 ``@skb peer sid``
+	 匹配，以确定该关联是否应被允许或拒绝。
+
+	 将sctp的 ``@asoc sid`` 设置为套接字的sid（来自 ``asoc->base.sk``）
+	 并从 ``@skb peer sid`` 中提取MLS部分。这将在SCTP的TCP类型套接字及
+	 剥离连接中使用，因为它们会导致生成一个新的套接字。
+
+	 如果配置了IP安全选项（CIPSO/CALIPSO），则会在套接字上设置IP选项。
+
+
+security_sctp_bind_connect()
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+根据 ``@optname`` 检查ipv4/ipv6地址所需的权限，具体如下::
+
+  ------------------------------------------------------------------
+  |                      BIND 权限检查                              |
+  |       @optname             |         @address contains         |
+  |----------------------------|-----------------------------------|
+  | SCTP_SOCKOPT_BINDX_ADD     | 一个或多个 ipv4 / ipv6 地址        |
+  | SCTP_PRIMARY_ADDR          | 单个 ipv4 or ipv6 地址            |
+  | SCTP_SET_PEER_PRIMARY_ADDR | 单个 ipv4 or ipv6 地址            |
+  ------------------------------------------------------------------
+
+  ------------------------------------------------------------------
+  |                   CONNECT 权限检查                              |
+  |       @optname             |         @address contains         |
+  |----------------------------|-----------------------------------|
+  | SCTP_SOCKOPT_CONNECTX      | 一个或多个 ipv4 / ipv6 地址        |
+  | SCTP_PARAM_ADD_IP          | 一个或多个 ipv4 / ipv6 地址        |
+  | SCTP_SENDMSG_CONNECT       | 单个 ipv4 or ipv6 地址            |
+  | SCTP_PARAM_SET_PRIMARY     | 单个 ipv4 or ipv6 地址            |
+  ------------------------------------------------------------------
+
+
+`SCTP的LSM支持`_ 提供了 ``@optname`` 摘要，并且还描述了当启用动态地址重新
+配置时，ASCONF块的处理过程。
+
+
+security_sctp_sk_clone()
+~~~~~~~~~~~~~~~~~~~~~~~~
+每当通过 **accept**\(2)（即TCP类型的套接字）创建一个新的套接字，或者
+当一个套接字被“剥离”如用户空间调用 **sctp_peeloff**\(3)时，
+``security_sctp_sk_clone()`` 将会分别将新套接字的sid和对端sid设置为
+``@asoc sid`` 和 ``@asoc peer sid`` 中包含的值。
+::
+
+	@asoc - 指向当前sctp关联结构的指针。
+	@sk - 指向当前sock结构的指针。
+	@newsk - 指向新sock结构的指针。
+
+
+security_sctp_assoc_established()
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+当接收到COOKIE ACK时调用，它将连接的对端sid设置为 ``@skb`` 中的值::
+
+	@asoc - 指向sctp关联结构的指针。
+	@skb - 指向COOKIE ACK包skbuff的指针。
+
+
+策略声明
+--------
+以下支持SCTP的类和权限在内核中是可用的::
+
+	class sctp_socket inherits socket { node_bind }
+
+当启用以下策略功能时::
+
+	policycap extended_socket_class;
+
+SELinux对SCTP的支持添加了用于连接特定端口类型 ``name_connect`` 权限
+以及在下面的章节中进行解释的 ``association`` 权限。
+
+如果用户空间工具已更新，SCTP将支持如下所示的 ``portcon`` 声明::
+
+	portcon sctp 1024-1036 system_u:object_r:sctp_ports_t:s0
+
+
+SCTP对端标签
+------------
+每个SCTP套接字仅分配一个对端标签。这个标签将在建立第一个关联时分配。
+任何后续在该套接字上的关联都会将它们的数据包对端标签与套接字的对端标
+签进行比较，只有在它们不同的情况下 ``association`` 权限才会被验证。
+这是通过检查套接字的对端sid与接收到的数据包中的对端sid来验证的，以决
+定是否允许或拒绝该关联。
+
+注:
+   1) 如果对端标签未启用，则对端上下文将始终是 ``SECINITSID_UNLABELED``
+      （在策略声明中为 ``unlabeled_t`` ）。
+
+   2) 由于SCTP可以在单个套接字上支持每个端点（多宿主）的多个传输地址，因此
+      可以配置策略和NetLabel为每个端点提供不同的对端标签。由于套接字的对端
+      标签是由第一个关联的传输地址决定的，因此建议所有的对端标签保持一致。
+
+   3) 用户空间可以使用 **getpeercon**\(3) 来检索套接字的对端上下文。
+
+   4) 虽然这不是SCTP特有的，但在使用NetLabel时要注意，如果标签分配给特定的接
+      口，而该接口‘goes down’，则NetLabel服务会移除该条目。因此，请确保网络启
+      动脚本调用 **netlabelctl**\(8) 来设置所需的标签（详细信息，
+      请参阅 **netlabel-config**\(8) 辅助脚本）。
+
+   5) NetLabel SCTP对端标签规则应用如下所述标签为“netlabel”的一组帖子：
+      https://www.paul-moore.com/blog/t.
+
+   6) CIPSO仅支持IPv4地址： ``socket(AF_INET, ...)``
+      CALIPSO仅支持IPv6地址： ``socket(AF_INET6, ...)``
+
+      测试CIPSO/CALIPSO时请注意以下事项：
+         a) 如果SCTP数据包由于无效标签无法送达，CIPSO会发送一个ICMP包。
+         b) CALIPSO不会发送ICMP包，只会默默丢弃数据包。
+
+   7) RFC 3554不支持IPSEC —— SCTP/IPSEC支持尚未在用户空间实现(**racoon**\(8)
+      或 **ipsec_pluto**\(8))，尽管内核支持 SCTP/IPSEC。
diff --git a/Documentation/translations/zh_CN/security/index.rst b/Documentation/translations/zh_CN/security/index.rst
index 05d24e3acc11..d33b107405c7 100644
--- a/Documentation/translations/zh_CN/security/index.rst
+++ b/Documentation/translations/zh_CN/security/index.rst
@@ -20,6 +20,7 @@
    lsm
    lsm-development
    sak
+   SCTP
    self-protection
    siphash
    tpm/index
@@ -29,6 +30,5 @@
 TODOLIST:
 * IMA-templates
 * keys/index
-* SCTP
 * secrets/index
 * ipe
-- 
2.49.0


