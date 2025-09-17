Return-Path: <linux-kernel+bounces-820370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89902B7CC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1A51C03602
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B0B32D5AC;
	Wed, 17 Sep 2025 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8BgUGOJ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1012E2DD8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102172; cv=none; b=aMM6xwjIIbv0kqkhSmyVxwujyc2S8zdrrP0OT+2JJ8d8MXuBlQ0f1OUIUjcy57X1VmvNxLdBbqcu82p2nKy6rKgSc+RuBUGKP4XIo99LKHnZ5WndN2hjz/0eF4Op/2f5dzDOzxnCM93Fd4s55ZKbJM/+UlMcmAfJuZ2uKsgkPoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102172; c=relaxed/simple;
	bh=+fYzHLnniVpywqxHpXon8nNX56ENCWlc28vR7604q4w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdwbDw1XLi08dWLPtEU/j4/VJWoZWaVYgzallyBWXCcHPbp2UzyL3Vs4vBmRffHj2DfqKLC7gFe/NJjAoFvTiTuVdpRR1Mr08NJWzu5jiwSPnr0H1i9fhJpcKlohKtU9/bKM2O11ZwfBOjTJpFIf8dJHoCuxYDGd5CcfCVhaeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8BgUGOJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7723f0924a3so7860021b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758102170; x=1758706970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=25QTBkeKISyuNQU9ZXXRUKgqu0c5eiSuYdBrvhfhVww=;
        b=V8BgUGOJB1bVSQx2kM/T61qSK+s3ptO3xiJm6OyE6TWbVCe/QOKesLlAPJCVPVx/Bt
         WxCf2zflZBCbVMAcNzsKjsfELhZ3Zei9gblTMXAIowrKHOF/cvfSuInMQYpw/k+/fze3
         LljAzssR6pMmYfm+52Q/hvGyga0VYKR3DwqW46s+Pve9KFZzpeBKH4fYyFjmmLjAQ2zT
         3xUix6nF8Z0F+bkgmWaZIJ72mpJhUy9mR6XWKtuPp+u9BX6FKnwXTj7D6ICEAJfRWSuF
         Y0X1bZS6uBZU9HifuglP3ZBlLYqlttBQ2StatgU+SF6J7ZNbBzHYWPnjxnECd+hahXEs
         fQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758102170; x=1758706970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25QTBkeKISyuNQU9ZXXRUKgqu0c5eiSuYdBrvhfhVww=;
        b=aq6bjsmlOv5NxFlfnWKJI6QNFreSk1l2Zq+pxfXdEC39W7bei23fAseLzEAngHBANI
         bZeq0HtemCjxQFWa7v5No9dDo+IRooMnb421MX0EFQ5zJPov1TfAX1WROY506CKqKDzj
         sxYFs+Vg0DUfrn68Ck2OQpHOsd9Uym7BOf67LnoKl6wFjECA8HrQsxL33H5ufmtLYezZ
         CmyjvA7uv+iGkBxv0vG7GjEZM/5fDMYv9WQYOMZcPEBMgCeyePuplC60fUctpa/FTg/k
         zp2nYyFsNFkqTb2Hv9hHnooYekBiOR3kYIx7Y7ALkO9iycUUHTRmdGY8TbrXKl+yrgyL
         jqXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD1on/MQq2a3Rpj3ORj+UbA6eV+MaFJOQI6Fi/sXNmKN2yHEXdROBliJqoA11+ORcOHi/gPUNkb3Fd7DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBlRINLJ0i69QavRGNg/m+sybep6+H+ImMGZaN5YB/QKmqjkYS
	QNmgTov3WYybGYYKnUWay3IjS//RCIx2bjCDYlz2Vy0dx1e9hR0S0/Sf
X-Gm-Gg: ASbGncvjdYDDTBv+Rf6B4GFGozeCrdAUUqU81vy+G9mpHrCA1dmbMcUvjIw6+cioH4z
	+XQYIB4UGMHeACpCXiYuwa08FLJ2aP8HUYUKPu2nu0yiueBxaKefYEiLAQEJZty2ozpJIngrIAh
	Ne6bsvwN65Yvvh3yPyusH/7X2PKdO51QDdq/4MjmdPzQTKT9qvi/Kvm3A7WbWHPkfXE1nORdZnb
	HO8pE2iZkD8ya8V0FGiJdL+vbSghofLFZ6ADMDKJg5lFPxL34ETeAYd+Gg6FuieD4UdUbCo63/p
	ZeiWgI5iwyVrn/MnB2TyoEutrGdZcUoonpzJ8pKdIyjQEz9iftI15BLhGip8YuxVux93GOQwJel
	8ofA1jzPgzXj9MJUL9g==
