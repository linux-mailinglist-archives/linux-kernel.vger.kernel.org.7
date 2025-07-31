Return-Path: <linux-kernel+bounces-752175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52CAB1721D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044A854565F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB62C3259;
	Thu, 31 Jul 2025 13:34:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266F016419
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968878; cv=none; b=Y0lIKKChvJz1vhgi5ulqLH5GgM1Wr9pXFjnsZgZob3NjBrFkCQfdG/IxGjNa960IpzETb3tHhsaEN+skTx3OvxNewzuZu+sW4NZ88X4D6c6MsefxRJoh6P4wo3cb2oGePntfuJECS3pUTCXy4a4JRSBDliMRRkgQ9T+rEmVGhIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968878; c=relaxed/simple;
	bh=r0F0vk7hLpGLH/6EeIFYI9x4trLoGD/QEMPssi7Uj+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GVZ8MsxWgwfsGRLirl3iHpHUfG7geMSDVV6S8arSrury1oT+X6lIlRRVQxhFXuDs4cK1BKs28Y1Z6vZKS044S1XeoXeuHoALDdjZlnv6u0N0KjoLQhlYVF1t3gGUj/8RCnfm5dCvJxn7Bkw745EixWgnErJJZDLr5WAFaoHDXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69CDD1D13;
	Thu, 31 Jul 2025 06:34:28 -0700 (PDT)
Received: from [10.1.27.30] (e122027.cambridge.arm.com [10.1.27.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12BAB3F66E;
	Thu, 31 Jul 2025 06:34:33 -0700 (PDT)
Message-ID: <927c9a00-f825-439b-bc78-03211fed4da9@arm.com>
Date: Thu, 31 Jul 2025 14:34:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/panthor: Serialize GPU cache flush operations
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, Dennis Tsiang <dennis.tsiang@arm.com>
References: <20250730174338.1650212-1-karunika.choo@arm.com>
 <63c7d33d-c475-448e-a928-570c6efe2387@arm.com>
 <216ebb8e-c973-4306-a748-a030eae01e2d@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <216ebb8e-c973-4306-a748-a030eae01e2d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/07/2025 13:48, Karunika Choo wrote:
> On 31/07/2025 11:57, Steven Price wrote:
>> On 30/07/2025 18:43, Karunika Choo wrote:
>>> In certain scenarios, it is possible for multiple cache flushes to be
>>> requested before the previous one completes. This patch introduces the
>>> cache_flush_lock mutex to serialize these operations and ensure that
>>> any requested cache flushes are completed instead of dropped.
>>>
>>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
>>> Co-developed-by: Dennis Tsiang <dennis.tsiang@arm.com>
>>
>> A Co-Developed-By needs to have a signed-off-by too[1]
> 
> Oops. I can push a v2 to add those.
> 
>>
>> [1]
>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
>>
>> But I also don't understand how this is happening. The only caller to
>> panthor_gpu_flush_caches() is in panthor_sched_suspend() and that is
>> holding the sched->lock mutex.
> 
> The fix is in relation to the enablement of GPU Flush caches by default
> for all GPUs [1]. While calls from the MMU are serialized, other calls
> i.e. from panthor_sched_suspend() are not. As such, this patch
> explicitly serializes these operations.

Ah, ok so this is effectively a bug fix for that patch - given we've not
yet merged that series can we just do a v9 of the series with the fix
rolled in? (Rather than having a commit or two where we know the bug is
present).

I have to admit it also feels like we should have something to avoid
doing excessive cache flushes - there's no point in queuing up multiple
flushes back-to-back. But I don't have a neat solution, and I'm not sure
whether this will happen often enough to worry about. So I guess we
should probably ignore it until/unless it becomes a problem.

Steve

> [1]
> https://lore.kernel.org/all/20250724124210.3675094-6-karunika.choo@arm.com/
> 
> Kind regards,
> Karunika Choo
> 
>> Steve
>>
>>> ---
>>>  drivers/gpu/drm/panthor/panthor_gpu.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
>>> index cb7a335e07d7..030409371037 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
>>> @@ -35,6 +35,9 @@ struct panthor_gpu {
>>>  
>>>  	/** @reqs_acked: GPU request wait queue. */
>>>  	wait_queue_head_t reqs_acked;
>>> +
>>> +	/** @cache_flush_lock: Lock to serialize cache flushes */
>>> +	struct mutex cache_flush_lock;
>>>  };
>>>  
>>>  /**
>>> @@ -204,6 +207,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>>>  
>>>  	spin_lock_init(&gpu->reqs_lock);
>>>  	init_waitqueue_head(&gpu->reqs_acked);
>>> +	mutex_init(&gpu->cache_flush_lock);
>>>  	ptdev->gpu = gpu;
>>>  	panthor_gpu_init_info(ptdev);
>>>  
>>> @@ -353,6 +357,9 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>>>  	bool timedout = false;
>>>  	unsigned long flags;
>>>  
>>> +	/* Serialize cache flush operations. */
>>> +	guard(mutex)(&ptdev->gpu->cache_flush_lock);
>>> +
>>>  	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
>>>  	if (!drm_WARN_ON(&ptdev->base,
>>>  			 ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
>>
> 


