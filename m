Return-Path: <linux-kernel+bounces-877605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D33C1E8FB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41A8188A9C1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47642FA0EF;
	Thu, 30 Oct 2025 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aKe97EaI"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E071288D0
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761805773; cv=none; b=OKgqVmJh8f0SOFKctiacXcJCHkMx+ZZmyBhEUyEm9xOCcC2dgDXmGEHIsm1hes5imNB0t+Fi1eIJufzlcUbsvrmBksy5VCif2FG0p4KQSPJ7W9TxnCbNUUjJtd7BZsoVr2m9LTQD0fCXEjiz0Z9kQraJMz/ey0mUfT9no971mXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761805773; c=relaxed/simple;
	bh=QeY8oRsFf+zBKsAzSQjuUVo8girw2XosEoALf26olAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ct0kAP04Ocr2BB1VOrEJv4+DQL43tkZrx9WuOsKn91vPbU0yPzgo1+EahS1kR7W4CibXWf4SseX73PdvgxojiPeCTp3NJ09VFy3pVt7jQVIslZkiXyynVAsVXX8tnU76AvTgsX0dBdn16Dbhar44bh2iCrdg7/qf6s0ei4Bo3yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aKe97EaI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TNJ9k0025875;
	Thu, 30 Oct 2025 06:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bKzt1J
	GeJe432FaMpv3O3KT3GPVkoToAnqMqF9aDlJ8=; b=aKe97EaIO80mDxPH+FySpz
	tt3AjgpDZhOrpW4QHNosmRksvJKume2h83OgY8gDc6Zmhi1nt77wM83y8235pS3q
	92oTbZYuo+uS+tu+4UHZol8msiSiFKmH/KHuoq256DsvpQgK88wYvmwYoOQ+OhLh
	DjId/q2jy3zX9jGt4+1JNDQSHrO5YFMJxZyv41nOyYfXI10eiI04rOAKex9PUm2w
	hZQgFsuR7yPJrVHlF9WgTN8L+QIDLMp0M0jgEZt5lvHxTvD9yWg9cckpAloVyINs
	hAuWi73XTFigl4TCFCMf30EQRecCyMKKrAc0Vx6eyXTKNL7unfr/ggxGznH3RxyQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aapqk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 06:29:17 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59U6PqC6023068;
	Thu, 30 Oct 2025 06:29:17 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aapqk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 06:29:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59U63jgs018748;
	Thu, 30 Oct 2025 06:29:16 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xwf5jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 06:29:16 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59U6TFvT2425596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 06:29:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6BE758059;
	Thu, 30 Oct 2025 06:29:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2017F58058;
	Thu, 30 Oct 2025 06:29:11 +0000 (GMT)
Received: from [9.98.110.226] (unknown [9.98.110.226])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Oct 2025 06:29:10 +0000 (GMT)
Message-ID: <be48760d-b705-424e-b6b7-b75205e83567@linux.ibm.com>
Date: Thu, 30 Oct 2025 11:59:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched: reorder some fields in struct rq
To: Blake Jones <blakejones@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20251029185458.3040228-1-blakejones@google.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20251029185458.3040228-1-blakejones@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ALkgKXG8 c=1 sm=1 tr=0 ts=690305bd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=p2StPhpDymKLoomlExIA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: poXPgD6XHVciQysXGnKVlmzZpEmaQo7b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX25RjPZlUCcLl
 QKPvd/KnTheLc8Z6uW5vNQWTJukMfzO80JaOL2JkYoIQ5UBV+onJezrDQFknAJkHO80HgHWZxD1
 k+Fwgz92VbTcvCdSOVS/66y9B27sPVJYS2VMiDH/W/uZqOb3ySgS9YQVgc7o74+yujee1HYvwJw
 RHBW081+yickVMrhVhggeUQV6pAUUBiMDvkRk+UebZ9ctSO+y7/Oni0WJgmqokOWkRh5t49Ute8
 sPQAOxPeJju4muOpJ5URAilT8DIUckJ7RiJfd6pJDTMKKsNE3eTSJhnQ/00t7w5FlxBSe9l81n3
 iIrrHJv+rfSZ1HZ/Ebx1zUHqPaT2YTyTvr6oZxBR4bF4LknJniY96dyAK+CpP2LMLYjEom5mDaE
 BZrD8UCiHKDUvmcZ9xpeg5JYoshbNw==
X-Proofpoint-GUID: XA9CFMcidyrEySjxnUsrXpxRC43HwQdU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

Hi Blake,

On 30/10/25 00:24, Blake Jones wrote:
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

Thanks for the patch.

Quick question about the lock placement: Did you test Peter's suggestion of
co-locating __lock with the clock fields? If so, how did it compare to keeping
them separate?

