Return-Path: <linux-kernel+bounces-852820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB00BD9FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 192B34E30AE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76692749F1;
	Tue, 14 Oct 2025 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="epnJbdvk"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12E922615
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452129; cv=none; b=Y07titd6IqaS8Fff0kATyYGzC/KwhkRo52zA36ULUSuSWmEI9DvDMqUtd/TYFa7FXuakhkk77A1ypzrbFhz1l05EuCch2eQIkO5Z6Syz62PaID3oFfrT1Dx/XgVJGOKwI3AgesoKfkqsHegIfg36GGGBtfd3MF7bfBl4qA2+9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452129; c=relaxed/simple;
	bh=NwsKY+Ck33XIQdyHcZaf2TkV0U+QkxNswVZwBADZNq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZImeI5tVqAQWHbdBGBVFj4O+5o30wjgIWkeyNrkVcHt5LOA42Ns3iRTnf5u+l31zUeOwnP5ds0oVYQhVU8pcTrhjEW/xi2ELWYFZVFrbnUnvWUxY/mDy52Pq07gD5JkYDS+9U/RbCRZk+RL5y6kNnzKrRS3ctktMYFhcmjQlkeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=epnJbdvk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EBaRke002981;
	Tue, 14 Oct 2025 14:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BxjOyy
	sfpEDBBj3Rw1NyMZUjRFiCfGUhak1ReTkJ71k=; b=epnJbdvkoJ3BWdFBpTaQt+
	s1q56ugSvkb+0XNCV9VjtpIQ7vcUWCmJOiZzO3VU5f26ZxKmG1I3c5+F2mn6ZeLg
	+HJj+/aGssvnnNot9VS5cETybIN0BSNSvlWEIASlGLixHugfu2lNkwfRXQoVl00I
	r2Dsp+RqrnK1etpYlb7jDZ6bpZjBKYJkjb1ItDfIUkzH2gfm0gnyD6NIJ/J8ARCq
	V46s+LbN1qEtDKn6Z7wPUslT2PKyGjzezoBr99UQ2bmBgWbW+5jB6rJnd+sU9QXn
	EHVcFRNw3QVe/QC8nFRCq7RKiBrO1yLk2G6xS+vSdXSWa29jGtmGewJSKZAdOQHg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewty74a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 14:28:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59ECQleS015466;
	Tue, 14 Oct 2025 14:28:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjb55t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 14:28:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59EESchR35652048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 14:28:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0065520071;
	Tue, 14 Oct 2025 14:28:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7AA62004B;
	Tue, 14 Oct 2025 14:28:35 +0000 (GMT)
Received: from [9.39.23.219] (unknown [9.39.23.219])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Oct 2025 14:28:35 +0000 (GMT)
Message-ID: <55ecba48-7abb-43e7-a50b-4341cc345b3a@linux.ibm.com>
Date: Tue, 14 Oct 2025 19:58:35 +0530
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
X-Proofpoint-GUID: ALfEd6LPkMrkQqnVcH-IETsAN-NP1nSY
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68ee5e18 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ESB0-EhKDTS6JWE3lIMA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: ALfEd6LPkMrkQqnVcH-IETsAN-NP1nSY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX7qOKJoXBSjgd
 syxX0wNfmHPfI4ViqEbxtIxMhmt3ca6D5K+fZIEpxXV0RKWJ7p8fFddjxokRZd88tZRKFl+sn4y
 3aKG6Kf5UO4YUPD6/pjdHB9fjYZt8RTi60igvMH1MhwXFXe3Zn4k+bTfornQzqWnJl2RMZIjqGL
 PFHirebXabOPF2RevTuTpn9XxQ7uewdJhRnpXMVj8rNDO62ahy7mR/eiy+wgHSKWOATQyjYIR8u
 rXRolTgq2HMlFtYRvYQhY3iQp0vNzgF+PNIQLXnZfnJamiAP9DaSgbHh/EbG7jvNrXA2muL8nca
 mlrkxEuXgEEtstRXw6T19pDYG1J3Mp7ofZNe6+xZbQRBnOU6QJ8k0n44hVVrrx4iPgq5KIoI0dl
 1ZDTKq2NIBWlP4OuBV/Bu0DTyKNeQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014



On 10/14/25 2:54 PM, Peter Zijlstra wrote:

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

One thing is missing, need to reset to 0 for redo logic to work.

@@ -11882,6 +11905,8 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
                         if (!cpumask_subset(cpus, env.dst_grpmask)) {
                                 env.loop = 0;
                                 env.loop_break = SCHED_NR_MIGRATE_BREAK;
+                               if (need_unlock)
+                                       atomic_set_release(&sched_balance_running, 0);
                                 goto redo;

