Return-Path: <linux-kernel+bounces-733785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C03DB078EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94AA03B8F09
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543E31373;
	Wed, 16 Jul 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EhTr8Vin"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D201A262D
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678082; cv=none; b=LrCm3kgSM9dUrJGilONY+LwnrtJRlMoy1BwdRsZJE6V68jjECjDsj5d6T2qGKF7qUZnbpDyf5QDjiU2mKNZjk/RcEjEg5n9GCr2TyRyvv80I69p3Js/ZCe2xtUCcaBxRefIU3TbTlhJzoqmA/qkk0UHbUyuKWwX8k8PCBo3BZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678082; c=relaxed/simple;
	bh=E8bua9ms2CAifgDQWPYLUARYXuLyT8TOKHOiWf9yyqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=go/MhgJJ4GbD1qHyNrIP2ZWlFG1Rt8Ik//Udrf2S6KqWPXqa4+Dvh/QpbjqaC4SteXVBunkXjGjrf178a6rZCE7R4lQShpinZ2AHC3m3dQgIkk/OnLW132zS2bdH0miaR/RnLuSWEUVIsKMcNSe/4wtNwoyV6fOoyFfI1dWFC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EhTr8Vin; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3df2d111fefso56818175ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752678080; x=1753282880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/L6AVpaMRxQoagP/2U0TZvwKc8bT9msQKrHGder61Y0=;
        b=EhTr8Vinw1U8IFreOONY/1Zj6h18DckqFKiIYTIeROGXGJ+UnEn8JHGcs0VO+fsKEM
         +6GIzXmWiuQkIYGtntur+0NIh2oRpz7b2fRsl1WvJWMTH7qWIQUL1Mzb9niLlbk4OXpm
         6wjtgSTqZA+V8+b2/20AEJ7oB3QLaIMIE3S3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678080; x=1753282880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/L6AVpaMRxQoagP/2U0TZvwKc8bT9msQKrHGder61Y0=;
        b=Lh9O0S/A7gijCK+G7F4i/WcXWs0gPOUP+sRxRqLWlxy9qZ5arpOTdfGMaMPb4KChbe
         qNuwTX/4IdWbZNplnn2qW+vAKqOPUAaFsOkXi54o8zUG9pled1IrERbwwN6D+LFNFlbX
         5fzg2bGjj/whKETvkVjrVWgBhUF1mzs8QtP5yvJf5hH8KQBr60nzJAG8u3LpLHqk0VD5
         diPVBlf6Tv0S3bvUqkq4na+flJmkSBofVZOQv0vchTrz8pA0YliRGSRVlvee/h15L98a
         +cYqU4MCVbGeslqhrI8ddOAaJRybGCwPI9MPpVMo+A/0l4va86dPqvmnkQ0/GRXJHSmm
         j5zw==
X-Forwarded-Encrypted: i=1; AJvYcCVOwumEAxQBQ3f/xG+ag8bpjL419xKhs4DUFkltxdqhrxBsSaKTRzcv85Xz7A4ZMkU5aQaNaOuRJp3wv3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0fJWalzkm1sf+Kk/jZoPHePikS0c4xEIj+Bxxsg6RerXQBB0b
	2wwKUfDICk1a0XMv2TLS5C2kuVUxejfdUxykGiWSfSgzp8/DVa3PiCGRHSRMatE25mI=
X-Gm-Gg: ASbGncux6tTHg6hIWMaxMa2wW087drDCEGbrmfBRa3CHn7maB0JV7Qu7vJ7DzAsUc2z
	k7GEk0/klVJFTtF6nSUs0LJ5m6Kanh7o0ODgfiMwJzuP/gn9/lVD+LbqlhCKQ7rYX0xTDk8P8lX
	9I7Z/nMNvqz8qZwKNOnUBbBiRP+ghWMXrm4WuYJ4B2P1y0i5uMNbcptRNS7htQwQuheCHY5CnSS
	L8VgnwhbL/wPKE6ruzeRfw5zCD7wjXaA/nQ4KXjPf5rdjAIUktEvDE5Sl5pYRD5EZ3JMRWwulF2
	+LLQ0WAAPLXsN3lbmrn0e28V02diSBVUby2FDwUBEiLBdXvv+dd6ltrT/yQ66xc/AXQWJTho2iU
	bNDQgYfdWkWHuzlOdEj/UdhwO7Fp2EYewAg==
X-Google-Smtp-Source: AGHT+IHfZQtErGT+6TyVnEo5uXoQ7tA42hG0UFbluZUKT9wY/1GsEkt0bSHRzJHzmhjhK6e2Gk4vMg==
X-Received: by 2002:a05:6e02:2288:b0:3df:47f1:bdb9 with SMTP id e9e14a558f8ab-3e282e8d3b9mr31378135ab.18.1752678080006;
        Wed, 16 Jul 2025 08:01:20 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24611e84asm44726865ab.15.2025.07.16.08.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:01:19 -0700 (PDT)
Message-ID: <a7205943-b3f2-46c9-a00b-0706eae9743e@linuxfoundation.org>
Date: Wed, 16 Jul 2025 09:01:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/148] 5.4.296-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250715130800.293690950@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250715130800.293690950@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 07:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.296 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.296-rc1.gz
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

