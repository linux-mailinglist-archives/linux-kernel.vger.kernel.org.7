Return-Path: <linux-kernel+bounces-800716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3FEB43AF4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282481C25A3C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2C6277CA4;
	Thu,  4 Sep 2025 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KIXHkON0"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CC82CCC0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987456; cv=none; b=bKQ9Z5zUWhKtVTv/ea0J9+z3JCfXI0n76DRNRY+jNaDTY9cTDVZhgKnWe30UnZcf3RhF7zkefaXY1+ItuREweMsufTCKnTvfWf6EDaYR/o9LWip8pSXY56PaZAR3zTp2rK+MYK7pbkojDuog6qzoTucpJYx+sPArogHoGttRjzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987456; c=relaxed/simple;
	bh=lGl2MbNsirxTb2TdNSbAhzazcBr/rp1kOoYDd4ovgYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5b4f43E2a+chkxvAqzgqqjTMdZSh22+S5vbp+/ItWgkpKQNKgoUUGavF/mrN59h0FWnANbLWqDJNtbduJCTIpKtTY8zQd6NEHFHAGEtSTFUiINBd2QyGFkJq7X5rOiRvD0RHYWtvqUdsRUMiZUPRLAME30vTc8/St6In+JqTgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KIXHkON0; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-329e1c8e079so799089a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756987453; x=1757592253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJUjFRTIwREb6ZjdrljHQu9O3h67SQdkCtIrAFpCPbs=;
        b=KIXHkON0wIIk1p0oAZAnWDkgCpmrpd4lcLFbQZQ35iatLKnY6ug9h9wR5n/hVUTRHo
         qWC0dqSdAptENB9qVOkEVa7J/Br+fTw4rAPL025oLxXjsHOQVt3+XxSENcUajg51elK0
         pC4qHKDOtnzt/drqNs7EyMC7VpRPzlQFfwjQfi8pPUvLL6MUjHI5LzQkvTMDqV4LB0d5
         Yu2i9tAQmNKEGrt8DjsCsWxBTr67odORjriM98Z6LFQsBU+6bOd2lswHTXP9Gq3xRGLV
         GkHUUfTEhXRo8Qc8ozWBQD8Ybg1ZrAqBraRQw/5wWCjdPvc+ki3UyIeouJynxMq+BCjz
         epJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756987453; x=1757592253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJUjFRTIwREb6ZjdrljHQu9O3h67SQdkCtIrAFpCPbs=;
        b=jalRQLq0ChSbLqGK59IvD93sJJKc/x9TzWd4vywnBPqeoWgfW+R3I+H3Y0KfEO+jdN
         dD0ma35z5/hfIG2xTCVvk5Sw1N+8Tp77W2iBeQmWFVVpKkaBZnF1OSPvvxeTJh56LrD1
         9u9Da92tWNbrgNsjKHNGnVP9Vb+nXNFX6HkUiQnwf9F8hUkh8NRW6x+eqCg0l0nOjQMm
         hY50xAoS0qGO7zMIzE5E9qOWrSqwLnJlXn3VUYqr0cP7Sxi19/HLaB7PVsXQVcL1KkM+
         +CcBzu7zTC7W3IgJwwD9RGrcsTF7qZpBo4BxEBjOtdam1weMwuPlRaaEbr6Nsdk0Ukr+
         ghzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/aVxqnOsVBZIEN8Hqs+coaI/R/8XJV2w7XYycOTERIMiLrbqUOPDLyjpT4oBR/IyDaM38bWhHjyVUhMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymqu2fDfTpFAsTQNzqovt0Bzgora5OXCQAZQ+8aHR7hAygG14h
	g8YmyRslhjCR9l4odmEqzLsJ5CKyg6bF5dAl7E4K6guzqT04NYfxmZ7kqhnsRFG0qA==
X-Gm-Gg: ASbGncslmCsi43MWcDGICv6n8q5Ekxrt7or8wbAeKzqeIoTJRYDk7g/vdyqgTdstGYP
	Wzvsm4no+R0ii0ao4WIfs3YGJwb4yOdMv/KpmbEw4v2+qA8wFmUdoRBf1nNelkZVKcQPzLFKKVc
	pWaHYKixhz1v75Ilirl/Irs+yoNsZvE3P98AVqFgXh9uNqpFT166RJ0IlMcE0lT16xZ82hXG0pi
	a0ogNfdvmTvAGSrhA+Y4a1Ny9MBC3qfrji1TRjn/p7+QnUeQnoldU039Ri46Ki+zB7qLPC4RywI
	DJ1WPxq6MtpIe3bS6NThosSZe6PNbvFm4OKg1ZCBJqL4UGevvIQ2RSap4n+9EcTszqniVoRNh3x
	Z7eSjLQZl2fJnuvNdYY8K4yspdNS511LwlDeIu7r/gDoDj4IrUw==
X-Google-Smtp-Source: AGHT+IH8Tg9q+phA5iI4fVJwpeklHVNbQqKLI4VFDnhH5jlcO/eiU3I6e37RUnTQfdOYSHOwldwpyg==
X-Received: by 2002:a17:90b:4d92:b0:327:a638:d21 with SMTP id 98e67ed59e1d1-3281531d3bbmr25209004a91.0.1756987452489;
        Thu, 04 Sep 2025 05:04:12 -0700 (PDT)
