Return-Path: <linux-kernel+bounces-869933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1C9C09078
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 14:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BE5C4E3E0A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B782FBE1A;
	Sat, 25 Oct 2025 12:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0oqDjVD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831B242D7F;
	Sat, 25 Oct 2025 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761396246; cv=none; b=DAzs811LytlswBFDrwB0KJIEvUPPE9xVmhGDzHQEnCvQBFb8BLcWDHpqrbK/7sYQEBRarSlB+ifiMx4wP6Ok/xB2OBE/sV4dQJwZAYHyftq0ZcmLNrQIZA8O+WtYg5DDHv3Ygu3vCfP8O7FiMGf7FNXh481Ze/aq7G8nFXuvDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761396246; c=relaxed/simple;
	bh=b5QpYMZmMe9U2UEWN9ko4/SOjOQwMOaP9+o4qUFvVF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUf0dBVvlvVTu6MVjZewEn3TukZmToq+Fve7yEJHoh6sXXa7Ao3/2dfAZ6RRa2QsoPYpYEpPNy0RhDRtwiz3OcvIVrsdedSy35zKuI9AtN8cwIOms6BWUAlQb2ne1yVx8wtJLh+opwxzehQXYdCbGqSrRqBbs1mz8SxVL4zUpFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0oqDjVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F2EC4CEF5;
	Sat, 25 Oct 2025 12:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761396245;
	bh=b5QpYMZmMe9U2UEWN9ko4/SOjOQwMOaP9+o4qUFvVF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m0oqDjVDFfQ9fTKk4ScPbIJezjt4zWQx7Y4LueSWL7XLlQtXTsKp5EEg5EY+SOdTU
	 Z9243Me9Stozh4c3HL6aMqpqqo9NyhSYLavRmj0E5ZkuE90XkXhLL8EiNDMjN+QaqI
	 NcuOaZqWGJvQ8D22AGN8cnqxIuR6LGo5vd7dPHFXYJHCGTAfXob/I1JPK2jxR92GFB
	 wN5++uQ/4SJjxX4zc/u/eXvzFnITz9y1M9XqnAaolvyC2fJSdiaYaYa/dYgT5jxEoB
	 TRtcdej4/bEnyIMQaMSe2d525pjYuaidWNAW8iH01QCp+tEUOr8KqMe+q8s4O8pNK7
	 JvHNt+DTi5RlA==
Date: Sat, 25 Oct 2025 13:44:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Longbin Li <looong.bin@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>, Ze Huang <huangze@whut.edu.cn>,
	devicetree@vger.kernel.org, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: sophgo: add TOP syscon for
 CV18XX/SG200X series SoC
Message-ID: <20251025-shakable-jujitsu-3a5e9c8895a5@spud>
References: <20251024030528.25511-1-looong.bin@gmail.com>
 <20251024030528.25511-2-looong.bin@gmail.com>
 <20251024-hangout-designing-33e96c0d35fc@spud>
 <oymxspgopaqja63nipufgzn6kpobkdopemfaw3azhom3ikvk5f@e7cg4lq64j2o>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BNmCECBWFm1Puo0R"
Content-Disposition: inline
In-Reply-To: <oymxspgopaqja63nipufgzn6kpobkdopemfaw3azhom3ikvk5f@e7cg4lq64j2o>


--BNmCECBWFm1Puo0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 10:27:13AM +0800, Longbin Li wrote:
> On Fri, Oct 24, 2025 at 05:46:03PM +0100, Conor Dooley wrote:
>=20
> > > ...
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - const: sophgo,cv1800b-top-syscon
> > > +          - const: syscon
> > > +          - const: simple-mfd
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  "#address-cells":
> > > +    const: 1
> > > +
> > > +  "#size-cells":
> > > +    const: 1
> > > +
> > > +  ranges: true
> >=20
> > Do you actually use ranges?
> >=20
> > > +patternProperties:
> > > +  "dma-router@[0-9a-f]+$":
> >=20
> > Do these actually appear at variable addresses, or is it always 48 for
> > the phy and 53 for the dma router?
> >=20
> > > +    $ref: /schemas/dma/sophgo,cv1800b-dmamux.yaml#
> > > +    unevaluatedProperties: false
> > > +
> > > +  "phy@[0-9a-f]+$":
> > > +    $ref: /schemas/phy/sophgo,cv1800b-usb2-phy.yaml#
> > > +    unevaluatedProperties: false
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - "#address-cells"
> > > +  - "#size-cells"
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/sophgo,cv1800.h>
> > > +
> > > +    syscon@3000000 {
> > > +      compatible =3D "sophgo,cv1800b-top-syscon", "syscon", "simple-=
mfd";
> > > +      reg =3D <0x03000000 0x1000>;
> > > +      #address-cells =3D <1>;
> > > +      #size-cells =3D <1>;
> > > +
> > > +      usbphy: phy@48 {
> >=20
> > Drop the labels off of these two, since they're unused in the example.
> >=20
>=20
> Hi,
>=20
> Thanks for the review.
>=20
> There are a couple of different opinions here.
> Could you please help confirm which approach is preferred here?
>=20
> This is Rob's reply:
> https://lore.kernel.org/all/20251015134144.GA3265377-robh@kernel.org/

I don't think that Rob and I disgree about the example, having child
nodes is good, having the label on them is what I don't want.

Re: the child node patterns, I was not looking for a return to what Rob
didn't like, but rather a move to just making them normal properties
rather than a pattern, if there's only one possible address.

--BNmCECBWFm1Puo0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPzGCgAKCRB4tDGHoIJi
0hKmAP9wppNOTqUcMNHIzevx1pK2MIBbfFM0ow0FlUnLwre+jAEA+1Y1ihrGIpfc
64g6hgbEVSbSRUo+VAr3/aMAaFlHdQo=
=AyBe
-----END PGP SIGNATURE-----

--BNmCECBWFm1Puo0R--

