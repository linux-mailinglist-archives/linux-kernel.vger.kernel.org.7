Return-Path: <linux-kernel+bounces-812555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393E0B539B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB55AA1804
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4495335AAC8;
	Thu, 11 Sep 2025 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J2QZ3bcE"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49635AAC6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609605; cv=none; b=X/HjMNgAjskMwsLLRZNPqeeIQKMNJaCfJDUxSIb74/BInS4NqnCl6X11T7t7oR/mJ/1Y+OLkiAWseGIIT2KyoSPI+nMC7y3mHXAKtqoTBreWOUcC77QX5+GPysb2eu2yCRBbZdjy5+XGG0wmNyLVyXfmryPJpJxOL2VYG8JTK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609605; c=relaxed/simple;
	bh=kXfg3wg5wceBbelXQh/vv2U/jsV9/YIMZmdhkaZerZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgQqOGTJt96229QhpBwO4i9QhNdc798LmRTYoof/yokEgENiCI2NNhIPtOGXWQNJm5dn47FtXMESi6lKVGJJIFyfd9kUr0PPsXeZzWWlTHJUu611T79R+aPFkcXLLwmDb62xjIIqdGGkyd04m1NgOo+2IaLQyOodjnSO35jb35w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J2QZ3bcE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B9uKM9010489;
	Thu, 11 Sep 2025 16:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XTGtuQ
	D5utI7HVt5qodKSuGFHkOEq3NoF8DGfmxnmOk=; b=J2QZ3bcEXwR9vpdUApiYKH
	cIl4NJy7QQ8BErF+AEZhTjeArT/ZqlEg+F464bVPvnGK86RRTCzp1WKWI3ca+40R
	hlW5PWfHdeSzmu1VfI5t4mYbYCik/NQra2E821YO4KkaZS2nP8SK/DmVdCnsvlEF
	/RRs/hiqudEWuJsKRyNRBtTXz4mTSJ+CNLPDzi26YAH+ovQbujFLbLW5ZVCcBezN
	gwQF8d4Shiut0AyJ/FvZ5LUSSI3x6h36lGE62L3ChHNhew826kfSjbemA5/EUhGv
	1/xLUOvHn9R7BxZGd5UERoHK8OzjaKnOJduVb6y61JrVNpKRK7g93XrzvJegD/dA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490uketqqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 16:53:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BGr34K000841;
	Thu, 11 Sep 2025 16:53:03 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490uketqqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 16:53:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDN65c007895;
	Thu, 11 Sep 2025 16:53:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pxt21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 16:53:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BGqxBe42402198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 16:52:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DDDE20043;
	Thu, 11 Sep 2025 16:52:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75EBA20040;
	Thu, 11 Sep 2025 16:52:50 +0000 (GMT)
