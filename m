Return-Path: <linux-kernel+bounces-864031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C4FBF9C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5913BD772
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35BB217733;
	Wed, 22 Oct 2025 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJD4Uysa"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751C199EAD
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761101307; cv=none; b=QURtqZEiMeblpZBT1u0fsKlhwDQaVFyKwoD7kBOM8qxbOh0/e2XYCG1Hh64KJJl6A8/U4E9rhXJ6Ailbrd0HsnXThRG+FiLOHG7TIn9lPsKIWXb+flFheUNZGymhJWIwbRRgt3/+GmY+NtQlVCAlj8zaqj0CRcGDlxHTj1NgKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761101307; c=relaxed/simple;
	bh=2ihbmTG7aYO6isgKBBo12eNmNVhYXXQhMaLYdKlUogE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFtUeb5FXZPVWGZUtioQgZvbJKvBSpYgIOa08/YPyWBWx8hM3K6VMEM7ivCUVszNwDCotuRwW3u7M+hOCNyNIz3bYGv4jOD4N4unr0HXfCTW+3Brri3yEo2EmYb/Vl5p7FTin/x2PD+wOD2C2xTkHI6/9ZHhNVbhDVJH2PHz9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJD4Uysa; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33226dc4fc9so5906289a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761101305; x=1761706105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fb9NiUGusZmP2HxYoohhNZQ3pvpdldxDNGCkCdvFaz8=;
        b=WJD4Uysa29+Cz+aabQp2MWGsPxogkQErHg3Wl+rF6KgQz0Fbm6hGNuOPIwEB4Uy7Zf
         1P6TFBC+p0eo3fDn2Hu8yPBzb311yhYgs1Utha0SAdL+J4TNSgjo99mNNrafkMfua8TM
         x7HocjXYb58PmWVCE1NIUySq5vsGVShIM3zGYQNAWrepMzEIGEaNfGbHlrY/LJDm3LRY
         nDt+YGl0PGCfL06FzGD/iZqNikdruxWIG18nQN9gbZOHTa4hU0No675u25ZdLmoi15pE
         euk+Y2FGYer/02LRIMdKza4ppfRgQnbe7DVrAuq6JDy557bKdN7Tm6oRnTu5GBzJkY5w
         aP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761101305; x=1761706105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fb9NiUGusZmP2HxYoohhNZQ3pvpdldxDNGCkCdvFaz8=;
        b=acRIWrff6KDF0OohBxUozkz0eNSRDM0VnfaRw1KNG8ees7aqlrc/DveRQQ1YOu8RcX
         gDQ/nhCzZ87tKyUZ65cZKutm3nZtxIqoowG/SCYER6WsxB6JqVfOP84jmh6pDeXFDl6d
         +B7ac97JgADl5MAmi8LPm5cF9KUDbX58lK5OmLe96hAVxDi+4fP3I9xWsuF4KdnXOufF
         iz0WSJ1X1B4EUohnyOgIL25+alU1yT5Zioj7jwArgwHZaD3pHrqtGgZ/4rlccVBTWtEF
         ybzW3WvabSqJJpK/pEGVxedhsRtMGIux/vLROF5iAJYPAZC6uXzFxNV1V+SNbqrTjRVd
         1EJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPaR+2ckI9NGvh5A5PPH/CVbpF6lgZ8ZJ3LvyU8xxxQ/8uPrZpnTYegbeCOIIW676VekDmQp/6wNr+CZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRoMdOi/wk5JpyKbI5kk/HDM6+/bszpkQzj8fRbwEdVJ0CtNbN
	s8CNOvOvtbCABZXxwGt5e02XcFqNTRgOYzd+WpXijwvbkZTdJVz6kpVd
X-Gm-Gg: ASbGncszSE5/fmrBnSLJ7ORdDf0KTEHk7mJK4WB9z1Yfnh+2IrjM7FlG615CR7r5H4T
	fMDiEzIdLF+LwKMjapQcsn51NM9gvcBY8MKndTYDPGvQqZiosaokXQDwObcayW3h8rhZslZ8EWf
	td4oT0Rii1VAekVMM2GOqxUTr1iiYwGZ/g/0ObnzTaRwcMqyEIrssNJBw9n6RfMCFBYw6ibQcx2
	hZWKnjWizr3bVIiw1NKkS7m3yWU0tMK8D51MsMjdjRaeLZOx5kkg/f3ajEPfqDovjopbURlLAVP
	ezC7tgqyEvefd28D6Z1ObAq2BsNm5ndQYxppPScgwg4lgypDq3vVF0LjExkqLbqImbGR9pj6Fkq
	yP0M6r93/+3q0d9xgO7ZhFe3pbppw2u1t8EqcM45YoEWv+z+HlF3QMtF9np+K3FriSpFtsOLAi7
	iFX51w6I3hdA1wEa68bdKvXFMb/9RQ9OoEE82mHIY+48aW7jraQP75
X-Google-Smtp-Source: AGHT+IHUH6QgXerzHyeX4iRldiExQDI3lqMQbQ+JkPENI4w+BBTAZQF3J02Ulp34lZmp62c/SVXYMg==
X-Received: by 2002:a17:90b:510d:b0:330:797a:f4ea with SMTP id 98e67ed59e1d1-33bcf9090dcmr21211755a91.29.1761101305056;
        Tue, 21 Oct 2025 19:48:25 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e222d8652sm1010138a91.0.2025.10.21.19.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 19:48:24 -0700 (PDT)
Message-ID: <9e2eadbf-f380-443e-84e7-53590ee54f2d@gmail.com>
Date: Tue, 21 Oct 2025 19:48:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/159] 6.17.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251021195043.182511864@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251021195043.182511864@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/21/2025 12:49 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 23 Oct 2025 19:49:51 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.5-rc1.gz
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


