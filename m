Return-Path: <linux-kernel+bounces-892059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2E9C44382
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 18:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FD53B1EE3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DA430505B;
	Sun,  9 Nov 2025 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iq1LCW6C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7F92765FF;
	Sun,  9 Nov 2025 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708396; cv=none; b=nI+8yp5VcVows+idUn+pI1+KqKcMyI859jOOxcTXqkfOaZe/mzMO2aVn/SoVFTwrmks/YFgeT5eZlaNX4nwHKf4c9mhNOPolcgnxfn2S7U7Ktxu9ajl91abOQ5rvMQMhta+8TwOt27QaWv33hpcPlz7+Pca19buYRlNeJ/MPWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708396; c=relaxed/simple;
	bh=REetAnCMz4hM/dnpMporPXycc4SyOGrdg5Ru1+D0tdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+RWMmwkqIN+vON29tMEk8mipmmKaROe5suyCpADkD1RRv9AlWd+6UWx5goyyOpqTY/bpwZGSrc3iE9nJjs20uWjUR4kXJsFWuPjqSm/0uYIdz4YOW/LGttKlJ5hM9WxLVXFR4juPA6y0BuqafkQSpio3XVvIaSBl9oipVlGWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iq1LCW6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB15C16AAE;
	Sun,  9 Nov 2025 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762708396;
	bh=REetAnCMz4hM/dnpMporPXycc4SyOGrdg5Ru1+D0tdU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iq1LCW6CzCt3zKlOOKSsHl/LO099SXcnLkr87LoMqZUVgUE9lkI9VgoHB0KjdZNnr
	 NlXPj5GmPwAqlLxo+vPAMrBSqGtyAwjieiXdTmgT5NrfLUoyqei6iRaNYXhWEfx7ev
	 1qXF95ngNZP82RKoHQHS7082/1VaK1lyzcrT19MhDNSAxaQ2T6LOpG1aeTM7O1TQUc
	 GrYSLSgxkUWx9HV+cZyte98NPv+Bn77+OUVYWzZ+7awwrWfwtpWT8gU9/D16Zoy1fC
	 0wu11x82oYna6aCU274ndPz/Ersp8lLOpIaxPkOHEXSqe70KEzW28Q4fNRuoyY3dTI
	 zCSiwGBWmobRw==
Message-ID: <aa54cf7c-cabd-490b-9bdd-a7a077ced35c@kernel.org>
Date: Sun, 9 Nov 2025 18:13:11 +0100
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
 <aa330123-e6d9-44ce-b030-b266cba1df9c@kernel.org>
 <20251108175244.0b51fac6@kemnade.info>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251108175244.0b51fac6@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2025 17:52, Andreas Kemnade wrote:
> On Sat, 8 Nov 2025 15:46:01 +0100
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
>>>>> +  fiti,tdly:    
>>>>
>>>> No, look at datasheet. What values are there? ms.
>>>>  
>>> Hmm, no to what? I do not understand your comment.  
>>
>> Please use proper units for the field expressed in the property name
>> suffix and possible values (enum).
>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
>>
>> You also need default.
>>
>>> So I guess a bit what might be options to discuss here:
>>> - put raw value for the bitfield here (what is currently done).
>>> - put the ms values here (then I would expect a suffix in the property name)
>>>   We have the mapping 0ms - 0, 1ms - 1, 2ms - 2, 4ms - 3, so it is
>>>   not identical.  
>> I don't know what has to be identical. You want here 0, 1, 2 or 4 ms.
>> BTW, if you speak about driver complexity, getting register value out of
>> above is absolutely trivial, so not a suitable argument.
> 
> Ok, no problem with doing that trivial conversion in the driver.
> 
> Playing around with dt-binding-check and add enums (and the -ms in a
> second step):
>   fitipower,tdlys:
>     $ref: /schemas/types.yaml#/definitions/uint32-array
>     description:
>       Power up soft start delay settings tDLY1-4 bitfields in the
>       POWERON_DELAY register
>     default: <0 0 0 0>
>     items:
>       - enum:
>           - 0
>           - 1
>           - 2
>           - 4
>       - enum:
>           - 0
>           - 1
>           - 2
>           - 4
>       - enum:
>           - 0
>           - 1
>           - 2
>           - 4
>       - enum:
>           - 0
>           - 1
>           - 2
>           - 4
> 
> 
> dt-binding-check accepts this, including the example. But if I change it to -ms
> as you requested, I get
> 
> /home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: 'anyOf' conditional failed, one must be fixed:
> 	'maxItems' is a required property
> 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> 	'$ref' is not one of ['maxItems', 'description', 'deprecated']
> 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> 	'default' is not one of ['maxItems', 'description', 'deprecated']
> 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> 	'items' is not one of ['maxItems', 'description', 'deprecated']
> 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> 	Additional properties are not allowed ('$ref', 'default' were unexpected)
> 		hint: Arrays must be described with a combination of minItems/maxItems/items
> 	'items' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
> 	'<0 0 0 0>' is not of type 'integer'
> 	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> /home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: '$ref' should not be valid under {'const': '$ref'}
> 	hint: Standard unit suffix properties don't need a type $ref
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> /home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: 'anyOf' conditional failed, one must be fixed:
> 	'maxItems' is a required property
> 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> 	'$ref' is not one of ['maxItems', 'description', 'deprecated']
> 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> 	'default' is not one of ['maxItems', 'description', 'deprecated']
> 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> 	'items' is not one of ['maxItems', 'description', 'deprecated']
> 		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
> 	Additional properties are not allowed ('$ref', 'default' were unexpected)
> 		hint: Arrays must be described with a combination of minItems/maxItems/items
> 	'items' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
> 	'<0 0 0 0>' is not of type 'integer'
> 	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> /home/andi/old-home/andi/kobo/kernel/Documentation/devicetree/bindings/regulator/fitipower,fp9931.yaml: properties:fitipower,tdly-ms: '$ref' should not be valid under {'const': '$ref'}
> 	hint: Standard unit suffix properties don't need a type $ref
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

You must drop ref. That's the entire point of common unit suffix.

> 
> Leaving out the type $ref does not improve things much.
> What is going on here?
Please paste the error from correct code, not above.


Best regards,
Krzysztof

