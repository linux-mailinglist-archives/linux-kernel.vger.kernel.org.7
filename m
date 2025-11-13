Return-Path: <linux-kernel+bounces-899861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3529C59110
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72333B7E82
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B4C3590CF;
	Thu, 13 Nov 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b="rOqI9L1T";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="dMGNyJQi"
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AE63BB40
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.152.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052240; cv=none; b=KG0gor7NBONufQwQ7xviUPxMjgG5WHxhjp8hGFjFlPt+t1N013Z2hX3RtbsQ4gp8j5qfE+ts7NHO/64BzUt19SQeCq7u0aR22M8oox9fSVu91/+NeBmhDiSIa2SfKCs6q7hg79G++tCYI9d/wci7/y57SF/R0y0ofXDkE8TGeXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052240; c=relaxed/simple;
	bh=M9YTZ3lmop9V3/WkTQGpF6a3OMeldw3nz0ErLVNMkiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxO2RAC8FjKpTZ5OhW26hgrQY3UJ4qG3jmPljGWZJPoUJpVlV6IodMizTQworbSQp4jUvmBiSd+Hg0OkujAhfLRlw6Sr1yPNFmKEw1z1gmLBuBe72Hb/nj7sqv2FwdTaSyFYv9ME+adRGYjmKI8I77YSl+dySVmnGU1RlFOoPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net; spf=pass smtp.mailfrom=damsy.net; dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b=rOqI9L1T; dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b=dMGNyJQi; arc=none smtp.client-ip=51.159.152.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damsy.net
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1763052209; bh=NJSnPkVvH7xY6kY2ZZ7qcZ0
	QmyJLiVtggX4UglWKEzc=; b=rOqI9L1T/zsxT2GprcbxfTD760Dihdk9Grf11UsOGPfg45K/eJ
	5nv11jZwvqbISzpVO669YOHaE4ZjfrHiAAClCsLLlu94GPXeym03kDvaY8lxaOaIDCSm7XC2ntZ
	dE/wFf6OrNlgreSv6Qietbp7Gk2o53qvb9AOTpTyKtTKbhUUqSbml1maPeL0EIdcinr/NtApJ0r
	10QI+1WEZWSal/W5C2lE20w9XWFcG7rAxloksldPyrH9+oDEC0Q7C4gYNz8FQrKkT9ES12EQxPI
	flQNFrh/E7DTPKRPn8inBiDNTAMpedzYhHYe0zQriaa6wBLg4p9VtUln08l3n3TFTKw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1763052209; bh=NJSnPkVvH7xY6kY2ZZ7qcZ0
	QmyJLiVtggX4UglWKEzc=; b=dMGNyJQip1hx78aX9Td42fdPum8wK8yjb0/wrVx7FE/h6lYWbC
	MjgLMTSmFGbIFiazgb0jahI2M08Yv6uZtpDA==;
Message-ID: <e9b84f62-f4e4-4c11-a1df-d429f0135cab@damsy.net>
Date: Thu, 13 Nov 2025 17:43:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] drm/amdgpu: increment sched score on entity
 selection
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251107090425.23199-1-pierre-eric.pelloux-prayer@amd.com>
 <20251107090425.23199-2-pierre-eric.pelloux-prayer@amd.com>
 <5717c024-0200-4b23-a25b-681ef0937d6f@amd.com>
 <9950dd13-d5c1-4b34-b3f9-2528a1ffb989@igalia.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <9950dd13-d5c1-4b34-b3f9-2528a1ffb989@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 07/11/2025 à 11:39, Tvrtko Ursulin a écrit :
