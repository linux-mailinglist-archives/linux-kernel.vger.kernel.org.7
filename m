Return-Path: <linux-kernel+bounces-783260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E441B32B09
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1095E03E3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6E2F49EB;
	Sat, 23 Aug 2025 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nPpOOF7L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0zuSs4BK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CFB2F3C2C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967227; cv=none; b=LXmq10D0AVvS0DYr4YwYHY+z0dzPUyA0e6CTIq5gvQE1WjkAYOodarGES54Dk6Saw9/5Yp1rZkG00+lF+c5clmAtYslxsGY0s00LRJ1djZL7IyLuE2lvU1zbNmEn915Wc/J42w8puN4HII0keGa9Jh3kf57E4r6M5d33Deb9c70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967227; c=relaxed/simple;
	bh=jMLgdAgHSzruoTT+FPjMRqYiLZvhfhiTmwc43GLZ84c=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=As24ZQUDSBU90H5Ob4TMHLiiYvcsVdqOHHkGBGl4Co4PZYg7NqzHDKLqIEZeU5SmhZexmEslr7QgP+iuQCb28GVJZVMoByrRyL6puTCThY+CXvKkVCfUGgQC/uU39kKf3qsH9NyDsQvdg8GZDCVs5qfKYtgdAmNIkH0F2B8SSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nPpOOF7L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0zuSs4BK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161655.191313426@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XsVwV0NBdObzq9VISgnSUcizZQn0vfkb/Q5nM7G/Qz4=;
	b=nPpOOF7LNNjW5JqjLgngnJBuM0Ybl35TXHP42G74PdJK9f18S3Mcb/LM8xR2V8pWiDSetZ
	K8OJTr4VxC0qEz4VK0S2KVrDMcv20CGG6fmTpRQaMYUKQZrZ26LZLSDvkPL6OrTrxzM82M
	7iXKo0Oc22pu6HuTM2wt0liUhThntas0LxvMQ26OisezDxlRFTkME7pCw/g9RAwDlYYv8y
	sRaVCm/yB9foosaopobCEDF/sKQ8vGkJPJcm7/e0eXGFJtZyeyA5h5rWckKYFSpUhHHirq
	97i8Eg/73yMSlIwD0HmjIDRZjiXrdEEeS6DgyA9eRMF2OnnFyrcE1PKD/Gc2UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XsVwV0NBdObzq9VISgnSUcizZQn0vfkb/Q5nM7G/Qz4=;
	b=0zuSs4BKC/RYh2FJmwFEVCZOiYBJ3WRqhzSc9rXLsIpu6X309U3n7w/r1HenBYF9FHZWNh
	geRvcuKsmUDmntDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
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
Subject: [patch V2 30/37] rseq: Split up rseq_exit_to_user_mode()
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:40:22 +0200 (CEST)

Seperate the interrupt and syscall exit handling. Syscall exit does not
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
@@ -519,19 +519,31 @@ rseq_exit_to_user_mode_work(struct pt_re
 
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
@@ -551,7 +563,8 @@ static inline unsigned long rseq_exit_to
 	return ti_work;
 }
 static inline void rseq_note_user_irq_entry(void) { }
-static inline void rseq_exit_to_user_mode(void) { }
+static inline void rseq_syscall_exit_to_user_mode(void) { }
+static inline void rseq_irqentry_exit_to_user_mode(void) { }
 static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
 #endif /* !CONFIG_RSEQ */
 


