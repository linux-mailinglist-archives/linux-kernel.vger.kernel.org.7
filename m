Return-Path: <linux-kernel+bounces-888229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD63C3A424
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2663B9289
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786512C031B;
	Thu,  6 Nov 2025 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="D6vT9roT"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B664D26B08F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762424586; cv=none; b=lI1Ekyg8EmUDBJzc/jfCXHkvjeDt09a0oPlaBhEM5pXcoLGaSBA8plQkBJZiZvc2OtOsiHlpSusH8FsoBfh5/xT9I+h50wbv7WfvmimQ5SLtYAmD+axkDMbOoX/fVZEA/+yta3DtDGXoHPqG1WIcK/rhibxu41f+hw1eYh2v/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762424586; c=relaxed/simple;
	bh=3VcIWGEidVBc6S38LPZkC6VXAiK5JHVOsJryEifSV+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qrmhEvh6i71QyN6HpdydkbHx/rktUTc9hu+PNU1GscgG/qsN6hPKs0gCkRY6pprpiHMcmm5sTOrE0wUQdq912AltLXKUliJqz+DEUxW+lmR7MYF2OdlazWG5GFe/EDbp7UUE1/M3vXmMHBlFrsMewUbMl2CDOLMsD2t1etVvUmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=D6vT9roT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47112a73785so4734665e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1762424583; x=1763029383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VgOP42kyVIF+OaMBMLYClO2LZ5oQJ3Uk17eUAjkdIvg=;
        b=D6vT9roTI1x4BCZBOD5YYJIg2jxQvudynP6jXxH364wrYpgCx9TZKSNBB7G2n9L4QU
         WtgVz5etJGoA2zQi1lP4rciBxqU73YirVEZigbY8xwJLYvTJTRpzHGY3Q47wF8uDjiYP
         GVwfNEfVazH8DtOYKJuy711MpZ7IkubaIKOxRetoJ6XjKuRTs1GWUSbQ2rop5dU3Leq3
         y4LHQ5PZ/56zWgFDaYaH6rS9Aqr4AIcoaiakngieEUFGZ9Kte9wKZTZ8heNOhOn32M1D
         Zpq9T2SamBW8kBuZpQjBIghUNwhob+WtTW4jJp38oA2JSx1nP6tcVX7e2zRAi3BtEppE
         4Exg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762424583; x=1763029383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgOP42kyVIF+OaMBMLYClO2LZ5oQJ3Uk17eUAjkdIvg=;
        b=HV+jDhGJstiOGs/CXUjM64fW4doWVeOE2qpQAjbmzZR1Y0oQgp5Toec5vrfT2riJXc
         ZhpTiqpk6U9ME24uMO8B0WxCjEu5A7OCen9V1HgdILwZHtS3WmD6baI/LiyLigRH9bSp
         hmRTwggkEJS3T2/hkTNh2ZtZg6KwgPzUCombe9Mt8Bj3Pf3k1LcC7cPUvpDqvjwxRhgp
         zNj9wVf6qybdlmtNg5Gty0ySAw5kqdXXTYaGzxwGUrGaBVBKn+PoMVUoX4ntiR6m8JN3
         Ah/x07Q1fALpDSV+dyTPBxVREViMWKGmn2yPTNJhAhic0foV+OY+H6cwR7JTlILnvGBY
         s1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa8aOvKh0Z6tzDzkw1c/h6aFhrJ1qXVkbfEqiWaISR//RQ45Z8EL6dadtL4EI/XWRrTU5VPioigKNaB0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyea0pVO4AHMMbi5ltnqkjll6JieJ8eX9d0Blef9/FgG3FyQ2F0
	vQRqaS5q+ebNA6SsAHtIcXFelNZpVhPrrhNU+zpLd5C2dqgq6MYDUPUQn//L0yJhijQ=
X-Gm-Gg: ASbGncuJLsTFq5GWdirQjCOIJWloL9Y4wMGaCEYyFjm0UPqsw42oTRVgERrirGMh8bV
	oMV4/TrQm0Rap4DnX5ab+91RCJQ4F/Pq0tgocz6xMGegYfC9keai11UxxtNtrbcW0NQOoQIsvn5
	AQkGz06HlP3XXq5xCRyROcB4DExc12QJSmwADyIU6zHqSqQv+uCmWuc+zzy62NQ6B8nT6Y1kf1p
	d9hbRAjmitZN1HbEBxCuVK6AqcVgdzAXZEd3F0nIarHJO3pUEKPJnfQ4IdELilS5/b00qy5V7pA
	zGmnE2H5ors7/I0kiClNTok7q1MDl3MWs2H07xnRzy+5f+aBmxZgbcZhMwwgorePCqH7acKCYmo
	5S4JdUpMmDo6Kn7jnMGEnNSnewYXTFJBt63mGDxzk2rHn0+hSve2A/Nxp8QlVdu4SdE5yaJDQvP
	rJAYnZxqWcWNzNfLRS0ln/lTi2E+8=
