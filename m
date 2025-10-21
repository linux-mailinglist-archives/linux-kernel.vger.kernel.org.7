Return-Path: <linux-kernel+bounces-863566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C752BF82E2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79744402B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DAF34B67B;
	Tue, 21 Oct 2025 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+uho2GA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268CA26F299;
	Tue, 21 Oct 2025 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073225; cv=none; b=Jo4Hlf4mJ6DyIVgQOKi3YvfRpS078c75yfwClSraM5SbjQFw+uXXhuKUUghwRQP1WKTyT2sRuIf1bn6oxoXnhEFiCkUXQpXHmnLoICGbhidJJZJNVhXXF/cOBmEhoNdijzopjMBOUaD0mNZtT4Wl7c/7c8GkKPDUUZ6puJ5jRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073225; c=relaxed/simple;
	bh=Sf0Qca7JPp4GCBsTXBvE+iV8s2TZnluhENYJ53JTcCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IofKjkvWGTYWVcOIDlO2cE979ITyCuiwzuGqiucUjqNV6ErNywCUnq+LU8X6dU742+xamss25lpcmjPQtU+6MT4kK12IJgkaZlPjVSBDLMmXa2kiJ0GM82DACVof3WwBKva5bVYAqxLk9dOOFWLzMqMiStMgY/slrJAYepItwic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+uho2GA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E837C4CEF1;
	Tue, 21 Oct 2025 19:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761073224;
	bh=Sf0Qca7JPp4GCBsTXBvE+iV8s2TZnluhENYJ53JTcCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+uho2GAf8Vjb4A4SydAjBzWs0/5EGqsqBYFt/vQ9TE+rzlCFJvT/o1w9y53nvfaL
	 0IxfDiVsOxNmhhu97BZBqmLsFZ9nJ2kC0pGyvUIDjNw7bmZV/rW3A26Q2rsEyXPFGP
	 vx3OjhPHuFq9163mJ0jj1/c5WhYZRBgZCu3TxsKxxzfjlmoHKcz2SFR5wO0lOX6oY/
	 UDGeiYUibskItbUPi3MNNMU6YHJgt+KTj/S3fc0vHr50+56DYsLOrawuTA9c6W79GU
	 WhzZonIuC+acHjPBVh6+/U0xk8BzV3mrdbUS5jMpZBQROo+9eoj1Ofw5OW4D6IOw0l
	 9fDl7ifm5kSBQ==
Date: Tue, 21 Oct 2025 20:00:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Herve Codina <herve.codina@bootlin.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Axel Lin <axel.lin@ingics.com>,
	Brian Austin <brian.austin@cirrus.com>, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] ASoC: cs4271: Fix cs4271 I2C and SPI drivers
 automatic module loading
Message-ID: <42f11845-35f2-40e0-b860-c25ba6f8d503@sirena.org.uk>
References: <20251016130340.1442090-1-herve.codina@bootlin.com>
 <20251016130340.1442090-2-herve.codina@bootlin.com>
 <60fbaaef249e6f5af602fe4087eab31cd70905de.camel@gmail.com>
 <20251017083232.31e53478@bootlin.com>
 <d6bd466a5d11b016183db0ac3c25185fad3036fc.camel@gmail.com>
 <4b851d47bf1d03988a27671ae21208cdeed76837.camel@gmail.com>
 <5f2aeb66-97d6-41b7-8c80-87674c1b14d8@sirena.org.uk>
 <d51a3e4e0ea960df60d5ba91817ae50eba0a4026.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RRkNqY/s75ow4Lmx"
Content-Disposition: inline
In-Reply-To: <d51a3e4e0ea960df60d5ba91817ae50eba0a4026.camel@gmail.com>
X-Cookie: Accordion, n.:


--RRkNqY/s75ow4Lmx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 17, 2025 at 08:14:43PM +0200, Alexander Sverdlin wrote:

> "Reparing" them as Herve proposed would result in I2C modules being
> loaded only via "of:" style modalias and SPI still via "spi:". Which
> sounds all but consistent.

> If SPI ever adopts the same of_device_uevent_modalias(), both backends
> would require "of:" prefixed modalias, and it will not be possible to
> load the proper one for the corresponding bus type.

> What are your thoughs on this?

Or at least you'd get both modules loaded with one being redundant.  TBH
I'm very reluctant to touch this stuff for SPI without some very careful
analysis that it's not going to cause things to explode on people, right
now things seem to be working well enough so I'm not clear we'd be
solving an actual problem.

--RRkNqY/s75ow4Lmx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj32D0ACgkQJNaLcl1U
h9B4/gf/Qw59HOWc4ilMWJnjdUicTkgCUxQ3osOR8HN/nvogeVLYFIAI2fnWKTj2
7+ko/Het774CE6g63V+xH1QzprNvkJWXEOvzZ4kYtHg9x9dA0TS2VsfwuMNn5fSm
e+wGtFLnoxkLklNmMNQdUwNQPPt3pxZntpnt8DPBZl8jSJv6KoEwFVgWpRq4OA9u
Td9dQDcov8GT221pj3pm5+Mkw7DJO49d+NA3yvkLPjFttWtpK0bbpi5wAUeoW1cp
+08yG1rglqTB/GHKN0+m+4tdbUe4U3M6yBOXe+pcGXFDjWDsJux0RT0S8VF9ZPdg
T73vPe6Jw5f8wjJmpm2jWMyv1snv+A==
=w1Tc
-----END PGP SIGNATURE-----

--RRkNqY/s75ow4Lmx--

