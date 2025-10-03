Return-Path: <linux-kernel+bounces-841589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19F7BB7C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F8719C7846
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517CA2DF12C;
	Fri,  3 Oct 2025 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="be9g4sgw"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B4284B2E
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512774; cv=none; b=eFl+8tuEq4AwE3+CsldnvKHdVHdcGAbKu5TrBZ8RQB4pZttB2cR1yhMHe3v3Ptu76MpU+0TdVNuFsVGMj9+25qmKG7q760r/CKI7x6pZfYore2JHMomUV6RlB6D+uh7kHq683inHO0zzMoyFE9Ry0fXArUuBQPv1S56r0EN0Luk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512774; c=relaxed/simple;
	bh=/zWwxR7jnhgT3e053y0mBHqlR28r1nG7om/4xdmHk2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iHqHA7bxgNe6JE4TEnOdfALZNq+0q7PkNqY82IChffzctI9eO3K62YiOuvhL5xOUo3cTwuyE3R0MMii4XNeg/905o3CIy+05+dDFMEVE2Zs3NOQ7BIKDXBI3bDm/F5mvKNAw7IHe4XiHahOHm9UwVsZ7FVAC4L85AhDEFM1mfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=be9g4sgw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27eec33b737so32514555ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759512772; x=1760117572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O3q3kNPw0ApKhnK7U/kRjsM4J9QuxzhyjRkD8O9PFXs=;
        b=be9g4sgw3LwzALk+si0aeSPaAXK4PW9AbVh0TS/6VhjC5ckcPzOSIhxYlQXKLR4bdy
         AbEukLjWa/LWxFE6JDcwYlDIeXDexr7gXaOyfR/eP3YukZPJbQuLnM/QxaGMTplghryc
         JBZyFgOjz2QAqYDOFHwexHlKDJDQOzd0p2XENTC6XoW6GqswgW0iEfLwXMdx4SN9fZQT
         zKX6l9sZtnGe5JEAqBzYg3VIzTjasdpELGZ2+x1O8M3kdofqWRxms7ndSdHNraI9j1KR
         c3yJ7wyex6cNqNF/6MCdAL4GMwjKnVvisNOtHWbNteONOMREA7zDplCf/Q6SxM+7g9rq
         1rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759512772; x=1760117572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3q3kNPw0ApKhnK7U/kRjsM4J9QuxzhyjRkD8O9PFXs=;
        b=M2FcywVwGPFlmfR+lA+vgfQspMaS9Bn53tCCZxVzTYhVyrjSe6CVRdSah5a9JB8tuu
         n6d+/CTU0eNSrzJ+076bZxjcqKvEx3pgb1TT3Tv06oZmTfZ2wDSfabBJv+6KxZ5jou1D
         hSeKzCp0LpjR/mVy+rmitQOTlAziBykhukMIicAKBEFF8yIq9Px1r2XFLpQy5CbCj/sT
         S9X/lt7W1RFDUukKlgrIk+v4V8qPY89iWXqUCRwTb4s9pLoEU4zAHoP36BPW3e9UvJ2+
         4ufpg/4T3sYaYZ9tFxJ9VVmNrxwWAn12g6jz5WAcMjLVfbIPOaxptfvnlsXjgSquckUX
         Y3Yg==
X-Forwarded-Encrypted: i=1; AJvYcCVcn8ycUIg/Lor0159wxLHH9CWIJLLRRj68DZT07IDdDueKEhdox2o4ev2PvBt1epsiWbK85YUPMYuSG14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDFECzb+lLnfyi2VHTnalwekrayZRKXNRqs6sEK/vqJdMocQN+
	dUhuuTLaCo/J+u2FAu3o11LJvDhnYUwdtJReabYRPAw9kPt/5wdUyyuc
X-Gm-Gg: ASbGnctmDT0d1tD83o8xs9WjDUFWtf3ckmyjbAm7JQ5YGoZ0L7Vkn0jiaqR8YAtw/wU
	Ton+R+0bw6TA3qHL9+lS4kadIqdiDyP4CPjI6iVCpWejHoOojE1E4kRIcDXLxwAP6aF9gIzs9PL
	IXj/qKaEO/Cy8Y1EMCB4nivbgWOiyKDdBRJo60sUTQiVlHMoEK2MKYxhlcBaIXjisYtmG6S83qY
	Tpf5tDPPEPU8ozlcpyIdBTivJh/y4JnLFbh9QirE34A/qjHq34oz89t8MR420lSfusx2HJd8UKI
	NAvIV2z9t3P9Lp4tkbeqooNxD0tr52ieR5exMfM/EXPAzuzfLqLT3kDIef8KkeAjXRKG1FztnBu
	azSisljNMeHW3HehK+e0lcPrMC1dwu3ArYj5B+63iK+mc6Mwo5v6Ojkno3Ab2+jLJgW5taZj7Qk
	9HEAS+t0nGSvG2CwS8mAg5SCo=
X-Google-Smtp-Source: AGHT+IEhIeNN62AWq5uTx46AyDu8Fa0z9Vfz2iBvkwTa/pyPi6SOUcGwfQS72vWfZG0oq9oJ2p0Edg==
X-Received: by 2002:a17:903:120d:b0:27e:f201:ec90 with SMTP id d9443c01a7336-28e9a5ba9afmr46890745ad.25.1759512772366;
        Fri, 03 Oct 2025 10:32:52 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a34f40sm2756054a91.17.2025.10.03.10.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:32:51 -0700 (PDT)
Message-ID: <08e96c76-f4ef-4504-b80a-9d474035b45d@gmail.com>
Date: Fri, 3 Oct 2025 10:32:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16 00/14] 6.16.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160352.713189598@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251003160352.713189598@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/3/2025 9:05 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.11 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
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


