Return-Path: <linux-kernel+bounces-871889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BF2C0EB55
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 734CD4FBD15
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5393D2FE078;
	Mon, 27 Oct 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts2udT4y"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6FA30CDA9
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576757; cv=none; b=piHGlRqaz/TgOKTNPcyiuQlffjvomRtQ0ZpaTGwyKFD9xPqDfwOL1LgIcSR+T+s/ttr6sim6vqp6Zn9BsPrlZpnaKiUFZ3nwELSJPYmhvwa/n5wRkzhXhf2bzRW4WfhRsvoKPK/ZcY6WftGb6CXSQP1vTKsv1HoU91Vv1Hlv/vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576757; c=relaxed/simple;
	bh=JM3k3PwNqLknagWoqcQBMMAmth++XIYqHqiXUR7kR0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MY7dwuqjtKC8/RXF6q2mmv7Lwz4RICxv0j3u7zaSQJVZwZL/iIZLQ1yzu02eUZrTV8NLcgTACiDVmA/teksr2DC/TB6RP00ZzgoSrwHzwYSrOQxtWDS+7+NWlR1Xp6iAU2dr1feOiNX37ECKKIgpWm4euedIc2UjEqpEqES7Ka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts2udT4y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso12993605e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761576753; x=1762181553; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CG2tkvlUbIfjNpzMGKRkYn92mrYl4xnwnC80WC0Ss5I=;
        b=Ts2udT4ykeghhh5+EsRUOSGC6otxii1kcFHknnPOQwBvP2ggzxS2Oibr3FjBToRCau
         WX9evgPG0R8X0a4zu74yJxUKN6YkxuTirUsGPjhqc6iYoZp0xSeZOEPemkmILPBokhRo
         meMqwVOEDJZJtAB2kdelPFIs4yL/rCKcX+9yOzRj5YunH4rtdGHeDU8tySvXHVIBiRJD
         5OJUHHvFkZE6JK+PfLVSovjcQ+h6IbLXbLAhXMvGlgcQ+VcZXTXMSQ2t8lkZ8qtGK6Jt
         6BQYOik2pPZRxqZ1bxAZz6Zgf8oKTYB/OKoUs5RWkvOec+yVlyIvAt2nEqLZoZ13PLax
         IGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761576753; x=1762181553;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CG2tkvlUbIfjNpzMGKRkYn92mrYl4xnwnC80WC0Ss5I=;
        b=RVfZRyqwYs/QrlffChCnvUCCFgc5R4nFCmllkUQ0zV14ja02NickPp87InYSsC8naZ
         qeUx+sg2H0nO1Rcucw0xOO+2rswcVCV6jTIzMnC7rOmx5/i5TAvJ5yiu7OhvmgqoWUG4
         zEU8q8ubflNcvy2nPq2lkvuOfMamckuCm3YossCPrpzb2kKdnYzpiswNcpD1F2GS2Vkf
         gvErlinLFy8ZNbU1vsWg811N5Qs1s1PaLrMRIbzXbAIjERJEPSk2ENJk+3lO7X9+uU8L
         GKMnDIZuy8nNKGpOEdaEWJhQ/7PSlI++hnsEmR5x8BCMlhTcWT7QYe8s0CEp10vzJuOF
         pcyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+LvwW9j85uI3RJQkRLRRaYDGnrMvaVV0+eAGvD9Jgh+vxyXvBK/NadPscv6v7kr9T24E2Z/XclxMftUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKuQc/9SKLM3mapAA1YB+A/Po7Vj33A5fZ6dVmQ3TbETdRj8ri
	IFPlkA+CjvzSibixpMnkPxLFw38g29l050sZ59qP15J9EAu/MEbm4JyA
