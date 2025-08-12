Return-Path: <linux-kernel+bounces-765433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4489B234C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69413166342
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A532FD1AD;
	Tue, 12 Aug 2025 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K6c+3NAM"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93436BB5B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024053; cv=none; b=OeSAftvwU0i1tlCqKSIj/HlMJlviAh/aiSDS8a0V1IYRNUjrEeylwYiuZvlG+/5MMbF74XDIkm1g8d4NDFrCdoanLPp44Ivs2F9XmOfhzFBJ3WLNinSJ5o0M7Y+ZRuxtAg5mbE9+gahA1bRrQPb3SzSvldSL/vRTCmUxbElSkdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024053; c=relaxed/simple;
	bh=YkPo5aHD6fCOxXmD/Bn+jmGsw2joPbXTcYHK3EUx6Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEFoOEW9gKY0Xyd/Hg2YZBXG5nWfh4BuzIBCxCznfBSqT//XrlzY2YMdFGWJJBHc6wiEkKkUtd1IEaa1L6o7wNLHOhCFJZyt7wmv6ifby1yJ/eCEz43KQLM4X6+JNna9nj1nxNnbe97th1TdLXxbh4lPlWUrL8rO37EJftCNTZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K6c+3NAM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CGbbAH032042;
	Tue, 12 Aug 2025 18:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Dwdw7e
	y5fRL5qqeZFjdhC9YXXZ9B60w7oqkX7t2MDb4=; b=K6c+3NAMiSEvIo7vs29dRX
	2OaDmcT4iif8dSxgnC4+IuP6ZvE3/l0PnK+bEs3SHPsRGAM6Rw8HhnhPDWCIUzkP
	+rns66F+UMQo5aJtRb2g5Dohm7vx5+EGb+luaQNTHoXEkNzvv1Jjkhah5sReHJYo
	JP/EFOw7E6qhRkUXcEuOn+DiSDwdn9ujVx6DmPuDUKjj2BHU0WquQF2f3tSVbsof
	tF1z/IFArzCrinymQpddzWiApo22TEsgvJ6JpEIO8kJkk4mVb/4p2WB8CaGhsr99
	Jy1iZMnLXc388rMZICjtvgPLXepKXf4EUMemIw5GtVlafqoS4I5CaJN23Ridcmwg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrp0305-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 18:40:33 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57CIeJWK008152;
	Tue, 12 Aug 2025 18:40:32 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrp02yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 18:40:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57CIUiDo025638;
	Tue, 12 Aug 2025 18:40:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ejvmbkvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 18:40:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57CIeRJU17695028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 18:40:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDA602004B;
	Tue, 12 Aug 2025 18:40:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 709D120040;
	Tue, 12 Aug 2025 18:40:24 +0000 (GMT)
Received: from [9.39.29.151] (unknown [9.39.29.151])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Aug 2025 18:40:24 +0000 (GMT)
Message-ID: <d87c4b4f-959b-4726-9b4b-4ddeb7488b37@linux.ibm.com>
Date: Wed, 13 Aug 2025 00:10:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 6/9] sched/core: Push current task out if CPU is marked
 as avoid
To: yury.norov@gmail.com
Cc: vschneid@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        mingo@redhat.com, peterz@infradead.org, kprateek.nayak@amd.com,
        huschle@linux.ibm.com, srikar@linux.ibm.com,
        linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org,
        maddy@linux.ibm.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
References: <20250625191108.1646208-1-sshegde@linux.ibm.com>
 <20250625191108.1646208-7-sshegde@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250625191108.1646208-7-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE3NiBTYWx0ZWRfXw8+z2SX9DDiz
 EG041ZhTJJ52b/zAzS+T8BIrNS1sPAym/RCB2jmHtPeDMkL0pkq0iPiKNAebCq01T0M4m93NkF5
 ert2vyO/qXtqECBN3cvtpjxoOQwRe8dXjjqieAw6grHmS1paA/3lD8CgOpfzQHBA8zoagQO8SE1
 LizaCpPzY/irZ5inva/v17+5GtjZ2SEX4oaLiAZGcNiNbcZe4PRSwfrpZr1EdgIaQAiE3RrjGDu
 xjb6geiGRT6/2476xcVg/CBiXgxgY6X2sA5XuC3lPbs5HORr4TMBDOpGkyNAtQa6DXGpu4RHhn3
 v901tOozmbAVFwMOnIZIh0Bu90BA9AZLpopW27zwQRuh9sMbRgenituXTJOnoMDmtaI/M4AxuH1
 E/dAztjnfc8CKYdMTz+QsdZPmrKB8g6S/3cgwdxPmeLCjxbVcOGOe9tFrGj4SbXBm4EVynxT
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=689b8aa1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=0SY00xeoSHbpX606VFoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ufIpwGsGi6HRf-h28LZjALTD051XfJxN
X-Proofpoint-ORIG-GUID: CsJOBVsWmIyZ2A5EZ0OhOgkYFABvy75L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120176


