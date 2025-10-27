Return-Path: <linux-kernel+bounces-871307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D90C0CE2B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F222E405880
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56032E6116;
	Mon, 27 Oct 2025 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFRL+UEu"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31881F92E
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559386; cv=none; b=czR8q4zHDqJNHZCj7TzLqbV1TjPU8H+Avs0lByxb6Zhf7AqDwNX6YPwtA4L6zbCI8KvHNwH7v/x0hZduhZQKJiloHbRHMFKoBE+ufFRCX5gKiWz6Ok+8n/nJ2wEkabM4LhCS2TQBxnDl/rJymrr1mjVb81+CzZsydvtSGzxXGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559386; c=relaxed/simple;
	bh=wSQhLyLVVBmeJLZo0528PfkrJqdciTos0SsYkvc8nkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S98enVIh/boVq8hJrDxsWPo2mQFB2fdwVWOk8aVW3IS0/yPH4Wq60NEyS6waGxq0t349Nmg/3NEPIHnU3zRqZexKSGF5GsmkmJscHe2boi45Vz4x9dESha9W9fFYEhXrLanhfWT6WA5wPF7xj5BjmJ8KBqZ6KfyEbwh1eiphyiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFRL+UEu; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4711810948aso31932675e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761559382; x=1762164182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ColHiiG/qinTBnjmfHXEdZo/afW+oA9OJEzlrf1jxbY=;
        b=RFRL+UEu05kQ8o0z+Kb9MfkV3NtB7EAcznaoh5XJaV24T43AmWU09ePgf6lEezcQFY
         Z15iOtvsVDCzfFNediPEWEfc8cUixuzpDGEXyg5NtujYRAvvKeIZBB2KMXRIa23SWKSo
         EurpQaoD0oGGA3ek8QuSzlvh2M2bydJIQMPrc10ke2SXsQeUg52Cpwcdqlbo8THx7BCc
         gqLYSZC/RZ/BZYEb2Nqmr4Z9LZt2gQOMylFwkgEPkQZrdRTT7APT8JCkcrWIcqFGEau0
         tKR/LrvIYqOY13CLUGRgiA/CUnca7t6R439RII256dh6FuvXInBY24qdLQL4n7do4Y7Y
         aINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761559382; x=1762164182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ColHiiG/qinTBnjmfHXEdZo/afW+oA9OJEzlrf1jxbY=;
        b=tY6rVCXSIgd4Gnf0ADqEKAB8dze4JdHdqmSLkLSodRFs3PtPBh0gJSNo3BFGKMOD2x
         mWZW/cKhGdby7znI/jJnISBd9kqjrz/j7To3p/mfAzr5W/ZkAys+oKijLFCX5XJnchtt
         UolItDK3GQ3bV7b/Xe7pvEnBWD2y9Q0IM0SSSe4FXu6F/7Y7x7gUN9khUeHDjzFRddl6
         5Qs+3DOQ0OPJbWeeptmi7alQr0RG8yzAx6HFfMXYlA0spXTP8NGVDpfr+5QISVn+/k7v
         FlOVRhmcQa5VMiujb6cywbTRjCjkEDWC3TDcoWJ+tcIMg+7nzu5ul3y3ESjtFWHPVqYg
         ALjg==
X-Forwarded-Encrypted: i=1; AJvYcCU8GlskUmX6ol5qELCqIe0nelIWGeTan6UmpsH7xDR7WSdrUDtPmo3D2jMhObaccTnPkh7lhopNpD3IWjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTGQDKJ/fx0w8o1M0spo4A02D6EbZWoxDvScaZtomKUwC6kUJ8
	pph6gbMtp+YyCmhMskwB6L25fQqOppxpdriIBhGOVjpWJQMC9AW7ga9N
