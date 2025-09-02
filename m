Return-Path: <linux-kernel+bounces-795501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48288B3F332
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E7F1A8137E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1642D592D;
	Tue,  2 Sep 2025 04:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RxpTJSae"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBCE19F12A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756785695; cv=none; b=KVJDkij1utHv4UhaCcNROL+TYmT5RaHUKMx5w/Alrhtpfu3NKbP+oG+3jGfDw2YV24qv/270srDdP/dgGfxYvPJwT9odf2xLBvoiUoUVsS0PH97siQFUUlcbbf/wAbtqs9cD9JxPgyrCt1TXcazzeMGRo7u8lJfEOWU8R7+pdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756785695; c=relaxed/simple;
	bh=vKol5aA9zVXJsQDnzmskykPLu50Z0i/zHvnhTkkSTaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDzzhn0lmS5i465S4JgR/uizQdQLTVWWulEMSsD5GZpXT5EW/Me8/jV58n2YW03mZkDPWx79D5+FD8blFpDd1+HtZdOjqFQXTZltDB44+YVsWSc1yVHnrjyFEryRo7MTpi3b2HzHAiZT1OLKcnNDNvtLu2DRcCSsDoSzth2He2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=RxpTJSae; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3f2b6e0b942so21190165ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 21:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1756785692; x=1757390492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0vF3AA+Rkq7nWTBrL0TBSZgMNIOZptEtxBEHlmZxNk=;
        b=RxpTJSaeoUczIcU7azRGB24Dq/oAIGnjrFpfbkWwSnfX+/H13wmECUJzk2jD4BedZI
         MHMqZ6axWHbjlLrJkYBcHCx/IBt028Tuk8RK4jDzUMXVfMQHjtUIV0EOy62napH1uHmv
         bY/c5CYOkKjPwWxwDjqUV/X8wZkEXfvxJDDUc4qoScz17gNuAl5qF3EM6wXdCEi0xp0f
         MSQkcW4vH2L1Ld6ESOlluNpwq41M1krkGXEECe+QQ2iCD2tKu3ivOKa75WjL9jM38d+h
         2AWB5y2d85tD+szkrl3Kl1LCdo08EizDtWZGfkQUp2qAeSJq/xjrtma9a/rzqE49caiY
         jLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756785692; x=1757390492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0vF3AA+Rkq7nWTBrL0TBSZgMNIOZptEtxBEHlmZxNk=;
        b=E4joDn+D+tLDKSDpuucdDy6eDfg+jYGj7GPzknN4NnwnOTHyOOv+ZrG/UQlbAsRW3O
         M9iHXxJ15gLzIbK5EyyajYBsV/370Wy5BYhFILUmKPJcHhGTgfkVtNvh9ZcJjHCbfmC3
         tx1RcwP9QQq7492dj97/iBApMIjS0UUWbrETqw5caj2Bea1HpLOSo8UPS7fdMm5dHx8p
         Aqrh2uaXs4NGM41oRAteH5w1rlvVmUIFv9YxFNi6MyTABqOLb/sZfmnL+DNUvIuAqD0Y
         wSshIQoGY6JjeH0DJaxOEBq80s/lO8WZziYzdw/KosAmGg/NHS7Joz3fHRkaepmtJrkJ
         RVOw==
X-Forwarded-Encrypted: i=1; AJvYcCX5N350sGAUxw7vwfA80s+JkBfOH+EP6+PjDt6uo5hjNFQafIzlCruwt+SYNZgSa1awbKMa1Ld3kWt1LY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyP/B0zUFVjOII3dchA/YRH6svo9+2J7orohKmqmcbtwiXpoE1
	l8+b2RKyDoG0/ZtDQvSsXBFOrH0tSg61lU0pxeTBvjRUUUfme4Qp3m3XcxfQwynId8vAMhpaoVh
	+xsPNlTBJ4RdwJ9QGAcYHXAPO4C+98lYtN3niMU3vJQ==
X-Gm-Gg: ASbGncszYs1325CtNHhsWtOa8I4kVp/szuXowkMxvUA0TfIXSebXIA1k6kL0vDlzlEY
	KrqiGd/t6P5fEfUUfzomXVMr4N0hmP3Jz6y7RDsv2VIqaqk2++kZ2rIKk3cQ24cGPykYYx9Jvv9
	C37r9SHN8eY5rbGzNFQoGFONfZXhGN1YcVmd0vj0mWQgezXvV0MMA+oYZzhFzX1lQ3QtX/kglkF
	qB5V/y53w==
