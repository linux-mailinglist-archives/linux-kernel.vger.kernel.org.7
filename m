Return-Path: <linux-kernel+bounces-855079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938B6BE02BE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465113ABEDC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B07C3254AC;
	Wed, 15 Oct 2025 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aIHGqwak"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7243254A9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552853; cv=none; b=tPL0uNhnrZs59Fbokp7rV1yl1pP94VbjC5R/NievbZ0YxaFl3LTZDrm5Omi8bnw1NUL9yVXEdeTmfgaDLuavk3sT6nhdK4g6pI7ubbQLdffgsh7eUGm3CFCIsH81Z1GU4V/A8l8zHHjrZAeP5YCLoV16+rnSPDXqk0rJ25tW7i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552853; c=relaxed/simple;
	bh=FUmjZrDMQUL++e4KRBTe1cVE3aPL9T940WzIgb+9WLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UT+bdVSutnSUU1QKO1LmcLw/cvm9DR1v1pngxdGsadFuT/1NyVFZX+0xgxmnTcVbqH3x5Ih1p60Rb3WgFCLI1K+n3cTF+UtAIWpBkK5tv4vvvohaiFjmlBAljuThTR+U8Z1Sl5DXhKbhJG/S/c8R0kZmuegbq5JaVSWo011i9aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aIHGqwak; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FDhB1w001281;
	Wed, 15 Oct 2025 18:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PiEP7v
	JpFq7F3jKtFwx8dQj4ZEHL4i+d6lDh49TdHlM=; b=aIHGqwakGvCBDjug7Iv4qa
	0OQU//7DTrAEfYmD2cBvDhF0RMwXvUfZ7W4Pf1Bru53Kuc4445Yt+eQGg/IfTz/h
	x2P/mynd78m6bDohNrqPoQtBEMxkgaqKcktQFa2xerbgxcdaS5HV1MbojFUbMqyd
	SCAm1vHq+OQcd5HTtEy90wgH8pdWRr/HBsSmIbkSeW4gXxDiJycj1Kv125RVcL/X
	igRnWhnJBCqkOq/vVBXkw/phO4U4yWlQBKS+hgc6183P5HZ987lYfhDyOGn/6OFf
	3dqhcNZmw/h/2gCfwd6melkYo8xAM1gNGnp5z7iPHgzF3u5jIKJxnbT+9CXBmGjA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8147h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 18:26:57 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59FIQuSW021031;
	Wed, 15 Oct 2025 18:26:57 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8147c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 18:26:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59FHb3RV018862;
	Wed, 15 Oct 2025 18:26:55 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jmsudw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 18:26:55 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59FIQsTP31064736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 18:26:54 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E10C58054;
	Wed, 15 Oct 2025 18:26:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B7BF5805F;
	Wed, 15 Oct 2025 18:26:43 +0000 (GMT)
Received: from [9.43.94.81] (unknown [9.43.94.81])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Oct 2025 18:26:42 +0000 (GMT)
Message-ID: <218a4324-c28c-4068-8526-3f27a55a2e70@linux.ibm.com>
Date: Wed, 15 Oct 2025 23:56:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/19] Cache Aware Scheduling
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Jianyong Wu <jianyong.wu@outlook.com>, Yangyu Chen <cyy@cyyself.name>,
        Tingyin Duan <tingyin.duan@gmail.com>, Vern Hao <vernhao@tencent.com>,
        Len Brown <len.brown@intel.com>, Aubrey Li <aubrey.li@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Libo Chen <libo.chen@oracle.com>,
        Adam Li <adamli@os.amperecomputing.com>,
        Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        haoxing990@gmail.com, Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <a54c33fd-504d-4eb4-9b0e-ad4a3e2156ad@linux.ibm.com>
 <5b82842ff20995cd50b422dad844664089dcd0c7.camel@linux.intel.com>
 <a08e9fe6-c3be-4818-bff0-7ed350b3438a@intel.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <a08e9fe6-c3be-4818-bff0-7ed350b3438a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1FKH8KW4CrzAMdlBTTJVsc5OfEipQFsF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX+TgfgJYiSV7q
 lIoatx8j007EHeLTMekxc/hHXCKKqtgy8lulU68VypjqVczpkj+u3Ydqec0RK5QioxyVlwkf5GI
 CFNm2dxDQQnQOs5274R+j1cKP131mEGMFs6KuDhmhhL8q+IVdxNCuEtUMo1LzrIZhdTkmbUnX1X
 QRBeMY9AwmiPDSp5mI6yOcJV6bzy11JCqFVQQTGixkLGcMWiQHCIa/6AvsfLZEQULRSqN/DQ1pX
 410NcowLLLRph/IM8I6r7tQ7MizorQwkX0ZXoUy4ha8ZNLBDIznfNUamCE4XN6pk4JFM+nSgn6u
 u1WIYredCtRffcJIo3Pxa4e1akqJSZ2EBSfl8SV6xNm9LvPBSJoO3bWepFl470dN/aZ+OJVZnm3
 fJbnmDzKZjX/T+urGwerQ5Bj9iSEBw==
