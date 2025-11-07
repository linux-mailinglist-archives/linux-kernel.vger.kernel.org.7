Return-Path: <linux-kernel+bounces-890003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CF4C3F0B1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049B4188D5E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1191B2FFFB7;
	Fri,  7 Nov 2025 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BedHoPOP"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B326C24EF8C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505846; cv=none; b=GGNA3L7tbjp1in0bYzWKJ0gx8RXdLNwaSgktUnnH42CG1CcYkHqcYzrFZcKC7GukyfVqTCn/JuK1qbwhSjfFOQb+aNVfxN9PLgOtDza2iRNvlJ/J0/eyy9EEf/scrQ88Zubo56gToPPxQbpOJ2OuQusKyg8KERF6rob9MQRwIWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505846; c=relaxed/simple;
	bh=Cap+zcS1OK4c4RwbkPQb9tbc24k7MF6/Jkgx09Hl0i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1gHdPXveJqAX6f66EyKsN/0qrkvBwloaEGZ+E2AjU5EBw4tOhesW/b2q4LeFrSexRSSdf4A399+1aS0CIv/9MkZ4HQzDnd/3M5AuNrznkA9yc8HLe4xMaWgzwMBG5j9zs05i0N14xOAMN9kIaZ3dSxDwHo3lFFCYHmj5n9qMIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BedHoPOP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A77RD8e027656;
	Fri, 7 Nov 2025 08:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oLM/iF
	S5950iNZz4yYZMUmk8malp9XY5r+OXGx3W228=; b=BedHoPOPhyow0XylSWdhMu
	ykkMdQcLNwq8cP2JBnlxa4ntYCtQDbOfLnfbgD8T5JkH2zJEOMbd3Ir0pj4oZWoq
	09FPUqZPR3CnoriDguVoPugFKIc/h9/sfI1CGqNCjlefsHpVusDO2ibHmo8fSouj
	qUBjixK0qhkTMsUEa+jWvKqJz4HF/Rc8f76WmZo+Jl6+/MzQjipKWEK6wzjnshvD
	TqcDyOYpj4Pf/FssuJ5C0ACEZx3WtnrNwmPICGelU7bzFKr5MQIPbm1jGm/Y6PdU
	Iq35FGZ42VvNhXmTCVYbEXyY01NFftGEq0/2qVfZT0v3tHB+3lQMHUO5AzDmPvTg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mrjmj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 08:57:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A773cRa027464;
	Fri, 7 Nov 2025 08:57:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwysyug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Nov 2025 08:57:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A78v8vc60097022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Nov 2025 08:57:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53B3120040;
	Fri,  7 Nov 2025 08:57:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85F6420043;
	Fri,  7 Nov 2025 08:57:06 +0000 (GMT)
Received: from [9.39.18.215] (unknown [9.39.18.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Nov 2025 08:57:06 +0000 (GMT)
Message-ID: <2edf1a85-4736-4e8b-bfc9-003dd1f34be7@linux.ibm.com>
Date: Fri, 7 Nov 2025 14:27:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
To: K Prateek Nayak <kprateek.nayak@amd.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <52fcd1e8582a6b014a70f0ce7795ce0d88cd63a8.1762470554.git.tim.c.chen@linux.intel.com>
 <1d6c22aa-c882-4833-b0be-a3999d684885@amd.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <1d6c22aa-c882-4833-b0be-a3999d684885@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: btyUDa8NfL19CWgbl9VLYUDI4epnkDRL
X-Authority-Analysis: v=2.4 cv=MKhtWcZl c=1 sm=1 tr=0 ts=690db467 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=8rtQOahW85AB8ZdKGuoA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: btyUDa8NfL19CWgbl9VLYUDI4epnkDRL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwMSBTYWx0ZWRfXxzjz4tnRpcjj
 8uAIwgrbNjeBFxL8Ulwpx+PKXjrSfQUhgpZSPOIMilP/jNsjXLRHM9pivf3aD4SUkiTmZvBzzDM
 6PwYtb8CEqgIyp3uHykwO538uLw7s4BxgQ+hPl0HVtq+uwidQcZiSvGKSeMWSk/DAEv6IR+Ab7J
 ze4nNqLmzrLZvrJDCXZHoSa5J3+UvmNSwhGLefebnJBC21OvZItr0p3lKyHnWcdf2jSR/ogO856
 r7/cNvoIlK9H7ZoQTSROuZ2TF1a14Lzi9LHepmBeoz/OiWADyJDXfJ+Y8WYZNPaUPBWBxqgYZ5/
 TNqIhGgWPx+Nlksdhwb8pBOeopOtGYuPFvwNanB+vsCJwz5ye45YoS7/QUNZzc3MUpLZN6aJ5ZL
 4z6YFxnqRdtEWbr5G8266fxSoK0gFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010001



On 11/7/25 8:27 AM, K Prateek Nayak wrote:
> Hello Tim,
> 
> On 11/7/2025 4:57 AM, Tim Chen wrote:
>> @@ -11757,6 +11772,7 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>>   		.fbq_type	= all,
>>   		.tasks		= LIST_HEAD_INIT(env.tasks),
>>   	};
>> +	int need_unlock = false;
>>   
>>   	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
>>   
>> @@ -11768,6 +11784,13 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>>   		goto out_balanced;
>>   	}
>>   
>> +	if (idle != CPU_NEWLY_IDLE && (sd->flags & SD_SERIALIZE)) {

Can you also try removing "idle != CPU_NEWLY_IDLE" and see the workload behavior?
If workloads don't observe regression, it might be worth serializing it too.

>> +		if (atomic_cmpxchg_acquire(&sched_balance_running, 0, 1)) {
>> +			goto out_balanced;
>> +		}
>> +		need_unlock = true;
>> +	}
>> +
>>   	group = sched_balance_find_src_group(&env);
>>   	if (!group) {
>>   		schedstat_inc(sd->lb_nobusyg[idle]);
>> @@ -11892,6 +11915,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>>   			if (!cpumask_subset(cpus, env.dst_grpmask)) {
>>   				env.loop = 0;
>>   				env.loop_break = SCHED_NR_MIGRATE_BREAK;
>> +				if (need_unlock)
>> +					atomic_set_release(&sched_balance_running, 0);
> 
> I believe we should reset "need_unlock" to false here since "redo" can
> fail the atomic_cmpxchg_acquire() while still having "need_unlock" set
> to "true" and the "out_balanced" path will then perform the
> atomic_set_release() when another CPU is in middle of a busy / idle
> balance on a SD_SERIALIZE domain.

Yes. Setting need_unlock = false looks better.

> 
> We can also initialize the "need_unlock" to false just after
> the redo label too - whichever you prefer.
> 
> nit. "need_unlock" can just be a bool instead of an int.
> 
> Apart from that, feel free to include:
> 
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
>> +
>>   				goto redo;
>>   			}
>>   			goto out_all_pinned;
>> @@ -12008,6 +12034,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>>   	    sd->balance_interval < sd->max_interval)
>>   		sd->balance_interval *= 2;
>>   out:
>> +	if (need_unlock)
>> +		atomic_set_release(&sched_balance_running, 0);
>> +
>>   	return ld_moved;
>>   }
>>   
> 


