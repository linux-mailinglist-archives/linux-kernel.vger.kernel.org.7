Return-Path: <linux-kernel+bounces-798261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD05FB41B6B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946C217720B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF31835957;
	Wed,  3 Sep 2025 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Vz3Yi+Jg"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945C42EA154
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894275; cv=none; b=MaLT5gXxPxMCtQtNx4mzN3FfgSNYag87yw10miuZIGAsAkiHceep6a307jMA4A70UzUDCHpZcFoWPxv0YRAN/0OUs54j2g7YCPrl0j7Hl+a7622rHoGs+PRaIM31RWGFC7RuJtuDOPwyHQyXz3kYqDODaxSz64rDBfil466466M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894275; c=relaxed/simple;
	bh=4Lx2giHwG6Mu/e9LWO1sDlxmxYMvtP0SNlKyvK7YVfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LANgEcf09XEFfozU3Sh8KzFsJ+0sVDyGSku+3JmUiRHHtOGdsiIeC3JRWUlGA5+dS7tQBVirJjOVJWWxcTqsjyO15c4zF5f25cIRyWDZX3A0AVezLW8S2pcoEYB1kPNgOChEiob9LXeIwMPq0e9KLHEWpq9QTFmSoohpsEYNKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Vz3Yi+Jg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-772481b2329so4068111b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756894273; x=1757499073; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W4jQfJVzSv1Nd2oLvd8fbn2hTUNd8qg98uQz9A7X4Hg=;
        b=Vz3Yi+JgKPoey6lzPCXIqqv5wU8iYR7GyNZ96PC6b+tQxipO6kDBUyHKFUfnzwdXDW
         QqBIutAjI0MVcvhaD3oa6jtN5+LLnniovS3pxkDBXBWV7gZE65z2am97sSQJs8oIo3Ag
         fA2f1PwoKJZZzFGHgbgdt7iBpRkApSgPL+lhStiZSOO4wtaGQZi9ofCUbpPdPPq6O0v0
         L5h/BR9rT+MnA8Dl48lSOpJTUW2qg/ZJ565wQoLUhegWPunRJvliyksRO4d/bty3pipE
         bidx1MnBMLPBTAsQpL5gGj44tjU1+IwoePQUg+hCI5V8UQztpEdw8AEFwQFrlUz8KMrE
         AhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756894273; x=1757499073;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W4jQfJVzSv1Nd2oLvd8fbn2hTUNd8qg98uQz9A7X4Hg=;
        b=A/3bMvtmJR5ATYRSzV0jBiVKw/6FIhk21QuN2Fk7nylyoQDBmjggR9NEvb0FL+7WS8
         HCpx7pCWdQG6hv0J+cgrEWBdsGuM6uQMSart+rrtlM+izr0QjJSHOGFfTrII251/X8p+
         Xc3dfG+hI4pB1m3T8T83F09w1VfiJxjXLkN8i3ru45HRyf0hAdYK5kCuUYY5n0NPxri/
         qGqWVqPKtE2T8uiHVljqPLyudUwPUKvO5FMIIrMu84FID5VTV+oiblTHvF61wzAGQTiO
         5eSF+396jSjWaNWgqd7OwSB7FE7CDF/O0R9ji7gCbnLe9DvBGKcgwZoWaWF0FyDHkWsh
         zbvw==
X-Forwarded-Encrypted: i=1; AJvYcCURsZcdpE+YqgAQ7fkv7kZNK8yPXxd2BQP9ejGeqp289ER6VFk8YARpCJYoqOpkQ6xFR7DkmkuEL0jLBY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ6b2y7ReDnordcUI8BgLC5CZ3kZCM6JvmO2uRVIFGaF0Po/G5
	Xs9cWWkJKfhlTeIvMW87/NnXeotEtpefEAMulHeXMz1241EAxaDQjBpaBTSzYOiqcg==
