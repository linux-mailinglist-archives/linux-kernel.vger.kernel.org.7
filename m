Return-Path: <linux-kernel+bounces-860982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D01BF1813
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADFD404A51
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31CB29DB65;
	Mon, 20 Oct 2025 13:18:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773A925A655
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966290; cv=none; b=Od7YX7tIkO2QOTiafsGcVKVTxcnEvo/AtIyPBE3qDh+flHLATnHaeE4A/YGvI7YDq5CWxsziQjtbYbyEcj00lxjce4phfYtL2xfk6FSh9/GAsV9wGfmPbT1fl17lSUhHKzx9dAFU0FDCMvnXhFAYgslr9THZJTMW48n9qN5qGIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966290; c=relaxed/simple;
	bh=WAmOCTliJzJeHPoMcdWhnFeu8BoebL8Q7w/VP3jRo0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aDqvPA9GVlIRhfaPdRJbCBy6myFYEAW4K1UPi0sUPP84UNBUl+blkEiACz4Wwc0tHomna6whLgtqSsFsYnHOpx11zaLmQaFClqYBTDaillfgpk9cdQ+onbJa5qaPIQ23sHhs/q5q8ZyKzx0LuHdg5ERJdnXv2NR3tas9zlt25mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D823D1063;
	Mon, 20 Oct 2025 06:17:57 -0700 (PDT)
Received: from [10.57.36.117] (unknown [10.57.36.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C00053F66E;
	Mon, 20 Oct 2025 06:18:03 -0700 (PDT)
Message-ID: <8f4c42d3-b0e9-4786-a14e-70045ec66489@arm.com>
Date: Mon, 20 Oct 2025 14:18:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/10] drm/panthor: Add support for Mali-G1 GPUs
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20251014094337.1009601-1-karunika.choo@arm.com>
 <20251014094337.1009601-11-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251014094337.1009601-11-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2025 10:43, Karunika Choo wrote:
> Add support for Mali-G1 GPUs (CSF architecture v14), introducing a new
> panthor_hw_arch_v14 entry with reset and L2 power management operations
> via the PWR_CONTROL block.
> 
> Mali-G1 introduces a dedicated PWR_CONTROL block for managing resets and
> power domains. panthor_gpu_info_init() is updated to use this block for
> L2, tiler, and shader domain present register reads.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c |  1 +
>  drivers/gpu/drm/panthor/panthor_hw.c | 30 ++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index c1b2fba311d8..dd5ffbea8cd8 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1493,3 +1493,4 @@ MODULE_FIRMWARE("arm/mali/arch10.12/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch11.8/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch12.8/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch13.8/mali_csffw.bin");
> +MODULE_FIRMWARE("arm/mali/arch14.8/mali_csffw.bin");
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 77fd2c56e69f..7a47414d246e 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -4,6 +4,7 @@
>  #include "panthor_device.h"
>  #include "panthor_gpu.h"
>  #include "panthor_hw.h"
> +#include "panthor_pwr.h"
>  #include "panthor_regs.h"
>  
>  #define GPU_PROD_ID_MAKE(arch_major, prod_major) \
> @@ -29,12 +30,28 @@ static struct panthor_hw panthor_hw_arch_v10 = {
>  	},
>  };
>  
> +static struct panthor_hw panthor_hw_arch_v14 = {
> +	.features = {
> +		BIT(PANTHOR_HW_FEATURE_PWR_CONTROL)
> +	},
> +	.ops = {
> +		.soft_reset = panthor_pwr_reset_soft,
> +		.l2_power_off = panthor_pwr_l2_power_off,
> +		.l2_power_on = panthor_pwr_l2_power_on,
> +	},
> +};
> +
>  static struct panthor_hw_entry panthor_hw_match[] = {
>  	{
>  		.arch_min = 10,
>  		.arch_max = 13,
>  		.hwdev = &panthor_hw_arch_v10,
>  	},
> +	{
> +		.arch_min = 14,
> +		.arch_max = 14,
> +		.hwdev = &panthor_hw_arch_v14,
> +	},
>  };
>  
>  static char *get_gpu_model_name(struct panthor_device *ptdev)
> @@ -82,6 +99,12 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
>  		fallthrough;
>  	case GPU_PROD_ID_MAKE(13, 1):
>  		return "Mali-G625";
> +	case GPU_PROD_ID_MAKE(14, 0):
> +		return "Mali-G1-Ultra";
> +	case GPU_PROD_ID_MAKE(14, 1):
> +		return "Mali-G1-Premium";
> +	case GPU_PROD_ID_MAKE(14, 3):
> +		return "Mali-G1-Pro";
>  	}
>  
>  	return "(Unknown Mali GPU)";
> @@ -114,6 +137,13 @@ static void panthor_gpu_info_init(struct panthor_device *ptdev)
>  
>  	/* Introduced in arch 11.x */
>  	ptdev->gpu_info.gpu_features = gpu_read64(ptdev, GPU_FEATURES);
> +
> +	/* Introduced in arch 14.x */
> +	if (panthor_hw_has_feature(ptdev, PANTHOR_HW_FEATURE_PWR_CONTROL)) {
> +		ptdev->gpu_info.l2_present = gpu_read64(ptdev, PWR_L2_PRESENT);
> +		ptdev->gpu_info.tiler_present = gpu_read64(ptdev, PWR_TILER_PRESENT);
> +		ptdev->gpu_info.shader_present = gpu_read64(ptdev, PWR_SHADER_PRESENT);
> +	}

This should be instead of reading the GPU_SHADER_PRESENT etc registers.
At the moment we're reading a bunch of registers which are reserved on
the new GPUs, only to replace the values here.

Thanks,
Steve

>  }
>  
>  static void panthor_hw_info_init(struct panthor_device *ptdev)


