Return-Path: <linux-kernel+bounces-891500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC14C42CA7
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 13:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD865349E0F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 12:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5BE25743E;
	Sat,  8 Nov 2025 12:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avHHFzDg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C107405A;
	Sat,  8 Nov 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762604254; cv=none; b=sZU2fkQX0DtRilZOuCrfxwoo5KMY9aF8jbBH2Zl+KHBYODrgCSVQWl6XtcGDuvu9qAmgG6whB6jJanQrqjcW9S89V5VSx9wed77r8n5zNyp9gCvhPoJ/X0xaVu5l365Pn+IbFWM2e4whBcwXygoQxEHCKUgzuutffqWWwvREICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762604254; c=relaxed/simple;
	bh=t/lUw2uAjrGoaUP0pXMwUEdFiZfFUqAFSrqPAxPUPIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL/2ohs0w+Ai2mnUcRPSBfqdk3VwvDoVNxs7MzdzXIR4YxFz+naB3plCdQbcHYBcGndxOHcDJtfLgnK/+LlMqe3ulsDmWHri5o8YdAZIJgPuE57CYCADGxpL/dlrxMNuzp46f6DSOkLlVoIYHNhH4lGwFRYcKF/hzv8XziHwpYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avHHFzDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F7BC4CEF7;
	Sat,  8 Nov 2025 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762604253;
	bh=t/lUw2uAjrGoaUP0pXMwUEdFiZfFUqAFSrqPAxPUPIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=avHHFzDgxKCou/jgamnlVwUy4p7h8lnCfPycezLONh7GKkBdBxyJLT3lymMEtjMCL
	 hN3gUJK7oPjnqjUQRQis/rtHg2FBSjz8en+AOhyLr8jZO3EocV5TVvlqJLCEOr0Nnp
	 qy7B8CBvqCH0nMCrjraHst1K592NRVwArC2MuGR8tL1dDwVP1RQHRwlL4QYqOzYxgN
	 UgZQPwMnA1aDbtJZ/OnL7T6kezSMGpRnZ5OX7khsQo85L0mNb253WAeFUq+FNdp4Rz
	 gX5xMFfqm39lH5DoidqzH9RMyHcPljcBvIx0k04RxJRlT+V7RV6EB57jr7BQ/lAZLY
	 Q6cgN60wY1roQ==
Date: Sat, 8 Nov 2025 13:17:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add Fitipower FP9931/JD9930
Message-ID: <20251108-vagabond-lyrical-hawk-ad3490@kuoka>
References: <20251107-fp9931-submit-v1-0-aa7b79d9abb6@kemnade.info>
 <20251107-fp9931-submit-v1-2-aa7b79d9abb6@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251107-fp9931-submit-v1-2-aa7b79d9abb6@kemnade.info>

On Fri, Nov 07, 2025 at 09:06:45PM +0100, Andreas Kemnade wrote:
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: fiti,fp9931
> +
> +      - items:
> +          - const: fiti,jd9930
> +          - const: fiti,fp9931
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#thermal-sensor-cells':

Why is this a thermal zone sensor? Aren't you mixing temperature
reading with soc? For temperature reading you can use hwmon, for
example.

> +    const: 0
> +
> +  enable-gpios:
> +    maxItems: 1
> +
> +  pg-gpios:
> +    maxItems: 1
> +
> +  ts-en-gpios:

It's called EN_TS, so en-ts-gpios.


> +    maxItems: 1
> +
> +  xon-gpios:

That's powerdown-gpios, see gpio-consumer-common.

> +    maxItems: 1
> +
> +  vin-supply:
> +    description:
> +      Supply for the whole chip. Some vendor kernels and devicetrees
> +      declare this as a non-existing GPIO named "pwrall".
> +
> +  fiti,tdly:

No, look at datasheet. What values are there? ms.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Power up soft start delay settings tDLY1-4 bitfields in the
> +      POWERON_DELAY register
> +

Drop blank line

> +    minItems: 4
> +    maxItems: 4
> +
> +  VCOM:

Lowercase, just group them under regulators node and use patterns.


> +    type: object
> +    $ref: /schemas/regulator/regulator.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      The regulator for the compenstation voltage.
> +    properties:
> +      regulator-name:
> +        const: VCOM

No, why? Board designers could call it differently. Drop.

> +
> +  VPOSNEG:
> +    type: object
> +    $ref: /schemas/regulator/regulator.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      The pair of symmetric LDOs
> +    properties:
> +      regulator-name:
> +        const: VPOSNEG

Drop

> +
> +  V3P3:
> +    type: object
> +    $ref: /schemas/regulator/regulator.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      The pair of symmetric LDOs
> +    properties:
> +      regulator-name:
> +        const: V3P3

Drop

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#thermal-sensor-cells'
> +  - pg-gpios
> +  - enable-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        fp9931: pmic@18 {

Drop unused label.

> +          compatible = "fiti,fp9931";
> +          reg = <0x18>;
> +          pinctrl-names = "default";
> +          pinctrl-0 = <&pinctrl_fp9931_gpio>;
> +          #thermal-sensor-cells = <0>;
> +          vin-supply = <&epd_pmic_supply>;
> +          pg-gpios = <&gpio2 7 GPIO_ACTIVE_HIGH>;
> +          ts-en-gpios = <&gpio2 9 GPIO_ACTIVE_HIGH>;
> +          enable-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
> +          fiti,tdly = <2 2 3 3>;
> +
> +          vcom_reg: VCOM {
> +            regulator-name = "VCOM";

Names are always lowercase.

Best regards,
Krzysztof


