Return-Path: <linux-kernel+bounces-871920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 721E6C0ECD9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDB91896F40
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC7630BF53;
	Mon, 27 Oct 2025 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGklizmX"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5D230BF4B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577267; cv=none; b=NnJCj2cTsSzSCvNEHE3/OtDgA6bldJKLytZ64maX0+fjCKaH7HgPp4CzHtYXRuoRtTF8mxSJanG/GjOS6gW8N4NcU899/cSa3T2CB+DswTvA0GwZpadtE4TNm9brvzaugIMRHvDcGEhilIxyJ0MUTZUubIyOKaEItKoEyrFv6BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577267; c=relaxed/simple;
	bh=JO6I44CyuWEdt8bZZexo38v+La0h0K/20FWd9YC6Bds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7Da2UGaRcL/6rWtMfJuNcKe94DYCvi5eV/+PlUFVNILP6zac+PqcNdWTlK0aRBF0PzQj+XTOi6sdaZwX8MGnsmDapq5YFCiDoJzM6ID0PRkUNLTXgogFBE7zb3F+95GDlP4cHeBUhRD3/3D3n2bjjOS+QNs1RVZQb/Fht4lpFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGklizmX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-474975af41dso33300465e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577264; x=1762182064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OwWL3U+YKBuEy27UD4gstwLK+fX/jcV1wo/uf2RvX+s=;
        b=gGklizmXDFCvMXVOlSpOVGIxT3hBICcK6jVyuPH/aZSwzRafIp9cpLRwLewFw5xWjI
         F4qwhQ5lbF9mN6Hg2xRYIWrrWujhcVrGA2+JZYXadhrBB5c9zZLSmttSeWWNvbjVtGyI
         GJNnuIY9Bvk7hdVg78+5NATpuPO49UmGGeoN6m5im/nc6LcBmHLLBC/6TLA7rapwU3N5
         NuzNEUGHo9T79Vv2HHk+yZlayMw2wG4hIB6eyv8tq+vXvnvXPRh4Jtd0PW2tpz9cENIm
         XvYgDiR/xjDFXZ24Gco9ONg5vKVPA/haS0lxGVc2htGb/i5IrHJnGfZdQ5RfG8Fkdn1J
         TfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577264; x=1762182064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwWL3U+YKBuEy27UD4gstwLK+fX/jcV1wo/uf2RvX+s=;
        b=C9w7j9Br/EIwSV/FNYFIDq3lYLsFs+qOh7/FkanTcl3vIuIKwLQ78tLsp0Hykfv6+T
         YvNRkL87mcOtBdpYFKh5LCWDqjY0HTRRRHe7UJZnPqf/1hS3vgjY9mLA0sRxlJhjl1tL
         Zi4XJMyCPoWboS+xDEIszYp6ZWKgPxUAKuVpl5znjW34Oqoxtz87gQ8T7nxuFG6EiGAS
         R7UPRbWzluJDnhARncAXDZRevyjqSyMQDFlmIBXAlvRhgs2FlgGqETR5kQe/V4VsGhUN
         PKbBuLPLNPfL8wFZu+jxBWt91yMnMbLOaSbmldYuxXAyILL48jkbyTm6jIsimvRI2ReH
         r6nw==
X-Forwarded-Encrypted: i=1; AJvYcCU+YNgd6mLRdKnKkfJ1TiYTmRnv5VteefSeUS7bc5QEka8nW69EoJ+odhyQNtrCjs0ZrS+cAli9PHqtKNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCSRpNFYkImn2iIUWoU2T4s/vF/WF1AnZx2evx1EQNk1hc9VM9
	+7vYquOlTxhmV1RppY+X1NGQ4f59dpkRVGqe1dx0KuAii17VuB8hOHzF
