Return-Path: <linux-kernel+bounces-740524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DAEB0D53E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7011696EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033112C3242;
	Tue, 22 Jul 2025 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5Sp5GIs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D632DAFC5;
	Tue, 22 Jul 2025 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175096; cv=none; b=fzyNRi7o18vCBXEjVubEwaFUUFL58oM6zcVQrowzDo5FQpJKeZxIGDyfWIwET9VWFzEXp0alY6X68Hrz3mSd08lJP/W86T+EHq9/JCVSeN4jmEPi8Y58bTfRE2Tq2JZI0E38wHJFbOLJNYbl0CSUErQRIxvlOupMPeDC0DrS3JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175096; c=relaxed/simple;
	bh=5a3qmKtFanuttcsG8G7/hPPyMdc+1UznbE0m5pJOyuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kwn/lN4rBaLI592V5ecDJWe/1HWhPWPI97yx2fzW5LoqGLhpFIlOsxBW23MVTr9DzJTs9MX5FtbwCcBOTyraUtD/hRpJFrwEqLFrGgAmlr6tNGW2nE9Ad12Iw59DEuu8LaY2NTAym/89kBDQgAn4tmBy7vlEloiGKNZBZYj720M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5Sp5GIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4EFC4CEF4;
	Tue, 22 Jul 2025 09:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753175095;
	bh=5a3qmKtFanuttcsG8G7/hPPyMdc+1UznbE0m5pJOyuE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=D5Sp5GIs+vvmCirZ9FZ7MznRLxrxx/6/weDkhXt0CxVY1V8ztf70fY9q9Psk5ClQT
	 yrjoEcP0ck5xRXNIyHFYZBwI6x1Z3QqHG5SD21wkjC8Iw/sJPEyYp+Ecf/9A7UA2pG
	 OyCgpntGFkJkqVlRwrDVsHfPq4GC2QYWZcd3al5k4tsYgTP2Zn/d8Z27535bEIYXL4
	 A7PpyW1ti8YhnB/7iPB/tRH0FwtsBoR9I6qmHYkzwxU89fdo3gBKazvPx2f7zUad8c
	 Dkv5ua94XijNnce3P+9lVMgHBfGLil9GdDN099CsgsOipnkHR63Qhw5wXxfd6hfh7X
	 8LaenmXvmzg+g==
Message-ID: <f4505b19-3496-4fab-ad74-d190d847eb17@kernel.org>
Date: Tue, 22 Jul 2025 11:04:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: regulator: Add Richtek RTR5133
 Support
To: jeff_chang@richtek.com, lgirdwood@gmail.com, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250722083543.2730796-1-jeff_chang@richtek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250722083543.2730796-1-jeff_chang@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2025 10:34, jeff_chang@richtek.com wrote:
> From: Jeff Chang <jeff_chang@richtek.com>
> 
> Add bindings for Richtek RT5133 IC Controlled PMIC

Subject - RTR or RT? Google tells me nothing about RTR.

> 
> Signed-off-by: Jeff Chang <jeff_chang@richtek.com>
> ---
> 
> PATCH v4
> 1. Add commit message and also /script/checkpatch --strict to fix warning.
> 2. Using subject prefixes matching dt-binding subsystem.
> 3. Re-order patches. DT patch before driver patch.
> 4. Fix description of yaml.
> 5. Add more description for base regulator.
> 6. Drop regulator-compatible proeprty.
> 7. Add prefix for vendor property richtek,oc-shutdown-all and richtek,pgb-shutdown-all.
> 8. Add more description for shutdown-all property.
> 9. Interrupts-extended -> interrupts.
> 10. pio->gpio for proper defines.
> 11. Drop unused labels. Keep rt5133_ldo1 label for ldo7 and ldo8.
> 
>  .../bindings/regulator/richtek,rt5133.yaml    | 175 ++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
> new file mode 100644
> index 000000000000..0da725596a87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
> @@ -0,0 +1,175 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/richtek,rt5133.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT5133 PMIC Regulator
> +
> +maintainers:
> +  - ShihChia Chang <jeff_chang@richtek.com>
> +
> +description:
> +  The RT5133 is an integrated Power Management IC for portable devices, featuring
> +  8 LDOs and 3 GPOs. It allows programmable output voltages, soft-start times,
> +  and protections via I2C. GPO operation depends on LDO1 voltage.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - richtek,rt5133
> +
> +  reg:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    maxItems: 1
> +
> +  wakeup-source: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  regulators:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      base:
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          Properties for base regulator which control force-off base circuit.
> +          Base circuit is the power source for LDO1~LDO6. Disabling it will
> +          reduce IQ for Chip.

I don't understand what this regulator is for. Your example is also
incomplete - missing min/max constraints like voltage.

Explain, what is this output pin? I already asked for explanations. I
have diagram in front of me, so explain precisely instead of sending THE
SAME again - which pin is it?

Also, what is IQ? Except Intelligence Quotient?


> +
> +        properties:
> +          richtek,oc-shutdown-all:
> +            type: boolean
> +            description:
> +              Anyone of LDO is in OC state, shut down all channels to protect CHIP.
> +              Without this property, only shut down the OC LDO channel.

I don't understand this. I also do not understand why this is property
of "base" not the chip itself...

So don't send next version with the same.

> +
> +          richtek,pgb-shutdown-all:
> +            type: boolean
> +            description:
> +              Anyone of LDO is in PGB state, shut down all channels to protect CHIP.

CHIP is an acronym? Or chip?

> +              Without this property, only shut down the PGB LDO channel.
> +
> +        required:
> +          - regulator-name
> +
> +    patternProperties:
> +      "^ldo([1-6])$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          Properties for single LDO regulator
> +
> +        required:
> +          - regulator-name
> +
> +      "^ldo([7-8])$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          Properties for single LDO regulator
> +
> +        properties:
> +          rt5133-ldo1-supply:

supplies do not have vendor prefixes.

> +            description: |
> +              Only for ldo7 ldo8, pvin7 and pvin8 reference design are RT5133 ldo1.
> +              If not connect to ldo1 vout, this property for pvin7 and pvin8 is necessary.

I don't understand why LDO1 supply is here.

Again, which pin is it?

> +
> +        required:
> +          - regulator-name
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - wakeup-source
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      rt5133@18 {

Nothing improved.

> +        compatible = "richtek,rt5133";
> +        reg = <0x18>;
> +        wakeup-source;
> +        interrupts-extended = <&gpio 187 0x0>;

Nothing improved

Implement previous comments and respond to each of them to confirm you
understood them.

> 


Best regards,
Krzysztof

