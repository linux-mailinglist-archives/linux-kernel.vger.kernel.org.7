Return-Path: <linux-kernel+bounces-869149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1318FC071A3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B21AD3596BE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B72F31D38F;
	Fri, 24 Oct 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQTRZnrQ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F0315D31
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321281; cv=none; b=Rx8D4hciGLWhUAroQN/lbBPG+4ilrgM+RfvGP/sfMPwTWN2GwplZbygaDKamIU/pSNIm11iYHBoA7bDZ+jKy8QQjTrv1j+kaeEEVeyY2BXGeRHxto/bM13C8Mr5GKsr23Cpw83PvPGnB3t/78WmREvBHLDcqBor/0/OfqH7bu4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321281; c=relaxed/simple;
	bh=9W0jOqh0WFB83c/hgolD1lDfJvFPAIhOpkeDEgaA6gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WP2se9+BRI3QducbaHFi2o8DVx0paOZPMW3/KsXOQQpEndi+cYwKuHLWJZ84oBTzMcqYdoNhmrRFJFwUtDQuWrOMxzf/7hpxdVYsncp01M57JPyVY4I6ZctgE2Hr0mfifMztgsiujxET+38L74p9E4ZCCfLS6/zUkEPaQAtoE2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQTRZnrQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so2296932b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761321280; x=1761926080; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SNrPSnUwQSgek1TWOY7IJ65SZA0nkgGonkU8txu9DEo=;
        b=uQTRZnrQVi97SUFOjaA7DAbbz0wZ42XI2Vojd3qRAGTY5E9SD2f7aNFB2NuX5LFIrg
         qK+Vy4FNrn5pqfKAI1LiP5eGY80JV4n0I6gyljU+J61xhSlGcUDj3xsiIGjYn4Uy9/zJ
         9/J9fleYvSVPydHezRuCrpHJprsLG2Zq8Fx6PbFtVFUohx2wKk4vTK3NfDN9YwGcH9Jx
         zfvroltqfzMhASP0N46BS8267doMyjyPxQ09om6QGXC3mY2NmmJhTE4LPSLwp3ppzz+C
         ci9fpBRz8RC7/DNqrDjV2SBFbXhbPoqqVSM4N67cXkfKdy7rj07maamEpnnzGMtLHVcW
         /lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761321280; x=1761926080;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNrPSnUwQSgek1TWOY7IJ65SZA0nkgGonkU8txu9DEo=;
        b=hGmLUurSEpPUOprg0erFGojxi58L5kM+l6kb6nYoY7UG59zpvQIrfBHycggfLAteDo
         zeFhSTRG9Lo+8qG4w0Jn7MrZkd050+S4FpDvMzXCZ18s/vCdJueRXlBHg76SEH2P9497
         uqVYQAmW2Z7U4JoK5uipkP2CJXToLwgiv+BX1nZuLGO6ME46/xrW8ktlrkTC/NExOy44
         V50KIRcTmWYjys7D/T/6wgiZjfAumkMGk2AOpqEoR3hzw7Q772gD2ZtiX6lfiRIZwGVf
         41YuxkWbtiJKSpaRkzHYl4C/rRe8Byr313ct+ocvkz7y3cOhMV7zx6m6ppyaDpm3Ee12
         gdeg==
X-Forwarded-Encrypted: i=1; AJvYcCWszbR2giH6wKSTVrySp3EpJ8KXlVn3eefWPHZqtkkDQZyiMs5C0Z3Iif+8c/RbakwC1MpkND8FY/etFnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD0FdpvsW5ccdPsZxX3xnNo80UiQNi94OzSwCPBSqB6BjLBPNu
	vj27e+vb1Mrcw+TczQcc74yDxzHaviv4HjdEDVzqwqQ6GGv1ElUB8i00r403qV6xSg==
X-Gm-Gg: ASbGncvhszkTnF5LJ5d98+McP3MB+xmS3Z21jA03Q3/QO3Ezs8dnaIU6b+Q8iT8XFHd
	TpO5clYmO7qTiAJPvWPh0J9m68aBHxO6Ag1N6/9Hyr+1+SO+hXfFqC7mAackKDGNH5xcvI6n2bk
	Vo+qIOP7G0aX8azMJtO3uNDCIfc5w4v7ySypouYBZSh1DbODs9os9kZ0QRroirCc4cfG2gdUvW7
	DtoAFxpM0o+tec5zhpVNKiWI2yef07Ir7dT3RpycRsh/8cSH7Qj5pkn+lb+UU1Rk/Dc1kW6d24A
	mp3zVR/VDNHIZOYBsAEeFi4fRhXEYfo+N9DJm9WjK4Hk8V0JL5rTEyvjcBujU9+2wtBk0UN+bDx
	8b0vLYyI+OB6F4uJoW43a9LKfDgT6oCX3EpZIYxOsmaXD5XITJzXs6I823l6WbZWvnXeCVpG9iK
	0waCdsJ89IOqf9enHetDd5nXl4sT1OuRNjvp9V/3TIWQDUadpT
X-Google-Smtp-Source: AGHT+IFKK/nc8huqNArnVsQcPMFPGO2/41KstRTfEUMyU+vcdTuI3QzEMa2HNBjhFdRtL+9SlQ1fRQ==
X-Received: by 2002:a05:6a00:13aa:b0:772:6856:e663 with SMTP id d2e1a72fcca58-7a284dbb2c9mr3491514b3a.8.1761321279403;
        Fri, 24 Oct 2025 08:54:39 -0700 (PDT)
Received: from google.com (80.88.82.34.bc.googleusercontent.com. [34.82.88.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9e8fasm6403828b3a.29.2025.10.24.08.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:54:39 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:54:35 +0000
From: William McVicker <willmcvicker@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Youngmin Nam <youngmin.nam@samsung.com>,
	Donghoon Yu <hoony.yu@samsung.com>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	John Stultz <jstultz@google.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-samsung-soc@vger.kernel.org, kernel-team@android.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 4/7] clocksource/drivers/exynos_mct: Use percpu
 interrupts only on ARM64
Message-ID: <aPuhO5wn8O85krV3@google.com>
References: <20251023205257.2029526-1-willmcvicker@google.com>
 <CGME20251023205313eucas1p2164ef0c1db80bccd2bbd6a79e809a1cb@eucas1p2.samsung.com>
 <20251023205257.2029526-5-willmcvicker@google.com>
 <c09387b9-3fcc-4d0e-8e29-21dee196014a@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c09387b9-3fcc-4d0e-8e29-21dee196014a@samsung.com>

On 10/24/2025, Marek Szyprowski wrote:
> On 23.10.2025 22:52, Will McVicker wrote:
> > From: Marek Szyprowski <m.szyprowski@samsung.com>
> >
> > For some unknown reasons forcing percpu interrupts for local timers
> > breaks CPU hotplug for 'little' cores on legacy ARM 32bit Exynos based
> > machines (for example Exynos5422-based Odroid-XU3/XU4 boards). Use percpu
> > flag only when driver is compiled for newer ARM64 architecture.
> >
> > Fixes: f3cec54ee3bf ("clocksource/drivers/exynos_mct: Set local timer interrupts as percpu")
> 
> This tag doesn't make sense in this patchset. Simply squash this change 
> with the previous one, adding the following tags:
> 
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Link: 
> https://lore.kernel.org/all/20250827102645.1964659-1-m.szyprowski@samsung.com/ 

Okay, no problem!

--Will

