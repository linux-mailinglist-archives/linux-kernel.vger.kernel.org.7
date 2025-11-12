Return-Path: <linux-kernel+bounces-897616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAEBC534D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 151555485FB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79D4342C92;
	Wed, 12 Nov 2025 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XHCVCJwl"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F19D34253F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962213; cv=none; b=E/b9X8/kRq0i/fGWXkUNlHn/Ju/OrOYu4l9ZRZEvzhxA21heoIFiswwTXqqRFwj9p2pzBzisnqkd9JJdPM2axLIHtVbevcrs8hUuMhcJoA3SU93xT/r+CIL+ztvUroqOheY5lpdrC8VbzTJeMCn3lxcGjXPfNDl9IUgRKUKIPvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962213; c=relaxed/simple;
	bh=+AsDIPYTmeWeREcjbhVQwAnzBy6bQrx+h0Tj/yrAr+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRlxu0sGyBtkeO7a58GFs3pzSsOTmXBRLoBiAB8EY40vA5vxX/3GFq/PWItYKSXaAHik2as5f15JJzCRFTB/Jtk4xTOe0aIZab7Wl5afFhwryU3u2cIH8kx+DVZxOIUY+K56p6xmZ/EcyQL5YUfqck69EAXE+qgVjqCJQRPov5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XHCVCJwl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACF4fa7009088;
	Wed, 12 Nov 2025 15:43:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CMjQOW
	okHV1brpidWF2FFBxRvYS0peisBFWIMBG5N6s=; b=XHCVCJwl+ZMBMuV3vagoMG
	g8tRbCqm+mM2C6atCexHdnNYoyglweGjIPksg104Rp4LlL/2MhcGFGoq31+MjWZ4
	X8ywJmlM5pfDnYb4+OLG3RX5zKAAXQNaILQlHL5OE1BNwkrSR/+tXexuTK2mSHM7
	tjpvcRdKIZ0VUGLItRidqZP8m4ycePBUx71T8atf8Rc7brHw+yAUQegHzF2d4nFq
	RsTBfknixn81k4DBmTJDJ4ny4Su5yP4O5Iz1wyiDXWqAfqpt842L+snaeEKUqLsE
	UQKj/vJA0dP/dZa+hEx41dngPzPK7d+ecRf+ml5Xh8i1CgVp7WxML4FAIbop7Kjg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7bdrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:43:05 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACFY2Iv022567;
	Wed, 12 Nov 2025 15:43:04 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7bdrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:43:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ACDViW5007325;
	Wed, 12 Nov 2025 15:43:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdjgtax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:43:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACFh1qi43516398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 15:43:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9F0C2004E;
	Wed, 12 Nov 2025 15:43:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8126120040;
	Wed, 12 Nov 2025 15:42:58 +0000 (GMT)
Received: from [9.124.217.11] (unknown [9.124.217.11])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 15:42:58 +0000 (GMT)
Message-ID: <588c0150-4a2c-414f-9fde-3d18b2bbb3ad@linux.ibm.com>
Date: Wed, 12 Nov 2025 21:12:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] sched/fair: Proportional newidle balance
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
        Chris Mason <clm@meta.com>,
        Joseph Salisbury <joseph.salisbury@oracle.com>,
        Adam Li <adamli@os.amperecomputing.com>,
        Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
        Josh Don <joshdon@google.com>
