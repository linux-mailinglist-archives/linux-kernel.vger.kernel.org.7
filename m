Return-Path: <linux-kernel+bounces-871719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 920C4C0E260
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 895D94FA66C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5590723E34C;
	Mon, 27 Oct 2025 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmdmKTKA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FD913AD26;
	Mon, 27 Oct 2025 13:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572582; cv=none; b=c1r/bzYx40By0vatMpwWX3fVA5WR2fhKgzNNyyNMmC0qtfHExNednfRZp0u/k20m4aDvgTomMZzsje/JaszpxjJUJTWiDCbcqxgQoXjwdyy83CD7KjmjZVF52dwVABvhreSZiLiJBWG7IrNSmjI1Hx2UHu0ms25Eur6tobXyibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572582; c=relaxed/simple;
	bh=rcHJcRZKbFz7WhScklCcAlWwdW0d+3OS+btBHZX02T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icgVeG2xJ/aQakKxAFj365ZMopBg8pdxJH1LzMPaTAsz6UShk+Wd+4KzVOWikUdJ+MYzhfOaEXXfgVDtQBUuY9WBSb7R3JxJf2pA7ePUDcCWWzIQYfXz4t7CtSiM2vYrCom95mcMs5rsP0KYrg3Ca8nJWfTS7jXVMsFsPSyS0jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmdmKTKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85E6C4CEF1;
	Mon, 27 Oct 2025 13:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572581;
	bh=rcHJcRZKbFz7WhScklCcAlWwdW0d+3OS+btBHZX02T4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mmdmKTKA2FV+TFYMId/4vvMV39KNtPS/Pl67f+KUCQg4Hz2DJOvXo1yXlhfRYDD39
	 HCxli1V5ug0wBVqnEeOvb5AK4W8eBRZVh+d60XeDRSLH5/hpOY8L+wEfpk1iSCFJzC
	 n9BYMsix4EZvdTuQxLPmOnNucp4HqsLCD+7XMqlmcop2tl4TRfiU/kX7Bam5Wt6WjP
	 VkJ4bz7H2f6nK+OzS104ZsG/AxzB29EjqTNc00xN4ACVQNmLKnpAcOXrfNNAs/dLk/
	 Rdoo1BOmBiYJLb8U7yBfEQhPF9Y/auayrA1DBNf0zH4daF/ZsQf0NisXdrIPSi3/PN
	 dV0ddZMZu/m1w==
Message-ID: <176b8cd1-8c70-4fb8-80c3-69a281dc1d57@kernel.org>
Date: Mon, 27 Oct 2025 14:42:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: lan9662-otpc: Add LAN969x series
To: Robert Marko <robert.marko@sartura.hr>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, horatiu.vultur@microchip.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.machon@microchip.com, luka.perkov@sartura.hr
References: <20251024192532.637563-1-robert.marko@sartura.hr>
 <f3bd99c8-eb70-40d3-9b43-fba56546f591@kernel.org>
 <CA+HBbNGZ3FwrGCtHX=mc8LQR9DCU84jqfhjFRGVDCJWtt+gdkA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CA+HBbNGZ3FwrGCtHX=mc8LQR9DCU84jqfhjFRGVDCJWtt+gdkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/10/2025 13:23, Robert Marko wrote:
> On Sun, Oct 26, 2025 at 11:10 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 24/10/2025 21:24, Robert Marko wrote:
>>> LAN969x series also has the same HW block, its just 16KB instead of 8KB
>>> like on LAN966x series.
>>>
>>> So, document compatibles for the LAN969x series.
>>>
>>> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>>> ---
>>>  .../devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml  | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
>>> index f97c6beb4766..f8c68cf22c1c 100644
>>> --- a/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
>>> +++ b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
>>> @@ -23,8 +23,15 @@ properties:
>>>        - items:
>>>            - const: microchip,lan9668-otpc
>>>            - const: microchip,lan9662-otpc
>>> +          - const: microchip,lan9691-otpc
>>> +          - const: microchip,lan9692-otpc
>>> +          - const: microchip,lan9693-otpc
>>> +          - const: microchip,lan9694-otpc
>>> +          - const: microchip,lan9696-otpc
>>> +          - const: microchip,lan9698-otpc
>>
>> Why are you changing lan9668? Nothing on this is explained in commit
>> msg. Also, list of more than 3 items is not really useful.
> 
> I am not chaning lan9668 but rather lan9698.


I clearly see lan9668 being affected here.


> I agree that a list of all possible SoC models is not ideal but I was
> just following the current
> style in the binding.
> 
> As far as I know, the whole LAN969x series has identical OTP so just
> using a single
> microchip,lan9691-otpc compatible is enough.
> 
>>
>>>        - enum:
>>>            - microchip,lan9662-otpc
>>> +          - microchip,lan9691-otpc
>>
>> Why is it listed twice? First you say lan9662 is compatible with
>> lan9691, now you say it is not.
> 
> They differ in OTP size, LAN966x series has 8KB while LAN969x series
> has 16KB of OTP space.

This does not explain how they can be compatible and not compatible the
same time. It's not Shroedinger's cat.


Best regards,
Krzysztof

