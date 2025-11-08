Return-Path: <linux-kernel+bounces-891381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315E1C42916
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 215C13B3771
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62B62D663D;
	Sat,  8 Nov 2025 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWZ+Irao"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ACD295DAC
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589166; cv=none; b=uc2apndQkvxMMhANpHo5n0kWaMkL0H4YstxudTi3iBP4Y4SwvhWo9EdB5zdXACbnRMZlEH/m21OubAcb4vQphN3tZ6DOYw2HhkUkgslW8VlfB1bg+PmjLvpux5mAts6Au+zQX35wmhaJsIMN6XmfXKE1/b7xdIE7dgS6uXnMeDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589166; c=relaxed/simple;
	bh=bSDEYAueziQBf3WylfgbNGKPCbRnWhpRBSBYqNqX8LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVW6edOd/v5J60jKvXLkrrOcGApiYflzclJ20CCew+MJO/BUF22aqQzwgPN7+bYaYmQ+ZdLL6KOym+HP7c3teZLovI7Wgu4GtAdX4FbhlXzn0Y77j55/A/TAU2QycHRdUaMIdkn+XaTLnTu5vICqVTcxqjftIpoODN3zThy2vCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWZ+Irao; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-793021f348fso1076553b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 00:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589164; x=1763193964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lm2scelwojVCxczz2ObXlffF/4mE69mJL29qxONKAeE=;
        b=mWZ+Iraonb0pS4o3FsRd/DTtF4uGjgEJJQo3kKwyYtYtv+T9K2Sn4lX7GTc9aKIJHR
         683YA+dN6UU8wz/TyE2Df4oheQB8QxVdj0qLfzRYXaVTHpQHcAuzDHBNDEZqLl9cuki2
         8ffKraX0T3/yWRC/tlC6rJ/8CiBH93DGqy2+rC4hEOMcN6qgttwaqaLynFU0zvWk8yEF
         lB/IrmjYMkXQ0qxffTDih+MhGczprNnY/OCb9zbiYlkLaby11OqFvxnjsyHhG1+nBfI7
         5QauInuSQDTtFW4akeFYHtghwHFmPTqxzLwwY1ok0aqwWczQAc3rzYf33Yt172IUifwa
         hYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589164; x=1763193964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lm2scelwojVCxczz2ObXlffF/4mE69mJL29qxONKAeE=;
        b=eWK3u2qWcn2N8v9jWy55p9qarIPLaX/pl06OjWYw5BPFrlrN5j0CqmsHXqgFz7U67R
         skI21aecYk3peRfJafOhxW0BY91oAE5MQGx5G0CMFHRPzrx3DKeEqhbBv/nomxVNP5xY
         vuovHexdmcqdMPFlER6gJPctgmbFYbgP9VEPXoGPmxk57bUe0eDvcnqwabTVy84lZnN8
         7IQND1PtgIUlRlCamoaIPBufk2qTnMVyr+PCtX03TbZeLYveVLMPHpo0GrAQbjqHib+R
         13sxhtTPpnGJAuEFZl9xEocfKsDJRSpUJ7ABCEekKyo9wj86KKj+MBdKPYZk5PctyjHz
         ZXuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXWYANOcB4Wp6OmXPhcEjpWy1+3qO/HqYbYyvCnvZDeSFSHGTVOc46oWpDFy6acN97vX2OebuPbIPCEXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWdMZqwXVYH4v4is73JsB92cdXndCOU7fsFGPBQ3DItsHLEGy
	zFdjJAty/8f43U37Oy3gsmN5+xsYeeiueAqGy3innstI8hVkQbG4Kq+X
X-Gm-Gg: ASbGncsVSQABfydT9uSd0RocWLhpFhFLarE97q+MpH+J4pXTKeZzwqRcYYH65kNYbGa
	lIGdG5ZzLXdYQ1D8UqZ15iPypNjBK33TYoweAgm4uJhmbMXKviiv5/P//OoPhvHPkul3NNlIiuK
	b+6rY4iiHOvO0bbEIvcsw3fDxoS79mg13YxgQ/PJsHg3dtMZL9BX5XbbOSiFqBvOOpigLsqGKZI
	/V4e0ISVLren20lw0aIx6LQBIEKiBw6whbV1dnmkYFW3lya2BQAyaxiivddB4DS3nbaQdFzFfXK
	cOJD1/esRQAkrVUMQriZFiHCrt89Ghl/Ka9CiJ/W0ShSvGFcXYDdv/Bl9fYXb8rYYw3FTowXtCk
	7mnbXohQTjv2EIJcgjFlKj0elgC1nFi4DQBG4mQAfrwuh08gcHgNX4xyfWdzyxgj5kPUQO71eYY
	UsjQXn6Qvdp+azVBV/chTVCxAAMATXLU6ZegnMSqkmzo5isA==
X-Google-Smtp-Source: AGHT+IGu/het2cVRieRqiXorkhj+THkOqiM2xkhG3vmOKrA/bzZOZb+7OfPVwqzTvt7adsqHGGOymQ==
X-Received: by 2002:a05:6a20:729d:b0:334:8a8e:6576 with SMTP id adf61e73a8af0-353a314c69fmr2474816637.29.1762589163524;
        Sat, 08 Nov 2025 00:06:03 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff8538sm5219197b3a.28.2025.11.08.00.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:02 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 95CE511388CB; Sat,  8 Nov 2025 17:06:01 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 03/13] um: nommu: memory handling
Date: Sat,  8 Nov 2025 17:05:38 +0900
Message-ID: <28512370a78b53783655667300bc4464fd338029.1762588860.git.thehajime@gmail.com>
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
index 0df9ea4abda8..031b357800b7 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -18,6 +18,7 @@
 #define __addr_range_nowrap(addr, size) \
 	((unsigned long) (addr) <= ((unsigned long) (addr) + (size)))
 
+#ifdef CONFIG_MMU
 extern unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 extern unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n);
 extern unsigned long __clear_user(void __user *mem, unsigned long len);
@@ -29,9 +30,6 @@ static inline int __access_ok(const void __user *ptr, unsigned long size);
 
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
-
-#include <asm-generic/uaccess.h>
-
 static inline int __access_ok(const void __user *ptr, unsigned long size)
 {
 	unsigned long addr = (unsigned long)ptr;
@@ -63,5 +61,8 @@ do {									\
 	barrier();							\
 	current->thread.segv_continue = NULL;				\
 } while (0)
+#endif
+
+#include <asm-generic/uaccess.h>
 
 #endif
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index f3258680bfbe..e599b637c5fb 100644
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


