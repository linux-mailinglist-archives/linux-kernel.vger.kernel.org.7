Return-Path: <linux-kernel+bounces-852329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EF4BD8B30
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524B53AD497
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F322EB87B;
	Tue, 14 Oct 2025 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sRPsKG+Y"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B129E0E5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436819; cv=none; b=pzlACWYz/ep+whcIPAlLvvYO2MEiro27LZ7RIqo7IUpc9ExHVQACV3U4dhXgKri7vBqiaN90gByecgsvN/F/qisEzqzaqtPAdB9oMPjers1HfTcoTO4x5b4i5tNcGiN5PqMDdohNL3DoDbHsQF9nSFt0WyO1kLWP7Tr3wLDn9tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436819; c=relaxed/simple;
	bh=RAllV1zgfVyBRzNVnRYle4zGTgQrkrFYG3hFoQoUq8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r/5C2q2Q1v45ok4HUXeznjf1C0LO0Kp7SbH5gOBMlM9vV9dSeCXQRWB2eSCjdoqQUzLPrITXWjyzT6g1a5NkD6KJOh0Mi5bA+PV92VjFYPcmkf2XKPJ12WlQQQaJkodE1FMlH9HbYhHUorhfqzo9B/+HISMFp5PoQo9d0EhjGgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sRPsKG+Y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E4bKTx020267;
	Tue, 14 Oct 2025 10:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oeJHjr
	BjW7eSSA0g6eSq6CL7ICO7khZx1OjhRzVL4Zg=; b=sRPsKG+YP+mqvTWzzISFme
	VQ9yJGVD0cy7HdpGCTj0g07QotraDjEA2mBp/4t9qSFo/i2lvqDiaQ+aTPEp505m
	Xj/6rqJ9bTQN9bsTd5ZdajvJ6jfKa/TNNHP/bK5sBjhW3U9m10t8JgzEsVMtRTwB
	NsSm0J/K2OsZQYJZuqmZjiQ4Y8jODiG0wOtiAhTXzYlztlPWyiXnnNJDsQvzhcvm
	4zmRWLctWSH7Qraa+IjxQwpjacEEnLvjTQ9yPfAWvsdkf16LikdhbWa6X/8Uk3PR
	34XlgbKGWdY7uaGmNqx9wcV10X8BslmhgX0mlhV2BG3rY+yjLebQgb3t9yzUsBvw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8ny7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 10:13:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59E7go36016996;
	Tue, 14 Oct 2025 10:13:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32jt8kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 10:13:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59EADMOu40436040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 10:13:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08EFB20073;
	Tue, 14 Oct 2025 09:51:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F007F20072;
	Tue, 14 Oct 2025 09:51:01 +0000 (GMT)
Received: from [9.39.23.219] (unknown [9.39.23.219])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Oct 2025 09:51:01 +0000 (GMT)
Message-ID: <dcc6e306-6095-4bbf-a911-d448d6b495d2@linux.ibm.com>
Date: Tue, 14 Oct 2025 15:21:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
 <20251013142638.GM3245006@noisy.programming.kicks-ass.net>
 <aa3d20e6d451e0d0b812fe16e9d403c1033feeaa.camel@linux.intel.com>
 <20251014092436.GK4067720@noisy.programming.kicks-ass.net>
 <e84de5a9-b498-4152-846a-c72e1ac66109@linux.ibm.com>
 <20251014094259.GR3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251014094259.GR3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a7HF92he2dabb12W6v0m6oaHv2P7faTI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfXywFECmkxUqK3
 mkN2YqTZlWgZbUPOqsNTBrmgV5WbOQutfdtaJ6gUH9RExfQh78mzVxK/zhsgAzx/xRZp71szf8o
 hYpMJ8VyIOQBqkcfmXlt35OApQE0I/qNV1Nn1lXpgxVz+r4fgayg4Oiz633t7mhQGBd425f7JI5
 GrTgs1Q3u5wvF+9aU1VGkgOnhOgWp/TCYYJ0OAj0thhtwbLxzh5qans+t5ILoXilT8uFusXPrkI
 UAOhUGnErRu4UCG1BOSgSrWsyotDzHGkKHtU/kivU9RlbhnwVfzyPld0LAlLQXdZi5quOS0TaJg
 XFewc9Fk9HgizjXdHsQbjl8aXWkBsRqXkTVlJMYnS7+AegP9Lce3a6MP171vbZSUKJOgOzn2W8O
 DVqtNFy257dbicg7ZavbSdv5RlyUwA==
