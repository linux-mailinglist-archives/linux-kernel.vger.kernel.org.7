Return-Path: <linux-kernel+bounces-838028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB0BBAE42C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372E319280A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B248620FA81;
	Tue, 30 Sep 2025 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLw8ucPl"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E042248B9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759255235; cv=none; b=F7Noj9brPnWUH2CJsTEQK7rQDFjFE9V4+ghT8YAn0Cay5nPk8SKeWr8oZr/ES8t+voRNWN1TbdHHeliTz8dTKHZE9MVBBHiQtxDCXmIb0aoNG/kEhO5qK61TOvioTpXfDOb8p0koyPjjtjTMoej4WxKuwuyjCY+jemBG/XiEsxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759255235; c=relaxed/simple;
	bh=YbSZbrwLsMWtea2gVsJ93Z7HflVLWz8Y++acXgdJZ78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jM05KlnrExEjuhe0Wonq36ZVNYMZO/yMr9ZIPAB30mLTeYkyAS8oIB+ex3WXrAN/PkO17ezxZa9/IeLfeLZStENLeoCsxpQAdiA+KJI8V6J3Z/Xt0FJtZwYHp7pQaNXQNK7n5kggSZ6+ds9DncGdhyXK7wOJ3N4t8BgUscL5vwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLw8ucPl; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4da7a3d0402so2368441cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759255232; x=1759860032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwfmIPtyp+rsa2DwTVLeGN/bTgy7je9QsgOF1Vb5InQ=;
        b=cLw8ucPlIBxGSiln7/Eww2Kre9NeyrWLu95eFLrsVHTxTCWy8t+xBf6Ivug2nRcA9u
         TjM5PEqWrRLDBKfYUm0QK+FWJN8QzMpfq46pkxlHg/Q6w4OAOlteE/KLwkpYqcxvoHxZ
         eGc+/ddgXsQAQBhuDyn1ESS3PkHXKwQ9bPpDzEP5onJ2aV5nZkxfNnEgauGU9RpNAmPs
         5Zol1WvGIFhJA933LtRGNr7GfJ5cGW5ZGaRYzieNI1L6HYAtNkbnWcYwehLp5IB37nNO
         pkpfKckyXjABkzJuQfDJEisEzCACk5niGCVqx1rFmjqCQ4L2vy83kUzCxKlhBINzrqx3
         KpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759255232; x=1759860032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwfmIPtyp+rsa2DwTVLeGN/bTgy7je9QsgOF1Vb5InQ=;
        b=Zpy4uZ0KD+gSJkVml3FRdbvXS6ygW0tQNHu0tEHl113OZIXdscblVYrMpXT+VHI1m5
         ObCest+pux1XrP268PwYV6dox/FSnsqVH7PGzF7PTjplM6LVpnwTcQy5cyUSaJMGgX4+
         X5w6bhbVDzDvDP5z0vFMdesIHcAc0ntrqJxKRrhYF6uWWFbYnztjlgatmQMu6amG1+dW
         9arEUlG6msgF3pAV4nnWpmz20UrxzJWVY1Mdi+pApgyt/YGrEhdN8kp157cLKlF5J1EL
         nNIX50RcBDycjxhxx+e8hK7URJaq9bWWdaT1lygIivI8mwHj45w5094sBe/xJ7tdbqCF
         7pFg==
X-Forwarded-Encrypted: i=1; AJvYcCVcBcYdGmSOiQEAgifw4jg8mqiI47e9ngjfdjv44wRFuQStdCZj3syfGDZ738g2FdtqcaOoWpcBE5U4Wbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyigiEmj7nzwF1BxtUFec9LnMyg77veO5+WTeg86C5JqoRZtk3k
	EVUP3TMTPexKUcpU/c0O+HYZ7ZGtAa4hK9ImDRSfwOE7FMKotCysUsmy
X-Gm-Gg: ASbGncvdGWzgG7TRwKo1UsIwbWRBzlh5QEDYq5w+uohreqKrgZl8VBGwhBJ0dHFmH+M
	pVvrVdU5GzUKu8hLWf70oR+JknUr//RW0Myisd56ERRGc+9DJ3kAKacO9JM6BuULfFb4wM743Ev
	Bl5GU4ihTpCA8msqHg7t8lYSYF37fIXPGKH8ZA9VrTQjvsbmD1LIfz+Ib1IBVD/y+AgMQVx6/fs
	eu6HIuToA4nm0w6fJzLKYtMqAXtPB8jOcYEhS2BPT0sWYOPTIPJvFbZGajrh4TFZXwaxpCS9vq1
	TIlNDVCG6hbUcr78UMSoGiZ49+5aSopwB03RUDWnWzQwBZwLDbRw3SG5GM1X5p/MTSlxbnQ8xzI
	Rz02Ax9A8IhTHGPbRvalPY60bCGA3dsVgIQCoeFWEm9zpTQTZqNwsQg9m3heNdFljWYJjxHFZBg
	==
X-Google-Smtp-Source: AGHT+IFqOmFo3m9m1uH4m6G/o8zmkURBdCOT/WGf9A+raEW73lMwTzSH15T/s5dgz5pdWTKLfpVFBw==
X-Received: by 2002:a05:622a:14d4:b0:4b3:4fa9:4cd2 with SMTP id d75a77b69052e-4e4068d9458mr13682061cf.33.1759255232394;
        Tue, 30 Sep 2025 11:00:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0b56fd1dsm98261811cf.12.2025.09.30.11.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 11:00:31 -0700 (PDT)
Message-ID: <00640a2c-8d8d-454b-924c-81da31e95d95@gmail.com>
Date: Tue, 30 Sep 2025 11:00:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/151] 5.15.194-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143827.587035735@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250930143827.587035735@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 07:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.194 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.194-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

