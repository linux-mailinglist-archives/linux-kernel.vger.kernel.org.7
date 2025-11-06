Return-Path: <linux-kernel+bounces-888210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F5FC3A357
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111514617EE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4696D30C345;
	Thu,  6 Nov 2025 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b="FdNoIyU0";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="Nito9qib"
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5662DF131
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.152.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423882; cv=none; b=AJnxJEZR2lCdfAdAHHlmymkpddz4oXpvWp+AaW7Ls4airc1xQeGI66700VjiKgkI+y1lQsxGL+w0HaUjyX4JlME9XIMgnHnoJDOz3ELdKQlebX2bzGvCYaPMTAguD/dt679XjvvQbPpvLafhwS/0gANTioiMnYMEgWbOiM8BUz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423882; c=relaxed/simple;
	bh=Y5z1uXmZs/OdJ17uDDr/wJqUZdutnhpg605mFdWeSzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQ/iECNQc+gARBxAFj0cvoITrHuYJfLcB0GXaEY12ZnGrRoC1hZfK28+xF7PAqlUqictslXTq+30ksnHFHBHZ93MwL6r7/8x6QSyu4WZ0P8oS51AXJDIkWBwl8v4oYov3d0On1GXzz3jdYpnZXwZYQyESverHO6o9jquEkzZMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net; spf=pass smtp.mailfrom=damsy.net; dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b=FdNoIyU0; dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b=Nito9qib; arc=none smtp.client-ip=51.159.152.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damsy.net
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1762423823; bh=ejLPRY3iozpYHHEti2rE7LN
	zfuScAzWruHHkQQn0/lQ=; b=FdNoIyU0AcOXJV90e6yWKsRg+Jsg5pgdjd0yKSyUz7HYYw429p
	hWUdHoTkspboJjGXfyfzPUJZmAqhF/pxKyjZ+se46kp1beiRn73IsAsAezW/08fEMD0rn0rf0VH
	8+HGuip3zJPedlYhTCU2VbYwBgSIX4PWjoMuADVp2ImU45F1gFnnpXVIajmPyG+E1Nz0IanIuVi
	598WLh1s2UlSHHfQhsuEhVX36mqWNUc1ykfyhW3idGDYL/sz36S87dzCDM4se570AemA1m/QbC+
	UKN6cudRs/RiWtF2uRQKD3suu1OfsHZDyPPEM5nY3VxaV7cHsfcTsR3MTfxTUqiSM5w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1762423823; bh=ejLPRY3iozpYHHEti2rE7LN
	zfuScAzWruHHkQQn0/lQ=; b=Nito9qibsjdqNZfJbc7et2R3jg7txn1gwFaaRuvOJEyl2WH1dT
	cgf7iKfE8ymmuILBhZud9+ZFAEVn+6jBL1Ag==;
Message-ID: <a87d491d-e0ff-4bf6-bce8-6d2935271e6b@damsy.net>
Date: Thu, 6 Nov 2025 11:10:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drm/amdgpu: increment sched score on entity
 selection
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251106093933.18859-1-pierre-eric.pelloux-prayer@amd.com>
 <20251106093933.18859-3-pierre-eric.pelloux-prayer@amd.com>
 <9e5abc5f-1948-4b18-8485-6540f84cdfd8@ursulin.net>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <9e5abc5f-1948-4b18-8485-6540f84cdfd8@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 06/11/2025 à 11:00, Tvrtko Ursulin a écrit :
