Return-Path: <linux-kernel+bounces-746142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA2B1239F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4E67B73D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FC42F0053;
	Fri, 25 Jul 2025 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGzw35ga"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26928C865;
	Fri, 25 Jul 2025 18:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467051; cv=none; b=mMU4AcmwhSJvcrSP2ZSlFIx8+y/zt9uiTiomHJ8ZrSkZ1kmzMeTzINTJFL9g053+M7GwpKSUmYhQCxIhX8iqRp6C0YGwfuk8C6+FEu4XPtMpYyF3Sscpsdhgwbf0JhmLLGsUS5AqwRK1zIETCP0sIWmq9V8GojCBqSplenjJQms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467051; c=relaxed/simple;
	bh=ri7jZCPA0DuqHqHzf3trIUgc4pLAhXJnKkCs7V2+7sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmPQsOyJY1f4MCxTcrYlZc4YBM5fpLzPGU/2NI4miz3TsAACwO7mCgzTaREDUUurJ8yTBWcK5NsYrd1zKcYBjfdc6i5oZh2YegA0FQMO67cNjtiDDJAAWYDZ7ilm22nswUMiUsQlc606fmcwvL9JvsgzzACNkO7d//HPi4OjG8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGzw35ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D2FC4CEE7;
	Fri, 25 Jul 2025 18:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753467051;
	bh=ri7jZCPA0DuqHqHzf3trIUgc4pLAhXJnKkCs7V2+7sI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGzw35ga3OQ59CyvGtuk2QLwuybS3IELuNLY9mFhjKQhkAgyeOWTTij5StjKAYitj
	 BQomCsvSUxK+cNQaB0WcAR+HF5rieI6Dj/HzG18FplUyWsnGrMzqlk464c4vkg8anY
	 mTsDmxXfnMT5cBhNL1vEKsnIk8ocVbHd8RdVG8wpkCDluhgVvmBHU/L37KGbIoIGuD
	 2zI4wdHdtO4QBlPZZ0Mq/KNIlhc1+jXqIMU6SED3nvteXGJ+wa6TEaPskzXjaja6Fi
	 cvJGCicMsuEMKT5W9aTRFbyZfqj7/gn+lXJYSCnftpRRFZ1IiusnrGbmScb518FV1C
	 oLLvgnllFaPTQ==
Date: Fri, 25 Jul 2025 19:10:46 +0100
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	William Qiu <william.qiu@starfivetech.com>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-common: drop no-sdio
 property from mmc1
Message-ID: <20250725-disorder-graceless-23c95454244d@spud>
References: <20250724075600.239522-1-e@freeshell.de>
 <20250724-equal-limb-2922f240961e@spud>
 <43c5908c-c478-4e00-b1e5-955296e4ec24@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vFc/GG+76alb8wgR"
Content-Disposition: inline
In-Reply-To: <43c5908c-c478-4e00-b1e5-955296e4ec24@freeshell.de>


--vFc/GG+76alb8wgR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 10:13:47PM -0700, E Shattow wrote:
> On 7/24/25 09:51, Conor Dooley wrote:
> > On Thu, Jul 24, 2025 at 12:55:53AM -0700, E Shattow wrote:
> >> Drop no-sdio property avoids a delete-property on variant board dts
> >> having an SDIO wireless module connected to mmc1.
> >=20
> > I'm struggling to understand why this change is correct.
> >=20
> > If there are specific boards that have wireless modules connected
> > instead of using sdcards, how come the no-sdio property isn't moved to =
the
> > the boards that do have sdcard slots?
>=20
> Why is 'no-sdio' property there to begin with...
>=20
> > The property was added for the visionfive 2, and only on mmc1, so should
> > it be retained for boards that match the visionfive 2 in terms of how
> > they use mmc?
>=20
> Ref.:
> https://lore.kernel.org/lkml/20221207131731.1291517-4-william.qiu@starfiv=
etech.com/
>=20
> My theory is VisionFive2 board hardware can support connecting up some
> SDIO module there with ready-made available adapters, it may be possible
> (if unusual) that would work? SDIO is 4-wide and some voltage
> requirements, and a couple of GPIO, so I'm aware that's a stretch of a
> statement but it could be done without soldering. I wouldn't expect it,
> but why restrict this everywhere inheriting from jh7110-common.dtsi with
> 'no-sdio' and then (needs testing!) if it doesn't matter one way or the

In case it was not clear, I am not questioning removing it from the
common file, just that you're removing it entirely.

> other for VisionFive2 just drop it I think as being inaccurate/unnecessar=
y?
>=20
> JH7110 CPU supports two interfaces of SDIO3.0/eMMC so it's not clear to
> me if there's some reason for 'no-sdio' property to be there. Does
> allowing SDIO (?) break eMMC and SD Card devices, is it destructive?
>=20
> Not knowing what 'no-sdio' does technically I dropped the property and
> tested with the hardware I do have. The 'no-sdio' property
> present/absent does not appear to do anything user-impactful on Pine64
> Star64 that has SD Card slot on mmc1, and as would be expected on Milk-V
> Mars CM Lite WiFi when there's an SDIO module at mmc1 it then fails to
> initialize if 'no-sdio' property is present.

The original addition looks very intentional - however I didn't look at
the commit message itself last night, just the diff. I wonder if "no-sdio"
and "no-mmc" were just added because William intended to restrict SD
cards since sdio1 is the SD card slot, rather than because the use of
sdio or mmc commands during init would cause problems. The wording of "Set
sdioo node to emmc and set sdio1 node to sd" is what makes me think
that.

> > Could you add an explanation for why removing this entirely is the right
> > thing to do, rather than only removing it for these variant boards?
>=20
> Yes, I can rephrase a bit like "relax no-sdio restriction on mmc1 for
> jh7110 boards", or else reconsider the approach. I was going to approach
> with `/delete-property/ no-sdio;` later elsewhere but after testing on
> Pine64 Star64 with similar configuration to VisionFive2 mmc interfaces,
> and knowing that Milk-V Mars CM Lite WiFi detects AP6256 SDIO peripheral
> at mmc1 when this property is dropped (and with a few additional
> things)... I prefer to reduce the problems that would need to be avoided.

I think using /delete-property/ would be unwise, properties shouldn't be
in the common dtsi if they are not, in fact, common.

> I have done all the testing I can do with hardware I have. As-is it's
> just like I wrote, we'll have to solicit some testing feedback on that
> and wait to learn what this does for the other boards.

I'd kinda be inclined to apply this diff, with a better commit message,
shortly after -rc1, unless someone comes forward with a justification
for it being there on the vf2. I figure it's only in the common dtsi
because it was not problematic until now cos noone tried to use the sdio
aspect.

> Aside, anyone want to chime in what is the utility of 'no-sdio'
> property, how do you know from a schematic if it is appropriate, can it
> be simply dropped as I suggest for JH7110 boards?

My (limited) understanding, mostly from looking at the caps in
mmc/host.h because I find the binding description obtuse, is that these
properties (no-sdio and no-mmc) block the use of commands that would
cause a device to malfunction. They don't appear to be required at all just
because the board layout doesn't support these types of devices.

Conor.

--vFc/GG+76alb8wgR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaIPIpgAKCRB4tDGHoIJi
0mBcAQD+A96JAVhCxAjxPYXSaFPQqB2LxWezej/NuFO0RC1CHwEAy2m06gpZsX5l
9XUN6qKUEUe8ijVeBcUwf9m8mN75SQI=
=EhER
-----END PGP SIGNATURE-----

--vFc/GG+76alb8wgR--

