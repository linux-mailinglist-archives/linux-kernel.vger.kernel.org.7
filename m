Return-Path: <linux-kernel+bounces-876079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1243C1A902
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C682567A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FD478F29;
	Wed, 29 Oct 2025 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="QQ/4RhAF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="DdRe5bk6"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99528642D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742750; cv=pass; b=IMB6ekLuy86LKcpq69+xE2RQH8ySftxX2qHMEegUkKYz3lmNPBRxbc8XF3O8Cs+eHm1MDLagCdtrxa/VEsBCg1pHiGvA6Ib6gM5pGRMzkx13pzUTjwKCPyY922wo6Q+/ZNlXLUxhqAQqktD8pvCijV+IV43K+uqqdHVa7DmhCS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742750; c=relaxed/simple;
	bh=qqXZpmRAdwZJbQzpBZ9hVLXtxfiYzD2nZK2ZSYHeI54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkjlrJCRkJAn7Nk+AfSAnfZKHN9FM+8oGEYFr6nOivlEAlaAvKMTNZMS+yWs2bdZATkJhze6O8KTXBhfb8WKEmvd+XWZqqgdWQzzJ2nf32QKJBcrLaqPee1qhoD206v261jbe4qA11enETWSn0cnHoZoQUo7CZrm8w++wzy8tOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=QQ/4RhAF; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=DdRe5bk6; arc=pass smtp.client-ip=185.56.87.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-h8q8.prod.antispam.mailspamprotection.com; s=arckey; t=1761742748;
	 b=iguoyQFoogZ0e7B72MoS9ciJyyPNpwwgLW2xR7V9pIlF/K3KR25qAJt8pRSG/ORjqKo2DMbqa1
	  88Og8AC1or33PaiRzTpnpodwYDLkciQMo9WhJ2i8PIAU+wY8Vt2iG0Pz8cfw9zUkTdIkpGSfSG
	  CmaBH4UQjOnvyHo1zPBVZk1vZypajiyQEQtJrxl0X05UjYJgccedwyWF0D+t2Sl3S9/OeUL9gC
	  g+iAKMD3pcEB/w5Jp8l6vWg7p++wV+IT1uRTa55YLY/f3zWq3cy1jijnIKEQXa5hIMDPb8KjJm
	  9SN/RFvwKGi6meCfWw3/BkvzsliQCYRSw9f4yrYW6JOIew==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-h8q8.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-h8q8.prod.antispam.mailspamprotection.com; s=arckey; t=1761742748;
	bh=qqXZpmRAdwZJbQzpBZ9hVLXtxfiYzD2nZK2ZSYHeI54=;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	  To:From:DKIM-Signature:DKIM-Signature;
	b=cGBeq4Uy+WOAH6A/GdwFwB9l0ffR2/HD9XRsQ+tObFOI42ldb+xIhplTwtCVS8EkLfvL2SUWyZ
	  jVaRZt0QMmr9IJ0rJYSJ3Zfs5JpcX11oBTkN+BbQQkIpjqobEDCaVjV5pvA/Veb2xFqczvHtNl
	  ah5Bx81skjc63gg3x+sh6lFAvO186k5TLu7+I2ayQ0Jv3gWimoCJKOn8U+WhdjWzpZmi4D8HdW
	  z8SuGWVXm26l8cyPwyBzSAXsHDnze4wy5jdlqGSuJzLPgPsTMZLhRc+yBFHgf/2xMNXmY/ZzSS
	  BYRjWPMQOpRWpcWUQzZqQ3mJgOG4xX4aC/ERkffgPVf3YQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=3oSppA+afvyqUxNHhPIkWdr61ZGsrwZwGDBFFJQIi6Q=; b=QQ/4RhAF13tVg8cBIoUNhCwEPQ
	Iy07DD4HCahmPeb51u2EcDsbAf9U7kjJqwUMNtKOt2vUYuR+GAE2EYCVJXtV6/XdC6EBphq/1nNZ6
	+xdPHg8utqTbxqkw5nI58n5mTAPBacG4rp+slxiUJEyjoQIs8hV6GRNIIg2P37myR8YA=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-h8q8.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vE5lX-0000000DiyE-1wMJ
	for linux-kernel@vger.kernel.org;
	Wed, 29 Oct 2025 12:59:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=3oSppA+afvyqUxNHhPIkWdr61ZGsrwZwGDBFFJQIi6Q=; b=DdRe5bk6zHEGKn06FFuSn8vLai
	gOfhjPA/iOu0RxB4imGfGZyjzmqBZzS8mNaAiMMhNRUVBJdllLCWS4IHvuzCSBzbNl2XBRlejr2dm
	awE0AYwn5f4hU+XkXqwGN00y4MdlnIhla834mpoOz7TaYBCtVykxqVSAn07lTJRGK1FI=;
