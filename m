Return-Path: <linux-kernel+bounces-887389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FF4C3818A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 22:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BA764EEBB3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 21:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA3D2BE7AB;
	Wed,  5 Nov 2025 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eI4/GVjO"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907812701CC
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379346; cv=none; b=GRGxJuk/fbkz6u5d+IcIWRxM4HhnqSkq63Qg7t964p7cwOz3OyHCSlMbBePe0ud3NqHJ1WO+uwNEm6HFO7KfMBGdy3QPvb8arNxSM6EyZmGo+WIaCo6I9vxQDmnM+xccPsDV7vosh3KwbyuHyBXKblUbZXjxR3Kq9vJbPOIdwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379346; c=relaxed/simple;
	bh=qEYWE7LSptAUipkDHVI3+wDB+A05eDWw3Mt5dZRsq5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0v9ML/qxdhDkiLn6dnmhVoajfAmOcDo9XMewSOORXjI+e6yGMaQcRcG2G8AchvpAmBjgkqPL4lxekFqN3dUwOIdQPBEdh4/S/fLt5JwwYHRi+CJWXbZ9wQDbbxJB8l8RvRcPunEmwPgcYwG7Gln2mIfp62x8HmGLgL9DwiUkM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eI4/GVjO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5FabKW023094;
	Wed, 5 Nov 2025 21:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zjvwE2
	qTrPY/9Kjo76gatrChsyi5BJQ46WIz9zpqTik=; b=eI4/GVjOUqFW+OPuvKGqBS
	GdYOmLRU93iVQWn/YYgkQt+usewEDFUh2MbxeCECTKaEJIFgodh7cwdgiur96kAy
	Sryf3qneyXj6jASg85c7aDVb7J+2vrbmm43X2PeQIRQiXNUk3unro1JDDr8LcDK/
	EzXDk5fCTBXeXnsMGxPty/3U3IUvLEQdgzqtYPP06/rxM0lmQApKxdg1M+UKyAJp
	ZEwtpkUGHwMQDfG12BhuZi4mwLyyP2hCcUed5Cke7OHFzAO6KlKi+hMjjYqBcMyC
	LuW4SmMf3utKcenVeL43hKHz8P1lQ6YbksXd35pFSAnGWX2udMf5szaFx2Ta706A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xc3tdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 21:48:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5JNauV021467;
	Wed, 5 Nov 2025 21:48:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5xrjt6fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 21:48:40 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5LmeZf14484202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 21:48:40 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2520458045;
	Wed,  5 Nov 2025 21:48:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2B7758050;
	Wed,  5 Nov 2025 21:48:33 +0000 (GMT)
Received: from [9.43.127.159] (unknown [9.43.127.159])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 21:48:33 +0000 (GMT)
Message-ID: <ddfde793-ad6e-4517-96b8-662dcb78acc8@linux.ibm.com>
Date: Thu, 6 Nov 2025 03:18:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>, Chris Mason <clm@meta.com>,
        linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20251103110445.3503887-1-mgorman@techsingularity.net>
 <20251103110445.3503887-3-mgorman@techsingularity.net>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20251103110445.3503887-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX+MUoAtseH0oP
 FAhX+gKIJ/CUxadpC31IVlZWBklfiikvhhoCGQgDE4/pybj1byEuljSVuNnb9uaG5Gei9u/KM/e
 LOP1MexKORFDQsugT/6P4oGoBFXPrtWyi1Qu3JSixig7x+Gk5bpVn9epFSp7Cb2a1DIb9ffAYJ8
 sRuAgqhqoJ9ZU7luMa5IBkHkih8IRVYqj+4+HjlJWH8kySt6Y63a4TJR7iBR4RdbFQ68F8V2pgt
 zqi2bm4XvKqN4FlJ+jnUKBll8EyKsqRfr00sxZwZXZMdh97uG9S54pEKzQ5Kx+EIo3HztIT+ew3
 j/COcQ9VjL2454yZq2IWGox/fSIoyaFBfQPwVnAKXTvACsVs+ti34eAhh/KZR+WO2XUVGuhQFEB
 SaMD6uWOuI3SXr0/o6q6ky7JzrGdyA==
X-Proofpoint-GUID: iV2ddITj7-XGbquENW6bSiNbHltvHhJd
X-Authority-Analysis: v=2.4 cv=OdCVzxTY c=1 sm=1 tr=0 ts=690bc639 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HnnIDNdDN-DDPO2MklwA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: iV2ddITj7-XGbquENW6bSiNbHltvHhJd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_08,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021

Hi Mel,

