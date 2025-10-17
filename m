Return-Path: <linux-kernel+bounces-858832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A5DBEBF6F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B27B34F668
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D273126DE;
	Fri, 17 Oct 2025 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmIUIpQX"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FE13126D6
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760741881; cv=none; b=Kn7XiNRVwKJvdbndNavl2spAtAxmq9JjNs+5AA75q65G653Ilm99M2wJontTtCMiV7OlBHv6ycygwL9F9MsSA6DRN2os5SWDjysOhZF5pbdYrflA0PWNS0CluV386zWTA7HHhuSeizo2IkVpvqOsCqaRtzJWrESHKUpR9E+sQQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760741881; c=relaxed/simple;
	bh=TVTG+O8iKJqOlsONKOctFtR5vUb2qk74Xxw1eeL6LKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tP+t6it0duJLJHOqIroh5PKpe1YVj+HUp0otD3jr30gVT4BFe5SkwhgH54yvlqgbZs+4ykDyBnMnp6zxipm7G/jdRWyGOUigFWu/tKhmaWwbjuw880HcteitsAv+WtqTKGqOpZd1UvmDksdc2EZ0mETUqKgShFPZ9v7Uydo/MxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmIUIpQX; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so37972176d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760741878; x=1761346678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pucK7w/tDLEJVDkMQTugbZEqJtDfp6Kr9NZGNFPGjzE=;
        b=dmIUIpQXyJE7vaib1KTjgDTMCehBQyWB66399yNETJS9oaRz/JQgo57uFbRnszFgYS
         pZi/NUbm9pu3jA3aNTjQmOp0RkXx8AOBbZd7n/pKNjPhQmYtSH64TYP4TskGmifTG3Cf
         Mt9vEaS2z5sha9BwVw+oWj69PSMjL3+OT4OjG0Xw3xQzm5JBGIAhxxnaMfdL1fbVJsb+
         HaN+6Bhk4f2BkeqNPtam1kCWAHCmtGncr2ViRAZqfqSVVEV5EpjM5uUR9kZkK9oeOm3s
         GQXrPqVjzh9pNF78nntfLuWLJKyuu9C9l60ocIKF4q3ndyNodH52eG1AISLlTb44DlC4
         hhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760741878; x=1761346678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pucK7w/tDLEJVDkMQTugbZEqJtDfp6Kr9NZGNFPGjzE=;
        b=E5UB7bV5cr21HME6zTO9RGNxc51EBCE63lp4k8D5JnOGt8SIzHRPEEiafuuQMkdXGa
         bLP/RRjBTdEI974e8nXQcWhUPxL7JXvB5HxJoC/3Hc1D4HVznYurHU4uU8UOnkA1Bqnc
         NT+qNpIbz+20nw4ZhsctGOMdXAhsW3DwYfIsT/1Z2pc6LZhH7jeV0YuymXvrc9KqQEAc
         f0hoCB2wpRaAnKitSS+ZxHdeKVsl+G3WSsdsfBorFru8R9UxOOO3McjEIJiDpV1cWgRZ
         Mi+Pu+gjr5iSHJ7oQqNtm7TnEfF0DLoj2cQYXgzJ5jN6TG2UP192hxrsKZZJXDYFewb/
         FtYg==
X-Forwarded-Encrypted: i=1; AJvYcCXhhpoLLGVrl7aArd2/Tq/iOuxdFsqbKCAlqTrpwkexd4t4TT7bf2AE444B546MmJ2tlOCfeC/03AXSMzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqmzxeclR7RicavnWiOuOKKPOuDt+QKzkKW9WObJvSQWmkjav6
	N2IqWveW6v0KQvSRlRvK8JI9MzgUxxUZxQr3iuSeQv8t+Af/WHr2CVvr
X-Gm-Gg: ASbGncu81qt4hSnHeTmF99CBOts+Ew9GQT6ZrcGFU713HyYPOo9w+irHOiG/PxmCV35
	DKW0eMCHNd5brVykPeryvFndPDqs3nCFNzLMuscJjC9I/Y1uUholM+/FQVdKjdiQADMRKZtZXBp
	HOQrAwqx21ILie5b55SXiiuwRdIw1lPQM6qsiS02RVLu0smLFADWIc9tZCuj9Q6o1mJFApy6ay+
	+VkfbZRbq88oHnFx/IlkrzgqSLmtq3s+jjFe4lsweuSBYW3th2r8SDYLR104gYw26fi7ZfFeJP8
	WGpWLk7D0Zf5dNXZc67WT5O8uTIVNWAIvOGSEQECIly1msBRm8arUhqUQ0QDrWYeBBljhVZDSL9
	hMSQNH6e7Cq94WCng4XcHRRghq2Frh8KNnmOqkoms5awzzYVrAyiuPopqfu9W2PtUTo94SWpdwb
	3sXK6n2roVMpgn5E2jeU4LwW+rYVQ=
X-Google-Smtp-Source: AGHT+IFtOTk+TeUWYZvFwbJ/WtL4J7f8SdXdsAQcBbwmd+vwHRetDEZvhB/XNjVaLuhKRvl+qTdF4g==
X-Received: by 2002:a05:6214:518c:b0:87c:2095:c582 with SMTP id 6a1803df08f44-87c2095cb68mr80609666d6.18.1760741877657;
        Fri, 17 Oct 2025 15:57:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87ce9d474fdsm6863656d6.0.2025.10.17.15.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 15:57:57 -0700 (PDT)
Message-ID: <c1b098d5-3499-4e24-aff9-6e5a293b4b1b@gmail.com>
Date: Fri, 17 Oct 2025 15:57:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/276] 5.15.195-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145142.382145055@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 07:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.195 release.
> There are 276 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.195-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

perf fails to build on ARM, ARM64 and MIPS with:

In file included from util/arm-spe.c:37:
/local/users/fainelli/buildroot/output/arm/build/linux-custom/tools/include/../../arch/arm64/include/asm/cputype.h:198:10: 
fatal error: asm/sysreg.h: No such file or directory
   198 | #include <asm/sysreg.h>
       |          ^~~~~~~~~~~~~~
compilation terminated.

I was not able to run a bisection but will attempt to do that later 
during the weekend.
-- 
Florian

