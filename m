Return-Path: <linux-kernel+bounces-886162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DCBC34E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA6EE4FDC79
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DCA3002D7;
	Wed,  5 Nov 2025 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b="mDOA4htJ";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="iswx5LVA"
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7103F3054E4;
	Wed,  5 Nov 2025 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.152.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335077; cv=none; b=CogyS9AToy/zqd21kTQQXyAh0DO8N/LDRo3zJ9CmRmI/HzRU9PakDej9Zt4l3K/e/QqEzdT8LZL9aR7zOQ+r2G5HYqMdof0P7stQeFLM840TbDBhHuuhJjZvj0BON2e05KHyZicHX0vhYsNe4iSglp8yZY10mSn59mCdAkttlSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335077; c=relaxed/simple;
	bh=LdBIIfbd11nlm3ecV5lsB9OkG9aIqoBoQuPuc1pvopc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bb2YsNC7ILvHkYlRliqpNzhlO079OUQ5HwTqnrHZzSY4f3Xqusbgw33Yt2K+eUQQ5p2y5Xa9MGzh8UGKJR950yxDOsq4/cWUctGykv0EmhgPDxzYeWr71Brm8wLeKgz8MnAvAmX+PRFpMaDucD6zTG2I1ofB6G20TOt8wBYXR/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net; spf=pass smtp.mailfrom=damsy.net; dkim=pass (2048-bit key) header.d=damsy.net header.i=@damsy.net header.b=mDOA4htJ; dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b=iswx5LVA; arc=none smtp.client-ip=51.159.152.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damsy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damsy.net
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1762335055; bh=mMC3l65IY1VPlkhnVVmJy0g
	52k4A4ulGLV/G3NS7BWE=; b=mDOA4htJoCHw2DvDjQT+G2BaxAuHcHTNlLg6G3uNqC88lprJn5
	H3IHS9CTlJIq9tLy1TnUQfdZ/lxk6LyWVLH3dZdgDrvgYXG0Qe9MxFQsED8dK8zFt6d37rFo6Ce
	Vs1ViCI/W9uhRSD2KnyjJ2d7ajllKmkX8TfZCaACAxVyHqDPLJPgaPu3PbNRRL/1MXFjvN0cIAO
	Yuq6SkQowoC2UpRApei7McY19yuW7I0vx1lvDzpL3XFbDcRu+I5Tr2ky4ihQlg7Y8Zqesclwel7
	FLGSoC0m9GXEEzIHPT+0wK3yqgTWTcudIGuUFvuR1LWsFRdkXjvJPAAOfk3/uIhoZqA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net; c=relaxed/relaxed;
	h=From:To:Subject:Date:Message-ID; t=1762335055; bh=mMC3l65IY1VPlkhnVVmJy0g
	52k4A4ulGLV/G3NS7BWE=; b=iswx5LVAoYUyILx1vMO7LlbkQPgENmmIsQvKUDdV/wwvIEKtqi
	DVJJFDO0EPzyGPNjuM2VHzpB+zcLyNJuWMAg==;
Message-ID: <9742acac-9402-4351-8cff-559ba6536629@damsy.net>
Date: Wed, 5 Nov 2025 10:30:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 17/20] drm/amdgpu: get rid of amdgpu_ttm_clear_buffer
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20251104083605.13677-1-pierre-eric.pelloux-prayer@amd.com>
 <20251104083605.13677-18-pierre-eric.pelloux-prayer@amd.com>
 <ca139b41-b4c3-4f0a-a2c1-8cfab6032625@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <ca139b41-b4c3-4f0a-a2c1-8cfab6032625@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/11/2025 à 09:46, Christian König a écrit :
