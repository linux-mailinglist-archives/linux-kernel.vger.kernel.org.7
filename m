Return-Path: <linux-kernel+bounces-801975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15698B44C42
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABE951C27A54
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF47246BA4;
	Fri,  5 Sep 2025 03:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZIQpQyw4"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B87221265
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 03:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757042847; cv=none; b=djvyIbGCiXG93RORL/bFXMkUQ7zwNHIbRGC3mXgbmywTBC8vuuBJ0noqyxmfzEdD07dROMAHD0BxVRL/A0HJMJt2PO4HSVSVyY0BVMJuqk87zR2k9ytsHpt5MwrdzKyKgt+Ty0QbgxSR/Hhpyje7Qz9OPTJsbIvV750aBIL2hwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757042847; c=relaxed/simple;
	bh=+VXSgIhRAwZIGPzIQ9jTQLIynfEbotiIyagnLddr+s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aph/Penh+MzQMzVnBBzIrhbYUyqO74ybD7cc4wHC+VUbB2itK9kDCkHuAWLRpGDB7N9kKrugnugGcspWNVdv10mDcj5hN30SQaJ/x89Dubh8qd4vrHNKx4Zye8nFigywmxvPOwiV2B/7tVgFjViqhz2Z9uP+9jwfKDpraCk1hMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZIQpQyw4; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61cebce2f78so985505a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 20:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1757042843; x=1757647643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os04syBpjRUYrOuY5Z5ul0OnAt1kwR5e6GPJHPTZohI=;
        b=ZIQpQyw4hPJRxODehY8OAZalmCmNJUNngkzc5B6rwowFxv2xDjACJZuv8gqkC0SiZe
         6aaWZrrr1tDtn8HBaa/TocFbseqFweI5V8LlQLF6b+o23zjVHneQa6Q1AY2OZNUQIYe3
         2wnexWIxWHjcJNdnPERhFzhqP7WHfLOjkb3P3nTRjyPe7m19BvG8YSHRhbKb2rZ+Z4aY
         CrLXR0NlV2oL0XujXiQlswvHg3a4qQEBkMvHs20WW4s8eyIZt2viqQSymzBMXFz5iED7
         ARUbh4ecfCURV9TE2aOHt9Ea4N+VPqatXiHrexBRjRtD4dHhKuvOvq8W0wxleTxy4w+F
         /kYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757042843; x=1757647643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=os04syBpjRUYrOuY5Z5ul0OnAt1kwR5e6GPJHPTZohI=;
        b=dRaNzEPil3mwjO8pky/ALKfYX6/4fi3Koa2Tqjb+UUldZI5+UoIb24kfh+jj8xRn/C
         UGW41WI/jjsG12DZL+JNNzHx+39w5PPzoGQ3WCojcecE2TWaWOTvgRtjA7AOy5WdG+gb
         PYIlL7uVO9maiFir0sGGzBtMmMhBAoHOU1LU2PAblwKLKJPXY04+MSPp+d4BuaTWKVi1
         Ipkbfz2G88Oh+9yQDWV9CUtyDJOBnELDkrFLcFKXp9V/6OPL3aPD8+aDn2+SkJ5Cuoq3
         Or5DhgBscP176fnUjFzM8x9YI1zNK8P9aBJA6vbCo5eSzhE0m4bGWUqatn8DPbg8B0dg
         DKdw==
X-Forwarded-Encrypted: i=1; AJvYcCUd1zuS9cLCWqh8MFWzoOT012QRVqjV/6w07Ohnvjb40v3I+gHncc+RRYcUb7sIsGPR0oVivYN8+jz4t7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx066IBqvVUQu3FYHVp+YLkfaoikjS6FsIWPPxcKua6KhDzJ+nN
	jHRl9DOz52codxPExA21xe8UP+EaERQVnFvkcFisRV+0lVgNmzdurXaDBwQGcZdkNo7maPmIG8l
	q418i1r4CDsU5KB7pVt7JwxcQ4PkwGxobkgzVb7Slvw==
X-Gm-Gg: ASbGncsER6bRzTji9d1E2LYVVmRYD8xJXAJqaWJfBur3nZwUZu+3sCfPqkoC5kcckGo
	4pFZkT1TfB8BhFgo2lPtYDmuelDmwIIGaAAjKvnDlmvp9aM41hKcOptJmxEIV8y8vgriCApQu58
	rDYsM5f5cL1tCvCz6+eMW8aEljoKV+lqsq8bPpaWa4rBfZ+PJqNEKLpe4MToe/HGYv1vtRdXuiR
	e5jmiHSLlUGTDRM00VK
X-Google-Smtp-Source: AGHT+IFTBZLssAj4YEI3yGO9zckI6NIStV+ozblxy5fjUOhfU+lQN15HDXjbRdJYZmz9vJUW1Pms6o2MHeVJKPYWHtY=
X-Received: by 2002:a05:6402:5cd:b0:61d:1443:8599 with SMTP id
 4fb4d7f45d1cf-61d26ec6264mr18308728a12.32.1757042843053; Thu, 04 Sep 2025
 20:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614142156.29420-3-zong.li@sifive.com> <20250901133629.87310-1-ni_liqiang@126.com>
 <CANXhq0ra+yv-Wt_vKTN3+c4StsPQB1vR+=Kp3RVSh0g10Oogqw@mail.gmail.com>
