Return-Path: <linux-kernel+bounces-813206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E664B541FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C47104E1328
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21789270EC1;
	Fri, 12 Sep 2025 05:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SWXTiFxX"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3456274B44
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757654565; cv=none; b=pJNl2sBt8HkFXlGZ1qhpiUpzqbgLSUJ0BptLr9R4g5CQ8EyNRdrjyywv8cF7FsNDR57/qWGKnspHsYIBaS1U8v0unBw8S05smi/gBvfYmeRfwA1nOxj5Duj92CD+6E3B+COPkcPIHaBONwxnldcxL/z2uasmsYBHrwNVMIrtseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757654565; c=relaxed/simple;
	bh=RAxMT9qAykd1Rum+aqDkUXs13SOxAbf/PyQDlBYWw8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImWmVm8Lv+bTw2tpthdvGvJ4HLpdToBfZQLj+rro3ipIal15BABjvaz3YSPE4VwwllhxaAMN5GHtbPeqpXOWuL82MOFL0WFJ66dJRRdmJ1it6lB9L6zQ6U+SkLnwsY5sCVUugt/tize45E6/vR0EQvf0KHoeBxjMcYmsGVEmOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SWXTiFxX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BKLvVP018756;
	Fri, 12 Sep 2025 05:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PSuSp9
	gFNTxiODTV6dcLDDWsJAUJ2FoQ3hQrSOaUA5A=; b=SWXTiFxXNWOamFDyj89VCj
	8D4Gp/T+0zsDrhMSAvym9YzOLhUey0H9u8T7xAd4ofyKYnYrknQb/Rbd+9lEY/vx
	DxNM42lMoExYoHgkHKU55KdRlY9JLz3GLKnNpGbxmr0oVjnjXdGzOZNZ3Nq8fcFS
	B4CxFiN5U07oJU1wezecYl5cVVEQybpTWPUVElz9QgJA6wAw5qyaQSFgZCrFYaKT
	aQUTELMveEvp2jsmrMj9QA+sPLYL9HnbfzAisO1aA0eIat6AmEEEz0EvQ/Igcpnk
	aJ70V+iE7rvEw57vqjl02TxBOeVJ6lKOIeHns14f8w3bZKCZA769j8jybVHz+jNg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx9cgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 05:22:17 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58C5LthZ030812;
	Fri, 12 Sep 2025 05:22:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmx9cge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 05:22:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58C0b9Fv020465;
	Fri, 12 Sep 2025 05:22:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp19fvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 05:22:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58C5MBG834800104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 05:22:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E31E2004E;
	Fri, 12 Sep 2025 05:22:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DFFD20040;
	Fri, 12 Sep 2025 05:22:02 +0000 (GMT)
