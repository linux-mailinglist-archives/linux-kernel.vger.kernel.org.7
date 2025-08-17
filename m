Return-Path: <linux-kernel+bounces-772360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1494DB291BC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 08:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0E51965AB5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 06:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D7C2040AB;
	Sun, 17 Aug 2025 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq+Qa1Q1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363E1A23AC;
	Sun, 17 Aug 2025 06:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755410491; cv=none; b=jhTCwN5QvPZCgLmCzFsNn2bUAon4zExB5l7prEwqzvtuXCICU3AIJu/nO64LG0yXs4z2oVYHrmV/f17V6D9LSIUfSoXJHSN+xCYyn0HysX16kCaXyS9Gp0aFk2eelRA0/fbEWwj+g2FM5OJr6b6EU6cEFpJ0KwacpKHXw/d9lQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755410491; c=relaxed/simple;
	bh=mHZUPtn5UficimsWMroxIB90kO/gt16LWXvu1TDftiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIpiDi6S+Lcs/fLAZSeA5mwnHQd1r9ZzD/wIDQ+XGvqbKBX3ckgAJxNL54ucO8qH2duoBoA0nuaIS8BBVDh/4J+wt6+fwroQqn51mLuBaWJro5zgn9KOzECAphE8uKY2VnE+K2iZxh1U2gAyM/ItEmoNG/3ObgW/fnFwyXSy2vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq+Qa1Q1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB26BC4CEEB;
	Sun, 17 Aug 2025 06:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755410490;
	bh=mHZUPtn5UficimsWMroxIB90kO/gt16LWXvu1TDftiI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qq+Qa1Q1NID6yT4ELg0thEZhShaOpzvUCqLG2VgKDcJPdQTrwBHc6P6O+jm/u/PgU
	 hWw+v+rZiWQLviUAgQwprPMRVcH3qBMPThs/Fb0XjwYaS9zPgj5lyH7ILdQBCDKM1i
	 KXQY+ZkXyHGkTDi0GYE21MYhDTf07kdCgcef4q2l1DE8iwuTMIVj1y3CeYsEwq643E
	 C0fQQzhP36sKEYjgPiuB1/DZJS6xGDXNwB/VlCZhuYhARWn8KLACfIP0gTmSDP4R6d
	 I4y6dYS5aIDM/0IBBtunQ9rBVZezmuX7qTC6k82hVpAvbQPmyvN7GCHZ5hT7NiY/uF
	 FSFJiZJPB7ZWg==
Message-ID: <58e3e3ef-1871-45b1-ba2b-be6981d7d3d1@kernel.org>
Date: Sun, 17 Aug 2025 08:01:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] clock: eswin: Documentation for eic7700 SoC
To: dongxuyang@eswincomputing.com, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, linux-riscv@lists.infradead.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
References: <20250815093539.975-1-dongxuyang@eswincomputing.com>
 <20250815093653.1033-1-dongxuyang@eswincomputing.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250815093653.1033-1-dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/2025 11:36, dongxuyang@eswincomputing.com wrote:
> From: Xuyang Dong <dongxuyang@eswincomputing.com>
> 
> Add device tree binding documentation for the ESWIN eic7700
> clock controller module.
> 
> Signed-off-by: Yifeng Huang <huangyifeng@eswincomputing.com>
> Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> ---
>  .../bindings/clock/eswin,eic7700-clock.yaml   | 381 ++++++++++++++++++
>  1 file changed, 381 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/eswin,eic7700-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/eswin,eic7700-clock.yaml b/Documentation/devicetree/bindings/clock/eswin,eic7700-clock.yaml
> new file mode 100644
> index 000000000000..45e70ebc08e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/eswin,eic7700-clock.yaml
> @@ -0,0 +1,381 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/eswin,eic7700-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Eswin EIC7700 SoC clock controller
> +
> +maintainers:
> +  - Yifeng Huang <huangyifeng@eswincomputing.com>
> +  - Xuyang Dong <dongxuyang@eswincomputing.com>
> +
> +description:
> +  The clock controller generates and supplies clock to all the modules
> +  for eic7700 SoC.
> +
> +properties:
> +  compatible:
> +    const: eswin,eic7700-clock
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +required:

Incorrectly placed. required is after all properties.

> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +patternProperties:
> +  "^fixed-rate.*":
> +    type: object
> +    $ref: /schemas/clock/fixed-clock.yaml#

No, you do not get node per clock.

> +
> +  ".*pll@[a-f0-9]+$":
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: eswin,pll-clock


Nothing explains in the changelog why this appeared. Drop all these
nodes and fake or redundant compatibles.


> +
> +      reg:
> +        items:
> +          - description: PLL's config 0 register
> +          - description: PLL's config 1 register
> +          - description: PLL's config 2 register
> +          - description: PLL's status register
> +
> +      '#clock-cells':
> +        const: 0
> +
> +      clock-output-names:
> +        maxItems: 1
> +
> +      enable-shift:
> +        description: Bit shift of the enable register.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 31
> +
> +      enable-width:
> +        description: Width of the enable register.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 31
> +
> +      refdiv-shift:
> +        description: Bit shift of the reference divider register.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 31
> +
> +      refdiv-width:
> +        description: Width of the reference divider register.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 31
> +
> +      fbdiv-shift:
> +        description: Bit shift of the feedback divider register.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 31
> +
> +      fbdiv-width:
> +        description: Width of the feedback divider register.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 31
> +
> +      frac-shift:
> +        description: Bit shift of the fractional divider register.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 31
> +
> +      frac-width:
> +        description: Width of the fractional divider register.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 31
> +
> +      postdiv1-shift:
> +        description: Bit shift of the post divider 1 register.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 31
> +
> +      postdiv1-width:
> +        description: Width of the post divider 1 register.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 31
> +
> +      postdiv2-shift:
> +        description: Bit shift of the post divider 2 register.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 31
> +
> +      postdiv2-width:
> +        description: Width of the post divider 2 register.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        maximum: 31
> +
> +      lock-shift:
> +        description: Bit shift of the lock register.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 31
> +
> +      lock-width:
> +        description: Width of the lock register.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 31
> +
> +    required:
> +      - compatible
> +      - reg
> +      - '#clock-cells'
> +      - clock-output-names
> +      - enable-shift
> +      - enable-width
> +      - refdiv-shift
> +      - refdiv-width
> +      - fbdiv-shift
> +      - fbdiv-width
> +      - frac-shift
> +      - frac-width
> +      - postdiv1-shift
> +      - postdiv1-width
> +      - postdiv2-shift
> +      - postdiv2-width
> +      - lock-shift
> +      - lock-width
> +
> +    additionalProperties: false
> +
> +  ".*mux@[a-f0-9]+$":
> +    type: object

NAK, but anyway explain in the changelog WHY you did this...


Best regards,
Krzysztof

