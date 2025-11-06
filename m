Return-Path: <linux-kernel+bounces-888158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4B8C3A03E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25C084FBCA7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AC630B520;
	Thu,  6 Nov 2025 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="EuKHeUq0"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2830C639
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423218; cv=none; b=Uxhfrs7pdH7CA5ewwo75Yiamzo0f1hTMyvfnZYQbnsAJhhTuE6UzuxYbdji+E5eipNsGL/fBvVNgTvhvPTgcy7MchN/9hF8E5kQZZjK2IrnJQOc7bENyzKkI6Eh1JrUy7org2lHyOOODWhGBkIdVXh/D5P+Sl9u0m8ddQKobr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423218; c=relaxed/simple;
	bh=71bGn3ZEXokAIMqEgnrFH5n4DUEahdvZ/KNncEvMUog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tvQ6XwN6RhEpDCUeSU4ChKnmkAezoZbfWdNVKa8H6P8hPqz3+rHVFFVM9L4Dh5k2B8i5PgWnVI0g9qdyaE42EwYgJ6FIp1q7nnwZhRyJmVh7aezFtL2S9daoTqXzfGMZ0XbGeEit281HDtaePXR9oagb6S13obvUwmKh6eJQBmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=EuKHeUq0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429eb7fafc7so504685f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1762423215; x=1763028015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/Zq2ZMLTkW/3rjXrb4929ZqxG9YuHUsxu8QuLD1NzA=;
        b=EuKHeUq00Yveka+Uj6QccpIA3bsinvdzEzUuiCqJjuOgI9dOSqsVs4297Z8HgrIXnF
         cX9upepT+iccR/iR+ra4qPZi0G3ShscTsIuGAciPCzPw6jogGdZoX1rvvlxL2QrTf8Vk
         3SgiY4QIqhSihVhPXjU5wxVJqJcalOf+qNz2MQtBVRlgAXTpYMSDjXYrB6SFnB6BxXDA
         pv8gtJyMLEQudUQ8+23IrN6ncR03Ag1INCqQYBe606An+XYAEtYDCHLNTDEFqtGMjj4J
         YwwxXOUR7JiJI8NXtrBsc9jbHCgiVQNPPiWUdiObP8dwnj7XKFhrnFo+UR7tQcwE/to3
         F58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762423215; x=1763028015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4/Zq2ZMLTkW/3rjXrb4929ZqxG9YuHUsxu8QuLD1NzA=;
        b=FUjO/K0E/ZkwWBhs5//zlxRPaAPxpKhzJug34KMxAXEQ3WguB+adn2PhXD9JeD10th
         X5+uNPf5XCIPHXoCw658Z09ks8vsYcNEPbYRTpcfbT//icTr8lFLwxqp7HkNkzeJMy9P
         yT62vYR4DMaO0803bzhaRoy0s/qW+z1Yv/0d7TXqw/29Cd/pjfc0DGQFDZWFZbEKpqhF
         7wtvgOiK6UxwG+ydi5qYfpGh8i5dZQL4SZhe/reWYQM+q6G/lQ+aJJuBjh0fuKMW3Txv
         2uwQd6rFvaDGIm3s/vi4Y+KUUchWQCY2MOwgkCWoXTQuNUztB6fhuaIntASuIgaVdxvu
         wdMA==
X-Forwarded-Encrypted: i=1; AJvYcCWjKIhsPhjNyTvHFsWUOzwj73GlfntNibf3YOrKvNrmcUU6pkguGMTD9PFOwDmbtDYT3nqSjZWZijynfOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+QfcaBMM3biqZH2H48gjXCYFul4LXKfVKZmFyw1kPW8tFNpS9
	vdPwOF/N3ckcPM6o6os5DTeFrIA/NxcMNjAuxW7E/WkQxaOsqjE/9PhS5RYmvD/4+ss=
X-Gm-Gg: ASbGncuq2NRNmQ4bkmhazIsjYUcurQfcKbTdCTMSrq+HPn75sR9PdJXdeThubcYssid
	ceDYZZBLX62rrDIhaQnXj7wjc05Qn5BN6L/RV/cT4kw7GBz4D3Ab+TfN1vfpFQz9aZ9Y+vwIta+
	tKC6m64R0SJn6e5V+lMbcrB2U8SGezJxzFMW1bmgyadLTdr2uPq7ZMQ1DZ0BO6gu7fYdOugNCAz
	+Jma3hpWiomJt+MQYTrudcEcZbp+yp5BT2bqtTipH9hJ3tvCJBk2XXaBdTCpBc809n975q54cKS
	d4sucL46cfn6TA6mVi+71uxSs8iY7anXhyDhQu9y8/cVqOKx1Fz6YKm8n7D3yfDJ5R5go3SveRG
	dtMUrGFxEilorLOIDHg68eWr+uASunOokmVBOvPPw/IyuDWO+DegB0jkH9HNgHdP6pNdSkwnNpi
	qkl9TA2Q9Zmn7YywLNLB1pgVb14T4=
