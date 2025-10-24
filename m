Return-Path: <linux-kernel+bounces-868742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80702C06004
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A392C188B2B1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94B7315D5E;
	Fri, 24 Oct 2025 11:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wlvje81j"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A5931280D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304593; cv=none; b=bFnHfgnAZLrw6i5iQPElvbOTPBHT9sKLJLKYeiFxaKBNykUMI44hmM+S6Ao23DWKPUSvCsdh39KSqbrpmV0tY9ZUElW8Zdrgxv5+L8ov7Ojt1KJFVoZ39Scm3fzDZlsblrolblU3WJq2aeT+dwf8Swrcs5kAhN4TFZL+UsUJS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304593; c=relaxed/simple;
	bh=WyNsDsfa3gayi4AFzTVz+zbL6eQyv+P7SQ+kovtRd9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwL9RNydmzllZzxeSkMDdE5m/ZTUJfFQ18ucLYCyIViQyr0aalQk686aTsk2dY+FwxfE2jZYo54QV+2qxU/h2cC6EL9swEmB0eEOVx3wV/9Nsyi6uJMu06LuNyek6lSo5G5OxQXaKEwc0GjyiQfbzv1gChZ05t2Oe6pMZbh1dvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wlvje81j; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47114a40161so19926755e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761304589; x=1761909389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bOYFJP18GQ2OUczGrlV4tj7QX2qw5H6RUygunpUvm1A=;
        b=Wlvje81jkjuggCGRnpsNq6VUeuzDwYjK9pb5yWOwJ1fX6OoKi9Ui8ku9Gd7pam9C0S
         sbdWC02f6egpk27V2yJdz+cr6hygkTAHBYQp2ZLRJbJAPlWGFexoTuDRzx+9Nb50WyX9
         yp25pxvIcE2o6UrzGIRofbHrP+6laOdpNo5oUn9rBFGGgp/LwCkT3/WveCXSlM7S+ElI
         AT0keeS2KjVyNjvHeOVQHydp6qATQDLpnsJn3KlXS6EU+nrQNC4Ug4CkWo8wLeFOWTU5
         fVFgODCMnNddZUtqA+b/N93I0Wk2L62vO4zZtab5+Jh6vjjSU/4pyjKwhDsVtjEWTm0P
         lUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761304589; x=1761909389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOYFJP18GQ2OUczGrlV4tj7QX2qw5H6RUygunpUvm1A=;
        b=IX3QtNj5nojDaO9OZEYzbcTrK8BA08QLnPlXd0A6KECCfqaTP+WxD2y7DMoz16S0O7
         j8TfszZ7hv44kIEFnGH6pin7O1LkTXj3M19+7PMWiBUY/UeAgICfN/+gh/0pA3gfZehn
         hWW5nyHWwrztzvc4ilAfW1/oB7B7m6HaZTUfIDT3JFn9eJTeucn8vtaoVonbj+FO0rq+
         ZxMvhkK7UP95tQ5qeonAnbmPeewX74FfLqgQJLXffvG1mU/SdUY/EfUKT22pocW+bECd
         pxGKBKLCYzg9PFgXD70TwFGINa6kEVR+xFIeixUfGnkjgS6T2wjnhWkDb2qyD7o2jbUM
         B3tw==
X-Forwarded-Encrypted: i=1; AJvYcCUqp1tFPqB4aCTY7P/88dDrGFNpwLlFYT/Lq6x2fag7QAPrJgd/rJs291NQNSyAxP+xRpf0YETYs6HF4zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZ51b2gt0vn5IhyeUettIQ5Sw5aR/JLWEwP3nrNC96hVbpo/5
	nt7kyxD5MZklWQHor60BCHL/0RrAj+fiyvsKwDDn4/swAxMEPnpJWnMH
