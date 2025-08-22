Return-Path: <linux-kernel+bounces-782460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD45B3209F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D7A18980CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28312580CF;
	Fri, 22 Aug 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8hLAZfJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5756D1F463C;
	Fri, 22 Aug 2025 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880629; cv=none; b=JXCp3kEO+7hU6hIJ8Pf+akyXeSSPqMVQPRAWytazdTjUSkwOgTLJ4rO45EjD+2qt6oIwcgl4e6V78gpxZ85oIdvMkfgfNLNQB8WHGpoxLnZ85P/Ia0J8NoI+JmBActKvxh/jI87GnjLcvN5llQ7ahJ4YfzSfNZq4ElNqwiRAlbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880629; c=relaxed/simple;
	bh=Nu4e6UeAXwVcvfZtjpDX4+Fvi5Hf97mH4y1qIQ3VZzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POkTcU3/NgeGouEkHlhywmkuvL/2y5LRK+hS0EoJo4VxkbbKZYxBDrSxoD3psn1HuUn9NLU6NWkkb2nY31UB3zM+B7vpqtTWuDpCJMD5M3wOIw2d55S9YaPzdTIkt/nSjSgMarIVZI7fsrFrVQH+W8fv9pxsPRN26rviYZl0Evo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8hLAZfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73852C4CEED;
	Fri, 22 Aug 2025 16:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755880628;
	bh=Nu4e6UeAXwVcvfZtjpDX4+Fvi5Hf97mH4y1qIQ3VZzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n8hLAZfJovCKOU2fELvFU+ZBcFqnowH+57AbthIsjm22+oAhTNi6jrkkShDDkK6K/
	 C1H8s6gvzNgkXr31PNpTZ4UMCG/1+hzaGo4VbrTKm/r+LrQ5wGvaWOI55XUeKNykvT
	 /jSzs4nHn9hFj1gb2KcPdkn6rZ0txqkgQnhe57K9CLyHSIJCjeTsQgr2OWkdLM7wc5
	 W8umRxG2B8NtlR/N5bVucmEIwDjeM2AjYC3sxBa07queDIccM1qoYlZ43ooRfiqC6b
	 D9zNd4dWYQxcO/nfvNYuzpk5PzHkPtB0GUYx+K9iKYzqGnGYiP5NHwB6Gf5ylsP3K7
	 BPZUyP/CprI9A==
Date: Fri, 22 Aug 2025 17:37:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 1/3] dt-bindings: riscv: Add StarFive JH7110S SoC and
 VisionFive 2 Lite board
Message-ID: <20250822-rascal-geometry-83c35926ea7e@spud>
References: <20250821100930.71404-1-hal.feng@starfivetech.com>
 <20250821100930.71404-2-hal.feng@starfivetech.com>
 <20250821-pencil-anguished-6b8467adbd38@spud>
 <ZQ2PR01MB13071F6F2732451DBE3BEE9DE63D2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nZfVf4i1qpRGT5hz"
Content-Disposition: inline
In-Reply-To: <ZQ2PR01MB13071F6F2732451DBE3BEE9DE63D2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>


--nZfVf4i1qpRGT5hz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 07:37:29AM +0000, Hal Feng wrote:
> > On 22.08.25 02:17, Conor Dooley wrote:
> > On Thu, Aug 21, 2025 at 06:09:28PM +0800, Hal Feng wrote:
> > > Add device tree bindings for the StarFive JH7110S SoC and the
> > > VisionFive 2 Lite board equipped with it.
> > >
> > > JH7110S SoC is an industrial SoC which can run at -40~85 degrees
> > > centigrade and up to 1.25GHz. Its CPU cores and peripherals are mostly
> > > similar to those of the JH7110 SoC.
> >=20
> > How "mostly" is mostly? Are there memory map or capability differences?
>=20
> To be precise, the CPU cores and peripherals are the same as those of the
> JH7110 SoC. I will improve the commit description in the next version.

Ye, please do. The complete lack of differences other than thermals
and cpu performance is what allows you to use all the same compatibles
for the peripherals after all!

>=20
> Here are the differences between them:=20
> JH7110 supports 0~70 degrees centigrade and up to 1.5GHz.
> JH7110S supports -40~85 degrees centigrade and up to 1.25GHz.
>=20
> Best regards,
> Hal
>=20
> >=20
> > >
> > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> > > ---
> > >  Documentation/devicetree/bindings/riscv/starfive.yaml | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml
> > > b/Documentation/devicetree/bindings/riscv/starfive.yaml
> > > index 7ef85174353d..a2952490709f 100644
> > > --- a/Documentation/devicetree/bindings/riscv/starfive.yaml
> > > +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> > > @@ -33,6 +33,11 @@ properties:
> > >                - starfive,visionfive-2-v1.3b
> > >            - const: starfive,jh7110
> > >
> > > +      - items:
> > > +          - enum:
> > > +              - starfive,visionfive-2-lite
> > > +          - const: starfive,jh7110s
> > > +
> > >  additionalProperties: true
> > >
> > >  ...
> > > --
> > > 2.43.2
> > >
>=20

--nZfVf4i1qpRGT5hz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaKicsAAKCRB4tDGHoIJi
0sCgAQCngjj8rbPb0Af9BMZYRbpS50JcfXIJv0U+8Lki4SL4CQEAzz2rJzTiq/u6
Udk42wTGzXD6bXBGwcGrUnFUsV713ws=
=6L7i
-----END PGP SIGNATURE-----

--nZfVf4i1qpRGT5hz--

