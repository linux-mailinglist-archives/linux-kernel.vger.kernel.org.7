Return-Path: <linux-kernel+bounces-897026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C29D3C51D50
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBEE74F54BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62D230B51D;
	Wed, 12 Nov 2025 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T9UHGXI1"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F8030ACE6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945165; cv=none; b=GqqL3boR8f4g+Kxf6zCi/81VzQxnrptMdP4dkIvHbVJofoMxkOdKJpJNOhTe6W30IATrY8EyP15eM0SJ2/pA4q7CV89fHi90zIBfDnM/yFeDfs9rQ+RNav4sVfK90JGawdFSkQhjQXv+sGMNUvcYk1BokANFdPvtH1/UoVW1Gsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945165; c=relaxed/simple;
	bh=InjHvWhRGMzVlZmUMSt2vq+YDe+ALg+IXVRMdWsm9T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUE/cblhBAi6MsaXdEJt2UbNXfDkOKz1oNXJc2gQfH6nTjW7ppzGbUaJNUAFvixGh1jiGTLg6OD8vyIOZk0w4kgUGJyrp+gC51FLOWsMV4a+sraKBMvtI2jnweLEshc3d4lwZwwTlJLRUJjuaWm6Vj72M/+jPLJ6IJWHcmteoCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T9UHGXI1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC87PKQ015737;
	Wed, 12 Nov 2025 10:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JIvesK
	VCZ5grXXaqEwPZTeq52OWDqYlbVysC44hbFYo=; b=T9UHGXI1KZ9mdB2dRJmcqI
	nKabcHBUMdw5z2bSkn3LHxUSVmkI4LDK2WsVLkEzhrKIR79/xcSbasnir1go9yQj
	SMrFPSs2yV/oaunH/G/Ud94lgmZqTCgDpGhDCb0JIvsfwnhepAf1C27mijOw3exj
	Sxl829M4i1Y+/0/S+4N9nGwL+q1DDbh16EBLOJJzn4kfZOv3uxTCmxqlYjOko8OU
	eyAKgF+gaYMiGUlhTb5bktMHHv1B1B/b4jzyTGinXJGo6kCtBJ5YoewBKT0PZf5Y
	0MM+uos8lkmfAgwdJAKADt7Vu3psH5b0uT1zuGpXIcDH/MEfDA39xuCuZTsYPi/A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wc7a35e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 10:53:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC9x65n011441;
	Wed, 12 Nov 2025 10:53:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1fchs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 10:53:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACAra5k39059938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 10:53:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 107FC2004E;
	Wed, 12 Nov 2025 10:53:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1956620043;
	Wed, 12 Nov 2025 10:53:33 +0000 (GMT)
Received: from [9.124.217.11] (unknown [9.124.217.11])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 10:53:32 +0000 (GMT)
Message-ID: <b2ac87cd-bd5e-439b-b2e3-afb4215c4edc@linux.ibm.com>
Date: Wed, 12 Nov 2025 16:23:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <aRQ_D1vyNfGVo-xK@linux.ibm.com>
 <20251112103740.GF4067720@noisy.programming.kicks-ass.net>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20251112103740.GF4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxOCBTYWx0ZWRfX/9bNHXlWVmDF
 Gi23DbVzBYC8EhKNSFcFq8CHLEPuO9E9IFCVkXWMc3PrU91DdQ00usTw3e4PHX48m/zOZLROwvE
 qPbWLdKd5Nn9aofNPGRNB9EwKzV1LiDP/KDJRuoGfmyqFdxUENS0rAH4Q59PWP6Yq/+f6+V44zG
 ypfeBLihBDAth5HMW994vgZ6QudlSRIUIiCXvqchytoFlpOvbapi+QXGvc4kI5ghJ2hQz7D/kCp
 rBV/ERVUMqsOJicDx5N60RRPWn5CCU0F4fuGO36VUfdU2XiK2KX7sh1YOsf5xPox3IqYYdr2FDt
 Nw96D4SwSh7FZ4Z7sZW4qereDMG5n1tOLkLCDYg0Pgh+4f1eGS2I06BeH/c23nqqfVHoMBJacfZ
 uPc6wEq7O/MoJDDc2JgIup6CgTMb2w==
X-Authority-Analysis: v=2.4 cv=GcEaXAXL c=1 sm=1 tr=0 ts=69146732 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=r34uGnnchd5__CjB4FgA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 69QEAvmsEhysfBnFfey446jXRzp7BMbo
X-Proofpoint-ORIG-GUID: 69QEAvmsEhysfBnFfey446jXRzp7BMbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080018



