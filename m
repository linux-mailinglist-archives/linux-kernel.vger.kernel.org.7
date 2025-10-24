Return-Path: <linux-kernel+bounces-869128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E31FC070B3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184FF3B8188
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA2732AAAC;
	Fri, 24 Oct 2025 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/Au3lH2"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D5314D2D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320657; cv=none; b=rCE8fU1TC/LZE26lC6S0nKrp1wTGY6ydeRWTYdc1yLP2CvHTD43d7OV3CnJ1L2T8Sx+qsepLn96a6Nwxe8Qs9PJuQtCQsOt/cluUU4HlXgqjLBJfjKjCncn/SnnDtx9MERd2hy3SGUxi57cBf7Ce37IBoGEX5P7IV+KQzUAHH5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320657; c=relaxed/simple;
	bh=OI5Mcwha4880QnYvaFHSmXPNmsViH6T7b40yOsLYZrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnM/8q8NS2t6MYQ8+XUbagAPEzyKtTUVu3jCbVp2Pcb4xA7PN5y/8lD8XEe7wUmUAhaX4LD7YnF0tLAw2DY9FEX2f6bi2KYsJsl53QSpzvhCDLRYRjt2vNDyzQzN3xqQKxdHkY/7X9ZtEaRieSavCV6kdRYdMl7mNRNVh9mxgyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/Au3lH2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47117e75258so16620945e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761320653; x=1761925453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HyFrzmD5VGIhCjgUJBbHgOpCz5hf6OpkpWtoCO82QTo=;
        b=X/Au3lH2Phc7aYqhx7IhhWVjWy2swtpe0xzbNbMqgms5nLMDA5EFjrIOc/WmLUAnZr
         ww/x6uyOzhRbPTCMViX59gjocUt0F8jvVIAJ5/cC+SDWkwfGujt54WjHT+Cs+wxRhBvM
         x++smsdJpcCgpU32m3sdP4aLddJxLDazY6+1PXV9CXBfmxf/6tSNwnY98f1D2Hg8m02D
         yjcTcS/bTcWydZNxZw0dFKIGJwSC4cufwIja0cIXVmO31k5Lzm7faI8rp0KiA+4fMCRC
         hdmSHpYwiP33XFttPhVZdI1QWelXXNZCymTesDDG9KGevwk8hkP4rvdPOAb7WhPeu5T3
         kymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761320653; x=1761925453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyFrzmD5VGIhCjgUJBbHgOpCz5hf6OpkpWtoCO82QTo=;
        b=IbeheYT9tYlQUq/ookk5rss6irUb9YFjQfzWKDQU4RqArXqJ++6mGrpBuVG13bOMvv
         Bp8X2e+ov4BCdabca+4MztH7VOqwVlP0GtstBgZiR5iy6MhKy3VVv/xs4/FLlku+9AFJ
         OUAdCwPQWbHzYJa/0yYY4w9MUi7jAXHo/gkz4L9BzJjSoPhkhasKoNCZWPWQiwZpi0Ho
         qZ2HplkUvVvNV3MgL9YxGpAy/ktMxYCBodTS8h1opMhzSH+y2/9yO64LsvaxNRtIxL/C
         6juMsUnCpjSplhjAAysbe3NgjR8GKuP+4hXcaCuSC5rQy+SF2UM0jt+EqhasBeFqdgNF
         E9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG+9IEo0hIwkfrWRBUOINlaKH/J5RCjTXECSmcYh3KJhEdx8eKWW/bPsMGzqVuQ8j6WyETJaCGjaCDmUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr8slttzjc9sCIp8LCfJs9+tuWaaEXhZf4M8Q2iwLbuUjB15jH
	hUnoIRnLjqITJ6T2m1LMeJ4FsWaS/1O+q8IYJYw4y3mWjyvoTEG35Ry/