X-Gm-Gg: ASbGncuHuZOH56BCKEh+t/uQRaGT3c5xMe0pG23asIrFxoJ2gVB17LD9Qn3kd11e5rX
	wMxxNJyjex6TUCNGJeGPAIFXhxq3Fg3kDYOD5m8O8OLfwqBC9wfhAc05Vyrut/EHiVPA1c8wv9K
	o43VjM49ebec0Hmh3d3rIVxpUJBInitlLwYljPG0mGe/tfhgmRDVqp8gq0QiymDonuVAxfLF4ZK
	Y0lyuPto5CaOSYaHeIzp3h7RHW9kZDPTd4bCgPZr0qyahr7JrIAW/mowCbkumC1t4lcaqJPJmwl
	SGLlvhOrDs6S5wZKWRPoBGSTFT1oZpWCqeN1cJknuAAbWiWb8eIQ1c+6WEjWmQEpBHwLOY6JNMI
	WsN4uuXLJvnySBSTo9BxdhwXzURNwwxlxDGFJnbemw69H+QrBVbjrA+UySD1IUyqBWqCTdRGRA3
	V01RVW0J0mXw==
X-Google-Smtp-Source: AGHT+IGnrzoxmGVkMjEWD2Ko8GINo3qyo00kse2cliLugsWK1IDfwV6V83Vq+H2BZ5vKxr7YcZeTIQ==
X-Received: by 2002:a05:600c:6085:b0:471:133c:4b9a with SMTP id 5b1f17b1804b1-4711786c79emr236436915e9.6.1761304589326;
        Fri, 24 Oct 2025 04:16:29 -0700 (PDT)
