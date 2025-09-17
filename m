Return-Path: <linux-kernel+bounces-820460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFBAB7E6FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FF1325FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9681835FC31;
	Wed, 17 Sep 2025 10:17:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B514296BA2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104250; cv=none; b=pNnS2LP8f25GOxSv6IEfadDEHima4LRtyGuzGCKV4M5jmWXnPTCmTia+hOE+84rK2QH31/GXEtaMaagOO89kbBkg+MeHmmQsMTXvTZ/9hv9AMuSJ9t47SiXV4db2+vdKoyuU+6pMnnxVquReruiDqnsYOPwNc+77VSV+YeWhfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104250; c=relaxed/simple;
	bh=SNJXGDyrpeyQlcc1Ww/8BPiLx8XrpL40MncirSx/QZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyYBHWCJr1NDEzt4YvZooqFPeyiNE37ppJ1Bd5519Vlm5kGbl8URuVFPIZ2dojGm5YTgP6Ti+g5rhvAQfW8e9rLnLEEQDt9xsue0tyLDAALLCDVrG2PM6UZUwySmdeY5PWv/EFZfYU3lCo8K4GX8e4Dbd3yvGpfHmBd+IL521BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7F2E25DC;
	Wed, 17 Sep 2025 03:17:18 -0700 (PDT)
Received: from [10.1.26.46] (e122027.cambridge.arm.com [10.1.26.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C3113F673;
	Wed, 17 Sep 2025 03:17:24 -0700 (PDT)
Message-ID: <e64440cb-4b7d-4b42-861b-4e6b529e13d5@arm.com>
Date: Wed, 17 Sep 2025 11:17:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drm/panfrost: Expose JM context IOCTLs to UM
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250912132002.304187-1-adrian.larumbe@collabora.com>
 <20250912132002.304187-4-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250912132002.304187-4-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/09/2025 14:19, Adrián Larumbe wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> Minor revision of the driver must be bumped because this expands the
> uAPI. On top of that, let UM know about the available priorities so that
> they can create contexts with legal priority values.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 36 ++++++++++++++++++++++---
>  1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index be384b18e8fd..69e72a800cd1 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -109,6 +109,14 @@ static int panfrost_ioctl_get_param(struct drm_device *ddev, void *data, struct
>  #endif
>  		break;
>  
> +	case DRM_PANFROST_PARAM_ALLOWED_JM_CTX_PRIORITIES:
> +		param->value = BIT(PANFROST_JM_CTX_PRIORITY_LOW) |
> +			       BIT(PANFROST_JM_CTX_PRIORITY_MEDIUM);
> +
> +		if (panfrost_high_prio_allowed(file))
> +			param->value |= BIT(PANFROST_JM_CTX_PRIORITY_HIGH);
> +		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -286,9 +294,6 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
>  	if (args->pad)
>  		return -EINVAL;
>  
> -	if (args->jm_ctx_handle)
> -		return -EINVAL;
> -
>  	if (!args->jc)
>  		return -EINVAL;
>  
> @@ -552,6 +557,27 @@ static int panfrost_ioctl_set_label_bo(struct drm_device *ddev, void *data,
>  	return ret;
>  }
>  
> +static int panfrost_ioctl_jm_ctx_create(struct drm_device *dev, void *data,
> +					struct drm_file *file)
> +{
> +	return panfrost_jm_ctx_create(file, data);
> +}
> +
> +static int panfrost_ioctl_jm_ctx_destroy(struct drm_device *dev, void *data,
> +					 struct drm_file *file)
> +{
> +	const struct drm_panfrost_jm_ctx_destroy *args = data;
> +
> +	if (args->pad)
> +		return -EINVAL;
> +
> +	/* We can't destroy the default context created when the file is opened. */
> +	if (!args->handle)
> +		return -EINVAL;
> +
> +	return panfrost_jm_ctx_destroy(file, args->handle);
> +}
> +
>  int panfrost_unstable_ioctl_check(void)
>  {
>  	if (!unstable_ioctls)
> @@ -619,6 +645,8 @@ static const struct drm_ioctl_desc panfrost_drm_driver_ioctls[] = {
>  	PANFROST_IOCTL(PERFCNT_DUMP,	perfcnt_dump,	DRM_RENDER_ALLOW),
>  	PANFROST_IOCTL(MADVISE,		madvise,	DRM_RENDER_ALLOW),
>  	PANFROST_IOCTL(SET_LABEL_BO,	set_label_bo,	DRM_RENDER_ALLOW),
> +	PANFROST_IOCTL(JM_CTX_CREATE,	jm_ctx_create,	DRM_RENDER_ALLOW),
> +	PANFROST_IOCTL(JM_CTX_DESTROY,	jm_ctx_destroy,	DRM_RENDER_ALLOW),
>  };
>  
>  static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
> @@ -715,6 +743,8 @@ static void panfrost_debugfs_init(struct drm_minor *minor)
>   * - 1.3 - adds JD_REQ_CYCLE_COUNT job requirement for SUBMIT
>   *       - adds SYSTEM_TIMESTAMP and SYSTEM_TIMESTAMP_FREQUENCY queries
>   * - 1.4 - adds SET_LABEL_BO
> + * - 1.5 - adds JM_CTX_{CREATE,DESTROY} ioctls and extend SUBMIT to allow
> + *	   context creation with configurable priorities/affinity
>   */
>  static const struct drm_driver panfrost_drm_driver = {
>  	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,


