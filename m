Return-Path: <linux-kernel+bounces-848717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB9EBCE6B9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEC7C4E7360
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 19:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C7301713;
	Fri, 10 Oct 2025 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtsOKhaF"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CC21F03D8
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760125594; cv=none; b=jz8t2h0DP6kMTfYFV6Vqbf8aXi40VNn4JraTTI9TX2+NN+bE3vkNHYLUJLF3DMAoZEvdnSaGVhjDuuew/DtSqLZYDw2bxiKaYlr2NT4pq30I2kF4MJTYZh2HKYbdAdii1bkJ3nd9p2kf5hbe7HK7m9U58Q15aVwG3FHUCKxqTRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760125594; c=relaxed/simple;
	bh=8B0TxVKymUNconocVqaGeavIGwY7T0t3daf3VX2qAXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7oKbHRavGKU+2d3/ElMixBNrlrGvSsffg/hjPdDf21WBxl3GAUXFA8BsAd7CIQQqVoatcjOX529gJlUeyJejBV484OcMsrtsQXH60zw9rh2CgR0wbkI0gY6C0lLZhVkqhvW5ZpTPCLrNNExfSjv9wgFqiaW37q8jl5gFfsQAM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtsOKhaF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so2579215a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760125592; x=1760730392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2hlRuh4XWPBhw9XhKqVrIvF45UiA/YFigu+0H9k6fc=;
        b=EtsOKhaF/VZhqf/Xt+MOS0/65DKEVJ9zYyZQFL1pq0/lfqw1SQbZqVxxoDoCOY1Kd/
         wqtl48L4xkumSgAd6R6nn4E6xv/XjlPvzM0rNFlXGj9GXL+Ar+bmGQrtGUWw8Vhck5XT
         dQfYTwWYrgWRKMyG3GoBl6habgp/HqPqdHxcTh1zzoXzZn7xaMXAgytSTVF0+aEsqdm3
         JMUHDJJaJLIpScAUJNGOfXmrT7iWeJfvKCgG8CuT1DniJMrdPkX/Gqa1yyuxaIz4D4tq
         CAdap3LA8YObH9ugImFLxxbSczDTcwZ47EsBfqIUS0Jx+cgrexdnj5E/y4o6nox/nqeo
         pNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760125592; x=1760730392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2hlRuh4XWPBhw9XhKqVrIvF45UiA/YFigu+0H9k6fc=;
        b=RlpKkzAUu45tN3SlxJOgnaJNePrX5ucnTNh7B5LLGA2cIwPV2NebH4M46NyI/e4e8t
         +4NgpF4GPJ7mU/9M91wbPJGbmRpe1mst0E42uPxtDMyy+OyeK6TfWli/jqEPLmV6ZvYy
         ofkr7G23cmh7ybcFspJKP+htSUBmat2BsfwG6j84rTwrE+583OwJJe3GGhi3KCJQKl6m
         8lWsWtn66NhRo9vq8Fo1tpratiPH3DgnRIWsz0dkILrwQf4YGxnM7aTACf8EFYcsaCWR
         Goxna7cO5VnSyHaFeKQmAhip4sBOgt9YQ4dyZcU4cCDZHuO8dIa8Rczbkk/wKk665C6J
         +lPA==
X-Forwarded-Encrypted: i=1; AJvYcCU0MbfOtUyPKr4KeOk6eKxpaVssvpD4Ztf1hVQnvzaEdw3N39sydbLmpBRTsnUFJv/IOGkJEUq6ZJwobeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8lg5zuyMCmXmwXdnU9592PGq3/7eQ95dsIaVtidf+sByeS3d5
	fn6s/lKAOJA353qhLqEggNxTPaTQHz5uulMq0kAzhj/QPvRY5MG3Rz7v
X-Gm-Gg: ASbGncswgqjF9KXgTdU3/LYLGKjQUSaintuZ46nY851x/KJvVymAXsit2NrPv3dgy+y
	k91zsDU02/aDBu3UUbrrLsZKAavNbQYR7IPJccNxh3SWKU+xnc6uRXGP7Gb0ULTY6R2mVrcyRXk
	bzxXILykf6iQoP5shMOL74+w6bFhZn818b4Jj9Z2ARyDbetVLiAOapKV2KLS3sAcpc7+h4zA2/r
	BprTYkfduAGvGMNb90DJUOMjemfNOZvcmNGD8RNwiovAKdTekADuGjHWqrIMIeZYLKJojOImnK4
	zjWCIrNqM7f5ggkwc57Xxr3cMgtfUZzvfsmbvj5PS/b+gpgaqGRSCnp9eoWOsXaXebCYyTzALjF
	wlJVGa4Ln3dI35zGFk2bsio6v2UfheF1bujRhDLRDHQeE7+HC+xHbU8s0j4llVQzNsketyrhd62
	tdzvr8ViFYNRmNJMbzS3m4vFqBpQlY0mE=