Sorry for the delay in response to bloat-o-meter report. Since stop_one_cpu_nowait needs protection
against race, need to add a field in rq. So ifdef check of CONFIG_PARAVIRT makes sense.

> 
> Since the task is running, need to use the stopper class to push the
> task out. Use __balance_push_cpu_stop to achieve that.
> 
> This currently works only CFS and RT.
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   kernel/sched/core.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
>   kernel/sched/sched.h |  1 +
>   2 files changed, 45 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 13e44d7a0b90..aea4232e3ec4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5577,6 +5577,10 @@ void sched_tick(void)
>   
>   	sched_clock_tick();
>   
> +	/* push the current task out if cpu is marked as avoid */
> +	if (cpu_avoid(cpu))
> +		push_current_task(rq);
> +
>   	rq_lock(rq, &rf);
>   	donor = rq->donor;
>   
> @@ -8028,6 +8032,43 @@ static void balance_hotplug_wait(void)
>   			   TASK_UNINTERRUPTIBLE);
>   }
>   
> +static DEFINE_PER_CPU(struct cpu_stop_work, push_task_work);
> +
> +/* A CPU is marked as Avoid when there is contention for underlying
> + * physical CPU and using this CPU will lead to hypervisor preemptions.
> + * It is better not to use this CPU.
> + *
> + * In case any task is scheduled on such CPU, move it out. In
> + * select_fallback_rq a non_avoid CPU will be chosen and henceforth
> + * task shouldn't come back to this CPU
> + */
> +void push_current_task(struct rq *rq)
> +{
> +	struct task_struct *push_task = rq->curr;
> +	unsigned long flags;
> +
> +	/* idle task can't be pused out */
> +	if (rq->curr == rq->idle || !cpu_avoid(rq->cpu))
> +		return;
> +
> +	/* Do for only SCHED_NORMAL AND RT for now */
> +	if (push_task->sched_class != &fair_sched_class &&
> +	    push_task->sched_class != &rt_sched_class)
> +		return;
> +
> +	if (kthread_is_per_cpu(push_task) ||
> +	    is_migration_disabled(push_task))
> +		return;
> +
> +	local_irq_save(flags);
> +	get_task_struct(push_task);
> +	preempt_disable();
> +
> +	stop_one_cpu_nowait(rq->cpu, __balance_push_cpu_stop, push_task,
> +			    this_cpu_ptr(&push_task_work));

Doing a perf record occasionally caused the crash. This happens because stop_one_cpu_nowait
expects the callers to sync and push_task_work should be untouched until the stopper executes.

So, i had to do something similar to whats done in active_balance.
Add a field in rq and set/unset accordingly.

Using this field in __balance_push_cpu_stop is also hacky. I have to do something like below,
	if (rq->balance_callback != &balance_push_callback)
		rq->push_task_work_pending = 0;
or i have to copy __balance_push_cpu_stop and do the above.

After this, it makes sense to put all this under CONFIG_PARAVIRT.


(Also, i did explore using stop_one_cpu variant, got to it via scheduling a work and then execute it at
preemptible context. That occasionally ends up in deadlock. due to some issues at my end, haven't debugged that
further. a backup option for nowait)

> +	preempt_enable();
> +	local_irq_restore(flags);
> +}
>   #else /* !CONFIG_HOTPLUG_CPU: */
>   
>   static inline void balance_push(struct rq *rq)
> @@ -8042,6 +8083,9 @@ static inline void balance_hotplug_wait(void)
>   {
>   }
>   
> +void push_current_task(struct rq *rq)
> +{
> +}
>   #endif /* !CONFIG_HOTPLUG_CPU */
>   
>   void set_rq_online(struct rq *rq)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 105190b18020..b9614873762e 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1709,6 +1709,7 @@ struct rq_flags {
>   };
>   
>   extern struct balance_callback balance_push_callback;
> +void push_current_task(struct rq *rq);
>   
>   #ifdef CONFIG_SCHED_CLASS_EXT
>   extern const struct sched_class ext_sched_class;

Hopefully i should be able to send out v3 soon addressing the comments.

Namewise, going to keep it cpu_paravirt_mask and cpu_paravirt(cpu).


