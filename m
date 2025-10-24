Return-Path: <linux-kernel+bounces-869043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6419C06C96
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46CAD35C5AC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35B724E4BD;
	Fri, 24 Oct 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJj/RkKq"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02084225A3D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317424; cv=none; b=Ccpv9Ko6MW4THs+Bf1veanQ+fHngp7cLkNFrOLiIuCpdYl6GSr8Vja16KsItFznR90YhIdQ7ywWqHU2jHJMJ7YqmQQO0VwUEVSclb0xnnT8d2cnzIGIrm6WgTwAy9csmd7B5jkZuZkepLga88/ipWr6jC/DQnzHRWfMigaxehM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317424; c=relaxed/simple;
	bh=YpmedxoHX103GRZLyFK655XyMWlbKvpw7Z5efNSETFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9XIgyap0Clwm5PgIZjeYJ0/PaVg6q9FUlACRJu0PvFwvlG9xhFEQXA4WK3W+XmxXo8/Ob+vjxb3PnI0HkNKAaGGHTCJyLwvYpPIuca/I9qtUfIFpqekdIp+li4xE236NPbisdydITLjBO1iJUpwXn/7DPxPCaAM1hrWiYwh2yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJj/RkKq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475dab5a5acso494085e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761317420; x=1761922220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bvkZR2Vh4Krn1ke+GLvqfOD39dvZoqg79ZqoUlC3wn8=;
        b=VJj/RkKqNecPxwa2IiIGV55ONmphLi1WCgxj2DCBhVPGXXkp3+fbFfCfBlWUfww6Dp
         r44MFvmfVnl3QHDj2Z6gh/6O1cP8lnvxH8ca5EsRNxB/PDDrQm495UnXEPliE6W496Sh
         3DIds84tllHlnZF20/QmcXxAOuYkX3kh7Vqo0CZ+AUk56lqVW2qZnGvIbC27mevXdE+k
         s1zDQXfT2ho7K3LVwiMjC0CeN0gh3PRuzLln4MFoNXWTfB3tuHe8K2BgwGuO7fJxXrvq
         Si/hi3kUCuQZGIQts4elPd/u+y1WktUATBE/Xn9O1WWupOPQsT2HCPGr8yLsZvF1ofr7
         nD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317420; x=1761922220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvkZR2Vh4Krn1ke+GLvqfOD39dvZoqg79ZqoUlC3wn8=;
        b=ZWE/pLvWLmXIttBm/3WSlI1hPQDAznyd6P7XW8J25Jd2R+0LsDznfLBxAmpq2x02DO
         JrI/czCAzK+FvIRWiX6/yspCulraVPZTvqXl9bIBdZTfUeK+xdpZT32z73H9NGDKbQ02
         qhs53V8dara+/XYyeX9Oa/dAorwEyyNzscERS+LmYU7BJF/gkqYJLn5BBfYr+mz1MIVP
         Xt6WtlXhdXZSX3RdtDYTeRK0Ac+9zndxW+NFwBziTfyIm6/9Cfqs/j99PT6yYtdTOwBf
         8hAIW0OLf7upElPWTRnvLZoB/J/OCnCzI2lHhaeNxHO6rOIrAy76631JzdnnFw6mKUBo
         WGSw==
X-Forwarded-Encrypted: i=1; AJvYcCVp0VRbKqAugVqPP5caV1itl+854HFCNNReZsaSk5RBO3DZBSAQ68JfWA61z+HG9NnZsbhlVfUYrWdERL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH1L2E8gou0ePJof8C9hAkWGpzbAJ/VfDphM0vGELTyXYqJ2Vw
	KOK57EzYkBlBXhTUscUuPAv5ns5WGkEz/uLKrdDkePuHZHZ+7oj7+lyoCWI4ioDq
