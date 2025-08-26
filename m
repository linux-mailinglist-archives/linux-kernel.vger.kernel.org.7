Return-Path: <linux-kernel+bounces-786514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54444B35ACD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8876D17D7D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1312BD00C;
	Tue, 26 Aug 2025 11:11:35 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA30F2BDC00;
	Tue, 26 Aug 2025 11:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206695; cv=none; b=EPOX17n+egG4YYgd2E8W6PdUiCxB2AcSHrpHqqBaFwI5mF04Zaet2JAA7P33yieK61xYtEACDwhcssIVWQQszzsOhU49cOGouN5aITFh/JbqJ5ceGzOB7ltCAUjlg7IZj5YN8x+8pbtIiRSDDFpwtz/3D3YRgdwy1TwmWS27hwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206695; c=relaxed/simple;
	bh=E+HlitpA7D03Mq0ySRI5hB32hPDVxAI8QJ6VDaTbMFg=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=f5BSZXfqBygDzr3UVvJW1dp9Ky9RMSRAHSjxI2V9bFGmel2xE+qb5yNDadtV9ncE/9c4X6K7xIrZFM4WyJ4VZ0fnL5oRazDRXSmN/HVmJ3vaWsMqVnNR/RViqqJR1EB7FrZzTzirQ0eq8eFJNEPxkkJXHMwCyCOOXyJaPykV8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cB4jV4V3Xz5B1CJ;
	Tue, 26 Aug 2025 19:11:26 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 57QB9Z09053463;
	Tue, 26 Aug 2025 19:09:35 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 26 Aug 2025 19:09:38 +0800 (CST)
Date: Tue, 26 Aug 2025 19:09:38 +0800 (CST)
X-Zmail-TransId: 2afa68ad95f2924-bb977
X-Mailer: Zmail v1.0
Message-ID: <20250826190938127nbv3PV-juvRbvQHDcjLhq@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIHY0IDYvN10gRG9jcy96aF9DTjogVHJhbnNsYXRlIGRub3RpZnkucnN0IHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 57QB9Z09053463
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 26 Aug 2025 19:11:26 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68AD965E.001/4cB4jV4V3Xz5B1CJ

From: Wang Longjie <wang.longjie1@zte.com.cn>

translate the "dnotify.rst" into Simplified Chinese.

Update to commit b31763cff488("docs: filesystems: convert dnotify.txt to
ReST")

Signed-off-by: Wang Longjie <wang.longjie1@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
v3->v4
resolve patch damage issues.
 .../zh_CN/filesystems/dnotify.rst             | 67 +++++++++++++++++++
 .../translations/zh_CN/filesystems/index.rst  | 10 +++
 2 files changed, 77 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/filesystems/dnotify.rst

diff --git a/Documentation/translations/zh_CN/filesystems/dnotify.rst b/Documentation/translations/zh_CN/filesystems/dnotify.rst
new file mode 100644
index 000000000000..5ab109b9424c
--- /dev/null
+++ b/Documentation/translations/zh_CN/filesystems/dnotify.rst
@@ -0,0 +1,67 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/filesystems/dnotify.rst
+
+:翻译:
+
+   王龙杰 Wang Longjie <wang.longjie1@zte.com.cn>
+
+==============
+Linux 目录通知
+==============
+
+	   Stephen Rothwell <sfr@canb.auug.org.au>
+
+目录通知的目的是使用户应用程序能够在目录或目录中的任何文件发生变更时收到通知。基本机制包括应用程序
+通过 fcntl(2) 调用在目录上注册通知，通知本身则通过信号传递。
+
+应用程序可以决定希望收到哪些 “事件” 的通知。当前已定义的事件如下：
+
+	=========	=====================================
+	DN_ACCESS	目录中的文件被访问（read）
+	DN_MODIFY	目录中的文件被修改（write,truncate）
+	DN_CREATE	目录中创建了文件
+	DN_DELETE	目录中的文件被取消链接
+	DN_RENAME	目录中的文件被重命名
+	DN_ATTRIB	目录中的文件属性被更改（chmod,chown）
+	=========	=====================================
+
+通常，应用程序必须在每次通知后重新注册，但如果将 DN_MULTISHOT 与事件掩码进行或运算，则注册
+将一直保持有效，直到被显式移除（通过注册为不接收任何事件）。
+
+默认情况下，SIGIO 信号将被传递给进程，且不附带其他有用的信息。但是，如果使用 F_SETSIG fcntl(2)
+调用让内核知道要传递哪个信号，一个 siginfo 结构体将被传递给信号处理程序，该结构体的 si_fd 成员将
+包含与发生事件的目录相关联的文件描述符。
+
+应用程序最好选择一个实时信号（SIGRTMIN + <n>），以便通知可以被排队。如果指定了 DN_MULTISHOT，
+这一点尤为重要。注意，SIGRTMIN 通常是被阻塞的，因此最好使用（至少）SIGRTMIN + 1。
+
+实现预期（特性与缺陷 :-)）
+--------------------------
+
+对于文件的任何本地访问，通知都应能正常工作，即使实际文件系统位于远程服务器上。这意味着，对本地用户
+模式服务器提供的文件的远程访问应能触发通知。同样的，对本地内核 NFS 服务器提供的文件的远程访问
+也应能触发通知。
+
+为了尽可能减小对文件系统代码的影响，文件硬链接的问题已被忽略。因此，如果一个文件（x）存在于两个
+目录（a 和 b）中，通过名称”a/x”对该文件进行的更改应通知给期望接收目录“a”通知的程序，但不会
+通知给期望接收目录“b”通知的程序。
+
+此外，取消链接的文件仍会在它们链接到的最后一个目录中触发通知。
+
+配置
+----
+
+Dnotify 由 CONFIG_DNOTIFY 配置选项控制。禁用该选项时，fcntl(fd, F_NOTIFY, ...) 将返
+回 -EINVAL。
+
+示例
+----
+具体示例可参见 tools/testing/selftests/filesystems/dnotify_test.c。
+
+注意
+----
+从 Linux 2.6.13 开始，dnotify 已被 inotify 取代。有关 inotify 的更多信息，请参见
+Documentation/filesystems/inotify.rst。
diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
index 9f2a8b003778..342b588ada34 100644
--- a/Documentation/translations/zh_CN/filesystems/index.rst
+++ b/Documentation/translations/zh_CN/filesystems/index.rst
@@ -15,5 +15,15 @@ Linux Kernel中的文件系统
 文件系统（VFS）层以及基于其上的各种文件系统如何工作呈现给大家。当前\
 可以看到下面的内容。

+核心 VFS 文档
+=============
+
+有关 VFS 层本身以及其算法工作方式的文档，请参阅这些手册。
+
+.. toctree::
+   :maxdepth: 1
+
+   dnotify
+
 文件系统
 ========
-- 
2.27.0

