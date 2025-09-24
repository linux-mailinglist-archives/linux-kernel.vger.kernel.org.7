Return-Path: <linux-kernel+bounces-829797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED51B97DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4438B7B4DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D824F13BC0C;
	Wed, 24 Sep 2025 00:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LuTgQ80v"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8527B23AD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758673663; cv=none; b=hrZrHWIoRbqyNvGgwWKeAmWM2nrBcuXjCQio6neBJ4mSdko/CRD9Bi9xDmqZTxrqta9bFO2xVkJYFVHIllbgqPAEl4SEEumGndScdx7JoG17qc+7kvBZ3N/r+43cZPzKWiZU2BLhQ2mANiIz30kF/tfvmzy78y4DIOtJe/YcUQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758673663; c=relaxed/simple;
	bh=5Bo7zvA6zBJS0OJDG7OZpq3+FCrMly1wKoLYNe7TreQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BT1SDsqUg4cfLF4KRHDa0QaDwSQNPhYDhuVZK/tMuF2LpejEaiJTo2pofvx3M0oPlw7Y3cnBE2n3orH+4LB9RU5UpKK5fE8gCO+EQBSj0qx9+2gKuV9bk4l6yhDm9aC16pXNOJcam8DPzwnFurPAazW3A0PK8CdGyELjLCOTxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LuTgQ80v; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-425715aeccdso17412705ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758673660; x=1759278460; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Wz4Rjalrhb/QiOrQ6U7e+va/tUv77hOSowEW0Hrr4Y=;
        b=LuTgQ80vk4RMCLG+KbnDNtBa2QmOSazq2f4c5WDf1XEPsievtHNre7khAvsKscJEmj
         xfTbjfQj4HsDEnZaiFfUw79HW72c0T5AEU6ISMUMlqEIZ6ijLbQGJnmmgRMGcKy1ZDD4
         FWWbZvA4700HPhdzYgvHmFT/mjBVyV/JN1PRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758673660; x=1759278460;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Wz4Rjalrhb/QiOrQ6U7e+va/tUv77hOSowEW0Hrr4Y=;
        b=WFS0ywz5ay2p/T7g46X+kEU4nBcQ4glkh4B0cvx836+2TlWyXZGYwrhZJW7T+0CSrG
         AIduhPEW9xxZ4R5pRDwIYhRVL1kWCvfFMrGBRMx2uv6k2K/9shFgUAnOs2WyH7wDmNv+
         /up/qrXDWMEbQXbTEvUJqZ2UJP2mWDo8U8XFYMvkBdQEhVbNSYMoTAAsyLL/H8ee2YlN
         63QZEajRqm9EOxmgcdwOCNs5b4Cjw4/rYGDDM2I15GpTkK9UqGpjuom8Fd8bvS/1h0Cn
         vtqBYd8zY5PZd7ZDdLMUPts2takHa1fTd2yZ65TMU+TCzT6PL8PgEEXsmVK5r+ganRLB
         1ZUw==
X-Forwarded-Encrypted: i=1; AJvYcCVQSM5702fPcVpJ1tFZhH01QJNbbZVgSWk04rpghlyG8SZM67wAeLoNvE1r/EIOdaIeL1DKXFVNu8y79Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDS9Lpjt2NH2SEX+0KmcIY7o6qhkiVYlaBtNNL6M2u6NLhYSrF
	q5Gvo9Wv6P6hAt+uG/gQz5M9DfmNrcTQ71Yitv7tESh0dXKzsKvBLb0+R3l/NoWxsro=
X-Gm-Gg: ASbGncus8tU86+MPrgFG6I9u23i+4LPsRio17/jYsHrwLNhDXZlcX4RXosC59KXD0MW
	Jocj76THTCe74aPobig9vNHczHE7Oi/2OwYwGaPIFk9PVPRMHeqa0SA0Ci0yqwLhRBVpa+jZGUC
	0fkBsAcOhxc1iMEetZA5pl+8YDFzqwT5ym5AncS6+eiNmWkD4cR0Wfc0OZ96vhoVpoXhyrmYuW6
	sz4l88LkYkNUxCeP4GIqgby3xoTsIjk4nFmqjCOb2kABD4taD0A/bttTBA//eis14qtGw0A+e5l
	pEl9xN2dtJKNCbBiEaOUUqZICTPYFbnVY3oUmFa+lQUU+AXoMKLV+bNTDBh5KzsxMR87BUDx9Mu
	4Mv54qPBhFHjOtJ4oTV101K1cOdydNeVnXc0=
X-Google-Smtp-Source: AGHT+IEjOPwrjQXV1ckIcBONH2sqdMovm36FztTg4RY0FjQkuAcLbHH6PXEtgycQCgk//BbSsBfTaA==
X-Received: by 2002:a05:6e02:184f:b0:403:c8eb:877c with SMTP id e9e14a558f8ab-42581e98f31mr80677015ab.25.1758673660629;
        Tue, 23 Sep 2025 17:27:40 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4257d1c2a23sm24632625ab.15.2025.09.23.17.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 17:27:40 -0700 (PDT)
Message-ID: <5565b45a-27ba-4283-a671-fb43b01e6446@linuxfoundation.org>
Date: Tue, 23 Sep 2025 18:27:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/105] 6.12.49-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250922192408.913556629@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250922192408.913556629@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 13:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.49 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.49-rc1.gz
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

