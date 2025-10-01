Return-Path: <linux-kernel+bounces-839278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E65BB13BE
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 18:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4F14C32EF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E38127056D;
	Wed,  1 Oct 2025 16:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQ9ZdcPp"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA79F262D14
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759335543; cv=none; b=d7++V22pbtfdTK4EOQ5C/wZpRGWBzZDzGAbFWcPm6K8p9xGCKdeHavRQwOkw8Q8ZvRWg1pF7KPp3mudQvcra6GodDFLBkT3gFVPCcwSn/v3n7NineswPOFf1igCblMkdmXbhZ6XpjhoVUM+LJl/xCfqeCLcUX9gsLe9npTbXrUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759335543; c=relaxed/simple;
	bh=VfIZnBuuXwbK3IWB7Akbz8kdzqSwGJv1M2L6QUoR7uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPZuAxo0Q46FYXjlGn6Om4EteXkS5b9WDZYqI6dReUmsO0vzmr4lsdeNLR17GZ9CtbJ30ITl/68/HbfTwnSdeeFGH57sXe9uOmNg+WS158O62lH6rSmiMbKN0edl0Cc0EJUnvFNNy0Lv2KvKOquPK7fFZ1/gTHJWOuLxboNTdvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VQ9ZdcPp; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-42571642aa7so225545ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759335541; x=1759940341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=310GXMr4EGkw4tBWn7jL9r751VwpOohlwnfgRE/DlJM=;
        b=VQ9ZdcPpXchhVFMY4Rmi49HlajYbraoMDHLKPjRHODsnmKNRS5SZCBlt/maTUlK6Tm
         v/VxepczpZzt84o4EKkrdNL046bx3N3K4Wd0kxFbIjE5k6Axguim7JNCpfrkbelO7/CW
         vKxA9J3V0SC9KZlrkPEBO88b5HYwOo3zc/nH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759335541; x=1759940341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=310GXMr4EGkw4tBWn7jL9r751VwpOohlwnfgRE/DlJM=;
        b=fTfHIKrYqM8yxW0AAj8mKR9Fh6xmVluej06kKc1hjW3szC7+O39mUuPaL8fCBT2QOe
         yvXnFBvaQ+BZr0ab8otpSJ9ocYphDV+3gmlGSG7TkKmuO8J/lQN0kdV3g618AjzCvDve
         MCNH5Wnd1Qq/BnBl1WxBW1gDGAKJ1QvCT0kFqzziy7aMggFQodSUdGy7OLTc6rMjR3kr
         hC7OuaqbeBNw2H6NV3087cDLvNIZ+XEFX3EQ/X/H/TnF5vBhrZ3OGiHbO9gQOF5+ejG7
         OCoKoLXcGtABxA+PF1vcCwA1vPRmVzXrkrqDo8P9FKlc6V5mTzewjWqYah56Q4lyU9qB
         LA/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUS8GsfMNrff40tfrdlVeTKVLFi6AE1/8eZ3ybJMIAt5PTTORWrjH2FDCMoEhBXCwZMTFEPAg/alwUwW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbn9bMPVgcPJoVXAD1jmiFe3IsWoKF62542a4HGGltka2AnSCK
	dbSO9DaK/SnwDAZ71NRmOh63k3B2+KmxzbJip5TkIQv6hoSxsaBLCyi4d3Qyb/tAfv0=
X-Gm-Gg: ASbGncsGWfEvWKlEvTRXVf0v2cyD7XYwsUdZ8dmveFFMIhsWOHqb0XyZkOaf3O7xB1+
	iznj88oj6p4KnIToXzz+XlyQUBg9/Aqmu1ZX0ZvfN45Y23+En8bUCFTqMNuBDJzdhVD7P7jBC2I
	f+gfP9LJ6EGisBkIuROuz5/jQm5R7mQCrAEZ+e/3+zf149U4kNw0kcSIQb1qjrYDTgGEgSNDY77
	Ek0AR3HZPTnu+Rqzx02iKArDyVAGzVFy84qLNESNDwxFYYKjprOWeKk83XpXs1xRer7WN7TTWCZ
	onIixcC6ytquXjcw8U7oUPoRmn59CSYcl60WLQZ+exRH1QtV74h/shpxcyqz6FmCSLyq1uKHTBP
	zcs5Pfgj1JHPMmZCG2mOHxGIskegBpc0mAPS9a6u9HwUOiAowUXM5W68mdupzvSlbpV5y+w==
X-Google-Smtp-Source: AGHT+IEnXWfyHiu0RepE/42DRKFrYsy1KrLdW46lG4vj8sMVf/WcdNKD770NIyGOoBca6Vs+nul+gg==
X-Received: by 2002:a05:6e02:219b:b0:427:de6d:b6ed with SMTP id e9e14a558f8ab-42d81611b33mr58944135ab.9.1759335540828;
        Wed, 01 Oct 2025 09:19:00 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6508a1bfsm6995443173.18.2025.10.01.09.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 09:19:00 -0700 (PDT)
Message-ID: <09ba5f85-701f-4889-962e-f7bf5bc2dd4e@linuxfoundation.org>
Date: Wed, 1 Oct 2025 10:18:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/151] 5.15.194-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250930143827.587035735@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250930143827.587035735@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 08:45, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.194 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.194-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

