Return-Path: <linux-kernel+bounces-841918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F23BB8879
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 04:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA76619E7C4A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 02:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283BC20A5DD;
	Sat,  4 Oct 2025 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="EJwug4n7"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C191F75A6
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759545627; cv=none; b=PyEpRbGlizhBR05r0UeBQYPYkYO00fV3ssHVxaQmVz22JD7t21JLSxoTRCDhAZFf4uRs8/7VwgXzNYYrISf2kFr62Ocj8YUnU+gdrR+N5dF535fW90muArrm/lxNJ6kY9uW3dmPJ9fsGHXqHzxZJy83WW+gbLCLc7fWXhaPJy/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759545627; c=relaxed/simple;
	bh=WZHBqjpgenWM6lUWOGdfdtHCtjWENrrZy4ZRfETPkw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dd1qjaNHU8Pi0XdZdZ7G69XWfpCoqenjqTJI3nAfryUsXJtn6r5FSE6xcxwO25QFuyxuO3hyrERxcyunQFAexmyxTbBhqHeSh2KHSMzF/sIC+iqQ/Ab3H/JCxV6Yc2bYu+iNDyGK5VoTVRTDJXARUTNBy7LgkhECuUiCfEqEPdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=EJwug4n7; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-4259247208aso18434765ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 19:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1759545623; x=1760150423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfGV84g55Fp70doV+YS/Migev0C/SPjmIXXRQJSXnGs=;
        b=EJwug4n74NhquNF9ckM1rGT08zH8v3vbJJ+jKghOm97IMOT3J1QWf/L/ROLg8sck/j
         x3XI9RzHf4mjtjn+tDqi09F9S8b86maEe9drgLtYi5CN1sAqu1UhN1F4jShmyCbedgd9
         4dnHAOs5CCbqPQQlQ/R8xm52pnFLrh+2ho+Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759545623; x=1760150423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfGV84g55Fp70doV+YS/Migev0C/SPjmIXXRQJSXnGs=;
        b=DGU6I+3d5cej+6P/pvUmtyUmMnv3fqJZLMPldxeYXRMwi/dQ5sOPptU+WQcTVatdUK
         K3BK4wKlH2awGrpJMmXFUBkAwrXScACWMhLJBulGnO+mL0FekK3Nl+EUXs5nYJSeg14J
         ZTDdTK7r3BF7sFTPlXRazHyppOfldM32sJsgnCPcyy6bPF2oRF5wzukBVtKScvGVQe5W
         JgARQhD+7uHc0iQfGnFHBmi424impDC+OIWAPBbMR+vfJxk3uncE4j3+H1zRvZ7BC1PR
         W+MxhAVVUJu1xcQoePlGsF3E2pfyESRnc2GVdHc17fCkK2tqBtbEWqiH2VvNf7dIIOGL
         loFA==
X-Forwarded-Encrypted: i=1; AJvYcCUWWjNz9ljYFgPvdT7qiNaOev1EJVBcFu89ZCvQxHRbPF5RpRtbE5gsLf0oFk+NLh30diRpk2gebLHf3u8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw8eLZFbTn8GuTMhFZT+Qf0Gr7tDAA5djIaRxqg28kDK/i9hwC
	4UANiLsAWKJmTDWR75OVdU50dJaqgPPM/eq6omMQYowauryE4yZOrh8qdCa3sZW55kuBVFbp804
	ZWnEvMQ==
X-Gm-Gg: ASbGnctZhpmBsvN+lS7rwi1LEbYzL60uwhZ87kdsSv42LdXqTWAumFbrzeep4e9L5Bh
	EoMgRT4rNPnJW11b+LwedUZakmpAuuJ/USkqsT0PjcWclTyCvvq7uZGREwo+h8qJaUww6/sAztP
	TA4GNvazb+sx3LPCaAtlImRPQFHWdvydJ1hubmONPMjeSoyp9qgGBxpr/2pTuicRorjGKfwD16d
	uA9vkcT0U4SNQAn+fnx1bl5WYtKrS2eAr79PMsXG/wWmzbeNviggWEYv7ZatEP7Te1EtLOtzRVR
	rdie7G/eQGhMY82nOn6auL6E9imQpcqtdNF/76OL9HB83GZtrOOeOq0+9xd9BGwdkJEClm5+joq
	Tiuiu8R8qt8p5GrSLaMnjlLri02F9IWbYuuqkkkvENX4bDJLOF1XPBvcnM10ILWRbwwuGvB6G6P
	LpPuE=
X-Google-Smtp-Source: AGHT+IEioTJIMNzacqCo/UZFC5W1RrKFxPYXMBDo5m8Vs8tnZCDhSKd87QqfaWpv2/P8gUHneV9Gkw==
X-Received: by 2002:a05:6e02:3e91:b0:428:973:797d with SMTP id e9e14a558f8ab-42e7ad258f4mr72119735ab.9.1759545623294;
        Fri, 03 Oct 2025 19:40:23 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.126.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ec10511sm2458733173.63.2025.10.03.19.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 19:40:22 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 3 Oct 2025 20:40:20 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.16 00/14] 6.16.11-rc1 review
Message-ID: <aOCJFN5CttsqZJ31@fedora64.linuxtx.org>
References: <20251003160352.713189598@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003160352.713189598@linuxfoundation.org>

On Fri, Oct 03, 2025 at 06:05:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.11 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

