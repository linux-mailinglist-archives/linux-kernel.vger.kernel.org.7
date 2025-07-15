Return-Path: <linux-kernel+bounces-731713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF29B05887
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12BE3B8C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B7B2D8788;
	Tue, 15 Jul 2025 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbh1VMSf"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7361414A4F0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577914; cv=none; b=Z4PfYnCeqE9jT5v7uK+YFHpCZF6qCgXj2ZoAZc/oCbQilhVLG5cL5v8mtk2mahUOePcfm+v/ovd/78XsJLHvY82LdmalXEzqrzJAKgDEQqeSh+M78Ih8Hm328EfqJs7066DgM6xLU3lUl+T0jm79vbTtRdHgVOqRuRO/crP1k9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577914; c=relaxed/simple;
	bh=l/yFbP2fCrLeH3hUtfWbaL0u1ry82Ak/7nDAOpJkQzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4xhsd4qAEqYDRpDEM1pUQX5u9rmXIRo3Brzv4QAm+sNKSRczXuF+vHXEjPBLJXCenKQh7dhugY2aZn1IiLW3ktxmAQAZusU8WchTNQrnvdh6ZirImf+XLr3zhVDzw7Nmv25Qv8i9CwWSoje1hcEkkt859pQrm828rFr0/FoZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gbh1VMSf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45629703011so2649555e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752577910; x=1753182710; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tOD2KdkDf2g2ZTL9DBAls4gcrEUjzzhQIBup1CEYFgk=;
        b=gbh1VMSfqgYIhmcr9rxFKuUTFIo9UHl/UqVYPdhIgb9eqQ3h3ZNr6LA+CFR7fa+fd/
         XOcP2fcXBEqC6d1ftq9WWCnStiosrbbi5CwYpEXwg3vij4k6NqnNKyF6YfGMyOufg2R2
         Cc4+TSlgU+T/QPZw8wEihCsZTRrrXZ2w1ovICV9oDtCClcTARAIik5XkVZF42HnPqGrj
         l32D093PMcF8ExYSbd0EIQ3tzyrlnTVlmHS6GZKYP+CtJgBfKt/QPNVb9RBqt9Cisl/3
         jD0XQVZhWrQ3pfgRA0348IO5naGZn+wycbKMnw5AmBX1JBKLrhH6d4XRXmcyJIk2Syn3
         mu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752577910; x=1753182710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOD2KdkDf2g2ZTL9DBAls4gcrEUjzzhQIBup1CEYFgk=;
        b=pjzIqdstyr1wWBUfO7bDQ1gwA/nB7eDnJESAuZgZl0CgvM3ixB4x/rqq7NtWiqS3GJ
         KQQRPqbX1HW7jWcqKn7h/VjPpCU0IF9khs/xme1k3bix3mniMEcM1I+ycfJu1azbczrl
         gy912LVnGwPeS8kdRFHHmQPtCQpBg4P1E9Ls1LQEeHpuB1ovQkqdKSf5uuF0f/PRtIqQ
         tNvMhdZpC/jAQRsm2Qzfiof7EV8N+EYccSY4EVhiFyw2lHvy0z3f8KxWya/9jb/QZM/m
         FcK/ESyIQVdurdvxXMbPA3dbo45lNyXpIiTDBIXmYwyOFxPxh0CShgl0KgMn3RWZCcj/
         zh9w==
X-Forwarded-Encrypted: i=1; AJvYcCUgzRMsy3SLcKQneddNXXt6iY3NNeEimQLym+7O5/N7WphV3qXJks5T7WLmrTyVonPuUo85f8lDqowdT3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOCe2v470bP8WTrufnfOTUhayh2mVV1yGP+0RcpM8iBXbBO+Nh
	QTCx9CQ14QYAJcuSaK1v6QXcIX5aqpoHFsyYqyg7gYWivJe+ebxezkik/Mg74UDvNME=
X-Gm-Gg: ASbGncsfJL0cqvAalxHR8j7C4BJkhqrFEAaQz5jd7ZnEEbIIQIUMpFMRlp49M2mgeQr
	/lkViR0do4AKUgu6q1XXcltrD+6HIxvKfWJAWiahjj03SX2Yr51npJE996cQH7zR57goCStM/BZ
	7qycfb8ntPQvn1thopTyXBONOJ29ny4dF6ugOhFtirzrzQREWiLB7y32zrnaq+Q6F99gTe0tdpE
	DHcBCiqg/NbGLgg/PtX5GVXMe/cycbeZoxLsNJXbJY5RpdpG3SYkS06S4z3I3Ja7BvC4iUETcWt
	E9NOjW5lna3YV9UlJhdfn5fYWTRTpseaXQEb/hs+nkqqNKyGmkwEBljLF60VJU3quylapUTB2PW
	J0ee+dIfpQdq/OAkRSJr+GyDyiICa10r9e+Bzg4YqYg/Zd3gXezYziRqnF2I3
X-Google-Smtp-Source: AGHT+IGJ8sAMfpJnZWaTVJ0W+e/q7g1M9AZrjsO4AxgHJf+hW740JklhqJ+pVd4Pz969wiFCOlmfiQ==
X-Received: by 2002:a05:600c:4709:b0:456:1904:27f3 with SMTP id 5b1f17b1804b1-45619042aa7mr79771555e9.18.1752577909564;
        Tue, 15 Jul 2025 04:11:49 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm15196012f8f.34.2025.07.15.04.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:11:49 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:11:47 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	Pohsun Su <pohsuns@nvidia.com>, Robert Lin <robelin@nvidia.com>
Subject: Re: [PATCH 1/2] clocksource/drivers/timer-tegra186: Avoid 64-bit
 divide operation
Message-ID: <aHY3c1bAdUmxoN6_@mai.linaro.org>
References: <20250614175556.922159-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250614175556.922159-1-linux@roeck-us.net>

On Sat, Jun 14, 2025 at 10:55:55AM -0700, Guenter Roeck wrote:
> Building the driver on xtensa fails with
> 
> tensa-linux-ld: drivers/clocksource/timer-tegra186.o:
> 	in function `tegra186_timer_remove':
> timer-tegra186.c:(.text+0x350):
> 	undefined reference to `__udivdi3'
> 
> Avoid the problem by rearranging the offending code to avoid the 64-bit
> divide operation.
> 
> Fixes: 28c842c8b0f5 ("clocksource/drivers/timer-tegra186: Add WDIOC_GETTIMELEFT support")
> Cc: Pohsun Su <pohsuns@nvidia.com>
> Cc: Robert Lin <robelin@nvidia.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

Applied, thanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

