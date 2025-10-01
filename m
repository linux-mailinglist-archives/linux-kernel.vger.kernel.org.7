Return-Path: <linux-kernel+bounces-839281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D6EBB13D8
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A31E2A7300
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AF6283FEB;
	Wed,  1 Oct 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e8au/F/y"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0F27F749
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759335664; cv=none; b=PE0F57N1Z6U3ULbvLdAhZjaF20LTtuG6Cmlvp8o8p8LvUL5FX3KNaIHt0LnNwhfnuan14P4zSGpUnMPOPxE3KXpDrVKtaeh7FQaNnlSkLHGk7G63qHIobbnFJRU4ki/iOrAk+2bU6/+9njYGmxdHovc+9Ysf1XUcbowvMmCz/g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759335664; c=relaxed/simple;
	bh=dQwY8oJbnBTTFC31L8Jg28jquYZBGcZkQ4P0+XW1Rns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+AVtzvl1Kt7s+A9FACJjabfHjUAH2sjgDmn3i1gx9T46ZggrROGIa6eRS7Mv+fv6mZ/hJbWSKufwFmdKANJGB95AiXlap1g/TzEI0/h8NJh6j4mnGwiJqODiLv6lK3W6jAgC7rRg3TpTXLC1lsyHduVEsjii22bIiKjwjeqCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e8au/F/y; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-424d3c1256fso6513775ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759335662; x=1759940462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0Bk/1XsHqvwUKw08M8vbOlRk6GNltlYfeCC1qY6aTs=;
        b=e8au/F/y2X6fLRFel6ap370XESBKRXRqzllUi0I2WONmo6tWiCWtXrSwUCu0UunMlk
         vLB+z55t2XlXGJVCUIWgiH1Q6gQyCam3b+TavnFIlMvYF8aI6M2xmpJvpdn7N9TIKU2z
         1Gs5ueS6y6FlQ3rBQmPp3LbH8AanW42ARTthw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759335662; x=1759940462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0Bk/1XsHqvwUKw08M8vbOlRk6GNltlYfeCC1qY6aTs=;
        b=D6+XsxeGH8HA7NxcwoWkY4zJEEtHGk82EGGh06ZZRYxkxVMTP9RCF+/NiNsHoHhflj
         w2uC12UAe53sn4eiwgA7lpI442/jtZPRfigOODbqZODV8dhuGCdTftS23PFs1RF0pZSk
         iJ0dsCufXmaxnSd2lVQNfZHU/ngg7EEz5CiNxV6RZMTUVs2lRBnOwWM8hfOKDGJvKoc0
         IeOq75h/2lYBvUu7KwJVVPOw8LbBHpgkaIcxG58zvjYE3PvxXH55khJAEBoE/M4DIleg
         +7v8xJ0uRWu0O9WzMbyr+2LslGRLuyMjgYxL2pVbALu70/LoBoufuuBlT17geX87Kl3V
         5qvg==
X-Forwarded-Encrypted: i=1; AJvYcCX7Hxffji+c2HehIQ48muNyEfX7CCz6SkrD0RDWEV0ZjxZ8zSIeRwTFD+BxbWgGpC5s+Lppsg+Z1EP7d1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTRf5A1WnUPT2pE6MHC3RbRQWQ3BuHmDHNv2e2YW87HJ0ui4t7
	ctn1+C/lSZyCaRaifF7ZAOwVKbb4p/SkKYCvYIq6raalog8FJgbekmgFndQc7bEnGCM=
X-Gm-Gg: ASbGncu0Kp07/OFRzzYt4vm9tzfNc63m9r1dQJj08fB/VqtgNhCTeCl5txV4C7i3eag
	HpFOauNL6GYeG6cxsjuC9QEPI7ogQXJmiVETmbf49fvlDC6kN1bOvF1Y1GFbLMDkDPYYK8Iq7rW
	WI124ok0JVBsujwwo2XF9DI5nxzkLhEmHuczltZ9p/XFutd/ruuG+3Pr/YsC8nBDC+JxzcUZsdW
	04r6bjU2GOUIfTMxmxMPUpxlkqE0YQzdP+aCyEFfC6OUQso4eJAj3H2rHDV0Dyi3geo/wKw2m26
	MpKMfKvpuM9ZGqJNIqDDcrZClebh3kAsCqYv6vnqSOcGEKDVWcPN8U6L8+ZUGnWZ4/4o03Fox8r
	CtpQR9dR61pvDhqW4LwSbMRjRgAmpqbCd7HZ+fS0H6LoR8EqAXzFBh7+y0m4=
X-Google-Smtp-Source: AGHT+IE5vkMaEzImU6yFMmEFTvIP5csOxBViu8ui15pbJItIu0M0O39f8AHeTTk0IGXWIMdNvHoLTA==
X-Received: by 2002:a05:6e02:214d:b0:423:2666:4687 with SMTP id e9e14a558f8ab-42d8b1e1a49mr2165795ab.15.1759335662156;
        Wed, 01 Oct 2025 09:21:02 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b281664sm299785ab.25.2025.10.01.09.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:21:01 -0700 (PDT)
Message-ID: <1b7e8b60-faee-418c-ad23-c2e659ffd03c@linuxfoundation.org>
Date: Wed, 1 Oct 2025 10:21:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/81] 5.4.300-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250930143819.654157320@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250930143819.654157320@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 08:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.300 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.300-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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

