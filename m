Return-Path: <linux-kernel+bounces-871242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4331CC0CB87
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFB554F3EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA64A2F12CE;
	Mon, 27 Oct 2025 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8RG+oqz"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4432F28F4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557918; cv=none; b=PullJmYFh+/IkNmjo1vZyGQLwLrWvnmC4bgrg7aomhWHOiv2OPtkUTmTIsMVT/0Nbyrh7i4lsf3DslrwS6snEXtEcVChWNgvCQuy4SgZzq8ckL9dCk+2fTOiNg51IPPDdF13O1NT7uVfkNeWYxQrLrJz28KjEJCxg9i6haz/UFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557918; c=relaxed/simple;
	bh=Bc+qrw/OhAmUr+DULNtCiQuB/GZhGymOqDfLUaPuYFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpFu0i2Tsdtde8chyx80Ybf0biyhTCmKkcnTmTjLs3XwJx+R4+MyLaMw+5vzf89NoxSG8Gy+dq3gdXZpTIjRxk9HDxW1Qy4geY0JRGr85a7/rTTp8TZ1zVoURS75oZtiW7Cp9JejoQyFXYoG79KbLpRvRlm3Ik94tGhRoK40cnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8RG+oqz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee130237a8so2840052f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761557914; x=1762162714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mrXR8lBbY3rQP++NKL3OM/LYz3iXG33tu2GQ0QMPU0o=;
        b=d8RG+oqzeeFuMi1PL/As9AA0NbwnZMKqpoECfqbhNoY7xL7SaKxL69B7Cs/2qveTJp
         JQp8CN2dCAXXGNcdUa6gkDyUoWi1xaWSxmJWaVKNasFQigGLWOUI8f+dYbI+bJmU46xB
         MqmhtYEqDEEjJaDmCgkTKBwG5LFIpX2F0O3P8uj/FqnEMDcBHQFv5Q4zC6C1VWsqnzMy
         qJD1uthDEkKwLdR3G6WlkbuW+ZtuRb1L/yaKoWL+cP39Vm61Z8Zx5UMbHbCStLzR3TVC
         zvn3Lvv+2gtGt7EF7Xk6AxynmUz/rC3LY2XJ2f0GfD5snxldgcHV3yov5yB8o3oFTYcX
         Dc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761557914; x=1762162714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrXR8lBbY3rQP++NKL3OM/LYz3iXG33tu2GQ0QMPU0o=;
        b=L/lNkhV134WWQaKWmunPEiGEs42P3aorinC/qKCkR4cm5RgfQeQEDv1xssdx0U56HG
         /9wzKELgbikXki5moaLLBCWh3Pw6ywN+gWkd5CPyQK5vczU7+5Wv9YjHy9dJSWX3kNOe
         /mHRZgonhgYmjqY6BwIo3HdhqjNZySZskxdgDWd9jtp4a9GkXga9S4V/Bni5CD8OF1Hi
         OwOt4b25gBtdpypO+iEtPwXHWl+STGWCfJeiowSNgM3S66Fg6H5j9h4yqAk18qb90i8+
         2ajw/07BHfg6w6w7jSp8Np5QX0eRLS759YLim6MibybLqOy9ka+5qjXEds1zzBgkdAfL
         +1Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWfL0tekr3xAypCec70D9UQJOKFbYd02Obm484q1Qbji0jAjdZxgvQBjSV5RjjIQidx2vlKKkFISHDkRao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1gaS+Jbey8vfWuZo6zLIqyKLe2Nx5DfHfjUtqeUF6RlSr2ws+
	IvB6KrQuK39rgMHQ3msnQX9ZKXC6JtEQwhx8sNxgFYfCxKg61JEhRmY7
X-Gm-Gg: ASbGnct8Q3N6nbB46mvvvB1ntO9QLVsqQKQEvFLGlr5/CmJYknz0z2TdI19Sf3XiDQQ
	SljxAe6qU811CcNFH9USXYIkvP0br40YjRzPIiKwxsK5jtmI2vw5Csdc2UNblhRgndisy8UVL3o
	hyOaE9W6OJCEMIvuYoo3qEa8rrxV1Usmnq5HyqCVBWuLIwA9p/wO0LsrDvDhGGE1SvsARSHd6cc
	9jq4y4/TtCnPG9d/+DrXaRZDTeDsgUZ4PeR4098GTRixFGlWxyMRNkbiowDv9KEuo6OyIcyz+MU
	Lmcd3dmnxSduNfS+lgf5oX4gWApGlvd1I3wVXp29JVMyNDwDpJDEFDFMUQFzEPWDusryg/haYBU
	BQDXEFUQcWYM9VqmaTiWItfTB774jFM1VfE/Rdtr2+/PJUUHYlFh34ZJe2cK+QQBcspQ9Y/xuiA
	==
X-Google-Smtp-Source: AGHT+IHQ+TEVjMq0y+9SkjrfTyB83zzg4AUyCMIh2DMHA2Qh4W3bcbJMnYyQxYMtIF1VS0cZAPn60w==
X-Received: by 2002:a05:6000:40cb:b0:427:72d1:e3b2 with SMTP id ffacd0b85a97d-4299072c24amr8621232f8f.35.1761557914436;
        Mon, 27 Oct 2025 02:38:34 -0700 (PDT)
