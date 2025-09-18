Return-Path: <linux-kernel+bounces-767764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B705B258D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435FF5A07DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F37183CC3;
	Thu, 14 Aug 2025 01:14:50 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5F2AD13;
	Thu, 14 Aug 2025 01:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755134090; cv=none; b=TWlASEN6qD4EMFxKASqZ6tL+htMW1T/1YBh7AFVmwJGhxooI2SvlX9msrEn6yv7CF/5UPX9frrWufMIJKg/a1cjecOFAiSRajNbZw/JOl/yllZcpSRVvMheq2lNyqdZnPsP/PupJ2MCG1c7T0GVgOa4wvRRM+q2e1hDuRds2ioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755134090; c=relaxed/simple;
	bh=wqq0F9DZu0/EK2souEeEqW9YAZQTBkOfKqL4AnnzukY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DWEtk+6Aktf68T8j56LRqY4Cv2fhmSA58H/IA9iII0gO0Sc6d5iUXfWEOZMsd+ir7U3aRhqRDddPeTWN4yMh5UKhXIx7lgLlgHSwEDLQmqVRsifxJFsktZBJr6dv/F7CJjjiywnShmKsam+1qAPD+OUmT60TVTzol8kLIHtZFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2S2Y5RmYzYQv67;
	Thu, 14 Aug 2025 09:14:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 5B52A1A1655;
	Thu, 14 Aug 2025 09:14:44 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgDHjNeAOJ1oyHsoDg--.41388S2;
	Thu, 14 Aug 2025 09:14:43 +0800 (CST)
Message-ID: <3e2776ed-03a8-4d5c-8145-13c3a1093f87@huaweicloud.com>
Date: Thu, 14 Aug 2025 09:14:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/core: Skip user_cpus_ptr masking if no online
 CPU left
From: Chen Ridong <chenridong@huaweicloud.com>
To: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
References: <20250718164143.31338-1-longman@redhat.com>
 <20250718164857.31963-1-longman@redhat.com>
 <0532c73c-fda0-4f12-b4ce-f84a74bc2f21@huaweicloud.com>
 <2c0b1511-b216-4f92-84c7-482f510cef7e@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <2c0b1511-b216-4f92-84c7-482f510cef7e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDHjNeAOJ1oyHsoDg--.41388S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF4fWry8tFyruFyUAr1fJFb_yoW5XF1UpF
	WkKF4UCFWqqF1jyayS93sI9ryFqa9xJ3W3XF1FyryF9FZ0qF1UCFy0gF13Wr1DKrsakFWU
	tF4ag3ySvFyqqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/31 20:03, Chen Ridong wrote:
> 
> 
> On 2025/7/23 9:58, Chen Ridong wrote:
>>
>>
>> On 2025/7/19 0:48, Waiman Long wrote:
>>> Chen Ridong reported that cpuset could report a kernel warning for a task
>>> due to set_cpus_allowed_ptr() returning failure in the corner case that:
>>>
>>> 1) the task used sched_setaffinity(2) to set its CPU affinity mask to
>>>    be the same as the cpuset.cpus of its cpuset,
>>> 2) all the CPUs assigned to that cpuset were taken offline, and
>>> 3) cpuset v1 is in use and the task had to be migrated to the top cpuset.
>>>
>>> Due to the fact that CPU affinity of the tasks in the top cpuset are
>>> not updated when a CPU hotplug online/offline event happens, offline
>>> CPUs are included in CPU affinity of those tasks. It is possible
>>> that further masking with user_cpus_ptr set by sched_setaffinity(2)
>>> in __set_cpus_allowed_ptr() will leave only offline CPUs in the new
>>> mask causing the subsequent call to __set_cpus_allowed_ptr_locked()
>>> to return failure with an empty CPU affinity.
>>>
>>> Fix this failure by skipping user_cpus_ptr masking if there is no online
>>> CPU left.
>>>
>>> Reported-by: Chen Ridong <chenridong@huaweicloud.com>
>>> Closes: https://lore.kernel.org/lkml/20250714032311.3570157-1-chenridong@huaweicloud.com/
>>> Fixes: da019032819a ("sched: Enforce user requested affinity")
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>>  kernel/sched/core.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 81c6df746df1..208f8af73134 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -3170,12 +3170,13 @@ int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx)
>>>  
>>>  	rq = task_rq_lock(p, &rf);
>>>  	/*
>>> -	 * Masking should be skipped if SCA_USER or any of the SCA_MIGRATE_*
>>> -	 * flags are set.
>>> +	 * Masking should be skipped if SCA_USER, any of the SCA_MIGRATE_*
>>> +	 * flags are set or no online CPU left.
>>>  	 */
>>>  	if (p->user_cpus_ptr &&
>>>  	    !(ctx->flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) &&
>>> -	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
>>> +	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr) &&
>>> +	    cpumask_intersects(rq->scratch_mask, cpu_active_mask))
>>>  		ctx->new_mask = rq->scratch_mask;
>>>  
>>>  	return __set_cpus_allowed_ptr_locked(p, ctx, rq, &rf);
>>
>> Tested-by:  Chen Ridong <chenridong@huawei.com>
>>
> 
> Friendly ping.
> 
> Best regards,
> Ridong
> 

Could someone please review this patch?

-- 
Best regards,
Ridong


