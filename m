Return-Path: <linux-kernel+bounces-785188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509D0B3474C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C9FF7A9A38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7926C3002BF;
	Mon, 25 Aug 2025 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="My3XKBs3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED3E2FB62A;
	Mon, 25 Aug 2025 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139159; cv=none; b=dEn8xRQdNoJtsqMA2qp4eVdgMH7b50s9C9nzQAQFCdSKipdiCBDOhv7ETSjKTmXQUERBICXgUYYU8J265sobEQdPhDrpjn4XNlPeL+Z0WNZOTBkNgk3fBxnjKpuwtBPZHC5jfD8qWoHMzaMtKjaW/f4Gb1iwNmUz5zDhk0cC9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139159; c=relaxed/simple;
	bh=J2gyzcKTE9GWvybDM3VRwRpqKIbNxUNphgPALDmkhfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx10QM7H5dILJRVZ8fFu6a4R1jzjsOCSRXxzlKiGHZyfv6YdivWoohkN2d0qhWAFMuyuCZs5bkzZhmkWp/LtVGJRhVORN+zd1SQZVRJJ1rcUFr80Mb8dAqChQBJckE323XeY+OII1OKC5eUMazqviSSRQDfqxkav5UrFIKnKa6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=My3XKBs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E43AC4CEED;
	Mon, 25 Aug 2025 16:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756139159;
	bh=J2gyzcKTE9GWvybDM3VRwRpqKIbNxUNphgPALDmkhfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=My3XKBs3+VVGigaoBXzAeoDS0/NPwxsVCWrVRF3m6R74kwo1y6l+1LH6Yff58avBS
	 Ywq9sGjcUaZOcAH1NZ7fwinfnW2lDrmKdHdEOHIz2bWXUZBZa7LJ82KTLATdQwG8aT
	 Bw+bkBbEG6cOs0WmPZLyvW/o/RDH7xbicdQfcL9EuRqF35FeGkX1ZP74QPyadM7x9t
	 2cImsZ2PbXfitV5+OOoenb06Ilz2WkbQICp/yqmXEJGh2bZvrywtTOBFe1h2LYB1pG
	 uBOnjj2g4QfTHS70weAlJTRZ+zQ+UC9RRewqihlj89RiNn602HB7seyKF9o/jVAhZd
	 LwBgGzfPGWnAA==
Date: Mon, 25 Aug 2025 17:25:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: E Shattow <e@freeshell.de>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: memory-controllers: add StarFive
 JH7110 SoC DMC
Message-ID: <20250825-deniable-quizzical-1d829756fff4@spud>
References: <20250823100159.203925-1-e@freeshell.de>
 <20250823100159.203925-2-e@freeshell.de>
 <20250824-new-messy-raccoon-1c26b7@kuoka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XpSz1rGszf+u1S0O"
Content-Disposition: inline
In-Reply-To: <20250824-new-messy-raccoon-1c26b7@kuoka>


--XpSz1rGszf+u1S0O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 11:25:08AM +0200, Krzysztof Kozlowski wrote:
> On Sat, Aug 23, 2025 at 03:01:41AM -0700, E Shattow wrote:
> > Describe JH7110 SoC DDR external memory interface.
> >=20
> > Signed-off-by: E Shattow <e@freeshell.de>
> > ---
> >  .../starfive,jh7110-dmc.yaml                  | 74 +++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/memory-controller=
s/starfive,jh7110-dmc.yaml
>=20
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> There is no memory controllers driver change, so I am fine if this goes
> via SoC/DTS tree.  If you want me to pick it up, please ping on IRC.

That's cool, I will take it with the dts changes. Thanks.

--XpSz1rGszf+u1S0O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKyOkwAKCRB4tDGHoIJi
0mVlAQDjFslnNMpDhJCuj60iIG8Y0qWw3himg2L42FsoPtlY8AEAwZ3JJLRx5z9H
v+mhaUKVytggyS5On5DkHtM7QaQe6Ao=
=Ff6V
-----END PGP SIGNATURE-----

--XpSz1rGszf+u1S0O--

