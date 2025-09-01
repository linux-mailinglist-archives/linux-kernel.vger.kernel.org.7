Return-Path: <linux-kernel+bounces-794630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C8FB3E475
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F077C16CCAE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED5A1DB34C;
	Mon,  1 Sep 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b="JEIZaDVs";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="x8hDoZTV"
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876A2A1B2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.152.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732624; cv=none; b=iUV5YzRPozVWDZQhG1VWU+NXwuRzDfArSXTgnk7489fLnZ7tZ2RVKi49zo2fyq0T8Q5bxNnDzaGIDieefIxvC2EwE+2H2xqyiFsq/OXSLMLe6y8r74+JTIiyNKGRj+8BQrwUOAqXt9iXodhnMp7Fs15WzSbpfZfzImB9K9Z622Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732624; c=relaxed/simple;
	bh=UNAROwscGWiJGVwNB7APBWmn5bQlb3OTupDa5/PNPHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZoO5Y8SbVutf/AYaAnULg+bxlk6N8izi79O5TOgLSSGDT4Gyy/RWbCxrhZU30pQ80gvktEqBsqzgcO1j4Fzw6+O68PfwXZp3QIdXoQnh3B+QDzo56pz58ZReB8rwaEqIb/8yqA5rdVtICH4ELsRaoG2UPiKbPPnru0wIEusONac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net; spf=pass smtp.mailfrom=damsy.net; dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b=JEIZaDVs; dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b=x8hDoZTV; arc=none smtp.client-ip=51.159.152.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damsy.net
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1756732446; bh=7ECHN7M/kl3GQF4/8IGepx+
	i7mB1UdMquaG7D1kI94Y=; b=JEIZaDVseVv66Xf/O+7mENL/rSPdZKDxm+P1qfrfG2sKe9cGMm
	Va2nEqyBaE5cye8aVnHTwcGlR8tSrPNYfbclbY997f3EqaXnBwCO37poOluQSh5vOjD34OjVJUU
	4VRqHA8ALueGYGeoZhBFGw54pTLRNWFqY1MMDMa4voXWVTtUPhZWZVd9+ZPS5byObB4a4qqL53m
	akRFj/NFx5rCX9basg3m360cpHoIDGRGArjKOIqL3+Mjs0BD+Zn/6P5WCdCum4mNQ1G3g0Y46+f
	yMyKpBzh5qjMjWcDb073uaOlBJc9dKYssMCBHSD/F0NYFogg9LkIOsy6vNcMkqpS4Zg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1756732446; bh=7ECHN7M/kl3GQF4/8IGepx+
	i7mB1UdMquaG7D1kI94Y=; b=x8hDoZTVgRBGz3D10HTukWs4uUrl5iV9qZcHI/xxwHu1JkajeL
	K1/FU2cv41gjf0Hzp10Zq5ZHTLpC9we09oCQ==;
Message-ID: <b1a8f459-93dd-4b6c-b29e-c68fba19f6fc@damsy.net>
Date: Mon, 1 Sep 2025 15:14:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/sched: limit sched score update to jobs change
To: phasta@kernel.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250822134348.6819-1-pierre-eric.pelloux-prayer@amd.com>
 <20250822134348.6819-2-pierre-eric.pelloux-prayer@amd.com>
 <9b68898ca34483b52d7f4510747a20bce52751c7.camel@mailbox.org>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <9b68898ca34483b52d7f4510747a20bce52751c7.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 25/08/2025 à 15:13, Philipp Stanner a écrit :
> On Fri, 2025-08-22 at 15:43 +0200, Pierre-Eric Pelloux-Prayer wrote:
>> Currently, the scheduler score is incremented when a job is pushed to an
>> entity and when an entity is attached to the scheduler.
> 
> It's indeed awkward why attaching is treated equivalently to job
> submission.
> 
> Can you expand the documentation for drm_sched_init_args a bit so that
> it gets clearer what the score is supposed to do?


drm_sched_init_args.score is the feature allowing multiple schedulers to share a 
score so I suppose you meant drm_gpu_scheduler.score?

The doc currently says "score to help loadbalancer pick a idle sched" which is a 
bit vague. It could be modified to become:

   @score: holds the number of yet-to-be-completed jobs pushed to each scheduler.
           It's used when load balancing between different schedulers.

What do you think?

> 
>>
>> This leads to some bad scheduling decision where the score value is
>> largely made of idle entities.
>>
>> For instance, a scenario with 2 schedulers and where 10 entities submit
>> a single job, then do nothing, each scheduler will probably end up with
>> a score of 5.
>> Now, 5 userspace apps exit, so their entities will be dropped.
>>
> 
> "entities will be dropped" == "drm_sched_entity_kill() gets called",
> right?

Yes.

>> In
>> the worst case, these apps' entities where all attached to the same
> 
> s/where/were
> 
> or better yet: "could be"

Will fix, thanks.

> 
>> scheduler and we end up with score=5 (the 5 remaining entities) and
>> score=0, despite the 2 schedulers being idle.
> 
> Sounds indeed like a (small) problem to me.
> 
> 
>> When new entities show up, they will all select the second scheduler
>> based on its low score value, instead of alternating between the 2.
>>
>> Some amdgpu rings depended on this feature, but the previous commit
>> implemented the same thing in amdgpu directly so it can be safely
>> removed from drm/sched.
> 
> Can we be that sure that other drivers don't depend on it, though? I
> suspect it's likely that it's just amdgpu, but…
> 

Aside from the new "rocket" as pointed out by Tvrtko, amdgpu is the only driver 
passing more than one schedulers to entities so they're the only ones that could 
be affected.

I verified amdgpu and Tvrtko pinged the rocket maintainers in the other thread.

> 
> 
> BTW, since you're cleaning up related stuff currently: I saw that it
> seems that the only driver that sets &struct drm_sched_init_args.score
> is amdgpu. Would be cool if you can take a look whether that's still
> needed.

It cannot really be removed yet as it's useful when a single hardware block is 
exposed through different schedulers (so pushing jobs to one of the schedulers 
should increase the load of the underlying hw).

Thanks,
Pierre-Eric

> 
> 
> P.
> 
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>   drivers/gpu/drm/scheduler/sched_main.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
>> index 5a550fd76bf0..e6d232a8ec58 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -206,7 +206,6 @@ void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
>>   	if (!list_empty(&entity->list))
>>   		return;
>>   
>> -	atomic_inc(rq->sched->score);
>>   	list_add_tail(&entity->list, &rq->entities);
>>   }
>>   
>> @@ -228,7 +227,6 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
>>   
>>   	spin_lock(&rq->lock);
>>   
>> -	atomic_dec(rq->sched->score);
>>   	list_del_init(&entity->list);
>>   
>>   	if (rq->current_entity == entity)


