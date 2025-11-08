Return-Path: <linux-kernel+bounces-891391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EEEC42933
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D6B1885545
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2252EBDDC;
	Sat,  8 Nov 2025 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0hDgUl1"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93D92E7F03
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589187; cv=none; b=OvPU8YIeyivnHHv2a68x11Cq7G9lzJay0epFaCT+jEDmMN0+/guT6fDS54/ALR4UUONgV10x2wpMkMjvpVnrzELFYVrvkK79aGEW6ch6D8YDTsarF9fxuHxISapfOX6F+RYfRuiWSj0WZYY54MSBi7vUcfMJgfJfAHokTvWKhJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589187; c=relaxed/simple;
	bh=vFTFIe6I8r5QCp5mBI9sujzCZER4Rq/NgROeYBJU/sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEg6iqhkc5hnYzI7LqR3oRVtt+NzAyzNEWGjws+1GEMwe1M1TMamdMpLuKP/5crohimgXLp57ZOXJouXGTKrfUnDPXNItDJ4hXYtfo5z7Hv+F2IBJoPqzQooSLa9YUEODR5i2/FQBF8POvjQAisEbWPVDdzkzfbAWl3zo5gy+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0hDgUl1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-341d07c020fso1919402a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 00:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589185; x=1763193985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ph9zR1fvONGEfCwcooy4q6QCBsuZBG7EiBPZ3ZJSBIk=;
        b=e0hDgUl1DMC/HP02yS/mIp5QGVGGxFk2LYfieOlVQ4Ycok/D0d3VccOlhQfp6xve4s
         CS7vFa85kRnS6vdpkKNuAgS/b5XlM+SOA1PEfyxJAmOpAM2Zz9l0jeRNhYbHDKPhxc8Z
         UHmFi8s27u3zkduPhXSbZ8pm56fPDL0U3C62w2aJepQs8czK4lqXdgNXnzXPOY9yGL1v
         lndOvBLARPq2xg5feBqBECfKRADdvxY7oYbPC6ngOA/nfaQhz53a1okNxE2Jta/twMyO
         klyYCWgGu0EITC4Bi11hiEi1zphcwKi+a5JRlJY5IjdRbnm7eKqJSXWWA+rdhmcdXO7c
         9hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589185; x=1763193985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ph9zR1fvONGEfCwcooy4q6QCBsuZBG7EiBPZ3ZJSBIk=;
        b=IF/rATaQZMUKp5+BQztTdG/wy19Lkb8LqXsBDi78N8mmvXFK7w/nz63h0/Eqb90Uhx
         4K/o6Gj5KUX3wvi6sO15qEvbMOUciDZFpAwkrF+1H76h1mjh4h63NEIW5vcIEQfZOFy4
         eonyHTRBuAKKbxL45qYSxW8CEbdUR4vtHu3m1UnO0pou/hlpEtNyGyNU9OrFwdFBcjah
         /ZqqvvKoZkXswBaWrRvrvXi/4lopc4T0qDjhHYxQES9rBSonGNg8EkczfminmifQu+LE
         3lOe6ZJiKYkNQkpZh55p9J91OALtEGJUd1jrufEd36PS6BNBtuiwLjRAV3gVWZgwTtjN
         LEtw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ/rBQo2CZ+AYXO+y3+dgvzBNxi4rPyrMsE2pO5rChdeWYFZxWXeJc10ekZMVi6b2ZLctXp8fwjmcOh7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwvuuidNq357D12BHEf6gm5gGO/oY1lPU4dK42QCtxR1g4kGW
	n51MgxRKi2k2f8kjdAMr5N4NaEKc/xQEod0PGVKG3FrEU7Fdb/ChYAOV
X-Gm-Gg: ASbGncuisXhSc7WxG2qPtJAz9lp/RzHuIA0zPWDHTetWxAoVJEo0IQYkKcYd0MLTHXk
	L/Uk/fspHQSX2cVjARI+elLoJsHHtcPWaEKsqJbIHad9hEgCuP62UVALGxJ0qK0sqkgjh6fKM7A
	yu0Q4dnzUcegOqcMkYufhDdvLMs/qwR4LwFVbHTuG2e2P65I9/4oXBVmlmCtXpVKSoFqdhNQrSW
	A4+Ky4Pzi8+34n4yHNQjMiDzjXKvtTcy+Osx3szFTBW0Moe1aUmaO6Q5y/cvzcgFa2JWwu7BqIb
	xLlm8qv9ihrCaSX/iftqjXxdOCk1E38UrcLFwtjQcA1KjoVW4Ux0m8CGVc7xoICfE9QdwZDt6Rn
	zszIA/rfjEwcBv2FudHU2RmbKcvOzt5dWz1juCwDr8fBgQPojs0SRU9TGKUpQuE5pHQqNLybAHm
	kSzA81opAAV/gJ0WgT/ZsT/XB9srIoPluDnbZf/RmChn3mvQBEZuhAfYY8kCwegXHK+YM=
