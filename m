Return-Path: <linux-kernel+bounces-749010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B3B148D3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E063F3BD7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7757224FA;
	Tue, 29 Jul 2025 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3lh+OBV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4421259CBB;
	Tue, 29 Jul 2025 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772369; cv=none; b=t4+pkNI/WxACZKKJHrXcFTWz+Y4nOlRtduzQbv2xfOFOoznpMf/AEfwD5KwOP6szQuL0wRFIOss/w4QWTEMLFEWFSf8F3kJ1RPizOhJ6kMKsiBDpDXuhvd/b9YB8ijSwAFePudDqTnrCfhUc3zDhGIQ6nUhr0HDd9Tw6gwqyz6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772369; c=relaxed/simple;
	bh=Uqd6tXdFD05YCUrkcoIIrl9u/Km2zMH15PBtKw3pBKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HMywA2WYm/+qH54IHAe2Qp7Ino3omTH2VJKL7S8JilvdQqSdN8AFGuUzz6tO8YXDgFWbt3V/qn7x8at6anACpB41Ng2Kg6fuyLyKN7uELQdLMRK8VvvJglxJrEqa0r5ZzUiQ6vo3AvIA272tTehOouo0Y6t4eWDhzTS357ViIE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3lh+OBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D479C4CEEF;
	Tue, 29 Jul 2025 06:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753772368;
	bh=Uqd6tXdFD05YCUrkcoIIrl9u/Km2zMH15PBtKw3pBKg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=b3lh+OBVwN52/Mc0Ta9X2DfO+ZonPD1BthoouBscrSo7Wd6J8Eu6L5EcVK34T2b7x
	 sEVTCFgKcB7GnA1t+h9ph+lSY+jIbiaUNo4o8XomspRKjtHSzaVGVU/21+0CJIuLOy
	 SOajYIGyqFusvdIS/vdiVyXxDczx3FzZy43UDs2vQ4JVUlDXFYHwcEk/8knbT/9Zre
	 F5ICqHdMzcJT3BsTBn4RK50s7CqTgVlj7JiIjXC522TzE1cfROGmoc8Dpr4pQDUv+Y
	 jb/9wjXSk8i7dqpi71bqNtFrRpX5Z+rqAK8nZCYjJ2sCMrf7NINNw1MGrDixzlKl9y
	 +sX7FK2Bc1tjQ==
Message-ID: <bbd655f4-4e3c-4808-a70f-a508714e463d@kernel.org>
Date: Tue, 29 Jul 2025 08:59:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: regulator: Add Richtek RT5133 Support
To: jeff_chang@richtek.com, lgirdwood@gmail.com, broonie@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250729064719.2810734-1-jeff_chang@richtek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250729064719.2810734-1-jeff_chang@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/07/2025 08:40, jeff_chang@richtek.com wrote:
> From: Jeff Chang <jeff_chang@richtek.com>
> 
> Add bindings for Richtek RT5133 IC Controlled PMIC
> 
> Signed-off-by: Jeff Chang <jeff_chang@richtek.com>

Subject prefix did not improve. Please read ENTIRE feedback you got at
v1, v2 and v3. I think v4 is the only one you applied.

> ---
> 
> PATCH v5
> 1. Fix Subject RT5133
> 2. Update Base regulator description.
> 3. Move richtek,oc-shutdown-all and richtek,pgb-shutdown-all to chip layer.
> 4. Update richtek,oc-shutdown-all and richtek,pgb-shutdown-all description.
> 5. Remove rt5133-ldo-supply, just using vin-supply for pvin7 and pvin8.
>    Pvin7,8 are power source for LDO7,8. Referecne is LDO1 Vout.
> 6. Using standard examples. (Node name and IRQ type)
> 
>  .../bindings/regulator/richtek,rt5133.yaml    | 176 ++++++++++++++++++
>  1 file changed, 176 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
> new file mode 100644
> index 000000000000..c12069ade224
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
> @@ -0,0 +1,176 @@
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

Still not wrapped.

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
> +  richtek,oc-shutdown-all:
> +    type: boolean
> +    description:
> +      Controls the behavior when any LDO (Low Dropout Regulator) enters an Over Current state.

Still not wrapped. Please follow Linux coding style.

> +      If set to true, all LDO channels will be shut down.
> +      If set to false (default), only the affected LDO channel will shut down itself.
> +
> +  richtek,pgb-shutdown-all:
> +    type: boolean
> +    description:
> +      Controls the behavior when any LDO enters a Power Bad state.
> +      If set to true, all LDO channels will be shut down.
> +      If set to false (default), only the affected LDO channel will shut down itself.
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
> +          Properties for the base regulator, which is the top-level supply for
> +          LDO1 to LDO6. It functions merely as an on/off switch rather than
> +          regulating voltages. If none of LDO1 to LDO6 are in use, switching off
> +          the base will reduce the quiescent current.
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
> +          vin-supply: true
> +
> +        required:
> +          - regulator-name
> +          - vin-supply
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - wakeup-source

This is surprising. If this is required, then it is implied by the
compatible. Drop it from here and from properties.

> +
> +unevaluatedProperties: false

additionalProperties instead

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      pmic@18 {
> +        compatible = "richtek,rt5133";
> +        reg = <0x18>;
> +        wakeup-source;
> +        interrupts-extended = <&gpio 0 IRQ_TYPE_EDGE_FALLING>;
> +        enable-gpios = <&gpio 2 0>;

This did not improve.

> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        richtek,oc-shutdown-all;
> +        richtek,pgb-shutdown-all;
> +        regulators {
> +          base {
> +            regulator-name = "rt5133,base";

Names do not have commas.

> +          };
> +          pvin78: ldo1 {
> +            regulator-name = "rt5133-ldo1";

Drop rt5133 prefix from every name.


Best regards,
Krzysztof

