Return-Path: <linux-kernel+bounces-722097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4762BAFD555
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071261AA6F68
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883F12DC32D;
	Tue,  8 Jul 2025 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VPJoWAsD"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491B02E5B3E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995770; cv=none; b=J4By7G+FJhMXarZ0FNh5U2sZrzRfATdNpETCsbX/SRxp2ORxtvgwFoh8bjXFr9D948zrRYwlmOWpvVm1KGMyZf4xMMl5Ui2anD7ZV6Hm+XNfPDsiuQWWpQTEIP3/EoVZHjzGtXxF5h03OhNH7AarR5s6rP+FZSeid2V8ZtVfxkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995770; c=relaxed/simple;
	bh=Huylt5ITl0TA86nZu9RAR3rikDw0tTXwGgtbeLTiTHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmSHCEKkXBmzUXL/Pn4txXljSnPQ/kkU9bRPX2bMt7ubou1nENPHU3RU3AF7v0VtnxiLnle+BhOOe9gZjbw1NeaY08r94Q6+8JIV1/Y2P/krsr8cy6oR55A3XgQUqxFVxgpLzWeGzT8QfZiG/HeQT07Qz+0r4zHmaDtbpUBy8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VPJoWAsD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568Flkt7030869;
	Tue, 8 Jul 2025 17:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e1xkx0
	Ho6LGte+UxbVuow+fmlu9x0ypNO2RXiafZoeY=; b=VPJoWAsDzmxUAJOzKckBIv
	lX+LyqLl+wmDOe1M2a6BLihaB3ppaa4SwaLPLc0cZZY/moMTyJxYPFZC81/3g0DY
	T7dxE/BgDfoZeCghAOlRAjZnY1IW+V/bC9b9kWnKIRcP/w8JEMshWKSQoRcHVdCA
	hRHgwEHW18jrHGrhCgb0MSXdrZUYas4CHO49aSA8G/4MnByex5KA5YedSjzjpHhv
	BDVmInV/gdFNdyYLWpVUmbbXtc8o4vsm6ta3/8AHf27rgvspirHCG4KPzoS6UyJc
	IYH2RGjLEwyscJr0mqq3oRhrJU75FUbedw++N5RRVxzDDWZ83J2tAVBxCCTBs+zg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk41h6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 17:29:13 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 568HMIZF031582;
	Tue, 8 Jul 2025 17:29:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puk41h6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 17:29:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 568E4XBv010841;
	Tue, 8 Jul 2025 17:29:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qes0473d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Jul 2025 17:29:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 568HT9rO56426762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Jul 2025 17:29:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F5AA20043;
	Tue,  8 Jul 2025 17:29:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1617A20040;
	Tue,  8 Jul 2025 17:29:07 +0000 (GMT)
Received: from [9.124.215.76] (unknown [9.124.215.76])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Jul 2025 17:29:06 +0000 (GMT)
Message-ID: <931f8673-a2b0-4b4e-8ae8-269b5a5c235d@linux.ibm.com>
Date: Tue, 8 Jul 2025 22:59:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] sched: Address schbench regression
To: Chris Mason <clm@meta.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com
References: <20250702114924.091581796@infradead.org>
 <132949bc-f901-40e6-a34c-d1d67d03d8b6@linux.ibm.com>
 <21eb2e07-7ac9-42ef-a8f7-15a01a3c1629@meta.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <21eb2e07-7ac9-42ef-a8f7-15a01a3c1629@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE0NiBTYWx0ZWRfXzzU9F2g7gLFJ COMHRJ6Ov+mJGFxG5DtnsIVJ1wUOTkHlJWzM0L8apynAJTq9pciO/YAoLPQkpuwo/ywTUVDDWWF tJ6Jj1ITxR2ietJap65aQXYRl1eEXJnzfjzQj0YRsOm7qXPyXaK4KHfGpDyynTQZNTHpnfeKckv
 zdyXWymXO3WbABXKpg1F8jqSU+EkMLQpUecjNS9Qr6TjdOAJXXZ5cDbOwL9XZHX5L+M/zVBcpjy 6XnR8R27fklahf/dOnQN3Mnlaig75hnaGGXi/tJLwAUiAeEbz+n3SisTzj/+pNkY0QjYy4FbwI9 3F3mmNKSA2LxeUSaVLchkDR+LNeYYZWZ9VZBa956PoLJ1HRiWTL1qbqCgeEYakBBVzzMFfCzZ48
 qEfgs71RNnx2mSNo/qz8GgfLu0OplchQpvbaLcbI+18cOMkvMVYUo8QCI/0YHPGYI0rfgodz
