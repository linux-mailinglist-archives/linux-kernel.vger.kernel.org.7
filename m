Return-Path: <linux-kernel+bounces-864969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 439AEBFBFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488E21A073AB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F081E34A3A7;
	Wed, 22 Oct 2025 12:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AWuko00G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NsB3bwm1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F369345CB2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137532; cv=none; b=NHZOGXtkdWtUuFNn/exWJxHyrWTut8D1bkaTOJthXHfjXFcEH7ts9E6bQHifHX5upweVmhAwdI9sci0KUFljdBubFj471qVjYyfZ0cnhAT7+SpzFYcjRSjjQehWuMwgoOS63mlczI0g6TItTC9AaOLcVWn5GMOfPaPewZougz/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137532; c=relaxed/simple;
	bh=A1vRO+JC6wXvVRyZ6M6JYXziZGl5gDaaaQTk8Wtbe7w=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dfUzm+JZfFPay33o+YF+KPURmy0xxJKJ2cyEUW79yBiEizkawIdNJAnbCgyY26RgN5ouZScVUqqO62n9ArFqWVXdk1jDU1r7HxbpZS4JKqVOHTJUyoXPHXs1/BZT04NgG4kFctId22MQH16rT0u6eVFrSA1b/VxxsRdrHjI86Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AWuko00G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NsB3bwm1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121941.624112132@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1gK10EHJk76APGnXrchUXEgYg86oZi63TuoER7ZkuNM=;
	b=AWuko00G3JtX0LlhdhAanUBC+LGls9v73M8QaDVY71xG9FPpjn4kdgGT+S6bqqBvtQa5v2
	0IH88KdymiBNlQhoMhYsCsx8RCobi4X0DFfRyGH5RDvcz2WrOe3j6xoZxK7GP6QQ0VqF1A
	PE+1lt81uNJ1zoHw2NFofgLDLggxdBiNrWFJO8T9mej3RKOzAXu0s5RAzmgQx3wYwydoV+
	QCzaqoyaKH0tz8jXrQacdgvt2zoyiFN79FUzhNkFQaClK+1OnhPW5UEa1d7mKqYnuFw0hi
	/H6eQkBSF3ayX7xHZTcxoU7y76Ah57frF4fdf6K7ERJS6M3eW3WgR08uqWWa9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1gK10EHJk76APGnXrchUXEgYg86oZi63TuoER7ZkuNM=;
	b=NsB3bwm1IKnBr1VVsw4kUAp0tEkJJLMzszVhBqGE2HeCJVahBHVqLa/n37rI1bYuV6mcvI
	IXsp8r9WJTintvAw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 x86@kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V5 04/31] rseq: Remove the ksig argument from
 rseq_handle_notify_resume()
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:05 +0200 (CEST)

There is no point for this being visible in the resume_to_user_mode()
handling.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 include/linux/resume_user_mode.h |    2 +-
 include/linux/rseq.h             |   13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)
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
@@ -37,19 +37,20 @@ static inline void rseq_set_notify_resum
 
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
-	scoped_guard(RSEQ_EVENT_GUARD)
-		__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
-	rseq_handle_notify_resume(ksig, regs);
+	if (current->rseq) {
+		scoped_guard(RSEQ_EVENT_GUARD)
+			__set_bit(RSEQ_EVENT_SIGNAL_BIT, &current->rseq_event_mask);
+		__rseq_handle_notify_resume(ksig, regs);
+	}
 }
 
 /* rseq_preempt() requires preemption to be disabled. */