X-Google-Smtp-Source: AGHT+IHyzW+/5sZk3REX6p5gITjtt3mTNs/VjN2Tek/XlWrX+PGuWni51wU7hsEbW1hVZXbmTe8C4BoqMzr7Lu08/nA=
X-Received: by 2002:a05:6e02:4901:b0:3f4:3c3b:5af8 with SMTP id
 e9e14a558f8ab-3f43c3b5b5fmr171695585ab.27.1756785692539; Mon, 01 Sep 2025
 21:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614142156.29420-3-zong.li@sifive.com> <20250901133629.87310-1-ni_liqiang@126.com>
In-Reply-To: <20250901133629.87310-1-ni_liqiang@126.com>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 2 Sep 2025 12:01:19 +0800
X-Gm-Features: Ac12FXwpi8gyi1mSx73Jw2TbBz0hbsvAceRzz4mouXq2z_brh7Py0L56YowF_GU
Message-ID: <CANXhq0ra+yv-Wt_vKTN3+c4StsPQB1vR+=Kp3RVSh0g10Oogqw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/10] RISC-V IOMMU HPM and nested IOMMU support
To: niliqiang <ni_liqiang@126.com>
Cc: aou@eecs.berkeley.edu, iommu@lists.linux.dev, jgg@ziepe.ca, 
	joro@8bytes.org, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org, 
	chenruisust@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 9:37=E2=80=AFPM niliqiang <ni_liqiang@126.com> wrote=
:
>
> Hi Zong
>
> Fri, 14 Jun 2024 22:21:48 +0800, Zong Li <zong.li@sifive.com> wrote:
>
> > This patch initialize the pmu stuff and uninitialize it when driver
> > removing. The interrupt handling is also provided, this handler need to
> > be primary handler instead of thread function, because pt_regs is empty
> > when threading the IRQ, but pt_regs is necessary by perf_event_overflow=
.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 8b6a64c1ad8d..1716b2251f38 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -540,6 +540,62 @@ static irqreturn_t riscv_iommu_fltq_process(int ir=
q, void *data)
> >   return IRQ_HANDLED;
> >  }
> >
> > +/*
> > + * IOMMU Hardware performance monitor
> > + */
> > +
> > +/* HPM interrupt primary handler */
> > +static irqreturn_t riscv_iommu_hpm_irq_handler(int irq, void *dev_id)
> > +{
> > + struct riscv_iommu_device *iommu =3D (struct riscv_iommu_device *)dev=
_id;
> > +
> > + /* Process pmu irq */
> > + riscv_iommu_pmu_handle_irq(&iommu->pmu);
> > +
> > + /* Clear performance monitoring interrupt pending */
> > + riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_PMIP=
);
> > +
> > + return IRQ_HANDLED;
> > +}
> > +
> > +/* HPM initialization */
> > +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> > +{
> > + int rc;
> > +
> > + if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> > +     return 0;
> > +
> > + /*
> > +  * pt_regs is empty when threading the IRQ, but pt_regs is necessary
> > +  * by perf_event_overflow. Use primary handler instead of thread
> > +  * function for PM IRQ.
> > +  *
> > +  * Set the IRQF_ONESHOT flag because this IRQ might be shared with
> > +  * other threaded IRQs by other queues.
> > +  */
> > + rc =3D devm_request_irq(iommu->dev,
> > +               iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IP=
SR_PMIP)],
> > +               riscv_iommu_hpm_irq_handler, IRQF_ONESHOT | IRQF_SHARED=
, NULL, iommu);
> > + if (rc)
> > +     return rc;
> > +
> > + return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(iommu->=
dev));
> > +}
> > +
>
> What are the benefits of initializing the iommu-pmu driver in the iommu d=
river?
>
> It might be better for the RISC-V IOMMU PMU driver to be loaded as a sepa=
rate module, as this would allow greater flexibility since different vendor=
s may need to add custom events.
>
> Also, I'm not quite clear on how custom events should be added if the RIS=
C-V iommu-pmu is placed within the iommu driver.

Hi Liqiang,
My original idea is that, since the IOMMU HPM is not always present,
it depends on the capability.HPM bit, if we separate HPM into an
individual module, I assume that the PMU driver may not have access to
the IOMMU's complete MMIO region. I=E2=80=99m not sure how we would check t=
he
capability register in the PMU driver and avoid the following
situation: capability.HPM is zero, but the IOMMU-PMU driver is still
loaded because the PMU node is present in the DTS. It will be helpful
if you have any suggestions on this.

Regarding custom events, since we don=E2=80=99t have the driver data, my
current rough idea is to add a vendor event map table to list the
vendor events and use Kconfig to define them respectively. This is
just an initial thought and may not be the good solution, so feel free
to share any recommendations. Of course, if we eventually decide to
move it to drivers/perf as an individual module, then we could use the
driver data for custom events, similar to what ARM does.

Thanks

>
>
> Best regards,
> Liqiang
>