X-Authority-Analysis: v=2.4 cv=XYeJzJ55 c=1 sm=1 tr=0 ts=686d5569 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=FOH2dFAWAAAA:8 a=6cMEACPwkbmYPFGOAeUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: gFOfqVCVdzaz6O7iC1l_z_mW2qrcjM_8
X-Proofpoint-GUID: nqbJKTt2w2pZwbrYou5eQEA5mz70HTjI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 mlxlogscore=460 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080146



On 7/8/25 20:39, Chris Mason wrote:
> On 7/7/25 5:05 AM, Shrikanth Hegde wrote:
>>
>>
>> On 7/2/25 17:19, Peter Zijlstra wrote:
>>> Hi!
>>>
>>> Previous version:
>>>
>>>     https://lkml.kernel.org/r/20250520094538.086709102@infradead.org
>>>
>>> Changes:
>>>    - keep dl_server_stop(), just remove the 'normal' usage of it (juril)
>>>    - have the sched_delayed wake list IPIs do select_task_rq() (vingu)
>>>    - fixed lockdep splat (dietmar)
>>>    - added a few preperatory patches
>>>
>>>
>>> Patches apply on top of tip/master (which includes the disabling of
>>> private futex)
>>> and clm's newidle balance patch (which I'm awaiting vingu's ack on).
>>>
>>> Performance is similar to the last version; as tested on my SPR on
>>> v6.15 base:
>>>
>>
>>
>> Hi Peter,
>> Gave this a spin on a machine with 5 cores (SMT8) PowerPC system.
>>
>> I see significant regression in schbench. let me know if i have to test
>> different
>> number of threads based on the system size.
>> Will go through the series and will try a bisect meanwhile.
> 
> Not questioning the git bisect results you had later in this thread, but
> double checking that you had the newidle balance patch in place that
> Peter mentioned?
> 
> https://lore.kernel.org/lkml/20250626144017.1510594-2-clm@fb.com/
> 
> The newidle balance frequency changes the cost of everything else, so I
> wanted to make sure we were measuring the same things.
> 

Hi Chris.

It was base + series only. and base was 8784fb5fa2e0("Merge irq/drivers into tip/master").
So it didn't have your changes.

I tested again with your changes and i still see a major regression.


./schbench -L -m 4 -M auto -t 64 -n 0 -t 60 -i 60
Wakeup Latencies percentiles (usec) runtime 30 (s) (18848611 total samples)
	  50.0th: 115        (5721408 samples)
	  90.0th: 238        (7500535 samples)
	* 99.0th: 316        (1670597 samples)
	  99.9th: 360        (162283 samples)
	  min=1, max=1487

RPS percentiles (requests) runtime 30 (s) (31 total samples)
	  20.0th: 623616     (7 samples)
	* 50.0th: 629760     (15 samples)
	  90.0th: 631808     (7 samples)
	  min=617820, max=635475
average rps: 628514.30


git log --oneline
7aaf5ef0841b (HEAD) sched: Add ttwu_queue support for delayed tasks
f77b53b6766a sched: Change ttwu_runnable() vs sched_delayed
986ced69ba7b sched: Use lock guard in sched_ttwu_pending()
2c0eb5c88134 sched: Clean up ttwu comments
e1374ac7f74a sched: Re-arrange __ttwu_queue_wakelist()
7e673db9e90f psi: Split psi_ttwu_dequeue()
e2225f1c24a9 sched: Introduce ttwu_do_migrate()
80765734f127 sched: Add ttwu_queue controls
745406820d30 sched: Use lock guard in ttwu_runnable()
d320cebe6e28 sched: Optimize ttwu() / select_task_rq()
329fc7eaad76 sched/deadline: Less agressive dl_server handling
708281193493 sched/psi: Optimize psi_group_change() cpu_clock() usage
c28590ad7b91 sched/fair: bump sd->max_newidle_lb_cost when newidle balance fails
8784fb5fa2e0 (origin/master, origin/HEAD) Merge irq/drivers into tip/master


