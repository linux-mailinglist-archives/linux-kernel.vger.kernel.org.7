Return-Path: <linux-kernel+bounces-869106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF08EC06F93
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2CEF1893236
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128B8326D4F;
	Fri, 24 Oct 2025 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXCS8wDW"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6731D742
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319682; cv=none; b=c9ahr+Zgcub1fCZiGyjnYPRYAX22knrsIK0rNhQUe92lONAgpsKq1ETjPIp0hq/zcJZqQNnLeonlpoBzd3ztYG6ricLZ+eGsd8zpGrSgA6iVNIQlL3LPuDugCy5qq/+FoSofpS+KfH70Y1S2rhs/0EiP1p5yNl6Yz1iFa9Rqgss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319682; c=relaxed/simple;
	bh=V0ye+jYnnU7DLxcZvpfHDeDTB6NQu4sOvjItidqGxhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMcrH4X2qPR272uvHlgD1IYhTPNH8us4uhF/yLv/sywvba7d4gXNv8GIcvbBNnHWmnsYSdyHNJxEwC+sOVDDKm7ECcwzM4fh/5AC5rQ4DIhRfWUQmdjL2ND5UOZLQ023Gwm9lN9yKKGNH5Pk8TbEpjNqxp9nq0p53Fv986D/Y5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXCS8wDW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4710665e7deso10809975e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761319679; x=1761924479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ztNfXSF1NkhyWiUsHRf36r0DXviZBccOSUgahHp2yUo=;
        b=AXCS8wDW6acPgg5WtzxUE/V84/wV4XbgmO1aSszul0WjTqbxwUjpvmHeQ0YNOj0Iv+
         KybnMiMYmEyJ0fgkJLUInYamoqgHdn+CNYIhp+t4BbJH+PdJc0cFB5iKSdVTFGBoBesK
         uP98IV0CxoW2I2Fx2w75J4MfMy+TAj5HsVUwygcLbpg97qyxoro3Jrdq3XDDxjh/lHvn
         enlozyHhi3n6cKI6LmEHrrQJb31dJQ5dEqMAlvGGn+bc860S7u0tKH/zyR/6M9pSkh34
         QsauX3eEWpNGzZZfUwe8Nx5zWSWCnG/JHCYBgS0RZbb0f+bOSlCMfb8A0CJllZroH6D9
         BfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761319679; x=1761924479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztNfXSF1NkhyWiUsHRf36r0DXviZBccOSUgahHp2yUo=;
        b=xEK34yTE8Gd/nXUaFmLZPrGCCLb2fWebi5++afBtUaafwtxy9Ny4/ouZiur4kWJZrY
         TthoU18tf75SfXpdy78Ql7lnvpfJowUwTcKT0tAwA82IiXSq6G9wjLR4M4Z4aScZTwzk
         6ROCq4jT7aumhQbgi5MGFaOM7SREerzbOUdLVRBWvou4EMAOBCJOrQug6rEMz65GBfCz
         J971vvT8vkyIB15eKmwvi+41DbNHpGUa+BdZnujNEoBax6XOx7vBxJTUUSSHL5RKQsO0
         xUOnyEEeEMC4a7pKNtUCe4br60QPBlBrTC1c3GyzzsWrFyTpC5ubxNSb8zUDUTGBl0co
         sIMg==
X-Forwarded-Encrypted: i=1; AJvYcCXuPSKjI1EyFXFeca1UDbHgdLgLNESAZJpKYWeRb7nkEI10I9HodtS6bRgStVfBphRURKJ4FaE+0E9Fykw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gwszboQaBNJ57vJX4fpHEkwEh1G2IX7K14p0Ih005ZRFD/Sr
	JRoXdk71RCtfom1gMBsxTfHTsafUDiStkIe45Ak0VdvjEvV5vol63bXG
