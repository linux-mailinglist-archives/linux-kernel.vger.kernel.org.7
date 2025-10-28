Return-Path: <linux-kernel+bounces-874574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E85C169BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802BE1A2616F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E9B34E772;
	Tue, 28 Oct 2025 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Znfa7xL3"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E62233CEA7
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679647; cv=none; b=tgMW0da1V/TK7PAK51vGc9WvUJ4RdAaAzrLH/emnqIPnxMQa+Qrd2+1U6+P4PhavTrdlEWN2qbNxkWz4qpe0GspJKF+NGqbPkC1WTLJBW62IYI1Jan7Nfte18jPxvoBa+C9A+oADwVgu8cr19zEzUwciWykffjEeaR5riQPMHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679647; c=relaxed/simple;
	bh=EjQDlMKljLoLF1RNLEqNk/sJQiRMv0YG75vPjfuCAbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bK4NFWLKmI80KGFdwEpGSZHghGBaxK9bA7SQv69IQPEClshg8aUZKd+y4HX2g+xcl3gD4wQNi99vynilMAkNnzwMSm+xQyJQ4qgCrbbfaWisp+4FEAelM7bwlkPmSRWuIwSUQUkWvoZQ00ZJZ0n3BBF2urlN8oYsTgtBZDqjoFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Znfa7xL3; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-430bf3b7608so67529235ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761679643; x=1762284443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GB2PFiCN2UaCVMnczPZbv8cjpS+ngdtn8TvyTng1lic=;
        b=Znfa7xL36HVagQIIMyIoI+BujbNqgkf8NrzQIjPOKuyIVMjIafWIHa6PR1todHfHZV
         savVsRFoOej1a0lEnYA83dfWj06cTrfMgzbTpaL5usXep6W0g2IFOb4czCYc5gOVUcuf
         7kgibXGQ3sWTTmF9MWcUpApjKSKH0G3IATGDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679643; x=1762284443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GB2PFiCN2UaCVMnczPZbv8cjpS+ngdtn8TvyTng1lic=;
        b=DKS0LoSbH9RuBKRPO47a85ym+MZCHKPXgSXcPv/Tg9n3FXTJq8v3bftnBZCpo0YhTa
         Da48d4KQaTJIpuSJqL99T9JmR38BZCERCraOFTbIJ6fJjpb/ZwInaEq2qksKbGzqkHJM
         wOkkSUBjmiHQxA/BxIMiEhOGaALEDS+8rdRMn3Tq0vOSCrzR/XobAT4jx366DoRefjjk
         rLIonKpAVkGSm3yu+69+c4zA6jvJw6D1GhEL/HNaJKtYiwLz2RqasFG6HnUPcXATrOvd
         Frb9cQt2A7tW2EH2grrgtH69+8HKOiptJvqOriTC1JGZ+pM+kWl8KZLY1PJcyvnBBODG
         Ghdg==
X-Forwarded-Encrypted: i=1; AJvYcCXBRE4Fv57+FxbJs5rhcOFbnDZ4BaKGaLnY6Qxzj6qIFhmKzEZX2nJSNWMwv2X3k30idMXHYVNO/C63rs0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw53rLV3tah6YwoyvWOwLSLPC6jEmnVrNdORPUFsEoBG3YQPYRi
	Sj3ZJzTvgPvcwhv/3j16JdVo0HfVKNCwEZfsNys+D11vHTL4wja2QdN38qjTK1jcwnA=
X-Gm-Gg: ASbGncuKaD34V+pqnGKnQ+Gq2MdwVlTU4znP/x66mzHkIXFNLsuVlDqX6go6cI+MNR5
	MCwscNLbAfkKaBi1suGgvkficr3fJPPHxWyCyPRXDfG57PGEnppmOaR9CJhFrvqo2FaJKG5lWlI
	/od4q2bWjDxoU0Vp5FHrWqaXQw+SlPUEfVkwqs5G+FhyaSaplJZL11mfVcla4X4iK4YzxSNuusq
	IVG1v8ynS+QQCV/AW/73xeeHDiMUP4w3zH7q00wm0qs8SuETrUa/KrdyD253q6jPjX3GVIEqHYr
	cwrg4fhTeYHDCeM9EsbjiOGzyOfR7VwIxedg/iWKRssC3iFxz6BZzGYFTPLjJgLayqV0XmJbQig
	d4jNa7Xq10T/BRwQ6svqG07vuxYVp+YAgZ17aib2BJXr0p+gvIJNqyt8PzBZZhJSrni0YeoALWw
	LPn7HfI/yCTn7D
X-Google-Smtp-Source: AGHT+IGXVvv4lpTGzJhlhova0pWyuJ1mMuUD5kivB8hewEmKrt3ll5migY+nbLuVZH69B76ZbpExJg==
X-Received: by 2002:a05:6e02:3c04:b0:430:b6a0:1b6a with SMTP id e9e14a558f8ab-432f9064bbfmr5094085ab.18.1761679643364;
        Tue, 28 Oct 2025 12:27:23 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea946de41sm4714939173.40.2025.10.28.12.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:27:22 -0700 (PDT)
Message-ID: <91fdefc0-c79d-49fc-a2f1-ecd650ede4d8@linuxfoundation.org>
Date: Tue, 28 Oct 2025 13:27:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/123] 5.15.196-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251027183446.381986645@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251027183446.381986645@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 12:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.196 release.
> There are 123 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.196-rc1.gz
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

