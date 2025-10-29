Return-Path: <linux-kernel+bounces-876928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E8BC1CCB2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB0518874CA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D012B3563D8;
	Wed, 29 Oct 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDk+hmAV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3D286897;
	Wed, 29 Oct 2025 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762956; cv=none; b=WJMJkFAZDkxAH7vnynY8ckw5yi3nXF/NVdAQZ+rWx7AgO/ZXVVa7kRPKDw/yT/xmZRQIhsWFgKfN3/XoPtR7XnTgu3nU4EgJ7JbSqBYhVk6nGSZyo+r6NJ/B/rRCCmKIr5zDLH7YjllxikjEZt4s3K0js6yNyL8EfgdNwxEMXvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762956; c=relaxed/simple;
	bh=sdripFbkO+G3eCx55o/qnidBR9lUVgPjsMG6dmmgndM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zv/J3yzJA5Np9cz6J5XGlXZn+6Gb3t06zL0LK215dhxAc4cyiq5tFrfypRQJIuFSnqVn26Lq53a68D7vgiRGghsnZf0kwjh5jZx+DGM3E59UMhIDSZO1/VjRKZSNCK0okmPSNvTFGkKGbkDL7amV/DmTM7YyeLXIKwMkHp2eRgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDk+hmAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A13C4CEF7;
	Wed, 29 Oct 2025 18:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761762955;
	bh=sdripFbkO+G3eCx55o/qnidBR9lUVgPjsMG6dmmgndM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VDk+hmAVPgj8bzjbENtfSt4gMQi6YPiu1Npo9kRKRyFYNnRhDxKqFUUrgIst/yanY
	 mCTqLefFtL8Dh0SFiC1u5kDtRx1emWx1bW6OUIQIIVGuJkWk+vhc4pShoIzZCm1OPf
	 43wvYGzEC+ntnop0igedzSyUk9L6Psls+BdRhcfnnjddZ8z6cxluyIMOZqP47u/94z
	 NcDbyxefLk1JI85rDL0vCZcna5tE3oDcqUClL1yOuTc1nKUOzJk42ZiL0Nr45S0YR2
	 kOVCteh6kNEWuQuLKOQGbxsUB3aFQUrEKq86lMF24aola5gxnjTpUlTCC078odspwg
	 4pp30V9nwETOQ==
Date: Wed, 29 Oct 2025 18:35:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: phy: Add documentation for Airoha
 AN7581 USB PHY
Message-ID: <20251029-henna-easily-227513366e90@spud>
References: <20251029173713.7670-1-ansuelsmth@gmail.com>
 <20251029173713.7670-3-ansuelsmth@gmail.com>
 <20251029-mutual-scotch-7ca52e17da69@spud>
 <69025bc9.5d0a0220.1f0440.deb9@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oeEKek2lDmQPqfwa"
Content-Disposition: inline
In-Reply-To: <69025bc9.5d0a0220.1f0440.deb9@mx.google.com>


--oeEKek2lDmQPqfwa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 07:24:04PM +0100, Christian Marangi wrote:
> On Wed, Oct 29, 2025 at 06:07:22PM +0000, Conor Dooley wrote:
> > On Wed, Oct 29, 2025 at 06:37:10PM +0100, Christian Marangi wrote:
> > > Add documentation for Airoha AN7581 USB PHY that describe the USB PHY
> > > for the USB controller.
> > >=20
> > > Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mode is
> > > always supported. The USB 3.0 mode is optional and depends on the Ser=
des
> > > mode currently configured on the system for the relevant USB port.
> > >=20
> > > The first USB port on the SoC can be both used for USB 3.0 operation =
or
> > > Ethernet (HSGMII).
> > > The second USB port on the SoC can be both used for USB 3.0 operation=
 or
