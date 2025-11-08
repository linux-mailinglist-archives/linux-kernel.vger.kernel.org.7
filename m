Return-Path: <linux-kernel+bounces-891385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77F3C42924
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0888B3A7DF9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29EE2E8B60;
	Sat,  8 Nov 2025 08:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Czr+DYGU"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C654288C22
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589175; cv=none; b=usq86QaCtcc7qvn3wpzpHrqHy4/0FDmB/cKkm8tU81+w1KlDUGh8m7u4mBpDL2wX3wBYC1F8N8VPgv1wXiAS6xFsOf4p/KgVfV6tkw2HS18Tn2xJpnvpHKsBej//4pcpcyBK96soFtDRBCJL9tm8x2RB+nGfJdSiPBOFdSeiBRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589175; c=relaxed/simple;
	bh=w/P0WV8/06U9fcziuDHn0Wwv3zpkumouszCtz0x7ivA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGHAou4zc15hV4dRPf4PVtUUzCU979Vs2Y6mqpG/CzKRP6rv8yzPfBiRqWcc+1ohTyuCaD8nOOdhsRolFE3fiLOlj0UD/SWmqdXt0NR3gwQvjASnAYnVhQWWwcYxOqgYWhmD/mX2kaJ7582oTcbo/xFvtRkRORtxyttn/TZv+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Czr+DYGU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-294df925292so16314305ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 00:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589173; x=1763193973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVM2G4FP/w8QD00uu0HK9wDNN1nmcST3P93SXeGJtYY=;
        b=Czr+DYGUtgCkR3/FHGIUfpRL8Vz2eH6QCIIi3OvCVhReh0ULCvHAZw833RSUJbgZ8j
         ll73ZvVNAjm0LErOtz0uadEM3j3NUMyJ7qtSGGnpCghbagwOK6FYsUztfUshfJwdhrm9
         TM0C3hWHDa6oUwIQdTLxXm/z2kqzoYJMVRSGFUS98nbfvqFtATtaF9L2PrJdGN8+pvSu
         XS5D6EtKv5dDyJwCKJNABtVipCXgfYAw9QKMsj1WBMl/2V4eSMAM8RkmRiBzIwl9hLjI
         htC8HHzVbpntx/m/V+7Jgn88Qn4zTtEZvcGckiFsVfkc4U0ppExADhLNObWDj/jNBQNQ
         cT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589173; x=1763193973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SVM2G4FP/w8QD00uu0HK9wDNN1nmcST3P93SXeGJtYY=;
        b=pErXONA57w460vaR6nNlpe+c/cMkrYiLZsz3pADXFtcZCOotCyMm6gGiJbPfss4ulc
         HrkIMAVrxV88BBplfQUA2wUiDhEmioHb0xTg30UPKhcvZqSMv6qS3/A+ya8LwVRIAkb8
         ygkpZZl1uhWkxq8PuUZIwVTNyFXkRuqOHuvaWufLPJczks0a3oyQ1dCn7pxzyYmYs5k5
         AbcBP2im+MBPh7AchXUuD28m//2ZzHQJ85KIxG2mNChHhFLuUDibgB9jIktBH5U/Nz75
         jJCDV54JUz2ob9iKOSQ6UdLGmnHeQKjbCIkyjDlAXWiQU2au9yOx6wk01sxeVq8ZJbCE
         YFkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0f2H/9YjWHumJ78sODJsaSFYyS2LFVcANnLT/TkuMrJtzagOmfmMcybLslnEANrZyftmu6sc7uN60Phg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5RsB4oNHGhL4yR1dIdJ8fEXHjWBgp6D9JbPzFENUKtR/Hcpge
	FfhpQ5qQl1WCdmZWzCx/X7tdfz12j+uSgSbnWsx9Ym6I5HSwGeF3SEAW
X-Gm-Gg: ASbGncvcY6H753C1RNPvVaIWhkVcq5swifTTCo24zAaJ8E1f1qMQ1BROcekTeeKyhUK
	UyHUxUFCarQSQ1CgikQhtpI6scFnIwd/G8QpR0i9srrz6cnc/yi+xVkcw/aKASRZD4B6wi2B4YK
	xuipoSD/KdHjOy6bLupZJdV8cPB3R7f7NwuLPqvrTzVR+WymppU3QoVDn9I6mPKkjkhZCWGTc4A
	pvmd215qrg0mkvM7dGdRnI1IKbJMnYKqYUO0wnpJ1CAdQx6OBwRMB8ZaDOkT6n/5jZb+mlu/nyR
	SL62jV6BQu+DnFGiFyyWcWnGIjkOCw28TY4Ak74IBq/iKMCP03MHmdOJGfuTMTnxVXixfyXvE2B
	VLIZbZlia6hqaOPSiG9Wddpi3lPsIAp/Il7iQv6z8emh+nsRsWWC7EUPWxYy7qjhPuFYdIzIJhT
	rpPThyDFzLLXS0whAvVKAInjjGFS6rF5VI2PuZEgSX42XXtC+WE78zbdD1
