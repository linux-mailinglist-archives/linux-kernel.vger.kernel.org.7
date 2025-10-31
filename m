Return-Path: <linux-kernel+bounces-880103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C944FC24E05
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ED271A66387
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32A9347BB7;
	Fri, 31 Oct 2025 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpJakExD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308F32F261D;
	Fri, 31 Oct 2025 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911751; cv=none; b=dA7p+OTnqFmS3I9bDK67XTwiJyd2a8t75rsYjUwo23YTOmLHq3byzGyHweDkZjdlsDf/6xp1vHCuDsHvMB11GIlqidxFrMyDEnS7Pdbn+K5clEB/pYcOIjhhhzzRobbHKJx0z/eKJ8qdTE/tY58sshS7CONvW3G67c+cj7wS034=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911751; c=relaxed/simple;
	bh=fIa0j/GtzmZQoXo7Ot/AE5uFcIg/11da1EjbWi+1FyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pcsf02VWu3JjbcOAFLTi75SXS8N/R9iSgak/l44mDwoT7Gm7JXt1WoiZ2QvcB3B5NUUfCD59vzRQ4mZyjbSBkI0yRzR2WFM7pgJgoZj3z5v6JqiqxfIfgpg+CTQJZDBg8kzKrRnvonKFlNIa4Q7sjZ8IUaO6iZwkNc5AMG2fLyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpJakExD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBE8C4CEFB;
	Fri, 31 Oct 2025 11:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761911749;
	bh=fIa0j/GtzmZQoXo7Ot/AE5uFcIg/11da1EjbWi+1FyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UpJakExDBsWMDyNT5cd0cPM42pmALGG2HG3KDlSC3d8/dEsp+7uftN1mBP9pSq2kC
	 SfzBHxziQDTrKJ01VLakWP/ATUknVzGs6NrPObaM+mqD7wncIu23SKVPxLczhm7VBp
	 5cwB36DRphXuiOt4h+PDSgirRDnzM4b9xQ1wHnNYf8Vov6UXW5xjf7UidadrsHiT1S
	 jd9AFjcrKoHNubKtEHzOyUSs0QlNtYQ7ZmYJaDX8FM3QqQUU1PEIzIk7VTCiAwOH/i
	 MgaRyAP/A0P+FRa4+2EC5Tw7LzIsFYLaQk+F5WSWrXNYtOZCQVQlBkZRYaiqMOs31A
	 lQIrDRXvqRt4Q==
Date: Fri, 31 Oct 2025 11:55:44 +0000
From: Conor Dooley <conor@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: claudiu.beznea@tuxon.dev, Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/7] reset: mpfs: add non-auxiliary bus probing
Message-ID: <20251031-rewrap-single-e13bbfd9f1bb@spud>
References: <20251029-chewing-absolve-c4e6acfe0fa4@spud>
 <20251029-macarena-neglector-318431fec367@spud>
 <4e3c3c3d6c1a0d2905a90e5f1c0b2cb8f67bc43b.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ertujbkv4Kiy4c2"
Content-Disposition: inline
In-Reply-To: <4e3c3c3d6c1a0d2905a90e5f1c0b2cb8f67bc43b.camel@pengutronix.de>


--3ertujbkv4Kiy4c2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 02:40:30PM +0100, Philipp Zabel wrote:
> On Mi, 2025-10-29 at 16:11 +0000, Conor Dooley wrote:
> > @@ -46,41 +52,46 @@ static inline struct mpfs_reset *to_mpfs_reset(stru=
ct reset_controller_dev *rcde
> >  static int mpfs_assert(struct reset_controller_dev *rcdev, unsigned lo=
ng id)
> >  {
> >  	struct mpfs_reset *rst =3D to_mpfs_reset(rcdev);
> > -	unsigned long flags;
> >  	u32 reg;
> > =20
> > -	spin_lock_irqsave(&mpfs_reset_lock, flags);
> > +	if (rst->regmap)
> > +		return regmap_update_bits(rst->regmap, REG_SUBBLK_RESET_CR, BIT(id),=
 BIT(id));
>=20
> This could use regmap_set_bits().
>=20
> > +
> > +	guard(spinlock_irqsave)(&mpfs_reset_lock);
> > =20
> >  	reg =3D readl(rst->base);
> >  	reg |=3D BIT(id);
> >  	writel(reg, rst->base);
>=20
> Since I've just seen this in the i.MX8ULP series [1], it would be
> cleaner to convert the aux driver to regmap as well. The readl/writel()
> code paths could be dropped then.
>=20
> [1] https://lore.kernel.org/lkml/20251029135229.890-1-laurentiumihalcea11=
1@gmail.com/

Yeah, it's definitely a lot neater this way. I'll do that. Patch ends up
touching the clock driver in the process, but I don't think that's a big
deal, since it's just the auxdev bits relating to the iomem pointer
becoming a regmap pointer instead.

--3ertujbkv4Kiy4c2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQSjwAAKCRB4tDGHoIJi
0vFhAQDkkuWAVOeVDtGSxjnEuSHfZc3mS1vaWbu8o2swToIRfQD/arEA8nv6Wdrl
4zip7L/VCNOznI8CuShbdOQVEj1BuAM=
=py6j
-----END PGP SIGNATURE-----

--3ertujbkv4Kiy4c2--

