Return-Path: <linux-kernel+bounces-868567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CF1C057CC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E041A04041
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC6930E84E;
	Fri, 24 Oct 2025 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcZskTxT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A355F305065;
	Fri, 24 Oct 2025 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761300428; cv=none; b=HDl+aAahiRNcd/yCrbS0KEymbQnu7kjfDIDJ1KT4nKMltUlViQh5k9kOkIs3j1VSLzF1jKny0eITgemCnnWKPA9Bx7nCGLEXwIQB7YMsakl8Jv+pj8umWSsIef27TIARM3LHMYj8whdeNqLdFqSdTym22+fBbqHFKAMNXk1/kJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761300428; c=relaxed/simple;
	bh=mAvyMZkDKEDQzM0cbfFWpMpv34LC/VLxM5Txgp0+6eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icjqC0lP+CK++b8e1KpRqgcW9jGf9+NWHpxQBKZlR2dTVEc6KX2FzdsR+UQhEzDki7NwiPcf9LIG4geHAgRSF5mFgXJ1t8xLnLV4lk5gMlJuQLECVgR+NCUWi8c2CfM01ePB+PmvKa7e/3g3Ngm739xxRJa3PMUwA5DUkwwL5eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcZskTxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68D6C4CEF5;
	Fri, 24 Oct 2025 10:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761300428;
	bh=mAvyMZkDKEDQzM0cbfFWpMpv34LC/VLxM5Txgp0+6eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CcZskTxTuVZTuy3uofRPvFha3nbGrmDbzJJteid6JGgVpeGmvo36leJYLYmH73zj0
	 wMc9mt5Jkxr/3Cwzswxak9gdaC3byg2lztBpPDHu3zi6vu3hzJVUGlQVngrMLxuZlX
	 rM9cbLDkS7lBtf2z8+rv/POmkY1RydtVhIPRIPF/PoVSSrJTH8r+09A15qUYjhdzec
	 Sinm1jN797NhM6lSrqf8wOv8WLJ83S+fy+vHDP4WmQcxe9/R6NSGu/s9rd0tN8UdAY
	 tgBpd7yn1lnFlENN+9ZUrXop7JsPhLwwwretliTcI/jLwrLvjM+4PBIEXCcwt/4iNY
	 7ONb1IoC40XyA==
Date: Fri, 24 Oct 2025 11:07:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] reset: mpfs: add non-auxiliary bus probing
Message-ID: <20251024-void-esteemed-832b3bf5b965@spud>
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
 <20251013-crane-utilize-cff9298291a4@spud>
 <60544429-3eeb-41df-b42c-613da651b4a1@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tXetbUU2Jb29E84+"
Content-Disposition: inline
In-Reply-To: <60544429-3eeb-41df-b42c-613da651b4a1@tuxon.dev>


--tXetbUU2Jb29E84+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 07:06:48AM +0300, Claudiu Beznea wrote:
> Hi, Conor,
>=20
> On 10/13/25 20:45, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > While the auxiliary bus was a nice bandaid, and meant that re-writing
> > the representation of the clock regions in devicetree was not required,
> > it has run its course. The "mss_top_sysreg" region that contains the
> > clock and reset regions, also contains pinctrl and an interrupt
> > controller, so the time has come rewrite the devicetree and probe the
> > reset controller from an mfd devicetree node, rather than implement
> > those drivers using the auxiliary bus. Wanting to avoid propagating this
> > naive/incorrect description of the hardware to the new pic64gx SoC is a
> > major motivating factor here.
> >=20
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > v4:
> > - Only use driver specific lock for non-regmap writes
> >=20
> > v2:
> > - Implement the request to use regmap_update_bits(). I found that I then
> >   hated the read/write helpers since they were just bloat, so I ripped
> >   them out. I replaced the regular spin_lock_irqsave() stuff with a
> >   guard(spinlock_irqsave), since that's a simpler way of handling the t=
wo
> >   different paths through such a trivial pair of functions.
> > ---
> >  drivers/reset/reset-mpfs.c | 83 ++++++++++++++++++++++++++++++--------
> >  1 file changed, 66 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
> > index f6fa10e03ea8..8e5ed4deecf3 100644
> > --- a/drivers/reset/reset-mpfs.c
> > +++ b/drivers/reset/reset-mpfs.c
> > @@ -7,13 +7,16 @@
> >   *
> >   */
> >  #include <linux/auxiliary_bus.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> > +#include <linux/mfd/syscon.h>
>=20
> Should you add a depends on MFD_SYSCON ?

Perhaps, but it's a NOP. This driver depends on the clock driver, which
does have a depends on MFD_SYSCON. I'll add it, but makes no difference
to either the build or functionality.

--tXetbUU2Jb29E84+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPtPxwAKCRB4tDGHoIJi
0uinAQDqJ3CDE8D9ZdZAqPBDpFO+5LryRbw842V3DiYnWn1NWAD8DNk95ic8DX2M
KR1ygcP7Fu/7AD8lobFc4LKzSL1XSg4=
=L2vi
-----END PGP SIGNATURE-----

--tXetbUU2Jb29E84+--

