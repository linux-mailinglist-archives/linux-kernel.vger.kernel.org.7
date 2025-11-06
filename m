Return-Path: <linux-kernel+bounces-889183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83E6C3CE7C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2EF3A2F3D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ED234B196;
	Thu,  6 Nov 2025 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUWJvAve"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4E62777EA;
	Thu,  6 Nov 2025 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450793; cv=none; b=czSVeuI7YIWBpO/I8ITaSn9vAiKrEjqfOIC/z8zzvHlxczwHIvv6VwjVFiJfAUdeE78xBNTSQNMsSlAPvS1Sn2gqqJgctW0dWe8wDjpObEhZI8QovQzvQkCXKLUShEU5EiBNGZ00i4hlss1qd0WRBZEwoRi3xAFoL1uhJ7/GA1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450793; c=relaxed/simple;
	bh=32ecH3quWdYg9VJjWgS8mhb2g3pXJ4BMYT5sjPUy0B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIL9YULHOCO7CxhQgFsuKMg5qNvGG90w7DXyLIm9CmOsRPzUNCoyxCjS33omySDHbEN6OIXzaOcAM1gHym+jsflD/AqCjok0bFVtyimygkPBDoYskHVz2QYyMbrZSjqZgCg9qwK3cbQaumqMQAiSzfX9NwWpFGg+UMO8N60/YoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUWJvAve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88AC4C4CEF7;
	Thu,  6 Nov 2025 17:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762450793;
	bh=32ecH3quWdYg9VJjWgS8mhb2g3pXJ4BMYT5sjPUy0B8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OUWJvAveZP4CAUYwRvtaCOpEwpHY3NNhEqTKgOEa3DVLFaWkokrHKdsd/v4jyKi7f
	 oiMcYzZ8TUWQ5clL5OAHCEMAbVLOMzGfBByDD4b8qFnsq+fnh50sQU5MilHAvVSua2
	 I2/kmMLiJI1FKQ0YAO4AYqxjCZLQnxbL6dmAXkCHzxsd+HcpmlzBnB2kDXkIfpUCm2
	 /GFYV9icsu2DvXfXydYT1bQHukoCGGJCp8dYd4O9aYibiLUqElDCxP7Cj2cZWF+ibZ
	 0NBW/db6MrKh5g07IjM4wlkHnYrwgvp3KnxXTM03NmjRY69GgMf88LzhHJf8kTHoeZ
	 XyW6QnBNhTvmA==
Date: Thu, 6 Nov 2025 17:39:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
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
Message-ID: <20251106-hull-petri-42878717ee85@spud>
References: <20251106013358.421809-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X7h4dEY6/aHtu7HK"
Content-Disposition: inline
In-Reply-To: <20251106013358.421809-1-Frank.Li@nxp.com>


