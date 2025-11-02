Return-Path: <linux-kernel+bounces-881712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61BFC28CC1
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 10:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAAE13ACFCF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DB726F29F;
	Sun,  2 Nov 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUMQz3Tn"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D0426E6F4
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762076999; cv=none; b=Urrh7AFWpIQxfbRyUSAbdn8ZNPFExNRJTn+5tXIOuH7WRnDDeiRUgQ0E22ZnOmtRPJ+q5ep3FZzjGwczNtcnLp5ENsPBbROpfLieAFeIsp1R8Ov4k2dDSPfwY0WU2EGOFQC/s+sty3cKTtXLN3ARXQD3g5Cos6YQAy17OKYbJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762076999; c=relaxed/simple;
	bh=asugRdDdRMBxIe1EMSyil3lIrPO4TUilJEIW10zlNcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcwyBVWsb6CVcrArZVSDsxeraacQrA9kmjvTo4RRqYosySD4tDwLVC/j6EAubkOoCbeK5nYzBXzEET55psgw1IjDc6GMxwuQxbJsrx77M/Y518pHEwv9wwEFaKv+US4Bvmh94uw3+uubgNsHZvQJDywg8rcrl4hAVixIQUSdX8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUMQz3Tn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-294fc62d7f4so30459075ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 01:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076997; x=1762681797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGE/jcU6KuNdO8mMPcpFhWHkaPMHY5y6/wQ8dXBnUzI=;
        b=CUMQz3TnpHD2C/qWZjQAjOlzwxS8xCrb3ZOfyrH5zeCKtoaVcncF3eZLqDb3P97IgY
         My+k8+VG630AjmZ1VWOKac4PB/oLF+pEHp4rakCel2ZUo4npzLDF8T+XWsiIVjg4oKZH
         F/4jUL1xz5zuJY7kN28JjVgfNKjV6qeUmb4EifzidvuRcJYr6ZCPQcIplmOuUKOVPmWe
         wp2I9gNQJCBcAFYwk8Z+gbnhnLxKzMnXN6sMilQ9A1QT7W8ekXVDR9jTYElxQklYgjYH
         9Y5EiZXD469PzxtMOa/a2XoFOUraYY04vz4bTS2M57IsXiXY/mUhPYpJldX4t/h3YJQI
         hMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076997; x=1762681797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGE/jcU6KuNdO8mMPcpFhWHkaPMHY5y6/wQ8dXBnUzI=;
        b=lCLewaI4gD+pHeukAzeRCeBeb4kF6bQnD3x/j+ZAYsEYYPY84OiGz3yi4PyLNTTXFY
         i/yr14A17aJq9kBy5IobrXemtWJWX/6TYHU7LwMz4WYShvu78Az7EdGd5O9nbP7I8dU7
         1AlJrvlhqOhVcUV5fjvp/oco3VLKXXWlT7z8t04lPj8dt6qRibpC3fOctYBxEuw2SL3y
         NLS7c+tcodCs1ErRWNDYwEPadv10VAnAiuk4fSwSEfeMyNhLpZeyCy3ItxMgo9QRT0Or
         QqmAJQsLCU2xc3gRsnNusuZQzT6rqsk62esJXkaWA29uRqLV00STcisezMfZw7b6/Box
         vxGA==
X-Forwarded-Encrypted: i=1; AJvYcCUcDfiWsuiku6dMYgzK3aBkt0KDqP2dbTpKLHG5QOLwBlDG1kTW63KYzmAnlPpAsJ34xfUT/bJ6tv5Vsvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJHS1G9st4ddLnTDTALXPb/v56ZNlx6ZmOcg+9XVdbwzpX7mX
	Vb95xQ6mothBE4lkrGO2vEhAA8Tqs0WWLwhcz+o/WznhlnoHnNTjl6gUTOwTYA==
X-Gm-Gg: ASbGncsn4WaNCt0VwkVBc82ZQ172hiiWjaCvyBxFR4nHB562ofsWrlHrCUE7snB/A5F
	c0XTlKiO2+mhTWpKKmeCzI3yzuxlCUD3Jff5lmoJFjQNlv7+0sVLIDOYSU7U2lNYqufaw2wVdIC
	HyLbOV+JgFhZ9xn4TfZV0Ag+K2LQ0dZS3z+yUwhpmTk1KXVzCRiLz1/+Gn/2aN0jt1FvcgvmkZg
	oJ3tjrUfn8Y8VUGat/QtTkVkh5u2J1mj3H19wzK5Z+koe7HK1MN10B5XGy+Tam0ZOEdAndrVvGt
	n+/7aRB0yfk4hGiX+12uAQwT0mSXRrEviQQRz1ICu4BQ8wKRInMrLdMk2dH4o2nRa41LDINES3J
	XgptD4RVhDyhqjU9TGHkA6M7GlDskAdvwbhfkFhm0HlDEwNDlLewYh1xkxydClXwUdr1v5YnsOy
	8Hv1t0ZTJbC+VKt9gvd+2On0kdM68894Xy50vnE9aLBIDV6w==
X-Google-Smtp-Source: AGHT+IGReh0qFD9/25L9otnnAJhTMLHIgLD9016XRnct0oN/9kvWpTVLUAzzoVVdm/CxflS7aR3gmA==
X-Received: by 2002:a17:902:ecd2:b0:295:3e80:9aa4 with SMTP id d9443c01a7336-2953e809f54mr75897205ad.22.1762076997472;
        Sun, 02 Nov 2025 01:49:57 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952810a664sm79134845ad.52.2025.11.02.01.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:56 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id D365B1123809; Sun,  2 Nov 2025 18:49:50 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 06/13] x86/um: nommu: process/thread handling
Date: Sun,  2 Nov 2025 18:49:31 +0900
Message-ID: <94b1c9a65af9d22e3f21d28bc0fad2f94e1e86cb.1762075876.git.thehajime@gmail.com>
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


