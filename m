Return-Path: <linux-kernel+bounces-812301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4969DB535DC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5562C1884255
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDF433EAFB;
	Thu, 11 Sep 2025 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ljlHC1A9"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2926C214A8B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601505; cv=none; b=GG94inniC70E2iwZPqcdYFRbC4pN2vVmK8ql/BKWmgA1OwEkKT/sF/lmZKqsXBCIEGyZlY2+q951DmNGpMuYfiOSRhyxWZ7HxDSKi10cQFAHstKtlvfGskZ3LHp5dMFAPCDFDP1zhYz/RdzCLG8wCdIY8JBhls+vM/KP1/jUef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601505; c=relaxed/simple;
	bh=gcBJssQhyGpxfwuSrDQk1DBIdTnWQiEdUdoDy8scbRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YhpcU1JK6e5zH7rBrvuUh9eUWYlwZWO3hb+Sjaxlfpb+PtwtRjkqPGzbEXVf/xa1rKr2ITmRqrrwXCJrTD+Fzf8aQVqQ+CAjlXhOeIF9A66jMroFm1Qzcd7grui/NnLo2MeY4UjlARq7lM4FLndeEuJ10NNTbKXaybEFvleHJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ljlHC1A9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B8i1JG003804;
	Thu, 11 Sep 2025 14:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8E4za3
	cgBD/qHg6HrhjRiAOm8JdBVvYrIkWytWTR8TU=; b=ljlHC1A9iKAWpeFkl/sboT
	qKJ7fvcGeGN7VpcnRXr8Cj4y+4ZmRJbvKcs6Z2dfpaBlLpvIhEiyFRhiaW2dOyoQ
	g/rBmIq4MvLkmWTZsgQKlANAnq+2frzxnHEhUMz7bb0MPM9sfO7/P2jojeyolhpg
	J43QmAORl6cDMQHuKZbvklgNiKyaRMbRFk1UhpjHYT5uQAxNMEMLiJkwbJfYjloW
	Xjcnq0QKpUl93bdHLUpTyLxIDxa2o5A6/IBKRamlQVPGujDOKFVELRL5lhA+49gy
	aRxcWE9P4zXPxay6nDajht9wzA/HHs8AmuU1Dxkzx8BexAWf0AGM/+Rve1gDB7AA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyda4kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 14:38:02 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BEPWZm003808;
	Thu, 11 Sep 2025 14:38:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyda4kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 14:38:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDgOSL010604;
	Thu, 11 Sep 2025 14:38:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910sn673b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 14:38:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BEbuob52167128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:37:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BFF820040;
	Thu, 11 Sep 2025 14:37:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 300F52004B;
	Thu, 11 Sep 2025 14:37:48 +0000 (GMT)
Received: from [9.61.95.215] (unknown [9.61.95.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 14:37:47 +0000 (GMT)
Message-ID: <b751b212-c4a5-4e7e-ad0f-df8cd3de19f7@linux.ibm.com>
Date: Thu, 11 Sep 2025 20:07:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 03/10] sched: Static key to check paravirt cpu push
To: Yury Norov <yury.norov@gmail.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, maddy@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        gregkh@linuxfoundation.org, vschneid@redhat.com, iii@linux.ibm.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        vineeth@bitbyteword.org, jgross@suse.com, pbonzini@redhat.com,
        seanjc@google.com
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
 <20250910174210.1969750-4-sshegde@linux.ibm.com> <aMIrgI9J4fuXntRz@yury>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aMIrgI9J4fuXntRz@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4-s6qgzZ4_xAyJU5GDYQ-xHSct33ia7x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX77wIAqGq1zVd
 Z32/B5q/79s9DCEy1gVTVkPmFkssIw54e57ttoLUy0hvUX7dKnnpGzAtOg9Wodk9ObOVPVwe2hO
 xQH6GKODcQjyr8dumwMZMELDeSrzmwA0ivCtaa12X/BkAgE/kTbScTLnZQBarGvu9aHZucyNMig
 SYWT9LbbwAFzrQQmPicOHZxOh5aSKS1xy6f/53r2nJAQ3P16Z5NCAMRBGYO+6PLcUVNirLchm/h
 y7bIAWtbX2EAyzI3CyH886xBwpJ9KnmlqJmx/zQuPetUtwIOrpreunBZpErrfI6OvWEOWbocrOw
 38CR9SyVCTqw9A7EtxEtQCIIpJyzQhFsTmLxoZjDsj+D9HVLUvVSawrWBy2OHk3WHiDU5J5OS08
 vhtxBee+
X-Proofpoint-GUID: Yt9om58zlIVtqpVI4MU_7ppkAEDadAp1
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c2deca cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=RFDGOpT60TssK192s-MA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235



On 9/11/25 7:23 AM, Yury Norov wrote:
> On Wed, Sep 10, 2025 at 11:12:03PM +0530, Shrikanth Hegde wrote:
>> CPUs are marked paravirt when there is contention for underlying
>> physical CPU.
>>
>> The push mechanism and check for paravirt CPUs are in sched tick
>> and wakeup. It should be close to no-op when there is no need for it.
>> Achieve that using static key.
>>
>> Architecture needs to enable this key when it decides there are
>> paravirt CPUs. Disable it when there are no paravirt CPUs.
> 

Hi Yury, Thanks for looking into this series.

> Testing a bit is quite close to a no-op, isn't it? Have you measured
> the performance impact that would advocate the static key? Please
> share some numbers then. I believe I asked you about it on the previous
> round.

The reasons I thought to keep are:

1. In load balance there is cpumask_and which does a loop.
Might be better to avoid it when it is not necessary.

2. Since __cpu_paravirt_mask is going to in one of the memory node in large NUMA systems
(likely on boot cpu node), access to it from other nodes might take time and costly when
it is not in cache. one could say same for static key too. but cpumask can be large when
NR_CPUS=8192 or so.


In most of the cases hackbench,schbench didn't show much difference.

> 
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   kernel/sched/core.c  |  1 +
>>   kernel/sched/sched.h | 17 +++++++++++++++++
>>   2 files changed, 18 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 0f1e36bb5779..b8a84e4691c8 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -10967,4 +10967,5 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
>>   #ifdef CONFIG_PARAVIRT
>>   struct cpumask __cpu_paravirt_mask __read_mostly;
>>   EXPORT_SYMBOL(__cpu_paravirt_mask);
>> +DEFINE_STATIC_KEY_FALSE(cpu_paravirt_push_tasks);
>>   #endif
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index b5367c514c14..8f9991453d36 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -3880,4 +3880,21 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
>>   
>>   #include "ext.h"
>>   
>> +#ifdef CONFIG_PARAVIRT
>> +DECLARE_STATIC_KEY_FALSE(cpu_paravirt_push_tasks);
>> +
>> +static inline bool is_cpu_paravirt(int cpu)
>> +{
>> +	if (static_branch_unlikely(&cpu_paravirt_push_tasks))
>> +		return cpu_paravirt(cpu);
>> +
>> +	return false;
>> +}
> 
> So is_cpu_paravirt and cpu_paravirt are exactly the same in terms of
> functionality. If you really believe that static branch benefits the
> performance, it should go straight to the cpu_paravirt().
> 
>> +#else	/* !CONFIG_PARAVIRT */
>> +static inline bool is_cpu_paravirt(int cpu)
>> +{
>> +	return false;
>> +}
>> +#endif	/* !CONFIG_PARAVIRT */
>> +
>>   #endif /* _KERNEL_SCHED_SCHED_H */
>> -- 
>> 2.47.3


