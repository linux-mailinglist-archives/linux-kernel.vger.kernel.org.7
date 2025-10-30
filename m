Return-Path: <linux-kernel+bounces-878940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C80B5C21D12
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534F91A66F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DE236CDFC;
	Thu, 30 Oct 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIV0RnhV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA9436CA8A;
	Thu, 30 Oct 2025 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761849868; cv=none; b=F3HrvEDb0zPdCv4+jp5xnP3Dps8LflSJNkjOiXkT8Vi52bCHTVU+Ak3TOU8+R2QFfpFJyiC4QPXU2i6JTLJC9dbl9ZYVqj3Xdch57lL0oro5y9IT0kujNHogt0Hy7jfZMM6umWHnxGk4rGoJIyEQmd0xyMV16X5HPQiZu2E3A1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761849868; c=relaxed/simple;
	bh=vsxQjGOMRY3e0Nsl6cvv000bCykVEx5m7nSv2iyskVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4EiXKtvnZkyyItSyf1sQ2nORnNGOetASX+QDPaFefjirXGdFQT2GBUoGpm+2Kd8D3gVuWfNRK5+OTAgqDJBqTXWPESFNX6tpxp22s3pIUM7ptf5AxbF4GULDA3lFJUKYbUad6Q6HjBFywLAPNnFbDK7OjOOlo8NExKQPWfa+yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIV0RnhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04015C4CEFB;
	Thu, 30 Oct 2025 18:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761849868;
	bh=vsxQjGOMRY3e0Nsl6cvv000bCykVEx5m7nSv2iyskVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIV0RnhVcltY/Bi0BH4Sr4pschfRBF+kH+skm2FbOSfSOGW7yT5ZHMo+pQwte7gMm
	 +pw0GKcajp/mXqv/789hvzUVQhYP6ikG2A2Jm87y+TWigKXl8ovCqwPMgCv6qwnzCC
	 rVzXt53NXicYIb01rohTpG5VIR8q6B3lT/527CHCiyLZofCCf1XAGcWFjfrhX281hu
	 YW07HDiMmJTc29XXyea1xf5sM0MqBVFdlCkYWsWEyhBgXob6fi3fiHXiPEmGWJ+iKz
	 GkMDA0paCt3lvhTCdEP+A3oPCitOrckomF/qYYeqTvFIeIgKE+dpeBrwlAi5RQWuLn
	 6WzGp6WGLTxOw==
Date: Thu, 30 Oct 2025 18:44:23 +0000
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
Message-ID: <20251030-unbridle-ribbon-5c8543b83b71@spud>
References: <20251029173713.7670-1-ansuelsmth@gmail.com>
 <20251029173713.7670-3-ansuelsmth@gmail.com>
 <20251029-mutual-scotch-7ca52e17da69@spud>
 <69025bc9.5d0a0220.1f0440.deb9@mx.google.com>
 <20251029-henna-easily-227513366e90@spud>
 <690266d4.050a0220.3a144c.eef7@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WOwBK0nI2n924yG0"
Content-Disposition: inline
In-Reply-To: <690266d4.050a0220.3a144c.eef7@mx.google.com>


--WOwBK0nI2n924yG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 08:11:10PM +0100, Christian Marangi wrote:
> On Wed, Oct 29, 2025 at 06:35:51PM +0000, Conor Dooley wrote:
> > On Wed, Oct 29, 2025 at 07:24:04PM +0100, Christian Marangi wrote:
> > > On Wed, Oct 29, 2025 at 06:07:22PM +0000, Conor Dooley wrote:
> > > > On Wed, Oct 29, 2025 at 06:37:10PM +0100, Christian Marangi wrote:
> > > > > Add documentation for Airoha AN7581 USB PHY that describe the USB=
 PHY
> > > > > for the USB controller.
> > > > >=20
> > > > > Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0 mo=
de is
> > > > > always supported. The USB 3.0 mode is optional and depends on the=
 Serdes
> > > > > mode currently configured on the system for the relevant USB port.
> > > > >=20
> > > > > The first USB port on the SoC can be both used for USB 3.0 operat=
ion or
> > > > > Ethernet (HSGMII).
> > > > > The second USB port on the SoC can be both used for USB 3.0 opera=
tion or
> > > > > for an additional PCIe line.
> > > > >=20
> > > > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > > > ---
> > > > >=20
> > > > > For DT maintainers, in v2 there were some comments, hope the new
> > > > > description and names of the property better clarify the usage and
> > > > > why they are needed.
> > > > >=20
> > > > >  .../bindings/phy/airoha,an7581-usb-phy.yaml   | 76 +++++++++++++=
++++++
> > > > >  MAINTAINERS                                   |  7 ++
> > > > >  .../dt-bindings/phy/airoha,an7581-usb-phy.h   | 11 +++
> > > > >  3 files changed, 94 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/phy/airoha,=
an7581-usb-phy.yaml
> > > > >  create mode 100644 include/dt-bindings/phy/airoha,an7581-usb-phy=
=2Eh
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/phy/airoha,an7581-=
usb-phy.yaml b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy.=
yaml
> > > > > new file mode 100644
> > > > > index 000000000000..5106685c124d
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/phy/airoha,an7581-usb-phy=
=2Eyaml
> > > > > @@ -0,0 +1,76 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/phy/airoha,an7581-usb-phy.yam=
l#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Airoha AN7581 SoC USB PHY
> > > > > +
> > > > > +maintainers:
> > > > > +  - Christian Marangi <ansuelsmth@gmail.com>
> > > > > +
> > > > > +description: >
> > > > > +  The Airoha AN7581 SoC USB PHY describes the USB PHY for the US=
B controller.
> > > > > +
> > > > > +  Airoha AN7581 SoC support a maximum of 2 USB port. The USB 2.0=
 mode is
