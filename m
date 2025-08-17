Return-Path: <linux-kernel+bounces-772460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FA0B292F3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 14:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E7B3BCEDE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 12:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1823958C;
	Sun, 17 Aug 2025 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9j3NsKI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A54AEE2;
	Sun, 17 Aug 2025 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755433303; cv=none; b=WAqOEKAePyquEwbKQjTn7NEfxJ2cisX9J7fQ4sZVbgROyMxaF8E8F/Bxjwlu+0ALH/K9nH9sE2QzZawGAVjMwr99cysJaQFtO6KjJcoQgqCduzp2YCE7liyPsWDqTXB/VLbo8RLpmAdgc3hDB8IiU2y/aT1H/cETHloFLvhZBt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755433303; c=relaxed/simple;
	bh=VB4Z7lCScCM/Ebi/TFVSHew7ca3XreWBpRHcE0r4w9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vE/sVIV5/pJq1ALvSGY6oGrWyG2gi1+cBbIjcZO+fplBNLb8ZaL7y5SXyAiIuNwRhlOeJtmGrfFjPlHuexK49bCPep3AV1JPt16cl4EelRafna/zJ4cwSzFT35BvRSb4CI96PAHJxGxE9/W3EN+X7N2/QsuvPvvEN1IGNOI+bwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9j3NsKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA1BC4CEEB;
	Sun, 17 Aug 2025 12:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755433301;
	bh=VB4Z7lCScCM/Ebi/TFVSHew7ca3XreWBpRHcE0r4w9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L9j3NsKI81TVqo9W4fzbWBIhRfdBEEQWfTFGTiIFo7Vi76QDMdhGZLHErec22Xolk
	 nj4slQ59WOD1ynry6RMSzSpmWMRJDDC4RXAvHPWw+kaqJF7u822wXxmYIrynq1/7AH
	 Jbla/Ja63ELezvzIiQUBQ+9cjK2NI07KuEhDINspNr/+FRzgalDplSyHsKL7bbb/Bh
	 o4D/m+0LOOcBu1cUpqTnKiEUQKHOCx9ZVGA1Rh0AMx0YuKdViUrJdNJULHBJh7DJpV
	 RhKzLLiIv6lIgyjy3YiMuUgqAsa9ZWZp/iQPK+/zy/+dIWU4iuSOLKwcoyMceMLdgI
	 UsRMfWgJFkWdg==
Message-ID: <cc9fab72-1fca-40de-b1c2-36f6f4e43fda@kernel.org>
Date: Sun, 17 Aug 2025 14:21:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: dt-bindings: ti,twl6040: convert to DT schema
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>, robh@kernel.org, lee@kernel.org
Cc: peter.ujfalusi@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org
References: <20250816023330.173349-1-jihed.chaibi.dev@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250816023330.173349-1-jihed.chaibi.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/08/2025 04:33, Jihed Chaibi wrote:
> Convert the legacy TXT binding for the TWL6040 MFD to the modern YAML
> DT schema format. This adds formal validation and improves documentation
> for the TWL6040/TWL6041 audio codec, which provides audio, vibra, and GPO
> functionality on OMAP4+ platforms.
> 
> The unused 'twl6040,audpwron-gpio' property has been dropped from
> the schema as it is not used by the driver.
> 
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> ---
>  .../devicetree/bindings/mfd/ti,twl6040.yaml   | 149 ++++++++++++++++++
>  .../devicetree/bindings/mfd/twl6040.txt       |  67 --------

That's a v3? Where is the changelog and rest of the patches?

You need to keep versioning and explain what was happening with the
patch (and why).


>  2 files changed, 149 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/twl6040.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl6040.yaml b/Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
> new file mode 100644
> index 000000000..c8922fce4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/ti,twl6040.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments TWL6040/TWL6041 Audio Codec
> +
> +maintainers:
> +  - Peter Ujfalusi <peter.ujfalusi@gmail.com>
> +
> +description:
> +  The TWL6040s are 8-channel high quality low-power audio codecs providing
> +  audio, vibra and GPO functionality on OMAP4+ platforms.
> +  They are connected to the host processor via i2c for commands, McPDM for
> +  audio data and commands.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,twl6040
> +      - ti,twl6041
> +
> +  reg:
> +    const: 0x4b
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 1
> +
> +  '#clock-cells':
> +    description: TWL6040 is a provider of PDMCLK which is used by McPDM.
> +    const: 0
> +
> +  vio-supply:
> +    description: Regulator for the VIO supply.
> +
> +  v2v1-supply:
> +    description: Regulator for the V2V1 supply.
> +
> +  enable-active-high:
> +    type: boolean
> +    description: If present, powers on the device during boot.
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2

Why flexible size? Old binding did not suggest that. Any differences
should be explained in commit msg.

> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum: [clk32k, mclk]

Why is this flexible instead of list of items?

> +
> +  # Vibra functionality :
> +
> +  vddvibl-supply:
> +    description: Regulator for the left vibra motor supply.
> +
> +  vddvibr-supply:
> +    description: Regulator for the right vibra motor supply.
> +
> +  vibra:
> +    type: object
> +    description: Node for vibra motor configuration parameters.
> +    properties:
> +      ti,vibldrv-res:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Resistance parameter for the left driver.
> +
> +      ti,vibrdrv-res:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Resistance parameter for the right driver.
> +
> +      ti,viblmotor-res:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Resistance parameter for the left motor.
> +
> +      ti,vibrmotor-res:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Resistance parameter for the right motor.
> +
> +      vddvibl_uV:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Optional override for the VDDVIBL default voltage (in uV).
> +
> +      vddvibr_uV:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description: Optional override for the VDDVIBR default voltage (in uV).
> +    required:
> +      - ti,vibldrv-res
> +      - ti,vibrdrv-res
> +      - ti,viblmotor-res
> +      - ti,vibrmotor-res
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - gpio-controller
> +  - '#gpio-cells'
> +  - '#clock-cells'
> +  - vio-supply
> +  - v2v1-supply
> +  - vddvibl-supply
> +  - vddvibr-supply
> +  - vibra
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      twl6040: twl@4b {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

audio-codec?

> +        compatible = "ti,twl6040";
> +        reg = <0x4b>;
> +
> +        interrupts = <0 119 4>;

Use standard defines. <0> also feels wrong here, that's I2C.

> +        interrupt-parent = <&gic>;
> +
> +        gpio-controller;
> +        #gpio-cells = <1>;
> +        #clock-cells = <0>;
> +



Best regards,
Krzysztof

