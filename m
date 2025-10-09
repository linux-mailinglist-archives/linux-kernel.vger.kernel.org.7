Return-Path: <linux-kernel+bounces-846312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A37D5BC78B5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 868BF4F3791
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FA21FFC48;
	Thu,  9 Oct 2025 06:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwMDQeIR"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9FD19922D
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990881; cv=none; b=h7/ZRTfWmoBcGaOrV0p+MFHShYZ6rvGXmb06PJ9/HRUAv6G2UM7tg/xW+brKPut7sndJfHNeoqG0uxvdeAeWlfnPI9X31/6v6G2maitQoHA4UKWsLmEP/yDvkJhN3RZhAWro4beYaHoYsWrQQGMz3QBcRMKlW8FwUZM2674zUAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990881; c=relaxed/simple;
	bh=mUXFQxxM3SWhjrY/3VObd9oQOyqoUQ45DAvv/+b6vnA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXYlzCKI67+TRPK+SkZucqmCQiCHi0od6LuTd+QMQiQNMw0T945n9W6tdwC4g6U2VVhExC3aStlQgKUEYen6mdm0fQZQ21MAAKFgEHAS2h0bimiB5WwlXvzT5MeDiuTjiFPF8D+OYAFhPLyFZLBT2tVbzJiXWoV4JNsa0xynyew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwMDQeIR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so626562a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759990879; x=1760595679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CaDCQIWYzWfBAMb6kIpf21J1Bedz5S2Y6aQfe2dSDhU=;
        b=hwMDQeIRK8h47Lg8B0dc7HFNcaJQhKDnsLs086ti+EHTUtO2GQOoysZGzzQW2ZYv3E
         gSz8mLYIk28/BKUTMAIgNFl5hb0FEyPwH59eYGhhrSH45fC1VM99LcI957gOTMR/jN4/
         z3z0V9N6/8QziLOJAJWy0iNRjVXINbt56UY/P0u3XWWqYhda7pqug3FwIvZm1AA0sYK0
         I8NiD1ruuQqdzYMloGH+DuNfTGG23/NkunW2Tk2viZ+PkqdkNsvkM3K3MkIMLddPMQb/
         04SmYIK1GoGM2gKllHI7C+XY+vxEsWqnTnpx9AQ45gXYoOGAtWBXHc4TwSDW2V+mAmbQ
         VVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759990879; x=1760595679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaDCQIWYzWfBAMb6kIpf21J1Bedz5S2Y6aQfe2dSDhU=;
        b=D6+DCXw3+4ZeJbOWcuV63T4NVqgfcYk7pFZiULuZlm4lKzKHMheNqazx9gfm+LrMqq
         6RgdBT5pErgyGlCP0B30n8bGniFm7/yBWZtNnmQY1WPkqAWmrEELG7ht7KkiMEUnZrfk
         aJqtzZ+PgyIzqC168208sjagcg0UsyTSqmkE+xM1RpB/koaZCZcwVuty/o1WsJBX09Ur
         g0OfZr/WdWgvq9kNmdlWnygoKPiUiJjn+kiOWumO1ohKXY+YntpZ8Ak2Yp6rx6c9ZF+O
         irtP6IoNdYuxjHCn3OuAMmqZ1t8rZDK/BljJdmtZmLSdLY9WDFSFrna8cJBqPff9I7Gq
         sD0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6KRFjRpkZ+kNE3dfHIFhTdS16GgHms/axv7R63X4eXmdIYf83O2EnCoGCJZqW2o54DjpcCiVbzDtUYks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaWf3R3/504k4kGCTsR8Y+OV6U4v4FW0/wvVLaCOmYr5MhVvT2
	8qPzvlWWyF5kDGTD8hAB58tMDUZkIb5qAU/J9CD0LL2l7BMSTNR8/G2nQvTjPg==
X-Gm-Gg: ASbGnctKqvIRv2pKyZNzH4wG6CCmtAGQnWTbayNSpupBwEN2ehS3OIFYRDCyOaC6rKh
	T4H2vEyJmCEAjEg+8NjNTlHs/man8ImDQ96Nee3Raprq70vbAhZKP9mvO3+7eyto8vzsQfdcBRp
	8iTLhc8cZASZB3w+IkVWEJcRNdnCmBBYDYNPSvGLuOcBjDtb37NpPzeCqp3FOHYt/7H2g7wBYiz
	1VjeBgqlVkLzHxoNHMAikN7VoukbLnBiO42o9l68LAUO7mjUIZ2MHHZsreL32pgZhmz7Zs10p0m
	VGJKxUyIQRX2GsIVnSxm4skuAgqr1waUblqApu+hLVFroQF7aXsdLb7NvbQqGYPDmM0ocuM6QyP
	g0pqMEU3oHsbQcZd+9sUZjyM/bNF7GzlBsn3fq7tYIR2iqyHO+qAI
X-Google-Smtp-Source: AGHT+IGoxorpMriSzmoWjhKNLS3crcyDw5O8UAg43YRloQ6H2VHBxiQKxxRcbbKhYFias0Pw2I94Dg==
X-Received: by 2002:a17:90b:3882:b0:32e:7270:94a1 with SMTP id 98e67ed59e1d1-33b51375992mr8878052a91.17.1759990878839;
        Wed, 08 Oct 2025 23:21:18 -0700 (PDT)
Received: from localhost ([46.232.121.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b51116b57sm5596878a91.15.2025.10.08.23.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:21:18 -0700 (PDT)
From: Frank Cen <focksor@gmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Frank Cen <focksor@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] docs/zh_CN: Add trace debugging Chinese translation
Date: Thu,  9 Oct 2025 14:20:18 +0800
Message-ID: <9ce3ec27f9abd0b4373f53701a16aafebe404f53.1759990204.git.focksor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1759990204.git.focksor@gmail.com>
References: <cover.1759990204.git.focksor@gmail.com>
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
index 000000000000..b66ac2cce47d
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
+==================
+使用追踪器进行调试
+==================
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
+----
+跟踪框架对于调试 Linux 内核非常有用。本文记录了使用追踪器进行调试的各种方法。
+
+首先，确保已经挂载了 tracefs 文件系统::
+
+ $ sudo mount -t tracefs tracefs /sys/kernel/tracing
+
+
+使用 trace_printk()
+-------------------
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
+------------
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
+------------------
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
+-----------------------------
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