References: <20251107160645.929564468@infradead.org>
 <20251107161739.770122091@infradead.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251107161739.770122091@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX31+Liz5HRe4q
 1U5wq2HQjULgROWM6GxIsgG2y4o1ybN+n8kNS1D/028hBHSYL2cBz+fRrZTDNQam5PJp8V4d+Ca
 a6HTdCRCnJpdi/zd3oUAyWTC1T/grBz6A9M2ZeGQBFMuF2jxmxnu4uz77FzwVTa7QvDpgbzk86G
 7UhW6TM4aJlZQcXp1KSN3/JPNWbqs29Ya2gqJt6r3wuPswkvNph6p88Ie1YMZBvyUK5F6JyeCCh
 hGkx7yGibjiuQgufFLtSEsG1blwl4fdMZ+/pOqdFBWFp8Bf8CDsmKC4BJSoewwpwVjBe2WQQk5n
 xkhmTf+HfiLJHcm/vZoTMf9GNNhBNdPwLAa5bMDEmACnoBuIm2TDenbGnhhZPJzupBvH7YJJFEX
 nQ5AUxjBW2JA8xmfbOnbrydcYncARA==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=6914ab09 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JfrnYn6hAAAA:8 a=f1eStZQGD1Kxnqo4adoA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: HKcxOhhwKkRdYwkgNLQchnrCZtgsLO9U
X-Proofpoint-ORIG-GUID: t8GQA4jbEbNDaC9dyTf7ULv2NFpgJWDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018



On 11/7/25 9:36 PM, Peter Zijlstra wrote:
> Add a randomized algorithm that runs newidle balancing proportional to
> its success rate.
> 
> This improves schbench significantly:
> 
>   6.18-rc4:			2.22 Mrps/s
>   6.18-rc4+revert:		2.04 Mrps/s
>   6.18-rc4+revert+random:	2.18 Mrps/S
> 

Could you please share the schbench command?

I see command like "schbench -t 90 -r 30 -i 30" running on 60 core regress.
Will do more iterations to confirm it (to be sure it is not run/run variation)

