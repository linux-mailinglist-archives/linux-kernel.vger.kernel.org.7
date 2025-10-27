Return-Path: <linux-kernel+bounces-872610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6D9C1191C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E30D24E36A9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54416322522;
	Mon, 27 Oct 2025 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoJFj9Br"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533121F7586
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761601235; cv=none; b=uVh7ssqBDM/47cdfxRgJ37Ila0bTGoFOZZGQiLLa31neaUgtoRLcqJkTyNbbwqKeuXq1SPOT+U6+eZ9kfinOXtaaLJYq3TTOqjzt+afJ3+saMX3LcRCAoC3ZzMDTUSMsAKU2fW0GThw54C2A6MErXQNZIPmAsbiymm/oZoJfOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761601235; c=relaxed/simple;
	bh=p7tIlPXsYZ5Avel+J+izx/jHKu3N4qM4abUQEluRedc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uda4k+BffMMdNXikmQ2nRTry2NnssuM/JKmpeH5W5aB5vF7r5cwbY0QEjZNdwGTICm2YEUIQtmm6TOIgZgmGAqcJZoVKkP5IKGUdLVoiBzn2y2u0iEkSLP3oU3ndDUuPU7uXCi2rqQTmXCmYv7EHVcH3K9MAStLAegVJLGxyp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoJFj9Br; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4e89ac45e61so50331831cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761601232; x=1762206032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=omu87Ze+GCEablLZ5Y1kVHweKQ9CM76WnBDADZ59AOg=;
        b=PoJFj9BrUNPixQ0Rrx3/GAtim4BqYW6vxIxOEHRFp063fh1ZBIJ35ERMGQvqLMqq5M
         G3UN3jY7tdvSsg84MeYRVzeZmvCfwxaKZbo52nQgFJoaYyVOHLrybq1M8m4GlrRc5Vyl
         YCiEvyFnD2a+A2IjM0uzIwr10H0o/FTGD7J2IT7F80WcKjB28xCV1MzUYv1SgG+Ar8IG
         sqLwlCCoKQPTHDfgPj/GnChfOlgd/YOYI4dmVv/Pl6ciunkAupUjo2ZAgXTQu21Mxray
         YNOeFL70HAZnSLWHEiyH+nEgKdxoo4YGXtvXAcb+GH8Mch7zA+qDPkQq+YazTt5UNmfV
         FZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761601232; x=1762206032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omu87Ze+GCEablLZ5Y1kVHweKQ9CM76WnBDADZ59AOg=;
        b=tgttR8lSo+ipTRmZkLM+WQaiIBDE3EdKMBE7PFLlnO4VbURzjTc8kobv59tX9nE3lt
         nfOO76EkszBu+XlfDAIDWCu5U+C9Ikt8taGjl0se8ylnZ74GO2fvxyE5A8ZP9DgqSZMc
         NFUeIVnwiJzB9E6XLg7aQvIyjdvqw3BgoHoMnHeVKrh7ZOWVbSMFbTLaXWeuqaCUkCCK
         w5d3qHazRB3kO/3XnFT27xKAW3wyWfv8dPiZjshxzoyf8Scbs+ngmMDZDHpuWFCtuC1+
         m8MQ4DuPWbUa42x9Zv1mAuEtGha6RmLMAP87+rs5c9BoHOc043avUD7KwPtxv6mkoApn
         is9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJ2o7TowwahQIr+OWQVBT/e1eDVgD0101lJxOTPQSU5UXyXbNHdg65Bsep/mA76rAzK2N/osOoojNfeSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbBFW/YiI52npsPH16L0hObWTwfAuUk16rYNJVZSZnJ3DAE0SX
	cYF8ApQtC+NLRMPLreXqGPxxeTjyzT5nIv4B1l8Rqx6kPVGSy8n/OjwQ
X-Gm-Gg: ASbGnctzD0pvUVbi7I1zNUy8zlSIqVZXaU2/5JtQbf5XR9PssD/aCaAPms1sqiwVmgO
	PPnYbpEh3mFoDDgoTZe2a6GswOMR5iDPGyU5XpSA3tn08I1xHzCm593TCw9hvYc9/6drfguQjbF
	qQSUFvPnUE3ZuhEgC3mR1dBI4fPDp49crRzvSpo21j4O7OtjarXM5YpWdwJjMXdX3wLouFoDhBM
	oLRunE0DjzxGXh4U/UA5N70ZWk2tFz49P/D8yITWrDM00tTdKxmSAjHKAJKjr+up4dZyocods8Z
	AOTuAPcwPAlc3xfpFLSIGuEvkITH6285YtlCj/4YprrkB+/g9VLJ967pILABh0xqDLBkMBxkv7i
	nDgIZWgF+7bKrxTpv/LHmpREBq6wcwo2F+ED2f/mf9Plg3g92euO8/ykvhx5OMGwF8B9MB/lQNo
	OFLuNMsJzfVXFvUhUgOMICVz3E2vQN2d6/KFjqYQ==
X-Google-Smtp-Source: AGHT+IHRMBR5sjtlPhpv5oFEsUc8g9V/hwydBp726BZW0B6O5IgDfBJOEDvIgpDlBg09ewyz074CIQ==
X-Received: by 2002:ac8:5d08:0:b0:4eb:d83e:2e71 with SMTP id d75a77b69052e-4ed074bc1afmr21527911cf.18.1761601232179;
        Mon, 27 Oct 2025 14:40:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f247fce0bsm679653685a.13.2025.10.27.14.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 14:40:31 -0700 (PDT)
Message-ID: <47ffcfe3-f9b8-457f-a336-bba4b7977a44@gmail.com>
Date: Mon, 27 Oct 2025 14:40:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/117] 6.12.56-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251027183453.919157109@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 11:35, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.56 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.56-rc1.gz
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

