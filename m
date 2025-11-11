Return-Path: <linux-kernel+bounces-895953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AF7C4F5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 19:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFC23B90A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 18:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70543A1CED;
	Tue, 11 Nov 2025 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aPnq99cS"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B053393DC1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762884015; cv=none; b=GAeJjLxaFmxuBwEVMUWLVLiCbLbcEBr1FGRH9V0kM/9yLiXM6JBwqGNWJbqBdLXjJCRE0dXU8oXkCV5NS9pKv/N/8NTtDN5uKOxq2FXnZAuJSNp9nnRtEd9Jmf3HoQQe3AW5rQgCoTaUf59NTaQOB0+6NaeKc1p1vIMVmRV6hOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762884015; c=relaxed/simple;
	bh=8BGgfEn97snW7daOKRguJgMVYYh52RpW/KfSxw5SYYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKQqM+v/2TXO7y3+7lR6V0SdxzRx2iSZbq27mE0JJaY1WhoDBhOnAiD3BLGi16TjPv33crolrq99v8KdF6XPhd893iHOtwyJLFtXWJ9pkuRvrFJxwqcOuqlNySk3LJZ6U4XKvN+B5tqJv/bGTS9zwgIxPs8TQTVBq0riKj/yf+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aPnq99cS; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-43377ee4825so19562725ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762884013; x=1763488813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zu4EHUDGvoxogQX+S3l1H2cM4F4fAMlTZfbToOtiANE=;
        b=aPnq99cSbrBKvJqc5odQzBgFGD+dhmjpJszk0EuKoTB1SITcDBRURFpwmNJd8fkekm
         EGSwwpPoagIxhUNWFrum2VfBYXI9t8MYJ1YQbSF7NM2wQrPx5OUbYGUgFlh3d20nDDQ/
         h+js+9Y/pMqU7JrPrYYVQ3sIDWsMMtTRzkHW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762884013; x=1763488813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zu4EHUDGvoxogQX+S3l1H2cM4F4fAMlTZfbToOtiANE=;
        b=GSPrgWh+gN8iFWeoMjOCXMqWXT9VF4ZI4k1UifVThqxDUDlw7+Sve3JUGWMB/d5hbf
         hwc41bQa6HVhECNdd6tVOgsHGfRmGyBzae8YNvCM+12YdSP1wfyXdT8U/pEJg5zAort2
         htfXM9e2r1fcuKnPtxdAR24ypfaZgMRTAchYoIRtxx0vT/oPUsUXwsP+aMp5hW4jDYmK
         dgf6cR9ecIGdUipIEQmW3whKqpexd/gFEXpmY5ULeOSqDtHYKpYElD3R4xUe5/6LbHCt
         SPi3AjH7FQbUxjzqmjCkScZNSBWENJwFvYA/nS0s3Dq3WcFd2Of23FZP+s27rsJucVG3
         12qA==
X-Forwarded-Encrypted: i=1; AJvYcCXsEXZY9Im9DUftk6+E7XupgVM6zRDZ/5+4xlD6amCyDqm1YnX20Gm3JXqcPguTqGQ8sBDBxwR6/o/YXhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKrJbrSEnLqwb9+GZTEkSFmqC7WYiAZV5QBNltU0QgpGEyuZTr
	07YghcHr+oUfeiKciTvjwd50eHc1RGhK0/8f+XjTIvMhjGfsMlpv+vO/Sqs3F2b+TlY=
X-Gm-Gg: ASbGnctXYmGtRRPObA3z0U7RYn+by8hjdKmp62Q+v0GHVXPwslJmbaQRt6Ok9xr0o5z
	OltZnl/JT2C7X/ro1/SArZmEO6vM3ilrZ7hRAMIWuzN7xPoA23SmY0XsXFDxFOXlAXFK9XDubPx
	49jISKs1osIQBYmN6200SaH10WnLRu9BAVj0156TnK7l2TjlVtDlrwTtov1OkYMsyzONRMWjVfK
	IenZ36MhUcRJ6TXaiOB++QDACJDISJDrUJzkSpHErNAm+/hC+Ls2FgnM+iC+5K/g0wZHymJbYGU
	U1zZPfzzBy74okflD8wqC3HljNxdvyxDFF8N/6MjHqCyT6WOfAbSGUzKCJNyc3ejmbExYSwGwfJ
	b/iiTNF3RFiM520+OvrPbXpGG6jySH6mjd0iIl67aN5yU6DNN2dsGOXwCS8/woH5+mG7/cxRhIo
	g1h+8UxwnEeOH6
X-Google-Smtp-Source: AGHT+IEQMr3Vpgo000GhycQVvJrz9u/ak9auHMJZ5/xjFusfwrcdqUjlULnvSbDKynTKwDNhnUux7Q==
X-Received: by 2002:a05:6e02:1fc3:b0:431:d7da:ee29 with SMTP id e9e14a558f8ab-43367e79e87mr145738845ab.28.1762884012698;
        Tue, 11 Nov 2025 10:00:12 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7ab11690fsm116564173.47.2025.11.11.10.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 10:00:12 -0800 (PST)
Message-ID: <641427c7-0069-4bee-8e6a-53347654a926@linuxfoundation.org>
Date: Tue, 11 Nov 2025 11:00:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/565] 6.12.58-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/10/25 17:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 565 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.58-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

I am seeing a build failure on my system - the following
commit could be the reason.

> 
> Heiner Kallweit <hkallweit1@gmail.com>
>      net: phy: fix phy_disable_eee
> 
drivers/net/phy/phy_device.c: In function ‘phy_disable_eee’:
drivers/net/phy/phy_device.c:3061:29: error: passing argument 1 of ‘linkmode_fill’ makes pointer from integer without a cast [-Wint-conversion]
  3061 |         linkmode_fill(phydev->eee_broken_modes);
       |                       ~~~~~~^~~~~~~~~~~~~~~~~~
       |                             |
       |                             u32 {aka unsigned int}

I will go build it without this and update you.

thanks,
-- Shuah


