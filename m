Return-Path: <linux-kernel+bounces-734808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2A8B0868A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D374D189E4E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B521225A4F;
	Thu, 17 Jul 2025 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NOuXmQ6t"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24872248BF
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737105; cv=none; b=TekNd/Q4G9aEEkwW4wUHx+uPZEv8RkHt7W4uW1uQ6yZYdI6zuOli5/dRrRTUfLdAk5P60YImP4u20HlAt7hIx2b5Ayp72+vAl9YFboY1KJFNGgJcPv9V4tcPvz/DXUbLm/lSmGX6kE4hY8ly31+tqcwKGJhgWM9K45m5MIcxnzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737105; c=relaxed/simple;
	bh=Gyrr6czyof+CG/WoQJ4Juc3W7orjc65KwRKgFjDWelc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6z/wF8bfGsyQ2NVxIJW2lcDNEgdrhKIvR+eSsOiraHguzHiYmVeSkF7v9CNeQtAuvM+h2p0j0vtTOM9lsZfSh0VtlSowiyJhbhS4JHl0tCjWnDJ0BMXeQDS5GSVAhX7tka1rG6MRO3D+33gX0y99oTA7saDezCFivYUeBGdh7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=NOuXmQ6t; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8bd2eae9e0so578248276.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1752737103; x=1753341903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZO3PPY2XBP748YrMIC0vrtHH5fS4RDPrIYRbHrH2g8=;
        b=NOuXmQ6tzLP9j/BpBplCSvBlB5bZbYmSSwHIHO7XEZbfbASzDBIQyL/PEmWIBehzlx
         l2EQw7Y15USB3bCU5OAzJTgoPbziWNB+JHNTDRmFqI92EMRCrujG7CM3IuCvCrdZFRL9
         reBAJGff8FmgVCUBMUEtap/PMqRfcM35OTq+UIoBSws4rFPvxa9RtaHVrEwi10X19jp1
         vIErf9iz651YmAvmcfrVKfNQpPFguFhVrMLDO839k2M3auUBE7rWweGRq+gnR3EcffTL
         f/uktwOcZlJe7p9ny8FU1U6+fThtI3G9WKQK55pZaO9OItNtywQLoSrhcEPQPEBi6rSC
         Jc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737103; x=1753341903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZO3PPY2XBP748YrMIC0vrtHH5fS4RDPrIYRbHrH2g8=;
        b=lHDWi57CWNbSYOQWaDJ2ml8CsWzwXRMggx7V571XMNqnBuYOjYlMD1cMOonkggvAfo
         Pj+XQdCUuCjzSps7IXVovjX04aPL/aQbmDl9M0tEpXJEoh1ten/M/TbwY0q+HVth9tYN
         whQIWiigfVd9mrd0sFNfqz9zJeIiDK4QnhmMKTboGGKXJs59L01GDMJTiZEyXkd8MB9P
         urrr1Jpf8JO2sDXgxP2R2yFa3Q4V6ctwkaSvoD8xTkrAnZ6S4V0i50cNvsHLkYnozsT5
         6YZVrg1fS3AtT/DVBb6WbZWBqU3TEMlVEFPURhs+lO5h1sbtiQ+EEK1DuECCxqOT0HIK
         Bp+g==
X-Forwarded-Encrypted: i=1; AJvYcCWFdb45YbO1WPn+KNJL1rj8ct80MbZUHBzcUm6p9wwbY956MwNV8IV7cUkwxKUFDPtIYfg//iD4EOyU4x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrEEGJcZbQj07Qey7uWzE9V6eV4DvjeE7LYqJjoPGa//+u6rzi
	CCwNVgLFCHybvc7/sneSgohuLdPmSoq3wkwyvyWLgul1erF34O5UyFh6NFvE3autK7BdwrOCYAa
	O9sZTbBns5mIC+vj5oXvkuhep+IuweCjHj0u/p2vHAA==
X-Gm-Gg: ASbGncvLnB0A4NwEpwDW8Hmy3l3xcT3ZE1K0GkkBLF9/akO21QEPLojZwnxqUoaSlNr
	GGPPpHDTX8cF8K3ux4kV6TWRpfehJx66F1xty1p9M4CJ8nVVKu9SL0gNdu6uvNzxwlASYGTS5RS
	YSYO9LRpIqojZ5qo8ncMEYUAYegnIEZsszmzRwqBtuBGS0xKZddbKKwW3+2VCZR33GyN9ecxZj2
	xJKasekCA==
X-Google-Smtp-Source: AGHT+IHbHhPYYb+k831eazsYDNt1rPOncGE6SqrWC+YnWF0atILZMfYXZRzierPS88Y0Mp8rI/N8+hI6L8iMWb3zj3o=
X-Received: by 2002:a05:6902:2b12:b0:e89:85ba:2197 with SMTP id
 3f1490d57ef6-e8bc246bb0fmr6368800276.19.1752737102417; Thu, 17 Jul 2025
 00:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709025516.28051-1-nick.hu@sifive.com> <20250709025516.28051-2-nick.hu@sifive.com>
 <CAAhSdy2J6C8LvBCB0LKd2np47qBQ2EFXXnDvb2OjYKqSOF7EbQ@mail.gmail.com>
