Return-Path: <linux-kernel+bounces-603368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57412A886B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 17:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721D21906E2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 15:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE5C27B501;
	Mon, 14 Apr 2025 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3/cRDxV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54389253932
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642732; cv=none; b=Q1jVtbuK4/wmnogxCr6rGQSY5n4cE8JzfZDCmAtfuDHgO0F2dZCHtShFWijvjLwH/kSJCOdQLpByfCPATlkfWG9MzuqmqrAxpnJKS/3t/7nf/P6Fd3DY19BWtoMwpTECDpCu2vS+d/mGpxyTA+tvDKIN8UEQxsDWtof4vJBFHX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642732; c=relaxed/simple;
	bh=ZL4niwD5OzbvUtZ2QvRy0R5Zi5kBv9CNQVZDN+I4Urg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gI0WhkpsbQA9coLSUenJrQWLYG361/ZTwr8lvhOf9l4c1Kg/b4r9Cww2WZ2sXB59GM09VEHdgEZgQ0LsHUp/FO+ls7z4J9zyamSA7KBkh6ZIxPh0NYGnwnHLHCB+9rZACIYzyADbLgZN98PVAYR1xlz6awfxr2opgmKyeAJ18jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3/cRDxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236B5C4CEE9;
	Mon, 14 Apr 2025 14:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744642731;
	bh=ZL4niwD5OzbvUtZ2QvRy0R5Zi5kBv9CNQVZDN+I4Urg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3/cRDxVV3XjNRB6h9i4f6QXNXzeFGdWszmayJQF/1Nd1i5mjQNqFinsh3dtWY6ZX
	 B0MDm81ZnU8LNjzrQvsvGS1cTKAFzJtObN9B7hqVHrf/H2u/0Stsy/VfW6S73dm/jK
	 98RLTfL1OR/3JI5HaKHSRDZtAYtAOHHL/CrcdtRyV1JG1UaeOs/uwIZSC5feY0OHwU
	 0c4ia7ZOtudz75sQQ9acuC6KVLSVxa3F3oRhYwUjU+ok/OaCv6sHD4oXvEU4ZjEZC4
	 W4T/VEASlUOwL2fUmiBVhSp90upIS4O+/RSESBuPL1/QSn3fy8DHjizdLEmCRzqz+E
	 6Gd4EBee/7EGA==
Date: Mon, 14 Apr 2025 16:58:48 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v5 06/11] drm/display: add CEC helpers code
Message-ID: <20250414-determined-kind-peacock-e9a47c@houat>
References: <20250407-drm-hdmi-connector-cec-v5-0-04809b10d206@oss.qualcomm.com>
 <20250407-drm-hdmi-connector-cec-v5-6-04809b10d206@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zeurqglj6czdayd5"
Content-Disposition: inline
In-Reply-To: <20250407-drm-hdmi-connector-cec-v5-6-04809b10d206@oss.qualcomm.com>


--zeurqglj6czdayd5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 06/11] drm/display: add CEC helpers code
MIME-Version: 1.0

On Mon, Apr 07, 2025 at 06:11:03PM +0300, Dmitry Baryshkov wrote:
> +static void drm_connector_hdmi_cec_adapter_unregister(struct drm_connector *connector)
> +{
> +	struct drm_connector_hdmi_cec_data *data = connector->cec.data;
> +
> +	cec_delete_adapter(data->adapter);
> +
> +	if (data->funcs->uninit)
> +		data->funcs->uninit(connector);
> +
> +	kfree(data);
> +	connector->cec.data = NULL;
> +}
>
> [...]
>
> +int drm_connector_hdmi_cec_register(struct drm_connector *connector,
> +				    const struct drm_connector_hdmi_cec_funcs *funcs,
> +				    const char *name,
> +				    u8 available_las,
> +				    struct device *dev)
> +{
> +	struct drm_connector_hdmi_cec_data *data;
> +	struct cec_connector_info conn_info;
> +	struct cec_adapter *cec_adap;
> +	int ret;
> +
> +	if (!funcs->init || !funcs->enable || !funcs->log_addr || !funcs->transmit)
> +		return -EINVAL;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->funcs = funcs;
> +
> +	cec_adap = cec_allocate_adapter(&drm_connector_hdmi_cec_adap_ops, connector, name,
> +					CEC_CAP_DEFAULTS | CEC_CAP_CONNECTOR_INFO,
> +					available_las ? : CEC_MAX_LOG_ADDRS);
> +	ret = PTR_ERR_OR_ZERO(cec_adap);
> +	if (ret < 0)
> +		goto err_free;
> +
> +	cec_fill_conn_info_from_drm(&conn_info, connector);
> +	cec_s_conn_info(cec_adap, &conn_info);
> +
> +	data->adapter = cec_adap;
> +
> +	mutex_lock(&connector->cec.mutex);
> +
> +	connector->cec.data = data;
> +	connector->cec.funcs = &drm_connector_hdmi_cec_adapter_funcs;
> +
> +	ret = funcs->init(connector);
> +	if (ret < 0)
> +		goto err_delete_adapter;
> +
> +	ret = cec_register_adapter(cec_adap, dev);
> +	if (ret < 0)
> +		goto err_delete_adapter;

I'm a bit concerned about the respective lifetimes of CEC adapters and
DRM connectors.

When you register the CEC adapter, its associated structure is
kzalloc'd, and freed when the DRM connector is freed (so when nobody has
any reference to it anymore: either when the device is torn down, or a
DP-MST hotplug scenario).

The CEC adapter however will only be freed when its own users will close
their file descriptor. So we can have a scenario when the CEC adapter is
still live but the DRM connector has been unregistered. Thus, the CEC
adapter data will have been kfree'd.

You might consider safe because $REASONS, but those need to be properly
detailed and explained.

That's another reason why I think that just putting the connector
pointer as data is better: connectors are refcounted, so we know those
aren't an issue.

Maxime>

--zeurqglj6czdayd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ/0iqAAKCRDj7w1vZxhR
xdWdAP9q44A678zD8WJJmtVxiTt5lWZn5UaMYOnwGGDARhyDbQD/XVEreZfGX2br
ElbrROnConG8KHHjwg2OxjYnfWsMrA8=
=uFDK
-----END PGP SIGNATURE-----

--zeurqglj6czdayd5--