X-Gm-Gg: ASbGncubpZ+U2sagY2U+zhSpw7n6lHeUrHeMW2NCCI45KRwaci6bbO7YFSPKpQBudge
	04Ql6o659Bkk6GJ2eZehctH+al/wPQpfpASRVXD++A8MUTRMa9NMUgWXWNnARU1ODaQMWaZIOwH
	RDj+U65odVUs2Rlw6zxpneZBpgYQjTDz+hPVRk29NIvsEAQNy1uJQfNKiIVYfd50PO8iqusq3Vq
	BCBTKfes6wnSP6RqzY5kuwRhglA4oN5JzoY5goe77W6hwLJ8fgz5DRNs5TcIyKI8xZI7FonUFW6
	uIFd1FoUNHePCW8y2/TtRRIkEC/hMSzdr3XK+KHyt/YgHHIeoZU1JiLlLu64vMORL1ufwLEqXQZ
	d3NLivsHUCMZsLQONfIVbdw3sH4SMVTxInhUbTS1zgolGDmexLRP5a94a+DP1uPYit0fT1NV6Ig
	dlIZXSKel+
X-Google-Smtp-Source: AGHT+IEhJgRbhZWxAtcGo/HkTUbtQh4nuBOxFDXFQPWt87Z+E3yOA3FIVntFGRPGhKTYH/ky4bgtag==
X-Received: by 2002:a05:600c:5392:b0:477:bcb:24cd with SMTP id 5b1f17b1804b1-4770bcb27a0mr35415935e9.22.1761559381856;
        Mon, 27 Oct 2025 03:03:01 -0700 (PDT)
