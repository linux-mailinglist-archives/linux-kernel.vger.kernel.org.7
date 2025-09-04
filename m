Return-Path: <linux-kernel+bounces-801766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E350B44994
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACF4165A36
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA39C2EAB60;
	Thu,  4 Sep 2025 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TytOoewh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qqsqpVzW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A062346A14
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024494; cv=none; b=Y45GF8o789eieo4I/RE5CuICpKnkHcvMks+w5iR+BKPKOc/naVRT5xDCWeL0LpxmqIE8RkTzlD+fzDB6YmwxUEccIKTXbjq3XVLcvDByE4xrt+Q1BA7zfuKQ3OOvkwzpd+igNQ4e5IEFeddkZII3npop7yfZxVbn9gUZFDPTVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024494; c=relaxed/simple;
	bh=gSOdei/ApqJ7l6+xXf6BLJUQqiZVkAxQjpWc1uEgcRQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=jYgWlEasF37nlkQ2opPbEtYRq0TEC0jMRW8ry5Ht63l5wWNnglQZgWx7JYV6BRWyiZ4lBi3TkHot1AzKHOYtlfiSrvjAFB2zrDD9izqqnQCD0Tasurtm26cIdt146Lt37WjTw8eNYlkcqB403ncpE/xajN1IaSLbcyzP+5hB4k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TytOoewh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qqsqpVzW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185721.035334836@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PrNwgPYVfrW/X6il8nJAHm4gWun9sPtQJJ3ct59cWaw=;
	b=TytOoewhk1Dy85GvPRqyx4vux+kGPwRFzgKLcfKUUUnDa4q5Y1wJOOjLaqTtaSYMMW1wIe
	KQdC9AMW+3on6BxIOWfd/hwfsM0H/7e3tX1TXBo67VtaVhJu2pYhyDolo7b9iKhA49HfAK
	86SYx9faP9030oARXUn2ZVDkbj2d+MHyge09UkoFDwx32PiOkIMFhKi6lr2mz5H/U25yxi
	nD/ntIwmXEqI+D4H34SfixT/sGVhJad1U98nlgaRnldgI8+zZMIhNsF0siPwyOlRR7ioR6
	anzhc2QTzgXVNNbMdbfpffCIcdcAgdojbS77VPtYPgQ4bxWgMoNCOWxotAulLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PrNwgPYVfrW/X6il8nJAHm4gWun9sPtQJJ3ct59cWaw=;
	b=qqsqpVzWvHFVzx9wwFH8qNDimMCTACcWVZ0N7dah76kMdeszU794PQ0WnbjQc/Fa/PgIsK
	8ARcY597rd2fzpAQ==
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
Subject: [patch V3 30/37] rseq: Split up rseq_exit_to_user_mode()
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:21:30 +0200 (CEST)

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
@@ -538,19 +538,31 @@ rseq_exit_to_user_mode_work(struct pt_re
 
 #endif /* !CONFIG_GENERIC_ENTRY */
 
-static __always_inline void rseq_exit_to_user_mode(void)
+static __always_inline void rseq_syscall_exit_to_user_mode(void)
 {
 	struct rseq_event *ev = &current->rseq_event;
 
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
+	struct rseq_event *ev = &current->rseq_event;
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
@@ -570,7 +582,8 @@ static inline unsigned long rseq_exit_to
 	return ti_work;
 }
 static inline void rseq_note_user_irq_entry(void) { }
-static inline void rseq_exit_to_user_mode(void) { }
+static inline void rseq_syscall_exit_to_user_mode(void) { }
+static inline void rseq_irqentry_exit_to_user_mode(void) { }
 static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
 #endif /* !CONFIG_RSEQ */
 