X-Gm-Gg: ASbGncstLt2T7Nz2Z/d4hLV9NjnqhhLD7hLyhqy0z7hsxJwGhg89XDbleyQF+kYB3zi
	42CAFIUcBmdTvL8XevOUBnmsNhKYbrrlAJG1tI8M/Hnwm0smkrwhbvTHUPamO/mv9tf7tPsOVtW
	mEoT9SAIOfCrRzeoPKB0JoB9LE/N7rz3vMPYoTd9+bELDhRscPHXJbBhogA73BmAa+fUp+h0ISI
	NnJzya7sbY5aYwTPuZOhv5bCCe6syAvVAxWvNMmunNz4KoTS7COSkdGsCrDDf/jbnG4UOkRGgkb
	iJ9bDEweu9gu5ztF9Lmy8eOcfrcVKF+F3TH+cLX3IGTK1BPAiKQsp3xk+llsoI2Onpo9IhbSQcj
	QVyPVv5q49IfYwTyQ2K8KKjobqt7u9bwJZkvkjoJvXQXNg3c9rXCHB8qd6sNEqyF462sL4rdwdL
	8=
X-Google-Smtp-Source: AGHT+IEqlFHh9cUmE6VeJkHTqoWYwUa2BjE3Cj5kkfpXYdD2XEHiKMq5M8rg1Ncamom4v1KrbdbmNw==
X-Received: by 2002:a05:600c:3b05:b0:471:d13:5762 with SMTP id 5b1f17b1804b1-471178761bemr206849505e9.4.1761317419995;
        Fri, 24 Oct 2025 07:50:19 -0700 (PDT)
