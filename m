Return-Path: <linux-kernel+bounces-822233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F624B835D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE65072144E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD902ED853;
	Thu, 18 Sep 2025 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFtKMmbX"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16772ECD23
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181164; cv=none; b=Tz5EsKZNNG0htphfphFmKZlviD9AznPXG0Yk8+QTc7Ln9DjTqEi0MwtTKV6ELIqOzaveVZYt5C03zI/VJ0E1MtQhCtFqNIY8fwYJWlp1/DYr5e/ledyJ+bL2FsbqVw3j0dYiprbDxM1Okmbhcjaipw6DxL/TQnckPXWyzcY2XdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181164; c=relaxed/simple;
	bh=byCqW4A9iLem+ANWjBVScnY9Hghuk40zDm3UjEWz6rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYKlMM9Gqk4UjGYgL1a/QQGV3K6pFTl6vpbY7pOVk4qB8IqYIst3LxcfSexKgsahWJYHFz1R+Z2xMkkv9JKvFV0xrc25OmY8k/WFMl/I4TAukbeobiVCZG0nY9ZZsHfZzUohfw7+Er+4m3WMFk0ZLre6qzXxMdjaRNtDgWwO2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFtKMmbX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-244580523a0so6911585ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181162; x=1758785962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v5kFFhzG2vuvgO+enxcsWpy0aeKbEC/zaWFYDqr9sQ=;
        b=JFtKMmbXu5gIYoJl2d3yPr3rsWcdGc9Cs4p2N1zDDoHPniVQMaQ1RXqv58DMTiJUlu
         SgXGx+O1wkchFNGkOBCHIdMe6AQMD2rfmeLkA0ohzFMjfWApEu4cDUJByA2pLdob32xg
         h3RX3aj3DQBJKDdgtoiKIbMOuXyeRCWxIymNsPohOurJ8gf9ux40/HEH+wiLQEG943+s
         4foxZtPwyw0I45uW5VbMigMHMQonPpToZ/UDfhuN9IJGPqk+M+z8cBzQ39RUIUivk8mA
         SSIWAq0G3M1tbs8zv6KGX8O0pu7ZJOl2s3fMAUlStIY1RByfrH74J+IBDvfGtwKl1XtM
         kuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181162; x=1758785962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5v5kFFhzG2vuvgO+enxcsWpy0aeKbEC/zaWFYDqr9sQ=;
        b=diSEbYUX4kkNq2eHciPrH5udDccE6mWnNFaxV2h71dS+D1YHA88rCnoGDFRJ+LQX9W
         EEaQbGwQhlWAxRwrjSTEmj5tbMYqcaPT32js2fA2RAQrzrEewKUWF+Jb+mfBqsPjA1dI
         ZKyKCbswKFxBH4nnvfsRbJyXLzGucZb7ZzNotn0LuNTF6TLD+WtpGI1yOXN6kZ5BTXcK
         V4bawI1h6hvhG1YpzT0iHfZfMou+QQt8k1LbxLm7lOsK9xcw8vtZrZ8FpgKmGaysXfsl
         12Stz9YWzX+JrHPqZgd7WABG/l3yfFDD8RXDvh1qmgHpsayCs1542hlfh6GRWgKHk0Ic
         uZOw==
X-Forwarded-Encrypted: i=1; AJvYcCWnJwNVrQBBXGofLx/SEgsIwqvEQL9NiWPGIx2CrYb6PSdjhv4Y8Hvnk3v2rhUquXowwnMVLYyJKCwgpRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiitvNXJiN7B+EfjoBRBBpipliXt/uz1w2p+Jk5fknQfTGOU82
	jKv5W5QzNgaV9iagjoJ9U4uUEjoo7Bd/xfidY3bINmUSeh6HY+d6gOUW
X-Gm-Gg: ASbGncuHzNwkiIQwgRrbpl+gv0/KAHfNvNEU0COrzt9FRTA8dqSLIefivbqM2U4BRcK
	pAKOShy1ekIMHH97+VLxVyK1l2yhuYJ9otnbvtfDpAAqkRvjpwr8WKqKXeqteE+W3du4Xu9z3Wl
	OMgNifCT+C2zqsaLqOg9HsHxNQPIT6Tc3OXeMSo2/WxJANzWLoG3ZN+qYoDbZXYvch8SNGUUWEm
	Uo57uXZyhGuhDnOmkeyVWFD7HzMYbKxYipm5sqbE9oveWmzRAIGAJcLR0379W8qddy5U10t28p0
	Lp/+EPIAyx5lOylpLJ78vEnQndTJhbp7C2ACnRK4I6wfhZheDYOgcndDi9WwkEojmIG3AuksYec
	TFiDtdgzNyq1lJjnm/Ejhwh5KqOdmbmZjwVvXHNibF1iMRxAwr6XJ7CLes0Va/YtxufZnH3NL4p
	FcOXLow/kV8p0=
X-Google-Smtp-Source: AGHT+IG6ytpLYdQrX/2pjjExkFEIINfv8kAcyaa95KwBKwyJzJzySBkChQImoYTUSwTSO6F65yBwsA==
X-Received: by 2002:a17:902:cccc:b0:24c:6125:390a with SMTP id d9443c01a7336-268118b95cdmr53455325ad.10.1758181161806;
        Thu, 18 Sep 2025 00:39:21 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980053201sm17187505ad.17.2025.09.18.00.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:20 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 09DA81062100; Thu, 18 Sep 2025 16:39:19 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 03/13] um: nommu: memory handling
Date: Thu, 18 Sep 2025 16:38:58 +0900
Message-ID: <5b248fc7351c6228f2a2bb9a4d33fddf3f1744ed.1758181109.git.thehajime@gmail.com>
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


