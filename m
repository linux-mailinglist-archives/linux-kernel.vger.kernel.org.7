Return-Path: <linux-kernel+bounces-824316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA90B88A38
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA25163231
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0BA2EFDBA;
	Fri, 19 Sep 2025 09:46:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8BB19D880
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275188; cv=none; b=P2/U04ix2S1j+pd7n8Hlvq8JEMtIdiWL2PMrsZCkAkNMdqGhQ8CMoSxVlo26n0BC3F81Vf5nZTcPltVhhyIHKMyHZ+YML0SrRQmiSOpeQNpd8ElljqDVLx0kds5iMPaqTjJ+AXSULalv1oZAQA+++9wodFiM1+djxNUO+Szde04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275188; c=relaxed/simple;
	bh=e09q5XFvjtzccVocqXaGgwEjz92VKs5YavBjorGoI2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZApxxNBv2rGJY//iG3HuHYiJQHBNnS/F9R5JORhzAKhp1/gMr08jJfK2aEEZTTLH8++ccwWwBaS15S1qYyLeKEi4/kSOeLxAIEh43Y75wIxLuF4KpE3cxZJkeq0rCVaGavUUvgMaaXRsd77vce0fn1vaVak6Jtl2NtdduTjQhYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6022D2F;
	Fri, 19 Sep 2025 02:46:12 -0700 (PDT)
Received: from [10.57.5.234] (unknown [10.57.5.234])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1E163F66E;
	Fri, 19 Sep 2025 02:46:19 -0700 (PDT)
Message-ID: <945085cb-ccfb-498f-b25e-d95f7627d78a@arm.com>
Date: Fri, 19 Sep 2025 10:46:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Bump the minor version number
To: Boris Brezillon <boris.brezillon@collabora.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250919080700.3949393-1-steven.price@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250919080700.3949393-1-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/09/2025 09:07, Steven Price wrote:
> Commit a017f7b86051 ("drm/panfrost: Expose JM context IOCTLs to UM")
> added new ioctls to the driver and was meant to bump the version number.
> However it actually only added a comment and didn't change the exposed
> version number. Bump the number to be consistent with the comment.
> 
> Fixes: a017f7b86051 ("drm/panfrost: Expose JM context IOCTLs to UM")
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Steven Price <steven.price@arm.com>

Pushed to drm-misc-next.

Thanks,
Steve

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 3af4b4753ca4..22350ce8a08f 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -853,7 +853,7 @@ static const struct drm_driver panfrost_drm_driver = {
>  	.name			= "panfrost",
>  	.desc			= "panfrost DRM",
>  	.major			= 1,
> -	.minor			= 4,
> +	.minor			= 5,
>  
>  	.gem_create_object	= panfrost_gem_create_object,
>  	.gem_prime_import_sg_table = panfrost_gem_prime_import_sg_table,


