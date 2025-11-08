Return-Path: <linux-kernel+bounces-891549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97529C42E73
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 15:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265B33AFA70
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 14:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA591AB6F1;
	Sat,  8 Nov 2025 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA70Cds9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D014A07;
	Sat,  8 Nov 2025 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762613168; cv=none; b=KIqxNeHa+Hi0lLqaOHwot1/slKoKV2VEDLAkfshoVd+Syad1w3gbJ0Fxhfebna6r7sEeAiQjgDmG9bhqDIHtB7haOgnTicik57rvCMqdJuGbSvCAwC5o9Cdzk0TzGFHY+aB7+dF5Dih98IxErmA66LBowGcDmFtrf45cBwQxQ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762613168; c=relaxed/simple;
	bh=4xr81XznMx3JxZ2PiBSb4F7WXSBRzdh4HzfJfDT1/sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1BHkhnd3GgZsTnAFsSx55N8ovvSNBuGSZFbB1RXxtuGD2n6hTirHHai8sO6YYjBLW1nvaUpxGeNq2H1ieD0sFgpauUaa77TB8N6UdH9wgauzm0DuhI7oRVbgzfqR/be2WkQxEnjkDLgm7y8lB5aT0fjJwRS45gKXKrsKwuMfE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA70Cds9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0831AC116D0;
	Sat,  8 Nov 2025 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762613166;
	bh=4xr81XznMx3JxZ2PiBSb4F7WXSBRzdh4HzfJfDT1/sM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RA70Cds9k9kY/4VsrrHOMAD7mgqWhN36Dnw86ZcSEVBMRvLKPVE34vuiO7/RXfvxg
	 ttmAEYGw89v/BY4VWUnClgJHHMFDC7ekDP3ET03RIXjKfqtzGp8KbKGfl78OqXe6qY
	 6SA8hJImkXv9gkB42PT/r6abGa1doZ1xFvYdanBaTeE7RXjAEIUhoOlk8fymgFZzjS
	 PVl2IDWWGCHzpJNKFxSMlvCrQrNZluc/QSrLWkRFDmt509wdhy975gQkY+ME00L8sa
	 ALFsaLxATvB9wcyFXfBaA9s9UIpoMkWQkjthwLUdQSDP86pIIxjQ3rRa3A3iJyFkER
	 UtVgN9zDj1PjQ==
Message-ID: <aa330123-e6d9-44ce-b030-b266cba1df9c@kernel.org>
Date: Sat, 8 Nov 2025 15:46:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: regulator: Add Fitipower FP9931/JD9930
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20251107-fp9931-submit-v1-0-aa7b79d9abb6@kemnade.info>
 <20251107-fp9931-submit-v1-2-aa7b79d9abb6@kemnade.info>
 <20251108-vagabond-lyrical-hawk-ad3490@kuoka>
 <20251108152114.53422ea6@kemnade.info>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251108152114.53422ea6@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2025 15:21, Andreas Kemnade wrote:
> On Sat, 8 Nov 2025 13:17:31 +0100
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>> On Fri, Nov 07, 2025 at 09:06:45PM +0100, Andreas Kemnade wrote:
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - const: fiti,fp9931
>>> +
>>> +      - items:
>>> +          - const: fiti,jd9930
>>> +          - const: fiti,fp9931
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  '#thermal-sensor-cells':  
>>
>> Why is this a thermal zone sensor? Aren't you mixing temperature
>> reading with soc? For temperature reading you can use hwmon, for
>> example.
>>
> well, I just took the SY7636A as reference. Is there any document describing
> the terme "thermal zone sensor". I would define a thermal zone as an area
> with things influencing each other thermically. These things are
> sensors, heat sources and sinks. Well, the panel typically does not produce
> much heat.
> But I do not insist on having that property here. As far as I understand,
> the hwmon uses this property as an indication to also create a thermal zone
> sensor.

That's Linux detail, but anyway you don't need it. This device does not
look like a part of thermal zones.

> 
>>> +    const: 0
>>> +
>>> +  enable-gpios:
>>> +    maxItems: 1
>>> +
>>> +  pg-gpios:
>>> +    maxItems: 1
>>> +
>>> +  ts-en-gpios:  
>>
>> It's called EN_TS, so en-ts-gpios.
>>
> ok
>>
>>> +    maxItems: 1
>>> +
>>> +  xon-gpios:  
>>
>> That's powerdown-gpios, see gpio-consumer-common.
>>
> looking a bit around: powerdown-gpios e.g. in the MCP4801
> describe an *input*, which should be connected to an output of the SoC. 
> Looking at the datasheet, I see "XON Open Drain N-MOS On-Resistance" so it is
> an *output* (same as for PG). So it is something different then the
> powerdown-gpios in e.g. the MCP4801.
> So it is a signal coming from the JD9930 after EN goes low in the power down
> sequence.

OK, I just briefly skimmed through datasheet.

> 
>>> +    maxItems: 1
>>> +
>>> +  vin-supply:
>>> +    description:
>>> +      Supply for the whole chip. Some vendor kernels and devicetrees
>>> +      declare this as a non-existing GPIO named "pwrall".
>>> +
>>> +  fiti,tdly:  
>>
>> No, look at datasheet. What values are there? ms.
>>
> Hmm, no to what? I do not understand your comment.

Please use proper units for the field expressed in the property name
suffix and possible values (enum).
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

You also need default.

> So I guess a bit what might be options to discuss here:
> - put raw value for the bitfield here (what is currently done).
> - put the ms values here (then I would expect a suffix in the property name)
>   We have the mapping 0ms - 0, 1ms - 1, 2ms - 2, 4ms - 3, so it is
>   not identical.
I don't know what has to be identical. You want here 0, 1, 2 or 4 ms.
BTW, if you speak about driver complexity, getting register value out of
above is absolutely trivial, so not a suitable argument.

Best regards,
Krzysztof