X-Gm-Gg: ASbGncvBNdMDRbG7vdFqoTY4fEHe/ZBl119RZHA0fU4Wm9qzIUH2I2hhqHsQtoaMFD8
	ulCCbxWalFwHTW03xfXhr22Cf2K+fCQDPH1sAuAbSE0BNOfsPiPNMWFRy2HPRbb5bhkTQ6ds4Ou
	BYW6S8ayoRvoj4ziSJF4Z1JY+gaKdPYoPKpNjnHQKYDqOnmFZLYY9vQvQc3W9LOpvdtNxruR4Dr
	8pzC4Re4akNWmTKFibA86x+Og33emIyCfdiFbINSQ0HTDjgBlRsbMRIzqZdL+IX+I3EjNP0QdEG
	nBkxDUov2GErctEP6nbVFB2+B3FpXsUzgUQ3GyCVzo4xtwKFTa8GHIRygdsHqCYacO10BDKhWnG
	2H4tTv0o3JSSGNgHqa/kefFhIsy12EhRoJQ15mJUJGqK+ezmJMahtQg13k+dJsYRztTXnnudHII
	WnPr8xtp/Q
X-Google-Smtp-Source: AGHT+IFc8+LlCVyiSuTLdP8egy6T7XZd5h/9gHCfxOT6+snrK0nSZi+gUtUTxGalPDNOgciNrl/ZFQ==
X-Received: by 2002:a05:600c:6094:b0:477:1326:7b4b with SMTP id 5b1f17b1804b1-47713267bbbmr21637325e9.19.1761577263637;
        Mon, 27 Oct 2025 08:01:03 -0700 (PDT)
