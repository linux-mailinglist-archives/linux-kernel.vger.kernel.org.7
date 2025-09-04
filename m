Return-Path: <linux-kernel+bounces-801773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D1FB44998
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABA03B1821
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B517352091;
	Thu,  4 Sep 2025 22:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qclfNY0X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IHAIx3a9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3142352086
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024507; cv=none; b=o91rU9nHU0dQAao/dJ3GQE8Kcb2tWUUddddFeA7eNPX80raXUNxDJThx6dNgsS4KjL2KvcYo1QeYahFCyTal81H5i1DX1pGRLwF2rnNrY86Zpz52t+jhIZdPUaiMxcaey9IQDoascqU0Ra36cXttaghkwX61lwoCMRfIv4rtHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024507; c=relaxed/simple;
	bh=YJ+GFYoQPY0jjBWU/llQgKqYS+kj06ebsW95VC/+2ts=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lbfjP9tgaBFKzI9HK8k13htwwg7cUh7/VkdAd+plGw8U9kIEr9oyDOZRA9zrfEE5hQ72wB//PSc2R0LV4l3vy4u77Dx/n4mibjqyqkj6lwZzAzezcfzcjK0JYXGqjPBMDye22IwcAnraQwq7HA48xtcl9gVLgYU8Ic5UtbPg3xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qclfNY0X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IHAIx3a9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185721.485665725@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4Xps66GyZvqvnForbfAB13MulYKnqs4rvz2UKWKZ60o=;
	b=qclfNY0XAGB0+nqRYqkJbCnHiltWy9Uuu81Ang/x4xXB8qfy2PGARBUI1e5wODkUeeZSsh
	jigrequKEIk7DYJja33y/OWk62D1s491aSEt6Pr4CFvoSJZY6l2ZlDHelehrY+DwYnjqZN
	xB4qL2BTooaZZC8SIUcK0FYz+zfHunc5jhC2AE2/MrieCeB9lllcPTEyYqdWKhVQbLq9LS
	oiCpHiMgC1YEGj5hdQebaQ4qUlOQ71XHEKL6MhI6ZQReEqtEK6KOesZqEXW3NLmV/9wR46
	CWs4Pi4lnU0zP0eE3UyV1H5U4TMU8TRJqvq7P9biMTNtuDacuvwoNdX6zS0m+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=4Xps66GyZvqvnForbfAB13MulYKnqs4rvz2UKWKZ60o=;
	b=IHAIx3a9fYgRRLL95ZxXvhSqbEu4Mbn8bKmKIrDplCXQVIo83iLSliF4TNJ9G1VYUySaRk
	i534PEy7+hEvh9BQ==
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
Subject: [patch V3 37/37] entry/rseq: Optimize for TIF_RSEQ on exit
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:21:43 +0200 (CEST)

Further analysis of the exit path with the seperate TIF_RSEQ showed that
depending on the workload a significant amount of invocations of
resume_user_mode_work() ends up with no other bit set than TIF_RSEQ.

On architectures with a separate TIF_RSEQ this can be distinguished and
checked right at the beginning of the function before entering the loop.

The quick check is lightweight so it does not impose a massive penalty on
non-RSEQ use cases. It just checks for the work being empty, except for
TIF_RSEQ and jumps right into the handling fast path.

This is truly the only TIF bit there which can be optimized that way
because the handling runs only when all the other work has been done. The
optimization spares a full round trip through the other conditionals and an
interrupt enable/disable pair. The generated code looks reasonable enough
to justify this and the resulting numbers do so as well.

The main beneficiaries are blocking syscall heavy work loads, where the
tasks often end up being scheduled on a different CPU or get a different MM
CID, but have no other work to handle on return.

A futex benchmark showed up to 90% shortcut utilization and a measurable
improvement in perf of ~1%. Non-scheduling work loads do neither see an
improvement nor degrade. A full kernel build shows about 15% shortcuts,
but no measurable side effects in either direction.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 include/linux/rseq_entry.h |   14 ++++++++++++++
 kernel/entry/common.c      |   13 +++++++++++--
 kernel/rseq.c              |    2 ++
 3 files changed, 27 insertions(+), 2 deletions(-)

