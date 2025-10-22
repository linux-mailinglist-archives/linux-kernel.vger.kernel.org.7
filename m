Return-Path: <linux-kernel+bounces-865402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594F1BFCFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218433AAFBE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AFA254876;
	Wed, 22 Oct 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HY7be3Uu"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41890257841
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148723; cv=none; b=b9MjKyQQp2C+4H/XLQMAsq/wdSVOo3FiIn8N6DedATrwsV1WdE+BCwKIY8eiExsf06KD9Ii+PqoiNcyMI7eTIHFvY9i5LK2vTmNgO/hK+YMYagqemVup+/XVTYK5WqlVL+QYKg/kyjPfo2CWZ0ki/RJgmKpGneJ62EDd+4g+rmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148723; c=relaxed/simple;
	bh=NM70aKifWa2Kd7WDeVBufAQ+rHD0r0An/049xG9//QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwT89ZI4BAYEgrFhd62Px7mbajyKVXpNgbeGFGzgubHqtqSwadsIXSoYwiwpcZCYpPYLuF/1emI9jYyDy7x/Jd+RAVAZelk6upRdS+zPFLX1zkPy/OOf2V34tyFeHlimoHeIRbkjSzH/g0wWGqip0U8HZtB6agaIhuqdbpxa5Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HY7be3Uu; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-430d0d37fd7so5687335ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761148720; x=1761753520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WtlN632BuZQuTO1b1nC1/pJZ9G7lNRGEK1QOBTkTILQ=;
        b=HY7be3UuLkE8mMupUjRKYOmUFTvbSWgkKYyySvF6UhSVG4TZZ0aKEc33ZnLSN+i57b
         N9XpC/0juZ/yB1E7aKaNd//oa/lZ+st1Ti9caJeIUTbKyEaAjsTtiLu40Ijfc8OoAO3I
         AHcVQo3CNVqKARWTWuSjY8byKN78A1jOnOidA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148720; x=1761753520;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtlN632BuZQuTO1b1nC1/pJZ9G7lNRGEK1QOBTkTILQ=;
        b=rgFgh1mLGs8KcaFxHxIDsPGkJyjStRAGl5q2pGWKjnxOTDqIwrl0cL8EGv7Jk0bZaQ
         65+cKrR688p5Ott2qLyjTefbAn2IoAjcF9E7ZSXbPaVsk0aADGiO3fl3ltlhVSYEKqJs
         kQ+mDcPHmxE48jxK6efZAEDYA9vWlh0VvDRvpOyOP9pluFz5lBGsCHQ18ENS5qSIfXwz
         jJliyrLDbnOUc8+mBFTQxAKcV0Qp4eQYHnOGfu6cQDb+JFvSqaWJfBxrTQf8CeeGjlgZ
         P8xhpvEI/LzF6yDk9No/YgN4386/pSbq25obpnX4xNnoAxSwbHfWAtjODB1FMduNdaix
         QCCg==
X-Forwarded-Encrypted: i=1; AJvYcCXiu4HgXVF46ypb9ZPXOmXpB2V1LWXQ4VkejdWH71qGdMG8SOKwWwodPq3qtJUy61jRps8YC4TkyX6xukg=@vger.kernel.org
X-Gm-Message-State: AOJu0YynG7BOWKigV6vsVGhIfsK7dKeivsG/aRFMzeV9+UUbJfYEPKNL
	yn/QDdBtQavotVMhHTPfQFn9ZDa8QhJdCX5yLAhtKYE4bT4CbLa43ycCwUW/Q2WqOoA=
X-Gm-Gg: ASbGncv5QXDSsTNbmKhTwQpZ8TxK6+g6FxTUqu20XAwPpkDQfVkdMKrQBc1B7ZuvQKI
	3gyOsJLx/Uk+Z3/Po7v92HtVxuSOZUfbiixN4uMrnz1D0kkZ2LpQ6No0EpzWSWzc74s+JIa7y/N
	Czt3DNPHBNDBImGehtXlLFu3U9ZmWcNuJkPZnZgy7oCdYeHj9+0wpkUoS+YHLZoxAg274qlI9TG
	eh+GFOPg00Faqe07jfeQIaR5fH95AUC0/L9dA2jyBRw60XPsFZUBKeY3censb4o5BdFu3LANJUF
	KXswCjOOBU1cjTimQ1WNftqEIdgrWSS82eI2akEUNM57IaO56Wk1iwcP8QzGucUS01YIZtU+6WO
	RjSo6dOv9cHOYwK0YbF1qOYU3eFFzgnMJNteApan9zqPhOCc21YvyIV6dhP0b1gc5KJR3P5rXG4
	EEROz3d6ozKSsJqwKVQylnFUg=
X-Google-Smtp-Source: AGHT+IFfmpCao/YI4qPYRvNe/k0MEVLSsUtQkapDAZIbYz/MAtfhrLCaFirgnyqdBAlZJ4fmtoS9qQ==
X-Received: by 2002:a05:6e02:228f:b0:430:b4e1:bcb8 with SMTP id e9e14a558f8ab-431d32d4088mr52223745ab.13.1761148720159;
        Wed, 22 Oct 2025 08:58:40 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431d73e411asm5735545ab.7.2025.10.22.08.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:58:39 -0700 (PDT)
Message-ID: <f0c89ede-19ee-4046-b2ba-0178c62e7243@linuxfoundation.org>
Date: Wed, 22 Oct 2025 09:58:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/159] 6.17.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251021195043.182511864@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251021195043.182511864@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 13:49, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Oct 2025 19:49:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 


> Mario Limonciello <mario.limonciello@amd.com>
>      drm/amd: Check whether secure display TA loaded successfully
> 

Verified that the error messages are now gone with this patch.

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

