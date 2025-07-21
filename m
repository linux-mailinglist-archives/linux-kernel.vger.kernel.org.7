Return-Path: <linux-kernel+bounces-739487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CABB0C6D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201086C099F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B064628C2B0;
	Mon, 21 Jul 2025 14:46:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5CB2D3236
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109205; cv=none; b=azMUBedwmzFmCLpLUxQ5o304pvK/b+iUcTan8bdcYgal3XT2omUmKo0g0UCgC+Fv9Mweiv7LOIQ52ZVvc4rh2tp6ChIvtepf/tWLsO4SzZV5MZEQ0hTO+vn014ZkNCR6S//NHRo4i5fDeRCI//mVwhiCEKPw/xRCtrOB9DNRVP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109205; c=relaxed/simple;
	bh=wuYODrr2iWFv8HaN91KSGOFVBZ0zVupE5R3XDV7yWOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YMN5DtFhQ5dkwOXAGKYgxYSmSrGT4ornBm0FZZJUqQukGaW5OX/vAZSX5K9WAFy3u9cHSK3R3h9afzFfSJ5uKC9B1Xf30LYWfjAHFaW4qBY62LoeSHOjFIb4NPpKIqKMrkskmwnG7lkGIk1F+2P+JFBwqdSVNLeS+rB/KcMBFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1F25153B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:46:36 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6BBF43F66E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:46:42 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:46:31 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] drm/panthor: Add support for Mali-Gx15 family of
 GPUs
Message-ID: <aH5Sx15_pyMa1rmN@e110455-lin.cambridge.arm.com>
References: <20250721111344.1610250-1-karunika.choo@arm.com>
 <20250721111344.1610250-5-karunika.choo@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250721111344.1610250-5-karunika.choo@arm.com>

On Mon, Jul 21, 2025 at 12:13:42PM +0100, Karunika Choo wrote:
> Mali-Gx15 introduces a new GPU_FEATURES register that provides
> information about GPU-wide supported features. The register value will
> be passed on to userspace via gpu_info. It also adds the following
> registers that are specific to the kernel driver only:
> - ASN_HASH_0~2
> - DOORBELL_FEATURES
> - PRFCNT_FEATURES
> - SYSC_ALLOC0~7
> - SYSC_PBHA_OVERRIDE0~3
> 
> Additionally, Mali-Gx15 presents an 'Immortalis' naming variant
> depending on the shader core count and presence of Ray Intersection
> feature support.
> 
> This patch adds:
> - support for correctly identifying the model names for Mali-Gx15 GPUs.
> - arch 11.8 FW binary support
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c   |  1 +
>  drivers/gpu/drm/panthor/panthor_hw.c   | 15 +++++++++++++++
>  drivers/gpu/drm/panthor/panthor_regs.h | 11 +++++++++++
>  include/uapi/drm/panthor_drm.h         |  3 +++
>  4 files changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index b7b454d16f12..fa6e0b48a0b2 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1404,3 +1404,4 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  MODULE_FIRMWARE("arm/mali/arch10.8/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch10.10/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch10.12/mali_csffw.bin");
> +MODULE_FIRMWARE("arm/mali/arch11.8/mali_csffw.bin");
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 7f138974d43b..a7583342d797 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -13,6 +13,9 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
>  	const u32 gpu_id = ptdev->gpu_info.gpu_id;
>  	const u32 product_id = GPU_PROD_ID_MAKE(GPU_ARCH_MAJOR(gpu_id),
>  						GPU_PROD_MAJOR(gpu_id));
> +	const bool ray_intersection = !!(ptdev->gpu_info.gpu_features &
> +					 GPU_FEATURES_RAY_INTERSECTION);
> +	const u8 shader_core_count = hweight64(ptdev->gpu_info.shader_present);
>  
>  	switch (product_id) {
>  	case GPU_PROD_ID_MAKE(10, 2):
> @@ -23,6 +26,15 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
>  		return "Mali-G510";
>  	case GPU_PROD_ID_MAKE(10, 4):
>  		return "Mali-G310";
> +	case GPU_PROD_ID_MAKE(11, 2):
> +		if (shader_core_count > 10 && ray_intersection)
> +			return "Mali-G715-Immortalis";
> +		else if (shader_core_count >= 7)
> +			return "Mali-G715";
> +
> +		fallthrough;
> +	case GPU_PROD_ID_MAKE(11, 3):
> +		return "Mali-G615";
>  	}
>  
>  	return "(Unknown Mali GPU)";
> @@ -53,6 +65,9 @@ static void panthor_gpu_info_init(struct panthor_device *ptdev)
>  	ptdev->gpu_info.shader_present = gpu_read64(ptdev, GPU_SHADER_PRESENT);
>  	ptdev->gpu_info.tiler_present = gpu_read64(ptdev, GPU_TILER_PRESENT);
>  	ptdev->gpu_info.l2_present = gpu_read64(ptdev, GPU_L2_PRESENT);
> +
> +	/* Introduced in arch 11.x */
> +	ptdev->gpu_info.gpu_features = gpu_read64(ptdev, GPU_FEATURES);
>  }
>  
>  static void panthor_hw_info_init(struct panthor_device *ptdev)
> diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/panthor/panthor_regs.h
> index 48bbfd40138c..e4c34f70a880 100644
> --- a/drivers/gpu/drm/panthor/panthor_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_regs.h
> @@ -70,6 +70,10 @@
>  #define GPU_PWR_OVERRIDE0				0x54
>  #define GPU_PWR_OVERRIDE1				0x58
>  
> +#define GPU_FEATURES					0x60
> +#define   GPU_FEATURES_RAY_INTERSECTION			BIT(2)
> +#define GPU_PRFCNT_FEATURES				0x68
> +
>  #define GPU_TIMESTAMP_OFFSET				0x88
>  #define GPU_CYCLE_COUNT					0x90
>  #define GPU_TIMESTAMP					0x98
> @@ -81,6 +85,8 @@
>  
>  #define GPU_TEXTURE_FEATURES(n)				(0xB0 + ((n) * 4))

Until they are actually used I would suggest that you remove the definitions for the
registers that are following this line.

With that change,

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

>  
> +#define GPU_DOORBELL_FEATURES				0xC0
> +
>  #define GPU_SHADER_PRESENT				0x100
>  #define GPU_TILER_PRESENT				0x110
>  #define GPU_L2_PRESENT					0x120
> @@ -107,6 +113,8 @@
>  
>  #define GPU_REVID					0x280
>  
> +#define GPU_ASN_HASH(n)				(0x2C0 + ((n) * 4))
> +
>  #define GPU_COHERENCY_FEATURES				0x300
>  #define GPU_COHERENCY_PROT_BIT(name)			BIT(GPU_COHERENCY_  ## name)
>  
> @@ -115,6 +123,9 @@
>  #define   GPU_COHERENCY_ACE				1
>  #define   GPU_COHERENCY_NONE				31
>  
> +#define GPU_SYSC_PBHA_OVERRIDE(n)			(0x320 + ((n) * 4))
> +#define GPU_SYSC_ALLOC(n)				(0x340 + ((n) * 4))
> +
>  #define MCU_CONTROL					0x700
>  #define MCU_CONTROL_ENABLE				1
>  #define MCU_CONTROL_AUTO				2
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index e1f43deb7eca..467d365ed7ba 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -327,6 +327,9 @@ struct drm_panthor_gpu_info {
>  
>  	/** @pad: MBZ. */
>  	__u32 pad;
> +
> +	/** @gpu_features: Bitmask describing supported GPU-wide features */
> +	__u64 gpu_features;
>  };
>  
>  /**
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

