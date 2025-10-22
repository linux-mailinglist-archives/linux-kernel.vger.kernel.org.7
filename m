Return-Path: <linux-kernel+bounces-865688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D99BFDC0A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3CC3A6B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532572E7BC3;
	Wed, 22 Oct 2025 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5+JwXBM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A438C28C00D;
	Wed, 22 Oct 2025 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156116; cv=none; b=JPk1Cm5FRuru5F0G7d5Bnb1AD0iqi0loSKVo+d7DXWDuvAJtSmYKup45+l9prxUX13NkUoRTjrq2krC/OreG5n9hX2gngixhwgZIF+vQoTU4ZDSNf122+ijsRwq6f/0gDOBHI2s6s0dpKUVv0IzuHjvgE4TTxyug7I3LwRHQePA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156116; c=relaxed/simple;
	bh=58mumSNUhT46WTT88usq3EBfCwuN7mWOryWKIRMP894=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKWLgkHv97MYfZ7gnbZ0zKbsMZIAZxKvuxsKA+RJK+Vy7kjaYpCcKh7yDzJuYfTDJIfUGxcdhEfKcibRjfQ1ky0i1PTeX89IVec4afxSATeWGNPXB3Tq94SxZJO/78Owlgkg8oChJ7kkzyH9aHaYexxYLjUDgN5RsJchi9mfHUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5+JwXBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3271C4CEE7;
	Wed, 22 Oct 2025 18:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761156116;
	bh=58mumSNUhT46WTT88usq3EBfCwuN7mWOryWKIRMP894=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a5+JwXBMT9Ig31v7lnuHVKebhGBLlQX1guunqcbnTCumZiNYDHnbbMymmFdqNyQEH
	 d8/0EhLte9mrD2DbuGWdyyTywxog6DNTLyYm3K9BhNq9ftjLdzT3yOhDpZy3s0DnAe
	 oNGSvBvZa3PVPLS7lO7k0Da9goykOjlXCuZ6BxkdJHuX+A8gCEQEBZM5Dw4vSrYVp/
	 Nrm5uPYtjXBzb8YkkVHA4LwBsAxXdFFE/sJKFG4qowFqgbS2Fr+nXm/5SKNdGk6L62
	 zy9cfhMcZDR9i/CXKbu5HWbSLW2e98+RZmBG5FLEUjAE6b1pgrnuDPgH/8PYcSQwWa
	 b7ukLPxpUyjGg==
Date: Wed, 22 Oct 2025 19:01:49 +0100
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
Message-ID: <4240deca-6dc5-4353-afd8-9b4d2819570b@sirena.org.uk>
References: <e7873e6ce07cd92f4b5ce8880aa81b12c2a08ed3.camel@gmail.com>
 <d38779a7-a1af-49e4-b429-5ebd791e2168@sirena.org.uk>
 <d42ab1a0665f55731aabd1e9fcb31b8401b7913f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J98ESMF++UfUzSbY"
Content-Disposition: inline
In-Reply-To: <d42ab1a0665f55731aabd1e9fcb31b8401b7913f.camel@gmail.com>
X-Cookie: Remember the... the... uhh.....


--J98ESMF++UfUzSbY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 22, 2025 at 07:46:26PM +0200, Alexander Sverdlin wrote:
> On Wed, 2025-10-22 at 15:56 +0100, Mark Brown wrote:

> > > Now declaring "of:" to be the new I2C bus prefix for uevents starting from
> > > Linux v4.18 sounds strange.

> > I think a robust solution would involve having the OF aliases namespaced
> > by bus, or just not using the OF aliases but potentially having
> > collisions if two vendors pick the same device name.

> But this sounds like the situation before the above mentioned commit
> af503716ac14, when both i2c and spi were symmetrically namespaced with
> i2c: and spi: respectively and contained the "compatible" stripped of the
> vendor prefix.

> And I must admit that I had more understanding for the prior state of things.

Right, it is.  The issue with this situation is that if the compatible
strings for a device are not simply vendor,part or if two vendors happen
to end up with the same part name (Wondermedia and Wolfson used to both
use wmNNNN for example, there were actual collisions though not on the
same bus type) we will have trouble figuring things out.  We don't have
a robust mechanism for translating from a compatible string to a
platform registration style name for a device.

--J98ESMF++UfUzSbY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj5HA0ACgkQJNaLcl1U
h9AnMwf/UoP4jFW0QyET4m3qBDFOUGnnzxPsai2Xhqz68QODoAl0x/LFs0r2ifoD
Nxwj88oeFMh0ptXtO7wv5YKXQy54Bxr4KcoT+chP2GFK6BdM3gt3cC/SRfL/7vaE
Uz8soMcnaTWEM0Sjkp/tbWlFprpvsk+60lAUNRtQ+DNdwdT0IkkBYc2bjVv2DoGl
PrEQRE1sV2YcJB1Sh4m8o8tBevGeeEflDp3gijX873INXup6EZfdc7bZ7+GsciGl
/ssc8Actm+koiXuAAyvWnsa6D0jgxVWdDc9vtT6BQlPakATCjZLvQBt3ccIU6EKM
8U5Kry0PJh1oNGbKfIX4jdaXgce32g==
=OVIe
-----END PGP SIGNATURE-----

--J98ESMF++UfUzSbY--

