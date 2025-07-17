Return-Path: <linux-kernel+bounces-735157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736ACB08B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53FC64E3D24
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3EE28D8F8;
	Thu, 17 Jul 2025 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+R4rl+h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481E7263F4E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752751063; cv=none; b=TxM/031/uAN350TL83mV4/m6oGjeoU1GAleVPpogfznVqSWZseSx2ahYm3+T6g6cQJIFw9EFo3rvWr7mfPoZsI9ToYtBUc+qAMQfLfehfGg9aVOF4RFaRugRrMzK/tuLsGj8Y4+OH2WvlfA+wkdy4kU/cPZKJgdLIKlAUTLZA0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752751063; c=relaxed/simple;
	bh=ck3WJaJW7UsSniUfSg6V0s188bzrbx5xdODkJYkBbUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p88dZyFmoCvvPFcRJRC2Bxlku3KOzzOOQyNL6yao85mhyUyYgYBDffgPwhXRSL2VYu+9P0lr0GjXcP8Ckht3UGaT4XXXIVOMbXeT6+f0u8bVsDN+ern5UDhBDap+VLpPiujc/FHSe2WjaFRtdMjncjVrL8aoP+ZRRTPgH/caRf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+R4rl+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02BAC4CEE3;
	Thu, 17 Jul 2025 11:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752751062;
	bh=ck3WJaJW7UsSniUfSg6V0s188bzrbx5xdODkJYkBbUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+R4rl+h8eVjVlShHOCSq/FdYimQbkVITwRjMsuCGdAE8GK00CU/QAZPRG2MLRXnL
	 uc+bidRBwOrtVoO/iZrOqM6UX1Vo3kH2i8UtGHG9wTvu3+Bh6I3Q3ViOD1H6AUA0NP
	 3NQ7joVxmStt3SLcWPgJ8f16VpJv9cHKZO+XV0z5QLEbvkPjxFPRAjfeovPV+bRVWA
	 RaFPzR9vUMxKd+Yf8lAZIS8JOWFv9v94Na+6waoNw9Xl9SaccWwNA3fqtEJuAjUSHf
	 m30eJZdYYzECw9nW7c127uv2fFDJ6Kfv4yi2I9Q8U5ktvMgH1mA614fv8AiQiES9ca
	 A04BTQV18K5xQ==
Date: Thu, 17 Jul 2025 12:17:38 +0100
From: Mark Brown <broonie@kernel.org>
To: jeff_chang@richtek.com
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: rt5133: Add RT5133 PMIC regulator Support
Message-ID: <223ac66e-7aa2-4ffd-b4e6-07b55f53d84a@sirena.org.uk>
References: <20250717081623.2674579-1-jeff_chang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hEt47VzocmbKr/rL"
Content-Disposition: inline
In-Reply-To: <20250717081623.2674579-1-jeff_chang@richtek.com>
X-Cookie: May I ask a question?


--hEt47VzocmbKr/rL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 04:16:01PM +0800, jeff_chang@richtek.com wrote:
> From: Jeff Chang <jeff_chang@richtek.com>
>=20
> RT5133 is an intefrated chip. It includes 8 LDOs and 3 GPOs that

Integrated?

> Signed-off-by: Jeff Chang <jeff_chang@richtek.com>
> ---
>  .../bindings/regulator/richtek,rt5133.yaml    | 164 +++++
>  drivers/regulator/Kconfig                     |  13 +
>  drivers/regulator/Makefile                    |   1 +
>  drivers/regulator/rt5133-regulator.c          | 636 ++++++++++++++++++
>  4 files changed, 814 insertions(+)

The DT bindings should be sent as a separate patch copied to the DT
maintainers, this should be a small series.

> +  soft-start-time-sel:
> +    type: object
> +    description: |
> +      soft-start time of LDO
> +        0: 1ms
> +        1: 2ms
> +        2: 4ms
> +        3: 8ms

Implement the set_soft_start() operation and use standard bindings for
this.

> +  rt5133-ldo1-supply:
> +    description: |
> +      Only for LDO7 LDO8, pvin7 and pvin8 reference design are RT5133 LD=
O1.
> +      If not connect to LDO1 vout, this property for pvin7 and pvin8 is =
necessary.

