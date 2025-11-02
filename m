Return-Path: <linux-kernel+bounces-881713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC981C28CC4
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 10:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94BB04E2770
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 09:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82FE26FA70;
	Sun,  2 Nov 2025 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4/ligWk"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53AA26ED23
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762077000; cv=none; b=LWcqd0HLBNr7fSXfWtZMyY9yT4UwxrPBM9LZANo/M5dQq3rnrfH9gjHVoPPDXyOLbSJODV8TPvMmGpUU7/Z/hmPqW05ETarAw4p+jtnUBMZ3pWy5i2dclnZAr27gunKSypdVqON0e/BcjMIUTgY7T9aOPY2ZcGV5O9guLX5xpZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762077000; c=relaxed/simple;
	bh=ApZCova8kpoHyvQowYMCMZfo2gH0ldio/mRio3HyRRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mi0+R958vjENgX7fxcVlpnXA4/n8RDXsgBvBjuvwhRqLVgroWRrAwuHhMx+e5MqrnPtAAx1iOf1PSnHVGYXsERHl05FJBnAETaRaGGA0n7rD8SUGp1MlDmgc4cqX3N9wg3UfZIX9lXKhXj1y/PysNGTAtBNsjO/Wak/JkohDi2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4/ligWk; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a4176547bfso3315725b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 01:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076998; x=1762681798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLnEdv1Aj+O6ghd8EMKGqBIoQpaMRjL7FrHMTz+k/js=;
        b=e4/ligWkuRxeYc48um+cdOz640wEML+oJ0C2ETSxjZrioM5UyrGSE3qZ2tq5yEm0QG
         LCmlg3RZWAKc6bGZ85YLVqxJ6v9GchTORWPb9g8uPkW6Kmr29w93ffq0IEYWYBQ5d1lH
         FEYYFCOnqENzdneAEk1K8OYa7qQbtbhnJjcjnArfhFOgwUHWn8riHdriBNNkUHwjA85u
         yACJTeZU0bg5sCW7DVz+eBU0wChmUxvTNlxMHANH93cxn12pzDmP5VSfOWFBYY91LqOH
         tma9nP8j4i3AP/NEPz19uSTAsoh1DYucKdOFQs8YTS/7MkKQx479PikXbtFM6DDME0r0
         kjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076998; x=1762681798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLnEdv1Aj+O6ghd8EMKGqBIoQpaMRjL7FrHMTz+k/js=;
        b=HxloBt4Q+Xy9vlnTLmqHd2LwDxz3d4O273OO1A2k1T5WTs12+664/zZC/EsnrXJl4C
         odBR1donNemlEgmeXELe1pplABVeWX2soh74Kjn8Z3ZxN5XMY3hnhJznGj0CeI34Jck0
         nAiB+RHFLKiOe4L3kRKJpmrndyQ6NDGSfBqGcINbdZn+cKzE5JB+bjqrTx0kKM9LgsOD
         lb3yw+5RNEmPy18U9sqo2cKaWACqPkYkX2S8GrnVmr2Th+MeQKVn29/al5iQHnwKBtD5
         MIVLayVTDYnCgoldTj9kEPnfyqoLBxl54pgdLp1OZIdjVg1y8pniVtKtQzMj/fc6bkH4
         46LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsTy+RIg03lysNJnKSF33o8a/3FQ0WuD/G9Bbcpy87cW670EtdgR0YkIyZKpJeVbqsVk7BleVR414yrWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlmrr2ToGZcY6gMM4ZyxWxJV4Hr6+dKls8jOhphJMVrDY4ltDA
	2SjePQL60D3YuI8qIuw7OgC3EsEIiGpVTqjQk4c0O9F0CDgb64oP7R6i
X-Gm-Gg: ASbGnctL2xRq5qGiBSk+qCL2aKAOl2CUOdor1z0dVx6RRYNx5tWgXtzeCq8rOZKLUY0
	ZH2rkJGcynBc1eewVsmeB/YgJXn5qKwSBwHBZrXFxADvPt/Enb/VQfo68+ovr7AZ38o2KPwvFzC
	0LGBBEXHXDjqUy3BXpazsuXlOpiCKKOHgXqQt+z241LoUDXFAWCGkkwajuNsYBD1FVUGJ4Etdqn
	wiM8Bycm1qkml3kNuJlmM8pxaITDxeh4Q+2L40HoQ3jn9XQQtKa5K+LWOAKfZi39qX/q7SZ+x8E
	XNLVl+ucLYuLZdujLGXHy7LVt+cTKFriM6s5RV3fGPth6sojBT5LBly2fVmlmtMKl3kJe4Jhqf6
	HqmaMZiMO+XoCN7o2CxaPcTkY0HT5GD1K5TFVEDFbBoX1Xtdn868Bu6K4H0O1sh58xgB5WU3Msq
	fzbAJfjPeuYwf6Kn3OK9pjYN22+KHG1fC/3eGzg6qAKc242+++RGiBROJC
