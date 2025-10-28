Return-Path: <linux-kernel+bounces-874224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBEBC15CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60E0460589
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A034575A;
	Tue, 28 Oct 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJf2QXDc"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9FF34402A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668444; cv=none; b=pbAj1b58Wvq9iu1s3005hjcuYRWixqQCiL1jtdNk4Hc6g0Qt2K7RSypB+48g2VrGUOmzb4Ipyc+V5OG8WCgJvqs/lMB4ffyw4NJe2ZBaVokyAEU5pWUmifOSiKWSMMWF4GKIbL/syZVO10RvqmDkK1bj191PMv41IOmw7LBgWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668444; c=relaxed/simple;
	bh=HH99Hm1/4ME4y2NVT7mTUovpgSko9sHLYoPoc4qGOcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qm7X2fPL9MlTs/pgCG/XEtF5PJsLvk0wwfrOmyvPgG7k0kmHUpKcQgFmRRFcWE5P4ScapNIJ70+bwTf8LAUGwd1Oe0tBvxsNl94kRR4k6PVdCeF/aBLEREOY+vRXEq8sUO1ZJQAkBUMGC1gqNn3yfxI+QMLrCNKJwG3VMgMXick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJf2QXDc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-89ead335934so433995585a.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761668441; x=1762273241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBw19L+zHPRR+YuRqFX7epI1wOiSjzP6L9/PKbP4WH0=;
        b=bJf2QXDctUqX/W4nwI1yFSZcT/LC8tHxnnGuquVebCQwCIkzHIxKM62q86yIsG1glk
         dSBDyL1Yn1BRmDbBl1YCagQ9wY3DbB5NYQmdyk/3doCAFz72bdU/hQFLnq2lx64It59U
         //+Onhle66a88C1TButEJWgBySCuVLraBP0VzHwiU5wRoFSB5equLVrPP1DoPBoz27Ii
         w6iP6Uk4foMT9CCQaJE160G4LE7+JHbIDy3X9fp1qANW7QUop8DC4FfgdgOgyXQTXVCB
         YRk1ZXwn+l4OcPYHSZAbcz4s4pSaeD9lB8/KicLNIjPFwJe3oVfVpv1Kr7a4r/DWbKTQ
         +ziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761668441; x=1762273241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBw19L+zHPRR+YuRqFX7epI1wOiSjzP6L9/PKbP4WH0=;
        b=kccSmIU6p3ZjoiYWvDvepT14RNTvdAnBw+a/BtWQKJj+g5mXR0K0QhaQqYIO/jK3aO
         WcAOoqjI/Qk8R1yqt7lxNaaspZceo7lQaX5FjIissfKD9NYiSYoIC4EgSrtURJoUDHZ0
         ulmSoJvLJSV/RWAhajjnWTbA5m74DyGIqKDP/Ix6qMwoAG1w//Xv1Rwlc29lADKCm5uv
         GXKDKcYzCqIMX77OmvlnjjX08CNFMEmwmXEoWgzNZkrnnv4bgZNem5Gbb5rgd+q/NRMF
         H/yJlgfED4r1QcjVieL0XZ7UOEvXLWsfksgUQAHCjUnyNpx4da6boHdU9WIIFcxUXoN0
         i7qg==
X-Forwarded-Encrypted: i=1; AJvYcCXcPeVwwlWq5zHZfi1TO/sY4f/bUW9NurZNn1zH1Sv+c2/BJr+OArnnlIxtY6OYxoKWlhDKbn06YtkVkSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQzLoTu9JqtKimgKo4VHPIkiSCJEHMHSbYvvFq1ubHP8Hc2wTC
	XQR7+8VhVOLISrn/V9ZH4+5X0I5TSgtcukdyKzX43YhoH47FSVPzTyWU
X-Gm-Gg: ASbGncsGAIOe90yEUtmRvhoNzgOSqL/DskBVdrzFCyDPTocoSPL9zFW+tDEijaFC5K+
	iAoxB/1kBgywjju50U8A9iJ65bG1FitapPuUhXZavReeGO3iMk26DUAxL0dk6IeeJ+USifkgzc3
	Yi2c9ZuGmwJB7SeZuuazNVexcnr1gtwlFCwUNuJrX2eF6wYMXxB6jwp+v3EePgZkZiOt6MIZHp+
	vOzFJW92RPGvU5gJTRjAOGT9JnS1HQCXYsepK6L16Fkfe+kmw+xIQAVSUhW4mE4bz6GkMJljr7i
	TKtJJmP9riLatFNbXMCm1cVTctbavjn5oRJ2sYfxbaY0h87jjeDuKYUNIZqB+9BDqN2VTlQfeBp
	ECCTU6z62eWJIMyHrbCF6giM+En+YeYLD8odyAnrBTTyVHgosobxN9mKTF8w+nORw4+xVVTrP20
	q+sqWqMjyQG27Kdf/617m9HI0jLVg=
X-Google-Smtp-Source: AGHT+IFiY7niBCsgWr+WrtN943Z11lRxWOW9j3KP33GiWaN6m/57e17SHj2oKDJ2x2+uveoFhStVnQ==
X-Received: by 2002:a05:620a:4052:b0:8a4:19a:dd5e with SMTP id af79cd13be357-8a7008e05a6mr507815685a.68.1761668441025;
        Tue, 28 Oct 2025 09:20:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f25798ad0sm838599385a.36.2025.10.28.09.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 09:20:39 -0700 (PDT)
Message-ID: <f978f5e5-5828-4556-a9d7-1f8df8bc16e0@gmail.com>
Date: Tue, 28 Oct 2025 09:20:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/325] 5.10.246-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20251028092846.265406861@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20251028092846.265406861@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 02:29, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.246 release.
> There are 325 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 30 Oct 2025 09:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.246-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

