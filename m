Return-Path: <linux-kernel+bounces-891384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2E7C4291E
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F98C188E187
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24FC2E6CC2;
	Sat,  8 Nov 2025 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuPNK7jZ"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670412E0405
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589173; cv=none; b=YukbC3Ms0pNVF8FPBiNeDWk5RgqWH3N19CeXKZK+gF6WpwPD6o2Fk3nS0rtbYTwG4Nx29U9NOQPez/sOZuRaYyAHwTZBkT/bydFwx8iSbF4QTE4lLr6pysBFOXXviI66j51NmU/JI7fstFGoTEZZ85gY+UmGW9F1ZSYcEe9CzB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589173; c=relaxed/simple;
	bh=Xdgd9SzJQKPXpSd3h/YCws/19jIBtbhoHsT1rlMAAwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sre4r5xzB2akwCJz7aD9F1MIJHEo5lBBPIdcHjvh6K4cyT6772BnSP/oqofdad/oJa/nYJ6pjK9ijqRZXqcPrYXp06bdRLqkYzCR77yzPv+jzZ56hekddMPy9AvlWP8ImxW2DpZOb76Ndfsg8Iem93FMLd2fgkebVL6FpAu8KA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JuPNK7jZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a4c202a30aso1235949b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 00:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589171; x=1763193971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBx1RAda5jRhU5+5MRbhR+8InixhRX8igq/pYh2YNko=;
        b=JuPNK7jZms4KducFyrcQsOxujdoJETgt1mQyx/kEGxmvVKhF3GKxKOqjwPLlZCqUhc
         wE3KXwya6lgT53sMVmVF1sY3PgULSFdrr78Pao5VCYnZHdKYPYB7GUFbGpdOtkyQqJhm
         XGmJ6YHXAbSCY/7/P5UgxrH+0vOTKJNG8fzdhds5PYSZkSNyRMeBXYS04fCcYAtPxQ6x
         6Bmotiw41RlKYt58jRzHzsZwF1t0QA/+ma1OD5tr6eMPKXgaolj1suCtvqlyun3iq3Ur
         i5RFd6ng07nkE3SBJ3nMzA956XafI2OcRk0195BwPa9Mo31713LQvd3Mk0KCRSdIWf2M
         2URg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589171; x=1763193971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBx1RAda5jRhU5+5MRbhR+8InixhRX8igq/pYh2YNko=;
        b=Y8LlKr5rKC7D5mdylr4rtgtWvpgGsX24vKtox+1ckSuev4JRl12QKZfhOjDdWsjYA7
         vMbXinWyxBbnLjsjZ53dvB4BpnE/hzlANAMfPlbinIja5F532pGjgVVEEJoyuNFz3G+H
         03umAwo+yphx2nnVjVV5bkNoXMv8OCaiAVLSXY9+8HnCJdsIGxZAZdmAyJhWx+xc/Ys5
         pAtOx0V6qmyJHHBi0b8zbhJ/RFFi+tTPaWkxnKROw6+MuDp8vIrNSoTJx5fDRs0L9wUG
         YXQY6Ow72wI8GrJvUwt+3xbtDwL3/Ea8/VpPc4jnais0AfCxCd7ZNsH5n22lfSICHfPm
         PVQw==
X-Forwarded-Encrypted: i=1; AJvYcCXQLK6mK6jXSDCXRW5eMMTdFKirRTRT8nMxA4yZvAJRQ72JEdM6nSFzpcbPZXq7Qvzj1mRIgR4yofo4evc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLcTpkb+ceEImFKAzNOw4q5DTdpa2+p5B5vLh0CDU3+g35JWMp
	Qvzl1SsZpu3iJSt1cb2gVcDYGPLGXtUKxuOibmwh57bnCGoOQ+8J1xqp
X-Gm-Gg: ASbGncvgWzH7+R1nDICf06D/yJCpwNEksps6v9yWLKsKY66OfHK36Hu86eW6sbDo/ma
	6QxsRn0ZNQTIERubOGBEig8KW5diXWpcJLVHKTKhHL4kAD5KC6/bSWqWqR+0anRhLCVM6/S9OeX
	Z00zjF+79wJVGB/Z5rIyRJpDfY4Zqots1NawVNdBzpmD3XrpSXAgjuZVX9M9VZgrIf5gmsyhFmT
	gp3q2lrKjIbCCLaKjNKU0qLk3t+7nMmfa+Fb03xCmSFUujGjsZpbbgPbTOwoy0HpUxmfwBqCA/R
	Of4+8//eERoLa3E7KOlAKjyJyeUYuQSUf1VC7f41hf78TPbet1QBASMcAS7YzdiF1GzTPcPvF+G
	LoihCWOYCpo14J+Ck6cmGEgdmv/Gsn4F4jCnGMTR6sGaT7JQMGmv2YlX1IhciW2P7Fd3/yM2BDg
	mOmYe1eUyyeT3+AOyZXt6axNi8hyEdlYsj+s1atfdjta/GhdawtX+/P+d3
X-Google-Smtp-Source: AGHT+IHzchLXWxzzDz1WxC3Dk4RM7G0kck5BQurVJPuk/UCkNNlsjtfs2t5XKr3BUU+NgfTwVrdmVA==
X-Received: by 2002:a05:6a21:6d83:b0:34e:7bef:e81d with SMTP id adf61e73a8af0-353a13a4dd7mr2538481637.8.1762589170593;
        Sat, 08 Nov 2025 00:06:10 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffe3616fsm7280302a12.19.2025.11.08.00.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:09 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id EE07211388D1; Sat,  8 Nov 2025 17:06:07 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 06/13] x86/um: nommu: process/thread handling
Date: Sat,  8 Nov 2025 17:05:41 +0900
Message-ID: <ad45749c65e4d7316b1d52b0ef0ba3553c2f3ed9.1762588860.git.thehajime@gmail.com>
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
index 39693807755a..98dc57afff83 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -26,7 +26,8 @@ subarch-y += ../kernel/sys_ia32.o
 
 else
 
-obj-y += mem_64.o syscalls_64.o vdso/
+obj-y += mem_64.o vdso/
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