> 
> On 07/11/2025 10:26, Christian König wrote:
>> On 11/7/25 10:04, Pierre-Eric Pelloux-Prayer wrote:
>>> For hw engines that can't load balance jobs, entities are
>>> "statically" load balanced: on their first submit, they select
>>> the best scheduler based on its score.
>>> The score is made up of 2 parts:
>>> * the job queue depth (how much jobs are executing/waiting)
>>> * the number of entities assigned
>>>
>>> The second part is only relevant for the static load balance:
>>> it's a way to consider how many entities are attached to this
>>> scheduler, knowing that if they ever submit jobs they will go
>>> to this one.
>>>
>>> For rings that can load balance jobs freely, idle entities
>>> aren't a concern and shouldn't impact the scheduler's decisions.
>>>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 22 +++++++++++++++++-----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>>>   2 files changed, 18 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/ 
>>> amdgpu/amdgpu_ctx.c
>>> index afedea02188d..4d91cbcbcf25 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -209,6 +209,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, 
>>> u32 hw_ip,
>>>       struct amdgpu_ctx_entity *entity;
>>>       enum drm_sched_priority drm_prio;
>>>       unsigned int hw_prio, num_scheds;
>>> +    struct amdgpu_ring *aring;
>>>       int32_t ctx_prio;
>>>       int r;
>>> @@ -239,11 +240,13 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx 
>>> *ctx, u32 hw_ip,
>>>               goto error_free_entity;
>>>       }
>>> -    /* disable load balance if the hw engine retains context among dependent 
>>> jobs */
>>> -    if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
>>> -        hw_ip == AMDGPU_HW_IP_VCN_DEC ||
>>> -        hw_ip == AMDGPU_HW_IP_UVD_ENC ||
>>> -        hw_ip == AMDGPU_HW_IP_UVD) {
>>> +    sched = scheds[0];
>>> +    aring = container_of(sched, struct amdgpu_ring, sched);
>>> +
>>> +    if (aring->funcs->engine_retains_context) {
>>> +        /* Disable load balancing between multiple schedulers if the hw
>>> +         * engine retains context among dependent jobs.
>>> +         */
>>>           sched = drm_sched_pick_best(scheds, num_scheds);
>>>           scheds = &sched;
>>>           num_scheds = 1;
>>> @@ -258,6 +261,12 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx 
>>> *ctx, u32 hw_ip,
>>>       if (cmpxchg(&ctx->entities[hw_ip][ring], NULL, entity))
>>>           goto cleanup_entity;
>>> +    if (aring->funcs->engine_retains_context) {
>>> +        aring = container_of(sched, struct amdgpu_ring, sched);
>>> +        entity->sched_score = aring->sched_score;
>>> +        atomic_inc(entity->sched_score);
>>> +    }
>>> +
>>>       return 0;
>>>   cleanup_entity:
>>> @@ -514,6 +523,9 @@ static void amdgpu_ctx_do_release(struct kref *ref)
>>>               if (!ctx->entities[i][j])
>>>                   continue;
>>> +            if (ctx->entities[i][j]->sched_score)
>>> +                atomic_dec(ctx->entities[i][j]->sched_score);
>>> +
>>>               drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
>>>           }
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/ 
>>> amdgpu/amdgpu_ctx.h
>>> index 090dfe86f75b..f7b44f96f374 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> @@ -39,6 +39,7 @@ struct amdgpu_ctx_entity {
>>>       uint32_t        hw_ip;
>>>       uint64_t        sequence;
>>>       struct drm_sched_entity    entity;
>>> +    atomic_t        *sched_score;
>>
>> I would rather prefer to not have that additional member here.
>>
>> Additional to that we are messing with the internals of the scheduler here and 
>> should probably have two clean functions to increase/decrease the score.

The problem of exposing a function to cleanly inc/dec the score, is that it 
requires entity->rq to never be set to NULL.

So I'd rather keep the current code / workaround in amdgpu. Or, I could modify 
the next one to do something like this:

if (entity->inc_score_on_add)
    atomic_inc(rq->sched->score);

= keeping the existing logic in the scheduler, but making it opt-in instead of 
the default behavior.

Pierre-Eric


> 
> Don't forget it is a driver owned atomic_t so I think it is fine driver 
> manipulates it on its own.
> 
> Regards,
> 
> Tvrtko
> 
> 
>> Regards,
>> Christian.
>>
>>>       struct dma_fence    *fences[];
>>>   };
>>


