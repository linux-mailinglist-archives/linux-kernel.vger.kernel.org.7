Return-Path: <linux-kernel+bounces-872182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D93D1C0F785
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110D319A3090
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B292C3148A5;
	Mon, 27 Oct 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Osy3bMHq"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4E3128DC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584037; cv=none; b=HDtnkZ8haT8fFQ3G2NWaLjY9XWt9y5Nu5ZzxrgX481vA6c3pr3rhCQ7R6VPZ4kZxFBGdrfoQbeBmgjRqmzzjgeDU4aV3/X9cspmUIwGFoX6gov5hhWbTa9FhAbjFpiFXi7yPvlGxXckAyZ0xEYTCevg+95leSbRAHD7B7wk90N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584037; c=relaxed/simple;
	bh=bjtZvodF4iC8SXP8RIJixhrHH9kdGCJEe8zX2Z2VOw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMKiKYt5mu51uuPUC+H2gA2KxaiuATQRpaSYssVvNCWccB2VG9Eeesjq8CupqKjyM7cNn40fKb7TuvhOz1HvcE2QQZyPONaETD4lD/Ar97KS1r+Ntqg7H1f+oT0ks6fzPEUUl7QZc+R8JEqkpSYn+jhYKRdORnHMMy66xwawmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Osy3bMHq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4743338b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761584036; x=1762188836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9NDuIHfeCDdX2wqZjc4Jxxi1StzQQhZtJcusn2VZs5E=;
        b=Osy3bMHqs8Gs4kHSA30m9ZcjBtvq5rXG3nS+Wk7SKk0rwLBTZwSTfkZrEebf7qy2Ta
         jQEbGGsRezUJmqgVa+HBr/hwAkk5r2zNPjbTpKDDnxCHSUSTOBxw5xQFghiLtEeNNdmi
         keDbZvjZZrrb46Ew3khiRHYnaYtL/nEtWQKEUhvXRlMjpPMl5wK88YKmxTjb4yU48lxs
         HXG4f8cXR+IwWHoFPPzRP88kGcRuEfki0KUyVUyYTm5sXxQtKukDj+OrMw1SOJ87zahV
         F2vP16XtXNJA9c0sSp/Ozx3wWTugT5emqH1Dhquv8dIWFa2wtfF1EOWR2qIz1nXIzK1x
         QMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761584036; x=1762188836;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NDuIHfeCDdX2wqZjc4Jxxi1StzQQhZtJcusn2VZs5E=;
        b=GXRNlrzePs8AaKzDnCqLUKDWxBo49y4+LtpvaCMO2Rfiuj0UlMjP/hclF5dcrFq27h
         kkj5eThpcxbLOhNibSWvx3CIglEkbuulb9WYqZxpHgMHqOiLnhVmr69EdxDmiByThHCK
         bA3I8a6CC6ZfKwrQZ4Jl720Wu1wy8xj67/rMxMkUmYvez/PDldTLwgiNgvZHykJXjtYK
         WMRrRVEVBscBItCYCcg89eN921guz/lzLGuoKK0BECHbD7g85XC5W26/jBRo+cJFuLHM
         WgbwCWQKXcNa48oRfX4fTS3d7zr62O1BE0PbsAtDJ2GrPBBTvqmZR4YkOkCHKGWsHEUO
         Nu7g==
X-Forwarded-Encrypted: i=1; AJvYcCWNHg7aUwhdQXFRHCfRbE9HvQsjwKEr52lpr6EAg1QmG5Sja8j5eiUkMYc9mTIdFvI+FDAF9kVsJ1n/ywg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhIQaL+/Q7PB2AIA71RjRjehnv3lfGSH9bdfa02znmhDgeVqJ
	L1pSNBsGFpGMQ5CsCz4fqs/WgxAZEJB2j9rWQNgI08c/Mj4iPYertm0eyeF67g==
X-Gm-Gg: ASbGncs64JRGUH2NmrEn/dD7Eb6fIv7if9WE3VMtvwBef8Ll+RxV+RvQ2C3uBTtAWGi
	FjrH2SlznoZayDuQj/vmG+eq5UtlyW39GpGDyVV2qfwWVy2JDpYO7m0PlUcftB4SMT+686hBiuO
	4wgyAVMQlJ9c2lbU9QndM6b5YM6IzbRzob52aTqQ3QpyGDqsykSCdAAgjn9nGKXEzWPHy+01Fy2
	W56Yxo1WIj9/mbvUpunzM8ZhrVnb1/ngCK9e0KtlRAUSC5bWxiXwuBaNueL03IIPB0/09ljcAzF
	j26NCODsN2BpztVeNP+OLPy6+zvtMDC+0o65eBf7/H5GdoJz69YeM4oIzBtnrAXim3gGxNKkD5Z
	2vP3UptoVjcZJdhofs4jgeNENMHfv4I/2tr2Y8Oi6Rj3wkwz5JgPSsthrkkUJ3hPg88Nf7jo4MA
	N6GTjXdX1+uJzKJDsMGCS27udyycB3NQQYMOiw73+cTbyLfaMy
X-Google-Smtp-Source: AGHT+IF4dFJWqD8ziRWUk4WOLl1Z73HSPs6staL5LnjdEhDwjm8lRRD5dL76dzXSVXC8kqSVIGEa8g==
X-Received: by 2002:a05:6a20:1586:b0:327:957:f915 with SMTP id adf61e73a8af0-344defde793mr147477637.24.1761584035563;
        Mon, 27 Oct 2025 09:53:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41403fa75sm8714839b3a.28.2025.10.27.09.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:53:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0dfcfcde-d207-44af-ae7f-d90d623bac02@roeck-us.net>
Date: Mon, 27 Oct 2025 09:53:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add support for ST TSC1641
 power monitor
To: Krzysztof Kozlowski <krzk@kernel.org>,
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <112db7fd-3c0e-4c56-a553-5aca12965bdf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 01:40, Krzysztof Kozlowski wrote:
> On 26/10/2025 20:58, Guenter Roeck wrote:
>>>>>> +  reg:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  shunt-resistor-micro-ohms:
>>>>>> +    description: Shunt resistor value in micro-ohms. Since device has internal
>>>>>> +      16-bit RSHUNT register with 10 uOhm LSB, the maximum value is capped at
>>>>>> +      655.35 mOhm.
>>>>>> +    minimum: 100
>>>>>> +    default: 1000
>>>>>> +    maximum: 655350
>>>>>> +
>>>>>> +  st,alert-polarity-active-high:
>>>>>
>>>>> Isn't this just interrupt? You need proper interrupts property and then
>>>>> its flag define the type of interrupt.
>>>>
>>>> This controls a bit written into device register.
>>>> I omitted interrupt property after looking at existing power monitor bindings,
>>>> especially hwmon/ti,ina2xx.yaml. INA226 has very similar bit controlling alert
>>>> pin polarity and binding doesn't define alert pin as interrupt. Overall, I didn't
>>>> find many power monitor bindings defining alert pins as interrupts.
>>>
>>>
>>> On INA2xx that's SMBUS Alert. Is this the case here as well?
>>>
>>
>> It could be wired to SMBus alert, or it could be wired to a CPU interrupt pin.
> 
> So please explain me why CPU interrupt pin, which in every really every
> device called "interrupts", would not be "interrupts" here? How CPU can
> even guess the number of the interrupt in such case, without
> "interrupts" property?
> 

I thought we were discussing the need for the st,alert-polarity-active-high
property, sorry.

Guenter


