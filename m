Return-Path: <linux-kernel+bounces-766946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A74B24D05
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59205188357B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07762F6593;
	Wed, 13 Aug 2025 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bbml6EM4"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3672D2F531A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097850; cv=none; b=htBRPIds2GBWkPQxvLYUCQIwuh++7buOWUjH3nFVz4bn/ICp/lLcW99rFnowcCpOLjA37T2u2+CoKuE8MqopJa0eo3NH0T9fdUy/tvdCfHU2sH44nKXs2uu3dOKdN5V+skjfOSTrs8299PX8yzVVt1YPxpiK+uv7KUF0/+PISx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097850; c=relaxed/simple;
	bh=qEyWX4DpS2OZS71Z3EmVZt3QnEC/1Su46EWk2Y0GS+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZt8D0HPWWB5BW80NEgpNQz0b2WmCVzGL/YJp/0qgYn+0fL/T+L6I7ETAFFuXHwpqWsdWyXLVKH63zO7s1GOpTw6xFSq4Np2THS0sSdtk1mwfcYOQMr5FPExGX8cmst/8mA4wRLwG8EOSUyXmr5X/z/+BXXpM7LaXfnZHlj2kDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bbml6EM4; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e406ca2d22so35706755ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755097846; x=1755702646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9TWMfaZ9cUPmbpbkghmAnSm/qty+t2w4h2Z0YWH3b4=;
        b=Bbml6EM4dcJmSUlUz7zDflXVklZnqbM2wZMCL+gI31yCikEYbTrDmBSHGvhEf7s1qE
         7V+gmPaEyK+gWhm2k/laTtstKpQPv2f4CAnmfy5DhLp6pynE75Tkkfk49gvjPvPLFCeG
         SqHxq7mw/95rq61RV0dQFfYf23fU2qEBTMkt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097846; x=1755702646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9TWMfaZ9cUPmbpbkghmAnSm/qty+t2w4h2Z0YWH3b4=;
        b=K9toh0MF/urN42NODVZ3met2Tj6BHWQ2TGoL1ysJ9M4NcJyMNywL/8qUKSBRd/eTsE
         6TF5LM2E2eKcc+5vyS+vHbRphIqNg7v1lT0tT77fcrUi0IMg9+tZKf53SFR1ieuzbrxa
         9E1NiyhKtcGCIBNs+WtAU8PQ/R4/4sTTepQrZ7Z3NAusXPzMTEJkawBeUY5NU/EM4r5I
         UfJeVymIXarSNkHLShivUEEwN9JnZJgQ4LjnKu5bGGkpMEg7p1fTXcjeRxyHxUOk2li4
         BZvKTst2q/LilsND2XELIv85qFVqOwa3Di4eJVRYjpWhpDBAaBppXr9VODyQYzI1kZ1Z
         Pqng==
X-Forwarded-Encrypted: i=1; AJvYcCW4oKWPPVP2iQUzb2WmEm8Ww66hwMcaxnuMXynBAUaWPZ/N0081aRP8l2FD/GfyjE9IUB7t6Y9Z25B2INU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyISNxt3wndaJSg37/xq7IzdkTRFDktbn5K4qsbPGUN1+gkQnjz
	hJCEOv4TQvLpP94ZNsdTljyAXDTf58fw8XtWGPIzepP4zhzj3EuVxOioOja6y/Z+/7I=
X-Gm-Gg: ASbGnct/hMI6mIOlIfncvF9xlQxFhkwFgv+pX1Mt3gDdPkuMInuTro2ArZ6xA8nVYbq
	lEqLoHFKe+2TJNdYyJRg9whnueruRjfkOiGaC7BKpW2SLDgkDvS4kUdS1rsjeVfYs4FJDwIdLhF
	E7DhErMSt5c8r3kNo9kT0j/rD5EhU0wFvIM3qALbJHOlY69N61/G6KKSp7N+qWKRRj0Ljv01SYF
	WA/BobMJl+nXRkS5p+Ol5TDTHb0DKMClotjT3bEAq+PwKLUPIAG2MqxcV1ALK4jQExasXg5r8IF
	qxCz7v8Nd5s+f2coDMsmtCcoLy70yoGL0K4c6CHdeE+qErudnsLJApZvlCvDm2WX9j+225lSoRQ
	p610jY5udSpZ9L98lYu0FrAEJEbj0JS2d/A==
X-Google-Smtp-Source: AGHT+IGIUfrH/onUJt9v2z5NiJEkUVDB0jr+F7u/mzY7NvvGCnp6Vfd2yhacr6P+7PUvb3cdMFgOqg==
X-Received: by 2002:a05:6e02:1645:b0:3e5:5c80:2cf3 with SMTP id e9e14a558f8ab-3e567492351mr51215665ab.13.1755097846224;
        Wed, 13 Aug 2025 08:10:46 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e55b077b34sm19523135ab.51.2025.08.13.08.10.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:10:45 -0700 (PDT)
Message-ID: <8e112680-447a-445f-ba94-1d4b25ce816f@linuxfoundation.org>
Date: Wed, 13 Aug 2025 09:10:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/369] 6.12.42-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 11:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.42 release.
> There are 369 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:27:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.42-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

