Return-Path: <linux-kernel+bounces-815728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF41B56A5E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2027F17D661
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACC02DF130;
	Sun, 14 Sep 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f/B4PnvK"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13012DCF45
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757865470; cv=none; b=pRcW6fNZexh38d8XpZTmlDvGbvOTwkWe8uCy4gHunNQIzu03OnbJPTYyIjXWQb6/TAX+wAYNLFjkin0WU7vJd5C6ZFx6mLP3KIWep0jEGuasojMSzpSKAqJLaP2CoqvWPoackoFSmu99snPmaADrJjIH5ALOlCJd395iGcDTjaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757865470; c=relaxed/simple;
	bh=oyU8/VCpzdYGFiF/koX3bPMgohukl7k2VfwI+lXHZ6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PiBVQlr0uisey7H2PklqZhYPgsQTenlSGDpivEAnnrbW7DC0Q9Tday+jOz56YIwlRjr4E82yiMs1lBDUIeHKo6vGHuYWvVdWlhtxbTjuQE9vkbe+oLU1S8/V1TlJsIHYwVdFCWvb+xjtSJ1We5aMBk0B8lAjCunnlMeqDt4llhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f/B4PnvK; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757865465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uWHTAE/9tK2VmYtJYChd0m6RlqKlICrq+eONEttRyNc=;
	b=f/B4PnvK67yJlD9oFLRA2LCJgt2inszhoK2k7stiHdEgjOKdiNpA60Vkrht7OTRZOuu9YW
	Fj+UEwnV8NIyOQ2Nko4WMXveMcdKXpzAkEBYT50TdWEZ0u58lHZnrEGAgfNpSz5Nwk1kWT
	O2a6vteizNXDWeP/HCKPXqEAcSZhTwg=
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
Subject: [PATCH v3 2/7] um: Determine sleep based on need_resched()
Date: Sun, 14 Sep 2025 23:56:53 +0800
Message-Id: <20250914155658.1028790-3-tiwei.bie@linux.dev>
In-Reply-To: <20250914155658.1028790-1-tiwei.bie@linux.dev>
References: <20250914155658.1028790-1-tiwei.bie@linux.dev>
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
index 1be644de9e41..41b3b3bf7309 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -225,6 +225,11 @@ int __uml_cant_sleep(void) {
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


