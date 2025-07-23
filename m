Return-Path: <linux-kernel+bounces-741880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE488B0EA26
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1361AA189A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 05:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832DC2475C7;
	Wed, 23 Jul 2025 05:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DJMpm+qn"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FDEF9E8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 05:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753249387; cv=none; b=Z6Qm7aCYuU92vYD+IZX93/4cibIOTXn7E9Il2KTIzf+VFpy5csPrmUqfUHclZic7RpOXt2tILuu5CfkCHyngyemtcjvRghFqveVebmxxohPMS8ZpbhvvRhSK7Set1Ow05VbTbUkB2hRnKS48g4D+AOhVAtAP8/nmZjQ3QGNznbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753249387; c=relaxed/simple;
	bh=N+mX/wzmYc2IU3vv6xkWCos+r/uEHYMs3KHIAkqT23A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHWCfr6RCn/u5j+D9zwC5i3E4aTzKU3DxZJyidUalpDGWojx5+mQk3LF+xWlZrAUCaCl+7OniL8Wa4EyG25diQDmD0fIS6CBPWmk7CjF6pIiYlGEixr7+xLp6gFTs60b+CLvwtk9olQ1r9I3YTQmPMszdrX1K28/DgqpqAMaPZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DJMpm+qn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MHsdcE027701;
	Wed, 23 Jul 2025 05:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LfT6S9
	128LNqHPn8W77Qhd2sTTBDkH5i/T3NaVkeZ3k=; b=DJMpm+qnDXUf/iQULACRck
	x4wyFbrekBt2TQNScHEr2tTkclzTp1CYF2Rls9dfdzZpQVYZkL1gZZgGBbKzPyDr
	riZE1CmXY/on8JONaPxjp/ZvE3mXyq2KV/jld83QWTE93YjzW254PzgWBo1rLX4x
	hwktIbX8Tapw87lA/zAVgl4WAU+Cx/LYLurruo8Ew+7ns59luaewTDvNdxU3+wYq
	wy8RloaQde4exjspvYMD5iJkz/xa9mzSL0fHokqCpSO+sCCYudXSTw3GUwOPmM2M
	NbYxbi2RC1DgyG0c716MtJC4q8eCBZzJwK1h+KidJQ2qTRH0xFGj6qf5fsk7PBgw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff5jt91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 05:42:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56N5fnxL032048;
	Wed, 23 Jul 2025 05:42:33 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ff5jt8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 05:42:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56N2lHNe025005;
	Wed, 23 Jul 2025 05:42:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480nptpn1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 05:42:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56N5gUHJ57344508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 05:42:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9880D20043;
	Wed, 23 Jul 2025 05:42:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B89220040;
	Wed, 23 Jul 2025 05:42:28 +0000 (GMT)
Received: from [9.39.18.80] (unknown [9.39.18.80])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Jul 2025 05:42:28 +0000 (GMT)
Message-ID: <91e9f2d6-3a27-4d4b-84ad-c62274d341ef@linux.ibm.com>
Date: Wed, 23 Jul 2025 11:12:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] sched: Add ttwu_queue support for delayed tasks
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, clm@meta.com
References: <20250702114924.091581796@infradead.org>
 <20250702121159.652969404@infradead.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250702121159.652969404@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA0NiBTYWx0ZWRfXwCmtHav5P4dz
 SfiJZrdZjQOf63oAKLpJJtJaKH9DUemk8YXvE70MhzhcRoKUH+o7BZqfHrYXGgmGME12r3nhsLH
 sZT9Elg6NLK5TVMvvzoMcPXAtF3h39W40jaDpPxdbDIpFGQi253YiocPNveqb+IuTyYzcKxeHYf
 3beS3t6GttzUx2KWu4EFr5k+eJNT1ruX/unud+MPh2ZJTflPmMGLxW6X0Nqg/aJfhVXkuXw/x7a
 I36EN/5+8EF2+i3DBdU/ZYR472YoKP4/uDx/utxBjyH3Ny2DgB5sUIPgQ1S5F1VKSEhU7ixK5NB
 yXzAPnmlGGUFpmb2aqXCiXBRhpkVT67dQBMKS6zrw1AoSwNnyh4PbABMGv/qvzlseE3FRJRZR+x
 t4syMsz9lIgMjxtEF5yGWvyS1BxGYjAIlmRTMyCE8gvYzuz8MbM2eeQXAcwSuLDU6ngmxR64
X-Authority-Analysis: v=2.4 cv=evLfzppX c=1 sm=1 tr=0 ts=68807649 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=VabnemYjAAAA:8 a=ujlQhItgod780Ov5V6kA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: IiF8e_Qc0lgqdQABV-2uWgqVNdzewiNF
X-Proofpoint-ORIG-GUID: wtcrqf7EBg24Z1GOZqKEtQridbVZKjBi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230046



