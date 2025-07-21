Return-Path: <linux-kernel+bounces-739506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 571A0B0C718
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816E03AD938
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BC12DCC13;
	Mon, 21 Jul 2025 15:00:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA672DCF40
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110005; cv=none; b=IWX2nRWZfNPsckn56FVa6HahsVypbm8X3ZctP14TIWuKgtpllkBGUv2tbQth18TGoVxrlWJwm8FXt1kIsPj1jItC9XPXxclSBc3wfXOzgTAl5xVYZZGdR3WTJfAtalJomo3yxgXmuHcgDwsAln+fbWfD0g/ITJy6UTMSxtIsLx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110005; c=relaxed/simple;
	bh=/h+BiP9gL45yMiNLBs3BZBI+spQn6H+y9ql1+NruU1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lC0r2YBhc+WzyeqJ9y9uiwDqv2O5GdknuTx23JnRhhBkSwe4YJkqxw119HQRy+ZNqtQp/UqG33z0hrYetO7kn3BqJDVTvzA6cysUk31FVXtIKp+b5P6DV8MwSKS1xcyF7X3cF0jqTim1Whr3qQzWGNVOun51s3PHEsRCt4MEH4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC9F0153B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 07:59:56 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 630A03F6A8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:00:02 -0700 (PDT)
Date: Mon, 21 Jul 2025 15:59:51 +0100
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
Subject: Re: [PATCH v5 6/6] drm/panthor: Add support for Mali-Gx20 and
 Mali-Gx25 GPUs
Message-ID: <aH5V5_sXBGp5XOBQ@e110455-lin.cambridge.arm.com>
References: <20250721111344.1610250-1-karunika.choo@arm.com>
 <20250721111344.1610250-7-karunika.choo@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250721111344.1610250-7-karunika.choo@arm.com>

On Mon, Jul 21, 2025 at 12:13:44PM +0100, Karunika Choo wrote:
> This patch adds firmware binary and GPU model naming support for
> Mali-Gx20 and Mali-Gx25 GPUs.
> 
> It also introduces the following registers:
> - GPU_COMMAND_ARG0~1
> - SHADER_PWRFEATURES
> - MCU_FEATURES
> 
> The GPU_COHERENCY_FEATURES macros are slightly reworked as the
> assumption that FEATURE = BIT(PROTOCOL) no longer holds with the
> introduction of the SHAREABLE_CACHE_SUPPORT, which is BIT(5) on the
> GPU_COHERENCY_PROTOCOL register. As such, the feature bits are now
> individually defined. Further changes were also made to enable
> SHAREABLE_CACHE_SUPPORT if coherency is enabled and the feature is
> supported.
> 
> This patch also fixes a minor bug that incorrectly writes ACE instead of
> ACE_LITE to GPU_COHERENCY_PROTOCOL if coherency is enabled.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c |  2 +-
>  drivers/gpu/drm/panthor/panthor_fw.c     |  2 ++
>  drivers/gpu/drm/panthor/panthor_gpu.c    | 14 ++++++++++++--
>  drivers/gpu/drm/panthor/panthor_hw.c     | 18 ++++++++++++++++++
>  drivers/gpu/drm/panthor/panthor_regs.h   | 11 ++++++++++-
>  5 files changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 81df49880bd8..f547aa4159ec 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -34,7 +34,7 @@ static int panthor_gpu_coherency_init(struct panthor_device *ptdev)
>  	 * ACE protocol has never been supported for command stream frontend GPUs.
>  	 */
>  	if ((gpu_read(ptdev, GPU_COHERENCY_FEATURES) &
> -		      GPU_COHERENCY_PROT_BIT(ACE_LITE)))
> +	     GPU_COHERENCY_FEATURE_ACE_LITE))
>  		return 0;
>  
>  	drm_err(&ptdev->base, "Coherency not supported by the device");
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index fa6e0b48a0b2..9bf06e55eaee 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1405,3 +1405,5 @@ MODULE_FIRMWARE("arm/mali/arch10.8/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch10.10/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch10.12/mali_csffw.bin");
>  MODULE_FIRMWARE("arm/mali/arch11.8/mali_csffw.bin");
> +MODULE_FIRMWARE("arm/mali/arch12.8/mali_csffw.bin");
> +MODULE_FIRMWARE("arm/mali/arch13.8/mali_csffw.bin");
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index 5e2c3173ae27..df2419706fe0 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -45,8 +45,18 @@ struct panthor_gpu {
>  
>  static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
>  {
> -	gpu_write(ptdev, GPU_COHERENCY_PROTOCOL,
> -		ptdev->coherent ? GPU_COHERENCY_PROT_BIT(ACE_LITE) : GPU_COHERENCY_NONE);
> +	u32 coherency_protocol = GPU_COHERENCY_NONE;
> +
> +	if (ptdev->coherent) {
> +		coherency_protocol = GPU_COHERENCY_ACE_LITE;
> +
> +		if ((gpu_read(ptdev, GPU_COHERENCY_FEATURES) &
> +		     GPU_COHERENCY_FEATURE_SHAREABLE_CACHE_SUPPORT))
> +			coherency_protocol |=
> +				GPU_COHERENCY_SHAREABLE_CACHE_SUPPORT;
> +	}
> +
> +	gpu_write(ptdev, GPU_COHERENCY_PROTOCOL, coherency_protocol);
>  }
>  
>  static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index a7583342d797..3fcb69a6f959 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -35,6 +35,24 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
>  		fallthrough;
>  	case GPU_PROD_ID_MAKE(11, 3):
>  		return "Mali-G615";
> +	case GPU_PROD_ID_MAKE(12, 0):
> +		if (shader_core_count >= 10 && ray_intersection)
> +			return "Mali-G720-Immortalis";
> +		else if (shader_core_count >= 6)
> +			return "Mali-G720";
> +
> +		fallthrough;
> +	case GPU_PROD_ID_MAKE(12, 1):
> +		return "Mali-G620";
> +	case GPU_PROD_ID_MAKE(13, 0):
> +		if (shader_core_count >= 10 && ray_intersection)
> +			return "Mali-G925-Immortalis";
> +		else if (shader_core_count >= 6)
> +			return "Mali-G725";
> +
> +		fallthrough;
> +	case GPU_PROD_ID_MAKE(13, 1):
> +		return "Mali-G625";
>  	}
>  
>  	return "(Unknown Mali GPU)";
> diff --git a/drivers/gpu/drm/panthor/panthor_regs.h b/drivers/gpu/drm/panthor/panthor_regs.h
> index e4c34f70a880..a9ea32e5fe39 100644
> --- a/drivers/gpu/drm/panthor/panthor_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_regs.h
> @@ -87,6 +87,8 @@
>  
>  #define GPU_DOORBELL_FEATURES				0xC0
>  
> +#define GPU_COMMAND_ARG(n)				(0xD0 + ((n) * 8))

