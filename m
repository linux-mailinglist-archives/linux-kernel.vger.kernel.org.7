Return-Path: <linux-kernel+bounces-819955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63588B7CEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14271B2361E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 03:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C342874E0;
	Wed, 17 Sep 2025 03:56:32 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2228226C3BF;
	Wed, 17 Sep 2025 03:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758081392; cv=none; b=AVZ6mUkhPeX0kPJOMrvhvwBYcogpdIDprUlUwRcnMJmLR20S87ei7DNReYMh6BTJYNTzaga+/ZNDEMKb0Likq3NQmwIFHSwK4LdXZ8DxHgayGE3KIsIdmHyp2A9pRQBnTA3DUuedrNDhNnhTqSAZspEkmUCLyhB7iJbfpzGmgE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758081392; c=relaxed/simple;
	bh=Vi4px5gPpTMSOb83mlAHWIropGYjp+awVuhhQS+6Np8=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=PYOTbPh+5aqpfml0hg/hx+XBUOWjJVZiSmX3OJ2M+6y7jNI7MfqjFnTP581j0gcChwJW2cwkU1sLNlt9P60N/A1nnxatOXbpNFyLRGnNu/sCVr2Kl4GrFyykJEIw/XelhipD+0IxmV7pcQeDXoclIpBzx3RSc7IJBJbSQrAi4js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cRQ1Q191Tz5B13f;
	Wed, 17 Sep 2025 11:56:26 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 58H3uEL8045964;
	Wed, 17 Sep 2025 11:56:14 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 17 Sep 2025 11:56:15 +0800 (CST)
Date: Wed, 17 Sep 2025 11:56:15 +0800 (CST)
X-Zmail-TransId: 2afb68ca315fda7-eb23f
X-Mailer: Zmail v1.0
Message-ID: <20250917115615772z-3xvYjsdrrS6f9y5h6YY@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIHY1IDQvN10gRG9jcy96aF9DTjogVHJhbnNsYXRlIGdmczItdWV2ZW50cy5yc3QgdG8gU2ltcGxpZmllZCBDaGluZXNl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 58H3uEL8045964
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 17 Sep 2025 11:56:26 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68CA316A.000/4cRQ1Q191Tz5B13f

From: Shao Mingyin <shao.mingyin@zte.com.cn>

translate the "gfs2-uevents.rst" into Simplified Chinese.

Update to commit 5b7ac27a6e2c("docs: filesystems: convert
gfs2-uevents.txt to ReST")

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
Signed-off-by: yang tao <yang.tao172@zte.com.cn>
---
v4->v5
fix some format issues.
 .../zh_CN/filesystems/gfs2-uevents.rst        | 97 +++++++++++++++++++
 .../translations/zh_CN/filesystems/index.rst  |  1 +
 2 files changed, 98 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst

diff --git a/Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst b/Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
new file mode 100644
index 000000000000..8ac820aa8dd5
--- /dev/null
+++ b/Documentation/translations/zh_CN/filesystems/gfs2-uevents.rst
@@ -0,0 +1,97 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/filesystems/gfs2-uevents.rst
+
+:翻译:
+
+   邵明寅 Shao Mingyin <shao.mingyin@zte.com.cn>
+
+:校译:
+
+   - 杨涛 yang tao <yang.tao172@zte.com.cn>
+
+===============
+uevents 与 GFS2
+===============
+
+在 GFS2 文件系统的挂载生命周期内，会生成多个 uevent。
+本文档解释了这些事件的含义及其用途（被 gfs2-utils 中的 gfs_controld 使用）。
+
+GFS2 uevents 列表
+=================
+
+1. ADD
+------
+
+ADD 事件发生在挂载时。它始终是新建文件系统生成的第一个 uevent。如果挂载成
+功，随后会生成 ONLINE uevent。如果挂载失败，则随后会生成 REMOVE uevent。
+
+ADD uevent 包含两个环境变量：SPECTATOR=[0|1] 和 RDONLY=[0|1]，分别用
+于指定文件系统的观察者状态（一种未分配日志的只读挂载）和只读状态（已分配日志）。
+
+2. ONLINE
+---------
+
+ONLINE uevent 在成功挂载或重新挂载后生成。它具有与 ADD uevent 相同的环
+境变量。ONLINE uevent 及其用于标识观察者和 RDONLY 状态的两个环境变量是较
+新版本内核引入的功能（2.6.32-rc+ 及以上），旧版本内核不会生成此事件。
+
+3. CHANGE
+---------
+
+CHANGE uevent 在两种场景下使用。一是报告第一个节点成功挂载文件系统时
+（FIRSTMOUNT=Done）。这作为信号告知 gfs_controld，此时集群中其他节点可以
+安全挂载该文件系统。
+
+另一个 CHANGE uevent 用于通知文件系统某个日志的日志恢复已完成。它包含两个
+环境变量：JID= 指定刚恢复的日志 ID，RECOVERY=[Done|Failed] 表示操作成
+功与否。这些 uevent 会在每次日志恢复时生成，无论是在初始挂载过程中，还是
+gfs_controld 通过 /sys/fs/gfs2/<fsname>/lock_module/recovery 文件
+请求特定日志恢复的结果。
+
+由于早期版本的 gfs_controld 使用 CHANGE uevent 时未检查环境变量以确定状
+态，若为其添加新功能，存在用户工具版本过旧导致集群故障的风险。因此，在新增用
+于标识成功挂载或重新挂载的 uevent 时，选择了使用 ONLINE uevent。
+
+4. OFFLINE
+----------
+
+OFFLINE uevent 仅在文件系统发生错误时生成，是 "withdraw" 机制的一部分。
+当前该事件未提供具体错误信息，此问题有待修复。
+
+5. REMOVE
+---------
+
+REMOVE uevent 在挂载失败结束或卸载文件系统时生成。所有 REMOVE uevent
+之前都至少存在同一文件系统的 ADD uevent。与其他 uevent 不同，它由内核的
+kobject 子系统自动生成。
+
+
+所有 GFS2 uevents 的通用信息（uevent 环境变量）
+===============================================
+
+1. LOCKTABLE=
+-------------
+
+LOCKTABLE 是一个字符串，其值来源于挂载命令行（locktable=）或 fstab 文件。
+它用作文件系统标签，并为 lock_dlm 类型的挂载提供加入集群所需的信息。
+
+2. LOCKPROTO=
+-------------
+
+LOCKPROTO 是一个字符串，其值取决于挂载命令行或 fstab 中的设置。其值将是
+lock_nolock 或 lock_dlm。未来可能支持其他锁管理器。
+
+3. JOURNALID=
+-------------
+
+如果文件系统正在使用日志（观察者挂载不分配日志），则所有 GFS2 uevent 中都
+会包含此变量，其值为数字形式的日志 ID。
+
+4. UUID=
+--------
+
+在较新版本的 gfs2-utils 中，mkfs.gfs2 会向文件系统超级块写入 UUID。若存
+在 UUID，所有与该文件系统相关的 uevent 中均会包含此信息。
diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
index 26b7ee6be3b1..7051fd9d94f3 100644
--- a/Documentation/translations/zh_CN/filesystems/index.rst
+++ b/Documentation/translations/zh_CN/filesystems/index.rst
@@ -29,3 +29,4 @@ Linux Kernel中的文件系统
    ubifs
    ubifs-authentication
    gfs2
+   gfs2-uevents
-- 
2.27.0

