Return-Path: <linux-kernel+bounces-822081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1869B82FAA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C63D4A347E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29AD2C3261;
	Thu, 18 Sep 2025 05:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNs9QuMx"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733C62BF3D7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172619; cv=none; b=DulfBv9i1tSB04KUC/Oh25bC7XTVJLK06REepBNQRKD7KtMp0hs4vTsHRwiBjOYtMsuRcPTRijTeSnsY6EKUQ4ORIyiWwc2YBW7uE4LkrHKtBJckV+iGDhE44EVzmKEw5/rZ0gJkL4eKMU0Kga3dKeK07eXx+jg0XRxqzd87X94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172619; c=relaxed/simple;
	bh=H4z+K4nZbNEAC2aE3ZetyeCuDlJ6EyjEggbl9qc6cyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ev3Pw8Q8v+mBQIAQgoFB79IJ2mAKMJmtp7dNb5jr6EzjGBC0SKwd/GJ9xfG2woBU4fJX3pYp1m+zuzCSA01aAO7Av3J0IlhPVoUkyxtV2nTjGVuG/x0qz78eqB5nvuM4/D84kQa55UMNeiNCbajKIKk5DPGEjAa51rcn7vKKDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNs9QuMx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77256e75eacso521175b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172618; x=1758777418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weQA9Kmk5Cj0pX9CPL2mzbHMoGKA1UTMBAigZCiGmmg=;
        b=VNs9QuMxO7x4klPLKHvQHvCSWba6Dorc+h0e2j0mGPTtPZpmWh0w/xjrB5YxE1xkk+
         c5XugWC54GMx0EhGNdLW0y+mPyFlBVrH2W20O66hTF7zrpVz1tOJfkzNhN5LQxOefBGO
         fKBxySQsFeRjlcOEPmIzEXddQOIatQ30zml1AuG4aFz3QHsGznb/tUPDMjKTfv1D2NLe
         5cAMHQcuS4cf0HW0iWoQ9VxabPY2vTCF9rj82cayGqTZi20pm267yP9l97GCXfGkcZ41
         zDdsyzJbnQTCvtPPo2sg5on2j7Jgj1nGrMMrEESdA+gYq4F/dcdP+bhesI8jTNPwl20C
         4Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172618; x=1758777418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=weQA9Kmk5Cj0pX9CPL2mzbHMoGKA1UTMBAigZCiGmmg=;
        b=LqLyz2DGJ2E5YjGYgDmZKhUyj5BLBYAYwEdR56mA7qxOMi+z9AVBmeFWDFVEUciUMF
         PHS1FxA737+ZUOW+1TPmIYkGMzgoyVi0XFxvBNC50LOfTYD0YByuP13C9ng+qOYfgO0A
         jZiuuSXtJmYZPVlIrp6aDQWRCRWdUlny9tjostSKSHgtW6Az5ja2A6x2SKX4L+fEqe16
         MiqORPpENio59LS4KPkWCBlYd8atpyh0ilpZe79m++gtp8UsWJq36AINP5HRhBGyT591
         F6dvKiFlmNQzbumZYyn2qfsvQHIvw92PiE9M+XOyqSSZb/Y5Aa6MJZCIfXiXgf+xst2Z
         yT1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWd+OpPt6i4utSkYkC/bEAutZhzz/0ptQxRlPOu19qsXmvbOKm8Gdz2X3aQgqK5AGrNUqTH/NWCCEihdsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwANz3owbsISd+VvfZ/GF6oVdIGqDniT4A2lmD3BvCB7IYM1p4k
	oZulCtQYHNvAAgF/B15v5C9Ryebv/2/fMARoaRVL3yQvYueSFNWX4/c4
X-Gm-Gg: ASbGnctPdt8GTuPmSdz0qtW+2ZjTvIZ0a3AfXydVljN2woC0RlqjwWZyHQ7FGxPP9DC
	yVPvovzglBeJavcCFCuZO5uMfMq+6k3wsub7jDKSLS2I5hNRKBIROucdIi29PmDaIK4FKTObvNC
	wAmFabN0kDtzAxmAnlnikeujygRLSjl93nLFUsBO4Z+oTUV3AhKfOmHTQpNc6stQSo/8vZ4ri2Y
	y/4ytwtqcFWZyGF/55NuwkGK7HLnrk0cddW1lRufTY+OwBGqmsEyHI/K1FZha+BF5qavELpkg0L
	OJEYMbJQa4XvRIIIFnVvJpoObrNvoekU2Hz62VrJAwHbtKKFSV4sIXxw4XrL73d26nzTpfTAZWP
	YiV+23aK4YTsQXEPog+CBo2zz5OucaSLRH8N+L9eW7rdzk1oE1CB8s47b4coiXSRSMSZfFNEup8
	npmmiB22oi6w4=
X-Google-Smtp-Source: AGHT+IGZQwtJMyRnh3Z8k0XoyJf1CY4mOdwaCuE/LPYRa5FoHXNH/TLQrn91zATBe14rAtpangIWQA==
X-Received: by 2002:a05:6a20:9150:b0:252:76ab:8beb with SMTP id adf61e73a8af0-27aa99bd366mr6383648637.41.1758172617633;
        Wed, 17 Sep 2025 22:16:57 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff35afa1sm1149269a12.7.2025.09.17.22.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:56 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 2AC351061EFD; Thu, 18 Sep 2025 14:16:55 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 14/14] um: nommu: plug nommu code into build system
Date: Thu, 18 Sep 2025 14:16:07 +0900
Message-ID: <8a9d6dde30441e5605b864d99977e6cf5842205c.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
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


