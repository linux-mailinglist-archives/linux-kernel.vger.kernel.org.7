Return-Path: <linux-kernel+bounces-847414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5269BCAC4D
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 22:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75F544E3BA1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 20:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B82266565;
	Thu,  9 Oct 2025 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NJat5KvI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEDD2641C3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760040726; cv=none; b=CSynSyCggcSYWAFxuxMSJVyvCwLXGJRYI8fWIfbD1molr5v1aG6iSMZvQJ/AxhyXrKPw+c2sLWyAK4UUITocHj/VbxIEy8ihacB/ecjYGNXD0aG19m4clwTZnZVD/Zdw1LXgk7Y1hHWDGNdsd6mpW1OYH+SHdhJr6Et4NxBFe3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760040726; c=relaxed/simple;
	bh=Tgw82CNadGPaNJb4U9QYiktpx4H52WOFMV9ejQ1aAjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlXjVeA3VbBU8pcbFjOcsLcL8j4CqffU9H63hX4coFCsibvwYpnMeKLWUrMrt30KFl8MFlCRrwn0eyS01YPJaNQlU2x2HfD7maVfJt3/dbbYvhLe9U3dB904GDnFJlc2cVf5cXyejwmEviupVzRXq8xoGVSZbQ+2k1imuvprKf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NJat5KvI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V4wDjvksUZ2zt23EOleQ5HrawKAqhTA4Dw4SqCmab1k=; b=NJat5KvIME1UocoBNY+7bKE1yv
	zU0sclKZh98SXb1Qoy+6ziwTSJN17ztXxsenCjaVebWcdaBJFeWOPrEFDak9lQSHefoBB0XoFinYN
	FHR+y3rHEwArcGlbYbPKt3VpXjs5lrGI9BR90v8jmg1xiJmZba7xknl5AyDQDqePeCnRRhKHpprmC
	1bnQNNKNZZE4TiXt+NTh7j+821hZmwgF+8k11CUT8hsg4i0OKg6pN59GlenNHoznS1y8PadC+6cr7
	iV3qCLKeIhuQMpclWnA5gSh3DK3okPTd0bDS2zXjPXf0jThP2BEyK2bl4n7F9peNnkocFfqUVSpYA
	1otY/aZw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6wzS-0000000ENQB-47Zy;
	Thu, 09 Oct 2025 20:11:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E1014300399; Thu, 09 Oct 2025 22:11:54 +0200 (CEST)
Date: Thu, 9 Oct 2025 22:11:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251009201154.GL1386988@noisy.programming.kicks-ass.net>
References: <20251008123014.GA20413@redhat.com>
 <20251008123045.GA20440@redhat.com>
 <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com>
 <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
 <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com>
 <20251009143748.GA2704@redhat.com>
 <20251009195024.GL3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009195024.GL3289052@noisy.programming.kicks-ass.net>

On Thu, Oct 09, 2025 at 09:50:24PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 09, 2025 at 04:37:49PM +0200, Oleg Nesterov wrote:
> 
> > Let me think a bit more before I send V3...
> 
> How do we feel about something a little like so?

Slightly nicer version that's actually compiled :-)

---
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5ce48eab7a2a..7273fddc19a2 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1209,4 +1209,87 @@ done_seqretry_irqrestore(seqlock_t *lock, int seq, unsigned long flags)
 	if (seq & 1)
 		read_sequnlock_excl_irqrestore(lock, flags);
 }
+
+enum ss_state {
+	ss_done = 0,
+	ss_lock,
+	ss_lock_irqsave,
+	ss_lockless,
+};
+
+struct ss_tmp {
+	enum ss_state	state;
+	int		seq;
+	unsigned long	flags;
+	spinlock_t	*lock;
+};
+
+static inline void __scoped_seqlock_cleanup(struct ss_tmp *sst)
+{
+	if (!sst->lock)
+		return;
+
+	if (sst->state == ss_lock_irqsave) {
+		spin_unlock_irqrestore(sst->lock, sst->flags);
+		return;
+	}
+
+	spin_unlock(sst->lock);
+}
+
+extern void __scoped_seqlock_fail(void);
+
+static inline void
+__scoped_seqlock_next(struct ss_tmp *sst, seqlock_t *lock, enum ss_state target)
+{
+	switch (sst->state) {
+	case ss_lockless:
+		if (!read_seqretry(lock, sst->seq)) {
+			sst->state = ss_done;
+			return;
+		}
+
+		switch (target) {
+		case ss_done:
+			__scoped_seqlock_fail();
+			return;
+
+		case ss_lock:
+			sst->lock = &lock->lock;
+			spin_lock(sst->lock);
+			sst->state = ss_lock;
+			return;
+
+		case ss_lock_irqsave:
+			sst->lock = &lock->lock;
+			spin_lock_irqsave(sst->lock, sst->flags);
+				sst->state = ss_lock_irqsave;
+			return;
+
+		case ss_lockless:
+			sst->seq = read_seqbegin(lock);
+			return;
+		}
+		BUG();
+
+	case ss_lock:
+	case ss_lock_irqsave:
+		sst->state = ss_done;
+		return;
+
+	case ss_done:
+		BUG();
+	}
+}
+
+#define __scoped_seqlock_read(_seqlock, _target, _s)			\
+	for (struct ss_tmp _s __cleanup(__scoped_seqlock_cleanup) = {	\
+		.state = ss_lockless, .seq = read_seqbegin(_seqlock),	\
+		.lock = NULL };						\
+	     _s.state != ss_done;					\
+	     __scoped_seqlock_next(&_s, _seqlock, _target))
+
+#define scoped_seqlock_read(_seqlock, _target)				\
+	__scoped_seqlock_read(_seqlock, _target, __UNIQUE_ID(seqlock))
+
 #endif /* __LINUX_SEQLOCK_H */
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 7097de2c8cda..d2b3f987c888 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -313,10 +313,8 @@ static u64 read_sum_exec_runtime(struct task_struct *t)
 void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 {
 	struct signal_struct *sig = tsk->signal;
-	u64 utime, stime;
 	struct task_struct *t;
-	unsigned int seq, nextseq;
-	unsigned long flags;
+	u64 utime, stime;
 
 	/*
 	 * Update current task runtime to account pending time since last
@@ -329,27 +327,19 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
 	if (same_thread_group(current, tsk))
 		(void) task_sched_runtime(current);
 
-	rcu_read_lock();
-	/* Attempt a lockless read on the first round. */
-	nextseq = 0;
-	do {
-		seq = nextseq;
-		flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
+	guard(rcu)();
+	scoped_seqlock_read(&sig->stats_lock, ss_lock_irqsave) {
 		times->utime = sig->utime;
 		times->stime = sig->stime;
 		times->sum_exec_runtime = sig->sum_sched_runtime;
 
-		for_each_thread(tsk, t) {
+		__for_each_thread(sig, t) {
 			task_cputime(t, &utime, &stime);
 			times->utime += utime;
 			times->stime += stime;
 			times->sum_exec_runtime += read_sum_exec_runtime(t);
 		}
-		/* If lockless access failed, take the lock. */
-		nextseq = 1;
-	} while (need_seqretry(&sig->stats_lock, seq));
-	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
-	rcu_read_unlock();
+	}
 }
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING

