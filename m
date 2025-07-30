Return-Path: <linux-kernel+bounces-750241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94349B15900
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57DD18A3D78
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9391EF36C;
	Wed, 30 Jul 2025 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cwJtshD+"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62831E47AE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753857458; cv=none; b=RPtXYlsLP7SB/a8tgqdCVf8PIT77gH8xr+B5zHONItMTDSBjfNySQJsJ/lj9027Pqf7xqxSkYvnj7q1A1cs1KUafvhsp2lLoqiun2ZINw59t1YYoVwSZSGeU7XO+hYzpWMISwUc+o1fdi5u2uFOL+TE4v62mhgR//JiWZb6czWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753857458; c=relaxed/simple;
	bh=MFe821af3BiCponl8PmL0aVtbRSoTdv51DmhkZkJb40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bmdv1H09S5TJfBCKIHwIlXfSSa2W9Hg4D7LHEFk0K9nXksvHYCc6LYZTAF9cwTxlVMR+3VDlcHmml6BKMcu0Y4KxBUWkssDhWBUNX6uJaAlO3YMwiLsb49BL6EbdDc3QFc6OLotSEqFbnDRadyJCkdNkVrVh6VNz00zEBENGIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cwJtshD+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U6OiCt002283;
	Wed, 30 Jul 2025 06:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tJXK/G
	CvecG8d9RO8nMevv0FdgRBJ0Y6uuLRU0bmHG0=; b=cwJtshD+OqWAOdvuwTaeAq
	WUkA3/Qmui6fWa0o0ZzsMScHar+Tl1PjSyeBOAzj+yPm51Pv3nKV9MbBCcO+29dC
	/X3Ljt8YDBKrLVL4SG8ghTbqXFmliKHzvbkpkYAjBJmevV8EgRweE4RF9f6jFoGx
	o4+XzbROhoPoR83qcZOvoF/UyFvU3WAOI1GjAXbDjiLICo5qaA2C5z57w6LvDm8E
	10qiYnbp9CzKdJ5MiwDFja4x03vDczSh+a+ABNqi8muLwWNWdEKpli0rNEXXDgtH
	1Pt7ko1kER2v+YFH+ougT/cjBxh8F5g9acGT+HtOgZHhhqqDULxkOqaIAQjMLD+w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hs4pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 06:35:59 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56U6Q0Jw029733;
	Wed, 30 Jul 2025 06:35:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hs4pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 06:35:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56U1tl3g018665;
	Wed, 30 Jul 2025 06:35:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 485abp66mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 06:35:57 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56U6ZuM731720056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 06:35:56 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17DBC58054;
	Wed, 30 Jul 2025 06:35:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E0A45804E;
	Wed, 30 Jul 2025 06:35:51 +0000 (GMT)
Received: from [9.204.207.125] (unknown [9.204.207.125])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Jul 2025 06:35:51 +0000 (GMT)
Message-ID: <172e48ee-7d90-4704-ad29-476fa7ee0aab@linux.ibm.com>
Date: Wed, 30 Jul 2025 12:05:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Reorder some fields in struct rq.
To: Blake Jones <blakejones@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250722201339.1198239-1-blakejones@google.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250722201339.1198239-1-blakejones@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uXDAMIUrJbYCCFK1n70_BKyG-wmchDlu
X-Authority-Analysis: v=2.4 cv=Mbtsu4/f c=1 sm=1 tr=0 ts=6889bd4f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=1XWaLZrsAAAA:8 a=p2StPhpDymKLoomlExIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DQx7YFVsqzvPU-_l5qgo3J7weMua7SfK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA0MiBTYWx0ZWRfX54tnGuAg+U18
 Z66+Y6IayDmGddhN5xMC8v9J21s25vgsjDT1cs1KyObiVWUYI+New1q8JlcK/L7YYT5wcmLijxu
 QyspTtIlmn6UE0kL2nuB1Lv9M2e0Vp4HpE82KYP2Zp3YzE0KkpCCDEG7vIyeqGZRoQLYUnydPZy
 I8l4W+4zNHPUd/a7F3/FpiPpn8AhLhQgj478BjtTL2fU7Q/9Jp5Zbkd1ejEHulbeKiIBy3zByeT
 fRn7DIwiSswaBN7F7I3OOPoBn1fRDujmbL6hHxAY6UQHpsey02uCmsAmtUCmrcGAYAEgK39C3j0
 dQv1v/MObha4MbiWwHe+Inkbu8UyuR+8KO6m20eImsNKKO+/BQOqhJpIwJQFgCmmPZLhbXr1nRS
 hbOdlwDCoXQtlNBnJ6FR4oOk4myQ1Cvr7rScp8IDfQCyi7uTcKsEeaDM3KUvnfDIC1pWgibc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300042

Hi Blake,

On 23/07/25 01:43, Blake Jones wrote:
> This colocates some hot fields in "struct rq" to be on the same cache line
> as others that are often accessed at the same time or in similar ways.
> 
> Using data from a Google-internal fleet-scale profiler, I found three
> distinct groups of hot fields in struct rq:
> 
> - (1) The runqueue lock: __lock.
> 
> - (2) Those accessed from hot code in pick_next_task_fair():
>       nr_running, nr_numa_running, nr_preferred_running,
>       ttwu_pending, cpu_capacity, curr, idle.
> 
> - (3) Those accessed from some other hot codepaths, e.g.
>       update_curr(), update_rq_clock(), and scheduler_tick():
>       clock_task, clock_pelt, clock, lost_idle_time,
>       clock_update_flags, clock_pelt_idle, clock_idle.
> 
> The cycles spent on accessing these different groups of fields broke down
> roughly as follows:
> 
> - 50% on group (1) (the runqueue lock, always read-write)
> - 39% on group (2) (load:store ratio around 38:1)
> -  8% on group (3) (load:store ratio around 5:1)
> -  3% on all the other fields
> 
> Most of the fields in group (3) are already in a cache line grouping; this
> patch just adds "clock" and "clock_update_flags" to that group. The fields
> in group (2) are scattered across several cache lines; the main effect of
> this patch is to group them together, on a single line at the beginning of
> the structure. A few other less performance-critical fields (nr_switches,
> numa_migrate_on, has_blocked_load, nohz_csd, last_blocked_load_update_tick)
> were also reordered to reduce holes in the data structure.
> 
> Since the runqueue lock is acquired from so many different contexts, and is
> basically always accessed using an atomic operation, putting it on either
> of the cache lines for groups (2) or (3) would slow down accesses to those
> fields dramatically, since those groups are read-mostly accesses.
> 
> This patch does not change the size of "struct rq" on machines with 64-byte
> cache lines. The additional "____cacheline_aligned" to put the runqueue
> lock on the next cache line will add an additional 64 bytes of padding on
> machines with 128-byte cache lines; although this is unfortunate, it seemed
> more likely to lead to stably good performance than e.g. by just putting
> the runqueue lock somewhere in the middle of the structure and hoping it
> wasn't on an otherwise busy cache line.
> 
> I ran "hackbench" to test this change, but it didn't show very conclusive
> results.  Looking at a profile of the hackbench run, it was spending 95% of
> its cycles inside __alloc_skb(), __kfree_skb(), or kmem_cache_free() -
> almost all of which was spent updating memcg counters or contending on the
> list_lock in kmem_cache_node. In contrast, it spent less than 0.5% of its
> cycles inside either schedule() or try_to_wake_up(). So it's not surprising
> that it didn't show useful results here.
> 
> Instead, to test this, I wrote a focused load test that would put load on
> the pick_next_task_fair() path. A parent process would fork many child
> processes, and each child would nanosleep() for 1 msec many times in a
> loop. The load test was monitored with "perf", and I looked at the amount
> of cycles that were spent with sched_balance_rq() on the stack. The test
> reliably showed 15-25% of all cycles were spent there. I ran it 80 times on
> a pair of 2-socket Intel GNR machines (480 vCPUs per machine) - one running
> 6.16-rc7, the other running this change - using 4800 child processes and
> 8000 1-msec sleeps per child.  The mean cycle count dropped from 405.4B to
> 387.6B, or a 4.4% decrease.

Thanks for your patch.

Could you please share the test you mentioned? I would like to try it on a
Power11 system.

Also, I noticed the patch doesn't apply cleanly on the latest tip/sched/core,
since the CONFIG_SMP ifdefs have been removed. Could you rebase it on the current
tip/sched/core tree?

Thanks,
Madadi Vineeth Reddy