> > > for an additional PCIe line.
> > >=20
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >=20
> > > For DT maintainers, in v2 there were some comments, hope the new
> > > description and names of the property better clarify the usage and
> > > why they are needed.
> > >=20
> > >  .../bindings/phy/airoha,an7581-usb-phy.yaml   | 76 +++++++++++++++++=
++
> > >  MAINTAINERS                                   |  7 ++
> > >  .../dt-bindings/phy/airoha,an7581-usb-phy.h   | 11 +++
> > >  3 files changed, 94 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/phy/airoha,an75=
81-usb-phy.yaml
> > >  create mode 100644 include/dt-bindings/phy/airoha,an7581-usb-phy.h
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/phy/airoha,an7581-usb-=
phy.yaml b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> > > new file mode 100644
> > > index 000000000000..5106685c124d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> > > @@ -0,0 +1,76 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/phy/airoha,an7581-usb-phy.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Airoha AN7581 SoC USB PHY
> > > +
> > > +maintainers:
> > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > +
> > > +description: >
> > > +  The Airoha AN7581 SoC USB PHY describes the USB PHY for the USB co=
ntroller.
> > > +
> > > +  Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mod=
e is
> > > +  always supported. The USB 3.0 mode is optional and depends on the =
Serdes
> > > +  mode currently configured on the system for the relevant USB port.
> > > +
> > > +  The first USB port on the SoC can be both used for USB 3.0 operati=
on or
> > > +  Ethernet (HSGMII).
> > > +  The second USB port on the SoC can be both used for USB 3.0 operat=
ion or
> > > +  for an additional PCIe line.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: airoha,an7581-usb-phy
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  airoha,usb2-monitor-clk-sel:
> > > +    description: Describe what oscillator across the available 4
> > > +      should be selected for USB 2.0 Slew Rate calibration.
> >=20
> > Why's this being set in dt? What actually determines what oscillator
> > should be used? Do they have different performance characteristics?
> > How is someone meant to know which one to use?
> >
>=20
> Hi Conor,
>=20
> thanks a lot for the review.
>=20
> The airoha,usb2-monitor-clk-sel is set in DT because it describe the HW
> and to what oscillator the PHY should be connected to.
>=20
> There are 2 PHY at different register space. One PHY needs to calibrate
> for oscillator 1 and the other PHY for oscillator 2 or the PHY doesn't
> work for USB 2.0 (the calibration fails)

This implies that the oscillator is not part of the phy block, if
there's multiple competing for the same one. Why are these oscillators
not represented as clocks?

> The previous implementation used an index property but that was rejected
> as it wasn't descriptive of the HW.
>=20
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [0, 1, 2, 3]
> > > +
> > > +  airoha,usb3-serdes:
> > > +    description: Describe what Serdes line is attached to the USB 3.=
0 port.
> > > +      Can be either Serdes USB1 or Serdes USB2.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [2, 3]
> >=20
> > This is confusing. Why 2 and 3 for usb1 and usb2? What even is the
> > mapping? Is it 2:1/3:2 or 2:2/3:1?
> >=20
>=20
> AFAIK there isn't a way to directly reference dt-bindings.

Usually people put the name of the file in.

>=20
> 2 and 3 are from include/dt-bindings/soc/airoha,scu-ssr.h
>=20
> #define AIROHA_SCU_SERDES_USB1		2
> #define AIROHA_SCU_SERDES_USB2		3

Why overcomplicate like this? Just use 1 and 2. If that corresponds to
register settings of 2 and 3, do that conversion in the driver.
Properties are not shoving just register settings etc into, what happens,
for example, when the next soc comes along and these are actually usb1 is
3 and usb2 is 4 there? All of a sudden, your property has different
meanings depending on which device is being used.

> > > +
> > > +  airoha,scu:
> > > +    description: Phandle to the SCU syscon to configure the Serdes l=
ine.
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +
> > > +  '#phy-cells':
> > > +    description: Describe if the referred PHY is the USB 2.0 PHY or =
USB 3.0 PHY.
> > > +    const: 1
> >=20
> > Which is which here?
> >
>=20
> Mhh I think I didn't understand here. #phy-cells describe the
> parameters to be used for phys property in a different node.
>=20
> The current usage would be
>=20
> <&usb0_phy PHY_TYPE_USB2> for USB 2.0
> or <&usb0_phy PHY_TYPE_USB3> for USB 3.0
>=20
> This node expose 2 PHY that can be referenced by the single parameters.