> > > > > +  always supported. The USB 3.0 mode is optional and depends on =
the Serdes
> > > > > +  mode currently configured on the system for the relevant USB p=
ort.
> > > > > +
> > > > > +  The first USB port on the SoC can be both used for USB 3.0 ope=
ration or
> > > > > +  Ethernet (HSGMII).
> > > > > +  The second USB port on the SoC can be both used for USB 3.0 op=
eration or
> > > > > +  for an additional PCIe line.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: airoha,an7581-usb-phy
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  airoha,usb2-monitor-clk-sel:
> > > > > +    description: Describe what oscillator across the available 4
> > > > > +      should be selected for USB 2.0 Slew Rate calibration.
> > > >=20
> > > > Why's this being set in dt? What actually determines what oscillator
> > > > should be used? Do they have different performance characteristics?
> > > > How is someone meant to know which one to use?
> > > >
> > >=20
> > > Hi Conor,
> > >=20
> > > thanks a lot for the review.
> > >=20
> > > The airoha,usb2-monitor-clk-sel is set in DT because it describe the =
HW
> > > and to what oscillator the PHY should be connected to.
> > >=20
> > > There are 2 PHY at different register space. One PHY needs to calibra=
te
> > > for oscillator 1 and the other PHY for oscillator 2 or the PHY doesn't
> > > work for USB 2.0 (the calibration fails)
> >=20
> > This implies that the oscillator is not part of the phy block, if
> > there's multiple competing for the same one. Why are these oscillators
> > not represented as clocks?
> >
>=20
> This was also pointed out in the old revision. The oscillator is
> internal and there isn't a register to read the frequency or to
> enable/disable.

If it has come up twice, that's a sure sign that you're not explaining
how this property works correctly. Since it's more about suitability and
less on usage, put it in the commit message.

> The PHY register block have the same exact bits to select from 0 to 3.
> The HW internally is then connected to 1 or 2 basted on the physical PHY.
>=20
> So yes they are part of the PHY block, just the register map is too
> ""liberal"" on the configuration.
>=20
> I verified if the same oscillator could be used for both but it does end
> up in the port not working as the calibration fails.
>=20
> > > The previous implementation used an index property but that was rejec=
ted
> > > as it wasn't descriptive of the HW.
> > >=20
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +    enum: [0, 1, 2, 3]
> > > > > +
> > > > > +  airoha,usb3-serdes:
> > > > > +    description: Describe what Serdes line is attached to the US=
B 3.0 port.
> > > > > +      Can be either Serdes USB1 or Serdes USB2.
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +    enum: [2, 3]
> > > >=20
> > > > This is confusing. Why 2 and 3 for usb1 and usb2? What even is the
> > > > mapping? Is it 2:1/3:2 or 2:2/3:1?
> > > >=20
> > >=20
> > > AFAIK there isn't a way to directly reference dt-bindings.
> >=20
> > Usually people put the name of the file in.
> >=20
>=20
> Yes on this I have seen mixed implementation with only the enum and some
> adding the link to it. I will add in the description.
>=20
> > >=20
> > > 2 and 3 are from include/dt-bindings/soc/airoha,scu-ssr.h
> > >=20
> > > #define AIROHA_SCU_SERDES_USB1		2
> > > #define AIROHA_SCU_SERDES_USB2		3
> >=20
> > Why overcomplicate like this? Just use 1 and 2. If that corresponds to
> > register settings of 2 and 3, do that conversion in the driver.
> > Properties are not shoving just register settings etc into, what happen=
s,
> > for example, when the next soc comes along and these are actually usb1 =
is
> > 3 and usb2 is 4 there? All of a sudden, your property has different
> > meanings depending on which device is being used.
> >=20
>=20
> This is really just to identify the serdes line that can have multiple
> usage, they don't refer to a specific register.
>=20
> The PCIe one are added as they can also be used for PCIe or Ethernet
> usage and in the future this feature will be implemented in the PCIe PHY.
>=20
> It's ok to change it 1 but then I hope we won't fall in the monclk case
> where we end up with

What is the "monclk" case?

> airoha,usb3-serdes =3D <1>;
>=20
> as that will be VERY confusing in DT.

Why would this be confusing for whatever "monclk" is?

I think the best argument for keeping it behaving how it does, is that
you've got pcie1 and pcie2 as potential options too.

Honestly, this whole patch comes across as doing weird or not needed
stuff, until the explanations arrive for why you're doing it this way a
few mails later. Just put the explanations for anything non-obvious like
this into either the property description (if usage is what's weird or
non-obvious) or into the commit message (if it's about suitability) and
we'll save a bunch of time in the future ;)


--WOwBK0nI2n924yG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQOyBwAKCRB4tDGHoIJi
0qoMAP9HpNWRs4Zq/vy3LETJGVucs+bfUBEThm/bBicAa7AR7gEA2OQoxk2WpciF
th8ZR3rnPWgmeYV7weaG5EKngI52OQk=
=EfK2
-----END PGP SIGNATURE-----

--WOwBK0nI2n924yG0--

