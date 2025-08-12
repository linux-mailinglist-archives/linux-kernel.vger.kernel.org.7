Return-Path: <linux-kernel+bounces-764364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D36FB22214
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7BF5633EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701002E62A4;
	Tue, 12 Aug 2025 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ht7vS1eO"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769972E6138
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988530; cv=none; b=amHCq/QIWxUznwxj8pq6jK2PIbWMpb37WX+2ZUSHXvX3f+wfh83iEhBtzgqVtB3Wl2mYiLTuzNglh7jPSzqkjV9gQiL4DALU7tI2o2WiywJrfXgETXz4xP1uCniYDJUQcX764nTycztKdWfL5SABbWz80THKxxIm3kDNJEA6FVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988530; c=relaxed/simple;
	bh=9qS2RQEQWRUhlRvpmkKEY4aDI+YK0NEhtWiywKmD+CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkniyipD+7SdgVrzt+DJuHweGIwa4F3nnUrPm10BHsgCpn1FHIcq5xlU7ZT9ZdckaxdXmUFhL53ex8wU23nFaqznN/CQ25g2RpS3slPhVbUV4TG0AEs1CM4nTRbaEy82SHaguyMyOvKRSc+tGUm+DXm4AzRzER9o6SSVcGxh26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ht7vS1eO; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4233978326so2912525a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754988528; x=1755593328; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XpIit4I/cjVIpPrd+Ctji5FRExg0FaKt0RzZLjt+AQw=;
        b=ht7vS1eO8TgIYHdz8CKNlQEojixzroYtiEstWage0Todqo9a3M4eEKmrYb09+rGyXV
         NWm3N7F5rtK4SY9lTLQ6cpJuXA3mvOv3jdjLZl4czu0sObpR6mRUxKd8Re7NzGjwUeJe
         QA0SrKE9UN2+Go3BxYaR10th7uXYjcJfc0jD+Vtc/tg4AH/pz7+TnVzWcppL/AslBNKj
         nP1XvJ2NQhQPv6K2FXWGdfF6DClUoOFmIkimThnPf5GhSzEcp/niSlB33wVzELacchWP
         0YvsCLGAW+/7dmBdaje5dde825eQXdwlN8/dUdIZoPYF7TttoTbRSwZInEqU1HMQmj/5
         gooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754988528; x=1755593328;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XpIit4I/cjVIpPrd+Ctji5FRExg0FaKt0RzZLjt+AQw=;
        b=xTqkV1n7kueprfNnRjWWirNDH6B7wN96omRLVbblI55bNfxNSKSCbajw09/0yh4v/X
         1Bq8Re9smprLKBsQw21mvcFczn9kY4gxquKmYyFx2syPdTiD2Y8cyaUXEyl/fu2/f1CJ
         Dl/iBMcekUaXrP/9zpQNAJ3RfxtMYlWHhA4yk1tneUZWeyJU7sjLF9MVJLB2+Pzsbnim
         xajEpbMQgGvJv+8x66j6onhk6G6J4y9gK+tNhAGbNJs9ct5HcmTBpbV9ZRoUZQdZHxdM
         Mubm/SHprQDd48kDMnKiwl3MK9zWt0mrt3jsuMgSNb7Jg+DwiiF5y65UWlUdaRItZo0u
         oUjg==
X-Forwarded-Encrypted: i=1; AJvYcCUmhrRJT7A5ilmsHTyPxV4TDlwk9uN5Xu2xY5kZ2m3CwMwaWV96jYPDJn+D32LMg/aWOFJ9NR/DIXS2Xqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZdugQUsE77GLV6NV0YBjhdN6UwOq+j6KtdwJTD/kDjVdIbDAw
	cSMMQy1RAT14/BS9ySSvZnS5m4BcofxPUUsttX+KfOb1jzxYP92Qnkk5RaGJRYs3yw==
