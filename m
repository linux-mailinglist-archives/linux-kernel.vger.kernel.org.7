Return-Path: <linux-kernel+bounces-870543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D2DC0B17F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65E61897350
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AAD2FD687;
	Sun, 26 Oct 2025 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB1s9PDB"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6082609D4
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761508693; cv=none; b=U4wHG9Aaog7vSJVojjwn7QAU29vHQH18EtAnV7M+WZoDYdlhtFrLiF28bN1wCikKcSU57oVH1vyGNIFW04rA7FzeQpDfDrYXaMRezvXOn6lvTC7QwaFzWKr2UMSRm4LXm9OornILCMa/Bo/BNM4GoaGVSuUl3VYv9s+xbhJd8n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761508693; c=relaxed/simple;
	bh=yOE0P7FWFoGaMhy1Bhi1naXUs1jG5gQoZnDqGoQWcSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAvoKOt6iYs608teV87ENN+XHraADrNxii5dg3sIKmSnSyu6NEtU2X8CsmY2zXxnleQn2gpHEhYHgGhHpmqKmQwuumg40HpZskmGBzlSOR/eG2QwT9v8JzUTz/PmwEs7fxtEYZ0o7VVsdFlui5TsPhRusJp3TTfG7zHlD3omHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SB1s9PDB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so2852245b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761508691; x=1762113491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rz+iPjrso650B0W3/FsE0e28IvCi/qUg0X/JHlyUrwk=;
        b=SB1s9PDBgJsQNM0MCxExgvljtAOM4F5hVfe7POB/MscBlVJDV2an679nt0/Mcn4yTx
         VEX0LLdOPzyNyj3lBCANxOHywE+Xw+1rcxSc90gzXE6mo2Cdx39BjAv+UEQwKwcz78z6
         Ag6XSeY0wIytk0JaN08QdLQbrCHZDajAWTtnAZIE3AF+H2IQlffoLftR6AqkNbO9mJ4W
         rT3UDWO9C2Wsf8ASmfxuoaxRikcGitB8ATsKSzytLJbm7XmkUpziSpFW9DlBeN+AUQsZ
         jqOvCvCDJtBmPW4c7O/VUS7bJjlkBZowEGX0KZgIZI39KtL4oyuTGD2dajLo79XE5JkI
         9UJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761508691; x=1762113491;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rz+iPjrso650B0W3/FsE0e28IvCi/qUg0X/JHlyUrwk=;
        b=vkOm9t39cU1+zmR27B3lzYFsSSgnqE2OMtRNOMSnW5HKWJi0OgH51ySosSwaPsCA/k
         BnZARIb0H1VJcsesCEhHhx7SSxcfoNdFPtkM083cDjt8ZfPj2zgKVr256tPOXBfxAE0N
         Evbll1r5Q5sqEeArFJDcOu1K9ClUu/j+C0hr8VDt9M2nyvK3mH+bLSBG8U8/MQGnC6l6
         TicMoPdxmLNBJyvAsKUC6bH7u4nCIMFKYoZUvdDncUDki0E1PfoMi6SvERImIjwKDwJJ
         jjRIDntVlw6QinGxxHXt/iDDMCV9hSzfgcoHf1yDDxi8Xiy+beA3HLpZ7CFmxZ5+zTIy
         vHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVewyDr4l8R4PBHBZTWP6RxtQjuKtl20odhjgYD4vzF+PoxcZYkuS1TyEvBcd0liZQgpCMz9/74HRhd5gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YytJJ40qZeIK6shc6QCgTe91ADqvjLmq2ZuDMsto2r8JENx5niN
	eGlvAHF3GuW1WNm13bUZumnY4CNSY9tp9SV4ujn1OFt8oO+s7RN4bVNi
X-Gm-Gg: ASbGncs8TFib6JadqIdOUyv9ju9/aRLxFRpEtGrfQY5SDrvOZuxgPs22J2bYe8csqo5
	59NSCIpokN5ji4WeFGy8ZYkHkyHILZAu3kMfmvywiewbSHmxgVUeYSfTwuZBL5PpxZm7QVQHsuK
	X5YF1J14Jy5UasPcNdrhADEnETEiO/5SgB+V3tDurno0mOwH7Abm+b9WMFnRWXdBHRwT5cFo3wA
	oguR1X+ONgJVZKMb1LAsHV/RpvtxZqhOjNeot1dD4IglsR0fl34GGIvSMo+N1Dly1dSb5qvtPF2
	O8q0GF4+cFXf2bLgdLiKdJ1qTB1LQtsfhy3l33+PFKNM8Z3OS45l24BWzhmxr0TgoTj5/zdBzOq
	5UDYpd9dNuEdGbdUaER6zsaN9ePrO+7OI0J1/ZWIFGgKS7tkQSebG0J4+0NWiBW28KqKbsX/zOi
	G3ssLIjNXgLOvPaLcRQRdWopqTvsL+uEp6O+jdm3iGgps3yZP+
X-Google-Smtp-Source: AGHT+IFoB+ruOh+nGUiptuYoaCYIh4e90e4xNspCvcjO4DwFEFbyG34XpfKFjr+dDPN56lOiGboX8w==
X-Received: by 2002:a05:6a00:813:b0:7a4:2294:92ff with SMTP id d2e1a72fcca58-7a4229495a8mr3384862b3a.27.1761508691177;
        Sun, 26 Oct 2025 12:58:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414082e10sm5525818b3a.55.2025.10.26.12.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 12:58:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e51c3dfa-406b-4dfa-bbb5-c31d1a2e0007@roeck-us.net>
Date: Sun, 26 Oct 2025 12:58:08 -0700
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <a45ad6b8-b4d5-4e0c-8f1a-3641dddb240d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/25 12:41, Krzysztof Kozlowski wrote:
> On 26/10/2025 19:46, Igor Reznichenko wrote:
>>> Subject: I asked to drop "binding" and not add "support for". "Support
>>> for" makes little sense in terms of binding. How binding can support
>>> anything? This is the "ST TSC1641 power monitor" not support.
>>
>> Krzysztof,
>>
>> Thanks for feedback, will fix this and will create following patch versions
>> in new threads.
>>
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  shunt-resistor-micro-ohms:
>>>> +    description: Shunt resistor value in micro-ohms. Since device has internal
>>>> +      16-bit RSHUNT register with 10 uOhm LSB, the maximum value is capped at
>>>> +      655.35 mOhm.
>>>> +    minimum: 100
>>>> +    default: 1000
>>>> +    maximum: 655350
>>>> +
>>>> +  st,alert-polarity-active-high:
>>>
>>> Isn't this just interrupt? You need proper interrupts property and then
>>> its flag define the type of interrupt.
>>
>> This controls a bit written into device register.
>> I omitted interrupt property after looking at existing power monitor bindings,
>> especially hwmon/ti,ina2xx.yaml. INA226 has very similar bit controlling alert
>> pin polarity and binding doesn't define alert pin as interrupt. Overall, I didn't
>> find many power monitor bindings defining alert pins as interrupts.
> 
> 
> On INA2xx that's SMBUS Alert. Is this the case here as well?
> 

It could be wired to SMBus alert, or it could be wired to a CPU interrupt pin.

Guenter


