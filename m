Return-Path: <linux-kernel+bounces-733780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAA4B07906
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602B01894419
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A1426739E;
	Wed, 16 Jul 2025 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HMd+JYrV"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB41B043A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677979; cv=none; b=g7w0CsmOr95R18hmsJAkK1f17WutkqU1qrL6mKy1LRSfB+UdTM1ts+Kd48jQzog3br0ygsMaaodIadoD9s9M/xto8LXAztoPI5OVQs1P/X/6R3Njsqpql0KGf9Gduy6kY9rqe8ZbOTkFSs0gWKyYOad21eUvd9pT4IK2JUDjJQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677979; c=relaxed/simple;
	bh=pElvr6OAn8/o0rsAhu8xEJ0k4OTTaUohXepM9+sPZes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=blzNIcV8CPnkE2fMgSsqOgMOb26xHP8AFkovBZE9oek1OAE8CerKR1g6uRkK8o3j28Io1ZERkwG/IfRUl+JznoZTmbdbn3mpyBbt29e3ZTiC1R+P3cW6tWDe63scbvFJ6pQJ/kppCGi8azEbwJcoP1/bGlX5Sb97+/d4Q+UTj8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HMd+JYrV; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3de2b02c69eso40736525ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752677976; x=1753282776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eJempd4OJNDSO0EWYBVMBDa2dGUd1yxIO1Ir4NFgQpo=;
        b=HMd+JYrVfcPoa0DIhleM1z4jd82e41EekZJc3wBCEyT//TBacRomB4LveiiTIUQv8g
         H0Pbo+ZUPgztK86u7Jv+Xr+oGnN39leAP9VAXyq0sSAh+FHjSCSB1p4a7em7Ignsl8E8
         KxxhH1y+Bfc0ufgnBewR/sfFHo7UZo+WTsJCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677976; x=1753282776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJempd4OJNDSO0EWYBVMBDa2dGUd1yxIO1Ir4NFgQpo=;
        b=hXoA92ECanhhGZLPhsAJhTsJiGXGOWbOJanFJOVz/aegK9huh1F3cl9VzytMPp4y+A
         DZYNbYrRbGYTRbxq7woX9wlrCKRP4D/Pu1CIqrT88asoRqpC5lsr8rvgBsYPL5tka5C8
         v8N+x4jP8Khbn5WotvfHQwAMw49j0/Nu+ZDBQn9G/qW6dKw7nRd2dplBKWYGqJee6m3a
         +Ztei2rNqXY1pHzSCSMh3SZnDB0JjGZsWBxuNfsa+pIZT7hDp6Af+pkoXGsHzTZG4bUB
         L2fT66gdBq1QOoabmYhiNm/lf6CDBM5bS2tzTB/8wivHJ5Jd3O7386VCWw8cRxFzJX6U
         ck1A==
X-Forwarded-Encrypted: i=1; AJvYcCXgoD4cgV2lhWHNtNVs2mQ3pFmrHxjczcnrnwGAlWcjiKV6aRxaKPixZQcvqOCtfjk/gyZz7dB+F3Qa35Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNCatTWGkQ+Mp6JwsMNLy2ZPeHLNOkdk1UZ19W7ps14iJQpfLs
	UA9CX/mKcIBJKHV8TiJ4FFHVvCtLKPIjO7IzVffJ3LDqVdgODlVuS30ofm80kTVVDQI=
X-Gm-Gg: ASbGnctsn1zEyXQy8vbeDHy4R6K7UopXPfP8f5nntD8AohWQ7XWWk4d04QnMn8cLDOw
	EXCgAObgftNBAsRig3zRPc2XpiYrcqVhZyyV8ZN/+tt0xtdtl1nevvEUhp4LWtLKZrsJp5cLOg0
	/31qvoLzMyvakPTKh+MfkqLa8iwlO/mmRGWSzjHfJQPsPEpdCveLNmx6ceckq+LFgGGRGDcflxE
	V87YGYhhUqPa6+2upmwO593yyyeJ3l5gOKIwhQigzQ24tXnqh7vWNiWehnYuoKUkVII6wyB/GXx
	rZPVegu3Ktynk3o+DAtUh5e+m8dN+CZ/x0KxNxhvItwcr/likY9gO5wftqiHm1F6lwdnolt84hp
	5F3THapYBr61J6It5O9tg9f2BeHD5otvYBA==
X-Google-Smtp-Source: AGHT+IEHyBKfKdnKKqLqyogPmYS+T+iV5IDluzDqDwsG+9OoFrySizp12bUVr5zit6PtTuV85Lqb/A==
X-Received: by 2002:a05:6e02:3497:b0:3dd:b4b5:5c9f with SMTP id e9e14a558f8ab-3e28307b2aemr34336545ab.19.1752677976330;
        Wed, 16 Jul 2025 07:59:36 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505569d0e4dsm3015334173.109.2025.07.16.07.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:59:35 -0700 (PDT)
Message-ID: <d0459758-767c-4593-8954-bf5f23be861f@linuxfoundation.org>
Date: Wed, 16 Jul 2025 08:59:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/77] 5.15.189-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250715130751.668489382@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250715130751.668489382@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 07:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.189 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.189-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

