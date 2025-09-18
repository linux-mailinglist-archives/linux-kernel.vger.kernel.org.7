Return-Path: <linux-kernel+bounces-822074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0D1B82F98
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0207231DB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFC129B8DB;
	Thu, 18 Sep 2025 05:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wkn37IH8"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E79F298CC0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172601; cv=none; b=cYlFnmkoAruSf8ftDemunYBQSVMX4Mnu35+dKgOfld7c/iOuXxPRn5xk1Gkg3eQME5DDjNtGKUYMr8Kg4n4AY1BgxWFGyud7+TWHEo+TTM2ycQ3LiCzxYJyrKqZu1liVsEo8PAc0nwAzxdAgwdTpKLf7ocjam4+LI9g0fLJOaG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172601; c=relaxed/simple;
	bh=asugRdDdRMBxIe1EMSyil3lIrPO4TUilJEIW10zlNcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dunOABWux3TsTPqeG7pb61Qlp0jig3z+MMERm436znrzue82mOQFB24Gl9D+WDMf446YysfHYJfAMdcUeUyc8i1uQH5MdKkcxoVJkEfFADrdsANeloJ3gN5a17AP7v+VmnQFnbq6bEJ7BJh5qHrSW5Sm/GoMupT0sBC0UM4rXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wkn37IH8; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so45176a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172599; x=1758777399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGE/jcU6KuNdO8mMPcpFhWHkaPMHY5y6/wQ8dXBnUzI=;
        b=Wkn37IH84k9U7mTBYGzFLbUuNLnCNm3n0V3gpd5O8kr6fVfV56JXvnc7XQ49BNwW1T
         8mLnsY5eewwPxx6WhSTSoQgIfKxQHFLTAjwxQ4/mWXIe9f92O5QTT2GCA5YnEb/njhXB
         feKSyDDlg6S+XQgAZUySzibk6LEN4DGePpWJ71Usm0EVukOrcUdcPJdxtJzOGlQNaO+Q
         6L+nDe0nQKkJNZrSc7bD1GJQu11cf4nTWipnjcbmheErj2ICpN460XRUx//Z/I9hubmI
         Go/eEkCIwPod/Rlvmr3EEqTO8SKZcQGCzjxYiyi7uEqrBq+FgDqn/lXmCMjs2V8G+DjV
         4vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172599; x=1758777399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGE/jcU6KuNdO8mMPcpFhWHkaPMHY5y6/wQ8dXBnUzI=;
        b=M7xWU511BJNXr342jpN6jfnaxa/h0RqhFge+UMWvNfmWT3TT1wQFs94fVGp2BYEe2N
         t0Re7hMcA8tCQ81UTG4hm0LKj9aIqJxiV/LodWaGFIostzQ/cfg2dJ1gP66vv8LNjGOr
         I+a6tRb8YE/nDw+bprr2hO1XTErTaKvPVLZZ5ZfGCH7l+7QHJ28se5/bV8IF3LrJduJx
         Zx9Hph3BMWPn/V6r3ZlUdU2o0kX6w2knrwsdc0YZwhNAIInCGH6DftlmCTTBSOYKjuQU
         BDmX3vONF9sP2Ld1RlA0i/llo5zrQrUG4nNMjylXjO5U+QCvcGBew9lB/KZEOWqEIb36
         MDTA==
X-Forwarded-Encrypted: i=1; AJvYcCXhuEKD6XzHd6bMfUyzuFwk2FrYUdAmf2HE34DL2N7FMXXhXav9wdFDSPkQG+7oQAkhodO7t5lKU71A3Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1S9701lxm1wFdinu22YqherzqIEPdmVrNCBRZE+dB/mdcxFTq
	K7ru45wqqNy/Lg1tEW84pi4GWIpUmhivX8NxVC8AQfDq2v/isPXC4Txa
X-Gm-Gg: ASbGncuCDj+0mRryw3Aji/rKBwaP1yzANSh4xrRVLGbr4dBLVuT6O4/iYlbUPXaPbMw
	UPNLywN/U3AkN+KrsEe6roL7becEyzEgiPLe4apduwP3uUMbzCnbAWWRpSoIB3dc4UpqegVAqU4
	gyjnuO5XT8jzyQOJ7XemPs+PbMCYDEKTZFVDkkq4rmDU1UAccbSdQ5y0lo+angYBTQ6iPJwDEtL
	Gl5ZFn6D1Hu4Ok4DD1b6UFMY/7T1dIQzWnv6FP7gM7N9LpKYl+5zbrXrLQVulGJArhBexA++q/q
	0AweFYT+X38N9tffqv3v20B7Zq6LzqD0zWdLZ31EOnCrKwQCrteN3eF/H5/Hb9MZ+peS0lTin8J
	DxXXHFBOd/6GHbzQVGoCNCVQ7v2+9mtJKtzwG9nncm+3rfqv+HIpUnIKxxOoQEqUNWV5/E1ZV2Z
	R/pcPLALUzlc0=
X-Google-Smtp-Source: AGHT+IF1j90Ta1QtOnlayd+rOIMVjDlDgB9HTQ6NhnrPndZrudKEMwQBaDxvvy2pq+iS/ce/Fx31JA==
X-Received: by 2002:a17:902:f792:b0:264:4e4a:904a with SMTP id d9443c01a7336-26813cfeb3fmr56547865ad.53.1758172599048;
        Wed, 17 Sep 2025 22:16:39 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803026e9sm12683435ad.107.2025.09.17.22.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:38 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 006621061EEE; Thu, 18 Sep 2025 14:16:37 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 07/14] x86/um: nommu: process/thread handling
Date: Thu, 18 Sep 2025 14:16:00 +0900
Message-ID: <5528885e35e11984cf2543665b4d92582f4b3ac1.1758171893.git.thehajime@gmail.com>
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


