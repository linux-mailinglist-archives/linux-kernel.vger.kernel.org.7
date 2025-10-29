Return-Path: <linux-kernel+bounces-876920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84568C1CC52
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9E2B4E1487
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41EA3559E2;
	Wed, 29 Oct 2025 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pd0Pbayb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FDB2D0C7B;
	Wed, 29 Oct 2025 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762344; cv=none; b=MwljLbuYrtrM5xyYqBjPDnMDyiHUv5v1hcXdvNEsIGq6LFu2PMgVPTUTZYFcr+Mv+uExOXlxNMnJyxDbW8OfrrQYfXRC1lBMg/V784m47lKeHffV9mhduFmK+I84xiW53bWFWyM2kGslj+PbSxwGdAS9kKiVa6P2gqVuptIddPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762344; c=relaxed/simple;
	bh=geRMwJ+CYZQK/r4OTp2CMfrmBkm2kjnecKf2X1Xibp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqijt5p56m90HMta8bAiuPaeZCVV8m0sSMPXUDOviLpeseNaT3Zg9bK8W2rSbGQFBYQrJHlWyezhpEyaxOM9O4PCtprXoht0U8h7zfzee5QuCIEYpsf92OouZic+9MNveiXI1o4HFUUC1WrCoIowal42omlDtQLcZkBJosG9PLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pd0Pbayb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7960C4CEF7;
	Wed, 29 Oct 2025 18:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761762343;
	bh=geRMwJ+CYZQK/r4OTp2CMfrmBkm2kjnecKf2X1Xibp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pd0Pbayba7zQdtiMDbrlK1AsmwO8X0W+Eugx4IJHnp6m+yRJBRXxp4Cn+qGwPEhLz
	 Ka2DV06i6tFf6oD5Gc8+GNYsRlsmew2uyWsU3EJixmdTYdx+zVExOXxohXn5IAiB3S
	 maKQ1kQlASiab8DglRX4VVLSzVj43TrPQ0S3KYoY9cg+/tSrF7r4XQdxyTcXNMsSPy
	 PcvoZzZbUy13AxIcLCJtH/b+nCCCBohMXJvMrjnQdiNr9H1L67UNFSzafSW/bVdPeJ
	 Q8TmMIiNnJ1KIPkQx0NXOj/oor9/WCnEWZ+VMLgZNnB3iAnIJP4zdY8HZ00Azid/mu
	 0p/fvEPqE1k4A==
Date: Wed, 29 Oct 2025 18:25:39 +0000
From: Conor Dooley <conor@kernel.org>
To: Marius Cristea <marius.cristea@microchip.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: temperature: add support for
 EMC1812
Message-ID: <20251029-blaspheme-stinking-91b73a8ab778@spud>
References: <20251029-hw_mon-emc1812-v1-0-be4fd8af016a@microchip.com>
 <20251029-hw_mon-emc1812-v1-1-be4fd8af016a@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pQCXUAYBFL+ZLfFS"
Content-Disposition: inline
In-Reply-To: <20251029-hw_mon-emc1812-v1-1-be4fd8af016a@microchip.com>


--pQCXUAYBFL+ZLfFS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 05:50:58PM +0200, Marius Cristea wrote:
> This is the devicetree schema for Microchip EMC1812/13/14/15/33
> Multichannel Low-Voltage Remote Diode Sensor Family.
>=20
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> ---
>  .../bindings/hwmon/microchip,emc1812.yaml          | 176 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 182 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/microchip,emc1812.ya=
ml b/Documentation/devicetree/bindings/hwmon/microchip,emc1812.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..cc4c7bb53cb13416c1e9419cc=
8c6c8a56da22df8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/microchip,emc1812.yaml
> @@ -0,0 +1,176 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/microchip,emc1812.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip EMC1812/13/14/15/33 multichannel temperature sensor
> +
> +maintainers:
> +  - Marius Cristea <marius.cristea@microchip.com>
> +
> +description: |
> +  The Microchip EMC1812/13/14/15/33 is a high-accuracy 2-wire multichann=
el
> +  low-voltage remote diode temperature monitor.
> +
> +  The datasheet can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/Prod=
uctDocuments/DataSheets/EMC1812-3-4-5-33-Data-Sheet-DS20005751.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,emc1812
> +      - microchip,emc1813
> +      - microchip,emc1814
> +      - microchip,emc1815
> +      - microchip,emc1833

