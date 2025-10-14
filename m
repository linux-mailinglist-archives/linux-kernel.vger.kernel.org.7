Return-Path: <linux-kernel+bounces-852081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D235BD81F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE173E35C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB70430F937;
	Tue, 14 Oct 2025 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBt/V24O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A662C17A0;
	Tue, 14 Oct 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429661; cv=none; b=Y3hSyov1cCyH/O2YCHyRXWlhZ/4sXzlLjp8KNrbyjGYj2Tl9zTNkSqjQv1Y/KUHjUg6t/aKiBXbp7UayApr9TDtUr7Mg/X59xo1R4HHJp/D4UNsV0DhqzyLOA0pXFHmNDlUq2nO+3qKVgCPL/fDXdO8FtpjUgt2QQvRT5dUUsAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429661; c=relaxed/simple;
	bh=z2DN9ODEs6QSr+GMW5CD+V+08jJFW5L1TjfvhVuUV6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpFvxd3knZAi9NLYRB/4KvNM/YXo2wIVZCLdcmC1cxgcXOXvD0uDKO0KrIDummP3ZCY85Gy5aQwTqccjnNFZ4uprgwW4rpdUvoYlK9HJh8FzUy69ganw5JRYLqSL9Zra3jqBAkuS137K6+AjBfVyiq/NeX0Mfh0oIXB2hI5lagM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBt/V24O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39512C4CEFE;
	Tue, 14 Oct 2025 08:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760429661;
	bh=z2DN9ODEs6QSr+GMW5CD+V+08jJFW5L1TjfvhVuUV6U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XBt/V24Ou4i7Ib2gApUrt1YIqwP+jrG6QMhN0IgQmkEPBu/Tk8PGvyynNHiQYnSkf
	 dt7kbj+PZ16PY49Bsx9icvGWSmIks5DdmNW0yZlGrsg/eKYAyd0gwjoXoaWBc76gwi
	 vHS6s/uUzsk6FP2mabHQLPPRcNXeuu4r6o+/pOfl68dP0tnj1SBrK6Bs/QgWhnCcpT
	 myU03oSfSNNwjiiRX2f2qvRXKw7+5DKP0RVxuSLskC0pejbPZyDlI8yhSDGXyXmTqY
	 NeIu7U22QGCi4nEcQmGOvf1mudgVO4gUqAJMF/27J0hmC/20K1W3FmakU9+EkxiAU7
	 ffsyveXhGXVkA==
Message-ID: <512ffe3d-5ab3-4e87-afd2-46f0005a8d17@kernel.org>
Date: Tue, 14 Oct 2025 10:14:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] dt-bindings: regulator: Add MAX77675 regulator
 binding
To: Joan-Na-adi <joan.na.devcode@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>
References: <20251014053142.15835-1-joan.na@analog.com>
 <20251014053142.15835-4-joan.na@analog.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251014053142.15835-4-joan.na@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/10/2025 07:31, Joan-Na-adi wrote:
> From: Joan Na <joan.na@analog.com>
> 
> Add device tree binding YAML schema for the Maxim MAX77675 PMIC regulator.
> This defines the node properties and supported regulator names for use
> in device tree sources.

A nit, subject: drop second/last, redundant "binding". The "dt-bindings"
prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> 
> Fixed:
> - Missing explanation of `maxim,fps-slot` default value
> - Updated DT binding enums to use string values (e.g., "low", "high") instead of integers
> - Converted several binary properties to boolean type
> - Renamed time-based properties to use standard unit suffixes (e.g., "-sec", "-us")
> - Added default values for properties


Probably you wanted a changelog? Changelog goes to --- with details
against EACH version. Please start using b4 if canonical patch format is
tricky. b4 would help.

> 
> Signed-off-by: Joan Na <joan.na@analog.com>
> ---
>  .../bindings/regulator/maxim,max77675.yaml    | 205 ++++++++++++++++++
>  1 file changed, 205 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
> new file mode 100644
> index 000000000000..6be29eced039
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
> @@ -0,0 +1,205 @@
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
> +  (SBB0–SBB3), accessible via I2C. Each SBB can be configured individually
> +  in the Device Tree. Additional PMIC settings can be configured through
> +  device-specific properties.
> +  Users should use the macros from dt-bindings/regulator/maxim,max77675-regulator.h
> +
> +allOf:
> +  - $ref: regulator.yaml#
> +
> +properties:
> +  compatible:
> +    const: maxim,max77675

Please organize the patch documenting compatible (DT bindings) before
their user.
See also:
https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

> +
> +  reg:
> +    maxItems: 1
> +
> +  maxim,en-mode:
> +    description: |
> +      Enable mode configuration.
> +      "push-button"  - Push button
> +      "slide-switch" - Slide switch
> +      "logic" - Logic mode