X-Gm-Gg: ASbGncthshR6V44TgSS6EHPhQJSsunmc7ixppO4Dvh/dI0fTEmTAro8hxnlVSpCsVJc
	mv4xPT+aKnJ9xwmPGBAeVDB6VHg6B1qJiZ9IGKlspSrkIdD7zZTvmKu4ipWDrxotWoM8HEvlb6K
	BL3mxYJJ0/29wkXRIWmvL2vrwJh56kGaWjPafDfKyEskIdCuKL9C2FqGqkRcSkbY25MlqG/mCEW
	AIBVkWBRM4PBPFEFcMnGFv1qUT/fNT7xYuSbv0TwIDdoiYl6wAOZTKLn0yEQFtUY0YMfmNGKyb+
	3hXps8fDNw3gvaMzoWoD5s0UEiqfVzYy5AIA7EjnjLx2Xsfnte08cSTo5tya3ANw0f52ZFhHoRo
	mI/M96a6Hv/wEYsGdX1JgKzHaLh0SJQ/E0+pYVMlZso1bQbE35tzw1djnJFlahgDRN421TZNeXg
	==
X-Google-Smtp-Source: AGHT+IHjBgSezOajtNnHj2arl75lAB5ScyHP+2SpFJAW6GyFs1n32z2GEG9yrr0CCn8Kd71lNpl3yg==
X-Received: by 2002:a05:600c:3e07:b0:471:c04:a352 with SMTP id 5b1f17b1804b1-4711787674fmr278303415e9.4.1761576752971;
        Mon, 27 Oct 2025 07:52:32 -0700 (PDT)
Received: from fedora ([94.73.38.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd042499sm140814925e9.8.2025.10.27.07.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:52:32 -0700 (PDT)
Date: Mon, 27 Oct 2025 15:52:30 +0100
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
Subject: Re: [PATCH 20/22] drm/vkms: Store the enabled/disabled status for
 connector
Message-ID: <aP-HLjiHzs2v5F8-@fedora>
References: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
 <20251018-vkms-all-config-v1-20-a7760755d92d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251018-vkms-all-config-v1-20-a7760755d92d@bootlin.com>

On Sat, Oct 18, 2025 at 04:01:20AM +0200, Louis Chauvet wrote:
> In order to prepare for dynamic connector configuration, we need to store
> if a connector is dynamic and if it is enabled.
> 
> The two new vkms_config_connector fields will helps for that.
> 
> Co-developed-by: José Expósito <jose.exposito89@gmail.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/tests/vkms_config_test.c |  4 ++
>  drivers/gpu/drm/vkms/vkms_config.c            |  2 +
>  drivers/gpu/drm/vkms/vkms_config.h            | 66 +++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+)
> 
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> index d1e380da31ff..f4b5f8f59fab 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> @@ -192,6 +192,10 @@ static void vkms_config_test_default_config(struct kunit *test)
>  				0);
>  		KUNIT_EXPECT_EQ(test, vkms_config_connector_get_edid_enabled(connector_cfg),
>  				false);
> +		KUNIT_EXPECT_EQ(test, vkms_config_connector_is_enabled(connector_cfg),
> +				true);
> +		KUNIT_EXPECT_EQ(test, vkms_config_connector_is_dynamic(connector_cfg),
> +				false);

I missed this in other reviews, but you can use KUNIT_EXPECT_TRUE/FALSE instead.

