Return-Path: <linux-kernel+bounces-735638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0EAB091F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A847BB9A4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A162F85C9;
	Thu, 17 Jul 2025 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="twfIqnxN"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22791F9F73
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770056; cv=none; b=uCZAiUfQkIF7GgVw5yM73KRvHlg9yt7xGu51FJLNdsipfOK2q9LmrXzmNH57w5ajABkfqPQihcU9KeGJln7BoHXBEYiwja//OleBT3fmip/E3wIcvcg8DTI9VJQGZykKOHFTmkInvYuT/REIin63KmY42yfY/eg+198AeL0ikqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770056; c=relaxed/simple;
	bh=U8WUmZ7UrNn0Gg7xFUg8nTdTA48ShRt5aSRebhZeSX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTLJTuOijlanObeZ6P1ZtO0xxZLBi2TK86eBMn3jwKe6sCJww7aZ1vCn/DNbzm7/pCN6vBM01CcOn6mLnzqzOwrjl8b3rK9FdFBVZH8s+CAxkpwX5Hw1mxWDkWPgVeM6jaKeoGG2xSos5T6C9279NzlrfNCCIkmnhoUuYdPJuow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=twfIqnxN; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2ea080f900cso471342fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752770051; x=1753374851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X2+K5kZAESVH5bjbMGycl+BENKKTT9M601876vlEf2I=;
        b=twfIqnxNVyFg+dBEBcwcMVLpGCxLrJVeZiT5ZvAwPeKxrpUMvm6TC/aO7Mbak+FMzn
         6/HBDpzPfQHlsQvahkXfobOdvu6+zheHEEVYQbeep8kJAfVYyMkaxYQQ96sT+AHv6V6c
         N2EVsZ5+EDOYfuS3VFMT3fhrYppN7gqAvX7BGxFd4RYlf5Oelq9pWkDdquD8jfZFNkRT
         2icQCiRb4cFpzWa1FQNgld8WJV22T+dolM5UEgxkEKj+FN80dur6lAPaV6QYJzKHTvun
         CK8h9AieHPgaa5IFMntXTmFRcU8syAebzK+Y9DhGAO4gnoBephEiwILw/wWPylF09VTJ
         VVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770051; x=1753374851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2+K5kZAESVH5bjbMGycl+BENKKTT9M601876vlEf2I=;
        b=I9mcKraV22yx1Ml+k3rzn2awqhUvFGBXUFRkDIebnP4qbnJY9WkcGyNqO8GYGpa4vD
         0B1cgnH2kWl2nuhmlWqL81mYleB3dWfoW8hdsTHPA1lMmNiM/+Cfaggcge74jX9HDgU5
         lOAb2Ns0K1nu1zPiMifNV8VRyzI3DLhh3dSXsO+00QPA9WDzG+bo6r8ZxrdWpb/G+2OY
         wQ49E1gXmcqZ76tXCqg9jFYnCRe8152igOBg0gsiBZgf/VxprSKl80eYKhyWg0LfYDDA
         KAhDALRGl8PNVVxiyR6sCRmL7LEap8tlJhRARokNrv+78SwHxTxPmAN9DBMey+S/UCvT
         oV6w==
X-Forwarded-Encrypted: i=1; AJvYcCUEhDuP7dhOBrJgc/LUYjOjpfHeAfpRZDolFPHM6FTMiLEutw0i4XAluOEx1D6pxQBx2a0RygOqJDcwWig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhy3lI8grK4ihumjT/dst4szMd5DbVfhzp3os1H4YCWk74q8Tc
	2zT3osZlfhOqZlVaoYIrbP+ZIBJcL4CULzKTBCZD4DlYXe0/kigPeejTFOqil8xmsw9+/lriLJU
	2HxZ4ihbD/5XCyDfToyrw2JTA7uAFSEYOo6W3RK3luA==
X-Gm-Gg: ASbGnctho2e21/IA2QYXvrIMFN2q+0T24jtxhmTk8oaOUzJctWyhZjQU0D3/6/XAHdx
	H6/J5V50verpv0QckQq0Kbm7DaIQqPDHcRhMIjnYhWGD5qcUaRJDG2ll5sVn29Wt4IjcVjtorMO
	/1deZShBK2i2qhWuL8juqC1LgGES02ZLGc8cfLQOOnfEA0XEZcWPETsIc6hUygoc9+Xf5/JEw20
	P1OC1IiPA==
X-Google-Smtp-Source: AGHT+IFwM46WAT88MwJQfwmy316aoGs2iMb5yuh3tLyPaOUzGsTIYwh4NOAiA1/hlEtURXz89n0/pWNod1NhIzdMukc=
X-Received: by 2002:a05:6870:2c9a:b0:296:aef8:fe9a with SMTP id
 586e51a60fabf-2ffb223d9damr5943160fac.7.1752770050610; Thu, 17 Jul 2025
 09:34:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711-gs101-cpuidle-v6-1-503ec55fc2f9@linaro.org> <5597644b-267d-40d0-aa33-a8a665cebd70@kernel.org>
