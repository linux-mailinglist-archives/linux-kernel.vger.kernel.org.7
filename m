Return-Path: <linux-kernel+bounces-881714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C353C28CC7
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 10:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E09914E5802
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AFC2701DA;
	Sun,  2 Nov 2025 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lua6H8m6"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88B26F28A
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762077002; cv=none; b=YL8c0LigAmXqwQtoDtH/juJVWxC/sqnq/nyIBU7p6BohAbS3zzSdiQHtQWFvGle0R/WApD00/gUwZBtYLPdVkBKNfuZpHEW0cyxd6hX3KSKuwbUrnZ9Rnu5+RI1GnCuVTQOqeGPRdBw8uuq/cZc9VO6TfYbiLt8hjmh3a6svIR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762077002; c=relaxed/simple;
	bh=w/P0WV8/06U9fcziuDHn0Wwv3zpkumouszCtz0x7ivA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBWJKyxEb9t74shU2F4svONTaD8+4yh78BdrVjqLdbNZW2hrV+p4VJmQI/k2S/hIEFtY+9rnodCt3jH8oIdg9SyZoqt6zFN7tgd34sgBwGCfaqc68wSxQJxLFQQFAE7IYVpEBJnbVUTAnhLhQKVtlhSYWpJ2f6Ej/eaIpVTxjSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lua6H8m6; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3407f385dd0so1882238a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 01:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076999; x=1762681799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVM2G4FP/w8QD00uu0HK9wDNN1nmcST3P93SXeGJtYY=;
        b=Lua6H8m6HWuex0+2+eso9rajpR1ykoco35u7xJRNmTgV/mOB5DlcNJxMrsOhbJ+B7Y
         KelMvCRO+R7c5tgNFiC6PLNpTS6s/RKdZi80ezRI/7+RMKXTBjOM4Wgkp+VA8ovJ28G8
         8nkT/Do+n0eMH9Ly8kFY2jTnrPFAq8r/FzdF4ZA0C+WKTxjo3DaHmctn9iXJ/AoMhKBO
         FFboW3R/DhSp05upKAHjoNhpE821zYeaTDiMpBCnHfLuMo2V+sdsZra5sMWY8g2miUmr
         ThogYKpNJegvsj1HG2utIU1ZsS+ClnUKUwZADQB5X2A64Q6ZJa3zbrHJIT42sc5zjay0
         DAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076999; x=1762681799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVM2G4FP/w8QD00uu0HK9wDNN1nmcST3P93SXeGJtYY=;
        b=WKIOOxy25C8aGLm4N8TAcwF6tpJ/HMKgd0GpbfbrEDbdh7q6pfr7SCrQHKLdfJ6rzK
         X6mt0WTBWNtBIGTLRHWyp468PN02Kgkggwr3H+U1PI/HKFceTRZEy30c/InwtTGLflv9
         cKKd3Io5ARlxCCRiQ3j/bUI9juX/vWa9MCSo9oZWvVH22/YVHBfrgtmvN/koAKAyCeKK
         gQdmAYctP3Ko8H8VLwsJ/uhkasDq5La5DTFzhUo2dTBZszIYe7AfsDc3lsaSKzmzAj0i
         6hjzHhDzXCFot8WgQ4Z9GWtoqwgTqMrO5mggaDIHsMGHHT+plADcYkCBcZittElG25lj
         Uz0g==
X-Forwarded-Encrypted: i=1; AJvYcCXNhFbLmGBJeSJ0A6rvBckEOTsiH3lOxU8cLFCbMR9YUBQ7PJLDiheFuhouUktB0GsC9cz8jK0sAyK+arA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTEnIjPAHKbzQBZLIAZqwV/TujoJCDkebgxwjBTWxpxeDsQLTc
	RKKS9IsZjVO88ouRoEUWG1nTE2ulfwiWCOwom9gP7axHUHkun/tUcOI5
X-Gm-Gg: ASbGnctRlYfWykMr9ZLsTtw9GF6LeWcLpvDv7xgtGsfm+ZHxwH7FVAQyjEOrYMb3Jml
	LybGW+8Xb2BhOjvDajqyddDaRn3yAD+QjT2e37MSSEvsF0wTOv3hhRoI+RToDgk+QOZfPNtCqdB
	RXd0p0iVvgCv4WS4VmY6wi2EwGdEPAXhGvTi2vbWQ3KsdkykjQjxEp2dZV6oJsfftYeLMG5PeZ9
	leQQXFuqYPDuIjBnQ37ISHdyteXoedQQFC9vD1Q332ACUQrOa4BWcsSaihRyZDPsUhD7nX9iU/N
	cLvRfZnn9LUemIXF8vg9iRwjvrckiznLBMvq75e1xlXOLH02uLHfRiBF0i47q8GrVcgIwhkDmCU
	20K36vY/FCMnSALUB2xlQDSjXD/s0R9cDA8Obk9jftnJK+J72yf1DMyPwSP13Cd1WCwDixZdT5u
	jwRJbIyfAamKCSfGc1+UVHKfPCQczGDDYUoGEVrn7wQmnToUu4AMXZ1yv6
X-Google-Smtp-Source: AGHT+IEGAiub3al+B+1jEkCyOgGZofHqkuwFGRsJXjVCnAfatIVXeTAFwQSvpFLTzPP2lopemXTUgw==
X-Received: by 2002:a17:90b:2ccb:b0:340:f7d6:dc70 with SMTP id 98e67ed59e1d1-340f7d6e39fmr2375548a91.13.1762076999483;
        Sun, 02 Nov 2025 01:49:59 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340d1a4a587sm3387074a91.3.2025.11.02.01.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:56 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 5DC30112380B; Sun,  2 Nov 2025 18:49:52 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 07/13] um: nommu: configure fs register on host syscall invocation
Date: Sun,  2 Nov 2025 18:49:32 +0900
Message-ID: <86fc0b173ac530454a0f0e33f5100e0b60e37730.1762075876.git.thehajime@gmail.com>
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


