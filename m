Return-Path: <linux-kernel+bounces-838908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9FCBB0674
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9375B16583F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2481EB5C2;
	Wed,  1 Oct 2025 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M9sfKFbF"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE12F1E5B71
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323760; cv=none; b=KLXEhGyA1v6guJleAtxHzh1eYemYe5wOz1UDqMdK+3vg/kVMSwGiQnG7nB8g6qNlToF5/CBXVlLjUxC1A903631s4dmj8i/WxlsHfr+DAd9+VXmudH6D3Ns6R/sRLcAlv0OHoYfUNLsJtcHv+U1ck7mq1agQvvWgaxKwDEv1/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323760; c=relaxed/simple;
	bh=UiURKlgRBxTuC+9/Qgr50XZ+E0KQB31aQMIJZ1OyBF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0QRBd9ZkAHro8/q40w7S39rHEb2EVgns8p/V6vyhpbu0WDK1Jm91IN+RNml3xQyD5+DWJxo1MMU3815qzM8jIeA6uIVY0cx6UQzu6L0QB9RJE27CLrdzjgbQiFv/8sArbLqbiLYNki3R9KBgUJfzbokog2RLQx1bx+Jsf/29dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M9sfKFbF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TK2ZpKxuOS85n6q0a3dtQV6/31pOLwOtr0xjWgEtrek=; b=M9sfKFbFwAtTVZ3PC36LWu1yxF
	VnI5A3KNcoMqUoUki0oF9tjKEKK7TIomMHDzAYpuvu/BVhz50BgCeu8cJZag6KTZnKTnJryPT7O7S
	C0LGbZT7YRR+vZVBGK3qhmDxfZiLbd9G027bvaSSZDW1f/+f80eoD8u9D2lYKWqYkMq6JnW5r6lVR
	z7AE/Cd5y4Kfb4q7l9HaKyLGE2Yy5nPdlbPhnZH4Nr03uYLBlajqqX/f8UvGfxk+75XwGVmF3bKb3
	dckMGaquuTeWtKIppPlGX0lP88IkJ42t4SqcDTHcHHEZSXH76sBBLCd0ioHnng0ZMDdk5Q8RrRfEl
	5Fl6WDIA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3wTV-000000012bx-1Bas;
	Wed, 01 Oct 2025 13:02:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6AB99300328; Wed, 01 Oct 2025 15:02:29 +0200 (CEST)
Date: Wed, 1 Oct 2025 15:02:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/1] seqlock: make the read_seqbegin_or_lock() API more
 simple and less error-prone ?
Message-ID: <20251001130229.GO3245006@noisy.programming.kicks-ass.net>
References: <20250928161953.GA3112@redhat.com>
 <20250928162054.GB3121@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928162054.GB3121@redhat.com>

On Sun, Sep 28, 2025 at 06:20:54PM +0200, Oleg Nesterov wrote:

> Can we improve this API?

Please :-)

> -------------------------------------------------------------------------------
> To simplify, suppose we add the new helper
> 
> 	static inline int need_seqretry_xxx(seqlock_t *lock, int *seq)
> 	{
> 		int ret = !(*seq & 1) && read_seqretry(lock, *seq);
> 
> 		if (ret)
> 			++*seq;	/* make this counter odd */
> 
> 		return ret;
> 	}

How about need_seqretry_or_lock() to stay in theme with
read_seqbegin_or_lock().

But then there's done_seqretry() without the _or_lock() :/

> which can be used instead of need_seqretry(). This way the users do not
> need to modify "seq" in the main loop. For example, we can simplify
> thread_group_cputime() as follows:
> 
> 	--- a/kernel/sched/cputime.c
> 	+++ b/kernel/sched/cputime.c
> 	@@ -314,7 +314,7 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
> 		struct signal_struct *sig = tsk->signal;
> 		u64 utime, stime;
> 		struct task_struct *t;
> 	-	unsigned int seq, nextseq;
> 	+	unsigned int seq;
> 		unsigned long flags;
> 	 
> 		/*
> 	@@ -330,9 +330,8 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
> 	 
> 		rcu_read_lock();
> 		/* Attempt a lockless read on the first round. */
> 	-	nextseq = 0;
> 	+	seq = 0;
> 		do {
> 	-		seq = nextseq;
> 			flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
> 			times->utime = sig->utime;
> 			times->stime = sig->stime;
> 	@@ -344,9 +343,7 @@ void thread_group_cputime(struct task_struct *tsk, struct task_cputime *times)
> 				times->stime += stime;
> 				times->sum_exec_runtime += read_sum_exec_runtime(t);
> 			}
> 	-		/* If lockless access failed, take the lock. */
> 	-		nextseq = 1;
> 	-	} while (need_seqretry(&sig->stats_lock, seq));
> 	+	} while (need_seqretry_xxx(&sig->stats_lock, &seq));
> 		done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
> 		rcu_read_unlock();
> 	 }
> 
> most (if not all) of other users can be changed the same way.
> 
> -------------------------------------------------------------------------------
> Or perhaps we can even add a helper that hides all the details, something like
> 
> 	int xxx(seqlock_t *lock, int *seq, int lockless)
> 	{
> 		if (lockless) {
> 			*seq = read_seqbegin(lock);
> 			return 1;
> 		}
> 
> 		if (*seq & 1) {
> 			read_sequnlock_excl(lock);
> 			return 0;
> 		}
> 
> 		if (read_seqretry(lock, *seq)) {
> 			read_seqlock_excl(lock);
> 			*seq = 1;
> 			return 1;
> 		}
> 
> 		return 0;
> 
> 	}
> 
> 	#define __XXX(lock, seq, lockless)	\
> 		for (int lockless = 1, seq; xxx(lock, &seq, lockless); lockless = 0)
> 
> 	#define XXX(lock)	\
> 		__XXX(lock, __UNIQUE_ID(seq), __UNIQUE_ID(lockless))
> 
> 
> ?

Oh gawd, that thing had better not have control flow escape that loop.

But yes, I suppose something like this is far more useable than the
current thing.

> This way the users can simply do:
> 
> 	seqlock_t sl;
> 
> 	void func(void)
> 	{
> 		XXX(&sl) {
> 			... read-side critical section ...
> 		}
> 	}
> 
> using only the new XXX() helper. No need to declare/initialize seq, no need
> for need_seqretry/done_seqretry.
> 
> What do you think?

I'm thinking we want something like this for the normal seqcount loops
too :-)

