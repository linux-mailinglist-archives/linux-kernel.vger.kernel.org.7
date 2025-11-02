Return-Path: <linux-kernel+bounces-881720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6F0C28CD9
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 10:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611B21882C97
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 09:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D312765D4;
	Sun,  2 Nov 2025 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZLPDNZ6"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BA2741C0
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762077008; cv=none; b=FuR0u7eV0cjgmS2aNhgLSPHIIBRrO7xyHIRAQrAE2OG99HpJAUA4++7HNq5CSFoaLcqsZC5/ViYoa+BtK2Nxe65vpChJNxDViinHzxEZ+kaobmfM2tlmd/d2bTpknT/oE8hguHhXrtPYsAY/tvJs8P8iIHf5DWxNhwxO1Uy02h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762077008; c=relaxed/simple;
	bh=vFTFIe6I8r5QCp5mBI9sujzCZER4Rq/NgROeYBJU/sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8GvbNv6CuNl57ScUcq5d0CUGZrySZejHQD/uYbpMNHknpF585jRPRQcVy17haZhSEBW+4djbwjXt2EnczzjVOyPDYTg478PmwI0nVxrPtL894dnhPEYzAXqfUQ6n4JyafjWQVJ9FJzuLctBAxjYngtEcjuTn2RPgdio881Y5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZLPDNZ6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29555415c5fso14400865ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 01:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762077006; x=1762681806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ph9zR1fvONGEfCwcooy4q6QCBsuZBG7EiBPZ3ZJSBIk=;
        b=AZLPDNZ6Sb4iLrTPxDBK0BKNxnGdm1+TdPurFqznSQ00qnW0MFkEqFrW9ZuAUhIKMa
         9xZ9ya20Yxb/72hKquoXTCBVvdfMqxPN6Q7Tou9FqTFV8I5pD1VTKFcsETjtUbsJ/Koz
         oR4nxXzjjcmb9cZuTxKfsGZu0dc+P3lAoExr5c8gH3/ZYU9SD0DuR2rbZWgrwbRyT0wg
         cino+t/XvXdUNYwxITLIudH4jN8odWAbs8X1pOVGmqFWcvH2HvgYkuq+ELKDgqg1Edbr
         pbRySwANTRKzu7fUs2XdNYKwj37UrUBv4Ys7cVKI6K4qc4orVoWge4n0rtLZp20PmYMU
         q4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762077006; x=1762681806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ph9zR1fvONGEfCwcooy4q6QCBsuZBG7EiBPZ3ZJSBIk=;
        b=Q/pUPp8eNb4Aw5P8S4j1AAZ5d6f9cCJBXyzU+VZuZMICjuAa0WH1ZBMDqhzLWVVr1d
         FBjJ9oDaE65qx0sOr5MF9WQLn2u1F7lHbmkPM5ag8wX3cjpIinH0O0G2yRYWrhF+kHQh
         mStJWPTWQ3MMhJrwjYWunL17fCvwko4xGaqMDKqGuCRMn8epXuwP2NPiX0+ARnlj1SxM
         +KliLvDO9U9L5UO5m6tXXD32SrU/xW/9LAclp78x6c0XUZJyUruBYcoqaUL1ZRXhH8zs
         5GhaA14BbVsq+Ple5JZeyokHTfS+OIv3FpUIdT0RdueWvA/OhV16kz+HvHer8WfvbGRd
         mA4g==
X-Forwarded-Encrypted: i=1; AJvYcCWO5a2Gbw5Hi5LBxLb13Cx2RIjECjOr1nXPNRXRpLnd755OujZ3umVrjKZ0VBMWXFkfjPUpEvONRPW1zDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFWiQSEK637BEdjCctzxj9OAh9LpzBZzjdz4mLNNSBOh6i59rH
	urKZlGrzpSTzg5cNu5jgqo/Xs8tp25TCLuRolfrht8VfNT/4p/Eb7t7z
X-Gm-Gg: ASbGncsQM8XxkaS06fiwMvObc28IDXoCZz2p1jv1xBOILtGJHQ8r+EalGtcdV1mDWej
	B2wbQfXPSOmvim8DC42Bf7AtQndDMIF4QV8Pyrs2W7qdO2D8uAG4MW7iISy7DmNuaNGPkCjYOf6
	LNpfJQNJ7WceH1KEIoCc8BMWNKI3nJuVkFDFFDOIyBbRmAPLt9wF6wJlORaBUus/ViQ9m0+avou
	TsPPw/qZqx6+I3EaaM8X2hqMcDOvmg0gHgRzzSUjHSV1IzXIM4m9TVLaPKCwZSzEGcvp63cmDjU
	DLXzceXBFCm+2lYxEbiZEMwuTLgFIQ3wooJd5+AulwJ+IVgIJ5uq/SZ5uVJBgEQsMFsAdvm7zjD
	Ks8rGxD8X0cTOhzCYSXRyunDdGSvFT8ocsQVsinVuhp+O9hixZdLnkLO0Db/gvKcuRtxHes4Pcn
	pa5W8Z4skSw6UHZf9/2I6dXTsO8vnq03fWYQaVLHnxQdChWBwWyPYssOpHN08RdsAu+wQ=
X-Google-Smtp-Source: AGHT+IHUuWG7Ov5kBT/yNTPJH3xuxkjK4iSTaaCg1YaGK1t1FQzTnk7AwddqLgQ2HelyS4KrdoJ2gA==
X-Received: by 2002:a17:903:2285:b0:290:2a14:2ed5 with SMTP id d9443c01a7336-2951a390655mr107666405ad.4.1762077006004;
        Sun, 02 Nov 2025 01:50:06 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2958dd23059sm18342285ad.47.2025.11.02.01.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:50:04 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id B73931123817; Sun,  2 Nov 2025 18:50:00 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 13/13] um: nommu: plug nommu code into build system
Date: Sun,  2 Nov 2025 18:49:38 +0900
Message-ID: <efea26f968ad9049116cee46fb55f450df50033d.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
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


