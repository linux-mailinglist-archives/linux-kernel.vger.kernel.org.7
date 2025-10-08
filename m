Return-Path: <linux-kernel+bounces-846007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63972BC6B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EAE64E93FA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5A72C11E0;
	Wed,  8 Oct 2025 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyg5ucnw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7319C26E6FD;
	Wed,  8 Oct 2025 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759959886; cv=none; b=VP2C8B2IHDO5Rcv2SHezEsgC3KtlfK4/DvoG39aOkDQl8ilolQaTDHx56AQSFStcjZY4iWMQkoxaI8Bu3AMlB5nowXZuCOr87gfLcNKul6ag6mkarwLCT4mrVsrmSsQkVjVVfwS94F+346ooevKibg+M1AZY64lXJxp9jIhZpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759959886; c=relaxed/simple;
	bh=llAbSKdnreqTt7I3McYr/8TsZ9LCpQRFJxOOErxnxog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKdtQj8ZoRxb8LI2P5tuGppNIUSMhHvxqNX0LpFWcV6wCXzaWtXJ42PbJtKHGjIWmuSQiq8LSYtoIL9oNnox8JCTADPcsut74kpL7d4SlWgJ6h4TVEjRUQsEY8GKCv1ex0HTygFEXPBjYchcr96HHG1uIwg5M4XT2ESYyy0KB5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyg5ucnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A007FC4CEE7;
	Wed,  8 Oct 2025 21:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759959886;
	bh=llAbSKdnreqTt7I3McYr/8TsZ9LCpQRFJxOOErxnxog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qyg5ucnwUvTrp7i1wv4cZMM90sFmmEpLauYs+/JZCLk2Fo/bDAWRgFMVQp4iOQ7Xe
	 ZvUZspBAWK3opFyz58Ur4U4Idd54FyWvJTjOe7I27n+vJj2RhO94uhHeI9vj/vWUYX
	 0j3Dqx9ofL2SrQqQuTetphL6lBHM+I9DYhZxaHK1cHS077/oztHWhGw1ff2BBWC3+O
	 +xVXmc4RZ61ImEZNd/+G8V99I9X+RAwTcN8ceeK0nJP0tCgpL+g1bup0+iu1E0nWHM
	 5jE6jf0kNA/E3qvhiWW5DYK1WOxkw3IAT+dwplgnLpkX8yYCRj36XZoqqLuk0N09ew
	 2GOyj8rBKDlVA==
Date: Wed, 8 Oct 2025 22:44:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Sune Brian <briansune@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <72ca91be-e953-428b-8314-d32de3478bc0@sirena.org.uk>
References: <20251008162719.1829-1-briansune@gmail.com>
 <aOacZAiWxG9XfWLS@opensource.cirrus.com>
 <CAN7C2SCDNz5TB3deVziuNNYFnPV_hmrsPL1k-j5Dsj58wvC2rw@mail.gmail.com>
 <aObHCq6JAHbtTJZ8@opensource.cirrus.com>
 <200b17e5-9655-49c7-a4af-7adaf2838168@sirena.org.uk>
 <CAN7C2SApVuEBTpq-E=bT=1yS+hQVv4J6FSe4ACa5_1a7pSprkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bei0OJtGpep5JNp8"
Content-Disposition: inline
In-Reply-To: <CAN7C2SApVuEBTpq-E=bT=1yS+hQVv4J6FSe4ACa5_1a7pSprkg@mail.gmail.com>
X-Cookie: 10.0 times 0.1 is hardly ever 1.0.


--Bei0OJtGpep5JNp8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 05:27:58AM +0800, Sune Brian wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=889=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:26=E5=AF=AB=E9=81=93=EF=BC=9A

> > Another one I've seen is that you're using the BCLK as the MCLK for
> > another part (a few devices even require this), you might want to run
> > BCLK at 256fs or whatever for the MCLK even though it's not needed for
> > when used as BCLK.

> If you need BCLK as MCLK same clock rate why you need to use BCLK from
> first place?

This is often partly a pinmuxing/routing question - if the CODEC is the
clock provider (and perhaps you're using a CODEC PLL so the clock isn't
visible without being output by the CODEC) then using a fast BCLK can
either be needed due to a lack of other places to output the MCLK or
just seem convenient to the board designer due to where the available
pins are.

--Bei0OJtGpep5JNp8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjm20gACgkQJNaLcl1U
h9AFTQf/ZI84eDZdvvWhnjhG6GU2Tdr4TpQiAAyKcwdEFaFV5ylOeHx5cbG86AGA
MI2avQT8SPC7t5Nf6Uc35j6MJC1A590J40jnOxofYIaQO63CccDDNF9yS7z60wrP
W2uUcq/USBdzyWnn1yVCgZXj4ZaNUBjfwIBYt2U6Cw9J/VFKvNQuCViuhrBTMdFy
cbbFkPz2Yqni9+pGIb22mLH0kItj2tHqShLHy2r1rtH3O7BgetFclEzMfTrXovCD
vQM5i39ghxE7DYLmqx6F5Yl59fKu8gCfsGCZ70msQPVhRfutDvHV2KFHRTUarpSn
V1t1C0VLXt5+MLCXVkUXxkUc/5TuTQ==
=RgEv
-----END PGP SIGNATURE-----

--Bei0OJtGpep5JNp8--