Received: from [95.75.8.65] (port=19426 helo=fedora.localnet)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vE5l0-00000000CSz-20fj;
	Wed, 29 Oct 2025 12:58:30 +0000
From: Francesco Valla <francesco@valla.it>
To: imx@lists.linux.dev, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: dri-devel@lists.freedesktop.org, Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/9] drm/bridge: fsl-ldb: Get the next non-panel bridge
Date: Wed, 29 Oct 2025 13:58:14 +0100
Message-ID: <2192154.9o76ZdvQCi@fedora>
In-Reply-To: <20250911-dcif-upstreaming-v5-2-a1e8dab8ae40@oss.nxp.com>
References:
 <20250911-dcif-upstreaming-v5-0-a1e8dab8ae40@oss.nxp.com>
 <20250911-dcif-upstreaming-v5-2-a1e8dab8ae40@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2765006.vuYhMxLoTh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: db48996b8cdd53a1528b9dd9605700b0
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vE5lX-0000000DiyE-1wMJ-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-h8q8.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

--nextPart2765006.vuYhMxLoTh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Francesco Valla <francesco@valla.it>
Date: Wed, 29 Oct 2025 13:58:14 +0100
Message-ID: <2192154.9o76ZdvQCi@fedora>
In-Reply-To: <20250911-dcif-upstreaming-v5-2-a1e8dab8ae40@oss.nxp.com>
MIME-Version: 1.0

Hi,