Received: from fedora ([37.29.213.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf15416sm95153355e9.10.2025.10.24.07.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:50:19 -0700 (PDT)
Date: Fri, 24 Oct 2025 16:50:16 +0200
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
Subject: Re: [PATCH 04/22] drm/vkms: Introduce configfs for plane rotation
Message-ID: <aPuSKCNRGRCLDwyp@fedora>
References: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
 <20251018-vkms-all-config-v1-4-a7760755d92d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251018-vkms-all-config-v1-4-a7760755d92d@bootlin.com>

On Sat, Oct 18, 2025 at 04:01:04AM +0200, Louis Chauvet wrote:
> To allows the userspace to test many hardware configuration, introduce a
> new interface to configure the available rotation per planes. VKMS
> supports any rotation and reflection, so the userspace can choose any
> combination.
> 
> The supported rotations are configured by writing a rotation bitmask to
> the file `supported_rotations` and the default rotation is chosen by
> writing a rotation bitmask to `default_rotation`.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  Documentation/gpu/vkms.rst           |  7 ++-
>  drivers/gpu/drm/vkms/vkms_configfs.c | 94 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 100 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
> index 3574e01b928d..a432968cc711 100644
> --- a/Documentation/gpu/vkms.rst
> +++ b/Documentation/gpu/vkms.rst
> @@ -87,10 +87,15 @@ Start by creating one or more planes::
>  
>    sudo mkdir /config/vkms/my-vkms/planes/plane0
>  
> -Planes have 1 configurable attribute:
> +Planes have 3 configurable attribute:

s/attribute/attributes/

>  
>  - type: Plane type: 0 overlay, 1 primary, 2 cursor (same values as those
>    exposed by the "type" property of a plane)
> +- possible_rotations: Available rotation for a plane, as a bitmask: 0x01 no rotation,
> +  0x02 rotate 90°, 0x04 rotate 180°, 0x08 rotate 270°, 0x10 reflect x, 0x20 reflect y
> +  (same values as those exposed by the "rotation" property of a plane)
> +- default_rotation: Default rotation presented to the userspace, same values as
> +  possible_rotations.
>  
>  Continue by creating one or more CRTCs::
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
> index ea245e2e2fd2..450e45e66a45 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -322,10 +322,104 @@ static ssize_t plane_type_store(struct config_item *item, const char *page,
>  	return (ssize_t)count;
>  }
>  
> +static ssize_t plane_supported_rotations_show(struct config_item *item, char *page)
> +{
> +	struct vkms_configfs_plane *plane;
> +	unsigned int plane_supported_rotations;
> +
> +	plane = plane_item_to_vkms_configfs_plane(item);
> +
> +	scoped_guard(mutex, &plane->dev->lock) {
> +		plane_supported_rotations = vkms_config_plane_get_supported_rotations(plane->config);

Checkpatch is complaining about this line being 1 character longer than
it should... Feel free to ignore it:

WARNING: line length of 101 exceeds 100 columns
#58: FILE: drivers/gpu/drm/vkms/vkms_configfs.c:333:
+               plane_supported_rotations = vkms_config_plane_get_supported_rotations(plane->config);


> +	}
> +
> +	return sprintf(page, "%u", plane_supported_rotations);
> +}
> +
> +static ssize_t plane_supported_rotations_store(struct config_item *item,
> +					       const char *page, size_t count)
> +{
> +	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
> +	int ret, val = 0;
> +
> +	ret = kstrtouint(page, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Should be a supported value */
> +	if (val & ~(DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK))
> +		return -EINVAL;
> +	/* Should at least provide one rotation */
> +	if (!(val & DRM_MODE_ROTATE_MASK))
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &plane->dev->lock) {
> +		/* Ensures that the default rotation is included in supported rotation */
> +		if (plane->dev->enabled ||
> +		    (val & vkms_config_plane_get_default_rotation(plane->config)) !=
> +		     vkms_config_plane_get_default_rotation(plane->config))
> +			return -EINVAL;

This makes a bit difficult to change the default supported rotations.

By default, default rotation is DRM_MODE_ROTATE_0. If the user wants to set the
supported rotations to DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y | DRM_MODE_ROTATE_90,
this will fail because the default rotation is not included in the new set of
supported rotations.

Therefore, the user would need to add DRM_MODE_ROTATE_0 (DRM_MODE_REFLECT_X |
DRM_MODE_REFLECT_Y | DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_0), change the default rotation
to DRM_MODE_ROTATE_90 and drop DRM_MODE_ROTATE_0 from the supported rotations.

To avoid this, I think we should check this before enabling the device instead,
in vkms_config_is_valid().

Also, having this logic as a helper called by vkms_config_is_valid() allows to
add a KUnit test to make sure all cases are covered.

What do you think?


> +		vkms_config_plane_set_supported_rotations(plane->config, val);
> +	}
> +
> +	return count;
> +}
> +
> +static ssize_t plane_default_rotation_show(struct config_item *item, char *page)
> +{
> +	struct vkms_configfs_plane *plane;
> +	unsigned int plane_default_rotation;
> +
> +	plane = plane_item_to_vkms_configfs_plane(item);
> +
> +	scoped_guard(mutex, &plane->dev->lock) {
> +		plane_default_rotation = vkms_config_plane_get_default_rotation(plane->config);
> +	}
> +
> +	return sprintf(page, "%u", plane_default_rotation);
> +}
> +
> +static ssize_t plane_default_rotation_store(struct config_item *item,
> +					    const char *page, size_t count)
> +{
> +	struct vkms_configfs_plane *plane = plane_item_to_vkms_configfs_plane(item);
> +	int ret, val = 0;
> +
> +	ret = kstrtouint(page, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Should be a supported value */
> +	if (val & ~(DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK))
> +		return -EINVAL;
> +	/* Should at least provide one rotation */
> +	if ((val & DRM_MODE_ROTATE_MASK) == 0)
> +		return -EINVAL;
> +	/* Should contains only one rotation */
> +	if (!is_power_of_2(val & DRM_MODE_ROTATE_MASK))
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &plane->dev->lock) {
> +		/* Ensures that the default rotation is included in supported rotation */
> +		if (plane->dev->enabled ||
> +		    (val & vkms_config_plane_get_supported_rotations(plane->config)) != val)
> +			return -EINVAL;
> +
> +		vkms_config_plane_set_default_rotation(plane->config, val);
> +	}
> +
> +	return count;
> +}
> +
>  CONFIGFS_ATTR(plane_, type);
> +CONFIGFS_ATTR(plane_, supported_rotations);
> +CONFIGFS_ATTR(plane_, default_rotation);
>  
>  static struct configfs_attribute *plane_item_attrs[] = {
>  	&plane_attr_type,
> +	&plane_attr_supported_rotations,
> +	&plane_attr_default_rotation,
>  	NULL,
>  };
>  
> 
> -- 
> 2.51.0
> 

