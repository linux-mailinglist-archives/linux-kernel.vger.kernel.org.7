Return-Path: <linux-kernel+bounces-858477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B114DBEAE76
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2932B746997
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349AD2E36E1;
	Fri, 17 Oct 2025 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk2+5bSs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8656629B239;
	Fri, 17 Oct 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719580; cv=none; b=qk0GH/Bri/quxC4EL5NUkXcTcvacq41PjgTXueQ1GWu/Qn2e1YF32Ss1Fv2kZtutQ5DoNm4R1MX9tWlzoCrRDnPJSC3NbVlVdDxJO8cif2B/OLs5Co86KI/d4QaUFR3l3B577IQlw8iKm8YcrBTUknhf75msoKHnwxnAGJH29PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719580; c=relaxed/simple;
	bh=n6v1uLKMlk9r96Os5GI1EowyL+vQvImj2ssOrXYnFe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0Q4up8zf8MWJVtTYRX+7a72QwKB9R/VVS5Pd0VmrDGAG5IMF6bm34vJ12LQFnh4uo2N+upqN7y3JPDLDSZMSKmMeGcnCxHiS7DxTrzDmfJYH6Y67WA7uOo9Wgfn2ZRx3nksePrTzo/t4TFXm9PGpaze4OHELrroip57oyUnqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk2+5bSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC94C4CEE7;
	Fri, 17 Oct 2025 16:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760719580;
	bh=n6v1uLKMlk9r96Os5GI1EowyL+vQvImj2ssOrXYnFe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kk2+5bSsOqtnv9n41pZnHcH4HnFKmsXgnhMnYQVgjG0Ku3OJmgs7WaEM6JR8ZmT4d
	 oR1zmztdHYVHenyKZE8uQMpXdOM3QRukf94rx38nTZyevm2UHmRARFjpvAopqZ7Oq8
	 o/XWYmdYxCGIu/Njl1RoUtazPGVOOKiTCs9fs0UAjYwGtoGEEienRmOqjzunwJyQ75
	 6giZy4sgRWrGwFJcBBKEEYWxkJ+5Gy+EJWX1/jrMtww5723RSOZTcmX3uFZZBXiOFZ
	 dTbBLEvWGefA9Qx+oCVJbmqd/n9MFgDPbatSlYMgQm4UHhLwfF1exhFLLHQeZTIa18
	 fEXvHbAarWu5Q==
Date: Fri, 17 Oct 2025 17:46:14 +0100
From: Mark Brown <broonie@kernel.org>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 11/11] ASoC: cs530x: Add SPI bus support for cs530x
 parts
Message-ID: <2330dca6-dc45-4675-aa67-07e3781b8504@sirena.org.uk>
References: <20251017161543.214235-1-vitalyr@opensource.cirrus.com>
 <20251017161543.214235-12-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BQuvZ8tq9opguYXc"
Content-Disposition: inline
In-Reply-To: <20251017161543.214235-12-vitalyr@opensource.cirrus.com>
X-Cookie: Androphobia:


--BQuvZ8tq9opguYXc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 17, 2025 at 05:15:38PM +0100, Vitaly Rodionov wrote:
> Cirrus Logic cs530x device family has 2 control buses I2C and SPI.
> This patch adds SPI support.

Don't we need a bindings update to reflect the SPI support?  Your
bindings patch only added new device IDs.

--BQuvZ8tq9opguYXc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjyctYACgkQJNaLcl1U
h9Dc0Af/TVyMo1ziaLYJ1MIAESWYV2iDnwIljJiz5d2+C2hPdPUCitQ/7RIa1n0x
f/iPpAmI1liTWBI9On0P7Yvz8u5GXLp1rSDkcrcdganHfFl6JGWBQ4pQXWw7k7Tf
XYUcJDGtGX0hxMQRuZP079yMeITJqvXX0AC4j3spH2Tqw2+Kp9nGKc5Efy2fZJKT
vrCZdb4Y1WO4emZex48APLhrxmCD72UNVDYrdfuxoYxocjfNVGR/lGBDMgI5bQVi
4pgJEuCbdlDzls3CHF2p9kXv60jWojPAokVr9ZnI4wXvhn1H7Yos7vvrpA+iwFPc
mvLztEnhEGIh0rDBiPe+9KvEwCO2bQ==
=AMe4
-----END PGP SIGNATURE-----

--BQuvZ8tq9opguYXc--

