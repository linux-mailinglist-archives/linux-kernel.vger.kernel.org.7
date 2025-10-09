Return-Path: <linux-kernel+bounces-846932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C80BC9763
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320F33BA63A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619212E9EC0;
	Thu,  9 Oct 2025 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0fWTGvI"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228893595C
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019395; cv=none; b=ulQTV8w+KqtuOc9nlczCU2LtSNgz99pUe4mnhYkIpEzO0vXxbEHNdIXDuyqSaygHotXjxtjqUCVJ/HlvPSjxY5GIIz3zcOcdWxzpnEEw14k4JjR3Mt1z/RDUeMj0Rm7HTnGwof8HDreGdfpWUlKoS/NOK0VyVUPh0+SH+bb5G84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019395; c=relaxed/simple;
	bh=INg2l1L3qVlchF8lbtAersWzkgZD/yRLdxvFc3cUXeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sieQSR+R7+lkO43S/+Ij2QVY61/8w2y1pnlhaEXj8FVcdgXyUbnic726BcK8JfZ5hfma7iGGwTO4hdV5ATrLoUu15jqfZ1r/JsoAt/U3UhmRtn2ZAi1QLguTM+O97U8355BggWIP1qZRt6pLRwUtGWbXMMKt+sGI8Ydag5yJ9lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0fWTGvI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e3e16d7fbso1604105e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760019392; x=1760624192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSrrO4mmiUzY5qFigdCsu5TCXkFT2TeakHQbJDtrsro=;
        b=j0fWTGvIFdiK5f0EoXBMVUYzcsX9OHO/lkAIaVK9ts151PuqE9MtCYJ22hUk1PVZhV
         0czUETb1Jz7Fw36nA2q90pImHgeKIFT1Mox8gLqi6V+sj/ZjerzOxqQbeojxPJsLkTS/
         q1B/oHSpsO5hfhQD3OGXp6HSuy2UjUFcXvIoqgk/CISYOpD7FMX8/LZTYqolvByBFYHD
         HZVKK8QppCajI5086q+KRP0vvigHslHIAtNX4InHPnmsOQZHzCADEw5CMJ0xKDCCFqnn
         ZWCY6m/1TFZw59YCvsidCxweXsrP1C2qsS7TqjhC/MEEgEPYH7z7S3wQdiK4i7C/4Hnl
         l/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760019392; x=1760624192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSrrO4mmiUzY5qFigdCsu5TCXkFT2TeakHQbJDtrsro=;
        b=Opl5/rsoOqkGVcnuw2OWpwdhozihBK+IXjmbXC/z5yR2pxE4hwgfzq4H3r3ff5gTca
         GP33OhegE9qjpgysXn/c/wlghO+E5qh/i51sZya3zZpHkw2VaUKnNZL4QbceAasr7VO9
         U16DTsDxYw9gQqXTXJvnQOg5HfekMUH5H71fius7TEHendo75AfRnBm0eMArq+bs9rkM
         14w6oSz/gJHZ9mYyIwxsrPF9QRWq5govAyjez75AmJuEuIs5A+eN2+7D9bAh/aXrmVEL
         82qMhwSE6YSMaSArzYEgUSas/fJwxhjc+T1H4Z1Qh4fV2Fcd5Zp2insAUCVhBs1FqL8o
         n32A==
X-Gm-Message-State: AOJu0Yxgm+uVtssPet+iNy9N1UaYDf6rJYp9gtDZpecz0GT2cKHtI9dU
	QLwmRSVXg2WyCZm7KRRJxcrzIHOXKA3Ivj/9PwRZMlyQpJg20mJEV3K3
X-Gm-Gg: ASbGnctCP4ggZQ59sPtFu1Zg+q+ncBsvPisLP7johotbui/6Bv8k2PRIPx/eD0TCuGz
	Fd0SBpJJZPQSreKJrfgK6gQDrLH5dXbYVHfSbXAMaLdxQt8nborMaKI+pzSdyp0DnfImw6umGu+
	fub8YCKH/3O8a8AlEJalWekF7kmPBDhQ9vApovbMYOwAjsRg8NvZ3WRU7l/fRslLwetm1HZx/SA
	6JlPxFjpPRidbXYDMUHKa3jEqVH1EGEauWen6w8VV4hlZM9vX+2/hShIl9cTjkWM600IQ/13O6y
	Rxjd0K8SRCsJt+3z/Y8ujHyi9xWxKOppkxsc6HZ5B+/ArlFvcvw/EbANPAn1gXI9Hdpkouh56Uq
	8mdKfiGfJe1fSWKOsWvbkSpiRRNqOSep+D5s9lZbcMRIIC9F0GNDZdcvJs8jjjaUwA6Mc8edNer
	+NPJjh
X-Google-Smtp-Source: AGHT+IG9tRKBlq86RJLVpcZ2NOyilhHrsunhrFrqoHub96Rq1cpuS2RUwseJcNN4aM0Y2mlO6+vqOA==
X-Received: by 2002:a05:6000:1846:b0:425:5d25:ffc7 with SMTP id ffacd0b85a97d-4266e7d4864mr2905327f8f.6.1760019392134;
        Thu, 09 Oct 2025 07:16:32 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.46.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4ab0sm35103359f8f.52.2025.10.09.07.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 07:16:31 -0700 (PDT)
Message-ID: <84bf5902-b3e5-4d58-a2a7-f01e15cfe143@gmail.com>
Date: Thu, 9 Oct 2025 16:16:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib: cpu_rmap.c Refactor allocation size calculation in
 kzalloc()
To: Shuah Khan <skhan@linuxfoundation.org>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
 linux-kernel-mentees@lists.linuxfoundation.org, khalid@kernel.org
References: <20250930092327.27848-1-mehdi.benhadjkhelifa@gmail.com>
 <10082c41-4302-4cb3-a2bf-788e59bad0c8@linuxfoundation.org>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <10082c41-4302-4cb3-a2bf-788e59bad0c8@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/25 11:23 PM, Shuah Khan wrote:

> 
> How did you find this problem and how did you test this change?
For the first part of your question,After simply referring to deprecated 
documentation[1] which states the following:
'For other calculations, please compose the use of the size_mul(), 
size_add(), and size_sub() helpers'
Which is about dynamic calculations made inside of kzalloc() and 
kmalloc(). Specifically, the quoted part is talking about calculations 
which can't be simply divided into two parameters referring to the 
number of elements and size per element and in cases where we can't use 
struct_size() too.After that it was a matter of finding code where that 
could be the problem which is the case of the changed code.

For the second part, As per any patch,I make a copy of all dmesg 
warnings errors critical messages,then I compile install and boot the 
new kernel then check if there is any change or regression in dmesg.
For this particular change, since it doesn't have any selftests because 
it's in utility library which in my case cpu_rmap is used in the 
networking subsystem, I did some fault injection with a custom module to 
test if in case of overflow it fails safely reporting the issue in dmesg 
which is catched by the __alloc_frozen_pages_noprof() function in 
mm/page_alloc.c and also return a NULL for rmap instead of wrapping to a 
smaller size.

If any further testing or work to be done or even suggestions on 
improvements to my testing methodology, I would gladly hear any advice.
Thank you for you time.

> 
> thanks,
> -- Shuah

Best Regards,
Mehdi Ben Hadj Khelifa


