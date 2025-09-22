Return-Path: <linux-kernel+bounces-827960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A07B93875
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A71D189AC33
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E74316189;
	Mon, 22 Sep 2025 23:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJCBA03D"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92644286427
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758582072; cv=none; b=UgAypjmMkqCGZEtnPhZO7K2K9MkTIyc/FDBXoRySUckDVHOyhKzgedw2jeY3KV3Tf6Ux8frnOm7BRQ6PWbm7/XlV4PIX0CLYEz2HRZBfavDVja5mJppLJREGljNH1ELBHXPt0tGnyMa1pG4STyj6x+J2E+8WLqQy5/AAQDPSAYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758582072; c=relaxed/simple;
	bh=Ip4IJ9YcCjAcNS7SeyBSugqXLgQYC1klaEHI+7Slqio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jXi4VgoUZnJL06HeT8iBTTQQ3/xwOl8K2tJ8HySMezg5Yi4nae1SY4ykMcDeC2wxSJp7SQBnl+RjkeyoX9ZkYT97SKk2KrW1EjtN8QCePx7ZoRE4jo1w+Jsb7iQd+zgyiGFm2sACYWBtjx7d7WqA/TuYqsKHe+ecfMG43Bl1bbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJCBA03D; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f429ea4d5so1236962b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758582070; x=1759186870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZIRmuzDxZZ6U1ppyV2zSqCOvJ0mDBr9fz+vZ74M3vS0=;
        b=FJCBA03DB9Nxg/HLx+YfD6NE9VS86kBiSD0Ua5mEjc54eTmdOl13f20AXQBYCcm6nu
         +ZQKM7b4YPSRqjHA8QB/jVDbuY2+avIqzCdRjyJVEypLl14vmx5p0sEAXrOBraaN8VmL
         4Uz7OHHZ737X8ztVhlX46oAMnOmWLjt8VGtfoeG/V5lBD6ilS0ri9wu/mw+EhDOGyikH
         2TzGIKGEcZjVHfzvI0Gfy69JOHuozi2gJX9hEtCXFbQJXpvXPRLfa8OYwCMW0/f67uxX
         du2vyMROWkMzwEYRGGHuTauRv2dPFSl+kw6w5XOXy4gnWOQiXysdLBVxG8npu/fM4Rjl
         Z8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758582070; x=1759186870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIRmuzDxZZ6U1ppyV2zSqCOvJ0mDBr9fz+vZ74M3vS0=;
        b=X5s73gUuw9cfsVcAMBWxJ6X0mPqk2c1x8XN65vFAd0bKXfr9t3c5E691aHSA2Lg+jd
         p4Xv5JXJYtl4N2/DhMxrt0H2OsBLeDEs/htpTW738cmnvcjFpFyAEjvH8XnqxQ5Xv4Lg
         gzUvg4Cs4TNN6SyLYh/JTrUe8ufMq5D/pAI8CFproqAItZ7+K+7vLJv2CiAhJhc1vQ9G
         ZqaazxLkZrmqGF1okzl6RR/IVKNiYdmo/RHTyXSHf1e77ER/OsIbd0GI6+FF1EjqWdsr
         G9BLyvaU0mUMTpYBHKdHPfqFnwA72unR2MoU13aKrmfSAv9bpuHBFPmqYhojx/sZTmPd
         vllw==
X-Forwarded-Encrypted: i=1; AJvYcCWHXRgnvnFubFXV6rwGWiUkbPO3LpAWVzQowPbRmFrULJmjDdujwfmU1u0mIJzgT3REperljER9/1SuLfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp3v10VqN6vyIlFTNcPxAE13dYNDIreIq2E375vUxAu2+C4S4m
	Ahzk99EO0prfx3QyO9Mota3ICNLsuJ/2GpZagzGtU2yMT2wmjCaEmmbf
X-Gm-Gg: ASbGncsB+Mc4CxZwsNpJ6mv3L2HCUQp0GlqttF4Rrs50e2UDkYxcwtT9/49Q2VgYHEp
	n95Us4LonoaOgOuh86h8iQEMFNeH4nPoXD5POvi62P+Q651gy4E3lbn3jOKg6SvXSqVIxBZD4dJ
	5qHMD5l0/vEy1dzrd+pakpn3TDDE9IKyGa6DH8K1nIFkvfITLNvUBgvpfpgdT/tlTkItedvWLE7
	lR2uRGCCxGEvmiqd2wzE8kQ92rSMezCHmBcy7pRFpIgdG19nql8h5w41B944BKJK2YWlzXde8TA
	B0z3pa5EFLFMtcKHELFUrtpZjf7RdJlsmfQe1tS887dra5TE7sCrNdJmfalYx4v/MoaILrESHev
	A/To+0Y/ce30LFStkWzr9mKy9w3qt/NrT9WTgw01dmEACLED81R6FI8mIXf6UnrIoDDuWaoO+Ec
	LqbnEq/+Zh
X-Google-Smtp-Source: AGHT+IEWsdn/BYQUoAQIfQeX+2S0J+Xjds0yc/56BhxRARTZuUx0AR6Bk4YM/v7fMbIc94nL6KpfHw==
X-Received: by 2002:a17:903:2f85:b0:266:f01a:98d5 with SMTP id d9443c01a7336-27cc79c350amr6680795ad.57.1758582069506;
        Mon, 22 Sep 2025 16:01:09 -0700 (PDT)
Received: from [10.255.83.133] (2.newark-18rh15rt.nj.dial-access.att.net. [12.75.221.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-271353b8792sm80534825ad.123.2025.09.22.16.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 16:01:08 -0700 (PDT)
Message-ID: <5326f2f5-e2cc-4733-a44a-db08dd8d19e7@gmail.com>
Date: Mon, 22 Sep 2025 16:01:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/149] 6.16.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250922192412.885919229@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/2025 12:28 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.9 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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


