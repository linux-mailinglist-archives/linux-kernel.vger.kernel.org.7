Return-Path: <linux-kernel+bounces-749706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64512B151E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A49418A4734
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D0C298987;
	Tue, 29 Jul 2025 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C65P7XVB"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938A9149C6F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753809128; cv=none; b=YHUVi3RGJpAxdr4Sn44UfVaa3yaI170FFUzZFSD62t6weQmsWfheXWvjaJNcbgvB1/xxHjH4xk9at2iGo1lPQhMaphb8cJ68hZE/wERZJuzUhvuF8Ld398S1pccN6sdxydoVCqiSi4B7az3roeudH7ftnO+t+mDX4HzekioIBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753809128; c=relaxed/simple;
	bh=t7BqUzkwy6YDLPCPlOg5tZ/d1gLUCA47f+uqrjKwphM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oF9c27FoULfImYTApsKgTRc805PnETJNMUgY0Jn189JxmpSKuyOBjQ0JL0y6GBI7al/Ac1lDhn52Uf9NbjZdayA3bFlzVZSCrDNOcEWLFjf3wM9flocbcoPnGcvo0rnFZG8N0UfaBkKDEY7cSX8tNrCw5WWw1gQazjysDF4oS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C65P7XVB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24014cd385bso31283615ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753809126; x=1754413926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGouwviuscU4MvVzPjOZbXPwY1apdTkMc59v81/WQ3o=;
        b=C65P7XVBBfcLnkTRwac9jFBCFHbo/R+xR3f87rWM/U9D8tgUoC+FJdyUbPI+530ppX
         Z5jNP5WU3zLNB5CQj9Ec+MQXyrLH3zx4IgPSNNTAv0NtuxKZ5Ye1/PI5WL6hU3ab59Ve
         iwF3vHDxKAqEgSZCDM/V+nJK2CfUqU2uhAMrA7lOYprRrPXinZkKCod8aAfVMP7xBUfx
         rNvQs4YiiXCP6QvXGUC//J2wIrJD6DNmgbwdnpctk0dO2S+xQtQ1JxSwAKAHzJ+CYPsF
         egt+KDsjgyU/si8pGwTKkJ0Lh3E5q/c8/AP33s6Y17k2FN7//RG3lzLxD6xFRCStiEzm
         ryZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753809126; x=1754413926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGouwviuscU4MvVzPjOZbXPwY1apdTkMc59v81/WQ3o=;
        b=qY/IJE4CgXpBHlapUlCKyS6dXaga+iCMVYWe/m/+MCyQ/9FiMbE4edFaukDUK/Slmu
         VEU4VYUhN5XCaTnp4e7pujS6LMLCW6LcKOb3UgncAe5CdpOakkBw9BaZBGtSVKAzNkXJ
         wtM4TPmgQ4a4TpDnkrI1y5izykZbnQbwYx+xCTzcPtlNXqR0vrDjFQCU8kq20meicvQg
         zZbe+JwMd/rNvZRArN5e2Y5D+es2tuUTWw47xLLAyJ2Ytb6wCBrZwcCM4vcJrVnRLuAV
         p/TKcLYgedKXuTLDioUJ+p1hvzAVF5XowUIg6mGHEHd6hHQGs15/ODeizjGHALGqiMC8
         9QPw==
X-Forwarded-Encrypted: i=1; AJvYcCUE6RkqauWzqvFZC7StcUQQW6MUQ07edhgiyNvd/ZwYEL5piV4Jd/TowapWPbAeWdUtdBbU2OmqqQEgR+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/f7TikY1WlfsTvXzVJPidd9i28SR7siNEUuVm841JpowVRlcV
	Y3cmW7KgdbMFSP0BIw70NI7xuLlwZJBupY0OwEy3Z40cZIjDcln3M0sKRZL3J/QvYA==
X-Gm-Gg: ASbGncvDcRdvNA5VqBOdsUBRzL5LqawT6gHdEsgR8bErHWhLJYchWfdANclI8TyMu7X
	tntVJtkpWO41/OGsDXGV6GJwsTdPATZE1FOjeWU1e1L+xtmMmaP46sTVNz/L0BnkPSzh+Dm3+aZ
	VY5OmmSy125eE3w+6LH4BNxTja23YQg1xuwhDpyqLF2HGY0juoTbO9NtP/ftjjoEfoZM4mitX06
	GXJLHB3Qn+mV+gf5NwNTTvQfeey82kT35JmH3GVJjsZczmuYEu7qhrHXAi2B+wrv08uk39yXXuR
	tJmS21GBuAFYgvCYul8VH3ymZsmpQfcTIbaZF3iSgtD9llIYU5LAPH5bFJr9rj4cEJn6iZmJ+cE
	vu2x4Mj6olCp9A9H1lhQLJU8ecAYIi8e5KLwwdUl/3Ppkvm+YwcfhPUw4gqV9Mjk=
