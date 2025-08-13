Return-Path: <linux-kernel+bounces-767152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 874B2B24FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B249D189C7B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4906728C877;
	Wed, 13 Aug 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eheYbEDR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WP+LsBLP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031E9287277
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102571; cv=none; b=nKJgyPbSTQo0fdetj/RuSIQtZX4P2+1kSKu3dhO0hbSyU+OxwDnThdyGEv+wq90eFjpg6WltVYXY6iLhWgswszgLvd4d9fJds5+xqkTte5ePH0XMZj7PUFxS3Mx/atgxHu8ggT9fiqH7LHcchftiqsUD5shQBx9LfJHzfiUdagI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102571; c=relaxed/simple;
	bh=O3nf3vQlO7UFs+0cmWzRz/9C26oMaQ0wGQoAjuRxuCo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=KlzNfrRwocxlhKi4p2/GI/qbnqajpAAi/7n5OIzbozAIapt5JJOENotVWmwzIg4SDKi72fU3lV6+rOLbhFXZHDqw2TkAPCjX+jPyEt58XapwOZpHyNXT+QH5YMPIroFAgjcaUIb211jIJuSC/fNgf0usSCbL1ODiLF4YqNv3WQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eheYbEDR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WP+LsBLP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813162824.164609663@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755102568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CyD2ghRr1kyVuv5De/CK9jkDkl00seF2v0b1Ou2dbUk=;
	b=eheYbEDRlaxnBzbo4NhIHzjGcku4Hiy3mJ3hjVOkBc/PwEXZMFWn9NtZ49uoGKs6sfCaWF
	B4iX+H9oEdnzoJpgWD5FaAJZxclhvQXp9Z5B72n2z5nnrEE+jvLphKWgZ03kJoODaotSht
	jR37h0VJ2aTGSqwfz6LUhrEvycEbuQTnFi+3TYvbVA+tpJWz6AqwP/8t+hAEl5yqRYcHwz
	gStpnbbpXzZDyXaVJqorApZLSoltNMU+H9JxVIg3hL8yDVbHtn6B+kQFs9BKvKMHpz3Pcy
	Yt7XwJweOa/hPsFtYoAgfcE4Pzzzm4QYPm/AdShlEp54G4wHwqYhq8Djsc5ohQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755102568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=CyD2ghRr1kyVuv5De/CK9jkDkl00seF2v0b1Ou2dbUk=;
	b=WP+LsBLPvyoMndyPZkjeFJE9iAh/j393lXk/VFzGbdURXA84Q2M14P3Ymy3i+q2HVACfY7
	5jwuXG/weDLTLpBA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [patch 06/11] rseq: Optimize exit to user space further
References: <20250813155941.014821755@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 18:29:27 +0200 (CEST)

Now that the event pending bit management is consistent, the invocation of
__rseq_handle_notify_resume() can be avoided if the event pending bit is
not set.

This is correct because of the following order:

  1)  if (TIF_NOTIFY_RESUME)
  2)    clear(TIF_NOTIFY_RESUME);
  	smp_mb__after_atomic();
  3)  	if (event_pending)
  4)       __rseq_handle_notify_resume()
  5)         guard()
  6)           work = check_and_clear_pending();

Any new event, which hits between #1 and #2 will be visible in #3.

Any new event, which hits after #2, will either be visible in #3 and
therefore consumed in #6 or missed in #3. The latter is not a problem as
the new event will also re-raise TIF_NOTIFY_RESUME, which will cause the
calling exit loop take another round.

The quick check #3 optimizes for the common case, where event_pending is
false. Ignore the quick check when CONFIG_DEBUG_RSEQ is enabled to widen
the test coverage.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/rseq.h |    8 +++++---
 kernel/rseq.c        |   17 +++++++++++++----
 2 files changed, 18 insertions(+), 7 deletions(-)

--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -17,7 +17,7 @@ void __rseq_handle_notify_resume(struct
 
 static inline void rseq_handle_notify_resume(struct pt_regs *regs)
 {
-	if (current->rseq)
+	if (IS_ENABLED(CONFIG_DEBUG_RESQ) || READ_ONCE(current->rseq_event_pending))
 		__rseq_handle_notify_resume(NULL, regs);
 }
 
@@ -30,8 +30,10 @@ static inline void rseq_signal_deliver(s
 
 static inline void rseq_notify_event(struct task_struct *t)
 {
+	lockdep_assert_irqs_disabled();
+
 	if (t->rseq) {
-		t->rseq_event_pending = true;
+		WRITE_ONCE(t->rseq_event_pending, true);
 		set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
 	}
 }
@@ -59,7 +61,7 @@ static inline void rseq_fork(struct task
 		t->rseq = current->rseq;
 		t->rseq_len = current->rseq_len;
 		t->rseq_sig = current->rseq_sig;
-		t->rseq_event_pending = current->rseq_event_pending;
+		t->rseq_event_pending = READ_ONCE(current->rseq_event_pending);
 	}
 }
 
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -524,9 +524,17 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 		ret = rseq_reset_rseq_cpu_node_id(current);
 		if (ret)
 			return ret;
-		current->rseq = NULL;
-		current->rseq_sig = 0;
-		current->rseq_len = 0;
+
+		/*
+		 * Ensure consistency of tsk::rseq and tsk::rseq_event_pending
+		 * vs. the scheduler and the RSEQ IPIs.
+		 */
+		scoped_guard(RSEQ_EVENT_GUARD) {
+			current->rseq = NULL;
+			current->rseq_sig = 0;
+			current->rseq_len = 0;
+			current->rseq_event_pending = false;
+		}
 		return 0;
 	}
 
@@ -601,7 +609,8 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 	 * registered, ensure the cpu_id_start and cpu_id fields
 	 * are updated before returning to user-space.
 	 */
-	rseq_set_notify_resume(current);
+	scoped_guard(irq)
+		rseq_notify_event(current);
 
 	return 0;
 }


