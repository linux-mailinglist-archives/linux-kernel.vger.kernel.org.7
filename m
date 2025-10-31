Return-Path: <linux-kernel+bounces-880782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CFEC268C1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 19:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DCA74350004
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40531351FB8;
	Fri, 31 Oct 2025 18:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdIBg2fT"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29004351FA8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761934927; cv=none; b=cV5VdEDLch9u18/7l5Zc0+TsVZIr3zuTCETAI5vta2fXRIrD9cpQQg/5NhJYFMDplOx4m3n8E4W8CXdCfTy35bDNULnMagOB4pBDdEdk5Ygvg4tgDGpKMPvPodqurMza9qASaDxNlOmcRJXFT/oCsiFKuiATYR4Px8BP6gJ9cfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761934927; c=relaxed/simple;
	bh=v1UakN9jsJPX7yNaZTbgyP8GASSXUsSW6o8Zsu1ouC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGe8D7E5n705nTNKv7O4CDIOdNdJQZu/XNPsbyUzkc8QelHaYVyv8JS+ruVBBNaypPol4j0oZfsLR1ch4/y0Y8LOUx/+H2H7IlL1kbBPhul3X2KZ5JGr0IlOh/nyvk4Csya4GQ7LeoUMnN0t3z1o9mpyIICk/m2FVB/PzkM3GIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdIBg2fT; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4e89ac45e61so22479101cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761934924; x=1762539724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNg7rFgur4Ks9J4kEGe6V9kXX8sEbPHDJWbUh7qSANQ=;
        b=XdIBg2fTsyB6MmtTo+yrX1t28QOJAQ1pKH6y8hRe+N6k8M/SkISeoDivWrmoKeU90Z
         QqC4Dpj0vFdhYzvJj4oOaqnre2UCj/ps30NNrBkWrbtEHxNlzkmqs77wKwTSVmQG/Bx9
         2PchN7iOPBURnsWdZRnP2J6Y6nRZgS7dz2V00MSMfcu69gzgazzKzUi64sp5hLgl5XaP
         o8CcRbVAplkb5edY1bR7OYzzV94F5aNkf6CFBFcEReUtZNSUxp8WvDrW0kqrjvpBohob
         4a805RH5aybh00MdtGh7yz+jsCsbeUDpXtWE7XGds0wglqZqKUNzxZJAVJBfXYjLUjb0
         pNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761934924; x=1762539724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNg7rFgur4Ks9J4kEGe6V9kXX8sEbPHDJWbUh7qSANQ=;
        b=D8sKnQLiInqSJ4yzGhJwtsHcnmqTSLxcW8yei/8T0XBxS/C/aX+MP1901eXy7Na4wl
         njEfqlwoG+CUA/+vgrBLLdIxQZ/6Mghe/ZrDgKjBd7FYlnqcj935Oozp7ZFti6XIRtdm
         9h2V89bUYWI7jJ9pZ/MXBVrL0uFJUfNnoSn6WthCYPc9VS5wrIki8M5+XqT5gX4rAoAc
         BIssXvAHlkSSz2RrUKINXAM3dBlzduzb27m2hhKcOcclJbdHvTphiEIO70YkTKjLCHOy
         ZGAgRx9LK1WLNfzwzg3AmhkMad8wK2iyr6xBZCG+jMZCRzWez4lNT431iomPxVnUkGCL
         Dp1w==
X-Forwarded-Encrypted: i=1; AJvYcCWD7HVl3p+jBObJ8aXhl8J2cXIU0Eh1epO/n7dlVNgtaMld/oWlgFIwx49T1CBqOX1vB6DiHLkhRqJnjwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy/28fEVOp4eY/l2iFT7FUSS0rYpCS0IkrJs+zD/yRqb82VCdq
	ieLlLqy7V1OQkECTVgMYZddn6XvfxIhY9E56Hw6Usaej544FJ8ApOAQRpt8CXsLD
X-Gm-Gg: ASbGncu+H6wh3taYgeuEPpU3ZwiZmZcCuSOvQGTXQyzZCcUXzNHknfAOaIPTPJZvo+P
	TJLELM6Y/36evBpnM6cngRt2TzddKENTw1z0GrR4ClEDlPje+Xbm0HVwMmRMVPaoPg37GmfJJ1j
	rgOb9z1SRFislmOx8ab4M1FQI7AKPpTRasYHenFAPowPgGuZmKqV4ytOZuh692M0WvMByYC7Nh2
	YiZlRivgvhsMiDaD04CKO2j70pC+CeS0m60xjhN0uZ7F6bEjK+zIRVIVY3NHDRp1xA7FRq+8aIt
	YTZ/VJu8QJRqqRu+EP517L+wLKMbnF97rL3ZaXc3yzA/Cp8GgYK4IZvS0A/gbgU5t3gk17DBtTw
	b+pdQgiG2JpzVAwH6KkU/fgS5wn4dYPrxCqkDz6vGbPIyV/MAvnw46xFSAH4XYFbn0xW2qeCZYX
	F/rC8ejzQhVCM2PfMFVfgPJ1GqUSmA99xgFRywuA==
X-Google-Smtp-Source: AGHT+IE2Y4cl4HdAmAnO0Nju4hog4gnzrMfHzCSqMbr0G0SdGHuWH2lYj4xE8ZKGSbOxQrsimKrLbA==
X-Received: by 2002:a05:622a:424c:b0:4ec:f285:4256 with SMTP id d75a77b69052e-4ed30dcaa9cmr58851571cf.25.1761934923830;
        Fri, 31 Oct 2025 11:22:03 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ac00a9a851sm153268685a.20.2025.10.31.11.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 11:22:02 -0700 (PDT)
Message-ID: <3305be28-849a-4892-9f62-706d6faf0f55@gmail.com>
Date: Fri, 31 Oct 2025 11:21:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/32] 6.6.116-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251031140042.387255981@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251031140042.387255981@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/25 07:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.116 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.116-rc1.gz
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