> 
> On 06/11/2025 09:39, Pierre-Eric Pelloux-Prayer wrote:
>> For hw engines that can't load balance jobs, entities are
>> "statically" load balanced: on their first submit, they select
>> the best scheduler based on its score.
>> The score is made up of 2 parts:
>> * the job queue depth (how much jobs are executing/waiting)
>> * the number of entities assigned
>>
>> The second part is only relevant for the static load balance:
>> it's a way to consider how many entities are attached to this
>> scheduler, knowing that if they ever submit jobs they will go
>> to this one.
>>
>> For rings that can load balance jobs freely, idle entities
>> aren't a concern and shouldn't impact the scheduler's decisions.
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 21 ++++++++++++++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>>   2 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/ 
>> amdgpu/amdgpu_ctx.c
>> index afedea02188d..953c81c928c1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -209,6 +209,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, 
>> u32 hw_ip,
>>       struct amdgpu_ctx_entity *entity;
>>       enum drm_sched_priority drm_prio;
>>       unsigned int hw_prio, num_scheds;
>> +    struct amdgpu_ring *aring;
>>       int32_t ctx_prio;
>>       int r;
>> @@ -239,11 +240,13 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx 
>> *ctx, u32 hw_ip,
>>               goto error_free_entity;
>>       }
>> -    /* disable load balance if the hw engine retains context among dependent 
>> jobs */
>> -    if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
>> -        hw_ip == AMDGPU_HW_IP_VCN_DEC ||
>> -        hw_ip == AMDGPU_HW_IP_UVD_ENC ||
>> -        hw_ip == AMDGPU_HW_IP_UVD) {
>> +    sched = scheds[0];
>> +    aring = container_of(sched, struct amdgpu_ring, sched);
>> +
>> +    if (aring->funcs->engine_retains_context) {
>> +        /* Disable load balancing between multiple schedulers if the hw
>> +         * engine retains context among dependent jobs.
>> +         */
>>           sched = drm_sched_pick_best(scheds, num_scheds);
>>           scheds = &sched;
>>           num_scheds = 1;
>> @@ -258,6 +261,11 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, 
>> u32 hw_ip,
>>       if (cmpxchg(&ctx->entities[hw_ip][ring], NULL, entity))
>>           goto cleanup_entity;
>> +    if (aring->funcs->engine_retains_context) {
>> +        entity->sched_score = sched->score;
>> +        atomic_inc(entity->sched_score);
> 
> Maybe you missed it, in the last round I asked this:

I missed it, sorry.

> 
> """
> Here is would always be sched->score == aring->sched_score, right?

Yes because drm_sched_init is called with args.score = ring->sched_score

> 
> If so it would probably be good to either add that assert, or even to just fetch 
> it from there. Otherwise it can look potentially concerning to be fishing out 
> the pointer from scheduler internals.
> 
> The rest looks good to me.
> """
> 
> Because grabbing a pointer from drm_sched->score and storing it in AMD entity 
> can look scary, since sched->score can be scheduler owned.
> 
> Hence I was suggesting to either fish it out from aring->sched_score. If it is 
> true that they are always the same atomic_t at this point.

I used sched->score, because aring->sched_score is not the one we want (the 
existing aring points to scheds[0], not the selected sched). But I can change 
the code to:

if (aring->funcs->engine_retains_context) {
    aring = container_of(sched, struct amdgpu_ring, sched)
    entity->sched_score = aring->sched_score;
    atomic_inc(entity->sched_score);
}

If it's preferred.

Pierre-Eric

> 
> Regards,
> 
> Tvrtko
> 
>> +    }
>> +
>>       return 0;
>>   cleanup_entity:
>> @@ -514,6 +522,9 @@ static void amdgpu_ctx_do_release(struct kref *ref)
>>               if (!ctx->entities[i][j])
>>                   continue;
>> +            if (ctx->entities[i][j]->sched_score)
>> +                atomic_dec(ctx->entities[i][j]->sched_score);
>> +
>>               drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
>>           }
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/ 
>> amdgpu/amdgpu_ctx.h
>> index 090dfe86f75b..f7b44f96f374 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> @@ -39,6 +39,7 @@ struct amdgpu_ctx_entity {
>>       uint32_t        hw_ip;
>>       uint64_t        sequence;
>>       struct drm_sched_entity    entity;
>> +    atomic_t        *sched_score;
>>       struct dma_fence    *fences[];
>>   };


