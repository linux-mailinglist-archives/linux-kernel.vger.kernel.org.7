Return-Path: <linux-kernel+bounces-842116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D49BB906C
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 18:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 622BA4E373D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BA7281509;
	Sat,  4 Oct 2025 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A0zZL383"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F425277007
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759597115; cv=none; b=SG1qUnAXEO8TmaGleWXF26TSpHSzlw/khhjq+lxOMYiHQi5NVyFre5dk3d2bBhCsfBBvFIEkVaZmg+CfG7EeD15UYdG5O40WjV73WK+NWXinjTPH7fzV/WBPAg0Li/JYVDqamiYR7MjDZ3tjW5zt32YT9FcgneoI4CgXukeJqnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759597115; c=relaxed/simple;
	bh=K9vC458WseZ+t5Qy5yDU9N4O2xS+IAk6v0rfKcmkCkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPK5boKazQGeJNCZBLX5iOV/OH+5IUXl3LOXQ82KcI/7xGYtKV6vuujhDwRUEwmhjkXN0+yR2gTi99OROcuhGmLkTNRcK0lHXaFeO4D+WHkYzMoT5tBEsvu5O0fjIMLuL+j3MQwbsnw13avxy6QJh4NT4OBXYVjJpbfZA5ENOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A0zZL383; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-42e7ad9474fso8965445ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 09:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759597111; x=1760201911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKCXGIJ/5BK0XkF8KRZhRh28Rfy6IWFA9g8zjTx/OE8=;
        b=A0zZL383y+HkitdZnP3b+bXSrq/QPBkAm53YTqd44BHkPLA7KXCxqF5tLwskOd3fqG
         MJyR2aOVONSZOpX17j+rBxmF4MuRO4Bdnsb2UrJwyv8nZa4VZRvdLYI0SlX4ooTtW0ch
         QJFx/JDu2X73CtMAYhdQofEBo9ZyOaLya5KG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759597111; x=1760201911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKCXGIJ/5BK0XkF8KRZhRh28Rfy6IWFA9g8zjTx/OE8=;
        b=NFkHxJNzJF8HpwspeW7qbI6Ba7TkW+2aXIcZroaI9/iIy5U1rynVFjaR+QXQ0fNxB/
         opkmXPUNMYbCbLL5YBmPnImUJoKCswPckLf2M7IE7zr6XRgvCQF8eSvPC7lwTKKEgRIC
         Dpeh7x7aYEv/tsVe/N+M/c3CBfIwEzzepBlTRvxa22p/I+KmlJr3q9Ao6OBxEpVDMY1M
         0vmBnxJI1WBrLhiOjrWvMhprYGX/QOW19d7BTzHHfFSOaGZXH+seLO23lSWavo/29Epv
         v/w0sxJo2nKr69gG7cDL8idxFy3oQzZKA6XeSKYdCKq7iXachu2d0o7Jj2X2s3dgXolh
         4VDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+p71OGkRCxLmmQNXQEdQ2VycbDAi4Doexh1SU22JRJzExyXobUaD6x+7r552ze5YCb51JUa2DymZZU/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz23cX0CkhIIAOsPtZi2eKzmGbbqEYtYisDwbfzCbL+f0CLtWf2
	sqqur3rbi8ifyLOqi1O6dcPKQn/SmvaQw9kldfiNsKmcmCX7NKYL3Sia1HQQKWiWhwA=
X-Gm-Gg: ASbGncsuyMg61aMg8swowzajG3YyuppjMnRhzp24HBa+kIZazJ1BcRgsJVXYFnQQLry
	0SPEsrxt1bsZMOYSBrSfcmVdYbKni3CqVoknqZy0vYqvGTWtXAS25zytL8t8IoXBpsL2XINKS0X
	8a3DZEkXPAnjkcsTpq8Cs9FHy629lwAy5GBtkznTtDdhyWUQoPplOo7KjLrZ0fnWfS6bHfOJAhu
	AXd+vYuTthUzDbZhtSnlAVz+XUi1IAz5gM5G/CQXLXAdAX+4YrOShdanxMGnKBtt2nGghb6VflW
	Rzhcg+qPCi4sqiH9XSXS+lU9R7XeLce6Js7VxGIRAA5JsqQ65COU45JGyEbr0jzCozaNKx891ro
	NjooKSIbGFK1nsack7YEpkWHP6Nri+7GP+lazMiPjXex670EOtoXMX+XAbdPu38q1+CvoYw==
X-Google-Smtp-Source: AGHT+IGBk0KCUm6TNrRRCC/kGTGBW3hhMrS42dCtvvENIAVPXJcG7xcFtOUNCLRzrIFUnqtmgp2/IQ==
X-Received: by 2002:a05:6e02:16c9:b0:424:b860:7d84 with SMTP id e9e14a558f8ab-42e7adaa636mr84992425ab.27.1759597111493;
        Sat, 04 Oct 2025 09:58:31 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b1f37edsm34479515ab.5.2025.10.04.09.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 09:58:31 -0700 (PDT)
Message-ID: <df2f8664-cb83-41b3-9094-ab2cd17fe531@linuxfoundation.org>
Date: Sat, 4 Oct 2025 10:58:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0/7] 6.6.110-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251003160331.487313415@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251003160331.487313415@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 10:06, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.110 release.
> There are 7 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.110-rc1.gz
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

