Return-Path: <linux-kernel+bounces-838069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59255BAE5AD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03346326368
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4ED23B63F;
	Tue, 30 Sep 2025 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClYQCZ3G"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A2C26E14C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759258294; cv=none; b=dA3DAXDoHdXIKI5EwFuz+we3+IfSYRCiRmUOp+GIX5Q/xKJi1vlqF93G4C3Vov+XrQgY0CULlEDiZqJpnO3GRZ5ZW7W6z9L/nsmfMkMc16DTZs1qGNHl9beCthu1LH/qayayafP0CNAYymNdsI3LxY0dCCwZn6xuKTIc32Onw4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759258294; c=relaxed/simple;
	bh=dYdnX8ie+JZ5tjHIeJUYzVzetNEwv4GKCyotFs/b7is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsrGklKzeqNHLijP2IZhKO6e+fzJIUbD0jCahiWuBIlx/2ovgxAHhIDxSZ1nI89o14uuNHacNsj2RmSGei9FUzkD+hNL3Ity+w49pOfLBcyFQOjF+6LhZlHPUpJBTDYeQDMHYnxDFQXVtlxutDsSJlPEnUIaa8tRnvnZ0yD4G5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClYQCZ3G; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32eb76b9039so7394797a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759258292; x=1759863092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ve1C6vWoOmZ19F9zqw9yKxDVhyGQuev6ZjtgPA7WGW0=;
        b=ClYQCZ3GOKhgfd0fxt+sXykWn7UGBZ8MMK4UuuOpPO5gsSUcqDfJfOeFpJE66WqpeH
         XapUjyMvhA3y0Gmsk1JY2cdFTzcxeJXqxFMx/Ugkc8WTftsnt8wBkrPqADol/tT+EHQE
         m4VwX+WhwJUx04BYyDfH0NAWjwT6hlpbAU73yCJChwe9/Esv/N5GV31Zl5Nms80VTBm6
         85h/O5LQSAGGBh3GvT/3JyKaVM/RlLvkQKb0xFhuXxAegtZzG3IX8dvKY4Z5p6a8QZta
         nCrn14vLLjO5SDtosNmpXjNFzrUByXycUc8dQpVPKNbd2/ojLlDnR7UTAnw/tazK27Sg
         2TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759258292; x=1759863092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ve1C6vWoOmZ19F9zqw9yKxDVhyGQuev6ZjtgPA7WGW0=;
        b=HMqEaBYDwxPj7PBwxVkbg+BHOHhaJUtyDeCYXDL/0qS9KWCBc9CyudJXoYakX1k86+
         pgy+g0OUtGrEcCc6yPgfP/ecr895KkC4ErKMtkAlXIWD+wUjq38SnzpnkvjAA4og4J9p
         odhSy0Rzzk1N2bNRbepazwIouBV1qU7aQj48/Cu4tZbmKHQrnmPw8CbA7PNgzEidnoFS
         ar3UZ7FRq0/4FqzxBVavmU2CStAziogxgtsRbGi/Evr7VDYSeiKOjpuPjcQvL3H2GdUF
         swAEfCRlLsf4DH7y2Y304QUn8Kz/M1CEuEYEPAEbtcg8OdmLLYdImcTkdhzN+prDcsVz
         ENaw==
X-Forwarded-Encrypted: i=1; AJvYcCULySlX0r/CR8n6IWhzjXyFimknLRUb9bHvZAkUkhipAn1Mb/Tt/WCLe7k7NHJozq4uEqxMMqOzJgg2BgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylFCTdNXP3OeDCVDjjwfP6DkDmvWrtHu/9EMCdFg9Q3FEoA1Vq
	moRFRrfn2IZqjfxBOAhxGzg/8WIdnSCvDPjEUeYiPTUXapUnoRCSC0xL
X-Gm-Gg: ASbGncsFlkSbs2KlDENE2GDvo71wAzh5bl2UA/jM79+GcEm4Bfd1C/yS5T08H6tZtER
	IPp+4iwSLQMHrTpydaW/NJQDHsvjwQ4HtBfHcC+GrPo/1qOAFIzVkuXEuoRJV3Thf8/XbK/0aM+
	7fCY/SaXkTZmhL7kCfZW5dYRJGRDAh7/LthwWf7ixhCZJlI2pkMzH8xAYVPSshRMJ9nRL/mhltE
	GKN5llLa5V3BPiAZOWo1hTYKECs4yuaBRGj8AwY8GsapzoWsRPIsoUys4k+7g8xe6Q8sE8AsXvq
	hoOWQoE821Adl/7X3qpjuza0k8vB6dOVXY7nfwaEOsJq3paLUSdkw3Bw6vkCmsQA2HsXOnApybH
	n5FKHHrxZcnzH5aC5No7CDZPsdQKV2lSCjJpzQsx8FLa6G81Gc5gMi/ueBgAp8kZJbxRjsAH2hg
	==
X-Google-Smtp-Source: AGHT+IGzLc1/Ztb09xi04tvvcSj9Kk8hLB6B/Dp5tfeybrmtI9NtITB9D3tx2zgrXWtztj/sQ3lA8A==
X-Received: by 2002:a17:90b:3e87:b0:32e:6fae:ba53 with SMTP id 98e67ed59e1d1-339a6e265fcmr637049a91.8.1759258292367;
        Tue, 30 Sep 2025 11:51:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a7039cf7sm248164a91.27.2025.09.30.11.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 11:51:31 -0700 (PDT)
Message-ID: <4478eb84-a8e4-4b3f-8cfd-192fa0b8e3cc@gmail.com>
Date: Tue, 30 Sep 2025 11:51:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/89] 6.12.50-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250930143821.852512002@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250930143821.852512002@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/25 07:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.50 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Oct 2025 14:37:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.50-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
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