--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -12,6 +12,7 @@ struct rseq_stats {
 	unsigned long	signal;
 	unsigned long	slowpath;
 	unsigned long	fastpath;
+	unsigned long	quicktif;
 	unsigned long	ids;
 	unsigned long	cs;
 	unsigned long	clear;
@@ -553,6 +554,14 @@ rseq_exit_to_user_mode_work(struct pt_re
 	return ti_work | _TIF_NOTIFY_RESUME;
 }
 
+static __always_inline bool
+rseq_exit_to_user_mode_early(unsigned long ti_work, const unsigned long mask)
+{
+	if (IS_ENABLED(CONFIG_HAVE_GENERIC_TIF_BITS))
+		return (ti_work & mask) == CHECK_TIF_RSEQ;
+	return false;
+}
+
 #endif /* !CONFIG_GENERIC_ENTRY */
 
 static __always_inline void rseq_syscall_exit_to_user_mode(void)
@@ -598,6 +607,11 @@ static inline unsigned long rseq_exit_to
 {
 	return ti_work;
 }
+
+static inline bool rseq_exit_to_user_mode_early(unsigned long ti_work, const unsigned long mask)
+{
+	return false;
+}
 static inline void rseq_note_user_irq_entry(void) { }
 static inline void rseq_syscall_exit_to_user_mode(void) { }
 static inline void rseq_irqentry_exit_to_user_mode(void) { }
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -22,7 +22,14 @@ void __weak arch_do_signal_or_restart(st
 	/*
 	 * Before returning to user space ensure that all pending work
 	 * items have been completed.
+	 *
+	 * Optimize for TIF_RSEQ being the only bit set.
 	 */
+	if (rseq_exit_to_user_mode_early(ti_work, EXIT_TO_USER_MODE_WORK)) {
+		rseq_stat_inc(rseq_stats.quicktif);
+		goto do_rseq;
+	}
+
 	do {
 		local_irq_enable_exit_to_user(ti_work);
 
@@ -56,10 +63,12 @@ void __weak arch_do_signal_or_restart(st
 
 		ti_work = read_thread_flags();
 
+	do_rseq:
 		/*
 		 * This returns the unmodified ti_work, when ti_work is not
-		 * empty. In that case it waits for the next round to avoid
-		 * multiple updates in case of rescheduling.
+		 * empty (except for TIF_RSEQ). In that case it waits for
+		 * the next round to avoid multiple updates in case of
+		 * rescheduling.
 		 *
 		 * When it handles rseq it returns either with empty work
 		 * on success or with TIF_NOTIFY_RESUME set on failure to
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -134,6 +134,7 @@ static int rseq_stats_show(struct seq_fi
 		stats.signal	+= data_race(per_cpu(rseq_stats.signal, cpu));
 		stats.slowpath	+= data_race(per_cpu(rseq_stats.slowpath, cpu));
 		stats.fastpath	+= data_race(per_cpu(rseq_stats.fastpath, cpu));
+		stats.quicktif	+= data_race(per_cpu(rseq_stats.quicktif, cpu));
 		stats.ids	+= data_race(per_cpu(rseq_stats.ids, cpu));
 		stats.cs	+= data_race(per_cpu(rseq_stats.cs, cpu));
 		stats.clear	+= data_race(per_cpu(rseq_stats.clear, cpu));
@@ -144,6 +145,7 @@ static int rseq_stats_show(struct seq_fi
 	seq_printf(m, "signal: %16lu\n", stats.signal);
 	seq_printf(m, "slowp:  %16lu\n", stats.slowpath);
 	seq_printf(m, "fastp:  %16lu\n", stats.fastpath);
+	seq_printf(m, "quickt: %16lu\n", stats.quicktif);
 	seq_printf(m, "ids:    %16lu\n", stats.ids);
 	seq_printf(m, "cs:     %16lu\n", stats.cs);
 	seq_printf(m, "clear:  %16lu\n", stats.clear);


