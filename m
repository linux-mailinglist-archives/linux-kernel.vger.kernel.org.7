Return-Path: <linux-kernel+bounces-801140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ADFB4404F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62FEAA06BE9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6255A21257E;
	Thu,  4 Sep 2025 15:16:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0FA27442
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999018; cv=none; b=kGw5I9RjSe6nEYF9WggT0gnMcGWSE8fGBDOXR98hTYeAu0P9J2mJTNpLADAUgzbTe/PLRDH6599pxpHmAbXt/fclqDeRiT3AIS/tmOBQmq1+RuzVW0aczC97EQUPuYVQEVRtxmmHu25MTx0OiRdvfWkfmUmg2weJDw/lMaHP/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999018; c=relaxed/simple;
	bh=+HJW9cLAWYwOXNO+TnoAuKFDjh7OTpYhpmHW22+JXSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=vBYbYF47ftTT9wuoFdM65OeSbj+xtt8LMaCC+pH/Xn/uJM/phRyda6HwMt/3rV+ejDZRxASM6b21xw7ar0EgRoxvFUGXLEBSq0F3bCb7g8grsTt7gNSObnZPDCXu2Jj5LASzNxaESUnB8Udi6SlkTwpXbbzTI1/nLyD+KdDB1dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A94D339;
	Thu,  4 Sep 2025 08:16:48 -0700 (PDT)
Received: from [10.1.25.55] (e122027.cambridge.arm.com [10.1.25.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D57A3F6A8;
	Thu,  4 Sep 2025 08:16:54 -0700 (PDT)
Message-ID: <7a5be556-89ee-420c-96d7-129be6808137@arm.com>
Date: Thu, 4 Sep 2025 16:16:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: validate group queue count
To: Chia-I Wu <olvaffe@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250903192133.288477-1-olvaffe@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250903192133.288477-1-olvaffe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/09/2025 20:21, Chia-I Wu wrote:
> A panthor group can have at most MAX_CS_PER_CSG panthor queues.
> 
> Fixes: 4bdca11507928 ("drm/panthor: Add the driver frontend block")
> Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com> # v1
> Reviewed-by: Steven Price <steven.price@arm.com>

Pushed to drm-misc-fixes.

Thanks,
Steve

> 
> ---
> v2:
>  - move validation up to panthor_ioctl_group_create
>  - add Fixes tag
> ---
>  drivers/gpu/drm/panthor/panthor_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index 9256806eb6623..4c202fc5ce050 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1094,7 +1094,7 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
>  	struct drm_panthor_queue_create *queue_args;
>  	int ret;
>  
> -	if (!args->queues.count)
> +	if (!args->queues.count || args->queues.count > MAX_CS_PER_CSG)
>  		return -EINVAL;
>  
>  	ret = PANTHOR_UOBJ_GET_ARRAY(queue_args, &args->queues);


