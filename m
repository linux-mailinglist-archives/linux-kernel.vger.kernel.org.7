Return-Path: <linux-kernel+bounces-865105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A00BFC447
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5879661707
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7428C348863;
	Wed, 22 Oct 2025 13:36:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53A5348441
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140191; cv=none; b=UzPWmo5IbiSYmHQAe5q5gwF5koTtLDmh13Rs36MuqdIQVuj8OvH2hDcIcFnt2rc8c+eb6iYV3vjkjTq9UrCYgAb7cMfeqxYI/vOzj8LTDthzuAx6ZriiWsRQ92m/DMwV692F9AnvJV+PRwtcS30o+DelBjY0eAST/pU/meIF+f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140191; c=relaxed/simple;
	bh=y4n+tbwGH/22VkyUJBtBrvR+kyYYvmvo6qbbz2Ce290=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJooqGFwvQVFYqk3EjY1Q6ZM/WBzqBB0CCpEWyN6I2wJtdq8kgxB+YvUFsGA34b8GNfdpxmb8Ts7l4X6JfmqjpNA5ike3Bixc+sI79ixAtU8U+fNQ8wWOabElHrY7U6o7yNvSx93wfbABzLxWQKep5pxea11iujZQA7RIjy3Tr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B6661063;
	Wed, 22 Oct 2025 06:36:20 -0700 (PDT)
Received: from [10.57.33.187] (unknown [10.57.33.187])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B23CF3F59E;
	Wed, 22 Oct 2025 06:36:25 -0700 (PDT)
Message-ID: <e257f8fe-fe9e-40bf-bd5a-6dad0c3d72e0@arm.com>
Date: Wed, 22 Oct 2025 14:36:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: Fix UAF race between device unplug and FW
 event processing
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251022103014.1082629-1-ketil.johnsen@arm.com>
 <20251022143751.769c1f23@fedora>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251022143751.769c1f23@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2025 13:37, Boris Brezillon wrote:
> On Wed, 22 Oct 2025 12:30:13 +0200
> Ketil Johnsen <ketil.johnsen@arm.com> wrote:
> 
>> The function panthor_fw_unplug() will free the FW memory sections.
>> The problem is that there could still be pending FW events which are yet
>> not handled at this point. process_fw_events_work() can in this case try
>> to access said freed memory.
>>
>> This fix introduces a destroyed state for the panthor_scheduler object,
>> and we check for this before processing FW events.
>>
>> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
>> Fixes: de85488138247 ("drm/panthor: Add the scheduler logical block")
>> ---
>> v2:
>> - Followed Boris's advice and handle the race purely within the
>>   scheduler block (by adding a destroyed state)
>> ---
>>  drivers/gpu/drm/panthor/panthor_sched.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
>> index 0cc9055f4ee52..4996f987b8183 100644
>> --- a/drivers/gpu/drm/panthor/panthor_sched.c
>> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
>> @@ -315,6 +315,13 @@ struct panthor_scheduler {
>>  		 */
>>  		struct list_head stopped_groups;
>>  	} reset;
>> +
>> +	/**
>> +	 * @destroyed: Scheduler object is (being) destroyed
>> +	 *
>> +	 * Normal scheduler operations should no longer take place.
>> +	 */
>> +	bool destroyed;
> 
> Do we really need a new field for that? Can't we just reset
> panthor_device::scheduler to NULL early enough in the unplug path?
> I guess it's not that simple if we have works going back to ptdev
> and then dereferencing ptdev->scheduler, but I think it's also
> fundamentally broken to have scheduler works active after the
> scheduler teardown has started, so we might want to add some more
> checks in the work callbacks too.
> 
>>  };
>>  
>>  /**
>> @@ -1765,7 +1772,10 @@ static void process_fw_events_work(struct work_struct *work)
>>  	u32 events = atomic_xchg(&sched->fw_events, 0);
>>  	struct panthor_device *ptdev = sched->ptdev;
>>  
>> -	mutex_lock(&sched->lock);
>> +	guard(mutex)(&sched->lock);
>> +
>> +	if (sched->destroyed)
>> +		return;
>>  
>>  	if (events & JOB_INT_GLOBAL_IF) {
>>  		sched_process_global_irq_locked(ptdev);
>> @@ -1778,8 +1788,6 @@ static void process_fw_events_work(struct work_struct *work)
>>  		sched_process_csg_irq_locked(ptdev, csg_id);
>>  		events &= ~BIT(csg_id);
>>  	}
>> -
>> -	mutex_unlock(&sched->lock);
>>  }
>>  
>>  /**
>> @@ -3882,6 +3890,7 @@ void panthor_sched_unplug(struct panthor_device *ptdev)
>>  	cancel_delayed_work_sync(&sched->tick_work);
>>  
>>  	mutex_lock(&sched->lock);
>> +	sched->destroyed = true;
>>  	if (sched->pm.has_ref) {
>>  		pm_runtime_put(ptdev->base.dev);
>>  		sched->pm.has_ref = false;
> 
> Hm, I'd really like to see a cancel_work_sync(&sched->fw_events_work)
> rather than letting the work execute after we've started tearing down
> the scheduler object.
> 
> If you follow my suggestion to reset the ptdev->scheduler field, I
> guess something like that would do:
> 
> void panthor_sched_unplug(struct panthor_device *ptdev)
> {
>         struct panthor_scheduler *sched = ptdev->scheduler;
> 
> 	/* We want the schedu */
> 	WRITE_ONCE(*ptdev->scheduler, NULL);
> 
> 	cancel_work_sync(&sched->fw_events_work);
>         cancel_delayed_work_sync(&sched->tick_work);
> 
>         mutex_lock(&sched->lock);
>         if (sched->pm.has_ref) {
>                 pm_runtime_put(ptdev->base.dev);
>                 sched->pm.has_ref = false;
>         }
>         mutex_unlock(&sched->lock);
> }
> 
> and
> 
> void panthor_sched_report_fw_events(struct panthor_device *ptdev, u32 events) {
> 	struct panthor_scheduler *sched = READ_ONCE(*ptdev->scheduler);
> 
> 	/* Scheduler is not initialized, or it's gone. */
>         if (!sched)
>                 return;
> 
>         atomic_or(events, &sched->fw_events);
>         sched_queue_work(sched, fw_events);
> }

Note there's also the path of panthor_mmu_irq_handler() calling
panthor_sched_report_mmu_fault() which will need to READ_ONCE() as well
to be safe.

I agree having an extra bool is ugly, but it easier to reason about than
the lock-free WRITE_ONCE/READ_ONCE dance. It worries me that this will
be regressed in the future. I can't immediately see how to wrap this in
a helper to ensure this is kept correct.

Thanks,
Steve

> 
> 
> sched_queue_[delayed_]work() could also be automated to issue a drm_WARN_ON()
> when it's called and ptdev->scheduler = NULL.


