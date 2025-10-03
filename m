Return-Path: <linux-kernel+bounces-841597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A579ABB7C98
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB9E3C0DE0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819E32DA77F;
	Fri,  3 Oct 2025 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkbxqKw+"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879B26E71D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759513257; cv=none; b=de25AwZg4+CXkWJSkXtbRblZ0VDRGvfOMDXCnzGBbQxg62SX5YgNs5dxwA1Y7I6Rgp95mIH19T0zqa/ya5eL6noLbkU7CDtMhZprSzWaX0/m3rmrk1Tjix4NMWOflY/+WyiuKgWSuBj492tXspVwPCb+uc90HzNmisD3CkzKNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759513257; c=relaxed/simple;
	bh=7zGsOrHucK/F3TXGYVNST8Ic2yHVpPVoo2wGcmdWcrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjKbQ1rZpuHDx/L5dIcQVIffapt7/6PEMjw7gdHaj7KgYGY4XHAgmGNEdxK3OL+tJwdLLpHyoys4fyP21uHPCaJQwGzGz7orb3XkutMPsAnSwdTn+Q+JmpqTMjJPNu1twUiWpS6GWXAw5MR7YAt26sPGgLyQWrvbfqfTT12wSCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkbxqKw+; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7835321bc98so2618129b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759513256; x=1760118056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8DvF1xSe5T64RA3ceOh6pYqc2KwrLyGdOksJedmvMUU=;
        b=hkbxqKw+DzXrAGrxqwX+lG9yp59iZVy6pdDuBC19kFtCCmW4sWNH1LejFm4KZ0AtNX
         6sf3Hd4AwWQH5u06uUlcfAMhOsrX8sywP3Fliv2n2BbvMcSLttdNWALlbGLuG4bKNoo8
         bnmci5vVJ5NILmWcPuZg2xf0x1qDuCM/cymCtDzsO/LBsQfEwDGF8vbfDoP5G/v0c/x9
         haQ4nqh926n1pWorWxT072pCf0s7TRMICgIPOV/AYurJxgYAWCglSsfilZpOWImZHghE
         ceTwfTpFU88x2953mi/DCh9dzc5Kknuw6rbN1s56qb3PLBoz70j8nrRh4LVioFCYjdM/
         C8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759513256; x=1760118056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DvF1xSe5T64RA3ceOh6pYqc2KwrLyGdOksJedmvMUU=;
        b=q2jbpl5j2kgd+frz9uCmq6yOfPQqoerGVLH2U1iXXyIk/2eoGJu2wh5Qun89qtg7nu
         /tZj5bKZ950tmvWXLHDahAXR3UJ4X+nilfgsTLaoAFwXz2R4AIiqD0l3zu1YmnSd2f1l
         f7rkn1DwivQkXI2jinTr+bsuaJrAD7/kWrT0c1qBGhK3pRvC05Z2pcHJwg0fmiVD/IgJ
         OMx+jfdZnpz3yWyVaG4J6W1zzw+HYWPBQmTKrwoT0xz5XjGv8fHhpEkGGT2u8HHGlKUb
         2CDrxePMI2boUIYnR853Vs00ir0HQOKQ/ODvGAq7GNGwHPeOcONSgrwLBBtxfWH+UT1o
         ReCA==
X-Forwarded-Encrypted: i=1; AJvYcCXP2K8DIn4+HNa6c0/NjTVi39ENUKe9iVFz2z5yWkY2/fyhgF0Q9f34dMyD8rQxg5vc/rkbs/mMczaYr9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh0M5V/7zqKnSZ/tC4+cSVh/iAgz5xng6F9tT16v3omUgXUzlG
	AO+2qszOBPV5PtIdYLwI/+CWs+Ffiqd6c5InHaw0WhIVqCoYz/6KYYtZ
X-Gm-Gg: ASbGnctcW1RWKGDH1780oGTAciigHlc9w5FyRvnRO4QsTmPbuHzvjQysQGmOyUr5gec
	FJ/z7/ip5LSHC0NJr6FIpqqmLPrJ8Vnsz1pk8vlTghZbRK6YQwyJLFt54xz5LUFLoL2fYC3bga6
	Xhn985PY6ntwX5/xKPT+l1RKLmRBxtNPqP9bH2+7S/PzHGyHsryCB8bkaqXA6uAfYky1wu9dgdv
	r0gLGkJdJgAt8G15MFLvng7MWlOzDHbakConGQCYhHT3m5EuMpSHGdem1+e8ojgau09NLyjaArm
	cLR3Vl3S1Bn5gaS6Tx63tQ0bJLMCbiqgoHPpzgAsYFMKCg7GErLjozu9TebRv8P9CLhztf4+DuI
	zm7xsMC82b5rm88hftlGo5GXspOHt6cSpkrW+IE6BoJr+X4b+1t93gt88PPT3sHA9LIQtF4i/cN
	8qaIfNqRZoD9F6De0MhieTX10=
X-Google-Smtp-Source: AGHT+IF0CWD2qg+PTIx7YyLiOrkXXs3s6uMSmo5ndEoOaGo2dua6hr9Ax9ka74DU9LIpjixcoQgBjQ==
X-Received: by 2002:a05:6a21:3283:b0:2e6:a01e:f218 with SMTP id adf61e73a8af0-32b61dfbdf5mr4344924637.11.1759513255860;
        Fri, 03 Oct 2025 10:40:55 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02053584sm5446155b3a.50.2025.10.03.10.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:40:55 -0700 (PDT)
Message-ID: <cacabcda-c0c7-497b-8556-f6475639a341@gmail.com>
Date: Fri, 3 Oct 2025 10:40:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 00/15] 6.17.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160359.831046052@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251003160359.831046052@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/2025 9:05 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.1 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.1-rc1.gz
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


