Return-Path: <linux-kernel+bounces-852217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86178BD874B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5821923715
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13192E7BB5;
	Tue, 14 Oct 2025 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lhZ+qjTc"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDE12EB5BF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434440; cv=none; b=BX979SQnwZb2KJDwO/01HmpjEbAGlMgtZOQ7HHhd/wHl35wNQIgvcrOkjC/tyoLgtG4BhoSajaCPkUT7FnCJi56cA4mkG8j5g+BqgjjDAiq8ZMoqspDfi5tUhahaVRaR4b960PK3PiITEqXb5MU6krFhnUe3qxJ5nPGwYFXpbFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434440; c=relaxed/simple;
	bh=X/VyQlzszpe2UxPNRQMrafOQkpuDqsOg6tFXdjjY6Uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKXoB8Hi05vN+CSIT8n3HSvWNK06zEtfWGMQPW1Dw/MzH4+7VBJA0h7ogpmWyiz2KOXfYyP3glrlnFSHR1VehDmrceMYc1QUymDIBLclDCjxFSbRZpP42mZWrN8//UWnthWfVxMBo9y37CRK9biUjhu/T7lXj7cyckx1vhV21UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lhZ+qjTc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E0GuBw023819;
	Tue, 14 Oct 2025 09:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FcmpHi
	kcw9EpIQcq8dZ0OIT6hkOj+ICn6Yky8UIgQW8=; b=lhZ+qjTcCmSFf+4nAlp1Su
	pB4lc8iopo8Px/VO8XOf2xYVtbszxIW44SSuWPpPcJiQO7rdU35bC1+Eaday/Abx
	RydbQnIviv4z1SfSxFvoPeUR9oN+KqLoPPDKqoXgWd8tr0lwf0ZQnnnOX+wFqRTI
	zLUBrMgRH++59EinJ5W+DuBpcFdkQ0aV+07L5s+eUQY28KURIy8QtvAEdDYNXM4Y
	SujDqOUlA3OVAtMy/53wGBKpEzRCLix7TbMDMiht727iT/hiyShDfOE1Q4RXgAaX
	ba8P2vn/DyZW9i5YRkM1JSZIeN4WPWgZ3dlZUU4Vckv6LzdITkwERRTgOxk9FsPg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qevyw9bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 09:33:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59E8Lf2F018348;
	Tue, 14 Oct 2025 09:33:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49s3rf3ssa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 09:33:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59E9Xicn36962730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 09:33:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9030C20043;
	Tue, 14 Oct 2025 09:33:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 824F620040;
	Tue, 14 Oct 2025 09:33:42 +0000 (GMT)
Received: from [9.39.23.219] (unknown [9.39.23.219])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Oct 2025 09:33:42 +0000 (GMT)
Message-ID: <e84de5a9-b498-4152-846a-c72e1ac66109@linux.ibm.com>
Date: Tue, 14 Oct 2025 15:03:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
To: Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
 <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
 <aa3d20e6d451e0d0b812fe16e9d403c1033feeaa.camel@linux.intel.com>
 <20251014092436.GK4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251014092436.GK4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7_fQ-ngSFmGQtZgIuUY-G26dk96IXB26
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68ee18fb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=27z3qPwZjjW7Pyp3Oa8A:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX/IPmvJt1yVMe
 S+WhMBSku46x82puFJziS1u2tolNdeEW8KM3YK4KvbMcdn6YREVLZ/AClHxLkFt6HG/XELuO2eW
 sVVAS3iz95qxEJC0mBHqXbj5PMsRxUI+gbsXPRsv24IbFkri8hP/93FKXMDxJtXpv5BwYx4x/5K
 qTwP68LhmrZpr8nDfxuRY+jvv6uL7f9ocD9vLGN0b8y5K7+PaZqa7gLDNe/Qy5ZxvmkVxlLWYuA
 QwmjP31Y7lohDH9YoFyBruQ1SPX5JUe83E/qP5s/ubRn4fiXAengseKzNSZvMclNBzlnChsRiNW
 Q4EmzsvqO7SHVurWCXllPv1GHEEhBUh/sbQQcG2Q955qloWSgbS9WrUUj3P0e5lm2jF1G5RFdSA
 6azm24RWG8qiHTdebu08OuJjMaPDow==
X-Proofpoint-GUID: 7_fQ-ngSFmGQtZgIuUY-G26dk96IXB26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014



