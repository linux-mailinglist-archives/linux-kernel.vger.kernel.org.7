Return-Path: <linux-kernel+bounces-870716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 344A7C0B864
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 01:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EEDD4EDD93
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 00:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D5321257E;
	Mon, 27 Oct 2025 00:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q8PZUXJ/"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78161DFD9A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761524325; cv=none; b=gsFgb5QFxkREndMCTacMokfxZHNNq7fYbnrVk+rVzr6x547Z+xA3yNpZOslQSH4JqF3D2HLfNH6ISUEblfJJceF0xdTlb/LEZZyHqyMSJPd1lVgExJFsm53kHRDu1GvYlIuKgB1wWgIq2YMzl3GIoMwEp3lo/BrvLUhzunQ2TXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761524325; c=relaxed/simple;
	bh=/bytV+P0QzJ2BkHlgOCUL+wKnHuQg6wcFuWibL7DaWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X3rGWqN3p9AwBRrvAA0bedWs7B7Izxshw46qpC94JuUedtWoYbIuVPM3xJZfjoUu3tFXsJY1jdWwSLNFPZbWh+aBnSzxWcYMGhgi3p/MSG6XsH/Kz0I8MujsQZkQ/fTXzxNBJRU2jNe9WhHNf9HqNygmTfapOe+0LYNLhk8Bc4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q8PZUXJ/; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761524320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yN0Jw1zCGCU2swiMeoJP4VIvF3PJD+YGhgn1SWJiEQ=;
	b=Q8PZUXJ/EFYmqfsILLrn33GI2LpzoVpOYBn1f/BIYssTfx9gjrppPCCAZ3n5cmcnPPfYdp
	i0BIgEY0kHVfH7XF7b5cbEI41wIZu8fxNgRSzhRlsZXWuo9wwWEMn/MTR1sQukRG0goVGX
	7R/et7Hpnq1H+UkawmRUWBLvKEViJV8=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	benjamin@sipsolutions.net,
	arnd@arndb.de,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH v4 3/8] um: Determine sleep based on need_resched()
Date: Mon, 27 Oct 2025 08:18:10 +0800
Message-Id: <20251027001815.1666872-4-tiwei.bie@linux.dev>
In-Reply-To: <20251027001815.1666872-1-tiwei.bie@linux.dev>
References: <20251027001815.1666872-1-tiwei.bie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tiwei Bie <tiwei.btw@antgroup.com>

With SMP and NO_HZ enabled, the CPU may still need to sleep even
if the timer is disarmed. Switch to deciding whether to sleep based
on pending resched. Additionally, because disabling IRQs does not
block SIGALRM, it is also necessary to check for any pending timer
alarms. This is a preparation for adding SMP support.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/kern_util.h |  1 +
 arch/um/kernel/process.c           |  5 +++++
 arch/um/os-Linux/internal.h        |  5 +++++
 arch/um/os-Linux/signal.c          |  6 ++++++
 arch/um/os-Linux/time.c            | 15 +++++++++------
 5 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 00ca3e12fd9a..3daaa5c4b35d 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -55,6 +55,7 @@ extern int __uml_cant_sleep(void);
 extern int get_current_pid(void);
 extern int copy_from_user_proc(void *to, void *from, int size);
 extern char *uml_strdup(const char *string);
+int uml_need_resched(void);
 
 extern unsigned long to_irq_stack(unsigned long *mask_out);
 extern unsigned long from_irq_stack(int nested);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 757e21185a0e..a60230b299da 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -221,6 +221,11 @@ int __uml_cant_sleep(void) {
 	/* Is in_interrupt() really needed? */
 }
 
+int uml_need_resched(void)
+{
+	return need_resched();
+}
+
 extern exitcall_t __uml_exitcall_begin, __uml_exitcall_end;
 
 void do_uml_exitcalls(void)
diff --git a/arch/um/os-Linux/internal.h b/arch/um/os-Linux/internal.h
index 5d8d3b0817a9..c2c7a0dc673c 100644
--- a/arch/um/os-Linux/internal.h
+++ b/arch/um/os-Linux/internal.h
@@ -15,6 +15,11 @@ void scan_elf_aux(char **envp);
  */
 void check_tmpexec(void);
 
+/*
+ * signal.c
+ */
+int timer_alarm_pending(void);
+
 /*
  * skas/process.c
  */
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 58da8c6ece98..554a87dd32cc 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -20,6 +20,7 @@
 #include <um_malloc.h>
 #include <sys/ucontext.h>
 #include <timetravel.h>
+#include "internal.h"
 
 void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *, void *mc) = {
 	[SIGTRAP]	= relay_signal,
@@ -159,6 +160,11 @@ void timer_set_signal_handler(void)
 	set_handler(SIGALRM);
 }
 
+int timer_alarm_pending(void)
+{
+	return !!(signals_pending & SIGALRM_MASK);
+}
+
 void set_sigstack(void *sig_stack, int size)
 {
 	stack_t stack = {
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 4d5591d96d8c..f3d4547e5227 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -15,6 +15,7 @@
 #include <kern_util.h>
 #include <os.h>
 #include <string.h>
+#include "internal.h"
 
 static timer_t event_high_res_timer = 0;
 
@@ -98,18 +99,20 @@ long long os_nsecs(void)
  */
 void os_idle_sleep(void)
 {
-	struct itimerspec its;
 	sigset_t set, old;
 
-	/* block SIGALRM while we analyze the timer state */
+	/* Block SIGALRM while performing the need_resched check. */
 	sigemptyset(&set);
 	sigaddset(&set, SIGALRM);
 	sigprocmask(SIG_BLOCK, &set, &old);
 
-	/* check the timer, and if it'll fire then wait for it */
-	timer_gettime(event_high_res_timer, &its);
-	if (its.it_value.tv_sec || its.it_value.tv_nsec)
+	/*
+	 * Because disabling IRQs does not block SIGALRM, it is also
+	 * necessary to check for any pending timer alarms.
+	 */
+	if (!uml_need_resched() && !timer_alarm_pending())
 		sigsuspend(&old);
-	/* either way, restore the signal mask */
+
+	/* Restore the signal mask. */
 	sigprocmask(SIG_UNBLOCK, &set, NULL);
 }
-- 
2.34.1


