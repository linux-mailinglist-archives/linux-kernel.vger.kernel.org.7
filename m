Return-Path: <linux-kernel+bounces-732226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E27A0B063AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDD41AA7A16
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C54F188A3A;
	Tue, 15 Jul 2025 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XUzVCwAM"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B8533D6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595219; cv=none; b=qmtOTmJqfk3JH3uoOdHdAIRgHZvc5kyHWZVjtMwyDdQMX0eCsfDW1JYd95prMGtpgAk8vWaSNDamGTydV3aq/BlYZ6Y1owkPdqr33iRiTO3sSlEmM6qo2y5ZoNbC20gu4GJsK4hiZyZExNIWNeiPDO7lwZGUx/Xapzx9ycyq+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595219; c=relaxed/simple;
	bh=qSaD5qlrxFDgSplAUFNkpRmFtNF1W2UGWVho/IWfTqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rb0EeXV97dTK55QkJFjZtUYQU0Dah02GrPlGUrDkAIeL3bXV0buRRec3c+aIz5stm07RNmA00QBLz0IGdI4Itawz0dTkXDxTBTN+/MeEclp1q64oOy+zftNsES4Os7Q4oSpRTxja9SjtmA4sgH3vZMHIprl+dxHui47/mpQSt/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XUzVCwAM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F96tdL012194;
	Tue, 15 Jul 2025 15:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=f+sG0I
	kaNelTXH812ghI/J/qEazKM0rs1vwlZTK51EM=; b=XUzVCwAMEYmx2zFzWT/7kL
	4ZQG2bw7otvJigIaGNZhw7EVVPs7PUVE7TKVwFQn5Y1T5ParPIFkBkzthFSaD0MU
	0CeNqN1To/Xs7BnRaJA4AxbC7T4M0eolGbg2fkDg0HsW02PDlt7nwc07DWfFq6qF
	Ba4aCvmEIsN7sUp55JeX1hAf74qZWzgfiwY4oF547+GQvgS8nDwnZUgFTBWnG0ol
	+IQWCWIQVRp3ctnqnu1IPVL4V7hC6NYv2fV5GbmGQd8AHoC29VCt9YI8Ys/atufq
	xT8qzmZB1e5hZO4E07qZnUyXMtb5QINrr72mB22KzZgweCSSdr0dekgweCqeiVEQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7d09p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 15:59:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56FD5IEx025517;
	Tue, 15 Jul 2025 15:59:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v31pk7cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 15:59:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56FFxc2323593712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 15:59:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAFBE20043;
	Tue, 15 Jul 2025 15:59:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6875C20040;
	Tue, 15 Jul 2025 15:59:35 +0000 (GMT)
Received: from [9.124.217.184] (unknown [9.124.217.184])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Jul 2025 15:59:35 +0000 (GMT)
Message-ID: <e0f58203-22ef-44c0-9f7b-b15c6007249b@linux.ibm.com>
Date: Tue, 15 Jul 2025 21:29:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] futex: Use RCU-based per-CPU reference counting
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>
References: <20250710110011.384614-1-bigeasy@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250710110011.384614-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YyrV1mJ5I-8Vl_aKzcrBWXQCUOSfU6uH
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=68767aed cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=WsHKUha7AAAA:8 a=E3QdD6O_K6KCv3zrH-QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-GUID: YyrV1mJ5I-8Vl_aKzcrBWXQCUOSfU6uH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE0NSBTYWx0ZWRfX4fybdKCsWwqI YvIrgLiC0eF9FZWtJKITZ+sRuK5cPX9O7i/WBzCkoSukDQwl6OmqiqHZKvJGwW6pkpdCA8GAu8K ikp0GKXioWebA/4LYTdMTsCeHm626olSSGtV27XjMxcRs0PDuk+08HmwSQyiaQIA2aVUDOt3nWA
 wtmJNF6AgTuLK07GZSDlwJfuJdNiAjoc2diEJD/DVie9NPpuWelw9+b4Dps/8433EPzPCJZ5QVN yhKSzAZBJJFeBQfD0zmkU6NmpSsChkZ+tIp/CebKt0XhCMd5DB1rdvrS26WyQ3oJyr4SfFFL1oL Xyqxr1RmogggpNIMmoYvH0bCgR2p+s1n7qrSlS1cWvveonYhZ41F8DhbFPzKpb2Ro8+oSKhl4d4
 iEFeF8z1JMCKcn8Bs0BTFmO/WalY7ll04ty2t6L4KYVcr5/9LObVfZW/S6om6SltBh72I/NJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150145



