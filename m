Return-Path: <linux-kernel+bounces-881711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A62C28CBE
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 10:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8560C3477D2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6643D26ED26;
	Sun,  2 Nov 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7VOkR+U"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50AF26B973
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762076998; cv=none; b=Z2KLxgZOIdvuFEeIhlOr6I8z8n6TV0KAIx3eXLQg6uOff61DhM9chKlmw7d+UdYshatdAb772Ridol9+enMoV99zCe/fFP/ru7FrLhVUYmnsFr1wHLM4d8PpttMcBAqEg3yBMyTa6B0rnqs72tydhgizxyWPI/8ULoi5u01HZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762076998; c=relaxed/simple;
	bh=MDKNy8GA7hh89rDwV6Uik8zdzD4tw3Zr+4cOFbUqcB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftZI6yI5w/lD5XszdHvItyEmtYIjko7OvBLfpTwjaWwPN4WEIaY8BqDL2+OPdFba+ZKme4pl0ljbBziBRqIhciEA6oe5R79aafdomruSzDrS9Mhs82BFz/l9PyB1ajwaodKrZ55oUPAGylE16IaSduGEsEku3YBjsGZaXoZAZrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7VOkR+U; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-340cccf6956so485954a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 01:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076996; x=1762681796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLVWDe27CxuFua8732sg2A25U9KjI/ik4lvuwLmfhJ4=;
        b=i7VOkR+U9EPaOtnmOSQucCPkRHZirLMvJzC+hb9jbVR63QAyIeKYmbLlt/F5htTv3g
         JIiAfTg/QGfBkQQzUYGTF+Ft6VtRAjbIdE61J4DqBYljwTR/nTqm4nncpAO6CZFtxxE8
         05nmTKXrLtF4WBnaWZtiYPZqlzgrw3DrJdrXAk3oQT0oVSMXPeEmGger0gLq2NqxHloy
         Ch73y5LWlpj7V5NP8spYeLAn4qoStEm3TY9DU91Og8ac3F+M7m7va0cZrJg0DCBy4vav
         tR0jSmAFh8BTvm8kjQKRjeF7bD+HlH5fTFALJutktomF2UZG8xqVf03JoZJ0BltDLRxB
         mOMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076996; x=1762681796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLVWDe27CxuFua8732sg2A25U9KjI/ik4lvuwLmfhJ4=;
        b=iHiWHOEUui6qXKREpTnC0QZujl+CeID/XmkC5NyCVI1rWeqClXiBAP6It6M/o0I1h7
         vdiuYx045bRwUlIFOzrzn9uDnx23u5Q5vi3qUr2C0SrkGl5Af94UmmlENHja9Yq/qt82
         Q8eENL9wHnRt23i/NlGwNRlIS7FfZPe5b38USWVGUrCzg/3ctqiozCQXw3MwkowTZwrI
         zbRPcIgJAMSNjIsOqS6pCjBEhpiidQUc54l5OL9Ft8nVl3GQbShpyKVGGQQr8SjiihMX
         tPx/gBz8xr1hzGODYdcQTnvB2O/fSjRs7vqUFWAnFgaqIsDuKyTNh9GAm2P4hffLNhWG
         WyFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaBp0uWaIyxKcmNog16ROLNc+tt/uSpghouPDy8wiFtaGsetjf5O6r0JR5QsCfU8KOlfWI4BEoaqniyqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYV21+38LVLfjDOVETXIa5/9THCU5MeZtBq7qAZCv6bJnf/UTO
	V9IZuPjdVr2Y04YjnCwQ3G9Eukx6ZX+VtVpgWz8Lx6Kc/eKUFyZ25kM8
X-Gm-Gg: ASbGncuhF3MNgZlBaxrOJDo1q7kfM7i5FQnkHJ18d1VUZuELN636eeoOpKW3hXiywU3
	K/L45oqXaXCap13lS6veMh2WCz/dTlTWBWNKNZx1Eu2Pssmncxfs86t2d0xvuA+sAJIM3o1qJSg
	DIERBx1J61FS3efAEjIoeiMKf8dDbd6BzdQR4cb9zUEKCy4/zDzE69SBXenGv8QJ9oxOnvVHMAT
	E01URPLm63KkTDT/azHDE8IuZ8XoP4N2OiAtxWEsz0dfTx51xyRNPYLO9xUTI5XZAkHVu/UMIRR
	BoscsToO3g4Jye33IRbXlKgnACbBxNgOGn1OFpwPdnkvT/5loV8XgiSI86nJykAxlAKt9sBbvt0
	+qfT4Qhmu9RS4Cre67dp6hnKr0Rub41wVKPdIizu7X7YKjoJSrJOE6sqoTp9eP0uAWWCJhKQ8cO
	5QT9HEe3atDfAUfG+p+AnGGtnzDTcpjzmhtbCNGgjn9vusZ6kZGNPMHcnZ
X-Google-Smtp-Source: AGHT+IGzGeGnGZ1p4XL3AbmXtABYfDo2QjDzgeG3Xh1EPclKdLYIizv0aT8x/i0qH9w4Wj7HzH+eoQ==
X-Received: by 2002:a17:90b:548e:b0:340:bfcd:6af3 with SMTP id 98e67ed59e1d1-340bfcd73e0mr5203014a91.33.1762076996088;
        Sun, 02 Nov 2025 01:49:56 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b9b8f2b5403sm812590a12.17.2025.11.02.01.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:54 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 7CB341123803; Sun,  2 Nov 2025 18:49:46 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 03/13] um: nommu: memory handling
Date: Sun,  2 Nov 2025 18:49:28 +0900
Message-ID: <ca690557be98a0b11744fc8aa664933552742266.1762075876.git.thehajime@gmail.com>
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
index 82a919132aff..c0b9ce3215c4 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -22,10 +22,13 @@ typedef struct mm_context {
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
 
 #define INIT_MM_CONTEXT(mm)						\
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
index 52cd906e3896..1b9e7c62412d 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -71,7 +71,8 @@ void __init arch_mm_preinit(void)
 	 * to be turned on.
 	 */
 	brk_end = PAGE_ALIGN((unsigned long) sbrk(0));
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
index c50fa865d8c7..ddb5258d7720 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -100,8 +100,8 @@ int os_map_memory(void *virt, int fd, unsigned long long off, unsigned long len,
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


