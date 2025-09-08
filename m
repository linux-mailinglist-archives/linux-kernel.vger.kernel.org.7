Return-Path: <linux-kernel+bounces-806820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 108F0B49C1F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58D2445AA2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5D232143A;
	Mon,  8 Sep 2025 21:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OzWTZuPF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bu8wyBxi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CD2320CCB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367153; cv=none; b=F3fJY8Fd0adx7j+CSxPzQ0eSaf/U2Eo0IopvQg/B3+61I6uLmNHZfW5D5bUNhTm8hFE09ZJyoQFzXBc587sO++1wytGRiDtpJOv3haMScCVlgHAbKF/k9z02Lb7kZnqHuyWlEwp+0muuPvBrmVM9ot+qwTFyU8Ajb0M7GUDLHag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367153; c=relaxed/simple;
	bh=MhRj7BYOoyRn3y1Eu5HbW3v5FTxee/7rHEpA52ZlGCc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rjtDLkY6Zd827/2V5GJynGxV2BW3+qNIsxqhYqskMusZBMlhdRlxV4Wg8Cb3y9XJEW8xflq5Hbe/vfiFCl4Z6kreNLoOPkk1rzjruP0fdlbDp25sj+J25+bSg7J/je4zK1jqTru/gYsCNAPJs5fMq3fd8EPnPouNXH/mLzuVwzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OzWTZuPF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bu8wyBxi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212927.186076299@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=97txbGpq3oRv+sMFTTi6yORgmAYc0+r9BmgMFiT+wA4=;
	b=OzWTZuPFMOUSX3WMPea9r+VDXIW3SigBY6x5awfwqtIvR2Dair9fuVFxkQ4dW3dAaG0WmM
	vSAYD8zVTYDkXy4kmlKBmI63r84I//hUaox8b2EbuV23vo6ve5Nz5qn9DIAJsv9URc5Y+8
	4DKfX1KnZVcfjyBhIRdEKE/1dKWHV8ry5PyRLTDdmIYRcYZQ+9nVveQeDRkIivnuusP5Ix
	/XZaFi+yaJEsPSRL09v0FsPpq3cgHIwr3avMm/HvdKkrdo5IRQIBKp2SnPVWem6C3hsEHM
	hwUu+MC/eYKtyzBnvJ7teK6ObSPnR/SIVkr+th6JHxWg8peKaURwxF7Mj8jWhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=97txbGpq3oRv+sMFTTi6yORgmAYc0+r9BmgMFiT+wA4=;
	b=Bu8wyBxiIwJdlOT4PFRqtbG7oOphIoCuqqhJY0VLN2bUNoOxvkf7R1gFUgvf0UpBXCoIp8
	A43dUpMzhZyEyXBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V4 30/36] rseq: Split up rseq_exit_to_user_mode()
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:32:27 +0200 (CEST)

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
@@ -532,19 +532,31 @@ static __always_inline bool rseq_exit_to
 
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
@@ -562,7 +574,8 @@ static inline bool rseq_exit_to_user_mod
 {
 	return false;
 }
-static inline void rseq_exit_to_user_mode(void) { }
+static inline void rseq_syscall_exit_to_user_mode(void) { }
+static inline void rseq_irqentry_exit_to_user_mode(void) { }
 static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
 #endif /* !CONFIG_RSEQ */
 


