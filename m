Return-Path: <linux-kernel+bounces-760617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E18EDB1EDD2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D991C2536A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6262A1E0DE8;
	Fri,  8 Aug 2025 17:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="F8Zd2LAS"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2125518871F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754674047; cv=none; b=rhQOFkk2reWS5jKYuOtT8WMTomJP21T38qgtfq2x+sShPq4WEfBX4xlKAq2D+PcPMe39lIHMQL5b/9Bb8dPO9COeidcpj3rdBV8GaFLmDaG/6QLpPbK72wdn7VURe9IA5FW3SDmdm2VSwwIzxTV+VeOAme/xS4AdAZ4/k71vypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754674047; c=relaxed/simple;
	bh=YhPHvRuY1v9h4xyqP0VCDLR15RTlx0Cn7QtYyintfS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=clSMSgX4f54QMSPr6ouCV9oOY0ZsITLHkmOLly/uIWvZ39WJAry927Jp9sXKYIUssXn1E7HKwTtcnaJRWIswHeIsTV8TadAi4AOT9XJXOUEFnH6UGl95cd7c6d4tOCvryloSXcJPKbcU/C59EpfH+43g+vo1iA/bRho/Adri9Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=F8Zd2LAS; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76bd6e84eddso3193109b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754674043; x=1755278843; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZu4M+16qQsYFOxJAPaXmK7wSvD11abK1ntpTO987P4=;
        b=F8Zd2LAS0ETB7jThp7+K9Gn3WlfeyvZQ6T4m8pgHjtYKUKa7MNgiZ9qtHxniOGhFoF
         LTpuMac3dysaDKiLLEytVpjHVzOraS9XsKoE1UMmnJ+oe9Qkeo+gCFrpeWZBOItWeiQv
         K3Q2vTqADDOH8FQy9PiKA0u3EA8ZEvohcvcjOR6a63KjLKxK6tWJWtWcwLCy1KXzBz5U
         2U5PkCKgZaginV0X8GGYoDBX8miE9H9SvQJL+A2ylbByf3UYHVt1I411cEg2H9KapQYf
         cjbeGaXvM+A54RUin4OP0NCWeN84n/2ggnLL/tKaGl+Xpb/JZqMWLNqYqe+z04Ow7Ts2
         fvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754674043; x=1755278843;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZu4M+16qQsYFOxJAPaXmK7wSvD11abK1ntpTO987P4=;
        b=OwNcxaX6n8u0puwtHy2Pd9Mk5XOwUr0bP94v+L3fyoCZc/SQkDsCOn+82yFgeFWnHV
         o95gSgQdk425ZaZqzYbtn41nHF/mXAposDCWWFeVOrLo43JkdjLktoDCJnYsLmEv18w0
         q3sbX53dO0griLpaRfOzHEEUqS1wlVJn1Pv6g35/K1b1+OKiJ76BpMVsAHuqwZivZv/y
         rR9KghqlyuyAFoB9S83QwFlQSvapv+iqLVyzf1TLSGdu+5PEfBnQ0REJUXIGjm8eeFey
         c/KlBdJdrKk0U0NAG0Ts8j6Phf0qQZ9SerE5zpQEdvayJVI78YqXM5lH0ywSEvo+zVcs
         rACg==
X-Gm-Message-State: AOJu0Yz5VjLw7Fx8/HfWm2dl6WpiAXZBFJWWox4epJ7waZQ1ZQ4osrrK
	RzgznmHyJi98zd20sdFcx4oHk9qHA5X8y4F31TmoqQz1Vx602mt8xNiuSq+iSWdGLvc=
X-Gm-Gg: ASbGncsrxhG3Sq/bPbAsvQLcvutLpg7fF6ywvkuMmOuJgoBi7sWcz6Dpu/7ZYqsgolT
	IoKCqVQ4eooc2iOtxfvGU1qL7vLaNtlWUL2+IQnnLGXf7MQgY7tPP2PO9ckbWpeQRgEt7N3SBrB
	+6fmuIOrjaSH81eT9BSGsQs0oKLDgREWOf/L/gVOVwPfNhXei++dPIgpjgCZ8xkgvs0DI+XgZbx
	iMNmsZfuInNqEyxcA9aZk7xdafsNi+y8QvZ0v8gm+jUwXY+oyYKEtathxUiNjGYex3RqhsWmd4z
	e/aFopf5pwa2GquUqXjF5Di0YPIJc6qecX/pxUVOkoV0+LUrTm0XonCeLG0DoSHGqRuG0OiKXqj
	SeDSVPSihNNPigpx6/ezy
X-Google-Smtp-Source: AGHT+IHZLqZ7E2Ncq3KMVSpsOCfBJkP8Mr77rZGywcbQgs9eQYzQo6jMvGzxCIqrZGpvYIHCckMFxw==
X-Received: by 2002:a05:6a20:3d88:b0:232:fcfc:7209 with SMTP id adf61e73a8af0-240551d6b07mr6845776637.35.1754674043198;
        Fri, 08 Aug 2025 10:27:23 -0700 (PDT)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd18c9sm20738657b3a.91.2025.08.08.10.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 10:27:22 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Patrice
 Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Mendez, Judith" <jm@ti.com>, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH] clocksource/drivers/arm_global_timer: Add
 auto-detection for initial prescaler values
In-Reply-To: <20250808-topic-am43-arm-global-timer-v6-16-v1-1-82067d327580@baylibre.com>
References: <20250808-topic-am43-arm-global-timer-v6-16-v1-1-82067d327580@baylibre.com>
Date: Fri, 08 Aug 2025 10:27:22 -0700
Message-ID: <7h8qjt7mh1.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Markus Schneider-Pargmann <msp@baylibre.com> writes:

> am43xx has a clock tree where the global timer clock is an indirect child
> of the CPU clock used for frequency scaling:
>
>   dpll_mpu_ck -- CPU/cpufreq
>         |
>         v
>   dpll_mpu_m2_ck -- divider
>         |
>         v
>   mpu_periphclk -- fixed divider by 2 used for global timer
>
> When CPU frequency changes, the global timer's clock notifier rejects
> the change because the hardcoded prescaler (1 or 2) cannot accommodate
> the frequency range across all CPU OPPs (300, 600, 720, 800, 1000 MHz).
>
> Add platform-specific prescaler auto-detection to solve this issue:
>
> - am43xx: prescaler = 50 (calculated as initial_freq/GCD of all OPP
>   freqs) This allows the timer to work across all CPU frequencies after
>   the fixed divider by 2. Tested on am4372-idk-evm.
>
> - zynq-7000: prescaler = 2 (preserves previous Kconfig default)
>
> - Other platforms: prescaler = 1 (previous default)
>
> The Kconfig option now defaults to 0 (auto-detection) but can still
> override the auto-detected value when set to a non-zero value,
> preserving existing customization workflows.
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>

Tested this on my am437x-gp-evm board, and confirm that all the noise
from CPUfreq failing to change frequencies is gone.

Thanks for fixing this!

Kevin

