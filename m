Return-Path: <linux-kernel+bounces-890880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A302C41453
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FAA61887BB6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351F433971F;
	Fri,  7 Nov 2025 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHcqFUXu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699372F83BC;
	Fri,  7 Nov 2025 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539657; cv=none; b=EaxOaQU+DuofxQtBq268ce5ECsGHIKtyLaqg1zNJ7oFB7qc1VFvZCTPjCnyGSxGJjAUo/QUIpvFUPp5YEY5LvrYJbdodfn645XapLCepoSHyjXe/c7NqoOksiE6K14K80ngTvVtxK9QooYQc8V0lmWGtglU/DLRGipkOhiwFAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539657; c=relaxed/simple;
	bh=XZ3GzvFfGFXlIB7TajdyAZQIUS5SDDqxmBn+AzTLv+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFX/D8Vq5/6aCtcJcCupEJCqZBRKcLTt1Dw5PZFQTbhkefeA4K/fV27f/lwKXc6C7ghUJ134FczNZTpLMaHCjFHP99bejUW3GOBfUxWadoI5p2fP6LVnlW2KXOklpw9nh+xtHXW5UR5S0T7jtsMRE1otLlSYbGiggIYtGtW3xZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHcqFUXu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A72C4CEF5;
	Fri,  7 Nov 2025 18:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762539657;
	bh=XZ3GzvFfGFXlIB7TajdyAZQIUS5SDDqxmBn+AzTLv+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AHcqFUXuzDR1EODPDxnZYlWVZSgOuuZQOxwdT/dxNUBqYTijNmpj3l07OV6gQA0Z6
	 HkkjWId81zy5CeibiE/k1bZjL0LRBOhbUzNZ2gYk6I27drxEuWTf9PB1lOPMVh9HSV
	 u6pCM7/XBm0P/aFrWwu3mD7ypKEjBRpg50ABGlnyWDLTQ6TYz+wuPPf6f9V79Eh6LF
	 5bIy88gatlkmKLWRcfMCl1q+ryb/zU5Ud1bw7LFE8gL4Ym5sSpsJNXI79GpQ3KC1rM
	 6G0KC924cDPQK3mzmjox2L1rnq25HbX/kjUzxxXfv2n1jQpUXPSEC4Kh5x2xpWfKFo
	 3tic9dkDo2BIg==
Date: Fri, 7 Nov 2025 18:20:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Michal Simek <michal.simek@amd.com>,
	Wensheng Wang <wenswang@yeah.net>,
	Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Grant Peltier <grantpeltier93@gmail.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: mfd: Convert dlg,da9052-i2c.txt to yaml
 format
Message-ID: <20251107-matrimony-showdown-ba6ce6996b2f@spud>
References: <20251106013358.421809-1-Frank.Li@nxp.com>
 <20251106-hull-petri-42878717ee85@spud>
 <aQz1Yt9lk+roRq9z@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q9vuaJ9qjpbg+ZRK"
Content-Disposition: inline
In-Reply-To: <aQz1Yt9lk+roRq9z@lizhi-Precision-Tower-5810>


--Q9vuaJ9qjpbg+ZRK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 02:22:10PM -0500, Frank Li wrote:
> On Thu, Nov 06, 2025 at 05:39:47PM +0000, Conor Dooley wrote:
> > On Wed, Nov 05, 2025 at 08:33:56PM -0500, Frank Li wrote:
> > > Convert dlg,da9052-i2c.txt to yaml format.
> > > Additional changes:
> > > - compatible string fallback to dlg,da9052 to align existing dts file=
s.
> > > - Add interrupts property.
> > > - Add ref to /schemas/spi/spi-peripheral-props.yaml#
> > >
> > > Remove dlg,da9053 from trivial-devices.yaml.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  .../devicetree/bindings/mfd/da9052-i2c.txt    | 67 -------------
> > >  .../devicetree/bindings/mfd/dlg,da9052.yaml   | 93 +++++++++++++++++=
++
> > >  .../devicetree/bindings/trivial-devices.yaml  |  2 -
> > >  3 files changed, 93 insertions(+), 69 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/mfd/da9052-i2c.=
txt
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/dlg,da9052.=
yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt b/D=
ocumentation/devicetree/bindings/mfd/da9052-i2c.txt
> > > deleted file mode 100644
> > > index 07c69c0c6624c..0000000000000
> > > --- a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
> > > +++ /dev/null
> > > @@ -1,67 +0,0 @@
> > > -* Dialog DA9052/53 Power Management Integrated Circuit (PMIC)
> > > -
> > > -Required properties:
> > > -- compatible : Should be "dlg,da9052", "dlg,da9053-aa",
> > > -			 "dlg,da9053-ab", or "dlg,da9053-bb"
> > > -
> > > -Optional properties:
> > > -- dlg,tsi-as-adc : Boolean, if set the X+, X-, Y+, Y- touchscreen
> > > -                    input lines are used as general purpose analogue
> > > -					input.
> > > -- tsiref-supply: Phandle to the regulator, which provides the refere=
nce
> > > -                 voltage for the TSIREF pin. Must be provided when t=
he
> > > -			     touchscreen pins are used for ADC purposes.
> > > -
> > > -Sub-nodes:
> > > -- regulators : Contain the regulator nodes. The DA9052/53 regulators=
 are
