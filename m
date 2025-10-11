Return-Path: <linux-kernel+bounces-849312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC65CBCFCC6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 22:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B33394E2943
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616C523D7E9;
	Sat, 11 Oct 2025 20:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EPSOard7"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EC742049
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760214849; cv=none; b=cjmrCWin+5LmOpYpe7CLHKW5JanLAzovyGzPeJuKa5Lhfly7MzrTMmi0YYzTU0c5uubJYw3Mj1meP1ocrko+KCRGbLB4BwHSDKi5/NyUos+HBJNNG9YQPzLU19lGJkEeApPNvrPIEtAMHtdSfaLBQIszO1ymgS2bN1Vb2/cdVSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760214849; c=relaxed/simple;
	bh=uiS1FkGG+yemWN7mZxq5ONbvirHM2tWtK7mDT6LdM5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hI8tw6YTBtAQoUF+CrVGvo1vRPKLP+ZlLOp4mAzOKeFkfwCCxLYtRbEBWpWr3Xz4JmTxiTo089taSU20638WrSLkW0Szk+R6DxpczDo8IqvaAsP34Su8CW6OpX5wJENZt9cNdROTj7IRWmg0hkYF+06s8TdZPEi4GnZ/yY4KsFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=EPSOard7; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so4578485a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 13:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760214846; x=1760819646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A9gwbJotZOCrW+prxIpkEfE0iubkb2OROKcfJ2ha4J8=;
        b=EPSOard7HozLNXnevkjKYErhe6OlisXx+xSomFGnb9Tka1E+Z3tPS5E++bjlyDSam1
         EDZduHLlsCSlHzCQxm1LXnykzSsPdOooJdwJbIRzpIMQVYkyYv4d5DnZcYzTiMjT5tDT
         q3bE5YsA9pHiNSdSn4Ov7gX08hUx3vwlCb6OAeX/fG/0gVnmTjsp+fcCJYbehHXJcQU7
         mJG7BLEBhtI8eFmZkH6Yp1Ewv25nQfps1DDtgswtiDruwUNX4vIA0q+P2XzUeqi2/8+c
         cRsYYfUfuIJ1RKW9YLH43WUS96IQ/flzLFvPACmmzZudTxnOoR+0kjPApNQ3CJrtsPXu
         ZrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760214846; x=1760819646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9gwbJotZOCrW+prxIpkEfE0iubkb2OROKcfJ2ha4J8=;
        b=tGqQcUafzU5P1We2pkgNcSD6NmSVRkFgFHZ9ICdVD4rSH0XZJPuaJeyZEUPGqBiB5Y
         F6aQnWXGHjvZmT1veDDsLDH8OLQIoCP99/zGgUTHuwsWmOKMc34To/5eAdMoXqc0bqTv
         7dSgSuxCqM/Vx5PfOx8wftX7FC9qOFha70vjvgqChCqN6mWgcf5SvM9S6adZytbPhMrn
         WpaWATq6qEZsaXzi3vFkSBhz6Ewb/phgrdBdi1zJxOBizQQAEx5RxYqzg6o6e+X6aKQ2
         jcGw6b+Zwi+x3/6UtqMKlJUx98C7+aDUuS0GrtkDndqudJL2hJke7FF8EfwsjEoJnL4e
         e7yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQSHZCEbqW+sDu+fuN710dkQDNyAvWZR91y6O7nPFTZBbdaJ768Ev6Gn9F+r6Nf2WBtez4DabT9tQzh8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWdkLaUduIdHBu7F22BmgHgamB/7PB5M90KVgFzUIXqzWY56kB
	rQNbaakyktTRuboOwUSWEMUCrAi/CXWNIhdhxoPMByjm4aLN4nnmNt0=
X-Gm-Gg: ASbGnctuIsRjqwM21znQb6Vpm2rkT078jXPF0xbm/WDjLtFMoaLjv6qzj1cZ/mlGSOP
	LxyJm+HG4YhjO5NsItoU9zz39r72C6DDxtKo+g2qllpDdj7IA6xU/XQzXUvjP8KNJOPd2nLbram
	cwntxVX5iha8YTwafh+/PkLfekGY0sUnopWVQN58GEaomxmVTNlhkjD871N9nPnm3PW6Xa2tzOq
	pRieYdcGuttencOHwnoTLBdx01tXSXn6XJ19qfuLOCnB8nkG785376yLMhsF78MYWbG06vH4sJi
	uzTc15lguhkbfR/l1ANM2jKv/2KI0qMmGtu2VvjIuURmvJaydb41pQ83rD/k1PNcYtb0mgGkd2P
	Bu/L6Txb1rAFrwmsyF8XJcW5hkUV5WlaYRuc6MTl8w/5z01xTEpMXUrNpuFHJb9mtRGRV93qVMq
	KQFKSJ9WvJAf7yVFrYOA==
X-Google-Smtp-Source: AGHT+IFUGLVBIVIYHcomGPL2XT0ezPYzLn2d7BMGCM1cqedqmfG5bPAhYq81N5HIov9FmaMCMAxvfA==
X-Received: by 2002:a17:907:97d0:b0:b4a:e11a:195b with SMTP id a640c23a62f3a-b50ac7e7627mr1567961066b.44.1760214846173;
        Sat, 11 Oct 2025 13:34:06 -0700 (PDT)
Received: from [192.168.1.3] (p5b057b9b.dip0.t-ipconnect.de. [91.5.123.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d2ce9sm557575466b.35.2025.10.11.13.34.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 13:34:05 -0700 (PDT)
Message-ID: <50922be7-e209-4578-881a-16a533470e8d@googlemail.com>
Date: Sat, 11 Oct 2025 22:34:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.16 00/41] 6.16.12-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org
References: <20251010131333.420766773@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20251010131333.420766773@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.10.2025 um 15:15 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.16.12 release.
> There are 41 patches in this series, all will be posted as a response
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

