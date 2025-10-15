Return-Path: <linux-kernel+bounces-854890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 705CCBDFB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB573C6C02
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BAA3376B0;
	Wed, 15 Oct 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qKChBuF+"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC5B29BDB9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546244; cv=none; b=Y1HKOboOt9Fozb3vZP5BN6uQmmw5jhniXlKd77r3u8mTUwdmO7q81367AbiGLgPugtzIUsdsveXEh2DspROg3TJBBEGMOEdLTBbTMS2WdsvmflNA38E3d0CBQyTch4hbYSAn5a+FY84rm0HA6PLujCJ3daOcawEYBoC4hHh2+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546244; c=relaxed/simple;
	bh=Ym3B/0H4USnvVL7IHlJUmg7fUVukV8KmIrHtGsUHGGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGD7a5aedz6IWy6DMDNbA78aT+c1CWCXMsclh7esV8NOHcFec/pdntNDNu8WRP/lUGKLXbqHhcBgKjXC2cyyQKrAAwMkHzlHF97ehsczLwL/UerAhtmGNkGUCUNg9+thvIoRi5cvwbADJ6OVINJuHqfsQwFh/tVUddG9QziB6LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qKChBuF+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FDhQK0021832;
	Wed, 15 Oct 2025 16:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BOt3zN
	h/px6+Lk6ezJYoXvE6qO/ttZQsZh8qIl1wPUg=; b=qKChBuF+BlPsTszV5TjC6Q
	erV9W9yx7QFHCQY2NYvwcPoqxqiU0qyh61evm96GOwBZzeEgetVvxnnNVCbhsJ1N
	EcJyFrSo2rehrmmrqOywg0Z9J1HZRxnh80u3na6njiVfyOa2QF2Xvk4HGkppvtaq
	yEoQQRz091ODP0tlq3S+A36vFtnpRgHl1SKaxe2GAAGsrT7HdfZibXczQCoX3ylj
	a/aMvwUVreuGxdMRjOpNLRKJrElktQOg6eSpo1LhpikbCrPvpOsxXo3UQ/9DWrmj
	YiFo5RjcO4NRfIhbpwm58zC5DtHpspBlW0imkgoazOA5/kWJd/cnHwSSJf1Qm1HQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew04usk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 16:36:48 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59FFjCRV028760;
	Wed, 15 Oct 2025 16:36:48 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew04usf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 16:36:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59FFBIAh015002;
	Wed, 15 Oct 2025 16:36:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjh4rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 16:36:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59FGajVr36110642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 16:36:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F67C200D2;
	Wed, 15 Oct 2025 16:36:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08ECB200D1;
	Wed, 15 Oct 2025 16:36:40 +0000 (GMT)
Received: from [9.124.218.242] (unknown [9.124.218.242])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Oct 2025 16:36:39 +0000 (GMT)
Message-ID: <6007f50a-7abd-46c8-8934-f1b09df57479@linux.ibm.com>
Date: Wed, 15 Oct 2025 22:06:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/19] sched/fair: Introduce a static key to enable cache
 aware only for multi LLCs