In-Reply-To: <CANXhq0ra+yv-Wt_vKTN3+c4StsPQB1vR+=Kp3RVSh0g10Oogqw@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 5 Sep 2025 11:27:10 +0800
X-Gm-Features: Ac12FXxCOomRzLnISI4mSuIvWFVx9HD9ac2cyQivUPSI8ky_l1yBqci4E2RqAio
Message-ID: <CANXhq0oeUZb7161eJ2z-9aRXSDSmt8P9RpC7QSH4DZ0YvNp_7Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/10] RISC-V IOMMU HPM and nested IOMMU support
To: niliqiang <ni_liqiang@126.com>
Cc: aou@eecs.berkeley.edu, iommu@lists.linux.dev, jgg@ziepe.ca, 
	joro@8bytes.org, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org, 
	chenruisust@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 12:01=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Mon, Sep 1, 2025 at 9:37=E2=80=AFPM niliqiang <ni_liqiang@126.com> wro=
te:
> >
> > Hi Zong
> >
> > Fri, 14 Jun 2024 22:21:48 +0800, Zong Li <zong.li@sifive.com> wrote:
> >
> > > This patch initialize the pmu stuff and uninitialize it when driver
> > > removing. The interrupt handling is also provided, this handler need =
to
> > > be primary handler instead of thread function, because pt_regs is emp=
ty
> > > when threading the IRQ, but pt_regs is necessary by perf_event_overfl=
ow.
> > >
> > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > ---
> > >  drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 65 insertions(+)
> > >
> > > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.=
c
> > > index 8b6a64c1ad8d..1716b2251f38 100644
> > > --- a/drivers/iommu/riscv/iommu.c
> > > +++ b/drivers/iommu/riscv/iommu.c
> > > @@ -540,6 +540,62 @@ static irqreturn_t riscv_iommu_fltq_process(int =
irq, void *data)
> > >   return IRQ_HANDLED;
> > >  }
> > >
> > > +/*
> > > + * IOMMU Hardware performance monitor
> > > + */
> > > +
> > > +/* HPM interrupt primary handler */
> > > +static irqreturn_t riscv_iommu_hpm_irq_handler(int irq, void *dev_id=
)
> > > +{
> > > + struct riscv_iommu_device *iommu =3D (struct riscv_iommu_device *)d=
ev_id;
> > > +
> > > + /* Process pmu irq */
> > > + riscv_iommu_pmu_handle_irq(&iommu->pmu);
> > > +
> > > + /* Clear performance monitoring interrupt pending */
> > > + riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_PM=
IP);
> > > +
> > > + return IRQ_HANDLED;
> > > +}
> > > +
> > > +/* HPM initialization */
> > > +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> > > +{
> > > + int rc;
> > > +
> > > + if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> > > +     return 0;
> > > +
> > > + /*
> > > +  * pt_regs is empty when threading the IRQ, but pt_regs is necessar=
y
> > > +  * by perf_event_overflow. Use primary handler instead of thread
> > > +  * function for PM IRQ.
> > > +  *
> > > +  * Set the IRQF_ONESHOT flag because this IRQ might be shared with
> > > +  * other threaded IRQs by other queues.
> > > +  */
> > > + rc =3D devm_request_irq(iommu->dev,
> > > +               iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMMU_=
IPSR_PMIP)],
> > > +               riscv_iommu_hpm_irq_handler, IRQF_ONESHOT | IRQF_SHAR=
ED, NULL, iommu);
> > > + if (rc)
> > > +     return rc;
> > > +
> > > + return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(iommu=
->dev));
> > > +}
> > > +
> >
> > What are the benefits of initializing the iommu-pmu driver in the iommu=
 driver?
> >
> > It might be better for the RISC-V IOMMU PMU driver to be loaded as a se=
parate module, as this would allow greater flexibility since different vend=
ors may need to add custom events.
> >
> > Also, I'm not quite clear on how custom events should be added if the R=
ISC-V iommu-pmu is placed within the iommu driver.
>
> Hi Liqiang,
> My original idea is that, since the IOMMU HPM is not always present,
> it depends on the capability.HPM bit, if we separate HPM into an
> individual module, I assume that the PMU driver may not have access to
> the IOMMU's complete MMIO region. I=E2=80=99m not sure how we would check=
 the
> capability register in the PMU driver and avoid the following
> situation: capability.HPM is zero, but the IOMMU-PMU driver is still
> loaded because the PMU node is present in the DTS. It will be helpful
> if you have any suggestions on this.
>
> Regarding custom events, since we don=E2=80=99t have the driver data, my
> current rough idea is to add a vendor event map table to list the
> vendor events and use Kconfig to define them respectively. This is
> just an initial thought and may not be the good solution, so feel free
> to share any recommendations. Of course, if we eventually decide to
> move it to drivers/perf as an individual module, then we could use the
> driver data for custom events, similar to what ARM does.

Maybe let's try auxiliary driver framework to resolve this topic in
the next version.

>
> Thanks
>
> >
> >
> > Best regards,
> > Liqiang
> >

