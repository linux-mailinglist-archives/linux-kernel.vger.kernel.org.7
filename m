Return-Path: <linux-kernel+bounces-744213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C70B10991
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707321CE1141
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6570E2BE040;
	Thu, 24 Jul 2025 11:50:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EF92BD5B9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357846; cv=none; b=RPATRMfLLvq9uBdjEsAeWX86O811gnmqlso7vTtP4JIFnEeG6YvCu67Im8q4kj9UeHPvH0kuxEzrkmzfFKrCfbSGp03AhQjOqt2FH6zv4HLQhoO/cg9sZYp/ZXe0KTquypMYwBRdHFFGp52xfSSqhS87r8QUYkK85WQTkWxEP6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357846; c=relaxed/simple;
	bh=O5kzB3GKrm6+vjlFrS+Kqyb7Gc9Po4g5n/O5Cuz/Jz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Phmaz6ErprIy5egrcO14B4tBDJuHnqJynwtJcs/y+FCF8oLzMxg1fopY67JD1sbZVgbAq9+CiihL/CkUzdmFCZU0O/E5he2QspGtHKWTUIILkOIuEmKwOAu/GS7/rqLSLJIJSg+vQ9B73gcGV1fqLrzLfuKWCbUg1b2r3n6taP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96A051CC4;
	Thu, 24 Jul 2025 04:50:37 -0700 (PDT)
Received: from [10.1.33.48] (e122027.cambridge.arm.com [10.1.33.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88B733F66E;
	Thu, 24 Jul 2025 04:50:41 -0700 (PDT)
Message-ID: <07bb07a6-edfc-44a9-ae9e-20868a5e9cf1@arm.com>
Date: Thu, 24 Jul 2025 12:50:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/6] drm/panthor: Make MMU cache maintenance use
 FLUSH_CACHES command
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, Chia-I Wu <olvaffe@gmail.com>
References: <20250724092600.3225493-1-karunika.choo@arm.com>
 <20250724092600.3225493-6-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250724092600.3225493-6-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2025 10:25, Karunika Choo wrote:
> As the FLUSH_MEM and FLUSH_PT MMU_AS commands are deprecated in GPUs
> from Mali-Gx20 onwards, this patch adds support for performing cache
> maintenance via the FLUSH_CACHES command in GPU_COMMAND in place of
> FLUSH_MEM and FLUSH_PT commands.
> 
> Mali-Gx10 and Mali-Gx15 GPUs also has support for the FLUSH_CACHES
> command and will also use this by default going forward.
> 
> Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 33 +++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 4140f697ba5a..367c89aca558 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -29,6 +29,7 @@
>  
>  #include "panthor_device.h"
>  #include "panthor_gem.h"
> +#include "panthor_gpu.h"
>  #include "panthor_heap.h"
>  #include "panthor_mmu.h"
>  #include "panthor_regs.h"
> @@ -568,6 +569,35 @@ static void lock_region(struct panthor_device *ptdev, u32 as_nr,
>  	write_cmd(ptdev, as_nr, AS_COMMAND_LOCK);
>  }
>  
> +static int mmu_hw_do_flush_on_gpu_ctrl(struct panthor_device *ptdev, int as_nr,
> +				       u32 op)
> +{
> +	const u32 l2_flush_op = CACHE_CLEAN | CACHE_INV;
> +	u32 lsc_flush_op = 0;
> +	int ret;
> +
> +	if (op == AS_COMMAND_FLUSH_MEM)
> +		lsc_flush_op = CACHE_CLEAN | CACHE_INV;
> +
> +	ret = wait_ready(ptdev, as_nr);
> +	if (ret)
> +		return ret;
> +
> +	ret = panthor_gpu_flush_caches(ptdev, l2_flush_op, lsc_flush_op, 0);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Explicitly unlock the region as the AS is not unlocked automatically
> +	 * at the end of the GPU_CONTROL cache flush command, unlike
> +	 * AS_COMMAND_FLUSH_MEM or AS_COMMAND_FLUSH_PT.
> +	 */
> +	write_cmd(ptdev, as_nr, AS_COMMAND_UNLOCK);
> +
> +	/* Wait for the unlock command to complete */
> +	return wait_ready(ptdev, as_nr);
> +}
> +
>  static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
>  				      u64 iova, u64 size, u32 op)
>  {
> @@ -585,6 +615,9 @@ static int mmu_hw_do_operation_locked(struct panthor_device *ptdev, int as_nr,
>  	if (op != AS_COMMAND_UNLOCK)
>  		lock_region(ptdev, as_nr, iova, size);
>  
> +	if (op == AS_COMMAND_FLUSH_MEM || op == AS_COMMAND_FLUSH_PT)
> +		return mmu_hw_do_flush_on_gpu_ctrl(ptdev, as_nr, op);
> +
>  	/* Run the MMU operation */
>  	write_cmd(ptdev, as_nr, op);
>  