To: "Chen, Yu C" <yu.c.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
        Hillf Danton <hdanton@sina.com>, Jianyong Wu <jianyong.wu@outlook.com>,
        Yangyu Chen <cyy@cyyself.name>, Tingyin Duan <tingyin.duan@gmail.com>,
        Vern Hao <vernhao@tencent.com>, Len Brown <len.brown@intel.com>,
        Aubrey Li <aubrey.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Adam Li <adamli@os.amperecomputing.com>,
        Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <ef136e6a6f5a2ef840b1f9571c47411f04705b6a.1760206683.git.tim.c.chen@linux.intel.com>
 <20251015110450.GO3289052@noisy.programming.kicks-ass.net>
 <15b871f2-49b8-4b62-926d-31f93ad49f51@intel.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <15b871f2-49b8-4b62-926d-31f93ad49f51@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oEoAAacKuOuAvk2q1P9GGsqlbRJhBpKQ
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68efcda0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=hyIIqotkGnHO3MzI:21 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=vzhER2c_AAAA:8
 a=Rr0q3t3VzmWdSmMSGToA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=0YTRHmU2iG2pZC6F1fw2:22 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfXzbru1ZRddg5V
 pzyvRF0uYWUzqP+HvQbzIPsrncyWI9joBUaiUaW9l90wzjaNJh12L5g0UsMX6rLqQ2qqrDmHJtW
 GwZPbd7fSyVm0uZmyrQXng84jMfX7RC2dRHxDBHkmJAau7MyU6JkKij5ZDrOrwRu8j2eaOV09Tl
 pit5HY7lswkp5TxzQZ52bpzlb+8aazwJ/nq5gsV/IeUPMjTXECZ9utq9QWAYy1zN7L55fcN08Zs
 j3vDtK8FMZfiiwFdUzy/XKBUnPaXBbNcYlKfNOp0dhDLBNThd4pPQ2oRynjmew8UYt7cFmy6C9Y
 Vlmk7oaen4jfXxaXUdA40XsqyhWaSxWg6ssZojWSbGmm1m6MnDizO4zsP1vezTeUBBO3b1eQyfe
 1jaMEZv8sSsNSDpvYpOKu5lTefoOCw==
X-Proofpoint-GUID: -GKxfyfwXuPGca4oKq9HZkuNcv5J7QCS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014



On 10/15/25 9:55 PM, Chen, Yu C wrote:
> On 10/15/2025 7:04 PM, Peter Zijlstra wrote:
>> On Sat, Oct 11, 2025 at 11:24:41AM -0700, Tim Chen wrote:
>>> From: Chen Yu <yu.c.chen@intel.com>
>>>
>>> Enable cache-aware load balancing only if at least 1 NUMA node has
>>> more than one LLC.
>>>
>>> Suggested-by: Libo Chen <libo.chen@oracle.com>
>>> Suggested-by: Adam Li <adamli@os.amperecomputing.com>
>>> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>>> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
>>> ---
>>>   kernel/sched/fair.c     | 15 ++++++++++++---
>>>   kernel/sched/sched.h    |  1 +
>>>   kernel/sched/topology.c | 14 ++++++++++++--
>>>   3 files changed, 25 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index cd080468ddc9..3d643449c48c 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -1208,6 +1208,14 @@ static s64 update_se(struct rq *rq, struct 
>>> sched_entity *se)
>>>   __read_mostly unsigned int llc_overload_pct       = 50;
>>>   __read_mostly unsigned int llc_imb_pct            = 20;
>>> +DEFINE_STATIC_KEY_FALSE(sched_cache_allowed);
>>> +
>>> +static inline bool sched_cache_enabled(void)
>>> +{
>>> +    return sched_feat(SCHED_CACHE) &&
>>> +        static_branch_likely(&sched_cache_allowed);
>>> +}
>>
>> Urgh; do we really need _2_ static keys stacked for this? I'm thinking
>> one should be well enough.
> 
> SCHED_CACHE allows user space to turn on/off the feature at runtime,
> while sched_cache_allow is a hardware capability. This capability is

isn't it possible use only static_branch_likely(&sched_cache_allowed) at runtime?

Enable that key only if FEAT is set. Disable when unset.
That way you could use only one static branch at runtime.

Also, I am not sure if the FEATURE should be true by default. I know it maybe unused but
IMO it should be true by default only when its proven there are no regression.
One should be aware of their topology to enable it.
>   disabled if there are no multiple LLCs within one node. I’m not sure
> if using one key could support the above two scenarios.
>It is possible to have multiple NUMA nodes. One node may have multiple LLC while other
one may have only 1 LLC. what happens in that case?

I am yet to go through the series(hopefully this week). Maybe its handled already.

