Return-Path: <linux-kernel+bounces-838051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F56FBAE529
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FB31925EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77D8258EDE;
	Tue, 30 Sep 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h05EiDDm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F0E1C68F;
	Tue, 30 Sep 2025 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759257420; cv=none; b=W0wBa6FexAfmoyZi8ZJiAflxfnxQAWximFUCMGnln3cAShbmaLZ133favZYz7fFQCa7aomEdmNliDtS0YE0ItjPwNBIDSiykFF7qRYZRTu4fWriO8WD5afBRe+KpHaEiOM0HYTjEokBmfNtO++KvoGVlKHGz15ozeOqKq7B8FmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759257420; c=relaxed/simple;
	bh=b0DO6QcFb+m6/nmTuU5im+jk0/VqEOzpAugWjXSZukc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlOFHJLiXvjVPkvvNg/gBNTAq/lne3I+AFnQmvdwrd368eKRF+FWnwfRvR8boaD8LXxyU9iD4eZAvjupSQrQixQ9QgDgDjSAt1h/BcZcFVIcvgmvB6Znr9gaZd2dS7BHlvFlpzh8hnh4pbqH+Rg76d3xOjJS5P1JibVxq2gx77k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h05EiDDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B043C4CEF0;
	Tue, 30 Sep 2025 18:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759257419;
	bh=b0DO6QcFb+m6/nmTuU5im+jk0/VqEOzpAugWjXSZukc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h05EiDDmLZSDnM4ZsKoHRYybhWLmI/4M+y4jhrTFRnfPn2fR3jfKFUGIbdnfOt0IZ
	 ntnrRwnMmfBmI1aYz5Tv/0EX7R8jpOlTpDy39jrWF6SJNRcXxaxzraBkqFHwDE93QF
	 tjZkzGGZDVs45y5PYryING89IycDANflyGsJfLEv8rzID5OO6JH7Q8suw4wTJEM6u7
	 rAyeVbUZRWpcVtXMyH5Vt5uTWrQzRelUU2VaLja5Ug1fHIBhY214G+w3VHsDO8WPrD
	 Pm6z+75SWrTqntdE/ZkEOAp4Kpr5ft5nkXJ1noJQs8FjllDmXwEp87HLYfEbXV5yQW
	 WRFCFtggsjHwQ==
Date: Tue, 30 Sep 2025 19:36:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Guangjie Song <guangjie.song@mediatek.com>,
	Laura Nao <laura.nao@collabora.com>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>, kernel@collabora.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: clock: mediatek: Add clocks for MT8196
 mfgpll
Message-ID: <20250930-reconcile-apostle-64397f998a30@spud>
References: <20250929-mtk-pll-rpm-v1-0-49541777878d@collabora.com>
 <20250929-mtk-pll-rpm-v1-1-49541777878d@collabora.com>
 <20250929-whoops-kennel-5f54fb6559a8@spud>
 <3374975.aeNJFYEL58@workhorse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fZ4QstzZMSk1bYrw"
Content-Disposition: inline
In-Reply-To: <3374975.aeNJFYEL58@workhorse>


--fZ4QstzZMSk1bYrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 05:57:00PM +0200, Nicolas Frattaroli wrote:
> On Monday, 29 September 2025 19:31:36 Central European Summer Time Conor =
Dooley wrote:
> > On Mon, Sep 29, 2025 at 02:13:20PM +0200, Nicolas Frattaroli wrote:
> > > The clock controllers for mfgpll, mfgpll-sc0, and mfgpll-sc1 all need
> > > CLK_TOP_MFG_EB to be on if their clock control registers are touched =
in
> > > any way.
> > >=20
> > > This was not known at the time this binding was written, as this
> > > dependency only came to light when I started poking at the MFlexGraph=
ics
> > > hardware, where this undocumented peculiarity made itself known throu=
gh
> > > SErrors being thrown during register reads.
> > >=20
> > > Add a clocks property to the binding to describe this relationship, a=
nd
> > > mark it as required for the affected clocks.
> > >=20
> > > Fixes: dd240e95f1be ("dt-bindings: clock: mediatek: Describe MT8196 c=
lock controllers")
> > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > ---
> > >  .../bindings/clock/mediatek,mt8196-sys-clock.yaml  | 28 ++++++++++++=
++++++++++
> > >  1 file changed, 28 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8196-=
sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8196-sy=
s-clock.yaml
> > > index 660ab64f390d2e722b7d3e25cf057926da318bc0..41aacd8d5f69050eebdf8=
392f7b652427632f491 100644
> > > --- a/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clo=
ck.yaml
> > > +++ b/Documentation/devicetree/bindings/clock/mediatek,mt8196-sys-clo=
ck.yaml
> > > @@ -45,6 +45,9 @@ properties:
> > >    reg:
> > >      maxItems: 1
> > > =20
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > >    '#clock-cells':
> > >      const: 1
> > > =20
> > > @@ -90,6 +93,23 @@ required:
> > > =20
> > >  additionalProperties: false
> > > =20
> > > +allOf:
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - mediatek,mt8196-mfgpll-pll-ctrl
> > > +              - mediatek,mt8196-mfgpll-sc0-pll-ctrl
> > > +              - mediatek,mt8196-mfgpll-sc1-pll-ctrl
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          items:
> > > +            - description: mfg_eb clock
> > > +      required:
> > > +        - clocks
> >=20
> > Don't you want an else: properties: clocks: false here?
>=20
> Possibly. I'm never quite sure how strict bindings should be when
> it comes to stuff like this. On the one hand, none of the other
> compatibles described in it use any clocks that we know of
> right now.

It's a bit case-by-case I suppose, but anything that is invalid and can
be easily prevented should be. Particularly in cases where information
about what's correct is harder to find.

> On the other, if we have a second set of compatibles that also
> needs clocks, but in a different way, would we repeat that for
> each such if/then condition? Or would be reformulate this as
> some oneOf/anyOf construct specifically for the clock property?

Depends on what's simpler to do. Sometimes it's better to have if/then
on a per property basis and sometimes separate entries under the allOf
per platform is. Usually depends on how unique each platform is.

--fZ4QstzZMSk1bYrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNwjRQAKCRB4tDGHoIJi
0k2bAQCjXXRncpKoMJR24/6cQoVfQTpI1s7ccTIPodjULJZPVwD/WV6udQlkMuX2
6ZxfAHeOTMBs515cJyWF94PA2GwEOAM=
=52m1
-----END PGP SIGNATURE-----

--fZ4QstzZMSk1bYrw--

