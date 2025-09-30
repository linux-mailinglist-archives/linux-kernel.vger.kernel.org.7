Return-Path: <linux-kernel+bounces-838078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B013BAE61F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A76194531C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE86327F00A;
	Tue, 30 Sep 2025 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLuiSbIW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022AE27A928;
	Tue, 30 Sep 2025 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258703; cv=none; b=W6cWAXETRndIL6XEr5Iv1qAqFVga7s8KDypERX8ESZUUzpMqKSpoz+x2UAnYOIAF7s403IBdtnarevUj/7qhSAl0FSkAQcT/1pi1+s9UYe8W5mU2FAFO9mvwTJmanRxokcJea4C9XubL2eDxm6SeblWX9lgTmEjkJOCynxx3gmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258703; c=relaxed/simple;
	bh=ftQwGWLKK1s5Gh7SLQ8fWSKuz7Q2521DX+kCSsNK2TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbHDfg1uGfjZmFmD0p88HvcV4bgvjWint8HXcSkArAgXrG9E2HXiYNP7gLm4GJHABtktLmK74T9/mFZIYJuKc2k5b0Zn9BA1taVCVCluf0LXhYcSINVtuBrCqFMg3q9kdZFCH6hqqi41mRj5auCTDyGL1ufTwat0JI+kHy7HjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLuiSbIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5835C4CEF0;
	Tue, 30 Sep 2025 18:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759258702;
	bh=ftQwGWLKK1s5Gh7SLQ8fWSKuz7Q2521DX+kCSsNK2TE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLuiSbIWeUPuyaB2cIR6Hva0pJrqWgWKi2/sn6DMebDOKbo2K/1thjS5iF2U0h2JN
	 Cez0uXzPvBOcDq6giu0Tg0y+q3Mkr7SQlXJjhBIpgfanco4oaWjrvDZujkaB0AKPGE
	 GmMIFW2sVuDr+jQgYh1wlbefJovOhuJnogvui0fctqU8cFlJ9hPXw5xkMI2HzB1296
	 uzTnDYxxhxcNWhe7Idupcodh0a6myEzn3JGZNBLIecr8wSYtPSLX6cyvE7Ei/CxTOW
	 i/MbbNCYqEs6SpR9DTysteH7ULMELtZgXR2Y+4QzcgQXSha+DIzEKcq4xKGqA6gegg
	 KG94pAdBE4uag==
Date: Tue, 30 Sep 2025 19:58:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Phil Elwell <phil@raspberrypi.com>
Cc: Stanimir Varbanov <svarbanov@suse.de>,
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	Rob Herring <robh@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>,
	Saenz Julienne <nsaenz@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 1/4] dt-bindings: Add Raspberry Pi's RP1 ADC
Message-ID: <20250930-overlord-scion-d60cff2ef1f5@spud>
References: <20250925000416.2408457-1-svarbanov@suse.de>
 <20250925000416.2408457-2-svarbanov@suse.de>
 <20250925-outlying-causal-015d8ba33c53@spud>
 <89dd04b9-e261-4bdd-83ab-499e46fc9c01@roeck-us.net>
 <88bd67f2-de8c-407b-ba98-08663eee2d7e@suse.de>
 <CAMEGJJ0KqPX462iigbMP+fwoyZgZ1J1PqaWt82MrNTW1VMwbpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ME1twZYxASzgwyN"
Content-Disposition: inline
In-Reply-To: <CAMEGJJ0KqPX462iigbMP+fwoyZgZ1J1PqaWt82MrNTW1VMwbpQ@mail.gmail.com>


