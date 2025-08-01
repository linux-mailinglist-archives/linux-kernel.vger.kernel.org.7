Return-Path: <linux-kernel+bounces-753583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D30B184E4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 17:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14447A8241E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A201B272E42;
	Fri,  1 Aug 2025 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjPPLucD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A1327145C;
	Fri,  1 Aug 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754061931; cv=none; b=sVIeB3mEdhTAdnudD44S3bJZgMEVWVxX8qOKlQzd34wsqbsUZKWdnX/Ga4hume8UGI7LgmrE7ElfCeA5mKwO7bLtgJ9P2ePA4SuNvKDHrGcoWPBKld7VhIZ3BiJS+UNPvNqhoH7eAnPCsSHGpc7CFm9X47GvuezWyCeQE7Fses0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754061931; c=relaxed/simple;
	bh=UV8FDHpbNM9aWBAqfMgYeTlU8Uc7fbwEdxNlwwotWow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KX8xMNp0tUL29OzZodx0QFKOgxJk4Jba9vRF9CmcBoUoWkCYF/Y4bBkUmYZ49uD3+E1E1uwiV+W1KsDJbriwNbKCRa0pBX6Qsn1FusBc4b5Gmj+PyZFOJReudPQdKOWEi7N8dDj/pxLqhSbrXVqOanubPFqKR+MwfxmSvfRQYwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjPPLucD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA5EC4CEE7;
	Fri,  1 Aug 2025 15:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754061930;
	bh=UV8FDHpbNM9aWBAqfMgYeTlU8Uc7fbwEdxNlwwotWow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjPPLucDOIqxae35F+/Af8liJe2JeEKw8JpYVIv9VJ+GahNyBO8QmPfyIUDMhctHN
	 VltQmkJ0og7V8GWxQTxrUS5OhH0URqUoMh71In1rnlhmxkN9x8nFXBencTZz9aYdWa
	 KHuH07SpDf85QiHsMBmJxxuhehcE1J9JNIMwJAdUbIo/zTUqo83PXOI7ahaCgoC25g
	 ThHR+yxRGcvMAv5nLSS5rKTEHSrEi+1U2fs3KSkmg0qEmgYE/P+oOFC/pDh1xUuQ92
	 XKMaYyi5+jCKFde9jTUTT6zIFhOaAsfmxhP70jGynyrM12F9N82mxx9+YTkidhzoM6
	 huykH2ukqHX3A==
Date: Fri, 1 Aug 2025 16:25:23 +0100
From: Mark Brown <broonie@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Tang Bin <tangbin@cmss.chinamobile.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	parkeryang <Parker.Yang@mediatek.com>,
	YR Yang <yr.yang@mediatek.com>, Zhang Yi <zhangyi@everest-semi.com>,
	Fei Shao <fshao@chromium.org>,
	Julien Massot <julien.massot@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [RFC RESEND PATCH 2/2] ASoC: airoha: Add AFE driver for Airoha
 AN7581
Message-ID: <7068c875-189e-428c-bf29-4c58052e409f@sirena.org.uk>
References: <20250801091812.4866-1-ansuelsmth@gmail.com>
 <20250801091812.4866-3-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u4i6tmdHxjn6/iCa"
Content-Disposition: inline
In-Reply-To: <20250801091812.4866-3-ansuelsmth@gmail.com>
X-Cookie: Who messed with my anti-paranoia shot?


--u4i6tmdHxjn6/iCa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 01, 2025 at 11:18:09AM +0200, Christian Marangi wrote:
> Add support for the Sound system present on Airoha AN7581 SoC. This is
> based on the mediatek AFE drivers.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  sound/soc/Makefile                          |   1 +
>  sound/soc/airoha/Kconfig                    |  10 +
>  sound/soc/airoha/Makefile                   |   2 +
>  sound/soc/airoha/an7581/Makefile            |   7 +
>  sound/soc/airoha/an7581/an7581-afe-common.h |  35 ++
>  sound/soc/airoha/an7581/an7581-afe-pcm.c    | 455 ++++++++++++++++++++
>  sound/soc/airoha/an7581/an7581-reg.h        |  29 ++

Commercially this might be a separate company (well, subsidiary) but
this really does look like in technical terms it's in the same family as
Mediatek so it's not clear why it's a separate directory.

--u4i6tmdHxjn6/iCa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiM3GMACgkQJNaLcl1U
h9AxQQf/cXI+oOJD0ocVccB1R1aH6Mz784IpZrG5A1J7QxDxrfQXl/E8FQArB0aR
LVB+A8JEApb5Bcu2hSB+luSv/yCoFzK+l54YVPRnZsvfE9Caa06wVenJGR9Q32nf
owvAz2th0Fy0SndV7Pz7DSxIsgaEPAE5Rf4rnb2vOqJu7GCa8GcBqyD6AeLzqRyn
fSbmTPPhQ5UsGIE8PAY0P0+TxNxT19n3HsfAKTDZ36j1fpnU4dfp5iNTMRzI3/Wq
SwWu4ylE75ivAMK9v+kicTto1bAzbmJmpNLMOdPpYxZuO0tRqrnymwQvaBdQceUr
fDJithAny9ANXVkzMKdhwXJclntdNQ==
=tZJ6
-----END PGP SIGNATURE-----

--u4i6tmdHxjn6/iCa--