Could you add a note to the commit message about what makes these
devices incompatible with one another?

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  interrupt-names:
> +    description:
> +      -alert-therm2 asserts when a diode temperature exceeds the ALERT
> +      threshold.
> +      -therm-addr asserts low when the hardware-set THERM limit threshol=
d is
> +      exceeded by one of the temperature sensors.

You should be able to just move this into interrupts:
  interrupts:
    items:
      - description:
          alert-therm2 asserts when a diode temperature exceeds the ALERT
          threshold.
      - description:
          therm-addr asserts low when the hardware-set THERM limit threshol=
d is
          exceeded by one of the temperature sensors.

> +    items:
> +      - const: alert-therm2
> +      - const: therm-addr

Also, should this and interrupts have minItems: 1? Are both actually
required? Can you have therm-addr without alert-therm2?

pw-bot: changes-requested

Cheers,
Conor.

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  microchip,parasitic-res-on-channel1-2:
> +    description:
> +      Indicates that the chip and the diodes/transistors are sufficiently
> +      far apart that a parasitic resistance is added to the wires, which=
 can
> +      affect the measurements. Due to the anti-parallel diode connection=
s,
> +      channels 1 and 2 are affected together.
> +    type: boolean
> +
> +  microchip,parasitic-res-on-channel3-4:
> +    description:
> +      Indicates that the chip and the diodes/transistors are sufficientl=
y far
> +      apart that a parasitic resistance is added to the wires, which can=
 affect
> +      the measurements. Due to the anti-parallel diode connections, chan=
nels
> +      3 and 4 are affected together.
> +    type: boolean
> +
> +  vdd-supply: true
> +
> +patternProperties:
> +  "^channel@[1-4]$":
> +    description:
> +      Represents the external temperature channels to which
> +      a remote diode is connected.
> +    type: object
> +
> +    properties:
> +      reg:
> +        items:
> +          minimum: 1
> +          maximum: 4
> +
> +      label:
> +        description: Unique name to identify which channel this is.
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,emc1812
> +              - microchip,emc1813
> +              - microchip,emc1833
> +    then:
> +      properties:
> +        microchip,parasitic-res-on-channel3-4: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,emc1812
> +    then:
> +      properties:
> +        channel@1:
> +          properties:
> +            reg:
> +              items:
> +                const: 1
> +      patternProperties:
> +        "^channel@[2-4]$": false
> +  - if:
> +      properties:
> +        compatible:
> +          pattern: "^microchip,emc18[13]3"
> +    then:
> +      patternProperties:
> +        "^channel@[12]$":
> +          properties:
> +            reg:
> +              items:
> +                maximum: 2
> +        "^channel@[34]$": false
> +  - if:
> +      properties:
> +        compatible:
> +          pattern: "^microchip,emc1814"
> +    then:
> +      patternProperties:
> +        "^channel@[1-3]$":
> +          properties:
> +            reg:
> +              items:
> +                maximum: 3
> +      properties:
> +        channel@4: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        temperature-sensor@4c {
> +            compatible =3D "microchip,emc1813";
> +            reg =3D <0x4c>;
> +
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            microchip,parasitic-res-on-channel1-2;
> +
> +            vdd-supply =3D <&vdd>;
> +
> +            channel@1 {
> +                reg =3D <1>;
> +                label =3D "External CH1 Temperature";
> +            };
> +
> +            channel@2 {
> +                reg =3D <2>;
> +                label =3D "External CH2 Temperature";
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6d7b697bfdba16e4f0ee5f4f0195b9d7da06dae5..85c236df781e47c78deeb7ef4=
d80bc94bba604c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16646,6 +16646,12 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/interrupt-controller/microchip,sama=
7g5-eic.yaml
>  F:	drivers/irqchip/irq-mchp-eic.c
> =20
> +MICROCHIP EMC1812 DRIVER
> +M:	Marius Cristea <marius.cristea@microchip.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/hwmon/microchip,emc1812.yaml
> +
>  MICROCHIP I2C DRIVER
>  M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>  L:	linux-i2c@vger.kernel.org
>=20
> --=20
> 2.48.1
>=20

--pQCXUAYBFL+ZLfFS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQJcIwAKCRB4tDGHoIJi
0lfgAP9dLu3oiNOSbLJE5hZi+eIjQo8c5VRNEXccoDhaloGJhQEAwpVobn2qH9ia
jcWZXdrmfZCnJWEOD4hQtVL+9PHQMw0=
=DnRy
-----END PGP SIGNATURE-----

--pQCXUAYBFL+ZLfFS--

