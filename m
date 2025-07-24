Return-Path: <linux-kernel+bounces-744697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F8CB10FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29EEC7B685D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933BE1F7060;
	Thu, 24 Jul 2025 16:50:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F22317A318
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753375808; cv=none; b=s9QbtOawYeoQNov+9yR9ZCOSipMprJlQh1ncqhV/TVfcqTyiUY1gcDIXo81lklHxjlA2IXoWL7Kx39i3enPuoXnMPfMZcXEpuuQISOtPGlQ+Wz2Jtyy7VhQZdIUWDNIh5cLc+J/AukjhxJEBRlkirG6NzcbzArpPKvHTwYbNK8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753375808; c=relaxed/simple;
	bh=YeVAZzteT4zgkKxLC4/qHJBjmXXMmD1AoAy921YmNuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qb6kUjHFuWjSnE64GMJxAS0pZ7VJecxyDzm+VEw0poUgZDriwePIq+HmQAgYmuoALuSjC9J8Nws+/SL2ouEOnyOcojLPpKEUV2+W1/y0suYScId1Yy9lKChlR+FM81awPHCk84No/Vka+AbLKKhtNAr/32fmlJLVqYlA7ekVajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FE791A00
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:49:58 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B57463F66E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:50:04 -0700 (PDT)
Date: Thu, 24 Jul 2025 17:49:53 +0100
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
Subject: Re: [PATCH v8 6/6] drm/panthor: Add support for Mali-Gx20 and
 Mali-Gx25 GPUs
Message-ID: <aIJkMV1J41ZB1pYH@e110455-lin.cambridge.arm.com>
References: <20250724124210.3675094-1-karunika.choo@arm.com>
 <20250724124210.3675094-7-karunika.choo@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250724124210.3675094-7-karunika.choo@arm.com>

On Thu, Jul 24, 2025 at 01:42:10PM +0100, Karunika Choo wrote:
> This patch adds firmware binary and GPU model naming support for
> Mali-Gx20 and Mali-Gx25 GPUs.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c |  2 ++
>  drivers/gpu/drm/panthor/panthor_hw.c | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
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
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 8c041e1074a1..4f2858114e5e 100644
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

