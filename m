Return-Path: <linux-kernel+bounces-872290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D038C0FD75
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B15434FBE79
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B24031B82A;
	Mon, 27 Oct 2025 18:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQFuoY6s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C8E2D73B3;
	Mon, 27 Oct 2025 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588113; cv=none; b=D59MQRslpDNpghp4sgUXPuuvK4pJJrthhQSgNV84zyx4l9S/URPcWYySOWGS8RH7KMhDBYjFC6Q61Mkt6hIZ7x+wYsAySpfUNdFXey+YN1MPVHGUtzWMTxmMfI+taTs+6uo55pXaVqwYgPWB+9E03nKTAV77GiGuQOnD4sDy//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588113; c=relaxed/simple;
	bh=FzhkkPx/bJH57tjT+tQuLUmnAYh7kimWNyLeFkyJm2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1Y0/8AY9AaKqKu6etrXH+uqLAS5GBqOrPK7vpNQX8oxs1J0+oHjXieJcyaujaVxN+se4tfRvVOJts7ujPUUfclrWk1w5yvC6D4RlG6eLNgeUMTbQfBMQ1FduIH6OF8IvaaPqNuBNloTuCL0mknoJF6WNsMwwTTz80lSctfjX/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQFuoY6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA6AC4CEF1;
	Mon, 27 Oct 2025 18:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761588112;
	bh=FzhkkPx/bJH57tjT+tQuLUmnAYh7kimWNyLeFkyJm2g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QQFuoY6sOPhRmbUaIIYGwELjo037kSApUYRJs+P3EQqCdDBecvGL5xDPX+E7Pe3eX
	 NPpObbBuncxo0rBnfO9rpv71PnBBaYt1mYR1/JzZqKplaJorhf1OgHpOZPzL17zsrr
	 PiKLqiT6q5LLGqnbO+NxbEpztdNm0NbzJ5Fr8uZwVJEP9dllYX3sfTltvRfVQiXHUC
	 6lwMushn+ymlRRFNEn32wtHRiWmfX8XCWrGCz9nC6QHoa02QRmDljNPqOx0AsAnqLV
	 m9DLUUs9NC3B/vnBAt7fHiJz7NvhJUaB0sVITCYNN7/NChH5U8C+VHmi/LZWkW7vx3
	 3eRSZou3PZjtg==
Message-ID: <ea00a07b-d0d6-49a2-a9d6-ef6c1ecf57dd@kernel.org>
Date: Mon, 27 Oct 2025 19:01:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add support for ST TSC1641
 power monitor
To: Guenter Roeck <linux@roeck-us.net>,
 Igor Reznichenko <igor@reznichenko.net>
Cc: conor+dt@kernel.org, corbet@lwn.net, david.hunter.linux@gmail.com,
 devicetree@vger.kernel.org, krzk+dt@kernel.org, linux-doc@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org,
 skhan@linuxfoundation.org
References: <408c1698-a8ad-4e16-8def-352c2c265f5a@kernel.org>
 <20251026184641.631641-1-igor@reznichenko.net>
 <a45ad6b8-b4d5-4e0c-8f1a-3641dddb240d@kernel.org>
 <e51c3dfa-406b-4dfa-bbb5-c31d1a2e0007@roeck-us.net>
 <112db7fd-3c0e-4c56-a553-5aca12965bdf@kernel.org>
 <0dfcfcde-d207-44af-ae7f-d90d623bac02@roeck-us.net>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <0dfcfcde-d207-44af-ae7f-d90d623bac02@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/10/2025 17:53, Guenter Roeck wrote:
> On 10/27/25 01:40, Krzysztof Kozlowski wrote:
>> On 26/10/2025 20:58, Guenter Roeck wrote:
>>>>>>> +  reg:
>>>>>>> +    maxItems: 1
>>>>>>> +
>>>>>>> +  shunt-resistor-micro-ohms:
>>>>>>> +    description: Shunt resistor value in micro-ohms. Since device has internal
>>>>>>> +      16-bit RSHUNT register with 10 uOhm LSB, the maximum value is capped at
>>>>>>> +      655.35 mOhm.
>>>>>>> +    minimum: 100
>>>>>>> +    default: 1000
>>>>>>> +    maximum: 655350
>>>>>>> +
>>>>>>> +  st,alert-polarity-active-high:
>>>>>>
>>>>>> Isn't this just interrupt? You need proper interrupts property and then
>>>>>> its flag define the type of interrupt.
>>>>>
>>>>> This controls a bit written into device register.
>>>>> I omitted interrupt property after looking at existing power monitor bindings,
>>>>> especially hwmon/ti,ina2xx.yaml. INA226 has very similar bit controlling alert
>>>>> pin polarity and binding doesn't define alert pin as interrupt. Overall, I didn't
>>>>> find many power monitor bindings defining alert pins as interrupts.
>>>>
>>>>
>>>> On INA2xx that's SMBUS Alert. Is this the case here as well?
>>>>
>>>
>>> It could be wired to SMBus alert, or it could be wired to a CPU interrupt pin.
>>
>> So please explain me why CPU interrupt pin, which in every really every
>> device called "interrupts", would not be "interrupts" here? How CPU can
>> even guess the number of the interrupt in such case, without
>> "interrupts" property?
>>
> 
> I thought we were discussing the need for the st,alert-polarity-active-high
> property, sorry.


Yes, we kind of do, I am just trying to understand what is expressed
here. If this is a CPU interrupt, its flags should mark the proper
signal level, including inverter.

If this is something else (or both), then this property might make
sense, I just don't know what is this.

Best regards,
Krzysztof

