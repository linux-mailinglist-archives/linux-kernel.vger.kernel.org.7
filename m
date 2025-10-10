Return-Path: <linux-kernel+bounces-848847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCFBBCEB02
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575CA3B1DD1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E09275AF3;
	Fri, 10 Oct 2025 22:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D9sC882M"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9737F2737FB
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 22:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134849; cv=none; b=tEdlLFahh/MUxFFgOUi0Sr82je9avChqWjflN/R9/JyWFZMIJXtcesvo5g2RORQJmJnTgSlthPQmvlzk1//tHkxlN3KAxOxek/OkBsZnVQ8C7zkwLiwh3uFYg12SpFdrEv7zvX62q2NHQ/gOsnXgeK0IkYTTfh6Qp6QxsA+oZ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134849; c=relaxed/simple;
	bh=cFf5WMYj7i8FlQb17nvjOopoXo8xhjRrXfWeuIY4meg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYX96BjEd10FIpwp5xHK2v+4q/X1y7cvTuQeCBDZEEJHAfpxPIiOBFuDE5DIjlMtIIBJz9KfP/dRNtWLPAP3R9vbJ0DETVYMKFdp40YTe7jHrtIRnP6wDKiYnaNJZUCdii1BauLSN7Nm2IiaZ8xyqHF44UhldNGVVLctaEhIUuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D9sC882M; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-42f95010871so8764945ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760134846; x=1760739646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mcgyS5h12h/YMXurt2BySXwQEIYv+y3F4YEj1VF0AY8=;
        b=D9sC882MTZnZ+9pIzWh7OdKgYwuVNJ5Yl894tmhvJdvtOK5Imug51+yRwuTNc5M213
         8/8YE5e4iRB7y/0AZkrgWc+v/soATFd1JnE+DYWw4L/8U5Sxpk/LX5iDvGLDLpTWOQE1
         z5qt0Zc9/ddEBxAvNroxW7PEI2Xqojb6i3C3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760134846; x=1760739646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcgyS5h12h/YMXurt2BySXwQEIYv+y3F4YEj1VF0AY8=;
        b=MoF01KUnFwZaC1v9T6fQ2JXZuQefYWGnFIsGkYwD341WqwnVKWkGHZAUOYFSoi76CP
         Ps1PoBbnPiLMbKBClcD37gcYNp1kiV152zJkpEy/MYnu22Qde4FBQFWNQHgU1vLuHATq
         jY7Im0IF03oLoIuDAiqzP9BhQTJXhRFgmeRuzG+W1Wx1KHmoKSANlARIE81S1fGoxIRn
         hW3fWyRgPeHSPArbZliId7dI/M3k8Uy4xnkaUAFC5DigvV8lKl4p2m0wd5GluREl/N0L
         sqqcKgb1iU8KEtRKAimCIK6sh/3AWoDj15JirADiWNpR7fV0+v2Qm6K3r5jBKNwVhe+o
         ELWw==
X-Forwarded-Encrypted: i=1; AJvYcCX+RKaq3FzMDGenY5NuxQveRMPiDOyh4N5R/MWGaWtpMtmGssuBRa8RExZ1KXRB/1k5luJJAaJuE+CaU1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD+OaQr4gRMuz1RCaFLqP88po96uyTZy1lc/Q3sI1otKRdoxFQ
	xN+1q9+jtd7w1JVR0rzwNbwkIzqHaBSGrfXQo1dUB18WqoWnBsa+Cj3kGD3CZnRWQQE=
X-Gm-Gg: ASbGncua/U6m12QWPeqBJY8MkV7m8tiO9ssJHjhACpITeIh06ilN3Jxq6Q645CHfytW
	2zonJSRE8EGm2KwpL5TL5X0QbxxZLWlAB1hNVCnl2FH6nIE4e9+2mxKj15N7iui9GEJFzcD1aKJ
	c150QYOSz1Bdc7+EiLTmYd0vuGKpNqyPbtyYkH9+nWuenaPLq61LcpVvffEJwAhvw3Hvgeb2qKA
	I0thRbgPAASBATwssJap1LWGszrpXCfoJgXvYIscqNYwYswIQOJAtyaO/vWZY2mQmWUXTk4eZ+V
	LjinaWN4BLtqhrrj4n6UfTN9sH62atK7i9hrusYFxp6j7CXmesxnP3xODa5dyQZjLULBHPboOqz
	Wquz7+iRK1oRehh+nCu8SPFtll1aGuYCzby5zskgSW+PeZIhXr6gJuA==
X-Google-Smtp-Source: AGHT+IEzkaLyZxfVHWfPQPq+ejARtvPQr645Z5Tu8T35RonlMZrPGBKctzylzQITvc64Ns8COdYcqw==
X-Received: by 2002:a92:c248:0:b0:42f:9353:c7bc with SMTP id e9e14a558f8ab-42f9353c88dmr107126965ab.6.1760134845664;
        Fri, 10 Oct 2025 15:20:45 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c49553esm1299727173.15.2025.10.10.15.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 15:20:45 -0700 (PDT)
Message-ID: <10eb6d94-5655-4e8f-9b2b-728d14e91e7d@linuxfoundation.org>
Date: Fri, 10 Oct 2025 16:20:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 00/41] 6.16.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251010131333.420766773@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251010131333.420766773@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/25 07:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.12 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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