In-Reply-To: <CAAhSdy2J6C8LvBCB0LKd2np47qBQ2EFXXnDvb2OjYKqSOF7EbQ@mail.gmail.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 17 Jul 2025 15:24:51 +0800
X-Gm-Features: Ac12FXxQ4tgNQntiZzQuZ4AONH_MLogmY5rpxtlHgkk0sUx63aRfaZn6OnTU0yk
Message-ID: <CAKddAkAOeoKZ9A7t4eK5JPN0xaVPBojCeY0X9khu-b=irE5=JQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip/riscv-imsic: Restore the IMSIC registers
To: Anup Patel <anup@brainfault.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 1:15=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> On Wed, Jul 9, 2025 at 8:26=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote=
:
> >
> > When the system woken up from the low power state, the IMSIC might be i=
n
> > the reset state. Therefore adding the CPU PM callbacks to restore the
> > IMSIC register when the cpu resume from the low power state.
> >
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > Reviewed-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > Reviewed-by: Cyan Yang <cyan.yang@sifive.com>
> > ---
> >  drivers/irqchip/irq-riscv-imsic-early.c | 41 ++++++++++++++++++++-----
> >  1 file changed, 33 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/=
irq-riscv-imsic-early.c
> > index d9ae87808651..f64d9a0642bb 100644
> > --- a/drivers/irqchip/irq-riscv-imsic-early.c
> > +++ b/drivers/irqchip/irq-riscv-imsic-early.c
> > @@ -7,6 +7,7 @@
> >  #define pr_fmt(fmt) "riscv-imsic: " fmt
> >  #include <linux/acpi.h>
> >  #include <linux/cpu.h>
> > +#include <linux/cpu_pm.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/irq.h>
> > @@ -109,14 +110,8 @@ static void imsic_handle_irq(struct irq_desc *desc=
)
> >         chained_irq_exit(chip, desc);
> >  }
> >
> > -static int imsic_starting_cpu(unsigned int cpu)
> > +static void imsic_restore(void)
> >  {
> > -       /* Mark per-CPU IMSIC state as online */
> > -       imsic_state_online();
> > -
> > -       /* Enable per-CPU parent interrupt */
> > -       enable_percpu_irq(imsic_parent_irq, irq_get_trigger_type(imsic_=
parent_irq));
> > -
> >         /* Setup IPIs */
> >         imsic_ipi_starting_cpu();
> >
> > @@ -128,6 +123,19 @@ static int imsic_starting_cpu(unsigned int cpu)
> >
> >         /* Enable local interrupt delivery */
> >         imsic_local_delivery(true);
> > +}
> > +
> > +static int imsic_starting_cpu(unsigned int cpu)
> > +{
> > +       /* Mark per-CPU IMSIC state as online */
> > +       imsic_state_online();
> > +
> > +       /* Enable per-CPU parent interrupt */
> > +       enable_percpu_irq(imsic_parent_irq,
> > +                         irq_get_trigger_type(imsic_parent_irq));
> > +
> > +       /* Restore the imsic reg */
> > +       imsic_restore();
> >
> >         return 0;
> >  }
> > @@ -143,6 +151,23 @@ static int imsic_dying_cpu(unsigned int cpu)
> >         return 0;
> >  }
> >
> > +static int imsic_notifier(struct notifier_block *self, unsigned long c=
md,
> > +                         void *v)
>
> s/imsic_notifier/imsic_pm_notifier/
>
Will update it in the next version. Thanks

Regards,
Nick
> The "void *v" parameter can be on the same line as function declaration.
>
> > +{
> > +       switch (cmd) {
> > +       case CPU_PM_EXIT:
> > +               /* Restore the imsic reg */
> > +               imsic_restore();
> > +               break;
> > +       }
> > +
> > +       return NOTIFY_OK;
> > +}
> > +
> > +static struct notifier_block imsic_notifier_block =3D {
>
> s/imsic_notifier_block/imsic_pm_notifier_block/
>
> > +       .notifier_call =3D imsic_notifier,
> > +};
> > +
> >  static int __init imsic_early_probe(struct fwnode_handle *fwnode)
> >  {
> >         struct irq_domain *domain;
> > @@ -180,7 +205,7 @@ static int __init imsic_early_probe(struct fwnode_h=
andle *fwnode)
> >         cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_IMSIC_STARTING, "irqchip/r=
iscv/imsic:starting",
> >                           imsic_starting_cpu, imsic_dying_cpu);
> >
> > -       return 0;
> > +       return cpu_pm_register_notifier(&imsic_notifier_block);
> >  }
> >
> >  static int __init imsic_early_dt_init(struct device_node *node, struct=
 device_node *parent)
> > --
> > 2.17.1
> >
>
> Otherwise, this looks good to me.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Regards,
> Anup

