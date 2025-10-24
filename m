Return-Path: <linux-kernel+bounces-868601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC5C059A3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCC33AE3C3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4CB30FF25;
	Fri, 24 Oct 2025 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWjDwZ9n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084230FC11;
	Fri, 24 Oct 2025 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301814; cv=none; b=HLuTO47xOO31CC7NGW8FZYCj86TX0uQzTbZU59WP6rGSQbeMY+l9t1TxnDjlP7Suq4bOHYSCtyDxgUab0Ngqhym9bEaPamBHFsrwVutyK3lY2XjcxCT0cqbotMapxTn7yHDn6h+Xr3nogh2AVCpmpGFmpr3wQSn58CMxNu2Ym1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301814; c=relaxed/simple;
	bh=JU9mlLt5OFRo9F3ipiVVfRJPb3nIO9fCv0eDi81ROAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMeHxXTZGi2yUyEBjsCe+6PHFRpwTwRNZcyfjtG5Dhx/e8N3D/mJG4lrJbEH2D7Wd0qQF4kxdOw7WstvrNL9+s7XgCS+1BKjlr/4n9wptWAtiBZea7/LXFgrKu2j669qyKi7gJK/thK69Q0d8QgyeTManHj72FNUIFDG3MEIgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWjDwZ9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0A9C4CEF5;
	Fri, 24 Oct 2025 10:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761301813;
	bh=JU9mlLt5OFRo9F3ipiVVfRJPb3nIO9fCv0eDi81ROAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GWjDwZ9npxXBtV2wwplsijKuUsN0XUNVpsE05e6x/WQuRcMorBffSwDuHBbrW15kC
	 Tv1HyF+JDvnLqZ3EQoqMdRUX4xBLxYUUMHgCaIx+SrlMwrvEAJPjUh+kg2cwE7q6ko
	 Iypv+pjIalmm+SxDbaLkPvrDWdwTFVXu2JzNq0l3tq7kConUDhsDI2Xp48Mh4idl4F
	 samQXBBSIHg35Ebu29n64Q8Pj0BRmkVTc2Fqhp96tvPyxh6K/HVlA1331/2/WQl64Q
	 RpIhVDJaAmSlbgwWH2X5UZjDY4yNOo79AUA8xvxwalNDuYrNXnqDwS0eRZN6JrDn4Z
	 dljrzU5iAzZ0A==
Date: Fri, 24 Oct 2025 11:30:08 +0100
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
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH v5 5/9] clk: microchip: mpfs: use regmap for clocks
Message-ID: <20251024-vocalist-irritable-dcac9f7db3ce@spud>
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
 <20251013-undercook-flatfoot-70dca974cd19@spud>
 <ab443375-524d-4e6c-a640-7e580c2d0c64@tuxon.dev>
 <20251024-dimness-everyday-1c074ce1f203@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cmdZOH2jDCUBULep"
Content-Disposition: inline
In-Reply-To: <20251024-dimness-everyday-1c074ce1f203@spud>


--cmdZOH2jDCUBULep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:20:23AM +0100, Conor Dooley wrote:
> On Thu, Oct 23, 2025 at 07:06:01AM +0300, Claudiu Beznea wrote:
> > On 10/13/25 20:45, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > > +static int mpfs_cfg_clk_set_rate(struct clk_hw *hw, unsigned long ra=
te, unsigned long prate)
> > > +{
> > > +	struct mpfs_cfg_hw_clock *cfg_hw =3D to_mpfs_cfg_clk(hw);
> > > +	struct mpfs_cfg_clock *cfg =3D &cfg_hw->cfg;
> > > +	unsigned long flags;
> > > +	u32 val;
> > > +	int divider_setting;
> >=20
> > This could be moved near flags to keep the reverse christmas tree order=
 as
> > in the rest of this patch.
>=20
> The driver doesn't (intentionally) use reverse christmas tree. If it
> does, that's just a byproduct of putting bigger types before smaller
> ones.
>=20
> > > +	divider_setting =3D divider_get_val(rate, prate, cfg->table, cfg->w=
idth, 0);
> > > +
> > > +	if (divider_setting < 0)
> > > +		return divider_setting;
> > > +
> > > +	spin_lock_irqsave(&mpfs_clk_lock, flags);
> >=20
> > As spin locking is introduced in this file by this patch, you can go
> > directly w/ cleanup helpers for locking.

Actually, if using regmap_update_bits(), locking might be entirely
removable. Depends on if there's some rmw sequence that can't move to
that.

> >=20
> > > +
> > > +	regmap_read(cfg->map, cfg->map_offset, &val);
> > > +	val &=3D ~(clk_div_mask(cfg->width) << cfg_hw->cfg.shift);
> >=20
> > Why cfg_hw->cfg.shift here --------------------^ but cfg->shift on the =
next
> > line?
> >=20
> > > +	val |=3D divider_setting << cfg->shift;
> > > +	regmap_write(cfg->map, cfg->map_offset, val);
> >=20
> > Can't the regmap_read() + updated + regmap_write() be replaced by
> > regmap_update_bits() ?
>=20
> Yeah, I suppose it could. Ultimately what's here is a revert of with
> readl()/writel() replaced by regmap operations directly, so the answer
> to the above three items is that that's how they were done before the
> patch I am reverting. That's probably the answer to 90% of the things
> you've said here, this is how they were done prior to the commit I am
> reverting.
>=20



--cmdZOH2jDCUBULep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPtVMAAKCRB4tDGHoIJi
0uf0AQDkUwMVo2nLuCjUiqS8lzzjgsUHyqv+EenABprkO/fhJAEAzoGnYa8a2STF
Q4Yml7WMygK6osuskoNBZTG8Nj5Trw0=
=qgBc
-----END PGP SIGNATURE-----

--cmdZOH2jDCUBULep--

