Return-Path: <linux-kernel+bounces-874569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70450C1698C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B8AE4E8211
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220C434F481;
	Tue, 28 Oct 2025 19:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FOHMTueG"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F6B34DB67
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679466; cv=none; b=BfbAhBeBNaZ8LPTMLbVqiTnC1waETWCduuewcWeeXxXvPUQqYplCk2cSlACnLWNPM5bvrB3IVi2w5ZnxqHiAe0EIjj5scZcgGh3nK+ev1y8rQuxLPt8qncugESoaycPZfDCiUhrKkn9OHTRRp4xfyrwVQG4IM6PCPQ8ADGgZQxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679466; c=relaxed/simple;
	bh=FNuV2ylpbQgdnCFLqngDIR4alG7qnXMuPBXZqxFBQnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UThtyCVKhipdrkXo/ETg5NDK2wH9VzJj4oh0og07nk1uPHmU4CERTHCbjP3LA7izAvGGLkwuo6sBm7X3XBLGVnIbbzBGjy1aPiXn08ucNhLheI5NS7ip/YdfUYiiROV2N0SDhU7KJfBqqNbtb6nI7T1FB/tH3XCqpLtqAdB+0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FOHMTueG; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-430d78a15b1so60147095ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761679463; x=1762284263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58Awx0bGuwSF6D/6xs0Bpv4Ns1WT5VljbxJNAptjXQI=;
        b=FOHMTueG3amuH0xkQCU6dBB8DgQfFZVa4OpUdW3wkzinGvdqqm1ZsslnKqeRZRklTH
         QYBnyzU8pays29zoxeZ6DBaq6PCschnN9vejNdcYN8OX+5Ev6EePpbkL/OcV74No0I4j
         2CJICanlVP51xHTPOY7feoMYVekRvtURsbIFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679463; x=1762284263;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58Awx0bGuwSF6D/6xs0Bpv4Ns1WT5VljbxJNAptjXQI=;
        b=eGNNBwiEKnLkKE7GZTUMwMq3OJk5k1D5BIaFCGKIjS4CTEPyo0tgxLAaJhCfRPKn3/
         G8fVqEReJHpjulZ7+2TovPB8s3adimWNEnM32A6gyHvPaIX1dAWcQhwM0UNqizmgN9On
         u6fpntZ2jn7WeSPFEzHJBcfUNwp9g11pHRPNOBGRZBeDa+XpPe1joaXJYWSNC3VKr2Xv
         umUvbI4/JZ7YvLJ7nXGnzxw18Zzbu61FrmRGTwrHkSv08i67Pi7wdmOUNv2zT8AsWAEz
         gMSiWk735mSRGqQunrUMCfVVZj90R/mpQkSDC1KLuJD1Y22VFVSegIozEPRaWuGsIFcX
         YEyw==
X-Forwarded-Encrypted: i=1; AJvYcCU01vlGvHixF0c/VHyQ7JXHYaLDRqSKUpSc0JcQ6fLEpf1F1ucK56gQHuuzBbHCiubzmpSECjF3yfsiqdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLLpmiis8mwCVOrWiKk7IMyfjKsGWeTOk14OdQ7lUK/X85EzL
	Xdxmm5N+vLD3aJmnGp4DP8DJ2pnXBspi/ya9QO7ZLWka0WIA2Y4MBLzYrdwLgIz1K8U=
X-Gm-Gg: ASbGnctr0CB4Qah8h10hU09cZ1GB4dHWBLZ/44uHMHbjpVEidGoYFxzWIA2zSh4Uz4d
	AYqlVBrmyDISLqMR7MH923VKI7c+wapvHv3P1FNhprPl7Nxo+5eP+U1/O2RQTlnhnYpP5FnZSHg
	eZp0t3moMzffClydPF2Ri6yOCEIO124IinNfybtGXRO84M8fk+kKv1z0LokSSba1aMCpMaUwBiS
	E1wDEToFCRoLRZvGFM2G8vCgwKh0Lzucef7Hr2sIUsFjUhypkxAO7tNjD14xM2DaLVeFcQhW+aa
	CP6NOrTkfWwm7zztoL5CwLQcFZzrsQQTC3iNLXa5ExisgaYExxZwIE+vh89CNQgVw0+sgGt0KjJ
	/MyFUUgHfJQFSrpZSAU7w/B0NJotwV43/HeStQT4jaPrTCMak/pzOs8usHJ9AA9/joP94qlIg3u
	PV9QKqYH19sNryCbPqXsipFrY=
X-Google-Smtp-Source: AGHT+IGaEFpRntODdNU7RTyaoyOhPbbt53aEcNEoUCMwoRku4C5s3OW5tIb5fHWdKQylLZZKXgEf/A==
X-Received: by 2002:a05:6e02:3983:b0:432:108f:427a with SMTP id e9e14a558f8ab-432f906651fmr5016915ab.32.1761679462694;
        Tue, 28 Oct 2025 12:24:22 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-431f688c355sm45945015ab.28.2025.10.28.12.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:24:22 -0700 (PDT)
Message-ID: <58e41cac-eae7-474a-97ce-2f1a084383d3@linuxfoundation.org>
Date: Tue, 28 Oct 2025 13:24:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/184] 6.17.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251027183514.934710872@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 12:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.6 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

