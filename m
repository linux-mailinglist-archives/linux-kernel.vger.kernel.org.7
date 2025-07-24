Return-Path: <linux-kernel+bounces-744132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 105BCB10854
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61DD1CE5391
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C7926B973;
	Thu, 24 Jul 2025 11:00:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0320626B2B3
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354809; cv=none; b=c/h+/F7uVrlD7CbIl3jh0LRNy5XoECKhaFz2OvZG8riHjU2olSHSsw7Kc1CNYiyCvNj5MvFlOimoKtoDMfDVyoqVjFW9ViXIAxYdn0OGG1vxQs4V27lH/razb57R6cEulj0vK3D0oK2elmMkQgf/EKIhM7bdg2rHplHqpsu0Di0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354809; c=relaxed/simple;
	bh=Fwo6bypNh+M7asWu1dKCYuluZBtFFVZBnu2X47+zADA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcuKi2B3kQW7XZ5ZGXoAbbzKOJ6FwhuLDJdNUCcPnahI2j7nIBkF8B9xhi9pYBIN8VKdyMQd0+9Yum9JY4gKocqOd4UdrA+Sb7TOMiAKRJo1tOdx+3nned5DtFxKwii0I/oUZvhxbRe/H+kIa6tXIMiaXUFdXEMRGjAWWe1dov4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E57251CC4;
	Thu, 24 Jul 2025 04:00:00 -0700 (PDT)
Received: from [10.1.33.48] (e122027.cambridge.arm.com [10.1.33.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A3373F66E;
	Thu, 24 Jul 2025 04:00:04 -0700 (PDT)
Message-ID: <df67821f-eb95-4a5a-930a-8613420d78cf@arm.com>
Date: Thu, 24 Jul 2025 12:00:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/6] drm/panthor: Simplify getting the GPU model name
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org, Chia-I Wu <olvaffe@gmail.com>
References: <20250724092600.3225493-1-karunika.choo@arm.com>
 <20250724092600.3225493-3-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250724092600.3225493-3-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2025 10:25, Karunika Choo wrote:
> This patch replaces the panthor_model structure with a simple switch
> case based on the product_id which is in the format of:
>         ((arch_major << 24) | product_major)
> 
> This simplifies comparison and allows extending of the function to
> accommodate naming differences based on supported GPU features.
> 
> Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_hw.c | 61 ++++++++--------------------
>  1 file changed, 17 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 3f7175cb0ab4..f39010c0ca86 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -5,39 +5,22 @@
>  #include "panthor_hw.h"
>  #include "panthor_regs.h"
>  
> -/**
> - * struct panthor_model - GPU model description
> - */
> -struct panthor_model {
> -	/** @name: Model name. */
> -	const char *name;
> -
> -	/** @arch_major: Major version number of architecture. */
> -	u8 arch_major;
> -
> -	/** @product_major: Major version number of product. */
> -	u8 product_major;
> -};
> -
> -/**
> - * GPU_MODEL() - Define a GPU model. A GPU product can be uniquely identified
> - * by a combination of the major architecture version and the major product
> - * version.
> - * @_name: Name for the GPU model.
> - * @_arch_major: Architecture major.
> - * @_product_major: Product major.
> - */
> -#define GPU_MODEL(_name, _arch_major, _product_major) \
> -{\
> -	.name = __stringify(_name),				\
> -	.arch_major = _arch_major,				\
> -	.product_major = _product_major,			\
> -}
> +#define GPU_PROD_ID_MAKE(arch_major, prod_major) \
> +	(((arch_major) << 24) | (prod_major))
> +
> +static char *get_gpu_model_name(struct panthor_device *ptdev)
> +{
> +	const u32 gpu_id = ptdev->gpu_info.gpu_id;
> +	const u32 product_id = GPU_PROD_ID_MAKE(GPU_ARCH_MAJOR(gpu_id),
> +						GPU_PROD_MAJOR(gpu_id));
> +
> +	switch (product_id) {
> +	case GPU_PROD_ID_MAKE(10, 7):
> +		return "Mali-G610";
> +	}
>  
> -static const struct panthor_model gpu_models[] = {
> -	GPU_MODEL(g610, 10, 7),
> -	{},
> -};
> +	return "(Unknown Mali GPU)";
> +}
>  
>  static void panthor_gpu_info_init(struct panthor_device *ptdev)
>  {
> @@ -68,27 +51,17 @@ static void panthor_gpu_info_init(struct panthor_device *ptdev)
>  
>  static void panthor_hw_info_init(struct panthor_device *ptdev)
>  {
> -	const struct panthor_model *model;
> -	u32 arch_major, product_major;
>  	u32 major, minor, status;
>  
>  	panthor_gpu_info_init(ptdev);
>  
> -	arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
> -	product_major = GPU_PROD_MAJOR(ptdev->gpu_info.gpu_id);
>  	major = GPU_VER_MAJOR(ptdev->gpu_info.gpu_id);
>  	minor = GPU_VER_MINOR(ptdev->gpu_info.gpu_id);
>  	status = GPU_VER_STATUS(ptdev->gpu_info.gpu_id);
>  
> -	for (model = gpu_models; model->name; model++) {
> -		if (model->arch_major == arch_major &&
> -		    model->product_major == product_major)
> -			break;
> -	}
> -
>  	drm_info(&ptdev->base,
> -		 "mali-%s id 0x%x major 0x%x minor 0x%x status 0x%x",
> -		 model->name ?: "unknown", ptdev->gpu_info.gpu_id >> 16,
> +		 "%s id 0x%x major 0x%x minor 0x%x status 0x%x",
> +		 get_gpu_model_name(ptdev), ptdev->gpu_info.gpu_id >> 16,
>  		 major, minor, status);
>  
>  	drm_info(&ptdev->base,