X-Google-Smtp-Source: AGHT+IFbUdPnNNCdHdOd3aWHqfiWNykncHbUZuz2LGLXLcHMra+1y9VTs59V2W3LfoQRs9MqT/0x+Q==
X-Received: by 2002:a17:902:cf0b:b0:240:4b3b:334f with SMTP id d9443c01a7336-24096b4c467mr2110255ad.34.1753809125594;
        Tue, 29 Jul 2025 10:12:05 -0700 (PDT)
Received: from google.com (152.33.83.34.bc.googleusercontent.com. [34.83.33.152])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f32cb3430sm2060873a91.33.2025.07.29.10.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 10:12:05 -0700 (PDT)
Date: Tue, 29 Jul 2025 10:11:58 -0700
From: William McVicker <willmcvicker@google.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Youngmin Nam <youngmin.nam@samsung.com>,
	Donghoon Yu <hoony.yu@samsung.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/exynos_mct: Revert commits causing
 section mismatches
Message-ID: <aIkA3sMvioatVNFu@google.com>
References: <20250725090349.87730-2-krzysztof.kozlowski@linaro.org>
 <63a6d253-305d-4ffd-9954-7cd665bd332d@linaro.org>
 <2f413942-8126-4d94-b64b-c4a05052b5a1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f413942-8126-4d94-b64b-c4a05052b5a1@linaro.org>

On 07/25/2025, Krzysztof Kozlowski wrote:
> On 25/07/2025 11:28, Daniel Lezcano wrote:
> > On 25/07/2025 11:03, Krzysztof Kozlowski wrote:
> >> Commit 5d86e479193b ("clocksource/drivers/exynos_mct: Add module
> >> support") introduced section mismatch failures.
> >> Commit 7e477e9c4eb4 ("clocksource/drivers/exynos_mct: Fix section
> >> mismatch from the module conversion") replaced these to other section
> >> mismatch failures:
> >>
> >>    WARNING: modpost: vmlinux: section mismatch in reference: mct_init_dt+0x164 (section: .text) -> register_current_timer_delay (section: .init.text)
> >>    WARNING: modpost: vmlinux: section mismatch in reference: mct_init_dt+0x20c (section: .text) -> register_current_timer_delay (section: .init.text)
> >>    ERROR: modpost: Section mismatches detected.
> >>
> >> No progress on real fixing of these happened (intermediary fix was still
> >> not tested), so revert both commits till the work is prepared correctly.
> > 
> > Please don't claim the fix was not tested. I reproduced the section 
> 
> 
> section mismatch code MUST BE tested with enabled DEBUG_SECTION_MISMATCH
> and disabled SECTION_MISMATCH_WARN_ONLY. If you have warnings which you
> missed (although if you have warnings what did you fix?), means you did
> not prepare testing setup.

Thanks Krzysztof for reporting this! Sorry for the mess this has created. I was
unaware of testing with DEBUG_SECTION_MISMATCH and clearly missed those
warnings when I compile tested with ARCH=arm. I see the issue and will fix
the patches accordingly.

Regarding ARM32 runtime testing, how do I ensure my patch series is testing on
ARM32 devices? The series was discussed on the list for quite some time and I'm
wondering what step I missed to get this further tested? Do I just need to
explicitly request for ARM32 testing on the list?

To avoid this in the future, I took a look at the thread that introduced the
section mismatch warning [1] and wondering (before I propose this broadly) if
we can make section mismatches fatal by default for everything except
allmodconfig? Then we can selectively disable it where appropriate.

[1] https://lore.kernel.org/all/1443807963-36364-1-git-send-email-drinkcat@chromium.org/

Thanks,
Will

> 
> > mismatch, tested it and figured out it was indeed fixing the issue. I 
> > just missed the error because it sounds very close to the first one 
> > reported initially and I did the confusion.
> > 
> > The driver is not supposed to be compiled as a module on ARM32.
> > 
> > The option tristate "Exynos multi core timer driver" if ARM64 is 
> > misleading. From this change, the defconfig on ARM can do 
> > CONFIG_EXYNOS_MCT=m which should not be allowed.
> > 
> > Before getting wild and revert everything, let's try to find a proper 
> > fix for that.
> 
> I am not wild here. The issue is there since 9 days.
> 
> Best regards,
> Krzysztof