On 03/11/25 16:34, Mel Gorman wrote:
> Reimplement NEXT_BUDDY preemption to take into account the deadline and
> eligibility of the wakee with respect to the waker. In the event
> multiple buddies could be considered, the one with the earliest deadline
> is selected.
> 
> Sync wakeups are treated differently to every other type of wakeup. The
> WF_SYNC assumption is that the waker promises to sleep in the very near
> future. This is violated in enough cases that WF_SYNC should be treated
> as a suggestion instead of a contract. If a waker does go to sleep almost
> immediately then the delay in wakeup is negligible. In all other cases,
> it's throttled based on the accumulated runtime of the waker so there is
> a chance that some batched wakeups have been issued before preemption.

[..snip..]

> +static inline enum preempt_wakeup_action
> +__do_preempt_buddy(struct rq *rq, struct cfs_rq *cfs_rq, int wake_flags,
> +		 struct sched_entity *pse, struct sched_entity *se)
> +{
> +	bool pse_before;
> +
> +	/*
> +	 * Ignore wakee preemption on WF_FORK as it is less likely that
> +	 * there is shared data as exec often follow fork. Do not
> +	 * preempt for tasks that are sched_delayed as it would violate
> +	 * EEVDF to forcibly queue an ineligible task.
> +	 */
> +	if ((wake_flags & WF_FORK) || pse->sched_delayed)
> +		return PREEMPT_WAKEUP_NONE;
> +
> +	/* Reschedule if waker is no longer eligible. */
> +	if (in_task() && !entity_eligible(cfs_rq, se))
> +		return PREEMPT_WAKEUP_RESCHED;
> +
> +	/*
> +	 * Keep existing buddy if the deadline is sooner than pse.
> +	 * The older buddy may be cache cold and completely unrelated
> +	 * to the current wakeup but that is unpredictable where as
> +	 * obeying the deadline is more in line with EEVDF objectives.
> +	 */
> +	if (cfs_rq->next && entity_before(cfs_rq->next, pse))
> +		return PREEMPT_WAKEUP_NEXT;

IIUC, the logic attempts to maintain deadline ordering among buddies, but
this doesn't address tasks already on the runqueue.

So with frequent wakeups, queued tasks (even with earlier deadlines) may be
unfairly delayed. I understand that this would fade away quickly as the
woken up task that got to run due to buddy preference would accumulate negative
lag and would not be eligible to run again, but the starvation could be higher if
wakeups are very high.

To test this, I ran schbench (many message and worker threads) together with
stress-ng (CPU-bound), and observed stress-ng's bogo-ops throughput dropped by
around 64%.

This shows a significant regression for CPU-bound tasks under heavy wakeup loads.
Thoughts?


I also ran schbench and hackbench. All these were run on a Power11 System
containing 4 sockets and 160 CPUs spread across 4 NUMA nodes.

schbench(new) 99.0th latency (lower is better)
========
load        	baseline[pct imp](std%)       With patch[pct imp]( std%)
20mt, 10wt      1.00 [ 0.00]( 0.24)           0.97 [ +3.00]( 0.18)
20mt, 20wt      1.00 [ 0.00]( 0.33)           1.00 [  0.00]( 0.12)
20mt, 40wt      1.00 [ 0.00]( 2.84)           0.76 [ +24.0]( 0.32)
20mt, 80wt      1.00 [ 0.00]( 3.66)           0.66 [ +34.0]( 0.72)
20mt, 160wt     1.00 [ 0.00](12.92)           0.88 [ +12.0]( 6.77)

mt=message threads ; wt=worker threads

schbench being a wakeup sensitive workload showed good improvement.


hackbench (lower is better)
========
case              load        baseline[pct imp](std%)      With patch[pct imp]( std%)
process-sockets   1-groups    1.00 [ 0.00]( 5.21)            0.91 [ +9.00]( 5.50)
process-sockets   4-groups    1.00 [ 0.00]( 7.30)            1.01 [ -1.00]( 4.27)
process-sockets   12-groups   1.00 [ 0.00]( 2.44)            1.00 [  0.00]( 1.78)
process-sockets   30-groups   1.00 [ 0.00]( 2.05)            1.04 [ -4.00]( 0.86)
process-sockets   48-groups   1.00 [ 0.00]( 2.25)            1.04 [ -4.00]( 1.03)
process-sockets   79-groups   1.00 [ 0.00]( 2.28)            1.05 [ -5.00]( 1.67)
process-sockets   110-groups  1.00 [ 0.00]( 11.17)           1.04 [ -4.00]( 8.64)

process-pipe      1-groups     1.00 [ 0.00]( 8.21)            0.84 [+16.00](13.00)
process-pipe      4-groups     1.00 [ 0.00]( 5.54)            0.95 [ +5.00]( 4.21)
process-pipe      12-groups    1.00 [ 0.00]( 3.96)            1.04 [ -4.00]( 2.26)
process-pipe      30-groups    1.00 [ 0.00]( 7.64)            1.20 [ -20.0]( 3.63)
process-pipe      48-groups    1.00 [ 0.00]( 6.28)            1.04 [ -4.00]( 8.48)
process-pipe      79-groups    1.00 [ 0.00]( 6.19)            1.01 [ -1.00]( 4.36)
process-pipe      110-groups   1.00 [ 0.00]( 10.23)           0.94 [ +6.00]( 5.21)

Didn't notice significant improvement or regression in Hackbench. Mostly in the noise
range.

Thanks,
Madadi Vineeth Reddy


> +
> +	set_next_buddy(pse);
> +
> +	/*
> +	 * WF_SYNC|WF_TTWU indicates the waker expects to sleep but it is not
> +	 * strictly enforced because the hint is either misunderstood or
> +	 * multiple tasks must be woken up.
> +	 */
> +	pse_before = entity_before(pse, se);
> +	if (wake_flags & WF_SYNC) {
> +		u64 delta = rq_clock_task(rq) - se->exec_start;
> +		u64 threshold = sysctl_sched_migration_cost;
> +
> +		/*
> +		 * WF_SYNC without WF_TTWU is not expected so warn if it
> +		 * happens even though it is likely harmless.
> +		 */
> +		WARN_ON_ONCE(!(wake_flags & WF_TTWU));
> +
> +		if ((s64)delta < 0)
> +			delta = 0;
> +
> +		/*
> +		 * WF_RQ_SELECTED implies the tasks are stacking on a
> +		 * CPU when they could run on other CPUs. Reduce the
> +		 * threshold before preemption is allowed to an
> +		 * arbitrary lower value as it is more likely (but not
> +		 * guaranteed) the waker requires the wakee to finish.
> +		 */
> +		if (wake_flags & WF_RQ_SELECTED)
> +			threshold >>= 2;
> +
> +		/*
> +		 * As WF_SYNC is not strictly obeyed, allow some runtime for
> +		 * batch wakeups to be issued.
> +		 */
> +		if (pse_before && delta >= threshold)
> +			return PREEMPT_WAKEUP_RESCHED;
> +
> +		return PREEMPT_WAKEUP_NONE;
> +	}
> +
> +	return PREEMPT_WAKEUP_NEXT;
> +}
> +
> +
>  /*
>   * Preempt the current task with a newly woken task if needed:
>   */
> @@ -8734,7 +8819,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	struct sched_entity *se = &donor->se, *pse = &p->se;
>  	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
>  	int cse_is_idle, pse_is_idle;
> -	bool do_preempt_short = false;
> +	enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_NONE;
>  
>  	if (unlikely(se == pse))
>  		return;
> @@ -8748,10 +8833,6 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	if (task_is_throttled(p))
>  		return;
>  
> -	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
> -		set_next_buddy(pse);
> -	}
> -
>  	/*
>  	 * We can come here with TIF_NEED_RESCHED already set from new task
>  	 * wake up path.
> @@ -8783,7 +8864,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  		 * When non-idle entity preempt an idle entity,
>  		 * don't give idle entity slice protection.
>  		 */
> -		do_preempt_short = true;
> +		preempt_action = PREEMPT_WAKEUP_SHORT;
>  		goto preempt;
>  	}
>  
> @@ -8802,21 +8883,41 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	 * If @p has a shorter slice than current and @p is eligible, override
>  	 * current's slice protection in order to allow preemption.
>  	 */
> -	do_preempt_short = sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice);
> +	if (sched_feat(PREEMPT_SHORT) && (pse->slice < se->slice)) {
> +		preempt_action = PREEMPT_WAKEUP_SHORT;
> +	} else {
> +		/*
> +		 * If @p potentially is completing work required by current then
> +		 * consider preemption.
> +		 */
> +		preempt_action = __do_preempt_buddy(rq, cfs_rq, wake_flags,
> +						      pse, se);
> +	}
> +
> +	switch (preempt_action) {
> +	case PREEMPT_WAKEUP_NONE:
> +		return;
> +	case PREEMPT_WAKEUP_RESCHED:
> +		goto preempt;
> +	case PREEMPT_WAKEUP_SHORT:
> +		fallthrough;
> +	case PREEMPT_WAKEUP_NEXT:
> +		break;
> +	}
>  
>  	/*
>  	 * If @p has become the most eligible task, force preemption.
>  	 */
> -	if (__pick_eevdf(cfs_rq, !do_preempt_short) == pse)
> +	if (__pick_eevdf(cfs_rq, preempt_action != PREEMPT_WAKEUP_SHORT) == pse)
>  		goto preempt;
>  
> -	if (sched_feat(RUN_TO_PARITY) && do_preempt_short)
> +	if (sched_feat(RUN_TO_PARITY))
>  		update_protect_slice(cfs_rq, se);
>  
>  	return;
>  
>  preempt:
> -	if (do_preempt_short)
> +	if (preempt_action == PREEMPT_WAKEUP_SHORT)
>  		cancel_protect_slice(se);
>  
>  	resched_curr_lazy(rq);


