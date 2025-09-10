Return-Path: <linux-kernel+bounces-810546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FABB51C2C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B821189669F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C772832A83D;
	Wed, 10 Sep 2025 15:42:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E09432BF4E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518968; cv=none; b=JpmRmh7ElqR2AGSTTOoTePopPFQzOzsUzembzsR+aRmtAFYVg0VUEvUEKajo3k9SKDNLmP/F86C0KLiZDaPuLNOQ3zb0Nve+ryyBVKecXRYzjkNTUJ/iLe0JeR22vO87zRNdluDhrWi/s5g3xSqz+l31BFU0kk9bk0jR34R6+yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518968; c=relaxed/simple;
	bh=oOk6BenM9nN4k5kQcY6eKw6h4RDUxyRw/uyM1nHrdTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEmtRB1c9vfxiz/RLHbfMQBoagPc2wpefFK6k5MqlX2aH8Cu741B5ov0cLM/0BMbzzoDBzUknT0TmEXEEwjEymL5CTT+otZ5X3yUPYHY5WZ9NML8em/AELVatTCwHcxkMfrj2Qg+EerrLWr+rcvOr34iTsoqqwUiV14krCwjOf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A814F16F2;
	Wed, 10 Sep 2025 08:42:37 -0700 (PDT)
Received: from [10.1.25.55] (e122027.cambridge.arm.com [10.1.25.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA1443F694;
	Wed, 10 Sep 2025 08:42:41 -0700 (PDT)
Message-ID: <1b270301-c5d1-4054-a602-aa6e227bd85e@arm.com>
Date: Wed, 10 Sep 2025 16:42:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/panfrost: Expose JM context IOCTLs to UM
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20250904001054.147465-1-adrian.larumbe@collabora.com>
 <20250904001054.147465-4-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250904001054.147465-4-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/09/2025 01:08, Adrián Larumbe wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> Minor revision of the driver must be bumped because this expands the
> uAPI. On top of that, let user know the available priorities so that
> they can create contexts with legal priority values.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 35 +++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 398c067457d9..02f704ec4961 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -13,6 +13,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <drm/panfrost_drm.h>
> +#include <drm/drm_auth.h>
>  #include <drm/drm_debugfs.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_ioctl.h>
> @@ -109,6 +110,15 @@ static int panfrost_ioctl_get_param(struct drm_device *ddev, void *data, struct
>  #endif
>  		break;
>  
> +	case DRM_PANFROST_PARAM_ALLOWED_JM_CTX_PRIORITIES:
> +		param->value = BIT(PANFROST_JM_CTX_PRIORITY_LOW) |
> +			       BIT(PANFROST_JM_CTX_PRIORITY_MEDIUM);
> +
> +		/* High prio require CAP_SYS_NICE or DRM_MASTER */
> +		if (capable(CAP_SYS_NICE) || drm_is_current_master(file))

NIT: This is repeating the check in jm_ctx_prio_to_drm_sched_prio(). It
would be nice to have this check in one place to ensure that the two
cannot get out of sync.

> +			param->value |= BIT(PANFROST_JM_CTX_PRIORITY_HIGH);
> +		break;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -295,8 +305,7 @@ static int panfrost_ioctl_submit(struct drm_device *dev, void *data,
>  			return -ENODEV;
>  	}
>  
> -	/* TODO: Use the default JM context until ctx management IOCTLs are exposed */
> -	jm_ctx = panfrost_jm_ctx_from_handle(file, 0);
> +	jm_ctx = panfrost_jm_ctx_from_handle(file, args->jm_ctx_handle);

I'm not sure if this should go in this patch or the previous one, but:
we need to add a check that the padding is 0. Personally I'd be tempted
to put it in the previous patch and enforce that jm_ctx_handle is zeroed
too (and drop that check here when you also remove the TODO).

>  	if (!jm_ctx) {
>  		ret = -EINVAL;
>  		goto out_put_syncout;
> @@ -547,6 +556,24 @@ static int panfrost_ioctl_set_label_bo(struct drm_device *ddev, void *data,
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
> +	/* We can't destroy the default context created when the file is opened. */
> +	if (!args->handle)
> +		return -EINVAL;

Also need a check for padding being non-zero.

Thanks,
Steve

> +
> +	return panfrost_jm_ctx_destroy(file, args->handle);
> +}
> +
>  int panfrost_unstable_ioctl_check(void)
>  {
>  	if (!unstable_ioctls)
> @@ -614,6 +641,8 @@ static const struct drm_ioctl_desc panfrost_drm_driver_ioctls[] = {
>  	PANFROST_IOCTL(PERFCNT_DUMP,	perfcnt_dump,	DRM_RENDER_ALLOW),
>  	PANFROST_IOCTL(MADVISE,		madvise,	DRM_RENDER_ALLOW),
>  	PANFROST_IOCTL(SET_LABEL_BO,	set_label_bo,	DRM_RENDER_ALLOW),
> +	PANFROST_IOCTL(JM_CTX_CREATE,	jm_ctx_create,	DRM_RENDER_ALLOW),
> +	PANFROST_IOCTL(JM_CTX_DESTROY,	jm_ctx_destroy,	DRM_RENDER_ALLOW),
>  };
>  
>  static void panfrost_gpu_show_fdinfo(struct panfrost_device *pfdev,
> @@ -710,6 +739,8 @@ static void panfrost_debugfs_init(struct drm_minor *minor)
>   * - 1.3 - adds JD_REQ_CYCLE_COUNT job requirement for SUBMIT
>   *       - adds SYSTEM_TIMESTAMP and SYSTEM_TIMESTAMP_FREQUENCY queries
>   * - 1.4 - adds SET_LABEL_BO
> + * - 1.5 - adds JM_CTX_{CREATE,DESTROY} ioctls and extend SUBMIT to allow
> + *	   context creation with configurable priorities/affinity
>   */
>  static const struct drm_driver panfrost_drm_driver = {
>  	.driver_features	= DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ,


