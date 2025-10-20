Return-Path: <linux-kernel+bounces-860405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B1CBF00FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95173E5A97
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C602ECEA3;
	Mon, 20 Oct 2025 08:57:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85EE299AB3
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760950646; cv=none; b=gc1EpoTh0jBM3HP36RBqAfkc8MFRcP7D6Uf2g0jYKFHQ98g/Z29V+6U6lfu0ynGB0Xf6nXdbumsyvIf8q1X4lwCM8Z4qH8P317MQ6FDaxXdQoRnWzi4RH/c6lbofFVmuh5Y2uZFKwh6kn8qzDqzq7IalTA4R4YS3clUK09v+O4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760950646; c=relaxed/simple;
	bh=d0EnmDC7UuamYBhsUplsA/mdq/esm0w+4Z4mpGxTkhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPnO6ph0xzum80V7ky7CQzn5+2pTQq7iyLHC6muJm8VEN+GJyEdW+2WEYBQnHdsHeiU+EUwWTDDgzCeNTihuNlrtbZRQ20s5Y+MYevU3HHZOJ3LPGsKnCeuxafQrPrEWV9Lrk9zl4GqlRm9Qyqive1boP1Lf+PWDUvl2TbkwsaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A67D1063;
	Mon, 20 Oct 2025 01:57:16 -0700 (PDT)
Received: from [10.57.36.117] (unknown [10.57.36.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC8B63F66E;
	Mon, 20 Oct 2025 01:57:21 -0700 (PDT)
Message-ID: <6c01f00b-7be3-451e-8429-2c5036dfe103@arm.com>
Date: Mon, 20 Oct 2025 09:57:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/10] drm/panthor: Factor out GPU_ID register read
 into separate function
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20251014094337.1009601-1-karunika.choo@arm.com>
 <20251014094337.1009601-2-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20251014094337.1009601-2-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2025 10:43, Karunika Choo wrote:
> Split the GPU_ID register read into its own helper function. The GPU_ID
> value will be used to enable architecture-specific behaviours, which may
> also affect how other registers (such as those used for gpu_info) are
> read.
> 
> This change separates the read operation so that subsequent code can
> depend on the intermediate result of processing the GPU_ID.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

I'd be very tempted to squash this into the next commit and simple read
the GPU ID at the beginning of panthor_hw_bind_device(). Is there any
reason not to?

Steve

> ---
>  drivers/gpu/drm/panthor/panthor_hw.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 4f2858114e5e..326a9db0b5c2 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -62,7 +62,6 @@ static void panthor_gpu_info_init(struct panthor_device *ptdev)
>  {
>  	unsigned int i;
>  
> -	ptdev->gpu_info.gpu_id = gpu_read(ptdev, GPU_ID);
>  	ptdev->gpu_info.csf_id = gpu_read(ptdev, GPU_CSF_ID);
>  	ptdev->gpu_info.gpu_rev = gpu_read(ptdev, GPU_REVID);
>  	ptdev->gpu_info.core_features = gpu_read(ptdev, GPU_CORE_FEATURES);
> @@ -117,8 +116,23 @@ static void panthor_hw_info_init(struct panthor_device *ptdev)
>  		 ptdev->gpu_info.tiler_present);
>  }
>  
> +static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
> +{
> +	ptdev->gpu_info.gpu_id = gpu_read(ptdev, GPU_ID);
> +	if (!ptdev->gpu_info.gpu_id)
> +		return -ENXIO;
> +
> +	return 0;
> +}
> +
>  int panthor_hw_init(struct panthor_device *ptdev)
>  {
> +	int ret = 0;
> +
> +	ret = panthor_hw_gpu_id_init(ptdev);
> +	if (ret)
> +		return ret;
> +
>  	panthor_hw_info_init(ptdev);
>  
>  	return 0;


