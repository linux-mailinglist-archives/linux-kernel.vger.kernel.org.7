Return-Path: <linux-kernel+bounces-874151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB0DC15A18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E0F401C28
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2193469FA;
	Tue, 28 Oct 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Sfds78sK"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2601E343218;
	Tue, 28 Oct 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666586; cv=none; b=mlOoEVGvNDRerU+oyofwyrYlydYD7UcduVwl70AV/r90OSwWxBkTTrgq6qnVOnySA0/+xRTvVtPTK0Dxgxec4LL8tBGZc/ppSuJ+Kw1t4PHNPFkC/RXla703jDpF2cIiT9SSJJgJq2xPwvGYj21mdYp2CZidQvHLyTosJuIwfS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666586; c=relaxed/simple;
	bh=XCKTlC1GxsaJgr6vkGg2GACzmsJhoqQmJ67EuG/Y8Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1vp3YjuNeUfrdjCQCkFUgS3cjlRAMTtmas2oXC6/GoL2ob1xghQORy2V8dC5hQeS31KSEvYSDbJXhULSa1OHc0ZbHd/6F1e8nJ2mUhFv/B/FU3Ref7K+4lbIZkXPw9yWQGLo0jqKvuKaQMCoi6r85FIDCVYX7upwFa6DP8oSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Sfds78sK; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [193.209.96.36])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 6AA35176B;
	Tue, 28 Oct 2025 16:47:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761666473;
	bh=XCKTlC1GxsaJgr6vkGg2GACzmsJhoqQmJ67EuG/Y8Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sfds78sK+IHQz4stuFpGc3nE7KU9QEN/VYpp9wJ93nOvkhwmCHtMFF8V1lylsohMA
	 +brd1O3pA0DVbOn0rWD2kmnsDyWfv2SzwLDyf2JpxOGcijpsFArTbrbje+9ZXRzzJt
	 3tPy9K2h4MxBpgqt377vuVxR9mvTZw4RixSIN9jA=
Date: Tue, 28 Oct 2025 17:49:29 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm: bridge: add enable gpio for display-connector
Message-ID: <20251028154929.GA797@pendragon.ideasonboard.com>
References: <20251028-enable-gpio-dp-connector-v1-0-2babdf1d2289@oss.qualcomm.com>
 <20251028-enable-gpio-dp-connector-v1-2-2babdf1d2289@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028-enable-gpio-dp-connector-v1-2-2babdf1d2289@oss.qualcomm.com>

On Tue, Oct 28, 2025 at 08:56:50PM +0530, Prahlad Valluru wrote:
> In some cases, need gpio to be set for the connector
> enable. Add optional enable gpio to display-connector.
> 
> Signed-off-by: Prahlad Valluru <venkata.valluru@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/bridge/display-connector.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
> index e9f16dbc9535..52f5e4175e64 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
> @@ -21,6 +21,7 @@ struct display_connector {
>  	struct drm_bridge	bridge;
>  
>  	struct gpio_desc	*hpd_gpio;
> +	struct gpio_desc	*enable_gpio;
>  	int			hpd_irq;
>  
>  	struct regulator	*supply;
> @@ -298,6 +299,12 @@ static int display_connector_probe(struct platform_device *pdev)
>  					     "Unable to retrieve HPD GPIO\n");
>  
>  		conn->hpd_irq = gpiod_to_irq(conn->hpd_gpio);
> +
> +		conn->enable_gpio = devm_gpiod_get_optional(&pdev->dev, "enable",
> +							 GPIOD_OUT_HIGH);

What does it mean to "enable the connector" ? Given that you don't set
the GPIO value at runtime, this seems to be a hack that is probably
better handled with GPIO hogs in the device tree.

> +		if (IS_ERR(conn->enable_gpio))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(conn->enable_gpio),
> +					     "Unable to retrieve enable GPIO\n");
>  	} else {
>  		conn->hpd_irq = -EINVAL;
>  	}

-- 
Regards,

Laurent Pinchart