In-Reply-To: <5597644b-267d-40d0-aa33-a8a665cebd70@kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 17 Jul 2025 17:33:54 +0100
X-Gm-Features: Ac12FXxDArSCCUN95XLlnHhF6jYPPCI7qSjY8zS1Dogc057C5wMeWh2BJ5AljmM
Message-ID: <CADrjBPq_ofiUirxUx+VyzTeGMgWKLmFRhPErVTSV3Qd3hKp-RA@mail.gmail.com>
Subject: Re: [PATCH v6] soc: samsung: exynos-pmu: Enable CPU Idle for gs101
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	William Mcvicker <willmcvicker@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, sudeep.holla@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks, as always, for your review feedback.

On Sat, 12 Jul 2025 at 18:42, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 11/07/2025 15:50, Peter Griffin wrote:
> >
> >  #include <linux/soc/samsung/exynos-regs-pmu.h>
> > @@ -35,6 +37,14 @@ struct exynos_pmu_context {
> >       const struct exynos_pmu_data *pmu_data;
> >       struct regmap *pmureg;
> >       struct regmap *pmuintrgen;
> > +     /*
> > +      * Serialization lock for CPU hot plug and cpuidle ACPM hint
> > +      * programming. Also protects the in_hotplug flag.
> > +      */
> > +     raw_spinlock_t cpupm_lock;
> > +     bool *in_hotplug;
>
> This should be bitmap - more obvious code.

I've done this in v7 which I just sent.

>
> > +     atomic_t sys_suspended;
> > +     atomic_t sys_rebooting;
> >  };
> >
> >  void __iomem *pmu_base_addr;
> > @@ -221,6 +231,15 @@ static const struct regmap_config regmap_smccfg = {
> >       .reg_read = tensor_sec_reg_read,
> >       .reg_write = tensor_sec_reg_write,
> >       .reg_update_bits = tensor_sec_update_bits,
> > +     .use_raw_spinlock = true,
> > +};
> > +
> > +static const struct regmap_config regmap_pmu_intr = {
> > +     .name = "pmu_intr_gen",
> > +     .reg_bits = 32,
> > +     .reg_stride = 4,
> > +     .val_bits = 32,
> > +     .use_raw_spinlock = true,
> >  };
> >
> >  static const struct exynos_pmu_data gs101_pmu_data = {
> > @@ -330,13 +349,19 @@ struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
> >  EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
> >
>
>
> ...
>
> > +/* Called from CPU PM notifier (CPUIdle code path) with IRQs disabled */
> > +static int gs101_cpu_pmu_offline(void)
> > +{
> > +     int cpu;
> > +
> > +     raw_spin_lock(&pmu_context->cpupm_lock);
> > +     cpu = smp_processor_id();
> > +
> > +     if (pmu_context->in_hotplug[cpu]) {
> > +             raw_spin_unlock(&pmu_context->cpupm_lock);
> > +             return NOTIFY_BAD;
> > +     }
> > +
> > +     __gs101_cpu_pmu_offline(cpu);
> > +     raw_spin_unlock(&pmu_context->cpupm_lock);
> > +
> > +     return NOTIFY_OK;
> > +}
> > +
> > +/* Called from CPU hot plug callback with IRQs enabled */
> > +static int gs101_cpuhp_pmu_offline(unsigned int cpu)
> > +{
> > +     unsigned long flags;
> > +
> > +     raw_spin_lock_irqsave(&pmu_context->cpupm_lock, flags);
> > +     /*
> > +      * Mark this CPU as entering hotplug. So as not to confuse
> > +      * ACPM the CPU entering hotplug should not enter C2 idle state.
> > +      */
> > +     pmu_context->in_hotplug[cpu] = true;
> > +     __gs101_cpu_pmu_offline(cpu);
> > +
> > +     raw_spin_unlock_irqrestore(&pmu_context->cpupm_lock, flags);
> > +
> > +     return 0;
> > +}
> > +
> > +static int gs101_cpu_pm_notify_callback(struct notifier_block *self,
> > +                                     unsigned long action, void *v)
> > +{
> > +     switch (action) {
> > +     case CPU_PM_ENTER:
> > +             /*
> > +              * Ignore CPU_PM_ENTER event in reboot or
> > +              * suspend sequence.
> > +              */
> > +
> > +             if (atomic_read(&pmu_context->sys_suspended) ||
> > +                 atomic_read(&pmu_context->sys_rebooting))
>
> I don't get exactly why you need here atomics. You don't have here
> barriers, so ordering is not kept (non-RMW atomics are unordered), so
> maybe ordering was not the problem to be solved here. But then you don't
> use these at all as RMW and this is even explicitly described in atomic doc!
>
> "Therefore, if you find yourself only using the Non-RMW operations of
> atomic_t, you do not in fact need atomic_t at all and are doing it wrong."
>
> And it is right. READ/WRITE_ONCE gives you the same.
>
> The question is whether you need ordering or barriers in general
> (atomics don't give you these) - you have here control dependency
> if-else, however it is immediately followed with gs101_cpu_pmu_offline()
> which will use spin-lock (so memory barrier).
>
> Basically you should have here comment explaining why there is no
> barrier - you rely on barrier from spin lock in next calls.
>
> And if my reasoning is correct, then you should use just READ/WRITE_ONCE.

There was a bad assumption on my part that atomic_read etc would have
barriers. After looking at this some more in v7 I decided to protect
the reboot/suspend flags with the raw spinlock. I think that makes it
much easier to reason about the code.

Thanks,

Peter