X-Gm-Gg: ASbGnctQbbpbl3Os62T/1tywgT/77AjAWM0Qjbq8qGsawtmHMHEe2MqF6phmlEBH5zS
	+1izHSUM3DdoLGYxn+8t/pWP2NKV5/VRHd1mq4L6Bv7dXjJ2NuVTsxZHFvoGSZLMY7FJQX57fkJ
	NR+dym6tWni8qTso+w/E2M8bZMulkf0+0OT5H6sxlqO/zGmk2sEMH9Fa/r7ksJ5g8jCIJ8GqWcy
	vpeqYcg/bdzRIt4MaRZmxdCwmLivIfQ5JHHfRbkfCbKt37a8jRbbq7rHa1uYa00MrSmhw+P4syQ
	cxCCERKSck51UjEmlAMRn/0qtu9jsUBfyUWl3LUzqIyiAy3SXA7nvS3etUJB7dmO6sQJVjaer60
	UWwPT+nBFR3UO8Tw40XOPfomL77sUtNkquz4235vQXIEvrZCAV3ozgQ==
X-Google-Smtp-Source: AGHT+IFUjBqEg8hRNqdI8JGKcdqO/SKeN+sfDKwdG8ab0l1S7Rsq2rv0SGMF6RdUG8mYneuEuHxE/w==
X-Received: by 2002:a17:903:178e:b0:224:10a2:cae7 with SMTP id d9443c01a7336-242fc360f8dmr38940125ad.40.1754988527457;
        Tue, 12 Aug 2025 01:48:47 -0700 (PDT)
Received: from bytedance ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899aa1asm292781015ad.122.2025.08.12.01.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:48:46 -0700 (PDT)
Date: Tue, 12 Aug 2025 16:48:28 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Songtang Liu <liusongtang@bytedance.com>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250812084828.GA52@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-4-ziqianlu@bytedance.com>
 <xhsmhv7myp46n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250808101330.GA75@bytedance>
 <xhsmhsei2ox4o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmhsei2ox4o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Fri, Aug 08, 2025 at 01:45:11PM +0200, Valentin Schneider wrote:
> On 08/08/25 18:13, Aaron Lu wrote:
> > On Fri, Aug 08, 2025 at 11:12:48AM +0200, Valentin Schneider wrote:
> >> On 15/07/25 15:16, Aaron Lu wrote:
> >> > From: Valentin Schneider <vschneid@redhat.com>
> >> >
> >> > In current throttle model, when a cfs_rq is throttled, its entity will
> >> > be dequeued from cpu's rq, making tasks attached to it not able to run,
> >> > thus achiveing the throttle target.
> >> >
> >> > This has a drawback though: assume a task is a reader of percpu_rwsem
> >> > and is waiting. When it gets woken, it can not run till its task group's
> >> > next period comes, which can be a relatively long time. Waiting writer
> >> > will have to wait longer due to this and it also makes further reader
> >> > build up and eventually trigger task hung.
> >> >
> >> > To improve this situation, change the throttle model to task based, i.e.
> >> > when a cfs_rq is throttled, record its throttled status but do not remove
> >> > it from cpu's rq. Instead, for tasks that belong to this cfs_rq, when
> >> > they get picked, add a task work to them so that when they return
> >> > to user, they can be dequeued there. In this way, tasks throttled will
> >> > not hold any kernel resources. And on unthrottle, enqueue back those
> >> > tasks so they can continue to run.
> >> >
> >> 
> >> Moving the actual throttle work to pick time is clever. In my previous
> >> versions I tried really hard to stay out of the enqueue/dequeue/pick paths,
> >> but this makes the code a lot more palatable. I'd like to see how this
> >> impacts performance though.
> >> 
> >
> > Let me run some scheduler benchmark to see how it impacts performance.
> >
> > I'm thinking maybe running something like hackbench on server platforms,
> > first with quota not set and see if performance changes; then also test
> > with quota set and see how performance changes.
> >
> > Does this sound good to you? Or do you have any specific benchmark and
> > test methodology in mind?
> >
> 
> Yeah hackbench is pretty good for stressing the EQ/DQ paths.
> 

Tested hackbench/pipe and netperf/UDP_RR on Intel EMR(2 sockets/240
cpus) and AMD Genoa(2 sockets/384 cpus), the tldr is: there is no clear
performance change between base and this patchset(head). Below is
detailed test data:
(turbo/boost disabled, cpuidle disabled, cpufreq set to performance)

hackbench/pipe/loops=150000
(seconds, smaller is better)

On Intel EMR:

nr_group          base             head          change
 1              3.62±2.99%      3.61±10.42%      +0.28%
 8              8.06±1.58%      7.88±5.82%       +2.23%