X-Google-Smtp-Source: AGHT+IGEB1oC5W8bqUi5NVnEQR/tZnvPiWF/2wnwqLC4TMuxSvT8HcXunME5KnODXeltaFD1eULcDg==
X-Received: by 2002:a05:6a00:6b95:20b0:781:16de:cc0c with SMTP id d2e1a72fcca58-7a778fdf49dmr9112560b3a.19.1762076998081;
        Sun, 02 Nov 2025 01:49:58 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8a76f00sm7452492b3a.12.2025.11.02.01.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:56 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 6AB251123807; Sun,  2 Nov 2025 18:49:49 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	Kenichi Yasukata <kenichi.yasukata@gmail.com>
Subject: [PATCH v12 05/13] um: nommu: seccomp syscalls hook
Date: Sun,  2 Nov 2025 18:49:30 +0900
Message-ID: <ad735edb645ba2b004fe68c4727e69f7beb8ea46.1762075876.git.thehajime@gmail.com>
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

This commit adds syscall hook with seccomp.

Using seccomp raises SIGSYS to UML process, which is captured in the
(UML) kernel, then jumps to the syscall entry point, __kernel_vsyscall,
to hook the original syscall instructions.

The SIGSYS signal is raised upon the execution from uml_reserved and
high_physmem, which locates userspace memory.

It also renames existing static function, sigsys_handler(), in
start_up.c to avoid name conflicts between them.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Kenichi Yasukata <kenichi.yasukata@gmail.com>
---
 arch/um/include/shared/kern_util.h    |  2 +
 arch/um/include/shared/os.h           | 10 +++
 arch/um/kernel/um_arch.c              |  3 +
 arch/um/nommu/Makefile                |  3 +
 arch/um/nommu/os-Linux/Makefile       |  7 +++
 arch/um/nommu/os-Linux/seccomp.c      | 87 +++++++++++++++++++++++++++
 arch/um/nommu/os-Linux/signal.c       | 16 +++++
 arch/um/os-Linux/signal.c             |  8 +++
 arch/um/os-Linux/start_up.c           |  4 +-
 arch/x86/um/nommu/Makefile            |  2 +-
 arch/x86/um/nommu/os-Linux/Makefile   |  6 ++
 arch/x86/um/nommu/os-Linux/mcontext.c | 15 +++++
 arch/x86/um/shared/sysdep/mcontext.h  |  4 ++
 13 files changed, 164 insertions(+), 3 deletions(-)
 create mode 100644 arch/um/nommu/Makefile
 create mode 100644 arch/um/nommu/os-Linux/Makefile
 create mode 100644 arch/um/nommu/os-Linux/seccomp.c
 create mode 100644 arch/um/nommu/os-Linux/signal.c
 create mode 100644 arch/x86/um/nommu/os-Linux/Makefile
 create mode 100644 arch/x86/um/nommu/os-Linux/mcontext.c

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 38321188c04c..7798f16a4677 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -63,6 +63,8 @@ extern void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs
 extern void winch(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs,
 		  void *mc);
 extern void fatal_sigsegv(void) __attribute__ ((noreturn));
+extern void sigsys_handler(int sig, struct siginfo *si, struct uml_pt_regs *regs,
+			   void *mc);
 
 void um_idle_sleep(void);
 
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index b26e94292fc1..5451f9b1f41e 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -356,4 +356,14 @@ static inline void os_local_ipi_enable(void) { }
 static inline void os_local_ipi_disable(void) { }
 #endif /* CONFIG_SMP */
 
+/* seccomp.c */
+#ifdef CONFIG_MMU
+static inline int os_setup_seccomp(void)
+{
+	return 0;
+}
+#else
+extern int os_setup_seccomp(void);
+#endif
+
 #endif
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index e2b24e1ecfa6..27c13423d9aa 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -423,6 +423,9 @@ void __init setup_arch(char **cmdline_p)
 		add_bootloader_randomness(rng_seed, sizeof(rng_seed));
 		memzero_explicit(rng_seed, sizeof(rng_seed));
 	}
+
+	/* install seccomp filter */
+	os_setup_seccomp();
 }
 
 void __init arch_cpu_finalize_init(void)
