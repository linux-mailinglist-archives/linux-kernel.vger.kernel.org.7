Return-Path: <linux-kernel+bounces-861303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C44BF2532
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F2D18A6514
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4004627E1A1;
	Mon, 20 Oct 2025 16:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MC2v0136"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA172773D4
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976672; cv=none; b=MYTkiM8PSkCrwiB/WvPirjlbTxK/euXEJsu4mIZ0BrX5nCyJLIb/IIH9/leqrJyZP8J8BfwhoyxW/Z7YaTOxkYes+rksWr93KCRLKNzuOKhSs1Dj+1NyxTAPqnfa+TYBMzO7aj2KSD6DkDIlrgEwuY/C4J2HmW2O6++Eu5ON7Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976672; c=relaxed/simple;
	bh=US9z+1/jx18tGTIEHp5xz3x75YUegAqC8biDYDf9R9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2K2/pP+JLY4Xcm6KbmF8kuQRdseW2BA2K1m9jeODvPI0xzFvQB5VJopOQWPoX2sXE6rckE/mCuVSXXw1L8o407l1e3L3cslqNCtRQF1Znw9SdvSHewSJZpdlrvjIpPMtoLJtZVG6upJ+GbKU8cCfD9vNHR/6xh4rucC90J/zWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MC2v0136; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47105eb92d8so7241955e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760976669; x=1761581469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=czFcyiI0D7UHfvNgP065c7neA2nLqXk0WjnumDdbO9A=;
        b=MC2v01364S3/kI6f3waNXCEpIbQp1JmDSTcqMXowZp2B1RtuqVpuGjfJanC2UXPih8
         +DUWzUpRXCUHUDAJw/2CtNKNlI9in48m3bOuyFslJakC/gZGyJfXqfbNXs5i4EuTbsWt
         zl6/oP1Z+035tVpoGpiGN934qy5Fdcr/db7r+68F39LAgMqVBTtf2OGs38xYd0LbGL2Z
         ZHBFCrQPU60Cj7xQ8GAcAOVPiS8TfB8D+9NQmWu2nRXAplGA6Wv3UKkjaMn/1xsCgLvT
         coYN0vUFQWvydMxUCyme2bBWfEcMDhdakIfRiuaMgH5UYEhPMvZirouQ8Y0Sd9InvEWz
         zKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976669; x=1761581469;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czFcyiI0D7UHfvNgP065c7neA2nLqXk0WjnumDdbO9A=;
        b=sltqIwNWzNrUb1/Jc3OFQMM9Q5NcnMgcYNzHUmtdFV1Trxti70bJ1jjWesdtERti9s
         ZnbRyB5zwvZRZIT6oefPtsblE6k8yFJ48E5U6JgGsdpwyI46rJ4S++7G9ts5BAx+diPM
         uBXHJqd1BPWU17v4Hj0Y+8qLlEJF0M4ChZ6YrBoHe9V/kCJX9RKZf9n+SvnjTB5KdaWq
         HJ3Z99r96oypLbkUFuxsGb8xGZPic/zcH7L9Nqf2UU574sgc7Cg5DhwFgRkT3viBEt3r
         ElWfwOBvDBZlqXRYpbuTq+/h3tLMrVLv0u75DUhqQTYmkF1S+Z/5Fc1VUUdOpPxKgTwa
         h1+g==
X-Forwarded-Encrypted: i=1; AJvYcCW79AhgC7KexEAWzl5EtWd2fp+H0dn+o3UZxsxrWF05nfkIpLUxQTjVFjzTg1mYhrlJOgedyezoLBYOQco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU9jHy7tbSDkMu/PiRhha3Ocy5s5FHoc9iXOy7ITXbVqbQjRB1
	wVed6Y4e34oF2KOLLTtEGlCQnanpYGlY/fPMRJdc3sPIupDUleL6JZK0ewkecuRhGTs=
