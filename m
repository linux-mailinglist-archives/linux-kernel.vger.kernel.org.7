Return-Path: <linux-kernel+bounces-847919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D96BCC0FF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0272424CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2AD277032;
	Fri, 10 Oct 2025 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ora1BG2W"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D282750E1
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083419; cv=none; b=j0WIauGZo7p29+iyzI+fj8KqQ3buU2KP4AvtKg9+i6BPzas0G4SbsTZ7sxG2V9GKO3h+mJy3OPdS8wj8GR2HYym1+SfvfoTv3Hdmd5OJihstb/vL65ONBqOiRgym1vBGZg5972LxDqw7aRg5wUSum3MV0bTwD4TvWuc8y8MXmZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083419; c=relaxed/simple;
	bh=Hr2HfUFu8PpxmQsxceE1JzN1nqvM5MKIHV4MaA5UBVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXzn3vIUH/dh2W2OEsatLb/a0j8ESiUP0NyT3I2DgEcoe4Lai2BFi0Nac375qQfi82ajP/Ap75N6WA8t8g99439kogl/h+9FRp79FozA9u99RIdDND5U6yEQt/YLxi3SBi7n13Yq+/JcxFl8mXu+oLTTzsvRQl8v8XXSf36ZaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ora1BG2W; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3sqi2g0Xg79fjy1lU/loVbkeZWtx4zm34wmi9o+3jck=; b=ora1BG2WxcE2bSYgK1Y5n6QY/D
	/LN/5DSzBUk3a1CUWTbjP3AKsmroNArBwBA7dIKM5O8509q9a50o3iEjpP3k7nFWvinr+t/aN6dSv
	BAgtYShTL85yiGvmRB90VADJq4e+OJM81ZhoWzcXoTHlYFdENcgIxwNbNYHjoZwUfr6q4kFOZA870
	+yJgPaEmhChhH9sVZVcTRvf8iKV/vMTDjvhJWsqgG1lrp6fJaTL72NSZLh05tTjSxWR6XJYPMOB9W
	P6Xzcjy6XJdOGkh9pPj8Jbv7h2+pjk89SoqTkwqBiNEolm6AZOju8ZDjy5VBgHtes+5TvTPjPkA94
	hPkcSH+A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v7863-000000077rD-03kV;
	Fri, 10 Oct 2025 08:03:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3186530023C; Fri, 10 Oct 2025 10:03:27 +0200 (CEST)
Date: Fri, 10 Oct 2025 10:03:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Boqun Feng <boqun.feng@gmail.com>,
	David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Li RongQing <lirongqing@baidu.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] seqlock: introduce scoped_seqlock_read() and
 scoped_seqlock_read_irqsave()
Message-ID: <20251010080327.GF4067720@noisy.programming.kicks-ass.net>
References: <20251008123045.GA20440@redhat.com>
 <CAHk-=wjozC9_JCdEW9K_uruJqzTLzhtcVpgDk1OuqErNRUS7Mg@mail.gmail.com>
 <CAHk-=wjuoFm9yZur_T4VOnX2iyDYD6T_gDRXE5ms9538W6Q35g@mail.gmail.com>
 <CAHk-=wiHbN+_LCmSj2sHswDRJ0yG3kkjptMvCXcMwk7jWK1F=Q@mail.gmail.com>
 <20251009143748.GA2704@redhat.com>
 <20251009195024.GL3289052@noisy.programming.kicks-ass.net>
 <20251009201154.GL1386988@noisy.programming.kicks-ass.net>
 <CAHk-=wh3h5cV=UiTg+gvqB-T6+pStDNH0+6w4i34qMC1BQwmpg@mail.gmail.com>
 <20251009221242.GX3419281@noisy.programming.kicks-ass.net>
 <CAHk-=whmjm0BbirO8HhT_TZQ2JJMs_FpTcT9SXXaA3NifW2a4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whmjm0BbirO8HhT_TZQ2JJMs_FpTcT9SXXaA3NifW2a4w@mail.gmail.com>

