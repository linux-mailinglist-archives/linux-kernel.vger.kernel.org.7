Return-Path: <linux-kernel+bounces-869242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3CFC0762B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A8D23453D8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48A513B797;
	Fri, 24 Oct 2025 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWycwC4E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C68A27FD52;
	Fri, 24 Oct 2025 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324474; cv=none; b=ksGKd2FsIef/QEPxqAmf0DwbBV6BCeCZC1tp9OmJr+JgKHw9y1UdU5AeW/gpHAInUrJvLm9ywmunw3V33xmLm+zdjpGC/T+wcABjFXoCAZVRoi5kWhAa50L1yoEn+go2Ak0oc4YNHxJPJQ2o7rhrnImeJqvQelCEc8Dfi3db9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324474; c=relaxed/simple;
	bh=2J2a852hu4Ko8dTkG+XS6Wfc56X851XsTvUBBXYgN7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0X/vrXFr2ereGqhn5XFM9PM/0pibyimVs0LITDikPy4wMrnoptG4sOHtqJZLkCL6PxeimhVY8HsECuqBTYsMZYGm1GqOmGLCnaxWjb2MD2Pmmrwjpm9ymu+yoorN+E8XJCqCFVyshTpS58Cc1CIl6gsCHPgmR/vHWqSRx7Dh0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWycwC4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6063AC4CEF1;
	Fri, 24 Oct 2025 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761324473;
	bh=2J2a852hu4Ko8dTkG+XS6Wfc56X851XsTvUBBXYgN7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eWycwC4EqIWFTE4zd9Wg/dQr53+HnDPp91iV+iCNqD+M+ZSe4hj/Vjx2Sy7Qnqjm6
	 0xZyD0YZ/bpvqaHZlKRmvMdXIzvt2gnGWfuZmxojGeFeUZ0nsbcjLOLXinzDwaVlV5
	 LpGJ5Eb/J1Bd5l9O6ltZgabZllZqjEogcnf4CiPR34XxDiB8dPaOjOGphouhZDKPoX
	 9QF+h80JrtBfL12HAuOMS2RNds5PmKlOzSGqLbwThVOI0HeddO4mEmqlV4zNgVJlp5
	 e/XrdRg06U9A4YQbTVxTVWE2itMKVIDc6LUbN/I6UEKCh9veLNEmwpjS8hvUxQvkQ4
	 X74gsbROMZR0A==
Date: Fri, 24 Oct 2025 17:47:48 +0100
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
Message-ID: <20251024-universe-undertake-8ff51d27d2cb@spud>
References: <20251024030528.25511-1-looong.bin@gmail.com>
 <20251024030528.25511-2-looong.bin@gmail.com>
 <20251024-hangout-designing-33e96c0d35fc@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Jmi8IxbuvN49Htrp"
Content-Disposition: inline
In-Reply-To: <20251024-hangout-designing-33e96c0d35fc@spud>


--Jmi8IxbuvN49Htrp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 05:46:03PM +0100, Conor Dooley wrote:
> On Fri, Oct 24, 2025 at 11:05:14AM +0800, Longbin Li wrote:
> > The Sophgo CV1800/SG2000 SoC top misc system controller provides regist=
er
>=20
> Please remind me how it works, sg2000 is just a rebadge and really this
> just refers to one device?
>=20
> > access to configure related modules. It includes a usb2 phy and a dma
> > multiplexer.
> >=20
> > Co-developed-by: Inochi Amaoto <inochiama@gmail.com>
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > Signed-off-by: Longbin Li <looong.bin@gmail.com>
> > ---
> >  .../soc/sophgo/sophgo,cv1800b-top-syscon.yaml | 81 +++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo=
,cv1800b-top-syscon.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800=
b-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1=
800b-top-syscon.yaml
> > new file mode 100644
> > index 000000000000..d044ca661fa2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800b-top-s=
yscon.yaml
> > @@ -0,0 +1,81 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800b-top-sysco=
n.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo CV18XX/SG200X SoC top system controller
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@outlook.com>
> > +
> > +description:
> > +  The Sophgo CV18XX/SG200X SoC top misc system controller provides
> > +  register access to configure related modules.
>=20
> Here and in the title you have Xs, are those placeholder or is this
> going into cv180x.dtsi and going to be used on multiple devices?

nvm, I read the next patch. It's going into cv180x.dtsi.

> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - const: sophgo,cv1800b-top-syscon
> > +          - const: syscon
> > +          - const: simple-mfd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +  ranges: true
>=20
> Do you actually use ranges?
>=20
> > +patternProperties:
> > +  "dma-router@[0-9a-f]+$":
>=20
> Do these actually appear at variable addresses, or is it always 48 for
> the phy and 53 for the dma router?
>=20
> > +    $ref: /schemas/dma/sophgo,cv1800b-dmamux.yaml#
> > +    unevaluatedProperties: false
> > +
> > +  "phy@[0-9a-f]+$":
> > +    $ref: /schemas/phy/sophgo,cv1800b-usb2-phy.yaml#
> > +    unevaluatedProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/sophgo,cv1800.h>
> > +
> > +    syscon@3000000 {
> > +      compatible =3D "sophgo,cv1800b-top-syscon", "syscon", "simple-mf=
d";
> > +      reg =3D <0x03000000 0x1000>;
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <1>;
> > +
> > +      usbphy: phy@48 {
>=20
> Drop the labels off of these two, since they're unused in the example.
>=20
> > +        compatible =3D "sophgo,cv1800b-usb2-phy";
> > +        reg =3D <0x48 0x4>;
> > +        #phy-cells =3D <0>;
> > +        clocks =3D <&clk CLK_USB_125M>,
> > +                 <&clk CLK_USB_33K>,
> > +                 <&clk CLK_USB_12M>;
> > +        clock-names =3D "app", "stb", "lpm";
> > +        resets =3D <&rst 58>;
> > +      };
> > +
> > +      dmamux: dma-router@154 {
> > +        compatible =3D "sophgo,cv1800b-dmamux";
> > +        reg =3D <0x154 0x8>, <0x298 0x4>;
> > +        #dma-cells =3D <2>;
> > +        dma-masters =3D <&dmac>;
> > +      };
> > +    };
> > +
> > +...
> > --
> > 2.51.0



--Jmi8IxbuvN49Htrp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPutswAKCRB4tDGHoIJi
0lGwAP47xVvM618ptskQQ8AFSpS1Gnoy0H4wGzkhpMsfmwbe9AEA9WivaOXdnATU
TX4YAn8naPW6b0nriANROCXT+i0kcQA=
=ffVH
-----END PGP SIGNATURE-----

--Jmi8IxbuvN49Htrp--

