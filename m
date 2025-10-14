Return-Path: <linux-kernel+bounces-853389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B00BBDB76D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 928DC353C8E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE550302CC7;
	Tue, 14 Oct 2025 21:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rocoI5F9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2789F24A046;
	Tue, 14 Oct 2025 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760478893; cv=none; b=K2kMEMEpg1JQsKXh7kvEzuKA3uVH820y3XZOvyJ7tEpdAWwda8xe3xRKCsblDNuxfw2AZIS3ScnwMfypNHLYM4VTwrFX35b+dk0PXQ6fbgTCbiYoQXJefENCggN5IjejgqBo1lJ5Xh/ryasl/uQrbdNZBGdf1Oxx+23Kky3MnJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760478893; c=relaxed/simple;
	bh=SJe55pwBMK7v+zE4FDLh/9wAcgkMSL5Vy9t/nv8YDtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTXyv30OvoUL0GJ2j4ZYIMyUV0x+95mz4ow846eK2vQaKZn+OC4+TfjSIt5KJeT1LtYjMjQysL12SgXXHAqEHDNb2TCvYsRCpRwDlC80k69qPpGYSaSGeqE4ztB/GqeOJ2s54m5XjU3luGgGILZZt1SYoquNKsFnZVFO6pzJDzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rocoI5F9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81C3C4CEE7;
	Tue, 14 Oct 2025 21:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760478889;
	bh=SJe55pwBMK7v+zE4FDLh/9wAcgkMSL5Vy9t/nv8YDtU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rocoI5F96pdeO+lorSrXlE52N4cYJImmxs/qvbIdK0edzhc1+Ww6Z/xv7utcnrI+Q
	 pRjekm4Kcog0VTccwWwQ0iDK1rXRmUrYreU7Q8nu7Lb5YPkxUKZRZx2MQD/jFHQ2Np
	 4hl1bzpeRjYDIMF4ipTgZVeJ/X8tzCkZscZuwUmbXFGnWwzE9VAJEmm7/fJsNR7MSf
	 rL4WxlXzE/peqEgdhyR+03XHiatJyTKWygb/pgPOm2JihQF0wTWml/siC7v9csD9kt
	 I5LrJUFCq80xiT/kPrCH+VFzGd6+zHxLQwiC10E5Z74o2ylX0LLKYTy6DCvXOsyAz2
	 se02lyoM89usg==
Message-ID: <1d1808d5-f166-488d-97b0-78fdd7d8ed0e@kernel.org>
Date: Tue, 14 Oct 2025 23:54:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] dt-bindings: regulator: Add MAX77675 regulator
 binding
To: Mark Brown <broonie@kernel.org>
Cc: Joan-Na-adi <joan.na.devcode@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Joan Na <joan.na@analog.com>
References: <20251014053142.15835-1-joan.na@analog.com>
 <20251014053142.15835-4-joan.na@analog.com>
 <512ffe3d-5ab3-4e87-afd2-46f0005a8d17@kernel.org>
 <08b4c0a0-cc59-4640-94ff-2d243c558a67@sirena.org.uk>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <08b4c0a0-cc59-4640-94ff-2d243c558a67@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/10/2025 15:11, Mark Brown wrote:
> On Tue, Oct 14, 2025 at 10:14:15AM +0200, Krzysztof Kozlowski wrote:
>> On 14/10/2025 07:31, Joan-Na-adi wrote:
> 
>>> +  maxim,en-mode:
>>> +    description: |
>>> +      Enable mode configuration.
>>> +      "push-button"  - Push button
>>> +      "slide-switch" - Slide switch
>>> +      "logic" - Logic mode
> 
>> You just repeat the name in the description. Say something useful.
> 
> Do you have concrete suggestions there?  I can see dropping the
> descriptions entirely but otherwise I'm not sure there's much to
> usefully add.


Then just drop descriptions. I could imagine datasheet has something
more, but if not, then really no point to copy paste.

> 
>>> +  maxim,latency-mode:
>>> +    description: |
>>> +      Latency mode for voltage transition:
>>> +      "high" - High latency (100μs)
>>> +      "low"  - Low latency (10μs)
> 
>> So use values 100 or 10, and proper type (-us)
> 
> Without knowing the device specifics at all I rather suspect those
> numbers are more ballparks than specifics.


That would be fine then. It should be reflected in commit msg, though.

> 
>>> +  maxim,dvs-slew-rate-mv-per-us:
> 
>> ... like here.
> 
>>> +    description: |
>>> +      Dynamic rising slew rate for output voltage transitions, in mV/μs.
> 
>> Except you said mv/us, not us. Confusing.
> 
> That's what I'd expect for a slew rate?  It's the speed with which the
> device ramps between voltages during voltage transitions, mV/us is a
> perfectly normal unit for that.


Yeah, but the property unit suffix "-us" says that unit is us, so not
mv/us. I think we did not have that case so far, unless I missed such,
so either we ignore description mismatch from property-units or we
change it to something, like "-mvperus".
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml


The actual type - uint32 - is suitable, so maybe mismatch in description
for that unit type does not really matter. I'll defer this to @Rob.

Best regards,
Krzysztof

