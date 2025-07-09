Return-Path: <linux-kernel+bounces-724527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1902AFF3FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80BC01C24D3D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B6823D2B6;
	Wed,  9 Jul 2025 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xL4zJN4b"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C87227B9F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097033; cv=none; b=MZubFpkaM/AQhalaE1HQHRvg9kFq4Gx9L6hw20Rh/wkIcd5jUhhW88K9otCQ5d5/xjVXztJnJYdC5y8YZKnofuhGVVU4dxg7hC0azmso5yKwvXgqZAT21Y9quojjGy9Qmp6Tya7yjOXySUpjO0h7uRSHQqASwx+65/3aQwes8P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097033; c=relaxed/simple;
	bh=+ClvygQ2RMEEPybf+Dhrb6/A2svFsACwgt2ByyISdvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nP2b1hrb/RfF4IMFtbxfRfxzwuFW8nzExszX7fuRXdXWcIY8Pl9ojRgVmzPuPkxGNJRpnHiG+EXBO8IYFemB8GiW8/MPK/lJz+cHkjcLNtKamIb0zh8Ogjjn39kfTYzOqHxcYCquwrQwn7KBl4L1lrIWTTGUqLcZJ7RN8KSwfF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xL4zJN4b; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2da3c572a0bso315057fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 14:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752097031; x=1752701831; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ej56GZoDfiEB41ozBqeCG5Oh6gi5hM+KQ3liG4bvyEs=;
        b=xL4zJN4b2P7p2blNBJz/pzTto63zeoi5g4aBFEsJwHKlLnjvcrbeRTyTRo3G02neRT
         1hN66cxM3OBPC79oKueWWYPx1jNgU9XnmUb6zNvUOfH/pr9KuJhDa8fIreaUWm97yTTA
         QEyocJUra8XbVSh+r5WX2EZDvRRaRp8yo21PLIY5ehEynNbDp9Q7SkaUemr4DSUUYo/a
         BgI9evRSB+2+HcekUYtFxDJZwX3raYQLV+6b/Mz1cPHBdFqG98+F5RNNN5V63rI6Zhqm
         LRtJug3uKNTFNgH5Q/IAPMnDCri+5DtBNN2wEwudi6R3vbh4J5I/eQaB4/ts5w8VkLBb
         eYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752097031; x=1752701831;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ej56GZoDfiEB41ozBqeCG5Oh6gi5hM+KQ3liG4bvyEs=;
        b=PXDCEqvdDvyeCjzoOCVcNvnbsNVS01bCwYO1K8OP73ZROAiVJXhdR5ygBlr8srPxlo
         /mHaRRdXsePzGFZqvSC7CzUC2ZUzEqajQK8KlwE/2dDpdPKCgb1EsxowAVbNL2pA2IWD
         SkTCfsL88bOASeapKWolQ01A/pXkIQOlMjLQQZgctf1zv6FxKbzobxzTluN80dDDZ82R
         rN++5G9+i12uqGy3gqgrXkXSqnzApflYTwlBmbgm3KGX5Nq7awSt6B0oNvIISoZpetPs
         3xEPci9sYpEi0YBxwrdS5VrvF/1i63+rGb4DbaGRxJ08Rpehj7UtTbasNbKL0srje9DG
         ysQA==
X-Forwarded-Encrypted: i=1; AJvYcCUcMWBFThNg2xk8S/HQ7DkJAllYmfRVSRKLGL5jNZx0wDWEL/NZGvWcwv2AACzoKm4t6ytuy+1CRgWY6sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDeplw+Mq6IP6I0zJWJhHlbTPv0s9Vgtu5hsx/7YQbImnNa1+N
	SapWq+JXF7/30gfAFL0Cak1WgFsYVRHUSCaLj/oh8Y6Q5MaoqHQ/ohGpo7iYrszNRZjL20AoWgL
	Y/PhQkDLqf0YY96ncNJLc8NU/J8RGPnzKs/QaYuVYJg==
