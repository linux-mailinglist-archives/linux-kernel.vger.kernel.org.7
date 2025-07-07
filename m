Return-Path: <linux-kernel+bounces-720507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F67CAFBCB4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4079F4A61E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDFF221F1F;
	Mon,  7 Jul 2025 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snCrH+3n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAA31FBE8B;
	Mon,  7 Jul 2025 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920935; cv=none; b=MIhg2DGINko4NJkiRP7D9CnsyWJGBEdkG2d9BpTKyGQMWQry5XtDKL9sIsB22DQQUxX72KYLigz5UAM2Ewwr1/vKBvLQwdJnrlVZbsk8x4GV3EyLAX2MIh44hd1MRWiohpbxYousIQR/53SYyHesf86j5BnvacMZt266Wo1EW3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920935; c=relaxed/simple;
	bh=TFwuCdZGPMLUWkDUlk7xc4pd4TWR/hWivyhMGdCjHvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYWQwrTsfKDQX0kOGuoReavsspxqeLZUmU7jEpMxWhzXT7KWXlnlNLo0A2EJqQO8go9AM55OxQRtzMJyI9i+bfcvO9Zh9BPjg7tRrYIjTerwh/+6kjuOSP97M2eTwhs+AfOPpJKL2MMn97oZIGDFqWT3xUClA7658VrOaJQ13F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snCrH+3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E221BC4CEE3;
	Mon,  7 Jul 2025 20:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751920934;
	bh=TFwuCdZGPMLUWkDUlk7xc4pd4TWR/hWivyhMGdCjHvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=snCrH+3n8WvC2YHtpwm12rKOgMBbsXOQTBPqas3wvKn/0BFXm2hxqaA7yKKCWxf3c
	 NoVQcmD3pEwW7bzk6Ul2sTXoK9T8g72Et4EuUAwdw5dG3i0JQ/ds3QHORR3Hv12E1o
	 OTZTRgH1MhERnuMWloeA/Q3CNgdhJnis94FPatSBZoi3XVXc6O3TSSyMv1hQEMij3Q
	 YFncjgr40t66854TLRjKZ9Lr8atSm3AH4q/DkzTx8N3MHQT7ZxjYzUWEmxd6kmg4hn
	 ehxiYqERfkHSS25plVukikQSCuU60gK6+zLa4D5cvvo4VMAsuJ/V4crT9D6kTUIzd1
	 bqgxKEiwkv6JA==
Date: Mon, 7 Jul 2025 21:42:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Nick Li <nick.li@foursemi.com>
Cc: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com,
	xiaoming.yang@foursemi.com, danyang.zheng@foursemi.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] ASoC: codecs: Add FourSemi FS2104/5S audio
 amplifier driver
Message-ID: <f2055d69-af5a-46a9-8bb7-46ec3175b790@sirena.org.uk>
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250703035639.7252-3-nick.li@foursemi.com>
 <b1ad15d1-bf9f-4b94-abb8-1e9c6d512987@sirena.org.uk>
 <1C4720AC50797830+aGe3L70OToh6txmC@foursemi.com>
 <0370941d-63eb-4676-8a74-b8afef524376@sirena.org.uk>
 <88CC983A5550253C+aGuGe7pQvIBPclfz@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2q2hNUYdsLxioORi"
Content-Disposition: inline
In-Reply-To: <88CC983A5550253C+aGuGe7pQvIBPclfz@foursemi.com>
X-Cookie: We are what we are.


--2q2hNUYdsLxioORi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 07, 2025 at 04:34:03PM +0800, Nick Li wrote:
> On Fri, Jul 04, 2025 at 03:37:32PM +0100, Mark Brown wrote:
> > On Fri, Jul 04, 2025 at 07:12:47PM +0800, Nick Li wrote:
> > > On Thu, Jul 03, 2025 at 03:59:34PM +0100, Mark Brown wrote:
> > > > On Thu, Jul 03, 2025 at 11:56:37AM +0800, Nick wrote:

> > > the volume will be masked in fs210x->vol[2],
> > > we restore the volume when the driver resumes(reinitializes) the deivce.

> > You're not just restoring the values on resume, you're also overwriting
> > them on probe.

> Yes, the volume will be set to the default value at the first time of initialization on probe,
> and it may be updated by volume control later.
> It's a good way to use the regmap cache(REGCACHE_RBTREE) to cache the volumes.

Great.  Note that for new things you should generally use _MAPLE
instead, it's a more modern data structure - _RBTREE can still make
sense for some specialist use cases but this is unlikely to be one of
them.

> > There's not great options here, and you're going to loose the start of
> > playback especially with devices that don't start clocking until audio
> > starts.  You really need the CPU vendors you're working with to
> > implement SND_SOC_DAIFMT_CONT or expose their clocks via the clock API
> > but not all hardware is able to do this.  I think given how limited your
> > hardware is here you really need something in trigger() or some new
> > callback that runs later than that, the delayed work you've got there is
> > trying to fudge things to run after trigger.

> We will start the start_work in dai->trigger if there is no clock bclk
> for us to control, and disable fading in/out in firmware to reduce
> the time consumption if it is needed(As a backup plan).

Great.  You could also make the fade in/out user selectable so the
application can trade off between pops/clicks and cut off audio.

--2q2hNUYdsLxioORi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhsMR4ACgkQJNaLcl1U
h9DXjgf/eR8r8mxqzf9OIJmirwEwrZZshozNp2kzXNehBqVpfmktmHfHwNvO3dQb
MWtqyl54nwZmR7AYLS6Bsb33Qd5EdDxzZWYkJF9WnrTwkzsS5YyNeBjQ2Yad70/h
1r11szUlBFLhg8DC4g1ERUGm1+QYrHHbiTv2UDTub+hktMViUNrHJ6hAIfgeCu49
6MjcRy20ycMhZsxEXSEyHa/PaMuIqPP6HydelwDOKaas6V3+L1aejjiApLH6xOFn
7GNR4OlC4W7yImsahefryZU149mY6tgxuaf/DWk9JKSxSfneQNzTe2M4g586EqkH
TGl5VwCSKnrqzrPuqZ2YJ8Q+rPyb6g==
=A+bV
-----END PGP SIGNATURE-----

--2q2hNUYdsLxioORi--

