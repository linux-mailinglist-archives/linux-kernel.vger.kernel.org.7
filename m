Return-Path: <linux-kernel+bounces-854257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 379D2BDDEEC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6ED44E2465
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABC831BC99;
	Wed, 15 Oct 2025 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbYPxHcY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C159530BF4B;
	Wed, 15 Oct 2025 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523227; cv=none; b=EKV+uPt3L8tcNmvoZDemWkYKi+Q3YU8uf0O1lPBqTM8NGwgBeznNH9hn8LszWXm3AX9H3a42io9ROqjx6khN/O0UbJdIoh2IxoBd2wV4aW1Ht9ewqhj3Yvc0p0EOc35NNTXBD334YrPrz6/IKHYRNrqhdl6U9QI7tT0OWrmfKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523227; c=relaxed/simple;
	bh=Q69SnQbEq8RmTGQUg9aWE4QuT2dmQQ/ZU7YOobmXYPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLRYZPYMlbB3gKfPr30P6Xxg/MkCoc0+Ot2666gx3mESDewLpU5svzjeH8FLPqBaIOdqq4vL346j4PVa5G6/rNCpFX+SZnyDlC8vxKEHybC1mXJorT/3ZZ7sIkyW9j7OgNSFRdhthXdaRsRH1tlfldwt7oLOn22s3ApwzsNcuU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbYPxHcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9673C4CEF8;
	Wed, 15 Oct 2025 10:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760523227;
	bh=Q69SnQbEq8RmTGQUg9aWE4QuT2dmQQ/ZU7YOobmXYPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dbYPxHcY2F/7O04AgWwjkgVwR8lIlN3dhWxtBpU6H5vMTUAJDO0lZYXgl1W2vYfef
	 p0p5vTaLYZyKIrLUtl5zGZWj3nvzdPu/YwVmHd3imbFggYlM9xvTKdAHxB7Cguh4xK
	 s4jI/UhWQTtCTJMGe1w8FON/Wx72iBVjYtVw1GCGQAJ1ANsu14CZRP3ctUFWmTTHfM
	 sieWPqBgZ2B0BWrKb+u+No6jHIhjzNh81Qs00bK9n+uSI/9TGsR/4S6xQOeWHoKKpC
	 2Z8qlDQKS1ARPMBKWUb68iIvwzE8084rBMVtth+twKc1a1dt0Qp83S9SAytk+JCJ7p
	 gqnlT4Zphmdgg==
Date: Wed, 15 Oct 2025 11:13:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
	Simon Trimmer <simont@opensource.cirrus.com>
Subject: Re: [PATCH 1/8] ASoC: cs530x: Correct log message with expected
 variable
Message-ID: <cbee75ec-768e-4bd8-8bd8-7b2079c3d8ef@sirena.org.uk>
References: <20251015092619.52952-1-vitalyr@opensource.cirrus.com>
 <20251015092619.52952-2-vitalyr@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HUgIZh8ZWxHmsdYH"
Content-Disposition: inline
In-Reply-To: <20251015092619.52952-2-vitalyr@opensource.cirrus.com>
X-Cookie: Long life is in store for you.


--HUgIZh8ZWxHmsdYH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:26:04AM +0100, Vitaly Rodionov wrote:
> From: Simon Trimmer <simont@opensource.cirrus.com>
>=20
> The function used one parameter for the switch statement, but logged a
> different parameter when it defaulted.
>=20
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> ---

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--HUgIZh8ZWxHmsdYH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjvc9YACgkQJNaLcl1U
h9BjIgf/do6w6y9M3nWg3A25W1y8Ro9AYhCrgfaRJnQ25iuAOUyCVMZ+KaKqiTxh
WHM5H/MBc7lXRrN9VkXvZbn0lknfgZbRn+YP364td0rR/wZnF6HwxSTGg9cZJSCY
FzZKp8hUZ3bivpGcLoGDxuvxR1BydszHHZ9EBz+H5dvGSRGEdh8R8t2xGLrWHzE3
bPFXF9nwcgQUNDzn6UQv3WC3uTIJXQd8aQbogithfc/qHrCe7VFUnAAysDy6Zh8B
6FzF5GoNJO1gESzAtbnVKgoxgIB22wvK5qXwDBn3yz+dhhtehoBniTdOCfeuoH3s
kwsZeEPigAL/65kropJqJ3Ku376uzw==
=BhqQ
-----END PGP SIGNATURE-----

--HUgIZh8ZWxHmsdYH--

