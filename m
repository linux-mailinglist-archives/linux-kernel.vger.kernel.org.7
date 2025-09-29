Return-Path: <linux-kernel+bounces-836629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4567BAA31A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F2216399E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC7A21D5B0;
	Mon, 29 Sep 2025 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dV9wat6n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C121257F;
	Mon, 29 Sep 2025 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167535; cv=none; b=Jwb+4FuQt0S6XoWq96aSNof6ts8VqV3Fogwwjpri4MZZO7WdAHzanj6YvXpDLygZOjlWn/5X0lEeBVuww8Zl6vxmjgZDZaGRXJ9BTHDRhobHDZ/lLXpxibULPPR88Gw/qqk+eecJJWg3udpfPbdOIjd4PeVySqJa/FPWN5s0Ank=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167535; c=relaxed/simple;
	bh=ws08pkjsBDlI4gUePxOGG3L4rQzUt1yT7G7SzMo4u3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/X2t1O6x5IgIWYIW3qRQUQj+mULz/N5IOg0Jao6k8E/oLTBSZt8j5yoo1s9gmhlKAj6bE8j/YgrgOek8eEBNHvodTpVCFDdRUi2QmoSG2EzzdzrVgpPMeReazmLgKcYWEVfmAG4C5g90LZo6AA037ImuZfAw4BRkh4F/oC0Bl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dV9wat6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15091C4CEF4;
	Mon, 29 Sep 2025 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759167534;
	bh=ws08pkjsBDlI4gUePxOGG3L4rQzUt1yT7G7SzMo4u3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dV9wat6nw14mq0Z4D3TY/1aU9t75NnS0I2H/gUowV40XE3JWVGTsq50qDK2INWXHo
	 /LhKlr2phCv8eonJczeX3LSLc7rYhNm2ljw8cvfO1KrMVBXWSehZk9GRwOyFqnJ060
	 CHzcUNYmD1zplvty0WgpveV1oAE7gxfKV2y1iFC3zwrLk6S8fbkCkDA2IrqqZIGm1y
	 HkQeBvJMD9OKnz5KT5RcMQEZUNdUdDYSmkqKUj57XF47LdI2ITyorU11TyhTiRhvuc
	 mhyQTqHOFNlvNlgzLmoSGg+TuRvMCqGU/IvRec0BoGahoKbePjrR/0Kcf8rwoVcTBM
	 vzklfkpZlDxbg==
Date: Mon, 29 Sep 2025 18:38:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Joan-Na-adi <joan.na.devcode@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/3] regulator: max77675: Add MAX77675 regulator driver
Message-ID: <aNrEIZBhh6PllyOy@finisterre.sirena.org.uk>
References: <20250929105618.177511-1-joan.na@analog.com>
 <20250929105618.177511-3-joan.na@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Md7+imvniJ2q5CYC"
Content-Disposition: inline
In-Reply-To: <20250929105618.177511-3-joan.na@analog.com>
X-Cookie: The star of riches is shining upon you.


--Md7+imvniJ2q5CYC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 07:56:17PM +0900, Joan-Na-adi wrote:
> This patch adds support for the Maxim Integrated MAX77675 PMIC regulator.
>=20
> The MAX77675 is a compact, highly efficient SIMO (Single Inductor Multipl=
e Output)

This looks basically good, there's some review comments below but
they're mostly cosmetic rather than substantial.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/20250927.cU4bEADk-lkp@intel=
=2Ecom/

There's no need to do this when you fixed a bug in a patch that was
never applied, it's only relevant when fixing a bug in code that was
merged.

> +static const struct regmap_config max77675_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D MAX77675_MAX_REGISTER,
> +	.cache_type =3D REGCACHE_NONE,
> +};

_NONE is the default, no need to specify it.  Though it'll generally
improve performance to have a cache so _MAPLE (plus a volatile_reg() op
for the interrupt/status registers), it'll cut down on I2C traffic which
is slow.

> +	/* Debug print all parsed values */
> +	pr_info("MAX77675 config parsed:\n"
> +		 "  dvs_slew_rate: %u\n"
> +		 "  latency_mode: %u\n"
> +		 "  drv_sbb_strength: %u\n"
> +		 "  manual_reset_time: %u\n"
> +		 "  en_pullup_disable: %u\n"
> +		 "  bias_low_power_request: %u\n"
> +		 "  simo_int_ldo_always_on: %u\n"
> +		 "  en_mode: %u\n"
> +		 "  en_debounce_time: %u\n",
> +		 config->drv_slew_rate,
> +		 config->latency_mode,
> +		 config->drv_sbb_strength,
> +		 config->manual_reset_time,
> +		 config->en_pullup_disable,
> +		 config->bias_low_power_request,
> +		 config->simo_int_ldo_always_on,
> +		 config->en_mode,
> +		 config->en_debounce_time);

This is a bit noisy, we don't tend to print the entire config out during
boot.  It's also going to be formatted weirdly (eg, only a timestamp at
the start).  I'd tend to drop this, or at most make it debug or vdebug
level.

> +static void max77675_regulator_remove(struct i2c_client *client)
> +{
> +	struct max77675_regulator *maxreg =3D i2c_get_clientdata(client);
> +
> +	dev_info(maxreg->dev, "MAX77675 regulators removed\n");
> +}

This is a bit noisy again.  In general the driver should be silent for
non-error stuff or parsing ID information from the hardware, it makes
it easier to find important informtion and with serial consoles lots of
prints from many drivers can end up slowing boot noticably.

--Md7+imvniJ2q5CYC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjaxCAACgkQJNaLcl1U
h9CFiAf/RHSTkU+fTdiF3dKpYoxmDPNJHjVzqLWHZwStm0FmLE/97lPltOAiYNUg
d0GNOUbGMxLL53GdGncgc5bIUEXnFBuhlq1D5bsCKYd+2BsA26ydhQBC2k6CgDPe
exI3hBPo9EV6KD20qAS0/RAx0UTkOyxpt5yjFjfJ5M1dppsw1/8MdDrjBQfyQ+kY
2Xm13NJ2ZmZiarNEXoOhVEeCOdpjUGBKY9p4SldG8M/ybbA1xoCJF3mNal/F+BhI
dYdPmZPphHEFkFxsQgeC9Qnpf7C79gEnO8xMdyz1vQ+a/uug+wih4lSPp/yeVamG
uHB6U/LGLHja2QItBDaUPH26ZceKww==
=eIwZ
-----END PGP SIGNATURE-----

--Md7+imvniJ2q5CYC--