X-Gm-Gg: ASbGncuNY3hyolI6xM43Rx+Gf0shWC8/gF3xBFuTih1h2wxc633GYZXeNe+OgYFTt7w
	FvoMWNMdNGBzK/y0gC4hSCBAF9O2LoKxrNUOoX/RIvZhcH2BIYYo4wr5qe59ZO6gJjBjN1uHXoC
	7U4o1htZMbBKgZix2sOrHdunhAgTc5tvxl5ZFJaf7F1pnpvWwTudkXw2uscEZ608Jx7mJTXZ3xf
	J1k1LZlgOv0d/0tkAs+uW5WVaggkQhkCEbN3oPgYXh7FA4RFj84bWlhivzyZ2uw2hRBwEQGKaif
	ZbpBohseiyPIVWzcYb0wl/+esUz56Bknzc75g2VQgvkuKW7kuV1A9/kxTcB4LV5Z7TK95y94Pys
	roYIPSuuPbVn72kWByMeBltoMITbRzIu7u7A983i1Vawg7sdvh05sovj41EasSdi1IX+2sasPSD
	y78ba7i3E8Dw==
X-Google-Smtp-Source: AGHT+IGLdAA7lW07FJwzdHpunnfAEeHs0j7e6oglL+ICYvhCaN8vtsYMA6YmlpmQQt67WQJiySD2Xg==
X-Received: by 2002:a05:6000:40e0:b0:426:d630:52b7 with SMTP id ffacd0b85a97d-42989edb584mr4809131f8f.0.1761319678541;
        Fri, 24 Oct 2025 08:27:58 -0700 (PDT)
