Return-Path: <linux-kernel+bounces-848090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FC1BCC7F5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9533140822E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEF2283129;
	Fri, 10 Oct 2025 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AA+qF05a"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783A023E347
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091389; cv=none; b=LkhE4CIje5uvjoAbZBKrrzrE/asUG3pTmiQn12HiEisi3RWsyFAeiF6BiWgxW47eJXS4N3xWHy+XyHI4QEa6kQfqWwgwsdKV5b7PyYwDLg01gdO6SuZXhpDXYfkfWiVyL2K+PztmgHYF5E7qDcBMKvtDOWAzSB10+qA/Vc9MKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091389; c=relaxed/simple;
	bh=5wd9tQUREC1eEyCsnMEodU1pS2RoWFi1973rUIhTsdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUMoZ4WA8WebzUAT1ygKpaSPp3g7pxoUkLr45z2EE6Qi1j4M3lDfzR3jmxC7XN0vL6dr6ySz1inwqpMn8sZ2Pf0Y40fBRZGbVh6NQqriuoyxlX767q/SnlbVWWzMjGsCBwL2rJvm566Cl/4cH5Fj1OeImDaqFFcef1fD9o+4Qbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AA+qF05a; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EABC1C08CC5;
	Fri, 10 Oct 2025 10:16:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8BD1360667;
	Fri, 10 Oct 2025 10:16:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 154DD102F220B;
	Fri, 10 Oct 2025 12:16:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760091383; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=n6HazN1sAWLIGVuPB5Q33kUmi4chDMBKIuv8XrJPLYE=;
	b=AA+qF05a9hf8XgayaG9t7T6DbV/WtbQkquFY9zFxQEJ/DdGBMziJQNqBRxPG5qTeOVSpvN
	uwzClc0Ux+cYTSI+IDMaAGevIWNlkkYOyDFH/CEnmBrAT1YW2OWmBceZlOu4MQAa+JOkUn
	u7Tw0fVKzGgHj3FQ96Ug3/TB6NJIkI5cMRN8pBNYi50mWGvk5RpbFpOIZispudvlRzSMnY
	JwoJMfpbikfmJrTEf8HhVzW3d3uc6uzk5hNLYAQbnvRqFAvm01uxxRA50uonqAeTKCkXn1
	LBqZsuSFzTrlLYLDlP5AhW5q1V96m4SjMuduf9sJ/J0KA1UAKq1WL+4J61gwYA==
Message-ID: <76033f73-4a8f-45c1-90a3-63a4eae2adaa@bootlin.com>
Date: Fri, 10 Oct 2025 12:16:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] dt-bindings: mtd: sunxi: Add new compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251010084042.341224-1-richard.genoud@bootlin.com>
 <20251010084042.341224-3-richard.genoud@bootlin.com>
 <414c16db-cdd1-433d-b0ae-915e11d964f0@kernel.org>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <414c16db-cdd1-433d-b0ae-915e11d964f0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Krzysztof,

Le 10/10/2025 à 10:45, Krzysztof Kozlowski a écrit :
> On 10/10/2025 10:40, Richard Genoud wrote:
>> The H616 NAND controller is quite different from the A10 and A23 ones,
>> some registers offset changed, and some new one are introduced.
>> Also, the DMA handling is different (it uses chained descriptors)
>>
> 
> 
> Subject: not new compatible, but "H616" or whatever device is called.
> Otherwise every commit would be called like that making git log
> --oneline useless.
Indeed.

> 
>> So, introduce a new compatible to represent this version of the IP.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
>>   .../mtd/allwinner,sun4i-a10-nand.yaml         | 56 ++++++++++++++-----
>>   1 file changed, 43 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
>> index 054b6b8bf9b9..cc63091fe936 100644
>> --- a/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/allwinner,sun4i-a10-nand.yaml
>> @@ -6,34 +6,64 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>>   title: Allwinner A10 NAND Controller
>>   
>> -allOf:
>> -  - $ref: nand-controller.yaml
>> -
>>   maintainers:
>>     - Chen-Yu Tsai <wens@csie.org>
>>     - Maxime Ripard <mripard@kernel.org>
>>   
>> +allOf:
>> +  - $ref: nand-controller.yaml
> 
> 
> If moving it, can you place it like in example-schema, so at the bottom,
> above unevaluatedProps?
Yes, absolutely.

> 
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - allwinner,sun4i-a10-nand
>> +              - allwinner,sun8i-a23-nand-controller
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: Bus Clock
>> +            - description: Module Clock
>> +        clock-names:
>> +          items:
>> +            - const: ahb
>> +            - const: mod
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - allwinner,sun50i-h616-nand-controller
>> +    then:
>> +      properties:
>> +        clocks:
>> +          items:
>> +            - description: Bus Clock
>> +            - description: Module Clock
>> +            - description: ECC Clock
>> +            - description: MBus Clock
>> +        clock-names:
>> +          items:
>> +            - const: ahb
>> +            - const: mod
>> +            - const: ecc
>> +            - const: mbus
>> +
>>   properties:
>>     compatible:
>>       enum:
>>         - allwinner,sun4i-a10-nand
>>         - allwinner,sun8i-a23-nand-controller
>> +      - allwinner,sun50i-h616-nand-controller
>>     reg:
>>       maxItems: 1
>>   
>>     interrupts:
>>       maxItems: 1
>>   
>> -  clocks:
>> -    items:
>> -      - description: Bus Clock
>> -      - description: Module Clock
>> -
>> -  clock-names:
>> -    items:
>> -      - const: ahb
>> -      - const: mod
> 
> 
> You cannot remove it. Broadest constraints, see writing schema.
> 
> or my standard reference example:
> https://elixir.bootlin.com/linux/v6.11-rc6/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L127
Ok

Thanks!

> 
> 
> Best regards,
> Krzysztof


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

