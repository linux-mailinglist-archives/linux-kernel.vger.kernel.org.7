Return-Path: <linux-kernel+bounces-781531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F8BB31398
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29A8B035F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193792F3C3F;
	Fri, 22 Aug 2025 09:31:36 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01402EF66F;
	Fri, 22 Aug 2025 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855095; cv=none; b=K+JG1qQFt3pJmztmoSH9xs1N6rsc/WAoZvYOr3QffKUYlv24zzUQBzeFMBZzVGTdtew2Z56P/J3E6idS940ns6/b/ICmRQuDQH/M2tgK/joiIvCCk2JfMLAalZkMbsZQrluPvNrNEDSV2pigZMpKCnaX1zromOm2cpRIdGg2tBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855095; c=relaxed/simple;
	bh=nweimmEhr8rbZFffy27dfvw3IXfpaakdBvXRLQUrYQw=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=DyE8dZK6tsIzcD6gs1Q5/yrzdVow3bUNW8Hi3F8Z9pyvDVAZ143BXK2L4mlFEiL36GS9U4pY9Wr9tbCJHYooscW13kSx1vL0fJSLhw07eYusg/xdzduWWmgBAsYYWDzpg++Ldnf+McnC6jQiW+XZQzBtpkKUaTeafkuTpsys1Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4c7Zgy5TCfz5B137;
	Fri, 22 Aug 2025 17:31:26 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 57M9UMvX065243;
	Fri, 22 Aug 2025 17:30:22 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 22 Aug 2025 17:30:24 +0800 (CST)
Date: Fri, 22 Aug 2025 17:30:24 +0800 (CST)
X-Zmail-TransId: 2afc68a838b0fffffffff82-e762b
X-Mailer: Zmail v1.0
Message-ID: <20250822173024327RyliP6dTeevq-Ufgsj-A2@zte.com.cn>
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
Subject: =?UTF-8?B?W1BBVENIIHYzIDcvN10gRG9jcy96aF9DTjogVHJhbnNsYXRlIGlub3RpZnkucnN0IHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 57M9UMvX065243
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Fri, 22 Aug 2025 17:31:26 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68A838EE.002/4c7Zgy5TCfz5B137

From: Wang Longjie <wang.longjie1@zte.com.cn>

translate the "inotify.rst" into Simplified Chinese.

