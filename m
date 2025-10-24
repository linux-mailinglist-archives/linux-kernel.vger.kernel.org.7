Return-Path: <linux-kernel+bounces-868582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5867AC058CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E373B4956
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A12730F925;
	Fri, 24 Oct 2025 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+m0hwPs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2CF2F7AD3;
	Fri, 24 Oct 2025 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301229; cv=none; b=RJp4PbPUem4Xg8boj68Kxf8qkp405iwjfyD+tu1FAADy3cvlhw9WErSH8oXWxWs8DhqyU7MlMmBZcWoe7kCdxRD5yi4Pk5W42vGFNuVp0GN+i2E0CYzuIjHuP1Sjxb9Z1GN2FtGm/qwIGeEKx+SNC/OgXMSXqDaVbWeAEJh+vRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301229; c=relaxed/simple;
	bh=FnW71TqPVzXRwI0dpG/xTBjzIyGRYlri2cV1BYifyeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6VIVsgRNEneo+Xps8ZKYKyKbBfEj75gPXhpuBFDAjyfmNrrcH6nR8xGYaosUw7ltxNsEl9BoDPAbvDLnmPwZpv1ixlOZeGIVuz/2TPNS4D9+8rL4RgwsqWUptcJaz6++t3D+1fnsBhCO0PLvgoRkEz0p3Q/BYwOlUSF3XQAFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+m0hwPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4A3C4CEF5;
	Fri, 24 Oct 2025 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761301228;
	bh=FnW71TqPVzXRwI0dpG/xTBjzIyGRYlri2cV1BYifyeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+m0hwPsa1c9TUACFZRnUOkfnRR//EoynKUc2HkHZer4k0ASAdUGyETGx+4DOd4/D
	 T3BqTR1lnp9a2tyc+UYGQKADQtoqLD6TKmNynKgNei1ThL7+S7Qk+DaJLUdwveuo5b
	 HtBPY6ZVlCVnkqYfuwh95NS8VnGSBjY2NgGwvXRiFc/WCjF454xtDd5274z7ReMfI8
	 tcCSlkNAa1y5lEccmQSqjwiZl+s58PvTDSo0TQ0rqZPmOpqAFZds6QPnGoU6K7Lw2e
	 Xpfa/CwIuZtVVUObftnAU0Rf0fmDrS/VxKJiCOehPFsRC4AKWT8n8Gpl4/wPjXPcMt
	 SXf+1m6g715zw==
Date: Fri, 24 Oct 2025 11:20:23 +0100
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
Message-ID: <20251024-dimness-everyday-1c074ce1f203@spud>
References: <20251013-album-bovine-faf9f5ebc5d4@spud>
 <20251013-undercook-flatfoot-70dca974cd19@spud>
 <ab443375-524d-4e6c-a640-7e580c2d0c64@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CLHXK2iYVH1gz/Qf"
Content-Disposition: inline
In-Reply-To: <ab443375-524d-4e6c-a640-7e580c2d0c64@tuxon.dev>


--CLHXK2iYVH1gz/Qf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 07:06:01AM +0300, Claudiu Beznea wrote:
> On 10/13/25 20:45, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > +static int mpfs_cfg_clk_set_rate(struct clk_hw *hw, unsigned long rate=
, unsigned long prate)
> > +{
> > +	struct mpfs_cfg_hw_clock *cfg_hw =3D to_mpfs_cfg_clk(hw);
> > +	struct mpfs_cfg_clock *cfg =3D &cfg_hw->cfg;
> > +	unsigned long flags;
> > +	u32 val;
> > +	int divider_setting;
>=20
> This could be moved near flags to keep the reverse christmas tree order as
> in the rest of this patch.

The driver doesn't (intentionally) use reverse christmas tree. If it
does, that's just a byproduct of putting bigger types before smaller
ones.

> > +	divider_setting =3D divider_get_val(rate, prate, cfg->table, cfg->wid=
th, 0);
> > +
> > +	if (divider_setting < 0)
> > +		return divider_setting;
> > +
> > +	spin_lock_irqsave(&mpfs_clk_lock, flags);
>=20
> As spin locking is introduced in this file by this patch, you can go
> directly w/ cleanup helpers for locking.
>=20
> > +
> > +	regmap_read(cfg->map, cfg->map_offset, &val);
> > +	val &=3D ~(clk_div_mask(cfg->width) << cfg_hw->cfg.shift);
>=20
> Why cfg_hw->cfg.shift here --------------------^ but cfg->shift on the ne=
xt
> line?
>=20
> > +	val |=3D divider_setting << cfg->shift;
> > +	regmap_write(cfg->map, cfg->map_offset, val);
>=20
> Can't the regmap_read() + updated + regmap_write() be replaced by
> regmap_update_bits() ?

Yeah, I suppose it could. Ultimately what's here is a revert of with
readl()/writel() replaced by regmap operations directly, so the answer
to the above three items is that that's how they were done before the
patch I am reverting. That's probably the answer to 90% of the things
you've said here, this is how they were done prior to the commit I am
reverting.


--CLHXK2iYVH1gz/Qf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPtS5wAKCRB4tDGHoIJi
0sNMAQDlxAVOoPeGx0hK7BMub2zdWhzl5Z42VCSLO0sdhyD3IAEAiM0jeYZctPm/
LnrQTlUDFXDzYmq5VgkJDAkrhjUULgk=
=KbJi
-----END PGP SIGNATURE-----

--CLHXK2iYVH1gz/Qf--

