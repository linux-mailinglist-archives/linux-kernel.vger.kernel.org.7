Return-Path: <linux-kernel+bounces-722049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1163DAFD404
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC061885D18
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF291548C;
	Tue,  8 Jul 2025 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnEqJjd8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8292DECBD;
	Tue,  8 Jul 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993909; cv=none; b=LJ6jStrih8vvbC14P5bwFesfQStVmlCnMYkmxRGRzMzcPYTCfyL8nwAqZBzrFvuo3cLnThEYhSy/QNwa6Vd7mZTMqiojr6/lVWGA/XjOOvrgMzt36nH8KVDPq8J77rz6MQpzM803cs4lsqvaNe2lrNL3NJzN7gXqJZoRdvKIygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993909; c=relaxed/simple;
	bh=hW86NrWeyBFFv7PFlMZTvyDxbDyoRrzlqT4/PD5mIrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSGHaWO6bJQJJsTRyrOHmbrDxVwmLbVOKk5ClCMAcJf9QjwrGPHKs+aO/TSuxU0GY3IO8CRZPv4A8nQ1rgrNwttlcqGDQ2MkZcNVmxEzimiDyqMNwBosdrZxUNJvUIRb3XI8dezvaK/wt26J20oJEkmbEoiA6H2Hzolqty0meVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnEqJjd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00246C4CEED;
	Tue,  8 Jul 2025 16:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751993909;
	bh=hW86NrWeyBFFv7PFlMZTvyDxbDyoRrzlqT4/PD5mIrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OnEqJjd8Hpu6HJuGkwu5jDtKeRJ1rCo2QCZBD5qsTFLIPiEKY395uO088RiCKBc60
	 KX2oPpsg6yR5rI+IM780RbkB6nfV35eyYSpTRmoyhZwJ9HhDAsh06uUFfcz4LAYe/9
	 o0sxxWNSEvy5jQdsdj1D8cUVnHp5l9d7PvXwyLEUx5XkJj4rf3NSYEgqbR16Hg1Sg/
	 Y4wW9G3RprGItF/V5Q7wGEIEFirgv8qcJ4p9Ce4z2p6U6cvrMzi3i5575+FHp1aEK4
	 1MUEJOwGD2Op00JHCXP+54WRHcJgxiIYC1qcaehfYblpNximjstpA1mqOh5azpZM+/
	 K8MwQl2uyUTOA==
Date: Tue, 8 Jul 2025 11:58:27 -0500
From: Rob Herring <robh@kernel.org>
To: Shree Ramamoorthy <s-ramamoorthy@ti.com>
Cc: lee@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	praneeth@ti.com, m-leonard@ti.com, rklein@nvidia.com
Subject: Re: [PATCH] mfd: dt-bindings: Convert TPS65910 to DT schema
Message-ID: <20250708165827.GA607073-robh@kernel.org>
References: <20250702220217.155647-1-s-ramamoorthy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702220217.155647-1-s-ramamoorthy@ti.com>

On Wed, Jul 02, 2025 at 05:02:17PM -0500, Shree Ramamoorthy wrote:
> Convert the TI TPS65910 documentation to DT schema format.
> 
> Fix incorrect I2C address in example: should be 0x2d.
> 
> TPS65910 datasheet: https://www.ti.com/lit/gpn/tps65910
> 
> Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
> ---
>  .../devicetree/bindings/mfd/ti,tps65910.yaml  | 333 ++++++++++++++++++
>  .../devicetree/bindings/mfd/tps65910.txt      | 205 -----------
>  2 files changed, 333 insertions(+), 205 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps65910.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/tps65910.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65910.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65910.yaml
> new file mode 100644
> index 000000000000..789b3c6d89cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,tps65910.yaml
> @@ -0,0 +1,333 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI TPS65910 Power Management Integrated Circuit
> +
> +maintainers:
> +  - Shree Ramamoorthy <s-ramamoorthy@ti.com>
> +
> +description:
> +  TPS65910 device is a Power Management IC that provides 3 step-down converters,
> +  1 stepup converter, and 8 LDOs. The device contains an embedded power controller (EPC),
> +  1 GPIO, and an RTC.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tps65910
> +      - ti,tps65911
> +
> +  reg:
> +    description: I2C slave address
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +    description: |
> +      The first cell is the GPIO number.
> +      The second cell is used to specify additional options <unused>.
> +      See ../gpio/gpio.txt for more information.

Don't add references to old docs. Or new ones, just drop the last line.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    description: Specifies the IRQ number and flags, as defined in
> +      Documentation/devicetree/bindings/interrupt-controller/interrupts.txt

Drop the reference.

