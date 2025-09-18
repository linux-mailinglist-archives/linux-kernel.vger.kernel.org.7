Return-Path: <linux-kernel+bounces-822070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0E3B82F89
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885FC1C240F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D105327E043;
	Thu, 18 Sep 2025 05:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzUmC410"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE2D2749E6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172591; cv=none; b=qVHZupl14BolKmAYb3epQ10GTWzNidQFmcrUHDePnJB0QTD2756gYc+68cHbdS/McOdmWmBJCZo/VCWXJEpBooOvZdtgcIyR1pKVyKjQhppfmMxhz11HCMA79yqJVeCzIMqKFWMwoU1QdpNDVX5ObuttgmiUWby/Ord2tmVzMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172591; c=relaxed/simple;
	bh=byCqW4A9iLem+ANWjBVScnY9Hghuk40zDm3UjEWz6rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2qddR4HBdG09AHxtIb+xn5sOz6phBGbvmkO4i/SSC8LWR7oxzLrpFrqknXVo4NYoJWbe+83ErVs5fq1roHyXbIkBSQbEJD/qeOR0KX9FPXf+RrOr5naOyFQEQOCKSXZEUoi4pI0iZu1eB2mMyLAIojCNqwlwYHAiMDLNx0/s6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzUmC410; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7741991159bso808768b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172589; x=1758777389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v5kFFhzG2vuvgO+enxcsWpy0aeKbEC/zaWFYDqr9sQ=;
        b=jzUmC410EjJqpdT8xplBojuB/waBDGx6PZOMHcjkBKpoigjewwwb7JEorDvs7frdy/
         8Vs6/CSebnZiH2bObePgbgMeH0o9h4BY1QN9QTYBIs5+6JTSzllNOS7L1LDWKxGNCWqY
         TIZkqScjx3jBPoHeqeXFhA+7adreoTW9JU20y/YDQMlEqqLbBQmL2AjNzjfJ8qO+RPd9
         grtaCEhN7Bf42ct/Sf+o1UWLz8n9xAOwDM/tRdQXPrLjwW0+LWHgdmLh87QAdqJJ4YmO
         zIYSqpydgVeQrYmRrykp8+gILNUTns/1/CnvRx7b7FOUVbH+wq+JNXc0ntpdK+3alKQD
         NZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172589; x=1758777389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5v5kFFhzG2vuvgO+enxcsWpy0aeKbEC/zaWFYDqr9sQ=;
        b=kEmJO27YDkwWqEMBAPyHBCBE4orjCyDJ7CTiUV7ZMA3QupjHbF+Z1bLMsccOULdsL2
         9+dvGk0H7g2sudcWnCKjnKTU0C4dBxH19gMN5Ox5eCNtghkjQPyrp2dE4juQ1CuW7NRx
         aDOCKZj53zMXupLE4tfTFLIeoF/Ghs0+kuDjgP7flccFynrazp59Yx7VyFBYRbW2Lj1d
         Qsl9epW4K++AqakJrwGBGmfpfW5lVtiyXd8RUAJ4SubTq6h2QLTDmGQ/FvCtqBJv30QB
         Sm5O3288NEjPhUK638AAJJ0NkwpLkdCRkKxZF84n6+rGar+iu9aR4pD2ERH1TS5n80aw
         qNJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfIx8azxxWenGGq0s8KoPQfk5pXy4AXjTcm3c8g3lFhF6dwI/D0mU/KIegGNiE7zJ95DPrpE/jQrQQPlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDcBFmRHtV8Qsliu8SISUGixX/lg3QYNeb/oT9dEVxIG3amkHT
	Gv8QMiI9NiB372uavxczFKmsvp1VHzUmyl5tmj895Wkf2jkaqt8JO551
X-Gm-Gg: ASbGncuvEoDldGuovRK9RdEpmu1wvxAaaJvGT/QuyGz8lIVnZ/rLh3mYnlZoy/qgv5F
	bEGU3UH9rDBFJnSSBBCNokTd5GaPPdQliySivDJQvQHFo7DUejdJS4z8eXqOlHmO5fHtEHPXj+x
	TMxB6G7m4xjkmEL/8i9VBi2wp8Lhi1QOeGR4uM7uupDNeRwJyoFLH+sfrZk12d4rKDkVRlJPw6c
	1FXRWnBM+R420Fp28Fg/KfJRggjsB9h5etlB+MOszHWwxQKqYxKFtCLN8xyhu9WfCTwrTVCJusc
	FBqemnE+dMpAGkdtSF5zDPwCRA/rjH6Ng/gZkGLSnSpXHhhpglDrjiBes+BnTn4jW/7sSxArA+H
	CDWHpcUvzDjMWePe2Ys7tlQYBFOn95Mwsvm7goR4XPcYSCzEq5jyXtb0/SAIm/kJXqBhd3l67Pl
	IP7WzUeBgfIYk=
X-Google-Smtp-Source: AGHT+IG8EEwYKDe4752fihuiPCe3VzAnJwEodvoJBXr6/jhOceuh0a1JLYy/bZX7937V8Cg9Tlqlzg==
X-Received: by 2002:a05:6a20:938e:b0:25c:3979:ec83 with SMTP id adf61e73a8af0-27aa99c1a45mr6611727637.58.1758172588580;
        Wed, 17 Sep 2025 22:16:28 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfec3c32fsm1027923b3a.71.2025.09.17.22.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:27 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id EB5551061EE6; Thu, 18 Sep 2025 14:16:26 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 03/14] um: nommu: memory handling