X-Google-Smtp-Source: AGHT+IGcrMW5bAkx8lKAGWdpQHmJ3n1S/JnVjYsLNXBmw+OKie6VvCjaORE4fhcWJKknP0Cu7jRe/w==
X-Received: by 2002:a17:902:e947:b0:267:a5df:9b07 with SMTP id d9443c01a7336-297e53e7303mr23827725ad.12.1762589173061;
        Sat, 08 Nov 2025 00:06:13 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccc19asm81307265ad.104.2025.11.08.00.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:12 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 8272C11388D3; Sat,  8 Nov 2025 17:06:10 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 07/13] um: nommu: configure fs register on host syscall invocation
Date: Sat,  8 Nov 2025 17:05:42 +0900
Message-ID: <5b4fab636ab8cbd1db025a0561fe9993990fc869.1762588860.git.thehajime@gmail.com>
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

As userspace on UML/!MMU also need to configure %fs register when it is
running to correctly access thread structure, host syscalls implemented
in os-Linux drivers may be puzzled when they are called.  Thus it has to
configure %fs register via arch_prctl(SET_FS) on every host syscalls.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/um/include/shared/os.h       |  6 +++
 arch/um/os-Linux/process.c        |  6 +++
 arch/um/os-Linux/start_up.c       | 21 +++++++++
 arch/x86/um/nommu/do_syscall_64.c | 37 ++++++++++++++++
 arch/x86/um/nommu/syscalls_64.c   | 71 +++++++++++++++++++++++++++++++
 5 files changed, 141 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 5451f9b1f41e..0ac87507e05e 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -189,6 +189,7 @@ extern void check_host_supports_tls(int *supports_tls, int *tls_min);
 extern void get_host_cpu_features(
 	void (*flags_helper_func)(char *line),
 	void (*cache_helper_func)(char *line));
+extern int host_has_fsgsbase;
 
 /* mem.c */
 extern int create_mem_file(unsigned long long len);
@@ -213,6 +214,11 @@ extern int os_protect_memory(void *addr, unsigned long len,
 extern int os_unmap_memory(void *addr, int len);
 extern int os_drop_memory(void *addr, int length);
 extern int can_drop_memory(void);
+extern int os_arch_prctl(int pid, int option, unsigned long *arg);
+#ifndef CONFIG_MMU
+extern long long host_fs;
+#endif
+
 
 void os_set_pdeathsig(void);
 
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index ddb5258d7720..dacf63ac33c8 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -18,6 +18,7 @@
 #include <sys/prctl.h>
 #include <sys/wait.h>
 #include <asm/unistd.h>
+#include <sys/syscall.h>   /* For SYS_xxx definitions */
 #include <linux/threads.h>
 #include <init.h>
 #include <longjmp.h>
@@ -179,6 +180,11 @@ int __init can_drop_memory(void)
 	return ok;
 }
 