> +    const: 2
> +
> +  ti,vmbch-threshold:
> +    description: |
> +      (TPS65911) Main battery charged threshold comparator.
> +      See VMBCH_VSEL in TPS65910 datasheet.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

Doesn't look like an array to me...

> +    minItems: 1
> +    maxItems: 1
> +    items:
> +      minimum: 0

0 is already the min.

> +      maximum: 3
> +
> +  ti,vmbch2-threshold:
> +    description: |
> +      (TPS65911) Main battery discharged threshold comparator.
> +      See VMBCH_VSEL in TPS65910 datasheet.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 1
> +    items:
> +      minimum: 0
> +      maximum: 3

Same comments here.

> +
> +  ti,en-ck32k-xtal:
> +    type: boolean
> +    description: Enable external 32-kHz crystal oscillator.
> +
> +  ti,en-gpio-sleep:
> +    description: |
> +      Enable sleep control for gpios.
> +      There should be 9 entries here, one for each gpio.

Don't repeat constraints in free form text.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 9
> +    maxItems: 9
> +    items:
> +      minimum: 0
> +      maximum: 1
> +
> +  ti,system-power-controller:
> +    type: boolean
> +    description: Identify whether or not this pmic controls the system power
> +
> +  ti,sleep-enable:
> +    type: boolean
> +    description: Enable SLEEP state.
> +
> +  ti,sleep-keep-therm:
> +    type: boolean
> +    description: Keep thermal monitoring on in sleep state.
> +
> +  ti,sleep-keep-ck32k:
> +    type: boolean
> +    description: Keep the 32KHz clock output on in sleep state.
> +
> +  ti,sleep-keep-hsclk:
> +    type: boolean
> +    description: Keep high speed internal clock on in sleep state.
> +
> +  regulators:
> +    type: object
> +    description: List of regulators provided by this controller.
> +
> +    patternProperties:
> +      "^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        properties:
> +          ti,regulator-ext-sleep-control:
> +            description: |
> +              Enable external sleep control through external inputs:
> +              [0 (not enabled), 1 (EN1), 2 (EN2) or 4(EN3)].
> +              If this property is not defined, it defaults to 0 (not enabled).
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 4, 8]
> +        unevaluatedProperties: true

false

> +
> +      "^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        properties:
> +          ti,regulator-ext-sleep-control:
> +            description: |
> +              Enable external sleep control through external inputs:
> +              [0 (not enabled), 1 (EN1), 2 (EN2) or 4(EN3)].
> +              If this property is not defined, it defaults to 0 (not enabled).
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 4, 8]
> +        unevaluatedProperties: true

false

> +
> +      "^ldo[1-8]$":
> +        type: object
> +        $ref: /schemas/regulator/regulator.yaml#
> +        properties:
> +          ti,regulator-ext-sleep-control:
> +            description: |
> +              Enable external sleep control through external inputs:
> +              [0 (not enabled), 1 (EN1), 2 (EN2) or 4(EN3)].
> +              If this property is not defined, it defaults to 0 (not enabled).
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 4, 8]
> +        unevaluatedProperties: true
> +
> +    additionalProperties: true

false

And move above patternProperties


> +
> +patternProperties:
> +  "^(vcc[1-7]-supply)|vccio-supply$":

^vcc(io|[1-7])-supply$

> +    description: |
> +      Input voltage supply phandle for regulators.
> +      These entries are required if PMIC regulators are enabled, or else it
> +      can cause the regulator registration to fail.

blank line between paragraphs.

