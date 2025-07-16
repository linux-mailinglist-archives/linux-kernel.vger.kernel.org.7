Return-Path: <linux-kernel+bounces-733677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7997B077B3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F47A421DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED5621D5BF;
	Wed, 16 Jul 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TclcVioV"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A76224220
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675193; cv=none; b=K86yHCRSz09xu5Ku5+5j0WBm/OYVJqNQW1Ijak7RFq3m+epMnYhv6HLL3rSIVCMdcR70Q9XrQGq156BuRmlDrFA72TtxjrUZP/Ni/1FKoYJ3H2PyNCoGP5vtBma5ml3WzTIlDFZ6mZwp70e4WbsrfMxQ+7n4t+kzIItH2GO7YRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675193; c=relaxed/simple;
	bh=9KP0i5+cSVpJWMEJF5cFZAgK0HCmNuvp123htV7QtDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHR2X9SWMWdFjNgZ8QK6RdvNxNVFiDU3qowkxNYqEjGE+6PVZ7+46lsqx/6h7B02w2jiCxaV9oJuidtWvpqeBKrZMV6EB4JgB3C+uaNLrH7Mw8zZsJ87Jfx9z9d/GirXjac3T81w+CDW8qptUV9ciTAEwvE9j0TPRkSf7XitQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TclcVioV; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-87a5603a8bdso4550339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752675190; x=1753279990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cun1QCF/ovodSSiSCrQbvW5XijyHxrC79EnA8g2Zp1s=;
        b=TclcVioVkC1TpjeqndyPAhPcxi4sSYMVv5mt/pbwm85+p0FCTHjyt/CHBodSXpM2on
         IvWOgYcME+kT243dtm6UWq1GjGmiJs7+ZVTSRQGcZmvhy6vDv7ApBtamkwjOqvX7CRn0
         45Fo8mZzAYjN8er1oduAyNWzDXyRy1nOEPdBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752675190; x=1753279990;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cun1QCF/ovodSSiSCrQbvW5XijyHxrC79EnA8g2Zp1s=;
        b=qLrp/nBehy7eSPHHH/+TlTz+6sjQ+eDPymZ4VbGbhDkY4Qm+4t2piNZS3mM8ZdUfKZ
         7ndB3VLTQ7p1+wxat1g6prC3X2L5UVdLaHRoO1oIM4wdrHnmx88ajQZ8UcHnFc7BULt4
         DBxmQ0Pu9V5DcUU1xyUj4FZP9VQ63Od2gUQtB7Y7UoLwqK/5Xb9biIJy9SDeEwscytel
         EERTla91SGts5sr3/ggsH4jwJ7dwKc9r+UOdHx9YH6PBFaODkk9a0/k1WzSu+WzX+1/a
         EV5Qi01r+kb4qt3L6c55fS20mZxsKvfc8uY7qmr5YhbtRVoSuclESQxnIg/QZRu9dtBM
         Es1w==
X-Forwarded-Encrypted: i=1; AJvYcCUKYfesv8wWzl8EweYtfAr6wjNW1WSM8rMj9l25dBFDDOpJlGwqxUe8FP8NrsKf4pvqMyxSfhr8ryyDI38=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx3nuNQ5vdFy4wbw30NZSQ2irsCTMGV5NmKG/kbJgH8C8+DQtX
	uQlw3sh//ORK/X7yWCS8DQOZFHZh9BNPN5ngpqKJye2KFqR7L4ikBtebkFn2QZAsTaQ=
X-Gm-Gg: ASbGncvkOzND1YjrTQ0I/u9XiW6GIIlS26Z1jUpMBbLzkbNamcTYO3kbgs+Msu2kfe/
	Jrl3KA0Ahyq8au2mxg9jKk0pHPsCuFQjNj4M7E6J3mqLsOX3jaegl+gFHa3py8SGuql6IRmf6ie
	sRG+8Bd86izhre7lirv/Em9Z4v7yvb0mmfbSjF8CROzCmVHwuzQMybGa4tUnwQO0+15U5wu9MXg
	Wg4FGMsDzEYnBVsT9h/Q/CwdWiLIYA7QoU/Yyaa8MbVx7gtpWhOfxJcx1aJYtZHsaFvuwYFiGhC
	qL+OZVG/VD+D7GLR9cGNjlZGAZg3wqfXZJxuga1TjeSvo6t3lrkVYA5EKOKgFfmWTJgXQbJHnED
	7NlhyQbogjNMp54YgABfdd7tmAbvL/3sjbQ==
X-Google-Smtp-Source: AGHT+IHpKFuCwjn3ngh9585q+QxCCdOLt8vZn2f2O2xTlcTneZ9nwwto9RRUsv4jwjnpkK+gfLiGFA==
X-Received: by 2002:a05:6602:a019:b0:86d:5b7:5a42 with SMTP id ca18e2360f4ac-879c08a606emr438776939f.4.1752675190609;
        Wed, 16 Jul 2025 07:13:10 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50556595731sm3062897173.42.2025.07.16.07.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:13:10 -0700 (PDT)
Message-ID: <481a8e7a-19d8-48f8-84bb-5a2a78b0e815@linuxfoundation.org>
Date: Wed, 16 Jul 2025 08:13:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.15 000/192] 6.15.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/15/25 07:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.7 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
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

