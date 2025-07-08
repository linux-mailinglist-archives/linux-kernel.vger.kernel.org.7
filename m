Return-Path: <linux-kernel+bounces-722257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ADAAFD707
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32D417D576
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8187D2E5413;
	Tue,  8 Jul 2025 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w8Q3ZBuu"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9081DE2A7;
	Tue,  8 Jul 2025 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752002482; cv=none; b=A9xakzbW9719lOlhw1bCPHceKAcrxh7YCLuMXeAYc4bx7NN78bU6vplt6TBzdCSocGi8HZRrWzuw/l+pmTUNAxjqpQTCW4hguY840qrDf+nN1pjSg2IiEVh50EnSsnfqaZfCPLinFDOEIfxfOSEIXS8qg9Fw560QKtDp3OZvcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752002482; c=relaxed/simple;
	bh=59aNncXnPlbNSy/pko/z0V4akGqnNneemlCM5SWgjk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FPNve8+iPh/b7mozpMIrOCP+UOzKuVu+Fxez1gQkNaujRm9peAbZ+dmpWXtgomlnLWcORWYWTWLY/gidb5l4ZkqzqeeEqF8/w5SeRwBGjUVr1kS3D8DzbWTHMmuAB06z17wzjwNOlEkTxA/GPLUrnAlYVsFrQgs2tqX7wWnjgWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w8Q3ZBuu; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 568JL9de600568;
	Tue, 8 Jul 2025 14:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1752002469;
	bh=Nmgh09nutpZxP1wXRfH6vIZbv4tye4dLHW5T27eTx9Q=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=w8Q3ZBuuG+ZvXIwSauz+iDR22G6YIiBNiDJAyNWOTSR06pyX0fbSqvfVWyJuOF9p4
	 RlsAno7qiurAtFiJ6kZsLxydfPRbvEFy0rZuvElVxm8q4JL2/DneeHiorNhx3quDLz
	 /37U6bFLXtzVAALbeVVLMNfikksgqFNmtGdcL+KE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 568JL9C51732317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 8 Jul 2025 14:21:09 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 8
 Jul 2025 14:21:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 8 Jul 2025 14:21:09 -0500
Received: from [128.247.29.251] (dmz007xyy.dhcp.ti.com [128.247.29.251])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 568JL9Bd2607953;
	Tue, 8 Jul 2025 14:21:09 -0500
Message-ID: <4210f35d-e3ac-43cb-9e6d-e67c25b62c57@ti.com>
Date: Tue, 8 Jul 2025 14:21:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: dt-bindings: Convert TPS65910 to DT schema
To: Rob Herring <robh@kernel.org>
CC: <lee@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <praneeth@ti.com>, <m-leonard@ti.com>, <rklein@nvidia.com>
References: <20250702220217.155647-1-s-ramamoorthy@ti.com>
 <20250708165827.GA607073-robh@kernel.org>
Content-Language: en-US
From: Shree Ramamoorthy <s-ramamoorthy@ti.com>
Organization: PMIC
In-Reply-To: <20250708165827.GA607073-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea


