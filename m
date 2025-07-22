Return-Path: <linux-kernel+bounces-741531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFD2B0E55F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD697AED59
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8A1286409;
	Tue, 22 Jul 2025 21:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UPv4UZak"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB19F285CB9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219332; cv=none; b=mB4F+MchyAjTwQEt4yboEV/QtAkbt+6PjzcDpDq/qJ+qvC5gSrDV/6dQpK/61mHpNDEI0WrI781lMxiQDSD73NzUDcndalwaOvfzTvr+/mqN0rmxm2NC2uxub3zS5CJeCruvO6g+IO7YhMKPNxK0rkOOxomTdiFyvDtonLFVpIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219332; c=relaxed/simple;
	bh=kRmeUWYh6EGVUzw8lu1fepCuY34yWYJEXR7sLZcqSFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7q5F3YKvg7empmAhGg+XNi0NlPqlCcgkPdK4vOtdRkG40o7f0p6IYqC9vu2CiX9lfDfOcIAgN8ohTH9FViwN79SU6h0b+GgWGqaQaQawswYHq8Fz0FiQ+S9Pn9gRxaXjv/SWQizT68Ju66KmBjPPxPu/LCgnhWaiKcsoqi3kjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UPv4UZak; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-87c0bb1ee4eso143893239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753219330; x=1753824130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=23EjP8BqsKxCkxGPOHLawUuEVZik+m90LNaYybWi94Q=;
        b=UPv4UZakm5ODu4igEQoGhFBWK+IEkerJnsz0YSlco7+R4/tfTAhGvOFkB3YHk5h5Xt
         nyO3TTkWuMyryGUjnz8FfcrY3f73Nr6Sz5yg8dZdvXEq1yBf9V6HX94+I0Hr1Vi1aebm
         SG8rp1eWRzG5GIFNyBRTAMSlu69+UrUgN6E5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219330; x=1753824130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23EjP8BqsKxCkxGPOHLawUuEVZik+m90LNaYybWi94Q=;
        b=EfQ9y4aeyDveQpSVRHg0EG8vPIyP5gskPom4Pl9951PsjecLl1EP6nP/adbm2UXnaj
         8eysMtROPnaPz/a+f/7KvibwItrgm/ZduFgin+SUSFKBsXqifx1I5/H3Ook5mmw5r3+V
         lKWRy0E+pCH/wop3jrRKCRc/fZjlueVVlH5RNAEvVHHiZVptf+13s6xjKusvWk78euii
         w6xogeU+23HbZxjwDlS8TA4Lv9peCllr8Tjx97Y4DLVG7iRGqARukA3dCe9YmKnjsc7G
         C6X6Vu5RIfMpyWR21A/HJQcaJhzcvOz1u0xLISYHxGESHTjWHe24aJtw5Iwy8y1tF9Bl
         8soQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqr2JzkdG9DNpNxG4+3WNgSOMrtrl6C1rwaFqpUOD0tE/2bjkEOasBUUdUWcUad8enAP1XTp25iyo2i3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoHlua/rtT4Osw97ZKCkyBoiGGUEI5BPw4Cg+BxILyVV68zb/n
	ABCpgIp6VlVm1NzYO1O9dXoXkpK3/8IJH8iOBR6yvZ609ji6OAf18rIhvwkD+Vsa/2A=
X-Gm-Gg: ASbGncvQf2F++4z6eKXRBWg+qNNbmGLMmj2R7AJHi4k8Fq4LRUCX6NSyTjkhSncLgMl
	RXQzXocbCmkjEPXnMfDl6XV5r08pESS0ljG/M3G/pWZHOYfuFRLy7pOEDJgkL8BRc9VoRs86ZDb
	YAfsqcvu/SOv82789SNS9IWfMeIyn6SqDM3ItVL1d5kvYkkerGIEMcp48M7UftwsbZUovt3vw2d
	9tT2WYTDV4eLO7lymhsdh+k4O3xxUzK/MOs2uiFACXecT+lUhRHsaQh0BDnXW4Jiyd+PKoyfK8X
	/xvElTBiq5xNsb+x3oc0smaYv7avnEkSNC0QF+vDCRGj+aUTpsHg1cfIoW9YuobM3MGnYX3Ck49
	FmJJfxSRVaxPK257+9wRNP2v+HA58c34gnA==
X-Google-Smtp-Source: AGHT+IHksoSUIDYhxq/5D669iNhvWPBnTdjsS7dJioKuBS1uJBE8Dnogw1moyMiqkJxW15JCNVn5hQ==
X-Received: by 2002:a05:6602:3a0d:b0:875:ba1e:4d7e with SMTP id ca18e2360f4ac-87c64fbb367mr137690039f.6.1753219329825;
        Tue, 22 Jul 2025 14:22:09 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87c0e1b2929sm322754539f.0.2025.07.22.14.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 14:22:09 -0700 (PDT)
Message-ID: <90113087-cf90-4c95-ad6a-168ec1563031@linuxfoundation.org>
Date: Tue, 22 Jul 2025 15:22:07 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/158] 6.12.40-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250722134340.596340262@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250722134340.596340262@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 07:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.40 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.40-rc1.gz
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

