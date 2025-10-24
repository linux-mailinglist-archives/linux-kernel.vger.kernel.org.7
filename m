Return-Path: <linux-kernel+bounces-868161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1A6C048A9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41D71A60CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847F3270552;
	Fri, 24 Oct 2025 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="etfvjaQv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BCB1E990E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761288217; cv=none; b=kAZ7vhu2jXb7vxH9iOynks6EgzueacYECrUd5wrGAWiizMdxLfSJlbiM8jOJJKhHdXt8jogrHo7qs1wnRQr8hb1spQz02iLdpY8AjFeyZb30lLh0trwzlZYL80t8q7rfTgEzcecoCgAgF2YUvPlaUEqU0g4HqkwdUcubfZz5Z/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761288217; c=relaxed/simple;
	bh=IbkdvNYR2kCJyPzBt28BRC+IBfhLd6Bj/NrNmn8Y4EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTJxQPY6naTb46ZoUobOrkvascrQyR3zIxq9EB+YNUGovodfDG9gUBI7xVyS3FMf73VVF0KeAfBcyDX7pVg22/16/f6aubXJkEmkD3Hui4S2Tm5gzNnpkPuayBwsh1UuR+veIZUlUA7sUA00pz0MPtemvSTZ0eK7jC2M8PRR94Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=etfvjaQv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761288214;
	bh=IbkdvNYR2kCJyPzBt28BRC+IBfhLd6Bj/NrNmn8Y4EQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=etfvjaQvpQUkHyjN+yZXLyL7RO5hXRg2yLZ0BmgNuRC2wQ1IZ306phpplQh9Ttii/
	 7ERQGs7zUZX0QoVHIc0dA8QKiK2cQfhqqb6lzDHLmvidl3R2PsGhh2dnFe1+OE5VAE
	 f3D6RTM9pCP2D0DgAApiET832nATRRByTCwLtTF0jzVpV0+ay2enxhpvMtgm+4GLr/
	 gsFIS6SXMTbYDM4XplpF+z9wW09MFcIcetz5nI9EO4eQYUTf7L+G+crVEuN0jrK41w
	 tiJGA7MCWNoLaOtSkKZSjtCrS6cx8cRH4T7z21+yUHLLBLuLdMAtU0GbTBwRoAJPkY
	 dwNxsaZ6QLYdg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8F1BD17E12DF;
	Fri, 24 Oct 2025 08:43:33 +0200 (CEST)
Date: Fri, 24 Oct 2025 08:43:27 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/10] drm/panthor: Introduce framework for
 architecture-specific features
Message-ID: <20251024084327.3332d548@fedora>
In-Reply-To: <20251014094337.1009601-4-karunika.choo@arm.com>
References: <20251014094337.1009601-1-karunika.choo@arm.com>
	<20251014094337.1009601-4-karunika.choo@arm.com>
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

On Tue, 14 Oct 2025 10:43:30 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> Add a framework to support architecture-specific features. This allows
> other parts of the driver to adjust their behaviour based on the feature
> bits enabled for a given architecture.

I'm not convinced we need this just yet. AFAICT, the only feature flag
being added in this patchset is PANTHOR_HW_FEATURE_PWR_CONTROL, and
most of this is abstracted away with function pointers already. The
only part that tests this FEATURE_PWR_CONTROL flag is the
initialization, which could very much be abstracted away with a
function pointer (NULL meaning no PWR block present). There might be
other use cases you're planning to use this for, so I'd like to hear
about them to make my final opinion on that.

> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_hw.c |  5 +++++
>  drivers/gpu/drm/panthor/panthor_hw.h | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index b6e7401327c3..34536526384d 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -186,3 +186,8 @@ int panthor_hw_init(struct panthor_device *ptdev)
>  
>  	return 0;
>  }
> +
> +bool panthor_hw_has_feature(struct panthor_device *ptdev, enum panthor_hw_feature feature)
> +{
> +	return test_bit(feature, ptdev->hw->features);
> +}
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index 39752de3e7ad..7a191e76aeec 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -4,14 +4,32 @@
>  #ifndef __PANTHOR_HW_H__
>  #define __PANTHOR_HW_H__
>  
> +#include <linux/types.h>
> +
>  struct panthor_device;
>  
> +/**
> + * enum panthor_hw_feature - Bit position of each HW feature
> + *
> + * Used to define GPU specific features based on the GPU architecture ID.
> + * New feature flags will be added with support for newer GPU architectures.
> + */
> +enum panthor_hw_feature {
> +	/** @PANTHOR_HW_FEATURES_END: Must be last. */
> +	PANTHOR_HW_FEATURES_END
> +};
> +
> +
>  /**
>   * struct panthor_hw - GPU specific register mapping and functions
>   */
>  struct panthor_hw {
> +	/** @features: Bitmap containing panthor_hw_feature */
> +	DECLARE_BITMAP(features, PANTHOR_HW_FEATURES_END);
>  };
>  
>  int panthor_hw_init(struct panthor_device *ptdev);
>  
> +bool panthor_hw_has_feature(struct panthor_device *ptdev, enum panthor_hw_feature feature);
> +
>  #endif /* __PANTHOR_HW_H__ */


