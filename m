Return-Path: <linux-kernel+bounces-839270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC00BB137A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFA11945156
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7D3285047;
	Wed,  1 Oct 2025 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="heg1YGWj"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91961220F2A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334894; cv=none; b=kPeeFqgqJ7hPkGPAm6APgO+cA4kjvY3pOIWC/bJyrDrHfhZp7bKYBInTGnro/m8QKi2OY9r9tkW1gxzR0HjlZKroBC0BZlthNpqqXE4Wht8fKZcxRBX5QuU4ermgnZvTe6PRF3JGO0mtNsZpiHoH3qgiaUUtpaYo/vm9srX2kOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334894; c=relaxed/simple;
	bh=4zahqbZVB1dViemCcCJZXwgbp6DQIyBEEvtQ06hxhqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b1x3x/NTGYE2L86Pr7kcfTxO4LgR/Y4MyqAIgSsVDD94MhwbrtsF2raxaLhfaCMx/91i3a0hfX1KZJSf6EDOJjUpgEIo7INvLJ5CcFeLd4oEnG4TOcE82fLhE2qbv+qHc49WhhzIPVOpHcYH1gR66oLUS/8JVg8Ry1CzJiVvb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=heg1YGWj; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-92aee734485so146134239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759334891; x=1759939691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pqQen5bgeQftZhhWpYC9UuT0CiCA9aQdBdei0IUghxQ=;
        b=heg1YGWjlvnJelgV1a27kkwArU8gcsO92xWVgrjtN+xIINPJ+CET2YFecj5/AUkZjK
         EGRtbor3pxoMAY7LT09SIi4MxUCAoYxSXhunqdFegBkzGnT0apNl6UdI0o+HleA4BrWN
         J1FVJRHe+10ffQ/nE82hDcW6ZUkrcoDuY7ObU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334891; x=1759939691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqQen5bgeQftZhhWpYC9UuT0CiCA9aQdBdei0IUghxQ=;
        b=epRz7QtFC2AIYeo8rmgbj6iRfDwlg4er95h+SKU/lQpZbg/b/K0O5hqgUJiksOAIvE
         qiZD0+9cAzpZ/ijs50DKUmEb1+BWg5KcUeAuLCheRFkYUpxBDO57Lxli6DzNMv00UAMX
         jDdCbaogyM3+B/GT6Jy59nebziqKh5njiVBIKS7LZ5rGoHxN5ugAYAgpJhweflpT0IIu
         K8H1hXwx9D3qnwHz5TPJc7mxrfZAwS4kilRGhkcjzA0o48N2pPhzBA6WmDHqPG4n53+Z
         53XtXKQfs/uQLxXhn9eZTXAweuEFp6bywzfE7X8w6C6VF9rZkpqNfAgMNK5+clJ/0AT7
         ozNw==
X-Forwarded-Encrypted: i=1; AJvYcCXdKRkzpqc6WLz+QRZamShVVh/RohoFN1V+jBtBNjRCUZyLcpwFLWqi28+IuOE2ywomdt2RlVVVCzVEAHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaXz1KDZWUFiS8fnV8V5p/A+dsOGHF1m9RdPtVqrInzKEbDIbS
	KS1EcPQRZW27G7fSov0oHtPujE6qDuwbiEf1SqrtKYE+2KlXp3OpOXyJXFujI8rBEr8=
X-Gm-Gg: ASbGncu5zdEnCKANeriQ2HvkMAv4wMbvHbz8AP+oaP3xMTFwgSYo87tmV+vp3qnlkdg
	u1HVSzUiywMoIsw81ZbC3T6laGR7+GU2AicfnS2sjQh7pxYdrEZdRUyuDEXtnEALlp1b35K3A8J
	zJUk8UsHPiB2G4jR59X0Ra/qumpEIoKfDGUVPe5CJ1oiBN+K8VeVd2XC+gF1JrBhY4cXQwlt6Hb
	Hd5G0ZxZElEK8z7wTNGEMgeO9yJssNTpx7mNcWkUKdHzrIiAdHss0YCFArVeMLO8uO8GC8IOKk0
	sYuHP85QTtO0dIaE3bmoJVX4HNbJMA60LbVdKbQtTTsOAb3XNoFSLdISCVJ1YP86T/nI0Iibf9Z
	jZ3/ncg8ZaofM0Qah3jACfEUHPDmhaOOSN7ZM8I06zAaUJK0r23COrB6niGM=
X-Google-Smtp-Source: AGHT+IFRMvxEYLeNKDQ1JmK6xJLRr7HtLVjyjPoczJKg+MoqWy9AxaHGv9UkUjU5GqojzD4dh8HSSg==
X-Received: by 2002:a05:6e02:194e:b0:425:7974:fe21 with SMTP id e9e14a558f8ab-42d8167e8bbmr55614135ab.22.1759334890495;
        Wed, 01 Oct 2025 09:08:10 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b28153asm215225ab.20.2025.10.01.09.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:08:09 -0700 (PDT)
Message-ID: <ec7fbcc9-cf19-4fa9-9e4a-73133203aad1@linuxfoundation.org>
Date: Wed, 1 Oct 2025 10:08:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/91] 6.6.109-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250930143821.118938523@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250930143821.118938523@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 08:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.109 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.109-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

