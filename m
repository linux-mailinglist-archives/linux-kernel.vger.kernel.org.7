Return-Path: <linux-kernel+bounces-797841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF837B4160B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 679427B1F6C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7522D9ECE;
	Wed,  3 Sep 2025 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zs9DcnNG"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A14D2D6624
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756883673; cv=none; b=UXKnOhPFdHatruVEIIo+39PKfFQCk33056vfcUq+MFGVzebQPi6o0Wo6GOif+3bdiIYWjiFSCu0C5HTYTRlTyWS0Twkmt4olJXKdnwazkRsOsJbuRTgtZJ5X4NvjtK3Kw39Wc+81e5Iow479oR7J/+caG4axA+U6gh1hNBL57Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756883673; c=relaxed/simple;
	bh=MtLj3j792MTkREn0ifYlURd1e4cyjoXcWtDfbqVOOu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy7w1VikcdXFBiFjdLn1d1JlQ3sBmrqlehhq20w/YMZZFRpS35Ks3VyY2XWX5Gp/z7iw88xp5MZwc2cELT0/JFEdOMkBcW5VUaIgpJUdfNP0wIlca6L+GVHTBwjk1VKoXj1HO5EVnyOUoILaON9AEhNU/ax7pAWKfxwXM1KofqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Zs9DcnNG; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4cf40cd0d1so4088282a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756883670; x=1757488470; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yy8uUV2KUjZh/6MG0/nrKp90bEarPiScLuck9NFvcrM=;
        b=Zs9DcnNGofm0PMikHUxQXbHhgL1E1Waa6M5I2CQ7q6UVvkDgPgMCGtNEl/q82A+cNI
         ZbKBTAGaX3tKPwcZAQ6Qy5DqWdefpB2nVJrERzB5McUVY8KBxe+Ci808EPgtG3KDXmFy
         wA8tYpcTGqex9l1bO4N3TvZPv2mZd8/FSyW9c6mQ0JwYpt0Hdhh6GLgbpfptWoI50v2i
         Oa5bDNWJPDe62kMmMUV3uehF7XTrR45cZwBrL6mIFxNPXRp2GlHYMgh/knX9BFdK57U8
         GDMQbdN3daJ3zmQcyvf2rSfc5TglY6dV5Pm6CfUyNrKOJMw8kKGtEQ0U2+tPq+hh6N26
         XXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756883670; x=1757488470;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yy8uUV2KUjZh/6MG0/nrKp90bEarPiScLuck9NFvcrM=;
        b=P+XVgPGIRNjHgutl66Ry86cqTOoutz5v/W2ccnAztDknpFfG4H7O4g4oyw5Xr0GRsU
         rZranOFx4+C4BD9B41bol4iHRP4860Zrkpv41ILNlpWQk74Lf7I2cmhudjTfYzf53GBY
         rttHkgSxDdJr+1ynMEYAM6v8cBue8ml78jKAvXP7+kBtN3q3f27ZCaIAUfUZRwdYkX0/
         IHhpM1xvO42q2d4uuCuh6NLfsoQddI2h0hAPSb0b9irHHmk7wJVhYi8vrEiT81tr/w+E
         IXKJ/HEElhnm97eUSDkeyTe1lfTn86Odx6X7ZtqlnUsGuvnrSB6GtclOqRWL2wPVulvx
         wKOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdmpBw1lF5kQdSTPOpk8uPVjCGv331z/LWO/TUPwUql/6G/asyJPfxB5m3SCMYvs8FprdWrlL083kTgVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDjZy3osCHS2VGySN1gnRFahgfY/3l8XETbt8TeNkxoOT2WmYk
	Qom3QcH2MpPdQ8CV1JlOUvC+r5+J63MiWspKSgupuvQ7faKcGio+vnE6QJbewf5duA==
X-Gm-Gg: ASbGncvvch6Adx7CQjkGj1666zK6PoCOh+48yFEgc4aylTW6XQPk4BX2YIZ/44ScPHK
	NigldSHpoo/C8++w8jrlFm3iYKVLDRzbrcBlFINpW/5D03b/SRBsPklU72pRk6r86wAYnV6ij4H
	DnEiQ42orzKF++ISxyBOAH9oWgd6imA0P3Dz9krCpaY4UIeXtOzwaCkNYuKeJAQjFvMEd/LK1jB
	eO7V0HPfAj6x+qj27PfZNo1vrtEUnxqztCDV/nLJG1MpQ4dVlDaz03tHscSxAvqEuQ39GJijiPO
	v3yHv9Cu//eQqBPagpplRLGAClzw8uYb70PfDxd6A7Nz4/VthElTu4AQRol6K2ZgdNlbENnRW6C
	OY8SI+Ro6u319DQxM7ipDwsp2rZvRKUhC+ciw03UbDmdZKuetyA==