> 
> 
> On 11/4/25 09:35, Pierre-Eric Pelloux-Prayer wrote:
>> It's doing the same thing as amdgpu_fill_buffer(src_data=0), so drop it.
>>
>> The only caveat is that amdgpu_res_cleared() return value is only valid
>> right after allocation.
>>
>> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  9 +--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 86 ++++------------------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  3 -
>>   3 files changed, 18 insertions(+), 80 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 4a69324bb730..410e9b68ff81 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -723,15 +723,10 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>>   
>>   	if (bp->flags & AMDGPU_GEM_CREATE_VRAM_CLEARED &&
>>   	    bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>> -		struct dma_fence *fence;
>> -
>> -		r = amdgpu_ttm_clear_buffer(bo, bo->tbo.base.resv, &fence);
>> +		r = amdgpu_fill_buffer(NULL, bo, 0, NULL,
>> +				       NULL, AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
>>   		if (unlikely(r))
>>   			goto fail_unreserve;
>> -
>> -		dma_resv_add_fence(bo->tbo.base.resv, fence,
>> -				   DMA_RESV_USAGE_KERNEL);
>> -		dma_fence_put(fence);
>>   	}
>>   	if (!bp->resv)
>>   		amdgpu_bo_unreserve(bo);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index d88bdb2ac083..1f553c56f31d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -2412,75 +2412,6 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring,
>>   	return 0;
>>   }
>>   
>> -/**
>> - * amdgpu_ttm_clear_buffer - clear memory buffers
>> - * @bo: amdgpu buffer object
>> - * @resv: reservation object
>> - * @fence: dma_fence associated with the operation
>> - *
>> - * Clear the memory buffer resource.
>> - *
>> - * Returns:
>> - * 0 for success or a negative error code on failure.
>> - */
>> -int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>> -			    struct dma_resv *resv,
>> -			    struct dma_fence **fence)
>> -{
>> -	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>> -	struct amdgpu_ring *ring = adev->mman.buffer_funcs_rings[0];
>> -	struct amdgpu_ttm_entity *entity;
>> -	struct amdgpu_res_cursor cursor;
>> -	u64 addr;
>> -	int r = 0;
>> -
>> -	if (!adev->mman.buffer_funcs_enabled)
>> -		return -EINVAL;
>> -
>> -	if (!fence)
>> -		return -EINVAL;
>> -	entity = &adev->mman.clear_entities[0];
>> -	*fence = dma_fence_get_stub();
>> -
>> -	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor);
>> -
>> -	mutex_lock(&entity->gart_window_lock);
>> -	while (cursor.remaining) {
>> -		struct dma_fence *next = NULL;
>> -		u64 size;
>> -
>> -		if (amdgpu_res_cleared(&cursor)) {
>> -			amdgpu_res_next(&cursor, cursor.size);
>> -			continue;
>> -		}
>> -
>> -		/* Never clear more than 256MiB at once to avoid timeouts */
>> -		size = min(cursor.size, 256ULL << 20);
>> -
>> -		r = amdgpu_ttm_map_buffer(&entity->base,
>> -					  &bo->tbo, bo->tbo.resource, &cursor,
>> -					  entity->gart_window_id1, ring, false, &size, &addr,
>> -					  NULL, NULL);
>> -		if (r)
>> -			goto err;
>> -
>> -		r = amdgpu_ttm_fill_mem(ring, &entity->base, 0, addr, size, resv,
>> -					&next, true,
>> -					AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
>> -		if (r)
>> -			goto err;
>> -
>> -		dma_fence_put(*fence);
>> -		*fence = next;
>> -
>> -		amdgpu_res_next(&cursor, size);
>> -	}
>> -err:
>> -	mutex_unlock(&entity->gart_window_lock);
>> -
>> -	return r;
>> -}
>> -
>>   /**
>>    * amdgpu_fill_buffer - fill a buffer with a given value
>>    * @entity: optional entity to use. If NULL, the clearing entities will be
>> @@ -2508,6 +2439,9 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_entity *entity,
>>   	struct amdgpu_res_cursor dst;
>>   	uint64_t cur_size, to;
>>   	int r, e, n_fences;
> 
>> +	/* The clear flag is only valid directly after allocation. */
>> +	bool consider_clear_flag =
>> +		src_data == 0 && k_job_id == AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER;
> 
> Absolutely clear NAK to that.

I suppose the NAK applies to the check, not the general idea of the patch?
In that case, would passing "bool consider_clear_flag" as a parameter be ok ?

Pierre-Eric

> 
> Christian.
> 
>>   
>>   	/* The fences will be either added to the resv object or the last fence
>>   	 * will be returned to the caller. In the latter case, all fill jobs will
>> @@ -2531,6 +2465,11 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_entity *entity,
>>   		while (dst.remaining) {
>>   			cur_size = min(dst.size, 256ULL << 20);
>>   
>> +			if (consider_clear_flag && amdgpu_res_cleared(&dst)) {
>> +				amdgpu_res_next(&dst, dst.size);
>> +				continue;
>> +			}
>> +
>>   			n_fences += 1;
>>   			amdgpu_res_next(&dst, cur_size);
>>   		}
>> @@ -2550,6 +2489,11 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_entity *entity,
>>   	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &dst);
>>   
>>   	while (dst.remaining) {
>> +		if (consider_clear_flag && amdgpu_res_cleared(&dst)) {
>> +			amdgpu_res_next(&dst, dst.size);
>> +			continue;
>> +		}
>> +
>>   		/* Never fill more than 256MiB at once to avoid timeouts */
>>   		cur_size = min(dst.size, 256ULL << 20);
>>   
>> @@ -2574,8 +2518,10 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_entity *entity,
>>   			goto error;
>>   		}
>>   
>> +
>>   		r = amdgpu_ttm_fill_mem(ring, &entity->base,
>> -					src_data, to, cur_size, resv,
>> +					src_data, to, cur_size,
>> +					resv,
>>   					&fence, true, k_job_id);
>>   		if (r) {
>>   			mutex_unlock(&entity->gart_window_lock);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index c059a3d52b57..97e73919cb0c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -182,9 +182,6 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring,
>>   		       struct dma_resv *resv,
>>   		       struct dma_fence **fence,
>>   		       bool vm_needs_flush, uint32_t copy_flags);
>> -int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>> -			    struct dma_resv *resv,
>> -			    struct dma_fence **fence);
>>   int amdgpu_fill_buffer(struct amdgpu_ttm_entity *entity,
>>   		       struct amdgpu_bo *bo,
>>   		       uint32_t src_data,