X-Gm-Gg: ASbGncv2ijICB0/HU9ibR62hT8FSZMld8cKHAOzUQJN1Aos2D0EdAgQOPqwnbalzXNe
	bfcI/3hqH+SO/+ALwGVlWcrHkgR2TR4yZb+6w1luYgmdbM3It/1dITOHB3yInmzomfhL2VoYxLA
	PHnCJX5/80vGd9VZKsppNTfX45PG/95Gzo/wBIO/nDTYdQHggHPU2j6RwWStpWLW0VUnIWmvVR3
	sN/syWFt5vB4xT2llDGviv3mqc36BzKb+I++J+1UqKEw0dQw5tV5Q5+bhMQ09OQA0bEQpXuw76K
	+YbwDqqlSDV/lPMMtGGQWXaNvGp8wtV/nxrWdg0Zf1N2htQl6yDsf5av1hXUu3iYY7wwyo/xmFf
	yGvd8Gk3Dn9/mrhVdqYVdPJF9tShPlSHBiMjEBaOOwY0JDLe7D2TwHUetP+6N/LURsj532JGpX1
	ijWwBNK3D25KVjYve415cp
X-Google-Smtp-Source: AGHT+IEubgG8lezOHzEid79A6EvcYG46QmDmuwMeFGV3CQH5ZDkGrXl7VIXkJVqTpBwwQDK5w3yMwQ==
X-Received: by 2002:a5d:64c4:0:b0:428:3cd7:a340 with SMTP id ffacd0b85a97d-4298a0a9602mr4884639f8f.35.1761320652968;
        Fri, 24 Oct 2025 08:44:12 -0700 (PDT)