X-Google-Smtp-Source: AGHT+IEyu+LL9PIjrMV2Sc0pvuCqgV31zattkOVodjSiVZm8Diq0bPOdRtvg1M96rDMtGOgDuQZdVw==
X-Received: by 2002:a17:903:290:b0:248:70b9:c0df with SMTP id d9443c01a7336-24944a1204emr195459055ad.27.1756883670156;
        Wed, 03 Sep 2025 00:14:30 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ca1c492afsm4984825ad.31.2025.09.03.00.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:14:29 -0700 (PDT)
Date: Wed, 3 Sep 2025 15:14:10 +0800
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
	Songtang Liu <liusongtang@bytedance.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v3 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250903071410.GA42@bytedance>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-4-ziqianlu@bytedance.com>
 <xhsmhv7myp46n.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250808101330.GA75@bytedance>
 <xhsmhsei2ox4o.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250812084828.GA52@bytedance>
 <xhsmhh5y9j3ut.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <20250815092910.GA33@bytedance>
 <20250822110701.GB289@bytedance>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822110701.GB289@bytedance>

On Fri, Aug 22, 2025 at 07:07:01PM +0800, Aaron Lu wrote:
> On Fri, Aug 15, 2025 at 05:30:08PM +0800, Aaron Lu wrote:
> > On Thu, Aug 14, 2025 at 05:54:34PM +0200, Valentin Schneider wrote:
> ... ...
> > > I would also suggest running similar benchmarks but with deeper
> > > hierarchies, to get an idea of how much worse unthrottle_cfs_rq() can get
> > > when tg_unthrottle_up() goes up a bigger tree.
> > 
> > No problem.
> > 
> > I suppose I can reuse the previous shared test script:
> > https://lore.kernel.org/lkml/CANCG0GdOwS7WO0k5Fb+hMd8R-4J_exPTt2aS3-0fAMUC5pVD8g@mail.gmail.com/
> > 
> > There I used:
> > nr_level1=2
> > nr_level2=100
> > nr_level3=10
> > 
> > But I can tweak these numbers for this performance evaluation. I can make
> > the leaf level to be 5 level deep and place tasks in leaf level cgroups
> > and configure quota on 1st level cgroups.
> 
> Tested on Intel EMR(2 sockets, 120cores, 240cpus) and AMD Genoa(2
> sockets, 192cores, 384cpus), with turbo/boost disabled, cpufreq set to
> performance and cpuidle states all disabled.
> 
> cgroup hierarchy:
> nr_level1=2
> nr_level2=2
> nr_level3=2
> nr_level4=5
> nr_level5=5
> i.e. two cgroups in the root level, with each level1 cgroup having 2
> child cgroups, and each level2 cgroup having 2 child cgroups, etc. This
> creates a 5 level deep, 200 leaf cgroups setup. Tasks are placed in leaf
> cgroups. Quota are set on the two level1 cgroups.
> 
> The TLDR is, when there is a very large number of tasks(like 8000 tasks),
> task based throttle saw 10-20% performance drop on AMD Genoa; otherwise,
> no obvious performance change is observed. Detailed test results below.
> 
> Netperf: measured in throughput, more is better
> - quota set to 50 cpu for each level1 cgroup;
> - each leaf cgroup run a pair of netserver and netperf with following
>   cmdline:
>   netserver -p $port_for_this_cgroup
>   netperf -p $port_for_this_cgroup -H 127.0.0.1 -t UDP_RR -c -C -l 30
>   i.e. each cgroup has 2 tasks, total task number is 2 * 200 = 400
>   tasks.
> 
> On Intel EMR:
>               base            head         diff
> throughput    33305±8.40%     33995±7.84%  noise
> 
> On AMD Genoa:
>               base            head         diff
> throughput    5013±1.16%      4967±1.82    noise
> 
> 
> Hackbench, measured in seconds, less is better:
> - quota set to 50cpu for each level1 cgroup;
> - each cgroup runs with the following cmdline:
>   hackbench -p -g 1 -l $see_below
> i.e. each leaf cgroup has 20 sender tasks and 20 receiver tasks, total
> task number is 40 * 200 = 8000 tasks.
> 
> On Intel EMR(loops set to 100000):
> 
>          base             head              diff
> Time     85.45±3.98%      86.41±3.98%       noise
> 
> On AMD Genoa(loops set to 20000):
> 
>          base             head              diff
> Time     104±4.33%        116±7.71%        -11.54%
> 
> So for this test case, task based throttle suffered ~10% performance
> drop. I also tested on another AMD Genoa(same cpu spec) to make sure
> it's not a machine problem and performance dropped there too:
> 
> On 2nd AMD Genoa(loops set to 50000)
> 
>         base             head               diff
> Time    81±3.13%         101±7.05%         -24.69%
> 
> According to perf, __schedule() in head takes 7.29% cycles while in base
> it takes 4.61% cycles. I suppose with task based throttle, __schedule()
> is more frequent since tasks in a throttled cfs_rq have to be dequeued
> one by one while in current behaviour, the cfs_rq can be dequeued off rq
> in one go. This is most obvious when there are multiple tasks in a single
> cfs_rq; if there is only 1 task per cfs_rq, things should be roughly the
> same for the two throttling model.
> 
> With this said, I reduced the task number and retested on this 2nd AMD
> Genoa:
> - quota set to 50 cpu for each level1 cgroup;
> - using only 1 fd pair, i.e. 2 task for each cgroup:
>   hackbench -p -g 1 -f 1 -l 50000000
>   i.e. each leaf cgroup has 1 sender task and 1 receiver task, total
>   task number is 2 * 200 = 400 tasks.
> 
>         base             head               diff
> Time    127.77±2.60%     127.49±2.63%       noise
> 
> In this setup, performance is about the same.
> 
> Now I'm wondering why on Intel EMR, running that extreme setup(8000
> tasks), performance of task based throttle didn't see noticeable drop...

