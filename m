Return-Path: <linux-kernel+bounces-865644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45654BFDAA7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD4264F8D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DF22D877E;
	Wed, 22 Oct 2025 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3dbX3zn"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E6A2D641A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155041; cv=none; b=K25qpdfr9P7Qi2QYKpAEsZaoPkhK23lmmaAZdKXE5vgQBd7afpIt8VZLZrZvggezOVB/YuhslQrgctnwkYybWVa55mzljGBpgz1fiT3407vpYPAHdlOungpXIAfBxhoAVNwYT86rAjReFkBxlKA0h2nxH924ZasfuvUobVg3jec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155041; c=relaxed/simple;
	bh=7/2fJy4pxhnnXtc6OkwmeAXK6plptjeyhyTaalub3jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxKxwbq7rinh3kzesW2lbLCoMOXen9cIowIiL/+MlZ2XnqBbo6v3mGyOiGijoIjhm5WOZ+LAprU32SmEn8G+nBkyHvWdcQbpO0J1yqzeyTx6ivrIvAFHrGS5EFOn0YqvFAIw/E+nx8qAepqFCLk2J3AXvmIj2eK8i5CrqDmxHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3dbX3zn; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a265a02477so971946b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761155038; x=1761759838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ddn45kgA5iBGs/Q0XZd+ROEGvzH3g9eY5nKIgWA7IA=;
        b=J3dbX3znb2PEZGoJFjQ+k0K4NRVykeQpcn7r30aorGtsb2PFE7JpF7u6rSK6yE/BiQ
         /VQu2oCn1GSTe0D8+wJatQNkWrY5b+pMklENbjQuO9OPfxzZqSsphkSlyr99ghenuhRD
         BAgvOyCtebwspsIUdvrNROf2N5PxLs13Ap9sGhV6SnmV6lYNkKCNk22gOxXoz7D/y5Cd
         C4+RHzEg8qZCCIc95OQxJGk/4+zybwzdrTbakzmx7VrIPVjiJAAidNqCLEAq5C4UaPUZ
         5vV0qhv51Z19sAnQApE9TCervfXQs+2LTu9/japsVB/XIhj9WneMcr4b7tXpJ1P/HB6e
         8Zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155038; x=1761759838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ddn45kgA5iBGs/Q0XZd+ROEGvzH3g9eY5nKIgWA7IA=;
        b=E+8Mk4NAWhrUCrBMR0UpwLnuivEAABggq3Z8Q/tx30068ACHmoHKEm/rbjAx1Ncb0M
         tHZTDevWc4qyhMCOBvooafhUiFmGx28PTukczWXVXFM07u/GLiu9IEpfFPppRKVx1t2e
         Qeu7IyOknVBUt7tFUcjvj3PsKOi2UA20ANS6DlfRi5MxaK7vZxVMhQ8WbTOQWS3KsLhA
         uZc1Lpqo8FyZY42SahilUKeLVfskSJI8Nkp//IZJBKsiNRb6pwOyGnS9x/SAC8ThwVSs
         WvugWnOTlPwzxiycV5i0ZygbwuhCnmzVy9x1T9DQ4BN5B+AaQekJp2Dt3AATztq+z3DC
         ae4A==
X-Forwarded-Encrypted: i=1; AJvYcCVwYnaGXxzxWAngO2nMUPItnkAS9+6BCFQMtSZw+BlfzwRJyB9EU98J8I9/82wp2yE+KbYEtWvvwy2Ow40=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMg/N3Wt+znqSa5zV6d4vDUaetR/dqxKEbTe8i3TI3NIOodm3B
	D/kSBoQn3rdz893nr6A5ClVMk5oBCuYnR2X6/Uub+/q6naZDABgTRvUo
X-Gm-Gg: ASbGncv7xd8c47NU+G2IFgqlgQnlK2hSh5n5y8O9fUQzsj1fKsyU2wlraqgLd6OR5C6
	JYQT7n/cLZm/0/UQ+3Ea1RtMrHrpMEwbdO1xB64UPyQFBFBQuOWzkDWBRfOvA7A4PSEmfSLsg+S
	RCXKqhcyuVg/IeUF28SzmFXKjZH08vpSpiD5rMl7tVgD/MfsVEcseqPrKg6JFzQ6aiOk+xjACIA
	5oNteeByThyFA7UAytfYiKKGd3A1ypcFGY6iFTIiCit9e4Iq0gFMvYRBf/IjL6oHhyoEPScl1GJ
	kF5zy2jUpQDlZa2AeZeGFLHEKCtuhFKP26luZeAScYG+Uyf2q07rLk4dFE+pUTLTdW1JMn0AxNE
	sw4GPB3JNzUtjhLRZDyBHLBbfnCS6VhPL1MwRu9cn/FQAeyCQLdB0wnEdW0Hg9NzisMY+aQwdEo
	DH4l2Epf9RuxGJ/8kld09A/NmSyK12Kkl5OyB+cA==
X-Google-Smtp-Source: AGHT+IFlcnSpDwzLFOUCCw5dfznfe42XnNXFCg/H83y/QkODNwwNkewmIPIBd13BJCZtlOmCR8rDog==
X-Received: by 2002:a17:903:18b:b0:269:96db:939 with SMTP id d9443c01a7336-290cba419d4mr292170355ad.58.1761155037894;
        Wed, 22 Oct 2025 10:43:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ebcce8sm145076535ad.18.2025.10.22.10.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:43:57 -0700 (PDT)
Message-ID: <90205139-d34c-4ddb-8059-e4796f040d14@gmail.com>
Date: Wed, 22 Oct 2025 10:43:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/160] 6.17.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251022053328.623411246@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251022053328.623411246@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/25 22:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Oct 2025 05:33:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

