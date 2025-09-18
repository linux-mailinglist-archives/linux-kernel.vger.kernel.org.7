Return-Path: <linux-kernel+bounces-822236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED419B835D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC7B7ACB1F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5AB2F0683;
	Thu, 18 Sep 2025 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaeq8+8K"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9062ECD39
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181167; cv=none; b=J3DzeP/wZCdCLYMBDc0H2BER+IWpS7ZnD4Ff4vLKf1DdHmmq7qGJCKoDw+6bST6tKiePDo93KBvCV3k0rwzmvZSXiJlWinE6tTjWCiyb3yuQl4RzkCPU/IB8y5gyMWZRCRAgOanI7tAOhHj8OBpf7vxmh0JlsIHESPuUZo/OVuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181167; c=relaxed/simple;
	bh=asugRdDdRMBxIe1EMSyil3lIrPO4TUilJEIW10zlNcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNQCDIFC7xPI/rt4Kxmvicdp3BiJDAQHt/IXeeNOQFXAcQpUR3gVFM+aj65mMGyAPW6cGbZSEdMpOba1gC8LWrX33++k1817eu38pfqjyfY/8wNP7lRly0BoslDFklnVR5uIffPFjikGIvepsY4iFkpvOZWYJIiKjB56JgUBn/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaeq8+8K; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so625715b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181165; x=1758785965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGE/jcU6KuNdO8mMPcpFhWHkaPMHY5y6/wQ8dXBnUzI=;
        b=kaeq8+8KWIgLk2XdzX/0FF/3ss95boX1A8S0cHcEa2VjxbEgqFpOn0xSBtZaia0BdG
         DEso4Liv/HfqAgWpV1YWwyYM8hH/Rtg1UjOv8ZzUapmYx6ukf+/rbPNvyXjp68H84Yis
         ZUXwqSG0vL+iMXrhykodkDtSazE8FvYcepX1QZZC5YSCn1mE9iNRLqZyulwhx7/QkgV7
         l5m2X98YXFeRiswbWwGzwuvvn/1DKvyM17gndMVSQ6mlinhNcwCnflheBYrBWzgfqbI7
         zVXdn2e/O4aqSQJN6fUW/dwD5wdquYbN+fsmcv6L5Fda5iPO/65RdE4PDMXEGqICeUQ+
         ho4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181165; x=1758785965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGE/jcU6KuNdO8mMPcpFhWHkaPMHY5y6/wQ8dXBnUzI=;
        b=au8r2MuGJ7JiuPWeYsiY7lhr3IWTsUFjEqrURZtiubAq0sAN69sjafUL6VaeYuu5Mr
         k/W6GImVp+cf2zwtot7+TAlTOWHH3KdQsb9CXtvVRP0qu/gYG75A2BrqInNu+Zmh+f7S
         BSAcYJyNAcXvxEFdFz7skcA3CWNph0sModLUEd4vs/9ovBeugxj0h1c1aOi1MOai7qRC
         u88Rh2yEyH5vQ/qb711SOr3pntnn76NIqpG2qPnkuRJ0gAK1BrGi0EH9OYTCoZ/oFf8J
         4FWFmKu8QWrfKX/N9z8wOHStaExy4USlE+j3bmhkITAWouCvLVkiGIz69+8wU3Aax5Ds
         JIbA==
X-Forwarded-Encrypted: i=1; AJvYcCV4PcQGmo3QdYG1Qb4ZMR++NG6QMbI1T13jplujQN9sUImfOhbb4T3bks6s0gxXvbgAH18UqINi3j8R/tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd0Qr6jxLNoz4nWacAE3ysDVdR7SzjrWsvjfCdWmSF+FL2Ln1Y
	UHYQUjCtCP+TIee53/APdMT1498U63lRtjTHFIdEvAlniUce1qjbP4pM
X-Gm-Gg: ASbGncv4Xh20KF6enpS6dNhBCNWOx+v1Ic6iZxpslH/apGdlfTrmP3d8lD6L/vJAFEv
	GVHpJCRhibQuZ3EJPSjRBK2jJ7i5QphEptj2H2brhqU9pKA8XbJm797M2Ta27jEShZNY46eW0Ww
	IqyyqeUPUqxJbn65M70dKSPvJy+aBmVBAtzQRsVj7qzwSGqLElWUmBzJ1pKVr784Ut1Zhz5j7UN
	cqStG3nILStVVs1//PQ+jfJXyRUXHNGPeJ0zwtFFlnpzW55J/jEE8XQK6dZWu8X5tdC46mArqwR
	iLaFzuhGwT0sMHNK2YvDh7v55Ldj47sP26goBaZraBUBOjpFo2qcg6+iDfYNQgQrfxNHCnP1Dnt
	guMwS6gOcVd1EwIM0Sc+BSOUm+pFjZzns9wSwcOAI97oRnRpQOo2XAeVGWifusWS4BebByJzQiT
	cBaEAm9rY44LE=
X-Google-Smtp-Source: AGHT+IEW5cCMKXIm+nzKIkKeGH7H3LKniIm9mBlWZr7k0aEOZl0QvIVtSPe8fhK1TP/J+mcsUGlRpA==
X-Received: by 2002:a05:6a20:a108:b0:277:f962:3163 with SMTP id adf61e73a8af0-27a94827d99mr7748359637.19.1758181165167;
        Thu, 18 Sep 2025 00:39:25 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed273e51dsm4547321a91.14.2025.09.18.00.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:24 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 06A791062106; Thu, 18 Sep 2025 16:39:23 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 06/13] x86/um: nommu: process/thread handling