Received: from [9.61.95.215] (unknown [9.61.95.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 16:52:49 +0000 (GMT)
Message-ID: <1617b0fb-273a-4d86-8247-c67968c07b3b@linux.ibm.com>
Date: Thu, 11 Sep 2025 22:22:48 +0530
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
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <7227822a-0b4a-47cc-af7f-190f6d3b3e07@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX+PwsUfA+p32B
 OESt31IR+satBDSqekaE3i9V5N5eH5xFJs7AfP8MeandfU+/OeMpaNlfxX0yRBZWGm2clgGu4o7
 xUCb9Caa48d3QiEksMAATbUX5865DX2Na1pCD1xi+4q+48uNFBvMB0aSNBmaXf6A6Of2ck2clTT
 LDDWV5Qm4IIMGT7BoApc4vENimBp1yrO86m6roJokTFTHkcmyyhIFMXRBRm3IG04CDCyP0VoHlN
 5OUMc7edQ54WRXmO1Ij1zd4BHMvd97ioQXn7isMsINO+O5U4Z/CDyPOq5ptmaXTdRNqySDwl6VA
 OJVX+djziy2EE3otjlKXA+YXy6SJlaPkjKpGVoolyDGtKFUSjM+ZY06asHks90s7EUFkpXBCctE
 fQFzJm0F
X-Proofpoint-ORIG-GUID: _ZzFbSyfs3LGE43PpPNDdWQUd4DHyRMk
X-Proofpoint-GUID: 1WJdtIuZbpwt9Ixkrb1rUEOz8k9d1Qsw
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68c2fe70 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=mpTyoKK0bIg8Vs96HzcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195



On 9/11/25 11:10 AM, K Prateek Nayak wrote:
> Hello Shrikanth,
> 
> On 9/10/2025 11:12 PM, Shrikanth Hegde wrote:
>> Actively push out any task running on a paravirt CPU. Since the task is
>> running on the CPU need to spawn a stopper thread and push the task out.
>>
>> If task is sleeping, when it wakes up it is expected to move out. In
>> case it still chooses a paravirt CPU, next tick will move it out.
>> However, if the task in pinned only to paravirt CPUs, it will continue
>> running there.
>>
>> Though code is almost same as __balance_push_cpu_stop and quite close to
>> push_cpu_stop, it provides a cleaner implementation w.r.t to PARAVIRT
>> config.
>>
>> Add push_task_work_done flag to protect pv_push_task_work buffer. This has
>> been placed at the empty slot available considering 64/128 byte
>> cacheline.
>>
>> This currently works only FAIR and RT.
> 
> EXT can perhaps use the ops->cpu_{release,acquire}() if they are
> interested in this.
>

>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   kernel/sched/core.c  | 84 ++++++++++++++++++++++++++++++++++++++++++++
>>   kernel/sched/sched.h |  9 ++++-
>>   2 files changed, 92 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 279b0dd72b5e..1f9df5b8a3a2 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -5629,6 +5629,10 @@ void sched_tick(void)
>>   
>>   	sched_clock_tick();
>>   
>> +	/* push the current task out if a paravirt CPU */
>> +	if (is_cpu_paravirt(cpu))
>> +		push_current_from_paravirt_cpu(rq);
> 
> Does this mean paravirt CPU is capable of handling an interrupt but may
> not be continuously available to run a task?

When i run hackbench which involves fair bit of IRQ stuff, it moves out.

For example,

echo 600-710 > /sys/devices/system/cpu/paravirt

11:31:54 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
11:31:57 AM  598    2.04    0.00   77.55    0.00   18.37    0.00    1.02    0.00    0.00    1.02
11:31:57 AM  599    1.01    0.00   79.80    0.00   17.17    0.00    1.01    0.00    0.00    1.01
11:31:57 AM  600    0.00    0.00    0.00    0.00    0.00    0.00    0.99    0.00    0.00   99.01
11:31:57 AM  601    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00
11:31:57 AM  602    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00


There could some workloads which doesn't move irq's out, for which needs irqbalance change.
Looking into it.

  Or is the VMM expected to set
> the CPU on the paravirt mask and give the vCPU sufficient time to move the
> task before yanking it away from the pCPU?
>

If the vCPU is running something, it is going to run at some point on pCPU.
hypervisor will give the cycles to this vCPU by preempting some other vCPU.

It is that using this infra, there is should be nothing on that paravirt vCPU.
That way collectively VMM gets only limited request for pCPU which it can satify
without vCPU preemption.

  
>> +
>>   	rq_lock(rq, &rf);
>>   	donor = rq->donor;
>>   
>> @@ -10977,4 +10981,84 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
>>   struct cpumask __cpu_paravirt_mask __read_mostly;
>>   EXPORT_SYMBOL(__cpu_paravirt_mask);
>>   DEFINE_STATIC_KEY_FALSE(cpu_paravirt_push_tasks);
>> +
>> +static DEFINE_PER_CPU(struct cpu_stop_work, pv_push_task_work);
>> +
>> +static int paravirt_push_cpu_stop(void *arg)
>> +{
>> +	struct task_struct *p = arg;
> 
> Can we move all pushable tasks at once instead of just the rq->curr at
> the time of the tick? It can also avoid keeping the reference to "p"
> and only selectively pushing it. Thoughts?
> 

I think that is doable.
need to pass rq as arg and go through all tasks in rq in the stopped thread.

>> +	struct rq *rq = this_rq();
>> +	struct rq_flags rf;
>> +	int cpu;
>> +
>> +	raw_spin_lock_irq(&p->pi_lock);
>> +	rq_lock(rq, &rf);
>> +	rq->push_task_work_done = 0;
>> +
>> +	update_rq_clock(rq);
>> +
>> +	if (task_rq(p) == rq && task_on_rq_queued(p)) {
>> +		cpu = select_fallback_rq(rq->cpu, p);
>> +		rq = __migrate_task(rq, &rf, p, cpu);
>> +	}
>> +
>> +	rq_unlock(rq, &rf);
>> +	raw_spin_unlock_irq(&p->pi_lock);
>> +	put_task_struct(p);
>> +
>> +	return 0;
>> +}
>> +
>> +/* A CPU is marked as Paravirt when there is contention for underlying
>> + * physical CPU and using this CPU will lead to hypervisor preemptions.
>> + * It is better not to use this CPU.
>> + *
>> + * In case any task is scheduled on such CPU, move it out. In
>> + * select_fallback_rq a non paravirt CPU will be chosen and henceforth
>> + * task shouldn't come back to this CPU
>> + */
>> +void push_current_from_paravirt_cpu(struct rq *rq)
>> +{
>> +	struct task_struct *push_task = rq->curr;
>> +	unsigned long flags;
>> +	struct rq_flags rf;
>> +
>> +	if (!is_cpu_paravirt(rq->cpu))
>> +		return;
>> +
>> +	/* Idle task can't be pused out */
>> +	if (rq->curr == rq->idle)
>> +		return;
>> +
>> +	/* Do for only SCHED_NORMAL AND RT for now */
>> +	if (push_task->sched_class != &fair_sched_class &&
>> +	    push_task->sched_class != &rt_sched_class)
>> +		return;
>> +
>> +	if (kthread_is_per_cpu(push_task) ||
>> +	    is_migration_disabled(push_task))
>> +		return;
>> +
>> +	/* Is it affine to only paravirt cpus? */
>> +	if (cpumask_subset(push_task->cpus_ptr, cpu_paravirt_mask))
>> +		return;
>> +
>> +	/* There is already a stopper thread for this. Dont race with it */
>> +	if (rq->push_task_work_done == 1)
>> +		return;
>> +
>> +	local_irq_save(flags);
>> +	preempt_disable();
> 
> Disabling IRQs implies preemption is disabled.
>

Most of the places stop_one_cpu_nowait called with preemption & irq disabled.
stopper runs at the next possible opportunity.

stop_one_cpu_nowait
  ->queues the task into stopper list
     -> wake_up_process(stopper)
        -> set need_resched
          -> stopper runs as early as possible.
          
>> +
>> +	get_task_struct(push_task);
>> +
>> +	rq_lock(rq, &rf);
>> +	rq->push_task_work_done = 1;
>> +	rq_unlock(rq, &rf);
>> +
>> +	stop_one_cpu_nowait(rq->cpu, paravirt_push_cpu_stop, push_task,
>> +			    this_cpu_ptr(&pv_push_task_work));
>> +	preempt_enable();
>> +	local_irq_restore(flags);
>> +}
>>   #endif