X-Gm-Gg: ASbGnct+9xn2QaI1onYd4THKBlwUGkfRsT/MVvPmnHxqf4NDUcFe/SqsaO8EW+NnbpO
	kOH7gvkosVdO6M4GGS2n2vjhRnVxkEh8hTU5TGs9vLXqXlVcaoji9gvxB2BdvaEVPU+eMvwYuTq
	HU4VhKGsL2nH9xrvdIrK+toJQu6caO6jAKQexwi8UvoKDNfUMd+VjVcTXsqpgPzoI5raxRMfw9Y
	50VybZ22N+2yxGgF2u+zW/F403nWHwzgfzNkWjBK/TZM8eYMEQ5uSBJh79O3oejFGsDPEAPJoFm
	qzIxeWA1pl+9qFILyjw1UxNFhLbM2qOJ8z0h3rFsaIkq6tOaAPLGdSmMeRlTXqofDZb8QTcNPAL
	/UpAzA6k6Jn1xqTv/KQQuBzNFZpuKH0HcddHSpqzk8yEGQfmcuXnQG5HdpNQl
X-Google-Smtp-Source: AGHT+IGxiZRyoEGYCRGGWHigdvjT4CPP6boJhIsnwQaS9ltoV3DHAWcM8lYnKekrTO81gQm/7Z5/+A==
X-Received: by 2002:a05:6a00:460e:b0:772:fc2:be71 with SMTP id d2e1a72fcca58-7723e338532mr17781687b3a.20.1756894272640;
        Wed, 03 Sep 2025 03:11:12 -0700 (PDT)
Received: from bytedance ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2d97acsm16125948b3a.41.2025.09.03.03.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 03:11:12 -0700 (PDT)
Date: Wed, 3 Sep 2025 18:11:02 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
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
	Songtang Liu <liusongtang@bytedance.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250903101102.GB42@bytedance>
References: <20250715071658.267-4-ziqianlu@bytedance.com>
 <xhsmhv7myp46n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250808101330.GA75@bytedance>
 <xhsmhsei2ox4o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250812084828.GA52@bytedance>
 <xhsmhh5y9j3ut.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250815092910.GA33@bytedance>
 <20250822110701.GB289@bytedance>
 <20250903071410.GA42@bytedance>
 <2b2e91e7-0514-4728-a3a3-96282a0d4286@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b2e91e7-0514-4728-a3a3-96282a0d4286@amd.com>

Hi Prateek,

On Wed, Sep 03, 2025 at 02:41:55PM +0530, K Prateek Nayak wrote:
> Hello Aaron,
> 
> On 9/3/2025 12:44 PM, Aaron Lu wrote:
> > On Fri, Aug 22, 2025 at 07:07:01PM +0800, Aaron Lu wrote:
> >> With this said, I reduced the task number and retested on this 2nd AMD
> >> Genoa:
> >> - quota set to 50 cpu for each level1 cgroup;
> 
> What exactly is the quota and period when you say 50cpu?

period is the default 100000 and quota is set to 5000000.

> 
> >> - using only 1 fd pair, i.e. 2 task for each cgroup:
> >>   hackbench -p -g 1 -f 1 -l 50000000
> >>   i.e. each leaf cgroup has 1 sender task and 1 receiver task, total
> >>   task number is 2 * 200 = 400 tasks.
> >>
> >>         base             head               diff
> >> Time    127.77±2.60%     127.49±2.63%       noise
> >>
> >> In this setup, performance is about the same.
> >>
> >> Now I'm wondering why on Intel EMR, running that extreme setup(8000
> >> tasks), performance of task based throttle didn't see noticeable drop...
> > 
> > Looks like hackbench doesn't like task migration on this AMD system
> > (domain0 SMT; domain1 MC; domain2 PKG; domain3 NUMA).
> > 
> > If I revert patch5, running this 40 * 200 = 8000 hackbench workload
> > again, performance is roughly the same now(head~1 is slightly worse but
> > given the 4+% stddev in base, it can be considered in noise range):
> > 
> >          base              head~1(patch1-4)    diff     head(patch1-5)
> > Time     82.55±4.82%       84.45±2.70%         -2.3%    99.69±6.71%
> > 
> > According to /proc/schedstat, the lb_gained for domain2 is:
> > 
> >          NOT_IDLE IDLE  NEWLY_IDLE
> > base        0     8052    81791    
> > head~1      0     7197   175096
> > head        1    14818   793065
> 
> Since these are mostly idle and newidle balance, I wonder if we can run
> into a scenario where,
> 
> 1. All the tasks are throttled.
> 2. CPU turning idle does a newidle balance.
> 3. CPU pulls a tasks from throttled hierarchy and selects it.
> 4. The task exits to user space and is dequeued.
> 5. Goto 1.
> 
> and when the CPU is unthrottled, it has a large number of tasks on it
> that'll again require a load balance to even stuff out.
> 