X-Proofpoint-GUID: hk1l8yUietJkV8AE1Ix3Avjwwd2iioXd
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68efe771 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=n-9LzQyjNMPsJOffe6EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084

On 15/10/25 11:08, Chen, Yu C wrote:
> On 10/15/2025 5:48 AM, Tim Chen wrote:
>> On Tue, 2025-10-14 at 17:43 +0530, Madadi Vineeth Reddy wrote:
>>> Hi Tim,
>>> Thanks for the patch.
>>>
>>> On 11/10/25 23:54, Tim Chen wrote:
> 
> [snip]
> 
>>>> [Genoa details]
>>>> [ChaCha20-xiangshan]
>>>> ChaCha20-xiangshan is a simple benchmark using a static build of an
>>>> 8-thread Verilator of XiangShan(RISC-V). The README file can be
>>>> found here[2]. The score depends on how aggressive the user set the
>>>> /sys/kernel/debug/sched/llc_aggr_tolerance. Using the default values,
>>>> there is no much difference observed. While setting the
>>>> /sys/kernel/debug/sched/llc_aggr_tolerance to 100, 44% improvment is
>>>> observed.
>>>>
>>>> baseline:
>>>> Host time spent: 50,868ms
>>>>
>>>> sched_cache:
>>>> Host time spent: 28,349ms
>>>>
>>>> The time has been reduced by 44%.
>>>
>>> Milan showed no improvement across all benchmarks, which could be due to the
>>> CCX topology (8 CCXs × 8 CPUs) where the LLC domain is too small for this
>>> optimization to be effective. Moreover there could be overhead due to additional
>>> computations.
>>>
>>> ChaCha20-xiangshan improvement in Genoa when llc_aggr_tolerance is set to 100 seems
>>> due to having relatively lesser thread count. Please provide the numbers
>>> with default values too. Would like to know numbers on varying loads.
>>
>> I'll ask Chen Yu who did the Xiangshan experiments if he has those numbers.
>>
> 
> Madadi, do you mean the performance score number or active thread number
>  when llc_aggr_tolerance is set to 1(default)?
> The score is around with sched_cache and llc_aggr_tolerance set to 1.
> The active number is 128 per process, and there are 8 processes when
> launching the benchmark. I suppose the 128 comes from the number
> of online CPUs. Please let me know if you need more data.
> 
> Cced Yangyu who's the author of this benchmark.

I mean the benchmark result with default value of llc_aggr_tolerance on Genoa
in comparison to baseline. Knowing number of threads also helps to understand
the impact. 

> 
> ls -l /proc/14460/task/ | grep -c '^d'
> 128
> 
>>>
>>> In Power 10 and Power 11, the LLC size is 4 threads which is even smaller. Not
>>> expecting improvements here but will run some workloads and share the data.
>>>
>>> Not gone through the entire series yet but are the situations like say in two
>>> NUMA system, if a task's preferred LLC is on the wrong NUMA node for its memory,
>>> which takes precedence?
>>
>> We take preferred NUMA node in the consideration but we do not force task to
>> go to the preferred node.
>>
>> I remembered initially we limited the consideration to only LLCs in the
>> preferred node. But we encountered regressions in hackbench and schbench,
>> because when the preferred node don't have any occupancy resulting in preferred LLC
>> to be set to -1 (no preference), and resulted in extra task migrations.
>> And also the preferred node for hackbench and schbench was volatile
>> as they have small memory footprint.  Chen Yu, please chime in if there
>> were other reasons you remembered.
>>
> 
> Since the preferred NUMA node is per task, while the preferred LLC
> is per process, scanning only the current task's preferred node
> would lead to cross-node migration. This is because the process's
> preferred LLC may not reside within the current task's preferred
> node. Such a scenario could leave curr_m_a_occ at 0, and any LLC
> with an occupancy > 0 would then trigger a preferred LLC switch.

Understood. Thanks for the context.

> 
>> We'll need to revisit this part of the code to take care of such
>> corner case. I think ideally we should move tasks to the least loaded LLC
>> in the preferred node (even if no LLCs have occupancy in the preferred node),
>> as long as preferred NUMA node don't changes too often.
>>
>>
> 
> Then we might need to introduce a new member in mm_struct to store the old
> occupancy, curr_m_a_occ, so that we can reliably compare the old and new
> occupancy - to avoid the 0 value of curr_m_a_occ.
> 
>>>
>>> Also, what about the workloads that don't share data like stress-ng?
>>>
> 
> The stream is single process stressing the memory without any share
> data, we did not observe any difference on stream. We can launch more
> tests on stress-ng.
> 

That would be helpful.

Thanks,
Madadi Vineeth Reddy

> thanks,
> Chenyu>
>> We can test those.  Ideally the controls to prevent over aggregation to preferred LLC
>> would keep stress-ng happy.
>>
>>> It will
>>> be good to make sure that most other workloads don't suffer. As mentioned,
>>> per process knob for llc_aggr_tolerance could help.
>>
>> Agree. We are planning to add per process knob for the next version.  One thought is to use
>> prctl. Any other suggestions are welcome.
>>
> 


