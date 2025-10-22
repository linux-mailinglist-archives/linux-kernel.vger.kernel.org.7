Return-Path: <linux-kernel+bounces-864997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB443BFC086
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB1462437F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE0D34F257;
	Wed, 22 Oct 2025 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UOdzPfC5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CizQurBi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891334C82D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137568; cv=none; b=aPLViDFuCnS9wcVNgUGnUIruPrWLyBvvcmQzk0aw3cjxLf2RmRrW8RlJbK1ijJVPq77G54tfT3dEPARLfDHKbc2/vPXCoCIo6y9LqdkdnJ/mFm2pxSOePIO49OWmG6kAGMYqPgWcrrwc+vYYfCCUWjo0xiNU/dUeuT0IIbXWbkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137568; c=relaxed/simple;
	bh=fRtKSAT+7JawqD54Nvj6KBAjse/kVX+VAldx1oveosY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=DR6nixMGeICCPgZ9oZsLX4Fe5L2mtSBgRzd3O/yzp8ttGHgtMBB+972DLRJpyruhY58uadyFSUkDHbHLFBuAOhUJYj8GSsXD3/9N83Tjjef9O+pR8oYKJJ+gyJMXSLcmgasL4VpXfl1QsFcBTmHbq8f5Vze1ccA4vwIcixxinPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UOdzPfC5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CizQurBi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121943.289709585@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=u/TMrFpJWl68PmfpLX0HbgIWYFPqgU/kRgNhPDl2Dak=;
	b=UOdzPfC5mYE8pqV8Yr4AKYsIup5EmDvkvbcSOzq6D3ksD4N4TCtqSiWim3mPlczwxPcDlo
	ZjRopucq2+k2EWBauSvnSYCPpRF4palFAUWe9PChg0faxJz+skAjXVBEhECGQ6QznvG7h8
	LklT3rIVoj0mZxn/WzhZATZoJT/E5vIW9LtlOYeAVZhq8qWWs/RgwBphtYJPu9R6nxLeqV
	0X7i9fVyMGOJ7fAIQxXnG5/AuoBVM06mBg6HjSpyjNXvGzaLIQFfV+hh2Avl1ta0T9tAIk
	y2uq7bBkzgz5FP/wJHPTLSjNiQ+rjvVgvY9TbjQ18fkaIqjkLHRBjTT64FLPwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=u/TMrFpJWl68PmfpLX0HbgIWYFPqgU/kRgNhPDl2Dak=;
	b=CizQurBiru7p8U5MQfpREn2M1zpr7bbeGgf5nt2yd8+K6DKkGfgtrzX4tgKpffmPI1EQYP
	zxbec4JeVxyu0ECw==
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
Subject: [patch V5 30/31] rseq: Split up rseq_exit_to_user_mode()
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:38 +0200 (CEST)

Separate the interrupt and syscall exit handling. Syscall exit does not
require to clear the user_irq bit as it can't be set. On interrupt exit it
can be set when the interrupt did not result in a scheduling event and
therefore the return path did not invoke the TIF work handling, which would
have cleared it.

The debug check for the event state is also not really required even when
debug mode is enabled via the static key. Debug mode is largely aiding user
space by enabling a larger amount of validation checks, which cause a
segfault when a malformed critical section is detected. In production mode
the critical section handling takes the content mostly as is and lets user
space keep the pieces when it screwed up.

On kernel changes in that area the state check is useful, but that can be
done when lockdep is enabled, which is anyway a required test scenario for
fundamental changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 include/linux/irq-entry-common.h |    4 ++--
 include/linux/rseq_entry.h       |   21 +++++++++++++++++----
 2 files changed, 19 insertions(+), 6 deletions(-)
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -247,7 +247,7 @@ static __always_inline void __exit_to_us
 static __always_inline void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	__exit_to_user_mode_prepare(regs);
-	rseq_exit_to_user_mode();
+	rseq_syscall_exit_to_user_mode();
 	__exit_to_user_mode_validate();
 }
 
@@ -261,7 +261,7 @@ static __always_inline void syscall_exit
 static __always_inline void irqentry_exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	__exit_to_user_mode_prepare(regs);
-	rseq_exit_to_user_mode();
+	rseq_irqentry_exit_to_user_mode();
 	__exit_to_user_mode_validate();
 }
 
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -520,19 +520,31 @@ static __always_inline bool rseq_exit_to
 
 #endif /* CONFIG_GENERIC_ENTRY */
 
-static __always_inline void rseq_exit_to_user_mode(void)
+static __always_inline void rseq_syscall_exit_to_user_mode(void)
 {
 	struct rseq_event *ev = &current->rseq.event;
 
 	rseq_stat_inc(rseq_stats.exit);
 
-	if (static_branch_unlikely(&rseq_debug_enabled))
+	/* Needed to remove the store for the !lockdep case */
+	if (IS_ENABLED(CONFIG_LOCKDEP)) {
 		WARN_ON_ONCE(ev->sched_switch);
+		ev->events = 0;
+	}
+}
+
+static __always_inline void rseq_irqentry_exit_to_user_mode(void)
+{
+	struct rseq_event *ev = &current->rseq.event;
+
+	rseq_stat_inc(rseq_stats.exit);
+
+	lockdep_assert_once(!ev->sched_switch);
 
 	/*
 	 * Ensure that event (especially user_irq) is cleared when the
 	 * interrupt did not result in a schedule and therefore the
-	 * rseq processing did not clear it.
+	 * rseq processing could not clear it.
 	 */
 	ev->events = 0;
 }
@@ -550,7 +562,8 @@ static inline bool rseq_exit_to_user_mod
 {
 	return false;
 }
-static inline void rseq_exit_to_user_mode(void) { }
+static inline void rseq_syscall_exit_to_user_mode(void) { }
+static inline void rseq_irqentry_exit_to_user_mode(void) { }
 static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
 #endif /* !CONFIG_RSEQ */
 