X-Gm-Gg: ASbGncuKpGjkjayYYmaInX2aS9ebwrrFHTqYFJb+VWN4/gkVeoo+NBt+gpEicxsFP4d
	hiIbV93ZiOyq93uRKqJpvOvmN6Nny3rQ0WzaF+JdVZbWCJg7YtylZLGrX93arRS21CvH4fj7HhE
	OfTQ0mRU6Z5ID37Nb0w5V0GnFBAilKuA0pxT0cj+tKgsuFhvZ59objNcxTZLvXEQmaIT/smDCGs
	o50gX+NWvXBkTaflnkFkucqrHg8Wbx21zChggBCpIeWYUd3BQXwM1I6AS2Vr7fFW6k+Jl16xr7h
	pNmjiwlmQ628PU0wY06Px3KrpmCxXQAQKJ67EuC2ks0JMMWsIQaBSrNeIFJzFICQDzTY6jb8rFp
	UPqSHJhsf1d4CmFZD8djW52tbPbuJ2Eu2f2MeCsdhdEuchToPKZe0Dud2/VroPh8fjF5U/Zg1NI
	0zSXagg/QYgInnOWfYv8PI
X-Google-Smtp-Source: AGHT+IERHetueVqe3nzm/yR+aLf6DfrYJu0onqTx/WS1ZKwLI4kcsMlx5kLKdRLOV+WQFMsT/gPxbg==
X-Received: by 2002:a05:600c:4e8e:b0:46b:938b:6897 with SMTP id 5b1f17b1804b1-47117874414mr57922005e9.1.1760976668967;
        Mon, 20 Oct 2025 09:11:08 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ba01bsm15740360f8f.41.2025.10.20.09.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 09:11:08 -0700 (PDT)
Message-ID: <c99820d9-4753-403e-adf7-b2b9fb496925@linaro.org>
Date: Mon, 20 Oct 2025 18:11:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: mfd: Add sony,cronos-cpld
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: robh <robh@kernel.org>, devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Georgy Yakovlev <Georgy.Yakovlev@sony.com>
References: <948400747.1748562.1758824253627.JavaMail.zimbra@raptorengineeringinc.com>
 <20250929141113.GA3987541-robh@kernel.org>
 <924260297.1801829.1760974499327.JavaMail.zimbra@raptorengineeringinc.com>
 <f6f9cfc9-b26e-4358-8781-6ce75075d13f@linaro.org>
 <1626454153.1801886.1760976086710.JavaMail.zimbra@raptorengineeringinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <1626454153.1801886.1760976086710.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/10/2025 18:01, Timothy Pearson wrote:
> 
> 
> ----- Original Message -----
>> From: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
>> To: "Timothy Pearson" <tpearson@raptorengineering.com>, "robh" <robh@kernel.org>
>> Cc: "devicetree" <devicetree@vger.kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "Conor Dooley"
>> <conor+dt@kernel.org>, "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Lee Jones" <lee@kernel.org>, "Georgy
>> Yakovlev" <Georgy.Yakovlev@sony.com>, "Shawn Anastasio" <sanastasio@raptorengineering.com>
>> Sent: Monday, October 20, 2025 10:58:40 AM
>> Subject: Re: [PATCH 1/4] dt-bindings: mfd: Add sony,cronos-cpld
> 
>> On 20/10/2025 17:34, Timothy Pearson wrote:
>>>>> +  watchdog:
>>>>> +    type: object
>>>>> +    description: Cronos Platform Watchdog Timer
>>>>> +
>>>>> +    allOf:
>>>>> +      - $ref: watchdog.yaml#
>>>>> +
>>>>> +    properties:
>>>>> +      compatible:
>>>>> +        const: sony,cronos-watchdog
>>>>
>>>> There's no need for a child node here. 'timeout-sec' can just go in the
>>>> parent node.
>>>
>>> Could you elaborate on this please?  As far as I can tell we ref watchdog.yaml
>>> and need some kind of compatible string, so why would I break out timeout-sec
>>> directly here?
>>
>>
>> Please look where the comment was placed. Under $ref? No. Under this
>> compatible. $ref goes to the parent, obviously.
> 
> This is not an area of the kernel I'm normally changing, so I appreciate the insight.  None of this yaml syntax is particularly obvious the first time it's encountered, at least not to me.

Sure, apologies for sounding harsh.

> 
>> You do not need kind of compatible string. Parent already has one. You
>> do not need compatible strings at all to instantiate Linux drivers.
>> That's pretty common pattern for most of MFD-like devices, plenty of
>> examples in the kernel.
> 

Maybe this will be useful - bd96801_wdt.c is example driver which
follows correct design and takes timeout from the parent (wd->dev is
parent of watchdog platform device), although parent's bindings lack
$ref to watchdog. I'll fix that.


> Understood.


Best regards,
Krzysztof

