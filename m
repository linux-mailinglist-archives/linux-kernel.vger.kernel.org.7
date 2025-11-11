Return-Path: <linux-kernel+bounces-895373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87AEC4D9BE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293DF3A5769
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BEA3559D8;
	Tue, 11 Nov 2025 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOcIiS45"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06208313E05
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863119; cv=none; b=UdRF0BGkmZczIK+shNZ18neo9cZu9qEEa9ulAI7S3ESdNSkTa2XM3nzQJN6fz+5F9FBPhPWg4nSa0k/PpE+mzf7O5dnWVwbBoPq13sT13sTv1TV/xOrdnesxa9mswl6vqJ2RvfRgjajFYUbTa3Tx+QEe103RZYhFaGAJv+rYlIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863119; c=relaxed/simple;
	bh=gNT/Uo4xdhWVXycXECO5Je+H65HZUA8JBXnTC1VRVc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2ScPzpV8yw4Bu/WWwkExnVbx8/Rg677YPohR5Q87aLH6zIc+UJD0YmKuVQD0vBuOBa+n/+73SOUI2vS1BYvloP07vDuXYjqeLu/iXWTbZQ+RLin5oznbq0xh0pUhRZZjNAgIIesqln3dv4MgiEq7x612A5zmkm5+ZlKkDHmypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOcIiS45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10720C19422;
	Tue, 11 Nov 2025 12:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762863118;
	bh=gNT/Uo4xdhWVXycXECO5Je+H65HZUA8JBXnTC1VRVc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOcIiS45c7Au6mj3Kk0PzXhVNEL2ba3fDkwxC2EIaaZ+BvNl2EogO9oGBXn8zzbkB
	 pZAkt828LnyjR2wM4nszSsJjmdq2sUIHd2SON6Px/EC9KomY+b5fdM3+KDsyB/fKWz
	 CUMHv0TqjiCclvMGh5mL3JcR9bBY4btusqYVD4eOgo/TX1xxPRY/1sY35jjCTjYlmf
	 LvDkX6WHokHXF6Ju3TJIzufzez76TEy3pBtoeimaA6Vmkb7kvjtobkvkE/hQp1gf4z
	 ogOuRfLCPQjqXNIDZOtGo9xRsWGsc2MnzlfDzTKs9BW3Sd6+h7ElB3+uM2QTYrY0+K
	 sPxSrb1LjAi8g==
Date: Tue, 11 Nov 2025 12:11:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Sudarshan Shetty <tessolveupstream@gmail.com>
Cc: lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] regulator: Add Waveshare panel regulator driver
Message-ID: <aRMoCWLJoV2WVcyc@finisterre.sirena.org.uk>
References: <20251111104320.3425143-1-tessolveupstream@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q/JrH14tIszO65DP"
Content-Disposition: inline
In-Reply-To: <20251111104320.3425143-1-tessolveupstream@gmail.com>
X-Cookie: You dialed 5483.


--Q/JrH14tIszO65DP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 11, 2025 at 04:13:20PM +0530, Sudarshan Shetty wrote:

> This patch adds a regulator driver for Waveshare panels.
> The regulator provides controlled power sequencing and is also used
> to enable or disable the display backlight.

> +++ b/drivers/regulator/Makefile
> @@ -138,6 +138,7 @@ obj-$(CONFIG_REGULATOR_PBIAS) += pbias-regulator.o
>  obj-$(CONFIG_REGULATOR_PCAP) += pcap-regulator.o
>  obj-$(CONFIG_REGULATOR_RAA215300) += raa215300.o
>  obj-$(CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY)  += rpi-panel-attiny-regulator.o
> +obj-$(CONFIG_REGULATOR_WAVESHARE_TOUCHSCREEN)  += waveshare-panel-regulator.o
>  obj-$(CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_V2)  += rpi-panel-v2-regulator.o

Please keep this and the Kconfig sorted.

> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Waveshare International Limited
> + *

