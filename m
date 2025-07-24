Return-Path: <linux-kernel+bounces-744300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA955B10AA5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5E1AC2518
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4FB2D46C4;
	Thu, 24 Jul 2025 12:50:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750022D5412
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753361432; cv=none; b=XZGwisorIAZah6L/y9awxW0iD/cKtGTdIr2SuVYbAyL58Ny04YA5M1F6q8B0UGLv+iPGBlNHnnYkzIXPn38jPHQ1sU+LnHJP2hm9k5ZKocIUm9KTcnGijteK6gl4TxV9gk6BBLVuj3h60tEgXSD0GNFX4YUFn90no7NhiP05RBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753361432; c=relaxed/simple;
	bh=ra9fLKjPaZ5EFjdlc1plVfWpo7R8fUe8ekBW+KjJbyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIBf2iR+7cyYwQYimuyQwp9vleLnKb11/2ir73ZhgdoFJTYn/vHuq1iwXJsJnsRNQUO1lJQBbtNCwrvpBNkn9rAPq6JicmX419gZdkFRzg16eEG+OmpM3TJVCa5AVisZe7EoTIs8YO1ilGLzqLblitlBNjS2wwzLUYPcb4Tahzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B23B1A00;
	Thu, 24 Jul 2025 05:50:23 -0700 (PDT)
Received: from [10.1.33.48] (e122027.cambridge.arm.com [10.1.33.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 779BB3F6A8;
	Thu, 24 Jul 2025 05:50:27 -0700 (PDT)
Message-ID: <6fa8edbe-6f36-4390-b783-cbf29715a940@arm.com>
Date: Thu, 24 Jul 2025 13:50:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] drm/panthor: Add support for Mali-Gx20 and
 Mali-Gx25 GPUs
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20250724124210.3675094-1-karunika.choo@arm.com>
 <20250724124210.3675094-7-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250724124210.3675094-7-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/07/2025 13:42, Karunika Choo wrote:
> This patch adds firmware binary and GPU model naming support for
> Mali-Gx20 and Mali-Gx25 GPUs.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

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