X-Google-Smtp-Source: AGHT+IEZKVyRG59cakGUG/uu7olGLVJjMN0xfbpmUq5+ampqbuf/q1ePNFMJ6cguRcdgyKCUSlBC+w==
X-Received: by 2002:a05:6000:210c:b0:429:8daa:c6b1 with SMTP id ffacd0b85a97d-429e3308887mr4652869f8f.38.1762423214827;
        Thu, 06 Nov 2025 02:00:14 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb41102bsm4118122f8f.17.2025.11.06.02.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 02:00:14 -0800 (PST)
Message-ID: <9e5abc5f-1948-4b18-8485-6540f84cdfd8@ursulin.net>
Date: Thu, 6 Nov 2025 10:00:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drm/amdgpu: increment sched score on entity
 selection
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251106093933.18859-1-pierre-eric.pelloux-prayer@amd.com>
 <20251106093933.18859-3-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251106093933.18859-3-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 06/11/2025 09:39, Pierre-Eric Pelloux-Prayer wrote:
> For hw engines that can't load balance jobs, entities are
> "statically" load balanced: on their first submit, they select
> the best scheduler based on its score.
> The score is made up of 2 parts:
> * the job queue depth (how much jobs are executing/waiting)
> * the number of entities assigned
> 
> The second part is only relevant for the static load balance:
> it's a way to consider how many entities are attached to this
> scheduler, knowing that if they ever submit jobs they will go
> to this one.
> 
> For rings that can load balance jobs freely, idle entities
> aren't a concern and shouldn't impact the scheduler's decisions.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 21 ++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>   2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index afedea02188d..953c81c928c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -209,6 +209,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   	struct amdgpu_ctx_entity *entity;
>   	enum drm_sched_priority drm_prio;
>   	unsigned int hw_prio, num_scheds;
> +	struct amdgpu_ring *aring;
>   	int32_t ctx_prio;
>   	int r;
>   
> @@ -239,11 +240,13 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   			goto error_free_entity;
>   	}
>   
> -	/* disable load balance if the hw engine retains context among dependent jobs */
> -	if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
> -	    hw_ip == AMDGPU_HW_IP_VCN_DEC ||
> -	    hw_ip == AMDGPU_HW_IP_UVD_ENC ||
> -	    hw_ip == AMDGPU_HW_IP_UVD) {
> +	sched = scheds[0];
> +	aring = container_of(sched, struct amdgpu_ring, sched);
> +
> +	if (aring->funcs->engine_retains_context) {
> +		/* Disable load balancing between multiple schedulers if the hw
> +		 * engine retains context among dependent jobs.
> +		 */
>   		sched = drm_sched_pick_best(scheds, num_scheds);
>   		scheds = &sched;
>   		num_scheds = 1;
> @@ -258,6 +261,11 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   	if (cmpxchg(&ctx->entities[hw_ip][ring], NULL, entity))
>   		goto cleanup_entity;
>   
> +	if (aring->funcs->engine_retains_context) {
> +		entity->sched_score = sched->score;
> +		atomic_inc(entity->sched_score);

Maybe you missed it, in the last round I asked this:

"""
Here is would always be sched->score == aring->sched_score, right?

If so it would probably be good to either add that assert, or even to 
just fetch it from there. Otherwise it can look potentially concerning 
to be fishing out the pointer from scheduler internals.

The rest looks good to me.
"""

Because grabbing a pointer from drm_sched->score and storing it in AMD 
entity can look scary, since sched->score can be scheduler owned.

Hence I was suggesting to either fish it out from aring->sched_score. If 
it is true that they are always the same atomic_t at this point.

Regards,

Tvrtko

> +	}
> +
>   	return 0;
>   
>   cleanup_entity:
> @@ -514,6 +522,9 @@ static void amdgpu_ctx_do_release(struct kref *ref)
>   			if (!ctx->entities[i][j])
>   				continue;
>   
> +			if (ctx->entities[i][j]->sched_score)
> +				atomic_dec(ctx->entities[i][j]->sched_score);
> +
>   			drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
>   		}
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 090dfe86f75b..f7b44f96f374 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -39,6 +39,7 @@ struct amdgpu_ctx_entity {
>   	uint32_t		hw_ip;
>   	uint64_t		sequence;
>   	struct drm_sched_entity	entity;
> +	atomic_t		*sched_score;
>   	struct dma_fence	*fences[];
>   };
>   


