Return-Path: <linux-kernel+bounces-827946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9079EB93821
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 00:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31F819055F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511872EC0B7;
	Mon, 22 Sep 2025 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC08TBCY"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3548B221F00
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758581314; cv=none; b=qTLzwkuspG/kEtvTqWT70g0yWzmZGG3ImsbZfhzd+CaF4svZam0Ov3t3Sm1ui8H8YDZmXmYtxn5odf294Ra50EmZYJs3ly60dTQKhqPP8BNF90VueY64Q2fSFh7sEqJgvkfo6bUa6UyboAewjEd3orYMz9AKaBFKDU949ls2jpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758581314; c=relaxed/simple;
	bh=2Z2tTtspoe5psrZmrmmvyzFTIj55orHfEAQOmXO0Qiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBDX+eck/XPl6QVUFHruTY/2JZcv7uvxm8qFS2tnJ9FlGOcnOAnPE1coM0e01F2sWJrQ4FBdKryu2Xx3D77ivXLKXUg/ouVLI8UIWfCA3JwgDLN07tWDr53tG118RMPFMoXjxNUjX8PUNQz0WOvSy63Y6fZvt7zORTOtCIAD+AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC08TBCY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-273a0aeed57so22707745ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758581312; x=1759186112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLU0RdHoW7PoANfhukGPTAXKBWaFmMBiRRNW5pcWh4Q=;
        b=HC08TBCY4k81rro3sV69umSmch0BvxfIBsTpd/o/ELCU9Od+LjVmxzd3uxc/F+TZEH
         tvrt5KvvgGfTO2Bm68j36Lh6IE2lHA4Yc75MXG56JySVWf65+6sWFX0IjT/2gbBsTHOD
         p/Qj1rPLExJpMv8pf/RIn8McciC2+0dMv0uRj0hXeL3yivq76j5vnDrA2p5RrRF11LTS
         WeBv0lSmjGBAoH80PNgHJ7i9GRFdeKRNe40SrzMJB4zdGlDGAOVo0PDFxkhmZ8Yx7fwV
         +mgJvM8CWSr7N6/CtqJDUiYrW3t4cwohCZngNpVTKz9tAUS43wtjkBAXlWEtvLBZ0M4f
         iURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758581312; x=1759186112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLU0RdHoW7PoANfhukGPTAXKBWaFmMBiRRNW5pcWh4Q=;
        b=g3QyMf39awefTQPv0zjvWg6In3VVYFojjQH+SIbqcBYDIDOwPI5ZuOdfRYhsfTGYfa
         gL6tttK1vay7ZwnA9t3ww5totC9Dhfk6V7dfXKdXlMagvMrVJkKRrAFkKejOiKkwj/E2
         pH6IngVfdfnDoFwqVVkw64/nPZUFPQnk+47q8BpeMjoOsQz8nsxsWzQFO3urqApsxc+0
         VhZNkIV2RFRyLxgWh5Jip7veoE7L4Ak5SVhxgzndp/ZJv5uk4p7sGPAU0ilC9MJwkO35
         9KWOfNT6c3A8p3g0ED9Apa42fD3btWLGBDZvWZYEVypDwZCgsZ8ZJl2hWPhISwI8hYsm
         WgFw==
X-Forwarded-Encrypted: i=1; AJvYcCXU2G7LikheTLmbwGqK2CwETEEu9SmYrvSHhVsCNLjBHg9vIy8VZAlg1AGa8ajA3c92+JdALyHngEEAmvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyvsLpNUKfXmSL8s0nTFKmo/B11+/XpvMoEWnv585z2NiC5nwt
	MDPkeNhSki5VNAcadtdWKWB+wD3C0SU8ISCxl2vR49nOVJ9KAjqmjuxC
X-Gm-Gg: ASbGncvTkKgMTuW2amPBUOTF559wWyyl5NVilz8lETfpb1lZsK2jqXIpekOcMAMRYNw
	lP9zGpwqv6fjY0kwNtYhVJEPZpyvA9YlUdyAsKgWHL1tzahsbEwn5sv+kPp2IwES4SZGfviF02J
	k9eS6fYFC5P1C93KpqROefK/E52kt+26IqEFSQdzVSGeluMNt+VcLsNX0+GsXE+fcBkrTCVuOUB
	ePgYBryYbQTEoIxrtzWAJlh2OwioAmmO53b5Fe7Xa6gkMsRIsi4u2QsYRT4byhY02gDckNTIWeu
	AR26sIEAfN3+FTD3uUDSkADqIvRWe7z0y3ux39c5Fj8PGncqYIz/BD1effVtJdGu6cjnTHgHvbk
	nyQjPUEY1aQXPFMab46jrjNK8pp+Su0U9kaQWhbLDarglFJcznq2rICIVv9crId+6JO+8Z2xfrC
	RPQ6XL4I9kcl4m7Xvyt/4=
X-Google-Smtp-Source: AGHT+IH+XQhrEjeck5jGys4mBDO15ghzcFF7hUwWuk/zDaYKmd6hNMS+rOvtx2mxlHZTk3VSN760sA==
X-Received: by 2002:a17:903:1a30:b0:249:71f5:4e5a with SMTP id d9443c01a7336-27cdbbd1124mr3539555ad.26.1758581312340;
        Mon, 22 Sep 2025 15:48:32 -0700 (PDT)
Received: from [10.255.83.133] (2.newark-18rh15rt.nj.dial-access.att.net. [12.75.221.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980357043sm140133185ad.138.2025.09.22.15.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 15:48:31 -0700 (PDT)
Message-ID: <c27d2fdf-0c99-41b2-977b-cc9551084fd7@gmail.com>
Date: Mon, 22 Sep 2025 15:48:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/70] 6.6.108-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20250922192404.455120315@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20250922192404.455120315@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/22/2025 12:29 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.108 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.108-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


