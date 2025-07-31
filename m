Return-Path: <linux-kernel+bounces-752455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F40BB175C1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC9D5803E7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A68F268FF1;
	Thu, 31 Jul 2025 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6OTR0vG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223F1C5F06;
	Thu, 31 Jul 2025 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753983723; cv=none; b=l0Y80jNS8ZncUy09yHXF5nIi7DGpENsDgY9iDevK9zvNDAsrdOUcLSz0kJxEQLrlOit/qZA+1j8XoSOzjqUHlCburD0ycN0idK515qrnnS5vrytn3uw/J90xC1a+HQA/PLOEF1dtKSTj2yMsPT6BWOXUIj6IjS/hJ+vpbaCsSCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753983723; c=relaxed/simple;
	bh=DOEjPRA2MgCwVcAX8nCWOwTlHqRodzpZ9gS+A8XgiM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ok1QkXltB/GLelrkynVZKIHkKrHxCB0V84OKd+/vivtYM8UT6r1mRcxgZkP53ovCsquQTTafzeJfN9XQaTvCxLDev+aDgWfHmLLAt5QZbtQvFnE2N7dnxtYTJAdERlAbDc1+foYeb5qzw/uew6VcyU+NE7ZdQ5vu620ycRz6Gik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6OTR0vG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDF6C4CEEF;
	Thu, 31 Jul 2025 17:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753983723;
	bh=DOEjPRA2MgCwVcAX8nCWOwTlHqRodzpZ9gS+A8XgiM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6OTR0vGCieHQ2Xl3R5A7G8OZ3bRlNPxC5NxxjqmYZDt5lxXxbNVB81yeHhkwG/0A
	 +hnH520zgQgiYUSD/AS8yUsHYDPHQsyIvCgRd6kCd/kFgCpWGbM1ReSkNSZcrQugyP
	 YTrbtBX98KsJVtKRMzNQIXNQIcoHsT+rsE04L98OBuoKTa3rZxJ7aGYTclJzTAJGtg
	 x2ULMVR499zaU2No33p5v2X9EZ989LpSKU+Ru30zq6VCAui5c0NRAcS9xsqtHERk8w
	 aEEVwZH+lOZh2/xS23rDg3rM1X6AMsYrecuJznecogrYKDVfdR3aNiPBmYulfsuH/G
	 R5vWnoG5YGfFw==
Date: Thu, 31 Jul 2025 12:42:01 -0500
From: Rob Herring <robh@kernel.org>
To: Joy Zou <joy.zou@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: regulator: add PF0900 regulator yaml
Message-ID: <20250731174201.GA2270846-robh@kernel.org>
References: <20250731-b4-pf09-v2-v3-0-4c2659516582@nxp.com>
 <20250731-b4-pf09-v2-v3-1-4c2659516582@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-b4-pf09-v2-v3-1-4c2659516582@nxp.com>

On Thu, Jul 31, 2025 at 06:44:41PM +0800, Joy Zou wrote:
> Add device binding doc for PF0900 PMIC driver.
> 
> Can not get the I2C_CRC_EN config by reading register. If the PMIC
> OTP_I2C_CRC_EN is enable, need to add the nxp,i2c-crc-enable property.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes for v3:
> 1. change regulator node names into lowercase.
> 2. add the following description for nxp,i2c-crc-enable.
>    The CRC enabled during register read/write. Controlled by customer
>    unviewable fuse bits OTP_I2C_CRC_EN. Check chip part number.
>    So can not get the I2C_CRC_EN config by reading register.
>    If the PMIC OTP_I2C_CRC_EN is enable, need to add this
>    property.
> 3. add more nxp,i2c-crc-enable description for commit message.
> 4. remove the unnecessary nxp,dvs-run/standby-voltage.
>    These changes come from review comments:
>    https://lore.kernel.org/imx/e9f38e38-7df7-4d19-b5c0-2f18aeebcc78@kernel.org/
> 5. add regulator-state-mem property for example.
> 
> Changes for v2:
> 1. modify the binding file name to match compatible string.
> 2. add one space for dt_binding_check warning.
> 3. remove unnecessary quotes from "VAON".
> 4. remove the unnecessary empty line.
> 5. move unevaluatedProperties after the $ref.
> 6. move additionalProperties after regulator type.
> 7. remove unnecessary regulator description
> ---
>  .../devicetree/bindings/regulator/nxp,pf0900.yaml  | 163 +++++++++++++++++++++
>  1 file changed, 163 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pf0900.yaml b/Documentation/devicetree/bindings/regulator/nxp,pf0900.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..8c8fc2cd4cedb0bef220d73f5cbc9a5f83072608
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pf0900.yaml
> @@ -0,0 +1,163 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/nxp,pf0900.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP PF0900 Power Management Integrated Circuit regulators
> +
> +maintainers:
> +  - Joy Zou <joy.zou@nxp.com>
> +
> +description:
> +  The PF0900 is a power management integrated circuit (PMIC) optimized
> +  for high performance i.MX9x based applications. It features five high
> +  efficiency buck converters, three linear and one vaon regulators. It
> +  provides low quiescent current in Standby and low power off Modes.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,pf0900
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  regulators:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      vaon:
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +    patternProperties:
> +      "^ldo[1-3]$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +      "^sw[1-5]$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +
> +  nxp,i2c-crc-enable:
> +    type: boolean
> +    description:
> +      The CRC enabled during register read/write. Controlled by customer
> +      unviewable fuse bits OTP_I2C_CRC_EN. Check chip part number.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic@8 {
> +            compatible = "nxp,pf0900";
> +            reg = <0x08>;
> +            interrupt-parent = <&pcal6524>;
> +            interrupts = <89 IRQ_TYPE_LEVEL_LOW>;
> +            nxp,i2c-crc-enable;
> +
> +            regulators {
> +                vaon {
> +                    regulator-name = "VAON";
> +                    regulator-min-microvolt = <1800000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                sw1 {
> +                    regulator-name = "SW1";
> +                    regulator-min-microvolt = <500000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                    regulator-ramp-delay = <1950>;
> +                    regulator-state-mem {
> +                        regulator-on-in-suspend;
> +                        regulator-suspend-max-microvolt = <650000>;
> +                        regulator-suspend-min-microvolt = <650000>;
> +                    };
> +                };
> +
> +                sw2 {
> +                    regulator-name = "SW2";
> +                    regulator-min-microvolt = <300000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                    regulator-ramp-delay = <1950>;
> +                };
> +
> +                sw3 {
> +                    regulator-name = "SW3";
> +                    regulator-min-microvolt = <300000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                    regulator-ramp-delay = <1950>;
> +                };
> +
> +                sw4 {
> +                    regulator-name = "SW4";
> +                    regulator-min-microvolt = <300000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                    regulator-ramp-delay = <1950>;
> +                };
> +
> +                sw5 {
> +                    regulator-name = "SW5";
> +                    regulator-min-microvolt = <300000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                    regulator-ramp-delay = <1950>;
> +                };
> +
> +                ldo1 {
> +                    regulator-name = "LDO1";
> +                    regulator-min-microvolt = <750000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                ldo2 {
> +                    regulator-name = "LDO2";
> +                    regulator-min-microvolt = <650000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +
> +                ldo3 {
> +                    regulator-name = "LDO3";
> +                    regulator-min-microvolt = <650000>;
> +                    regulator-max-microvolt = <3300000>;
> +                    regulator-boot-on;
> +                    regulator-always-on;
> +                };
> +            };
> +        };
> +     };

Wrong indentation. Otherwise,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Rob