X-Google-Smtp-Source: AGHT+IEplxdoa50O5ZdnsO2eferFGqHLrfu8hvNNWoOY9z9pwuW3EK4yfbM159pKYAzo47L2iKAXGQ==
X-Received: by 2002:a05:6a00:84c:b0:771:fd01:9784 with SMTP id d2e1a72fcca58-77bf96606dcmr1637743b3a.29.1758102169577;
        Wed, 17 Sep 2025 02:42:49 -0700 (PDT)
Received: from localhost ([46.232.121.212])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c48f22sm18690780b3a.92.2025.09.17.02.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:42:49 -0700 (PDT)
From: Frank Cen <focksor@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Frank Cen <focksor@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: Add trace debugging Chinese translation
Date: Wed, 17 Sep 2025 17:40:35 +0800
Message-ID: <20250917094052.593829-2-focksor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Translate .../trace/debugging.rst into Chinese.

Update the translation through commit c44a14f216f4
("tracing: Enforce the persistent ring buffer to be page aligned")

Signed-off-by: Frank Cen <focksor@gmail.com>
---
 .../translations/zh_CN/trace/debugging.rst    | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/trace/debugging.rst

diff --git a/Documentation/translations/zh_CN/trace/debugging.rst b/Documentation/translations/zh_CN/trace/debugging.rst
new file mode 100644
index 000000000000..7ad0aaee4900
--- /dev/null
+++ b/Documentation/translations/zh_CN/trace/debugging.rst
@@ -0,0 +1,133 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+:Original: Documentation/trace/debugging.rst
+:翻译:
+
+ 岑发亮 Frank Cen <focksor@gmail.com>
+
+==============================
+使用追踪器进行调试
+==============================
+
+Copyright 2024 Google LLC.
+
+:Author:   Steven Rostedt <rostedt@goodmis.org>
+:License:  The GNU Free Documentation License, Version 1.2
+          (dual licensed under the GPL v2)
+
+- Written for: 6.12
+
+引言
+------------
+跟踪框架对于调试 Linux 内核非常有用。本文记录了使用追踪器进行调试的各种方法。
+
+首先，确保已经挂载了 tracefs 文件系统::
+
+ $ sudo mount -t tracefs tracefs /sys/kernel/tracing
+
+
+使用 trace_printk()
+--------------------
+
+trace_printk() 是一个非常轻量级的工具，可以在内核中除 "noinstr" 部分外的任何上下文使用。
+它可以在正常、软中断、硬中断甚至 NMI 上下文中使用。
+跟踪数据以无锁的方式写入到环形缓冲区 (tracing ring buffer) 中。
+为了使其更轻量，当可能时，它会只记录格式字符串的指针，并将原始参数保存到缓冲区中。格式和参数
+将在读取环形缓冲区时再进行处理。这样，格式化处理就不会在热路径（即记录追踪的地方）中完成。
+
+trace_printk() 只用于调试，绝不应添加到内核的子系统中。如果需要调试跟踪，请改用添加跟踪事件。
+如果在内核中发现 trace_printk()，则 dmesg 中会出现以下内容::
+
+  **********************************************************
+  **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
+  **                                                      **
+  ** trace_printk() being used. Allocating extra memory.  **
+  **                                                      **
+  ** This means that this is a DEBUG kernel and it is     **
+  ** unsafe for production use.                           **
+  **                                                      **
+  ** If you see this message and you are not debugging    **
+  ** the kernel, report this immediately to your vendor!  **
+  **                                                      **
+  **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
+  **********************************************************
+
+
+调试内核崩溃
+------------------------
+有多种方法可以在内核崩溃时获取系统状态。这可以通过 printk 中的 oops 消息
+来实现，也可以使用 kexec/kdump。但这些方法只能显示崩溃时的情况，而知道
+在崩溃发生之前发生了什么则非常有帮助。tracing ring buffer 默认情况下是一个循环缓冲区，
+它会用较新的事件覆盖较旧的事件。当崩溃发生时，ring buffer 会包含导致崩溃的所有事件。
+
+在调试时，可以通过一些内核命令行参数来辅助。第一个参数是 ftrace_dump_on_oops，
+它会在系统发生 oops 时，把 tracing ring buffer 的内容输出到控制台。如果控制台的输出被记录下来，这会非常有帮助。
+但如果使用的是串口控制台，建议将环形缓冲区设得相对较小，否则转储环形缓冲区可能需要几分钟甚至数小时才能完成。
+下面是一个内核命令行示例::
+
+  ftrace_dump_on_oops trace_buf_size=50K
+
+注意，tracing buffer 由每个 CPU 的缓冲区组成，每个缓冲区又被划分为默认大小为 PAGE_SIZE 的子缓冲区。
+上面的 trace_buf_size 选项将每个 CPU 的缓冲区设置为 50K，因此在一个有 8 个 CPU 的机器上，
+总共实际上是 400K。
+
+跨重启的持久缓冲区
+-------------------------------
+如果系统内存允许，可以在内存中的特定位置指定追踪环形缓冲区。如果该位置在重启时保持不变
+且内存未被修改，则可以在下一次启动后读取跟踪缓冲区。有两种方法可以为环形缓冲区保留内存。
+
+更可靠的方法（在 x86 上）是使用 memmap 内核命令行选项来保留内存，然后将该内存用于 trace_instance。
+这需要对系统的物理内存布局有一定的了解。使用这种方法的优点是，环形缓冲区的内存位置将始终保持不变::
+
+  memmap==12M$0x284500000 trace_instance=boot_map@0x284500000:12M
+
+上面的 memmap 选项在物理内存地址 0x284500000 处保留了 12 兆字节的内存。
+然后，trace_instance 选项将在同一位置创建一个名为 "boot_map" 的 trace instance，
+这个实例使用与保留的内存相同的大小。由于环形缓冲区被划分为每个 CPU 的缓冲区，
+因此这 12 兆字节的内存将被均匀地分配给这些 CPU。如果你有 8 个 CPU，
+那么每个 CPU 的环形缓冲区大小将是 1.5 兆字节。注意，这其中还要包括元数据，
+因此环形缓冲区实际使用的内存会稍微小一些。
+
+另一种更通用但没那么可靠的在启动时分配环形缓冲区映射的方法是使用 reserve_mem 选项::
+
+  reserve_mem=12M:4096:trace trace_instance=boot_map@trace
+
+上面的 reserve_mem 会在启动时找到 12 兆字节的可用内存，并按 4096 字节对齐。
+这块内存会被标记为 "trace" 以供后续的命令行选项使用。
+
+trace_instance 选项创建了一个名为 "boot_map" 的 trace instance，并将使用
+由 reserve_mem 保留的、标记为 "trace" 的内存。这种方法更通用，但可能不那么可靠。
+由于 KASLR（内核地址空间布局随机化）的存在，reserve_mem 保留的内存位置可能会有所不同。
+当这种情况发生时，环形缓冲区将不是来自上一次启动的内容，并且会被重置。
+
+有时我们可以使用更大的对齐方式，来防止 KASLR 以某种方式移动内存位置从而改变 reserve_mem 的位置。
+通过使用更大的对齐方式，可能会使缓冲区的位置更一致::
+
+  reserve_mem=12M:0x2000000:trace trace_instance=boot_map@trace
+
+在启动时，会对为 ring buffer 保留的内存进行验证。它会经过一系列测试，以确保 ring buffer 包含有效数据。
+如果测试通过，该环形缓冲区将被设置为可从实例中读取。如果测试未通过，则会被清空并重新初始化。
+
+这块映射内存的布局在不同的内核版本之间可能不一致，因此只有相同的内核版本才能保证工作正常。
+切换到不同的内核版本可能会发现布局不同，缓冲区将会被标记为无效。
+
+注意：映射的地址和大小都必须符合架构的页面对齐要求。
+
+在启动阶段使用 trace_printk()
+-----------------------------------------
+默认情况下， trace_printk() 的内容会进入 top level tracing instance。
+但这个 instance 在重启时不会被保留。为了让 trace_printk() 的内容
+和其他一些内部 tracing（如 dump stacks）进入被保留的缓冲区，
+可以从内核命令行设置 instance 为 trace_printk() 的目标，
+或者在启动后通过 trace_printk_dest 选项进行设置。
+
+启动后::
+
+  echo 1 > /sys/kernel/tracing/instances/boot_map/options/trace_printk_dest
+
+在内核命令行设置::
+
+  reserve_mem=12M:4096:trace trace_instance=boot_map^traceprintk^traceoff@trace
+
+如果在内核命令行中设置，建议同时使用 "traceoff" 标志来禁用追踪，并在启动后再启用追踪。
+否则，最近一次启动的追踪信息将与上一次启动的追踪信息混在一起，可能会变得难以阅读。
-- 
2.43.0