X-Google-Smtp-Source: AGHT+IEtpJZ2x8DlPogW4WdO8xvm2uRzmqJs0tYIUZ3boZRuyGklclD2npgr2Aq/2sPhN6v4NkYQGw==
X-Received: by 2002:a05:600c:1e1e:b0:476:6ef6:e28c with SMTP id 5b1f17b1804b1-4775ce23c7amr41354635e9.38.1762424582943;
        Thu, 06 Nov 2025 02:23:02 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc552sm106633505e9.6.2025.11.06.02.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 02:23:02 -0800 (PST)
Message-ID: <6a7159d5-fb5c-44b5-ba90-2dcd02b59097@ursulin.net>
Date: Thu, 6 Nov 2025 10:23:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drm/amdgpu: increment sched score on entity
 selection
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251106093933.18859-1-pierre-eric.pelloux-prayer@amd.com>
 <20251106093933.18859-3-pierre-eric.pelloux-prayer@amd.com>
 <9e5abc5f-1948-4b18-8485-6540f84cdfd8@ursulin.net>
 <a87d491d-e0ff-4bf6-bce8-6d2935271e6b@damsy.net>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <a87d491d-e0ff-4bf6-bce8-6d2935271e6b@damsy.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 06/11/2025 10:10, Pierre-Eric Pelloux-Prayer wrote:
> 
> 
> Le 06/11/2025 à 11:00, Tvrtko Ursulin a écrit :
>>
>> On 06/11/2025 09:39, Pierre-Eric Pelloux-Prayer wrote:
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
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux- 
>>> prayer@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 21 ++++++++++++++++-----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>>>   2 files changed, 17 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/ 
>>> drm/amd/ amdgpu/amdgpu_ctx.c
>>> index afedea02188d..953c81c928c1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>> @@ -209,6 +209,7 @@ static int amdgpu_ctx_init_entity(struct 
>>> amdgpu_ctx *ctx, u32 hw_ip,
>>>       struct amdgpu_ctx_entity *entity;
>>>       enum drm_sched_priority drm_prio;
>>>       unsigned int hw_prio, num_scheds;
>>> +    struct amdgpu_ring *aring;
>>>       int32_t ctx_prio;
>>>       int r;
>>> @@ -239,11 +240,13 @@ static int amdgpu_ctx_init_entity(struct 
>>> amdgpu_ctx *ctx, u32 hw_ip,
>>>               goto error_free_entity;
>>>       }
>>> -    /* disable load balance if the hw engine retains context among 
>>> dependent jobs */
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
>>> @@ -258,6 +261,11 @@ static int amdgpu_ctx_init_entity(struct 
>>> amdgpu_ctx *ctx, u32 hw_ip,
>>>       if (cmpxchg(&ctx->entities[hw_ip][ring], NULL, entity))
>>>           goto cleanup_entity;
>>> +    if (aring->funcs->engine_retains_context) {
>>> +        entity->sched_score = sched->score;
>>> +        atomic_inc(entity->sched_score);
>>
>> Maybe you missed it, in the last round I asked this:
> 
> I missed it, sorry.
> 
>>
>> """
>> Here is would always be sched->score == aring->sched_score, right?
> 
> Yes because drm_sched_init is called with args.score = ring->sched_score
> 
>>
>> If so it would probably be good to either add that assert, or even to 
>> just fetch it from there. Otherwise it can look potentially concerning 
>> to be fishing out the pointer from scheduler internals.
>>
>> The rest looks good to me.
>> """
>>
>> Because grabbing a pointer from drm_sched->score and storing it in AMD 
>> entity can look scary, since sched->score can be scheduler owned.
>>
>> Hence I was suggesting to either fish it out from aring->sched_score. 
>> If it is true that they are always the same atomic_t at this point.
> 
> I used sched->score, because aring->sched_score is not the one we want 
> (the existing aring points to scheds[0], not the selected sched). But I 
> can change the code to:
> 
> if (aring->funcs->engine_retains_context) {
>     aring = container_of(sched, struct amdgpu_ring, sched)
>     entity->sched_score = aring->sched_score;
>     atomic_inc(entity->sched_score);
> }
> 
> If it's preferred.

For me it is, yes. Because it removes any doubt on who owns the atomic_t 
pointed to. And it also isolates the driver from any changes in DRM 
scheduler structures.

With that:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

>>> +    }
>>> +
>>>       return 0;
>>>   cleanup_entity:
>>> @@ -514,6 +522,9 @@ static void amdgpu_ctx_do_release(struct kref *ref)
>>>               if (!ctx->entities[i][j])
>>>                   continue;
>>> +            if (ctx->entities[i][j]->sched_score)
>>> +                atomic_dec(ctx->entities[i][j]->sched_score);
>>> +
>>>               drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
>>>           }
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/ 
>>> drm/amd/ amdgpu/amdgpu_ctx.h
>>> index 090dfe86f75b..f7b44f96f374 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>>> @@ -39,6 +39,7 @@ struct amdgpu_ctx_entity {
>>>       uint32_t        hw_ip;
>>>       uint64_t        sequence;
>>>       struct drm_sched_entity    entity;
>>> +    atomic_t        *sched_score;
>>>       struct dma_fence    *fences[];
>>>   };