X-Google-Smtp-Source: AGHT+IED75ZRA8aUNNWtEN0desHQoL9OpLop/JAYe/9l97lED+LZpw3Uwd0bVgno+BX9gPJUsMrjIA==
X-Received: by 2002:a17:90b:384c:b0:335:2823:3689 with SMTP id 98e67ed59e1d1-33b5114b63dmr17972054a91.4.1760125591793;
        Fri, 10 Oct 2025 12:46:31 -0700 (PDT)
Received: from ?IPV6:2804:14d:4c64:860f:5abf:20b2:7217:3f90? ([2804:14d:4c64:860f:5abf:20b2:7217:3f90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b62645851sm3734705a91.9.2025.10.10.12.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 12:46:31 -0700 (PDT)
Message-ID: <935dbd93-2b20-45fb-a5b1-04f6ac67615e@gmail.com>
Date: Fri, 10 Oct 2025 16:46:26 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: usb: add yaml file for maxim,max3421
To: Krzysztof Kozlowski <krzk@kernel.org>, gregkh@linuxfoundation.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, davidm@egauge.net
Cc: ~lkcamp/patches@lists.sr.ht, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251009182046.185520-1-rodrigo.gobbi.7@gmail.com>
 <c65f8b8d-9ee9-4aea-8f27-66c9fe12401a@kernel.org>
Content-Language: en-US
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
In-Reply-To: <c65f8b8d-9ee9-4aea-8f27-66c9fe12401a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/25 22:34, Krzysztof Kozlowski wrote:
> On 09/10/2025 03:15, Rodrigo Gobbi wrote:
>> Convert maxim,max3421.txt to yaml format with a few extra properties like
> 
> 
> Here and in subject, please do not use yaml at all. Look at other
> commits, this is supposed to be:
> 
> dt-bindings: usb: maxim,max3421: convert to DT schema
> 
> (and all other things like "file for" are redundant")
> 
>> maxim,vbus-en-pin, maxim,gpx-pin, reset pin and supplies. Also add a
> 
> Why new properties? You must explain not only the difference but WHY you
> are doing this.
> 
> WHY is the most important question/answer.

The reason was that the device (the IC) supports that. Is it
enough to justify? I mean, is a plausible answer in this case? If yes,
I agree that my commit msg was not right since I didn`t mention that.

> 
>> maxim,max3421e compatible with a fallback, since the actually PN is with
>> the 'e' suffix.
> 
> We don't add PNs usually, unless there is a need. So again, why?
> 

The PN of this is Maxim3421e, Maxim3421 without `e` doesn`t exists as far as I`ve
searched it. If it exists, it`s a different thing. In this case, I would expect that
the compatible string should be something that "matches" the device, but in this
case, the compatible string is without the 'e'. In that way, I was suggesting in this patch to
allow a more precisely compatible string to no break anyone using the original one. But if 
it was a bad idea here, I can drop that for sure.

>> +  spi-max-frequency:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> No, drop $ref. Do you see any binding like that? No, there is none.

I`ve a previous patch recently at [1], that added a "similar" thing of frequency:

+  sampling-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2500000
+    maximum: 20000000
+    description:
+      Default sampling frequency of the ADC in Hz.

In that case, $ref and description were added. Why that case is different from this one here?
[1] https://lore.kernel.org/all/20250522204130.21604-1-rodrigo.gobbi.7@gmail.com/

> 
>> +
>> +  maxim,vbus-en-pin:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    description:
>> +      One of eight GPOUT pins to control external VBUS power and the polarity
>> +      of the active level. It's an array of GPIO number and the active level of it.
>> +    minItems: 2
>> +    maxItems: 2
>> +
>> +  maxim,gpx-pin:
> 
> I don't understand. There is no need for this property. Drop.

During my other reviews of new bindings, my final premise was that we should add every "capability" of
a device (the IC) regardless of the driver support. In this case, the maxim,gpx-pin, is an example of that,
the device supports that despite the driver support. I`m wondering here why we cannot add that here.

Tks and best regards.
Rodrigo.



