Return-Path: <linux-kernel+bounces-858980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C83A7BEC663
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 05:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B66F4EA6D2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6131275B0F;
	Sat, 18 Oct 2025 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR/CS80L"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E823E3595C
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760757393; cv=none; b=HbvS+OlU/EL9KY1rjvxDGuPH/xEGasSvO4dEGC1YOkSajBoAEBldVPM1Mp36KvO/VXg6vH8xveHV1Xwwmg1Ss82bLU7sOvH3FyebyamRoQO0P+Mn+XwbFZFu56IIJ8M4Mec6D3eXIsJOaucSLUSCFJTEq+bcDYKk9eobxlro54A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760757393; c=relaxed/simple;
	bh=3wqEQjGVhmexMMNO6iz9PsnEYDiNYzXnxmnJPClebZk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QPQCLV7aV2D1FliU3emMq6+5KyTPz1nY45kTuYiQ3vgzsiH1fpIc8In2Bj4yoX/QrT6GfVpWaERbTK6f/QYCIYpHDu90Sdgbsa3zFWj44nqUgsyV+kDcG6B5es6Ja/KFgNM945kEc3RuW3GWfEoZzZKKAocHTOiLLpzm5jnWAZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR/CS80L; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b550a522a49so2075037a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760757391; x=1761362191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CngrJsnwfVz5Z0uglJuuMx3gx6jUeZ2x5IS2P/yOwoQ=;
        b=gR/CS80LjwryuZNHudCAi7HdsjgeHZnv7JWdgehz1m260vjmxwaR6Wp4k2IAKWgVfw
         bTLm0/R5asfUsI/z4glb1S9r3cTXOrZkP6+DhxjrxkSUB4XwvGzIpVrGkusvifCi1Rv4
         9zF4Uns59Stv1AaZ8oR3UhWqdjmwvwE7mnyoFNmY8iIl0XL760vF47GMxt/ZK4n/3yAv
         eidS8fAFQXy9pN90fO1rJq8WTBJx0r2Mkpd2/I4IvtZu/D4/Avno9uw6XDRBykor9Rhx
         knbmydFQUcGaWD61Ue1TT7KMTIHfMRjSDqQNbefNV52yC2UMJMwfHiHHoqbASS+Qaq52
         78ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760757391; x=1761362191;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CngrJsnwfVz5Z0uglJuuMx3gx6jUeZ2x5IS2P/yOwoQ=;
        b=OVWqifHsOxUkFidgojXt0vB4cZSGa6JtZ7EU5/frxHw4qy9OMzH2L7GKB0ckgw6pee
         oc1D3LFH4uXGQuauoyFgcC5xCs1DBDDx1c7hoWNQCJ2iIZ+6wSz5Uwpsz/UmvTYm4gML
         kYP6Ss3WaFub+xa12LFkXOe22eM/hKzXcLeEbQL3i/Eq2Ydt+Q8R7rXIhLLMZyPZFsvk
         o6Crw871QZwz+8HMYOIfYB8Wx3ZZtBJRcQUC9biCrIYW122uD+rrl6gGJw/OXFgW3RxS
         FpqxHeiseqUiuOBsQtBSAzuZxXC4HGq61NziZyraB9VodcrUEEWXuNCw5HPkdyGY00IQ
         MmDg==
X-Forwarded-Encrypted: i=1; AJvYcCXPnEk4I9/UN2Gso0OwRYAzFJCrHfPJj7sHb+ZekHPt5BYvOKn21ZSaaT3g9QJZdf9ekNwefqqym39afKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOQrUV1KzCI4pjB4pMlrNiVjgTT0ENsjL3WykVR2i+mHiX1vjq
	OobsymPZrxUJG79o1Z4dLXJgjskkZsSl8OCJsyNSbwIHXtCZ1OtbKgoB
X-Gm-Gg: ASbGncuuFICU+k7leXdYhBetLJs4hkTTxz3UPmtArT3WFr3n9U+9f+WmVCxVHkxpLMJ
	k4ECps2ujowe0stGowiK076jE3jYCE8Kzu8tHIxgJiCczs9/ZHNtM/mZlowjDFhUnz1xKpKPm54
	SIvDloIEtBCPjDsd5Bnr/+xsRrM8tr8aFNyQGbQmAoDGRLo5ds7ieQRmaGoxpuhsdHOv5RDz+8y
	di4nTL+4dQgw+fIoSJdYR7S0jexBiPVuTnAtBeeuqJJWEegPWIdLkFLH7ZTCr7YJ4I+EAyz5qGt
	vUJ+iq28NY2Sdi9C3LJDusTHKlbasqbzrm9ZQ6yyy+lsjhUJ7zdoXuLEBKIZ15tGC8ZEo3C0bEq
	s4K+gY799/kx+gnZzM2UrM19ANbuXgZ1V6aWAsuwJ+LXdealcTL6dGm0acFwBb6zftkFpE9o18a
	YEc+ZE52ZS0jRTzfT66tTAlXyePSO3m3Ja45wizAWCqrfYRcliwRmk
X-Google-Smtp-Source: AGHT+IGF6g1VgS+2PdOdy2+M9tUOsUipAN1cyuL9NAJ+Yq6EnSQf09Cwm1hQzI6MsDSu/Ika2xwH0g==
X-Received: by 2002:a05:6a20:72a4:b0:2f9:48ac:c8ed with SMTP id adf61e73a8af0-334a8534251mr7721301637.1.1760757391312;
        Fri, 17 Oct 2025 20:16:31 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5df5c2e3sm977960a91.11.2025.10.17.20.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 20:16:30 -0700 (PDT)
Message-ID: <1b17c6d0-98b5-4456-a586-918d6533ca12@gmail.com>
Date: Fri, 17 Oct 2025 20:16:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.6 000/201] 6.6.113-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251017145134.710337454@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20251017145134.710337454@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/25 07:51, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.113 release.
> There are 201 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.113-rc1.gz
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

