Return-Path: <linux-kernel+bounces-898642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5F7C55A44
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FE454E18EA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D22F2DC348;
	Thu, 13 Nov 2025 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jgvDwCIH"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D262BE629
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763007937; cv=none; b=tFtanzVghq7OlykzDl5VgPe7EIpPOcIP8mCEGI5/7GLp9zr985tOzLDv2/2Jl4HOJViJMGke+qXXOP7Fu/twHP7f3nNK9YvbBz/aXhq2gAA+cKxsbLwnKot75NNmAsj8BcnGfNjQFlWezENJ3q9jtlXFzes3f0cJR4Li4KkBEBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763007937; c=relaxed/simple;
	bh=qrfBLO0SnRmHNNF/xBgLTyOTHmKFoh5kol68KBmc8tA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9RCTVu5csJETE3+Zzo6Qwa6x7ppxcR5M8LKU/ZGkv83my2jLKREXDUAXniP9cTgajilDX7zfDSAzS+VzapbxNAFc8QYHQj3zlqFvSl38nKBvKTSUhWGeTVF9oIsV4mg/RjIx2P3zJcNGIAoNN74TlC34Ih41rQjGBY/0e6xRmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jgvDwCIH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD0kug4030681;
	Thu, 13 Nov 2025 04:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+ToMzf
	Ypi5eezgZcYo6Gley/Zf5jdfIuoMGLiEnNnVc=; b=jgvDwCIHpRGPEaAhdZhwfb
	d+Ws26sPz5LVeXqOPX7zKgVF3YNnB2vClshFGYcF6VmqZFIRRrqEY70RnDsZr5p5
	dB9FROyOOSmWCkGBio6X7jcF8RFzhPwVDHHYeFZLrAIRYLEIvqMz695w0QM1W67X
	w7OPl7Q9LFXcUEqX/TyiZz2SkxwuC6zGCxFYorjF8F1wi3+1NycfhY8eXY6j5mtw
	NBAB/E/2Z6WYABjjMBzhShFla3yi1y89+YrOdBO/SewuMiD39AFAetd7wRwJFWWY
	kZeZ2BW5jdsdkOXfBG5Oirk5WA4zNRv7uzAgqdef4Onyi9ZREylCQ+u+hcxhCMhg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk8e14v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 04:25:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD4LXUA014859;
	Thu, 13 Nov 2025 04:25:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpkbw7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 04:25:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AD4PLVb39059724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 04:25:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AC8B20040;
	Thu, 13 Nov 2025 04:25:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1CE82004B;
	Thu, 13 Nov 2025 04:25:18 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 04:25:18 +0000 (GMT)
Message-ID: <96d58672-330a-48fb-a308-fb41ce084063@linux.ibm.com>
Date: Thu, 13 Nov 2025 09:55:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
To: Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
 <aRQ_D1vyNfGVo-xK@linux.ibm.com>
 <20251112103740.GF4067720@noisy.programming.kicks-ass.net>
 <20251112104555.GE4068168@noisy.programming.kicks-ass.net>
 <55e02921-6477-4ed0-9ef6-16c3f34594a8@linux.ibm.com>
 <20251112112113.GO278048@noisy.programming.kicks-ass.net>
 <c6fe7ac0f6de4d51705bb2f24f82df2c3018804f.camel@linux.intel.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <c6fe7ac0f6de4d51705bb2f24f82df2c3018804f.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX2B1VW8kH9GJN
 h8olrrRc/WIEqc6ySNvQPCq+ZCusbMyNDlKJeyw78ntsIfVwZiO/Y2nKMaPJngkg55u2RH0LPsn
 SdpK0y65PPSBfZOAPSLHKxL2ZbOiRQzDtkbm6vmLpZ9c+2iPHUGT2t2729T8Q9uAIBKR8hL4kqr
 qVuO89gtVulsUeHZs6DiH2Vj86EZuPb8iHzhJ0LsBnzhnzlxA1Wt3evbQLpPZTykgOJmnx3BVzJ
 LA+YfXl1H/WJmdzs96rFJK/I8Wct5zxmZrd8qGssHuqwq+8w1XLYNmxWzfbM1zuhyb/Tz6zU757
 rcHNpjgc5K1BoHFLuP94aA4F3iRjrtxH79w8zfsFwIecuf2DwNSTd1D4rY5Yvip0mK9ZO2fvMVu
 o1VEWszSLDR2bBxwV0oc73YsUZ/BTg==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=69155db4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gVAPzhZn9TK19jZSpa8A:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: pJwcpfayw_HjZuauQ_YvGj9h1RbNQhzL
X-Proofpoint-GUID: pJwcpfayw_HjZuauQ_YvGj9h1RbNQhzL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022



On 11/13/25 2:40 AM, Tim Chen wrote:
> On Wed, 2025-11-12 at 12:21 +0100, Peter Zijlstra wrote:
>> On Wed, Nov 12, 2025 at 04:39:43PM +0530, Shrikanth Hegde wrote:
>>>
>>>
>>
>>>> So perhaps this is the better option -- or did I overlook something with
>>>> should_we_balance? It doesn't look like that will make a different
>>>> decision on the retry.
>>>>
>>>
>>> I think in newidle balance, these checks are there in swb to bail of load balance.
>>> redo logic catches it right?
>>
>> Urgh, my brain still thinks we're not serializing on newidle. Perhaps I
>> should make this 2 patches, one moving the serializing and one adding it
>> to newidle.
>>
>>> env->dst_rq lock is taken only in attach_tasks, meanwhile, if the wakeup happened,
>>> pending would be set. is irq enabled or remote CPU can set ttwu_pending on this rq?
>>>
>>>          if (env->idle == CPU_NEWLY_IDLE) {
>>>                  if (env->dst_rq->nr_running > 0 || env->dst_rq->ttwu_pending)
>>>                          return 0;
>>>                  return 1;
>>>          }
>>
>> Right, that could get tickled.
> 
> How about something like the following on top of v4 patch?
> This will avoid releasing the lock and take care of the NEWLY_IDLE case.
> 
> Tim
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 43c5ec039633..26179f4b77f6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11772,14 +11772,13 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
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
>   redo:
> -	need_unlock = false;
>   	if (!should_we_balance(&env)) {
>   		*continue_balancing = 0;
>   		goto out_balanced;
> @@ -11916,9 +11915,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>   			if (!cpumask_subset(cpus, env.dst_grpmask)) {
>   				env.loop = 0;
>   				env.loop_break = SCHED_NR_MIGRATE_BREAK;
> -				if (need_unlock)
> -					atomic_set_release(&sched_balance_running, 0);
> -
> +				if (env->idle == CPU_NEWLY_IDLE &&
> +				    (env->dst_running > 0 || env->dst_rq->ttwu_pending))
> +					goto out;

IIUC, we come here, it means busiest cpu was found, but due to
affinity restrictions none of the tasks can come to this cpu.

So a redo is done excluding that busiest cpu if there are cpus other
than the group_mask of this cpu. So doing a redo does make sense specially
for newidle.

So doing bailing out might be wrong.

>   				goto redo;
>   			}
>   			goto out_all_pinned;