Received: from fedora ([94.73.38.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd00cf3dsm61686405e9.1.2025.10.27.02.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:38:34 -0700 (PDT)
Date: Mon, 27 Oct 2025 10:38:32 +0100
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
Subject: Re: [PATCH 16/22] drm/vkms: Introduce config for connector supported
 colorspace
Message-ID: <aP89mA408-Y6Kq7q@fedora>
References: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
 <20251018-vkms-all-config-v1-16-a7760755d92d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018-vkms-all-config-v1-16-a7760755d92d@bootlin.com>

Sorry for the additional email.

I see that the colorspace is ignored if the connector is not HDMI,
eDP or Display Port. Should we add some kind of validation?


On Sat, Oct 18, 2025 at 04:01:16AM +0200, Louis Chauvet wrote:
> To emulate some HDR features of displays, it is required to expose some
> properties on HDMI, eDP and DP connectors.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/tests/vkms_config_test.c |  3 +++
>  drivers/gpu/drm/vkms/vkms_config.c            |  1 +
>  drivers/gpu/drm/vkms/vkms_config.h            | 26 ++++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_connector.c         | 15 +++++++++++++++
>  4 files changed, 45 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> index 8633210342a4..a89ccd75060d 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> @@ -187,6 +187,9 @@ static void vkms_config_test_default_config(struct kunit *test)
>  	vkms_config_for_each_connector(config, connector_cfg) {
>  		KUNIT_EXPECT_EQ(test, vkms_config_connector_get_type(connector_cfg),
>  				DRM_MODE_CONNECTOR_VIRTUAL);
> +		KUNIT_EXPECT_EQ(test,
> +				vkms_config_connector_get_supported_colorspaces(connector_cfg),
> +				0);
>  	}
>  
>  	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index 20750c9f6d08..56e2082b91c9 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -772,6 +772,7 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
>  	connector_cfg->config = config;
>  	connector_cfg->status = connector_status_connected;
>  	vkms_config_connector_set_type(connector_cfg, DRM_MODE_CONNECTOR_VIRTUAL);
> +	vkms_config_connector_set_supported_colorspaces(connector_cfg, 0);
>  	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
>  
>  	list_add_tail(&connector_cfg->link, &config->connectors);
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index 36d289a010f6..ec614c2d4a30 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -141,6 +141,7 @@ struct vkms_config_connector {
>  
>  	int type;
>  	enum drm_connector_status status;
> +	u32 supported_colorspaces;
>  	struct xarray possible_encoders;
>  
>  	/* Internal usage */
> @@ -239,6 +240,31 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
>   */
>  void vkms_config_destroy(struct vkms_config *config);
>  
> +/**
> + * vkms_config_connector_set_supported_colorspaces() - Set the supported colorspaces for a connector
> + * @connector_cfg: Connector configuration to modify
> + * @supported_colorspaces: Bitmask of supported colorspaces (DRM_COLOR_YCBCR_*)
> + */
> +static inline void
> +vkms_config_connector_set_supported_colorspaces(struct vkms_config_connector *connector_cfg,
> +						u32 supported_colorspaces)
> +{
> +	connector_cfg->supported_colorspaces = supported_colorspaces;
> +}
> +
> +/**
> + * vkms_config_connector_get_supported_colorspaces() - Get the supported colorspaces for a connector
> + * @connector_cfg: Connector configuration to query
> + *
> + * Returns:
> + * Bitmask of supported colorspaces (DRM_COLOR_YCBCR_*)
> + */
> +static inline u32
> +vkms_config_connector_get_supported_colorspaces(struct vkms_config_connector *connector_cfg)
> +{
> +	return connector_cfg->supported_colorspaces;
> +}
> +
>  /**
>   * vkms_config_get_device_name() - Return the name of the device
>   * @config: Configuration to get the device name from
> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
> index 5a87dc2d4c63..cc59d13c2d22 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -84,6 +84,21 @@ struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> +	if (vkms_config_connector_get_supported_colorspaces(connector_cfg)) {
> +		if (connector_cfg->type == DRM_MODE_CONNECTOR_HDMIA) {
> +			drm_mode_create_hdmi_colorspace_property(&connector->base,
> +								 vkms_config_connector_get_supported_colorspaces(connector_cfg));
> +			drm_connector_attach_hdr_output_metadata_property(&connector->base);
> +			drm_connector_attach_colorspace_property(&connector->base);
> +		} else if (connector_cfg->type == DRM_MODE_CONNECTOR_DisplayPort ||
> +			   connector_cfg->type == DRM_MODE_CONNECTOR_eDP) {
> +			drm_mode_create_dp_colorspace_property(&connector->base,
> +							       vkms_config_connector_get_supported_colorspaces(connector_cfg));
> +			drm_connector_attach_hdr_output_metadata_property(&connector->base);
> +			drm_connector_attach_colorspace_property(&connector->base);
> +		}
> +	}
> +
>  	drm_connector_helper_add(&connector->base, &vkms_conn_helper_funcs);
>  
>  	return connector;
> 
> -- 
> 2.51.0
> 

