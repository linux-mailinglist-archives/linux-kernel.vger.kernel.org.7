Return-Path: <linux-kernel+bounces-794146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BB7B3DD7F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769AA16AE52
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4D13043DD;
	Mon,  1 Sep 2025 09:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="W/0OQzDW"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F23002BC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717327; cv=none; b=uu90zoqB2BRT63JTHtIOY9QFZgYH+xFCceDMCExmIXzHA8kf37EmpxAhXSR8l60s+ERlbLgU2XYknAumgQ4qmO7SsS0hYBrF//svu8A6uytdYz1MoStqmkUzVToM03jFHvozhFZr0Y6x6J1GlS7oxhq2byINhiJynb5306DoxsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717327; c=relaxed/simple;
	bh=NEFqkeGhuqCDqJq9+oGk7QJUsIy/m8/mtw+9FHfX6Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfXULdlRPpfL0XjDQWiwP5sekysq3Q0OP8cD/rKVuw0gPK15nTIbd2i5o0KplPmQOelJy9cBPkw8gS/DrYAzArdHxCx6xRP67TAw9Iehv1cVMv8B82pK48Crs7WfRy/Lz4TZv6fyfQGrrGVs5P6f/OLrRRG5j7Zl+zW/qaL752c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=W/0OQzDW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b8b02dd14so5145735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1756717324; x=1757322124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q8RPXBLC5ldsUqsxVQXK6DmVHhHHPKbMvb74af34BlQ=;
        b=W/0OQzDWM7TdgBvd+GGUOEzXJs3fdj0Sq+dbMP8r/CPgrmcVCe5pDngYGp8cPsPYoD
         /Ywey5L2zckcd87+t3XvVIL1Dwy5z4vLRg+doMxbEu1A5yWHQ5dL3MEiMDpdVY1gSmnV
         CDJtY4yj1ByNEFoPSNSD5qn8ZLu8LAorEHP0vWX17l33T0ns6cmxgRjFGYNxRgJEJtfM
         YnkRmEPb0Je+Nkmb85IRSAo2BOFzo0mXAMHI/1oOWQc37st+69YvYJEFZL8VGpMjpm2w
         Sqyvv5C8Qlnd6KD6NGE6vACmbwjBDXmQZBesvOgoLPxKEBBRlNGCez5gmjie0wz8btDq
         GRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756717324; x=1757322124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8RPXBLC5ldsUqsxVQXK6DmVHhHHPKbMvb74af34BlQ=;
        b=AGxVKNs13V5rB9HrX/r6szG1YVdag+I6lRg+0yJE7KY+CIIMv/6U6sDefPGEajWP6F
         w9Hz+jIt7RHBmXNS5NQNVo3sgu56YpdlRi1e+KFke0Il8hZazDvThETQJHfrQLUkcjEC
         ABmwBHomxqmF59CLSWtLNCfoTGi9RGOYCz5rFjz+EPqvEWjfXmbI2jhJ5g5YWwb9v8dw
         04RnEaPWtAhV0fGfxkHrRt1e37mpEx7rrkcy8aHHiDLW6JE5I5cbt93gDz6vP3MqQ4ZA
         QK/6lQ/X9HABbEj4GmfQ7snz9vnBvR4ls8IJPD051/l1u0qM5qe5LqpRJKMsSAFz4MZ1
         2JrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzN9fsZOnDI+Ep6ofnUDrQ/Y7oWEml4rw9ij0Yi6Tk1B8ctGsA1PBQIM7vGYPE1ZcaV5bk4qQQUSq1rNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQg6fFJhPNqh4chk+DHsMgFwowkpXb9cyVFN1kpM1WJJOet/c
	eUwVPzDfDxDluW7Q/nZDKZb1sbv5zUqn9kimNEu7Mlf4xwWtbpu3cVdT6RFRVd2eLnE=
X-Gm-Gg: ASbGnctwBhvFucb7A+dvO7VllG+pm9InPiJp5myDDfWFDoeDPBnG6vmfO6tKinoHjzo
	XRPMrruik1XCXsKQu68y2W77o0i4S3Z01hwKKNcrq0sePPh4j2IigEHNGIN1HfpnKrrmF1fIkPP
	cMmcOyhgMWB8lkbzsUbCf6Rrt5pDsbycaZEFqSyZsQgHnnLHBkiePQ2nrKu/TbZq4t5Db3T5ij3
	Y3pZSndWSdNQeFBm4ETivf4Y5g8BN1g2NRsBo/Bm9zaj7ta1FB68YbtvKF1naSE5F6hogf16GtJ
	9KtBro5HgNiNpb3H0Cz8JgLx+/9nvNk328NlTlZPzjRr6cD0Tr1ynYj13R7Y6vZbyo5j3lWVnzk
	lfUXD5o9tJwUW1VOlvnMVH+Qqdhpm7FeSgsJmE6ESeMGs8A==
