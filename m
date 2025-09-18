Return-Path: <linux-kernel+bounces-823785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0435AB876FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B00D53A5C94
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA77627AC2F;
	Thu, 18 Sep 2025 23:59:19 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A197E34BA5A;
	Thu, 18 Sep 2025 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239959; cv=none; b=qpzJoOJbkOfJs1+1evl/Cwr2JKr5Mu9NWBYRYT90MsPD6aCcIvZN3mZGbWLTq4dk206Lh9ZPjUdXzyIri3sSI69sS40t6ozUZoI0pMhvdvetMklYMee1HylDWaLMtQkbcNyILbsQZt4qr6gKLUZI+xyFjNXQ2MekuHTl15uqNbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239959; c=relaxed/simple;
	bh=lavAnUNN9d/ZV3QJzI93O9nw5RwNxDQyBRkqDL+7+LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PWavY/gOvDmeIWfyncMxP1+CjbHUTyG+SzyIbrTZrb23xu5u7Aa76/FPQeyHMo8R3rSrFYKR4dqkynbneZ6k7PhL5xStpcTab17EGFKClkc2Ud3+KEaXd12GiDeyZymBpi7tUqiRpl3A4erKbgO1AjMG3djg5ZWR5mBhvLdeeQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip3t1758239883t0b647914
X-QQ-Originating-IP: ebRMGzBjijlWXuQsf6iwul141MP9TuMkYCuGXgTq/S0=
Received: from [IPV6:240f:10b:7440:1:ce36:128f ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Sep 2025 07:57:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2633226193335492939
Message-ID: <0DB47BC84E90B0E6+694b1274-4826-4ec1-9aa2-ca8aa790f61a@radxa.com>
Date: Fri, 19 Sep 2025 08:57:57 +0900
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
 <FBB5B30DE8FEABD7+59ee6f48-2ad1-45dd-8cf1-8b58a03513a9@radxa.com>
 <adbc2396-d5f0-4dd6-a65e-0dd78a58b9a4@wildgooses.com>
 <2325560.3ZeAukHxDK@diego>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <2325560.3ZeAukHxDK@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NZl/JFjf+G/9NnBAWC2/wJeh4AzqbtRYPSMN1AjWaIeQlmOgZHzuswFw
	MFTkVb6usk5d4A1zax0rQ3KC8+hZrFcRh/U9k35MY9eo4Pfd2aWWTKpAz2C209BQBFgW6SM
	1UF5XGW6mWpzfWSliuJZxIqkz8pQw2djRfHGOPpQL8GIIFCg8JfQMPv/unRGVGe9QiLeY8I
	lHxqlm1qNe40z8tEZR52xgt5asps3atmePwjTBSbK7i0tPN+cugr0rVO3Q8VTcGDmfGg1Nk
	8k+pbFudOkdhzj2mgtCgW1GyyVneLngmmMdQwbZJJQnOFso01rXueqDH5n3Ia7YxCF5reUN
	tYOU8PWKVYEwv2rmDmja77gbSXhPfNBrUi77iBhEmg41AoIcKB/HdKN3xaW+s1ttESKhTs4
	jocyKGSJ2guYErBOW2pPBtUK//pfktX/izVrpy4PGngYlpa2tI/FpyULlrqr7TawhxwduzI
	Mt08+PBiwJ/T5JzIG/b5TUDX8aTVnVyRowRc84aIZPAzhoX4Z46ezFPSkpCPu8aj1zof8PL
	QWyW2JJrSdVhPYZPRpDCD9azlMrv5TjK8amv7efR5HpcwC6i0xj2l2sX+kp0TkFga6ZsGn4
	jt0P5Iogf+Ns+rxh4U8dfMPmLPPJI2LwbqF6XJ6OxF9zLE0XqRxRMMXlF7LwR8oyrr0A7AW
	TgMEX9x8HTuKgkqpf/AILxXtk02V9NgOfbW57Zx3cm+QJfvRl/cAfSZ32s5rFiuln1cGQAM
	aCNWbZa+57NKRyQ5fACrTDn4zkL+F6qIKMS1gAxDRZ599ncSZsEFcNihQsJX2wS/nx6CcvG
	HxCL3n37pxUiMpOjzgNTCEDohqLp5ClzMnkYTuT497EAYkNOwFzai+O/LB/Y99lYSxK7HGC
	roL2ZJTARioDXHYNN/27qccS+HTcQOiltvipapkXpdjgUFFvGlIaXeAFODQyXXor+9u6J2E
	1ir41ekPl470t5rADbK8D1GgqyvneD7zV6dMRNxChciMufHbGuHSrAJFY0LTBXFjPQfKs+g
	jvY1RR6Q==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Hi Heiko, Ed,

On 9/19/25 01:18, Heiko Stübner wrote:
> Am Donnerstag, 18. September 2025, 17:23:04 Mitteleuropäische Sommerzeit schrieb Ed W:
>> On 18/09/2025 05:53, FUKAUMI Naoki wrote:
>>> Hi Ed,
>>>
>>> Thank you very much for your work.
>>>
>>> On 9/17/25 20:49, Ed Wildgoose wrote:
>>>> The rk3566 has multiplexed pins and the uarts can be moved to a choice
>>>> of 2 pin groups. The default rk356x-base.dtsi appears to default to mux0
>>>> for all uarts, however, specific hardware might choose to implement
>>>> alternatives
>>>>
>>>> The Radxa zero 3 shows that is uses M1 for uarts:
>>>> - uart4
>>>> - uart5
>>>> - uart9
>>>>
>>>> These aren't normally enabled, but we should at least correct the
>>>> default pinctrl definitions. Without these changes there will be
>>>> conflicts with mmc0/mmc1, leading to the SD or eMMC going missing.
>>>
>>> Sorry, but why do we need these definitions for disabled nodes?
>>>
>>> Or why don't we do similar definitions for nodes other than uart?
>>> For example, PWM12, I2S3, and SPI3 also use M1. Are they not related to SD/eMMC and therefore
>>> don't need to be defined?
>>>
>>> If users want to use UARTs on pin headers, they will refer to the correct documentation[1] to
>>> determine which pins are UARTs and will of course write the correct pinctrl definition.
>>>
>>> [1] https://docs.radxa.com/en/zero/zero3/hardware-design/hardware-interface#gpio-interface
>>>
>>> Best regards,
>>>
>>
>>
>> Personally, and I'm saying this as a user who is technical enough to fix the definitions, it took me
>> quite a few days to figure out what was wrong with the definitions and understand the intricate tree
>> of dtsi includes, to finally figure out why I couldn't just do a "status = "okay";" to enable the
>> UARTs... (which is roughly what is shown in several radxa supplied overlays to enable uarts on
>> various boards)
>>
>> So my vote would be to correctly define all the hardware for a given board. Then users can simply do
>> a status="okay" to enable and off they go.
> 
> And I'd agree with that argument. Setting up the needed pinctrl settings
> for the peripherals described in the device documentation
> ( https://docs.radxa.com/en/zero/zero3/hardware-design/hardware-interface#gpio-interface )
> 
> is the sensible thing to do. While keeping the peripherals itself disabled
> and for the user to decide which peripheral to enable.

I'm not strongly opposed to this policy, but I thought if you're going 
to do this, you should do it for everything, not just UARTs.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Heiko
> 
> 
> 