Update to commit de389cf08d47("docs: filesystems: convert inotify.txt to
ReST")

Signed-off-by: Wang Longjie <wang.longjie1@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 .../translations/zh_CN/filesystems/index.rst  |  1 +
 .../zh_CN/filesystems/inotify.rst             | 81 +++++++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/filesystems/inotify.rst

diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
index ef688ac095f6..c9b371549fc7 100644
--- a/Documentation/translations/zh_CN/filesystems/index.rst
+++ b/Documentation/translations/zh_CN/filesystems/index.rst
@@ -41,4 +41,5 @@ Linux Kernel中的文件系统
    gfs2
    gfs2-uevents
    gfs2-glocks
+   inotify

diff --git a/Documentation/translations/zh_CN/filesystems/inotify.rst b/Documentation/translations/zh_CN/filesystems/inotify.rst
new file mode 100644
index 000000000000..a07c2a78f3eb
--- /dev/null
+++ b/Documentation/translations/zh_CN/filesystems/inotify.rst
@@ -0,0 +1,81 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/filesystems/inotify.rst
+
+:翻译:
+
+   王龙杰 Wang Longjie <wang.longjie1@zte.com.cn>
+
+==========================================
+Inotify - 一个强大且简单的文件变更通知系统
+==========================================
+
+
+
+文档由 Robert Love <rml@novell.com> 于 2005 年 3 月 15 日开始撰写
+
+文档由 Zhang Zhen <zhenzhang.zhang@huawei.com> 于 2015 年 1 月 4 日更新
+
+	- 删除了已废弃的接口，关于用户接口请参考手册页。
+
+(i) 基本原理
+
+问：
+   不将监控项与被监控对象打开的文件描述符（fd）绑定，这背后的设计决策是什么？
+
+答：
+   监控项会与打开的 inotify 设备相关联，而非与打开的文件相关联。这解决了 dnotify 的主要问题：
+   保持文件打开会锁定文件，更糟的是，还会锁定挂载点。因此，dnotify 在带有可移动介质的桌面系统
+   上难以使用，因为介质将无法被卸载。监控文件不应要求文件处于打开状态。
+
+问：
+   与每个监控项一个文件描述符的方式相比，采用每个实例一个文件描述符的设计决策是出于什么
+   考虑？
+
+答：
+   每个监控项一个文件描述符会很快的消耗掉超出允许数量的文件描述符，其数量会超出实际可管理的范
+   围，也会超出 select() 能高效处理的范围。诚然，root 用户可以提高每个进程的文件描述符限制，
+   用户也可以使用 epoll，但同时要求这两者是不合理且多余的。一个监控项所消耗的内存比一个打开的文
+   件要少，因此将这两个数量空间分开是合理的。当前的设计正是用户空间开发者所期望的：用户只需初始
+   化一次 inotify，然后添加 n 个监控项，而这只需要一个文件描述符，无需调整文件描述符限制。初
+   始化 inotify 实例初始化两千次是很荒谬的。如果我们能够简洁地实现用户空间的偏好——而且我们
+   确实可以，idr 层让这类事情变得轻而易举——那么我们就应该这么做。
+
+   还有其他合理的理由。如果只有一个文件描述符，那就只需要在该描述符上阻塞，它对应着一个事件队列。
+   这个单一文件描述符会返回所有的监控事件以及任何可能的带外数据。而如果每个文件描述符都是一个独
+   立的监控项，
+
+   - 将无法知晓事件的顺序。文件 foo 和文件 bar 上的事件会触发两个文件描述符上的 poll()，
+     但无法判断哪个事件先发生。而用单个队列就可以很容易的提供事件的顺序。这种顺序对现有的应用程
+     序（如 Beagle）至关重要。想象一下，如果“mv a b ; mv b a”这样的事件没有顺序会是什么
+     情况。
+
+   - 我们将不得不维护 n 个文件描述符和 n 个带有状态的内部队列，而不是仅仅一个。这在 kernel 中
+     会混乱得多。单个线性队列是合理的数据结构。
+
+   - 用户空间开发者更青睐当前的 API。例如，Beagle 的开发者们就很喜欢它。相信我，我问过他们。
+     这并不奇怪：谁会想通过 select 来管理以及阻塞在 1000 个文件描述符上呢？
+
+   - 无法获取带外数据。
+
+   - 1024 这个数量仍然太少。  ;-)
+
+   当要设计一个可扩展到数千个目录的文件变更通知系统时，处理数千个文件描述符似乎并不是合适的接口。
+   这太繁琐了。
+
+   此外，创建多个实例、处理多个队列以及相应的多个文件描述符是可行的。不必是每个进程对应一个文件描
+   述符；而是每个队列对应一个文件描述符，一个进程完全可能需要多个队列。
+
+问：
+   为什么采用系统调用的方式？
+
+答：
+   糟糕的用户空间接口是 dnotify 的第二大问题。信号对于文件通知来说是一种非常糟糕的接口。其实对
+   于其他任何事情，信号也都不是好的接口。从各个角度来看，理想的解决方案是基于文件描述符的，它允许
+   基本的文件 I/O 操作以及 poll/select 操作。获取文件描述符和管理监控项既可以通过设备文件来
+   实现，也可以通过一系列新的系统调用来实现。我们决定采用一系列系统调用，因为这是提供新的内核接口
+   的首选方法。两者之间唯一真正的区别在于，我们是想使用 open(2) 和 ioctl(2)，还是想使用几
+   个新的系统调用。系统调用比 ioctl 更有优势。
+
-- 
2.25.1

