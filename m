Return-Path: <linux-kernel+bounces-845527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CD6BC5400
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EAB3BA439
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE29285CBB;
	Wed,  8 Oct 2025 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJMfhKR5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9292F1E32B9;
	Wed,  8 Oct 2025 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930834; cv=none; b=bP9JpyxBnqy5VJ7xlRvrio8yztQDhTEr8Zy7VQyjhcrr9HrTTq8xNalLHpLaMJTLb4T4XGICYMnJ3y2tDdXi30aOBQIwnMdkfOlhxcytKraJuiWQvRz/bLQUd7yjXVZGNJtR6Ra0qTc0u7/w6a8Jv+Xx2HiaHB1v+966hmR1j5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930834; c=relaxed/simple;
	bh=epwwXqZJBNLYvfOP2QpZKHntBg+jbfQvF7qSfwdNi/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHvI3doBXatxdYQ8MluBEXP4TnOMUGBeWOuYfe67u6vD3u599Uz3YhbWnMRikjCuTa8JEBS6VZV0xUyZOFh0L2EKdkbr/crWVT9mddA5ZJkWnOHKXd8q/TiGROtTkljA87yihAdK6bbqCPHaApF5S8070LaKkH59LG1LZMMewlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJMfhKR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B309FC4CEF4;
	Wed,  8 Oct 2025 13:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759930834;
	bh=epwwXqZJBNLYvfOP2QpZKHntBg+jbfQvF7qSfwdNi/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJMfhKR53ZQ8FUOndNRYzgYuZpBc7YpDKUdwR+yYkPmobvwgDYEMd/KFtjjjmSafw
	 l0hq2VTSG0vYK1VrB36BRuUeDHvVrz+sdhNunzIz8KDcvaL+SYqqRnTO4TmqDzBlO8
	 v0KyTw/i1xlVfIE1wTlIk2HH7Je1fqTsawKAD1DLomhGcr8H717Q2wYqTWJizWhi3S
	 /7py3unlO1Gxc5HK3dQPTqTUQ4ES0SMPSQAGgXqfRNBPl2yzG8T4fc0bFX3YdT8QK4
	 N0vUWkS+VizmGiVXpGA9JARGAUO8AaAIipY9ZYIbIiJX/Xj36TzkVqnpcs8e2E7Gz5
	 BdUKYEKiltbhw==
Date: Wed, 8 Oct 2025 14:40:29 +0100
From: Mark Brown <broonie@kernel.org>
To: Sune Brian <briansune@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: wm8978: add missing BCLK divider setup
Message-ID: <58756837-9be7-4027-b951-401ceeb69e4c@sirena.org.uk>
References: <20251007145028.1845-1-briansune@gmail.com>
 <aOUv69rMkyYFiHae@opensource.cirrus.com>
 <CAN7C2SDUiuMfPs_X5r0RDC56313aJsfhfx0-juhZRKGTb1OKuA@mail.gmail.com>
 <e78c9cc0-4a1f-4a22-9cba-a8213a7b9301@sirena.org.uk>
 <CAN7C2SDMB8_b-m0ZMzuSmhHxWpA10mcxxxDMKWuNe6wfiEXo-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y18mBiCfWAz+F7/N"
Content-Disposition: inline
In-Reply-To: <CAN7C2SDMB8_b-m0ZMzuSmhHxWpA10mcxxxDMKWuNe6wfiEXo-g@mail.gmail.com>
X-Cookie: 10.0 times 0.1 is hardly ever 1.0.


--Y18mBiCfWAz+F7/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 09:26:16PM +0800, Sune Brian wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:12=E5=AF=AB=E9=81=93=EF=BC=9A

> > Consider the case where the BCLK needed is 100 and SYSCLK is 198.
> > Dividing by 1 will result in an absolute difference of 98 and a BCLK of
> > 198 while dividing by 2 will result in an absolute difference 1 and a
> > BCLK of 99 which is lower than the required BCLK.
>=20
> for (i =3D 0; i < ARRAY_SIZE(bclk_divs); i++) {
> bclk =3D wm8978->f_256fs / bclk_divs[i];
> if (abs(bclk - target_bclk) < min_diff) {
> min_diff =3D abs(bclk - target_bclk);
> bclkdiv =3D i;
> }
> }

Your mail client has made this extremely hard to read.

> Cycle 0: min_diff=3D0xffff_ffff
> bclk =3D 198/bclk_divs[0] =3D 198/1=3D198
> bclk-target_bclk =3D 198-100 =3D 98
> 98 < 0xffff_ffff
> min_diff =3D 98
> bclkdiv=3D0

This is OK, BCLK is 198.

> Cycle 1: min_diff =3D 98
> bclk =3D 198/bclk_divs[1] =3D 198/2=3D99
> bclk-target_bclk =3D 99-100 =3D 1
> 1 < 98
> min_diff =3D 1
> bclk_div=3D1

This is not OK, BCLK is 99 which is less than 100 so there are not
enough BCLK cycles to clock the samples.

--Y18mBiCfWAz+F7/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjmac0ACgkQJNaLcl1U
h9B/3Af+O8VEXHOun8UdMgX8dlTSnoxN5QLlgmpvFH1clhfY4d8Ryhz44jXi4vIb
eOcAvttScBFTtkbAKDT97W2VHdJgI1o0hfTY2phggu0G5yNAKKy78OrmwaFsEKC5
GuIPWG7CTm/28E6dDgBCdlZ5PCQdvdySYR0mGjenjZyY97t1v2Q6Aos5V7z2NNQb
/kMGSgIPMbnpIeDBVITTOlzb5ho2DGXV14+QPbSXym9i28ukG6bptRiy+8hVPOj1
ZLHlgMXq6IOZAfGvjA7vJhBj2XZyDxBb4Z2dv2Kmt/lBu6tX9pJlM/h8WVECqmMk
bTCVmqU8h4S4M3+bpcmmQZhVHAMetQ==
=uMJf
-----END PGP SIGNATURE-----

--Y18mBiCfWAz+F7/N--

