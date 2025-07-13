Return-Path: <linux-kernel+bounces-729159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2636B0329D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 20:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4062176BB3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 18:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C78285419;
	Sun, 13 Jul 2025 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nFu3rh+R"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4984915B0EF
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752430680; cv=none; b=SzD4zD7EBhXbXiaTy16uniOSOv0Gxh7tVoG3J0h7uc8gnamixzMvBezvXnUlZhckbdiHLQqfnIF9hfBWiSYJBaLuJWUj9si6J84w+qbhCUJwUYy66z6AQtFw580Xl7rT4Gxf82R2INOv4IgJj/E9508UY0gl6DjUZQ+/HQerD4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752430680; c=relaxed/simple;
	bh=23bYENTlYrPlihLxDvSntwg0TiLPIQg0juuj3zPUQBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U12Os8D0FU4vZboM0jM2TEzXMiwJjrNCRbRlLp2znfF+euLThjQ87fnchrSx5vfGFWjNob1C7kOxs4lmPeOxS27FMV45Ec33GsrGNe8bMBT/kdlLwmeLcRr0wAzWdSPPspfwop/0ULq67L7xwXDb1r4IKUxu9iVi+gey6wRqLmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nFu3rh+R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DAM25w024900;
	Sun, 13 Jul 2025 18:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QWUlpY
	FVB+HrYgitrXB2rrip/yZF8UEF2OQ5B7vKgNA=; b=nFu3rh+R/J0zQ1qp81guqG
	WjCD+kTpQDSJkTTxf7owdfB6VwbeEXzhKIDygyTNh5eO7/AzI5Dx4gc8S/VHE3Fg
	PJoxT2EQWnomAoRk07y3ZshcD3oPf0W4aJEOwaZ3bn3WgXaUfAC5O8ccB86vqluG
	krkiQ20w3nbRsiD9D7TiqM4LZNm5iPKasyWh4rL5zd7dD9AUSube5PW8a/YaWINT
	QGC1cygj+OI2j+c9Z5woMsS8RIm2gdnRnPfPHCQypJNjnLIxJ49LOesocoEpVwFg
	pDp8623Hzkr05fvJHPFWX5HSbFk6v6PitVY5S1RRUYWA2ZQ30oGOjRMtS7jJ9rMg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tnsaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 18:17:35 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56DIHZ9a002373;
	Sun, 13 Jul 2025 18:17:35 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tnsau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 18:17:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56DEZ0p9021972;
	Sun, 13 Jul 2025 18:17:34 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r2taqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 18:17:34 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56DIHX0E11207386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Jul 2025 18:17:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55D9558051;
	Sun, 13 Jul 2025 18:17:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D3185805A;
	Sun, 13 Jul 2025 18:17:27 +0000 (GMT)
Received: from [9.43.115.180] (unknown [9.43.115.180])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 13 Jul 2025 18:17:26 +0000 (GMT)
Message-ID: <71bf9ee3-859c-4c3e-9db4-38c1ab35440a@linux.ibm.com>
Date: Sun, 13 Jul 2025 23:47:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] sched/fair: Limit run to parity to the min slice
 of enqueued entities
To: Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, dhaval@gianis.ca, linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250708165630.1948751-1-vincent.guittot@linaro.org>
 <20250708165630.1948751-5-vincent.guittot@linaro.org>
 <5bbe61ee-d384-47b9-b6f2-c9f607f00156@linux.ibm.com>
 <CAKfTPtAYS3OV+udSncqVWHh7+PCQxL-_pnSGCJqJMr_nyTOXUA@mail.gmail.com>
 <20250710123435.GM1613376@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250710123435.GM1613376@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=6873f83f cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=LmcLtsNzV1WpfnEq:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=AR8wSN-9fXSpI2d3VK0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lz0nWrApoh1emOciOp8JoDbRGRfHUvXJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDEyOCBTYWx0ZWRfX3UfrjTYBMY3Y xUJPvkvk/Jg1gyLWadEHa2vV6bjl4V8lCjV0T3Ny8Xd8i9B1zh7aTE8BJjCqG2HjfWaTmYseAzu nG4Rp2+fVK4eZQYVZTyL8E0DmvFQwUXQURIwY3Z1DJ6Vbg61uVyFwRqdC2LlKLiYb+h4E4OuBtX
 1Fz90lFkBG+Oq9zNzwxxIFxacea7fd5CBGuEyAFb9K7vC2L+EgeEUUqIX+Mp9XHp+tc56SDr+Bj N6JcLXlpEUux+hs7Dtxxwoe+q/tZqCRsMSrRzvZyoMfDmQViBL4C6dFz9Ox6w7ZGH0nBodXjL75 pdCsCxqhRXSleVBSpHhtbRZHIHBTIxLLNouqxYtXxznZ/VlN1O9trLJYKNnRxU7skDFduKtofOt
 JEKsKauh2gOV/gYGKpVL0VxMZvG+q8YXyLFnaQwoBMxmq4pjkt2EeknI+ocisOdEStKLWloC
X-Proofpoint-ORIG-GUID: 8icpRCWWgwyedDycXUVlqIdS8bZ0nWDH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=961
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507130128

Hi Vincent, Peter

On 10/07/25 18:04, Peter Zijlstra wrote:
> 
>>> If I set my task’s custom slice to a larger value but another task has a smaller slice,
>>> this change will cap my protected window to the smaller slice. Does that mean my custom
>>> slice is no longer honored?
>>
>> What do you mean by honored ? EEVDF never mandates that a request of
>> size slice will be done in one go. Slice mainly defines the deadline
>> and orders the entities but not that it will always run your slice in
>> one go. Run to parity tries to minimize the number of context switches
>> between runnable tasks but must not break fairness and lag theorem.So
>> If your task A has a slice of 10ms and task B wakes up with a slice of
>> 1ms. B will preempt A because its deadline is earlier. If task B still
>> wants to run after its slice is exhausted, it will not be eligible and
>> task A will run until task B becomes eligible, which is as long as
>> task B's slice.
> 
> Right. Added if you don't want wakeup preemption, we've got SCHED_BATCH
> for you.

Thanks for the explanation. Understood now that slice is only for deadline
calculation and ordering for eligible tasks.

Before your patch, I observed that each task ran for its full custom slice
before preemption, which led me to assume that slice directly controlled
uninterrupted runtime.

With the patch series applied and RUN_TO_PARITY=true, I now see the expected behavior:
- Default slice (~2.8 ms): tasks run ~3 ms each.
- Increasing one task’s slice doesn’t extend its single‐run duration—it remains ~3 ms.
- Decreasing one tasks’ slice shortens everyone’s run to that new minimum.

With this patch series, With NO_RUN_TO_PARITY, I see runtimes near 1 ms (CONFIG_HZ=1000).

However, without your patches, I was still seeing ~3 ms runs even with NO_RUN_TO_PARITY,
which confused me because I expected runtime to drop to ~1 ms (preempt at every tick)
rather than run up to the default slice.

Without your patches and having RUN_TO_PARITY is as expected. Task running till it's
slice when eligible.

I ran these with 16 stress‑ng threads pinned to one CPU.

Please let me know if my understanding is incorrect, and why I was still seeing ~3 ms
runtimes with NO_RUN_TO_PARITY before this patch series.

Thanks,
Madadi Vineeth Reddy

