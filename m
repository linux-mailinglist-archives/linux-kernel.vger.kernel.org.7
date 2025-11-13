Return-Path: <linux-kernel+bounces-899599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C37F5C5871F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C72B14F24A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92083546FC;
	Thu, 13 Nov 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Uj1NZUEM"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22EC3546ED
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046920; cv=none; b=rqYcNoulF8VTaO+RhZpU/cT6JTa1asfBxn7CkqjTReGISopVGeFX+b2IBHNX7buODACQJr56LnfrYOUvNCz/L6oQU4OqrOgZChfgVbiSrG4eurZsbGRjZq6VKkZww7uzXjr2woo+FA7t9JwQt1HzdsBgyiam1CwKPGE9HZjiqiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046920; c=relaxed/simple;
	bh=0ik9KPDJc8uPfe3CBxyTTgxK0Ft4sIv13EeKIWjzJyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGaB9AqruaagxddnEdg/w5YAdNuKaz10VNfLJRXJAgcAd+sdT/m9sDb1arc7NgT8TG/hR3nm2Pz9TUDvnByF1BXLuKJl20BtaUqHttXmkZ2pTOfCx2bB2kbdV9ScZWR1m26dGtZGLn5BP/jfS0gOaDOKbnP1hh11djZE3ZzgWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Uj1NZUEM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c7869704so744275f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1763046917; x=1763651717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WIyx4FoiIJ0CWUrLGPOpWyxSuEUcoWV0c7Rxw2upNw=;
        b=Uj1NZUEMCo0Rp3WxqMNw8zQffThchvlI1NNDG1iF3aJEuv+ICfRcscvCBJSb0TYrr2
         A0vXQUgAtyJ+k8LGzKRQmT96LABrdjqwP/axbQ5c0aIPmThzfV757F9ObHE7pMxwv3fN
         WP8JHuSyUjyBN6oGSZE3CBq8Mx1PHJpBpwn28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763046917; x=1763651717;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WIyx4FoiIJ0CWUrLGPOpWyxSuEUcoWV0c7Rxw2upNw=;
        b=WV+/hfW5aX3MJV/VWgUb6bvoix1ZsGMCbf4SIpiNnLDyMnEbcHY+Vy/qhBQ6Xkk/Yo
         /bZ5+TNvIhYcH5EVHmM05UleFOc5IhxTW373eFbYtOF9zHi7dTkj+o1wfZhO+aIZ/IfO
         ZM4/7o8jUgljj6mu9yWYuNn+RgEklKrCbflA/aLNPEMkzu1IChx38Kp4hm8GIsiM3yGV
         5vm838ibeN296Ad3Xs/w25oFB2B/RJT4Y8DU9JtgFn3oY9PaNxCWUqf2LBDRc7pOGv7d
         bkvU9JlI1GzuqLw7R3v29qsBmdJSGeL2fXxR3DL3XLKWL7SAhCBEZDDo/69QQvzRFw/F
         jqEw==
X-Forwarded-Encrypted: i=1; AJvYcCUT/jgYOfGyhyoqYeULwaKvhZiAmHlH0Xx23tsXcwYTQmWeOa8Cv/SvvkJZ5Hq3ybT44eEC9j+8Ugs/sjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfwkDmOwgrSJ4VQwbrIU4IJHSw03dXuSh/hvtBRBbHs466igN9
	KBf448zDxwHwhwJTUTPYKne5hza8pVMXCS9qN05L64wFJ6k7/oKHvW7kdKRCRGQdsrI=
X-Gm-Gg: ASbGncuFlH4u6WrCrXfn6fhle8kMhWxrkRpZdKTb+UcgzuMlOuLB/RvLf4MO6Dox8oF
	l8GBBB40mts8fTLRqSBHM26uJOmp9Wd0KBQK0MR6rZeV4t9/JhazpQOtT5cPgtxFTnvkzTGXLlG
	44sJLdMcXhgqBgJqOKGrDJAKK5GCVneryz2ohDuL7/Hhenp63cWeIS0RfBSMqBVUu+E+Koysziu
	/dh8Fs70fCDvYsumnC33bC1UCw2sOI76gZv/8hob/4LVneRuaTrmzEQtU4gzSGvCuZ1DB6kFk5+
	3D0HVTYXX3pH2jH5bHsr5qqRcSK+s5bkXub6TW9NxOzjk+1XdDW+YXwBQuAmrw8XoJfYpwVPSjb
	ZgA9KNH3btkoy1FmOEqQTy5fbn/ECmnE/QM8+kTLrYIlFR7EUe+Jibpq2PqW6Q6TtmDw+DfWxgl
	dzLFyjTnYbP4E=
X-Google-Smtp-Source: AGHT+IFoRg+d+pL391Nz1AIVvXRJX3r10NwZrLU28XXz89idaEZx0Ay9ePoKh9ZhXKLOg5pBzi9jlw==
X-Received: by 2002:a05:6000:2086:b0:42b:4247:b07e with SMTP id ffacd0b85a97d-42b4bd90a34mr6567401f8f.25.1763046916668;
        Thu, 13 Nov 2025 07:15:16 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f21948sm4476270f8f.43.2025.11.13.07.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 07:15:15 -0800 (PST)