Please make the entire comment block a C++ one so things look more
intentional.

> +static const struct regmap_config waveshare_panel_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = REG_PWM,
> +};

Perhaps worth enabling caching to cut down on reads and hence improve
performance?

> +static int waveshare_panel_gpio_get(struct gpio_chip *gc, unsigned int offset)
> +{
> +	struct waveshare_panel_lcd *state = gpiochip_get_data(gc);
> +	u16 pwr_state;
> +
> +	mutex_lock(&state->pwr_lock);
> +	pwr_state = state->poweron_state & BIT(offset);
> +	mutex_unlock(&state->pwr_lock);
> +
> +	return !!pwr_state;
> +}

This will only read the value that has been set but there's support in
the driver for configuring the GPIO as an input, how would that work?

> +static int waveshare_panel_gpio_set(struct gpio_chip *gc, unsigned int offset,
> +				     int value)
> +{
> +	struct waveshare_panel_lcd *state = gpiochip_get_data(gc);
> +	u16 last_val;
> +
> +	if (offset >= NUM_GPIO)
> +		return 0;

Shouldn't this be an error?

> +	ret = waveshare_panel_i2c_read(i2c, REG_ID, &data);
> +	if (ret == 0)
> +		dev_info(&i2c->dev, "waveshare panel hw id = 0x%x\n", data);
> +
> +	ret = waveshare_panel_i2c_read(i2c, REG_SIZE, &data);
> +	if (ret == 0)
> +		dev_info(&i2c->dev, "waveshare panel size = %d\n", data);
> +
> +	ret = waveshare_panel_i2c_read(i2c, REG_VERSION, &data);
> +	if (ret == 0)
> +		dev_info(&i2c->dev, "waveshare panel mcu version = 0x%x\n",
> +			 data);

Shouldn't we take I/O errors on these registers more seriously?

> +	state->direction_state = 0;
> +	state->poweron_state = BIT(9) | BIT(8); // Enable VCC
> +	regmap_write(regmap, REG_TP, state->poweron_state >> 8);
> +	regmap_write(regmap, REG_LCD, state->poweron_state & 0xff);
> +	msleep(20);

Generally the default for regulators is to leave the hardware alone
unless explicitly configured to control it.

> +static const struct of_device_id waveshare_panel_dt_ids[] = {
> +	{ .compatible = "waveshare,touchscreen-panel-regulator" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, waveshare_panel_dt_ids);

This DT binding needs to be documented.

> +static struct i2c_driver waveshare_panel_regulator_driver = {
> +	.driver = {
> +		.name = "waveshare_touchscreen",
> +		.of_match_table = of_match_ptr(waveshare_panel_dt_ids),
> +	},
> +	.probe = waveshare_panel_i2c_probe,
> +	.remove	= waveshare_panel_i2c_remove,
> +	.shutdown = waveshare_panel_i2c_shutdown,
> +};

This doesn't actually seem to register a regulator, why put it in the
regulator subsystem?

--Q/JrH14tIszO65DP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkTKAgACgkQJNaLcl1U
h9BLzwf+IuLnAv83T3hG0zmHdT3suyv/C4ISPVWqC0XSelW0rz0ioUXp+kxZEmrk
Mt1rwR+kQQDHLhd3DxQXjUFzBjgDxAdoMwJ/qyutmNexGnBJzVfmlQLUy6L9sOAi
pDZj3uTZQbUAEW/8tzJmaROPJaTFKs8+rOmIqzljUW84cpAo2yB5c+wlJeGkUeuW
ZdIxlXaiC22G6s8PyLUX6iGScs0fbnUWzQwSpZfxZp7S/Dtixeq+raxidT+gD4gZ
c5HdJPIujBBrAnbiLwseEVAj1NRV34tB03of8VysaeBqr0u3xmucEeZOW3+qMkMS
W34JGunEwK35f1H1g97CeOhVP9w2lw==
=LRha
-----END PGP SIGNATURE-----

--Q/JrH14tIszO65DP--

