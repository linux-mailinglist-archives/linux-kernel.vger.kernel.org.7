Return-Path: <linux-kernel+bounces-886417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93907C3588B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B9324E9C5A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8093126B4;
	Wed,  5 Nov 2025 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM/cY5Ki"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684B311977;
	Wed,  5 Nov 2025 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343685; cv=none; b=KlS9hYaXvAURUokyKH84vYf1/LBGAs9/qrPRIdpCyxm6p0puUyJgAiZ7Iu0Dts1pbopU9/7DLaQlpOsGLb55/QSbYfMuNEo8vV0mzv3gA7JVwCHVmn8XoFBjoTgE5dqWjj7xde/FjZKgZpDerQIOkyq/5zmSb7ohGxecrxbM/C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343685; c=relaxed/simple;
	bh=fWXEEpra3JSRXtn+vmC3wMzG+TNvV4eqDMvW3p5wny4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j21MnrxpjSzuXzAgvPeysA7Bi1J2TB1FnhQQ1ooL6X69WoUXi3dFfE1cfoXXthZ6phz5dDZBOzyP5Vwelq5A0d6VJdNYccMw8xf5QP4cZGQR+tPLTtesO4X65+FFPWm7GvQFVv3cA0spVmIQ7EmmiOQazQHBkqrasA9ybKX0ILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hM/cY5Ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7ABC4CEFB;
	Wed,  5 Nov 2025 11:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762343685;
	bh=fWXEEpra3JSRXtn+vmC3wMzG+TNvV4eqDMvW3p5wny4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hM/cY5KiggonlBpQS6r6aUbQCzmxqedMYrNiw5nWJDwLW7yBuvTNF6tQNZiH7Ckn+
	 AEYM+Y5ZDtiyvsPWGsEqGdLsWThkVadOzZOHGYNr4Nb8t4zgnG37geJk90dvTyOVKU
	 z348htJf6XzkaDyjJGeQdOMhsjsmZ2pBQzCUAziWSobwrrtx+WnsiwyQ3/b0diYn0G
	 /t0xqWMxPL8V6LoPxnz5eTKOnLflY0clYziscaVqc0TK4y/Hg7orWHNaWcLW8CvIQw
	 9yZybJdJc3+kFYnMZUtjBLfCmIh0O2topDLZMrF3hFx9bYXd8yRRadBTMwDAF4rAQf
	 6OfWiXyemUoXQ==
Date: Wed, 5 Nov 2025 11:54:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: vulab@iscas.ac.cn, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
	David Rhodes <david.rhodes@cirrus.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: cs4271: Fix regulator leak on probe failure
Message-ID: <aQs7Ae99uxewgQyk@finisterre.sirena.org.uk>
References: <20251105062246.1955-1-vulab@iscas.ac.cn>
 <2f31c494-b655-43e3-aa6b-90c4594d1d44@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sW4N0oa2V8v1biPX"
Content-Disposition: inline
In-Reply-To: <2f31c494-b655-43e3-aa6b-90c4594d1d44@web.de>
X-Cookie: If in doubt, mumble.


--sW4N0oa2V8v1biPX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 09:43:13AM +0100, Markus Elfring wrote:
> > The probe function enables regulators at the beginning
> > but fails to disable them in its error handling path.
> =E2=80=A6
>=20
> Would an other word wrapping be a bit nicer for such a change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.18-rc4#n658

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--sW4N0oa2V8v1biPX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkLOwAACgkQJNaLcl1U
h9Axrwf/ZbaZPe7ifA+WMRLQD/vYPTfcBcrWPWr4z4T3PNb2HSND6RAyVvLHA7M0
EQ525OQfSzF9bk9d8D70+9cEQzrOwIiBbMuCpJcv69YrLZAmisH97pCWeAJpZB6D
DgOGBva1ttqvFMfyvRdVKpcG/PgxOYUBE3t+qVmrkzmgPJPRS3roBbwh2KFWlWPe
epwfDTT/jqINVXzfzaZaoK1w/50WlGFxtS98uthISX2iwU3K2Z+5OU1UfZVS+zRo
pasY/KP02BgR5W+nFpa7x3o9IJaO0shOiv4xrVhfW+yEALY42dDklazj4ss80194
d8znrqtF9DS7OirN+6HvL7o5WnoOIg==
=tMB3
-----END PGP SIGNATURE-----

--sW4N0oa2V8v1biPX--

