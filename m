Return-Path: <linux-kernel+bounces-749279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8641DB14C47
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A674E48BE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B49288C85;
	Tue, 29 Jul 2025 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRXove43"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FA3264A60;
	Tue, 29 Jul 2025 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785372; cv=none; b=uCvHBtp7M7LVf6sMtej1V55rtsfS90d1ReYn9aFNeyvucDmxCE8m3EAng/cd00O3kkucrixbdadDAAPyicnfKlRwNtwEf7tZS2LNjjeXLzX5N+p9ECz+cCzcOarCkaLQ++AHEmHMNmtAUQk0Lo9ySIznDgYOm/XNLgVSqVtFyro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785372; c=relaxed/simple;
	bh=PAmGFz6fuvJ0+txbapj32eZ4+ppJS2V2a0z1iKAPypQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTlFGxC6Pkd6DtXiwTNwoF9fWz9vhH4GZAR5K2uhZMOHuVcKJ6eNd1fv1iix844IFqh+aSCeNJ10HmfpAVsAqMXExq5wTqmuU2xb7GixPhC/thBjpAPP/2KnwMWO4zWFbsXoTZUtKCm6WQdOjqdavtl25kmmPmQVC0wnq+GuibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRXove43; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D8AC4CEEF;
	Tue, 29 Jul 2025 10:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753785371;
	bh=PAmGFz6fuvJ0+txbapj32eZ4+ppJS2V2a0z1iKAPypQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZRXove43Flq4L54vJ/Z175oQc5lr+hBuqUtZvXhosonDQ1jR4OM7hDYnQP2/geo8p
	 wB5S+sMG+CSMIOsNZwRC15xJm/riWcvFAmRPNSni3JVIotvqOkENlD/g5l1A0Uz4Fk
	 jLGNtVa8L8GnSDgi+RbpbJYt0I3Py05f3rGbpwkrdbli/dJ31DwEcLQq2YupYb2tJg
	 fUnPxaSQZio7bEm9ykw02FQxzM/FwH8kQOr9SF5hlQOw5d/m1BBYO+I2IvQMk277gQ
	 HNdFd93jdnxkYsoIWbOriRUR3QjrfD4p8kNcnj0D11XpxA3urIWCyup0yIb1HfSk0W
	 ejk7Irz42kf9A==
Date: Tue, 29 Jul 2025 11:36:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	syed.sabakareem@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: acp: Adjust pdm dmic gain using module
 parameter
Message-ID: <d7326f95-13fb-4f3b-86e5-69797b9235f8@sirena.org.uk>
References: <20250728094243.3824450-1-venkataprasad.potturu@amd.com>
 <2025072814-stardom-anointer-0a62@gregkh>
 <7d8c0bbf-2911-4e18-8287-e7c72fab396c@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="THCj9nB3gw2irpsq"
Content-Disposition: inline
In-Reply-To: <7d8c0bbf-2911-4e18-8287-e7c72fab396c@amd.com>
X-Cookie: Short people get rained on last.


--THCj9nB3gw2irpsq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 29, 2025 at 11:34:59AM +0530, Mario Limonciello wrote:
> On 7/28/2025 4:22 PM, Greg KH wrote:
> > On Mon, Jul 28, 2025 at 03:12:27PM +0530, Venkata Prasad Potturu wrote:

> > >   * If users do end up using it to debug and report different values
> > >     we should introduce a config knob that can have policy set by ucm.

> > Please do this properly, with a per-device setting.

> As the main purpose for this parameter is for being able to tune whether the
> property is correct, how about adding a debugfs file instead?

> AFAICT it should just be a single register write, so debugfs to read current
> value and write the debugging value seems pretty straightforward.

Or you could just go direct to making it user tunable like a normal gain
control?

--THCj9nB3gw2irpsq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiIpBQACgkQJNaLcl1U
h9Af2Af/ZHOIDdRyN8oESG5QLmQLs7d0Oelgs8FwkLMeecheCioZ4xlxslIC7tjW
AMnSumzY3xrWiRha8JFBiO7jyxN32o27AgNbXa0nVxKmpczL5Pp1UVU62QfpuBJX
1Lu8BIKYeiT8vTPGfZfhZ/ypGtehBJPiPepn0+nlsTPQkGwtdnbyShpNihbrnhUs
YpVBANMyEeroYqcDE0P74QSiA8NqWmY7TlIeFnPXbd6PWsLWkV4vmfGK9oyXWKtX
cv2Q2p512BtnrGv5snTVctWJrJIk2ucLVFDPUrF9+NW6u6vChdEOs10Ix6OXl623
OGpb2W9g/8YA5ReOLrsz+fSDphNJLQ==
=pQ9m
-----END PGP SIGNATURE-----

--THCj9nB3gw2irpsq--

