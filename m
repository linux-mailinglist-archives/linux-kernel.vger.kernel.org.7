Return-Path: <linux-kernel+bounces-724383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBE9AFF1F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9217E4840F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF1123FC41;
	Wed,  9 Jul 2025 19:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VVgHW7yD"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201CB23B63F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752089994; cv=none; b=R06RBXxZW9ZZYC0Q4b+GS9SnwWw54IfXCF85d3HZMe3POz/T8L4HHnHt97S/Zvrq4yf1R0eLFDQCZcDUfqCG+qiazmE9UbWsm7s/YmyeTpgG5H5aMAIbMW35JTr+ypZR3p1NshVqdBVKQv81vJ03VxMe4WVDdSFoM++VDfTEStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752089994; c=relaxed/simple;
	bh=OhL7FzdGS/A3f3C7XEUl6XaEj6zTDtxPxExMi1haswQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ul2H6+Cwot+FXcQCSk+cR3VIRU128QRDXPjOD+y0V+EogGrH4zf9f2Em9tBXS51rNFhOziqqL+Mr56Fip6ACFc1iKpn0BKXBINksDMkKmlr72YXG604OQXFs7RpgrMAFTA3mvjwoA0nvLldA522a0ammpE7BVmKedZAlXPwvhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VVgHW7yD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569HPUdr000853;
	Wed, 9 Jul 2025 19:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NyYapI
	sHEbAqOn2CnZTf+9xBZbWhyp31WiyBgcKtNTo=; b=VVgHW7yDcjJgop1bfXmzZ4
	vWGE68wuf1v8zTh9R0k+BeM3EOJmFe7SpWko0Ng6+dW8xK+H9buC7xfE2ESgmskE
	TOuO0C8848JQz3+iW4J5/F8USIoKEnOfuMf5dnG+s5Aaic1GBn59aR5BKNCOTkkx
	M3ouJZHPKWlKitZHyA7A4wFv/3G9cdZpPeA+unW0qDOXx5shR+nrBkpB/HUV2RYy
	hLgo21NKnNeRoo8M6RsnKX9g1yalZEE+XrhAJ55WWfzllmia6E2WB6+npQ6ZHX/N
	62abZqps8yYBojZNCemeyDgYBDnQT1n3nqNpVfScWdnGkH8U78m0TvzZrvaJQY4w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puqnfg1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 19:39:27 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 569JPNK4025083;
	Wed, 9 Jul 2025 19:39:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puqnfg1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 19:39:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569Ja2wJ024353;
	Wed, 9 Jul 2025 19:39:25 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh32hhb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 19:39:25 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569JdIUZ16253562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 19:39:19 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE2615803F;
	Wed,  9 Jul 2025 19:39:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F0A558054;
	Wed,  9 Jul 2025 19:39:16 +0000 (GMT)
Received: from [9.43.126.152] (unknown [9.43.126.152])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 19:39:16 +0000 (GMT)
Message-ID: <8f6c7c69-b6b3-4c82-8db3-96757f09245f@linux.ibm.com>
Date: Thu, 10 Jul 2025 01:09:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: Re: [RFC patch v3 00/20] Cache aware scheduling
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Vincent Guittot
 <vincent.guittot@linaro.org>,
        Libo Chen <libo.chen@oracle.com>, Abel Wu <wuyun.abel@bytedance.com>,
        Hillf Danton <hdanton@sina.com>, Len Brown <len.brown@intel.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <cover.1750268218.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
In-Reply-To: <cover.1750268218.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FZ43xI+6 c=1 sm=1 tr=0 ts=686ec56f cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=WsHKUha7AAAA:8 a=QyXUC8HyAAAA:8 a=RTJj0j5lB8TR8mIImT0A:9
 a=QEXdDO2ut3YA:10 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-GUID: spmGvXaltdDvVpG2TM1JnweB2ayp9zdf
X-Proofpoint-ORIG-GUID: mvSeLkomLDobr5J-eY9HBn9lz3Oqnl3q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE3MyBTYWx0ZWRfX6sxCQnsEOywG 70tsHgc+sY1xLvBe0rCjbd/lRShkCd1Xj7ke/3bSyL3HgeuDOvRBlgUwsV8jk6Zo5cuEznCjcgb n+j752V+2L7IUisNGUxOkSKPoTYGE90J6wMny/6wtnsr4Ro7lyLq2HoXpSppkUdcbBQyCOILQQ2
 VLQYJMqFEt93qQmkFZjtgvBdy7AsOxzxJYDV5qSc3O+utzKhgK/iZyfLkPdXoLcdpuchhkeAqqm 1JohYsXsC/gCvsafj7bsGw6VNysF+w8ccG+K2V1X9NosyQ1uS0HdhMf5kyrqofr75MupG/av1A6 8iNpPiFvWJ6exN+qkI+RWucTfnmiIVjm9muEF6k2xPnIj+aCKB8sifTyrfq6lfxN+3dTjYFRuxa
 FO7vXX9AGAdqGvZBkmxvxW0B42CGoEFcDF+66WAA96B1UWYCH+PjyGymuIszBJsvNRn+nlkh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=863 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090173