Received: from fedora ([37.29.213.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ed13fsm9876155f8f.44.2025.10.24.08.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:44:12 -0700 (PDT)
Date: Fri, 24 Oct 2025 17:44:09 +0200
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
Subject: Re: [PATCH 09/22] drm/vkms: Introduce config for plane format
Message-ID: <aPueydZ1bdmEQ8VE@fedora>
References: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
 <20251018-vkms-all-config-v1-9-a7760755d92d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018-vkms-all-config-v1-9-a7760755d92d@bootlin.com>

On Sat, Oct 18, 2025 at 04:01:09AM +0200, Louis Chauvet wrote:
> VKMS driver supports all the pixel formats for planes, but for testing it
> can be useful to only advertise few of them. This new configuration
> interface will allow configuring the pixel format per planes.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c | 99 ++++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_config.h | 49 +++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_plane.c  | 39 +--------------
>  3 files changed, 150 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index 8f00ca21ed6e..0b975a0d47aa 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -8,6 +8,42 @@
>  
>  #include "vkms_config.h"
>  
> +static const u32 vkms_supported_plane_formats[] = {
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_BGRA8888,
> +	DRM_FORMAT_RGBA8888,
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_RGB888,
> +	DRM_FORMAT_BGR888,
> +	DRM_FORMAT_XRGB16161616,
> +	DRM_FORMAT_XBGR16161616,
> +	DRM_FORMAT_ARGB16161616,
> +	DRM_FORMAT_ABGR16161616,
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_BGR565,
> +	DRM_FORMAT_NV12,
> +	DRM_FORMAT_NV16,
> +	DRM_FORMAT_NV24,
> +	DRM_FORMAT_NV21,
> +	DRM_FORMAT_NV61,
> +	DRM_FORMAT_NV42,
> +	DRM_FORMAT_YUV420,
> +	DRM_FORMAT_YUV422,
> +	DRM_FORMAT_YUV444,
> +	DRM_FORMAT_YVU420,
> +	DRM_FORMAT_YVU422,
> +	DRM_FORMAT_YVU444,
> +	DRM_FORMAT_P010,
> +	DRM_FORMAT_P012,
> +	DRM_FORMAT_P016,
> +	DRM_FORMAT_R1,
> +	DRM_FORMAT_R2,
> +	DRM_FORMAT_R4,
> +	DRM_FORMAT_R8,
> +};
> +
>  struct vkms_config *vkms_config_create(const char *dev_name)
>  {
>  	struct vkms_config *config;
> @@ -435,6 +471,11 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
>  	if (!plane_cfg)
>  		return ERR_PTR(-ENOMEM);
>  
> +	if (vkms_config_plane_add_all_formats(plane_cfg)) {
> +		kfree(plane_cfg);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
>  	plane_cfg->config = config;
>  	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_OVERLAY);
>  	vkms_config_plane_set_name(plane_cfg, NULL);
> @@ -563,6 +604,64 @@ static struct vkms_config_plane *vkms_config_crtc_get_plane(const struct vkms_co
>  	return NULL;
>  }
>  
> +int __must_check vkms_config_plane_add_all_formats(struct vkms_config_plane *plane_cfg)
> +{
> +	u32 *ret = krealloc_array(plane_cfg->supported_formats,
> +				  ARRAY_SIZE(vkms_supported_plane_formats),
> +				  sizeof(uint32_t), GFP_KERNEL);
> +	if (!ret)
> +		return -ENOMEM;
> +	plane_cfg->supported_formats = ret;
> +
> +	memcpy(plane_cfg->supported_formats, vkms_supported_plane_formats,
> +	       sizeof(vkms_supported_plane_formats));
> +	plane_cfg->supported_formats_count = ARRAY_SIZE(vkms_supported_plane_formats);
> +	return 0;
> +}
> +
> +int __must_check vkms_config_plane_add_format(struct vkms_config_plane *plane_cfg, u32 drm_format)
> +{
> +	bool found = false;
> +
> +	for (int i = 0; i < ARRAY_SIZE(vkms_supported_plane_formats); i++) {
> +		if (vkms_supported_plane_formats[i] == drm_format)
> +			found = true;

Missing break?

> +	}
> +
> +	if (!found)
> +		return -EINVAL;
> +	for (unsigned int i = 0; i < plane_cfg->supported_formats_count; i++) {
> +		if (plane_cfg->supported_formats[i] == drm_format)
> +			return 0;
> +	}
> +	u32 *new_ptr = krealloc_array(plane_cfg->supported_formats,
> +				      plane_cfg->supported_formats_count + 1,
> +				      sizeof(*plane_cfg->supported_formats), GFP_KERNEL);
> +	if (!new_ptr)
> +		return -ENOMEM;
> +
> +	plane_cfg->supported_formats = new_ptr;
> +	plane_cfg->supported_formats[plane_cfg->supported_formats_count] = drm_format;
> +	plane_cfg->supported_formats_count++;
> +
> +	return 0;
> +}
> +
> +void vkms_config_plane_remove_all_formats(struct vkms_config_plane *plane_cfg)
> +{
> +	plane_cfg->supported_formats_count = 0;
> +}
> +
> +void vkms_config_plane_remove_format(struct vkms_config_plane *plane_cfg, u32 drm_format)
> +{
> +	for (unsigned int i = 0; i < plane_cfg->supported_formats_count; i++) {
> +		if (plane_cfg->supported_formats[i] == drm_format) {
> +			plane_cfg->supported_formats[i] = plane_cfg->supported_formats[plane_cfg->supported_formats_count - 1];
> +			plane_cfg->supported_formats_count--;
> +		}
> +	}
> +}
> +
>  struct vkms_config_plane *vkms_config_crtc_primary_plane(const struct vkms_config *config,
>  							 struct vkms_config_crtc *crtc_cfg)
>  {
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index 8127e12f00dc..0b7067508e5f 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -62,6 +62,8 @@ struct vkms_config_plane {
>  	unsigned int supported_color_encoding;
>  	enum drm_color_range default_color_range;
>  	unsigned int supported_color_range;
> +	u32 *supported_formats;
> +	unsigned int supported_formats_count;
>  	struct xarray possible_crtcs;
>  
>  	/* Internal usage */
> @@ -404,6 +406,53 @@ vkms_config_plane_set_supported_color_range(struct vkms_config_plane *plane_cfg,
>  	plane_cfg->supported_color_range = supported_color_range;
>  }
>  
> +static inline u32 *
> +vkms_config_plane_get_supported_formats(struct vkms_config_plane *plane_cfg)
> +{
> +	return plane_cfg->supported_formats;
> +}
> +
> +static inline unsigned int
> +vkms_config_plane_get_supported_formats_count(struct vkms_config_plane *plane_cfg)
> +{
> +	return plane_cfg->supported_formats_count;
> +}
> +
> +/** vkms_config_plane_add_format - Add a format to the list of supported format of a plane
> + *
> + * The passed drm_format can already be present in the list. This may fail if the allocation of a
> + * bigger array fails.
> + *
> + * @plane_cfg: Plane to add the format to
> + * @drm_format: Format to add to this plane
> + *
> + * Returns: 0 on success, -ENOMEM if array allocation fails, -EINVAL if the format is not supported
> + * by VKMS
> + */
> +int __must_check vkms_config_plane_add_format(struct vkms_config_plane *plane_cfg, u32 drm_format);
> +
> +/**
> + * vkms_config_plane_add_all_formats - Helper to quickly add all the supported formats
> + * @plane_cfg: Plane to add the formats to
> + *
> + * Returns: 0 on success, -ENOMEM if array allocation fails, -EINVAL if the format is not supported
> + * by VKMS
> + */
> +int __must_check vkms_config_plane_add_all_formats(struct vkms_config_plane *plane_cfg);
> +
> +/**
> + * vkms_config_plane_remove_format - Remove a specific format from a plane
> + * @plane_cfg: Plane to remove the format to
> + * @drm_format: Format to remove
> + */
> +void vkms_config_plane_remove_format(struct vkms_config_plane *plane_cfg, u32 drm_format);
> +
> +/**
> + * vkms_config_plane_remove_all_formats - Remove all formast from a plane
> + * @plane_cfg: Plane to remove the formats from
> + */
> +void vkms_config_plane_remove_all_formats(struct vkms_config_plane *plane_cfg);
> +
>  /**
>   * vkms_config_plane_set_name() - Set the plane name
>   * @plane_cfg: Plane to set the name to
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index ab719da2ca0b..0414865915d8 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -14,42 +14,6 @@
>  #include "vkms_formats.h"
>  #include "vkms_config.h"
>  
> -static const u32 vkms_formats[] = {
> -	DRM_FORMAT_ARGB8888,
> -	DRM_FORMAT_ABGR8888,
> -	DRM_FORMAT_BGRA8888,
> -	DRM_FORMAT_RGBA8888,
> -	DRM_FORMAT_XRGB8888,
> -	DRM_FORMAT_XBGR8888,
> -	DRM_FORMAT_RGB888,
> -	DRM_FORMAT_BGR888,
> -	DRM_FORMAT_XRGB16161616,
> -	DRM_FORMAT_XBGR16161616,
> -	DRM_FORMAT_ARGB16161616,
> -	DRM_FORMAT_ABGR16161616,
> -	DRM_FORMAT_RGB565,
> -	DRM_FORMAT_BGR565,
> -	DRM_FORMAT_NV12,
> -	DRM_FORMAT_NV16,
> -	DRM_FORMAT_NV24,
> -	DRM_FORMAT_NV21,
> -	DRM_FORMAT_NV61,
> -	DRM_FORMAT_NV42,
> -	DRM_FORMAT_YUV420,
> -	DRM_FORMAT_YUV422,
> -	DRM_FORMAT_YUV444,
> -	DRM_FORMAT_YVU420,
> -	DRM_FORMAT_YVU422,
> -	DRM_FORMAT_YVU444,
> -	DRM_FORMAT_P010,
> -	DRM_FORMAT_P012,
> -	DRM_FORMAT_P016,
> -	DRM_FORMAT_R1,
> -	DRM_FORMAT_R2,
> -	DRM_FORMAT_R4,
> -	DRM_FORMAT_R8,
> -};
> -
>  static struct drm_plane_state *
>  vkms_plane_duplicate_state(struct drm_plane *plane)
>  {
> @@ -226,7 +190,8 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
>  
>  	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
>  					   &vkms_plane_funcs,
> -					   vkms_formats, ARRAY_SIZE(vkms_formats),
> +					   vkms_config_plane_get_supported_formats(config),
> +					   vkms_config_plane_get_supported_formats_count(config),
>  					   NULL, vkms_config_plane_get_type(config),
>  					   vkms_config_plane_get_name(config));
>  	if (IS_ERR(plane))
> 
> -- 
> 2.51.0
> 

