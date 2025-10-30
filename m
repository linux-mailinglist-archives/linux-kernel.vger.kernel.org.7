Return-Path: <linux-kernel+bounces-878539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B7EC20EE0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16E514EC5B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35485363B9E;
	Thu, 30 Oct 2025 15:28:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B711533F8AC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838121; cv=none; b=HuTzqri8+W12PanPHAvm0d0wzmukKBbUp4Wnpegm1r0NaZwOF48kUQ+6UvtF7bA4pRJOiirlxgtYzjRTNrXBhTidhHU7am8am2HfylBmDEZPALkw2fyp7tEPP2nXREV2uNIfCVodYkEeJy/JtCLKLBRxbm4uHcbi+d8batQ0KWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838121; c=relaxed/simple;
	bh=XHZMcK+5OSpCXFB1wFSnCNpApeCmcMqWLIl2TOiFHK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLIQx6xD6A6VKpihpCxHh8T3lDqddT03/7Y9IK15uKhcW+qdrmBH+7YG1Vws6ncgkeH1z7fb9k3tV1UwzbGlxLV8vb//zwuBx7Fmm7cf3J7wu4gA/aNJUyT1uQTnwoosF/y47/+kgjLR4oNrrYujF2vhmQUM472IEoHSb2lEn/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CF3E2C40
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:28:30 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F290E3F673
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:28:37 -0700 (PDT)
Date: Thu, 30 Oct 2025 15:28:33 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Rain Yang <jiyu.yang@oss.nxp.com>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, boris.brezillon@collabora.com,
	steven.price@arm.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, xianzhong.li@nxp.com,
	Rain Yang <jiyu.yang@nxp.com>,
	Prabhu Sundararaj <prabhu.sundararaj@nxp.com>
Subject: Re: [PATCH v3] drm/panthor: attach the driver's multiple power
 domains
Message-ID: <aQOEIdRM2yk0JhLt@e110455-lin.cambridge.arm.com>
References: <20251022092604.181752-1-jiyu.yang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251022092604.181752-1-jiyu.yang@oss.nxp.com>

On Wed, Oct 22, 2025 at 05:26:04PM +0800, Rain Yang wrote:
> From: Rain Yang <jiyu.yang@nxp.com>
> 
> Some platforms, such as i.MX95, utilize multiple power domains that need
> to be attached explicitly. This patch ensures that the driver properly
> attaches all available power domains using devm_pm_domain_attach_list().
> 
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Suggested-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Prabhu Sundararaj <prabhu.sundararaj@nxp.com>
> Signed-off-by: Rain Yang <jiyu.yang@nxp.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index f0b2da5b2b96..c39b9812eaa7 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -64,6 +64,16 @@ static int panthor_clk_init(struct panthor_device *ptdev)
>  	return 0;
>  }
>  
> +static int panthor_init_power(struct device *dev)
> +{
> +	struct dev_pm_domain_list  *pd_list = NULL;
> +
> +	if (dev->pm_domain)
> +		return 0;
> +
> +	return devm_pm_domain_attach_list(dev, NULL, &pd_list);
> +}
> +
>  void panthor_device_unplug(struct panthor_device *ptdev)
>  {
>  	/* This function can be called from two different path: the reset work
> @@ -218,6 +228,12 @@ int panthor_device_init(struct panthor_device *ptdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = panthor_init_power(ptdev->base.dev);
> +	if (ret < 0) {
> +		drm_err(&ptdev->base, "init power domains failed, ret=%d", ret);
> +		return ret;
> +	}
> +
>  	ret = panthor_devfreq_init(ptdev);
>  	if (ret)
>  		return ret;
> -- 
> 2.39.5
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

