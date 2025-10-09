Return-Path: <linux-kernel+bounces-846329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C19BC7980
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B1419E5746
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C664C2D0267;
	Thu,  9 Oct 2025 06:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRl6DxCo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B8520B22
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759992875; cv=none; b=SzwsqQyNam+2RG/08En+XieaFTtpM8XMkS9n/G8Uvmqo809wb0QbX8Nknsj7vceCwKWnax0u+ObJHulUCOSNPQYMGZPpQWjJg6dpkNAzo2NYjEPex6ctVUT51vjJfMTpT/igDWPD2ZD7PRtNuHuUBWMsbCzAxbzlRsru398tbpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759992875; c=relaxed/simple;
	bh=rzrfV6OtS/lt+i2VgHtH+N700eokZ91K/bMU5408Dww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3yUVEdGAIX7aDkaMPRQfKUqQ83GEO+kI7jSrEbl9yjVY8oER+n+kRRSWenjcfcFwWb9zOHHgTl87KvXw3bSG0j0mjrz6ZOYriqSxz69QH0gks7XU05YChmNmAHKv67yiznwdWkl4iJUluldlJQgQeeqeCQ1uhalVKn4znluTXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRl6DxCo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759992871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bBVfRHmwTxTfWpJViC0vb0/pvUUmJPwzJ3swAkb7++M=;
	b=RRl6DxCoZJAarMkRUxStkpMOjpHZiTTr9abiltevQ5obtowsLDGp+zsh3BqT4fUXuT7bVU
	p0PKu+byhWZ4ghOxK9chZ/uE1N3j2yfQhb0VJohWlz14dO4jkiTjCHfKwDt0UEgADqne/z
	iqRXAjckMdK5KfjJSHT9Fnh9BdpiqCg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-EdUEy45-OG-OQASYPv0dzQ-1; Thu, 09 Oct 2025 02:54:30 -0400
X-MC-Unique: EdUEy45-OG-OQASYPv0dzQ-1
X-Mimecast-MFC-AGG-ID: EdUEy45-OG-OQASYPv0dzQ_1759992869
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46eee58d405so2538905e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759992869; x=1760597669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBVfRHmwTxTfWpJViC0vb0/pvUUmJPwzJ3swAkb7++M=;
        b=QYVEV5BI3RnJzcYBpcrbiqaihsFxwjkOgnXjzX5EAwoGLY8JIqKOiNSu1GO4GX2jkn
         2n7GNHxyFO2j7wGAdHD8/a/eHbwdUkBmeCfD4sOaz6tJjHClDRqIpHkRjCYKtToscgD9
         hL+DkH8FzLbdR7ntQxamQ9Oj6gpCWM+lJ87RLKhGwfGi6tMVEfCVjELw/6aKfEvWNH5w
         n4e5RzGfKJ8P/IA8ScsvGHma0XSVVummwPDCU4YxYav2x1EJbjINe3a5o56sVMhc3WiK
         HfIa3o8MrF3pgiS9SC2gtrOM9j0WH6Hc+AQ+zCOoB7gTceNxHn+JwjAJG28hKQierEPl
         AKZA==
X-Forwarded-Encrypted: i=1; AJvYcCVG2DHXfF5dwNXYdICtG3G6cS4O78YOIsydHRqe6T44aXHbf9rQIFIxSAA6rIUAUGbVQGLpCBphr27Jsmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWSl/Ir+UErOWwTcuq8bQfqYPcxGvzYsi8+uwcksU7I4Hue5Uo
	HGw+E8OxQ+TKTzM9g39P83aFmA9LXy9Mi+eaVydpK8EbKFaBEoCySIHVLnX7avUaxgpCLsN02g0
	xtWeKNssKOgVd56LwUHkokEHdl3Orq591ejYFpzVKJ1+0EcNapjFnPvjy0JvIzN+Mgg==