Received: from [9.61.95.215] (unknown [9.61.95.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Sep 2025 05:22:02 +0000 (GMT)
Message-ID: <36042e33-772d-4c4e-ba6d-8461c8f6e29b@linux.ibm.com>
Date: Fri, 12 Sep 2025 10:52:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 07/10] sched/core: Push current task from paravirt
 CPU
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: vschneid@redhat.com, iii@linux.ibm.com, huschle@linux.ibm.com,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, vineeth@bitbyteword.org,
        jgross@suse.com, pbonzini@redhat.com, seanjc@google.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
 <20250910174210.1969750-8-sshegde@linux.ibm.com>
 <7227822a-0b4a-47cc-af7f-190f6d3b3e07@amd.com>
 <1617b0fb-273a-4d86-8247-c67968c07b3b@linux.ibm.com>
 <5493a681-4438-4854-9cf4-c1e71ad2dbed@amd.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <5493a681-4438-4854-9cf4-c1e71ad2dbed@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n-ZocXSi8m0y8ap2kiJ0D1CK5Gtj1qc4
X-Proofpoint-ORIG-GUID: FM1G5HVCM9c_ywMYga2YZs-cfqyFgGT8
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68c3ae09 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=qsZGKYFnRep_aCdFJpgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX40MtRhpfZEqS
 YDeYgXKtm0J9Bt8S5pC4TXwNvadk6QvDr1L79d131e2hdvWhZhfLdxrgDmJK5DKLbFTlOG2k+Y0
 5qGZ/I8e2c2Nc/w3n45yx5ABC8sQrQtPFqq7IunIEwekmrOIXRO1oyx1rThEoLuATWR4rrHBFJ/
 HfwH6uNgjIjdtkcSb+fs8WxhZ8uyU5t92B5L8SwEkYpDpCyQEsvM4Pp0z64L9rJn6U07Sef4qR6
 q/Cnfcf4d1GEwYLURpmbHUnyZ9GCxqdbvmKeqCDgrsLUZa7O+NxkRUQCZIhDWgtXkB4SGbf6jBd
 Nkb2yijRCeiOCrIH1lAc+CfgNrU6NEyH9LeEp0YBTupLeM8fBrSrd7y/TDWcT20Z38H31QXS9Im
 AboiCWEC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025



On 9/11/25 10:36 PM, K Prateek Nayak wrote:
> Hello Shrikanth,
> 
> On 9/11/2025 10:22 PM, Shrikanth Hegde wrote:
>>>> +    if (is_cpu_paravirt(cpu))
>>>> +        push_current_from_paravirt_cpu(rq);
>>>
>>> Does this mean paravirt CPU is capable of handling an interrupt but may
>>> not be continuously available to run a task?
>>
>> When i run hackbench which involves fair bit of IRQ stuff, it moves out.
>>
>> For example,
>>
>> echo 600-710 > /sys/devices/system/cpu/paravirt
>>
>> 11:31:54 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>> 11:31:57 AM  598    2.04    0.00   77.55    0.00   18.37    0.00    1.02    0.00    0.00    1.02
>> 11:31:57 AM  599    1.01    0.00   79.80    0.00   17.17    0.00    1.01    0.00    0.00    1.01
>> 11:31:57 AM  600    0.00    0.00    0.00    0.00    0.00    0.00    0.99    0.00    0.00   99.01
>> 11:31:57 AM  601    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
>> 11:31:57 AM  602    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
>>
>>
>> There could some workloads which doesn't move irq's out, for which needs irqbalance change.
>> Looking into it.
>>
>>   Or is the VMM expected to set
>>> the CPU on the paravirt mask and give the vCPU sufficient time to move the
>>> task before yanking it away from the pCPU?
>>>
>>
>> If the vCPU is running something, it is going to run at some point on pCPU.
>> hypervisor will give the cycles to this vCPU by preempting some other vCPU.
>>
>> It is that using this infra, there is should be nothing on that paravirt vCPU.
>> That way collectively VMM gets only limited request for pCPU which it can satify
>> without vCPU preemption.
> 
> Ack! Just wanted to understand the usage.
> 
> P.S. I remember discussions during last LPC where we could communicate
> this unavailability via CPU capacity. Was that problematic for some
> reason? Sorry if I didn't follow this discussion earlier.
> 

Thanks for that questions. Gives a opportunity to retrospect.

Yes. That's where we started. but that has a lot of implementation challenges.
Still an option though.

History upto current state:

1. At LPC24 presented the problem statement, and why existing approaches such as hotplug,
    cpuset cgroup or taskset are not viable solution. Hotplug would have come handy if the cost was low.
    The overhead of sched domain rebuild and serial nature of hotplug makes it not viable option.
    One of the possible approach was CPU Capacity.

1. Issues with CPU Capacity approach:
    a. Need to make group_misfit_task as the highest priority. That alone will break big.LITTLE
       since it relies on group misfit and group_overload should have higher priority there.
    b. At high concurrency tasks still moved those CPUs with CAPACITY=1.
    c. A lot of scheduler stats would need to be aware of change in CAPACITY specially load balance/wakeup.
    d. in update_group_misfit - need to set the misfit load based on capacity. the current code sets to 0,
       because of task_fits_cpu stuff
    e. More challenges in RT.

That's when Tobias had introduced a new group type called group_parked.
https://lore.kernel.org/all/20241204112149.25872-2-huschle@linux.ibm.com/
   
It has relatively cleaner implementation compared to CPU CAPACITY.

It had a few disadvantages too:
1. It use to take around 8-10 seconds for tasks to move out of those CPUs. That was the main
    concern.
2. Needs a few stats based changes in update_sg_lb_stats. might be tricky in all scenarios.

That's when we were exploring how the tasks move out when the cpu goes offline. It happens quite fast too.
So tried a similar mechanism and this is where we are right now.

> [..snip..]
>>>> +    local_irq_save(flags);
>>>> +    preempt_disable();
>>>
>>> Disabling IRQs implies preemption is disabled.
>>>
>>
>> Most of the places stop_one_cpu_nowait called with preemption & irq disabled.
>> stopper runs at the next possible opportunity.
> 
> But is there any reason to do both local_irq_save() and
> preempt_disable()? include/linux/preempt.h defines preemptible() as:
>
>      #define preemptible()   (preempt_count() == 0 && !irqs_disabled())
> 
> so disabling IRQs should be sufficient right or am I missing something?
> 

f0498d2a54e79 (Peter Zijlstra) "sched: Fix stop_one_cpu_nowait() vs hotplug"
could be the answer you are looking for.

>>
>> stop_one_cpu_nowait
>>   ->queues the task into stopper list
>>      -> wake_up_process(stopper)
>>         -> set need_resched
>>           -> stopper runs as early as possible.
>>          