On 11/12/25 4:07 PM, Peter Zijlstra wrote:
> On Wed, Nov 12, 2025 at 01:32:23PM +0530, Srikar Dronamraju wrote:
>>>   	group = sched_balance_find_src_group(&env);
>>>   	if (!group) {
>>>   		schedstat_inc(sd->lb_nobusyg[idle]);
>>> @@ -11892,6 +11916,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>>>   			if (!cpumask_subset(cpus, env.dst_grpmask)) {
>>>   				env.loop = 0;
>>>   				env.loop_break = SCHED_NR_MIGRATE_BREAK;
>>> +				if (need_unlock)
>>> +					atomic_set_release(&sched_balance_running, 0);
>>> +
>>
>> One nit:
>> While the current code is good, would conditionally resetting the
>> need_unlock just after resetting the atomic variable better than
>> unconditional reset that we do now?
> 
> Right, I had the same thought when grabbed the patch yesterday, but
> ignored it.
> 
> But perhaps something like so?
> 
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11717,14 +11717,20 @@ static int sched_balance_rq(int this_cpu
>   		.fbq_type	= all,
>   		.tasks		= LIST_HEAD_INIT(env.tasks),
>   	};
> -	bool need_unlock;
> +	bool need_unlock = false;
>   
>   	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
>   
>   	schedstat_inc(sd->lb_count[idle]);
>   
> +	if (0) {
>   redo:
> -	need_unlock = false;
> +		if (need_unlock) {
> +			atomic_set_release(&sched_balance_running, 0);
> +			need_unlock = false;
> +		}
> +	}
> +
>   	if (!should_we_balance(&env)) {
>   		*continue_balancing = 0;
>   		goto out_balanced;
> @@ -11861,9 +11867,6 @@ static int sched_balance_rq(int this_cpu
>   			if (!cpumask_subset(cpus, env.dst_grpmask)) {
>   				env.loop = 0;
>   				env.loop_break = SCHED_NR_MIGRATE_BREAK;
> -				if (need_unlock)
> -					atomic_set_release(&sched_balance_running, 0);
> -
>   				goto redo;
>   			}
>   			goto out_all_pinned;
> 
> 
> ---
> 
> The other option is something like this, but Linus hated on this pattern
> when we started with things.
> 
> ---
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11692,6 +11692,8 @@ static void update_lb_imbalance_stat(str
>    */
>   static atomic_t sched_balance_running = ATOMIC_INIT(0);
>   
> +DEFINE_FREE(balance_unlock, atomic_t *, if (_T) atomic_set_release(_T, 0));
> +
>   /*
>    * Check this_cpu to ensure it is balanced within domain. Attempt to move
>    * tasks if there is an imbalance.
> @@ -11717,24 +11719,23 @@ static int sched_balance_rq(int this_cpu
>   		.fbq_type	= all,
>   		.tasks		= LIST_HEAD_INIT(env.tasks),
>   	};
> -	bool need_unlock;
>   
>   	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
>   
>   	schedstat_inc(sd->lb_count[idle]);
>   
>   redo:
> -	need_unlock = false;
>   	if (!should_we_balance(&env)) {
>   		*continue_balancing = 0;
> -		goto out_balanced;
> +		return 0;
>   	}
>   
> +	atomic_t *lock __free(balance_unlock) = NULL;
>   	if (sd->flags & SD_SERIALIZE) {
> -		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)) {
> -			goto out_balanced;
> -		}
> -		need_unlock = true;
> +		if (!atomic_try_cmpxchg_acquire(&sched_balance_running, 0, 1))
> +			return 0;
> +
> +		lock = &sched_balance_running;
>   	}
>   
>   	group = sched_balance_find_src_group(&env);
> @@ -11861,9 +11862,6 @@ static int sched_balance_rq(int this_cpu
>   			if (!cpumask_subset(cpus, env.dst_grpmask)) {
>   				env.loop = 0;
>   				env.loop_break = SCHED_NR_MIGRATE_BREAK;
> -				if (need_unlock)
> -					atomic_set_release(&sched_balance_running, 0);
> -
>   				goto redo;
>   			}
>   			goto out_all_pinned;
> @@ -11980,9 +11978,6 @@ static int sched_balance_rq(int this_cpu
>   	    sd->balance_interval < sd->max_interval)
>   		sd->balance_interval *= 2;
>   out:
> -	if (need_unlock)
> -		atomic_set_release(&sched_balance_running, 0);
> -
>   	return ld_moved;
>   }
>   

Second one is difficult to understand.


Is this an option too?
---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f8e1df9c5199..64e2aeacd65e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11720,14 +11720,13 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
                 .fbq_type       = all,
                 .tasks          = LIST_HEAD_INIT(env.tasks),
         };
-       bool need_unlock;
+       bool need_unlock = false;
  
         cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
  
         schedstat_inc(sd->lb_count[idle]);
  
  redo:
-       need_unlock = false;
         if (!should_we_balance(&env)) {
                 *continue_balancing = 0;
                 goto out_balanced;
@@ -11864,8 +11863,10 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
                         if (!cpumask_subset(cpus, env.dst_grpmask)) {
                                 env.loop = 0;
                                 env.loop_break = SCHED_NR_MIGRATE_BREAK;
-                               if (need_unlock)
+                               if (need_unlock) {
                                         atomic_set_release(&sched_balance_running, 0);
+                                       need_unlock = false;
+                               }
  
                                 goto redo;
                         }



