Return-Path: <linux-kernel+bounces-751339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F00B167EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 23:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6326E3A8B00
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD85421E0BB;
	Wed, 30 Jul 2025 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M46tIZ6P"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C8E1FBCA1
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753909222; cv=none; b=ICSaApTbaRrHIsVIWUGXm3v+JmBGAkEnAvH4HC6gsCkTgH/qbVfBvV3DwioZRnnb1nXFyzaNcemUUTkC07Fn78TM+nDRLe4midedRXdovnplES6w7kZw/k236sjVOvtrPHJ3cKvFNVYYcf1SqnJf8RyDyo2RUfGWt5Xrol7AbDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753909222; c=relaxed/simple;
	bh=qYO9XYMd9Ess2LLFsyadSHoQze0pFR9pSR+4q7JxSB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccn/S8vzQCF6xhe8PrxKrZNMpGO5VKCw1XUvcB89sFzp7CXquJmvNriVGJsNGykfYo5F/V7ibIpTEHTYakqYw5q8fXfDDMjsdJPyinpG/poBwNcA7IPDI+VvptqXwYg7VtiitwujjpkgBJ7RjG9Jx4fTh88FmlJacspdhzm87mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M46tIZ6P; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3da73df6c4eso1264635ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753909219; x=1754514019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nTYoBlbWe2hufH9UN/C4sSrgwEPP02z/hVZuVmtCWI=;
        b=M46tIZ6PXfLfP52r+SU0yCBUE/63HE/9r4avOn3XDSE7WV3r10KYmvT71xXH9/wTF0
         X5UHPRKDEX5yCEkKm3lovsX6rM6H7Mg6HxTD8Nryx59vPb8JkshwFfo2hoRoMZrmgydg
         Fmz0rtZynd8g79gEXYbS313g1OVw+woajmNoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753909219; x=1754514019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nTYoBlbWe2hufH9UN/C4sSrgwEPP02z/hVZuVmtCWI=;
        b=hB+1Kpm/Uq3QKXEDu7j7gk/hYgKTzDG1iyrBDGTciL7ZLyfYmmmBG5i+Lip5BPw0wS
         bkpUp5Ut5X9kGdNMAPQfpgpfh0fBb5DIKE4OWooa5Vv/4OBc4PMcBV3MeG+uZ0etMdvF
         kxPglcxfZbq821oPS89+r1tt2H55I+bGr0m5NCWzgnJ7+M5oQ80DCdqg/qM/NBMcK/Kr
         ssUa8oThSvzm9DdEyv+gQBhiO3EdeOhiVTRkDoTyNZnvBMNIcRRrAv0+ZgZgD6/WNZq4
         qpIJvV0WrOYJ05IjOyXGB6+k88CdWE5ci1btIoCJBfpSjFAoTrL+vbV5RuBABgHUHFME
         e4HA==
X-Forwarded-Encrypted: i=1; AJvYcCV7rCJkOeEC2TGuv84pp4yVWsW9AYQKvi5KGz5/ffMsMWAeO25XbVGYMlZv8jfu0hShpq38uptNVeIvuBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAl8j7BxgTONna/ZMd0j/goqDEcuy3NdmlLXAlrclQqyhATBe2
	EyRTFqL+IUtla0Y61gFClp1KS85+sXtmGqSxCwSG8xa+TwoY293dlE8E/3CXYXDhgXc=
X-Gm-Gg: ASbGncugnGzFclEogOrrDDthjltFhHu6KiDJcKRetf3JfoI5T8tvKpPM4OgRdyauMxq
	5GUWXpKQPBfMZVi/lCFteruz6tdcaHoDgTbsqysaVDa8aKGpVk5QHoMQr9QFfZyaF4Tb/oC+XPI
	N3p/K76fc2jvYXzNZBA9IUyeCbPP09snP97lGC5SEmZa8BF4j/5u4JnpTU+xg9vB8xnn7MzxWKu
	ynMWJ/N3av7fZHK140+XNScLA5qBymLx6djXs8nXOO90hQAYy6G41YqR5zhWQ90VG9qV/dl95v4
	ceYfaMBmGORpT/lPDcMgm2THMGsG6ng5AdILKf9OIxdNa8O68yCG9roCb3owM1Kd0pEiq066+uO
	fLzNYLgtIcZUT2PKRgHJxFcn6uW6fIHnqqA==
X-Google-Smtp-Source: AGHT+IGjPEbPegqBnEDpd/XcqciAKEnaO2geFGrPEn0TWYZQKwLtS8S00ByN+2MQJrm5bjkEbIXPWA==
X-Received: by 2002:a05:6e02:240a:b0:3e3:d50c:d657 with SMTP id e9e14a558f8ab-3e3f60b6207mr86671535ab.3.1753909219396;
        Wed, 30 Jul 2025 14:00:19 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55b19250sm59262173.5.2025.07.30.14.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 14:00:19 -0700 (PDT)
Message-ID: <ba33d960-df47-441f-8898-5253e685ed2d@linuxfoundation.org>
Date: Wed, 30 Jul 2025 15:00:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/76] 6.6.101-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250730093226.854413920@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250730093226.854413920@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 03:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.101 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.101-rc1.gz
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

