Return-Path: <linux-kernel+bounces-606889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D583A8B504
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 11:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75870444539
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3074022B8C1;
	Wed, 16 Apr 2025 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ogAVquxD"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA062557C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795024; cv=none; b=PXzsagbgJju3h1U3J+sWUQkXIn4pwhMmEWLB6LaLRBgcIasM0HP7S2Ue/J0ogzfOZ6YteJEjPdg3b3HeJ+NkbPctPsKXGtiCt9TS7m/89M2LR8VlvW1qi2cfFcC4Ql1s14Zoz3rAfWxvYBXEEbUADjTQPgy1UUzR/QjIaVYVCkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795024; c=relaxed/simple;
	bh=F3gyMVudY5nzkMf/WU1z0FQtCegXxMlIC3excB97FxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FEfHM6EEU/4qwWnnwqz1R8imurApB5PIcp5xRr8mLuKTEYLrg/QXejfsr9N6iFeIl4b1jrA1Cb8JBjrnsol0AvWIfR5Bvvxi5SvCOmJ2+FfM6PfUyqWPjh5t7srsxF/+IiCKQfbv8I/r2BA1NHrGiyl5InH6l2eGgjwWb9hwy70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ogAVquxD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FLh78R028081;
	Wed, 16 Apr 2025 09:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2fhvbz
	vlCk3yxHSu/jZXPShZGq2s1FVIdv9WUknRhyI=; b=ogAVquxDGn+eEfJ7iYL9XW
	rfe1nJjuFsdBA29jDXvKzXU9AfE3xMtG8r7hFUhLC6G/tiYY4TcbONUMLTmhoAP6
	29jdG3KlFDZdXvL7YsN6KXOoY9yDjfaPGPVbQl0E0alnB55F3s0I/l1RIKEQ53ji
	c4vJu0LPBK7l1fdnCeDHImbwUyEgtEn9XFIUH4m0mFUlxX2Ec27wa9tWhnebI/yL
	yhTleNCAP6VKn9Ef/QN4hd2DeOaRV18AIBtpaNbdS057xNTyZ1rl79mIPiBqupdJ
	WaLV9EsRkoO5Vgyt6m1zXE/8bCwl8EftHMGDNz3S9SzsWqsS5lcURmOowkZX+2NA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461ykt2ejs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:16:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53G81BQ5016746;
	Wed, 16 Apr 2025 09:16:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46057276bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:16:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53G9GolG39256404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 09:16:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FFB020040;
	Wed, 16 Apr 2025 09:16:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E1102004B;
	Wed, 16 Apr 2025 09:16:48 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 09:16:48 +0000 (GMT)
Message-ID: <5e191de4-f580-462d-8f93-707addafb9a2@linux.ibm.com>
Date: Wed, 16 Apr 2025 14:46:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Skip useless sched_balance_running acquisition if
 load balance is not due
To: "Chen, Yu C" <yu.c.chen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20250416035823.1846307-1-tim.c.chen@linux.intel.com>
 <fbe29b49-92af-4b8c-b7c8-3c15405e5f15@linux.ibm.com>
 <667f2076-fbcd-4da7-8e4b-a8190a673355@intel.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <667f2076-fbcd-4da7-8e4b-a8190a673355@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9ieTpl_4jgjT0OLCtgwc_Ag6CLxIVoYa
X-Proofpoint-ORIG-GUID: 9ieTpl_4jgjT0OLCtgwc_Ag6CLxIVoYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160073



