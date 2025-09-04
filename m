Return-Path: <linux-kernel+bounces-801532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55859B4464A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789687AC287
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CF7270569;
	Thu,  4 Sep 2025 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5/eO+uE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0189315DBC1;
	Thu,  4 Sep 2025 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757013743; cv=none; b=Ycisn5ZuMtu38lSXjjtV0fgtIaQTQL2cU1xZTgcEtTLodPSzEbPfAfHa0yGfksoVJahqZpXcu3zzDd4vbQXskiN+4hadG+slIpru1nbQ8L+UM5hMMEed/3RD3ipqDptifbPlglchyaj2pHjT6bTKcnvMMmocFbZvE/EtKdIEV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757013743; c=relaxed/simple;
	bh=Lq715o4AtQ1M/Ec2GCwC/M7b+u8Q7zWIeKZ45ythTf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgYiPUM+8ViiIK+7J5tUXTqyskTXMAIsXzHZJWq75OBSgCxAC64OTZFsqv8vpYM5eWot5xaWeVeCwAdgT3xqE9Db4hC3yjfnOV7AJBn+bu93yyA2I5T9b9YbcPtsKXSgc1LX7GEyZKukO/MlT/ArGpLkckSrqezA+ckmLtEIT9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5/eO+uE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE0DC4CEF0;
	Thu,  4 Sep 2025 19:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757013741;
	bh=Lq715o4AtQ1M/Ec2GCwC/M7b+u8Q7zWIeKZ45ythTf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5/eO+uE82zes/6v7IZAQJPKG2GeaZ/MF1Rt05Y9wLk0c19z8DE5XaCYEN4cnKdQs
	 3dDQyK0kGtyMOD3Ku47SRXl96mcD6UM4YLl/+EV4lts9r37S0ykCGM4UEcFNhjZ9ZQ
	 9kVA3oGdsftwap540m5w/ouh/vhn9vgNOe7H8HHEoYIJZ1DpgnR6DZGkojuGcauj+l
	 ZpwWAIkbz2EgC27gO8GDyEVSifAIwxGiVzsn2EStv/3vp+x6i86OCy3YI6vng5kT4w
	 I4GgQik3IutMUowHBejzXAdOEsdzm5GpIVrNENzbLSXQgAs0iB9n3aYaj4K/HhXiOD
	 fViK5ZX07sPyQ==
Date: Thu, 4 Sep 2025 20:22:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250904-molar-prune-4d3420b1bcb4@spud>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
 <20250904154402.300032-14-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RNJ48Z5sF50vbdIN"
Content-Disposition: inline
In-Reply-To: <20250904154402.300032-14-vladimir.oltean@nxp.com>


--RNJ48Z5sF50vbdIN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04, 2025 at 06:44:01PM +0300, Vladimir Oltean wrote:
> Going by the generic "fsl,lynx-28g" compatible string and expecting all
> SerDes instantiations on all SoCs to use it was a mistake.
>=20
> They all share the same register map, sure, but the number of protocol
> converters and lanes which are instantiated differs in a way that isn't
> detectable by software. So distinguish them by compatible strings.
> At the same time, keep "fsl,lynx-28g" as backup.

Why keep the backup? Doesn't sound like you can use it for anything,
unless there's some minimum set of capabilities that all devices
support. If that's not the case, should it not just be marked deprecated
or removed entirely?

>=20
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>  .../devicetree/bindings/phy/fsl,lynx-28g.yaml     | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml b/Do=
cumentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
> index ff9f9ca0f19c..55d773c8d0e4 100644
> --- a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
> +++ b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
> @@ -11,8 +11,17 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - fsl,lynx-28g
> +    oneOf:
> +      - items:
> +          - const: fsl,lynx-28g
> +      - items:
> +          - enum:
> +              - fsl,lx2160a-serdes1
> +              - fsl,lx2160a-serdes2
> +              - fsl,lx2160a-serdes3
> +              - fsl,lx2162a-serdes1
> +              - fsl,lx2162a-serdes2
> +          - const: fsl,lynx-28g
> =20
>    reg:
>      maxItems: 1
> @@ -33,7 +42,7 @@ examples:
>        #address-cells =3D <2>;
>        #size-cells =3D <2>;
>        serdes_1: phy@1ea0000 {
> -        compatible =3D "fsl,lynx-28g";
> +        compatible =3D "fsl,lx2160a-serdes1", "fsl,lynx-28g";
>          reg =3D <0x0 0x1ea0000 0x0 0x1e30>;
>          #phy-cells =3D <1>;
>        };
> --=20
> 2.34.1
>=20

--RNJ48Z5sF50vbdIN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaLnm5wAKCRB4tDGHoIJi
0pErAP9yvf3WBafNeMNSZ2REiiIYTnnAkYySqATqbln4O/ZYAgD/UvrGl28vLgSC
Z1g1U1BnJkUXXdApv5dywfEXMFCl4gA=
=dIYP
-----END PGP SIGNATURE-----

--RNJ48Z5sF50vbdIN--

