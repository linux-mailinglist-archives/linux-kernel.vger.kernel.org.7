Return-Path: <linux-kernel+bounces-898201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BD3C548F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0073B5920
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A972BD5BF;
	Wed, 12 Nov 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXhSghs5"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A29D29B22F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981835; cv=none; b=CuRQorhigTAMwJGSpOk1FkLbdqWqCPrVIUiCF6s4PAp26W7TdMYTY9fA773yq4dd9SLp1ae7ARPdtz17rpBHqOuGFqgNy0yXHsFPDiWT5Jp6bpUeRguo54aLmwEo2kZpAiQgPLCixjhibZHNlzSn2O4hnJRNPqBPz3wiU1hbc5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981835; c=relaxed/simple;
	bh=NFCiZbCWZdsDuxKkR+3uhYDtGTTOmadQRYG4/hTK6zg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UbbJduVJz7T8+S1TfbcIGoTgkxXvAkdWIvoDScGpo2RoP8DrI6xqZ+iYJ5m7cRigXYhlC79T0yOcn/FP94ENXlnwbNWS+tWNR4gUcI2MjRzZNvYfKfC3olTTzR75DC/9jhqkSKIhGaqMOXTBs5bVLNXPHM2rmmgkuDQVfLHBw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXhSghs5; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b22b1d3e7fso12131885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762981832; x=1763586632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q8qaWvPN3J8o3Bl5ry+HYdP7j93QWDZn/Cnz56U1Aog=;
        b=BXhSghs50a4FDsSg7n2sUOYCsKoT4fFgVOH0h0skFAqQOf9/jjLFIffeb+UpAfGDMK
         NE/WGDzbcd0mG9sfFjWNiL1+a8o0BPTtAkN8eFxDavC+ySyYvuZGA9A6SMBAQ8NM66Zb
         lda6ZctYFFJ3gzp9tEnKAH1uGEg3lJ83cRV3jFU/78uEUGhpXVQtBxJRhPGI9uzVFeOl
         QMY21Mucaja6n/nVW12U56g45k84rGr0/3VZ7Pl3SQRyVzEVRNsMJtp7e09RnAO2Sr/X
         MOhlDTpDplVk14+UxzJcEkjjd2N9foC0i7PfvXygOqgIkNNrIBzl/M3CMEM1drkxTLIB
         jygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981832; x=1763586632;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8qaWvPN3J8o3Bl5ry+HYdP7j93QWDZn/Cnz56U1Aog=;
        b=XNv8pfEeh0Ua+Qm/JyxUEoatkSAtisy7DbgniAS3S9IF73m3/61k58mQEcSP/RPtAN
         CjtCOofzyXzMBwCOUfsUMMbItMmhsx9sTwnWGB5auU+k9du1LCopE34AZJJfEY7+9kre
         pKZXjHaGkuoNGm8psVlenhOkeba/4rTubXWHCfwyWIpNLgpNfFyCv/felk7qyR9voQq7
         bvE2UCBPGaPV0HAvvp6e3W7d/H2DqRqdvNQClJz3pQ5kstBWTzsGpEjga7ntcFZcCzog
         vtR7Icz4ieugfAWJXPdQmop696RFDbVPRApS/yqrxX1dwvblVSO1buS+yc7uvF3DaIDw
         64OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmK5pm3vI4OLHuvFBhq5LtHW22IFlcxJKf4icY+3yok2o3h8e6ZFBS17swUDNpPusZBTV+LxMoYjYvCYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmOFYkdSubggv0tJLib7pS7m5MvX1tatmfR/NZFf28nkoOb7z/
	D8PQ3MMP5GnGNbi2AmdDTOscnOT712kE93uSLzRxk9mNKEYK4Yk/1RjP
X-Gm-Gg: ASbGnctKHiC8+zPDp7pBI89v1pTTm2243+7JycndHYxuy26RGqtYDKPAy2CpP3ROu23
	PpF/U5MjX5RBSxJ+1jh7LEt3fwaawGyGAR0qjtID2CP2RunnugVWGwc4vxj9pwufBjsrBC6due5
	iZvPw7j/9A2ZLI78FCQoJImcH8LRXP39TuyXDHgAe6aeHJ7hdx5yqrk5ZH9No+9bgm7JIYsr2FU
	ATurQzDESdkSyDVXdJ4UHzccPQb19EUO7Ss+moxlW6hkoeG2VYAw1MBncY7b3JVGqlr5wRvTf9j
	tS9+wevjA7njTv55y1hlbQgU7V24Y2cf+KtYWOVysUB8YVIiDBFfrL9JT7Yi/iNCCTBZonHleLB
	+ok9ecDmx6gR1/LAFoWoha4Nt8litn+ZIozRxJVgXxE3C5vkwGcTnZWJaSzDmxJhT9W2M8Lxtuh
	dPWdoCpk8IIYyJ7OobllJbqgySGds=
X-Google-Smtp-Source: AGHT+IFofS0tn+1q/BFHwqg8tHswBktjEiPFttAd7/GfZAqUecg++L2+A/6CVudzDds3JxckzQyKcg==
X-Received: by 2002:a05:6214:48c:b0:882:4a63:63a7 with SMTP id 6a1803df08f44-88271a4232bmr71218726d6.60.1762981832057;
        Wed, 12 Nov 2025 13:10:32 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8823892b84bsm103123356d6.10.2025.11.12.13.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 13:10:31 -0800 (PST)
Message-ID: <845a2c50-8d2c-49bf-bb47-2f6ee1c31d61@gmail.com>
Date: Wed, 12 Nov 2025 13:10:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251111004536.460310036@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/10/2025 4:32 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTb using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


