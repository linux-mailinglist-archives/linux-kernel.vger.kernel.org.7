Return-Path: <linux-kernel+bounces-838052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 802D1BAE52F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D79F324774
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEBC2343B6;
	Tue, 30 Sep 2025 18:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY02zDuq"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A695B223705
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759257436; cv=none; b=Or1bf86AiEQjN5ffDL5Z0QBNDhy/PoU4rlelulug/V20Ahfda+JFMW6vQNUE8KUGdodqocYVxDsb6LDgGbl5OrBZ0992fc0RBTF6axbCgUyLzJpeznuVv/qZ7+ssAtlEg+v0ttvz38XMbLNmxXQFs1V3zg7mejIYGqZ4DvP3XWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759257436; c=relaxed/simple;
	bh=UzISaNqBnr6oPeKPZ/ZMlptaIWSDz7JBW9vqCatixqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oq2x8jb5SDq2E+tO9kaAjCHtjhbY6Ju8hOy1Y2YSxENn3WSBSEXpu9LqAj6Qrqe3MpVEeInkskN4qzanX90IGuCzQWkKUw6r8Gh7JMZSNL+nXzJJQiGfBS54ljs0UmYqhY+7Wf0grReFJ1z2YZL5mLeBtH4nozbyBRDEeAMvyIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RY02zDuq; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-81efcad9c90so47215186d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759257433; x=1759862233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2QGQGEsrfTFXVfCocwQk/OlKEvR0Qi5M6Cv20Qoyek=;
        b=RY02zDuqEn74SsWRmi5IbfV5gu1lyv1rh2J/LfwhvoT6G+8uaAdTPDH71mfMnapczZ
         +LDOn22BFcJBuncxK7oAqzKSqqGfPso3nABo9jMu+EY7aFvF21Oopa6ex/+EMcINwk88
         6Nx4G9GHqOeH9JMGgLwFi1ZA4LUv17RBcCbLXEzSzY8May7apXLUYykGMwdMZ777YUZ3
         dS5ZmbZbIYjvj88eeDJq3gW0cFYa/a1NWrY9mEstcolr7It1NXS4G2+dJHjltbwSsHaT
         kRHYQTFbvartUtn8cDXou1ajtLby3JDjFiaAK4XeBRKzwpuYw/4gv7drRdpr3v+0SqWd
         TaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759257433; x=1759862233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a2QGQGEsrfTFXVfCocwQk/OlKEvR0Qi5M6Cv20Qoyek=;
        b=AikuCrdKY+I8enzGQSe9miwBXmM2h6OxafoB74tV8VfCPxTgkDAluYUVM7m5nhEeIn
         q2TPa1eXuu92sG2sG/xcs/xDjQ6l8TW8PORJcjVhaNeJJl8bZyEUDmn9QkpZBTCjQNv/
         UMLZCN57MC+h2GHtYa/gsuUXdnnrgX7tMT3m79poSUmac1NrdN9gtcmkfxFHwVk15Uz0
         B3VlmE2t5OwpKwzIDX3iQugYWgvhhgm06zIfL7jaBy1Qqir486ZU7UnDuCip7vH0hQCA
         GHn0xf9dXyhULIpZX/zhBnsLYTD4hNmVHJLwjIcKHqPHaHCgzJfo2EmwN+QbHmvO4WbJ
         8PWw==
X-Forwarded-Encrypted: i=1; AJvYcCXqMa2XLiu2yDfPjMWqucyyvHMN6BbNpoMVCwezz7gAhSTc8JeCHh+sRcHpKdgVwTjgDJ7S7OzC0zqjYr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9nYHbRfG3jUUL6nr6HnkWRMqoKA2d6zyWVh6oErcHeASfRc7a
	qGJd9+9eOJ1CsEG0PCkPfueedFJEA8c4GAaStnbFJzeQBUXpbOpVWMFH
X-Gm-Gg: ASbGnctbNyge/CNpZr2rOaPh0gbZPY2gWtIzUkqvDI97tylZglgRvcP8Sr/jNzSjGCS
	i7K8HPHtW7OBYftB6UEvubQw8xPYY3YDqB6K2QhmAUmKBSyH79H0y8eDjBOa9JrN6c6bSqxwGjJ
	FGvy1jDYeEnsXy1Lqwgqwbvblmt64KQH8zoa9xaXRL/YCDsRrDoOoem9NvW9jDb2txf4kW3g1iQ
	HWF7qVyvm0/TlbYicwzu7aLkTK/tbsbvx5PG1SI8G/K13J0CFaWbeBmYq02zKqLAWpXbKieXEZS
	lQI4APwMeMX6SlL34Y6VRXBvCb4IqzKZwGPuCrl+peJQ82b6qBH2uYAK8H/JWXiJxvhkzHVRVgI
	3oPdbHfIY6iURUxpZaq3znIyuRnbyhRI34wex45+lV6bUTY0U1tCQHI7IU+mrWAdfzQq92DuPeU
	WXuX5XBKdt
X-Google-Smtp-Source: AGHT+IG1ZzECb3HDDfSi//Asq0waIXTic0POdoKNFFJPYCDQ78uGhB+aw9swukGFQsfSRdJwVYvYxA==
X-Received: by 2002:a05:6214:1bcc:b0:7f1:c596:e1cc with SMTP id 6a1803df08f44-8739d051ce4mr13159286d6.19.1759257433401;
        Tue, 30 Sep 2025 11:37:13 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8013cdf424asm98541956d6.26.2025.09.30.11.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 11:37:12 -0700 (PDT)
Message-ID: <94f572c9-36b8-44c6-86c6-cc28f90de64d@gmail.com>
Date: Tue, 30 Sep 2025 11:37:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/91] 6.6.109-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143821.118938523@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250930143821.118938523@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 07:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.109 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.109-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

