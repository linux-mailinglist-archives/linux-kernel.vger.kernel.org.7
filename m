Return-Path: <linux-kernel+bounces-812467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689C6B5387B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F791A02FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF367352FC8;
	Thu, 11 Sep 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s5vvQM8N"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A1B35208C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606256; cv=none; b=OP0Kv802ivfQ4Tn5D+rfmBy8VZKo1FKWaR6gEhKMf6uhla8bmNhzibWdV+vZ4RCm3rThQeJIDy6fYhHVgrZZOnu8RfcJbeMAG+KGpQykKhb1xX9lTycd+2T4mhvFE8JglV2t9qxmIheiydxabOO2zKb90p6AnkQ0APOm+GRenB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606256; c=relaxed/simple;
	bh=4ABrTSDZ57iC3tz4EOR6OqnmNd7tMzJcUfePHoeMfU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s4E0a/3cLWhPLBmWDL8JSWa/OZzts7J65KAPmvqecbusWfxnxJyhxvNqRKJ/1pgWio6/s8Re9C8XwL3pT4TUXWzFPTRSG0U/j9oBeUxPCDh0uyd82cLmIWRVvmZgI0fp/AwdRTTCe5y+lPArMs/8QENnIpCrnOGIwv/v2fLwkd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s5vvQM8N; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BCnHjk028671;
	Thu, 11 Sep 2025 15:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hR/2y1
	7EnbK2MMU7nd0ZkeNZdUrDyWTrnM4xm/omK2Q=; b=s5vvQM8Nx3oU1NguNkfFsH
	H+8S5mqyTk+KEDU7K+uK5YIMgKibg4IwEnqnTtGcPnfsNY1Qo8Mz71GCxre8kg43
	8/2FD/7BaOhW5xqnEzKeWG2mrprz/jP5mGTk4NmpFWyjkGZADrMrR3Byhf77JJXo
	QNL0lc93wdXqwOiO6NTgSquRm/IKviywy2XMFZL8O3JGmwYKYHq0rgokMXpM7w+v
	jqbpYfSunlpw7fYQksyrGs3d1xu4fKjKNE+/n9RYAjYatnViTieQFO49DsA0UavW
	vEDJR83zKdG+zcXeGUQgav8HtDoncd3BGkcVXoMzau7KodVyN58Vr8FTILjXmeHQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xydajk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 15:57:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BFo1u8018580;
	Thu, 11 Sep 2025 15:57:11 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xydajjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 15:57:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BENWIL001188;
	Thu, 11 Sep 2025 15:57:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 491203p9rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 15:57:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BFv7oN49217970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 15:57:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08BFC20040;
	Thu, 11 Sep 2025 15:57:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80B5120043;
	Thu, 11 Sep 2025 15:56:58 +0000 (GMT)
Received: from [9.61.95.215] (unknown [9.61.95.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 15:56:58 +0000 (GMT)
Message-ID: <e3826a8d-98cc-4497-85ce-5d92e0556cea@linux.ibm.com>
Date: Thu, 11 Sep 2025 21:26:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 05/10] sched/fair: Don't consider paravirt CPUs for
 wakeup and load balance
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: vschneid@redhat.com, iii@linux.ibm.com, huschle@linux.ibm.com,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, vineeth@bitbyteword.org,
        jgross@suse.com, pbonzini@redhat.com, seanjc@google.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
 <20250910174210.1969750-6-sshegde@linux.ibm.com>
 <d0aa1a34-2097-405c-b431-907fd973ad96@amd.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <d0aa1a34-2097-405c-b431-907fd973ad96@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EoQsnxEWE1fI354CANC2daJRZduOKjwS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX40KWbzuYW4yb
 HAkT/MkP3dT8oVyRGsBmRbDj8DxlBiVmoppZy4vOpQlrlkaNFcagd7duMX8LekGfxPqeiWxbPCG
 0jdB9Uq2b28bszHS69d9zU/QCuccRH25xJW8jgMJFfQUUnr9eA5TJVGmR6B+V3cZ3ubgN5ztd4A
 DkCgZoDxs0+/luDXoaIXiBJGs2VAxUneyqzv0jRWEBsYMZAyuofYeEukbYDT0/r42fqNiLgt8Jr
 2n1GIHqgt3XMBKNrPB01/0UoAgMYt+YiAveDpD018CWULDfRrayT1JPThOu4R1VAt7eDdUQRxfD
 XhYXBPPE5H16s5a9vZQQx/oFEav6qSbZXNZ9cOM3BhC2McMszLw5IX5stZzgm/WAhZR9If2yIpC
 SGIfN9Dr
X-Proofpoint-GUID: snWUdQdLKZTGcpGH5mLV10L87_zdZ_yv
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c2f158 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=ex1m0Fpx1afbAyXWguEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235



On 9/11/25 10:53 AM, K Prateek Nayak wrote:
> Hello Shrikanth,
> 
> On 9/10/2025 11:12 PM, Shrikanth Hegde wrote:
>> @@ -8563,7 +8563,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>>   		if (!is_rd_overutilized(this_rq()->rd)) {
>>   			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
>>   			if (new_cpu >= 0)
>> -				return new_cpu;
>> +				goto check_new_cpu;
> 
> Should this fallback to the overutilized path if the most energy
> efficient CPU is found to be paravirtualized or should
> find_energy_efficient_cpu() be made aware of it?
> 
>>   			new_cpu = prev_cpu;
>>   		}
>>   
>> @@ -8605,7 +8605,12 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>>   	}
>>   	rcu_read_unlock();
>>   
>> -	return new_cpu;
>> +	/* If newly found or prev_cpu is a paravirt cpu, use current cpu */
>> +check_new_cpu:
>> +	if (is_cpu_paravirt(new_cpu))
>> +		return cpu;
>> +	else
> 
> nit. redundant else.
> 

Do you mean "is_cpu_paravirt(new_cpu) ? cpu; new_cpu"

This needs to return cpu instead of true/false. maybe i not seeing the obvious.

>> +		return new_cpu;
>>   }
>>   
>>   /*
>> @@ -11734,6 +11739,12 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>>   
>>   	cpumask_and(cpus, sched_domain_span(sd), cpu_active_mask);
>>   
>> +#ifdef CONFIG_PARAVIRT
>> +	/* Don't spread load to paravirt CPUs */
>> +	if (static_branch_unlikely(&cpu_paravirt_push_tasks))
>> +		cpumask_andnot(cpus, cpus, cpu_paravirt_mask);
>> +#endif
> 
> Can something similar be also be done in select_idle_sibling() and
> sched_balance_find_dst_cpu() for wakeup path?

That's a good suggestion. don't make a choice which is a paravirt CPU.
Will explore.

> 
>> +
>>   	schedstat_inc(sd->lb_count[idle]);
>>   
>>   redo:


