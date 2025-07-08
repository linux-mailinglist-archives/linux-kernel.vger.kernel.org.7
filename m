Return-Path: <linux-kernel+bounces-721941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45C9AFCFB8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CD1169FDE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87532E172F;
	Tue,  8 Jul 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vM4vngYq"
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3A2E06DC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989847; cv=none; b=AzSpuiqDahJJBthYE0Qv3KpGsq1HMcjc+WA+6y1t5XLZI7pJIfjUXFs76D6Tn3+G17LKST4OcpziUPIps3gQCZwuAS6UJUUO5kimOUL4TzLC77tScc8Cx/+cnFQWIMUEbRD2lVHA73K3EjRC2CMwaGHHMeJikpncnvHycIc7gy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989847; c=relaxed/simple;
	bh=LzPutXUmlKDhoAc90fcegtLTLC6jK0JHT9tx8r9o9VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVCobdthOCcIAx1o/iDdozsgSM3nnDC2QSJw1JlPpa+1h92x7BfTo6a/hpHTWEXR5OQ2NlJbunqIN1cSDhi0Omc1Kah1Q1MYv8+TvsQgQUaxlAROBKYSVrDFuS68xBOvOqlYMC31eNKADXfynZkNVQpHXY7fYvyNbXxizZVzzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vM4vngYq; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso3935310fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751989844; x=1752594644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR/TgcEAqCHK/tg9If0ZSzpG7FbkUkTA33Wfi18MQFM=;
        b=vM4vngYqJST/o4gsRZGESZFB0IiJ/wffr6LQLjChd/v7ZtHHSqNQFJ0Gh9kIaQfp90
         nS6Xq1tfwJdx64WgXHPI5G6RkZVm3lk3iH9a6XpVSzJqTpqSVDhsenZOVV8ncvK3pUNL
         TMjtoJ2trSQ31RT0JIL4YfYpz6X7RpJO+EhnSWLqKEpPJxclq5bLzPq04ajn1Tlc69PK
         CEIwqkmc0JxVxaW1y+apyLdkx9i9khixzYby2eYN3bCZA+WpLdiFSJkSB6fmmtyIzDdF
         8jgqgp5/S1QxDHDIfuVNLxAWzZisBCljlYvZNhnUJJzcwoXTLyJBVGz4cgIj3wVpaxaC
         d9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751989844; x=1752594644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HR/TgcEAqCHK/tg9If0ZSzpG7FbkUkTA33Wfi18MQFM=;
        b=XgRNUiBdxaPJ769x2xG4OiZb7f85agCTcrRfg9c4cu06u/N7AfXRqYZ4cl53kxDgir
         0wBRaYVudwVnuHsIwdfFExBzL2/w9LjLxhU6iR5VhQxRz2TZ19a8tLhzavIGCdsbKpTo
         zsl6xgBGCIp6ujIRyEvh8gAaecSmiDH45l3h0TwNQ0BFd1bhg+ayhc4ceoP3qBezqa7I
         tX0jxd3D+gI5P8Uo8uQcEiOQ+x0zxXDNfsdjbdhSZUfc+m5UMlBcYNkg3VrLjUQnYvkH
         XyaWcgTKcMczB4ZTB6QShK38iZkjeuXqXOBptIOQAAZl6asGtwLS+x4cgNFE66Am5WDv
         qvJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv8Ld8DZ1NiUk3qohY4maKaBIIdwG3sQZF+Mn5BujJNP6gdj9zzp+qpxIqhvzI4Skj6zxepeFDkO51ajo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXnHG+9riGQlZXfm70sTZnIfWq70dkbzOB/RohmGzg4lGPlRnh
	QGlYCtkR9eO+RpadLLzannIPVAafz2IqoEOzmw6H9P9Q7KzN2yRvNAv2C+Nj0y9YSEGTjgpvJDO
	NJ6rFuXaACab4Yjp8XrM1dQUL6KSxSrRR4k/yppnMEg==
X-Gm-Gg: ASbGncta37TuKxMQN0FUm+0DQJI+13FNCoXZ7t9ZF1mZHRMGi3QnxgRhaTnHu9bsZZ9
	lf4kHuGC8Nt3S341ZdYqXOWPv4zwHomzyYbAaVpFVgrhIN7t3ZvH/BrLGdPv+wn4gvt6LWdAk6u
	Ze69uDgoABrH0RYo0EMJ+5dCf7dGwhAfuPVncxab/fki2L
X-Google-Smtp-Source: AGHT+IGhIQ2d/00hL1lp2ihpRXFXuMHqlKF15eMdEWAqhGG29SEV8c2orYdqfn2UR2Uw+vlIpZwoKsKNN3Ed1kDkKrI=
X-Received: by 2002:a05:6871:4b86:b0:2c2:174b:c829 with SMTP id
 586e51a60fabf-2f796c4ee82mr12539861fac.15.1751989844169; Tue, 08 Jul 2025
 08:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627-gs101-cpuidle-v3-1-0200452dfe60@linaro.org> <91a9d4dbe5504c493856ef81b30d98e7da925ac0.camel@linaro.org>
In-Reply-To: <91a9d4dbe5504c493856ef81b30d98e7da925ac0.camel@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 8 Jul 2025 16:50:32 +0100
X-Gm-Features: Ac12FXxe1PgFTp6fHm1isStWQQM_MoDhyRf3bpetBoit9EPNjj6uOBov0c3l-qo
Message-ID: <CADrjBPr+iQ=BQ=iLhkTDmRbv+sKOYM1rRpU0Dc1FXQhkeBU_Dg@mail.gmail.com>
Subject: Re: [PATCH v3] soc: samsung: exynos-pmu: Enable CPU Idle for gs101
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, William Mcvicker <willmcvicker@google.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

On Thu, 3 Jul 2025 at 11:12, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> Thanks Pete for your patch!
>
> On Fri, 2025-06-27 at 14:08 +0100, Peter Griffin wrote:
> > Register cpu pm notifiers for gs101 which call the
> > gs101_cpu_pmu_online/offline callbacks which in turn program the ACPM
> > hint. This is required to actually enter the C2 idle state.
> >
> > A couple of corner cases are handled, namely when the system is rebooti=
ng
> > or suspending we ignore the request. Additionally the request is ignore=
d if
> > the CPU is in CPU hot plug. Some common code is refactored so that it c=
an
> > be called from both the CPU hot plug callback and CPU PM notifier takin=
g
> > into account that CPU PM notifiers are called with IRQs disabled wherea=
s
> > CPU hotplug callbacks aren't.
> >
> > Note: this patch has a runtime dependency on adding 'local-timer-stop' =
dt
> > property to the CPU nodes. This informs the time framework to switch to=
 a
> > broadcast timer as the local timer will be shutdown. Without that DT
> > property specified the system hangs in early boot with this patch appli=
ed.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>
> With this applied, I see the following during boot:

Thanks for the lockdep report. It has turned out to be a bit of a
lockdep rabbit hole!
To fix this I've had to: -
1) Update to use raw_spin_lock() variants from the callbacks
2) Set .use_raw_spinlock =3D true  in regmap_smccfg
3) Create a new custom regmap_pmu_intr (instead of relying on the
syscon generated mmio regmap) for the pmu_intr_gen region that sets
.use_raw_spinlock =3D true

>
> [    1.841304][    T0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    1.841422][    T0] [ BUG: Invalid wait context ]
> [    1.841550][    T0] 6.16.0-rc4-next-20250702+ #54 Tainted: G     U    =
      T
> [    1.841727][    T0] -----------------------------
> [    1.841844][    T0] swapper/0/0 is trying to lock:
> [    1.841965][    T0] ffff000800ee84b8 (&pmu_context->cpupm_lock){....}-=
{3:3}
> [    1.842001][    T0] , at: gs101_cpu_pm_notify_callback+0x48/0x100
> [    1.842309][    T0] other info that might help us debug this:
> [    1.842613][    T0] context-{5:5}
> [    1.842987][    T0] 1 lock held by swapper/0/0:
> [    1.843442][    T0]  #0:
> [    1.843859][    T0] ffffafe9d8f1f100
> [    1.844282][    T0]  (
> [    1.844618][    T0] cpu_pm_notifier.lock
> [    1.844980][    T0] ){....}-{2:2}, at: cpu_pm_enter+0x30/0x88
> [    1.845340][    T0] stack backtrace:
> [    1.845855][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G   =
  U          T   6.16.0-rc4-next-20250702+ #54 PREEMPT
> [    1.845878][    T0] Tainted: [U]=3DUSER, [T]=3DRANDSTRUCT
> [    1.845884][    T0] Hardware name: Oriole (DT)
> [    1.845897][    T0] Call trace:
> [    1.845909][    T0]  show_stack+0x24/0x38 (C)
> [    1.845934][    T0]  dump_stack_lvl+0x40/0xc0
> [    1.845949][    T0]  dump_stack+0x18/0x24
> [    1.845956][    T0]  __lock_acquire+0xc68/0xd90
> [    1.845976][    T0]  lock_acquire+0x14c/0x2b8
> [    1.845985][    T0]  _raw_spin_lock+0x54/0x78
> [    1.846011][    T0]  gs101_cpu_pm_notify_callback+0x48/0x100
> [    1.846021][    T0]  notifier_call_chain+0xb0/0x198
> [    1.846046][    T0]  raw_notifier_call_chain_robust+0x50/0xb0
> [    1.846053][    T0]  cpu_pm_enter+0x4c/0x88
> [    1.846063][    T0]  psci_enter_idle_state+0x2c/0x70
> [    1.846078][    T0]  cpuidle_enter_state+0x14c/0x4c0
> [    1.846097][    T0]  cpuidle_enter+0x44/0x68
> [    1.846121][    T0]  do_idle+0x1f0/0x2a8
> [    1.846142][    T0]  cpu_startup_entry+0x40/0x50
> [    1.846152][    T0]  rest_init+0x1c4/0x1d0
> [    1.846161][    T0]  start_kernel+0x358/0x438
> [    1.846181][    T0]  __primary_switched+0x88/0x98
>
> >
> > [...]
> >
> > @@ -444,6 +586,18 @@ static int exynos_pmu_probe(struct platform_device=
 *pdev)
> >                        */
> >                       dev_warn(&pdev->dev, "pmu-intr-gen syscon unavail=
able\n");
> >               } else {
> > +                     pmu_context->hotplug_ing =3D
> > +                             devm_kmalloc_array(dev, num_possible_cpus=
(),
> > +                                                sizeof(bool), GFP_KERN=
EL);
>
> I haven't done a full review, but sizeof(bool) should be rewritten as
> sizeof(*pmu_context->hotplug_ing)

Will fix

>
> > [...]
> >
> > @@ -471,10 +628,32 @@ static int exynos_pmu_probe(struct platform_devic=
e *pdev)
> >       return 0;
> >  }
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +static int exynos_cpupm_suspend_noirq(struct device *dev)
> > +{
> > +     atomic_set(&pmu_context->sys_suspended, 1);
> > +     return 0;
> > +}
> > +
> > +static int exynos_cpupm_resume_noirq(struct device *dev)
> > +{
> > +     atomic_set(&pmu_context->sys_suspended, 0);
> > +     return 0;
> > +}
> > +
> > +static const struct dev_pm_ops cpupm_pm_ops =3D {
> > +     .suspend_noirq =3D exynos_cpupm_suspend_noirq,
> > +     .resume_noirq =3D exynos_cpupm_resume_noirq,
> > +};
> > +#endif
> > +
> >  static struct platform_driver exynos_pmu_driver =3D {
> >       .driver  =3D {
> >               .name   =3D "exynos-pmu",
> >               .of_match_table =3D exynos_pmu_of_device_ids,
> > +#ifdef CONFIG_PM_SLEEP
> > +             .pm =3D &cpupm_pm_ops,
> > +#endif
>
> This can use pm_sleep_ptr() instead to avoid the ifdef.

Will fix.

Thanks,

Peter

