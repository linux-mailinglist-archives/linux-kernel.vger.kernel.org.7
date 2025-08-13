Return-Path: <linux-kernel+bounces-767153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEE5B24FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0975C1FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBD528D8DA;
	Wed, 13 Aug 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s6LidLSZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CUPZ+ECv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4C02874E9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102574; cv=none; b=eiPNoacfvFqtG1gg+tonO1LMxFNXX7CLi761i4hlC/ORAVmilcU2n8FCI0kFfcKZLHhtsrgHwRfQNvRRhiTrXbyMKMjQ/848Lmguj2WQ/hPkplcd4Qg/aVNJP2i6qwIv20+Ta2ybm7fxGgNfa9MKKvttV8GhsTjo8Rq5RHKSfUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102574; c=relaxed/simple;
	bh=IgZmxkLq3m2Z80XEeemlqIVhV3dreYfNDbiNxXNy3Wo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=OVJkAWjmgwmWohPVxtoRhn0q+E6OWOnzXRgPj8hR+8L/VslGvKWFg+2R7z1+anVBPVsUGdSTF7pgcj57E0KXV5kwsStCI3qbHOFGaEd7of5lQXVjH0nm7ANwPTxaZKgcxwMWQYLE2Ddn6Fx4CkjQSWN+W8ofp5gHLaPae34Lqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s6LidLSZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CUPZ+ECv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813162824.228728594@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755102571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vFxQdIIT/kyuIG3Fn10fgvET/1WhG4dHE+HshN4w1HQ=;
	b=s6LidLSZzXzx9XybgpPVOqVexjDOCBt59in4CnnrxRopFEYVfTM5Ne/Hc+VTuxUuaGCzjc
	AXvpQ13Nr8LqV47xEEoR0XkAMf6lgDBCyV2XlknKAH6wnE2R1nEcp+rNpLEZ30rtDtta46
	RAeFZt9pT+EJCzKqMGS0RDtXyeTeuaSOFhy0PwjylqmHWmBjNqL5Sgh5KRcIFVFh3MAduX
	YApYza+Q0Zdcb21oVoYkzS9dkXFLH5rvbOMIEqD4LLHudi2f9ZdtFowhVOmdj3wnHK864+
	SlbqCglqGEp5ypgDPBnyrg3iiHwi0R/dO7rC9+fvhjtqIfhKioD42Ttunm2Tnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755102571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vFxQdIIT/kyuIG3Fn10fgvET/1WhG4dHE+HshN4w1HQ=;
	b=CUPZ+ECvk//HuwvBkdK4yb+tlhSuKWFaFc6CW9soowSyp8tWzb/QbgCjnOdwnxvLDe/oLB
	Vi00Keem3OoZRNBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [patch 07/11] entry: Cleanup header
References: <20250813155941.014821755@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 18:29:29 +0200 (CEST)

Cleanup the include ordering, kernel-doc and other trivialities before
making further changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/entry-common.h     |    8 ++++----
 include/linux/irq-entry-common.h |    2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -3,11 +3,11 @@
 #define __LINUX_ENTRYCOMMON_H
 
 #include <linux/irq-entry-common.h>
+#include <linux/livepatch.h>
 #include <linux/ptrace.h>
+#include <linux/resume_user_mode.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
-#include <linux/livepatch.h>
-#include <linux/resume_user_mode.h>
 
 #include <asm/entry-common.h>
 #include <asm/syscall.h>
@@ -37,6 +37,7 @@
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
 				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
 				 ARCH_SYSCALL_WORK_ENTER)
+
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
@@ -61,8 +62,7 @@
  */
 void syscall_enter_from_user_mode_prepare(struct pt_regs *regs);
 
-long syscall_trace_enter(struct pt_regs *regs, long syscall,
-			 unsigned long work);
+long syscall_trace_enter(struct pt_regs *regs, long syscall, unsigned long work);
 
 /**
  * syscall_enter_from_user_mode_work - Check and handle work before invoking
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -68,6 +68,7 @@ static __always_inline bool arch_in_rcu_
 
 /**
  * enter_from_user_mode - Establish state when coming from user mode
+ * @regs:	Pointer to currents pt_regs
  *
  * Syscall/interrupt entry disables interrupts, but user mode is traced as
  * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
@@ -357,6 +358,7 @@ irqentry_state_t noinstr irqentry_enter(
  * Conditional reschedule with additional sanity checks.
  */
 void raw_irqentry_exit_cond_resched(void);
+
 #ifdef CONFIG_PREEMPT_DYNAMIC
 #if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 #define irqentry_exit_cond_resched_dynamic_enabled	raw_irqentry_exit_cond_resched


