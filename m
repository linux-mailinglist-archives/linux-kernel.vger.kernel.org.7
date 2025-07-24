Return-Path: <linux-kernel+bounces-744212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CA8B1098F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E831CE0F62
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9043C2BD5BB;
	Thu, 24 Jul 2025 11:50:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCD71853
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357844; cv=none; b=gglpLrGLsx5BnIcbM9h5vT9VB9utLXuprAy5SGMpd2wzMojz5geogfphXRv5l4sW4PaiiCJqAa1xkgljwoa9YaGyfOqNIXKoOUh2H7fBcrt6OIUwCPfKlYxyv0DU/GRJmRQZwFM4aZ9UWQzW9G5rf06h9ofJUQ3ZoIA+vWwbfac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357844; c=relaxed/simple;
	bh=5v5bD0zn3kS5aH9PCUf6OOkBRFpaYDLN+1JqMD2Lquk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeFNiGiwQbX+0VMgyw/xTQw0LTJqAdez63iqN6ca94703EI7FQ1dg6noDLG9Av/PS4Z0GiN9l2qbmC2Qz8kATnqbthRqotwpgoTMGFqHvkO1AKLCTvY+LIBGfheaNAu1bSo1GcNlTvpEh9AgTqf6Er9WHDbi/nME3dfDNDH+RWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D04081A00;
	Thu, 24 Jul 2025 04:50:34 -0700 (PDT)
Received: from [10.1.33.48] (e122027.cambridge.arm.com [10.1.33.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B77993F66E;
	Thu, 24 Jul 2025 04:50:38 -0700 (PDT)
Message-ID: <2819e4cc-b9c8-4d50-a4d4-2670dba2603b@arm.com>
Date: Thu, 24 Jul 2025 12:50:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] drm/panthor: Add support for Mali-Gx15 family of
 GPUs
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, Chia-I Wu <olvaffe@gmail.com>
References: <20250724092600.3225493-1-karunika.choo@arm.com>
 <20250724092600.3225493-5-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250724092600.3225493-5-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2025 10:25, Karunika Choo wrote:
> Mali-Gx15 introduces a new GPU_FEATURES register that provides
> information about GPU-wide supported features. The register value will
> be passed on to userspace via gpu_info.
> 
> Additionally, Mali-Gx15 presents an 'Immortalis' naming variant
> depending on the shader core count and presence of Ray Intersection
> feature support.
> 
> This patch adds:
> - support for correctly identifying the model names for Mali-Gx15 GPUs.
> - arch 11.8 FW binary support
> 
> Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c   |  1 +
>  drivers/gpu/drm/panthor/panthor_hw.c   | 15 +++++++++++++++
>  drivers/gpu/drm/panthor/panthor_regs.h |  3 +++
>  include/uapi/drm/panthor_drm.h         |  3 +++
>  4 files changed, 22 insertions(+)
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
> index 48bbfd40138c..8bee76d01bf8 100644
> --- a/drivers/gpu/drm/panthor/panthor_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_regs.h
> @@ -70,6 +70,9 @@
>  #define GPU_PWR_OVERRIDE0				0x54
>  #define GPU_PWR_OVERRIDE1				0x58
>  
> +#define GPU_FEATURES					0x60
> +#define   GPU_FEATURES_RAY_INTERSECTION			BIT(2)
> +
>  #define GPU_TIMESTAMP_OFFSET				0x88
>  #define GPU_CYCLE_COUNT					0x90
>  #define GPU_TIMESTAMP					0x98
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


