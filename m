Return-Path: <linux-kernel+bounces-767150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951C8B24FEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F3762617E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ABC28B4E1;
	Wed, 13 Aug 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZtRUELDR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="55Irt9Bn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949F828980F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755102569; cv=none; b=g3HNITSNTQLOk86XA6DnFw6xRDIO8w38lgRu152i8dY+J2SzdLG39UOHpf0T4RwsrrsPfGGCykQag0wAu1uNSyHYWOq6g9r1omocUN+blxga2lZP/4GZtzoS2zADgEf0BuRtWGWDQT1IJuXdOoY7UQwPTO4niSsgSbDOXndQU3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755102569; c=relaxed/simple;
	bh=eNVmM11/VxJ0gZJky7d2P8a3z9oDJ7H5eoAFZmT8Vgw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=DbSDN7KDBg9SehHIz3PBDLIqFY1kZiY8FQE0qGIOj+Zcxqz3Dqrj4Hv2beq9cvZbUL3Be7Rip2dI2eiuVSsSKNhShiPaCJAnuY2hRS65s8+9l/iWGQL/2hoC9Sxkg11A7vbIS7dPxX+WgU12T8b94kkOtjD2vCN61hbzRCLqOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZtRUELDR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=55Irt9Bn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250813162824.100212248@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755102566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=FcyAdnf9n089HR0oCpbdG20fsjCKd6CMKAT/PpPW5sg=;
	b=ZtRUELDRpk3WHqAL7H2KT9HFwbGicBTFhhc4QZNYVUoPNLqAThPCfPl4gyfMEJQe3cV90K
	AEO9rsIdyxIZ51IOSE5RAuUO8t+WAnqij0sI+bDrZXPNoif0rtxkq2LFp/04wpvG3CZvGu
	2NygOfBNC7mooqt1aWsSnCumRmCqkFdX9E8qqEP2sdNLXwc8t7369I/t9mIfaoP2KW4PKv
	7NLS35pc2JYAijLzKxrwrQ05kKzu6ZbcMeJI2WWHOMWixGquWE0p8kBmOGiO6uN9Ssk6wS
	yJGFb39VHQQ7OgGyviz6nMxl3U4lJiBk9lcjUJv0R1Nxz7+9ZFEjzewtm590Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755102566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=FcyAdnf9n089HR0oCpbdG20fsjCKd6CMKAT/PpPW5sg=;
	b=55Irt9BnJdWYV9HJvVerDTHUDvjMXADRnjyZsnZTY9IyvQ5YIdouHXUwS5Wo5z8xBFxcsh
	Hcxaas4g5AI70+Bw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Wei Liu <wei.liu@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: [patch 05/11] rseq: Optimize the signal delivery path
References: <20250813155941.014821755@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 18:29:24 +0200 (CEST)

Now that the individual event mask bits are gone, there is no point in
setting the event flag before invoking rseq_handle_notify_resume(). The
fact that the signal pointer is not NULL indicates that there is an event.

Simply drop the setting of the event bit and just fold the event in
rseq_handle_notify_resume() when the signal pointer is non-NULL.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/resume_user_mode.h |    2 +-
 include/linux/rseq.h             |    9 +++------
 kernel/rseq.c                    |    7 ++++++-
 3 files changed, 10 insertions(+), 8 deletions(-)

--- a/include/linux/resume_user_mode.h
+++ b/include/linux/resume_user_mode.h
@@ -59,7 +59,7 @@ static inline void resume_user_mode_work
 	mem_cgroup_handle_over_high(GFP_KERNEL);
 	blkcg_maybe_throttle_current();
 
-	rseq_handle_notify_resume(NULL, regs);
+	rseq_handle_notify_resume(regs);
 }
 
 #endif /* LINUX_RESUME_USER_MODE_H */
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -15,20 +15,17 @@ static inline void rseq_set_notify_resum
 
 void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
 
-static inline void rseq_handle_notify_resume(struct ksignal *ksig,
-					     struct pt_regs *regs)
+static inline void rseq_handle_notify_resume(struct pt_regs *regs)
 {
 	if (current->rseq)
-		__rseq_handle_notify_resume(ksig, regs);
+		__rseq_handle_notify_resume(NULL, regs);
 }
 
 static inline void rseq_signal_deliver(struct ksignal *ksig,
 				       struct pt_regs *regs)
 {
-	if (current->rseq) {
-		current->rseq_event_pending = true;
+	if (current->rseq)
 		__rseq_handle_notify_resume(ksig, regs);
-	}
 }
 
 static inline void rseq_notify_event(struct task_struct *t)
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -451,6 +451,11 @@ void __rseq_handle_notify_resume(struct
 		 * again and this function is invoked another time _before_
 		 * the task is able to return to user mode.
 		 *
+		 * If directly invoked from the signal delivery path, @ksig
+		 * is not NULL and @regs are valid. The pending bit is not
+		 * set by the caller as it can easily be folded in during
+		 * the evaluation when @ksig != NULL.
+		 *
 		 * On a debug kernel, invoke the fixup code unconditionally
 		 * with the result handed in to allow the detection of
 		 * inconsistencies.
@@ -458,7 +463,7 @@ void __rseq_handle_notify_resume(struct
 		bool event;
 
 		scoped_guard(RSEQ_EVENT_GUARD) {
-			event = t->rseq_event_pending;
+			event = t->rseq_event_pending || !!ksig;
 			t->rseq_event_pending = false;
 		}
 


