Return-Path: <linux-kernel+bounces-846921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D16DBC96F1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0CC883446FE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BAD2EA165;
	Thu,  9 Oct 2025 14:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ED8590oe"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DBF23F422
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018909; cv=none; b=afEwIkfND3a2GmT87ghVG0+DCE1ohwIfcHFpMi2TVBhogcH4CkL9w5v4fIcRXz22N8H/ASsLakQQa2k3R/u1wX+35F4oYHPy332qD3MtmhwnZR7BRDKZwby/mpxjHFxjzHldqcpiy+9Y8Pv7Ja+qFaG4BrZjGFURR0LdqCc+DyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018909; c=relaxed/simple;
	bh=98imV8lVIGk8WyTK8tvGhNb5OZS/YSt24Kf6BNRUYh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuNNxvo549pbvjEJzLLAyuLpq7Sy9arCpT/B8W5AdbByzMD2vhlc6LxE110gEo9aRViVY3e4QVpckoLBiSUoJVlPd2a75F6MYBipdqigr987YKiFy3j0N+L3l+8zA7iWs5H6S/QeXIKlZrl5WB7p+ebzxT0hyUh9eC1Vrzz3rMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ED8590oe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760018905;
	bh=98imV8lVIGk8WyTK8tvGhNb5OZS/YSt24Kf6BNRUYh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ED8590oeT4HT+FpBMjy+Ea9QNtoh2UjrenScteN4Tn0y1DNiJ5BGtlY5Xc9QZykwF
	 Qt9u3HvVig+fCJzwXKemxkiEzZbechh5k5xoh8BP0su+qf+6jnfdQO1auZOCfWw6EJ
	 vqAKkpamcQrIBE+WsipIvUIbBZJN5moiqX8Xg1U5iRoL3rApzvYtehxi5uP8Udsfe8
	 2D/FEm+qYDXrvlPVfI2bj3Be0n3Piq4Cb9b6BEOrK9UWbaLwIOkxoHT0kn0gPLEEPX
	 HPEVCvpQthkSOvshCH8xVm4s1U6N8cZv6n/hxrgaMFk0gXFgzgLgY3keaERQshm+8X
	 83UiQ+mGXeBRA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E9E4D17E0CF8;
	Thu,  9 Oct 2025 16:08:24 +0200 (CEST)
Date: Thu, 9 Oct 2025 16:08:20 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Rain Yang <jiyu.yang@oss.nxp.com>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, steven.price@arm.com, liviu.dudau@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Rain Yang <jiyu.yang@nxp.com>, Prabhu
 Sundararaj <prabhu.sundararaj@nxp.com>
Subject: Re: [PATCH] drm/panthor: attach the driver's multiple power domains
Message-ID: <20251009160820.74f04ead@fedora>
In-Reply-To: <20251009140039.101189-1-jiyu.yang@oss.nxp.com>
References: <20251009140039.101189-1-jiyu.yang@oss.nxp.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Oct 2025 22:00:39 +0800
Rain Yang <jiyu.yang@oss.nxp.com> wrote:

> From: Rain Yang <jiyu.yang@nxp.com>
> 
> Some platforms, such as i.MX95, utilize multiple power domains that need
> to be attached explicitly. This patch ensures that the driver properly
> attaches all available power domains using devm_pm_domain_attach_list().
> 
> Signed-off-by: Prabhu Sundararaj <prabhu.sundararaj@nxp.com>
> Signed-off-by: Rain Yang <jiyu.yang@nxp.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 6 ++++++
>  drivers/gpu/drm/panthor/panthor_device.h | 2 ++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index f0b2da5b2b96..6f40d053b16c 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -218,6 +218,12 @@ int panthor_device_init(struct panthor_device *ptdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_pm_domain_attach_list(ptdev->base.dev, NULL, &ptdev->pd_list);
> +	if (ret < 0) {
> +		drm_err(&ptdev->base, "attach power domains failed, ret=%d", ret);
> +		return ret;
> +	}
> +
>  	ret = panthor_devfreq_init(ptdev);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 4fc7cf2aeed5..5ecb541ec67b 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -196,6 +196,8 @@ struct panthor_device {
>  		/** @recovery_needed: True when a resume attempt failed. */
>  		atomic_t recovery_needed;
>  	} pm;

Add a blank line here.

> +	/** @pm: Power management related data. */
> +	struct dev_pm_domain_list  *pd_list;
>  

Do we even need to keep the pd_list in panthor_device if we don't do
anything with it?

>  	/** @profile_mask: User-set profiling flags for job accounting. */
>  	u32 profile_mask;


