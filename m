Return-Path: <linux-kernel+bounces-660646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5190FAC205C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 12:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122DD4E2138
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 10:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9915229B28;
	Fri, 23 May 2025 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n4X9rZVe"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F42F3E
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747994067; cv=none; b=CeI/Ql3V3Oa1fEWbH8eRZNH2aylvfIn+o01EcbUCI7e8yBlaK+Ak+olIwMFlM6oUjT73cgZxruFJrwYsARbT6YpuxAhofo77eu3nmKbnF0+pI//0GS+cjIQC5tpQkguaf+8xTvTv4XO5RW8RlGFQrwT3VBQupoHNLBgQ1RzDkOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747994067; c=relaxed/simple;
	bh=E8gNIneXWGPjnI07iEOK/Byl8S2wW9tOYjihShZcXoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epFqo0Y5TEg2zjFeaDKrUmEed2HMLyT1qqUD8/DNeklBdDX2I108/pTUUXnjwLsppk6ipS+PlV+p9UAGA3VZWYgSfOS3+6RqBkz3Rlq0p1JNn6HurfLBS9DxVuN98IRQWtdKsNgTfWJwRZ/9pzYRrZfj08Wp33kEHIf73pRV8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n4X9rZVe; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a0d4f499-1222-45da-a3ea-e9d445b81c87@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747994061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNzhlrTrgf6zoW1XzrBUaGQMb+etBo16vS9kQPgLQhQ=;
	b=n4X9rZVee6YQEK15TmlRupOQhGROGs4wShiX52st6RNL3S4rjkXFlnuTSuEdiwG+M/4VlU
	nm26hkGfFusbHhPrvHx62oSNMVqkUMnlZuLL2nttXng/BVu/JnQSBPIrhhf2toQKFjgY9s
	d7qG9MgsBmwp+1pqlFysl2KGWTi/SVA=
Date: Fri, 23 May 2025 17:53:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 4/7] sched/fair: Take care of group/affinity/sched_class
 change for throttled task
To: Aaron Lu <ziqianlu@bytedance.com>
Cc: Valentin Schneider <vschneid@redhat.com>, Ben Segall
 <bsegall@google.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Don <joshdon@google.com>,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Xi Wang <xii@google.com>,
 linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
 Chuyi Zhou <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <20250520104110.3673059-1-ziqianlu@bytedance.com>
 <20250520104110.3673059-5-ziqianlu@bytedance.com>
 <63237b23-ae10-45f9-abdd-8ea4adb4d15e@linux.dev>
 <20250523075640.GA1168183@bytedance>
 <ad8197f1-548d-4fad-abd0-e8f6e9dbe12a@linux.dev>
 <20250523094106.GA1210419@bytedance>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20250523094106.GA1210419@bytedance>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/5/23 17:42, Aaron Lu wrote:
> On Fri, May 23, 2025 at 05:13:35PM +0800, Chengming Zhou wrote:
>> On 2025/5/23 15:56, Aaron Lu wrote:
>>> On Fri, May 23, 2025 at 10:43:53AM +0800, Chengming Zhou wrote:
>>>> On 2025/5/20 18:41, Aaron Lu wrote:
>>>>> On task group change, for tasks whose on_rq equals to TASK_ON_RQ_QUEUED,
>>>>> core will dequeue it and then requeued it.
>>>>>
>>>>> The throttled task is still considered as queued by core because p->on_rq
>>>>> is still set so core will dequeue it, but since the task is already
>>>>> dequeued on throttle in fair, handle this case properly.
>>>>>
>>>>> Affinity and sched class change is similar.
>>>>
>>>> How about setting p->on_rq to 0 when throttled? which is the fact that
>>>> the task is not on cfs queue anymore, does this method cause any problem?
>>>>
>>>
>>> On task group change/affinity change etc. if the throttled task is
>>> regarded as !on_rq, then it will miss the chance to be enqueued to the
>>> new(and correct) cfs_rqs, instead, it will be enqueued back to its
>>> original cfs_rq on unthrottle which breaks affinity or task group
>>
>> Yeah, this is indeed a problem, I was thinking to delete the throttled task
>> from the cfs_rq limbo list, then add it to another cfs_rq limbo list or cfs_rq
>> runnable tree based on the new cfs_rq's throttle status.
> 
> Only work when the task is still handled by fair :)
> 
>>
>> But it's much complex compared with your current method.
>>
>>> settings. We may be able to do something in tg_unthrottle_up() to take
>>> special care of these situations, but it seems a lot of headaches.
>>>
>>> Also, for task group change, if the new task group does not have throttle
>>> setting, that throttled task should be allowed to run immediately instead
>>> of waiting for its old cfs_rq's unthrottle event. Similar is true when
>>> this throttled task changed its sched class, like from fair to rt.
>>>
>>> Makes sense?
>>
>> Ok, the another problem of the current method I can think of is the PELT maintenance,
>> we skip the actual dequeue_task_fair() process, which includes PELT detach, we just
>> delete it from the cfs_rq limbo list, so it can result in PELT maintenance error.
>>
> 
> There are corresponding callbacks that handle this, e.g. for task group
> change, there is task_change_group_fair() that handles PELT detach; for
> affinity change, there is migrate_task_rq_fair() does that and for sched
> class change, there is switched_from/to() does that.
> 
> Or do I miss anything?

