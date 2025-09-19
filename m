Return-Path: <linux-kernel+bounces-824373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11806B88E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B97527930
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C8A3090F7;
	Fri, 19 Sep 2025 10:22:47 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9367307AC7;
	Fri, 19 Sep 2025 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277367; cv=none; b=LTl0TBLZm3h6N357nKDIsLQMyWdTbJHlEFGxb5+KsWJrpM7OZz01gz/ApUqBPGDx5lDNuMlKQZjq6LhI0o2i5uSQgKJu8aBE73JCyFunSjGN9zsHAxiPqQs8zMdxago3ZBfEN8FqmxtK9toIiQI2D6/usmkPxRQcKsS/QxG98Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277367; c=relaxed/simple;
	bh=e5CpFgnR1eY39Yetf70XgUHYv1VYkT+qazRgSFCBqvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LH8DTG8FsYjxYd3jWIym9zX4OZoCUOg3R9dAj3B3ZNnmBD+z+Shx3ka4RE7+OGTG8b1HV00cOqjl+IFkQsSOsz5yZ0jSLqsu0q9NtD+4SogntUKrJOXV4Hwr6W1Sla/9W06BXv88QDTIal75VZE1O3orcRmtDPxHNaO+H1XZrFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1758277275ta8f180fc
X-QQ-Originating-IP: FaZuIGI3lqEvBtl92gk0ndR9LDofYDIzCT5EB3kaeoo=
Received: from [IPV6:240f:10b:7440:1:ce36:128f ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Sep 2025 18:21:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16849280493774206844
Message-ID: <E2F727E460ACE497+3eb0af61-5175-47f1-a2f2-4bae7471b916@radxa.com>
Date: Fri, 19 Sep 2025 19:21:10 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: correct uart mux for Radxa
 ZERO3
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ed W <lists@wildgooses.com>
References: <20250917114932.25994-1-lists@wildgooses.com>
 <2325560.3ZeAukHxDK@diego>
 <0DB47BC84E90B0E6+694b1274-4826-4ec1-9aa2-ca8aa790f61a@radxa.com>
 <1971910.g5d078U9FE@diego>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <1971910.g5d078U9FE@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NojR6Ao/DkEDOzfxtENjUyQURpJdQNHOroe4VshccZ3SVgNOr8liZPYK
	HX6UFTrhAyrNgkQ9TeeaTcAUvqsNCWEGKUuz2FIBYzAmT9hJ3ueXpVcGzUp3WUu+rbG3Xnt
	Xn76txT/HTFG6xlVroukdIAMduzlneXbQT0Os6d03CJjkH9arDHxTTnCY4ZEo6qjIW1kPwO
	qP6xx6DOeQP4Y1tjMiOBfEfuRjomVXcJ4469GuwLKGFincYKIT5bL5qXydMc+U1SJGGmOUc
	N+BwkdzODiL2QI3/jy48fAjE15gSIFZX/i47+HgqbcvpyLk4yR+7jkmVQ7TahyofEgE8sAk
	MYYcZtl1iyH7fX1BMukcCDA6E2zTMj9CZP+7CpuRC9S0tBNxOk/mbhqJT1holqLXuN0Pin6
	zyR99PMN/UVP09hjU4qakG/kzO6Q3dpgX0rmATtXX6a1CAIZldwr8ogOtC6RPlbUL3TmpZn
	PCFVK9F/YV0dQ/XTyGjoXYHAby0xlneX/GVE1ySBlDe32YOlfCEj+w5d1Q3k04Is8rTUxb+
	3iCa7aC6qNFBJjw5Z1H20oQLc7bxUuCO5zLEB3bJGBgNuVsAWy8as2/tFIhOAFuh8jbqsy9
	G9gl2hFJL/K1RY8H9nTeJPo4UB0Ctmzw6M4ncVM1l6Gp79TW6LP4FRJmGaKCw+rGI+cQK65
	HENUPwf6MrFguRuJQKqPtK3Wc6xG2kjBf0+5A169jEXWMvk3cPl9xUjk9n0FoX9HQcu69Cm
	sb7uawSBubOJwinUII9bkIvfk1g2vRZ1YdzWBBrwPKngquDxcvl5Nb/imPAwur46I4Q9LLR
	zgJm/oDdSrZyBdKxuNJ1upm4DkUi5oq/TpVJ6ikZVvuah/3bavC/HAJkroBDftNfFpk+vJL
	axrp+7L2vU7pK7gRNdTCBIVRu6ZpkhkiQQhdcegZJxJ0b4alY/NBrPLJc5HJorCY7BoMFl8
	9Cg/XVXNE+vFpK/ujEH7Vk77q18MPRf8rWjjgVNdp/gsoFvSIqbePgM1M/lsdMhQhynI85D
	zAan8N6n0/dZ/dCT+FGIDCY7leQrVIi49rJfPD33ORFQBxRCaT
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On 9/19/25 19:17, Heiko Stübner wrote:
> Am Freitag, 19. September 2025, 01:57:57 Mitteleuropäische Sommerzeit schrieb FUKAUMI Naoki:
>> Hi Heiko, Ed,
>>
>> On 9/19/25 01:18, Heiko Stübner wrote:
>>> Am Donnerstag, 18. September 2025, 17:23:04 Mitteleuropäische Sommerzeit schrieb Ed W:
>>>> On 18/09/2025 05:53, FUKAUMI Naoki wrote:
>>>>> Hi Ed,
>>>>>
>>>>> Thank you very much for your work.
>>>>>
>>>>> On 9/17/25 20:49, Ed Wildgoose wrote:
>>>>>> The rk3566 has multiplexed pins and the uarts can be moved to a choice
>>>>>> of 2 pin groups. The default rk356x-base.dtsi appears to default to mux0
>>>>>> for all uarts, however, specific hardware might choose to implement
>>>>>> alternatives
>>>>>>
>>>>>> The Radxa zero 3 shows that is uses M1 for uarts:
>>>>>> - uart4
>>>>>> - uart5
>>>>>> - uart9
>>>>>>
>>>>>> These aren't normally enabled, but we should at least correct the
>>>>>> default pinctrl definitions. Without these changes there will be
>>>>>> conflicts with mmc0/mmc1, leading to the SD or eMMC going missing.
>>>>>
>>>>> Sorry, but why do we need these definitions for disabled nodes?
>>>>>
>>>>> Or why don't we do similar definitions for nodes other than uart?
>>>>> For example, PWM12, I2S3, and SPI3 also use M1. Are they not related to SD/eMMC and therefore
>>>>> don't need to be defined?
>>>>>
>>>>> If users want to use UARTs on pin headers, they will refer to the correct documentation[1] to
>>>>> determine which pins are UARTs and will of course write the correct pinctrl definition.
>>>>>
>>>>> [1] https://docs.radxa.com/en/zero/zero3/hardware-design/hardware-interface#gpio-interface
>>>>>
>>>>> Best regards,
>>>>>
>>>>
>>>>
>>>> Personally, and I'm saying this as a user who is technical enough to fix the definitions, it took me
>>>> quite a few days to figure out what was wrong with the definitions and understand the intricate tree
>>>> of dtsi includes, to finally figure out why I couldn't just do a "status = "okay";" to enable the
>>>> UARTs... (which is roughly what is shown in several radxa supplied overlays to enable uarts on
>>>> various boards)
>>>>
>>>> So my vote would be to correctly define all the hardware for a given board. Then users can simply do
>>>> a status="okay" to enable and off they go.
>>>
>>> And I'd agree with that argument. Setting up the needed pinctrl settings
>>> for the peripherals described in the device documentation
>>> ( https://docs.radxa.com/en/zero/zero3/hardware-design/hardware-interface#gpio-interface )
>>>
>>> is the sensible thing to do. While keeping the peripherals itself disabled
>>> and for the user to decide which peripheral to enable.
>>
>> I'm not strongly opposed to this policy, but I thought if you're going
>> to do this, you should do it for everything, not just UARTs.
> 
> yes, exactly
> So patches for the other header peripherals welcome :-) .
> 
> But still it's nice to do it in steps like this one, as it makes reviewing easier.

I agree.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> 
> 
> Heiko
> 
> 
> 