X-Google-Smtp-Source: AGHT+IGJfdh18b/VLG+FNXOhiB/u0ohyfs/EsEy0a88QiPDZTbxqJDMvN0IIjQCopB9ZzCCa4OleMg==
X-Received: by 2002:a17:902:ecc5:b0:295:565b:c691 with SMTP id d9443c01a7336-297e5629152mr26786625ad.17.1762589185138;
        Sat, 08 Nov 2025 00:06:25 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b8ffsm81262075ad.21.2025.11.08.00.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:24 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 52B3311388DF; Sat,  8 Nov 2025 17:06:23 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 13/13] um: nommu: plug nommu code into build system
Date: Sat,  8 Nov 2025 17:05:48 +0900
Message-ID: <ae577803cd463b830d120f15b316ad8c373d4735.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nommu kernel for um build.  defconfig is also provided.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/Kconfig                        | 14 ++++++-
 arch/um/configs/x86_64_nommu_defconfig | 54 ++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 2 deletions(-)
 create mode 100644 arch/um/configs/x86_64_nommu_defconfig

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 097c6a6265ef..4907fd2db512 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -34,16 +34,19 @@ config UML
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY # Needed for line.c
-	select HAVE_ARCH_VMAP_STACK
+	select HAVE_ARCH_VMAP_STACK if MMU
 	select HAVE_RUST
 	select ARCH_HAS_UBSAN
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select THREAD_INFO_IN_TASK
 	select SPARSE_IRQ
+	select UACCESS_MEMCPY if !MMU
+	select GENERIC_STRNLEN_USER if !MMU
+	select GENERIC_STRNCPY_FROM_USER if !MMU
 
 config MMU
-	bool
+	bool "MMU-based Paged Memory Management Support" if 64BIT
 	default y
 
 config UML_DMA_EMULATION
@@ -225,8 +228,15 @@ config MAGIC_SYSRQ
 	  The keys are documented in <file:Documentation/admin-guide/sysrq.rst>. Don't say Y
 	  unless you really know what this hack does.
 
+config ARCH_FORCE_MAX_ORDER
+	int "Order of maximal physically contiguous allocations" if EXPERT
+	default "10" if MMU
+	default "16" if !MMU
+
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
+	default 3 if !MMU
+	range 3 10 if !MMU
 	default 2 if 64BIT
 	range 2 10 if 64BIT
 	default 1 if !64BIT
diff --git a/arch/um/configs/x86_64_nommu_defconfig b/arch/um/configs/x86_64_nommu_defconfig
new file mode 100644
index 000000000000..02cb87091c9f
--- /dev/null
+++ b/arch/um/configs/x86_64_nommu_defconfig
@@ -0,0 +1,54 @@
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
+CONFIG_BLK_CGROUP=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_DEVICE=y
+CONFIG_CGROUP_CPUACCT=y
+# CONFIG_PID_NS is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_MMU is not set
+CONFIG_HOSTFS=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_SSL=y
+CONFIG_NULL_CHAN=y
+CONFIG_PORT_CHAN=y
+CONFIG_PTY_CHAN=y
+CONFIG_TTY_CHAN=y
+CONFIG_CON_CHAN="pts"
+CONFIG_SSL_CHAN="pts"
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_IOSCHED_BFQ=m
+CONFIG_BINFMT_MISC=m
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_BLK_DEV_UBD=y
+CONFIG_BLK_DEV_LOOP=m
+CONFIG_BLK_DEV_NBD=m
+CONFIG_DUMMY=m
+CONFIG_TUN=m
+CONFIG_PPP=m
+CONFIG_SLIP=m
+CONFIG_LEGACY_PTY_COUNT=32
+CONFIG_UML_RANDOM=y
+CONFIG_EXT4_FS=y
+CONFIG_QUOTA=y
+CONFIG_AUTOFS_FS=m
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_NLS=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
+CONFIG_FRAME_WARN=1024
+CONFIG_IPV6=y
-- 
2.43.0


