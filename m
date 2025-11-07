Return-Path: <linux-kernel+bounces-890223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F30EC3F842
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98453188F290
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25FD308F3A;
	Fri,  7 Nov 2025 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oXSl2Cx2"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596A27E04C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511979; cv=none; b=ayjM+Pns6aFPe0JCYzyDWXADNAf/JBV1kdp7yMBfXTlVjT1sm50bRtKyRAmJrbdMfttURHQpiI1LDMQsASUlwcIA0/5s+/BieFlyZylhR38O6n9u7doySLzCiNGPqUme+l0pIS3DRirHhLTeBCpHsT3M3uYGAcC3bmyQNNqKxk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511979; c=relaxed/simple;
	bh=GBg2OD7e5Qf4GFrI73D8kYm44zNVk8N5tcC0d+OTuVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pt7p0APj5LyvoBZKEYL63CqU+/dayw6txt7AmcRStfkUC4G7AWM7KhCcAPZB4WwsvyZSVUdWfBU/9bfW8Ft3LK4Jtn18kenIT70K978PP3IQOuUIpI0gft74b5VjHtNmWHBTl/OBDFnO4g3TlfgLHMR0KqUEJ/jxhAg5L+m5o6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oXSl2Cx2; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XKdn+Xj1gOnE7ZvuS+Eu3smLhABwegmjFrOFhjYnzqk=; b=oXSl2Cx2snJ5WwIbG2h/SLuuRy
	DYw1YoYbmmQ7gEXUlDSbmiU/2zMfM/GR0NPC/CBgsasYkhODayzYatsTyMWHl3ZL00xj37wBAvjRa
	2usJWFQ1eVLyIp6SfjeqvA96FttmKJwM5vGnHB2Y1QXur77Nq1fzdVN/tTMr4zV4opUvqXTKIlbQf
	nabkLyJ8GYQvB4HjIaKAEB6aCs2+yWdYtLgHibOfoiX6CIZj9vdjLnksnrYxjONc66L8KVft2WBEr
	Z4/cNwbmvFbXo1DKJtAuNtXjzjlT8YGwLmA9E2t2WskZYzTAU3MyFw2y/LG5HLSjIJRmHNPllONDj
	1AQjdH6w==;
Received: from [90.240.106.137] (helo=[192.168.0.101])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vHJsN-003PGZ-Ot; Fri, 07 Nov 2025 11:39:27 +0100
Message-ID: <9950dd13-d5c1-4b34-b3f9-2528a1ffb989@igalia.com>
Date: Fri, 7 Nov 2025 10:39:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] drm/amdgpu: increment sched score on entity
 selection
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20251107090425.23199-1-pierre-eric.pelloux-prayer@amd.com>
 <20251107090425.23199-2-pierre-eric.pelloux-prayer@amd.com>
 <5717c024-0200-4b23-a25b-681ef0937d6f@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <5717c024-0200-4b23-a25b-681ef0937d6f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 07/11/2025 10:26, Christian König wrote:
> On 11/7/25 10:04, Pierre-Eric Pelloux-Prayer wrote:
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
>> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 22 +++++++++++++++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>>   2 files changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index afedea02188d..4d91cbcbcf25 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -209,6 +209,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>>   	struct amdgpu_ctx_entity *entity;
>>   	enum drm_sched_priority drm_prio;
>>   	unsigned int hw_prio, num_scheds;
>> +	struct amdgpu_ring *aring;
>>   	int32_t ctx_prio;
>>   	int r;
>>   
>> @@ -239,11 +240,13 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>>   			goto error_free_entity;
>>   	}
>>   
>> -	/* disable load balance if the hw engine retains context among dependent jobs */
>> -	if (hw_ip == AMDGPU_HW_IP_VCN_ENC ||
>> -	    hw_ip == AMDGPU_HW_IP_VCN_DEC ||
>> -	    hw_ip == AMDGPU_HW_IP_UVD_ENC ||
>> -	    hw_ip == AMDGPU_HW_IP_UVD) {
>> +	sched = scheds[0];
>> +	aring = container_of(sched, struct amdgpu_ring, sched);
>> +
>> +	if (aring->funcs->engine_retains_context) {
>> +		/* Disable load balancing between multiple schedulers if the hw
>> +		 * engine retains context among dependent jobs.
>> +		 */
>>   		sched = drm_sched_pick_best(scheds, num_scheds);
>>   		scheds = &sched;
>>   		num_scheds = 1;
>> @@ -258,6 +261,12 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>>   	if (cmpxchg(&ctx->entities[hw_ip][ring], NULL, entity))
>>   		goto cleanup_entity;
>>   
>> +	if (aring->funcs->engine_retains_context) {
>> +		aring = container_of(sched, struct amdgpu_ring, sched);
>> +		entity->sched_score = aring->sched_score;
>> +		atomic_inc(entity->sched_score);
>> +	}
>> +
>>   	return 0;
>>   
>>   cleanup_entity:
>> @@ -514,6 +523,9 @@ static void amdgpu_ctx_do_release(struct kref *ref)
>>   			if (!ctx->entities[i][j])
>>   				continue;
>>   
>> +			if (ctx->entities[i][j]->sched_score)
>> +				atomic_dec(ctx->entities[i][j]->sched_score);
>> +
>>   			drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
>>   		}
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> index 090dfe86f75b..f7b44f96f374 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
>> @@ -39,6 +39,7 @@ struct amdgpu_ctx_entity {
>>   	uint32_t		hw_ip;
>>   	uint64_t		sequence;
>>   	struct drm_sched_entity	entity;
>> +	atomic_t		*sched_score;
> 
> I would rather prefer to not have that additional member here.
> 
> Additional to that we are messing with the internals of the scheduler here and should probably have two clean functions to increase/decrease the score.

Don't forget it is a driver owned atomic_t so I think it is fine driver 
manipulates it on its own.

Regards,

Tvrtko


> Regards,
> Christian.
> 
>>   	struct dma_fence	*fences[];
>>   };
>>   
> 


