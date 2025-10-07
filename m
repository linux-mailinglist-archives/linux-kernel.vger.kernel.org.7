Return-Path: <linux-kernel+bounces-844376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D50BC1C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC653E20A9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB8D2E0B5F;
	Tue,  7 Oct 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJMAWVON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6792C9D;
	Tue,  7 Oct 2025 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759847550; cv=none; b=dkbp0wJ6597nujYlMHYVF+ZNjRhPtEmeyVsBWxGBm1tLAFZ2/fM3nEe3U4pcAQsX0kitXyjumYyWELT+f+roEEfXt4eRdHtJOkhqnrvUWKvxDp+egcRHdxZmad01T9/hrc6Dsai85es37HycO7jM3z0nqzICbegwOS/wVTeNtCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759847550; c=relaxed/simple;
	bh=r3KTorr/hJ49ML3BqGKrdyJyFFjrREySUrtwB9NkDME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAbyd5jyG/O5W1+Y7aVX5Q6cfsqGf/fLTwX+4Wr6nwoJNucETdXh3kcR6NnhpYCQDgROhwtnS3JS9KA/vnwd3IwMqjAbogCB4dCffU1764WGEVBlY0K96R/HA+1TS/l+2znXD03696WOuqQgwNsBxiuxGMcfqXHSFX92bPuJOX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJMAWVON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B72C4CEF9;
	Tue,  7 Oct 2025 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759847549;
	bh=r3KTorr/hJ49ML3BqGKrdyJyFFjrREySUrtwB9NkDME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LJMAWVONH5ybNH2CymIh49T72KAz/glHsbK3zQlCOGOwmZw1q8CY5ZelJSaGCDN/S
	 TiZsYzFgBzlewMCP9Hvj7cMq689qMzCcUUaZC/oM7DSY+yoof7mHLoz4S5hGOqSJ1k
	 KMOTo7lCSFcooDD1puulj3kozAtdI5vRyMDmTudf6cbBERJ4yHhLNcYAEyhBudKTPl
	 I50Eq8bJuumgdxBt2eEb1YT4qElr2UO0U8/QviWm2jiSrALSkWbW0ccwFm1QdlVEO3
	 LRSmmJcGAo8aiKsEEMBGuoqdw5wzKG/RYfekAb0+YJL1u654W7ejw8WfhRAsvjK+Zw
	 t+fmKzcbgKGaQ==
Message-ID: <ea4f6245-631b-45b7-a432-a5c417c5a9ae@kernel.org>
Date: Tue, 7 Oct 2025 23:32:23 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: counter: Add new ti,omap-dmtimer-cap
 compatible
To: Gokul Praveen <g-praveen@ti.com>, j-keerthy@ti.com, vigneshr@ti.com,
 wbg@kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Cc: u-kumar1@ti.com, n-francis@ti.com
References: <20250909080042.36127-1-g-praveen@ti.com>
 <20250909080042.36127-2-g-praveen@ti.com>
 <6faff5b1-65b1-41ee-aba8-8c06a2bc6f58@kernel.org>
 <9653740a-44fe-46bb-92c8-f7fc26cbe5ee@ti.com>
 <30101fb9-e2eb-4050-896a-7be629ced44d@kernel.org>
 <2de3151b-eedc-4209-8b20-53473cafacef@ti.com>
 <1561d6f5-bc60-4b41-aef5-3e22a23ee133@kernel.org>
 <20fd5c31-eb37-4f48-9774-62a05f416bab@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20fd5c31-eb37-4f48-9774-62a05f416bab@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/10/2025 18:49, Gokul Praveen wrote:
> Hi Krzysztof,
> 
> On 07/10/25 15:09, Krzysztof Kozlowski wrote:
>> On 07/10/2025 18:23, Gokul Praveen wrote:
>>> Hi Krzysztof,
>>>
>>>
>>> On 07/10/25 12:05, Krzysztof Kozlowski wrote:
>>>> On 26/09/2025 18:06, Gokul Praveen wrote:
>>>>>>
>>>>>>> +
>>>>>>> +  ti,timers:
>>>>>>> +    description: Timer instance phandle for the Capture
>>>>>>
>>>>>> So the only resource is phandle? That's completely fake device then. NAK.
>>>>>>
>>>>>
>>>>>
>>>>> The OMAP Timer IP can operate in 3 modes: Timer, PWM mode or capture
>>>>> (mutually exclusive).
>>>>> The timer/ti,timer-dm.yaml file describes the timer mode of operation.
>>>>> It encapsulates base IP block and reg property is also part the same
>>>>> binding.
>>>>>
>>>>> This node represents the capture mode with phandle reference to the
>>>>> timer DT node. This is modeled all the same lines as how PWM
>>>>> functionality is implemented in pwm/ti,omap-dmtimer-pwm.yaml
>>>>
>>>> Different modes do not have their own device nodes. It is still one
>>>> device, so one device node.
>>>>
>>>>>
>>>>> Now, if this needs to change, please suggest alternate.
>>>>>
>>>>> One solution is perhaps to add a new property to ti,timer-dm.yaml itself
>>>>> to indicate the mode of IP?
>>>>
>>>> Not sure, depends what this really is and how it is used. I can also
>>>> imagine that consumer defines the mod of operation.
>>>>
>>>
>>> For a timer operating in capture mode, there are no consumers actually
>>> and the only way we use it is through sysfs.
>>>
>>> Would it be good enough if I have a separate "mode" property for the
>>> dmtimer device node just like how it is done for USB as follows where
>>> the usb device node has a "dr_mode" property to decide on whether the
>>> usb should act in host, device or otg mode.
>>
>>
>> No, because of all my other comments in previous email.
>>
>>
> Will having a separate sysfs property for enabling capture mode in 
> dmtimer be a viable solution, which will then eliminate the need for a 
> device tree property?
> 
> It would be great to hear your feedback on this, krzysztof.

Could be, if this can be a runtime property. My questions and doubts are
indeed not a very clear guidance, partially because I don't know all use
cases for this hardware.

Lack of PWM consumer is already an indication for the driver to
configure it in other mode, for example.

But think rather why choice of mode would be board-level static
configuration. If you cannot answer that, then it should not be a DT
property most likely.

Best regards,
Krzysztof

