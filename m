Return-Path: <linux-kernel+bounces-836645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AC9BAA387
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3FCF421F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDE1273F9;
	Mon, 29 Sep 2025 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHaY7izU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F35733086;
	Mon, 29 Sep 2025 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167977; cv=none; b=bI0iz5PVr/hlOwIiS4ydzyCWsKgcleMELYxV8u2L3RY6dtmAVyMdbsXOPi3uwbL8Unwnve9JAWINpNPY/emWCsTQzzwlGyzTw8JbQyXCZ25R80N0qhyOr7ShTf2NCW1l7ZQNkie94XJ/zWoPPF9Up3q37jH5Bh1jMM+ID9Pk1bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167977; c=relaxed/simple;
	bh=y4XpJqJuDggPW3QOPPk8QsxbwQMr0oYsgzTpm857cnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1lo2CSmeW1M5upBelQbMzUvjkpIDD7CoVHHmz5AbT1Car5SBRdWulBanE3ZDTAc1N7ycB3nehTePvSH4JFby8V3UpkOYCYE1eE/TosLbn4AwWDOymFg6Ptp7KcZd2b+AsmXwDJtjqNc+oLSCVSiKzDWf9UASZtfQAzpQHBo+4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHaY7izU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E07C4CEF4;
	Mon, 29 Sep 2025 17:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759167975;
	bh=y4XpJqJuDggPW3QOPPk8QsxbwQMr0oYsgzTpm857cnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DHaY7izU7Pviv+1YCyqLNjOxeHQcJHmIqG7yjk6Vn8Gh3Vwp7RvnRWheQQlknGWmt
	 4mCLrOuXlK0Ezbbh6QO9cWED0lBeVKb8D3+aqkt+cFWK35WuxwJjBLywAYltLd9B2c
	 gZkVUD5+fzJLpK8+woibfb2HRr9x0Wkcq8mHJToywdg/OxifQ4WftdnsGQq4rEdY2B
	 /eITTty0d6qXCuGu6V3V58uonq4ocA32lZYKzpxmVpGRjDjrVBkhyopOB7BHrKU9zb
	 JUNt8rryKYjzBYGiGlL0peuIEXmwdvWChbpQgGxFgjEQb6PQOqDY9jKlt3Ba6bTJDn
	 VBlvjuroLr7GQ==
Date: Mon, 29 Sep 2025 18:46:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Joan-Na-adi <joan.na.devcode@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: regulator: Add MAX77675 regulator
 binding
Message-ID: <20250929-morally-finally-d2c0f4dacce8@spud>
References: <20250929105618.177511-1-joan.na@analog.com>
 <20250929105618.177511-4-joan.na@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VGH9y9Cg8XagcEKb"
Content-Disposition: inline
In-Reply-To: <20250929105618.177511-4-joan.na@analog.com>


--VGH9y9Cg8XagcEKb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 07:56:18PM +0900, Joan-Na-adi wrote:
> From: Joan Na <joan.na@analog.com>
>=20
> Add device tree binding YAML schema for the Maxim MAX77675 PMIC regulator.
> This defines the node properties and supported regulator names for use
> in device tree sources.
>=20
> Signed-off-by: Joan Na <joan.na@analog.com>

I reviewed v1 on the 26th, but see no mention nor sign of any of my
comments here. Why is that?

Cheers,
Conor.

