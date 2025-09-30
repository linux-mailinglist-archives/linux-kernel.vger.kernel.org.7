Return-Path: <linux-kernel+bounces-838014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB5BBAE392
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064464A6B55
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D2126A1AB;
	Tue, 30 Sep 2025 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4BkDL2l"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899531E766E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253881; cv=none; b=oCCqUa7e3Vkj8cnmejLjKKYyT2y9mx5cfO7qBO2MmuUeg/hZc+VkDI4QEa3WubOYo38mMtCt+uaEGMVMn2iXzNRTJX1oe+VtqYWXuFKKI48zw1/m6K/Qn0RoGBgntG7TcF5s0XofDIng22qCHhkZ9TwoZ0FoaeB24njouG31nB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253881; c=relaxed/simple;
	bh=2TC+hXWlv6u2VfdLj+sqgeI1o1n9KDX4csxjWQttT40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBEIrnGxSEiMcR1cVeLeoh8wPyqBHdyYpMfXvKg/K9auLrBt0YJVHoISFQq31bDVzqRcdUZcWAIwe5vk16I7mkFy+FBllamd1r9pTHR+ikfhG21EngwO/4L6x3l4UejJmINWMsaWfyOETde+pDwM9kEiGMcEzkUXSUSx0oFUtaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4BkDL2l; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7960d69f14bso33852476d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759253878; x=1759858678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/hKAmf18Y2yd5/OgWhquQHdykw3Pq1AdppT9xBph94=;
        b=R4BkDL2lsug+3F4xDFhQSSm1oZFKYq1pzEBdLb4m6bBFqZL2uSPnm3j740r1/RVB/X
         MuJ3U+6+U6OUnxF2y5nzmuJgPquT5txrNsNsHe3MuYyeIT3tm4OtpMbLObY7D1Yw2GRw
         WUa+gH17oF80GMfXegDdUKbExHBNXec2MExKDNSn4w9IdS0jsca4IfiMYqIiTQdMP++T
         3qHRJ9GUOFeLWERtsLRnmgfPPzarH4EnH5PgcG6Frn5k+IlqnGXnLTw+K6EEWk5fN8Yk
         ERfT+yM6BJLyhCjTjf7IbIvNHA/gTJYRdwf8Oj0gM9YPTCZgfeJkzQ2fX2kuS0rjDlAe
         NGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759253878; x=1759858678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/hKAmf18Y2yd5/OgWhquQHdykw3Pq1AdppT9xBph94=;
        b=PKbro4pxlTM69fo9/GTgXgYpd3jh4+K+bbzhh3vmhtWIi4JKClxbaBU9ww3ApcI9/3
         DSk6JZOXetAZERZEEk1X/nUTMbNSCCAUCK8HK7g1GXZ4tr3L8B/dBa04cRx4OnpQza8L
         91+fTemcvn87WsEYb0vOOj85iu+a8lu343RqCEc9n6YkJ5UhRiq1zJ2LrnOEuW1t/f/L
         fEE7LaZ1NVCLspnCwmJmNX8zyG6YT+CVoohCiIc4pmq7kuAVOL0OwZxTucTb4NQjySzg
         JEYVIFM8l+6Bejw2jDkHbkdFDKYX/C4a00M8UL8XXuhNYw1DftRTHuQ0sds5rGsr8xcx
         2m0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzd5jYM4iTzF8DlrnOs2YTD7/BE7jmMnAlnassx27NDZWat7WrxM56KjLSNoDcaDQvkLYbImHsBjKdJH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ0Asfiqmvg8XWIes0OsOeei3w+gEswk9NAGCDwnMgJQ7/ufrM
	ed7kSBS1ZhimNG9vUHCzPgQ6dR3QH1X5FoafDV2l1UD4ORxjtWfkBcRv
X-Gm-Gg: ASbGncv0wn8J8W5j62mgVXjZKfD8kwY/IUKl+GBlhQTIt+9vaw3hBW3BblhGw9pcHYw
	XnGo68ifA3KVftwFDlGGPuD84vKxzeHBLpWi6+2SFEA40ewWEwvRRjhoc2ZlfqxFLL8O2OJk76a
	Cs13JL0spvweI0bY6sMzr6xywvadmF7UkBgcUrXP1B1GVvQa0dKH2uldLcJluU2TPg46ROvyYE8
	rbiUek3fXNocBWPo9x7AyCf513lW1SjlfeaTV6ZPfbHRBnMP+cL75GbcSv1yGFL3Z5/AKLzcdZw
	RMlT/rihcHkS/ahMGM+D7RDp/8FAZzb4En9BiQsQO20iGUNysnMBiJ2oixdCIj6qMb3b7b4q5EV
	ButF0axklczl8gg8YSjuEN8JtHG2qz8dEVNSHWBQtVhr5TE5Ic/CqfsjIF5BS63JAlynzyhXfHg
	J4LAIQkzlZ
X-Google-Smtp-Source: AGHT+IGbjSFJAyEmYIrbmrRb0yeJFBW2dGMo2KMlv5+3FIAq4zrRdXA+otMMWuN8ptuBHCZdh1GUfQ==
X-Received: by 2002:a05:6214:1d03:b0:773:b324:c5b2 with SMTP id 6a1803df08f44-873a5574753mr9567246d6.38.1759253878259;
        Tue, 30 Sep 2025 10:37:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-801351c32b2sm99165166d6.4.2025.09.30.10.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 10:37:57 -0700 (PDT)
Message-ID: <0d6e467e-1c03-452c-b8c6-a9d22a497ef9@gmail.com>
Date: Tue, 30 Sep 2025 10:37:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/73] 6.1.155-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143820.537407601@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250930143820.537407601@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 07:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.155 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.155-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