X-Gm-Gg: ASbGncsZt02FyiJ09+IlVxSs2PFx1kuodYR7vIRzn5FGApWVdRofYa3FCamPIqKxn5J
	1TzR3K5Ts6YvZPJ7rqPA5U0FKTPCIFv1nd7qrAs3YCv4QHdEIUITN4XGhSB5C8usL2SszZ4XAZ1
	0LxACS09KMVpazQNFNs17tyzvLWDNpFUuzelydv12JYYxe0x0wyhU24wDYoCW42xn9pnC7lCtY2
	+3CpwF/BmL1MWbijx6fShqhXR+0M+qfiYxe2rrk+ZwVtu+N2Bu56x3fzvhfoRDHGNPs6NfDIbXQ
	2ZVPMNrHo6BPatvrsIHEeb7/0tWrvz5uf/DRT/NineTEu0rnq0Su++mqqiSMx5C1HFIhKJ6KqZE
	gXw==
X-Received: by 2002:a05:600c:138f:b0:46e:19f8:88d8 with SMTP id 5b1f17b1804b1-46fa9b17d03mr38487175e9.34.1759992869326;
        Wed, 08 Oct 2025 23:54:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOD7+tXpigpCMwEkhGw+TORwzG1YRaCZxKpb8lRMKUCUP1JgzKC6GF4ksxSDMVA922AQCZ0g==
X-Received: by 2002:a05:600c:138f:b0:46e:19f8:88d8 with SMTP id 5b1f17b1804b1-46fa9b17d03mr38486975e9.34.1759992868798;
        Wed, 08 Oct 2025 23:54:28 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.13.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9c07a83sm76092635e9.6.2025.10.08.23.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:54:28 -0700 (PDT)
Date: Thu, 9 Oct 2025 08:54:25 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Yuri Andriaccio <yurand2000@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: Re: [RFC PATCH v3 12/24] sched/rt: Update task event callbacks for
 HCBS scheduling
Message-ID: <aOdcIbsqwhJTdGjL@jlelli-thinkpadt14gen4.remote.csb>
References: <20250929092221.10947-1-yurand2000@gmail.com>
 <20250929092221.10947-13-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929092221.10947-13-yurand2000@gmail.com>

Hello,

On 29/09/25 11:22, Yuri Andriaccio wrote:
> Update wakeup_preempt_rt, switched_{from/to}_rt and prio_changed_rt with
> rt-cgroup's specific preemption rules.
> Add checks whether a rt-task can be attached or not to a rt-cgroup.
> Update task_is_throttled_rt for SCHED_CORE.

A little dry. :) This is telling the what, can you please add also the
why and how?

> Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
> Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
> Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Co-developed-by: luca abeni <luca.abeni@santannapisa.it>
> Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
> Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
> ---
>  kernel/sched/core.c     |  2 +-
>  kernel/sched/rt.c       | 88 ++++++++++++++++++++++++++++++++++++++---
>  kernel/sched/syscalls.c | 13 ++++++
>  3 files changed, 96 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e5b4facee24..2cfbe3b7b17 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9346,7 +9346,7 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
>  		goto scx_check;
>  
>  	cgroup_taskset_for_each(task, css, tset) {
> -		if (!sched_rt_can_attach(css_tg(css), task))
> +		if (rt_task(task) && !sched_rt_can_attach(css_tg(css), task))
>  			return -EINVAL;
>  	}
>  scx_check:
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index d9442f64c6b..ce114823fe7 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -946,6 +946,50 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
>  {
>  	struct task_struct *donor = rq->donor;
>  
> +	if (!rt_group_sched_enabled())

Should we actually be using rt_group_sched_enabled() (instead of
ifdeffery) everywhere to check if group scheduling is enabled and
differentiate behavior?

> +		goto no_group_sched;
> +
> +	/*
> +	 * Preemption checks are different if the waking task and the current
> +	 * task are running on the global runqueue or in a cgroup.
> +	 * The following rules apply:
> +	 *   - dl-tasks (and equally dl_servers) always preempt FIFO/RR tasks.

We already touched upon this and maybe we can leave it for later, but
the fact that dl_servers always preempt FIFO/RR is going to be a change
of behavior wrt legacy RT group scheduling. Legacy users might have
expectations that setting an high static priority means those tasks will
always be scheduled first and this will break that. Maybe we want to
convince them to change their assumptions, but we need to at least
cleary document the new behavior (and why it is right/better - if it is
indeed :). Not sure if we can also find a way to be "back-compatible"
and if we want to do that.

> +	 *     - if curr is inside a cgroup (i.e. run by a dl_server) and
> +	 *       waking is not, do nothing.
> +	 *     - if waking is inside a cgroup but not curr, always reschedule.
> +	 *   - if they are both on the global runqueue, run the standard code.
> +	 *   - if they are both in the same cgroup, check for tasks priorities.
> +	 *   - if they are both in a cgroup, but not the same one, check whether
> +	 *     the woken task's dl_server preempts the current's dl_server.
> +	 */
> +	if (is_dl_group(rt_rq_of_se(&p->rt)) &&
> +	    is_dl_group(rt_rq_of_se(&rq->curr->rt))) {
> +		struct sched_dl_entity *woken_dl_se, *curr_dl_se;
> +
> +		woken_dl_se = dl_group_of(rt_rq_of_se(&p->rt));
> +		curr_dl_se = dl_group_of(rt_rq_of_se(&rq->curr->rt));
> +
> +		if (rt_rq_of_se(&p->rt)->tg == rt_rq_of_se(&rq->curr->rt)->tg) {

What about checking if woken_dl_se and curr_dl_se are the same dl_se?

> +			if (p->prio < rq->curr->prio)
> +				resched_curr(rq);
> +
> +			return;
> +		}
> +
> +		if (dl_entity_preempt(woken_dl_se, curr_dl_se))
> +			resched_curr(rq);
> +
> +		return;
> +
> +	} else if (is_dl_group(rt_rq_of_se(&p->rt))) {
> +		resched_curr(rq);
> +		return;
> +
> +	} else if (is_dl_group(rt_rq_of_se(&rq->curr->rt))) {
> +		return;
> +	}
> +
> +no_group_sched:
>  	if (p->prio < donor->prio) {
>  		resched_curr(rq);
>  		return;

...

> @@ -1750,8 +1797,17 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
>  	 * then see if we can move to another run queue.
>  	 */
>  	if (task_on_rq_queued(p)) {
> +
> +#ifndef CONFIG_RT_GROUP_SCHED
>  		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
>  			rt_queue_push_tasks(rt_rq_of_se(&p->rt));
> +#else
> +		if (rt_rq_of_se(&p->rt)->overloaded) {

Is this empty because intra-group migration is coming with some future
change? Even if that's the case, I believe this wants a comment
explaining why this branch is empty.

> +		} else {
> +			if (p->prio < rq->curr->prio)
> +				resched_curr(rq);
> +		}
> +#endif
>  		if (p->prio < rq->donor->prio && cpu_online(cpu_of(rq)))
>  			resched_curr(rq);
>  	}

...

> @@ -1876,7 +1943,16 @@ static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
>  #ifdef CONFIG_SCHED_CORE
>  static int task_is_throttled_rt(struct task_struct *p, int cpu)
>  {
> +#ifdef CONFIG_RT_GROUP_SCHED
> +	struct rt_rq *rt_rq;
> +
> +	rt_rq = task_group(p)->rt_rq[cpu];
> +	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
> +
> +	return dl_group_of(rt_rq)->dl_throttled;
> +#else
>  	return 0;
> +#endif
>  }
>  #endif /* CONFIG_SCHED_CORE */
>  
> @@ -2131,7 +2207,7 @@ static int sched_rt_global_constraints(void)
>  int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)

tsk argument is not going to be used anymore with this, please remove
it. Also maybe rename to something closer to what the function actually
checks for, e.g. [sched_]rt_group_has_runtime.

>  {
>  	/* Don't accept real-time tasks when there is no way for them to run */
> -	if (rt_group_sched_enabled() && rt_task(tsk) && tg->rt_bandwidth.rt_runtime == 0)
> +	if (rt_group_sched_enabled() && tg->dl_bandwidth.dl_runtime == 0)
>  		return 0;

Thanks,
Juri


