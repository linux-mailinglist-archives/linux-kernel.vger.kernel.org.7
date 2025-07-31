Return-Path: <linux-kernel+bounces-751920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDABB16F54
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81EE67A1D6A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B3229B8E0;
	Thu, 31 Jul 2025 10:18:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C17B746E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957086; cv=none; b=SfuVld3C88ylDI+IeYgkA+ySYONMjX/dtnoDOvyWo2/YiYmWkM4IyebS96pibmOaSvyMFEQcr/BajeYR2MVKP+EEUNDuRFJQysPYuGFQRthYCCmGu6nIEklaYs91c7qTvYmK8TBzEN2tVipNHfQ3DvJapZLMyorWGEQFDSCmjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957086; c=relaxed/simple;
	bh=19DiYw+EXIdSVtrJmNtIIGQYoLRGU/XWDbZfzsoViww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pt7NM5qy2ZW8+5/zy37534jHQuiuL+632NHi2WJp8IgmYQaqW9u/Fb52pPj3FGULNsm393X8wFPGiE4zbl/XFvitaDCCewXVPshNfNg0R4ui+kcqIZ6FEYIPEsf/dp43sLxW7C2gqnHwvx3EtTOAQQl6zRTaB9Zu7Y0D/X7BReA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B31FD1D13
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:17:56 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7DA563F673
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:18:04 -0700 (PDT)
Date: Thu, 31 Jul 2025 11:17:53 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org, Dennis Tsiang <dennis.tsiang@arm.com>
Subject: Re: [PATCH v1] drm/panthor: Serialize GPU cache flush operations
Message-ID: <aItC0UKB8lMMdp79@e110455-lin.cambridge.arm.com>
References: <20250730174338.1650212-1-karunika.choo@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250730174338.1650212-1-karunika.choo@arm.com>

On Wed, Jul 30, 2025 at 06:43:38PM +0100, Karunika Choo wrote:
> In certain scenarios, it is possible for multiple cache flushes to be
> requested before the previous one completes. This patch introduces the
> cache_flush_lock mutex to serialize these operations and ensure that
> any requested cache flushes are completed instead of dropped.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> Co-developed-by: Dennis Tsiang <dennis.tsiang@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index cb7a335e07d7..030409371037 100644
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
>  /**
> @@ -204,6 +207,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  
>  	spin_lock_init(&gpu->reqs_lock);
>  	init_waitqueue_head(&gpu->reqs_acked);
> +	mutex_init(&gpu->cache_flush_lock);
>  	ptdev->gpu = gpu;
>  	panthor_gpu_init_info(ptdev);
>  
> @@ -353,6 +357,9 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  	bool timedout = false;
>  	unsigned long flags;
>  
> +	/* Serialize cache flush operations. */
> +	guard(mutex)(&ptdev->gpu->cache_flush_lock);
> +
>  	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
>  	if (!drm_WARN_ON(&ptdev->base,
>  			 ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
> -- 
> 2.49.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

