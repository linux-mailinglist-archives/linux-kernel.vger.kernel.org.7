Return-Path: <linux-kernel+bounces-880073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0F7C24CE2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D473466F58
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70F43446D0;
	Fri, 31 Oct 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="rJ+uzu2o"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3877D32572D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761910452; cv=none; b=TTx918lPfScUKGNMjxN4+K52FKh5SeAdTtCXeoX2Utq+VfuGOtG4oJETAGOKUMBweqrclnsrFhOP46myoJKLxHxSEAL6BThkr1nV9JhKP+68a4hQ0KD0oyKaN3hEo2R49m/etH5BPnD6gVQHBxJ9U808Ok/CK/8VtzhL1Ksiqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761910452; c=relaxed/simple;
	bh=XATAyiHMPQIBIWS5BQSAHuVEayOIMrsGF0uQYDcHyJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZswPZmED5GM37HVzJh26THrF5rKW5PpNkyO/6/Kx1D4oeZEPU6WeKw5EGnhCPk7ek2N90AzkgaLLF21AZ/U6FPCGLzrGnUmlsCmh8mr/TqmLIKxINsWaENg8jvll9DrRbpSonSpvneLBCpH4qilDEKZoQAnIF+tWxtLXRuCtc7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=rJ+uzu2o; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso1390557f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1761910449; x=1762515249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFoH9dphz22RV4V8e/g5JgWomlWKPQjQuR22oDYHToY=;
        b=rJ+uzu2oXjdNdLeKJ5J1wYIPS9i59snfRX5gGhuBEYcfDrtLJU6VdX4DC9p9UzUO3w
         d7m74MQQ17iI+FifHGRLq4g+4DNEo6dYCNrvE0dU+d5MaLjzU/E+wC6huMBhs5HB598f
         sIvesF2zsPj0j4x99ngFGRIO91B6TMDHxMkDSbSedR2F7IIU3eDxsBL7bISAZRNXER+n
         P9b3VUzNcifwkQlws9hgTA3J0v1vkW35APotJO4zvKjTmcumFwVucsz2525XK8wuJHl7
         FPmhJ/gHR9tLkJMDHMDtHWu3I2nTYPTu9CG3KDUo1SMxSHNTf2m+z6HmzMCsONiNWUBo
         Fmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761910449; x=1762515249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFoH9dphz22RV4V8e/g5JgWomlWKPQjQuR22oDYHToY=;
        b=ut+K66qzVpHAaFLjUUKkVOHNLCecfGdVoAWuVxX1mq9iUYBxGIDB3hUyJlLhpR5xzB
         OiGY/SUUnIl+L2N65Fggj/vhgk1GJhKRrfWoMwQD+nI1koS+7f5/cSOszDAaShC/cxRn
         hlVkUC1BfsB0EXV+jH7VWcg7sq1fqUBgjXK8SvpwLnU5rtNexqXliSMb+sUwFO+FZLb1
         il7EdF5PnleGOy4jI702kYzPgy+u6+phB6ScQWzN1g8o9DD3O1nA/IYem5/qyaZGinHg
         WduU624SYdnmQgJH8dQjMwGH4gANNe2JbMcBP+CwTMEANy9iNNBNnL/XdOp47wbIlOsA
         M9Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXnvsIwdqs/tiKAuPBDFP4ejavnndW4e5V18pPGUZJelIms5sIsphmNkue67GmOii55TzdPl900Drc0r8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtPQPKFGFMPu6auOajZtF0uHISTzG80dOBAdth9CKnKB9CT6NY
	/NoWp2AuFv+tRXjmR+XpJvdnXGHtQi6/o6KUe2P5estvi9NUc4Pc0hobnwUUQlC3/JY=
X-Gm-Gg: ASbGncsPWxD+SDtSbsAwyQpGhaFmkBj7fvq/Y/JKEPD0MUzTpaQrhetA+CI/4a0JuIG
	cZRjfLUTueUq6EJWJ9Y0WhtgL2I2zwrs1pLQO4kGztKmYJRldqkY8+XJpwHmXQiDhwy4XkaPmaQ
	j6sIQrHkS1tzSWnK77YQnakCg9HTQUh8KSFZXbVqxAlHzdnyGe92kHvF1wkiTmcS8Q9dk96r9Mo
	J+Qseugkda8yOtdmMP1mqOs/k/i+HTMYHSAi/fFnvPsOWHIuqEbeKi/TlO/JTPy7+LZjuzIC5xx
	N9Vz1W/FJAJNDKAppvjASk0rHjiRNhZmaVaACphVPMLUaBr49w7jywDr+418MDkVtl0OMHAf7Oj
	rzNncGJ2/d5Q+ge2HCa6a0/vNqX4wta1VVqO/vpN25KR5e/cozLXSWoklqcDAZLZ9jjib4TfZA7
	ZFKSCUd9hJtcHztOUJr0pzVlXIUuWLMmjLvxPoNA==
X-Google-Smtp-Source: AGHT+IFNuI6XvXz/21/93Z9Xgap5O6+X30C1xltgLrY/68Kwz6eDPhNHCzKd1IK+3yhpTrYGeQozvQ==
X-Received: by 2002:a05:6000:615:b0:429:bc68:6ca0 with SMTP id ffacd0b85a97d-429bc686fd5mr3075065f8f.4.1761910448985;
        Fri, 31 Oct 2025 04:34:08 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732ff8004sm28524355e9.15.2025.10.31.04.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 04:34:08 -0700 (PDT)
Message-ID: <a95987d2-c696-4e3d-9b9f-a76aa70489a3@ursulin.net>
Date: Fri, 31 Oct 2025 11:34:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/amdgpu: increment sched score on entity
 selection
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251030091118.4864-1-pierre-eric.pelloux-prayer@amd.com>
 <20251030091118.4864-2-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251030091118.4864-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 30/10/2025 09:11, Pierre-Eric Pelloux-Prayer wrote:
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
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 23 +++++++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>   2 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index f5d5c45ddc0d..953c81c928c1 100644
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
> @@ -236,14 +237,16 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>   		r = amdgpu_xcp_select_scheds(adev, hw_ip, hw_prio, fpriv,
>   						&num_scheds, &scheds);
>   		if (r)
> -			goto cleanup_entity;
> +			goto error_free_entity;

It would be best to split this out as a standalone patch. It is not a 
bug due kzalloc and DRM scheduler not doing anything with it in 
drm_sched_fini but still it would be best practice.

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

Here is would always be sched->score == aring->sched_score, right?

If so it would probably be good to either add that assert, or even to 
just fetch it from there. Otherwise it can look potentially concerning 
to be fishing out the pointer from scheduler internals.

The rest looks good to me.

Regards,

Tvrtko

> +		atomic_inc(entity->sched_score);
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