On Thu, Oct 09, 2025 at 03:55:15PM -0700, Linus Torvalds wrote:
> On Thu, 9 Oct 2025 at 15:12, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Sure; otoh compiler should be able to tell the same using liveness
> > analysis I suppose, but perhaps they're not *that* clever.
> 
> They are that clever, but only if they end up unrolling the loop
> statically. If the loop remains a loop, the two variables end up live
> in the same code.
> 
> And while a compiler _could_ in theory still see that they aren't
> actually live in the same _iteration_, I don't think any compiler
> actually ends up being that clever in practice.
> 
> So making it a union then hopefully gets the compiler to basically use
> that explicit information.

Right, so I had to use -Os to not make it unroll the thing, but then
indeed, sharing the variable helps it.

> > So I thought they were fine; we handle all the enum cases with 'return'
> > so its impossible to not exit the switch() but the silly compiler was
> > complaining about possible fall-through, so clearly it was getting
> > confused.
> 
> Yeah, I found the same thing with the 0/1/2 approach - the compiler
> wouldn't realize that the range was limited until I added a very
> explicit limit check that "shouldn't matter", but did.
> 
> This might obviously end up depending on compiler version and other
> random things, but in general the whole value range analysis tends to
> be a pretty fragile thing.
> 
> In practice, compilers tend to be good at doing value range analysis
> if they see particular patterns (like initializing it to some value,
> always incrementing it by one, and comparing against another value).
> 
> But when it's written more like a state machine like this, it's
> clearly very hit and miss.

I reordered the code, it is happier now.

Anyway, the below seems to generate decent code for
{-O2,-Os}x{gcc-14,clang-22}. Yay for optimizing compilers I suppose :-)

---
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5ce48eab7a2a..45fab026f7d6 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -1209,4 +1209,83 @@ done_seqretry_irqrestore(seqlock_t *lock, int seq, unsigned long flags)
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
+	unsigned long	data;
+	spinlock_t	*lock;
+	spinlock_t	*lock_irqsave;
+};
+
+static inline void __scoped_seqlock_cleanup(struct ss_tmp *sst)
+{
+	if (sst->lock)
+		spin_unlock(sst->lock);
+	if (sst->lock_irqsave)
+		spin_unlock_irqrestore(sst->lock, sst->data);
+}
+
+extern void __scoped_seqlock_invalid_target(void);
+extern void __scoped_seqlock_bug(void);
+
+static inline void
+__scoped_seqlock_next(struct ss_tmp *sst, seqlock_t *lock, enum ss_state target)
+{
+	switch (sst->state) {
+	case ss_done:
+		__scoped_seqlock_bug();
+		return;
+
+	case ss_lock:
+	case ss_lock_irqsave:
+		sst->state = ss_done;
+		return;
+
+	case ss_lockless:
+		if (!read_seqretry(lock, sst->data)) {
+			sst->state = ss_done;
+			return;
+		}
+		break;
+	}
+
+	switch (target) {
+	case ss_done:
+		__scoped_seqlock_invalid_target();
+		return;
+
+	case ss_lock:
+		sst->lock = &lock->lock;
+		spin_lock(sst->lock);
+		sst->state = ss_lock;
+		return;
+
+	case ss_lock_irqsave:
+		sst->lock_irqsave = &lock->lock;
+		spin_lock_irqsave(sst->lock, sst->data);
+		sst->state = ss_lock_irqsave;
+		return;
+
+	case ss_lockless:
+		sst->data = read_seqbegin(lock);
+		return;
+	}
+}
+
+#define __scoped_seqlock_read(_seqlock, _target, _s)			\
+	for (struct ss_tmp _s __cleanup(__scoped_seqlock_cleanup) =	\
+	     { .state = ss_lockless, .data = read_seqbegin(_seqlock) };	\
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

