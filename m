Return-Path: <linux-kernel+bounces-822243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56331B835EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E47657A5523
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2432F5305;
	Thu, 18 Sep 2025 07:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiJ9/ACX"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D262EC54E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181177; cv=none; b=aM2bt3A2zKDffWWzOkcaA1G7a2KCDvnyP1QYI2VxxxEGPyHYwgxZ8Qx8mq5Sx3kXd/McXT4aggDK5xRmAvK7YPKSCdCUkxgCiWJMCH9U8Rtd91j253MtT8fK1DjzlkEN4p8Ecco4qacrpN8/bR2zp6a4h+THSfV5yDPeu9vlp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181177; c=relaxed/simple;
	bh=H4z+K4nZbNEAC2aE3ZetyeCuDlJ6EyjEggbl9qc6cyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAV+d5IdxdWOQUXIo+UvET8QqjEOkxcksTDmmQDNvNV8SGgvYvKBmDnWJAr1cWWITMkiqi0oXgTqJs5J6XnCfty7FdDvCn3LggRv14vygCZ2mPCChTlE35ef7oZm3ptSERxHEbesy10MtDapG3DxkRpJzCC8gf72mNX0wsmSo7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiJ9/ACX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b55003f99fdso448771a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181175; x=1758785975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weQA9Kmk5Cj0pX9CPL2mzbHMoGKA1UTMBAigZCiGmmg=;
        b=EiJ9/ACXgXGN2TizLxDXvrcFltR0Sesj3aUtfBSCdAxpjcjzOi8zWFFY1vAlr8hMFm
         xT+xIUp+mULfVIUVHIRWNSu8W7zl/XlK4pST6bEFLgALtxl+vU6dq9LJFHreO5YIzp5H
         0oLlO3OfRtITfuosE3iGFMX9uSQE5wZt3dQ44/KeDDPFPLo7MaCtsZe6Gx9DdMRlttYU
         zppAvYCG8Z9Yf+hQP0E9oWYMBG2flDKbYQxPwIsXvbk4Cj8KAWyR0SzvmyMZekHghB1G
         T8zIquOt0Nk+HufY6B1y6ZaQoHWq+Hgc4sAnj8Fbeg/TiXvT1JHWUDwGzTElVvnHoUOb
         Ra0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181175; x=1758785975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weQA9Kmk5Cj0pX9CPL2mzbHMoGKA1UTMBAigZCiGmmg=;
        b=nXCEX93izthUXSLL+PiG/WBNl4erII/wRwodQacOqrgatsx75KoIPLBvo5jB2C+Ty2
         OqLtNEroQGXFdIF/UK//Ekr9bNqQqEWIt98cgxnVShCvf1aaj4xylWP2PY8SEiRkT9+P
         kBl1f+TSw4iEXsrIQcHduYpOAtPpKvORaIfAvbQFd2HDLVP+qgMWfaWl8f32zXUR4tve
         iVXMsZ1EvZtv/lVzk0TUeNia1p80bwxMJQqq7Dbkm+SdutSj7rXc2INNic8Jz1Z0BdT4
         wtm5lBY2rWfZA9/7VmJdn51ESN8xbCPhHHLREbc5iQzT/mujFVjxr+h6dEkZXa1oGXoH
         dlhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcxskEx29z73AiPzFBHYE5wAyyE/2yKI4GM+6OrZ+6GbOXjwA96++AyjCAhnhLGN4amHhDLlef7Vl9zfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvKGGtqZQ9N6EPVlxfrxYNSPXu6CqjDpKPrmSv+RvYgyHkQv55
	IAy99H7Q4qHqmkv4CbHH4kQwH1t6wvyVJtIKAV2IlzX41zC4fxmiOLIQ
X-Gm-Gg: ASbGncvpY8NjauZevV74RuKi70CGN4LI1c0NqSR2Jti5fR56g37K9Qgp2j3coV888ki
	u521zQ6Z7SkV6nffDhcKC6Dbd2Gls/E8Zv+p2YQKI7ei09OLORDpzz0AGz4/nAO6nh9hFZUPlva
	+G6jk+dRoPslJBS8Uourmm1lHcssHcXtLSDgW+cuWJYeH+rKSFCB/9tziCxDW4LzmYHrnArK5R/
	BKfzsTj9PZ9ETR1EwAUj/7Hu3wkR/QMu9Ky6ST7GS5oyLitQsqL90TvnzQQM+pcSC6u5KhtOR6w
	Lq5YFHMXSUS4ULXEXDBi6zxv6EUJbljreI0ERoXPhg2/JG4S+UhULagPdSmh0vo6RKQsFmL7jjE
	G5h85/+9fwrecFU9BrcxM376SEjA5lxyBuoOhjnNLxm5H4bA6zOQL0jsOzhha45bxOoM5Vftlhi
	Tmv3GXZpnnKkw=
X-Google-Smtp-Source: AGHT+IE+HOwpQOTe1IjwWUlVdtuE/bhc6md4K+/CWF49tmVYYKG4ELGdQ5lhm0IUR79AdsHRiU6vaA==
X-Received: by 2002:a17:903:18e:b0:24e:e5c9:ecfd with SMTP id d9443c01a7336-2681390328cmr73932485ad.42.1758181175568;
        Thu, 18 Sep 2025 00:39:35 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm16679445ad.90.2025.09.18.00.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:34 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 3475E1062114; Thu, 18 Sep 2025 16:39:33 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 13/13] um: nommu: plug nommu code into build system
Date: Thu, 18 Sep 2025 16:39:08 +0900
Message-ID: <fc8ca16be8d409c82acd2bdb3e62b18ae3afe3ef.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
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
index 8161cc5ae6f7..b3d2716836ac 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -32,16 +32,19 @@ config UML
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
@@ -185,8 +188,15 @@ config MAGIC_SYSRQ
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