I think it is because we allow balancing tasks under a throttled
hirarchy that made the balance number much larger.

> > 
> > Other domains have similar number: base has smallest migration number
> > while head has the most and head~1 reduce the number a lot. I suppose
> > this is expected, because we removed the throttled_lb_pair() restriction
> > in patch5 and that can cause runnable tasks in throttled hierarchy to be
> > balanced to other cpus while in base, this can not happen.
> > 
> > I think patch5 still makes sense and is correct, it's just this specific
> > workload doesn't like task migrations. Intel EMR doesn't suffer from
> > this, I suppose that's because EMR has a much larger LLC while AMD Genoa
> > has a relatively small LLC and task migrations across LLC boundary hurts
> > hackbench's performance.
> 
> I think we can leave the throttled_lb_pair() condition as is and revisit
> it later if this is visible in real world workloads. I cannot think of
> any easy way to avoid the case for potential pileup without accounting
> for the throttled tasks in limbo except for something like below at
> head~1:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bdc9bfa0b9ef..3dc807af21ba 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9385,7 +9385,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	/*
>  	 * We do not migrate tasks that are:
>  	 * 1) delayed dequeued unless we migrate load, or
> -	 * 2) throttled_lb_pair, or
> +	 * 2) throttled_lb_pair unless we migrate load, or
>  	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
>  	 * 4) running (obviously), or
>  	 * 5) are cache-hot on their current CPU, or
> @@ -9394,7 +9394,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>  	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
>  		return 0;
>  
> -	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
> +	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu) &&
> +	    env->migration_type != migrate_load)
>  		return 0;
>  
>  	/*
> ---
> 
> Since load_avg moves slowly, it might be enough to avoid pileup of
> tasks. This is similar to the condition for migrating delayed tasks
> above but unlike the hierarchies of delayed tasks, the weight of
> throttled hierarchy does change when throttled tasks are transitioned to
> limbo so this needs some more staring at.
>

I was thinking: should we not allow task balancing to a throttled target
cfs_rq? For task based throttle model, if a task is on rq's cfs_tasks
list, it is allowed to run so we should not check src cfs_rq's throttle
status but we should check if the target cfs_rq is throttled and if it is,
then it's probably not very useful to do the balance. I tried below diff
and the performance is restored:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df8dc389af8e1..3e927b9b7eeb6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9370,6 +9370,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
 		return 0;
 
+	if (throttled_hierarchy(task_group(p)->cfs_rq[env->dst_cpu]))
+		return 0;
+
 	/*
 	 * We want to prioritize the migration of eligible tasks.
 	 * For ineligible tasks we soft-limit them and only allow

         base              head'               diff     head(patch1-5)
Time     82.55±4.82%       83.81±2.89%         -1.5%    99.69±6.71%

head': head + above diff

I also tested netperf on this AMD system as well as hackbench and
netperf on Intel EMR, no obvious performance difference observed
after applying the above diff, i.e. base and head' performance is
roughly the same.

Does the above diff make sense? One thing I'm slightly concerned is,
there may be one case when balancing a task to a throttled target
cfs_rq makes sense: if the task holds some kernel resource and is
running inside kernel, even its target cfs_rq is throttled, we still
want this task to go there and finish its job in kernel mode sooner,
this could help other resource waiters. But, this may not be a big deal
and in most of the time, balancing a task to a throttled cfs_rq doesn't
look like a meaningful thing to do.

Best regards,
Aaron