Received: from fedora ([94.73.38.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4a36easm128111685e9.10.2025.10.27.03.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 03:03:01 -0700 (PDT)
Date: Mon, 27 Oct 2025 11:02:59 +0100
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
Subject: Re: [PATCH 18/22] drm/vkms: Introduce config for connector EDID
Message-ID: <aP9DU6g_qbEn1lHn@fedora>
References: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
 <20251018-vkms-all-config-v1-18-a7760755d92d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018-vkms-all-config-v1-18-a7760755d92d@bootlin.com>

On Sat, Oct 18, 2025 at 04:01:18AM +0200, Louis Chauvet wrote:
> Allows configuration of EDID for each connector.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/tests/vkms_config_test.c |  2 +
>  drivers/gpu/drm/vkms/vkms_config.h            | 77 +++++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_connector.c         | 48 +++++++++++++++--
>  3 files changed, 123 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> index a89ccd75060d..d1e380da31ff 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> @@ -190,6 +190,8 @@ static void vkms_config_test_default_config(struct kunit *test)
>  		KUNIT_EXPECT_EQ(test,
>  				vkms_config_connector_get_supported_colorspaces(connector_cfg),
>  				0);
> +		KUNIT_EXPECT_EQ(test, vkms_config_connector_get_edid_enabled(connector_cfg),
> +				false);
>  	}
>  
>  	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index ec614c2d4a30..eaf76a58aab6 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -129,6 +129,8 @@ struct vkms_config_encoder {
>   * @type: Store the type of connector using DRM_MODE_CONNECTOR_* values
>   * @config: The vkms_config this connector belongs to
>   * @status: Status (connected, disconnected...) of the connector

@edid_enabled: If true, @edid and @edid_len are taken into account

(or similar)

> + * @edid: Stores the current EDID
> + * @edid_len: Current EDID length
>   * @possible_encoders: Array of encoders that can be used with this connector
>   * @connector: Internal usage. This pointer should never be considered as valid.
>   *             It can be used to store a temporary reference to a VKMS connector
> @@ -142,6 +144,9 @@ struct vkms_config_connector {
>  	int type;
>  	enum drm_connector_status status;
>  	u32 supported_colorspaces;
> +	bool edid_enabled;
> +	u8 *edid;
> +	unsigned int edid_len;
>  	struct xarray possible_encoders;
>  
>  	/* Internal usage */
> @@ -265,6 +270,78 @@ vkms_config_connector_get_supported_colorspaces(struct vkms_config_connector *co
>  	return connector_cfg->supported_colorspaces;
>  }
>  
> +/**
> + * vkms_config_connector_get_edid_enabled() - Check if EDID is enabled for a connector
> + * @connector_cfg: Connector configuration to check
> + *
> + * Returns:
> + * True if EDID is enabled for this connector, false otherwise.
> + */
> +static inline bool
> +vkms_config_connector_get_edid_enabled(struct vkms_config_connector *connector_cfg)
> +{
> +	return connector_cfg->edid_enabled;
> +}
> +
> +/**
> + * vkms_config_connector_set_edid_enabled() - Enable or disable EDID for a connector
> + * @connector_cfg: Connector configuration to modify
> + * @enabled: Whether to enable EDID for this connector
> + */
> +static inline void
> +vkms_config_connector_set_edid_enabled(struct vkms_config_connector *connector_cfg,
> +				       bool enabled)
> +{
> +	connector_cfg->edid_enabled = enabled;
> +}
> +
> +/**
> + * vkms_config_connector_get_edid() - Get the EDID data for a connector
> + * @connector_cfg: Connector configuration to get the EDID from
> + * @len: Pointer to store the length of the EDID data
> + *
> + * Returns:
> + * Pointer to the EDID data buffer, or NULL if no EDID is set.
> + * The length of the EDID data is stored in @len.
> + */
> +static inline const u8 *
> +vkms_config_connector_get_edid(const struct vkms_config_connector *connector_cfg, int *len)
> +{
> +	*len = connector_cfg->edid_len;
> +	return connector_cfg->edid;
> +}
> +
> +/**
> + * vkms_config_connector_set_edid() - Set the EDID data for a connector
> + * @connector_cfg: Connector configuration to modify
> + * @edid: Pointer to the EDID data buffer
> + * @len: Length of the EDID data
> + *
> + * If @len is 0, the EDID data will be cleared. If memory allocation fails,
> + * the existing EDID data will be preserved.
> + */
> +static inline void
> +vkms_config_connector_set_edid(struct vkms_config_connector *connector_cfg,
> +			       const u8 *edid, unsigned int len)
> +{
> +	if (len) {
> +		void *edid_tmp = krealloc(connector_cfg->edid, len, GFP_KERNEL);
> +
> +		if (edid_tmp) {
> +			connector_cfg->edid = edid_tmp;
> +			memcpy(connector_cfg->edid, edid, len);
> +			connector_cfg->edid_len = len;
> +		} else {
> +			kfree(connector_cfg->edid);
> +			connector_cfg->edid_len = 0;

I wonder if in case of error it makes sense to NULL connector_cfg->edid and
vkms_config_connector_set_edid_enabled(false)?

It'd be also nice to print the EDID in hex format in vkms_config_show().

> +		}
> +	} else {
> +		kfree(connector_cfg->edid);
> +		connector_cfg->edid = NULL;
> +		connector_cfg->edid_len = len;
> +	}
> +}
> +
>  /**
>   * vkms_config_get_device_name() - Return the name of the device
>   * @config: Configuration to get the device name from
> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
> index cc59d13c2d22..339d747e729e 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -42,13 +42,53 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
> +static int vkms_connector_read_block(void *context, u8 *buf, unsigned int block, size_t len)
> +{
> +	struct vkms_config_connector *config = context;
> +	unsigned int edid_len;
> +	const u8 *edid = vkms_config_connector_get_edid(config, &edid_len);
> +
> +	if (block * len + len > edid_len)
> +		return 1;
> +	memcpy(buf, &edid[block * len], len);
> +	return 0;
> +}
> +
>  static int vkms_conn_get_modes(struct drm_connector *connector)
>  {
> -	int count;
> +	struct vkms_connector *vkms_connector = drm_connector_to_vkms_connector(connector);
> +	const struct drm_edid *drm_edid = NULL;
> +	int count = 0;
> +	struct vkms_config_connector *context = NULL;
> +	struct drm_device *dev = connector->dev;
> +	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
> +	struct vkms_config_connector *connector_cfg;
>  
> -	/* Use the default modes list from DRM */
> -	count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
> -	drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
> +	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
> +		if (connector_cfg->connector == vkms_connector)
> +			context = connector_cfg;
> +	}
> +	if (context) {
> +		if (vkms_config_connector_get_edid_enabled(context)) {
> +			drm_edid = drm_edid_read_custom(connector,
> +							vkms_connector_read_block, context);
> +
> +			/*
> +			 * Unconditionally update the connector. If the EDID was read
> +			 * successfully, fill in the connector information derived from the
> +			 * EDID. Otherwise, if the EDID is NULL, clear the connector
> +			 * information.
> +			 */
> +			drm_edid_connector_update(connector, drm_edid);
> +
> +			count = drm_edid_connector_add_modes(connector);
> +
> +			drm_edid_free(drm_edid);
> +		} else {
> +			count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
> +			drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
> +		}
> +	}
>  
>  	return count;
>  }
> 
> -- 
> 2.51.0
> 

