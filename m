Return-Path: <linux-kernel+bounces-845305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DCABC4517
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1E7400CD0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108B72F5322;
	Wed,  8 Oct 2025 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FE6OFiMQ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2ED1E0B9C
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759919283; cv=none; b=lgAC2SopWK1w6eyAcTFBwYOzbDJO1hH8i/olNCH/smDAuBJDw4SVD7n0MHfM60oqwFqCZ2qqw1nwcQfODqjOSNfj36lTtBhcD5wC4qAgefDVPTa2X+9YM6TWfbiF09havjTXOkO8ugTGr5+X7+utmi/7WLtizyfhvQdr4rVEBbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759919283; c=relaxed/simple;
	bh=L0HF6uQnkG/1DXegcgo7cms2B8bLc5/OG1QK7W2R5Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8DlG9Oge7hH0SEb41xy0pw+xOohXi1+4MOVomjjzkFbb9wrcWq6v9gLQ7K8rukGmOEpdBdiwzN3vKEbWLw0EaykzFU78qEDuyD7T1jKSFcZWopxY2koa5YW5KED4qBDjXGfGha/7x67gMKeQ1JB+P57mOg1yXVhm+OW/28sfnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FE6OFiMQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FqOBYjQGpqr2TLAwPP+mdxzkBBXm0wwLnisHEx7WET0=; b=FE6OFiMQV9j1gS1YN2yh+F2HxY
	gVBZ5JT60LdVvolN4iz2WjVRvbMg1rQZcZKlLYNH6796RDdZmyzKZ3ErwyYxp6DiEzX2oolezJsU4
	jcgKrYTmVRh+nFMPDPOpHtQC0GpIBl+BePPPuRrBt4hCQ+NXk94nbHQbF1M0b4lysXi9q3rvewmWx
	mQBi4OmgqBLFvg4+KZHXRJijg8C5JFVcEGpKbe8v7umk36c16IqJNAXo19e8V8u6tkc0R6Fgw3lLU
	QNR1MBxD4WRg0X78Vq7v1NAN1HxKYYHokHpSU9t8Zs6otKOVpHCpMjBL5IX9f8hN2EsV8MtmWUSGV
	3Xwd3YXg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6ROG-00000000e01-2y5g;
	Wed, 08 Oct 2025 10:27:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 78057300220; Wed, 08 Oct 2025 12:27:22 +0200 (CEST)
Date: Wed, 8 Oct 2025 12:27:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [PATCH v22 1/6] locking: Add task::blocked_lock to serialize
 blocked_on state
Message-ID: <20251008102722.GT3419281@noisy.programming.kicks-ass.net>
References: <20250926032931.27663-1-jstultz@google.com>
 <20250926032931.27663-2-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926032931.27663-2-jstultz@google.com>

On Fri, Sep 26, 2025 at 03:29:09AM +0000, John Stultz wrote:
> So far, we have been able to utilize the mutex::wait_lock
> for serializing the blocked_on state, but when we move to
> proxying across runqueues, we will need to add more state
> and a way to serialize changes to this state in contexts
> where we don't hold the mutex::wait_lock.
> 
> So introduce the task::blocked_lock, which nests under the
> mutex::wait_lock in the locking order, and rework the locking
> to use it.
> 
> Signed-off-by: John Stultz <jstultz@google.com>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  include/linux/sched.h        | 52 +++++++++++++++---------------------
>  init/init_task.c             |  1 +
>  kernel/fork.c                |  1 +
>  kernel/locking/mutex-debug.c |  4 +--
>  kernel/locking/mutex.c       | 40 +++++++++++++++++----------
>  kernel/locking/ww_mutex.h    |  4 +--
>  kernel/sched/core.c          |  4 ++-
>  7 files changed, 57 insertions(+), 49 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index e4ce0a76831e5..cb4e81d9d9b67 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h

> +static inline struct mutex *get_task_blocked_on(struct task_struct *p)
> +{
> +	guard(raw_spinlock_irqsave)(&p->blocked_lock);
> +	return __get_task_blocked_on(p);
>  }

This isn't a safe function in general; nothing guarantees the value
returned is stable. Perhaps move it inside kernel/locking/mutex.h, its
only users (below) are mutex debug code after all.

> diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
> index 949103fd8e9b5..1d8cff71f65e1 100644
> --- a/kernel/locking/mutex-debug.c
> +++ b/kernel/locking/mutex-debug.c
> @@ -54,13 +54,13 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>  	lockdep_assert_held(&lock->wait_lock);
>  
>  	/* Current thread can't be already blocked (since it's executing!) */
> -	DEBUG_LOCKS_WARN_ON(__get_task_blocked_on(task));
> +	DEBUG_LOCKS_WARN_ON(get_task_blocked_on(task));
>  }
>  
>  void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
>  			 struct task_struct *task)
>  {
> -	struct mutex *blocked_on = __get_task_blocked_on(task);
> +	struct mutex *blocked_on = get_task_blocked_on(task);
>  
>  	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
>  	DEBUG_LOCKS_WARN_ON(waiter->task != task);
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index de7d6702cd96c..c44fc63d4476e 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c

> @@ -740,11 +752,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  	return 0;
>  
>  err:
> -	__clear_task_blocked_on(current, lock);
> +	clear_task_blocked_on(current, lock);
>  	__set_current_state(TASK_RUNNING);
>  	__mutex_remove_waiter(lock, &waiter);
>  err_early_kill:
> -	WARN_ON(__get_task_blocked_on(current));
> +	WARN_ON(get_task_blocked_on(current));
>  	trace_contention_end(lock, ret);
>  	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
>  	debug_mutex_free_waiter(&waiter);

