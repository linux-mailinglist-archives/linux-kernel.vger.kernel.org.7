Return-Path: <linux-kernel+bounces-891496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE0C42C76
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 13:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67B3188AA25
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADD723EA94;
	Sat,  8 Nov 2025 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pLXV1ojM"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C9A757EA
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762603523; cv=none; b=NJS+rOSXwoI+Y4/A9+Lr6aK97xzaZ9mgF0SYzovdY/1Zd7QBTug6NZxM9CMCuFLvN9K6yXYq2kSNGYY9MdWm0PHoCNIdn3JYQECHG8NykDj0mFVaoIUSch7lyvhL2+Oh5E11079afGZtqdh0Vcf78pZ7aC+uZUdmzjylPNiiHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762603523; c=relaxed/simple;
	bh=oRqTW2U0XIzN7lh2wE+hsgdUQ/X/8rDJ83wgj11BZTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUkeiTtWaij+RT5yTmL7LVJfkivUPjMqerT/wx/BIovFIPVm/Y5DNl62UofkeuTPURyKCMj/OVgwD38tlI3qErJjzvrEPQqSDBLBZY5XbhMZmigeH/k2Mm3wUNCyTFcd4Ow7coZe016AynEsharv2nWF/O03iX8AVqN9b9/T2Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pLXV1ojM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8Aq568027585;
	Sat, 8 Nov 2025 12:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BPuTDK
	3wudd7tV1PHDj+w7MkGceOWgYTtNwyx5UVOTs=; b=pLXV1ojMjPhB50eHL75Mjr
	ecbzevYj41eDIWKlRQA7tjWKbrcaZEyr1SpNOVhJYv8u8WbXZZu/Ty1QVeXKJQLO
	52B4JUSFVNPk7os3ZjeXKdikP41I77lEhcHjHlZYfr5vblPovl8uLEv7C+26EMSY
	sX2+OFAtAkdBCI/zwZwNEgW8VnzrPVXzv2ul96AP6gnC0R0IkvcLO4ogjvpKD88W
	c1eIMOndFAMtEe8Cqay77KQO3KeZl3+Im4d+VsUho6ec0IPfmT9QYjfULl3Ay/El
	nJfm7OccMR8+Drt2GQ7Mq/R2cHP7AnboPuTDO7886jge80LzAnwg421JEPi3evUw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m7r921-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Nov 2025 12:04:55 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A8C4S4A026050;
	Sat, 8 Nov 2025 12:04:55 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa3m7r91x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Nov 2025 12:04:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A891kgX025582;
	Sat, 8 Nov 2025 12:04:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5vht79nc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Nov 2025 12:04:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A8C4oHo41550204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Nov 2025 12:04:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29EBE2004E;
	Sat,  8 Nov 2025 12:04:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C90E2004B;
	Sat,  8 Nov 2025 12:04:46 +0000 (GMT)
Received: from [9.39.18.210] (unknown [9.39.18.210])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Nov 2025 12:04:46 +0000 (GMT)
Message-ID: <44d1a4a3-da2d-4cee-b947-a83023a4ceaa@linux.ibm.com>
Date: Sat, 8 Nov 2025 17:34:45 +0530
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
X-Authority-Analysis: v=2.4 cv=MtZfKmae c=1 sm=1 tr=0 ts=690f31e7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Hl_OmnuzmpaPTutlhbAA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: hYfeG4CVYqghkJ34NGed4q1hNWUxDFvs
X-Proofpoint-ORIG-GUID: XTdIfH8OmLfG722bMF6XWJxspuONoxGp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3OSBTYWx0ZWRfX0q6P98QYlhAa
 vicp2b+NWIWzDosCnt3qcTdZS2QD0FB//Q/mrgo+cmHXUuhgbeLYcPM1BGDdORRPHnl/xgOfbnG
 mO+7IUNOEytcPRnYzDMyJKizowkTlp3tDCAPoqoFt8EdejLajBHWUjcjc7+6kqfnuNbDKIoaYxX
 dnbevZDNO0dtIztOMvpvQkIoC9RJrFM8LKxRU0Y0zH1lFzGjcZL9H4RqfRXnjJMrLqsP6FVBfiQ
 nRcnLv7h4cNsng2A4BcKuPHHAlkwU3qbYJkj8oN98p5RX8XyEV7SeydukfqvJDWFlI6WphI/X/U
 NOYJfyfDEeFhER0U/ihtWC7vJpR4Dk00jZ2kytMroTMYCsmFef82ua8yhd76VO5YIZrQqurTht0
 OhGP1zQnY2QLUevh7IbDNrcCX3YyWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080079



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


While thinking about this, are there any such system which has vCPUs and
overcommits and still has energy model backing it?

Highly unlikely. So, I am planning to put a warning there and see if any
such usage exists there.

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
> 

We have this pattern in select_task_rq_fair

cpu = smp_processor_id();
new_cpu = prev_cpu;

task is waking up after a while, so likely prev_cpu is marked as paravirt
and in such cases we should return current cpu. if current cpu is paravirt(unlikely),
and prev_cpu is also paravirt, then should return current cpu.
In next sched tick it will be pushed out.

select_idle_sibling(p, prev_cpu, new_cpu); - (new_cpu will remain prev_cpu if wake_affine doesn't change it)
Will have to change the prototype to send current cpu as well.

