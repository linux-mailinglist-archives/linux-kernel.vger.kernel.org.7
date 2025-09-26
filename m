Return-Path: <linux-kernel+bounces-834460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F7BBA4BC4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C7E77AFD75
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9364330C0EF;
	Fri, 26 Sep 2025 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcAC5Ct/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB0226D4EF;
	Fri, 26 Sep 2025 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758906504; cv=none; b=LO5tZ3OA3TaWCqnHx67gF7STq0RRRHKeLqnA63yG44YR5njMzcTq9DZPhGedWj5wCdQ1ReTq6476/wyxMKhZ+MzxKjTTGr5w/m7/YRkesX1ON9W+rCkEjcueC92DIlI1xk/TiOy5ALELj3MWPFIGJxVKxGMertwI7B22PdVTcxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758906504; c=relaxed/simple;
	bh=DdOHPKjFapoKiubB7w8+kTw2/pHKVJAEF8mpMrWc1Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3N03utz2xEhImxrPhAu4E9yG/fM5xX335N4OGnBJ3UVFUFfLTqjHgSZBr+xl9F9vhrrkCL1x9UQvkjYqnuULUR1bNS5xyHPkJqZ5FFKMxPPKZ8UI2yy2udFizDL6axrfFbPFU5NjmIM4qpcc66DyzyCpdm9GbDNidW/TrDqdkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcAC5Ct/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD0BC4CEF4;
	Fri, 26 Sep 2025 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758906501;
	bh=DdOHPKjFapoKiubB7w8+kTw2/pHKVJAEF8mpMrWc1Ms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KcAC5Ct/ns6qbixNqYichIq4QktRG/haIAN7jWinp6mJvW8V7DCyw4lSU5vcsTMQf
	 CjaSxK+byI+jd2gdMqtcX9u+PFOwAsEhcw7W6+FAy2xuVUEncesPrf7T9uk+vz8zoy
	 Oo1iBQb/MAH+UuBmPJyDlu8kvqggrBMT2pV1HQPyaw/+ZUCYmmDHXxrZy8P8Unbmfk
	 0w3q2rr6VbSDgQ4USCRThYu7ba+DwvHeOuKXWvIQsz1jYakRqC+Aty/WbGA4eOseOV
	 mXaXHycevxBaUo9O293nR9fpbrFiyJ4/z2ORtjLaDW7M9JY5A9mltWIW+LBM9XmPWQ
	 tFu8+W5vz1CTQ==
Date: Fri, 26 Sep 2025 18:08:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Joan-Na-adi <joan.na.devcode@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>
Subject: Re: [PATCH 3/3] dt-bindings: regulator: Add MAX77675 regulator
 binding
Message-ID: <20250926-silliness-unopposed-d48b3dea455e@spud>
References: <20250926053757.480086-1-joan.na@analog.com>
 <20250926053757.480086-4-joan.na@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YasFFFzUT3OF5nyw"
Content-Disposition: inline
In-Reply-To: <20250926053757.480086-4-joan.na@analog.com>


--YasFFFzUT3OF5nyw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 02:37:57PM +0900, Joan-Na-adi wrote:
> From: Joan Na <joan.na@analog.com>
>=20
> Add device tree binding YAML schema for the Maxim MAX77675 PMIC regulator.
> This defines the node properties and supported regulator names for use
> in device tree sources.
>=20
> Signed-off-by: Joan Na <joan.na@analog.com>
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

Please use proper units for this property.

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

Seems like this should be a string enum, of "low" and "high".

> +  maxim,drv-sbb-strength:

Drive strengths usually in amps, how come this is not? If amps is not
meaningful here, please use strings not register values.

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

For time measured in seconds, the standard unit suffix is "-sec". Please
use that rather than register values.

> +
> +  maxim,en-pullup-disable:
> +    description: |
> +      Disable internal pull-up for EN pin.
> +      0 (MAX77675_PU_EN): Internal pull-up enabled (default).
> +      1 (MAX77675_PU_DIS): Internal pull-up disabled.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]

binary properties like this should be booleans. You decide based on the
property being present rather than the value.

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

Same for these two.

> +  maxim,en-mode:
> +    description: |
> +      Enable mode configuration.
> +      0 (MAX77675_EN_PUSH_BUTTON): Push button
> +      1 (MAX77675_EN_SLIDE_SWITCH): Slide switch
> +      2 (MAX77675_EN_LOGIC): Logic mode
> +      3 (MAX77675_EN_RESERVED): Reserved
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]

This should probably be a string. Not sure what the point of allowing
the reserved value is though.

> +
> +  maxim,en-debounce-time:
> +    description: |
> +      Debounce timer enable.
> +      0 (MAX77675_DBEN_100US): 100us
> +      1 (MAX77675_DBEN_30MS): 30ms
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]

Please put this property into a unit of time. "-us" is probably the
correct suffix to go for.

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

What does this even mean? Where does the default come from?

Also, is this property basically just a reinvention of reg?
There's no explanation so it is hard to tell.

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

Seems like this should be a boolean property, "maxim,fixed-slew-rate"
where being present sets it to 2mV/us and absent uses the inherited
dynamic rate.

> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators

Most of your properties are missing default values since they're not
required.

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

--YasFFFzUT3OF5nyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNbIgAAKCRB4tDGHoIJi
0qwsAQCbPzlzcW425PzA/L/YhpUqNpuViPzM92Z80WXFxFd2mwD/fbVqA1FvNL+B
aa7MthvYE77wJezeQQ99B5sX64AINQs=
=KJNx
-----END PGP SIGNATURE-----

--YasFFFzUT3OF5nyw--

