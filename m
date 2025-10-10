Return-Path: <linux-kernel+bounces-847947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE29DBCC238
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 887B54F07A2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CFC25A655;
	Fri, 10 Oct 2025 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s85p5hys"
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F734BA44
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085051; cv=none; b=YTSFGBcyoMPO5EaaXWSrhjtKxHQWOtaMP1RmGyRIjcYw1P/Z3zrUaRPmg9ABYeRFHDrcTjiR2QR0x4B1UguZIR0JLOB+36Yp9yfF1HVSpxHfrVEgkLERHWV5BWlGIKxT8V1YKW6A4NXMkOiLdXrcUCChchPGagkX2LRpwoZfyTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085051; c=relaxed/simple;
	bh=wctb4CCPOsVlg4MBcIeDFfStXaSUm2uLp61kJxrLTi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXcxbOsMPgbhR7uRoLJzU1zDAj9z1j+s5fyi/Ypvt5iu/K8lBrgQMiUBdHyA5B5NUsGg9xEeaEAecjZRoDuYbYQjyJtrl55YH+j/hzVHUqHmawQH6WhjysBeTuQkCdBec65ByKv7TfTyrKpNa+9YSxINAmXB1euN8OONvF6tRXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s85p5hys; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6353ff1a78dso1748702d50.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 01:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760085048; x=1760689848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M7/UvMP8pF2d0Di4W7qdfx/D73nsmwZpf5H8xyBvB+I=;
        b=s85p5hys2GJk4R2j/PSaXILtwxCSyOg9r3/u8A6IxWeo9STlzUQ5D52W8RVN3MbLIv
         lrUjsx30TPlYGhavLa53XBOOhVODHyb77OzdhjLfWqBTSoCTS9ZqFucHpiwrYr7hSin4
         2aUf1CX1QRuDez1k1ic9ArED8oqmZhPgEqmhY2iwZe6Iws9IvCkF1SFYMQmC4JhXGQVC
         fw0EWxXartvzR2LMkEllyw00cAKOVn27Im18yjXJH4Uaoa2CxskdOs4Jvpg5BWulmhcw
         tkk1nqsJYO4V6bDvAkw4mT6QPLwA1/ssxvJTOeqtMNkfTtmCy9pg3BiLi4vyHR1VXC5e
         HBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760085048; x=1760689848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7/UvMP8pF2d0Di4W7qdfx/D73nsmwZpf5H8xyBvB+I=;
        b=bl8f7t60o+w21hSdL9v26J+CDVOe+i51Pqkof9i3EYbbjSSykMvz3cEPjU/RNQBv8M
         BnMnIlF3eq2l58jQLiQZtjfrivzZcsWCIDsz8D+8dVg5t81KPicF2dfTtCrBle67PJHW
         rKdCBLeHpBeOpM/rpniFcLIoNwDYhwDa6MeS3yJPJv+StoaYzGNZTnSZHpZzp3zotzTD
         2Hlj3Vfa7ujpurbiLJwZJmTDjYqP2u+zDDiLTmfX3/1uxh0R5qYeDwIhzSm+CtTfACnb
         WPYiSRw28dEUS7ECSxA4+sw627WmyxJTx8TIAiNG64LVlDdQPvkWcZrVv1nartaRRUA2
         3JUg==
X-Forwarded-Encrypted: i=1; AJvYcCWFEi4nMZepQsXVJZVKRFZ7prawK1qsbtDqOj+9rUP+e0YxpH6cBkdlxSnOc/HYQQIZ3+82Ar8JXE2EQdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQyA0ep33DGWb05gyBxotVVOlRaAajUs9is/SWHlB1vM0tMHpN
	VCxs1s1Xy53ouEHw1IDSYxU1QBbdo85CxzJ3JjN06uPVHzD4jR44AH1J31orvSgqfBIwqEIPR8Z
	kzzrhGR2uhVqaKFiyAUJxP3Y072lXRKMhTOhIHN/KpA==
X-Gm-Gg: ASbGncuvUyfVGqWwUZog3WG4CG/g2wLRFwY7ef60tj7XmdNy5M6KVxiOdRulUenok0H
	LsfVOQ9DXeRBnNAlYprAEDkbOlaQ81D57r15FZ7tDamstASaKE0cLt+crVtL1TKcIcFipIaiE36
	KgYcyQ/F4f4R6EIZ2lLlfJgt+nbBy58971lp0fhLI//XiKxOssZRdiFzqw4wUiPBPH1NI9C9tD7
	9S9ajG8GCOy/dPVu8XeXtB4HETtL2PAO4TlhQ7MoQ==
X-Google-Smtp-Source: AGHT+IELcVFwUCUEmhVUGDnSnGJlpWYHNQOXe5296t/FoFUefz+C1OeDjmmVZXYWz/J3fiD3QdzX5PFMMDEjuQIT79o=
X-Received: by 2002:a05:690e:1a99:b0:63b:a4fa:202e with SMTP id
 956f58d0204a3-63ccb8db942mr7870853d50.41.1760085047581; Fri, 10 Oct 2025
 01:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003150251.520624-1-ulf.hansson@linaro.org>
 <20251003150251.520624-3-ulf.hansson@linaro.org> <865xcsyqgs.wl-maz@kernel.org>
In-Reply-To: <865xcsyqgs.wl-maz@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 10 Oct 2025 10:30:11 +0200
X-Gm-Features: AS18NWBt9HOnP-sXI05iFB0KpurINCBSnZcmko0s_eAswoddpw0G_kSGehKntmY
Message-ID: <CAPDyKFq4RgL0=hPhB0cwTQF-A+mXH8dxsZAYTB1CFuLxxxTujg@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: smp: Implement cpus_has_pending_ipi()
To: Marc Zyngier <maz@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Maulik Shah <quic_mkshah@quicinc.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 17:55, Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 03 Oct 2025 16:02:44 +0100,
> Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > To add support for keeping track of whether there may be a pending IPI
> > scheduled for a CPU or a group of CPUs, let's implement
> > cpus_has_pending_ipi() for arm64.
> >
> > Note, the implementation is intentionally lightweight and doesn't use any
> > additional lock. This is good enough for cpuidle based decisions.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  arch/arm64/kernel/smp.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index 68cea3a4a35c..dd1acfa91d44 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -55,6 +55,8 @@
> >
> >  #include <trace/events/ipi.h>
> >
> > +static DEFINE_PER_CPU(bool, pending_ipi);
> > +
> >  /*
> >   * as from 2.5, kernels no longer have an init_tasks structure
> >   * so we need some other way of telling a new secondary core
> > @@ -1012,6 +1014,8 @@ static void do_handle_IPI(int ipinr)
> >
> >       if ((unsigned)ipinr < NR_IPI)
> >               trace_ipi_exit(ipi_types[ipinr]);
> > +
> > +     per_cpu(pending_ipi, cpu) = false;
> >  }
> >
> >  static irqreturn_t ipi_handler(int irq, void *data)
> > @@ -1024,10 +1028,26 @@ static irqreturn_t ipi_handler(int irq, void *data)
> >
> >  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
> >  {
> > +     unsigned int cpu;
> > +
> > +     for_each_cpu(cpu, target)
> > +             per_cpu(pending_ipi, cpu) = true;
> > +
>
> Why isn't all of this part of the core IRQ management? We already
> track things like timers, I assume for similar reasons. If IPIs have
> to be singled out, I'd rather this is done in common code, and not on
> a per architecture basis.

The idea was to start simple, avoid running code for architectures
that don't seem to need it, by using this opt-in and lightweight
approach.

I guess we could do this in generic IRQ code too. Perhaps making it
conditional behind a Kconfig, if required.

>
> >       trace_ipi_raise(target, ipi_types[ipinr]);
> >       arm64_send_ipi(target, ipinr);
> >  }
> >
> > +bool cpus_has_pending_ipi(const struct cpumask *mask)
> > +{
> > +     unsigned int cpu;
> > +
> > +     for_each_cpu(cpu, mask) {
> > +             if (per_cpu(pending_ipi, cpu))
> > +                     return true;
> > +     }
> > +     return false;
> > +}
> > +
>
> The lack of memory barriers makes me wonder how reliable this is.
> Maybe this is relying on the IPIs themselves acting as such, but
> that's extremely racy no matter how you look at it.

It's deliberately lightweight. I am worried about introducing
locking/barriers, as those could be costly and introduce latencies in
these paths.

Still this is good enough to significantly improve cpuidle based
decisions in this regard. Please have a look at the commit message of
patch3.

That said, for sure I am open to suggestions on how to improve the
"racyness", while still keeping it lightweight.

Kind regards
Uffe