--7ME1twZYxASzgwyN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 11:47:58AM +0100, Phil Elwell wrote:
> Hi Stanimir, Guenter,
>=20
> On Tue, 30 Sept 2025 at 11:21, Stanimir Varbanov <svarbanov@suse.de> wrot=
e:
> >
> > Hi,
> >
> > On 9/25/25 11:37 PM, Guenter Roeck wrote:
> > > On Thu, Sep 25, 2025 at 08:40:54PM +0100, Conor Dooley wrote:
> > >> On Thu, Sep 25, 2025 at 03:04:13AM +0300, Stanimir Varbanov wrote:
> > >>> Document dt-bindings for Raspberry Pi's RP1 ADC.
> > >>>
> > >>> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> > >>> ---
> > >>>  .../bindings/hwmon/raspberrypi,rp1-adc.yaml   | 46 +++++++++++++++=
++++
> > >>>  1 file changed, 46 insertions(+)
> > >>>  create mode 100644 Documentation/devicetree/bindings/hwmon/raspber=
rypi,rp1-adc.yaml
> > >>>
> > >>> diff --git a/Documentation/devicetree/bindings/hwmon/raspberrypi,rp=
1-adc.yaml b/Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-adc.ya=
ml
> > >>> new file mode 100644
> > >>> index 000000000000..5266b253fd2b
> > >>> --- /dev/null
> > >>> +++ b/Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-adc.y=
aml
> > >>> @@ -0,0 +1,46 @@
> > >>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > >>> +%YAML 1.2
> > >>> +---
> > >>> +$id: http://devicetree.org/schemas/hwmon/raspberrypi,rp1-adc.yaml#
> > >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > >>> +
> > >>> +title: Rasberry Pi RP1 ADC device
> > >>> +
> > >>> +maintainers:
> > >>> +  - Stanimir Varbanov <svarbanov@suse.de>
> > >>> +
> > >>> +description: |
> > >>> +  The RP1 ADC is a five input successive-approximation ADC with 12=
-bit
> > >>> +  resolution (ENOB 9.5-bit) at 500kSPS. It has four external inputs
> > >>> +  and one internal temperature sensor.
> > >>> +
> > >>> +properties:
> > >>> +  compatible:
> > >>> +    const: raspberrypi,rp1-adc
> > >>> +
> > >>> +  reg:
> > >>> +    maxItems: 1
> > >>> +
> > >>> +  clocks:
> > >>> +    maxItems: 1
> > >>> +
> > >>> +  vref-supply:
> > >>> +    description:
> > >>> +      Reference voltage regulator 3.3V.
> > >>
> > >> Looks like you're missing the io-channels-cells property that allows
> > >> this device to be a provider of adc channels to other devices.
> > >>
> > > Only makes sense if the driver is implemented as iio driver.
> > > Which would be fine with me, assuming this is a generic ADC.
> > > The iio -> hwmon bridge can then be used to instantiate a
> > > hwmon device if needed.
> > >
> >
> > According to the RP1 peripheral document the information about ADC is
> > limited and I cannot be 100% sure that this is generic ADC, but it looks
> > like it is. On RPi5 board the ADC inputs are not configurable, but that
> > could change on another board.
> >
> > I personally don't have objections to implement it as IIO driver.
> >
> > Phil, are you fine with implementing the driver as IIO?
>=20
> The problem with adding unused functionality, apart from the effort
> involved, is that testing it is harder. Will the IIO driver be
> inherently better/simpler because some of the hwmon support gets
> picked up by the generic IIO/HWMON bridge?
>=20
> Ultimately we'll make whatever changes are considered necessary in
> order to get this simple driver accepted, but it would be nice to feel
> there was some real world benefit now for the work, not on Pi 6/7/etc.

tbh, I don't care how the driver side of things is done, I would just
like for the binding documentation to be complete. If there's no usecase
at all where the device provides io channels, then omit the property.

--7ME1twZYxASzgwyN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNwoSAAKCRB4tDGHoIJi
0sgKAPwPyHVOPL3+vGEY13Q+XNBtSaCSUTqKSTF8wzaH2E54/gD9HS1r/CHIxVmU
pM/olI54HwZAmhzTQDkVGvN9sY8T8wI=
=fHEy
-----END PGP SIGNATURE-----

--7ME1twZYxASzgwyN--

