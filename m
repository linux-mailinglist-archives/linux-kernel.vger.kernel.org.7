Return-Path: <linux-kernel+bounces-833746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4AABA2F12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00521179944
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3497E28D829;
	Fri, 26 Sep 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b="unR/6/6h";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="aPCMQVM9"
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348DC10942
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.152.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758875216; cv=none; b=fPcTUGJZZsORMBSvPd962J2jkhAqsqtp4kBlAIWGQp3e4ZUGuOENwfLafpfi1+Uu5J9hYlkJ2GhodQG7q7FwabiAa048U7ZinjFEB1GmsRgG4FcY0v8tfOCebFKM2dO+avBHNQMuft+PVSEusy8sIA+z6BbF02Fgb+dB4PsaGvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758875216; c=relaxed/simple;
	bh=5nm4HS65TfWRYnBfBE/qIYbYQwn56kVqpCVQZBkv0UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkaESMnhLgTGhH6GDjFMFAtrdlpolZ7RvGZ96VZji8z/Ld+ReyVaQLatwyMTE926OBKLqbt1Dm48DjYg4pfrhpkj92gZaEOgm0/reFTHzD0wSnmgz0hpA8pzAWlJyYGdQhhgJd32nnR/W7Jtby5YyJGQIqf5TrsOiE+szjrZPzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net; spf=pass smtp.mailfrom=damsy.net; dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b=unR/6/6h; dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b=aPCMQVM9; arc=none smtp.client-ip=51.159.152.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damsy.net
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1758875193; bh=F2OzFM3T9UbaWHojhoseCQw
	u6OLvdoYSG4Ss6eGnrQM=; b=unR/6/6h1PiOR5EX8XTZn6gJDTuqDpoYc4VyHYVQp7FDosVOlO
	8d6SR084FA9qAfws85M4EEsMm77x/QfZU0cp5CZuDlfO8FMc+h/0a6l5C/LG49o1YJbCyYFMENy
	f30lTQpCUaTjYvravNwE/X+iXPOxK14vvE3ggCYXeSuZ+432BQJiSgB1sGAkyHCnSRfkVMFTlQq
	h3zJblN1v1Ucf1jxZWoYttItbtHRnctUcJrn0Z2O+b+JqNSV67QDiMF7sppdojTUUijU5vUvKw4
	ArNX/ChgflWmMe9ZVRo6Y2kKxUB5B/mBqRGKSEvqsd6DfdR87Y32Z7a2yPLiXFfCajA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1758875193; bh=F2OzFM3T9UbaWHojhoseCQw
	u6OLvdoYSG4Ss6eGnrQM=; b=aPCMQVM9cp+MhVLlfuG5SFG1R0W4wX+MGuk4gYPTkhrQZvT1pl
	zr3dzBbv9Dsl8vFoyaz1hVOJHCP3YziEWICQ==;
Message-ID: <1eeb09dd-a27e-478f-a0f1-30d059f20018@damsy.net>
Date: Fri, 26 Sep 2025 10:26:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/sched: limit sched score update to jobs change
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Simona Vetter <simona@ffwll.ch>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Philipp Stanner <phasta@kernel.org>
References: <20250822134348.6819-1-pierre-eric.pelloux-prayer@amd.com>
 <20250822134348.6819-2-pierre-eric.pelloux-prayer@amd.com>
 <abb776bc-5b13-4db7-9421-59259119b859@ursulin.net>
 <5183ed88-1634-42c2-9bd8-ed0e626f877b@damsy.net>
 <f5a7ceb4-2313-48b9-bf75-628e9ad91757@ursulin.net>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <f5a7ceb4-2313-48b9-bf75-628e9ad91757@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/09/2025 à 10:24, Tvrtko Ursulin a écrit :
> 
> On 26/09/2025 09:20, Pierre-Eric Pelloux-Prayer wrote:
>> Hi,
>>
>> Le 01/09/2025 à 11:20, Tvrtko Ursulin a écrit :
>>>
>>>
>>> + Tomeu and Oded
>>>
>>> On 22/08/2025 14:43, Pierre-Eric Pelloux-Prayer wrote:
>>>> Currently, the scheduler score is incremented when a job is pushed to an
>>>> entity and when an entity is attached to the scheduler.
>>>>
>>>> This leads to some bad scheduling decision where the score value is
>>>> largely made of idle entities.
>>>>
>>>> For instance, a scenario with 2 schedulers and where 10 entities submit
>>>> a single job, then do nothing, each scheduler will probably end up with
>>>> a score of 5.
>>>> Now, 5 userspace apps exit, so their entities will be dropped. In
>>>> the worst case, these apps' entities where all attached to the same
>>>> scheduler and we end up with score=5 (the 5 remaining entities) and
>>>> score=0, despite the 2 schedulers being idle.
>>>> When new entities show up, they will all select the second scheduler
>>>> based on its low score value, instead of alternating between the 2.
>>>>
>>>> Some amdgpu rings depended on this feature, but the previous commit
>>>> implemented the same thing in amdgpu directly so it can be safely
>>>> removed from drm/sched.
>>>>
>>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux- prayer@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/scheduler/sched_main.c | 2 --
>>>>   1 file changed, 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/ drm/ 
>>>> scheduler/sched_main.c
>>>> index 5a550fd76bf0..e6d232a8ec58 100644
>>>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>>>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>>>> @@ -206,7 +206,6 @@ void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
>>>>       if (!list_empty(&entity->list))
>>>>           return;
>>>> -    atomic_inc(rq->sched->score);
>>>>       list_add_tail(&entity->list, &rq->entities);
>>>>   }
>>>> @@ -228,7 +227,6 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
>>>>       spin_lock(&rq->lock);
>>>> -    atomic_dec(rq->sched->score);
>>>>       list_del_init(&entity->list);
>>>>       if (rq->current_entity == entity)
>>>
>>> LGTM.
>>>
>>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>
>>
>> Thanks.
>>
>>> Only detail is, I did a revisit of the scheduler users and it looks like the 
>>> new rocket driver is the only one other than amdgpu which passes a list of 
>>> more than one scheduler to drm_sched_entity_init. I don't *think* it would be 
>>> affected though. It would still pick the least loaded (based on active jobs) 
>>> scheduler at job submit time. Unless there is some hidden behaviour in that 
>>> driver where it would be important to consider number of entities too. 
>>> Anyway, it would be good for rocket driver to double-check and ack.
>>>
>>
>> Tomeu, Oded: any concerns about this change?
> 
> Tomeu acked it in case you missed it:
> 
> https://lore.kernel.org/dri-devel/20250822134348.6819-1-pierre-eric.pelloux- 
> prayer@amd.com/T/#m4efa0d69211b2bb378cfb302e459faa30e57f58c

Indeed I missed it, sorry!

I'll update patch 1/2 based on Philipp's comment and send v2 then.

Thanks.