--X7h4dEY6/aHtu7HK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 08:33:56PM -0500, Frank Li wrote:
> Convert dlg,da9052-i2c.txt to yaml format.
> Additional changes:
> - compatible string fallback to dlg,da9052 to align existing dts files.
> - Add interrupts property.
> - Add ref to /schemas/spi/spi-peripheral-props.yaml#
>=20
> Remove dlg,da9053 from trivial-devices.yaml.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/mfd/da9052-i2c.txt    | 67 -------------
>  .../devicetree/bindings/mfd/dlg,da9052.yaml   | 93 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  3 files changed, 93 insertions(+), 69 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/da9052-i2c.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/dlg,da9052.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt b/Docum=
entation/devicetree/bindings/mfd/da9052-i2c.txt
> deleted file mode 100644
> index 07c69c0c6624c..0000000000000
> --- a/Documentation/devicetree/bindings/mfd/da9052-i2c.txt
> +++ /dev/null
> @@ -1,67 +0,0 @@
> -* Dialog DA9052/53 Power Management Integrated Circuit (PMIC)
> -
> -Required properties:
> -- compatible : Should be "dlg,da9052", "dlg,da9053-aa",
> -			 "dlg,da9053-ab", or "dlg,da9053-bb"
> -
> -Optional properties:
> -- dlg,tsi-as-adc : Boolean, if set the X+, X-, Y+, Y- touchscreen
> -                    input lines are used as general purpose analogue
> -					input.
> -- tsiref-supply: Phandle to the regulator, which provides the reference
> -                 voltage for the TSIREF pin. Must be provided when the
> -			     touchscreen pins are used for ADC purposes.
> -
> -Sub-nodes:
> -- regulators : Contain the regulator nodes. The DA9052/53 regulators are
> -  bound using their names as listed below:
> -
> -    buck1     : regulator BUCK CORE
> -    buck2     : regulator BUCK PRO
> -    buck3     : regulator BUCK MEM
> -    buck4     : regulator BUCK PERI
> -    ldo1      : regulator LDO1
> -    ldo2      : regulator LDO2
> -    ldo3      : regulator LDO3
> -    ldo4      : regulator LDO4
> -    ldo5      : regulator LDO5
> -    ldo6      : regulator LDO6
> -    ldo7      : regulator LDO7
> -    ldo8      : regulator LDO8
> -    ldo9      : regulator LDO9
> -    ldo10     : regulator LDO10
> -
> -  The bindings details of individual regulator device can be found in:
> -  Documentation/devicetree/bindings/regulator/regulator.txt
> -
> -Examples:
> -
> -i2c@63fc8000 { /* I2C1 */
> -
> -	pmic: dialog@48 {
> -		compatible =3D "dlg,da9053-aa";
> -		reg =3D <0x48>;
> -
> -		regulators {
> -			buck1 {
> -				regulator-min-microvolt =3D <500000>;
> -				regulator-max-microvolt =3D <2075000>;
> -			};
> -
> -			buck2 {
> -				regulator-min-microvolt =3D <500000>;
> -				regulator-max-microvolt =3D <2075000>;
> -			};
> -
> -			buck3 {
> -				regulator-min-microvolt =3D <925000>;
> -				regulator-max-microvolt =3D <2500000>;
> -			};
> -
> -			buck4 {
> -				regulator-min-microvolt =3D <925000>;
> -				regulator-max-microvolt =3D <2500000>;
> -			};
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9052.yaml b/Docu=
mentation/devicetree/bindings/mfd/dlg,da9052.yaml
> new file mode 100644
> index 0000000000000..4ecd498864e4e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/dlg,da9052.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/dlg,da9052.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dialog DA9052/53 Power Management Integrated Circuit (PMIC)
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - dlg,da9053

Should this actually exist? It was never in any drivers etc at all, and
as far as I can tell any users use the -XX suffixed ones. Probably this
is the only compatible that /should/ have been used, but it might be
pointless to add now.

> +              - dlg,da9053-aa
> +              - dlg,da9053-ab
> +              - dlg,da9053-bb

The driver also has a bc, I think that should be added.

> +          - const: dlg,da9052

Is this actually a correct fallback?
I know it is being used, but looking at the drivers I see things like:
	/* Select the appropriate current limit range */
	if (regulator->da9052->chip_id =3D=3D DA9052)
		row =3D 0;
	else if (offset =3D=3D 0)
		row =3D 1;
in both the battery and regulator drivers.
Might actually be the devicetrees are wrong here?

> +      - enum:
> +          - dlg,da9052
> +          - dlg,da9053-aa # Just for match existed old platform

Could you just change that one old platform using it?
Otherwise, conversion looks okay to me.

pw-bot: changes-requested

Cheers,
Conor.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  dlg,tsi-as-adc:
> +    type: boolean
> +    description:
> +      if set the X+, X-, Y+, Y- touchscreen input lines are used as gene=
ral
> +      purpose analogue input.
> +
> +  tsiref-supply:
> +    description: The reference voltage for the TSIREF pin.
> +
> +  regulators:
> +    type: object
> +    additionalProperties: false
> +
> +    patternProperties:
> +      "^(ldo([1-9]|10)|buck[1-4])$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - regulators
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        pmic@48 {
> +            compatible =3D "dlg,da9053-aa";
> +            reg =3D <0x48>;
> +
> +            regulators {
> +                buck1 {
> +                    regulator-min-microvolt =3D <500000>;
> +                    regulator-max-microvolt =3D <2075000>;
> +                };
> +
> +                buck2 {
> +                    regulator-min-microvolt =3D <500000>;
> +                    regulator-max-microvolt =3D <2075000>;
> +                };
> +
> +                buck3 {
> +                    regulator-min-microvolt =3D <925000>;
> +                    regulator-max-microvolt =3D <2500000>;
> +                };
> +
> +                buck4 {
> +                    regulator-min-microvolt =3D <925000>;
> +                    regulator-max-microvolt =3D <2500000>;
> +                };
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 2eff6f274302a..17b72a8028e08 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -103,8 +103,6 @@ properties:
>            - dfrobot,sen0322
>              # DH electronics GmbH on-board CPLD trivial SPI device
>            - dh,dhcom-board
> -            # DA9053: flexible system level PMIC with multicore support
> -          - dlg,da9053
>              # DMARD05: 3-axis I2C Accelerometer
>            - domintech,dmard05
>              # DMARD06: 3-axis I2C Accelerometer
> --=20
> 2.34.1
>=20

--X7h4dEY6/aHtu7HK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQzdYwAKCRB4tDGHoIJi
0sesAP9lVftM6R6ZaMuARmBUwRxLBCmEVo1AdtU+Dl6bVKEO5AD/eQnvxBgws/5M
OUhiBtSiN52tfVHRmS/cujMSn8xwvA4=
=OxCC
-----END PGP SIGNATURE-----

--X7h4dEY6/aHtu7HK--