> > > -  bound using their names as listed below:
> > > -
> > > -    buck1     : regulator BUCK CORE
> > > -    buck2     : regulator BUCK PRO
> > > -    buck3     : regulator BUCK MEM
> > > -    buck4     : regulator BUCK PERI
> > > -    ldo1      : regulator LDO1
> > > -    ldo2      : regulator LDO2
> > > -    ldo3      : regulator LDO3
> > > -    ldo4      : regulator LDO4
> > > -    ldo5      : regulator LDO5
> > > -    ldo6      : regulator LDO6
> > > -    ldo7      : regulator LDO7
> > > -    ldo8      : regulator LDO8
> > > -    ldo9      : regulator LDO9
> > > -    ldo10     : regulator LDO10
> > > -
> > > -  The bindings details of individual regulator device can be found i=
n:
> > > -  Documentation/devicetree/bindings/regulator/regulator.txt
> > > -
> > > -Examples:
> > > -
> > > -i2c@63fc8000 { /* I2C1 */
> > > -
> > > -	pmic: dialog@48 {
> > > -		compatible =3D "dlg,da9053-aa";
> > > -		reg =3D <0x48>;
> > > -
> > > -		regulators {
> > > -			buck1 {
> > > -				regulator-min-microvolt =3D <500000>;
> > > -				regulator-max-microvolt =3D <2075000>;
> > > -			};
> > > -
> > > -			buck2 {
> > > -				regulator-min-microvolt =3D <500000>;
> > > -				regulator-max-microvolt =3D <2075000>;
> > > -			};
> > > -
> > > -			buck3 {
> > > -				regulator-min-microvolt =3D <925000>;
> > > -				regulator-max-microvolt =3D <2500000>;
> > > -			};
> > > -
> > > -			buck4 {
> > > -				regulator-min-microvolt =3D <925000>;
> > > -				regulator-max-microvolt =3D <2500000>;
> > > -			};
> > > -		};
> > > -	};
> > > -};
> > > diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9052.yaml b/=
Documentation/devicetree/bindings/mfd/dlg,da9052.yaml
> > > new file mode 100644
> > > index 0000000000000..4ecd498864e4e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/dlg,da9052.yaml
> > > @@ -0,0 +1,93 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/dlg,da9052.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Dialog DA9052/53 Power Management Integrated Circuit (PMIC)
> > > +
> > > +maintainers:
> > > +  - Frank Li <Frank.Li@nxp.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - dlg,da9053
> >
> > Should this actually exist? It was never in any drivers etc at all, and
> > as far as I can tell any users use the -XX suffixed ones. Probably this
> > is the only compatible that /should/ have been used, but it might be
> > pointless to add now.
>=20
> A old dts arch/arm/boot/dts/nxp/imx/imx53-smd.dts use "dlg,da9053", "dlg,=
da9052"

Given my observations about the fallback below, I think this one should
be changed in the dts to whatever dlg,da9053-XX variant it actually is.

> > > +              - dlg,da9053-aa
> > > +              - dlg,da9053-ab
> > > +              - dlg,da9053-bb
> >
> > The driver also has a bc, I think that should be added.
> >
> > > +          - const: dlg,da9052
> >
> > Is this actually a correct fallback?
> > I know it is being used, but looking at the drivers I see things like:
> > 	/* Select the appropriate current limit range */
> > 	if (regulator->da9052->chip_id =3D=3D DA9052)
> > 		row =3D 0;
> > 	else if (offset =3D=3D 0)
> > 		row =3D 1;
> > in both the battery and regulator drivers.
> > Might actually be the devicetrees are wrong here?
>=20
> Ideally, not fallback to dlg,da9052, but need update old dts file to clean
> up warning.
>=20
> If you prefer this way, I can remove fallback and update dts files.

Yeah, I think so. If the things need different current limits I don't
think that the fallback is really suitable.

> > > +      - enum:
> > > +          - dlg,da9052
> > > +          - dlg,da9053-aa # Just for match existed old platform
> >
> > Could you just change that one old platform using it?
>=20
> Yes

And since we are removing the da9052 fallback, this comment can be
removed and the old platform can stay as it is.

--Q9vuaJ9qjpbg+ZRK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQ44gwAKCRB4tDGHoIJi
0ubIAP4l3CNYFcE166XUJIAGc9GKUzWC2GSixh4YFSNUt35QdgD7Bl4tH71Ban+S
HuNOGWoZdjtoYu5iqu50nGvoTH9P9gA=
=lM++
-----END PGP SIGNATURE-----

--Q9vuaJ9qjpbg+ZRK--