On 7/8/25 11:58 AM, Rob Herring wrote:
> On Wed, Jul 02, 2025 at 05:02:17PM -0500, Shree Ramamoorthy wrote:
>> Convert the TI TPS65910 documentation to DT schema format.
>>
>> Fix incorrect I2C address in example: should be 0x2d.
>>
>> TPS65910 datasheet: https://www.ti.com/lit/gpn/tps65910
>>
>> Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
>> ---
>>   .../devicetree/bindings/mfd/ti,tps65910.yaml  | 333 ++++++++++++++++++
>>   .../devicetree/bindings/mfd/tps65910.txt      | 205 -----------
>>   2 files changed, 333 insertions(+), 205 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps65910.yaml
>>   delete mode 100644 Documentation/devicetree/bindings/mfd/tps65910.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ti,tps65910.yaml b/Documentation/devicetree/bindings/mfd/ti,tps65910.yaml
>> new file mode 100644
>> index 000000000000..789b3c6d89cd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/ti,tps65910.yaml
>> @@ -0,0 +1,333 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/ti,tps65910.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI TPS65910 Power Management Integrated Circuit
>> +
>> +maintainers:
>> +  - Shree Ramamoorthy <s-ramamoorthy@ti.com>
>> +
>> +description:
>> +  TPS65910 device is a Power Management IC that provides 3 step-down converters,
>> +  1 stepup converter, and 8 LDOs. The device contains an embedded power controller (EPC),
>> +  1 GPIO, and an RTC.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,tps65910
>> +      - ti,tps65911
>> +
>> +  reg:
>> +    description: I2C slave address
>> +    maxItems: 1
>> +
>> +  gpio-controller: true
>> +
>> +  '#gpio-cells':
>> +    const: 2
>> +    description: |
>> +      The first cell is the GPIO number.
>> +      The second cell is used to specify additional options <unused>.
>> +      See ../gpio/gpio.txt for more information.
> Don't add references to old docs. Or new ones, just drop the last line.
>
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-controller: true
>> +
>> +  '#interrupt-cells':
>> +    description: Specifies the IRQ number and flags, as defined in
>> +      Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> Drop the reference.
>
>> +    const: 2
>> +
>> +  ti,vmbch-threshold:
>> +    description: |
>> +      (TPS65911) Main battery charged threshold comparator.
>> +      See VMBCH_VSEL in TPS65910 datasheet.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> Doesn't look like an array to me...
>
>> +    minItems: 1
>> +    maxItems: 1
>> +    items:
>> +      minimum: 0
> 0 is already the min.
>
>> +      maximum: 3
>> +
>> +  ti,vmbch2-threshold:
>> +    description: |
>> +      (TPS65911) Main battery discharged threshold comparator.
>> +      See VMBCH_VSEL in TPS65910 datasheet.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 1
>> +    maxItems: 1
>> +    items:
>> +      minimum: 0
>> +      maximum: 3
> Same comments here.
>
>> +
>> +  ti,en-ck32k-xtal:
>> +    type: boolean
>> +    description: Enable external 32-kHz crystal oscillator.
>> +
>> +  ti,en-gpio-sleep:
>> +    description: |
>> +      Enable sleep control for gpios.
>> +      There should be 9 entries here, one for each gpio.
> Don't repeat constraints in free form text.
>
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    minItems: 9
>> +    maxItems: 9
>> +    items:
>> +      minimum: 0
>> +      maximum: 1
>> +
>> +  ti,system-power-controller:
>> +    type: boolean
>> +    description: Identify whether or not this pmic controls the system power
>> +
>> +  ti,sleep-enable:
>> +    type: boolean
>> +    description: Enable SLEEP state.
>> +
>> +  ti,sleep-keep-therm:
>> +    type: boolean
>> +    description: Keep thermal monitoring on in sleep state.
>> +
>> +  ti,sleep-keep-ck32k:
>> +    type: boolean
>> +    description: Keep the 32KHz clock output on in sleep state.
>> +
>> +  ti,sleep-keep-hsclk:
>> +    type: boolean
>> +    description: Keep high speed internal clock on in sleep state.
>> +
>> +  regulators:
>> +    type: object
>> +    description: List of regulators provided by this controller.
>> +
>> +    patternProperties:
>> +      "^(vrtc|vio|vpll|vdac|vmmc|vbb|vddctrl)$":
>> +        type: object
>> +        $ref: /schemas/regulator/regulator.yaml#
>> +        properties:
>> +          ti,regulator-ext-sleep-control:
>> +            description: |
>> +              Enable external sleep control through external inputs:
>> +              [0 (not enabled), 1 (EN1), 2 (EN2) or 4(EN3)].
>> +              If this property is not defined, it defaults to 0 (not enabled).
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            enum: [0, 1, 2, 4, 8]
>> +        unevaluatedProperties: true
> false
>
>> +
>> +      "^(vdd[1-3]|vaux([1-2]|33)|vdig[1-2])$":
>> +        type: object
>> +        $ref: /schemas/regulator/regulator.yaml#
>> +        properties:
>> +          ti,regulator-ext-sleep-control:
>> +            description: |
>> +              Enable external sleep control through external inputs:
>> +              [0 (not enabled), 1 (EN1), 2 (EN2) or 4(EN3)].
>> +              If this property is not defined, it defaults to 0 (not enabled).
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            enum: [0, 1, 2, 4, 8]
>> +        unevaluatedProperties: true
> false
>
>> +
>> +      "^ldo[1-8]$":
>> +        type: object
>> +        $ref: /schemas/regulator/regulator.yaml#
>> +        properties:
>> +          ti,regulator-ext-sleep-control:
>> +            description: |
>> +              Enable external sleep control through external inputs:
>> +              [0 (not enabled), 1 (EN1), 2 (EN2) or 4(EN3)].
>> +              If this property is not defined, it defaults to 0 (not enabled).
>> +            $ref: /schemas/types.yaml#/definitions/uint32
>> +            enum: [0, 1, 2, 4, 8]
>> +        unevaluatedProperties: true
>> +
>> +    additionalProperties: true
> false
>
> And move above patternProperties
>
>
>> +
>> +patternProperties:
>> +  "^(vcc[1-7]-supply)|vccio-supply$":
> ^vcc(io|[1-7])-supply$
>
>> +    description: |
>> +      Input voltage supply phandle for regulators.
>> +      These entries are required if PMIC regulators are enabled, or else it
>> +      can cause the regulator registration to fail.
> blank line between paragraphs.
>
>> +      If some input supply is powered through battery or always-on supply, then
>> +      it is also required to have these parameters with the proper node handle for always-on
>> +      power supply.
>> +      tps65910:
>> +          vcc1-supply: VDD1 input.
>> +          vcc2-supply: VDD2 input.
>> +          vcc3-supply: VAUX33 and VMMC input.
>> +          vcc4-supply: VAUX1 and VAUX2 input.
>> +          vcc5-supply: VPLL and VDAC input.
>> +          vcc6-supply: VDIG1 and VDIG2 input.
>> +          vcc7-supply: VRTC and VBB input.
>> +          vccio-supply: VIO input.
>> +      tps65911:
>> +          vcc1-supply: VDD1 input.
>> +          vcc2-supply: VDD2 input.
>> +          vcc3-supply: LDO6, LDO7 and LDO8 input.
>> +          vcc4-supply: LDO5 input.
>> +          vcc5-supply: LDO3 and LDO4 input.
>> +          vcc6-supply: LDO1 and LDO2 input.
>> +          vcc7-supply: VRTC input.
>> +          vccio-supply: VIO input.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - interrupt-controller
>> +  - '#interrupt-cells'
>> +  - gpio-controller
>> +  - '#gpio-cells'
>> +  - regulators
>> +
>> +additionalProperties: false
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - ti,tps65910
>> +    then:
>> +      properties:
>> +        regulators:
>> +          patternProperties:
>> +            "^(ldo[1-8]|vddctrl)$": false
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - ti,tps65911
>> +    then:
>> +      properties:
>> +        regulators:
>> +          patternProperties:
>> +            "^(vdd3|vaux([1-2]|33)|vdig[1-2])$": false
>> +            "^(vpll|vdac|vmmc|vbb)$": false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        pmic: tps65910@2d {
> Indent by 4 here...
>> +          compatible = "ti,tps65910";
> And by 2 here. Be consistent (use 4).
>
>> +          reg = <0x2d>;
>> +          interrupt-parent = <&intc>;
>> +          interrupts = < 0 118 0x04 >;
>> +
>> +          #gpio-cells = <2>;
>> +          gpio-controller;
>> +
>> +          #interrupt-cells = <2>;
>> +          interrupt-controller;
>> +
>> +          ti,system-power-controller;
>> +
>> +          ti,vmbch-threshold = <0>;
>> +          ti,vmbch2-threshold = <0>;
>> +          ti,en-ck32k-xtal;
>> +          ti,en-gpio-sleep = <0 0 1 0 0 0 0 0 0>;
>> +
>> +          vcc1-supply = <&reg_parent>;
>> +          vcc2-supply = <&some_reg>;
>> +          vcc3-supply = <&vbat>;
>> +          vcc4-supply = <&vbat>;
>> +          vcc5-supply = <&vbat>;
>> +          vcc6-supply = <&vbat>;
>> +          vcc7-supply = <&vbat>;
>> +          vccio-supply = <&vbat>;
>> +
>> +          regulators {
>> +            vrtc_reg: vrtc {
> Drop unused labels

Will update this series, thank you for your feedback!

>
>> +              regulator-name = "vrtc";
>> +              regulator-always-on;
>> +            };
>> +            vio_reg: vio {
>> +              regulator-name = "vio";
>> +              regulator-min-microvolt = <1500000>;
>> +              regulator-max-microvolt = <3300000>;
>> +              regulator-always-on;
>> +              regulator-boot-on;
>> +            };
>> +            vdd1_reg: vdd1 {
>> +              regulator-name = "vdd1";
>> +              regulator-min-microvolt = < 600000>;
>> +              regulator-max-microvolt = <1500000>;
>> +              regulator-always-on;
>> +              regulator-boot-on;
>> +              ti,regulator-ext-sleep-control = <0>;
>> +            };
>> +            vdd2_reg: vdd2 {
>> +              regulator-name = "vdd2";
>> +              regulator-min-microvolt = < 600000>;
>> +              regulator-max-microvolt = <1500000>;
>> +              regulator-always-on;
>> +              regulator-boot-on;
>> +            };
>> +            vdd3_reg: vdd3 {
>> +              regulator-name = "vdd3";
>> +              regulator-min-microvolt = <5000000>;
>> +              regulator-max-microvolt = <5000000>;
>> +              regulator-always-on;
>> +            };
>> +            vdig1_reg: vdig1 {
>> +              regulator-name = "vdig1";
>> +              regulator-min-microvolt = <1200000>;
>> +              regulator-max-microvolt = <2700000>;
>> +              regulator-always-on;
>> +            };
>> +            vdig2_reg: vdig2 {
>> +              regulator-name = "vdig2";
>> +              regulator-min-microvolt = <1000000>;
>> +              regulator-max-microvolt = <1800000>;
>> +              regulator-always-on;
>> +            };
>> +            vpll_reg: vpll {
>> +              regulator-name = "vpll";
>> +              regulator-min-microvolt = <1000000>;
>> +              regulator-max-microvolt = <2500000>;
>> +              regulator-always-on;
>> +            };
>> +            vdac_reg: vdac {
>> +              regulator-name = "vdac";
>> +              regulator-min-microvolt = <1800000>;
>> +              regulator-max-microvolt = <2850000>;
>> +              regulator-always-on;
>> +            };
>> +            vaux1_reg: vaux1 {
>> +              regulator-name = "vaux1";
>> +              regulator-min-microvolt = <1800000>;
>> +              regulator-max-microvolt = <2850000>;
>> +              regulator-always-on;
>> +            };
>> +            vaux2_reg: vaux2 {
>> +              regulator-name = "vaux2";
>> +              regulator-min-microvolt = <1800000>;
>> +              regulator-max-microvolt = <3300000>;
>> +              regulator-always-on;
>> +            };
>> +            vaux33_reg: vaux33 {
>> +              regulator-name = "vaux33";
>> +              regulator-min-microvolt = <1800000>;
>> +              regulator-max-microvolt = <3300000>;
>> +              regulator-always-on;
>> +            };
>> +            vmmc_reg: vmmc {
>> +              regulator-name = "vmmc";
>> +              regulator-min-microvolt = <1800000>;
>> +              regulator-max-microvolt = <3300000>;
>> +              regulator-always-on;
>> +              regulator-boot-on;
>> +            };
>> +          };
>> +        };
>> +    };

-- 
Best,
Shree Ramamoorthy
PMIC Software Engineer


