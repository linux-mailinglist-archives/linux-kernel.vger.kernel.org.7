Return-Path: <linux-kernel+bounces-766957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3836B24D21
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145DF1667B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD45A1F09A3;
	Wed, 13 Aug 2025 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="giIE6ZUz"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A9A1EB193
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098197; cv=none; b=XcZuk/aGBXRFdajgWJrhdKgPWi3raQgzOlyZR7RnpCxiIChvHIsBePiPfDsgGyMMm5q1pvcnZdxUe3CR5HwEo5g2Jy0xWZF5V6nvw4RcArqV1AlYtce10hWPHqauLVb88P06AXwY7rzXEvRljr1XJvMt1zD07Vu38rG/7cwofXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098197; c=relaxed/simple;
	bh=YWu6QysTTta+ygIB5yJvbhmovNUrZ+mY2Zbvv1O16X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AADZGrqux/7CTuFA64+VUXvWunhbrh4pmzY9y09oSvRpNMzRqyulOa20Dz/2kk/PQ6xUaiZ1jlIFwjm+N24nQc7uoaOuhsZ9LKkIlHNIScuzLQTYqBQB7u6NQguFaeGfpQnOS6sN1GTqKSMXeVksBZ5BmhsXCYMBvStNYShSYRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=giIE6ZUz; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e5614e02efso9793645ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755098194; x=1755702994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shieCgzmVFkz48fGZIWPswfofiSSkJbIXRswAa1EobQ=;
        b=giIE6ZUzXsy5BiSrQL0MfvrHmTJC/QgApadMRKTwaz5RCeH3bFX1XkJg4DAPaMkPNx
         5jHBIHwNtjpYMhOsC84f+8FOmxNP7AsSp0Q19UPDWDXnMvmhAGzeq+cEa4ZOS8LG9tuB
         4hHh/jkYrI4URct0zsXCw8q01h4FIT26RpE7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098194; x=1755702994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shieCgzmVFkz48fGZIWPswfofiSSkJbIXRswAa1EobQ=;
        b=Z4XfFwdl8ntWoG5GJuTDQT1EV1KQgmIHdXdO/HY4sQXvNauYxLYGBiqat+2WDn3sYo
         F/hYwoWfEleUuCB2My8/PIEy3htCGjkDiHh+NCekMNaMdgp8b38Z0/1AK3HPWCprh6cG
         t3p37IvPRQN4qEGALGBpzUgC9yAMW3H79O8Zy0PTHC6ay4HaYfzcKOTecNaZ4uoVruOb
         cNj0F/+hUAQjbkJyuSWSmvjT06sgTNQnZI+6eY1nwFc7SlqfxtUhN7PLoKThSHXvDH9H
         fiRnoR77oaOYDJFAMhIe0reN8vjlv/xjrXGwF3AT91DFIDB3GWwdgnPYqHHflSY3tVJF
         eqDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9OYE6DAaQHWXH9PhtdPs3xk+GP5kghJfhsESdgqQzshWbEYUiVaG4e1292EzRXIwxW/ZNrK/fiqoQYr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1IXZL4zcfdA5IQeyam77iwu8Mki4s7XsxVJzqCSi5ipipjbhr
	/BHj+LN9637NF2svpGuCR7XnZWzLf8iOIWg+WMwKl6Pf4EfvGolvPlwa9n3kmEPBcaE=
X-Gm-Gg: ASbGnctWtA35b5iUd2qUYh4zdwsXAg+iVLDzwVimDxUQFEQomBr6AbenY+8FhzVSwWh
	rySAyLYUEAxVBuDyVwOWGPSucSWSjjadQyBqkBO3HTcextVv/jXegnLmFDU+ZhfYd7p0pRDJvGF
	rv+NBDVEDpE+7/NkRZTcCyUlJ6K8RHWO0doiu7YSjKmGOuvqgnP8kvk3OGalWQ2jd7MZtmp86Kb
	zcve6OBJsFgKRn28e/B7fYbuNQm7zjTgRxLiTxGbIWUZl1OZXoiCcfYJxPZq8QrM9fHBMLgz7mH
	84XUN6+BNf1VFnWb6q8B7QsWbCm4AJMmBkLmCC+xS49f17WYH8hOlFxwJA3Esw2hYUntqcB+fC5
	HBzBw/ib42qjQj6kmHFm417gsZqWbYDDl4A==
X-Google-Smtp-Source: AGHT+IH3h+VIDrQjN5ai4jcK9ftE/5NNjveL7L/XQI2ggB2zwH69RAmhjvCcKUG170OJcY5Gh8frWA==
X-Received: by 2002:a05:6e02:1fe6:b0:3e5:4b2e:3b05 with SMTP id e9e14a558f8ab-3e56739e3b5mr58175045ab.2.1755098194414;
        Wed, 13 Aug 2025 08:16:34 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e54270f79fsm43167685ab.7.2025.08.13.08.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:16:33 -0700 (PDT)
Message-ID: <0e8e6d86-1fd8-449b-aca7-5ec86b049267@linuxfoundation.org>
Date: Wed, 13 Aug 2025 09:16:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/253] 6.1.148-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 11:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.148 release.
> There are 253 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:27:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.148-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

