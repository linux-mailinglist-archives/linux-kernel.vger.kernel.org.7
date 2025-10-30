Return-Path: <linux-kernel+bounces-878278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6F1C202A4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEED1188512E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA683546E3;
	Thu, 30 Oct 2025 13:06:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ABC34D923
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829611; cv=none; b=piwwXuG6b0XqCbdGdPPeXhZvVDYJdjOZvM18Kq/shX9vzDbncd2SUx1XDlipnEH9NrnYcjeBn6PbIycHDAqnCI2pUjDMrlQTtO3i3o06980g2yGHgoDyfZJG/eXmTajJJO+Z4286WnTuB0mV55G61tV1jUY3qYY5lM+nKfb1sOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829611; c=relaxed/simple;
	bh=tyv5U14rZUqntfSo8Ih2AZ1Lql7y8cKlmbDYXAk3K1c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QDQlLqT5Xhsk/CjxGCIfiAxRPqgpk+ptDSrYxK6cH3mDqaRKRljR154XNC15tWlSZs9RkSq5Cn2bNpZhZCjEbVqpgYVvO8rTX4S1wdU7TMh2/G/ADIvoHZ76B+0I+A8MmlHfGUH7gWd2sgxsGzyA0Ko/VAt2ev98KAdnLig0OYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESMJ-0006ym-Cs; Thu, 30 Oct 2025 14:06:31 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESMI-006DXP-03;
	Thu, 30 Oct 2025 14:06:30 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vESMH-000000009YP-3s7P;
	Thu, 30 Oct 2025 14:06:29 +0100
Message-ID: <105ed81ed67d8e4cacb63a83a606e206a4d6f310.camel@pengutronix.de>
Subject: Re: [PATCH v3 5/8] reset: imx8mp-audiomix: Switch to using regmap
 API
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>, Abel Vesa
	 <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, Michael Turquette
	 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam
	 <festevam@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang
	 <shengjiu.wang@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,  Pengutronix Kernel Team	
 <kernel@pengutronix.de>
Date: Thu, 30 Oct 2025 14:06:29 +0100
In-Reply-To: <20251029135229.890-6-laurentiumihalcea111@gmail.com>
References: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
	 <20251029135229.890-6-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
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

On Mi, 2025-10-29 at 06:52 -0700, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>=20
> As far as the Linux kernel is concerned, block devices such as i.MX8MP's
> AUDIOMIX block control or i.MX8ULP's SIM LPAV can simultaneously act as
> clock controllers, reset controllers or mux controllers. Since these IPs
> offer different functionalities through different subsystem APIs, it's
> important to make sure that the register R-M-W cycles are performed under
> the same lock across all subsystem APIs. This will ensure that registers
> will not end up with the wrong values because of race conditions (e.g.
> clock consumer tries to update block control register A, while, at the
> same time, reset consumer tries to update the same block control register=
).
>=20
> However, the aforementioned race conditions will only impact block contro=
l
> IPs which use the same register for multiple functionalities. For example=
,
> i.MX8MP's AUDIOMIX block control IP provides clock gating functionalities
> and reset control functionalities through different registers. This is wh=
y
> the current approach (i.e. clock control and reset control work using
> different locks) has worked well so far.
>=20
> Since we want to extend this driver to be usable for i.MX8ULP's SIM LPAV
> block control IP, we need to make sure that clock control, reset control,
> and mux control APIs use the same lock since all of these functionalities
> are performed using the SYSCTRL0 register.
>=20
> To do so, we need to switch to the regmap API and, if possible, use the
> parent device's regmap, which, in the case of i.MX8ULP, will be the clock
> controller. This way, we can make sure that the clock gates and the reset
> controller will use the same lock to perform the register R-M-W cycles.
>=20
> This change will also work fine for cases where we don't really need to
> share the lock across multiple APIs (e.g. i.MX8MP's AUDIOMIX block
> control) since regmap will take care of the locking we were previously
> explicitly performing in the driver.
>=20
> The transition to the regmap API also involves some cleanup. Specifically=
,
> we can make use of devres to unmap the device's memory and get rid of the
> memory mapping-related error paths and the remove() function altogether.
>=20
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  drivers/reset/reset-imx8mp-audiomix.c | 91 +++++++++++++++++----------
>  1 file changed, 57 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-=
imx8mp-audiomix.c
> index e9643365a62c..3f6d11270918 100644
> --- a/drivers/reset/reset-imx8mp-audiomix.c
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/regmap.h>
>  #include <linux/reset-controller.h>
> =20
>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
> @@ -42,8 +43,8 @@ static const struct imx8mp_reset_map reset_map[] =3D {
> =20
>  struct imx8mp_audiomix_reset {
>  	struct reset_controller_dev rcdev;
> -	spinlock_t lock; /* protect register read-modify-write cycle */
>  	void __iomem *base;

Drop base as well, better let devres handle this.

[...]

> +/* assumption: registered only if not using parent regmap */
> +static void imx8mp_audiomix_reset_iounmap(void *data)

Pass base instead of dev.

> +{
> +	struct imx8mp_audiomix_reset *priv =3D dev_get_drvdata(data);
> +
> +	iounmap(priv->base);

	void __iomem *base =3D data;

	iounmap(base);

> +}
> +
> +/* assumption: dev_set_drvdata() is called before this */

Why not just pass priv instead of dev?

> +static int imx8mp_audiomix_reset_get_regmap(struct device *dev)
> +{
> +	struct imx8mp_audiomix_reset *priv;
> +	int ret;
> +
> +	priv =3D dev_get_drvdata(dev);
> +
> +	/* try to use the parent's regmap */
> +	priv->regmap =3D dev_get_regmap(dev->parent, NULL);
> +	if (priv->regmap)
> +		return 0;
> +
> +	/* ... if that's not possible then initialize the regmap right now */
> +	priv->base =3D of_iomap(dev->parent->of_node, 0);

Make base a local variable ...

> +	if (!priv->base)
> +		return dev_err_probe(dev, -ENOMEM, "failed to iomap address space\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, imx8mp_audiomix_reset_iounmap, de=
v);

... and pass it as data instead of dev.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register action\n");
> +
> +	priv->regmap =3D devm_regmap_init_mmio(dev, priv->base, &regmap_config)=
;
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "failed to initialize regmap\n");
> +
> +	return 0;
> +}
> +
>  static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
>  				       const struct auxiliary_device_id *id)
>  {
> @@ -105,36 +139,26 @@ static int imx8mp_audiomix_reset_probe(struct auxil=
iary_device *adev,
>  	if (!priv)
>  		return -ENOMEM;
> =20
> -	spin_lock_init(&priv->lock);
> -
>  	priv->rcdev.owner     =3D THIS_MODULE;
>  	priv->rcdev.nr_resets =3D ARRAY_SIZE(reset_map);
>  	priv->rcdev.ops       =3D &imx8mp_audiomix_reset_ops;
>  	priv->rcdev.of_node   =3D dev->parent->of_node;
>  	priv->rcdev.dev	      =3D dev;
>  	priv->rcdev.of_reset_n_cells =3D 1;
> -	priv->base            =3D of_iomap(dev->parent->of_node, 0);
> -	if (!priv->base)
> -		return -ENOMEM;
> =20
> +	/* keep before call to imx8mp_audiomix_reset_init_regmap() */

Not needed if priv is passed to it directly.

regards
Philipp

