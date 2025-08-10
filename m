Return-Path: <linux-kernel+bounces-761329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA60B1F881
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6EED7ADCE5
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 05:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DCB1EEA47;
	Sun, 10 Aug 2025 05:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OlFukPY3"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904F1FCCF8
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 05:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754805138; cv=none; b=rzv5OAjfApb8Sg9nBgxwga7jdQVkp9mOqMfZFp7DrwhkAm5+v6+r8qReUcxi5rxPhSvPfKwIidEEr5AAavBqbY+/hbDhHLYHg9YsNS/3D9RxBha2yOlKNbZnakV6G2oM8A8LxDanVb4K1eCyaD2j9cATT/PLTKAfpJlH9a5Wb40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754805138; c=relaxed/simple;
	bh=acBRSZbrEpqi3lnap8oUxvvIcutNWNbW6vv+VjCL1N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VXTb/+ui/lC+W4dA/THPKUq7zqozNQAXfBNOGk07bWiyq+dsjVJG7UeS/Th+IXUYLidJT6p0FUC88S/Agv3Gamcprd+OyuCABR7y7pS+jp4qjWFki2ciBS3Fa+xlAZLnu5nmyXP28kUdHvOUxIa3TUyOtmkq5OYGrvu7ZuXMA3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OlFukPY3; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754805133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LrFS7N8p/JHZD+0Aak4dVrLUX8Ckh4/iyF2T8Dum6MY=;
	b=OlFukPY3XxdbpeTk4pmML6sft29u5VqQJV9uj/paWBPDOb9tzNZFXpvKh1Or1aROnUGdR1
	vH/+68LtTWGwOjUlL6ou0+lG+kppYJkB32tL9msU6Qx+7ubSOPzUcm5CNQrKX1/cNLGeih
	/jJhfSv8SHEC/FM3UH9X8h9twYv+zj4=
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
Subject: [PATCH v2 05/10] um: Determine sleep based on need_resched()
Date: Sun, 10 Aug 2025 13:51:31 +0800
Message-Id: <20250810055136.897712-6-tiwei.bie@linux.dev>
In-Reply-To: <20250810055136.897712-1-tiwei.bie@linux.dev>
References: <20250810055136.897712-1-tiwei.bie@linux.dev>
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
on pending resched. This is a preparation for adding SMP support.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/kern_util.h |  1 +
 arch/um/kernel/process.c           | 12 ++++++++++--
 arch/um/os-Linux/time.c            | 11 +++++------
 3 files changed, 16 insertions(+), 8 deletions(-)

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
index 1be644de9e41..01b935c00454 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -209,10 +209,13 @@ int arch_dup_task_struct(struct task_struct *dst,
 
 void um_idle_sleep(void)
 {
-	if (time_travel_mode != TT_MODE_OFF)
+	if (time_travel_mode != TT_MODE_OFF) {
 		time_travel_sleep();
-	else
+	} else {
+		raw_local_irq_enable();
 		os_idle_sleep();
+		raw_local_irq_disable();
+	}
 }
 
 void arch_cpu_idle(void)
@@ -225,6 +228,11 @@ int __uml_cant_sleep(void) {
 	/* Is in_interrupt() really needed? */
 }
 
+int uml_need_resched(void)
+{
+	return need_resched();
+}
+
 extern exitcall_t __uml_exitcall_begin, __uml_exitcall_end;
 
 void do_uml_exitcalls(void)
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 4d5591d96d8c..f25a4196bab7 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -98,18 +98,17 @@ long long os_nsecs(void)
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
+	/* Sleep if no resched is pending. */
+	if (!uml_need_resched())
 		sigsuspend(&old);
-	/* either way, restore the signal mask */
+
+	/* Restore the signal mask. */
 	sigprocmask(SIG_UNBLOCK, &set, NULL);
 }
-- 
2.34.1


