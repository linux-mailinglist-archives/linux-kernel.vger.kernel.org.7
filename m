Return-Path: <linux-kernel+bounces-724561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B75AAFF45E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52221738C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D13B23C8D3;
	Wed,  9 Jul 2025 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UifMY2Gg"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A0C21C9F4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 22:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752098800; cv=none; b=JmlGPSg4S9MGBBC6smApdnf5eGIHT42p3epTF4j8p5hZAf+skYsBHVakG71kIpCXKY6Rta77NOXudN6RJnh87HXip2FYFyuJQCDu88upau8XNMEWzhJ3wlXJJ9IxWeds5B2DnmuTJWusuRIow7zvn6tePPBaR5Ezw+pxS+Ax6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752098800; c=relaxed/simple;
	bh=UivWZVbVTdAnNMHvcMlummL2yP5IUJF6YP9QTx7V2tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciMM+PXU7GNrkGKw84/60oJFg1chjrzvH+KPbE95I2/POl7n25+QBnQoOHoOdGwz8ilSZPkOpDQL3rk35eg3+D7KgWW/P49+UD1hTzq2nckw+pLx8fYgD0mzT6O0wddyYI3Y7i1eK8EGx6KhDmkrLtaEvNNkgRty091YUWToD8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UifMY2Gg; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ddd2710d14so2596455ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 15:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752098797; x=1752703597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AHVWGMYHRCKbeFjqKUCEW0KQtyaUl3Of7Bsa4d9NxMs=;
        b=UifMY2GggVhBNXWIgOs5fiBljg22QniffZZhOGbol58ck883+pC35CPGIBeJQrnIOA
         HRMvV0Cl3y8PluYqmnInksWqWbKNOGgXISzpOG0CXndCWA6hWn+04JqA9zIX15eq2xGe
         SD4b2hg50FElch2LiAX8fx5YLSglDcOnLCIbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752098797; x=1752703597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHVWGMYHRCKbeFjqKUCEW0KQtyaUl3Of7Bsa4d9NxMs=;
        b=UmDY5VjZxCY7vNEt7WBMqIpDbKrMuJVQMP8R3n129ePU9Hy6m68RDSSLrqfxOWZS9L
         6mwnyHoZEb2+4K1omfaIdkQF2IhAII8r9O0EB8RpA09m4DnU0L6qnlmu0f64KSriES9z
         PdVZk9TWcmqx2SupLgboX4as2XjfI10SrpZv5Hr1UPrK0e4CpBi1CPlNooMXbNSU9wfb
         ooVffkOKoxq34Ku3DnywlzfguRmWZa2h9Ni5+vHke3i1SWHHnV6G1FJtmvzmu4HCvGVr
         BPR9xx9TCu1LSeDkdvIU+xdsu5SeVAJO6IXcEHwfhiztiQ+Q9u2P1+Vryw3lTHb6nxhD
         721A==
X-Forwarded-Encrypted: i=1; AJvYcCVPtWLNMx4+2BuiMLhWihABEXAVqJ2LacBHj38RzlhbUMK9qFhyC6Xcd4/+bHHtEns3BZBLHvxdHOTeN6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC8AN2vIDtb+V21NYN/rFCFk1XH6QWQEl45QfdjOdpiTWKkUfy
	UJIRzk2yQfZzTP0nCDnu39XzYXrjXoIwgZxvOKnJ+VOtg6ZhFNSeIHIxvZlHEzyMgbE=
X-Gm-Gg: ASbGncuMRpHOhinraAniTFTmxddKK4+ljkihwUeIMdfvCPV1nibUx+wZvAIYSNjlWoB
	fT1JaaApiApl+9NQFiv1mki5dGlqY3ACYlMKyGdLqSkGeEv5OR1w9VDiDipovGFiJjCrvIRtudZ
	HU96enDG/f5EDzeLmAhhW4tWVmD0u2TSlfhx/zMoevP2B+dGg/O7DcSLGL4gfW+0dbkpyrizCm5
	Dy9GrcaI3lDM4bxBg5AmS/VhfGnPuaYA1oWCV5UDVfUEPd8DBX6u14dDiGpqq6iWCGxGTrRxGyN
	WBzNTr8dcjchUMCUh5Vi80/o6KRm0m0h7YCxm1RtpBWgflQCsguo1h1fOJ3RwTbhdN/VL4MWDw=
	=
X-Google-Smtp-Source: AGHT+IHWjvyzeLL6N8yU+Q79PG0An3NzZ7hrnWtn2/hlkyOhS6W5NhNcVoTCYr01Ld/L8cIfVJIByg==
X-Received: by 2002:a05:6e02:2205:b0:3df:3110:cc01 with SMTP id e9e14a558f8ab-3e2461eb736mr3622715ab.19.1752098797568;
        Wed, 09 Jul 2025 15:06:37 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-505569cc6e3sm37400173.102.2025.07.09.15.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 15:06:37 -0700 (PDT)
Message-ID: <2c51d285-186c-4110-b292-4051737ad215@linuxfoundation.org>
Date: Wed, 9 Jul 2025 16:06:35 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/81] 6.1.144-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250708162224.795155912@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250708162224.795155912@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 10:22, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.144 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Jul 2025 16:22:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.144-rc1.gz
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

