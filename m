Return-Path: <linux-kernel+bounces-735635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E8EB091EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54ECE1C44C75
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453A22FCE0D;
	Thu, 17 Jul 2025 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YE3Duy1D"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1B32FCFE4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752769958; cv=none; b=Hs7S2srZ2fqnVlaSHVqSq/UcwEk80KDfYqCZfvELPHnp0rnY0aizOK7SYqdkhrdGw+CLWseVoTHjmX2GcuVwxdkRjE+TtabUSXc1kYmE8fV66+PN7fR7umf4HCNNVEYLYpqXgmn7W8gKjxT17FqALfsPkQilOOdklkNG8p4bMpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752769958; c=relaxed/simple;
	bh=YwcxOCo6YE3diM78IuQgp6r0Rfk40N3dw4L9cGXNWnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpG6lJvTNHzAYbAyHej5imuHJeeI/j2uF9sUlwJ+WUNHKPS7k2KlTC189nKkp6WI3Hi6ApOm42FqRi2q+x9ELL2QHTZoA8WRXiQJ0aGZmsneLdiDE43/kxOu4IplFREZtytDyNQuOKjsPMUBFFpbQzaiiT5/b69VjGFV6j9h1dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YE3Duy1D; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3df303e45d3so3916145ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752769956; x=1753374756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ByiPDi/G0NIi8kD/E4Qwgbmk/3DTxuAzNeguTYZA24=;
        b=YE3Duy1DbWAhOJbOxSIiTl5iCkkNHHWsLD+d1WNIP4VCrcO4XHOL7OBcJvwOOxYGSN
         olyNokk036B0mhrvzIcTJAG7X+TjQ+3jUj3qCy/Bl6XFkq1+FyjRC7gG4VZYTOPyHuFM
         su4iOhv5z9vETGxo5LY2gCEoufmkgrSwrEvfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752769956; x=1753374756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ByiPDi/G0NIi8kD/E4Qwgbmk/3DTxuAzNeguTYZA24=;
        b=OsmhnJvB7LV/QfeFWwwtD+9JXawrYGOqKWacEzd0Yy35Yx3IJUKIbUEczm/zgJv3yO
         ITAtN/pTpCXKAhJZUkXEbi+JxuMST+r50JBWnXh8AZKK41/otdvbTBiXkngb8+Bw3o4n
         snWzmjHwKTbw8mCp1lVLG0mAyAOkLZevKdKuMXcNSpmFlnCdE5ehcL8w5R2IEoh7L2tI
         rdH4Ku4Fe0400AjBmnFiimJU/3LnTyM4ii0IQ8+4QdguV6pSoPAtRfHoEqnpMEwrBONZ
         rqbBKSgfF8cS7rhSqWX+hsE39hC1nP7c10GSDU0hVieRf0auPSUFnCu0obmY9uMc94kv
         chwA==
X-Forwarded-Encrypted: i=1; AJvYcCXPaxX76FiQk5xFGUhxNpn/e7RoawCBeKFwoPSK9n6OgV2gM1yEiHFB320loUOkaK7iW0qz599IzoO/oSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDOr78oIaWiA/tz5noSpEHYY0VLMehxvcLSUtKJYBs2ggS89d8
	MBGVmsrw9o/QEGNC+UiQoBBD9qNkfeQ9e1OEUamBKXaLnuNhri+goRkcypyVJRIsIeEAKa76ZCj
	lj5oq
X-Gm-Gg: ASbGncufYNHFincx5uGvyAib/gXwZTSEEfJuJd55vROAc+d8mj05djq9bNIUOipaZXk
	Dw4BqRN2fJyqdUrNt3eoMThZBia99WsAKhnY5AEZh+UJkzpoCkLoSPEu4PNp2y8Z9QEamKoDvfM
	8BnWOvX8ANzedC2JNdfMAAw0iUmxjfIa2ixYFArTgDQbAv+NJTKqTp5EdsTKlI6kdfHd4vYRRvx
	x4DFzcVPEINBSJp5mUWRvMAUvQex5NJqzKbZ9E6cCIgofeLVuiF2Bg0Xr0TPMwzPlh2rklXvj/w
	0JT9hzB90IaNat/9YSiMOTqUryEVm5ZWVuf8ha09IOFxG32lNILpYqfQvxXcgEeFWrWKIHGfFQP
	lFDVFYesbPr4N0HXvqXcsV5vznwsvS4Phjg==
X-Google-Smtp-Source: AGHT+IFdEpa/4272demo+JHHwVf9NMi6k6hcUm7ADZo9/5EQH6F4oSZm3b2YUzHc9cuti9PH5gADIQ==
X-Received: by 2002:a92:cd8f:0:b0:3dd:f1bb:da0b with SMTP id e9e14a558f8ab-3e28d3b8924mr35218295ab.7.1752769955454;
        Thu, 17 Jul 2025 09:32:35 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e26b208436sm31349615ab.5.2025.07.17.09.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 09:32:34 -0700 (PDT)
Message-ID: <878ca180-c54b-44cf-aa14-cf6028723167@linuxfoundation.org>
Date: Thu, 17 Jul 2025 10:32:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Code of Conduct violation complaint
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Cc: "conduct@kernel.org" <conduct@kernel.org>
References: <13a6b8e3-a35a-425d-bafc-006e0a52599f@linuxfoundation.org>
 <aHanGu9nOGOegUg2@duo.ucw.cz>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <aHanGu9nOGOegUg2@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 13:08, Pavel Machek wrote:
> Hi!
> 
> I publicly apologize.
> 								Pavel

Hi Pavel,

The Code of Conduct Committee holds these conversation privately
with the people involved. Looks like you cc'ed the mailing list.
Respecting your choice, we can continue this conversation publicly.

Chose one or all of these threads to apologize to the developer
directly.

https://lore.kernel.org/all/aG2B6UDvk2WB7RWx@duo.ucw.cz/
https://lore.kernel.org/all/aG2ClcspT5ESNPGk@duo.ucw.cz/
https://lore.kernel.org/all/aG2BjYoCUYUaLGsJ@duo.ucw.cz/

thanks,
-- Shuah (On behalf of the Code of Conduct Committee)

  
> 
> On Tue 2025-07-15 09:28:19, Shuah Khan wrote:
>> Hi Pavel,
>>
>> The Code of Conduct Committee has received a complaint about your
>> interactions on the mailing list which are in violation of the
>> Linux kernel code of conduct.
>>
>> We urge you to apologize publicly to make amends within the next
>> week.
>>
>> Refer to these documents in the kernel repo for information on
>> the Code of Conduct and actions taken when violations such as
>> these happen.
>>
>> https://docs.kernel.org/process/code-of-conduct.html
>> https://docs.kernel.org/process/code-of-conduct-interpretation.html#code-of-conduct-interpretation
>>
>> thanks,
>> -- Shuah (On behalf of the Code of Conduct Committee)
> 


