Return-Path: <linux-kernel+bounces-846564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA07BC85C1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86F9F34B447
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913092C11EB;
	Thu,  9 Oct 2025 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E6aAN1hB"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3356526E6FD
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760003277; cv=none; b=ZJMiG+HAm3aZFlXNK9/qiuhQqTjKbjBOFQALMnLF2xE6lyiZJ0Zy9FJEclU1WSx5GiHql0WSYlvvZWe0xfLqZaetD9z5ibQOS/NtMUFN3VS0JYaZcXvhT0vmahV8rR4R9WwdAd2EEB6No8wW/dz0sXcMw4R36+N35hyoUbsA90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760003277; c=relaxed/simple;
	bh=gO0Z1Gv9QEHuYgyrdTTrvH3GN88KIA9qy2CsFGXqVmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0IEZeyeG5X4UogS//0EoOJKm81oOluEdWixGG1Ia3vrD6zXNxNPNB7DXjkzUNSPQPN5MYCYdkHizzlIaot2Q0+k3ENpq3n/d5ibXMNOnUcqAVgfsPQKKP/FbTcgGhCPIlpjQ2Jc3Qr4OPx8ai0h+QIkaeQhfhDwmGdHF1EUsfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E6aAN1hB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59967VtM031169;
	Thu, 9 Oct 2025 09:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b3iuP7
	5s/7HuEbGbD6UiSI1R1j7C7WmLHEin761aULI=; b=E6aAN1hBIw4ca7rz5sY4/Z
	AvDBOEb3J7kLbTQybT+gDhHcdkGg6MoyIBnu1QlZDBVkDENYw91rmMm+Jui6qyrD
	C1yy4ahijs6WWzZXZ0aAGAcwsE36jnVB7C6zMSltVLUx36QTALARLD9PGMq0nk21
	5RAzGkjEHMIW0tv8GpsfM5lszIPhTcu0lL/irHM94ZR5cQuquNV93HvgfqHYKCS6
	mszQjm/09HLp24sPkt//PQTDNOu8R9Sz4blVua1IeFjHH9gXrQ25hHF3xsmjOb20
	zJWSQd6WeDrErsXCIpszuk1GgAQTnuvkPUzel5n+lbVJ6F/YREWzKLkkCWyY094A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81kwnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 09:47:48 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5999jww5014959;
	Thu, 9 Oct 2025 09:47:47 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81kwna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 09:47:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5998LJLq020997;
	Thu, 9 Oct 2025 09:47:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49nv9muuea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 09:47:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5999lheP53084626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 09:47:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0CAB200DE;
	Thu,  9 Oct 2025 09:47:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55C0F200DD;
	Thu,  9 Oct 2025 09:47:41 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 09:47:41 +0000 (GMT)
Message-ID: <ccac0b98-fd05-403f-8cd2-6143f6e8cbdd@linux.ibm.com>
Date: Thu, 9 Oct 2025 15:17:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bisected][mainline]Kernel warnings at
 kernel/sched/cpudeadline.c:219
To: Peter Zijlstra <peterz@infradead.org>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, jstultz@google.com,
        stultz@google.com
References: <8218e149-7718-4432-9312-f97297c352b9@linux.ibm.com>
 <20251008095039.GG3245006@noisy.programming.kicks-ass.net>
 <5a248390-ddaa-4127-a58a-794d0d70461a@linux.ibm.com>
 <20251008111314.GI3289052@noisy.programming.kicks-ass.net>
 <86fbf707-9ecf-4941-ae70-3332c360533d@linux.ibm.com>
 <20251009080007.GH3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20251009080007.GH3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ywjW_IJhW58weh_YLD-WyXllKI9qTpkB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXw2N3hF6dYV6b
 D7ZboDvfpXcvaPgRJNZdD3DrKcKPchW4fOO+BEKMRf5lCTsgLR07bctiuLMfW+ZWPB2kae+3NZ5
 O5zwDoliDL7TYsUdBlYNL0mnCAs5XVSDxzBp3hrYCFaPR+mI/fXe/F3W4+C3LLeB8rESk26NnRG
 kPEW3cZeSEVZysPZnFgLwbZ0hjPKMcSRj7fjV0rn6Tb3fpIdv1EJ/eowFq3wpj6ugsW0OiIBDwD
 EMFuznZLksI6OE60a04NEwjeD1DuvUZPFm4e+miPyxZMwznXM9RBtzKh6+5aoXmXFMmgx0iNB8m
 tNDl/6YWSAdtZXaPMlEHLN0WBg+YOIE4dd6XNn0AOa6XHHR9EWdTfVnPig5t4aPJvd7DHlP9KQJ
 c4SF2X4s12ZPg0pKZdN55eUZ7jkbHQ==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e784c4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=RDWyn_YapoD0ENg9tjYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ml748-No0PCCasYfTsSrrS_2M9j6c7Dc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 10/9/25 1:30 PM, Peter Zijlstra wrote:
