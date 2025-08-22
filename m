Return-Path: <linux-kernel+bounces-781500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6232FB31350
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6348AE600F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2D82F28E9;
	Fri, 22 Aug 2025 09:28:32 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61502F1FFA;
	Fri, 22 Aug 2025 09:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854911; cv=none; b=owe5SpFYgwPlDxr7YGwUq5LO8QybrYHIixacJnB94ZlNgGgEXsPYZCZyHSAXa/2S2cNyeDTQA/hwsy2IFNeM/IUE7G1CDpHb9fADVrGfk96bdQWtB6CNKqH7UhoVyoxpjnKyWsy6YXK/DnNDgittO9DtjKJYsoDqSjqNouwaG1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854911; c=relaxed/simple;
	bh=6NfNKH2/5Ex9MkMi1xX3pcCJaCNEsgGjtKN2pSlHG/M=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=mkTRWKQS6cbdowIrslfg/uNBdaXeL1pF+v/vVeyyGMDSmh8HsVQdR13RI/Ac/NUsa8AEM8yNtLkX/4q56h8IsR0dBnJKKBb9zZ7nSyObE5AUpoEfoyD8gIlj2dwhx4Q1tT0JFe2EtUib3w+/pShqsIXOF5/3BRzzZ2HzuNbH9GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4c7ZcW4xPfz5PM38;
	Fri, 22 Aug 2025 17:28:27 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 57M9SBtG061104;
	Fri, 22 Aug 2025 17:28:12 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 22 Aug 2025 17:28:14 +0800 (CST)
Date: Fri, 22 Aug 2025 17:28:14 +0800 (CST)
X-Zmail-TransId: 2afc68a8382effffffff97c-e4028
X-Mailer: Zmail v1.0
Message-ID: <20250822172814216UpCi2uCZm_cXohi5cSYB-@zte.com.cn>
In-Reply-To: <20250822171232584GYKo3tPbZNfE3VsK7dvM0@zte.com.cn>
References: 20250822171232584GYKo3tPbZNfE3VsK7dvM0@zte.com.cn
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
Subject: =?UTF-8?B?W1BBVENIIHYzIDYvN10gRG9jcy96aF9DTjogVHJhbnNsYXRlIGRub3RpZnkucnN0IHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 57M9SBtG061104
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Fri, 22 Aug 2025 17:28:27 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68A8383B.001/4c7ZcW4xPfz5PM38

From: Wang Longjie <wang.longjie1@zte.com.cn>

translate the "dnotify.rst" into Simplified Chinese.

Update to commit b31763cff488("docs: filesystems: convert dnotify.txt to
ReST")

Signed-off-by: Wang Longjie <wang.longjie1@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
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
@@ -15,6 +15,16 @@ Linux Kernel中的文件系统
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