16             11.40±2.57%     11.25±3.72%       +1.32%

For nr_group=16 case, configure a cgroup and set quota to half cpu and
then let hackbench run in this cgroup:

                 base             head           change
quota=50%      18.35±2.40%     18.78±1.97%       -2.34%

On AMD Genoa:

nr_group          base             head          change
 1             17.05±1.92%     16.99±2.81%       +0.35%
 8             16.54±0.71%     16.73±1.18%       -1.15%
16             27.04±0.39%     26.72±2.37%       +1.18%

For nr_group=16 case, configure a cgroup and set quota to half cpu and
then let hackbench run in this cgroup:

                  base             head          change
quota=50%      43.79±1.10%     44.65±0.37%       -1.96%

Netperf/UDP_RR/testlen=30s
(throughput, higher is better)

25% means nr_clients set to 1/4 nr_cpu, 50% means nr_clients is 1/2
nr_cpu, etc.

On Intel EMR:

nr_clients     base                 head             change
  25%       83,567±0.06%         84,298±0.23%        +0.87%
  50%       61,336±1.49%         60,816±0.63%        -0.85%
  75%       40,592±0.97%         40,461±0.14%        -0.32%
 100%       31,277±2.11%         30,948±1.84%        -1.05%

For nr_clients=100% case, configure a cgroup and set quota to half cpu
and then let netperf run in this cgroup:

nr_clients     base                 head             change
 100%       25,532±0.56%         26,772±3.05%        +4.86%

On AMD Genoa:

nr_clients     base                 head             change
 25%        12,443±0.40%         12,525±0.06%        +0.66%
 50%        11,403±0.35%         11,472±0.50%        +0.61%
 75%        10,070±0.19%         10,071±0.95%         0.00%
100%         9,947±0.80%          9,881±0.58%        -0.66%

For nr_clients=100% case, configure a cgroup and set quota to half cpu
and then let netperf run in this cgroup:

nr_clients     base                 head             change
100%         4,954±0.24%          4,952±0.14%         0.00%

> >> > +	if (throttled_hierarchy(cfs_rq) &&
> >> > +	    !task_current_donor(rq_of(cfs_rq), p)) {
> >> > +		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
> >> > +		return true;
> >> > +	}
> >> > +
> >> > +	/* we can't take the fast path, do an actual enqueue*/
> >> > +	p->throttled = false;
> >> 
> >> So we clear p->throttled but not p->throttle_node? Won't that cause issues
> >> when @p's previous cfs_rq gets unthrottled?
> >> 
> >
> > p->throttle_node is already removed from its previous cfs_rq at dequeue
> > time in dequeue_throttled_task().
> >
> > This is done so because in enqueue time, we may not hold its previous
> > rq's lock so can't touch its previous cfs_rq's limbo list, like when
> > dealing with affinity changes.
> >
> 
> Ah right, the DQ/EQ_throttled_task() functions are when DQ/EQ is applied to an
> already-throttled task and it does the right thing.
> 
> Does this mean we want this as enqueue_throttled_task()'s prologue?
> 
>   /* @p should have gone through dequeue_throttled_task() first */
>   WARN_ON_ONCE(!list_empty(&p->throttle_node));
>

Sure, will add it in next version.

> >> > @@ -7145,6 +7142,11 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
> >> >   */
> >> >  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >> >  {
> >> > +	if (unlikely(task_is_throttled(p))) {
> >> > +		dequeue_throttled_task(p, flags);
> >> > +		return true;
> >> > +	}
> >> > +
> >> 
> >> Handling a throttled task's move pattern at dequeue does simplify things,
> >> however that's quite a hot path. I think this wants at the very least a
> >> 
> >>   if (cfs_bandwidth_used())
> >> 
> >> since that has a static key underneath. Some heavy EQ/DQ benchmark wouldn't
> >> hurt, but we can probably find some people who really care about that to
> >> run it for us ;)
> >> 
> >
> > No problem.
> >
> > I'm thinking maybe I can add this cfs_bandwidth_used() in
> > task_is_throttled()? So that other callsites of task_is_throttled() can
> > also get the benefit of paying less cost when cfs bandwidth is not
> > enabled.
> >
> 
> Sounds good to me; just drop the unlikely and let the static key do its
> thing :)

Got it, thanks for the suggestion.

