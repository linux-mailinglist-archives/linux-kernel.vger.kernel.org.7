Return-Path: <linux-kernel+bounces-848848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EF8BCEB08
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF463B32AD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2E5275AF2;
	Fri, 10 Oct 2025 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XZSWzrsv"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3E62737FB
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760134874; cv=none; b=aNA/4G7w+AutW5waw1VjlEe78L4RuGh0B8t30XL3vdMSYcKwPwaavJ6Lay0vv+SlnpXDrtJIFu0KpmuNcvrJHzeqeEo1TgAVnBGaZBahfo2rdYiKpg+8yPlPPBUkD6DUfaWDCkhRR89VbsPdx490mrFYmCzpXKtVrjM6kG97+lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760134874; c=relaxed/simple;
	bh=ArQy/aBxepqtqZjpmtkPhu0y/QoRlipcXP0SdEbn4mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kL4Y9sYFujIwncjfrGAM7Nh8ChR1bmQyZVf+H3mWoEGR0gMyIiYZdqqHyFG/6gIEdSiLcbTS84rtaDqZExvIwg3WcyGXJI/Lp79IOid4pRKAZQ5QgceaQ71RjZN9veop3CAcjAOX09lYMEYkMMZB9BmRUmWM/UefXl5sFvED67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XZSWzrsv; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-93e2d42d9b4so28555639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 15:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1760134871; x=1760739671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lx5r5CLrhF3bcMJ0X7SPGFexB90B8MChAA3VoqSyKsE=;
        b=XZSWzrsv0Gff3MHM9iLJdOyG2WIcR1Ykh8ph60heEVADzB6nB3XxzOpD8Su5QWE7Qm
         JPWdXoLPduxj4dabnGXPPQufFlparqmdIPVRVQrfnRBPBQEiZIeDFQ72Mo6SsftD0bb/
         YVXWz6BAVoTNBk2t6ZYPvb/h/x8GQTkexnHbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760134871; x=1760739671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lx5r5CLrhF3bcMJ0X7SPGFexB90B8MChAA3VoqSyKsE=;
        b=htqC7nx17P6DZ9umNCESP/rRslYnHp7PXFpg6MsBiHWBc1ecSuiiygJMI6UmvMY0Zq
         /YW8UPc+33xgJ2w84/KlrK+7TLUES/Cu6eMSJ251lCqjiPhlwUM9TJw5IS61ID4JJkmW
         7wA9l454usTQ/1gx838ZCrsSQ7qkwJizcK1kItBJK4TKUsgp4B19cVRVheNPmClcP+RE
         /YiKS865cNny9ypjo/ABP/uoVHyX3nCMiemvThdXn/Mgq5zHHYRnD+/WDfqb3/361APU
         a7dbaNyZG73JH64jdwbNewJDB2MrnOM2UstYNHt5vQsXxMPOLtZTwDjGCkadmwlRTYGc
         o2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcps8Rkg4RKO00ly4zmpXUNBYnnxzjosw+z13frdat/GBG3k48dK7BkTxKyxkfJBq52fnU1YSYk3QDr50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0aEzw1p5CbsPzVBhjUcJqpemo0JkBbkMmxGG53mCiA8YMRHiE
	D+LgCgU+hwG9FdMXk6GCA1yVqU86UWjAsfQVlevoMR56ohLfsXVeYRkBgs8IEjFfM9U=
X-Gm-Gg: ASbGnctvAAi+SOTKb3vltm7K438VWw8M8DT6MH5h2h8tnXfSstPdrTYrjqD463sgZZt
	gqmeIzRUFtx03xaoHwUAvy+c+JHTnXcQul7/fIfZ+8YGwCIjLCeworjnxcYmbD426cFLB/zEpyG
	FlwPlFKFANLAp6/ADwbP3Fv7ibMEPkiE1QvHnXSRuDcPXWB5zKQEK0CoB+cxbUntNFU87LT5wRT
	06Ap2a98FbAag3XSe2OZ65/GZfZx84R0dXhP6SZSs4TbVtQXwgJMkPYqVUJjhq4ipS+uxX4Fclc
	d9gkThizLZo14rOZX7RGbUG6BTaARTdIv5n56uHtT+ACTEB7Iho1SQVPiA6/WGLQsMbv18/osV3
	vBg2nGbThEL3UuAWa6fNUKRVnnBbhkhI26QfjenRLdsAQJlY+72oxxKH6w82CYvKE
X-Google-Smtp-Source: AGHT+IFxBtMZTPCXc1lKr5S6PbgrQdr+9ayyIqV8P0135BbdiNaXWyMPA4gEYyZCfPG7eNjUg7lCqA==
X-Received: by 2002:a05:6e02:2164:b0:42b:2f98:3fc2 with SMTP id e9e14a558f8ab-42f873ec98bmr149773715ab.17.1760134871512;
        Fri, 10 Oct 2025 15:21:11 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6cd59fe3sm1310332173.20.2025.10.10.15.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Oct 2025 15:21:11 -0700 (PDT)
Message-ID: <f5fdae10-56a3-4933-833e-fc69a7cf914d@linuxfoundation.org>
Date: Fri, 10 Oct 2025 16:21:10 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/35] 6.12.52-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20251010131331.785281312@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251010131331.785281312@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/25 07:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.52 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Oct 2025 13:13:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.52-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

