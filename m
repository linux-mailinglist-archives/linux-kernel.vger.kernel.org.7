Return-Path: <linux-kernel+bounces-858900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EE3BEC2CF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 02:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444BB1AA2D3F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD646178372;
	Sat, 18 Oct 2025 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E5cbu9XU"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76F27462
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760747941; cv=none; b=QoxQB+yYTSCNzXmzLmLWk+7ntRKyVYOHvlq0iiAlSrxsQ8rPIYcZ0ii9OCKE5ShXiYAN7Zd48qX9TKzgu2h5raFcZr9A2Ir1hItW+kPPXbL/zIRe/fr4ZiLqlNQjygQ2lMWTTgFMod47RmzFFKktyQniM5YN8j8x2n0Ri5kl4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760747941; c=relaxed/simple;
	bh=TfkrOdViFaSEovMzB0nSzeBVuPcuZ5Q4h4pTegO9HiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EiPMNrYhrGh0T3RJA+D87vMHL+v8OX/2HQ5oLbtjzUJYSULdvBA1BOSbvWwx4xq5cJzIFwEegzrUKJ92SZ42X4z2MCYcrBvybOC8QmWs7OosRdrc4vdqhkJen4O3Slb8I0zWaX3sMc5XpnUvE/HBos+WnEql8/PSSXO7/Fm8eys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E5cbu9XU; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-93ba2eb817aso220562539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760747937; x=1761352737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6Kl7ZV/gVS/yfGRDqrKMc7VJq5dimqOMeIoI+yFLws=;
        b=E5cbu9XUb++DG0FY1+V/PqCwyPWCFDNb9eYu27dTLwgRj/l3aWfn/FGVa4JresnlSK
         kI/lAiNWUit32niVnlNr8nAshmJwtDxxMzPyNyFLL9VQWWqPV3TZw+FPUdxOimlp2shR
         s6N3yLpCMEhkny4dGxy4xEitbUDeYoLRdMWGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760747937; x=1761352737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6Kl7ZV/gVS/yfGRDqrKMc7VJq5dimqOMeIoI+yFLws=;
        b=DKs5ZD5je8IK5M8Tf4TxyvKCzOMWUSN5HLfU/0r8FPY31K+yeldWqFekavrn5O69J+
         VOIfv08maPu26LgtH1QL9a9GJgZBygnegRaaj4INbH4fkNMuc3zfH99QwJbNNs6R85EI
         p40D/2jw68a55QnjeJ14SEKYRCi8B1bnZoFNuemqOcZbKPnaA+BfBNbhi0dvtU8jHvnD
         aBprGAyNc09z8jR1teY+PlrO/3CdPp5VzzgjDGaOOXxC8JOP4Zer3sltvqHY84K3AIaL
         UWPEtGe2R7kvtjDHgBYiB5vjGFasvyOGsQAi1kl7cB6N7bh1m06+CYjAUzkpskANkch0
         oCWw==
X-Forwarded-Encrypted: i=1; AJvYcCVUsDqT4InewdpUGq6yGcfaWs15wp2gBxw4Id0c3C7Q6cjuhc0iwwczTkPcpoFa8pW9367cUvy5ipA/AdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3irQb4zMLg0MLNBhgHL9NMp4n/kcieg7WRmrqRMkKW93IBc5B
	UJiynjNaJ9cDRGwx6KUn6bszhK7mZgckV1NQQB15IQO5IVVk9jI+iEoksrCSkQTEEyI=
X-Gm-Gg: ASbGnctfaFF9Wz0AYOXrVXc0Lv5keP3tHYbmIcQHDGgLe6LA3FteVsBPNSvHlWx3lz3
	3nFc261qc57R1bzaGLZSMD+HA4NhIicgqC9AY0NLi4udkQKJzmuZT+v9qDMAEYZFqPGEpb4VQbL
	K8Gmj8UNXVzs0X2Sa5TxW+hEmdvZgeoZfjMRWpBj4fIX0v8ve+FfSfOVwTYhrH5odeULMWrSrxl
	Wy69r3aq1hY66G9l1WQ1GX96k1Pz7EuFQRuzz+ZvpYwDH8faretcDQOsIHf2RVDJSMx5HFRkPHJ
	+nIYqgGNagBwvobShwI9Ku7MgOQZHXJngRgga6d0dk5I4oEIgqtEu0YWRhfi/+5hZ4GZO/Mwpyt
	FEeey7i1t8L5oIq6KazFS5PJLQcAUKWuthMzZ73nyuK9NIjnwkQJMjy9Gw8R4vJ+VwLSdbm3o9e
	LUBSyAehazbbqTd7ru70b7Wds=
X-Google-Smtp-Source: AGHT+IFQ1arpM4XiIHOzegBMIippzM4fh8WNlEEgxxDEdrMw5sQl3E/rQ4YiBNkwMyu4gNlwkvHgmw==
X-Received: by 2002:a05:6e02:3e06:b0:430:9f96:23c7 with SMTP id e9e14a558f8ab-430c524fcd9mr83643375ab.4.1760747937361;
        Fri, 17 Oct 2025 17:38:57 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07b3eccsm5151775ab.28.2025.10.17.17.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 17:38:56 -0700 (PDT)
Message-ID: <95598231-ae6a-4a0a-8697-7ff273b6124e@linuxfoundation.org>
Date: Fri, 17 Oct 2025 18:38:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/168] 6.1.157-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251017145129.000176255@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251017145129.000176255@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 08:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.157 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.157-rc1.gz
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

