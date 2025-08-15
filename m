Return-Path: <linux-kernel+bounces-770659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7182BB27D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81D6E167AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3AD2F60D9;
	Fri, 15 Aug 2025 09:50:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8F523A9A0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251434; cv=none; b=JIP4K2AipyEM8k50vP3O9eKcnJvwVbCbZxxfWP4cyhohEuKrVC2Tl6Mc+f4GdE5MqmyFAQYoljl2vzSxHWUpa3IuacnrgCjSuPUrkke+XVmOGqetPhmuOs340ljAtaYgFe1M4a9J6Or+kNEBVxHNSCOR0H9qD7Knc9JvRLYDPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251434; c=relaxed/simple;
	bh=M/R+Mbw9+jPgzgqE4edJDpIdj0XMn6LrcThLYl2a2no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoGUT0D9e5bgq8wqtfW4Inq884GGqZozUlmcpqTUzYkNW9dvv5fAzYcmkp9krnVCnQFJs73UVTIX8Fl5IZH4hH2Qws0ckhHrdvNGbalFs0B0lXJ/+0ilD1k19Jz5i9m8mKimJAljT6S/kBoej04Gl64cUpicoFkai85wII6xtnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49C3F1655;
	Fri, 15 Aug 2025 02:50:24 -0700 (PDT)
Received: from [10.1.29.14] (e122027.cambridge.arm.com [10.1.29.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1484E3F63F;
	Fri, 15 Aug 2025 02:50:29 -0700 (PDT)
Message-ID: <f7ea81af-398f-4a58-8193-1681ebafa678@arm.com>
Date: Fri, 15 Aug 2025 10:50:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/7] drm/panthor: Serialize GPU cache flush operations
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, Dennis Tsiang <dennis.tsiang@arm.com>
References: <20250807162633.3666310-1-karunika.choo@arm.com>
 <20250807162633.3666310-6-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250807162633.3666310-6-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2025 17:26, Karunika Choo wrote:
> In certain scenarios, it is possible for multiple cache flushes to be
> requested before the previous one completes. This patch introduces the
> cache_flush_lock mutex to serialize these operations and ensure that
> any requested cache flushes are completed instead of dropped.
> 
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Co-developed-by: Dennis Tsiang <dennis.tsiang@arm.com>
> Signed-off-by: Dennis Tsiang <dennis.tsiang@arm.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index 5e2c3173ae27..db69449a5be0 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -35,6 +35,9 @@ struct panthor_gpu {
>  
>  	/** @reqs_acked: GPU request wait queue. */
>  	wait_queue_head_t reqs_acked;
> +
> +	/** @cache_flush_lock: Lock to serialize cache flushes */
> +	struct mutex cache_flush_lock;
>  };
>  
>  #define GPU_INTERRUPTS_MASK	\
> @@ -110,6 +113,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  
>  	spin_lock_init(&gpu->reqs_lock);
>  	init_waitqueue_head(&gpu->reqs_acked);
> +	mutex_init(&gpu->cache_flush_lock);
>  	ptdev->gpu = gpu;
>  
>  	dma_set_max_seg_size(ptdev->base.dev, UINT_MAX);
> @@ -258,6 +262,9 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  	bool timedout = false;
>  	unsigned long flags;
>  
> +	/* Serialize cache flush operations. */
> +	guard(mutex)(&ptdev->gpu->cache_flush_lock);
> +
>  	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
>  	if (!drm_WARN_ON(&ptdev->base,
>  			 ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {


