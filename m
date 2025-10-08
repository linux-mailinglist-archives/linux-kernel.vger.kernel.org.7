Return-Path: <linux-kernel+bounces-845365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74853BC4963
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 13:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717441888ED2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 11:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FFE2EB878;
	Wed,  8 Oct 2025 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KFKBFIBU"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146F25B1CE
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759923449; cv=none; b=WUi71aWaGlmu0ymqSiqn2Pyns2Mq/6QZEjd2NeIuOweHqkJ9wCLXAGhT4cYDVq8W7//fvnjW4vh4dOykePlCeM0vEEDhStUAN2sOCyJ8lIJ3GRvo2SUMFxylTdINCbXloHMNB0CMc5/X07P5DimEjb4j+7Hkwy6QFlibXDIbEbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759923449; c=relaxed/simple;
	bh=vyibQgDohNPlsD0FCwsM1rLRhORPlfbfdwXRep+Z4bE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnHCYZBl3Pwk6DOpB42VYsh2fisQrBrVVHmoOytp8bylkq2J5nxbI3blKKBpIt4MIJcEPCS6vLu05bATWvPP56NUQ41Uk1GWGDLo9tYm5fyvIE+ynDVoAbx1lp3w9nWEjuJOQ2ncVG009PpqbK4xxf+Z3t+0L8wrN29zgraxUdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KFKBFIBU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jgprr7F3KdJ+JKXM/25Z++fkBAjjCczyn4sy7+XGqu0=; b=KFKBFIBUccgaXaF6dKrcg+/EJ/
	MUmr5V1ruA96j7rGG/E7wbJisVaWMjQNo0U/XcuYfn0kR0egRhTy33Jhua7KVoaAQvCKbKlUXvJvT
	Cpbd1QWNC5NwUnJsq+JnYO5IWMqUfs/j+u/MvMxrCdJIoce6AdW6YZ7ilYhN8hD+RYxhZXoO7hHln
	kbRdy+eMrUGg6quzOkendWK55ytk5DDj4NvJ7ORDI/tkbNGkfL4/J2tpdYIzgZfHvFlRw3qZ2VMNa
	ErVLGzeD1wX3B+w4svh4Jrfbbet/MpzjrdReRo/d4B7IgGDXpGDYrIOUoLevA6wlfFKG7ctB8N+v/
	xQSEMuCQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6STt-00000003w9Y-1cAQ;
	Wed, 08 Oct 2025 11:37:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1CDA6300220; Wed, 08 Oct 2025 13:37:18 +0200 (CEST)
Date: Wed, 8 Oct 2025 13:37:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
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
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Suleiman Souhlal <suleiman@google.com>,
	kuyo chang <kuyo.chang@mediatek.com>, hupu <hupu.gm@gmail.com>,
	kernel-team@android.com
Subject: Re: [PATCH v22 3/6] sched: Add logic to zap balance callbacks if we
 pick again
Message-ID: <20251008113718.GV3419281@noisy.programming.kicks-ass.net>
References: <20250926032931.27663-1-jstultz@google.com>
 <20250926032931.27663-4-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926032931.27663-4-jstultz@google.com>

On Fri, Sep 26, 2025 at 03:29:11AM +0000, John Stultz wrote:

> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +/*
> + * Only called from __schedule context
> + *
> + * There are some cases where we are going to re-do the action
> + * that added the balance callbacks. We may not be in a state
> + * where we can run them, so just zap them so they can be
> + * properly re-added on the next time around. This is similar
> + * handling to running the callbacks, except we just don't call
> + * them.
> + */
> +static void zap_balance_callbacks(struct rq *rq)
> +{
> +	struct balance_callback *next, *head;
> +	bool found = false;
> +
> +	lockdep_assert_rq_held(rq);
> +
> +	head = rq->balance_callback;
> +	while (head) {
> +		if (head == &balance_push_callback)
> +			found = true;
> +		next = head->next;
> +		head->next = NULL;
> +		head = next;
> +	}
> +	rq->balance_callback = found ? &balance_push_callback : NULL;
> +}
> +#else
> +static inline void zap_balance_callbacks(struct rq *rq) {}
> +#endif
> +
>  static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
>  {
>  	void (*func)(struct rq *rq);
> @@ -6942,10 +6974,15 @@ static void __sched notrace __schedule(int sched_mode)
>  	rq_set_donor(rq, next);
>  	if (unlikely(task_is_blocked(next))) {
>  		next = find_proxy_task(rq, next, &rf);
> -		if (!next)
> +		if (!next) {
> +			/* zap the balance_callbacks before picking again */
> +			zap_balance_callbacks(rq);
>  			goto pick_again;
> -		if (next == rq->idle)
> +		}
> +		if (next == rq->idle) {
> +			zap_balance_callbacks(rq);
>  			goto keep_resched;
> +		}
>  	}
>  picked:
>  	clear_tsk_need_resched(prev);

I would feel a wee bit better if you'd add something like:

  pick_again:
+	assert_balance_callbacks_empty();
	next = pick_next_task(...);

And have that verify the balance list is indeed empty (save for push).
Perhaps make that depend on PROVE_LOCKING or so; since someone went and
deleted SCHED_DEBUG *sigh*.