diff --git a/arch/um/nommu/Makefile b/arch/um/nommu/Makefile
new file mode 100644
index 000000000000..baab7c2f57c2
--- /dev/null
+++ b/arch/um/nommu/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y := os-Linux/
diff --git a/arch/um/nommu/os-Linux/Makefile b/arch/um/nommu/os-Linux/Makefile
new file mode 100644
index 000000000000..805e26ccf63b
--- /dev/null
+++ b/arch/um/nommu/os-Linux/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y := seccomp.o signal.o
+USER_OBJS := $(obj-y)
+
+include $(srctree)/arch/um/scripts/Makefile.rules
+USER_CFLAGS+=-I$(srctree)/arch/um/os-Linux
diff --git a/arch/um/nommu/os-Linux/seccomp.c b/arch/um/nommu/os-Linux/seccomp.c
new file mode 100644
index 000000000000..d1cfa6e3d632
--- /dev/null
+++ b/arch/um/nommu/os-Linux/seccomp.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <signal.h>
+#include <sys/prctl.h>
+#include <sys/syscall.h>   /* For SYS_xxx definitions */
+#include <init.h>
+#include <as-layout.h>
+#include <os.h>
+#include <linux/filter.h>
+#include <linux/seccomp.h>
+
+int __init os_setup_seccomp(void)
+{
+	int err;
+	unsigned long __userspace_start = uml_reserved,
+		__userspace_end = high_physmem;
+
+	struct sock_filter filter[] = {
+		/* if (IP_high > __userspace_end) allow; */
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer) + 4),
+		BPF_JUMP(BPF_JMP + BPF_JGT + BPF_K, __userspace_end >> 32,
+			 /*true-skip=*/0, /*false-skip=*/1),
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_ALLOW),
+
+		/* if (IP_high == __userspace_end && IP_low >= __userspace_end) allow; */
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer) + 4),
+		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, __userspace_end >> 32,
+			 /*true-skip=*/0, /*false-skip=*/3),
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer)),
+		BPF_JUMP(BPF_JMP + BPF_JGE + BPF_K, __userspace_end,
+			 /*true-skip=*/0, /*false-skip=*/1),
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_ALLOW),
+
+		/* if (IP_high < __userspace_start) allow; */
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer) + 4),
+		BPF_JUMP(BPF_JMP + BPF_JGE + BPF_K, __userspace_start >> 32,
+			 /*true-skip=*/1, /*false-skip=*/0),
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_ALLOW),
+
+		/* if (IP_high == __userspace_start && IP_low < __userspace_start) allow; */
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer) + 4),
+		BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, __userspace_start >> 32,
+			 /*true-skip=*/0, /*false-skip=*/3),
+		BPF_STMT(BPF_LD + BPF_W + BPF_ABS,
+			 offsetof(struct seccomp_data, instruction_pointer)),
+		BPF_JUMP(BPF_JMP + BPF_JGE + BPF_K, __userspace_start,
+			 /*true-skip=*/1, /*false-skip=*/0),
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_ALLOW),
+
+		/* other address; trap  */
+		BPF_STMT(BPF_RET + BPF_K, SECCOMP_RET_TRAP),
+	};
+	struct sock_fprog prog = {
+		.len = ARRAY_SIZE(filter),
+		.filter = filter,
+	};
+
+	err = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	if (err)
+		os_warn("PR_SET_NO_NEW_PRIVS (err=%d, ernro=%d)\n",
+		       err, errno);
+
+	err = syscall(SYS_seccomp, SECCOMP_SET_MODE_FILTER,
+		      SECCOMP_FILTER_FLAG_TSYNC, &prog);
+	if (err) {
+		os_warn("SECCOMP_SET_MODE_FILTER (err=%d, ernro=%d)\n",
+		       err, errno);
+		exit(1);
+	}
+
+	set_handler(SIGSYS);
+
+	os_info("seccomp: setup filter syscalls in the range: 0x%lx-0x%lx\n",
+		__userspace_start, __userspace_end);
+
+	return 0;
+}
+
diff --git a/arch/um/nommu/os-Linux/signal.c b/arch/um/nommu/os-Linux/signal.c
new file mode 100644
index 000000000000..19043b9652e2
--- /dev/null
+++ b/arch/um/nommu/os-Linux/signal.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <signal.h>
+#include <kern_util.h>
+#include <os.h>
+#include <sysdep/mcontext.h>
+#include <sys/ucontext.h>
+
+void sigsys_handler(int sig, struct siginfo *si,
+		    struct uml_pt_regs *regs, void *ptr)
+{
+	mcontext_t *mc = (mcontext_t *) ptr;
+
+	/* hook syscall via SIGSYS */
+	set_mc_sigsys_hook(mc);
+}
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 327fb3c52fc7..2f6795cd884c 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -20,6 +20,7 @@
 #include <um_malloc.h>
 #include <sys/ucontext.h>
 #include <timetravel.h>