This ...

> +
>  #define GPU_SHADER_PRESENT				0x100
>  #define GPU_TILER_PRESENT				0x110
>  #define GPU_L2_PRESENT					0x120
> @@ -96,6 +98,8 @@
>  #define L2_READY					0x160
>  
>  #define SHADER_PWRON					0x180
> +#define SHADER_PWRFEATURES				0x188
> +#define   SHADER_PWRFEATURES_RAY_TRACING_UNIT		BIT(0)

... and this are not used anywhere. Can we remove them until we add code that uses them?

>  #define TILER_PWRON					0x190
>  #define L2_PWRON					0x1A0
>  
> @@ -116,12 +120,15 @@
>  #define GPU_ASN_HASH(n)				(0x2C0 + ((n) * 4))
>  
>  #define GPU_COHERENCY_FEATURES				0x300
> -#define GPU_COHERENCY_PROT_BIT(name)			BIT(GPU_COHERENCY_  ## name)
> +#define   GPU_COHERENCY_FEATURE_ACE_LITE		BIT(0)
> +#define   GPU_COHERENCY_FEATURE_ACE			BIT(1)
> +#define   GPU_COHERENCY_FEATURE_SHAREABLE_CACHE_SUPPORT	BIT(5)
>  
>  #define GPU_COHERENCY_PROTOCOL				0x304
>  #define   GPU_COHERENCY_ACE_LITE			0
>  #define   GPU_COHERENCY_ACE				1
>  #define   GPU_COHERENCY_NONE				31
> +#define   GPU_COHERENCY_SHAREABLE_CACHE_SUPPORT		BIT(5)
>  
>  #define GPU_SYSC_PBHA_OVERRIDE(n)			(0x320 + ((n) * 4))
>  #define GPU_SYSC_ALLOC(n)				(0x340 + ((n) * 4))
> @@ -137,6 +144,8 @@
>  #define MCU_STATUS_HALT					2
>  #define MCU_STATUS_FATAL				3
>  
> +#define MCU_FEATURES					0x708

Same for this one.

With that changed,

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> +
>  /* Job Control regs */
>  #define JOB_INT_RAWSTAT					0x1000
>  #define JOB_INT_CLEAR					0x1004
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