+int os_arch_prctl(int pid, int option, unsigned long *arg2)
+{
+	return syscall(SYS_arch_prctl, option, arg2);
+}
+
 void init_new_thread_signals(void)
 {
 	set_handler(SIGSEGV);
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 33e039d2c1bf..c0afe5d8b559 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -20,6 +20,8 @@
 #include <sys/resource.h>
 #include <asm/ldt.h>
 #include <asm/unistd.h>
+#include <sys/auxv.h>
+#include <asm/hwcap2.h>
 #include <init.h>
 #include <os.h>
 #include <smp.h>
@@ -37,6 +39,8 @@
 #include <skas.h>
 #include "internal.h"
 
+int host_has_fsgsbase;
+
 static void ptrace_child(void)
 {
 	int ret;
@@ -460,6 +464,20 @@ __uml_setup("seccomp=", uml_seccomp_config,
 "    This is insecure and should only be used with a trusted userspace\n\n"
 );
 
+static void __init check_fsgsbase(void)
+{
+	unsigned long auxv = getauxval(AT_HWCAP2);
+
+	os_info("Checking FSGSBASE instructions...");
+	if (auxv & HWCAP2_FSGSBASE) {
+		host_has_fsgsbase = 1;
+		os_info("OK\n");
+	} else {
+		host_has_fsgsbase = 0;
+		os_info("disabled\n");
+	}
+}
+
 void __init os_early_checks(void)
 {
 	int pid;
@@ -488,6 +506,9 @@ void __init os_early_checks(void)
 	using_seccomp = 0;
 	check_ptrace();
 
+	/* probe fsgsbase instruction */
+	check_fsgsbase();
+
 	pid = start_ptraced_child();
 	if (init_pid_registers(pid))
 		fatal("Failed to initialize default registers");
diff --git a/arch/x86/um/nommu/do_syscall_64.c b/arch/x86/um/nommu/do_syscall_64.c
index 292d7c578622..9bc630995df9 100644
--- a/arch/x86/um/nommu/do_syscall_64.c
+++ b/arch/x86/um/nommu/do_syscall_64.c
@@ -2,10 +2,38 @@
 
 #include <linux/kernel.h>
 #include <linux/ptrace.h>
+#include <asm/fsgsbase.h>
+#include <asm/prctl.h>
 #include <kern_util.h>
 #include <asm/syscall.h>
 #include <os.h>
 
+static int os_x86_arch_prctl(int pid, int option, unsigned long *arg2)
+{
+	if (!host_has_fsgsbase)
+		return os_arch_prctl(pid, option, arg2);
+
+	switch (option) {
+	case ARCH_SET_FS:
+		wrfsbase(*arg2);
+		break;
+	case ARCH_SET_GS:
+		wrgsbase(*arg2);
+		break;
+	case ARCH_GET_FS:
+		*arg2 = rdfsbase();
+		break;
+	case ARCH_GET_GS:
+		*arg2 = rdgsbase();
+		break;
+	default:
+		pr_warn("%s: unsupported option: 0x%x", __func__, option);
+		break;
+	}
+
+	return 0;
+}
+
 __visible void do_syscall_64(struct pt_regs *regs)
 {
 	int syscall;
@@ -13,6 +41,9 @@ __visible void do_syscall_64(struct pt_regs *regs)
 	syscall = PT_SYSCALL_NR(regs->regs.gp);
 	UPT_SYSCALL_NR(&regs->regs) = syscall;
 
+	/* set fs register to the original host one */
+	os_x86_arch_prctl(0, ARCH_SET_FS, (void *)host_fs);
+
 	if (likely(syscall < NR_syscalls)) {
 		unsigned long ret;
 
@@ -29,4 +60,10 @@ __visible void do_syscall_64(struct pt_regs *regs)
 
 	/* handle tasks and signals at the end */
 	interrupt_end();
+
+	/* restore back fs register to userspace configured one */
+	os_x86_arch_prctl(0, ARCH_SET_FS,
+		      (void *)(current->thread.regs.regs.gp[FS_BASE
+						     / sizeof(unsigned long)]));
+
 }
diff --git a/arch/x86/um/nommu/syscalls_64.c b/arch/x86/um/nommu/syscalls_64.c
index d56027ebc651..19d23686fc5b 100644
--- a/arch/x86/um/nommu/syscalls_64.c
+++ b/arch/x86/um/nommu/syscalls_64.c
@@ -13,8 +13,70 @@
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <registers.h>
 #include <os.h>
+#include <asm/thread_info.h>
+#include <asm/mman.h>
 #include "syscalls.h"
 
+/*
+ * The guest libc can change FS, which confuses the host libc.
+ * In fact, changing FS directly is not supported (check
+ * man arch_prctl). So, whenever we make a host syscall,
+ * we should be changing FS to the original FS (not the
+ * one set by the guest libc). This original FS is stored
+ * in host_fs.
+ */
+long long host_fs = -1;
+
+long arch_prctl(struct task_struct *task, int option,
+		unsigned long __user *arg2)
+{
+	long ret = -EINVAL;
+	unsigned long *ptr = arg2, tmp;
+
+	switch (option) {
+	case ARCH_SET_FS:
+		if (host_fs == -1)
+			os_arch_prctl(0, ARCH_GET_FS, (void *)&host_fs);
+		ret = 0;
+		break;
+	case ARCH_SET_GS:
+		ret = 0;
+		break;
+	case ARCH_GET_FS:
+	case ARCH_GET_GS:
+		ptr = &tmp;
+		break;
+	}
+
+	ret = os_arch_prctl(0, option, ptr);
+	if (ret)
+		return ret;
+
+	switch (option) {
+	case ARCH_SET_FS:
+		current->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)] =
+			(unsigned long) arg2;
+		break;
+	case ARCH_SET_GS:
+		current->thread.regs.regs.gp[GS_BASE / sizeof(unsigned long)] =
+			(unsigned long) arg2;
+		break;
+	case ARCH_GET_FS:
+		ret = put_user(current->thread.regs.regs.gp[FS_BASE / sizeof(unsigned long)], arg2);
+		break;
+	case ARCH_GET_GS:
+		ret = put_user(current->thread.regs.regs.gp[GS_BASE / sizeof(unsigned long)], arg2);
+		break;
+	}
+
+	return ret;
+}
+
+SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
+{
+	return arch_prctl(current, option, (unsigned long __user *) arg2);
+}
+
 void arch_set_stack_to_current(void)
 {
 	current_top_of_stack = task_top_of_stack(current);
@@ -48,3 +110,12 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
 
 	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
 }
+
+static int __init um_nommu_setup_hostfs(void)
+{
+	/* initialize the host_fs value at boottime */
+	os_arch_prctl(0, ARCH_GET_FS, (void *)&host_fs);
+
+	return 0;
+}
+arch_initcall(um_nommu_setup_hostfs);
-- 
2.43.0