Received: from bytedance ([61.213.176.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7726c1ed65bsm8688569b3a.45.2025.09.04.05.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 05:04:11 -0700 (PDT)
Date: Thu, 4 Sep 2025 20:04:01 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Benjamin Segall <bsegall@google.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal Koutn?? <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250904120401.GJ42@bytedance>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
 <14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
 <xm26o6rrtgav.fsf@google.com>
 <20250904081611.GE42@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904081611.GE42@bytedance>

On Thu, Sep 04, 2025 at 04:16:11PM +0800, Aaron Lu wrote:
> On Wed, Sep 03, 2025 at 01:46:48PM -0700, Benjamin Segall wrote:
> > K Prateek Nayak <kprateek.nayak@amd.com> writes:
> > 
> > > Hello Peter,
> > >
> > > On 9/3/2025 8:21 PM, Peter Zijlstra wrote:
> > >>>  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> > >>>  {
> > >>> +	if (task_is_throttled(p)) {
> > >>> +		dequeue_throttled_task(p, flags);
> > >>> +		return true;
> > >>> +	}
> > >>> +
> > >>>  	if (!p->se.sched_delayed)
> > >>>  		util_est_dequeue(&rq->cfs, p);
> > >>>  
> > >> 
> > >> OK, so this makes it so that either a task is fully enqueued (all
> > >> cfs_rq's) or full not. A group cfs_rq is only marked throttled when all
> > >> its tasks are gone, and unthrottled when a task gets added. Right?
> > >
> > > cfs_rq (and the hierarchy below) is marked throttled when the quota
> > > has elapsed. Tasks on the throttled hierarchies will dequeue
> > > themselves completely via task work added during pick. When the last
> > > task leaves on a cfs_rq of throttled hierarchy, PELT is frozen for
> > > that cfs_rq.
> > >
> > > When a new task is added on the hierarchy, the PELT is unfrozen and
> > > the task becomes runnable. The cfs_rq and the hierarchy is still
> > > marked throttled.
> > >
> > > Unthrottling of hierarchy is only done at distribution.
> > >
> > >> 
> > >> But propagate_entity_cfs_rq() is still doing the old thing, and has a
> > >> if (cfs_rq_throttled(cfs_rq)) break; inside the for_each_sched_entity()
> > >> iteration.
> > >> 
> > >> This seems somewhat inconsistent; or am I missing something ? 
> > >
> > > Probably an oversight. But before that, what was the reason to have
> > > stopped this propagation at throttled_cfs_rq() before the changes?
> > >
> > 
> > Yeah, this was one of the things I was (slowly) looking at - with this
> > series we currently still abort in:
> > 
> > 1) update_cfs_group
> > 2) dequeue_entities's set_next_buddy
> > 3) check_preempt_fair
> > 4) yield_to
> > 5) propagate_entity_cfs_rq
> > 
> > In the old design on throttle immediately remove the entire cfs_rq,
> > freeze time for it, and stop adjusting load. In the new design we still
> > pick from it, so we definitely don't want to stop time (and don't). I'm

Per my understanding, we keep PELT clock running because we want the
throttled cfs_rq's load to continue get update when it still has tasks
running in kernel mode and have that up2date load could let it have a
hopefully more accurate weight through update_cfs_group(). So it looks
to me, if PELT clock should not be stopped, then we should not abort in
propagate_entity_cfs_rq() and update_cfs_group(). I missed these two
aborts in these two functions, but now you and Peter have pointed this
out, I suppose there is no doubt we should not abort in
update_cfs_group() and propagate_entity_cfs_rq()? If we should not mess
with shares distribution, then the up2date load is not useful and why
not simply freeze PELT clock on throttle :)

> > guessing we probably also want to now adjust load for it, but it is
> > arguable - since all the cfs_rqs for the tg are likely to throttle at the
> > same time, so we might not want to mess with the shares distribution,
> > since when unthrottle comes around the most likely correct distribution
> > is the distribution we had at the time of throttle.
> >
> 
> I can give it a test to see how things change by adjusting load and share
> distribution using my previous performance tests.
>

Run hackbench and netperf on AMD Genoa and didn't notice any obvious
difference with the cumulated diff.

> > Assuming we do want to adjust load for a throttle then we probably want
> > to remove the aborts from update_cfs_group and propagate_entity_cfs_rq.
> > I'm guessing that we need the list_add_leaf_cfs_rq from propagate, but
> > I'm not 100% sure when they are actually doing something in propagate as
> > opposed to enqueue.
> >
> 
> Yes, commit 0258bdfaff5bd("sched/fair: Fix unfairness caused by missing 
> load decay") added that list_add_leaf_cfs_rq() in
> propagate_entity_cfs_rq() to fix a problem.
> 
> > The other 3 are the same sort of thing - scheduling pick heuristics
> > which imo are pretty arbitrary to keep. We can reasonably say that "the
> > most likely thing a task in a throttled hierarchy will do is just go
> > throttle itself, so we shouldn't buddy it or let it preempt", but it
> > would also be reasonable to let them preempt/buddy normally, in case
> > they hold locks or such.
> 
> I think we do not need to special case tasks in throttled hierarchy in
> check_preempt_wakeup_fair().
>

Since there is pros and cons either way and consider the performance
test result, I'm now feeling maybe we can leave these 3 as is and revisit
them later when there is some clear case.

> > 
> > yield_to is used by kvm and st-dma-fence-chain.c. Yielding to a
> > throttle-on-exit kvm cpu thread isn't useful (so no need to remove the
> > abort there). The dma code is just yielding to a just-spawned kthread,
> > so it should be fine either way.
> 
> Get it.
> 
> The cumulated diff I'm going to experiment is below, let me know if
> something is wrong, thanks.

