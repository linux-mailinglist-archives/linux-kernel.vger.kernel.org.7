Return-Path: <linux-kernel+bounces-766934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BFEB24CE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C26F188189C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081C32F2914;
	Wed, 13 Aug 2025 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VFCuFcDb"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A12E7F3A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097537; cv=none; b=kQOuCXy6pceD6ZTMt8zmgD602WOLJyMK8E0hiB2sPqZkGloepK+5CM1J9QZz4V/A3gC5khV4xk9UMDne7+hR2Oo83+kGjAuzOwf7Kt/JQXIK/UiL8fBC4/orvyHU6Rk4G3StWXvrsL1gbhxZyiGV/0M3cmRGeYfIdrNbqrf68T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097537; c=relaxed/simple;
	bh=3XzWy2tt6bqaDyewBfl3310hnzDoLk8KgRxkC51IzhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhLDtWaEIbgDVDskkJPuaXzTgVmoE8aNzmH0tYQXLcbCMqgDTK9j8Kdqc9PTA97ZNxNhFIl5Cqo3mmlOwZNbGMTgCDnz9c6yhHn5N+JxKwQ6ty6WzrG7sfi577MInrLz7t5r7yl3IVGc2DlWue7luUFo/7Ttg5pLvaPd2xEhsO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VFCuFcDb; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8819826f5d8so38014539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755097533; x=1755702333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bLuxF8BcFQ4U8Ber6EP4PVwS4pfKrMlITaK4ixL0kHE=;
        b=VFCuFcDbZBAV0Cxc8O45ddSVRoWaD3pYueV9YHvF5bsWe/KXYApbc7C/uAfxNX1gLZ
         q/G7IRRFncRdMXvoe3Wr4wDC7GFGiEORwbUiFVJAaKUdHZNqLyKujfyoHqQ8kNv54wcb
         VZHLcICqYjjG6DMmX9Y3w7J51f2brc2nmksDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097533; x=1755702333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bLuxF8BcFQ4U8Ber6EP4PVwS4pfKrMlITaK4ixL0kHE=;
        b=hMgx4VWJ1OJKgO2Soui7yOLqJyjwvZAPHLAiENIHnfG5j9vNJ09UPhWsz9CO07/LOT
         QjGTWb2IosqJkGM3A3UcZ/PdFPvuIotxnWUQNn2axF4usvgK9rxVnqY4UJV3CpORL+JV
         xqntKPsY4C+aYVCcpBq8WsbEbMpAfgXuj0YRnf+queud8lSoKrDxYIx8Wz5g0Srv3SBX
         ys6ZM7yibb7o7sG3oy2CI3FIU4fAZaTTz+hl7GC3R4GBhNQEpxOkrgHw4o/DL7ykYQb1
         tep32zmbQ3CJ0/8w9XxMtrXqoBS8UHm3h9potWk//5HFn9TjAcmN5wtP5IFc+zFQI/mJ
         wlXw==
X-Forwarded-Encrypted: i=1; AJvYcCWHirLvfgzrGSSK9VNlYe3z2frS5klJ4frQWQ/5LpNmdF02SjDKsO4SFFlbIdFibMmpkHsOnanKV3uhRrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhex7sUKIv6mq6lsnQWxtYtDUzLxyywBpBcC6OLBX94i1dpbY+
	BQ3/Vy4lhQN6xiwLqhgwdAoBw4vl4CpMv7fhCySmYJ0QfY9jwZtEXipseqUXv6XLxz4=
X-Gm-Gg: ASbGncuIas0o/ZhddA+AeDG4Rw/NVIZCzRPl8Xaigtg2gbUiTw3LyhiCGZBrLjW4tmo
	jk7dPyVHiNuFSmilAzU1kWJVFsozF0YHRr6Zbzsdn4pDVvZPjqev5yIWpdvoAn1rWFPzmYDsBw3
	YWPFiQYqX6iYVz/XnvDf7GVJMKBgcSDeCTRa1adpoO4CyFH3a32YGtcvvsrn7IfpMNjpQvCM93e
	flSTi07jhnLLpYWKpXVEL7KfRytPtLrvZ5perX1nI6fd5uRVYA8uN3SftfziTkiXGICL2LaV4y3
	b8QDSI52IV5VBiRaXfdcc8MiygGjAIN521AtLbK4neUE/LwOMRH23SO0kilJ7EVhNL7IJ59BiJD
	fyKN7Ghj0NTNJELVvZ0qaWBr19bSQdvdIGA==
X-Google-Smtp-Source: AGHT+IGV/ISII8H2LUhsvrlcWKzdOlv0auQmk4l8zj9XLpqt/+BOLYq6RaNdUSrvqV76pSjl/LDVlA==
X-Received: by 2002:a05:6602:1651:b0:881:4b5e:fa9d with SMTP id ca18e2360f4ac-8842a332320mr450166339f.0.1755097532624;
        Wed, 13 Aug 2025 08:05:32 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-883f19d013dsm448497339f.31.2025.08.13.08.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:05:32 -0700 (PDT)
Message-ID: <173eccf4-5613-4899-a3d1-1931379ce09b@linuxfoundation.org>
Date: Wed, 13 Aug 2025 09:05:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/25 11:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.1 release.
> There are 627 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Aug 2025 17:32:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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

