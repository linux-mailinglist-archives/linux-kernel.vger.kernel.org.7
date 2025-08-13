Return-Path: <linux-kernel+bounces-766932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9527B24CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3163BD91B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCDA2F0674;
	Wed, 13 Aug 2025 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RbvYgVtT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="me8bWs0J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558222E611E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097354; cv=none; b=CbMzN7ZhKITigH4yAeDv74HfFnW5GgmwazATxIiclGTGvjU+doF2d0ZiJJSFh3/eBoSOcByG3F3KWXNDcNMdpcCruNEKeGPujJae3QcsYyujPRFY/M2ZWIceuMKXR9QZprCtG9KWJDj2EwgfucItUnSc4VrnOVB7yjhZPUPb4AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097354; c=relaxed/simple;
	bh=F0wVrLj3ZklsdkCUH/Lpw+U5vZTmcpISd3mWm5k+kNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RTfApPoDYUrbD1N64BuTUo/eDYck1vxVlgRRV3VByLSLJd0Lt+JyTZN5IgWiDL3P3zy6RPYN0qDOCViNxgGCKOJ4Ywqrv+UrnX0P8n2fb1Q80HGC06aTJXACMmGHjDrXaCsnZI3NEDzVgckoeaAsGhlqhRINuIZ48b0lgquMOAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RbvYgVtT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=me8bWs0J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755097351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=FFViEKTE22iy+D8lVjCIhFhr1V8IYeTO6Zxa1EJRBd8=;
	b=RbvYgVtT8UqY0oE9Z5cTSeFTEvQaAO1im1og87O+PPe1WQXa4z93VxbHhQmhMDIpxWW0vu
	MAlJKrUeGlEwALdS6VfAOBiGR5ZQLNkYY+V/yU2IijPBtunxBAgmD17jY9Me1VsJsr8b8W
	Ud3E+i2v4wkuVWQK5XJorNj6hjZOjy6syi/LkhPiioHDiq36SwgwkBv/gbI24xuJmv8rKu
	tIqzwlWpFLmf7ekoG2a2lOlAXXmdsVTPGn2plxRIbbfsE0sO85GuQBZGMLt38chv9z4E1W
	CBabF2jV4rQppzuqn4AQWpSGO3Z6nuUPR5wDDLCUrvC5Z9F+9XDaVHeVUqASJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755097351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=FFViEKTE22iy+D8lVjCIhFhr1V8IYeTO6Zxa1EJRBd8=;
	b=me8bWs0JJQzZOfZ/wtzy8ZCOD6jKyWrb54FmVJRv0/dKxDKdeJnSEVyHXQJtFY9LhUaCep
	HVXJqaqvq9Nz1cAQ==
To: LKML <linux-kernel@vger.kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun
 Feng <boqun.feng@gmail.com>
Subject: [PATCH] rseq: Protect event mask against membarrier IPI
Date: Wed, 13 Aug 2025 17:02:30 +0200
Message-ID: <87o6sj6z95.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 12 Aug 2025 16:34:43 +0200

rseq_need_restart() reads and clears task::rseq_event_mask with preemption
disabled to guard against the scheduler.

But membarrier() uses an IPI and sets the PREEMPT bit in the event mask
from the IPI, which leaves that RMW operation unprotected.

Use guard(irq) if CONFIG_MEMBARRIER is enabled to fix that.

Fixes: 2a36ab717e8f ("rseq/membarrier: Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: stable@vger.kernel.org
---
 include/linux/rseq.h |   11 ++++++++---
 kernel/rseq.c        |   10 +++++-----
 2 files changed, 13 insertions(+), 8 deletions(-)

--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -7,6 +7,12 @@
 #include <linux/preempt.h>
 #include <linux/sched.h>
 
+#ifdef CONFIG_MEMBARRIER
+# define RSEQ_EVENT_GUARD	irq
+#else
+# define RSEQ_EVENT_GUARD	preempt
+#endif
+
 /*
  * Map the event mask on the user-space ABI enum rseq_cs_flags
  * for direct mask checks.
@@ -41,9 +47,8 @@ static inline void rseq_handle_notify_re
 static inline void rseq_signal_deliver(struct ksignal *ksig,
 				       struct pt_regs *regs)
 {
-	preempt_disable();
-	__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
-	preempt_enable();
+	scoped_guard(RSEQ_EVENT_GUARD)
+		__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
 	rseq_handle_notify_resume(ksig, regs);
 }
 
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -342,12 +342,12 @@ static int rseq_need_restart(struct task
 
 	/*
 	 * Load and clear event mask atomically with respect to
-	 * scheduler preemption.
+	 * scheduler preemption and membarrier IPIs.
 	 */
-	preempt_disable();
-	event_mask = t->rseq_event_mask;
-	t->rseq_event_mask = 0;
-	preempt_enable();
+	scoped_guard(RSEQ_EVENT_GUARD) {
+		event_mask = t->rseq_event_mask;
+		t->rseq_event_mask = 0;
+	}
 
 	return !!event_mask;
 }

