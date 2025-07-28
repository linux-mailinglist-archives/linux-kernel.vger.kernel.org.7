Return-Path: <linux-kernel+bounces-748549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D684B14285
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE6D189FD46
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F31627874A;
	Mon, 28 Jul 2025 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/efa2CU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B5B1EDA2C;
	Mon, 28 Jul 2025 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753731423; cv=none; b=E9J27MR8APt0yEQ2v9PWxfh1TqJCb2m+/GP+415elLAu1Je3IzD0NSvk+Wawa06geECjWJOhM5C/caePKBL6oiTFEB5i6XLWajanphC9uEKj2h5ia/FKHRyMetla+FMUWXXnCzssuPYJyeqbW3ZKZ4b53c5Gpj6utNA6e02x4Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753731423; c=relaxed/simple;
	bh=2Sb9fBblq1FYAwuJDHOTzzqKufW/7NOkzrWORdlvt30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFEAY2pr5KbYeuhW/t8Tp/CzcDdse8v2JqhKDvROKG/co6GrI52AGturtv2GU87Fpx9i4k+HhaZVA1AA1r1j/+qcla5FRE+ayN382DSYp3JckxUNHkqDklXsH551d2JdZG0h7Xps3ppQewrbXUmBQYNYFj/ciUfzeTYFH/5aJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/efa2CU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B69EC4CEE7;
	Mon, 28 Jul 2025 19:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753731422;
	bh=2Sb9fBblq1FYAwuJDHOTzzqKufW/7NOkzrWORdlvt30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/efa2CU5jy3bq6KVvHApUHYUdpj8gSEzMyPr/A7154pGp9h8XxnYd4B3+CDkCLip
	 ZR0LivYkT3kYCE2li8Ar5OSQ2JGfX5KLj4pTvWRejo4cMT+yY/Rq+FK22Kt04sQz5H
	 ys/LtSV3lnG3XwJu+49VIxE+lfbutX/0i9uMwFX57cFUZRGfJ3FtH+6qf5mbsMrleL
	 RJYU3zbi3yxU+CZwVUKvDIyFvNjYb+0mLdQHmJK+zl1GVbD8yKFYRRDGSqNyAq24aH
	 HhGjDZGmnNSrxKwaFI9x+I6QDlroHFbdCMSjtmb4Uy/I6KU2b7MPqYifQCIxP/zR22
	 wv21/l5M4Z39w==
Date: Mon, 28 Jul 2025 20:36:57 +0100
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	William Qiu <william.qiu@starfivetech.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-common: drop no-sdio
 property from mmc1
Message-ID: <20250728-urethane-backside-52dfb7b96b3b@spud>
References: <20250724075600.239522-1-e@freeshell.de>
 <20250724-equal-limb-2922f240961e@spud>
 <43c5908c-c478-4e00-b1e5-955296e4ec24@freeshell.de>
 <20250725-disorder-graceless-23c95454244d@spud>
 <8841923c-cbb6-4cce-97f4-a851783b6102@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T4MMNLS7LDfTamu7"
Content-Disposition: inline
In-Reply-To: <8841923c-cbb6-4cce-97f4-a851783b6102@freeshell.de>


--T4MMNLS7LDfTamu7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 08:52:50PM -0700, E Shattow wrote:

> >> Yes, I can rephrase a bit like "relax no-sdio restriction on mmc1 for
> >> jh7110 boards", or else reconsider the approach. I was going to approa=
ch
> >> with `/delete-property/ no-sdio;` later elsewhere but after testing on
> >> Pine64 Star64 with similar configuration to VisionFive2 mmc interfaces,
> >> and knowing that Milk-V Mars CM Lite WiFi detects AP6256 SDIO peripher=
al
> >> at mmc1 when this property is dropped (and with a few additional
> >> things)... I prefer to reduce the problems that would need to be avoid=
ed.
> >=20
> > I think using /delete-property/ would be unwise, properties shouldn't be
> > in the common dtsi if they are not, in fact, common.
> >=20
>=20
> Ack, you wanted these moved out into each board dts? That would be okay
> with me. I suspected that `no-sdio` `no-mmc` don't belong so I'm still
> in favor of dropping them overall. I think nothing will break but I want
> more data from users.

Ye, moved out to the board dts is my preference over using /delete-property=
/.
Things that aren't actually common shouldn't be in the common file. I do
agree that in this case, removal entirely is probably the right call.
There's some sdio wifi cards that can go into sd card slots, so just
because the mmc controller is connected to a sd card slot doesn't mean
no-sdio should be used.

--T4MMNLS7LDfTamu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaIfRWQAKCRB4tDGHoIJi
0nmjAQCEANsDtguhRuMO4ZhwOLtWZ/dXuKM5l8uct25QPgTicAEAoy8sjgj/KZDz
gsDMRaML2ZB4DzXwCewRrkeNo73JDw4=
=opz+
-----END PGP SIGNATURE-----

--T4MMNLS7LDfTamu7--

