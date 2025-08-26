Return-Path: <linux-kernel+bounces-786523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 079FAB35AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480BA360CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747B2335BC8;
	Tue, 26 Aug 2025 11:13:21 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B28334392;
	Tue, 26 Aug 2025 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206800; cv=none; b=LColrl/xcSP+hrXeA3VDiCPSiDCPbYBMg//roY1rYMKFhwefSox1XwulyIQEc2AbAzTTUHzajYPhiItjqQ90kIcJlrMg3vwkfLa586DtiOQTWK3ta5bAgxyHbZrM1oX1LsWbJ/9qBMvhEUHWpT1Jw4vfZe0dGwkefTFpk/sEveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206800; c=relaxed/simple;
	bh=hx3VjNm9hL5Re325Q2m1xUtHFv297j/64xIFFRrsAu4=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=ri8bnmfxfdQUkcQEp30O3hJVxK5yCKRLHI3b4piHPQcFiekubJ3icaVWGC+PW3/9aNYh/g6II0pjjorO5j95sdTDBYocQbGngkgqyzXa2Ip+5e4d1GpPyU1uFY7AslppWr9H6wmQXydltDreu7Tazo63oBbZhqVeg/1yTUGvzYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cB4lc25CLz6G4T5;
	Tue, 26 Aug 2025 19:13:16 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 57QB4T1B019077;
	Tue, 26 Aug 2025 19:04:29 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 26 Aug 2025 19:04:32 +0800 (CST)
Date: Tue, 26 Aug 2025 19:04:32 +0800 (CST)
X-Zmail-TransId: 2afa68ad94c01d5-b522e
X-Mailer: Zmail v1.0
Message-ID: <20250826190432466GaTpnjTc3gxpU-_9GwAkj@zte.com.cn>
In-Reply-To: <20250826185643235jApHbqi4zaPaZWVy6_Pot@zte.com.cn>
References: 20250826185643235jApHbqi4zaPaZWVy6_Pot@zte.com.cn
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
        <xu.xin16@zte.com.cn>, <yang.tao172@zte.com.cn>,
        <wang.longjie1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY0IDMvN10gRG9jcy96aF9DTjogVHJhbnNsYXRlIGdmczIucnN0IHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 57QB4T1B019077
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 26 Aug 2025 19:13:16 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68AD96CC.001/4cB4lc25CLz6G4T5

From: Shao Mingyin <shao.mingyin@zte.com.cn>

translate the "gfs2.rst" into Simplified Chinese.

Update to commit d9593868cd58("Documentation: Update
filesystems/gfs2.rst")

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
Signed-off-by: yang tao <yang.tao172@zte.com.cn>
---
v3->v4
resolve patch damage issues.
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
@@ -28,3 +28,4 @@ Linux Kernel中的文件系统
    tmpfs
    ubifs
    ubifs-authentication
+   gfs2
-- 
2.25.1

