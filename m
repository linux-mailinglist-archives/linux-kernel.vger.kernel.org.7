Return-Path: <linux-kernel+bounces-833108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7944BA13CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D973188B911
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D359231D722;
	Thu, 25 Sep 2025 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOiLZG7q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E554F81;
	Thu, 25 Sep 2025 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758829260; cv=none; b=VN+12ZnGSlZfPb0FQvFGnpjj34to50CaWT+qQDHXs8uieNES+csPNp3B6w/ZheMAYOBqVfxLo+1ERpG/0fS6kKv6WA2ctkkd2KXgQVPEDWP0Y3Q9HhGessNpGa3p/or8x/j71fLV7UjX5Zwp+NdQ30+8llPn/6j29wVsFK4E8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758829260; c=relaxed/simple;
	bh=ViA5pc3Tho/YfhUjfRLL2YX34M7Tl+XYrQGrX1MRlWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa0AjpeitelBLXhUD95vO+scXuOj7XR5ogvS2WUgAApQIySCYtNhv28OjY0vfx0gygIYdGMQ0NwL7Cj3VVnc1n6bUwgQu5dxOpsWHQVG7ebBpogXhGvvdDfLL4cRZmK/oWcAW79eSVimc+Z8GKx+SG1pUFRavat++7cDr82GULY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOiLZG7q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FBBC4CEF0;
	Thu, 25 Sep 2025 19:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758829260;
	bh=ViA5pc3Tho/YfhUjfRLL2YX34M7Tl+XYrQGrX1MRlWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOiLZG7qujcbYL14RHm0Jy1r66U2dBjwkUHV+/MnHyXa/YvI4dJWMgtWAYVfckoFY
	 eMUJcEhRLKgE137/qMcmLwc3Ayj2sICdtJxR0xsLVzRNbHw/I9BlK4Orza1aRR8A5V
	 cpfulSKEBcN6iFp8jejX6uhx2E5AGp+PPcMigZ5d2jWRQEzTg12t6fe9FqQ4CJlKCY
	 YgC2Zk2w7uEwLS9xuEklTvS/RFiWhSgUQ0m2lQvZdTxAt3+SlznIeI4+HZLkkqaVaD
	 3yVpxrwPP2hKtRZ06nhavgI0IF2031ZBnrFqaINDg1ekXCBKBa55E5x6a6BKM1ouF6
	 UFDv2nio5MFWQ==
Date: Thu, 25 Sep 2025 20:40:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>,
	Saenz Julienne <nsaenz@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 1/4] dt-bindings: Add Raspberry Pi's RP1 ADC
Message-ID: <20250925-outlying-causal-015d8ba33c53@spud>
References: <20250925000416.2408457-1-svarbanov@suse.de>
 <20250925000416.2408457-2-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DEAMv2iXlbCNcm+O"
Content-Disposition: inline
In-Reply-To: <20250925000416.2408457-2-svarbanov@suse.de>


--DEAMv2iXlbCNcm+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 03:04:13AM +0300, Stanimir Varbanov wrote:
> Document dt-bindings for Raspberry Pi's RP1 ADC.
>=20
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
>  .../bindings/hwmon/raspberrypi,rp1-adc.yaml   | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/raspberrypi,r=
p1-adc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-adc.=
yaml b/Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-adc.yaml
> new file mode 100644
> index 000000000000..5266b253fd2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/raspberrypi,rp1-adc.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/hwmon/raspberrypi,rp1-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rasberry Pi RP1 ADC device
> +
> +maintainers:
> +  - Stanimir Varbanov <svarbanov@suse.de>
> +
> +description: |
> +  The RP1 ADC is a five input successive-approximation ADC with 12-bit
> +  resolution (ENOB 9.5-bit) at 500kSPS. It has four external inputs
> +  and one internal temperature sensor.
> +
> +properties:
> +  compatible:
> +    const: raspberrypi,rp1-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      Reference voltage regulator 3.3V.

Looks like you're missing the io-channels-cells property that allows
this device to be a provider of adc channels to other devices.

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - vref-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc@400c8000 {
> +      compatible =3D "raspberrypi,rp1-adc";
> +      reg =3D <0x400c8000 0x4000>;
> +      clocks =3D <&rp1_clocks 30>;
> +      vref-supply =3D <&rp1_vdd_3v3>;
> +    };
> --=20
> 2.47.0
>=20

--DEAMv2iXlbCNcm+O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNWaxgAKCRB4tDGHoIJi
0pQHAQC21E9owOCVvJfNrBEbbj2dwuVJ4gWOmP4qMntXYj/OmAD/fhH7+LUL0aNT
IDpUD7965J1+1DOEDBP3AVDFKgEPjgU=
=5H4q
-----END PGP SIGNATURE-----

--DEAMv2iXlbCNcm+O--