Date: Thu, 18 Sep 2025 16:39:01 +0900
Message-ID: <5c56554cf8c0215ea378b4c5935664ebc7a27d50.1758181109.git.thehajime@gmail.com>
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

Since ptrace facility isn't used under !MMU of UML, there is different
code path to invoke processes/threads; there are no external process
used, and need to properly configure some of registers (fs segment
register for TLS, etc) on every context switch, etc.

Signals aren't delivered in non-ptrace syscall entry/leave so, we also
need to handle pending signal by ourselves.

ptrace related syscalls are not tested yet so, marked
arch_has_single_step() unsupported in !MMU environment.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/include/asm/ptrace-generic.h |  2 +-
 arch/x86/um/Makefile                 |  3 +-
 arch/x86/um/nommu/Makefile           |  2 +-
 arch/x86/um/nommu/entry_64.S         |  2 ++
 arch/x86/um/nommu/syscalls.h         |  2 ++
 arch/x86/um/nommu/syscalls_64.c      | 50 ++++++++++++++++++++++++++++
 6 files changed, 58 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/um/nommu/syscalls_64.c

diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index 62e9916078ec..5aa38fe6b2fb 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -14,7 +14,7 @@ struct pt_regs {
 	struct uml_pt_regs regs;
 };
 
-#define arch_has_single_step()	(1)
+#define arch_has_single_step()	(IS_ENABLED(CONFIG_MMU))
 
 #define EMPTY_REGS { .regs = EMPTY_UML_PT_REGS }
 
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 227af2a987e2..53c9ebb3c41c 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -27,7 +27,8 @@ subarch-y += ../kernel/sys_ia32.o
 
 else
 
-obj-y += syscalls_64.o vdso/
+obj-y += vdso/
+obj-$(CONFIG_MMU) += syscalls_64.o
 
 subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o \
 	../lib/memmove_64.o ../lib/memset_64.o
diff --git a/arch/x86/um/nommu/Makefile b/arch/x86/um/nommu/Makefile
index ebe47d4836f4..4018d9e0aba0 100644
--- a/arch/x86/um/nommu/Makefile
+++ b/arch/x86/um/nommu/Makefile
@@ -5,4 +5,4 @@ else
 	BITS := 64
 endif
 
-obj-y = do_syscall_$(BITS).o entry_$(BITS).o os-Linux/
+obj-y = do_syscall_$(BITS).o entry_$(BITS).o syscalls_$(BITS).o os-Linux/
diff --git a/arch/x86/um/nommu/entry_64.S b/arch/x86/um/nommu/entry_64.S
index 485c578aae64..a58922fc81e5 100644
--- a/arch/x86/um/nommu/entry_64.S
+++ b/arch/x86/um/nommu/entry_64.S
@@ -86,6 +86,8 @@ END(__kernel_vsyscall)
  */
 ENTRY(userspace)
 
+	/* set stack and pt_regs to the current task */
+	call	arch_set_stack_to_current
 	/* clear direction flag to meet ABI */
 	cld
 	/* align the stack for x86_64 ABI */
diff --git a/arch/x86/um/nommu/syscalls.h b/arch/x86/um/nommu/syscalls.h
index a2433756b1fc..ce16bf8abd59 100644
--- a/arch/x86/um/nommu/syscalls.h
+++ b/arch/x86/um/nommu/syscalls.h
@@ -13,4 +13,6 @@
 extern long current_top_of_stack;
 extern long current_ptregs;
 
+void arch_set_stack_to_current(void);
+
 #endif
diff --git a/arch/x86/um/nommu/syscalls_64.c b/arch/x86/um/nommu/syscalls_64.c
new file mode 100644
index 000000000000..d56027ebc651
--- /dev/null
+++ b/arch/x86/um/nommu/syscalls_64.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2003 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+#include <linux/syscalls.h>
+#include <linux/uaccess.h>
+#include <asm/prctl.h> /* XXX This should get the constants from libc */
+#include <registers.h>
+#include <os.h>
+#include "syscalls.h"
+
+void arch_set_stack_to_current(void)
+{
+	current_top_of_stack = task_top_of_stack(current);
+	current_ptregs = (long)task_pt_regs(current);
+}
+
+void arch_switch_to(struct task_struct *to)
+{
+	/*
+	 * In !CONFIG_MMU, it doesn't ptrace thus,
+	 * The FS_BASE registers are saved here.
+	 */
+	current_top_of_stack = task_top_of_stack(to);
+	current_ptregs = (long)task_pt_regs(to);
+
+	if ((to->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)] == 0) ||
+	    (to->mm == NULL))
+		return;
+
+	/* this changes the FS on every context switch */
+	arch_prctl(to, ARCH_SET_FS,
+		   (void __user *) to->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)]);
+}
+
+SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
+		unsigned long, prot, unsigned long, flags,
+		unsigned long, fd, unsigned long, off)
+{
+	if (off & ~PAGE_MASK)
+		return -EINVAL;
+
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
+}
-- 
2.43.0