> 
> More importantly, given that this change reduces cache misses in a very hot
> kernel codepath, there's likely to be additional application performance
> improvement due to reduced cache conflicts from kernel data structures.
> 
> Signed-off-by: Blake Jones <blakejones@google.com>
> ---
>  kernel/sched/sched.h | 59 +++++++++++++++++++++++++++-----------------
>  1 file changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 83e3aa9171429..b21be28823609 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1097,30 +1097,45 @@ DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
>   * acquire operations must be ordered by ascending &runqueue.
>   */
>  struct rq {
> -	/* runqueue lock: */
> -	raw_spinlock_t		__lock;
> -
> +	/*
> +	 * The following members are loaded together from pick_next_task(),
> +	 * and should be on an isolated cache line to avoid cache pollution.
> +	 */
>  	unsigned int		nr_running;
>  #ifdef CONFIG_NUMA_BALANCING
>  	unsigned int		nr_numa_running;
>  	unsigned int		nr_preferred_running;
> -	unsigned int		numa_migrate_on;
>  #endif
> +#ifdef CONFIG_SMP
> +	unsigned int		ttwu_pending;
> +	unsigned long		cpu_capacity;
> +#endif
> +	union {
> +		struct task_struct __rcu *donor; /* Scheduler context */
> +		struct task_struct __rcu *curr;  /* Execution context */
> +	};
> +	struct task_struct	*idle;
> +	/* padding left here deliberately */
> +
> +	/*
> +	 * The next cacheline holds the runqueue lock, as well as some
> +	 * other less performance-critical fields.
> +	 */
> +	u64			nr_switches	____cacheline_aligned;
> +
> +	/* runqueue lock: */
> +	raw_spinlock_t		__lock;
> +
>  #ifdef CONFIG_NO_HZ_COMMON
> +	unsigned int		nohz_tick_stopped;
> +	atomic_t		nohz_flags;
>  #ifdef CONFIG_SMP
> -	unsigned long		last_blocked_load_update_tick;
>  	unsigned int		has_blocked_load;
> +	unsigned long		last_blocked_load_update_tick;
>  	call_single_data_t	nohz_csd;
>  #endif /* CONFIG_SMP */
> -	unsigned int		nohz_tick_stopped;
> -	atomic_t		nohz_flags;
>  #endif /* CONFIG_NO_HZ_COMMON */
>  
> -#ifdef CONFIG_SMP
> -	unsigned int		ttwu_pending;
> -#endif
> -	u64			nr_switches;
> -
>  #ifdef CONFIG_UCLAMP_TASK
>  	/* Utilization clamp values based on CPU's RUNNABLE tasks */
>  	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
> @@ -1143,6 +1158,9 @@ struct rq {
>  	struct list_head	*tmp_alone_branch;
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>  
> +#ifdef CONFIG_NUMA_BALANCING
> +	unsigned int		numa_migrate_on;
> +#endif
>  	/*
>  	 * This is part of a global counter where only the total sum
>  	 * over all CPUs matters. A task can increase this counter on
> @@ -1151,24 +1169,23 @@ struct rq {
>  	 */
>  	unsigned long 		nr_uninterruptible;
>  
> -	union {
> -		struct task_struct __rcu *donor; /* Scheduler context */
> -		struct task_struct __rcu *curr;  /* Execution context */
> -	};
>  	struct sched_dl_entity	*dl_server;
> -	struct task_struct	*idle;
>  	struct task_struct	*stop;
>  	unsigned long		next_balance;
>  	struct mm_struct	*prev_mm;
>  
> -	unsigned int		clock_update_flags;
> -	u64			clock;
> -	/* Ensure that all clocks are in the same cache line */
> +	/*
> +	 * The following fields of clock data are frequently referenced
> +	 * and updated together, and should go on their own cache line.
> +	 */
>  	u64			clock_task ____cacheline_aligned;
>  	u64			clock_pelt;
> +	u64			clock;
>  	unsigned long		lost_idle_time;
> +	unsigned int		clock_update_flags;
>  	u64			clock_pelt_idle;
>  	u64			clock_idle;
> +
>  #ifndef CONFIG_64BIT
>  	u64			clock_pelt_idle_copy;
>  	u64			clock_idle_copy;
> @@ -1187,8 +1204,6 @@ struct rq {
>  	struct root_domain		*rd;
>  	struct sched_domain __rcu	*sd;
>  
> -	unsigned long		cpu_capacity;
> -
>  	struct balance_callback *balance_callback;
>  
>  	unsigned char		nohz_idle_balance;


