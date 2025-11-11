Return-Path: <linux-kernel+bounces-896134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85638C4FBA3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62EF41899317
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB35733D6D5;
	Tue, 11 Nov 2025 20:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aaXNtQQV"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6533D6C7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762893687; cv=none; b=rwAocGoLDeIlZQoW/dTr7A/OkeI0TahArjKtYRCxI9kKir4SpJ2T7A7szog2cCH40mwxZqOE89pS5itKDGGbY4EktdBRwFOhA5PiSE7huPqgs2Ff18Hh1ltmIRK5VJuQ2aqfV0OxnixV651GMw8tm4vGtY0QYlUDJ0W4JpdB/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762893687; c=relaxed/simple;
	bh=YEr04aoMcmyecPDZJfLTTNm/R81XpSd91kOBrbpoX5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhNj83eadkAl4II0ezDwJSwHG6+y6wg+IGIKzP9iA2ZghRGSu4Uszu+t6WB5OLYTKuEdWzzmSYS81CNv4wSB7a55y/M7lc0EUUxQbM3+mWoVeD//rmbSv9rNsEs3o+gLy+ZXDd5K1gS5WRQbDNEyO3z5/tqktS5rXhtlwRM/4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aaXNtQQV; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-43320651e53so638965ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762893685; x=1763498485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5r/++3mVCJ9xD+Mh5hsq3AQxsTxN+uDvyJmdcqTQc8I=;
        b=aaXNtQQVT0QVZ74s0Bb2mWmlC27v3Ww1CcjHi9IRDMJQfXaIJLQwAfi2yb8ibsKBvE
         OG+Y5fudBEJy+JgiMEZbxpdGQhZ5cBABrHNUsHlGJF7acxt0YiMrlVT7peqeGO7QOlaR
         ukkgbEvwdobj6n79HUmW1TEmS8jzT8qLvdP7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762893685; x=1763498485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5r/++3mVCJ9xD+Mh5hsq3AQxsTxN+uDvyJmdcqTQc8I=;
        b=rV2wYfmYNYJcn6y+/7ugZCKm4iin0Tjnnj/hQH1lrMLLzgnDNzfFp2ZtDcOrNXuBQC
         wJPm5MMSoqqduPmSIb+8mhN+pKwRak8bkQFQmKX0zRltF6F/D8fFgIi+jfChW4rWgLxp
         7L6Jlja6+PAbe403Irshjs1uIX3oKzl5k/NMaiJxlbrmmBbXvrxC25soMrF8tJEKeGoE
         QXTaflxQEVPHXTONT2SngLb1G+h4yPyQ9ayiMytnGuA+HXmVKg1BlQkoLlo3I8XS9aVp
         EQN5bOubMNNceAY7a4FryMzSUFucttJkRZXekRNyejnMcxMet6bU0uAY+QCbF623Llho
         9bxg==
X-Forwarded-Encrypted: i=1; AJvYcCX28ceOEg4HCaELO0/mt55ihXFMnqnF/PeS5/R98lGNYxiAd8p4IgDZrMNQ4RmxVV04RKYv2LU+sA22Qng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxRn0oCOGPMFmrJpwJVcWXEhLR2CYeH1oDRvhXD7EVIHUw6ak8
	s2NNEHZcH/bx0wFK8X7cl+rhCi97W7NGG+2LllltxWigomJVzwqqzXwPC9R7D0KHX/0=
X-Gm-Gg: ASbGncuBkp/Fgl2iWW/di7rHD3FPyP2ZdFhFCDBSZy9iCoOk/DLk66zQhWTzS6E869B
	KT+45udO390nN2EFtx/QHcASVozqY92g+kmWFgN3CaxH8a49oGrm3AjRHLb0k3pT1+dN4g7zPf7
	m04hZhzewHV6nGWogqO0zJ6zpu8L7neodbFy2rMIE9hVl5M1XsAAtowmz525LOH+RzkxZ6Th8DL
	8Qnbeml3fZzxy3WSxHPPbAMQ0rmkVatbOF/80KER5r1QU2q3EH1NiB2VUniqLDaNspdkWuQ8Y7d
	dRhwWvjL8jD4YmJv1LSNO0cdK8LWVnhbq4cKTJrwJLqrsJEXcldcL1HNUqObBQFfQEg+mlbCGjq
	oUNPb2Jg6azSyDgKmMuw3FJ8Cu7u7PnS24jbjdxj70iXas+5++9qU9MuWb0OWaJyTapmKNM8E2b
	p3yCAYN7ohbjpbzcmGv6GBfng=
X-Google-Smtp-Source: AGHT+IHc85hYIBG9ds9G2pphrlClRxY7dfT0RUGyDwgFy2LVDtnEan/ZgMhySlr1XPzoCUV2ctuLfA==
X-Received: by 2002:a05:6e02:174e:b0:433:5e33:d424 with SMTP id e9e14a558f8ab-43473cff5demr8186165ab.2.1762893684483;
        Tue, 11 Nov 2025 12:41:24 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4347338d4d7sm2687265ab.20.2025.11.11.12.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:41:24 -0800 (PST)
Message-ID: <b7cc8106-6383-4035-bf9a-f3abcf0b7da3@linuxfoundation.org>
Date: Tue, 11 Nov 2025 13:41:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/565] 6.12.58-rc1 review
To: Slade Watkins <sr@sladewatkins.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
 <641427c7-0069-4bee-8e6a-53347654a926@linuxfoundation.org>
 <07d63659-72b1-43d0-9139-2a0b6d73edd4@sladewatkins.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <07d63659-72b1-43d0-9139-2a0b6d73edd4@sladewatkins.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/25 12:47, Slade Watkins wrote:
> On 11/11/2025 1:00 PM, Shuah Khan wrote:
>> I am seeing a build failure on my system - the following
>> commit could be the reason.
>>
>>>
>>> Heiner Kallweit <hkallweit1@gmail.com>
>>>      net: phy: fix phy_disable_eee
>>>
> 
> Hey Shuah,
> 
> Just to save you some time, this patch was already dropped from 6.12.58-rc2! :)
> 
> rc2: https://lore.kernel.org/stable/20251111012348.571643096@linuxfoundation.org/
> 

Thanks. I noticed that right after sending the email. I am building
rc2 now.

thanks,
-- Shuah