On 7/2/25 17:19, Peter Zijlstra wrote:
> One of the more expensive things to do is take a remote runqueue lock;
> which is exactly what ttwu_runnable() ends up doing. However, in the
> case of sched_delayed tasks it is possible to queue up an IPI instead.
> 
> Reported-by: Chris Mason <clm@meta.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20250520101727.984171377@infradead.org
> ---
>   include/linux/sched.h   |    1
>   kernel/sched/core.c     |   96 +++++++++++++++++++++++++++++++++++++++++++++---
>   kernel/sched/fair.c     |   17 ++++++++
>   kernel/sched/features.h |    1
>   kernel/sched/sched.h    |    1
>   5 files changed, 110 insertions(+), 6 deletions(-)
> 
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -984,6 +984,7 @@ struct task_struct {
>   	 * ->sched_remote_wakeup gets used, so it can be in this word.
>   	 */
>   	unsigned			sched_remote_wakeup:1;
> +	unsigned			sched_remote_delayed:1;
>   #ifdef CONFIG_RT_MUTEXES
>   	unsigned			sched_rt_mutex:1;
>   #endif
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -675,7 +675,12 @@ struct rq *__task_rq_lock(struct task_st
>   {
>   	struct rq *rq;
>   
> -	lockdep_assert_held(&p->pi_lock);
> +	/*
> +	 * TASK_WAKING is used to serialize the remote end of wakeup, rather
> +	 * than p->pi_lock.
> +	 */
> +	lockdep_assert(p->__state == TASK_WAKING ||
> +		       lockdep_is_held(&p->pi_lock) != LOCK_STATE_NOT_HELD);
>   
>   	for (;;) {
>   		rq = task_rq(p);
> @@ -3727,6 +3732,8 @@ ttwu_do_activate(struct rq *rq, struct t
>   	}
>   }
>   
> +static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags);
> +
>   /*
>    * Consider @p being inside a wait loop:
>    *
> @@ -3754,6 +3761,35 @@ ttwu_do_activate(struct rq *rq, struct t
>    */
>   static int ttwu_runnable(struct task_struct *p, int wake_flags)
>   {
> +	if (sched_feat(TTWU_QUEUE_DELAYED) && READ_ONCE(p->se.sched_delayed)) {
> +		/*
> +		 * Similar to try_to_block_task():
> +		 *
> +		 * __schedule()				ttwu()
> +		 *   prev_state = prev->state		  if (p->sched_delayed)
> +		 *   if (prev_state)			     smp_acquire__after_ctrl_dep()
> +		 *     try_to_block_task()		     p->state = TASK_WAKING
> +		 *       ... set_delayed()
> +		 *         RELEASE p->sched_delayed = 1
> +		 *
> +		 * __schedule() and ttwu() have matching control dependencies.
> +		 *
> +		 * Notably, once we observe sched_delayed we know the task has
> +		 * passed try_to_block_task() and p->state is ours to modify.
> +		 *
> +		 * TASK_WAKING controls ttwu() concurrency.
> +		 */
> +		smp_acquire__after_ctrl_dep();
> +		WRITE_ONCE(p->__state, TASK_WAKING);
> +		/*
> +		 * Bit of a hack, see select_task_rq_fair()'s WF_DELAYED case.
> +		 */
> +		p->wake_cpu = smp_processor_id();
> +
> +		if (ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_DELAYED))
> +			return 1;
> +	}
> +
>   	CLASS(__task_rq_lock, guard)(p);
>   	struct rq *rq = guard.rq;
>   
> @@ -3776,6 +3812,8 @@ static int ttwu_runnable(struct task_str
>   	return 1;
>   }
>   
> +static void __ttwu_queue_wakelist(struct task_struct *p, int cpu);
> +
>   static inline bool ttwu_do_migrate(struct rq *rq, struct task_struct *p, int cpu)
>   {
>   	struct rq *p_rq = rq ? : task_rq(p);
> @@ -3801,6 +3839,52 @@ static inline bool ttwu_do_migrate(struc
>   	return true;
>   }
>   
> +static int ttwu_delayed(struct rq *rq, struct task_struct *p, int wake_flags,
> +			struct rq_flags *rf)
> +{
> +	struct rq *p_rq = task_rq(p);
> +	int cpu;
> +
> +	/*
> +	 * Notably it is possible for on-rq entities to get migrated -- even
> +	 * sched_delayed ones. This should be rare though, so flip the locks
> +	 * rather than IPI chase after it.
> +	 */
> +	if (unlikely(rq != p_rq)) {
> +		rq_unlock(rq, rf);
> +		p_rq = __task_rq_lock(p, rf);
> +		update_rq_clock(p_rq);
> +	}
> +
> +	if (task_on_rq_queued(p))
> +		dequeue_task(p_rq, p, DEQUEUE_NOCLOCK | DEQUEUE_SLEEP | DEQUEUE_DELAYED);
> +
> +	/*
> +	 * NOTE: unlike the regular try_to_wake_up() path, this runs both
> +	 * select_task_rq() and ttwu_do_migrate() while holding rq->lock
> +	 * rather than p->pi_lock.
> +	 */

When it comes here, it was because p->wake_cpu was a remote cpu and taking remote rq lock
would be costly.

So, when p->wake_cpu is passed, eventually we could end up fetching that rq again, such as in idle_cpu
checks, which also could be costly no?

Why there is need for select_task_rq here again? Why can't ttwu_do_activate be
done here instead?

> +	cpu = select_task_rq(p, p->wake_cpu, &wake_flags);
> +	if (ttwu_do_migrate(rq, p, cpu))
> +		wake_flags |= WF_MIGRATED;
> +
> +	if (unlikely(rq != p_rq)) {
> +		__task_rq_unlock(p_rq, rf);
> +		rq_lock(rq, rf);
> +	}
> +
> +	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
> +	p->sched_remote_delayed = 0;
> +
> +	/* it wants to run here */
> +	if (cpu_of(rq) == cpu)
> +		return 0;
> +
> +	/* shoot it to the CPU it wants to run on */
> +	__ttwu_queue_wakelist(p, cpu);
> +	return 1;
> +}
> +
>   void sched_ttwu_pending(void *arg)
>   {
>   	struct llist_node *llist = arg;
> @@ -3819,12 +3903,13 @@ void sched_ttwu_pending(void *arg)
>   		if (WARN_ON_ONCE(p->on_cpu))
>   			smp_cond_load_acquire(&p->on_cpu, !VAL);
>   
> -		if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
> -			set_task_cpu(p, cpu_of(rq));
> -
>   		if (p->sched_remote_wakeup)
>   			wake_flags |= WF_MIGRATED;
>   
> +		if (p->sched_remote_delayed &&
> +		    ttwu_delayed(rq, p, wake_flags | WF_DELAYED, &guard.rf))
> +			continue;
> +
>   		ttwu_do_activate(rq, p, wake_flags, &guard.rf);
>   	}
>   
> @@ -3964,12 +4049,13 @@ static inline bool ttwu_queue_cond(struc
>   
>   static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
>   {
> -	bool def = sched_feat(TTWU_QUEUE_DEFAULT);
> +	bool def = sched_feat(TTWU_QUEUE_DEFAULT) || (wake_flags & WF_DELAYED);
>   
>   	if (!ttwu_queue_cond(p, cpu, def))
>   		return false;
>   
>   	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
> +	p->sched_remote_delayed = !!(wake_flags & WF_DELAYED);
>   
>   	__ttwu_queue_wakelist(p, cpu);
>   	return true;
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5327,7 +5327,10 @@ static __always_inline void return_cfs_r
>   
>   static void set_delayed(struct sched_entity *se)
>   {
> -	se->sched_delayed = 1;
> +	/*
> +	 * See TTWU_QUEUE_DELAYED in ttwu_runnable().
> +	 */
> +	smp_store_release(&se->sched_delayed, 1);
>   
>   	/*
>   	 * Delayed se of cfs_rq have no tasks queued on them.
> @@ -8481,6 +8484,18 @@ select_task_rq_fair(struct task_struct *
>   	/* SD_flags and WF_flags share the first nibble */
>   	int sd_flag = wake_flags & 0xF;
>   
> +	if (wake_flags & WF_DELAYED) {
> +		/*
> +		 * This is the ttwu_delayed() case; where prev_cpu is in fact
> +		 * the CPU that did the wakeup, while @p is running on the
> +		 * current CPU.
> +		 *
> +		 * Make sure to flip them the right way around, otherwise
> +		 * wake-affine is going to do the wrong thing.
> +		 */
> +		swap(cpu, new_cpu);
> +	}
> +
>   	/*
>   	 * required for stable ->cpus_allowed
>   	 */
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -82,6 +82,7 @@ SCHED_FEAT(TTWU_QUEUE, false)
>   SCHED_FEAT(TTWU_QUEUE, true)
>   #endif
>   SCHED_FEAT(TTWU_QUEUE_ON_CPU, true)
> +SCHED_FEAT(TTWU_QUEUE_DELAYED, true)
>   SCHED_FEAT(TTWU_QUEUE_DEFAULT, false)
>   
>   /*
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2280,6 +2280,7 @@ static inline int task_on_rq_migrating(s
>   #define WF_RQ_SELECTED		0x80 /* ->select_task_rq() was called */
>   
>   #define WF_ON_CPU		0x0100
> +#define WF_DELAYED		0x0200
>   
>   static_assert(WF_EXEC == SD_BALANCE_EXEC);
>   static_assert(WF_FORK == SD_BALANCE_FORK);
> 
> 
> 