Looks like hackbench doesn't like task migration on this AMD system
(domain0 SMT; domain1 MC; domain2 PKG; domain3 NUMA).

If I revert patch5, running this 40 * 200 = 8000 hackbench workload
again, performance is roughly the same now(head~1 is slightly worse but
given the 4+% stddev in base, it can be considered in noise range):

         base              head~1(patch1-4)    diff     head(patch1-5)
Time     82.55±4.82%       84.45±2.70%         -2.3%    99.69±6.71%

According to /proc/schedstat, the lb_gained for domain2 is:

         NOT_IDLE IDLE  NEWLY_IDLE
base        0     8052    81791    
head~1      0     7197   175096
head        1    14818   793065

Other domains have similar number: base has smallest migration number
while head has the most and head~1 reduce the number a lot. I suppose
this is expected, because we removed the throttled_lb_pair() restriction
in patch5 and that can cause runnable tasks in throttled hierarchy to be
balanced to other cpus while in base, this can not happen.

I think patch5 still makes sense and is correct, it's just this specific
workload doesn't like task migrations. Intel EMR doesn't suffer from
this, I suppose that's because EMR has a much larger LLC while AMD Genoa
has a relatively small LLC and task migrations across LLC boundary hurts
hackbench's performance.

I also tried to apply below hack to prove this "task migration across
LLC boundary hurts hackbench" theory on both base and head:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c2..34c5f6b75e53d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9297,6 +9297,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
 		return 0;
 
+	if (!(env->sd->flags & SD_SHARE_LLC))
+		return 0;
+
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
 
With this diff applied, the result is:


         base'              head'              diff
Time     74.78±8.2%         78.87±15.4%        -5.47%

base': base + above diff
head': head + above diff

So both performs better now, but with much larger variance, I guess
that's because no load balance on domain2 and above now. head' is still
worse than base, but not as much as before.

To conclude this: hackbench doesn't like task migration, especially when
task is migrated across LLC boundary. patch5 removed the restriction of
no balancing throttled tasks, this caused more balance to happen and
hackbench doesn't like this. But balancing has its own merit and could
still benefit other workloads so I think patch5 should stay, especially
considering that when throttled tasks are eventually dequeued, they will
not stay on rq's cfs_tasks list so no need to take special care for them
when doing load balance.

On a side note: should we increase the cost of balancing tasks out of LLC
boundary? I tried to enlarge sysctl_sched_migration_cost 100 times for
domains without SD_SHARE_LLC in task_hot() but that didn't help.

