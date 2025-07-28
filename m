Return-Path: <linux-kernel+bounces-747396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E58B1334D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0996C17020C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940B1F1505;
	Mon, 28 Jul 2025 03:05:21 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4149478;
	Mon, 28 Jul 2025 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753671921; cv=none; b=PdBdmy3qjc7ZOjeYLdc1IovLdNDm/5A/q/1l3ootMwfdyQyD8PcurS3he1F1yyYzan3EfkruuanjKwWqg80eq3j3OluqkkMZGVq2ddu7oc2PUq1vDI5D0l77TEywezyGPi44uKF+24TzaiLK5q7KMSiWvdASpMo75Y3Ot8zXoNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753671921; c=relaxed/simple;
	bh=XH8B0+X1ZXQh8y+eGIisvazrp6k9ZmAg0j8+f38JWMQ=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=FsAuOEWx8+FQOF7VLpGtuhD+jvNruQUcuOZ7iWQbPXMf4iVnnOR5P1GZv81NiU9ovRMxbT3qyiYe/1wdFbn2MJkLftpLSuLqehZJrEWBFR0CJyHVR/oBIHnWV0sSp8BGn6qrTjSXc7CRdfanDycSf/7s42GayltJ0UnFJ2DaNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4br3Hv0RyCz8Xs7W;
	Mon, 28 Jul 2025 11:05:15 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 56S34sKQ059337;
	Mon, 28 Jul 2025 11:04:54 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 28 Jul 2025 11:04:55 +0800 (CST)
Date: Mon, 28 Jul 2025 11:04:55 +0800 (CST)
X-Zmail-TransId: 2afc6886e8d7ffffffffe66-d3799
X-Mailer: Zmail v1.0
Message-ID: <20250728110455218YMoNSSMWFXr2UW0plwvDE@zte.com.cn>
In-Reply-To: <20250728105611902ENzYOxJcTdsXoAd-8dSZi@zte.com.cn>
References: 20250728105611902ENzYOxJcTdsXoAd-8dSZi@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <shao.mingyin@zte.com.cn>
Cc: <alexs@kernel.org>, <si.yanteng@linux.dev>, <dzm91@hust.edu.cn>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <yang.tao172@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYyIDMvNV0gRG9jcy96aF9DTjogVHJhbnNsYXRlIGdmczIucnN0IHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56S34sKQ059337
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Mon, 28 Jul 2025 11:05:15 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6886E8EB.000/4br3Hv0RyCz8Xs7W

From: Shao Mingyin <shao.mingyin@zte.com.cn>

translate the "gfs2.rst" into Simplified Chinese.

Update to commit d9593868cd58("Documentation: Update
filesystems/gfs2.rst")

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
Signed-off-by: yang tao <yang.tao172@zte.com.cn>
---
v1->v2
send patches of one patchset in the same thread.
 .../translations/zh_CN/filesystems/gfs2.rst   | 57 +++++++++++++++++++
 .../translations/zh_CN/filesystems/index.rst  |  1 +
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2.rst

diff --git a/Documentation/translations/zh_CN/filesystems/gfs2.rst b/Documentation/translations/zh_CN/filesystems/gfs2.rst
new file mode 100644
index 000000000000..301a6af257b1
--- /dev/null
+++ b/Documentation/translations/zh_CN/filesystems/gfs2.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/filesystems/gfs2.rst
+
+:翻译:
+
+ 邵明寅 Shao Mingyin <shao.mingyin@zte.com.cn>
+
+:校译:
+
+ - 杨涛 yang tao <yang.tao172@zte.com.cn>
+
+=====================================
+全局文件系统 2 (Global File System 2)
+=====================================
+
+GFS2 是一个集群文件系统。它允许一组计算机同时使用在它们之间共享的块设备（通
+过 FC、iSCSI、NBD 等）。GFS2 像本地文件系统一样读写块设备，但也使用一个锁
+模块来让计算机协调它们的 I/O 操作，从而维护文件系统的一致性。GFS2 的出色特
+性之一是完美一致性——在一台机器上对文件系统所做的更改会立即显示在集群中的所
+有其他机器上。
+
+GFS2 使用可互换的节点间锁定机制，当前支持的机制有：
+
+  lock_nolock
+    - 允许将 GFS2 用作本地文件系统
+
+  lock_dlm
+    - 使用分布式锁管理器 (dlm) 进行节点间锁定。
+      该 dlm 位于 linux/fs/dlm/
+
+lock_dlm 依赖于在上述 URL 中找到的用户空间集群管理系统。
+
+若要将 GFS2 用作本地文件系统，则不需要外部集群系统，只需：:
+
+  $ mkfs -t gfs2 -p lock_nolock -j 1 /dev/block_device
+  $ mount -t gfs2 /dev/block_device /dir
+
+在所有集群节点上都需要安装 gfs2-utils 软件包；对于 lock_dlm，您还需要按
+照文档配置 dlm 和 corosync 用户空间工具。
+
+gfs2-utils 可在 https://pagure.io/gfs2-utils  找到。
+
+GFS2 在磁盘格式上与早期版本的 GFS 不兼容，但它已相当接近。
+
+以下手册页 (man pages) 可在 gfs2-utils 中找到：
+
+  ============          =============================================
+  fsck.gfs2		用于修复文件系统
+  gfs2_grow		用于在线扩展文件系统
+  gfs2_jadd		用于在线向文件系统添加日志
+  tunegfs2		用于操作、检查和调优文件系统
+  gfs2_convert		用于将 gfs 文件系统原地转换为 GFS2
+  mkfs.gfs2		用于创建文件系统
+  ============          =============================================
diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
index 3c25b39739db..37968fb91f1a 100644
--- a/Documentation/translations/zh_CN/filesystems/index.rst
+++ b/Documentation/translations/zh_CN/filesystems/index.rst
@@ -28,4 +28,5 @@ Linux Kernel中的文件系统
    tmpfs
    ubifs
    ubifs-authentication
+   gfs2

-- 
2.25.1

