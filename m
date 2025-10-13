Return-Path: <linux-kernel+bounces-850515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88150BD30C2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DF8D4E8302
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4B827FB1B;
	Mon, 13 Oct 2025 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPQaJiM5"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13126E714
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760359694; cv=none; b=QsUefAeJ2zIn5y+OkI7Bh4amOhpiOxbPIcu9SH7ezI7JAjcylDq5yd4exPWPgVXF/2wWisaRFC0Mv12kLTMLwZ5JUMI9Q9U067KJ47EBvYe4b+H2pBcPjOAFhUDFCJ0k0hWql49EMEFqJiraMGU6UgDQSDZRIqF7FIc33DiQS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760359694; c=relaxed/simple;
	bh=998bCQ5vVclaoJfJBg10iHBupkkwTUVT6piNf84yOAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icCsNbcoP3kODWwrr4tp3jp9HB3hK+2kFWihsRW+Fh2kPYkPwihjbaUMzUpTeoJ30gQJiO6zCCOOjSfW+kWVXSrUzg3OCU6c5oxTHWOJ0izqkTclxQfyW6GE5cS1OQWB8/SELkMcwiiZZFXXwcGka8+aqc8b63Ptb3QvEqwllLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPQaJiM5; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6394938e0ecso6819820a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760359690; x=1760964490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ME8ir36ArdJeQ8VOuoWbknt4FySWcug96E0ZWizlwFA=;
        b=NPQaJiM5Lo6OGWnN0sekJQ4QZ8icT7kHy5wCjuym0dkVKzfis28kx64b75v9mGLDo/
         zoo5eogYxgEXgOtQGaT2oMDpoePoE/JpN58X+ZZsU+6HwCJ/U+slBXyKhb7KT7vhsAfN
         p/o5qSNQd+KP1ZpLRora/fHNjTsw6h+Fmo3vpYiQc3cD5eiNTyU0opPaOJaCpNtnFmlA
         D3sw0v+duY4b0YHJ4UvYUue6o32Ddhd3WhKUtQE01hJnX0K1c1Zcl3Zeo3KqUVymCtUR
         QBSDUGMz7u1/rw6G75VNbWBWGFPGPQiBH6gT0RG4KE6nT3gD93JYWLtXVHeS8UaesP6u
         eUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760359690; x=1760964490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ME8ir36ArdJeQ8VOuoWbknt4FySWcug96E0ZWizlwFA=;
        b=S7oGvHI9IojeP25v5ustWzEsmORJ1vQBzx2Re1+D6QChzhMdhczbyPpUtrkAKVbAsX
         b3iiJBDgcPUlk5QSLoqH26AGqAlJR/U1d6Xl96ktJpQcCuDdgeznpsCD9SHEzOCCJWDM
         rYqBrMzQNxpyTQBB7LLjn/n5bc2W2jyBNA2aYQsCENrKqux0Xzao+YEbTkfWgYyc1fBe
         k2Eyw38HkkjTkzOKG1UH2iBXvqVVRjf1ompiNQdkIOVs5sFVvC0fWURQ44TjrlE8IjIo
         BMYs7Y5ZrO0KHGUPaGdzlAeQCxjgelU0qKbhQWr03aC8ausx0b+JBT581GRr3LjPl+9T
         Jniw==
X-Forwarded-Encrypted: i=1; AJvYcCXNO8g9iX7ZCEIJxAVv19SKpIIhGkNCJSEVsiKAd6mI173q3xRX3Gm+Ps+1CSD+B83f+D8Mo+26AtCIKss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLxyu9e/OuSCfSQGSEGhpGfEpgIQZd03WLltYUpywcuWx7Clrd
	NuLqTcJrC82FqdlgPhY33DqU4Ly9obkkDF8x2PYj92nTNTgPA9S+BGAK
X-Gm-Gg: ASbGnctcukiIBZgcgEJZFCdwzDldG5AqRhLECmtdEr/4EvODmkUmAB/ueyZwWylW//A
	bO2q+KOmZW1U4ujqfd9LlzlMEKksDm3F2amQmV0umkbiEIlsQyizmo790xQ4+/YbmxmTeAaP2nX
	jWXSi8RfS8zEKONl4RqYPtPnYzCamTHzdRai7M2iU2sQvCx4clT0LZDW28/wlgowPdb9JKBYUSS
	sB3nHTk5HzhM/G6dgqeYscOXWpF0AnvqjaA+JCqy4u0f+vRqRh7h7aW618DMJ9MtkRaLfIsiycE
	gxQs+TuS6AfCVASSldPVBSETmDdfnt41Yn+r/vFWQVc53XzSoE0F39qOmaaBoMaeHjhnSxD7f8Y
	Mudgd5n2uTTDf7TV5yL4GRQvj56SCLmvAxMQExrhCRU7OaGWvpkLTeAe8KI9+6ND/TXy2wf9u/m
	BygbZY