Received: from fedora ([37.29.213.75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ccd88sm10596977f8f.36.2025.10.24.04.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:16:28 -0700 (PDT)
Date: Fri, 24 Oct 2025 13:16:25 +0200
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
Subject: Re: [PATCH 01/22] drm/vkms: Introduce config for plane name
Message-ID: <aPtgCUX5kixTh2ua@fedora>
References: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
 <20251018-vkms-all-config-v1-1-a7760755d92d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018-vkms-all-config-v1-1-a7760755d92d@bootlin.com>

Hey Louis,

Thanks a lot for this series.

I'm reviewing it on my side and adding some KUnit tests to help
me with the review/testing process. I'll send the new tests once
they are ready :)

On Sat, Oct 18, 2025 at 04:01:01AM +0200, Louis Chauvet wrote:
> As planes can have a name in DRM, prepare VKMS to configure it using
> ConfigFS.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_config.c |  4 ++++
>  drivers/gpu/drm/vkms/vkms_config.h | 26 ++++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_drv.h    |  5 +++--
>  drivers/gpu/drm/vkms/vkms_output.c |  6 +-----
>  drivers/gpu/drm/vkms/vkms_plane.c  |  6 ++++--
>  5 files changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index f8394a063ecf..ed172f800685 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -350,6 +350,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  		seq_puts(m, "plane:\n");
>  		seq_printf(m, "\ttype=%d\n",
>  			   vkms_config_plane_get_type(plane_cfg));
> +		seq_printf(m, "\tname=%s\n",
> +			   vkms_config_plane_get_name(plane_cfg));
>  	}
>  
>  	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
> @@ -390,6 +392,7 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
>  
>  	plane_cfg->config = config;
>  	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_OVERLAY);
> +	vkms_config_plane_set_name(plane_cfg, NULL);
>  	xa_init_flags(&plane_cfg->possible_crtcs, XA_FLAGS_ALLOC);
>  
>  	list_add_tail(&plane_cfg->link, &config->planes);
> @@ -402,6 +405,7 @@ void vkms_config_destroy_plane(struct vkms_config_plane *plane_cfg)
>  {
>  	xa_destroy(&plane_cfg->possible_crtcs);
>  	list_del(&plane_cfg->link);
> +	kfree_const(plane_cfg->name);
>  	kfree(plane_cfg);
>  }
>  EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_plane);
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index 4c8d668e7ef8..b69c35097ba0 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -35,6 +35,7 @@ struct vkms_config {
>   *
>   * @link: Link to the others planes in vkms_config
>   * @config: The vkms_config this plane belongs to
> + * @name: Name of the plane
>   * @type: Type of the plane. The creator of configuration needs to ensures that
>   *        at least one primary plane is present.
>   * @possible_crtcs: Array of CRTCs that can be used with this plane
> @@ -47,6 +48,7 @@ struct vkms_config_plane {
>  	struct list_head link;
>  	struct vkms_config *config;
>  
> +	const char *name;
>  	enum drm_plane_type type;
>  	struct xarray possible_crtcs;
>  
> @@ -288,6 +290,30 @@ vkms_config_plane_set_type(struct vkms_config_plane *plane_cfg,
>  	plane_cfg->type = type;
>  }
>  
> +/**
> + * vkms_config_plane_set_name() - Set the plane name
> + * @plane_cfg: Plane to set the name to
> + * @name: New plane name. The name is copied.
> + */
> +static inline void
> +vkms_config_plane_set_name(struct vkms_config_plane *plane_cfg,
> +			   const char *name)
> +{
> +	if (plane_cfg->name)
> +		kfree_const(plane_cfg->name);
> +	plane_cfg->name = kstrdup_const(name, GFP_KERNEL);
> +}

I think we should limit the name to a set of well-known charaters.

The reason is that, in libinput, we had a format string vulnerability
due to the kernel exposing devices with names containing strings like
"%s" in the name (CVE-2022-1215):
https://gitlab.freedesktop.org/libinput/libinput/-/issues/752

In my opinion, we could avoid surprising user-space too much and allow
only a set of "safe" characters.

> +/**
> + * vkms_config_plane_get_name - Get the plane name

Missing "()":
vkms_config_plane_get_name() - Get the plane name

> + * @plane_cfg: Plane to get the name from
> + */
> +static inline const char *
> +vkms_config_plane_get_name(struct vkms_config_plane *plane_cfg)
> +{
> +	return plane_cfg->name;
> +}
> +
>  /**
>   * vkms_config_plane_attach_crtc - Attach a plane to a CRTC
>   * @plane_cfg: Plane to attach
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index db260df1d4f6..9ad286f043b5 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -225,6 +225,7 @@ struct vkms_output {
>  };
>  
>  struct vkms_config;
> +struct vkms_config_plane;
>  
>  /**
>   * struct vkms_device - Description of a VKMS device
> @@ -298,10 +299,10 @@ int vkms_output_init(struct vkms_device *vkmsdev);
>   * vkms_plane_init() - Initialize a plane
>   *
>   * @vkmsdev: VKMS device containing the plane
> - * @type: type of plane to initialize
> + * @config: plane configuration
>   */
>  struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> -				   enum drm_plane_type type);
> +				   struct vkms_config_plane *config);
>  
>  /* CRC Support */
>  const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 2ee3749e2b28..22208d02afa4 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -19,11 +19,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>  		return -EINVAL;
>  
>  	vkms_config_for_each_plane(vkmsdev->config, plane_cfg) {
> -		enum drm_plane_type type;
> -
> -		type = vkms_config_plane_get_type(plane_cfg);
> -
> -		plane_cfg->plane = vkms_plane_init(vkmsdev, type);
> +		plane_cfg->plane = vkms_plane_init(vkmsdev, plane_cfg);
>  		if (IS_ERR(plane_cfg->plane)) {
>  			DRM_DEV_ERROR(dev->dev, "Failed to init vkms plane\n");
>  			return PTR_ERR(plane_cfg->plane);
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
> index e592e47a5736..263376686794 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -11,6 +11,7 @@
>  
>  #include "vkms_drv.h"
>  #include "vkms_formats.h"
> +#include "vkms_config.h"

Nit: Includes are sorted alphabetically.

Jose
  
>  static const u32 vkms_formats[] = {
>  	DRM_FORMAT_ARGB8888,
> @@ -217,7 +218,7 @@ static const struct drm_plane_helper_funcs vkms_plane_helper_funcs = {
>  };
>  
>  struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
> -				   enum drm_plane_type type)
> +				   struct vkms_config_plane *config)
>  {
>  	struct drm_device *dev = &vkmsdev->drm;
>  	struct vkms_plane *plane;
> @@ -225,7 +226,8 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
>  	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
>  					   &vkms_plane_funcs,
>  					   vkms_formats, ARRAY_SIZE(vkms_formats),
> -					   NULL, type, NULL);
> +					   NULL, vkms_config_plane_get_type(config),
> +					   vkms_config_plane_get_name(config));
>  	if (IS_ERR(plane))
>  		return plane;
>  
> 
> -- 
> 2.51.0
> 

