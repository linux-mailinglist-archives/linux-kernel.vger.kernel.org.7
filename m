Return-Path: <linux-kernel+bounces-739532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DDEB0C778
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02440174F29
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A7F2DECBC;
	Mon, 21 Jul 2025 15:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gPXFm/Gb"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B6B2DC33A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111394; cv=none; b=Vq5EKC5fSexKIBL8/k+osl8i94ASICh0sS6JOiEcfA07hVX8gEKAAyEEgd/K0ztRNmGKIkrO+7J57HXtlnuK0jsjZdsxK46/kcJG9baVWeA4b119hxpSInT9uP6lZKzlyAyNXLod9/IZIucyLaqyQoUUa6kf55tgUnj7KJFUwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111394; c=relaxed/simple;
	bh=oicr6RoFq5fUpp1pY4KleFnFlDOlmYDpZMK26uRSeV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KriVX21tGRs7oAF1cCz4NSUUSwnzc1eeGHcKaKWX/aGLFkFW3kZxwPF7k2HyhdJxWPzqXKCWF2OwS5UvXZsgIKmhFgaNrLEGXE4vQmCxIieGjw/ApOMf2IQwbaU99bgHSpYJgg+EjlRP3rcSrfzfvwkpa4P26XJzMA16G2Wfk98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gPXFm/Gb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LBDw5Q013798;
	Mon, 21 Jul 2025 15:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=anrf01
	QeeUHl/Tu6IhXNBFIbMGrW4/lKr0bP2cOYtNk=; b=gPXFm/GbVGp8GX1PBgbzrQ
	xilU9i5yLY2AiLdfgbyzs0wOM3y7MhggN8zJb6pib584D3ZV/fEfb2j3XGoQu2gE
	2I4JCrkO2BSd7gR6w98xgPMeY9//SAU/qsxs4lZt9vd0qNKpDK+kQhgtIEVu3Fl0
	aY76TM9+bZJws+bfvjoBdDT2tlMOuZXT6z04cuyvV3cz1shZxunIxYjPqChIVThv
	+KsGt0vFFMg01NVRuIHmd4F0nB1OsQ7JMyAQfkXd62nBDJE34GkPy2CsFOd5BAc1
	QmT4XHSWxTDYLrnbi3JJQSnSSN88MdhgnUOVZf+EcaEJA6DL9SJcOkOQO+a2AyOQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805ut1fdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 15:22:25 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56LFMOYU022018;
	Mon, 21 Jul 2025 15:22:24 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805ut1fdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 15:22:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56LBvMOM024972;
	Mon, 21 Jul 2025 15:22:23 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480nptex0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 15:22:23 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56LFMMGL30343742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 15:22:22 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41B5458065;
	Mon, 21 Jul 2025 15:22:22 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A34258059;
	Mon, 21 Jul 2025 15:22:16 +0000 (GMT)
Received: from [9.43.2.242] (unknown [9.43.2.242])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Jul 2025 15:22:16 +0000 (GMT)
Message-ID: <f278e055-fdc7-48bb-8afe-878445258a39@linux.ibm.com>
Date: Mon, 21 Jul 2025 20:52:07 +0530
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
 <cee2b280-a036-43b5-8ff8-6ec2a0b9356b@linux.ibm.com>
 <CAKfTPtCNkqp87j8mAKbfBS+Pk=YWv9qQf9VE4=AkqPu9YCR=Kw@mail.gmail.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <CAKfTPtCNkqp87j8mAKbfBS+Pk=YWv9qQf9VE4=AkqPu9YCR=Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzNSBTYWx0ZWRfXwbHnSjk+cvGk
 ZnJ/IqkgCvIlpu/4LA28PgQzrbHgcnMnA9R1YiD/1xX5ZKFABtlcDIGUG6LiWIsW5PfFSwkxvjb
 /vroFrnzqIpdsLku7SPg+OHMxfVcxGoDlV/ugyEHMXt4JkKt9iRgaaj5bVw1M5CQ4IuIb70fQbH
 Cu6qtn9bbppXjiOfrTh6532juP7Rkws16PLhsqaCndsakvTI+A7wcui4LUWBtgwOnry73z+dsfZ
 +wnlNakkGArvW0OviVWhXwkX2LdFsJwKnsFVc2J0nuTSl3PRCsUNUI/wHOYn7XaDmqN4LT5fq20
 WYQ1kaRdffweMMQ+0kIDaEUy7IKhCqd0E/Y4er4uWs79v1F0F05SxK9C2yAi13KHvfuycUZlGem
 w1Wb7aOPkQzRiUd08cXtXft5qqGur1OtuBwDI6Ijcx1AkZ0zwWcLjc8bC8yoVnZerNJu1Evr