Thanks,
Madadi Vineeth Reddy

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
> The "__no_randomize_layout" was added to reflect the fact that performance
> of this data structure is unusually sensitive to placement of its members.
> 
> Signed-off-by: Blake Jones <blakejones@google.com>
> Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  kernel/sched/sched.h | 77 +++++++++++++++++++++++++++-----------------
>  1 file changed, 47 insertions(+), 30 deletions(-)
> 
> v3 -> v4 changes:
> - Updated comment, moved "nr_iowait" to the end of the structure, and added
>   "__no_randomize_layout" tag to the structure.
>   Link to v3: https://lore.kernel.org/lkml/20251028080348.2177469-1-blakejones@google.com/T/#u
>   (v3 includes details of previous perf testing)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index e7718f12bc55..e1c3fefb14b7 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1114,28 +1114,50 @@ DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
>   * acquire operations must be ordered by ascending &runqueue.
>   */
>  struct rq {
> -	/* runqueue lock: */
> -	raw_spinlock_t		__lock;
> -
> -	/* Per class runqueue modification mask; bits in class order. */
> -	unsigned int		queue_mask;
> +	/*
> +	 * The following members are loaded together, without holding the
> +	 * rq->lock, in an extremely hot loop in update_sg_lb_stats()
> +	 * (called from pick_next_task()). To reduce cache pollution from
> +	 * this operation, they are placed together on this dedicated cache
> +	 * line. Even though some of them are frequently modified, they are
> +	 * loaded much more frequently than they are stored.
> +	 */
>  	unsigned int		nr_running;
>  #ifdef CONFIG_NUMA_BALANCING
>  	unsigned int		nr_numa_running;
>  	unsigned int		nr_preferred_running;
> -	unsigned int		numa_migrate_on;
>  #endif
> +	unsigned int		ttwu_pending;
> +	unsigned long		cpu_capacity;
> +#ifdef CONFIG_SCHED_PROXY_EXEC
> +	struct task_struct __rcu	*donor;  /* Scheduling context */
> +	struct task_struct __rcu	*curr;   /* Execution context */
> +#else
> +	union {
> +		struct task_struct __rcu *donor; /* Scheduler context */
> +		struct task_struct __rcu *curr;  /* Execution context */
> +	};
> +#endif
> +	struct task_struct	*idle;
> +	/* padding left here deliberately */
> +
> +	/*
> +	 * The next cacheline holds the (hot) runqueue lock, as well as
> +	 * some other less performance-critical fields.
> +	 */
> +	u64			nr_switches	____cacheline_aligned;
> +
> +	/* runqueue lock: */
> +	raw_spinlock_t		__lock;
> +
>  #ifdef CONFIG_NO_HZ_COMMON
> -	unsigned long		last_blocked_load_update_tick;
> -	unsigned int		has_blocked_load;
> -	call_single_data_t	nohz_csd;
>  	unsigned int		nohz_tick_stopped;
>  	atomic_t		nohz_flags;
> +	unsigned int		has_blocked_load;
> +	unsigned long		last_blocked_load_update_tick;
> +	call_single_data_t	nohz_csd;
>  #endif /* CONFIG_NO_HZ_COMMON */
>  
> -	unsigned int		ttwu_pending;
> -	u64			nr_switches;
> -
>  #ifdef CONFIG_UCLAMP_TASK
>  	/* Utilization clamp values based on CPU's RUNNABLE tasks */
>  	struct uclamp_rq	uclamp[UCLAMP_CNT] ____cacheline_aligned;
> @@ -1158,6 +1180,9 @@ struct rq {
>  	struct list_head	*tmp_alone_branch;
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>  
> +#ifdef CONFIG_NUMA_BALANCING
> +	unsigned int		numa_migrate_on;
> +#endif
>  	/*
>  	 * This is part of a global counter where only the total sum
>  	 * over all CPUs matters. A task can increase this counter on
> @@ -1166,36 +1191,31 @@ struct rq {
>  	 */
>  	unsigned long 		nr_uninterruptible;
>  
> -#ifdef CONFIG_SCHED_PROXY_EXEC
> -	struct task_struct __rcu	*donor;  /* Scheduling context */
> -	struct task_struct __rcu	*curr;   /* Execution context */
> -#else
> -	union {
> -		struct task_struct __rcu *donor; /* Scheduler context */
> -		struct task_struct __rcu *curr;  /* Execution context */
> -	};
> -#endif
>  	struct sched_dl_entity	*dl_server;
> -	struct task_struct	*idle;
>  	struct task_struct	*stop;
>  	unsigned long		next_balance;
>  	struct mm_struct	*prev_mm;
>  
> -	unsigned int		clock_update_flags;
> -	u64			clock;
> -	/* Ensure that all clocks are in the same cache line */
> +	/* Per class runqueue modification mask; bits in class order. */
> +	unsigned int		queue_mask;
> +
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
>  #endif
>  
> -	atomic_t		nr_iowait;
> -
>  	u64 last_seen_need_resched_ns;
>  	int ticks_without_resched;
>  
> @@ -1206,8 +1226,6 @@ struct rq {
>  	struct root_domain		*rd;
>  	struct sched_domain __rcu	*sd;
>  
> -	unsigned long		cpu_capacity;
> -
>  	struct balance_callback *balance_callback;
>  
>  	unsigned char		nohz_idle_balance;
> @@ -1317,7 +1335,9 @@ struct rq {
>  	call_single_data_t	cfsb_csd;
>  	struct list_head	cfsb_csd_list;
>  #endif
> -};
> +
> +	atomic_t		nr_iowait;
> +} __no_randomize_layout;
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  


