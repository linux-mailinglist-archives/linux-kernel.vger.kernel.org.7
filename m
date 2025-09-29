Return-Path: <linux-kernel+bounces-836369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564BBBA9811
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79817167AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84013090EF;
	Mon, 29 Sep 2025 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clhvRy59"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9743064BB;
	Mon, 29 Sep 2025 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155077; cv=none; b=aEZnZ3wVAUkxBpAx3H10I2dzisOU6ss4aZWAN6X8waXgikMkxDLRQBdJXinwA+qF3CxfmUhaotse/oUgmFBQxJVAQu7psFnWkYBjtRMSUv0Tesu7+OXr9E/1jz3c4vCpfq0nWbhjTaVWehj0NbNkkSkWvyoNfl7iLsGztmHd/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155077; c=relaxed/simple;
	bh=ki2cswukQPgJq2I/s5h5f2pdLs+OuiwbO3rA0ZkNyrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZK5hm5/pE3GPT1P9SEhyXO1zWD6TcxKbLFfjDnvvLCQva6hzmzVFKf6G+O7E9mYaT/K4tEFq24vrdNaicFY7pt2InQLgFZ9Nu/yzacaVa80td7mMAaDCsJq5OJ0Hm2eOKo75pI5lN+0M2c8Gh+eKbt4VhUHEckjRBjXtSk3lqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clhvRy59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D50BC4CEF4;
	Mon, 29 Sep 2025 14:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759155074;
	bh=ki2cswukQPgJq2I/s5h5f2pdLs+OuiwbO3rA0ZkNyrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clhvRy59EDUJy0Tio8hVOUs63L+gNoEICQiqW7n6rziCUZjHFfbb/KtntQr1kwxn6
	 kIzQKNW8vZ/6onKEybrGaQF+nvDfxD9nSPTDbHNevlvzGM6OZFn37fh06P2nEoO3fd
	 Xccg0at3/eDnCrtDXwJ5z0faKaHW83H8fycY7vUhCOt7X0T9VtEZUKVfdMNCStVLXj
	 fsf220kMERCyj2eW0t/EeIGCWwkxhXOSWMCHr42HAEBzQycO9J965U4M/ZQFF0JeaL
	 NnUy3P8hmvI8ozW71xXvEoJvshyi6iutD90r0HhPP15RElCwlhk4SeKqFVhLvLrM43
	 hsKRz0QnU3/9w==
Date: Mon, 29 Sep 2025 09:11:13 -0500
From: Rob Herring <robh@kernel.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: devicetree <devicetree@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Georgy Yakovlev <Georgy.Yakovlev@sony.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: Re: [PATCH 1/4] dt-bindings: mfd: Add sony,cronos-cpld
Message-ID: <20250929141113.GA3987541-robh@kernel.org>
References: <948400747.1748562.1758824253627.JavaMail.zimbra@raptorengineeringinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <948400747.1748562.1758824253627.JavaMail.zimbra@raptorengineeringinc.com>

On Thu, Sep 25, 2025 at 01:17:33PM -0500, Timothy Pearson wrote:
> The Sony Cronos Platform Controller CPLD is a multi-purpose platform
> controller that provides both a watchdog timer and an LED controller for
> the Sony Interactive Entertainment Cronos x86 server platform. As both
> functions are provided by the same CPLD, a multi-function device is
> exposed as the parent of both functions.
> 
> Add a DT binding for this device.
> 
> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
> ---
>  .../bindings/mfd/sony,cronos-cpld.yaml        | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml b/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
> new file mode 100644
> index 000000000000..3cebf6c0153d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sony,cronos-cpld.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 Raptor Engineering, LLC
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/sony,cronos-cpld.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sony Cronos Platform Controller CPLD multi-function device
> +
> +maintainers:
> +  - Georgy Yakovlev <Georgy.Yakovlev@sony.com>
> +
> +description: |

Don't need '|' if no formatting or paragraphs to preserve.

> +  The Sony Cronos Platform Controller CPLD is a multi-purpose platform
> +  controller that provides both a watchdog timer and an LED controller for the
> +  Sony Interactive Entertainment Cronos x86 server platform. As both functions
> +  are provided by the same CPLD, a multi-function device is exposed as the
> +  parent of both functions.
> +
> +properties:
> +  compatible:
> +    const: sony,cronos-cpld
> +
> +  reg:
> +    maxItems: 1
> +
> +  leds:
> +    type: object
> +    additionalProperties: false
> +    description: |
> +      The Cronos LED controller is a subfunction of the Cronos platform
> +      controller, which is a multi-function device.
> +
> +      Each led is represented as a child node of sony,cronos-led. Fifteen RGB
> +      LEDs are supported by the platform.
> +
> +    properties:
> +      compatible:
> +        const: sony,cronos-led
> +
> +      reg:
> +        maxItems: 1
> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^multi-led@[0-15]$":
> +        type: object
> +        $ref: leds-class-multicolor.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            description:
> +              LED channel number (0..15)
> +            minimum: 0
> +            maximum: 15
> +
> +        required:
> +          - reg
> +
> +    required:
> +      - compatible
> +      - "#address-cells"
> +      - "#size-cells"
> +
> +  watchdog:
> +    type: object
> +    description: Cronos Platform Watchdog Timer
> +
> +    allOf:
> +      - $ref: watchdog.yaml#
> +
> +    properties:
> +      compatible:
> +        const: sony,cronos-watchdog

There's no need for a child node here. 'timeout-sec' can just go in the 
parent node.

Rob