You just repeat the name in the description. Say something useful.

> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: ["push-button", "slide-switch", "logic"]
> +    default: "slide-switch"
> +
> +  maxim,latency-mode:
> +    description: |
> +      Latency mode for voltage transition:
> +      "high" - High latency (100μs)
> +      "low"  - Low latency (10μs)

So use values 100 or 10, and proper type (-us)


> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: ["high", "low"]
> +    default: "high"
> +
> +  maxim,drv-sbb-strength:
> +    description: |
> +      SIMO Buck-Boost Drive Strength Trim.
> +      Controls the drive strength of the SIMO regulator's power MOSFETs.
> +      This setting affects the switching speed, which impacts power efficiency and EMI.
> +      "max"  – Maximum drive strength (~0.6 ns transition time)
> +      "high" – High drive strength (~1.2 ns transition time)
> +      "low"  – Low drive strength (~1.8 ns transition time)
> +      "min"  – Minimum drive strength (~8 ns transition time)
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: ["max", "high", "low", "min"]
> +    default: "max"
> +
> +  maxim,dvs-slew-rate-mv-per-us:

... like here.

> +    description: |
> +      Dynamic rising slew rate for output voltage transitions, in mV/μs.

Except you said mv/us, not us. Confusing.

> +      This setting is only used when 'maxim,fixed-slew-rate' is not present.
> +    enum: [5, 10]
> +    default: 5
> +
> +  maxim,en-debounce-time-us:
> +    description: |
> +      Debounce time for the enable pin, in microseconds
> +    enum: [100, 30000]
> +    default: 100
> +
> +  maxim,manual-reset-time-sec:
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Manual reset time in seconds:
> +    enum: [4, 8, 12, 16]
> +    default: 4
> +
> +  maxim,en-pullup-disable:
> +    type: boolean
> +    description: |
> +      Disable internal pull-up for EN pin.
> +      When set, the internal pull-up is disabled.
> +      Defaults to enabled if this property is not specified.

This and maybe few more properties look like pinctrl bindings. Maybe
properties from pincfg are applicable?

> +    default: false
> +
> +  maxim,bias-low-power-request:
> +    type: boolean
> +    description: |
> +      Request low-power bias mode.
> +      When set, the device enters low-power bias mode.
> +      Defaults to normal bias mode if this property is not specified.
> +    default: false
> +
> +  maxim,simo-int-ldo-always-on:
> +    type: boolean
> +    description: |
> +      Set internal LDO to always supply 1.8V
> +      When set, the internal LDO always supplies 1.8V.
> +      By default, the SIMO internal channel supplies 1.8V during low-power mode
> +    default: false
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

That's not property of regulators. Totally messed indentation.


> +        description: |
> +          FPS (Flexible Power Sequencer) slot selection.
> +          The Flexible Power Sequencer allows resources to power up under hardware or software control.
> +          Additionally, each resource can power up independently or among a group of other regulators
> +          with adjustable power-up and power-down slots.
> +          This device's regulators provide an additional property to configure the FPS parameters,
> +          allowing each regulator to be assigned to an FPS slot for proper power management control.
> +          "slot0"   - Assign to FPS Slot 0
> +          "slot1"   - Assign to FPS Slot 1
> +          "slot2"   - Assign to FPS Slot 2
> +          "slot3"   - Assign to FPS Slot 3
> +          "default" - Use the default FPS slot value stored in OTP and read from the register
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum: ["slot0", "slot1", "slot2", "slot3", "default"]
> +        default: default
> +
> +      maxim,fixed-slew-rate:
> +        type: boolean
> +        description: |
> +          Use fixed slew rate of 2 mV/μs for output voltage transitions.
> +          When this property is present, the device uses a constant 2 mV/μs slew rate
> +          and ignores any dynamic slew rate configuration.
> +          When absent, the device uses the dynamic slew rate specified
> +          by 'maxim,dvs-slew-rate-mv-per-us'
> +        default: true
> +
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
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      max77675: pmic@44 {
> +        compatible = "maxim,max77675";
> +        reg = <0x44>;
> +
> +        maxim,en-mode = "slide-switch";
> +        maxim,latency-mode = "high";
> +        maxim,drv-sbb-strength = "max";
> +        maxim,dvs-slew-rate-mv-per-us = <5>;
> +        maxim,manual-reset-time-sec = <4>;
> +        maxim,en-debounce-time-us = <100>;
> +
> +        regulators {
> +          sbb0: sbb0 {
> +            regulator-name = "sbb0";
> +            regulator-min-microvolt = <500000>;
> +            regulator-max-microvolt = <5500000>;
> +            maxim,fps-slot = "default";

I don't think this was tested.


Best regards,
Krzysztof