Received: from fedora ([94.73.38.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5773sm15995176f8f.27.2025.10.27.08.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:01:02 -0700 (PDT)
Date: Mon, 27 Oct 2025 16:01:00 +0100
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
Subject: Re: [PATCH 21/22] drm/vkms: Allow to hot-add connectors
Message-ID: <aP-JLHHg5nm6l0ji@fedora>
References: <20251018-vkms-all-config-v1-0-a7760755d92d@bootlin.com>
 <20251018-vkms-all-config-v1-21-a7760755d92d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251018-vkms-all-config-v1-21-a7760755d92d@bootlin.com>

On Sat, Oct 18, 2025 at 04:01:21AM +0200, Louis Chauvet wrote:
> In order to allow creating dynamic connector, add the required
> infrastructure in vkms_connector.
> 
> Co-developed-by: José Expósito <jose.exposito89@gmail.com>
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> [Louis Chauvet: use drm_atomic_helper_connector_reset instead of
> drm_mode_config_reset because connector is not yet registered]

Aha! That was why, thanks a lot for figuring this out :)

> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_connector.c | 69 ++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/vkms/vkms_connector.h | 33 +++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_output.c    | 11 +++++-
>  3 files changed, 111 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
> index 339d747e729e..77a544728721 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0+
> -
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_managed.h>
> @@ -144,9 +143,77 @@ struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
>  	return connector;
>  }
>  
> +static const struct drm_connector_funcs vkms_dynamic_connector_funcs = {
> +	.fill_modes = drm_helper_probe_single_connector_modes,
> +	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> +	.destroy = drm_connector_cleanup,
> +	.detect = vkms_connector_detect,
> +};
> +
>  void vkms_trigger_connector_hotplug(struct vkms_device *vkmsdev)
>  {
>  	struct drm_device *dev = &vkmsdev->drm;
>  
>  	drm_kms_helper_hotplug_event(dev);
>  }
> +
> +struct vkms_connector *vkms_connector_hot_add(struct vkms_device *vkmsdev,
> +					      struct vkms_config_connector *connector_cfg)
> +{
> +	struct vkms_config_encoder *encoder_cfg;
> +	struct vkms_connector *connector;
> +	int ret;
> +	unsigned long idx = 0;
> +
> +	connector = kzalloc(sizeof(*connector), GFP_KERNEL);

Could we use drmm_kzalloc instead?

> +	if (IS_ERR(connector))
> +		return connector;
> +	ret = drm_connector_dynamic_init(&vkmsdev->drm,
> +					 &connector->base,
> +					 &vkms_dynamic_connector_funcs,
> +					 connector_cfg->type,
> +					 NULL);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	drm_connector_helper_add(&connector->base, &vkms_conn_helper_funcs);
> +
> +	vkms_config_connector_for_each_possible_encoder(connector_cfg, idx, encoder_cfg) {
> +		ret = drm_connector_attach_encoder(&connector->base,
> +						   encoder_cfg->encoder);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	drm_atomic_helper_connector_reset(&connector->base);
> +
> +	ret = drm_connector_dynamic_register(&connector->base);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return connector;
> +}
> +
> +void vkms_connector_hot_remove(struct vkms_device *vkmsdev,
> +			       struct vkms_connector *connector)
> +{
> +	drm_connector_unregister(&connector->base);
> +	drm_mode_config_reset(&vkmsdev->drm);
> +	drm_connector_put(&connector->base);
> +}
> +
> +int vkms_connector_hot_attach_encoder(struct vkms_device *vkmsdev,
> +				      struct vkms_connector *connector,
> +				      struct drm_encoder *encoder)
> +{
> +	int ret;
> +
> +	ret = drm_connector_attach_encoder(&connector->base, encoder);
> +	if (ret)
> +		return ret;
> +
> +	drm_mode_config_reset(&vkmsdev->drm);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
> index a124c5403697..224950c13a93 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.h
> +++ b/drivers/gpu/drm/vkms/vkms_connector.h
> @@ -7,6 +7,7 @@
>  
>  #define drm_connector_to_vkms_connector(target) \
>  	container_of(target, struct vkms_connector, base)
> +struct vkms_config_connector;
>  
>  /**
>   * struct vkms_connector - VKMS custom type wrapping around the DRM connector
> @@ -33,4 +34,36 @@ struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
>   */
>  void vkms_trigger_connector_hotplug(struct vkms_device *vkmsdev);
>  
> +/**
> + * vkms_connector_hot_add() - Create a connector after the device is created
> + * @vkmsdev: Device to hot-add the connector to
> + * @connector_cfg: Connector's configuration
> + *
> + * Returns:
> + * The connector or an error on failure.
> + */
> +struct vkms_connector *vkms_connector_hot_add(struct vkms_device *vkmsdev,
> +					      struct vkms_config_connector *connector_cfg);
> +
> +/**
> + * vkms_connector_hot_remove() - Remove a connector after a device is created
> + * @connector: The connector to hot-remove
> + */
> +void vkms_connector_hot_remove(struct vkms_device *vkmsdev,
> +			       struct vkms_connector *connector);
> +
> +/**
> + * vkms_connector_hot_attach_encoder() - Attach a connector to a encoder after
> + * the device is created.
> + * @vkmsdev: Device containing the connector and the encoder
> + * @connector: Connector to attach to @encoder
> + * @encoder: Target encoder
> + *
> + * Returns:
> + * 0 on success or an error on failure.
> + */
> +int vkms_connector_hot_attach_encoder(struct vkms_device *vkmsdev,
> +				      struct vkms_connector *connector,
> +				      struct drm_encoder *encoder);
> +
>  #endif /* _VKMS_CONNECTOR_H_ */
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 217f054d9598..aba2f9ab243d 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -92,7 +92,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>  		}
>  	}
>  
> -	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
> +	vkms_config_for_each_connector_static(vkmsdev->config, connector_cfg) {
>  		struct vkms_config_encoder *possible_encoder;
>  		unsigned long idx = 0;
>  
> @@ -116,5 +116,14 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>  
>  	drm_mode_config_reset(dev);
>  
> +	vkms_config_for_each_connector_dynamic(vkmsdev->config, connector_cfg) {
> +		if (connector_cfg->enabled) {
> +			connector_cfg->connector = vkms_connector_hot_add(vkmsdev, connector_cfg);
> +
> +			if (IS_ERR(connector_cfg->connector))
> +				return PTR_ERR(connector_cfg->connector);
> +		}
> +	}
> +
>  	return 0;
>  }
> 
> -- 
> 2.51.0
> 