X-Google-Smtp-Source: AGHT+IGhsH9Jko1f8FqT4pidOms6fn00pFogStN/Ol9Z3CUMb20PsGcKDB/1u9de4k8QmAJ4VfkJ0A==
X-Received: by 2002:a17:906:4a85:b0:b55:c35e:e533 with SMTP id a640c23a62f3a-b55c35ee5d6mr1063241366b.12.1760359689360;
        Mon, 13 Oct 2025 05:48:09 -0700 (PDT)
Received: from [192.168.4.55] ([92.120.5.12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cacba7sm916644566b.5.2025.10.13.05.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 05:48:08 -0700 (PDT)
Message-ID: <1ad36baf-83af-4ab7-9f47-dd7f74d4749f@gmail.com>
Date: Mon, 13 Oct 2025 15:48:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] dt-bindings: clock: document 8ULP's SIM LPAV
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-clk@vger.kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
 <20250804155407.285353-4-laurentiumihalcea111@gmail.com>
 <20250805-stereotyped-precise-vicugna-1c78ff@kuoka>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <20250805-stereotyped-precise-vicugna-1c78ff@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/5/2025 10:03 AM, Krzysztof Kozlowski wrote:
> On Mon, Aug 04, 2025 at 11:54:03AM -0400, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> Add documentation for i.MX8ULP's SIM LPAV module.
>>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> ---
>>  .../bindings/clock/fsl,imx8ulp-sim-lpav.yaml  | 69 +++++++++++++++++++
>>  1 file changed, 69 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
>> new file mode 100644
>> index 000000000000..ef44f50921f8
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/fsl,imx8ulp-sim-lpav.yaml
>> @@ -0,0 +1,69 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/fsl,imx8ulp-sim-lpav.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NXP i.MX8ULP LPAV System Integration Module (SIM)
>> +
>> +maintainers:
>> +  - Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> +
>> +description:
>> +  The i.MX8ULP LPAV subsystem contains a block control module known as
>> +  SIM LPAV, which offers functionalities such as clock gating or reset
>> +  line assertion/de-assertion.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - fsl,imx8ulp-sim-lpav
>> +      - const: syscon
> Why is this syscon?


because of the MUX child's progamming model (i.e. "mmio-mux") which needs a syscon parent.

will get rid of this by using "reg-mux" instead. There shouldn't be a need for syscon anyways.


>
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 3
>> +
>> +  clock-names:
>> +    items:
>> +      - const: lpav_bus
>> +      - const: hifi_core
>> +      - const: hifi_plat
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +    description: clock ID
> Drop description, redundant. Look how other bindings write this.


ACK. Very sorry for the easily avoidable mistakes.


>
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +    description: reset ID
> Ditto
>
>> +
>> +  mux-controller:
>> +    $ref: /schemas/mux/reg-mux.yaml#
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - '#clock-cells'
> reset cells and mux controller.


I'd say the mux-controller child can stay optional since the driver allows it?


As for "#reset-cells": unless CONFIG_RESET_CONTROLLER is enabled, the driver allows

this property to not be specified. The whole idea was to try and make the driver more

flexible in case, for whatever reason, people wouldn't want/need the reset controller bit.

In hindsight, I think this decision makes writing the binding a bit more awkward (since the

optionality of this property depends on the value of CONFIG_RESET_CONTROLLER) so maybe

we'd just be better off with having this property mandatory and modifying the driver to remove

the aforementioned flexibility?


>
>
>
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/imx8ulp-clock.h>
>> +
>> +    clock-controller@2da50000 {
>> +        compatible = "fsl,imx8ulp-sim-lpav", "syscon";
>> +        reg = <0x2da50000 0x10000>;
>> +        clocks = <&cgc2 IMX8ULP_CLK_LPAV_BUS_DIV>,
>> +                 <&cgc2 IMX8ULP_CLK_HIFI_DIVCORE>,
>> +                 <&cgc2 IMX8ULP_CLK_HIFI_DIVPLAT>;
>> +        clock-names = "lpav_bus", "hifi_core", "hifi_plat";
>> +        #clock-cells = <1>;
>> +        #reset-cells = <1>;
> Incomplete node - missing properties/child. Post complete binding and
> complete example.
>
> Best regards,
> Krzysztof
>