You should probably just define all the supplies for all the regulators,
then if some of them are supplied from other regulators on the device
that can be represented naturally.

> +++ b/drivers/regulator/rt5133-regulator.c
> @@ -0,0 +1,636 @@
> +// SPDX-License-Identifier: GPL-4.0
> +/*
> + * Copyright (C) 2025 Richtek Technology Corp.
> + *
> + * Author: ChiYuan Huang <cy_huang@richtek.com>
> + */

What's with the GPL-4.0 license?  The kernel is GPL 2.0 plus extras, and
AFAIK there is no GPL-4.0.

Please also make the entire comment a C++ one so things look more intention=
al.

> +static bool dbg_log_en;
> +module_param(dbg_log_en, bool, 0644);
> +#define rt_dbg(dev, fmt, ...)	\
> +	do { \
> +		if (dbg_log_en) \
> +			dev_info(dev, "%s " fmt, __func__, ##__VA_ARGS__); \
> +	} while (0)

Just use the standard dev_dbg().

> +#define RT5133_DRV_VERSION		"1.0.2_MTK"

We normally don't version drivers, the versions don't get updated by
people doing normal kernel work.

> +static irqreturn_t rt5133_intr_handler(int irq_number, void *data)
> +{
> +	struct rt5133_priv *priv =3D data;
> +	u32 intr_evts =3D 0, handle_evts;
> +	int i, ret;
> +
> +	ret =3D regmap_bulk_read(priv->regmap, RT5133_REG_BASE_EVT, &intr_evts,
> +			       RT5133_INTR_BYTE_NR);
> +	if (ret)
> +		goto out_intr_handler;
> +
> +	handle_evts =3D intr_evts & RT5133_BASE_EVT_MASK;
> +	/*
> +	 * VREF_EVT is a special case, if base off
> +	 * this event will also be trigger. Skip it
> +	 */
> +	if (handle_evts & ~RT5133_VREF_EVT_MASK)
> +		dev_info(priv->dev, "base event occurred [0x%02x]\n",
> +			 handle_evts);

This logging might get noisy.  Also if there are no events the handler
should return IRQ_NONE so genirq can handle things if they go wrong
(same for the read error above).

> +static const struct regmap_config rt5133_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D RT5133_REG_LDO8_CTRL4,
> +};

May as well enable a cache for the non-volatile registers?

> +static int rt5133_probe(struct i2c_client *i2c)
> +{
> +	struct rt5133_priv *priv;
> +	struct regulator_config config =3D {0};
> +	int i, ret;
> +
> +	dev_info(&i2c->dev, "%s start(%s)\n", __func__, RT5133_DRV_VERSION);

Remove all these dev_info() logs during normal operation, logging the
chip revision if you read one would make sense but just "I'm here" logs
aren't so useful.

> +	priv->gc.label =3D dev_name(&i2c->dev);
> +	priv->gc.parent =3D &i2c->dev;
> +	priv->gc.base =3D -1;
> +	priv->gc.ngpio =3D RT5133_GPIO_NR;
> +	priv->gc.set =3D rt5133_gpio_set;
> +	priv->gc.get =3D rt5133_gpio_get;
> +	priv->gc.direction_output =3D rt5133_gpio_direction_output;

These should be _cansleep operations given that the device is controlled
via I2C.

--hEt47VzocmbKr/rL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh429IACgkQJNaLcl1U
h9DKbgf/RLalWU1f+igInC1kHGYOwAtnmOg8y7lOxzJYkKFwxIB5tUFRuPBnes9j
gpWbJvFdNk0LnvqgOVW4zl6i2i2DmhyrU+2a9gQA7onKq8AB/M/cXp+1ipwqWa++
qJLn7/8sneOAK2ErVvVYD1sCQjd+BKJNC+odLInE9UYXhxBIC53jwssGwDs/sPPG
r36sENNn2J4kpa94MHqlHLpbXmva2rQjl2KVF7F0H+l/8Y9CuvzkijrQCWaCS1yI
RCR1BvrymhjR57x4gt4GvYR7ZmtEF4jDsVt6N/wY/gPrrLQfuoE1dC6+6X8vs+DH
Iq4YUGoOJd2BiSFsk1CPW9js1kU6gw==
=Y2gP
-----END PGP SIGNATURE-----

--hEt47VzocmbKr/rL--

