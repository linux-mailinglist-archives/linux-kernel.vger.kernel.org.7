Return-Path: <linux-kernel+bounces-738148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F644B0B507
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA7487ADEC7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC811F4282;
	Sun, 20 Jul 2025 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G7T+EtcN"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860F12E7F
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753009063; cv=none; b=hmUhK2bjpovTpLo2u2H53JZdOIfSD8CJBIIPQ23F8hLuMFqYhkAxQS8tV+mOfquJVeKjBpmn+nPNhhBGDVB+reWuXafj8IiwAoT+z8xH/Z+V0cY8py2lQN8/5WTR5JrFVQbHXMjgAEfNhRoanVL9Rv7lRUCT1SyztRKJ4HvLPF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753009063; c=relaxed/simple;
	bh=1rRsWbMCMdPPhYlC/fHN7bNrfs15MGi0xH0w1+S4RjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6cOyaLsJ1IBIaNaa5wxyGBPhKYivivau8iKaDEar0H2yo1Mhu2Y4cbTWQZXFVDEO26kAxtkD1RUaPNzL5syEBYUhHwT+SPXhr+NtiSfPNqqt43n9I1tfGv2q5D3S+puCMmDvsn7ONe3eRB8lVuD4xUqvfLSs+iV/umKayhFsjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G7T+EtcN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56K3KDR4012988;
	Sun, 20 Jul 2025 10:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eX9F96
	oa3/WaJ4yobmxak8X9YLJgqrKmtIy67HVTBvg=; b=G7T+EtcNFqsGf3R/OW59tN
	96+QF9fOtoxTh0pl7Lt+AhP7Ivos2I1/0W4nnJPRzKb1N9tGwPpic4V5iJWpxAUn
	ZHZq57iIoK49lEmULUaAncNWhmRMnXle+Sx3fKaJZzfvgYN/mVQJGK8JmEf+1c/a
	j1r7k7KvszF06IMqxkG4aEa5VSvMVQWABHOniAcjYTfMaL51ukmJEt4mogwcaGO2
	uGdQhss83FbggWUVfDMaOYA4YOFl/TLiXYIgCZ39VmnuMcMoA1/6DgEgKrlvF1XP
	k9JCyeX0NlF564K0fgGtxS0WPCJABm69WOLsbfEYPP15ArMOyTDYnLhD4zoAJlUw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805usv770-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 10:57:13 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56KAvCGF009625;
	Sun, 20 Jul 2025 10:57:12 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805usv76x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 10:57:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56KAtqZo024960;
	Sun, 20 Jul 2025 10:57:11 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480npt9qs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 10:57:11 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56KAvBOd27525886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 10:57:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 355D858052;
	Sun, 20 Jul 2025 10:57:11 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4214B58056;
	Sun, 20 Jul 2025 10:57:05 +0000 (GMT)
Received: from [9.43.55.199] (unknown [9.43.55.199])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Jul 2025 10:57:04 +0000 (GMT)
Message-ID: <cee2b280-a036-43b5-8ff8-6ec2a0b9356b@linux.ibm.com>
Date: Sun, 20 Jul 2025 16:27:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] sched/fair: Limit run to parity to the min slice
 of enqueued entities
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
        dhaval@gianis.ca, linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250708165630.1948751-1-vincent.guittot@linaro.org>
 <20250708165630.1948751-5-vincent.guittot@linaro.org>
 <5bbe61ee-d384-47b9-b6f2-c9f607f00156@linux.ibm.com>
 <CAKfTPtAYS3OV+udSncqVWHh7+PCQxL-_pnSGCJqJMr_nyTOXUA@mail.gmail.com>
 <20250710123435.GM1613376@noisy.programming.kicks-ass.net>
 <71bf9ee3-859c-4c3e-9db4-38c1ab35440a@linux.ibm.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <71bf9ee3-859c-4c3e-9db4-38c1ab35440a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDEwMiBTYWx0ZWRfX+JvMErXa3sOY
 CbKxE4Ozs0sJJTpTOrmrkRRcY6TmGlXjCxq4VPwv3PVSswhuJgY8Zb7F5B/8JPS+xz0jA3/1YdZ
 2ZdFigJlopFqk86DiNKdCMbuZS+QvM1jYII4zQUVOhjRJKPPCqXJpO7VJ0kLuB3Q8hSi+e83+m9
 mnKR1NRAx3rvoo1FLcMflTEOa4Zk66zYzN9/KViqluLj0efeuJ1l4rHAbeRIcFR4FEOTO3ypbHt
 s6sK6mnSeG7EZa5DCo7sILOQd0nGXvFNQ6pGa0a1LHNvg9Cf4bwFG+lGx/sac94U+00+BmODj3V
 zh735jinMrtTijIITVZu9rtiRzzMClUkOhKiUPZ69/ShV9/dQAjNJj+axvRv531eQ6ZM9nvwqr3
 8vtoB9JyQAPAlhdSdfZpCXh6XaI+GfBF1XjG7W6o05lvLVBnCPD464elcRBMiBYKwpgV07qe