On 10/14/25 2:54 PM, Peter Zijlstra wrote:
> On Mon, Oct 13, 2025 at 02:54:19PM -0700, Tim Chen wrote:
> 
>>> So I'm not sure I understand the situation, @continue_balancing should
>>> limit this concurrency to however many groups are on this domain -- your
>>> granite thing with SNC on would have something like 6 groups?
>>
>> That's a good point.  But I think the contention is worse than
>> 6 CPUs.
>>
>> The hierarchy would be
>>
>> SMT
>> NUMA-level1
>> NUMA-level2
>> NUMA-level3
>> NUMA-level4
> 
> Aren't you missing the LLC/NODE domain here? We should have at least one
> !SD_NUMA domain above SMT.
> 
>> There would be multiple CPUs in that are first in the SMT group
>> with continue_balancing=1 going up in the hierachy and
>> attempting the cmpxchg in the first NUMA domain level,
>> before calling should_we_balance() and finding that they are
>> not the first in the NUMA domain and set continue_balancing=0
>> and abort. Those CPUS are in same L3.
>> But at the same time, there could be CPUs in other sockets
>> cmpxchg on sched_balance_running.
> 
> Right, Yu Chen said something like that as well, should_we_balance() is
> too late.
> 
> Should we instead move the whole serialize thing inside
> sched_balance_rq() like so:
> 
> ---
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bc0b7ce8a65d..e9f719ba17e1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11722,6 +11722,22 @@ static void update_lb_imbalance_stat(struct lb_env *env, struct sched_domain *sd
>   	}
>   }
>   
> +
> +/*
> + * This flag serializes load-balancing passes over large domains
> + * (above the NODE topology level) - only one load-balancing instance
> + * may run at a time, to reduce overhead on very large systems with
> + * lots of CPUs and large NUMA distances.
> + *
> + * - Note that load-balancing passes triggered while another one
> + *   is executing are skipped and not re-tried.
> + *
> + * - Also note that this does not serialize rebalance_domains()
> + *   execution, as non-SD_SERIALIZE domains will still be
> + *   load-balanced in parallel.
> + */
> +static atomic_t sched_balance_running = ATOMIC_INIT(0);
> +
>   /*
>    * Check this_cpu to ensure it is balanced within domain. Attempt to move
>    * tasks if there is an imbalance.
> @@ -11747,6 +11763,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>   		.fbq_type	= all,
>   		.tasks		= LIST_HEAD_INIT(env.tasks),
>   	};
> +	int need_unlock = false;
>   
>   	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
>   
> @@ -11758,6 +11775,12 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>   		goto out_balanced;
>   	}
>   
> +	if (idle != CPU_NEWLY_IDLE && (sd->flags & SD_SERIALIZE)) {
> +		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
> +			goto out_balanced;

Maybe goto out instead of out_balanced ?

> +		need_unlock = true;
> +	}
> +
>   	group = sched_balance_find_src_group(&env);
>   	if (!group) {
>   		schedstat_inc(sd->lb_nobusyg[idle]);
> @@ -11998,6 +12021,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>   	    sd->balance_interval < sd->max_interval)
>   		sd->balance_interval *= 2;
>   out:
> +	if (need_unlock)
> +		atomic_set_release(&sched_balance_running, 0);
> +
>   	return ld_moved;
>   }
>   
> @@ -12122,21 +12148,6 @@ static int active_load_balance_cpu_stop(void *data)
>   	return 0;
>   }
>   
> -/*
> - * This flag serializes load-balancing passes over large domains
> - * (above the NODE topology level) - only one load-balancing instance
> - * may run at a time, to reduce overhead on very large systems with
> - * lots of CPUs and large NUMA distances.
> - *
> - * - Note that load-balancing passes triggered while another one
> - *   is executing are skipped and not re-tried.
> - *
> - * - Also note that this does not serialize rebalance_domains()
> - *   execution, as non-SD_SERIALIZE domains will still be
> - *   load-balanced in parallel.
> - */
> -static atomic_t sched_balance_running = ATOMIC_INIT(0);
> -
>   /*
>    * Scale the max sched_balance_rq interval with the number of CPUs in the system.
>    * This trades load-balance latency on larger machines for less cross talk.
> @@ -12192,7 +12203,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>   	/* Earliest time when we have to do rebalance again */
>   	unsigned long next_balance = jiffies + 60*HZ;
>   	int update_next_balance = 0;
> -	int need_serialize, need_decay = 0;
> +	int need_decay = 0;
>   	u64 max_cost = 0;
>   
>   	rcu_read_lock();
> @@ -12216,13 +12227,6 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>   		}
>   
>   		interval = get_sd_balance_interval(sd, busy);
> -
> -		need_serialize = sd->flags & SD_SERIALIZE;
> -		if (need_serialize) {
> -			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
> -				goto out;
> -		}
> -
>   		if (time_after_eq(jiffies, sd->last_balance + interval)) {
>   			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
>   				/*
> @@ -12236,9 +12240,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>   			sd->last_balance = jiffies;
>   			interval = get_sd_balance_interval(sd, busy);
>   		}
> -		if (need_serialize)
> -			atomic_set_release(&sched_balance_running, 0);
> -out:
> +
>   		if (time_after(next_balance, sd->last_balance + interval)) {
>   			next_balance = sd->last_balance + interval;
>   			update_next_balance = 1;