Date: Thu, 18 Sep 2025 14:15:56 +0900
Message-ID: <5b248fc7351c6228f2a2bb9a4d33fddf3f1744ed.1758171893.git.thehajime@gmail.com>
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

This commit adds memory operations on UML under !MMU environment.

Some part of the original UML code relying on CONFIG_MMU are excluded
from compilation when !CONFIG_MMU.  Additionally, generic functions such as
uaccess, futex, memcpy/strnlen/strncpy can be used as user- and
kernel-space share the address space in !CONFIG_MMU mode.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/Makefile                  | 4 ++++
 arch/um/include/asm/futex.h       | 4 ++++
 arch/um/include/asm/mmu.h         | 3 +++
 arch/um/include/asm/mmu_context.h | 2 ++
 arch/um/include/asm/uaccess.h     | 7 ++++---
 arch/um/kernel/mem.c              | 3 ++-
 arch/um/os-Linux/mem.c            | 4 ++++
 arch/um/os-Linux/process.c        | 4 ++--
 8 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 7be0143b5ba3..5371c9a1b11e 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -46,6 +46,10 @@ ARCH_INCLUDE	:= -I$(srctree)/$(SHARED_HEADERS)
 ARCH_INCLUDE	+= -I$(srctree)/$(HOST_DIR)/um/shared
 KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/um
 
+ifneq ($(CONFIG_MMU),y)
+core-y += $(ARCH_DIR)/nommu/
+endif
+
 # -Dvmap=kernel_vmap prevents anything from referencing the libpcap.o symbol so
 # named - it's a common symbol in libpcap, so we get a binary which crashes.
 #
diff --git a/arch/um/include/asm/futex.h b/arch/um/include/asm/futex.h
index 780aa6bfc050..785fd6649aa2 100644
--- a/arch/um/include/asm/futex.h
+++ b/arch/um/include/asm/futex.h
@@ -7,8 +7,12 @@
 #include <asm/errno.h>
 
 
+#ifdef CONFIG_MMU
 int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr);
 int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 			      u32 oldval, u32 newval);
+#else
+#include <asm-generic/futex.h>
+#endif
 
 #endif
diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index e9661846b4a3..9f30c69e5278 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -18,10 +18,13 @@ typedef struct mm_context {
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
 
+#ifndef CONFIG_MMU
+	unsigned long   end_brk;
 #ifdef CONFIG_BINFMT_ELF_FDPIC
 	unsigned long   exec_fdpic_loadmap;
 	unsigned long   interp_fdpic_loadmap;
 #endif
+#endif /* !CONFIG_MMU */
 } mm_context_t;
 
 #endif
diff --git a/arch/um/include/asm/mmu_context.h b/arch/um/include/asm/mmu_context.h
index c727e56ba116..528b217da285 100644
--- a/arch/um/include/asm/mmu_context.h
+++ b/arch/um/include/asm/mmu_context.h
@@ -18,11 +18,13 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 {
 }
 
+#ifdef CONFIG_MMU
 #define init_new_context init_new_context
 extern int init_new_context(struct task_struct *task, struct mm_struct *mm);
 
 #define destroy_context destroy_context
 extern void destroy_context(struct mm_struct *mm);
+#endif
 
 #include <asm-generic/mmu_context.h>
 
diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 1c6e0ae41b0c..b9677758e759 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -23,6 +23,7 @@
 #define __addr_range_nowrap(addr, size) \
 	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))
 
+#ifdef CONFIG_MMU
 extern unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 extern unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n);
 extern unsigned long __clear_user(void __user *mem, unsigned long len);
@@ -34,9 +35,6 @@ static inline int __access_ok(const void __user *ptr, unsigned long size);
 
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
-
-#include <asm-generic/uaccess.h>
-
 static inline int __access_ok(const void __user *ptr, unsigned long size)
 {
 	unsigned long addr = (unsigned long)ptr;
@@ -70,5 +68,8 @@ do {									\
 	barrier();							\
 	current->thread.segv_continue = NULL;				\
 } while (0)
+#endif
+
+#include <asm-generic/uaccess.h>
 
 #endif
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 106a2f85ab5c..4be1cf240d71 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -64,7 +64,8 @@ void __init arch_mm_preinit(void)
 	 * to be turned on.
 	 */
 	brk_end = (unsigned long) UML_ROUND_UP(sbrk(0));
-	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
+	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1,
+		   !IS_ENABLED(CONFIG_MMU));
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
 	min_low_pfn = PFN_UP(__pa(uml_reserved));
diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 72f302f4d197..4f5d9a94f8e2 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -213,6 +213,10 @@ int __init create_mem_file(unsigned long long len)
 {
 	int err, fd;
 
+	/* NOMMU kernel uses -1 as a fd for further use (e.g., mmap) */
+	if (!IS_ENABLED(CONFIG_MMU))
+		return -1;
+
 	fd = create_tmp_file(len);
 
 	err = os_set_exec_close(fd);
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index d000907ec796..bc598e661ec6 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -98,8 +98,8 @@ int os_map_memory(void *virt, int fd, unsigned long long off, unsigned long len,
 	prot = (r ? PROT_READ : 0) | (w ? PROT_WRITE : 0) |
 		(x ? PROT_EXEC : 0);
 
-	loc = mmap64((void *) virt, len, prot, MAP_SHARED | MAP_FIXED,
-		     fd, off);
+	loc = mmap64((void *) virt, len, prot, MAP_SHARED | MAP_FIXED |
+		     (!IS_ENABLED(CONFIG_MMU) ? MAP_ANONYMOUS : 0), fd, off);
 	if (loc == MAP_FAILED)
 		return -errno;
 	return 0;
-- 
2.43.0