X-Google-Smtp-Source: AGHT+IFATa0P1gj9ZG+bFpTTF/PDbmIBdrStL6Ztg7iLjcDRq2nyWpFsCTfBKuh9T9aPaqNoKufiSQ==
X-Received: by 2002:a05:600c:1d06:b0:45b:6275:42cc with SMTP id 5b1f17b1804b1-45b8557a3f7mr54828095e9.28.1756717323313;
        Mon, 01 Sep 2025 02:02:03 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8efb280csm9195665e9.3.2025.09.01.02.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:02:02 -0700 (PDT)
Message-ID: <a05bb414-4dd1-4cbe-aa1a-beaea2d056aa@ursulin.net>
Date: Mon, 1 Sep 2025 10:02:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: increment share sched score on entity
 selection
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250822134348.6819-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250822134348.6819-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 22/08/2025 14:43, Pierre-Eric Pelloux-Prayer wrote:
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 23 ++++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>   2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index f5d5c45ddc0d..4a078d2d98c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -206,9 +206,11 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   {
>   	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
>   	struct amdgpu_device *adev = ctx->mgr->adev;
> +	bool static_load_balancing = false;
>   	struct amdgpu_ctx_entity *entity;
>   	enum drm_sched_priority drm_prio;
>   	unsigned int hw_prio, num_scheds;
> +	struct amdgpu_ring *aring;
>   	int32_t ctx_prio;
>   	int r;
>   
> @@ -236,17 +238,22 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   		r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
>   						&num_scheds, &scheds);
>   		if (r)
> -			goto cleanup_entity;
> +			goto error_free_entity;

Indeed, previously this was calling drm_sched_entity_fini() before 
drm_sched_entity_init() and it only worked because of kzalloc.

>   	}
>   
>   	/* disable load balance if the hw engine retains context among dependent jobs */
> -	if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
> -	    hw_ip == AMDGPU_HW_IP_VCN_DEC ||
> -	    hw_ip == AMDGPU_HW_IP_UVD_ENC ||
> -	    hw_ip == AMDGPU_HW_IP_UVD) {
> +	static_load_balancing = hw_ip == AMDGPU_HW_IP_VCN_ENC ||
> +				hw_ip == AMDGPU_HW_IP_VCN_DEC ||
> +				hw_ip == AMDGPU_HW_IP_UVD_ENC ||
> +				hw_ip == AMDGPU_HW_IP_UVD;
> +
> +	if (static_load_balancing) {
>   		sched = drm_sched_pick_best(scheds, num_scheds);
>   		scheds = &sched;
>   		num_scheds = 1;
> +		aring = container_of(sched, struct amdgpu_ring, sched);
> +		entity->sched_ring_score = aring->sched_score;
> +		atomic_inc(entity->sched_ring_score);

If we were to bike-shed we could find a way to avoid the new local 
variables. Keeping the if as is and assign to entity->sched_ring_score 
directly, and then checking for that on the cleanup path. Still works 
due kzalloc. Or if relying on kzalloc is not desired, at least bool 
static_load_balance could be replaced by re-naming the aring local as 
static_aring and using it like the name suggests.

Could also move the atomic_inc to the success path to avoid having to 
add code to error unwind.

Both cases are I think equally racy in the sense that parallel 
amdgpu_ctx_init_entity invocations can all pick the same sched. But that 
is true today AFAICT because score is not incremented until later in the 
job submit process.

I suppose one way to make the assignment more robust would be to 
"rotate" (or randomize) the sched list atomically before calling 
drm_sched_pick_best. Thoughts?

Regards,

Tvrtko

>   	}
>   
>   	r = drm_sched_entity_init(&entity->entity, drm_prio, scheds, num_scheds,
> @@ -264,6 +271,9 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   	drm_sched_entity_fini(&entity->entity);
>   
>   error_free_entity:
> +	if (static_load_balancing)
> +		atomic_dec(entity->sched_ring_score);
> +
>   	kfree(entity);
>   
>   	return r;
> @@ -514,6 +524,9 @@ static void amdgpu_ctx_do_release(struct kref *ref)
>   			if (!ctx->entities[i][j])
>   				continue;
>   
> +			if (ctx->entities[i][j]->sched_ring_score)
> +				atomic_dec(ctx->entities[i][j]->sched_ring_score);
> +
>   			drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
>   		}
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 090dfe86f75b..076a0e165ce0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -39,6 +39,7 @@ struct amdgpu_ctx_entity {
>   	uint32_t		hw_ip;
>   	uint64_t		sequence;
>   	struct drm_sched_entity	entity;
> +	atomic_t		*sched_ring_score;
>   	struct dma_fence	*fences[];
>   };
>   