>  	}
>  
>  	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index 56e2082b91c9..fd724ae2ebc9 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -773,6 +773,8 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
>  	connector_cfg->status = connector_status_connected;
>  	vkms_config_connector_set_type(connector_cfg, DRM_MODE_CONNECTOR_VIRTUAL);
>  	vkms_config_connector_set_supported_colorspaces(connector_cfg, 0);
> +	vkms_config_connector_set_dynamic(connector_cfg, false);
> +	vkms_config_connector_set_enabled(connector_cfg, true);
>  	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
>  
>  	list_add_tail(&connector_cfg->link, &config->connectors);
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index eaf76a58aab6..6716b5a85f0d 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -128,6 +128,8 @@ struct vkms_config_encoder {
>   * @link: Link to the others connector in vkms_config
>   * @type: Store the type of connector using DRM_MODE_CONNECTOR_* values
>   * @config: The vkms_config this connector belongs to
> + * @dynamic: Store if a connector should be created with drm_connector_dynamic_init
> + * @enabled: If @dynamic, this means that the correct is currently registered in drm
>   * @status: Status (connected, disconnected...) of the connector
>   * @edid: Stores the current EDID
>   * @edid_len: Current EDID length
> @@ -142,6 +144,8 @@ struct vkms_config_connector {
>  	struct vkms_config *config;
>  
>  	int type;
> +	bool enabled;
> +	bool dynamic;

In this patch we could also log this in vkms_config_show().

>  	enum drm_connector_status status;
>  	u32 supported_colorspaces;
>  	bool edid_enabled;
> @@ -185,6 +189,24 @@ struct vkms_config_connector {
>  #define vkms_config_for_each_connector(config, connector_cfg) \
>  	list_for_each_entry((connector_cfg), &(config)->connectors, link)
>  
> +/**
> + * vkms_config_for_each_connector_static - Iterate over the static vkms_config connectors
> + * @config: &struct vkms_config pointer
> + * @connector_cfg: &struct vkms_config_connector pointer used as cursor
> + */
> +#define vkms_config_for_each_connector_static(config, connector_cfg) \
> +	vkms_config_for_each_connector((config), (connector_cfg)) \
> +		if (!(connector_cfg)->dynamic)
> +
> +/**
> + * vkms_config_for_each_connector_dynamic - Iterate over the dynamic vkms_config connectors
> + * @config: &struct vkms_config pointer
> + * @connector_cfg: &struct vkms_config_connector pointer used as cursor
> + */
> +#define vkms_config_for_each_connector_dynamic(config, connector_cfg) \
> +	vkms_config_for_each_connector((config), (connector_cfg)) \
> +		if ((connector_cfg)->dynamic)
> +
>  /**
>   * vkms_config_plane_for_each_possible_crtc - Iterate over the vkms_config_plane
>   * possible CRTCs
> @@ -441,6 +463,50 @@ vkms_config_connector_set_type(struct vkms_config_connector *connector_cfg,
>  	connector_cfg->type = type;
>  }
>  
> +/**
> + * vkms_config_connector_set_enabled() - If the connector is part of the device
> + * @crtc_cfg: Target connector
> + * @enabled: Add or remove the connector
> + */
> +static inline void
> +vkms_config_connector_set_enabled(struct vkms_config_connector *connector_cfg,
> +				  bool enabled)
> +{
> +	connector_cfg->enabled = enabled;
> +}
> +
> +/**
> + * vkms_config_connector_is_enabled() - If the connector is part of the device
> + * @connector_cfg: The connector
> + */
> +static inline bool
> +vkms_config_connector_is_enabled(struct vkms_config_connector *connector_cfg)
> +{
> +	return connector_cfg->enabled;
> +}
> +
> +/**
> + * vkms_config_connector_set_dynamic() - If the connector is dynamic
> + * @crtc_cfg: Target connector
> + * @enabled: Enable or disable the dynamic status
> + */
> +static inline void
> +vkms_config_connector_set_dynamic(struct vkms_config_connector *connector_cfg,
> +				  bool dynamic)
> +{
> +	connector_cfg->dynamic = dynamic;
> +}
> +
> +/**
> + * vkms_config_connector_is_enabled() - If the connector is dynamic
> + * @connector_cfg: The connector
> + */
> +static inline bool
> +vkms_config_connector_is_dynamic(struct vkms_config_connector *connector_cfg)
> +{
> +	return connector_cfg->dynamic;
> +}
> +
>  /*
>   * vkms_config_plane_get_default_rotation() - Get the default rotation for a plane
>   * @plane_cfg: Plane to get the default rotation from
> 
> -- 
> 2.51.0
> 