X-Authority-Analysis: v=2.4 cv=Nd/m13D4 c=1 sm=1 tr=0 ts=687e5b31 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=LmcLtsNzV1WpfnEq:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8
 a=_t28vcK501OQvQiiYUYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kMt9pCak_Q98YMHGARs8ztSe4Y0uLYnY
X-Proofpoint-GUID: OECk1UcG0CrT2bzIuxjkzVMy5jKpRnDO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 mlxlogscore=787 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210135

Hi Vincent,

On 21/07/25 14:41, Vincent Guittot wrote:
> On Sun, 20 Jul 2025 at 12:57, Madadi Vineeth Reddy
> <vineethr@linux.ibm.com> wrote:
>>
>> On 13/07/25 23:47, Madadi Vineeth Reddy wrote:
>>> Hi Vincent, Peter
>>>
>>> On 10/07/25 18:04, Peter Zijlstra wrote:
>>>>
>>>>>> If I set my task’s custom slice to a larger value but another task has a smaller slice,
>>>>>> this change will cap my protected window to the smaller slice. Does that mean my custom
>>>>>> slice is no longer honored?
>>>>>
>>>>> What do you mean by honored ? EEVDF never mandates that a request of
>>>>> size slice will be done in one go. Slice mainly defines the deadline
>>>>> and orders the entities but not that it will always run your slice in
>>>>> one go. Run to parity tries to minimize the number of context switches
>>>>> between runnable tasks but must not break fairness and lag theorem.So
>>>>> If your task A has a slice of 10ms and task B wakes up with a slice of
>>>>> 1ms. B will preempt A because its deadline is earlier. If task B still
>>>>> wants to run after its slice is exhausted, it will not be eligible and
>>>>> task A will run until task B becomes eligible, which is as long as
>>>>> task B's slice.
>>>>
>>>> Right. Added if you don't want wakeup preemption, we've got SCHED_BATCH
>>>> for you.
>>>
>>> Thanks for the explanation. Understood now that slice is only for deadline
>>> calculation and ordering for eligible tasks.
>>>
>>> Before your patch, I observed that each task ran for its full custom slice
>>> before preemption, which led me to assume that slice directly controlled
>>> uninterrupted runtime.
>>>
>>> With the patch series applied and RUN_TO_PARITY=true, I now see the expected behavior:
>>> - Default slice (~2.8 ms): tasks run ~3 ms each.
>>> - Increasing one task’s slice doesn’t extend its single‐run duration—it remains ~3 ms.
>>> - Decreasing one tasks’ slice shortens everyone’s run to that new minimum.
>>>
>>> With this patch series, With NO_RUN_TO_PARITY, I see runtimes near 1 ms (CONFIG_HZ=1000).
>>>
>>> However, without your patches, I was still seeing ~3 ms runs even with NO_RUN_TO_PARITY,
>>> which confused me because I expected runtime to drop to ~1 ms (preempt at every tick)
>>> rather than run up to the default slice.
>>>
>>> Without your patches and having RUN_TO_PARITY is as expected. Task running till it's
>>> slice when eligible.
>>>
>>> I ran these with 16 stress‑ng threads pinned to one CPU.
>>>
>>> Please let me know if my understanding is incorrect, and why I was still seeing ~3 ms
>>> runtimes with NO_RUN_TO_PARITY before this patch series.
>>>
>>
>> Hi Vincent,
>>
>> Just following up on my earlier question: with the patch applied (and RUN_TO_PARITY=true),
>> reducing one task’s slice now clamps the runtime of all tasks on that runqueue to the new
>> minimum.(By “runtime” I mean the continuous time a task runs before preemption.). Could this
>> negatively impact throughput oriented workloads where remaining threads need longer run time
>> before preemption?
> 
> Probably, it is also expected that tasks which have shorter slices,
> don't want to run forever. The shorter runtime will only apply while
> the task is runnable and this task should run 1st or almost and go
> back to sleep so its impact should be small. I agree that if you have
> an always running task which sets its slice to 1ms it will increase
> number of context switch for other tasks which don't have a longer
> slice but we can't do much against that
> 
>>
>> I understand that slice is only for ordering of deadlines but just curious about it's
>> effect in scenarios like this.

Understood, thank you for the clarification. Since fairness is the first priority, I see
that there's not much that can be done in the "always running" case.

Thanks again for the detailed explanation.

Thanks,
Madadi Vineeth Reddy

>>
>> Thanks,
>> Madadi Vineeth Reddy
>>
>>> Thanks,
>>> Madadi Vineeth Reddy
>>


