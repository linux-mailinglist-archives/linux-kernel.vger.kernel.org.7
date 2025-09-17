Return-Path: <linux-kernel+bounces-819954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFF4B7CDC6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B2F32835D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA22277003;
	Wed, 17 Sep 2025 03:56:04 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE4726C3BF;
	Wed, 17 Sep 2025 03:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081364; cv=none; b=sGyZBTw6W3IfWuJnvJX2F9AWFMxNRLmzW1UyxPQ3f/Zel8MsgaXjS0vortLBecSX4bjZiLWHeIhUHWEJSRhFBop2dRqJdMGRKs/Jl4y8YYnW+sxODAhoWTNIpQ6hBORWmrfhkbCyQQaZw7ZMYOCh0LKlZHsm7ht20RMJZv9DhdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081364; c=relaxed/simple;
	bh=LEZzt4a25XPChqm3OjWcAHOCfOllpYJUgz7ItNqgkXE=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=dgCFCswz7N0JstAF8CrmPd+m3GmAB17gvHX1eAxs1Wwy9XbEP8F6BaP75SEwz6ArKo2e7kerfx0s8KJJJc0aPX1XNcCwQtQzduSrD0nBAFiI/OwHnLlFlmCqYyF+jgIuHlMgfDrOFkvCF46FDIfYqRVXtvECPSaejpGrH+Nz+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cRQ0t3YDnz5B13w;
	Wed, 17 Sep 2025 11:55:58 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 58H3tLO1042496;
	Wed, 17 Sep 2025 11:55:21 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 17 Sep 2025 11:55:22 +0800 (CST)
Date: Wed, 17 Sep 2025 11:55:22 +0800 (CST)
X-Zmail-TransId: 2afb68ca312aad0-e9f69
X-Mailer: Zmail v1.0
Message-ID: <20250917115522495GLHVUSlfNCJr9lf9gxsDy@zte.com.cn>
In-Reply-To: <20250917115057635tlnrFBfUcn1C1pBCZ02gN@zte.com.cn>
References: 20250917115057635tlnrFBfUcn1C1pBCZ02gN@zte.com.cn
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
Subject: =?UTF-8?B?W1BBVENIIHY1IDMvN10gRG9jcy96aF9DTjogVHJhbnNsYXRlIGdmczIucnN0IHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 58H3tLO1042496
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 17 Sep 2025 11:55:58 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68CA314E.000/4cRQ0t3YDnz5B13w

From: Shao Mingyin <shao.mingyin@zte.com.cn>

translate the "gfs2.rst" into Simplified Chinese.

Update to commit d9593868cd58("Documentation: Update
filesystems/gfs2.rst")

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
Signed-off-by: yang tao <yang.tao172@zte.com.cn>
---
v4->v5
fix some format issues.
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