Ah, I didn't know that the 1 cell variant here was type not index.

> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - airoha,usb2-monitor-clk-sel
> > > +  - airoha,usb3-serdes
> > > +  - airoha,scu
> > > +  - '#phy-cells'
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/phy/airoha,an7581-usb-phy.h>
> > > +    #include <dt-bindings/soc/airoha,scu-ssr.h>
> > > +
> > > +    phy@1fac0000 {
> > > +        compatible =3D "airoha,an7581-usb-phy";
> > > +        reg =3D <0x1fac0000 0x10000>;
> > > +
> > > +        airoha,usb2-monitor-clk-sel =3D <AIROHA_USB2_MONCLK_SEL1>;
> > > +        airoha,usb3-serdes =3D <AIROHA_SCU_SERDES_USB1>;
> > > +        airoha,scu =3D <&scu>;
> > > +
> > > +        #phy-cells =3D <1>;
> > > +    };
> > > +
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 8085fdca7bcd..af23c590bbc6 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -763,6 +763,13 @@ S:	Maintained
> > >  F:	Documentation/devicetree/bindings/spi/airoha,en7581-snand.yaml
> > >  F:	drivers/spi/spi-airoha-snfi.c
> > > =20
> > > +AIROHA USB PHY DRIVER
> > > +M:	Christian Marangi <ansuelsmth@gmail.com>
> > > +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
> > > +S:	Maintained
> > > +F:	Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.yaml
> > > +F:	include/dt-bindings/phy/airoha,an7581-usb-phy.h
> > > +
> > >  AIRSPY MEDIA DRIVER
> > >  L:	linux-media@vger.kernel.org
> > >  S:	Orphan
> > > diff --git a/include/dt-bindings/phy/airoha,an7581-usb-phy.h b/includ=
e/dt-bindings/phy/airoha,an7581-usb-phy.h
> > > new file mode 100644
> > > index 000000000000..efbb0ae75e3a
> > > --- /dev/null
> > > +++ b/include/dt-bindings/phy/airoha,an7581-usb-phy.h
> > > @@ -0,0 +1,11 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> > > +
> > > +#ifndef _DT_BINDINGS_AIROHA_AN7581_USB_PHY_H_
> > > +#define _DT_BINDINGS_AIROHA_AN7581_USB_PHY_H_
> > > +
> > > +#define AIROHA_USB2_MONCLK_SEL0                 0
> > > +#define AIROHA_USB2_MONCLK_SEL1                 1
> > > +#define AIROHA_USB2_MONCLK_SEL2                 2
> > > +#define AIROHA_USB2_MONCLK_SEL3                 3
> >=20
> > These definitions seem completely pointless. The property is called
> > "airoha,usb2-monitor-clk-sel" so any use will look like
> > "airoha,usb2-monitor-clk-sel =3D <3>;"
> > That's more informative than the define is, since it doesn't even
> > truncate "monitor". I'd just delete this header entirely and use the
> > number. If you want the define in the driver to avoid magic numbers,
> > just define it in the driver.
> >=20
>=20
> Well yes the idea here is to not have to use magic numbers in DT and try
> to use the naming in the SoC documentation since they are called
> monclk_sel0, monclk_sel1 ...

Sometimes the "magic" number just makes sense to use. If something is
completely arbitrary, then sure use one to make it readable. If
literally the number itself, as it is here, don't bother.

--oeEKek2lDmQPqfwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQJehwAKCRB4tDGHoIJi
0uzdAP9bfvOWqmOLSu+ZjI8e5AECiH2Cisx+6CuyofLZGqxz1wEAgiA/AWgNS939
sMMOUiE+Hfbd0r0M7wiKPPrrVeMQfwY=
=R2uO
-----END PGP SIGNATURE-----

--oeEKek2lDmQPqfwa--

