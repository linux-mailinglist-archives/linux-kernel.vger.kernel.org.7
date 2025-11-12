Return-Path: <linux-kernel+bounces-897063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EADEFC51DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD821886348
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A403126D9;
	Wed, 12 Nov 2025 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="miAh06DT"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA983126A2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945807; cv=none; b=PGRpNvlh8+h0VqlGkbrG8DfK/x35J4+vDMQp098iUaUpepFilkN1+rckMRwyxfAEGJITxuVGYHlBZovGuVHEcWSsvbq7XobjBT0ZdvBmDo3U/ag4JsoMkjHxnq3frjmE4YiyWLJKAs++qe6EhqIkP386pT40pGzcUpCvvwAgleE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945807; c=relaxed/simple;
	bh=tTil4E5KnLPlJx6WSy3BCbz8S6ky5g/0dP1bbtgRHpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BSyAsposy/aRafLe2yJ7Q5YKvsKcFSz0unkYumetjg0RnEc6yG3ZWVWhZSc+yfPsLWs14+6xsrK8XSvIiJyXXRbp99OpLIgbeVyyQt3o+vTQhS3IZdeb5u0ZcYoopifKHfa5f3h8CAbobzYimT34xo0MPkkM8v4Ey3Tbx9KXYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=miAh06DT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC8JLAq031978;
	Wed, 12 Nov 2025 11:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Pl0Sqz
	T1bslbBmDmLQvh2UHnUdDCOjDMoD1QUAVN/7s=; b=miAh06DTekaykDJeDQBrJ0
	yc1ua5issL5mGhDGD5K+Hqu6rg31Nzn7dzUIJsRILMvL2YpKZ2LXbmmc4QTAnhkj
	I3YI4En4G+N+wnWFaUsZyd4rtnBUQGh9haQWk6Aj5Z3BfIsNap4TXkiJCRC1swU5
	f9lHfiG4sOBeiScG98hCDfcasXvCtM0BAlJiULagUHWxy0omnZlsjKixQ8lKlL/J
	yEdeG4O/yPaZ/vSvd4B3TITfHC1M8HqfUpxzRsl6oSpT2eA3/3k0Tbx0AEaF9vZ0
	uRPkrabIMTK7OoO9HvUTa4+qkmiG7B7M4OiZ1R5BDNPvyxWGzr6fOPJ7equglBwA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m87yec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:09:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC9qnnI014759;
	Wed, 12 Nov 2025 11:09:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpk7qpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:09:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACB9lR244433848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 11:09:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ACB12004E;
	Wed, 12 Nov 2025 11:09:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D55AC20043;
	Wed, 12 Nov 2025 11:09:44 +0000 (GMT)
Received: from [9.124.217.11] (unknown [9.124.217.11])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 11:09:44 +0000 (GMT)
Message-ID: <55e02921-6477-4ed0-9ef6-16c3f34594a8@linux.ibm.com>
Date: Wed, 12 Nov 2025 16:39:43 +0530
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
 <20251112104555.GE4068168@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251112104555.GE4068168@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=69146afe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jVdCUccH_q-BKY16FVMA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 6hKRQkfgX7euzuemw6vW7BUe82MRgjf0
X-Proofpoint-ORIG-GUID: 6hKRQkfgX7euzuemw6vW7BUe82MRgjf0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfX+vSHNCpI8Ddu
 +C3iDhbqW4YBJMwEHMfWkEVJHn5D4/2FTQk6IUw8fzSpig3uLV6AdiIw932/nBmJnWCHqYgB5dg
 0yXcxoAaWqdaSF/e9/qnngm4oOXB+2B/GUbrRq2AjjwBP1VB77tUi3g/W0mtyqvrhZNhfxiDMWI
 41euhL3eWL+uwlrVT0J9OK/dGGqGuLhDLo+FaNVCXhrhfUtatg2Oie3D6aYz+fK2xV82AOW8sFp
 FJBDlsdTmSI9lRPMHJgOfZZ0vs5S3z9GpGs38J+6qw8OAZLBxpgj9ew346aj1q0NNovQBIlU7u4
 gNX7prg8Em/mYBX+MpPj9B1UbFkoai3BMksOO3TDG4u8/2yY3X+RDVvnhChS1g2JG5RlB0Sj9hB
 hKo/t1+Ex9047P86VSGCcNxtVB/fVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079



On 11/12/25 4:15 PM, Peter Zijlstra wrote:
> On Wed, Nov 12, 2025 at 11:37:40AM +0100, Peter Zijlstra wrote:
>> On Wed, Nov 12, 2025 at 01:32:23PM +0530, Srikar Dronamraju wrote:
>>>>   	group = sched_balance_find_src_group(&env);
>>>>   	if (!group) {
>>>>   		schedstat_inc(sd->lb_nobusyg[idle]);
>>>> @@ -11892,6 +11916,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>>>>   			if (!cpumask_subset(cpus, env.dst_grpmask)) {
>>>>   				env.loop = 0;
>>>>   				env.loop_break = SCHED_NR_MIGRATE_BREAK;
>>>> +				if (need_unlock)
>>>> +					atomic_set_release(&sched_balance_running, 0);
>>>> +
>>>
>>> One nit:
>>> While the current code is good, would conditionally resetting the
>>> need_unlock just after resetting the atomic variable better than
>>> unconditional reset that we do now?
>>
>> Right, I had the same thought when grabbed the patch yesterday, but
>> ignored it.
>>
> 
> Hmm, should we not redo while keeping the lock? Doesn't make much sense
> to drop and try to reacquire things here.
> 
> So perhaps this is the better option -- or did I overlook something with
> should_we_balance? It doesn't look like that will make a different
> decision on the retry.
> 

I think in newidle balance, these checks are there in swb to bail of load balance.
redo logic catches it right?

env->dst_rq lock is taken only in attach_tasks, meanwhile, if the wakeup happened,
pending would be set. is irq enabled or remote CPU can set ttwu_pending on this rq?


         if (env->idle == CPU_NEWLY_IDLE) {
                 if (env->dst_rq->nr_running > 0 || env->dst_rq->ttwu_pending)
                         return 0;
                 return 1;
         }


