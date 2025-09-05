Return-Path: <linux-kernel+bounces-802317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 491B2B450EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8361BC18E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021462FD7B8;
	Fri,  5 Sep 2025 08:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7r1A9vu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417C2DF71;
	Fri,  5 Sep 2025 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059843; cv=none; b=u3GJLyRQbYZn9kqr+gzodqUj/cuDvCQG67hsN9UdzxyyLdznrJ9QURI7kg05Oy1fONP7mKE4uWtRXtlmmJvPx3aeUPzpevdHZK5vQ0dqX5s1p0WGjJqXAYdyQ/RBngimChw4D/muzHGVorrtNfW6vuXi0kzYjJTO5wTQefTOths=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059843; c=relaxed/simple;
	bh=5j4EJZCYnaX5wdGukSnYY4+GHzOWlhHBIHpH4amAKuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYTxV5+BKCoYwgXi8blgO79BfnC5OE4ThrDlkrSG38euNQpMVsgqhB7B9iwZmDWXGXKKj9NHW4sbthkoVjYiuufL98iTi4ICx/sH9bm95t5gg8K5cxkyEjSQBCsZ3jwhaNIj4L/TpErM/R6czz9XdqELEUG/xzObWAA0OH7xOA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7r1A9vu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A526C4CEF1;
	Fri,  5 Sep 2025 08:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757059842;
	bh=5j4EJZCYnaX5wdGukSnYY4+GHzOWlhHBIHpH4amAKuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7r1A9vu6gEFM8SHHq+HTmjSr1qaGBNGm8kBouACRDR81QrFR5g7GB1bWnBlmuPRU
	 2S3a7tunL4DtPhLB6XPcKqAJJem637OWSLRDUHaFFGb4XNvjscqCCwZiEL6rIvT6CS
	 CenMpUFAovfdjOOaSx0W9KFPe90QNEAwoeYyGjMZZgj9p2EcQ3m/K9VB/eZXyrAYKV
	 yPArVMcyX17vb+7e0hk+5+j/5wMvcR6h2clHhtCuBOm6aseQ2Y79QniGc7WCeMisUh
	 Q2d4N2J2azUO24TELOzbhFxpQ+Y/X+SC9o6LOENvQWplfUkYisvwuuRHEGiYyWs5Wg
	 l07sVD5ba6jHQ==
Date: Fri, 5 Sep 2025 10:10:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gregory Fuchedgi <gfuchedgi@gmail.com>
Cc: Robert Marko <robert.marko@sartura.hr>, 
	Luka Perkov <luka.perkov@sartura.hr>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: update TI TPS23861 with
 per-port schema
Message-ID: <20250905-deft-porcelain-teal-a3bdbf@kuoka>
References: <20250904-hwmon-tps23861-add-class-restrictions-v3-0-b4e33e6d066c@gmail.com>
 <20250904-hwmon-tps23861-add-class-restrictions-v3-1-b4e33e6d066c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904-hwmon-tps23861-add-class-restrictions-v3-1-b4e33e6d066c@gmail.com>

On Thu, Sep 04, 2025 at 10:33:44AM -0700, Gregory Fuchedgi wrote:
> Update schema after per-port poe class restrictions and a few other options
> were implemented.
> 
> Signed-off-by: Gregory Fuchedgi <gfuchedgi@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/ti,tps23861.yaml     | 93 +++++++++++++++++++++-
>  1 file changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> index ee7de53e19184d4c3df7564624532306d885f6e4..7538d1a9c19905ec90c48d34f84a92c1972f566b 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tps23861.yaml
> @@ -24,12 +24,60 @@ properties:
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
> +    description: GPIO for the reset pin.
> +    maxItems: 1
> +
> +  ti,ports-shutdown-gpios:

You can drop the vendor prefix, we do not have them for pins and
supplies.

> +    description:
> +      GPIO for the shutdown pin. Used to prevent PoE activity before the driver
> +      had a chance to configure the chip.
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Only required if PoE class is restricted to less than class 4 in the
> +      device tree.
> +    maxItems: 1
> +
> +patternProperties:
> +  "^poe-port@[0-3]$":

Keep consistent quotes, either ' or ".

> +    type: object
> +    description: Port specific nodes.
> +    unevaluatedProperties: false
> +    properties:
> +      reg:
> +        description: Port index.
> +        items:

Drop items, you want here a scalar, not array, and this suggests you
miss array constrain.

> +          maximum: 3
> +
> +      ti,class:
> +        description: The maximum power class a port should accept.

What's the meaning of values? There are no other generic properties like
that? Last time it was a generic property, but maybe the answer to my
question should be that there is or should be such generic one?

Also, why exactly wouldn't you want to accept here always the highest
power class? What makes it a board-level property?

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        maximum: 4

default: [ ... ]

> +
> +      ti,off-by-default:
> +        description: Indicates the port is off by default.

I fail to see how this is property of a board... unless you wanted to
figure out which ports are not connected, but status=disabled could be
used for that.

Sorry, but device has FIXED reset values for registers, so whether
something is off or on by default is defined by compatible.


> +        type: boolean
> +
> +      label:
> +        description: Port label.
> +
> +    required:
> +      - reg
> +
>  required:
>    - compatible
>    - reg
> @@ -45,9 +93,52 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        tps23861@30 {
> +        poe_controller@30 {

See DTS coding style.

>              compatible = "ti,tps23861";
>              reg = <0x30>;
>              shunt-resistor-micro-ohms = <255000>;
>          };
>      };
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        poe_controller@28 {
> +            compatible = "ti,tps23861";
> +            reg = <0x28>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            shunt-resistor-micro-ohms = <255000>;
> +            interrupt-parent = <&gpio1>;
> +            interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
> +            label = "cabinet_poe_controller";
> +            reset-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
> +            ti,ports-shutdown-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
> +
> +            poe-port@0 {
> +                    reg = <0>;

Mixed up indentation.

> +                    ti,class = <2>; // Max PoE class allowed.
> +                    ti,off-by-default;
> +                    label = "cabinet_port_a";

Best regards,
Krzysztof