> +      If some input supply is powered through battery or always-on supply, then
> +      it is also required to have these parameters with the proper node handle for always-on
> +      power supply.
> +      tps65910:
> +          vcc1-supply: VDD1 input.
> +          vcc2-supply: VDD2 input.
> +          vcc3-supply: VAUX33 and VMMC input.
> +          vcc4-supply: VAUX1 and VAUX2 input.
> +          vcc5-supply: VPLL and VDAC input.
> +          vcc6-supply: VDIG1 and VDIG2 input.
> +          vcc7-supply: VRTC and VBB input.
> +          vccio-supply: VIO input.
> +      tps65911:
> +          vcc1-supply: VDD1 input.
> +          vcc2-supply: VDD2 input.
> +          vcc3-supply: LDO6, LDO7 and LDO8 input.
> +          vcc4-supply: LDO5 input.
> +          vcc5-supply: LDO3 and LDO4 input.
> +          vcc6-supply: LDO1 and LDO2 input.
> +          vcc7-supply: VRTC input.
> +          vccio-supply: VIO input.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - regulators
> +
> +additionalProperties: false
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,tps65910
> +    then:
> +      properties:
> +        regulators:
> +          patternProperties:
> +            "^(ldo[1-8]|vddctrl)$": false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,tps65911
> +    then:
> +      properties:
> +        regulators:
> +          patternProperties:
> +            "^(vdd3|vaux([1-2]|33)|vdig[1-2])$": false
> +            "^(vpll|vdac|vmmc|vbb)$": false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic: tps65910@2d {

Indent by 4 here...
> +          compatible = "ti,tps65910";

And by 2 here. Be consistent (use 4).

> +          reg = <0x2d>;
> +          interrupt-parent = <&intc>;
> +          interrupts = < 0 118 0x04 >;
> +
> +          #gpio-cells = <2>;
> +          gpio-controller;
> +
> +          #interrupt-cells = <2>;
> +          interrupt-controller;
> +
> +          ti,system-power-controller;
> +
> +          ti,vmbch-threshold = <0>;
> +          ti,vmbch2-threshold = <0>;
> +          ti,en-ck32k-xtal;
> +          ti,en-gpio-sleep = <0 0 1 0 0 0 0 0 0>;
> +
> +          vcc1-supply = <&reg_parent>;
> +          vcc2-supply = <&some_reg>;
> +          vcc3-supply = <&vbat>;
> +          vcc4-supply = <&vbat>;
> +          vcc5-supply = <&vbat>;
> +          vcc6-supply = <&vbat>;
> +          vcc7-supply = <&vbat>;
> +          vccio-supply = <&vbat>;
> +
> +          regulators {
> +            vrtc_reg: vrtc {

Drop unused labels

> +              regulator-name = "vrtc";
> +              regulator-always-on;
> +            };
> +            vio_reg: vio {
> +              regulator-name = "vio";
> +              regulator-min-microvolt = <1500000>;
> +              regulator-max-microvolt = <3300000>;
> +              regulator-always-on;
> +              regulator-boot-on;
> +            };
> +            vdd1_reg: vdd1 {
> +              regulator-name = "vdd1";
> +              regulator-min-microvolt = < 600000>;
> +              regulator-max-microvolt = <1500000>;
> +              regulator-always-on;
> +              regulator-boot-on;
> +              ti,regulator-ext-sleep-control = <0>;
> +            };
> +            vdd2_reg: vdd2 {
> +              regulator-name = "vdd2";
> +              regulator-min-microvolt = < 600000>;
> +              regulator-max-microvolt = <1500000>;
> +              regulator-always-on;
> +              regulator-boot-on;
> +            };
> +            vdd3_reg: vdd3 {
> +              regulator-name = "vdd3";
> +              regulator-min-microvolt = <5000000>;
> +              regulator-max-microvolt = <5000000>;
> +              regulator-always-on;
> +            };
> +            vdig1_reg: vdig1 {
> +              regulator-name = "vdig1";
> +              regulator-min-microvolt = <1200000>;
> +              regulator-max-microvolt = <2700000>;
> +              regulator-always-on;
> +            };
> +            vdig2_reg: vdig2 {
> +              regulator-name = "vdig2";
> +              regulator-min-microvolt = <1000000>;
> +              regulator-max-microvolt = <1800000>;
> +              regulator-always-on;
> +            };
> +            vpll_reg: vpll {
> +              regulator-name = "vpll";
> +              regulator-min-microvolt = <1000000>;
> +              regulator-max-microvolt = <2500000>;
> +              regulator-always-on;
> +            };
> +            vdac_reg: vdac {
> +              regulator-name = "vdac";
> +              regulator-min-microvolt = <1800000>;
> +              regulator-max-microvolt = <2850000>;
> +              regulator-always-on;
> +            };
> +            vaux1_reg: vaux1 {
> +              regulator-name = "vaux1";
> +              regulator-min-microvolt = <1800000>;
> +              regulator-max-microvolt = <2850000>;
> +              regulator-always-on;
> +            };
> +            vaux2_reg: vaux2 {
> +              regulator-name = "vaux2";
> +              regulator-min-microvolt = <1800000>;
> +              regulator-max-microvolt = <3300000>;
> +              regulator-always-on;
> +            };
> +            vaux33_reg: vaux33 {
> +              regulator-name = "vaux33";
> +              regulator-min-microvolt = <1800000>;
> +              regulator-max-microvolt = <3300000>;
> +              regulator-always-on;
> +            };
> +            vmmc_reg: vmmc {
> +              regulator-name = "vmmc";
> +              regulator-min-microvolt = <1800000>;
> +              regulator-max-microvolt = <3300000>;
> +              regulator-always-on;
> +              regulator-boot-on;
> +            };
> +          };
> +        };
> +    };

