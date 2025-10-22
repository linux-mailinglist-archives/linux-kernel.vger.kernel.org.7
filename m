Return-Path: <linux-kernel+bounces-865607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB4DBFD933
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB58D3ACC52
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE541D63C7;
	Wed, 22 Oct 2025 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ad8XxZ/w"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69948286A4
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153738; cv=none; b=nEYnnbD063qnNUBXVOmadJLfZyywsgDpXXzfEmuPTWh3CdCLgt6oHRrFgL3UREGZskb1twjYPQLBAnV/xuamVLFYgBWvDxbQSJbrKIjknYLMfQsnG3Dv7U4xImDYfn5D/2iz2e+jjRa9fgO+eteOtPS4M7kx0nbDK/WlYHZukHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153738; c=relaxed/simple;
	bh=rGFNJn6c8/oP+tvYXX7DpdFBuuX0tJHuE52i0IcEjdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JtMMv32suXo3okHD3Yr7nAS3ebTOYMxouGabZvpjxcZReOHYVl+2Q3SDDcMIjSMsQ1FoGp/JSYu73uNurnFBTubQciW61K8TwinpvQFzY1mcCI3s2+KLvVQILmMG27Exv+wPjrwts3lz/SDQ11pj8qQFCuSPJSpCRpjW5ZPhF0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ad8XxZ/w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M8LmCG017699;
	Wed, 22 Oct 2025 17:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OWwV7T
	n3ArbSOBK/ru+JS+aA89QzPdU/w+o0r+7boyw=; b=Ad8XxZ/wihLAfGoKF4++Io
	i8ydeCK1Qr7KG8kUEKaUaTOdY5ePREm3cxjvJnmfTdeaW8Ya9jfXlMtNkHgLNAhH
	LJwTCQDp6Sl8PPNpG8jKnDp3oDE8mcNn8B6t+bEDNwOqauSIzRwsMseIf9uO5gEL
	5M3Oc1f8BOjYtCRpEZ2+DnXbTNMzfxyFsNA9HV3vNJsolRPrd7Ip9P2/larsjKIq
	G+LHS0XRGWqqtAdd4bePHA6zHjSp8aDx+O2ovWDZd+T6NgTLgWfRgrUXRu3P3XM0
	k0BYBoxW0os1dYP85I6NNdF//RIhU+j/RnrVLCiFzardv0Y9AKg+mvZjZ1wAUj1Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vvn01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 17:21:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MH2dWp015102;
	Wed, 22 Oct 2025 17:21:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vvmyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 17:21:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MEOvtX002926;
	Wed, 22 Oct 2025 17:21:27 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejhchh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 17:21:27 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MHLPN132244300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 17:21:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A57485805C;
	Wed, 22 Oct 2025 17:21:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 347505805D;
	Wed, 22 Oct 2025 17:21:14 +0000 (GMT)
