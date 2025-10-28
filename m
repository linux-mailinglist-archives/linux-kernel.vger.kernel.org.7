Return-Path: <linux-kernel+bounces-874571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC95C169AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A4F54EC544
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AA934F47C;
	Tue, 28 Oct 2025 19:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BAxn48q9"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD53259C94
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761679531; cv=none; b=SrHNK8dn17WmOgMcqN3z3tTbrgOYJoSFOIfq/U3v7D5jksDz7bebivLO22gXAcc7cSXxCK2JAfA6kZhCvdw/DWXUKO5jskLMWVkry8h4qBMndmXQDuUsajcwpRirUFHqcOS5xXrlqxm/Sp+q7nKkv8HWSwaF/tDJ/l69M2y4f+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761679531; c=relaxed/simple;
	bh=6XhqGS0XEGnv3jX/pGKq/NJFCGQN3DL8eZKSvZTExYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJ/TuAze+xkPCuY+P6kpCvzooI5prHgEweApKgutNucc0k//w04VnUpxQrDR/fl3Hj4jDgddDqX7KwecaJX014IVfV9/tMTVgsIOT1hq5J/E1Jm8QQDPa5AKzChJ5VbQs5c7RIE/Sws4l+kh4e0uNBZHIdjicKizAdkUCj+Gdo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BAxn48q9; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-92aee734585so274548939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1761679528; x=1762284328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ntm+pSoGGrTLjw9jSc8czmANZelUc7CVhn/2fFWs9c0=;
        b=BAxn48q9qmIhuzrd1+0qaRlEtIifjez2mnZEjNX5U/pfQSmslrM3AxtA8CX1Cbeau8
         oMRZsJuKPqDPIyN2GJNdC4YSOAKusT3BbgdfUEKbgvAbCrVg2GXs5mdKyCvvVx5Py5ux
         Oz6QOBu14s/weGpcSPjxXzSNlVmzcRWoxCYvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761679528; x=1762284328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ntm+pSoGGrTLjw9jSc8czmANZelUc7CVhn/2fFWs9c0=;
        b=fPRKgtQlsVL8aZFpo4pFQSncIY7Z0CM/7FN8lmjWKD8tx1wtGeoUwd+vWTk11MD70F
         mfT0oi5t5BreT4Sg9SXiuBQefOjix1oY0sJKqWOz7Sp/CdgQPDPy+y682TV4s1zPj3kO
         ttpt7EfGIc+Q5vkzPMh+A3TpDRdo4MvFosficVqwp03f8LRb2tOlrpPKvFuuMf0RrUuK
         hRBaPe/LC+rL1FDep64Fts+ngB/y5sN7RDjPDVpG6Kizote29vypaxVHYlGZ5PvHWfOL
         S6JV6OqOvt4eK+PHtxtBE6jmwCZnG5Uoq7v9I9+c/npfoSS0uHpYwWwPJAlIsyPH8M4T
         Zi6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrT1J8SMnsa0VZ9c96J6h4y8osvYW20HVdHTjDuCF65j6+n783Px9mMunOuyoOe2bW/3/UHbxLRXClQjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQdE7jdhBd3erDCteN93tteAPhEFOM7yeBtypXJDehjESqHjl
	B2cpYRJEyaffmhak0hcqfYDpMo2SfNGJRMVbYRzRlf+2FnfesA1Z/2LtW8Z9Tw56ShM=
X-Gm-Gg: ASbGncvpWH4WG+csQmoxwy7aCoGtb8IdKNDks7L6WxjIYKmn2AhySm8h2Zfl6AOM9ni
	w20kyxAlhs6Xp7pXh3Vvo0DMTXNcaLzoPDjwLocFGrJV8Yg3OWaiEttD6pUHPuKLPPtZpVofJpx
	3pz8qynsnhMFmj9fcmiaUt0M8cSTrNUVqEYyWhX5gBCB8l42qDR6pq4iRZVOe9ZrL0x5hBctZeQ
	brgVRy5cDBEw6eso9tiUE9IELtWXSD7zNwoAqU1iblCmPA233eeLHPISM8welPLYMlbsiF1RLiE
	eAT57V7YVC3fm0az1EZhBsglfOBsC6i2HToHElH83MHJneiSKF7e13HWs2pLIa+dOUSrVo4G0yl
	VimachTA2qB7tBi1ouaynToMgAbp0lYZn/T4NfdZzThgHxTBvHayIH7Qcx1zpcBKUlyPQVVVxWk
	lhZ6b3LLuwSEaV
X-Google-Smtp-Source: AGHT+IFiT3LediOigZFqB9hgXiOho/4NEBYFsscX1ZMleYKnQWVc995iuHoH3hsCSfQ7cCIC5sZbbw==
X-Received: by 2002:a05:6602:1613:b0:91a:695a:cb61 with SMTP id ca18e2360f4ac-945c97f0662mr94211039f.13.1761679528464;
        Tue, 28 Oct 2025 12:25:28 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359e32d9bsm381597739f.2.2025.10.28.12.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:25:28 -0700 (PDT)
Message-ID: <1db89160-7f4c-43fd-b12b-1aa624d9d09d@linuxfoundation.org>
Date: Tue, 28 Oct 2025 13:25:26 -0600
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
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20251027183438.817309828@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251027183438.817309828@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 12:35, Greg Kroah-Hartman wrote:
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
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