On 4/16/25 11:58, Chen, Yu C wrote:
> Hi Shrikanth,
> 
> On 4/16/2025 1:30 PM, Shrikanth Hegde wrote:
>>
>>
>> On 4/16/25 09:28, Tim Chen wrote:
>>> At load balance time, balance of last level cache domains and
>>> above needs to be serialized. The scheduler checks the atomic var
>>> sched_balance_running first and then see if time is due for a load
>>> balance. This is an expensive operation as multiple CPUs can attempt
>>> sched_balance_running acquisition at the same time.
>>>
>>> On a 2 socket Granite Rapid systems enabling sub-numa cluster and
>>> running OLTP workloads, 7.6% of cpu cycles are spent on cmpxchg of
>>> sched_balance_running.  Most of the time, a balance attempt is aborted
>>> immediately after acquiring sched_balance_running as load balance time
>>> is not due.
>>>
>>> Instead, check balance due time first before acquiring
>>> sched_balance_running. This skips many useless acquisitions
>>> of sched_balance_running and knocks the 7.6% CPU overhead on
>>> sched_balance_domain() down to 0.05%.  Throughput of the OLTP workload
>>> improved by 11%.
>>>
>>
>> Hi Tim.
>>
>> Time check makes sense specially on large systems mainly due to 
>> NEWIDLE balance.

scratch the NEWLY_IDLE part from that comment.

>>
> 
> Could you elaborate a little on this statement? There is no timeout 
> mechanism like periodic load balancer for the NEWLY_IDLE, right?

Yes. NEWLY_IDLE is very opportunistic.

> 
>> One more point to add, A lot of time, the CPU which acquired 
>> sched_balance_running,
>> need not end up doing the load balance, since it not the CPU meant to 
>> do the load balance.
>>
>> This thread.
>> https://lore.kernel.org/all/1e43e783-55e7-417f- 
>> a1a7-503229eb163a@linux.ibm.com/
>>
>>
>> Best thing probably is to acquire it if this CPU has passed the time 
>> check and as well it is
>> actually going to do load balance.
>>
>>
> 
> This is a good point, and we might only want to deal with periodic load
> balancer rather than NEWLY_IDLE balance. Because the latter is too 
> frequent and contention on the sched_balance_running might introduce
> high cache contention.
> 

But NEWLY_IDLE doesn't serialize using sched_balance_running and can 
endup consuming a lot of cycles. But if we serialize using 
sched_balance_running, it would definitely cause a lot contention as is.


The point was, before acquiring it, it would be better if this CPU is 
definite to do the load balance. Else there are chances to miss the 
actual load balance.


> thanks,
> Chenyu
> 
>>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>>> Reported-by: Mohini Narkhede <mohini.narkhede@intel.com>
>>> Tested-by: Mohini Narkhede <mohini.narkhede@intel.com>
>>> ---
>>>   kernel/sched/fair.c | 16 ++++++++--------
>>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index e43993a4e580..5e5f7a770b2f 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -12220,13 +12220,13 @@ static void sched_balance_domains(struct rq 
>>> *rq, enum cpu_idle_type idle)
>>>           interval = get_sd_balance_interval(sd, busy);
>>> -        need_serialize = sd->flags & SD_SERIALIZE;
>>> -        if (need_serialize) {
>>> -            if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1))
>>> -                goto out;
>>> -        }
>>> -
>>>           if (time_after_eq(jiffies, sd->last_balance + interval)) {
>>> +            need_serialize = sd->flags & SD_SERIALIZE;
>>> +            if (need_serialize) {
>>> +                if (atomic_cmpxchg_acquire(&sched_balance_running, 
>>> 0, 1))
>>> +                    goto out;
>>> +            }
>>> +
>>>               if (sched_balance_rq(cpu, rq, sd, idle, 
>>> &continue_balancing)) {
>>>                   /*
>>>                    * The LBF_DST_PINNED logic could have changed
>>> @@ -12238,9 +12238,9 @@ static void sched_balance_domains(struct rq 
>>> *rq, enum cpu_idle_type idle)
>>>               }
>>>               sd->last_balance = jiffies;
>>>               interval = get_sd_balance_interval(sd, busy);
>>> +            if (need_serialize)
>>> +                atomic_set_release(&sched_balance_running, 0);
>>>           }
>>> -        if (need_serialize)
>>> -            atomic_set_release(&sched_balance_running, 0);
>>>   out:
>>>           if (time_after(next_balance, sd->last_balance + interval)) {
>>>               next_balance = sd->last_balance + interval;
>>


