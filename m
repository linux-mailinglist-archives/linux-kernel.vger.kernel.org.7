Return-Path: <linux-kernel+bounces-733764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D697DB078C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99EBB189CABB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B1126E6F4;
	Wed, 16 Jul 2025 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MWQbTIqm"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B11264F81
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677603; cv=none; b=eNXDqahsNMNFpHtn+WrVlaFwjbdkX/HEqJvXb2GSEANSeyJ1RdJB3ewQRViCMMSnn5LH49/irl5BI+H6BcX8J3IkNq7yW4jJdG8wK89EF1LpqjPvM//ggwZIMdwUVvPelqt8hFIwOYXdhGWCas4qG8s9jbWj4173XWe9EPIPxfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677603; c=relaxed/simple;
	bh=aObTEVOu65cgXJJYv/X83Rx9FuUZIVPF7FW9+xhRJKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEJIjPG6GBScQy1V0fH7KLZiuquJVH7+Uci28it15ksVuneSRRxehSE7g2WCbAFjkhDs/2o/mAG45gh/EGz4kiOzzS/Cl0S/vm4X8QiFd3VlNqKbtu6uLBVkGC+PUkfuobmY8Z7MlUIgjUfeUihkcykhlfDmVWcffa/fAlp2xOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MWQbTIqm; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3df2fb6378cso15975ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752677600; x=1753282400; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70hqscYKUMhS36bD6H7W3bD6jK3TRd5Z4bT4xaOOeio=;
        b=MWQbTIqmiIrD4hLKtEaQU63+mAKpRij0KAy12dNmUM6KGSXpdIbhgTZt+5V2O0O4NG
         zYXF/UNaqweZ9Tz1ziDJcUDeoi2xiR4v5Xij6pUDdR/RPM5qNjFh2dPkjbeslpaNDf78
         YqFGaq1SV82kHzNpIPduGBU9zdpPEyTCsxpNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677600; x=1753282400;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70hqscYKUMhS36bD6H7W3bD6jK3TRd5Z4bT4xaOOeio=;
        b=ETQ4w1F3+bBHGoBsCPpWnz/yRGohhMr0gxA8TIZEN7Yw4kJrZcOnmjPz/5lGsuOJGY
         jtUCL8ztbAUM/czX35wXySN3AczZojJajOb5xCsVBr6o0ORns6g8c8+wTHSQf0WKSbs1
         U1cT18HzOd4qESY5KjaTuttkg807M/xo3Z8pUu+I9UT1OiEAyCz37dkVAdOeH/k0ZYmw
         oxVm8IkBXEHHuW4oL6vrwQjwOE/seOTxLXKR7cZQEFho95gUpLsSRmMvnozqAU/qogZE
         Zg7hUS8JqycarDAHpVyomhkTsmOA4fPxEvkNiuCt+GYEat1VaQVgKfJOYx34zZoQ8WB9
         cgLA==
X-Forwarded-Encrypted: i=1; AJvYcCUg1imkQMI/gBDrBpZtz2qqcx211JYPrFKQ8m1ixSjM1vGMZCbwuaE9H3p9QUeN18nqrSfmYY2sF/2xf+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8kCwQ+y3O3mnC+AsFYYEQ05VpspBOlRv9v396WrjkdNPfe9yw
	L96ZPJNg9VRqKq4u/FdSSmJmAoLX/Y1ek+Iuw+ZrDTJ9cNceDEbAgpybwfyWgccEZu4Sl9wZ9j1
	6c0Em
X-Gm-Gg: ASbGncvwaCPoAEu1vy+sKYtpKAOw53wfGYycBMEoD1R6Wbah5YIGThdbTFcQxgpvLQd
	hkFsBfnYu/l8c+FoGoDoNg4LZLel7HVZ3On4Qp8HuWfTlyu7LwNGCj1C5d+oErYyKkd2KuFiiAS
	46Y3fRdU+d//4wbNHIrm0SdfhhUl6I0JZBHvPUtkSxhfvIjKizE6ifpH4jgqE3akQ4XXHSPa5iL
	L1JbIfyOPedI2r2I2bWymQT5JZaaDMz17XFb9H0eafLSutNXF4dglt0SZ7QOwzR9/6ZOsP5wPix
	h4gcN9MwDlcmIg2+Qdh7L/CfbYMk/my5Or4CqYKMkWemrGKLDhqPCsv6JdgKFUG+hdDpgifDro7
	x3tJqI30SLwI2BV3005lzb62VAHZkNDEBkg==
X-Google-Smtp-Source: AGHT+IG0GNVprRljye1iFIt81jTPpLRCL9X5k/6lyQr0UNEP/58Gv2FGcMU9mg9LCJMzEMaDolb+wA==
X-Received: by 2002:a92:d64b:0:b0:3dc:879b:be95 with SMTP id e9e14a558f8ab-3e277c6ac35mr57796965ab.5.1752677600268;
        Wed, 16 Jul 2025 07:53:20 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556535f2asm3080620173.1.2025.07.16.07.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:53:19 -0700 (PDT)
Message-ID: <631a6946-0a8a-4f6e-ab5d-f9b2d0585817@linuxfoundation.org>
Date: Wed, 16 Jul 2025 08:53:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/109] 6.6.99-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250715130758.864940641@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250715130758.864940641@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 07:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.99 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.99-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

