Return-Path: <linux-kernel+bounces-896297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DFBC500CE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 00:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E408C34C395
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81142D6407;
	Tue, 11 Nov 2025 23:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VGaGDyMR"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF622F363E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903655; cv=none; b=DnPPDPbBNXL97hIjRht5oU5Cc+ZlZdC0qJICliUYpqi01dHD8nxJx/wBzW6YIyuHzuUX00FcLKsFZUncqW10lryMW8S6t6Etdt1FgVcVjNZ5PmpHJjCISQUmJfULaFApLfrZtLZtK4Dk1TqvK+X4ORfxyeZP1Fg+hGTTH8KayTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903655; c=relaxed/simple;
	bh=IuR5ZRXeBEMrVUdIn/c5gPLOVw4Th37CLXfP2y0VULE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c7Wst6v7CzpgoTq9MGbQCS1/55Vkl4WLbiLoXYl8m1pk7Ne3dl9HKHVMM2BTvULsXn80obzlVAxVtUWGPjFc1OtitYa3tALYsqnWIKpRv8zYgZUYrWRW/PU3C50jbbZh84+e9RqnaK/bXrYGuKOFZRw7tPbcI35Vc5WG/NHvfQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VGaGDyMR; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c28bf230feso192747a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762903652; x=1763508452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O9QgRZSf+qoN7+x7rLV1kVs/iEm4M3TDqxWUlp4O9RQ=;
        b=VGaGDyMRD6aButDGxKhqrpFaNC4Tx42IH+tc6tDuO+SxssRBbvQreZVHaftHULhvyx
         iKIOsa10OWkSk1aUwZ1YpTxzlEykwbYHwF16/SqqotVpp8/VbrtKoxJQ8kK51WJckSdB
         qU7alTRCJZ467+6W6Ya7lN5Psd/oi+KzLHSpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762903652; x=1763508452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O9QgRZSf+qoN7+x7rLV1kVs/iEm4M3TDqxWUlp4O9RQ=;
        b=kX2QM3wrZuzUKJdwEKOjYYoKvT68N/BEK+L9pJmssHgZX9BUNGvL0HMWA4X4m2GwW2
         FnwtuRRbjnYNKUgL+JYmgs3mxu3wJkyfIXZEGcfYOt3LUuYB3XoPUgM18FSLxSXY5mjD
         6SAFfQUl0a+IousTGDN8cJ9qdLLl13Io/7fvHXeYntOAQE8JMPatpHwiiXVWl78lSSgx
         ZIIEf+phSJY8CvgxeT84hDZ35oSpCoWb4kax4f7FlhftEyRd+SDj9DYF92tk+7452+dm
         HF1GfdJW0meS/GQkZfwwkeGKZgA1vVg+GaTFQr3HEPZLmR9zO+BA6usUlduLAgaTbwU5
         lfXw==
X-Forwarded-Encrypted: i=1; AJvYcCWXg2tnc1m4dVv+n1CfF3tnjSLAcgb+LTGZgHsKPnJgBgWnsUQw5sITvili8aYpp82BL0BIZCPXussPAtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvljoiMhZxDGmxBLDDjDe/fFpB1SNAKpmudR6ET41oz9JsHyjL
	lCQXZvm7ryVnxCmMbh2+p6Bk5rA878Xpulg987wkE9zT+tPH2tNaZ70P4l7XZHVZ/y8=
X-Gm-Gg: ASbGncuT/5sr6H5/9yaO5efEHl78TGjK87MNFVfvxgdHhLji7T8qI42QvRbopsjrAh5
	9Q/aKkcClodqWDcw4to5i1gP2UhYNRxNsYvvQ46m4gsXW9X4jlSICptk4PrqAtrKVVnsYFUl1Ej
	R8syfiNEMSRiYAuzpbDNlhKiVKu+sNrRsh5v5szpqwwUn8TQTbqnbCKOXKK9k+mmjnzsfbatpi+
	9Ss/Xl4gN3iTNwdGr4X85H8TQn6PKVxMhFC72odWcWGwBpSpy+AUg38U8MTcEUU1pVyK+xbWr7z
	I4IADEuk5BzBdBo35gUkfdhk9iLiLIxYewzMHHqFcHpKKZpLz9m4qpGYddiS+A8OrVCGgSbiH5Z
	BOcEejcwU2ff/vPg0FcGMAr2fAbfhhqO8ptWEl+2Kyb1+k0KNrSed0LcSTW0q2kUijl587DLc4j
	VvKFZB+n9Udo5m
X-Google-Smtp-Source: AGHT+IHveGWcHvUuvrntsLVRkctV87zv6f2ES3vse/t5ppbqYjXZLjyMUEBBOSX6NbMtKYeNIAOi6w==
X-Received: by 2002:a05:6830:6d25:b0:7c5:33f5:c028 with SMTP id 46e09a7af769-7c72d4d77a8mr807476a34.8.1762903651855;
        Tue, 11 Nov 2025 15:27:31 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c6f0f5e882sm7650941a34.8.2025.11.11.15.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 15:27:31 -0800 (PST)
Message-ID: <0c6b16e6-bee1-44c1-bd62-2c4baa22630c@linuxfoundation.org>
Date: Tue, 11 Nov 2025 16:27:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 000/849] 6.17.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 17:32, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.8 release.
> There are 849 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Nov 2025 00:43:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
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