Received: from fedora ([37.29.213.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898cceebsm9854782f8f.37.2025.10.24.08.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:27:58 -0700 (PDT)
Date: Fri, 24 Oct 2025 17:27:55 +0200
From: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Melissa Wen <melissa.srw@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	victoria@system76.com, sebastian.wick@redhat.com,
	thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 08/22] drm/vkms: Introduce configfs for plane color range
Message-ID: <aPua-4yt_rMtRCAp@fedora>
References: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
 <20251018-vkms-all-config-v1-8-a7760755d92d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018-vkms-all-config-v1-8-a7760755d92d@bootlin.com>

On Sat, Oct 18, 2025 at 04:01:08AM +0200, Louis Chauvet wrote:
> To allows the userspace to test many hardware configuration, introduce a
> new interface to configure the available color ranges per planes. VKMS
> supports multiple color ranges, so the userspace can choose any
> combination.
> 
> The supported color ranges are configured by writing a color range bitmask
> to the file `supported_color_ranges` and the default color range is
> chosen by writing a color encoding bitmask to `default_color_range`.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  Documentation/gpu/vkms.rst           |  7 ++-
>  drivers/gpu/drm/vkms/vkms_configfs.c | 93 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index 4ff75b53a386..979f8a545498 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -87,7 +87,7 @@ Start by creating one or more planes::
>  
>    sudo mkdir /config/vkms/my-vkms/planes/plane0
>  
> -Planes have 5 configurable attribute:
> +Planes have 7 configurable attribute:
>  
>  - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
>    exposed by the "type" property of a plane)
> @@ -101,6 +101,11 @@ Planes have 5 configurable attribute:
>    by the COLOR_ENCODING property of a plane)
>  - default_color_encoding: Default color encoding presented to the userspace, same
>    values as supported_color_encoding
> +- supported_color_range: Available color range for a plane, as a bitmask:
> +  0x1 DRM_COLOR_YCBCR_LIMITED_RANGE, 0x2 DRM_COLOR_YCBCR_FULL_RANGE (same values as
> +  those exposed by the COLOR_RANGE property of a plane)
> +- default_color_range: Default color range presented to the userspace, same
> +  values as supported_color_range
>  
>  Continue by creating one or more CRTCs::
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index a4e0e054cf2d..0b280c73b0cc 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -412,6 +412,95 @@ static ssize_t plane_default_rotation_store(struct config_item *item,
>  	return count;
>  }
>  
> +static ssize_t plane_supported_color_range_show(struct config_item *item, char *page)
> +{
> +	struct vkms_configfs_plane *plane;
> +	unsigned int supported_color_range;
> +
> +	plane = plane_item_to_vkms_configfs_plane(item);
> +
> +	scoped_guard(mutex, &plane->dev->lock) {
> +		supported_color_range = vkms_config_plane_get_supported_color_range(plane->config);
> +	}
> +
> +	return sprintf(page, "%u", supported_color_range);
> +}
> +
> +static ssize_t plane_supported_color_range_store(struct config_item *item,
> +						 const char *page, size_t count)
> +{
> +	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
> +	int ret, val = 0;
> +
> +	ret = kstrtouint(page, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Should be a supported value */
> +	if (val & ~(BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
> +		    BIT(DRM_COLOR_YCBCR_FULL_RANGE)))
> +		return -EINVAL;
> +	/* Should at least provide one color range */
> +	if ((val & (BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
> +		    BIT(DRM_COLOR_YCBCR_FULL_RANGE))) == 0)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &plane->dev->lock) {
> +		/* Ensures that the default rotation is included in supported rotation */
> +		if (plane->dev->enabled ||
> +		    (val & vkms_config_plane_get_default_color_range(plane->config)) !=
> +		     vkms_config_plane_get_default_color_range(plane->config))
> +			return -EINVAL;
> +		vkms_config_plane_set_supported_color_range(plane->config, val);
> +	}
> +
> +	return count;
> +}
> +
> +static ssize_t plane_default_color_range_show(struct config_item *item, char *page)
> +{
> +	struct vkms_configfs_plane *plane;
> +	unsigned int default_color_range;
> +
> +	plane = plane_item_to_vkms_configfs_plane(item);
> +
> +	scoped_guard(mutex, &plane->dev->lock)
> +		default_color_range = vkms_config_plane_get_default_color_range(plane->config);
> +
> +	return sprintf(page, "%u", default_color_range);
> +}
> +
> +static ssize_t plane_default_color_range_store(struct config_item *item,
> +					       const char *page, size_t count)
> +{
> +	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
> +	int ret, val = 0;
> +
> +	ret = kstrtouint(page, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Should be a supported value */
> +	if (val & ~(BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
> +		    BIT(DRM_COLOR_YCBCR_FULL_RANGE)))
> +		return -EINVAL;
> +	/* Should at least provide one color range */
> +	if ((val & (BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
> +		    BIT(DRM_COLOR_YCBCR_FULL_RANGE))) == 0)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &plane->dev->lock) {
> +		/* Ensures that the default rotation is included in supported rotation */
> +		if (plane->dev->enabled ||
> +		    (val & vkms_config_plane_get_supported_color_range(plane->config)) !=
> +		     val)
> +			return -EINVAL;
> +		vkms_config_plane_set_default_color_range(plane->config, val);

Same comment about the validation here.

> +	}
> +
> +	return count;
> +}
> +
>  static ssize_t plane_supported_color_encoding_show(struct config_item *item, char *page)
>  {
>  	struct vkms_configfs_plane *plane;
> @@ -513,6 +602,8 @@ static ssize_t plane_default_color_encoding_store(struct config_item *item,
>  CONFIGFS_ATTR(plane_, type);
>  CONFIGFS_ATTR(plane_, supported_rotations);
>  CONFIGFS_ATTR(plane_, default_rotation);
> +CONFIGFS_ATTR(plane_, supported_color_range);
> +CONFIGFS_ATTR(plane_, default_color_range);

And the mixed use of singular and plural for supported_*.

>  CONFIGFS_ATTR(plane_, supported_color_encoding);
>  CONFIGFS_ATTR(plane_, default_color_encoding);
>  
> @@ -520,6 +611,8 @@ static struct configfs_attribute *plane_item_attrs[] = {
>  	&plane_attr_type,
>  	&plane_attr_supported_rotations,
>  	&plane_attr_default_rotation,
> +	&plane_attr_supported_color_range,
> +	&plane_attr_default_color_range,
>  	&plane_attr_supported_color_encoding,
>  	&plane_attr_default_color_encoding,
>  	NULL,
> 
> -- 
> 2.51.0
> 