X-Authority-Analysis: v=2.4 cv=Nd/m13D4 c=1 sm=1 tr=0 ts=687ccb89 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=LmcLtsNzV1WpfnEq:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=dQ8BquNh9TJFvUWgR2AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VumrDuCV6Dg291v9Y7AfP_WVij4xa37e
X-Proofpoint-GUID: g0vDM-jS7_X6UCuBpZTIBUH__6QSHvaY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 mlxlogscore=850 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200102

On 13/07/25 23:47, Madadi Vineeth Reddy wrote:
> Hi Vincent, Peter
> 
> On 10/07/25 18:04, Peter Zijlstra wrote:
>>
>>>> If I set my task’s custom slice to a larger value but another task has a smaller slice,
>>>> this change will cap my protected window to the smaller slice. Does that mean my custom
>>>> slice is no longer honored?
>>>
>>> What do you mean by honored ? EEVDF never mandates that a request of
>>> size slice will be done in one go. Slice mainly defines the deadline
>>> and orders the entities but not that it will always run your slice in
>>> one go. Run to parity tries to minimize the number of context switches
>>> between runnable tasks but must not break fairness and lag theorem.So
>>> If your task A has a slice of 10ms and task B wakes up with a slice of
>>> 1ms. B will preempt A because its deadline is earlier. If task B still
>>> wants to run after its slice is exhausted, it will not be eligible and
>>> task A will run until task B becomes eligible, which is as long as
>>> task B's slice.
>>
>> Right. Added if you don't want wakeup preemption, we've got SCHED_BATCH
>> for you.
> 
> Thanks for the explanation. Understood now that slice is only for deadline
> calculation and ordering for eligible tasks.
> 
> Before your patch, I observed that each task ran for its full custom slice
> before preemption, which led me to assume that slice directly controlled
> uninterrupted runtime.
> 
> With the patch series applied and RUN_TO_PARITY=true, I now see the expected behavior:
> - Default slice (~2.8 ms): tasks run ~3 ms each.
> - Increasing one task’s slice doesn’t extend its single‐run duration—it remains ~3 ms.
> - Decreasing one tasks’ slice shortens everyone’s run to that new minimum.
> 
> With this patch series, With NO_RUN_TO_PARITY, I see runtimes near 1 ms (CONFIG_HZ=1000).
> 
> However, without your patches, I was still seeing ~3 ms runs even with NO_RUN_TO_PARITY,
> which confused me because I expected runtime to drop to ~1 ms (preempt at every tick)
> rather than run up to the default slice.
> 
> Without your patches and having RUN_TO_PARITY is as expected. Task running till it's
> slice when eligible.
> 
> I ran these with 16 stress‑ng threads pinned to one CPU.
> 
> Please let me know if my understanding is incorrect, and why I was still seeing ~3 ms
> runtimes with NO_RUN_TO_PARITY before this patch series.
> 

Hi Vincent,

Just following up on my earlier question: with the patch applied (and RUN_TO_PARITY=true),
reducing one task’s slice now clamps the runtime of all tasks on that runqueue to the new
minimum.(By “runtime” I mean the continuous time a task runs before preemption.). Could this
negatively impact throughput oriented workloads where remaining threads need longer run time
before preemption? 

I understand that slice is only for ordering of deadlines but just curious about it's
effect in scenarios like this.

Thanks,
Madadi Vineeth Reddy

> Thanks,
> Madadi Vineeth Reddy


