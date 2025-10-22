Return-Path: <linux-kernel+bounces-864030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C82E0BF9C39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E57B4E84FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06F415687D;
	Wed, 22 Oct 2025 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSXGcZnU"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80CA8248C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101264; cv=none; b=a1yeyTP/Ufec8Fc6VVOJiH0qlxMPOpP4WNzIX47GtPg2jMu7nRYvONPkQ3StPm8fgrhQ5xaLK203wEEvK4/shYnBV07kXZde+PcXtyfGzDtK87PoXYR8UWDS/6Z/ljPpXeJ3EUbnOwwuIWjg7cwmddSkkbwzCcug3bDiz5EUxPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101264; c=relaxed/simple;
	bh=8wXGKm6DUxI/W19y08JL6KjPHN5Amq0Rx+ianN8ybZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHNL0l7QiaxD37GZFJMVHmQRUqSAXlCRPFxPTXVnI99kEeLnPy7evWiQYXqpmhDwbCpA6SkjZgzVGYwMqreujeY5g81b47+Nf8w+y/ovtT8T9Zxo9i/nPUmvagRltzUfkUgVVNdD/sczeA/ltOFOZ2zxV32m4IeJ15iHfqg1MZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSXGcZnU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33bda2306c5so5034374a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761101262; x=1761706062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Is5hZBe95ARo9o9vNbLjG6y2uIXewO4LIaE8nuciUpw=;
        b=WSXGcZnUg4TL9d35Pq09LzTJ6Dm7m6W82IdVxsqSaQEk8ri0CL0nDr+Yyakyf1S3Mo
         Q7b/jjZWaroWa4/JtC7LTfS6xOX8a1SSREq+8el6FIFfrjxQFIrgvZ0fy24wk2nPY7SV
         F0/TH7L0W7CRmfvl/3OStqcJmQODk8SH10FeWSJ4jPBlSXLa9vLCIbKfD4UwD6y0/L79
         HYr/DFl6ED1PFKJh+BNp+ToDBOOqWP6gTJUELjtUn9p9fLF9VrgYkjIsrgG7z3K/XsF4
         Djr/+o4h//PXFew4Trsdjs8b50f2D9V0QYM2qVKG2BtE8rAqTMqFQh751yT7usx01Qjz
         zR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761101262; x=1761706062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Is5hZBe95ARo9o9vNbLjG6y2uIXewO4LIaE8nuciUpw=;
        b=i5vIvO1GL5P+KduwXXQj5he+cqkbCTSCcOmOgg2D1w0fGngZh6AvYLhENh2TDlFMM4
         apqyZx+PQu7d9+42lFXkclUctc3xp/NiebRiWmMh39Q3PA/0g6CznwQgHmgzE6cg/hl6
         atwQBJbpIwkNxpvWNi/OBS6+wvKKmMywwRISsJL7t99JbHRbGDsnHsn0e/lBSflfWg/r
         FTr+75Cy8XdtLdg2Gy/AisJ02sv4+pz7no1OXmirXqkXu6393ql4Ya3bVGRhhhgfptwP
         lTRxk5BpOefZaIxlRsbjX02KRWam9ORMHsOFMyOKcXe7egZy4anILyokkAJJu5hSwKj6
         yYAg==
X-Forwarded-Encrypted: i=1; AJvYcCVR9ovJl1/Jhl7Wq/zwlly/CxwM4rvqFVQjfR3yjKUkS261d/f2bTUwpYqBqVqxjPM3PWNbvliq7zwm4sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjDfbxBgKDBY3fSbH1LeV8Mg291WU4NbPZWQlC7FP0VWvk6XeK
	0l2+qB9AhylMH9R5oKnLTOfUbGCUpz8X+VPRKE4UwvjQ4NtDBEFhpKww
X-Gm-Gg: ASbGnctWFLhjX/IB1MNY6aa0vV5xTQ1R99Hx1tTG5/FYIkHHcgTMKi4811FWAUAA2JG
	do6bCKO9CuMVFAn535v3EsKxz9mXTh3UJgOfL3CzSSWm4/QRpYVq6ixIqtEMbbJwFAD2V6hNdBc
	IGvXTB0IAvbd9B/ZCHPy+b/t+vbX3uWYmWsbUiqINPli0HzfASNnNx0LA65wsCdqGe1PDW7YC5k
	WGb9/TidgTEZABVTQaf6OMmoFveqCXew4/CZvuZBK8DBGDVZwcBhen0gjgNx+Fwhn1RJcw0iwhr
	b55R6F4UQzhqARG0wiqZalfNsXz9sdnjnmNodzp57Rjn/Xd28qv1JXvcTlHWclJqbbW6fePo0TN
	aOtbogKjCV8Hzd/GtydN/sq63Bujm6Nh0DZ0DwaCfPE79DGkfQHiGFyUyjM46m0KEguq5EgCCEl
	aV/LdI1VNErEkk1Wh2N4MDbd7S51I+heMHs6CwBKiSGdJy5HuyjIDX
X-Google-Smtp-Source: AGHT+IFavwVqCCJX51O/QL9n0GDxtahmjbc0ecv27WqJFcgjvOksegxUDTtOpcgnKqBiINrdJt0TZw==
X-Received: by 2002:a17:90b:1d0e:b0:330:7a11:f111 with SMTP id 98e67ed59e1d1-33bcf9222e2mr28788633a91.35.1761101262106;
        Tue, 21 Oct 2025 19:47:42 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c7e19sm991944a91.3.2025.10.21.19.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 19:47:41 -0700 (PDT)
Message-ID: <c6090593-cead-4a3e-8380-615cd055f2b0@gmail.com>
Date: Tue, 21 Oct 2025 19:47:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/136] 6.12.55-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251021195035.953989698@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251021195035.953989698@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/21/2025 12:49 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.55 release.
> There are 136 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Oct 2025 19:49:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.55-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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