> ---
>  .../bindings/regulator/maxim,max77675.yaml    | 202 ++++++++++++++++++
>  1 file changed, 202 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max=
77675.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77675.y=
aml b/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
> new file mode 100644
> index 000000000000..f93dfdc499bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
> @@ -0,0 +1,202 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/maxim,max77675.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX77675 PMIC Regulator
> +
> +maintainers:
> +  - Joan Na <joan.na@analog.com>
> +
> +description: |
> +  The MAX77675 is a PMIC providing multiple switching buck regulators
> +  (SBB0=E2=80=93SBB3), accessible via I2C. Each SBB can be configured in=
dividually
> +  in the Device Tree. Additional PMIC settings can be configured through
> +  device-specific properties.
> +  Users should use the macros from dt-bindings/regulator/maxim,max77675-=
regulator.h
> +
> +allOf:
> +  - $ref: regulator.yaml#
> +
> +properties:
> +  compatible:
> +    const: maxim,max77675
> +
> +  reg:
> +    maxItems: 1
> +
> +  maxim,dvs-slew-rate:
> +    description: |
> +      DVS slew rate setting.
> +      0 (MAX77675_DVS_SLEW_5MV) - 5 mV/=CE=BCs
> +      1 (MAX77675_DVS_SLEW_10MV) - 10 mV/=CE=BCs
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  maxim,latency-mode:
> +    description: |
> +      Latency mode for voltage transition:
> +      0 (MAX77675_LAT_MODE_HIGH_LATENCY) - Low quiescent current, high l=
atency (~100=CE=BCs)
> +      1 (MAX77675_LAT_MODE_LOW_LATENCY) - High quiescent current, low la=
tency (~10=CE=BCs)
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  maxim,drv-sbb-strength:
> +    description: |
> +      SIMO Buck-Boost Drive Strength Trim.
> +      0 (MAX77675_DRV_SBB_FASTEST) - Fastest transition (~0.6 ns)
> +      1 (MAX77675_DRV_SBB_FAST) - Faster transition (~1.2 ns)
> +      2 (MAX77675_DRV_SBB_MEDIUM) - Moderate transition (~1.8 ns)
> +      3 (MAX77675_DRV_SBB_SLOWEST) - Slowest transition (~8 ns)
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +  maxim,manual-reset-time:
> +    description: |
> +      Manual reset time in seconds:
> +      0 (MAX77675_MRT_4S): 4 seconds
> +      1 (MAX77675_MRT_8S): 8 seconds
> +      2 (MAX77675_MRT_12S): 12 seconds
> +      3 (MAX77675_MRT_16S): 16 seconds
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +  maxim,en-pullup-disable:
> +    description: |
> +      Disable internal pull-up for EN pin.
> +      0 (MAX77675_PU_EN): Internal pull-up enabled (default).
> +      1 (MAX77675_PU_DIS): Internal pull-up disabled.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  maxim,bias-low-power-request:
> +    description: |
> +      Controls the bias low-power mode setting.
> +      0 (MAX77675_BIAS_NORMAL): Normal bias operation
> +      1 (MAX77675_BIAS_LPM_REQ): Request low-power bias mode
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  maxim,simo-int-ldo-always-on:
> +    description: |
> +      SIMO internal channel disable configuration.
> +      0 (MAX77675_SIMO_INT_NORMAL): SIMO channel enabled
> +      1 (MAX77675_SIMO_INT_LDO): SIMO channel disabled
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  maxim,en-mode:
> +    description: |
> +      Enable mode configuration.
> +      0 (MAX77675_EN_PUSH_BUTTON): Push button
> +      1 (MAX77675_EN_SLIDE_SWITCH): Slide switch
> +      2 (MAX77675_EN_LOGIC): Logic mode
> +      3 (MAX77675_EN_RESERVED): Reserved
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +  maxim,en-debounce-time:
> +    description: |
> +      Debounce timer enable.
> +      0 (MAX77675_DBEN_100US): 100us
> +      1 (MAX77675_DBEN_30MS): 30ms
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  regulators:
> +    type: object
> +    description: Regulator child nodes
> +    patternProperties:
> +      "^sbb[0-3]$":
> +        type: object
> +        $ref: regulator.yaml#
> +    properties:
> +      maxim,fps-slot:
> +        description: |
> +          FPS slot selection.
> +          0 (MAX77675_FPS_SLOT_0): FPS Slot 0
> +          1 (MAX77675_FPS_SLOT_1): FPS Slot 1
> +          2 (MAX77675_FPS_SLOT_2): FPS Slot 2
> +          3 (MAX77675_FPS_SLOT_3): FPS Slot 3
> +          4 (MAX77675_FPS_NONE): No FPS Slot (disabled)
> +          5 (MAX77675_FPS_DEF): Use the defaul
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2, 3, 4, 5]
> +
> +      maxim,slew-rate-use-dvs:
> +        description: |
> +          0 (MAX77675_SR_2MV_PER_US): Fixed slew rate of 2mV/=CE=BCs.
> +          1 (MAX77675_SR_USE_DVS): Uses maxim,dvs-slew-rate for dynamic =
voltage scaling.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1]
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/regulator/maxim,max77675-regulator.h>
> +
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      max77675: pmic@44 {
> +        compatible =3D "maxim,max77675";
> +        reg =3D <0x44>;
> +
> +        maxim,dvs-slew-rate =3D <MAX77675_DVS_SLEW_5MV>;
> +        maxim,latency-mode =3D <MAX77675_LAT_MODE_HIGH_LATENCY>;
> +        maxim,drv-sbb-strength =3D <MAX77675_DRV_SBB_FASTEST>;
> +        maxim,manual-reset-time =3D <MAX77675_MRT_4S>;
> +        maxim,en-pullup-disable =3D <MAX77675_PU_EN>;
> +        maxim,bias-low-power-request =3D <MAX77675_BIAS_NORMAL>;
> +        maxim,simo-int-ldo-always-on =3D <MAX77675_SIMO_INT_NORMAL>;
> +        maxim,en-mode =3D <MAX77675_EN_PUSH_BUTTON>;
> +        maxim,en-debounce-time =3D <MAX77675_DBEN_100US>;
> +
> +        regulators {
> +          sbb0: sbb0 {
> +            regulator-name =3D "sbb0";
> +            regulator-min-microvolt =3D <500000>;
> +            regulator-max-microvolt =3D <5500000>;
> +            maxim,fps-slot =3D <MAX77675_FPS_DEF>;
> +            maxim,slew-rate-use-dvs =3D <MAX77675_SR_2MV_PER_US>;
> +          };
> +
> +          sbb1: sbb1 {
> +            regulator-name =3D "sbb1";
> +            regulator-min-microvolt =3D <500000>;
> +            regulator-max-microvolt =3D <5500000>;
> +            regulator-allow-set-voltage;
> +            maxim,fps-slot =3D <MAX77675_FPS_DEF>;
> +            maxim,slew-rate-use-dvs =3D <MAX77675_SR_2MV_PER_US>;
> +          };
> +
> +          sbb2: sbb2 {
> +            regulator-name =3D "sbb2";
> +            regulator-min-microvolt =3D <500000>;
> +            regulator-max-microvolt =3D <5500000>;
> +            regulator-allow-set-voltage;
> +            maxim,fps-slot =3D <MAX77675_FPS_DEF>;
> +            maxim,slew-rate-use-dvs =3D <MAX77675_SR_2MV_PER_US>;
> +          };
> +
> +          sbb3: sbb3 {
> +            regulator-name =3D "sbb3";
> +            regulator-min-microvolt =3D <500000>;
> +            regulator-max-microvolt =3D <5500000>;
> +            regulator-allow-set-voltage;
> +            maxim,fps-slot =3D <MAX77675_FPS_DEF>;
> +            maxim,slew-rate-use-dvs =3D <MAX77675_SR_2MV_PER_US>;
> +          };
> +        };
> +      };
> +    };
> +
> --
> 2.34.1
>=20

--VGH9y9Cg8XagcEKb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNrF4wAKCRB4tDGHoIJi
0rKzAP4+UV3/Vx6wMnnUrs/2ydlpPI99u7laoIwKe1DjZJn2MAEA/eDoUnjf/WTN
PiFKaLEcfvM2q0nluhQms9Ez6ItTtg4=
=yEmL
-----END PGP SIGNATURE-----

--VGH9y9Cg8XagcEKb--

