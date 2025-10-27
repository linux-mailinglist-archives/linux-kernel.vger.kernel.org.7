Return-Path: <linux-kernel+bounces-871117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE5FC0C7C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A82401B47
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63762314B73;
	Mon, 27 Oct 2025 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yeeckoxe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q3ifiu5F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB59314A9D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554728; cv=none; b=TrZ16a92ozmqxyl/tp5csqzoEo05gvigNKqbTIyBAfVT9LDIxWqHrqobiRH4WpetTINNDGpZb6MJXY7Wcodt7fcPmqjj6fqNej5qHadnw9Mbijr6LMGVroAEoweiMHBBGgymbL6x7aeu85L/5ys+cFtfK8XBtAaRDaXBiflDUDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554728; c=relaxed/simple;
	bh=fRtKSAT+7JawqD54Nvj6KBAjse/kVX+VAldx1oveosY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=gtncAYWSI99oEFr1OMZc3VsS4kl1gxQvpnF2UmPC4/d63DegF5rRoJu8zVTfAnUaLe5oI5D67EOyf9H4T5LBDSK0PKUslIlTWpXzeUI54o1vn67y7Xy8NJS+m2ROF/XeRpnr2AoUUUwhuOc2fK5Sx+R9IVcVHIeXgCNYL+y4M8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yeeckoxe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q3ifiu5F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084307.842785700@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=u/TMrFpJWl68PmfpLX0HbgIWYFPqgU/kRgNhPDl2Dak=;
	b=yeeckoxeyM4n81b5Vqxr9nppS9ydBKITYfHqtB438C6gxtgB9J58DB/1o09RT0VULapl65
	vSLF9cgNbuRyJbtMJo5rCinD0+bMNWvVwJ1uvqT93gXe7DisRYYKD5sBY32vbeDQoIY5hA
	WdLvYPl8F2IgrlWoSq5sZctW18ZuRG2C+YDrjoMf+LQ6ofqZTu4RnA3LU44wjNDBHamJdF
	mCQPZkIUIkQOlb28x2E7pSA458GpbxG+nV3yTyNMo+6t/QYlM2jemiqo8Bji+B/gAgr5V7
	rSQxS4zeCRnZPzVg/BMUJOkSEj3nl60LZkTk8s8mU8ZoH8+xP/nNXvM4GXrVlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=u/TMrFpJWl68PmfpLX0HbgIWYFPqgU/kRgNhPDl2Dak=;
	b=q3ifiu5F5Y1qGq/6DTOdSU/vjS9roBf3XsbLpiHXNYBtyRCjun8/+n/iBqdrEcdm6+fnHe
	iify3RF8W2UlrGBQ==
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
Subject: [patch V6 30/31] rseq: Split up rseq_exit_to_user_mode()
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:45:24 +0100 (CET)

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
 