migrate_task_rq_fair() only do it when !task_on_rq_migrating(p), which is wakeup migrate,
because we already do detach in dequeue_task_fair() for on_rq task migration...
You can see the DO_DETACH flag in update_load_avg() called from dequeue_entity().

Thanks!

> 
> Thanks,
> Aaron
>   
>>>>>
>>>>> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
>>>>> ---
>>>>>     kernel/sched/fair.c | 24 ++++++++++++++++++++++++
>>>>>     1 file changed, 24 insertions(+)
>>>>>
>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>> index 74bc320cbc238..4c66fd8d24389 100644
>>>>> --- a/kernel/sched/fair.c
>>>>> +++ b/kernel/sched/fair.c
>>>>> @@ -5866,6 +5866,10 @@ static void throttle_cfs_rq_work(struct callback_head *work)
>>>>>     		update_rq_clock(rq);
>>>>>     		WARN_ON_ONCE(!list_empty(&p->throttle_node));
>>>>>     		dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
>>>>> +		/*
>>>>> +		 * Must not add it to limbo list before dequeue or dequeue will
>>>>> +		 * mistakenly regard this task as an already throttled one.
>>>>> +		 */
>>>>>     		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
>>>>>     		resched_curr(rq);
>>>>>     	}
>>>>> @@ -5881,6 +5885,20 @@ void init_cfs_throttle_work(struct task_struct *p)
>>>>>     	INIT_LIST_HEAD(&p->throttle_node);
>>>>>     }
>>>>> +static void dequeue_throttled_task(struct task_struct *p, int flags)
>>>>> +{
>>>>> +	/*
>>>>> +	 * Task is throttled and someone wants to dequeue it again:
>>>>> +	 * it must be sched/core when core needs to do things like
>>>>> +	 * task affinity change, task group change, task sched class
>>>>> +	 * change etc.
>>>>> +	 */
>>>>> +	WARN_ON_ONCE(p->se.on_rq);
>>>>> +	WARN_ON_ONCE(flags & DEQUEUE_SLEEP);
>>>>> +
>>>>> +	list_del_init(&p->throttle_node);
>>>>> +}
>>>>> +
>>>>>     static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags);
>>>>>     static int tg_unthrottle_up(struct task_group *tg, void *data)
>>>>>     {
>>>>> @@ -6834,6 +6852,7 @@ static inline void sync_throttle(struct task_group *tg, int cpu) {}
>>>>>     static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
>>>>>     static void task_throttle_setup_work(struct task_struct *p) {}
>>>>>     static bool task_is_throttled(struct task_struct *p) { return false; }
>>>>> +static void dequeue_throttled_task(struct task_struct *p, int flags) {}
>>>>>     static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
>>>>>     {
>>>>> @@ -7281,6 +7300,11 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>>>>>      */
>>>>>     static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>>>     {
>>>>> +	if (unlikely(task_is_throttled(p))) {
>>>>> +		dequeue_throttled_task(p, flags);
>>>>> +		return true;
>>>>> +	}
>>>>> +
>>>>>     	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
>>>>>     		util_est_dequeue(&rq->cfs, p);