On Thursday, 11 September 2025 at 13:37:02 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com> wrote:
> From: Liu Ying <victor.liu@nxp.com>
> 
> The next bridge in bridge chain could be a panel bridge or a non-panel
> bridge.  Use devm_drm_of_get_bridge() to replace the combination
> function calls of of_drm_find_panel() and devm_drm_panel_bridge_add()
> to get either a panel bridge or a non-panel bridge, instead of getting
> a panel bridge only.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/gpu/drm/bridge/fsl-ldb.c | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
> index 5c3cf37200bcee1db285c97e2b463c9355ee6acb..665053d0cb79d2b4f50e69c397863ab024553867 100644
> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
> @@ -15,7 +15,6 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
>  #include <drm/drm_of.h>
> -#include <drm/drm_panel.h>
>  
>  #define LDB_CTRL_CH0_ENABLE			BIT(0)
>  #define LDB_CTRL_CH0_DI_SELECT			BIT(1)
> @@ -86,7 +85,7 @@ static const struct fsl_ldb_devdata fsl_ldb_devdata[] = {
>  struct fsl_ldb {
>  	struct device *dev;
>  	struct drm_bridge bridge;
> -	struct drm_bridge *panel_bridge;
> +	struct drm_bridge *next_bridge;
>  	struct clk *clk;
>  	struct regmap *regmap;
>  	const struct fsl_ldb_devdata *devdata;
> @@ -118,7 +117,7 @@ static int fsl_ldb_attach(struct drm_bridge *bridge,
>  {
>  	struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
>  
> -	return drm_bridge_attach(encoder, fsl_ldb->panel_bridge,
> +	return drm_bridge_attach(encoder, fsl_ldb->next_bridge,
>  				 bridge, flags);
>  }
>  
> @@ -292,9 +291,7 @@ static const struct drm_bridge_funcs funcs = {
>  static int fsl_ldb_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *panel_node;
>  	struct device_node *remote1, *remote2;
> -	struct drm_panel *panel;
>  	struct fsl_ldb *fsl_ldb;
>  	int dual_link;
>  
> @@ -317,33 +314,27 @@ static int fsl_ldb_probe(struct platform_device *pdev)
>  	if (IS_ERR(fsl_ldb->regmap))
>  		return PTR_ERR(fsl_ldb->regmap);
>  
> -	/* Locate the remote ports and the panel node */
> +	/* Locate the remote ports. */
>  	remote1 = of_graph_get_remote_node(dev->of_node, 1, 0);
>  	remote2 = of_graph_get_remote_node(dev->of_node, 2, 0);
>  	fsl_ldb->ch0_enabled = (remote1 != NULL);
>  	fsl_ldb->ch1_enabled = (remote2 != NULL);
> -	panel_node = of_node_get(remote1 ? remote1 : remote2);
>  	of_node_put(remote1);
>  	of_node_put(remote2);
>  
> -	if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled) {
> -		of_node_put(panel_node);
> -		return dev_err_probe(dev, -ENXIO, "No panel node found");
> -	}
> +	if (!fsl_ldb->ch0_enabled && !fsl_ldb->ch1_enabled)
> +		return dev_err_probe(dev, -ENXIO, "No next bridge node found");
>  
>  	dev_dbg(dev, "Using %s\n",
>  		fsl_ldb_is_dual(fsl_ldb) ? "dual-link mode" :
>  		fsl_ldb->ch0_enabled ? "channel 0" : "channel 1");
>  
> -	panel = of_drm_find_panel(panel_node);
> -	of_node_put(panel_node);
> -	if (IS_ERR(panel))
> -		return PTR_ERR(panel);
> -
> -	fsl_ldb->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
> -	if (IS_ERR(fsl_ldb->panel_bridge))
> -		return PTR_ERR(fsl_ldb->panel_bridge);
> -
> +	fsl_ldb->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node,
> +						      fsl_ldb->ch0_enabled ? 1 : 2,
> +						      0);
> +	if (IS_ERR(fsl_ldb->next_bridge))
> +		return dev_err_probe(dev, PTR_ERR(fsl_ldb->next_bridge),
> +				     "failed to get next bridge\n");
>  
>  	if (fsl_ldb_is_dual(fsl_ldb)) {
>  		struct device_node *port1, *port2;
> 
> 

Reviewed-by: Francesco Valla <francesco@valla.it>

This is also required to complete support for some of the i.MX8MP
platforms for which a DTS already exists, as well as for upcoming i.MX93
work (see [2]).

[1] https://elixir.bootlin.com/linux/v6.17.5/source/arch/arm64/boot/dts/freescale/imx8mp-evk-lvds0-imx-dlvds-hdmi-channel0.dtso
[2] https://lore.kernel.org/all/20251028-imx93_ldb_bridge-v1-1-fca2e7d60e0a@valla.it/


Thank you!

Francesco


--nextPart2765006.vuYhMxLoTh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRUrtjevJ039mawAeLir2xSXEi5AAUCaQIPZgAKCRDir2xSXEi5
AMbCAP42EvVfJ0roztG8NupiiGaTkb86WaCv99Prrby9Vkr0SwD+K9vUyxfRtmxI
8VKWhxQWZp0tPzFGBEz88OWVOOp7fAU=
=BQyw
-----END PGP SIGNATURE-----

--nextPart2765006.vuYhMxLoTh--




