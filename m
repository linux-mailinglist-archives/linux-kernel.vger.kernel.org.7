Return-Path: <linux-kernel+bounces-741535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4C6B0E569
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F117B0CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4817328640F;
	Tue, 22 Jul 2025 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CnvWfY8q"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1827FD56
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219616; cv=none; b=OYgPz1Rx491wOAF8UqN21ZPnWiHsFSQ/Qj76UDTc1dW474y7YFloaLBZuy1xMIVPJhXGSKPCL/p9m1cwuDqvRqCWooQoNw1pw0C7AqEYkyGKXubyjRfWd2XKw3OgnPM+SQg7hb66aIc4QTneMficNkivaXUE4keCceShYIZ90NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219616; c=relaxed/simple;
	bh=R90sy8ga0ZZZAu0ItAJ459x0QIDCaY14qd4tQ/HifJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=goH0Je+qTghawL/FJeDDuylyxJf8FUmmqCLFklTZ6MaMbzaxpeYBAQT0EPd8NI6kG+rvqwpnLAVZeeRwgvj7i7CLp1NKRw5xMM7X/NKw23ApvOrD/eHddZhp0ynUWhkevZT4rmDqYDExWQWzL369qSlaBfuZw2GpILq4ZTm+ub8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CnvWfY8q; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-87c04c907eeso333798339f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753219614; x=1753824414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4UuRsKYfywplWAbr3imuDGMU54u1KPSnKxc8G3B9oxs=;
        b=CnvWfY8q66Z0J3Kim8TtHfM4+W2JZHQdxp6tsvUNIOWKq3NGXzZGPee46QOxAMGWLo
         i47Xr07TR7RdKQWKhuu5hNx6aOeD/vOCmd5Q0CeX2xzIJNtA6SqJjHKug0lYIyV3ZiVc
         RkQ0OzsvP0nXsgl/XA4ZoH5y9Nkwx2WCKQi7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219614; x=1753824414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UuRsKYfywplWAbr3imuDGMU54u1KPSnKxc8G3B9oxs=;
        b=mGGlu0n1Cnmg6OfPpQ/h1u3A5c9a/CwdBEJKN2RRPPGHy7jotv5UebPRYtO/NEQBjF
         pTUiM+V186DCU7HUCxPmh3onvNOTtKAMuc1YN6FSAu68bbd9m/fSclta4O8+ASoJ6vxa
         xejKAwiPe2zK0V+/w5D3s9usfhDS21GudnKXCLlLadTy0/xpNr8HQoHiDSlN7O2dDanh
         iJkcjs5T2PF4KVZ7pBrY3SVu+aGMdHs4jWUu5qOgDgtIIGhYeu7gxKcTBHTxyknaSICR
         hop3J6zi65YtzqcZBTxPz0q/MwKGqbAeYMIqQjhrZdrYuqIL6gNNsa9VVjF1+gXmT80V
         pLig==
X-Forwarded-Encrypted: i=1; AJvYcCUoJZiZ1JvFykbw9IFofnhkWPhufnHPEucsyL4rAy9E6U0tuUMmZNxatn0MIFGoheu8J7ZzJ47S/6dKXHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhrujIL4JGMyNQcLkb3KWl13DRusMhubSXVkL5eJE+ZW9nFlqi
	z6Eag62aDWQsvJl7VP4m3daoxLtyj/Nyq/QnjsWi7UJTdpsCoqR6mqAb2BzIwWBCPT4=
X-Gm-Gg: ASbGnctZC5mzb2XhWsmohxNYZbhpTY6DGWN7OCPs0G+ehSD7fusmv4I5CPrJnufKRb5
	vhQmWgjjETAO5Xhu+VMMjBRtS+IUAhBiRlpFqUWHQGLs1Ji/GGQhT66+d/B0DqALjbX9tDlegJE
	ydkgmOAV817Xs3bK3uTjTsT+o61t9KIasC3H2QHH9TtCkoLjQq4hfYtR8imW4AgVF8P2cEbltIX
	lOdrf4pmOa/LC+bh5pU0g1+8fkXjWZ45xm8ILpJo3Xk4DjVV2Hq0pUC5X9tAPfb/+FmLVPUTOdf
	MRSVT/MYmxqRXMGdS8LbGS3N8mWrvGzs5e1L0eROX58uFBJ7ebpwc/v2RDhD3XJLQauDWZl0FY9
	llx4Jth5BU/RSuZe7hSZZ8YfiLEItiEt0SA==
X-Google-Smtp-Source: AGHT+IEenob1JoKLFexDbIKx2AIbRh0HfTi7tgzzyJ46nb+DTSQdX6wLisZdHxDOfQgdRENh8XvLqw==
X-Received: by 2002:a05:6602:7403:b0:867:6c90:4867 with SMTP id ca18e2360f4ac-87c6504a724mr115953939f.14.1753219613813;
        Tue, 22 Jul 2025 14:26:53 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87c0e40f9efsm331649039f.1.2025.07.22.14.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 14:26:53 -0700 (PDT)
Message-ID: <27d83e9f-c2f7-4d8f-b5c2-0b23ece4ed0b@linuxfoundation.org>
Date: Tue, 22 Jul 2025 15:26:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/79] 6.1.147-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250722134328.384139905@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250722134328.384139905@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 07:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.147 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.147-rc1.gz
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

