Return-Path: <linux-kernel+bounces-751382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA32AB168F0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A563AC91B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E77B22B8CF;
	Wed, 30 Jul 2025 22:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sx+0XCrP"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E1C1DED57
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753913583; cv=none; b=g8FyQjAk4M4lHcAdoMZxgHm/lJn4A+ihJm0TgUz18ZUh5FtlMo9QGRJF4Q3dt5j9C7Em8E5CCV9eB9bt/kjqu6m5iP+HK7d/IOwje34dJgWrhIFDxrZWpuWdOrJ3sluIYDqBAZpn9iMr873QepyJF/+vD97MF7xD7clGpYJaPTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753913583; c=relaxed/simple;
	bh=qYO9XYMd9Ess2LLFsyadSHoQze0pFR9pSR+4q7JxSB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJuNlEtAWp279kd9FzHY0+zk2fZpeCV8Pba+wdXOb/SvVGBGFh+aghdAl+ppKN7vEO1MkjbWf6rTht0fA2aTxhNKfRmHLvi+snVwMXoqaC+NwKWnJg/bZxLFoCddGqAradaEECDIYsNRiQunSDeHPmbkv8YPJdrfM9GaQSUshn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sx+0XCrP; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e2ab85e0b4so6595735ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753913577; x=1754518377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nTYoBlbWe2hufH9UN/C4sSrgwEPP02z/hVZuVmtCWI=;
        b=Sx+0XCrP4+Q2rGIg3799Y6VxfCDIVLn7mvjlKiZc1fnNDIFbjSChPaxgrNKBRGe1Yk
         CAFE/bZyv1TgmXxrwev0ZYaYjTFJ6+7A28Mb3xfNWeGR6vjQw/Ww3Dka44l11/zq7onO
         Ks1/IMHxFf6NPbLx/QyQt5qNAShsm+Lyp6Qng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753913577; x=1754518377;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nTYoBlbWe2hufH9UN/C4sSrgwEPP02z/hVZuVmtCWI=;
        b=LG/wX1mOP3PyU98rRnubsxf6mDIstuWzEatJ/tYqA7KBm4G3wBurmiznPvIluwg1tf
         7HUPasm/uivu0E01rxyvu17UoYPK1NGLWNgcD3E4/h2hPQNT617Xuhq4XIGCydDbaQMS
         zgCk9ilnPMc90EReEanvcN4jQDeU4tc/tp3tX0OAn3Z175L2PmC4g0PJpaVokwEU5Xb5
         +WuGyxyeMNF9BYiGApWHQ9riOSsEc1Ni7N2lsNcGzxjne5jF2pzsGvJeNK22BDy1CyAu
         Ga0qdWpPyGmE2/66mA5O2CnoTUszK/H5s/D2FdvB8pWNSNvO/TRHz5NPa0GlXxdLyV1W
         EjAw==
X-Forwarded-Encrypted: i=1; AJvYcCVKonbff1YDjOdipAXq+HYndvtNUagT68b+GA2GQeNilcOH2zy48RoSYys/2x7iVFujhYyh9TPcwbdDQQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7FwogcLXeEDQMj6OAMZrCPIgqY6w+v/o+ebPzbEU0EH7D/eih
	tqDb/FT2S6TI2h/UAaRrPc4vyxoBM9MFCZwVo/S+I+/lhCO7M3xk+rYYDHw/M//0kic=
X-Gm-Gg: ASbGncuvkMmfGH6llfem/fvWr+cSSuDKA/K24kLZyJ//fypErBXW9pIbMM0l2AhTgzV
	xqEuejzLWncGbGg7EPCqJ4TqR0YuEwM6kmhLIZroPFbqlfyNSpGMulSm6TVcSlxvxc2G9sZ7ve6
	X+30Gwudwsc/zlIW/+42b+KFCtYKsAX/Z4PNkFL2wnr4aivZoNOUQVfvoK/lt+hamkExyQ12eIo
	n29SpxA5sxIKcKWikU4QY51mV+XPgHMb1rlsWRlK9OdTMQiGKjdWPRnyU6whmcyYOvRy5ZLVm0E
	tFmrVNXqhVc/Mge8mnoFfkAoa5PzXye9anzYFNmW40NTMc9r9G8dFqBsWqn+hMvdGRp4BYUC6kY
	evvuJLUrEX2UopC8KvjrkXo2u4vHcE5Y4vg==
X-Google-Smtp-Source: AGHT+IENXvtA8hkhU/P6BXgu/6rZ6F/aOk7oAL7Z3QHmfwQrFaEE1/aG4rLPZfTApHUL7oAUHR3i0w==
X-Received: by 2002:a05:6e02:ca2:b0:3d9:2992:671b with SMTP id e9e14a558f8ab-3e3e92ceab4mr94834675ab.4.1753913572713;
        Wed, 30 Jul 2025 15:12:52 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55da3360sm91133173.83.2025.07.30.15.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 15:12:52 -0700 (PDT)
Message-ID: <b718868b-d805-4ff3-bcae-3ee8b540707f@linuxfoundation.org>
Date: Wed, 30 Jul 2025 16:12:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/76] 6.6.101-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250730093226.854413920@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250730093226.854413920@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 03:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.101 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.101-rc1.gz
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

