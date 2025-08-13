Return-Path: <linux-kernel+bounces-767158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B984EB24FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D13C1BC5F97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40422877E3;
	Wed, 13 Aug 2025 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ONHD7JLB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+qlJPQSL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2E299948
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102583; cv=none; b=Y/UkundntD9MjsDnkYhx4QZyvw7jO30BNxIcYipXupWkKKq8bNieZS2kv0ArzIqNNicuqvNtBKCaMab9zPeZb8f9Sy/bcqoM12qwBjES6N5JqZvcK896nS9OdXf04mrFjX76fUGYQtAovJPF+ItYGG51XDY8ur2CeLfiVgzfoxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102583; c=relaxed/simple;
	bh=e++jtXx1AVP8PYbK2GIyL33zMqQDaIpLZ87iJxg+IGs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bs7FWEMcn5HnH0iE+XQZLcgiib2F61Ocrt0nQprRlo8CuWYu9Y4zdmeLPtQmRNAyZgblE7RivGtZKFsfuM6hMAeQJzrTucYCgpDEWc0AvPv5722bS+MnKTYdQFHsm9MnsaWja1ZpZTisSYvUI3vZpeoGsksD2Vgi0CRwtlKGn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ONHD7JLB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+qlJPQSL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813162824.420583910@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755102578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0UA6AfVfDpisXE6yID1nZmppuD1kF4OtUvT17obAfwI=;
	b=ONHD7JLBTZq02oCQ0B5e4tqUJzwls6ViJ83dahpsPy7fEX5y7V6qyVapNMcxoTSTyv0bCV
	HqgF2LxacgsvHJbu8K87u+tO2YYH+NYymM8UYnzY0OsV+killjtmPlNOEhqQAGt7D2LoD/
	EidY4RT6YJ65czpgbVwnAsHCPCCfDoQsxAjee37KAWdbpc8wYkScqpIUetDe2BuCKqWv0r
	YBsMOgwlpQAnD3RdHoWhGtvyr0UJSdCUfIofBsO1/xrtSkalmOgw8n/e6MN02iZeqWZGRm
	1WBCUxCEWnVmbdFQMILLImmQ3rnsf7yw3zT6ycx4ulBWX0Ne6OE+tBO5olhf/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755102578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0UA6AfVfDpisXE6yID1nZmppuD1kF4OtUvT17obAfwI=;
	b=+qlJPQSLuRF33XC8WEySzbXKOe0sRbmXf0cYPjXrtvIsSY07p4O+s+pJ1UJ7d31G4NkXuo
	6r42Mx7lHST8N1Dw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [patch 10/11] rseq: Skip fixup when returning from a syscall
References: <20250813155941.014821755@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 18:29:37 +0200 (CEST)

The TIF_NOTIFY_RESUME handler of restartable sequences is invoked as all
other functionality unconditionally when TIF_NOTIFY_RESUME is set for
what ever reason.

The invocation is already conditional on the rseq_event_pending bit being
set, but there is further room for improvement.

The heavy lifting of critical section fixup can be completely avoided, when
the exit to user mode loop is from a syscall unless it's a debug
kernel. There was no way for the RSEQ code to distinguish that case so far.

On architectures, which enable CONFIG_GENERIC_ENTRY, the information is now
available through a function argument to exit_to_user_notify_resume(),
which tells whether the invocation comes from return from syscall or return
from interrupt.

Let the RSEQ code utilize this 'from_irq' argument when

    - CONFIG_GENERIC_ENTRY is enabled
    - CONFIG_DEBUG_RSEQ is disabled

and skip the critical section fixup when the invocation comes from a
syscall return. The update of CPU and node ID has to happen in both cases,
so the out of line call has always to happen, when a event is pending
whether it's a syscall return or not.

This changes the current behaviour, which just blindly fixes up the
critical section unconditionally in the syscall case. But that's a user
space problem when it invokes a syscall from within a critical section and
expects it to work. That code was clearly never tested on a debug kernel
and user space can keep the pieces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/resume_user_mode.h |    2 +-
 include/linux/rseq.h             |   12 ++++++------
 kernel/rseq.c                    |   22 +++++++++++++++++++++-
 3 files changed, 28 insertions(+), 8 deletions(-)

--- a/include/linux/resume_user_mode.h
+++ b/include/linux/resume_user_mode.h
@@ -60,7 +60,7 @@ static inline void exit_to_user_notify_r
 	mem_cgroup_handle_over_high(GFP_KERNEL);
 	blkcg_maybe_throttle_current();
 
-	rseq_handle_notify_resume(regs);
+	rseq_handle_notify_resume(regs, from_irq);
 }
 
 #ifndef CONFIG_GENERIC_ENTRY
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -13,19 +13,19 @@ static inline void rseq_set_notify_resum
 		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
 }
 
-void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
+void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs,
+				 bool from_irq);
 
-static inline void rseq_handle_notify_resume(struct pt_regs *regs)
+static inline void rseq_handle_notify_resume(struct pt_regs *regs, bool from_irq)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_RESQ) || READ_ONCE(current->rseq_event_pending))
-		__rseq_handle_notify_resume(NULL, regs);
+		__rseq_handle_notify_resume(NULL, regs, from_irq);
 }
 
-static inline void rseq_signal_deliver(struct ksignal *ksig,
-				       struct pt_regs *regs)
+static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs *regs)
 {
 	if (current->rseq)
-		__rseq_handle_notify_resume(ksig, regs);
+		__rseq_handle_notify_resume(ksig, regs, false);
 }
 
 static inline void rseq_notify_event(struct task_struct *t)
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -408,6 +408,22 @@ static int rseq_ip_fixup(struct pt_regs
 	return 0;
 }
 
+static inline bool rseq_ignore_event(bool from_irq, bool ksig)
+{
+	/*
+	 * On architectures which do not select_GENERIC_ENTRY
+	 * @from_irq is not usable.
+	 */
+	if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || !IS_ENABLED(CONFIG_GENERIC_ENTRY))
+		return false;
+
+	/*
+	 * Avoid the heavy lifting when this is a return from syscall,
+	 * i.e. not from interrupt and not from signal delivery.
+	 */
+	return !from_irq && !ksig;
+}
+
 /*
  * This resume handler must always be executed between any of:
  * - preemption,
@@ -419,7 +435,8 @@ static int rseq_ip_fixup(struct pt_regs
  * respect to other threads scheduled on the same CPU, and with respect
  * to signal handlers.
  */
-void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
+void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs,
+				 bool from_irq)
 {
 	struct task_struct *t = current;
 	int ret, sig;
@@ -467,6 +484,9 @@ void __rseq_handle_notify_resume(struct
 			t->rseq_event_pending = false;
 		}
 
+		if (rseq_ignore_event(from_irq, !!ksig))
+			event = false;
+
 		if (IS_ENABLED(CONFIG_DEBUG_RSEQ) || event) {
 			ret = rseq_ip_fixup(regs, event);
 			if (unlikely(ret < 0))