> Conversely, per Adam Li this affects SpecJBB slightly, reducing it by 1%:
> 
>   6.17:			-6%
>   6.17+revert:		 0%
>   6.17+revert+random:	-1%
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   include/linux/sched/topology.h |    3 ++
>   kernel/sched/core.c            |    3 ++
>   kernel/sched/fair.c            |   43 +++++++++++++++++++++++++++++++++++++----
>   kernel/sched/features.h        |    5 ++++
>   kernel/sched/sched.h           |    7 ++++++
>   kernel/sched/topology.c        |    6 +++++
>   6 files changed, 63 insertions(+), 4 deletions(-)
> 
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -92,6 +92,9 @@ struct sched_domain {
>   	unsigned int nr_balance_failed; /* initialise to 0 */
>   
>   	/* idle_balance() stats */
> +	unsigned int newidle_call;
> +	unsigned int newidle_success;
> +	unsigned int newidle_ratio;
>   	u64 max_newidle_lb_cost;
>   	unsigned long last_decay_max_lb_cost;
>   
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -121,6 +121,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_updat
>   EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
>   
>   DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> +DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
>   
>   #ifdef CONFIG_SCHED_PROXY_EXEC
>   DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
> @@ -8589,6 +8590,8 @@ void __init sched_init_smp(void)
>   {
>   	sched_init_numa(NUMA_NO_NODE);
>   
> +	prandom_init_once(&sched_rnd_state);
> +
>   	/*
>   	 * There's no userspace yet to cause hotplug operations; hence all the
>   	 * CPU masks are stable and all blatant races in the below code cannot
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12146,11 +12146,26 @@ void update_max_interval(void)
>   	max_load_balance_interval = HZ*num_online_cpus()/10;
>   }
>   
> -static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
> +static inline void update_newidle_stats(struct sched_domain *sd, unsigned int success)
> +{
> +	sd->newidle_call++;
> +	sd->newidle_success += success;
> +
> +	if (sd->newidle_call >= 1024) {
> +		sd->newidle_ratio = sd->newidle_success;
> +		sd->newidle_call /= 2;
> +		sd->newidle_success /= 2;
> +	}

Would it be better to >> 1 ? or compiler takes care of it?

> +}
> +
> +static inline bool
> +update_newidle_cost(struct sched_domain *sd, u64 cost, unsigned int success)
>   {
>   	unsigned long next_decay = sd->last_decay_max_lb_cost + HZ;
>   	unsigned long now = jiffies;
>   
> +	update_newidle_stats(sd, success);
> +
>   	if (cost > sd->max_newidle_lb_cost) {
>   		/*
>   		 * Track max cost of a domain to make sure to not delay the
> @@ -12198,7 +12213,7 @@ static void sched_balance_domains(struct
>   		 * Decay the newidle max times here because this is a regular
>   		 * visit to all the domains.
>   		 */
> -		need_decay = update_newidle_cost(sd, 0);
> +		need_decay = update_newidle_cost(sd, 0, 0);
>   		max_cost += sd->max_newidle_lb_cost;
>   
>   		/*
> @@ -12843,6 +12858,22 @@ static int sched_balance_newidle(struct
>   			break;
>   
>   		if (sd->flags & SD_BALANCE_NEWIDLE) {
> +			unsigned int weight = 1;
> +
> +			if (sched_feat(NI_RANDOM)) {
> +				/*
> +				 * Throw a 1k sided dice; and only run
> +				 * newidle_balance according to the success
> +				 * rate.
> +				 */
> +				u32 d1k = sched_rng() % 1024;
> +				weight = 1 + sd->newidle_ratio;
> +				if (d1k > weight) {
> +					update_newidle_stats(sd, 0);
> +					continue;
> +				}
> +				weight = (1024 + weight/2) / weight;
> +			}
>   
>   			pulled_task = sched_balance_rq(this_cpu, this_rq,
>   						   sd, CPU_NEWLY_IDLE,
> @@ -12850,10 +12881,14 @@ static int sched_balance_newidle(struct
>   
>   			t1 = sched_clock_cpu(this_cpu);
>   			domain_cost = t1 - t0;
> -			update_newidle_cost(sd, domain_cost);
> -
>   			curr_cost += domain_cost;
>   			t0 = t1;
> +
> +			/*
> +			 * Track max cost of a domain to make sure to not delay the
> +			 * next wakeup on the CPU.
> +			 */
> +			update_newidle_cost(sd, domain_cost, weight * !!pulled_task);
>   		}
>   
>   		/*
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -121,3 +121,8 @@ SCHED_FEAT(WA_BIAS, true)
>   SCHED_FEAT(UTIL_EST, true)
>   
>   SCHED_FEAT(LATENCY_WARN, false)
> +
> +/*
> + * Do newidle balancing proportional to its success rate using randomization.
> + */
> +SCHED_FEAT(NI_RANDOM, true)
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -5,6 +5,7 @@
>   #ifndef _KERNEL_SCHED_SCHED_H
>   #define _KERNEL_SCHED_SCHED_H
>   
> +#include <linux/prandom.h>
>   #include <linux/sched/affinity.h>
>   #include <linux/sched/autogroup.h>
>   #include <linux/sched/cpufreq.h>
> @@ -1348,6 +1349,12 @@ static inline bool is_migration_disabled
>   }
>   
>   DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> +DECLARE_PER_CPU(struct rnd_state, sched_rnd_state);
> +
> +static inline u32 sched_rng(void)
> +{
> +	return prandom_u32_state(this_cpu_ptr(&sched_rnd_state));
> +}
>   
>   #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
>   #define this_rq()		this_cpu_ptr(&runqueues)
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1662,6 +1662,12 @@ sd_init(struct sched_domain_topology_lev
>   
>   		.last_balance		= jiffies,
>   		.balance_interval	= sd_weight,
> +
> +		/* 50% success rate */
> +		.newidle_call		= 512,
> +		.newidle_success	= 256,
> +		.newidle_ratio		= 512,
> +
>   		.max_newidle_lb_cost	= 0,
>   		.last_decay_max_lb_cost	= jiffies,
>   		.child			= child,
> 
> 


run hackbench with it, Looks like hackbench does better when utilization is very high.
Otherwise, it regresses slightly.

I compared series applied vs on 65177ea9f64d. Let me know if i need to set anything different.
Will do numbers with more loops/iterations to iron out any run/run variations.

