Return-Path: <linux-kernel+bounces-771080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962D3B282A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66AB1CE598E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB4121D3F4;
	Fri, 15 Aug 2025 15:06:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C6C4086A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755270418; cv=none; b=oiVomNPXrfOWJMb8nW0LlgXDeWLpeujafC/6IGdm5oCd+oUmPQoVFbLUj1Btetqkdmw1vbfKPN0D0l9HzjQpPS2oNOLggcommY1bNGmZgkGwtpEfUjG16bTE9aerdQb790QUaiElVUpBeBhdWdiJgoK6npt88kQV4XYUYpYtiak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755270418; c=relaxed/simple;
	bh=BcITpFybWBt3uJnJlV7HPPQk242CaQC+wMDxngtmLG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MbKORuompd+/TAXnRRVnWWHUyDBGVZOq8nS7hUEmg/scgd2iBEqMKr4nEDa2CyjEVogSkrzXCVDS4VHuGhmizKLc1tYhupT9GdjC4Mt68H09sMxGiP5OYaU6Br+V5SAWR8CyKXkStJ5AtpsI65pxCAzEXODXsa3Yz+SMREicGl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umw10-0004t6-6g; Fri, 15 Aug 2025 17:06:46 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umw0x-000R8g-1i;
	Fri, 15 Aug 2025 17:06:43 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1umw0x-000PY3-1L;
	Fri, 15 Aug 2025 17:06:43 +0200
Message-ID: <93025d4cb696f06228e1c84a7c22dbcede6e77a3.camel@pengutronix.de>
Subject: Re: [PATCH 04/21] drm: remove unneeded 'fast_io' parameter in
 regmap_config
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Andrzej Hajda
 <andrzej.hajda@intel.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Liu Ying <victor.liu@nxp.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>,  Fabio Estevam <festevam@gmail.com>,
 Sandy Huang <hjc@rock-chips.com>, Heiko =?ISO-8859-1?Q?St=FCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Date: Fri, 15 Aug 2025 17:06:43 +0200
In-Reply-To: <20250813161517.4746-5-wsa+renesas@sang-engineering.com>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
	 <20250813161517.4746-5-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mi, 2025-08-13 at 18:14 +0200, Wolfram Sang wrote:
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> No dependencies, can be applied directly to the subsystem tree. Buildbot =
is
> happy, too.
>=20
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c   | 1 -
>  drivers/gpu/drm/imx/dc/dc-cf.c                   | 1 -
>  drivers/gpu/drm/imx/dc/dc-de.c                   | 1 -
>  drivers/gpu/drm/imx/dc/dc-ed.c                   | 2 --
>  drivers/gpu/drm/imx/dc/dc-fg.c                   | 1 -
>  drivers/gpu/drm/imx/dc/dc-fl.c                   | 1 -
>  drivers/gpu/drm/imx/dc/dc-fw.c                   | 2 --
>  drivers/gpu/drm/imx/dc/dc-ic.c                   | 1 -
>  drivers/gpu/drm/imx/dc/dc-lb.c                   | 2 --
>  drivers/gpu/drm/imx/dc/dc-tc.c                   | 1 -
>  drivers/gpu/drm/imx/ipuv3/imx-tve.c              | 2 --
>  drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c | 1 -
>  12 files changed, 16 deletions(-)
>=20
[...]
> diff --git a/drivers/gpu/drm/imx/ipuv3/imx-tve.c b/drivers/gpu/drm/imx/ip=
uv3/imx-tve.c
> index c5629e155d25..b34037d0d7a8 100644
> --- a/drivers/gpu/drm/imx/ipuv3/imx-tve.c
> +++ b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
> @@ -457,8 +457,6 @@ static struct regmap_config tve_regmap_config =3D {
> =20
>  	.readable_reg =3D imx_tve_readable_reg,
> =20
> -	.fast_io =3D true,
> -
>  	.max_register =3D 0xdc,
>  };
> =20

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

