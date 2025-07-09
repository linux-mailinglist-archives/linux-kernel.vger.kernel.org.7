Return-Path: <linux-kernel+bounces-724284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A11AFF0CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6441896570
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A469236A7C;
	Wed,  9 Jul 2025 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LyK4lXZJ"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1739C2397B0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085321; cv=none; b=aKaUfNjcxiwimSRnIbth6cWmaDCh1wLik647cxhNMPB77fy1i+u6q8RJJaSa6rT4+Pmk1THF2gDpm7cTgT9CNILaQvTQ/GuSpk0ucTD9jqRroQiRvbb3EBuQgdjacOr0ck5G6fIPMkdGB0A7y2GQz1/lUcuFkgspgbS4ElmGzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085321; c=relaxed/simple;
	bh=8LvNsabc0my7V+hNxMMtYFnztRuOaqiig2opJPSQKqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKGGf4NeafBLhXxzpo/C/YnC8KPsapAUsjaMxiyje/xWSTaTy8UCk8Zfu4JwBKgo7Ek/ejlbDmpBo1BKwFqbYWlni1QYUlfItiLE3WsesY09ihxrfQaBdYFBmzh3EED51t3nQg+L/8aUE8vXcd4+oRRItOLVDJ7pYM+H7qYfuoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LyK4lXZJ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e0570a9b83so547165ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752085317; x=1752690117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBRfgTf7RIgKnJwuu7ZvDO6OZoixjZPMxFISgPsX2vc=;
        b=LyK4lXZJOyLF8sUbdoTwK7ROhfvMOnxHvlwAxJFV0jdLMgsJce2k7Woo5w4XPzdVbZ
         lg8eJz51kTL18OKNxDEWxCUH9BdZFtIVCJ2ISfVqubk9mJ3RKEZ6S6XYSPuT4FhOVisA
         9zT2t/zK2THWQCQWc7sZyu/oR+sQARBiuW6Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752085317; x=1752690117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PBRfgTf7RIgKnJwuu7ZvDO6OZoixjZPMxFISgPsX2vc=;
        b=R4aoEfoh3lDTgjYSp9Zh0OHCo5reMy/kKTSyPrvEf+7C5uYMmMerON2YmaU/zoUguw
         a5lGPcFQ9sxF3a7nxy1RVOC/EgwETUZwQ1i4O4D9OfurKnySUPQIyK0FjFp/A7iWb1s+
         LSpxryNWfTLuH005vTNfUjqeWcKL9Rzn3fzEC+JmpqrinXq4qncV2RlYjGb9scWm2+hH
         T6YYHMgGAZSVliNmk7bc/GHL5kPlBUTyOzg2DwAo/Q5SLq42+d8IrL6+DZ9E2I59Ptle
         dLYRgSkbKhIKUcZ06R6X0KPYsQ4vausR5gFeidXARy/HI2DbaBW9/ggjWviB1sG6XXMZ
         Lysg==
X-Forwarded-Encrypted: i=1; AJvYcCUHywyOetNHbVUo4+9CUyMTteBhAlxqwQRHs8sLcJm9DRI0dJUH51V1oxg5jkuJPqji+0D7KjHb5JAofG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrEAcKIFZp+D7dRopINbuAHuKhZFvcNcx3tLAFQjelRjq0GP6X
	Km/j9WPpXnpJLpHVCIWdTJgPofaMh2wD41kEZ1X7WjS78szJYD6/c8snpH76yQCSIIQ=
X-Gm-Gg: ASbGncvNE/d00nmt2TufwcP0PuOx1njQjn4L5ygOYyl8jY3LbJ3wrZ3TgIBuFZCNaiZ
	P5adnuAxuM0jOvml/SUrccfZ0yUIFJGyf5A1QOKeAEII5OJ17amSJtpn96PIYDvFHppZcoipLZQ
	mc86XgAqoo84lALuBW0UKlKNbZ8beSsySPoa2LMeyt/iwDAoaiMhOZ/SWajVjfveVCiRIVmzsK5
	tYFufo1wWugCVa/QtekMHocnHQ9n6glJAgrU5D4wceLPvo3gScSPRZc0atYzTXKUMW+7XSdTrbi
	WuWBT/6fSMK5U6gG+4R95HYCbqe1zJ+01at2iCxvmwEiGaDcPPWSrQ9QhUTSfFXmUO0ftoTzAp3
	NdhXXVKYf
X-Google-Smtp-Source: AGHT+IHiWna6bSyXG2HZPU9BES5Uu3BzehbrD/ysyplTdibJ/xd0zNUZnSNOWYpFqmRipgJGKDYT9A==
X-Received: by 2002:a05:6e02:3487:b0:3e1:5f8c:10e6 with SMTP id e9e14a558f8ab-3e243ff1490mr8804495ab.13.1752085317104;
        Wed, 09 Jul 2025 11:21:57 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-503b573ab0fsm2823317173.0.2025.07.09.11.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 11:21:56 -0700 (PDT)
Message-ID: <a7227104-f537-4e76-b567-4b3e3d3306aa@linuxfoundation.org>
Date: Wed, 9 Jul 2025 12:21:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/178] 6.15.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 10:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.6 release.
> There are 178 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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