+#include <linux/compiler_attributes.h>
 #include "internal.h"
 
 void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *, void *mc) = {
@@ -31,6 +32,7 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *, void *mc) =
 	[SIGSEGV]	= segv_handler,
 	[SIGIO]		= sigio_handler,
 	[SIGCHLD]	= sigchld_handler,
+	[SIGSYS]	= sigsys_handler,
 };
 
 static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
@@ -182,6 +184,11 @@ static void sigusr1_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
 	uml_pm_wake();
 }
 
+__weak void sigsys_handler(int sig, struct siginfo *unused_si,
+			   struct uml_pt_regs *regs, void *mc)
+{
+}
+
 void register_pm_wake_signal(void)
 {
 	set_handler(SIGUSR1);
@@ -193,6 +200,7 @@ static void (*handlers[_NSIG])(int sig, struct siginfo *si, mcontext_t *mc) = {
 	[SIGILL] = sig_handler,
 	[SIGFPE] = sig_handler,
 	[SIGTRAP] = sig_handler,
+	[SIGSYS] = sig_handler,
 
 	[SIGIO] = sig_handler,
 	[SIGWINCH] = sig_handler,
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 054ac03bbf5e..33e039d2c1bf 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -239,7 +239,7 @@ extern unsigned long *exec_fp_regs;
 
 __initdata static struct stub_data *seccomp_test_stub_data;
 
-static void __init sigsys_handler(int sig, siginfo_t *info, void *p)
+static void __init _sigsys_handler(int sig, siginfo_t *info, void *p)
 {
 	ucontext_t *uc = p;
 
@@ -274,7 +274,7 @@ static int __init seccomp_helper(void *data)
 			sizeof(seccomp_test_stub_data->sigstack));
 
 	sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
-	sa.sa_sigaction = (void *) sigsys_handler;
+	sa.sa_sigaction = (void *) _sigsys_handler;
 	sa.sa_restorer = NULL;
 	if (sigaction(SIGSYS, &sa, NULL) < 0)
 		exit(2);
diff --git a/arch/x86/um/nommu/Makefile b/arch/x86/um/nommu/Makefile
index d72c63afffa5..ebe47d4836f4 100644
--- a/arch/x86/um/nommu/Makefile
+++ b/arch/x86/um/nommu/Makefile
@@ -5,4 +5,4 @@ else
 	BITS := 64
 endif
 
-obj-y = do_syscall_$(BITS).o entry_$(BITS).o
+obj-y = do_syscall_$(BITS).o entry_$(BITS).o os-Linux/
diff --git a/arch/x86/um/nommu/os-Linux/Makefile b/arch/x86/um/nommu/os-Linux/Makefile
new file mode 100644
index 000000000000..4571e403a6ff
--- /dev/null
+++ b/arch/x86/um/nommu/os-Linux/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y = mcontext.o
+USER_OBJS := mcontext.o
+
+include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/x86/um/nommu/os-Linux/mcontext.c b/arch/x86/um/nommu/os-Linux/mcontext.c
new file mode 100644
index 000000000000..b62a6195096f
--- /dev/null
+++ b/arch/x86/um/nommu/os-Linux/mcontext.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/ucontext.h>
+#define __FRAME_OFFSETS
+#include <asm/ptrace.h>
+#include <sysdep/ptrace.h>
+#include <sysdep/mcontext.h>
+
+extern long __kernel_vsyscall(int64_t a0, int64_t a1, int64_t a2, int64_t a3,
+			      int64_t a4, int64_t a5, int64_t a6);
+
+void set_mc_sigsys_hook(mcontext_t *mc)
+{
+	mc->gregs[REG_RCX] = mc->gregs[REG_RIP];
+	mc->gregs[REG_RIP] = (unsigned long) __kernel_vsyscall;
+}
diff --git a/arch/x86/um/shared/sysdep/mcontext.h b/arch/x86/um/shared/sysdep/mcontext.h
index 6fe490cc5b98..9a0d6087f357 100644
--- a/arch/x86/um/shared/sysdep/mcontext.h
+++ b/arch/x86/um/shared/sysdep/mcontext.h
@@ -17,6 +17,10 @@ extern int get_stub_state(struct uml_pt_regs *regs, struct stub_data *data,
 extern int set_stub_state(struct uml_pt_regs *regs, struct stub_data *data,
 			  int single_stepping);
 
+#ifndef CONFIG_MMU
+extern void set_mc_sigsys_hook(mcontext_t *mc);
+#endif
+
 #ifdef __i386__
 
 #define GET_FAULTINFO_FROM_MC(fi, mc) \
-- 
2.43.0


