Return-Path: <linux-kernel+bounces-889216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7890FC3CFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84E594E3976
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6542D8790;
	Thu,  6 Nov 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnFKoMEF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB692D97AF;
	Thu,  6 Nov 2025 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452006; cv=none; b=kwyRL4KSerflbtDkGxM7aXGFfnEmSPcDlA1baDT/XItdPxI+Nzbr8TNwllPUBzzUXr7Gr1+S44OfhyZmElk+Vb0LAp5IeOh/2/Q9nz7wT9wr5sP7rcSNsnncEe+tDL1Ep4nanxtlOgGGi0/iIRoeoR6KbQm0gqhZCyYyK9jqJII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452006; c=relaxed/simple;
	bh=K+BPFyLCfamSMDwZ8KsDrlpG6nZVikNteJeFbcNvR1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJEU4Acgl/KCBPbbLHjBYHlf2xov93214ACCQBC97EBQHjy9jyb50NMKH9WEvRi8UizELjZNWpEHFfJXlA+4beWggpK9Gc+cy/armXiTjuUkahZETbJcIdRdf7hilGOUmEPL7y/Ba117DCqu3L0CV2BT0PO6xMIQjZ8jTDEEQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnFKoMEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9C7C4CEFB;
	Thu,  6 Nov 2025 18:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762452006;
	bh=K+BPFyLCfamSMDwZ8KsDrlpG6nZVikNteJeFbcNvR1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnFKoMEFqcXmAXLY7UpAsgh5Zec4rO+wbWtiCLFMA0YR81DrS5LpP5k7y5PcQUdEH
	 OHPUB95uvy5Br5km/980AHA7p18JHWwh5iUdqBD2qUPVCH+XrWB4jpGcZkvWPllhve
	 vtVo5ocT0IgZYEKj8d1BUs6OVVna3GtqZKqfxzF57TgBJwPaa6ekCTZPa4PUgTD06t
	 qFgeIxkuudLyEB2YJdAs7DZgFQBlxoR+pkFVHrGY0PFWTxqaLV/K6MqbM35wdRNRB5
	 rcyWKKOSfLGbekmDsDU0td2VopjUj/ty34vSQIcZjfB7xy+/GSV0rQQRPfQHUSxvIC
	 12D7G+CbMvclw==
Date: Thu, 6 Nov 2025 18:00:01 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: imx6ul-clock: add optional clock
 enet1_ref_pad
Message-ID: <20251106-trapezoid-evaluator-b6bff0ce8932@spud>
References: <20251105-ccm_dts-v1-0-6aadcdf97cb8@nxp.com>
 <20251105-ccm_dts-v1-1-6aadcdf97cb8@nxp.com>
 <20251106-seventeen-gilled-5146c6dc9720@spud>
 <aQzhbZwEYgALKqPJ@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HEXwvQb1v3ypYyEa"
Content-Disposition: inline
In-Reply-To: <aQzhbZwEYgALKqPJ@lizhi-Precision-Tower-5810>


--HEXwvQb1v3ypYyEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 12:57:01PM -0500, Frank Li wrote:
> On Thu, Nov 06, 2025 at 05:44:36PM +0000, Conor Dooley wrote:
> > On Wed, Nov 05, 2025 at 11:55:28AM -0500, Frank Li wrote:
> > > Add optional clock source enet1_ref_pad, which input from ENET ref pa=
d.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/clock/imx6q-clock.yaml  | 4 ++++
> > >  Documentation/devicetree/bindings/clock/imx6ul-clock.yaml | 4 ++++
> > >  2 files changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml=
 b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > > index cd3c04c883df4ab02af29582369757df36269cb6..49475aec22a81ba87048e=
ef588368261cbb38465 100644
> > > --- a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > > +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > > @@ -29,20 +29,24 @@ properties:
> > >      const: 1
> > >
> > >    clocks:
> > > +    minItems: 4
> > >      items:
> > >        - description: 24m osc
> > >        - description: 32k osc
> > >        - description: ckih1 clock input
> > >        - description: anaclk1 clock input
> > >        - description: anaclk2 clock input
> > > +      - description: clock input from enet1 ref pad
> > >
> > >    clock-names:
> > > +    minItems: 4
> > >      items:
> > >        - const: osc
> > >        - const: ckil
> > >        - const: ckih1
> > >        - const: anaclk1
> > >        - const: anaclk2
> > > +      - const: enet1_ref_pad
> >
> > I think you could drop the _pad from here, and just make it enet1_ref.
> > Only a suggestion though,
>=20
> The old dts already use enet1_ref_pad. But anyway, after I double check
> that it should be enet_ref_pad for 6q, enet1_ref_pad for 6ul.

Okay, cool. You can retain the ack on the new version with the 1
removed from 6q.

--HEXwvQb1v3ypYyEa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQziIQAKCRB4tDGHoIJi
0scfAP48vkBJzTstyVGwHIy6JnaQfvK8Pr/lOLLAEyXPEDKEqwD/ZY0vXFQRYQXR
oJAO3KS+3P5a518czGSMjX+ALexZAgY=
=IguN
-----END PGP SIGNATURE-----

--HEXwvQb1v3ypYyEa--