X-Gm-Gg: ASbGnctnkNG2nMeqy0KTKC0NgNaOe03OUEwT058w24OVlAw9ApB3lifwHcgXhCMUhJj
	azWUzUU7s5+WpjK4EE9lx25NJSvT0BtRi90UxvI1OLsBZ5fXGrZ3h+5aKPhltVYaTDSljSr8Adn
	l4O/1cb1kaeYgIxR2tjMXCMDGbyUjjNGeTsDioZ9Lvmb0=
X-Google-Smtp-Source: AGHT+IFkQC/A6ox6MY05MYUw+CxjeUHI6gwfGQcb8/ByhkzLHUkzh1cpvqJdYCStR9o2v2KnGFlHUHdMYMFFGD7SDdg=
X-Received: by 2002:a05:6871:293:b0:2ea:841f:773c with SMTP id
 586e51a60fabf-2fef87e6153mr3338509fac.35.1752097030840; Wed, 09 Jul 2025
 14:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-gs101-cpuidle-v5-1-b34d3210286d@linaro.org> <20250709-chocolate-flamingo-of-nirvana-5de895@sudeepholla>
In-Reply-To: <20250709-chocolate-flamingo-of-nirvana-5de895@sudeepholla>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 9 Jul 2025 22:36:59 +0100
X-Gm-Features: Ac12FXwllShNhqvUQknysIBtFTk51NgLeP-HjV13-opUWbLkoeErzAnBiZILB3U
Message-ID: <CADrjBPqYSVO20a0ox9un0fq7dBss9sMGK1Q3ivCjCGaFyqhZFA@mail.gmail.com>
Subject: Re: [PATCH v5] soc: samsung: exynos-pmu: Enable CPU Idle for gs101
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, William Mcvicker <willmcvicker@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Hi Sudeep,

Thanks for your review feedback!

On Wed, 9 Jul 2025 at 17:10, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jul 09, 2025 at 02:26:27PM +0100, Peter Griffin wrote:
> > Register cpu pm notifiers for gs101 which call the
> > gs101_cpu_pmu_online/offline callbacks which in turn program the ACPM
> > C2 hint. This hint is required to actually enter the C2 idle state.
> >
> > A couple of corner cases are handled, namely when the system is rebooting
> > or suspending we ignore the request. Additionally the request is ignored if
> > the CPU is in CPU hot plug. Some common code is refactored so that it can
> > be called from both the CPU hot plug callbacks and CPU PM notifier taking
> > into account that CPU PM notifiers are called with IRQs disabled whereas
> > CPU hotplug callbacks are not.
> >
> > Additionally due to CPU PM notifiers using raw_spinlock the locking is
> > updated to use raw_spinlock variants, this includes updating the pmu_regs
> > regmap to use .use_raw_spinlock = true and additionally creating and
> > registering a custom  pmu-intr-gen regmap instead of using the regmap
> > provided by syscon.
> >
> > Note: this patch has a runtime dependency on adding 'local-timer-stop' dt
> > property to the CPU nodes. This informs the time framework to switch to a
> > broadcast timer as the local timer will be shutdown. Without that DT
> > property specified the system hangs in early boot with this patch applied.
> >
>
> Assuming this is arm64 platform and using PSCI for all the power management,
> can you please briefly explain why all these dance is absolutely necessary
> when PSCI calls can be the clue for the EL3 firmware. I am basing my question
> on this information in the file:

Yes, you're correct it is an arm64 platform using PSCI. Unfortunately
I don't have access to the el3mon firmware code to speak super
authoritatively about it, but you're correct that it is essentially
working around a firmware limitation.

What I initially observed whilst working on suspend to RAM, when
hotplugging CPU's with just the PSCI calls the system hangs. Debugging
this and tracing versus the downstream production drivers the missing
piece was programming the "ACPM hint" to the CPU_INFORM registers.
Further debugging and power measurements also showed that the ACPM
hint is also required in addition to PSCI calls for the cpuidle states
to function correctly.

> /*
>  * CPU_INFORM register hint values which are used by
>  * EL3 firmware (el3mon).
>  */
>
> This clearly sounds like workaround for the firmware limitations. That
> needs to be clearly documented IMO.

Sure I can add a more verbose comment, that this is required to work
around firmware limitations in the PSCI implementation.

Thanks,

Peter

