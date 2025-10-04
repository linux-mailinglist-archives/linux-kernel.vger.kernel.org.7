Return-Path: <linux-kernel+bounces-842171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 093CBBB922E
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 00:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D683C0C06
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 22:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E951200BBC;
	Sat,  4 Oct 2025 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="BpSZrDRS"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433221DF723
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759615252; cv=none; b=XfgTQuC2CWpk7UIOYoP1ArpJsb2+k+Ho14+H7umCDN5PimoeR/qAYjQ22TH1H7T4F/z0aqSpE87lwtfbqfQOEHbmoXfhZNTBtuv9VYLn6lmrB8pm4AQuRWTYCAOXxu3AFpGxzhXTBcAb6CFOu+w1/DlLSqyGmqNh/nNbv09Ied0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759615252; c=relaxed/simple;
	bh=39ur+pPankFd+80RSO99G4yOSWj0ludsHWCXKzCVtlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZjx5X4p84y5wel6hX71w2wHB31Y+ZNq0GPSPXE+7XN0QkMWIjVoeHV5RkBUNUfQLyBHby3TMAmg/AJebXZGCu41C/+2sndz1wDQGtxRrAbTyF2HR4jzD0JHWP3zK0e7v6hEFIK2Gh9Lj4ihnUt/IhZLYZ/uZT7Ap8ugIZin/9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=BpSZrDRS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso22527865e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759615249; x=1760220049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrwePmzvlfJrLd7N0vwxdJyXFluZEkQIm9+cZVTRpyc=;
        b=BpSZrDRSYscWLh4drtk+9bXV5UBSE96GgEEwOKRQ0MsNKpuVY1F8q+Wikn8UyW4eWD
         Z4GosR6wiCDAJK0rlqyg5Z7ygT7IyaMudLErDPFxLqXkpijfQAj8p4oOHjkkksv4pTLa
         Dyvl7cZIWlyjLtopjCfT3ubO6OLVCwunpldzLsrMb4Wi+jz/4JVVcve1L55ix/SlJP5j
         GaqYUi96bNMjBWWWUhXh9WxnwoUSa9LuoZdWemhbvOwdeEAO037l8xHzMLF2oPOTTgI5
         tPof6b1M79cVusetkmhGqXgFpRYHUxP3sQU2L27jTS1nFfogXW6tCIMEcJKHKyokiq+o
         TuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759615249; x=1760220049;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrwePmzvlfJrLd7N0vwxdJyXFluZEkQIm9+cZVTRpyc=;
        b=hbzPixNgjjI2WvOrs7QQxw+LG0IBZvzVvtRrpRwQihKWJ2xkazw+nCduJhQSln7pne
         r608h83/5l2tJ/NIxTD1rv0TkZL2gmP/alzlKtjy3vdd+Y4WYg5osGD5YhN7LDieQA0J
         ORBgj9hJ0d2jiAuYU0ABCewWZogT8wEkdYfH/ZO0m+v/yknqsYLEDFOQxdcFZ3IuXcOk
         yVmNT98aAY7uNkR6D/kvgxVuhJgURlXEbhHu0YW3kdEVrcKPdfpVGnd1tR2PrOP5TEqE
         cpZoaqqZ/o4W9un0+LjF5tpiSDhM/yzYhLeUqwnalfsOXbBJoNPwIIKwDwkYVN4+bBMd
         v97w==
X-Forwarded-Encrypted: i=1; AJvYcCW870ulY4ccSelqeUB2IBhSk57lrnW4jZ/E2nHUplh3mxwELMKEWisenz3CTa1LZXYjK7rS+AIGICHbaE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/EGGWUyEQyX1inuvl7N67UZOo8YtmEdZoGF1Bbse7BBizsopm
	mz53DOVfsOFQfFT1iZBjj/uSrJdwUJCRPPaKoM4374tjNmXGlTA3JOI=
X-Gm-Gg: ASbGncuY07HTs1a0uMJsR/psM7sX7zXDP/kaLYeq8itTeQB9aKFve/brUahqb1dNSLa
	bxZtUH4H+gMLqGy8uAHsAW+ebdP5GwyPIe/8AqzAud8vOV1XfjfbOa0HnD/mep89oCgZ6+r4H+A
	/X+x+gQsAEnV9fz/Ocp8Jl63CMkS8nT8GCKu/Q2NqYcWrMAW+id3bVH8LJ7IzAHj05a7gwre/7w
	ZPGHDfQ9/RAUWUEYXjnMmQOg5cbCHxFq6RNbJN2CPfJ72HWe8fBQzU9fF9QPIw5UFpEV+9+Vjrl
	w+W5/tRboaSDHiKKnbhXhiowIRf8yRrNm4DM1fuigkWDwPdaQ2TRLP8tbEreCVlvpdvkhIWXuFz
	qEdoourUb34x4jHzlTArsSiTMqBKBRj7F326VLyg0wNaZ3MJKVLQuJUb0YZGRLsU4cv4zFNSVmD
	yjlW3qUDdOVTXgr/mMnRxbqAxToIuNSpxDibiHcZEJI10D
X-Google-Smtp-Source: AGHT+IFyYaDXCL4NuohF9rw9FsAnPRZ0lq1AJ4DLezYntd9SRm7tn50dM/xu/3UWfRq51iRwtAzJvw==
X-Received: by 2002:a05:600c:8718:b0:46e:21c8:ad37 with SMTP id 5b1f17b1804b1-46e711473b9mr46847365e9.25.1759615249207;
        Sat, 04 Oct 2025 15:00:49 -0700 (PDT)
Received: from [192.168.1.3] (p5b2acd24.dip0.t-ipconnect.de. [91.42.205.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e674b6591sm156584935e9.4.2025.10.04.15.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 15:00:48 -0700 (PDT)
Message-ID: <0928ccec-c7ed-42cc-b9a8-84b96dedde8e@googlemail.com>
Date: Sun, 5 Oct 2025 00:00:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.16 00/14] 6.16.11-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251003160352.713189598@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251003160352.713189598@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.10.2025 um 18:05 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.16.11 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