> On Wed, Oct 08, 2025 at 11:39:11PM +0530, Shrikanth Hegde wrote:
> 
>> *It pointed to this*
>>
>> NIP [c0000000001fd798] dl_server_start+0x50/0xd8
>> LR [c0000000001d9534] enqueue_task_fair+0x228/0x8ec
>> Call Trace:
>> [c000006684a579c0] [0000000000000001] 0x1 (unreliable)
>> [c000006684a579f0] [c0000000001d9534] enqueue_task_fair+0x228/0x8ec
>> [c000006684a57a60] [c0000000001bb344] enqueue_task+0x5c/0x1c8
>> [c000006684a57aa0] [c0000000001c5fc0] ttwu_do_activate+0x98/0x2fc
>> [c000006684a57af0] [c0000000001c671c] try_to_wake_up+0x2e0/0xa60
>> [c000006684a57b80] [c00000000019fb48] kthread_park+0x7c/0xf0
>> [c000006684a57bb0] [c00000000015fefc] takedown_cpu+0x60/0x194
>> [c000006684a57c00] [c000000000161924] cpuhp_invoke_callback+0x1f4/0x9a4
>> [c000006684a57c90] [c0000000001621a4] __cpuhp_invoke_callback_range+0xd0/0x188
>> [c000006684a57d30] [c000000000165aec] _cpu_down+0x19c/0x560
>> [c000006684a57df0] [c0000000001637c0] __cpu_down_maps_locked+0x2c/0x3c
>> [c000006684a57e10] [c00000000018a100] work_for_cpu_fn+0x38/0x54
>> [c000006684a57e40] [c00000000019075c] process_one_work+0x1d8/0x554
>> [c000006684a57ef0] [c00000000019165c] worker_thread+0x308/0x46c
>> [c000006684a57f90] [c00000000019e474] kthread+0x16c/0x19c
>> [c000006684a57fe0] [c00000000000dd58] start_kernel_thread+0x14/0x18
>>
>> It is takedown_cpu called from CPU0(boot CPU) and it wakes up kthread
>> which is CPU Bound I guess.  Since happens after rq was marked
>> offline, it ends up starting the deadline server again.
>>
>> So i think it is sensible idea to stop the deadline server if the cpu
>> is going down.  Once we stop the server we will return
>> HRTIMER_NORESTART.
> 
> D'0h.. that stop was far too early.
> 
> How about moving that dl_server_stop() into sched_cpu_dying() like so.
> 
> This seems to survive a few hotplugs for me.
> 
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 198d2dd45f59..f1ebf67b48e2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8571,10 +8571,12 @@ int sched_cpu_dying(unsigned int cpu)
>   	sched_tick_stop(cpu);
>   
>   	rq_lock_irqsave(rq, &rf);
> +	update_rq_clock(rq);
>   	if (rq->nr_running != 1 || rq_has_pinned_tasks(rq)) {
>   		WARN(true, "Dying CPU not properly vacated!");
>   		dump_rq_tasks(rq, KERN_WARNING);
>   	}
> +	dl_server_stop(&rq->fair_server);
>   	rq_unlock_irqrestore(rq, &rf);
>   
>   	calc_load_migrate(rq);
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 615411a0a881..7b7671060bf9 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1582,6 +1582,9 @@ void dl_server_start(struct sched_dl_entity *dl_se)
>   	if (!dl_server(dl_se) || dl_se->dl_server_active)
>   		return;
>   
> +	if (WARN_ON_ONCE(!cpu_online(cpu_of(rq))))
> +		return;
> +
>   	dl_se->dl_server_active = 1;
>   	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
>   	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))

Yes. This works. no warning with drmgr or chcpu.

shall i write changelog and send it as patch?