Received: from [9.43.23.38] (unknown [9.43.23.38])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 17:21:13 +0000 (GMT)
Message-ID: <1a63ee2a-9c1e-4aa3-adb0-012e0eae5dcf@linux.ibm.com>
Date: Wed, 22 Oct 2025 22:51:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] sched/fair: Disable cache aware scheduling for
 processes with high thread counts
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu
 <yu.c.chen@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
        Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>,
        Len Brown <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Libo Chen <libo.chen@oracle.com>,
        Adam Li <adamli@os.amperecomputing.com>,
        Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <a098a60d9b4fc8ccea3392096f8bb0cf03af070b.1760206683.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <a098a60d9b4fc8ccea3392096f8bb0cf03af070b.1760206683.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Kze02mROfrpaQniMaypF_E1r2umAZ759
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX4FPLRow0MAPI
 yTZDQ2xeAP5r2WUmPzBEnwiEaukoYZ1xR6Q3z2X7rLo+NGe2e4PMid3uFoSt9ZJ0lFEsrPyhNRF
 KbBlYPn9ufoHoDOycQt/dZIzU0h3txvev7xdbw6dawvinNV66f90N9x6gItojMHNNhX7n8EqqFX
 lpxI09Pur12xV3S40z6WJl7N1aab5koPNoBYsZmwxX1Y2YmGT9lYXSUArTj5eyVhfoQP3JT8Q4W
 aoIuHXfEYgqHxmg7twxyZhcxiRsDPYwRSnIIQ84cX4/tBAro/YjE/p708/NVoJF6U7oQrzroFEO
 0fOXvBvujU5UbbGzR7jGK+HoAmxRensCVtRdT3Q+Bhdr98CkvfiQCBDQQs+uf+iqq5FoGNwZR6l
 n1IrAnrirKoaop8DHzPkORZjrkxCRg==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f91298 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=zd2uoN0lAAAA:8 a=R188rTlZ2uNt2ZuBVgAA:9 a=QEXdDO2ut3YA:10
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: -p6P4eB-YeH6xH9nASp-tsiUglMoe745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On 11/10/25 23:54, Tim Chen wrote:
> From: Chen Yu <yu.c.chen@intel.com>
> 
> If the number of active threads within the process
> exceeds the number of Cores(divided by SMTs number)
> in the LLC, do not enable cache-aware scheduling.
> This is because there is a risk of cache contention
> within the preferred LLC when too many threads are
> present.
> 
> Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 79d109f8a09f..6b8eace79eee 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1240,6 +1240,18 @@ static inline int pref_llc_idx(struct task_struct *p)
>  	return llc_idx(p->preferred_llc);
>  }
>  
> +static bool exceed_llc_nr(struct mm_struct *mm, int cpu)
> +{
> +	int smt_nr = 1;
> +
> +#ifdef CONFIG_SCHED_SMT
> +	if (sched_smt_active())
> +		smt_nr = cpumask_weight(cpu_smt_mask(cpu));
> +#endif
> +
> +	return ((mm->nr_running_avg * smt_nr) > per_cpu(sd_llc_size, cpu));

In Power10 and Power11 that has SMT8 and LLC size of 4, this would disable
cache aware scheduling even for one thread.

Also, llc_overload_pct already ensures the load on the  preferred LLC doesn't
exceed certain capacity. Why is this exceed_llc_nr() check needed? Won't the
existing overload_pct naturally prevent excessive task aggregation by blocking
migrations when the destination LLC reaches ~50% utilization?

Thanks,
Madadi Vineeth Reddy

> +}
> +
>  static void account_llc_enqueue(struct rq *rq, struct task_struct *p)
>  {
>  	int pref_llc;
> @@ -1385,10 +1397,12 @@ void account_mm_sched(struct rq *rq, struct task_struct *p, s64 delta_exec)
>  
>  	/*
>  	 * If this task hasn't hit task_cache_work() for a while, or it
> -	 * has only 1 thread, invalidate its preferred state.
> +	 * has only 1 thread, or has too many active threads, invalidate
> +	 * its preferred state.
>  	 */
>  	if (epoch - READ_ONCE(mm->mm_sched_epoch) > EPOCH_LLC_AFFINITY_TIMEOUT ||
> -	    get_nr_threads(p) <= 1) {
> +	    get_nr_threads(p) <= 1 ||
> +	    exceed_llc_nr(mm, cpu_of(rq))) {
>  		if (mm->mm_sched_cpu != -1)
>  			mm->mm_sched_cpu = -1;
>  	}
> @@ -1467,6 +1481,11 @@ static void __no_profile task_cache_work(struct callback_head *work)
>  	if (p->flags & PF_EXITING)
>  		return;
>  
> +	if (get_nr_threads(p) <= 1) {
> +		mm->mm_sched_cpu = -1;
> +		return;
> +	}
> +
>  	if (!zalloc_cpumask_var(&cpus, GFP_KERNEL))
>  		return;
>  
> @@ -9826,6 +9845,10 @@ static enum llc_mig can_migrate_llc_task(int src_cpu, int dst_cpu,
>  	if (cpu < 0 || cpus_share_cache(src_cpu, dst_cpu))
>  		return mig_unrestricted;
>  
> +	 /* skip cache aware load balance for single/too many threads */
> +	if (get_nr_threads(p) <= 1 || exceed_llc_nr(mm, dst_cpu))
> +		return mig_unrestricted;
> +
>  	if (cpus_share_cache(dst_cpu, cpu))
>  		to_pref = true;
>  	else if (cpus_share_cache(src_cpu, cpu))


