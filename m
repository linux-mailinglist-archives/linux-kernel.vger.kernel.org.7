Return-Path: <linux-kernel+bounces-865399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E0ABFCFB2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D91164E7F77
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FF4253356;
	Wed, 22 Oct 2025 15:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MtkCC1jr"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55770252910
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148469; cv=none; b=F9v2MTkCtgDx4xlAKFk79m0LtJQGsMXLr1vGMNGrbNCINVGmAsLOtOhXWq5BAlMpfRLumk9iArB/z3c8VkVyATyVQ8yqZOOLSHIcqo7GyitlOcVWJJJYKcfF2etpJZR51fYHsQsCk84yonFu5ZEEiAEFSTsjJ2SaVeTDhlxA4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148469; c=relaxed/simple;
	bh=VtcfjPwuQZm0EMKKvDInhFF5KNaU7Il0txe6BbrjIJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpjbJ3fX/hiJSp0L0FwSaGF02QRgFhJ/rW/dPYFa29vngXfTpcg4L8Z0fP0bIsNEE1vT9V34qx8GtGUNS6zSPDVHj7446gyO4aBEOnd926wPTfo3Nq4GeKVmDzv4YwEC00TeNLPIahpdYfdDGtY9N5hN1ZPVIyxeIgcQiS0QRGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MtkCC1jr; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-430c180d829so28617085ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761148466; x=1761753266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIVUN3fWWhWOEdh7Hs/wcK5VnrTq8BMj3+c8cRQCw6Y=;
        b=MtkCC1jrWsjjdTGKlZsPJOKHOm/tRLRLeP8n6YjFUOQPwYK53/BmlSAvyxWKjp4TW5
         cpTn03g2exGP150iSm0hW3fUl9cTdOyydsbOC8R/bcgG5gYwO07rKvd51qkoce9SFJ4B
         2y+f+eyGwT3STyhIp2YeWRT1yoZ8rtq67PHT8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148466; x=1761753266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIVUN3fWWhWOEdh7Hs/wcK5VnrTq8BMj3+c8cRQCw6Y=;
        b=g4tvv95Hj2x71R4HEcFqJ4Mv5OiJ6/aFIp7cvdXlmjJFpVeEHubTxjiOQE9I7p0LsJ
         i86qPl/Q5BkQlD04vaZBX/xyeBdAHB7O9H5cxFAxhc0zdHuha+g0yh5hXzZyEvLEYO0X
         1foEcFYhDmsl38kdddcqRMMelGgXFNIhYR+FBNA4mU8T1ozcDdIYzINC0lB9T0RgAPDo
         Ir5pazx9JciKXHLpqDskdsC9BFqsb51dWbhaNWnjHs+gJgB6ZkppjTLT2GSDPCv/aLF0
         MUh3Em7V5fdjrEZ+yV7/Ctz3yTpK5M81qZaO7DtyU1pPSSC4u50o9BvJuDDRTpf76qVU
         DweQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmnZcqpnJclz7iqUa6Vbx1nhXjj+VADhz3HWi7crBHNS4k05oxHPh3GhYW/6bqOkbiySXVjTrxgZiArhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1HdhennyScvt01TD1SF9Q2ZrcjBX5JiUVmPdvi3AeaW5Ml1w4
	yuhi1pupCooeACHj1A4ovT7Vv5NAvUY5MiYZGyaJbUV5BVN0ksIyWTadMoWEMGxLrEk=
X-Gm-Gg: ASbGncs6vhd8HfOaDIjRJG+CtclygDidBQwkyAq4ydzc9eGkDzG9saoBfqDkgDAjhpy
	IxJp1IU9SWebjjs+lY8EUJJTqR3rb6gguf8wQ/VK1mnA/pXo8BWjWxaLacZSkZpRnVtSPKPKh4W
	Dw/o0U7HUjMmbW6XUOQVAOCeKVt43UDVKUC5aUb+g0mhSt+1CG9RcSnfx41P9pGJlUe9H87ucDh
	QyCODc6GwaM33oqOfrMVA6biaiTzrjG2DaceL8IpaClQVTlql+f0YpKs77U4cJbOGATB+As+a21
	0+SJXCUdNRs4ffPld6XglLZKHNiZvNqaD0VU8BD6SuL/rWIojTR2e1/uzOxbZNsOdHezndhom2i
	2Vpof5gtCsy+d95cyPAv/6iPRVligZCvTnbBkMQ2Xg8CdmhZEydhbZX/H5WN9lWKRUHwzBTZ/Es
	s7VKKCtHr2YzAlhNHmybgaJ2k=
X-Google-Smtp-Source: AGHT+IEcWRugNt4PgDrDpPZh4hjUcHFJMLAEuTjX9qEtdywPClLHqCfX+99xjdiYkwyoiP2giGCghw==
X-Received: by 2002:a05:6e02:2584:b0:430:a4ba:d098 with SMTP id e9e14a558f8ab-430c526604amr321051155ab.14.1761148465999;
        Wed, 22 Oct 2025 08:54:25 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d06f9ff0sm54597005ab.3.2025.10.22.08.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:54:25 -0700 (PDT)
Message-ID: <bd81295c-d448-491a-91ee-bf07604bcc69@linuxfoundation.org>
Date: Wed, 22 Oct 2025 09:54:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.4 000/797] 6.4.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20230717185649.282143678@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230717185649.282143678@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/23 12:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 797 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Jul 2023 18:55:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.4-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

> Mario Limonciello <mario.limonciello@amd.com>
>     drm/amd: Don't try to enable secure display TA multiple times

Verified that the error messages are now gone with this patch.

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

