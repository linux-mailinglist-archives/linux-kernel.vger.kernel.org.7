Return-Path: <linux-kernel+bounces-738864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A29EFB0BE64
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E15917C774
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E41F285C8D;
	Mon, 21 Jul 2025 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7N5W7ta"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BEE283FF9;
	Mon, 21 Jul 2025 08:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085085; cv=none; b=I5g9JP/u41w8V4HSPgsT2ymkTtNYKABcAqAl3tdRisE/m0v2JCvAoG//MAfJwBTHOjIcIyXNvrmGKaIlmCF62wc/YW3ZLlszhlXwhuWviqMCE2JbH2JKRCCeKLDoQmyO0M3Z+BXHQQ958U6fA07l8L7EYuycOsJHWeWlk2khzTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085085; c=relaxed/simple;
	bh=QgDLhVT5/Im3WYhce4U20WhSBJqy+kOhesA7mNbWrHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ik4fR6jAatlX0X9eYroa0cbkYjNVV14GFm2W56A61GCtaAG3PRPNFn0GQTxI62yvC4zDkoh6UEAeLMpQBSKjdukr6VNK0FX4JISTe1pDl+pd/zCfp0RvLaHS5F/tUrEeB2qclzElp/72DXWPPFwvyjAY/VJZHPLVsfevFRcMUPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7N5W7ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C987C4CEED;
	Mon, 21 Jul 2025 08:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753085084;
	bh=QgDLhVT5/Im3WYhce4U20WhSBJqy+kOhesA7mNbWrHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7N5W7tai1vfrQpA1hq53JrFSkqITF78cHo0BN+Tetz3lQFvqOr24uWsEOqX9WcYd
	 Orkuv6Wk0OIZZ9NnN71Kw0AZJ5VJjde3EQtsnQeVMWc0NknnM7vK+tY8Vj0Ng3IcKC
	 2QadC4DZMmHJSKzWz4SAlXDsc4ZsdMPmiAUTk0791CNQxKEgOQ6gd+EiNiR1VQcqgC
	 MeLDyPHumO/ToS+tDk2FfeHWP3KqyBF6j1kpN5EgjiRthLO+NEnBgcu9Buhc8nrFEN
	 8kXMFH50s9RjwtTdZ0W8ULdm3yGBxXDIvPe4qtmt3hvkwehclT1bd3aBW9IHePZAWS
	 MXt9K0szD2zkA==
Date: Mon, 21 Jul 2025 10:04:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: jeff_chang@richtek.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: regulator: Add Richtek RTR5133 DT
 Binding Documentation
Message-ID: <20250721-wonderful-auk-of-whirlwind-8beda4@kuoka>
References: <20250721060215.2718217-1-jeff_chang@richtek.com>
 <20250721060215.2718217-2-jeff_chang@richtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250721060215.2718217-2-jeff_chang@richtek.com>

On Mon, Jul 21, 2025 at 02:01:35PM +0800, jeff_chang@richtek.com wrote:
> From: Jeff Chang <jeff_chang@richtek.com>
> 

Missing commit msg.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.


Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

I already asked for it. Did you really read what I linked last time?

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

I already asked for it, so you ignored another comment. Why are you not
responding or implementing the comments?

Bindings go before users, so please re-order patches (see submitting
patches in DT dir).

> Signed-off-by: Jeff Chang <jeff_chang@richtek.com>
> ---
> 
> PATCH v3
> 1. fix Subject format
> 2. using correct patches version
> 3. remove '|'
> 4. remove allOf: &ref regulator.yaml#
> 5. remove redundant description
> 6. move BASE to base property with correct indentation
> 7. only using lowercase node name
> 8. make DT_CHECKER_FLAG=-m DT_SCHEMA_FILES=richtek,rt5133.yaml dt_binding_check pass
> 
> 
>  .../bindings/regulator/richtek,rt5133.yaml    | 197 ++++++++++++++++++
>  1 file changed, 197 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
> new file mode 100644
> index 000000000000..a92e7f775832
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5133.yaml
> @@ -0,0 +1,197 @@
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
> +  RT5133 is an integrated chip. It includes 8 LDOs and 3 GPOs that can be
> +  used to drive output high/low purpose. The dependency of the GPO block
> +  is internally LDO1 Voltage. If LDO1 voltage output disabled, GPO cannot
> +  be used to drive output high. It need to pay more attention on the usage.

Last statement does not feel relevant.

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
> +          Properties for base regulator which for force-off base circuit

That's not a regulator supply or you need to provide proper description
of hardware.

> +
> +        properties:
> +          regulator-compatible:
> +            description: Compatible string for regulator
> +            $ref: /schemas/types.yaml#/definitions/string

Drop property.

> +
> +          oc-shutdown-all:

Missing vendor prefix.

> +            type: boolean
> +            description:
> +              Anyone of LDO OC state, shut down all channels.

I don't understand the description at all.

> +
> +          pgb-shutdown-all:
> +            type: boolean
> +            description:
> +              Anyone of PGB OC state, shut down all channels.

Same problems here

> +
> +        required:
> +          - regulator-name
> +          - regulator-compatible

No, drop compatible. Please read the bindings.

> +
> +    patternProperties:
> +      "^ldo([1-6])$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          Properties for single LDO regulator
> +
> +        properties:
> +          regulator-compatible:
> +            description: Compatible string for regulator
> +            $ref: /schemas/types.yaml#/definitions/string
> +
> +        required:
> +          - regulator-name
> +          - regulator-compatible
> +
> +      "^ldo([7-8])$":
> +        type: object
> +        $ref: regulator.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          Properties for single LDO regulator
> +
> +        properties:
> +          regulator-compatible:
> +            description: Compatible string for regulator
> +            $ref: /schemas/types.yaml#/definitions/string
> +
> +          rt5133-ldo1-supply:
> +            description: |
> +              Only for ldo7 ldo8, pvin7 and pvin8 reference design are RT5133 ldo1.
> +              If not connect to ldo1 vout, this property for pvin7 and pvin8 is necessary.
> +
> +        required:
> +          - regulator-name
> +          - regulator-compatible
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended

interrupts instead

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
> +      rt5133: rt5133@18 {

Drop unused labels.


Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +        compatible = "richtek,rt5133";
> +        reg = <0x18>;
> +        wakeup-source;
> +        interrupts-extended = <&pio 187 0x0>;

Use proper defines

> +        enable-gpios = <&pio 186 0x0>;

Use proper defines.

> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        regulators {
> +          base {
> +            regulator-compatible = "BASE";
> +            regulator-name = "rt5133,base";
> +            oc-shutdown-all;
> +            pgb-shutdown-all;
> +          };
> +          rt5133_ldo1: ldo1 {

Drop unused labels.

Best regards,
Krzysztof


