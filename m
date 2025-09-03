Return-Path: <linux-kernel+bounces-799044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3720EB4263F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE77B484CD4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF89B2BD036;
	Wed,  3 Sep 2025 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSDqUf6I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300A72BD013;
	Wed,  3 Sep 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915739; cv=none; b=gmefqsYVutYgmzn9BxlNnIy3LrUW2arWX0b3yEG2e7CAdtgw7jPAE89hV9EMbo4OiQ9ZsPHejAsiDo5BQJI2ErcfDTqXGbocX1NvKLOunO6UpH+J2phAGmS6yLvZ6X1kAEwU72So8iEYxynLG1fJnkcaItGpUX7ZZ9o1qBGHhFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915739; c=relaxed/simple;
	bh=mtkcys/OuZJbfEkAwwoIDAScOcNW90WlNc0yQmGWZfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1WWrSd8uTs2aax/AqGFMR2g1kpzkxWszWxRKQRaAs3LeiQvyXa7ngI7157nGGEpMayKNBZH1darBQmG76KzdiMEi8lrXRzqf4ubyDEYYB9u9IGC/dKJ9Xqh/I3DyuEtVI120u2zpwo2TCgeJv1qhJPUkyLfgeeeUFG0HzOqPz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSDqUf6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEC5C4CEE7;
	Wed,  3 Sep 2025 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756915738;
	bh=mtkcys/OuZJbfEkAwwoIDAScOcNW90WlNc0yQmGWZfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSDqUf6IwDBoRlD6+/P99Cun1RwHR1RnDE5smkFXoy9Fxq0qLXFRxHKhbs9S7lI3K
	 uZO9k4sL2JU3bHo/b/+ubWqrgWzQT3Y+WmjgVB9Zyw633PmWK4V7M210WRYWxHo7pP
	 7zFgcsgR53O8c3k6rVA4mvcF335AQ/xW1GCCaG/csu4/zydm7rw1429sZxv8MF/J9x
	 f45sX2o6fegNEvFlV0yy55+GjPD5xxiMvRlY2C2NB4TuV3JSNZ7wzuGk6jon3E1RPd
	 Doxm/tBzNBIMZMCtRxyITj2CnToSi+y0HNhb5HZxIo60On6VHtUCP9ZdBaPSf0DXrz
	 d8az9llxSVHew==
Date: Wed, 3 Sep 2025 17:08:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Woodrow Douglass <wdouglass@carnegierobotics.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] regulator: pf530x: NXP PF530x regulator driver
Message-ID: <cd9e526d-9f17-4c2d-99f7-a495e2d58d73@sirena.org.uk>
References: <20250902-pf530x-v2-0-f105eb073cb1@carnegierobotics.com>
 <20250902-pf530x-v3-0-4242e7687761@carnegierobotics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZXhJwh23vIJKsLSp"
Content-Disposition: inline
In-Reply-To: <20250902-pf530x-v3-0-4242e7687761@carnegierobotics.com>
X-Cookie: You were s'posed to laugh!


--ZXhJwh23vIJKsLSp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 03, 2025 at 11:31:36AM -0400, Woodrow Douglass wrote:
> On 9/2/25 11:08, Mark Brown wrote:
> > On Tue, Sep 02, 2025 at 10:21:33AM -0400, Woodrow Douglass wrote:

> >> +static int pf530x_get_status(struct regulator_dev *rdev)
> >> +{

> > I would have expected this function to check INT_SENSE1/2 for current
> > error statuses and report those.

> I have added the INT_SENSE1 bits to the REGULATOR_STATUS_ERROR return value. I'm
> not sure how to properly represent the thermal bits in INT_SENSE2 here -- this
> part can safely run at high temperatures, some of those bits are just
> informational in some designs (including the board I'm working on now)

If the device can happily run at those levels then report as a warning.

> > The custom is_enabled() operation doesn't seem to line up with the
> > generic regmap enable/disable operations, and we don't seem to have
> > enable_val or disable_val in the regulator_desc which the generic ops
> > expect.  The whole connection with the modes seems a bit odd, the
> > standby voltages look like they'd more naturally map to the regulator
> > API's suspend mode but perhaps these devices are not usually integrated
> > in that way and this would be controlled separately to system suspend.

> I agree, I was misguided here. I've added enable_reg, enable_mask, enable_val,
> and disable_val to the regulator_desc initializer, and moved to the regmap
> function from helpers.c. I'm moving the "suspend mode" settings too here. The
> board i'm working with has the suspend pin grounded, so I can't really test
> suspend mode -- supporting that may have to wait for a future patchset.

That's fine, someone can always extend the functionality later.

> >> +static int pf530x_identify(struct pf530x_chip *chip)
> >> +{

> >> +	dev_info(chip->dev, "%s Regulator found.\n", name);

> > It wouldn't hurt to read and log the data in REV, EMREV and PROG_ID too
> > (it can be helpful when debugging).

> I've added REV and PROG_ID, EMREV is listed as "Reserved for NXP Internal Use"
> on page 95 of the datasheet, and  -- I can include those bits here but i'm not
> sure they're very useful; if you'd like me to include those bits anyway i will

IIRC something in there mentioned it was a metal revision which would
make sense for the name.  Given the name you may as well include them,
worst case they just get ignored best case it helps someone debug some
issue sometime.

--ZXhJwh23vIJKsLSp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi4aBUACgkQJNaLcl1U
h9Dtpwf/Ukc6dbCrtZOsHbBctRiMsNl+XIJBspR7pGSgzC5V0BOjCHTiU5AGWXOf
LnXl9777oLoiLLYx/cBCrHTVR/V/P70t/h3DconrMoF8l1H/k6wXqlfTUBV1iugg
ZCTRMKglg7o8MFRNiZx1dDOvs0mixNDPcbdtt9p6okPdWVllqc1n6PlPmx2d/rF9
rWvCc97+Wnz4agfMcQCPfz1hNbdU2WNIl4o/Qc2Vuxokdhc36uzsaIz64JQL/jtr
IK80ZNqsW15DIe1JVYFvQNx4pkpb+6SwMxSON4axCvryG6QSBWTO3cWQdpybV8Os
Do8d93StRgrpRnzC1VZaL5m1HEDsUA==
=wnur
-----END PGP SIGNATURE-----

--ZXhJwh23vIJKsLSp--

