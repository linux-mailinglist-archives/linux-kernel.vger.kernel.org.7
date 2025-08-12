Return-Path: <linux-kernel+bounces-764175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BE9B21F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD2E3B4D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90D12DCF6C;
	Tue, 12 Aug 2025 07:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFA+l0xD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085EA2D781F;
	Tue, 12 Aug 2025 07:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754983232; cv=none; b=b2P1Rt+t8rPnw771SAUd0zOSlQEGprf+HggMtCzrblAvX8WI+XU/2GMTO3vJNJjv4/ePDyfzCErbKkqOvtcAVOvOUwPxUsqGYQFkGBejzKY/uAsN2AtBPp7D4fTdWAvidnMu24fY1dEcwS3/PQChd1MjWIbACFOC2eoBcoL1pn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754983232; c=relaxed/simple;
	bh=3zXD/+65HbFtTHBlTBULFxIEcPSOGq0V7b8vr8mcreE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+1nRZE1+ym9tDypg94fUTDX9YU4ZuzzuP0ws7htjRlg2YkllVHdhV/aPRMqavOioxt0KWjBaeCb/i5jsnQy6p7ydqXtxjo0tF9w1Rxza/SMuU27LZimv1Xz8VM9e41iJ8wfzcvCgZ1LXoR9KZ9m31Vi8n6BVQR3pwrzy6ZWG5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFA+l0xD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6B0C4CEF0;
	Tue, 12 Aug 2025 07:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754983231;
	bh=3zXD/+65HbFtTHBlTBULFxIEcPSOGq0V7b8vr8mcreE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WFA+l0xDczXlJQV0BfNDF6S5Adxp4Jjr1xRUUhYBWgihhjiPxagxSt5sJfBnl5OcD
	 ehqDYQORdF6Ss/ew4pR38LZX//pWEaqLxzcV+pQLMVLx27jxQr5bP1c53bddIN+3RM
	 IISVe8bkBRxC5xz+oodaWBu9eLoZwZHupBjMzDcLvQeahd6c7+AAcYOyEt5kJo2wCG
	 tKY4NnjCKQaQpk9NoGbYM7+E0rQQsxGZbc+ZelO302jsegywG2Sl24Pn/ik6k2c0p5
	 tZlNFGoXPgAY/bkoExgU3Ml4rQ8wKiI88Ums6TzxCE7ylIlSE4wDlnBVX4jANLJmew
	 Mbt2KZpcCBSdQ==
Message-ID: <eab6d2d2-9337-40fe-81c7-95dc1956ce6f@kernel.org>
Date: Tue, 12 Aug 2025 09:20:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: update TI TPS23861 bindings
 with per-port schema
To: gfuchedgi@gmail.com, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250811-hwmon-tps23861-add-class-restrictions-v2-0-ebd122ec5e3b@gmail.com>
 <20250811-hwmon-tps23861-add-class-restrictions-v2-2-ebd122ec5e3b@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250811-hwmon-tps23861-add-class-restrictions-v2-2-ebd122ec5e3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/08/2025 18:13, Gregory Fuchedgi via B4 Relay wrote:
> From: Gregory Fuchedgi <gfuchedgi@gmail.com>
> 
> Update schema after per-port poe class restrictions and a few other options
> were implemented.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> 
> Signed-off-by: Gregory Fuchedgi <gfuchedgi@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/ti,tps23861.yaml     | 86 ++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> index ee7de53e19184d4c3df7564624532306d885f6e4..578f4dad7eab630b218e9e30b23fc611a760d332 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> @@ -24,12 +24,62 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
>    shunt-resistor-micro-ohms:
>      description: The value of current sense resistor in microohms.
>      default: 255000
>      minimum: 250000
>      maximum: 255000
>  
> +  reset-gpios:
> +    description: Optional GPIO for the reset pin.
> +    maxItems: 1
> +
> +  shutdown-gpios:

powerdown-gpios, see gpio-consumer-common.yaml

> +    description: |

Drop |

> +      Optional GPIO for the shutdown pin. Used to prevent PoE activity before
> +      the driver had a chance to configure the chip.
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      The interrupt specifier. Only required if PoE class is restricted to less

Drop first sentence, redundant. Interrupts property cannot be anything
else than interrupt specifier.

> +      than class 4 in the device tree.
> +    maxItems: 1
> +
> +patternProperties:
> +  "^port@[0-3]$":

This goes to ports property.


> +    type: object
> +    description: Port specific nodes.
> +    unevaluatedProperties: false
> +    required:
> +      - reg

required goes to the end.

> +
> +    properties:
> +      reg:
> +        description: Port index.
> +        items:
> +          minimum: 0

Drop minimum.

> +          maximum: 3
> +
> +      class:
> +        description: The maximum power class a port should accept.

What are the values? Where is the property defined - which schema - that
you do not use vendor prefix?

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0

Drop minimum.

> +        maximum: 4
> +
> +      off-by-default:

Same question - which common schema defines this?

> +        description: Indicates the port is off by default.
> +        type: boolean
> +
> +      label:
> +        description: Optional port label

Skip all "optional" here and other places. Schema tells it, not free
form text. Say something useful here or just ": true".

> +
>  required:
>    - compatible
>    - reg
> @@ -51,3 +101,39 @@ examples:
>              shunt-resistor-micro-ohms = <255000>;
>          };
>      };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        tps23861@28 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


> +            #address-cells = <1>;
> +            #size-cells = <0>;

Follow closely DTS coding style.

> +            compatible = "ti,tps23861";
> +            reg = <0x28>;
> +            shunt-resistor-micro-ohms = <255000>;
> +            reset-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> +            shutdown-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <14 0>;

0 looks like invalid flag. Use proper defines and proper values.

> +            label = "my_poe_controller";

Use useful names or just drop it.


> +            port@0 {
> +                    reg = <0>;
> +                    class = <2>; // Max PoE class allowed.


> +                    off-by-default;
> +                    label = "myport";

Also not useful.


Best regards,
Krzysztof