Date: Thu, 13 Nov 2025 16:15:13 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Simona Vetter <simona@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Harry Wentland <Harry.Wentland@amd.com>
Subject: Re: [PATCH] drm/amd: Move adaptive backlight modulation property to
 drm core
Message-ID: <aRX2AQYIX-FZ_xrE@phenom.ffwll.local>
Mail-Followup-To: Mario Limonciello <mario.limonciello@amd.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	Harry Wentland <Harry.Wentland@amd.com>
References: <20251112222646.495189-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112222646.495189-1-mario.limonciello@amd.com>
X-Operating-System: Linux phenom 6.12.38+deb13-amd64 

On Wed, Nov 12, 2025 at 04:26:46PM -0600, Mario Limonciello wrote:
> The adaptive backlight modulation property is supported on AMD hardware but
> compositors should be aware of it in standard DRM property documentation.
> 
> Move the helper to create the property and documentation into DRM.
> 
> Suggested-by: Simona Vetter <simona.vetter@ffwll.ch>
> Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 69 +++------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.h |  7 ---
>  drivers/gpu/drm/drm_connector.c             | 63 +++++++++++++++++++
>  include/drm/drm_connector.h                 |  8 +++
>  4 files changed, 80 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index f8b35c487b6c..3d840bef77bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1363,67 +1363,9 @@ static const struct drm_prop_enum_list amdgpu_dither_enum_list[] = {
>  	{ AMDGPU_FMT_DITHER_ENABLE, "on" },
>  };
>  
> -/**
> - * DOC: property for adaptive backlight modulation
> - *
> - * The 'adaptive backlight modulation' property is used for the compositor to
> - * directly control the adaptive backlight modulation power savings feature
> - * that is part of DCN hardware.
> - *
> - * The property will be attached specifically to eDP panels that support it.
> - *
> - * The property is by default set to 'sysfs' to allow the sysfs file 'panel_power_savings'
> - * to be able to control it.
> - * If set to 'off' the compositor will ensure it stays off.
> - * The other values 'min', 'bias min', 'bias max', and 'max' will control the
> - * intensity of the power savings.
> - *
> - * Modifying this value can have implications on color accuracy, so tread
> - * carefully.
> - */
> -static int amdgpu_display_setup_abm_prop(struct amdgpu_device *adev)
> -{
> -	const struct drm_prop_enum_list props[] = {
> -		{ ABM_SYSFS_CONTROL, "sysfs" },
> -		{ ABM_LEVEL_OFF, "off" },
> -		{ ABM_LEVEL_MIN, "min" },
> -		{ ABM_LEVEL_BIAS_MIN, "bias min" },
> -		{ ABM_LEVEL_BIAS_MAX, "bias max" },
> -		{ ABM_LEVEL_MAX, "max" },
> -	};
> -	struct drm_property *prop;
> -	int i;
> -
> -	if (!adev->dc_enabled)
> -		return 0;
> -
> -	prop = drm_property_create(adev_to_drm(adev), DRM_MODE_PROP_ENUM,
> -				"adaptive backlight modulation",
> -				6);
> -	if (!prop)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < ARRAY_SIZE(props); i++) {
> -		int ret;
> -
> -		ret = drm_property_add_enum(prop, props[i].type,
> -						props[i].name);
> -
> -		if (ret) {
> -			drm_property_destroy(adev_to_drm(adev), prop);
> -
> -			return ret;
> -		}
> -	}
> -
> -	adev->mode_info.abm_level_property = prop;
> -
> -	return 0;
> -}
> -
>  int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
>  {
> -	int sz;
> +	int ret, sz;
>  
>  	adev->mode_info.coherent_mode_property =
>  		drm_property_create_range(adev_to_drm(adev), 0, "coherent", 0, 1);
> @@ -1467,7 +1409,14 @@ int amdgpu_display_modeset_create_props(struct amdgpu_device *adev)
>  					 "dither",
>  					 amdgpu_dither_enum_list, sz);
>  
> -	return amdgpu_display_setup_abm_prop(adev);
> +	adev->mode_info.abm_level_property = drm_create_abm_property(adev_to_drm(adev));
> +	if (IS_ERR(adev->mode_info.abm_level_property)) {
> +		ret = PTR_ERR(adev->mode_info.abm_level_property);
> +		adev->mode_info.abm_level_property = NULL;
> +		return ret;
> +	}
> +
> +	return 0;
>  }
>  
>  void amdgpu_display_update_priority(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> index 2b1536a16752..dfa0d642ac16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> @@ -54,11 +54,4 @@ int amdgpu_display_resume_helper(struct amdgpu_device *adev);
>  int amdgpu_display_get_scanout_buffer(struct drm_plane *plane,
>  				      struct drm_scanout_buffer *sb);
>  
> -#define ABM_SYSFS_CONTROL	-1
> -#define ABM_LEVEL_OFF		0
> -#define ABM_LEVEL_MIN		1
> -#define ABM_LEVEL_BIAS_MIN	2
> -#define ABM_LEVEL_BIAS_MAX	3
> -#define ABM_LEVEL_MAX		4
> -
>  #endif
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index 272d6254ea47..376169dac247 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2603,6 +2603,69 @@ static int drm_mode_create_colorspace_property(struct drm_connector *connector,
>  	return 0;
>  }
>  
> +/**
> + * DOC: integrated panel properties

Thanks for doing this, but just moving the function isn't enough. Aside
from what Jani said there's a few more things that are more about the
technicallities of making good docs for uabi.

- We want proper kerneldoc for the function drm_create_abm_property() like
  for any other function the drm core/helper code exports to drivers.

- The property documentation needs to be moved (or included, but I think
  moving is better) so it shows up in the generated html docs at the right
  place with all the other connector properties.

- We need a mention from the 2nd place to the function (which should
  result in a working hyperlink in the generated docs, please check that
  by generating the docs and confirming with the output) so that driver
  authors can find this. Als the function needs to link to the enum (which
  also needs kerneldoc) and the other direction so that docs are easily
  discoverable.

Thanks a lot!

Cheers, Sima

> + *
> + * adaptive backlight modulation:
> + *	Adaptive backlight modulation (ABM) is a power savings feature that
> + *	dynamically adjusts the backlight brightness based on the content
> + *	displayed on the screen. By reducing the backlight brightness for
> + *	darker images and increasing it for brighter images, ABM helps to
> + *	conserve energy and extend battery life on devices with integrated
> + *	displays.  This feature is part of AMD DCN hardware.
> + *
> + *	sysfs
> + *		The ABM property is exposed to userspace via sysfs interface
> + *		located at 'amdgpu/panel_power_savings' under the DRM device.
> + *	off
> + *		Adaptive backlight modulation is disabled.
> + *	min
> + *		Adaptive backlight modulation is enabled at minimum intensity.
> + *	bias min
> + *		Adaptive backlight modulation is enabled at a more intense
> + *		level than 'min'.
> + *	bias max
> + *		Adaptive backlight modulation is enabled at a more intense
> + *		level than 'bias min'.
> + *	max
> + *		Adaptive backlight modulation is enabled at maximum intensity.
> + */
> +struct drm_property *drm_create_abm_property(struct drm_device *dev)
> +{
> +	const struct drm_prop_enum_list props[] = {
> +		{ ABM_SYSFS_CONTROL, "sysfs" },
> +		{ ABM_LEVEL_OFF, "off" },
> +		{ ABM_LEVEL_MIN, "min" },
> +		{ ABM_LEVEL_BIAS_MIN, "bias min" },
> +		{ ABM_LEVEL_BIAS_MAX, "bias max" },
> +		{ ABM_LEVEL_MAX, "max" },
> +	};
> +	struct drm_property *prop;
> +	int i;
> +
> +	prop = drm_property_create(dev, DRM_MODE_PROP_ENUM,
> +				"adaptive backlight modulation",
> +				6);
> +	if (!prop)
> +		return ERR_PTR(-ENOMEM);
> +
> +	for (i = 0; i < ARRAY_SIZE(props); i++) {
> +		int ret;
> +
> +		ret = drm_property_add_enum(prop, props[i].type,
> +						props[i].name);
> +
> +		if (ret) {
> +			drm_property_destroy(dev, prop);
> +
> +			return ERR_PTR(ret);
> +		}
> +	}
> +
> +	return prop;
> +}
> +EXPORT_SYMBOL(drm_create_abm_property);
> +
>  /**
>   * drm_mode_create_hdmi_colorspace_property - create hdmi colorspace property
>   * @connector: connector to create the Colorspace property on.
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 8f34f4b8183d..644c0d49500f 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -2454,6 +2454,7 @@ int drm_connector_attach_hdr_output_metadata_property(struct drm_connector *conn
>  bool drm_connector_atomic_hdr_metadata_equal(struct drm_connector_state *old_state,
>  					     struct drm_connector_state *new_state);
>  int drm_mode_create_aspect_ratio_property(struct drm_device *dev);
> +struct drm_property *drm_create_abm_property(struct drm_device *dev);
>  int drm_mode_create_hdmi_colorspace_property(struct drm_connector *connector,
>  					     u32 supported_colorspaces);
>  int drm_mode_create_dp_colorspace_property(struct drm_connector *connector,
> @@ -2563,4 +2564,11 @@ const char *drm_get_colorspace_name(enum drm_colorspace colorspace);
>  	drm_for_each_encoder_mask(encoder, (connector)->dev, \
>  				  (connector)->possible_encoders)
>  
> +#define ABM_SYSFS_CONTROL	-1
> +#define ABM_LEVEL_OFF		0
> +#define ABM_LEVEL_MIN		1
> +#define ABM_LEVEL_BIAS_MIN	2
> +#define ABM_LEVEL_BIAS_MAX	3
> +#define ABM_LEVEL_MAX		4
> +
>  #endif
> -- 
> 2.51.2
> 

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch

