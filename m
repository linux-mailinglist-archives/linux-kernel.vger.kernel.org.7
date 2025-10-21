Return-Path: <linux-kernel+bounces-862417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158B7BF53B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45F43AAF2C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186DC303C9C;
	Tue, 21 Oct 2025 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bSTHBKpp"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0B303A23
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035393; cv=none; b=hpEQFVjN0ZG6JuLqSxmek+ov4UdMo8JLNNwAy9sFQRvcGYW3OBHANViHN+Jc3vOax1/98xHpdhpPr47d0u88KT2x9MbAFUGx57oQqTGG2IeC4iQotdwNQ6EuZ7P/mbnIRaTuQcrF2mfRgHAv0KmtDw3SSjmvTFEvR+kA3Dkj/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035393; c=relaxed/simple;
	bh=8wESUU6c+pC0MWIPvczFD6jA8aY4gH4cFuUNfZDlANM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svCeKeOLeBwZsr6y92VWjGVWAi/+ObZLXqfO1gxhQxwf+UMvDE5e2S9blGtegDyQJRp/PA/IwNeufY0yi+3RzY7ENj10Ne85AgOfow+DEyDzS/Tlbnzco2rPUCqBGpCSnaQCUdVps7i/akZJIxP7suN18WQvo1Keq7MuucavYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bSTHBKpp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L1tmml029037;
	Tue, 21 Oct 2025 08:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vm8ibH
	ZZZh21yN3Ke0nGiSgkB3/2fhgLxDRX+a4lgQo=; b=bSTHBKpp5iEKdEuX1sFQSu
	lvdbH2kTAW01numNEdFgM4+5iYc+o4OgsEOX3vQkyuDSZ/4RPFShb2lxlEQyQAdf
	U7onSkkBYpsbLKdDdPvHznrT8YBYYsWxeZsyhFXSOH3wpPhuH9PX688N4EX0kLHM
	PmTst8Sdz7840wObCl7YIH2qDj6IVZMIyl5dIUbH3YZDjietT3fLtRp7IY0+FgHn
	hRRwP716k8i2H5D7Vo60HBysdXK84flnQvpNL1XxKEbKviQW26JW1oC7qwjbaMVC
	mVskvqH8/aB7fCSq/SgzVCmKq8ZLd630sgURUK4t5fm0T/TYxkAyf6f+TfXwIgSA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vmm8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 08:28:53 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59L8G559002895;
	Tue, 21 Oct 2025 08:28:52 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vmm8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 08:28:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L83hOD024690;
	Tue, 21 Oct 2025 08:28:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqjsqt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 08:28:51 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59L8SntI29098560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 08:28:50 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD2865805F;
	Tue, 21 Oct 2025 08:28:49 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1C6C58053;
	Tue, 21 Oct 2025 08:28:40 +0000 (GMT)
Received: from [9.98.110.226] (unknown [9.98.110.226])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Oct 2025 08:28:40 +0000 (GMT)
Message-ID: <a31003cc-fabd-4c18-9603-7763ec1e92ea@linux.ibm.com>
Date: Tue, 21 Oct 2025 13:58:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/19] sched/fair: Introduce per runqueue task LLC
 preference counter
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
        Chen Yu <yu.c.chen@intel.com>, Libo Chen <libo.chen@oracle.com>,
        Adam Li <adamli@os.amperecomputing.com>,
        Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <cover.1760206683.git.tim.c.chen@linux.intel.com>
 <a002ffc53c06bfa0ef0700631b0cb5413bdbf06c.1760206683.git.tim.c.chen@linux.intel.com>
 <20251015122125.GU3289052@noisy.programming.kicks-ass.net>
 <782009c48dbde2cb2912f4d5dc573ecfbd2c1087.camel@linux.intel.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <782009c48dbde2cb2912f4d5dc573ecfbd2c1087.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zeoFzgJS2yYASJfBOUisTtk_aYIUas0v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1S3h0DT3tQCw
 YM6EYEd1EkxQKS1/kVYLAUcx/1OnFJajioWtsr07Ij+MrX8g5CNRFizTV+Y2+EO0BtbN8fxwR8o
 dR6y/RbDSCMYozpxb7++g9wSG63O5cDck+hpuQbyOPo4wVxc/p50PcBjH1TZcwqzJvhdhEB8/T3
 cb/ePN+zcFR1ZaxgNgEz73E+6S32e1MMcWcznFsQdg5tM7nZJbh9FotiTjbjyBpHSmU+lZaZ1+4
 XoWwlqnvlHiyoC33Gp9tLhY7Kw+OCvnCPB8WVQcuzM8Sx4G/ElEncg9O3nxsHY1HV2BlxR4OzR0
 aKsXIfNvJJTHm7fJmkXVh6KBad3jIPRhelhWZAhvcT0Uw5H8yG/i7N+PErf1dHy31oVvL3DLjaL
 ovu8UEHOZ/JgedF10E79JujarN3rkA==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f74445 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ypq1MTz9OACtASZl0d4A:9 a=QEXdDO2ut3YA:10 a=nl4s5V0KI7Kw-pW0DWrs:22
 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-ORIG-GUID: 27cN7s8cZLE7jZxX0WeO7pNS413GISEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On 16/10/25 02:11, Tim Chen wrote:
> On Wed, 2025-10-15 at 14:21 +0200, Peter Zijlstra wrote:
>> On Sat, Oct 11, 2025 at 11:24:45AM -0700, Tim Chen wrote:
>>> Each runqueue is assigned a static array where each element tracks
>>> the number of tasks preferring a given LLC, indexed from 0 to
>>> NR_LLCS.
>>>

[snip]

>>
>>>  
>>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>>> index 3ab64067acc6..b801d32d5fba 100644
>>> --- a/kernel/sched/sched.h
>>> +++ b/kernel/sched/sched.h
>>> @@ -1101,6 +1101,7 @@ struct rq {
>>>  #ifdef CONFIG_SCHED_CACHE
>>>  	unsigned int		nr_pref_llc_running;
>>>  	unsigned int		nr_llc_running;
>>> +	unsigned int		nr_pref_llc[NR_LLCS];
>>
>> Gah, yeah, lets not do this. Just (re)alloc the thing on topology
>> changes or something.
> 
> Will have to think about how to keep the tasks' preference
> consistent with nr_pref_llc with the new array.  Perhaps
> make it size of NR_CPUS so we will allocate
> once and don't have to resize and reallocate it, and
> fill it back up with the right data.
> 
> Tim

IIUC, what Peter meant is to dynamically allocate the array size based on
the actual number of LLCs computed in build_sched_domains() or somesuch
rather than statically allocating NR_LLCS which is 64 by default.

Making it NR_CPUS would be even larger and waste more memory on systems
with few LLCs.

Thanks,
Madadi Vineeth Reddy