X-Proofpoint-GUID: a7HF92he2dabb12W6v0m6oaHv2P7faTI
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68ee2245 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fN0QsRKp1KExyfdZop8A:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011



On 10/14/25 3:12 PM, Peter Zijlstra wrote:
> On Tue, Oct 14, 2025 at 03:03:41PM +0530, Shrikanth Hegde wrote:
> 
>>> @@ -11758,6 +11775,12 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>>>    		goto out_balanced;
>>>    	}
>>> +	if (idle != CPU_NEWLY_IDLE && (sd->flags & SD_SERIALIZE)) {
>>> +		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
>>> +			goto out_balanced;
>>
>> Maybe goto out instead of out_balanced ?
> 
> That would be inconsistent with the !should_we_balance() goto
> out_balanced right above this, no?

Yes. But whats the reason for saying out_balanced for !should_we_balance?

Load balance wasn't even attempted there right? Could this be updating it wrongly?
At-least comments around out_all_pinned doesn't make sense if we came here via !swb

         schedstat_inc(sd->lb_balanced[idle]);
         sd->nr_balance_failed = 0;


> 
>>> +		need_unlock = true;
>>> +	}
>>> +
>>>    	group = sched_balance_find_src_group(&env);
>>>    	if (!group) {
>>>    		schedstat_inc(sd->lb_nobusyg[idle]);
>>> @@ -11998,6 +12021,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>>>    	    sd->balance_interval < sd->max_interval)
>>>    		sd->balance_interval *= 2;
>>>    out:
>>> +	if (need_unlock)
>>> +		atomic_set_release(&sched_balance_running, 0);
>>> +
>>>    	return ld_moved;
>>>    }
>>> @@ -12122,21 +12148,6 @@ static int active_load_balance_cpu_stop(void *data)
>>>    	return 0;
>>>    }
>>> -/*
>>> - * This flag serializes load-balancing passes over large domains
>>> - * (above the NODE topology level) - only one load-balancing instance
>>> - * may run at a time, to reduce overhead on very large systems with
>>> - * lots of CPUs and large NUMA distances.
>>> - *
>>> - * - Note that load-balancing passes triggered while another one
>>> - *   is executing are skipped and not re-tried.
>>> - *
>>> - * - Also note that this does not serialize rebalance_domains()
>>> - *   execution, as non-SD_SERIALIZE domains will still be
>>> - *   load-balanced in parallel.
>>> - */
>>> -static atomic_t sched_balance_running = ATOMIC_INIT(0);
>>> -
>>>    /*
>>>     * Scale the max sched_balance_rq interval with the number of CPUs in the system.
>>>     * This trades load-balance latency on larger machines for less cross talk.
>>> @@ -12192,7 +12203,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>>>    	/* Earliest time when we have to do rebalance again */
>>>    	unsigned long next_balance = jiffies + 60*HZ;
>>>    	int update_next_balance = 0;
>>> -	int need_serialize, need_decay = 0;
>>> +	int need_decay = 0;
>>>    	u64 max_cost = 0;
>>>    	rcu_read_lock();
>>> @@ -12216,13 +12227,6 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>>>    		}
>>>    		interval = get_sd_balance_interval(sd, busy);
>>> -
>>> -		need_serialize = sd->flags & SD_SERIALIZE;
>>> -		if (need_serialize) {
>>> -			if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
>>> -				goto out;
>>> -		}
>>> -
>>>    		if (time_after_eq(jiffies, sd->last_balance + interval)) {
>>>    			if (sched_balance_rq(cpu, rq, sd, idle, &continue_balancing)) {
>>>    				/*
>>> @@ -12236,9 +12240,7 @@ static void sched_balance_domains(struct rq *rq, enum cpu_idle_type idle)
>>>    			sd->last_balance = jiffies;
>>>    			interval = get_sd_balance_interval(sd, busy);
>>>    		}
>>> -		if (need_serialize)
>>> -			atomic_set_release(&sched_balance_running, 0);
>>> -out:
>>> +
>>>    		if (time_after(next_balance, sd->last_balance + interval)) {
>>>    			next_balance = sd->last_balance + interval;
>>>    			update_next_balance = 1;
>>


