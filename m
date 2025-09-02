Return-Path: <linux-kernel+bounces-796862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE511B4088B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174F4164D32
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A4E3128D8;
	Tue,  2 Sep 2025 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4cCs1Hs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D8B1DE2A0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756825710; cv=none; b=rXhSDyt6/q+y+iPoObQhnsZ+nRIIuedhUhySyfGmtNlcAxmyLG79KZdw8iqPHgsVvB5p4x+ulsMFmAhnMdP2IwqxOrYBF0St11wmDCh0MAyLk8dFz8hCW0yXTI9MD5tH+67CJMWyw/0wTk5tzGCf6OUQ2ilP9Zbxga59G3eXQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756825710; c=relaxed/simple;
	bh=oiEUagkVWMeI5P3JwjOELOdl6p6ZZssMWMN2Ug1c+P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHjLd3XmSez0SFoeEHjz6nke/agAPqnz0haA/xAIpoOnMt+GMGRBUXNb8vpc2MbiDZ7vVeTRPRVijK1bGqi0GnWifacFIftl7wn7nDDggsOOcPWTfX5iAaK68nhTjjoJqGipQ0GD2/lcwVDiIwVBpygoOJJsffzxJKPJu5YG1e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4cCs1Hs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2EEC4CEED;
	Tue,  2 Sep 2025 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756825710;
	bh=oiEUagkVWMeI5P3JwjOELOdl6p6ZZssMWMN2Ug1c+P8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4cCs1HstBxiGEyzCWUP8ClROJf4GyyVGKFqp8SQp3nPFTaTh4HY7k2YHOzTWRH+H
	 AZxt0VC9G2aGdP+18xAgPItuhLNNA5IsXJaFGf+VhukgANPL0GNkfUt/9wj1D/3jR+
	 UODIIC2p0z228OKY24J0mUVER5sWRONxDcx0K7E24DPK+hvCfD1PDoGOdwsJNJKxUU
	 s0IiE5x83WpbxMU1mzFxtaNy7d8xkuWNw4Qvd/pVYszcDdgNdcgLwGIRvpm7kNhfgG
	 Wi6TUkC1v/efch7//c3daEREAKUM61BLJg41qZLhf3WLpTJzIYUMP5C2mYoE1bfw2g
	 oK0hJVuuHaOaA==
Date: Tue, 2 Sep 2025 16:08:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Woodrow Douglass <wdouglass@carnegierobotics.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/2] regulator: pf530x: Add a driver for the NXP PF5300
 Regulator
Message-ID: <91086d3b-01e0-4334-894d-3627fa132709@sirena.org.uk>
References: <cover.1756822704.git.wdouglass@carnegierobotics.com>
 <3e56ab596698a3cde4875b9b336c80296ad72977.1756822704.git.wdouglass@carnegierobotics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZHP1F0aRelP+Uo55"
Content-Disposition: inline
In-Reply-To: <3e56ab596698a3cde4875b9b336c80296ad72977.1756822704.git.wdouglass@carnegierobotics.com>
X-Cookie: Vote anarchist.


--ZHP1F0aRelP+Uo55
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2025 at 10:21:33AM -0400, Woodrow Douglass wrote:

>  obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
>  obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
>  obj-$(CONFIG_REGULATOR_PF9453) += pf9453-regulator.o
> +obj-$(CONFIG_REGULATOR_PF530X) += pf530x-regulator.o
>  obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
>  obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
>  obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o

I'd say please keep this sorted but there's some cleanup needed here
already so whatever, let's deal with that separately.

> +static const struct regmap_config pf530x_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +       .max_register = PF530X_OTP_MODE,
> +       .cache_type = REGCACHE_RBTREE,
> +};

In general it's better to use _MAPLE register caches unless you've got a
good reason not to, the data structure is more modern.

> +static int pf530x_is_enabled(struct regulator_dev *rdev)
> +{
> +	//first get mode

Usual comment style would have a space after the //.

> +static int pf530x_get_status(struct regulator_dev *rdev)
> +{

I would have expected this function to check INT_SENSE1/2 for current
error statuses and report those.

> +static int pf530x_get_error_flags(struct regulator_dev *rdev, unsigned int *flags)

I see INT_STATUS2 has thermal warning/error interrupts in it as well.
Not essential but it'd be nice to also check those.  These statuses are
also clear on write so I'd expect a write to clear them, even though the
device lacks an actual interrupt line so it's all somewhat ornamantal
ATM :/  I suppse we ought to implement some core thing to do polling for
non-interrupting regulators, but that's definitely out of scope for this
driver.

> +static const struct regulator_ops pf530x_regulator_ops = {
> +	.enable = regulator_enable_regmap,
> +	.disable = regulator_disable_regmap,
> +	.is_enabled = pf530x_is_enabled,

The custom is_enabled() operation doesn't seem to line up with the
generic regmap enable/disable operations, and we don't seem to have
enable_val or disable_val in the regulator_desc which the generic ops
expect.  The whole connection with the modes seems a bit odd, the
standby voltages look like they'd more naturally map to the regulator
API's suspend mode but perhaps these devices are not usually integrated
in that way and this would be controlled separately to system suspend.

> +static int pf530x_identify(struct pf530x_chip *chip)
> +{

> +	dev_info(chip->dev, "%s Regulator found.\n", name);

It wouldn't hurt to read and log the data in REV, EMREV and PROG_ID too
(it can be helpful when debugging).

--ZHP1F0aRelP+Uo55
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi3CGkACgkQJNaLcl1U
h9AtDQf+PKS+/FOUlDHvvYvrtF3JIKXrH+lQuGv+iBd7o2bt007QacyrEVH8Io6P
lPwShBOmAEVomSIBrcbvyBghUmwDFQMFG6wFGIS5UaUzH67rqOZJiE6kfFauBHQE
jiGZBzL5Nwy4b30LMFZ9QDI68fsu1RUFEps/qvqZusb739mYOlN92tIjaze9grlA
ARy6NhEmMa1WRaLog4347qzhXHIsSPPYUe47ZZb+AeCV55rC6BAIBVo8X2e3sDSb
k6A0kZxtzfguLF+B/mN7+m1NW09rdrKc6r5lJFfkhs7U4ZzpVHJIaH0DbsH1JqbH
H4azb2GiOVq4i1kMew8BaI6vtj08Ow==
=YM0f
-----END PGP SIGNATURE-----

--ZHP1F0aRelP+Uo55--