On 7/10/25 16:30, Sebastian Andrzej Siewior wrote:
> I picked up PeterZ futex patch from
>      https://lore.kernel.org/all/20250624190118.GB1490279@noisy.programming.kicks-ass.net/
> 
> and I am posting it here it now so it can be staged for v6.17.
> 
> This survived a few days on my machine and compile robot reported that
> is passes its tests.
> 
> v1…v2 https://lore.kernel.org/all/20250707143623.70325-1-bigeasy@linutronix.de
>   - Removed the IMMUTABLE bits
>   - There was a race if the application exits while the RCU callback is
>     pending. Stuffed with mmget()/ mmput_async().
> 
> Changes since its initial posting:
> - A patch description has been added
> - The testuite is "fixed" slightly different and has been split out
> - futex_mm_init() is fixed up.
> - The guard(preempt) has been replaced with guard(rcu) since there is
>    no reason to disable preemption.
> 
> Since it was not yet released, should we rip out the IMMUTABLE bits and
> just stick with GET/SET slots?
> 
> Peter Zijlstra (1):
>    futex: Use RCU-based per-CPU reference counting instead of rcuref_t
> 
> Sebastian Andrzej Siewior (5):
>    selftests/futex: Adapt the private hash test to RCU related changes
>    futex: Make futex_private_hash_get() static
>    futex: Remove support for IMMUTABLE
>    selftests/futex: Remove support for IMMUTABLE
>    perf bench futex: Remove support for IMMUTABLE
> 
>   include/linux/futex.h                         |  16 +-
>   include/linux/mm_types.h                      |   5 +
>   include/linux/sched/mm.h                      |   2 +-
>   include/uapi/linux/prctl.h                    |   2 -
>   init/Kconfig                                  |   4 -
>   kernel/fork.c                                 |   8 +-
>   kernel/futex/core.c                           | 281 ++++++++++++++----
>   kernel/futex/futex.h                          |   2 -
>   tools/include/uapi/linux/prctl.h              |   2 -
>   tools/perf/bench/futex-hash.c                 |   1 -
>   tools/perf/bench/futex-lock-pi.c              |   1 -
>   tools/perf/bench/futex-requeue.c              |   1 -
>   tools/perf/bench/futex-wake-parallel.c        |   1 -
>   tools/perf/bench/futex-wake.c                 |   1 -
>   tools/perf/bench/futex.c                      |  21 +-
>   tools/perf/bench/futex.h                      |   1 -
>   .../trace/beauty/include/uapi/linux/prctl.h   |   2 -
>   .../futex/functional/futex_priv_hash.c        | 113 +++----
>   18 files changed, 315 insertions(+), 149 deletions(-)
> 

Hi. Sorry for not stumble upon this earlier. Saw these now.

Since perf bench had shown a significant regression last time around, and
for which immutable option was added, gave perf futex a try again.

Below are the results: Ran on 5 core LPAR(VM) on power. perf was compiled from tools/perf.

===========
baseline:
===========
tip/master at
commit 8784fb5fa2e0042fe3b1632d4876e1037b695f56 (HEAD)
Author: Borislav Petkov (AMD) <bp@alien8.de>

./perf bench futex hash
Averaged 1559643 operations/sec (+- 0.09%), total secs = 10
Futex hashing: global hash

schbench -t 64 -r 5 -i 5
current rps: 2629.85

schbench -L -m 4 -M auto -t 64 -n 0 -r 5 -i 5
current rps: 1538674.22

=================
baseline + series
=================

./perf bench futex hash
Averaged 306403 operations/sec (+- 0.29%), total secs = 10    <<<  around 1/5th of baseline.
Futex hashing: auto resized to 256 buckets                    <<<  maybe resize doesn't happen fast?


./perf bench futex hash -b 512                                <<< Gave 512 buckets,
Averaged 1412543 operations/sec (+- 0.14%), total secs = 10   <<< much better numbers, still off by 8-10%.
Futex hashing: 512 hash buckets

(512 is the number of buckets that baseline would have used, increased the buckets to 8192 for trial)

./perf bench futex hash -b 8192
Averaged 1441627 operations/sec (+- 0.14%), total secs = 10
Futex hashing: 8192 hash buckets


schbench -t 64 -r 5 -i 5
current rps: 2656.85                                          <<< schbench seems good.

schbench -L -m 4 -M auto -t 64 -n 0 -r 5 -i 5
current rps: 1539273.79

