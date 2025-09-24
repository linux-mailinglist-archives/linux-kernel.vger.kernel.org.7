Return-Path: <linux-kernel+bounces-829800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB1B97E5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B87E1AE15A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1904617A303;
	Wed, 24 Sep 2025 00:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UJc5/0NN"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B9347C7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674016; cv=none; b=g1owP9RZAaDNWjzPQVI3JtEHg2xT+royo9h9bIn74MzRJXZTAf4myy1AKpcSDHPLoBMZMzNiIywoOg5g8keeeFZyQxZneySI0amnjLLS7LOElxuNXe+gs/jac3Vs/BzpBOc8EIOfFTdDc6YhOaXcHDkixeAnCKaDWC3C1lreIVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674016; c=relaxed/simple;
	bh=C5xHHpQBIRnwOxQRsuVMnox28OdPSZKgsMEWMSVqR14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjmGvU8goH25aVjMu+Slw30u1btHujKPUvskT/HGF5QoMQszqKQqmuOYL+naURAOR3/nDQbS7H/f+GVMUnVpcBR+XJ0RG5t/H7R6P+xk3ygOZygI/HpzTH6Vi2VBWYuSYfvXDs+IVWMHSngbtElbqCNOknokWXtkLqZyViD8vHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UJc5/0NN; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-42480cb42e9so26188625ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758674012; x=1759278812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeCpOzQKe2yNJ/96XeJlPPvMwoakp9LE73apKlL8nBs=;
        b=UJc5/0NNNFr7vsO9PyYKDsVFmBXJ2pItelTKja5hgRUAFOuPWbIoKedppI7R/QP3s+
         DyHREbW7v07pepFUQ8yepf8E7UaWLhmvCYwKl1HEQMA090yilk31OI+ki3AGA0jq8EoS
         gLeRlfGmGYSkgQk/anEf090cyeE+JHkTNGI6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758674012; x=1759278812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeCpOzQKe2yNJ/96XeJlPPvMwoakp9LE73apKlL8nBs=;
        b=lCUzlj2y8hjjjTtrHr3uauTHs3BHHPRIte24a2h4WSVEutPtAN8RbheZLpeBPxY5XN
         E05THJsvg02Dstk6wLYE3JEL41M08ct+GaETaColaPubnSE2FlRAC456tK9Uuc/azTQR
         rk85rGbbSShkcfY1AnnK34KKkzezEGg0DhFr0o8s0GxCej79ReB1f5e2JKjVBzn4tvvm
         sad9Piajsunirn4T0acKySfgsuQu7Fr8naqJtNYpG8h1vfpHwDLUm5mrNoJJ92YjY/tR
         uK2N0Ki07qZp3PAU54mSX8JDiWtzDbkEb/vWbJ61Vr2I9CZG20Cw4pq2yFKwlwN4zktr
         BiTw==
X-Forwarded-Encrypted: i=1; AJvYcCWWDoBLyIoOklsgTVqFBvjwHDRXbCh99J38Cg3HL8FPRHdoJ7wPsIqp3NwFKoUNLYSghBvuXop61hQcdfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyraPXv4FJ20r7j2ZSmRi9zfenhOPCCfSOQujD8E0yWxTPtRQ65
	h80DI59UVQV0f3A6uQ0pv6TvjOHZ4ldbu6V8xYMZ8x27xBXRzt3nX3RVxT5nspxe1pI=
X-Gm-Gg: ASbGncuzHe6UkDBkq9GOGxIIBPwo6rQsiHI9tt7HC4nOx/248cOnnWecEz/sSftsatT
	C9K+ZWGlajxUiOQR/NWPFjtbXjEBagMB+dRmY+/PR4Yh0JjwmkTsgvNqMC2Ep5O95LWdLWVWWOU
	oLprtj+DDy63pT8CYJgUb0L3TXIHx64jG0fXbq6utIcb9cjz3r26WypM8eo95hQWBf5dTGD/d4l
	da5xv2VSExFl5PmxESeBOYJX2RI/2ZvOPHF1jCy7QE0fxiOG6dPFu+BBAX3YtnTS4WG2qZ5BV2r
	9gCYT6OF1j5FJ4rm3nbyuFYEpbJ94kzXcpRKipkQOenX7WhduQNukd5BhKRSpBj7nXHauSQ78Ts
	HNEkxRERQs2aFRuTw+cZIYM39MwUGnqSY4M5DdEIeXtB2rw==
X-Google-Smtp-Source: AGHT+IGMzxAmPOIYUqjqDWkSj1Vv2Q3usl1ONJIUBuObLOZq0Lscrf1N9LalcNZh3CtVcwMy11Qc3Q==
X-Received: by 2002:a05:6e02:2181:b0:424:71e8:3a2e with SMTP id e9e14a558f8ab-42581e7a670mr60747925ab.16.1758674012501;
        Tue, 23 Sep 2025 17:33:32 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3e337433sm7570329173.27.2025.09.23.17.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 17:33:32 -0700 (PDT)
Message-ID: <69689eef-8323-4afe-bc29-bfb5954137f1@linuxfoundation.org>
Date: Tue, 23 Sep 2025 18:33:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/61] 6.1.154-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250922192403.524848428@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250922192403.524848428@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 13:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.154 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.154-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

