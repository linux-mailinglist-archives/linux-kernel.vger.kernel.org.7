Return-Path: <linux-kernel+bounces-872614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0536CC1193D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25F7D18949B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E79C2E0925;
	Mon, 27 Oct 2025 21:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3rMXqmj"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0DF2DE71C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761601867; cv=none; b=tdW7d6Xf5imMwYMCUdunHApBr9FOQZQnHjEGAkjs7sFqlMyu3RAXa0reA+t+nfTV2/H84m9ySx47OBk8sjdfMA4xZmp0a7mwKSgH7hn8bb8DQILgt1B+3bm/uf3rdL5lZIE8H4lzn7SIk+Y7sQYV0+bR7rZlR55aV5TA4Co1Ge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761601867; c=relaxed/simple;
	bh=c0b2t3qnr5HsGsKFjLxBwS4JC9oQ+YneowGykdOhJkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+q9HNnrA19m+FJ9UUATaqBdNYLdZsrELiOzOhYEBaVPU/mFp++rYjNbyKrD2P0lw8B3M1YYT62cXf0mIqTpVp8pgu7UBV3Pzmj12KfXft/yj7IhlM/LINmT6XrKoKqh0rfR0mGSBGJjO8UAgN88+OmC0n1b0vglQcCsNzWbQb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3rMXqmj; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-79599d65f75so46555346d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761601864; x=1762206664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OrREd7iHeiHOSpPNpoHh/ywRu6TBc92FEkyLuBrGSa8=;
        b=k3rMXqmjMAXg1XE+pGT4zs7rFBSsjfh5H3TBBy535PWnwreRSYGMiaG5dfUKIdq/Ov
         rxU4ir5oeFc8EzFK7eN/Z1NllUnG1RCXSVB1qxE4d3EoAjUCMzQdctjrpxuwL0+rpMxI
         +Kb6Q22Iyk0Sc/NhUpF3FgjQ6kDU0ppUQ8zYAFEDWnq5vC8dp5PSJgC441jMTbaahCSV
         wIeZQpn2S9NUcJuBMiokOdvq6mIhTkPOm7eUrUhhV49M12IcTDoftDUa8A/+BeB3Lj0K
         K1kVhbxUu4knCF2f6qBeUFCHv3uGfbT6athxeU0SSolA2zX1SBpKzjdfZw+0vUSh2IUG
         lI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761601864; x=1762206664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OrREd7iHeiHOSpPNpoHh/ywRu6TBc92FEkyLuBrGSa8=;
        b=JJX7MlImRAoz5Gik8HFJIcRVOzZfKmPAwtaEPMdgujKXrW13x8FwBWIeaEk1nxilOM
         dEomspThUJ0i7sqYCTA4OXuFw+mWjVmSho2oDMmYwWX1Am2UfEXruAzazuN2m3xfn6qQ
         hEhFWVZ0ddt/5EtwUq3B2LVsx//C0M91pIKKRSW1SjRtAZd/t8YLSSw97qZbVp2W/FTV
         7v3GCLzzr9hZ0k9zw+aUqqCXoUPAY4PYockExxDa72S9ZuMjm1ACu7x5I8qX/ZcYmIEf
         i5r0MEwgrXjI/SqynXeIyPVeoGDCCCZHKUzjU051EkevGyee2PkrAiq6koO0sevO0rak
         Z1Cg==
X-Forwarded-Encrypted: i=1; AJvYcCVCTRmlppGU9HyFjpjqhbgxEFbQQnV9UAXujQKtJWLWJxGU/r8fD8BmD0VnSjOSdPDTAcRvQi+iEeITcbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO3RI+KTYanVHqqp4SIfgsYaC1BVLpuN4qomMm5OqCv/sz0FO/
	oBsyWSyDlArQYaTh68cFLqE5pZGRmx0r8RirJ9dASAw3wJgnHvOJ5Sq9
X-Gm-Gg: ASbGncvThq4pBJdM19PTVuBkduNVxLZi5vvB1smkA0PCrhiNKjZVjF3uJz39iPmKAqS
	3mA8fFGZUYW3UfdWALdEEzHHuwKEnQgU8PhuAph/FNrnr9mTvAcxjJSeAkxYcVG57V8c0cFueUf
	oE9Pjohr0kJ+oQpaEyuVzhg9kFepIRxYt+mukZT8AgXirhZy4BsJV8vExGN/VF06yersNvH6ajV
	AzUU8SkhvMJx6NT09Y85LkVPsYsM8osVOoZjAXJu+AjL4K9iE65aKsPo38c7m6zhMi05nt5YPsg
	b+aKoayGAoMoNAa1p70kZmbj+rIR+dQ9E6jjpPnF7zGbkKEr2NKYUfYWDlxKSOC0SqJEJDLlFK9
	Ec/GOc2MCdJ1Uga1DLGiJup5TyLBESKeIZIx00WXm/A0FwONEQxzK//iqYee+jDXp4ViyJJ/EYy
	Ku/HDzPu9gDBJhd7T/X8U6te5KlHikGftbU9rbHA==
X-Google-Smtp-Source: AGHT+IEwMMAsl472wJTKvmKmtOeEVAzkmf55c6RANBm4nkhvEStvP0PtCn8QQl45Mv31CE6MfxiCZg==
X-Received: by 2002:a05:6214:2122:b0:87a:aa4:4b47 with SMTP id 6a1803df08f44-87ffb119637mr15831806d6.53.1761601863876;
        Mon, 27 Oct 2025 14:51:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48f7323sm63559206d6.29.2025.10.27.14.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 14:51:03 -0700 (PDT)
Message-ID: <7cc00d0e-1cf6-4abb-a3f2-e96e30cd9128@gmail.com>
Date: Mon, 27 Oct 2025 14:50:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/84] 6.6.115-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251027183438.817309828@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251027183438.817309828@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 11:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.115 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.115-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