On 18/06/25 23:57, Tim Chen wrote:
> This is the third revision of the cache aware scheduling patches,
> based on the original patch proposed by Peter[1].
>  
> The goal of the patch series is to aggregate tasks sharing data
> to the same cache domain, thereby reducing cache bouncing and
> cache misses, and improve data access efficiency. In the current
> implementation, threads within the same process are considered
> as entities that potentially share resources.

[..snip..]

> 
> Comments and tests are much appreciated.

When running ebizzy as below:
ebizzy -t 8 -S 10

I see ~24% degradation on the patched kernel, due to higher SMT2 and
SMT4 cycles compared to the baseline. ST cycles decreased.

Since both P10 and P11 have LLC shared at the SMT4 level, even spawning
fewer threads easily crowds the LLC with the default llc_aggr_cap value
of 50. Increasing this value would likely make things worse, while
decreasing it to 25 effectively disables cache-aware scheduling
(as it limits selection to just one CPU).

I understand that ebizzy itself doesn't benefit from cache sharing, so
it might not improve but here it actually *regresses*, and the impact
may be even larger on P10 /P11 because of its smaller LLC shared by 4
CPUs, even with fewer threads. IPC drops.

By default, the SCHED_CACHE feature is enabled. Given these results for
workloads that don't share cache and on systems with smaller LLCs, I think
the default value should be revisited.

Thanks,
Madadi Vineeth Reddy

> 
> [1] https://lore.kernel.org/all/20250325120952.GJ36322@noisy.programming.kicks-ass.net/
> 
> The patches are grouped as follow:
> Patch 1:     Peter's original patch.
> Patch 2-5:   Various fixes and tuning of the original v1 patch.
> Patch 6-12:  Infrastructure and helper functions for load balancing to be cache aware.
> Patch 13-18: Add logic to load balancing for preferred LLC aggregation.
> Patch 19:    Add process LLC aggregation in load balancing sched feature.
> Patch 20:    Add Process LLC aggregation in wake up sched feature (turn off by default).
> 
> v1:
> https://lore.kernel.org/lkml/20250325120952.GJ36322@noisy.programming.kicks-ass.net/
> v2:
> https://lore.kernel.org/lkml/cover.1745199017.git.yu.c.chen@intel.com/
> 
> 
> Chen Yu (3):
>   sched: Several fixes for cache aware scheduling
>   sched: Avoid task migration within its preferred LLC
>   sched: Save the per LLC utilization for better cache aware scheduling
> 
> K Prateek Nayak (1):
>   sched: Avoid calculating the cpumask if the system is overloaded
> 
> Peter Zijlstra (1):
>   sched: Cache aware load-balancing
> 
> Tim Chen (15):
>   sched: Add hysteresis to switch a task's preferred LLC
>   sched: Add helper function to decide whether to allow cache aware
>     scheduling
>   sched: Set up LLC indexing
>   sched: Introduce task preferred LLC field
>   sched: Calculate the number of tasks that have LLC preference on a
>     runqueue
>   sched: Introduce per runqueue task LLC preference counter
>   sched: Calculate the total number of preferred LLC tasks during load
>     balance
>   sched: Tag the sched group as llc_balance if it has tasks prefer other
>     LLC
>   sched: Introduce update_llc_busiest() to deal with groups having
>     preferred LLC tasks
>   sched: Introduce a new migration_type to track the preferred LLC load
>     balance
>   sched: Consider LLC locality for active balance
>   sched: Consider LLC preference when picking tasks from busiest queue
>   sched: Do not migrate task if it is moving out of its preferred LLC
>   sched: Introduce SCHED_CACHE_LB to control cache aware load balance
>   sched: Introduce SCHED_CACHE_WAKE to control LLC aggregation on wake
>     up
> 
>  include/linux/mm_types.h       |  44 ++
>  include/linux/sched.h          |   8 +
>  include/linux/sched/topology.h |   3 +
>  init/Kconfig                   |   4 +
>  init/init_task.c               |   3 +
>  kernel/fork.c                  |   5 +
>  kernel/sched/core.c            |  25 +-
>  kernel/sched/debug.c           |   4 +
>  kernel/sched/fair.c            | 859 ++++++++++++++++++++++++++++++++-
>  kernel/sched/features.h        |   3 +
>  kernel/sched/sched.h           |  23 +
>  kernel/sched/topology.c        |  29 ++
>  12 files changed, 982 insertions(+), 28 deletions(-)
> 


