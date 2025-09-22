Return-Path: <linux-kernel+bounces-827943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0222B9380C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60CF444590D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683BF30F54D;
	Mon, 22 Sep 2025 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lqcj3OJA"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0392FD1CF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581015; cv=none; b=Uh+Rzfv4KtXNNAeJ5RZbNOJK+T5L9SSkehYPk5aA64oAZOqDCUkRJEggUFISjoDiY2/tbBgcCVAusU28K/3o/+nbtUnH+pLUoihD9GAo9RtvN9DF2yNG0svrQRxYJRJn9X2nBQYwnGI++kdjCMISzF9zShfqqqAHn7wyojEt32M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581015; c=relaxed/simple;
	bh=uk8zDoALOJGCpc6J5qC/9xvOmqzcv8BXgnYFvenDJm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbTp1AmV9QgZoBIUpbGEUoMLdJeHLjCx5S4gMiMZshUaU24JuQB0iqtbDcBTU5BdACIWa9703AhKIFUTNDhmL2E8h4vZFs5x7i9cEMItIEh9toc0uXcI73f8hZp0OlLLEqE13niccZjj1/K9HTlbGbDpEOR5cAo7Atz3XzIeXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lqcj3OJA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-25669596921so52857575ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758581013; x=1759185813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FgCSsQENa288XITw/HVlbMVFXGjqWN4OmK4n73b9eYI=;
        b=Lqcj3OJAxTa5MR4CYygCLtvGJLI+XOAPj2P4Lf8F4XhQXQLZ+RZFFUMvKY0R+u0moA
         BvL0n4Wo3kJ/9Cm2nFCN44z74Of+sw5com8pxjzACbnPGLLp8b8dEsZIDSvWmTigfXhI
         qNMHaeAp3bypzy0UBES4Mcwclo769bTmDZA+UU7tHP/wik7u5r8bBKwpchXMfCD68M4V
         5Dox0Mbg/n1gXBSZjULdDEQeD4TPq+ZCqbQa9cwiJK3Fey6V8gfTjUOntHLT7bIW1N49
         IMNh3pRBZPi61JuO9EArHkkjph0TxtCcHoOf6iknwYabY9yA13YBkB6i2Fyq9sw1kE8P
         EfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581013; x=1759185813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgCSsQENa288XITw/HVlbMVFXGjqWN4OmK4n73b9eYI=;
        b=VXTcjZ3zwimprtKfPvUUfYmEEw9xfqKQjFAMF5CRrDXZy1cZgSiBawMgiqvySdN46T
         x7qgiRLjAv3ICjo0zYViCKzbzqD7GOPo3v4f08ELbLf+Vy4oF4i5M6O2x7895YdRqe5B
         lUymJrCNLuygEf5CBIZEpXYfocS/6X1086yDag16QijtWTh02EOBHAg6pf6fbWS0kyRB
         Ha5exKY2vRKZEQYd7L0LWI+XfNFS/u8yiQ9pn+Ss6IJ2vhECYmRk07YT0tZ7/4b7JLSK
         6h1ulvhV/kzIjKJ1JEE+2IzzuMDME4vbs5qz2d+qrdqNy7FhaK/AdQUOyRFqqMVlSPmE
         d/UA==
X-Forwarded-Encrypted: i=1; AJvYcCV+j4VIlQuglJuzwSLX4Ys0psy1yF94q6kJjGjO5Q7rYEmw/YQ1w47Sx2lkN72teK3QnvvV9Rk0iNS+CjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY6PzYxXnHHCioVEf+CYiZtU7xya1IXwceMthuCh92RKweLh0H
	/DfvQLJYnI/wHvscgGUZOAkahqnNaj3g/NXZWXxTforQrmj6G/a4Pcno
X-Gm-Gg: ASbGncs1mcwLSQ/ZNL+iN53q6OAMi5dKMm/Wa5/yaHH7Z1Ugih97hGxaORO6WGpBl3h
	yJwwmsTn8xTMcfzxffepT46NygdNcBDR4nxPNlP+CU9QR3qzYU4BY0913kxUz4sD5ZBHbVZ4JSs
	fVPK90KkqKErrtN3R8xtdwM/HKUvx4r+RolAitEQnGjAIX7euF4KY28Ml1aW82nMncJBixtLDrP
	g92ez6FrdTGjX4WNa1uHxPer4dJCArATrpEvGotRWFuCgwaNtKPfwtPMwnEh6lpUsMUwoCK3XfK
	/Or0k1TsVeUZlqd2UoYabDtWEKiCRBykZRixHqvP/Rsdz06LIiVHiI6KKuxmmRTbcreTwMJmz81
	cyCa68kTQSDohxQCpCUxAKNhc3+cvVcCAB3dx01MxlmRGN/ParIo9KiBR+LdhWMsVNBpV19hC3M
	DISeRjnrjQ
X-Google-Smtp-Source: AGHT+IHIp1qkMddrTINGGwbaE3hOjo0maJ+lSPzxbZ8279E8GS9DPPZ7W4x8rQ3ZYqAY/VwbhzNeaQ==
X-Received: by 2002:a17:903:1248:b0:269:8072:5bda with SMTP id d9443c01a7336-27cc71212demr6761385ad.54.1758581013388;
        Mon, 22 Sep 2025 15:43:33 -0700 (PDT)
Received: from [10.255.83.133] (2.newark-18rh15rt.nj.dial-access.att.net. [12.75.221.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306085e6dcsm14314305a91.29.2025.09.22.15.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 15:43:32 -0700 (PDT)
Message-ID: <96c99d72-6231-40b1-abcd-1d4f968fe904@gmail.com>
Date: Mon, 22 Sep 2025 15:43:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/61] 6.1.154-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250922192403.524848428@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250922192403.524848428@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/2025 12:28 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.154 release.
> There are 61 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.154-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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


