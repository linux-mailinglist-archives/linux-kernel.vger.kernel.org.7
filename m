Return-Path: <linux-kernel+bounces-874308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CAEC15FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C18D4E1CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3AE32E6B9;
	Tue, 28 Oct 2025 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7AiJ2Vm"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD074307ADA
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670599; cv=none; b=QBKQD6uQTWOqEWZ8DlZtTr5Nmm4NiEzCw8umPJY9gQBoPYwdBnXWBhlteuft+7ntSpSvqKELkDdpMoFLIc6sf5rxxosdD5xpI0tt8qaeYG9ILSMifL1p/k8zQU48RkmmWffKJVZ/QkEZAsQ2jLXvTkquzSkx37z2UPPT6sZo1lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670599; c=relaxed/simple;
	bh=p6RyFVKNQkIaQ4ZcnL2+jkSmewms8zqCNQv3TST4Jn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KU7STWXpvmUiopKNwmUX5MxCVLRwGwDI/96KT7G2JeoKqXqRfmjEtZwtMIi+PkJCWSLDrOQ19C9GDROClano5u5a9b9ggHdAHQ9CYQl3zgxN0LIhliSyc6v1Pn0JGsA5HTasP3hC4S8nsiYGgj5CptTSyO2PCd0WQ5KrNiA2/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7AiJ2Vm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4770c34ca8eso25189795e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761670596; x=1762275396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWB3SgEBP2sW+IMp9VjTcvHlAHIvY8hohrCBcP8MjQI=;
        b=j7AiJ2VmQ5qcCj2/XwGuPPWrQWk8EeOVeRKM5Vpm1kcqj+fJ82nfhNPNCZvEb+gwW4
         YDyrhbNUIySdvb1NnTsxn0v4BLGJ0ej2Vh26Y/HCz+qTno9HlAVquHD+kN+P+qV9dHRQ
         4//C9L8JdnWS2yYN/oQgIXTR3MQUafRdwvk+Pi7NbZl12egs5OI4VAgOQEYmxBBtIWsn
         ub01fHBF81cpM537/I8m1etOTD5tE6AuGi4fmBG+vuoMYjAWNijB7dWkQ/t6E1OHsw7h
         lO7PErcsIPe+SckMfqpYpuzqlg1p2667beolctEXPJjqwfHHyHiEV8N29qaSZTi6KoJ6
         B2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670596; x=1762275396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWB3SgEBP2sW+IMp9VjTcvHlAHIvY8hohrCBcP8MjQI=;
        b=EwtBwTAhP8oevuOOkPnKGPokH6zEa3LfNj4KJMLJykc5xhEBxI923qFbvbo1jj6Ss3
         ShXihp2NB31+VtRYuTz5N+S8Haw6L5Ii+3TVmTBssvsiTCbpR+IrOv4Rw9JyWBVPw2e6
         Cy28dH4RfcvxOENotzZZGKU4k7Y/QJ4TWywllzIaNMGKOFmM92AjuLTxrmVHMDVpQSHW
         /XfwPRY/A8JzLnEW76WDGPEq9bJ/mCGZ/ROcHj3KHUq8jqdhIFktVFhBQrl0fap9WyRP
         qDQvBlDixKoES1Xrv10uXs2VZ4xxKRy/9IvzQfQUAMOE9FO0czznkN1WUG+xrZZuWZox
         745g==
X-Forwarded-Encrypted: i=1; AJvYcCWDYWCxByFrKKIweBXIheqTL/ymk54buQFIBzEoRkW3+M4Z+poUPiGkF0zZmbzhDNLqs47y4ZA76bwTvH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiKHNzX4VSTeEATNjk9OvQ/y8VM0C+KQZRaeYQZlGl4aXHWhgp
	PH2VRn/QzMBeOf3phLy8fsYzM4DqdBxJcOJN/wbcm4rCpyf8FmaJg/z7
X-Gm-Gg: ASbGncvAgiQgpMX/BqQlMAkIhxAkeWao5crJt52UhBVTJ2UvC6lSQKxukdQM1Wx2cLx
	OnPHGSL1L0Gif+eODESk5KndtYMd5am51BPQwwsZySkW+BKVpqv9zevk9Ont66QjjgaRl8OXro9
	ybFgYC6xHJhjnMGH9Nb6tAgIruiTpj7SOM2s+dF31z/TNmJiiGIF1qj+KycVJKJwUs7V7z40kdS
	RaygM/aRs6is+72FQlvo576+amZmsZi8WSt7H9HHDt9GtMdO6i9cPbXwah8qqQ7PGUcxPlpG+YZ
	xkLrYBgDGA3SRaA2+3rA1zh0BIBnKkS26WqK8y8cgVkCMo4McNszqT8v5HhQMrnBnQT0fU1S27k
	zAUSrV/EI1cWsLIX7wvevgO9/Qvzvjn17nFchiFpMK80BXG8tBAwTvg5eDABkrdQ4mN4ePPJm3M
	90ecyWmevJ/9SFhW6xhnx9TrNqLz4=
X-Google-Smtp-Source: AGHT+IGzGR4B0wLNVXJkWpJi+gf0J9ZLmHxgn1i3xJss3GSWwRHMfKatObo/0+gt1zOBw+J/Okn6YQ==
X-Received: by 2002:a05:600d:435c:b0:46f:b42e:e39e with SMTP id 5b1f17b1804b1-4771e3cb792mr378315e9.39.1761670595796;
        Tue, 28 Oct 2025 09:56:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df473sm21333826f8f.42.2025.10.28.09.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 09:56:35 -0700 (PDT)
Message-ID: <3c1dfe1c-a1bc-4873-9c5c-4f9904888194@gmail.com>
Date: Tue, 28 Oct 2025 09:56:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/117] 5.15.196-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251028092823.507383588@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251028092823.507383588@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 02:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.196 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Oct 2025 09:28:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.196-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

