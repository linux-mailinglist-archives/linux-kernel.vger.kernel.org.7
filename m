Return-Path: <linux-kernel+bounces-865488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D70BFD451
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B428619C4C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28102D4B40;
	Wed, 22 Oct 2025 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A0+836r4"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B929B20A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149849; cv=none; b=du9y4nSH0S7CCKqdq+np24h1ZIgSA2spfgEEuc3ws8uquO48W1i3CFC2FVnVk0/ilHRuHPqpSU28Hd8rPOrfwvaijC6+jRWDKgqJjtgPhpAxFXZLuCiOF1EbIH3Lm+B0ysSot5ghnUJ1CUcsnurA0w+LkflWjdUlh41WuV39aX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149849; c=relaxed/simple;
	bh=bJnDcFIdIHGxiONbn2/mN1YrXxkCQ69AXDwYI3D7Ojw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgKPjGVr1S+GQhvMqpsb7/F1V7fPj9tGnN3cw0f0V963RmlG8O07iG8RiaJDV/1YxD5eqk3IzZFmtb3SAQMHmZxYvXWrhQdlmE3zK3IZR+4joyD/bJy9ixUwP9z5fExzuH9JVZm8rOWVFjegihaBFK9umIU6d3l7d6diajT/vDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A0+836r4; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-940276d224dso443733139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761149846; x=1761754646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohIPApBH9FOd6VfSJ6LwqJdcHsRV0vgebW42BSjwjLI=;
        b=A0+836r4epO+xX3d6pNKxpILxLXAxbA8LVrO+vNouFSKbY34blWi42DRyQ8tlR2Vk9
         UPGSzna4fwrdvdVpwoQYfkdVHWZRCwgyDWXecuchKd/17py0XmtQ1rmWoIBeIYmtMWEn
         w0qxynlTWrljhRXhUCt714gfbh1/Faw0/yRX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761149846; x=1761754646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohIPApBH9FOd6VfSJ6LwqJdcHsRV0vgebW42BSjwjLI=;
        b=gxfZwovAgEVjAgHo3xftZ7kaitAsJT5z9Fpq9P5UTMFQyJmIngojP0KD4s9HAxSna0
         7ozMeoeZEnL6Y1osl2djmhR0hRaHmVxQnGLsndEzUD39302V7HoIofLHK93oxnCZtIlP
         9CBbPhIw9Vrg5cRuBBgvzeesbNoLDUaz/+os2gTSml8TSUfhv5saU897b2JRobQYNMxv
         rsKHQuWTYS+vVa6BN6nZwfQas8PFMftFyh5NXLCC2cR24RGz9PRY/C7tpTbf+ebBxNZ1
         92+6NzrtHEJpEuiU38NhSy/R+efPgV9rlt/g9XpqhMXl15hscx8wgLG9A2QY8Q9HUEyK
         y7ig==
X-Forwarded-Encrypted: i=1; AJvYcCW70Qv8ry0htfKlys7txL0dpjGGeRSaSqpf9GxxOBobkDBw7FlNklE7ql/bgufn6nP4jDATnceLMREwEsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0dewe3PGFhbUzZKuwJIXOFDv+Aht12WlbigkvobFSEjyb4XBu
	fmSJ/fnXWfn4d3sge9s6JiiDF+2HPvo+rWNKJ/exGhjfQjcIHEKh9Ro/8ZR5YF0704w=
X-Gm-Gg: ASbGnctSN8Nn9gKKFF36gQNk78CK87sq/jw2HEV4tbc6OJglq/mStVT8Ppv581usLB5
	PvF4wOdhmclUHd6xRy95V37O6ft/E7QzGf6H5uCF3RAHBGhyFmZvyMTM1aBNjg692A29e1q0iVB
	TUuAGlOaFwiZEOv6FsBxlFg4Me5b9zNIjw3zfcybRs45p9cAcQX5m/n7m/70ZbtiOzExq60apDX
	0eAYJqWE9t3EUcrYxBjw5UqQjjw0gKz8zTTJFUoK65dTSJXOIiuzshO2vofAI8XVVyBmBIRSqdo
	B7jD3bCVHj/9KPgiEQjz7g8KlNmldqZ0xylYR5t/Iw1Shlq5kdPhzSCXkv6OJkHkTh+2GA/IM9T
	1i4OYD6uzuSQ3foIQoA1b6a7cUb/gBoIxsCOZ9jgpc8HhRQfSgC4/Bpr4QXrr219ou4fL8t9Yu9
	qZ69AY5OvRunZV
X-Google-Smtp-Source: AGHT+IENId+3otkyvFCVvSbIP7aMnHBbcVmNJLxAqp8FAcojgNqEhNO66lf7DIELTcRS0+v4li/Ckw==
X-Received: by 2002:a05:6602:6416:b0:93e:84d8:429 with SMTP id ca18e2360f4ac-93e84d80763mr2540500339f.6.1761149845759;
        Wed, 22 Oct 2025 09:17:25 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e8ca2d51esm469991139f.21.2025.10.22.09.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 09:17:25 -0700 (PDT)
Message-ID: <e4ca190d-313b-4c0a-9100-9c351b1be22b@linuxfoundation.org>
Date: Wed, 22 Oct 2025 10:17:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/105] 6.6.114-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251021195021.492915002@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251021195021.492915002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 13:50, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.114 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Oct 2025 19:49:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.114-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 


> Mario Limonciello <mario.limonciello@amd.com>
>      drm/amd: Check whether secure display TA loaded successfully

Verified that the error messages are now gone with this patch.

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


