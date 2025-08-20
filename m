Return-Path: <linux-kernel+bounces-778304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F19E8B2E3FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E015E5457
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEF1335BC6;
	Wed, 20 Aug 2025 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNsJnbz3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2E23BD1B;
	Wed, 20 Aug 2025 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710795; cv=none; b=uzoG3EY0kCtFeTORsdrpMRlMuzpXbXhHUjMHDVVgzQyxieMw0kE5fXmOSJK2y29XBVQgIPWYuOy3TOqDVdlzHINxj5GdmXztl6y0u+vjbXTzKWLChaVvEB6iodcrScRVbn7w33TZJYJHQsxni0tw3wZ4vn5CNnE0qwo0ohUAfmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710795; c=relaxed/simple;
	bh=2HxiUW8t0HrEjsYL4FGL1eWcypffGvojSNkMNHG2UK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=He+AG6aR/i87YbfnozxbGJ64kM12B5XDPjM9sHeN7C/q4IScfZW7c5Tn2Yrc7f1MTbyTlV15t9/F18+epjkMovPK++ZAIO0RuaAf2tLFGhhWdRve9U9u+UFjTDDS0NE/CA9KZzC9/JCKMfkjyzNPrWTFK5wnXX+Jq1x5Inq4qww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNsJnbz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC8AC4CEE7;
	Wed, 20 Aug 2025 17:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755710794;
	bh=2HxiUW8t0HrEjsYL4FGL1eWcypffGvojSNkMNHG2UK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNsJnbz33XUs+f7DHFXusLggHbld5Oa0GZoDnO4LvmNDRSnXCnVnUrmIfwd3mRG0P
	 VG95dyBr7nr2VJL3ZTRdmVcGu3/dTPFynZxUbJ106X75TKyipcDjz3wqCx2mC852jF
	 Hc5iXC3U12EcrwMEc+CY4uH2JuxB1Jo4POHabhQSuYOPk37NZgVjW8KrfvHOHvHqIg
	 syynHObGm3qYw79mEcxeRUnYwNWLvySnDTxctaaEMMPveotJUuj1Ft2vBO21+9mghM
	 BA8Q28LXGfg8TPhyoVDCO3SlBQkXyGDUCh7NivYtNSMH76//dycDH+Z+srbsoaiWLQ
	 1t8kv447fTfxQ==
Date: Wed, 20 Aug 2025 18:26:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com, perex@perex.cz, tiwai@suse.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de,
	kai.vehmanen@linux.intel.com, pierre-louis.bossart@linux.dev,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-sound@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: SOF: imx: Remove the use of dev_err_probe()
Message-ID: <a1fa8baa-3116-496c-8c33-bdbc1712c062@sirena.org.uk>
References: <20250819112654.588527-1-zhao.xichao@vivo.com>
 <CAEnQRZB=fq7=ahMkFWaQ58SR_yftSTYqZKFBh7YEXz2M7PyXsQ@mail.gmail.com>
 <00984350-97d2-4aaf-96c3-091f15ec1254@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="THIbrnuRqt5F+FD8"
Content-Disposition: inline
In-Reply-To: <00984350-97d2-4aaf-96c3-091f15ec1254@gmail.com>
X-Cookie: Whoever dies with the most toys wins.


--THIbrnuRqt5F+FD8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 12:24:40PM +0300, Laurentiu Mihalcea wrote:
> On 8/20/2025 10:04 AM, Daniel Baluta wrote:
> > On Tue, Aug 19, 2025 at 2:29=E2=80=AFPM Xichao Zhao <zhao.xichao@vivo.c=
om> wrote:

> >> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> >> Therefore, remove the useless call to dev_err_probe(), and just
> >> return the value instead.

> > NACK on this.

> > Quote from dev_err_probe documentation:
> >
> > ```
> >  Using this helper in your probe function is totally fine even if @err

> AFAIK the kernel logs are verbose enough on OOM errors, which makes prints
>=20
> such as the ones removed by this series unneeded (have a look at [1]). No=
rmally,
>=20
> you'd get a warning from checkpatch but I think these logs slipped throug=
h the
>=20
> cracks because the error messages do not quite match the expected format?

Indeed, there's generally no need for any additional logging on OOM and
if the code is fixed there's no possibility of deferral.

--THIbrnuRqt5F+FD8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmimBUMACgkQJNaLcl1U
h9AyHQf/eILWRJD35lCaZ8JrEPC/MN/J2z9zjlYr+Ve8qCXP0UpMzm6yaDLLd8Ja
0sjDidcN5FJxNMiCUj3H6Nn9YiyLuI5xJkms66XSrtC0l6Lge0PvjF3e3XHmHzne
ip602hTKXEI2AbBls7skB8iwr8c2mXcBtsEXNVrwvVUpP3gh6jgk3AGQiMA9H9qg
hYjihZQRdBx+67Y/sJFqBZaQqMagqVSB/q/4OrWMFBywBbuOim3RjCQAHfLn1Ts4
la9PLUUD3BycKYRW4WFlTxxTEwivN0pG8bT5ywnksUe8Wx3b/aglJkCSe6Z9zG4y
GkI7t5GpI3MOn2TlODzs8m/O8PEPGQ==
=74Wd
-----END PGP SIGNATURE-----

--THIbrnuRqt5F+FD8--

