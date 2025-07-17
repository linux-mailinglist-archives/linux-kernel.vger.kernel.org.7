Return-Path: <linux-kernel+bounces-734813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5A4B08697
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B007B8BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C7D234964;
	Thu, 17 Jul 2025 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="grINJTKI"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D705225A5B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737233; cv=none; b=WSO7O1ubvUXCk3aKrOD44+KZbyONgF4oiRG6IfzRZ1FJEHSfNSL5L3Mbk9xIxSvhAzO9Cx2rblDzWkPit1f9WNkdDPmzAYLvmsQg+BcmbusJn9Ny+NOsMCqfkfOGU44h/0uSyVr6WFwCQPMQzmZcwYdXQhm3oMAmQoZ9PcVTB6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737233; c=relaxed/simple;
	bh=ii/wqUUTgZNJQYw78ykPDYVLVoPccR4XWKY+Gg6q7Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLCyMgHybatxMHG3W4NJIPr1WinAchUMr9L8ZoFNKa+nO01AyCBxJDa9r9G3ozosKbAe/CrGu6FOqfTTVElRVR6rO5v3FyBPEc6BcEpCIGBB57+dVrvvcpD2r/CEC5SsYAZ4qkyvMk+Hb6yohgXqj0LvaTR1SNUYWwMG4193yCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=grINJTKI; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e740a09eb00so611931276.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1752737230; x=1753342030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoF437zPz7dDJpJOTbArcXPJ8/LelD/eabKM5wbWdSQ=;
        b=grINJTKI816eAj4WC/E5uzmfEvJHa5TO6VFtSe50kXKa3y4dJ6YuzUndZR5Qzv5tzA
         8n6G17ALco1QXbm7O6oyYtcbSPVKvYpRJZrqFba5neCKlyv6ZVcgef8wcCdlr3wFCRrw
         k4qrhfw53biWeXlZ4S6ybY5XwBqo3OE5hIpu0ZUb39vMFOFPSE8OjsgqANLEpxEZ5Vjw
         OJBrCwhhpADumK4rZR1Pz/EoVnMuv6RvQ57QZaqOPIHcFgApa9qhxPlz58UjhUewWk52
         u1eYHKGo5Nz763pJeB6ruTFlSUMavdBTmWFnwbYqig/e0467Fw7oex3IYdeqc2IwT6XZ
         BOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737230; x=1753342030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SoF437zPz7dDJpJOTbArcXPJ8/LelD/eabKM5wbWdSQ=;
        b=ltXb8ZsFnD/3uvtKk+b4c59JyM+T/ptTOYvZy6cdcuGcVsGNxdXYdvefhSlzFvcO0Y
         uG04dejcq1uFyTnHsRrQMBB3d/pj0PG5FNcZZNZo+FIj8f4SkLAdRUs48sE7URHb54gq
         fDjkoN7xbe5j0sAupnht0B7ck5S6TdynjCVKKxbzmn8vxhGvhgZQXx+QH+Ly2FunVhj8
         0Qa34LUS3ySybO5t8lDmpq1LKPTl4frWtCRbyjQtSru8FE9fAID2TpT9z/6CTuTr4Oi7
         GKK8I1+qKAQvWgICKhwqVGAtZe15TNzVqM2O+7rk+ZnRvJRWQsso8VrNA1fcnzksrodU
         OtHA==
X-Forwarded-Encrypted: i=1; AJvYcCWY/L0Y8+viPWqMotVUhr/kWefBQdIfZ7KYHgwSp8MR4/7KXIWGO+kBhW8unNNsJnDxpgX7CTOaYSTuycc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxpyH6IPnYv0LQTBDDdyyr5VsrEbHWzpe7mIw20uGM7488sS38
	dvozf5yMpCozZqXb69y864p/nnnIVLbGvJbo5ZU8qfkHu4Wyt20mt+fhhCYeK1qgK/D5Y8jJ5mH
	R6SpAAAksf722hn1Ib0ynXW0lxrSvxrTvkw09ezWD+g==
X-Gm-Gg: ASbGncvFElzSQDRVjPr8eh7hIQjJO19pQg7KhYd4/ak8HRAqBSyKlWjwVKBqDDYRr0B
	1sXexv721GHGJYXEoDEp42Kwa3iJJp88fkr4vurvoeOOAcYG4+eKJ0IB6GOOuSUqp4SIUztVzRL
	k3fxnoU7wQ688sTN9iycvCxDCJPZk2pokuCU697ps4yNyjp8trzFcV/T/fnlVlofJs5e8wuQ08b
	WNE7eRjuqfmEDqbv7v/
X-Google-Smtp-Source: AGHT+IE27ofQ4QelsPwBxrRwEs8qHXOCm0Cnd2yVAEPN6BWAF9uk+ncZYcL65WCuDmTuD7OaGLLmzGjzIqBtddete2c=
X-Received: by 2002:a05:6902:154f:b0:e8b:520f:62b0 with SMTP id
 3f1490d57ef6-e8bc27a868amr7407031276.44.1752737230482; Thu, 17 Jul 2025
 00:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709025516.28051-1-nick.hu@sifive.com> <20250709025516.28051-3-nick.hu@sifive.com>
 <CAAhSdy3SE8wcjaYmQ==HZ9B9qx826=T8dD4bJ9DDtGh_Rrsc4Q@mail.gmail.com>
In-Reply-To: <CAAhSdy3SE8wcjaYmQ==HZ9B9qx826=T8dD4bJ9DDtGh_Rrsc4Q@mail.gmail.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Thu, 17 Jul 2025 15:26:59 +0800
X-Gm-Features: Ac12FXwRWyj-Gkv15XZfvSCm4Mjuk0LX17cPqZ5pTOhB6JMggBsu4ysuMw4-kN4
Message-ID: <CAKddAkDDobykRUe=2SbQCGnyYKjahTOARsCi8dWRs9WMKgZaEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] irqchip/riscv-aplic: Save and restore APLIC registers
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
> > The APLIC may be powered down when the CPUs enter a deep sleep state.
> > Therefore adding the APLIC save and restore functions to save and
> > restore the states of APLIC.
> >
> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
> > Reviewed-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> > Reviewed-by: Cyan Yang <cyan.yang@sifive.com>
> > ---
> >  drivers/irqchip/irq-riscv-aplic-direct.c |  14 ++-
> >  drivers/irqchip/irq-riscv-aplic-main.c   | 143 +++++++++++++++++++++++
> >  drivers/irqchip/irq-riscv-aplic-main.h   |  12 ++
> >  drivers/irqchip/irq-riscv-aplic-msi.c    |   3 +-
> >  4 files changed, 170 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip=
/irq-riscv-aplic-direct.c
> > index 205ad61d15e4..df42f979d02c 100644
> > --- a/drivers/irqchip/irq-riscv-aplic-direct.c
> > +++ b/drivers/irqchip/irq-riscv-aplic-direct.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/bitfield.h>
> >  #include <linux/bitops.h>
> >  #include <linux/cpu.h>
> > +#include <linux/cpumask.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irqchip.h>
> >  #include <linux/irqchip/chained_irq.h>
> > @@ -171,6 +172,16 @@ static void aplic_idc_set_delivery(struct aplic_id=
c *idc, bool en)
> >         writel(de, idc->regs + APLIC_IDC_IDELIVERY);
> >  }
> >
> > +void aplic_direct_restore(struct aplic_priv *priv)
> > +{
> > +       struct aplic_direct *direct =3D
> > +                       container_of(priv, struct aplic_direct, priv);
> > +       int cpu;
> > +
> > +       for_each_cpu(cpu, &direct->lmask)
> > +               aplic_idc_set_delivery(per_cpu_ptr(&aplic_idcs, cpu), t=
rue);
> > +}
> > +
> >  static int aplic_direct_dying_cpu(unsigned int cpu)
> >  {
> >         if (aplic_direct_parent_irq)
> > @@ -343,5 +354,6 @@ int aplic_direct_setup(struct device *dev, void __i=
omem *regs)
> >         dev_info(dev, "%d interrupts directly connected to %d CPUs\n",
> >                  priv->nr_irqs, priv->nr_idcs);
> >
> > -       return 0;
> > +       /* Add the aplic_priv to the list */
> > +       return aplic_add(dev, priv);
> >  }
> > diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/i=
rq-riscv-aplic-main.c
> > index 93e7c51f944a..9054ce7a7256 100644
> > --- a/drivers/irqchip/irq-riscv-aplic-main.c
> > +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> > @@ -12,10 +12,130 @@
> >  #include <linux/of.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/pm_domain.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/printk.h>
> > +#include <linux/syscore_ops.h>
> >
> >  #include "irq-riscv-aplic-main.h"
> >
> > +static LIST_HEAD(aplics);
> > +
> > +static void aplic_restore(struct aplic_priv *priv)
> > +{
> > +       int i;
> > +       u32 clrip;
> > +
> > +       writel(priv->saved_domaincfg, priv->regs + APLIC_DOMAINCFG);
> > +#ifdef CONFIG_RISCV_M_MODE
> > +       writel(priv->saved_msiaddr, priv->regs + APLIC_xMSICFGADDR);
> > +       writel(priv->saved_msiaddrh, priv->regs + APLIC_xMSICFGADDRH);
> > +#endif
> > +       for (i =3D 1; i <=3D priv->nr_irqs; i++) {
> > +               writel(priv->saved_sourcecfg[i - 1],
> > +                      priv->regs + APLIC_SOURCECFG_BASE +
> > +                      (i - 1) * sizeof(u32));
> > +               writel(priv->saved_target[i - 1],
> > +                      priv->regs + APLIC_TARGET_BASE +
> > +                      (i - 1) * sizeof(u32));
> > +       }
> > +
> > +       for (i =3D 0; i <=3D priv->nr_irqs; i +=3D 32) {
> > +               writel(-1U, priv->regs + APLIC_CLRIE_BASE +
> > +                           (i / 32) * sizeof(u32));
> > +               writel(priv->saved_ie[i / 32],
> > +                      priv->regs + APLIC_SETIE_BASE +
> > +                      (i / 32) * sizeof(u32));
> > +       }
> > +
> > +       if (priv->nr_idcs) {
> > +               aplic_direct_restore(priv);
> > +       } else {
> > +               /* Re-trigger the interrupts */
> > +               for (i =3D 0; i <=3D priv->nr_irqs; i +=3D 32) {
> > +                       clrip =3D readl(priv->regs + APLIC_CLRIP_BASE +
> > +                                     (i / 32) * sizeof(u32));
> > +                       writel(clrip, priv->regs + APLIC_SETIP_BASE +
> > +                                     (i / 32) * sizeof(u32));
> > +               }
> > +       }
> > +}
> > +
> > +static void aplic_save(struct aplic_priv *priv)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 1; i <=3D priv->nr_irqs; i++) {
> > +               priv->saved_target[i - 1] =3D readl(priv->regs +
> > +                                                 APLIC_TARGET_BASE +
> > +                                                 (i - 1) * sizeof(u32)=
);
> > +       }
> > +
> > +       for (i =3D 0; i <=3D priv->nr_irqs; i +=3D 32) {
> > +               priv->saved_ie[i / 32] =3D readl(priv->regs +
> > +                                              APLIC_SETIE_BASE +
> > +                                              (i / 32) * sizeof(u32));
> > +       }
> > +}
> > +
> > +static int aplic_syscore_suspend(void)
> > +{
> > +       struct aplic_priv *priv;
> > +
> > +       list_for_each_entry(priv, &aplics, list) {
> > +               aplic_save(priv);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void aplic_syscore_resume(void)
> > +{
> > +       struct aplic_priv *priv;
> > +
> > +       list_for_each_entry(priv, &aplics, list) {
> > +               aplic_restore(priv);
> > +       }
> > +}
> > +
> > +static struct syscore_ops aplic_syscore_ops =3D {
> > +       .suspend =3D aplic_syscore_suspend,
> > +       .resume =3D aplic_syscore_resume,
> > +};
> > +
> > +static int aplic_notifier(struct notifier_block *nb, unsigned long act=
ion,
> > +                         void *data)
>
> s/aplic_notifier/aplic_pm_notifier/
>
> The "void *data" parameter can be on the same line as function declaratio=
n.
>
> > +{
> > +       struct aplic_priv *priv =3D container_of(nb, struct aplic_priv,=
 genpd_nb);
> > +
> > +       switch (action) {
> > +       case GENPD_NOTIFY_PRE_OFF:
> > +               aplic_save(priv);
> > +               break;
> > +       case GENPD_NOTIFY_ON:
> > +               aplic_restore(priv);
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +int aplic_add(struct device *dev, struct aplic_priv *priv)
> > +{
> > +       int ret;
> > +
> > +       list_add(&priv->list, &aplics);
> > +       /* Add genpd notifier */
> > +       priv->genpd_nb.notifier_call =3D aplic_notifier;
> > +       ret =3D dev_pm_genpd_add_notifier(dev, &priv->genpd_nb);
> > +       if (!ret)
> > +               return devm_pm_runtime_enable(dev);
> > +
> > +       return ret =3D=3D -ENODEV || ret =3D=3D -EOPNOTSUPP ? 0 : ret;
> > +}
> > +
>
> Make aplic_add() as static and directly call it from aplic_setup_priv().
>
> To cleanup upon device removal, use devm_add_action_or_reset().
>
> >  void aplic_irq_unmask(struct irq_data *d)
> >  {
> >         struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> > @@ -59,6 +179,7 @@ int aplic_irq_set_type(struct irq_data *d, unsigned =
int type)
> >         sourcecfg =3D priv->regs + APLIC_SOURCECFG_BASE;
> >         sourcecfg +=3D (d->hwirq - 1) * sizeof(u32);
> >         writel(val, sourcecfg);
> > +       priv->saved_sourcecfg[d->hwirq - 1] =3D val;
> >
> >         return 0;
> >  }
> > @@ -95,6 +216,8 @@ void aplic_init_hw_global(struct aplic_priv *priv, b=
ool msi_mode)
> >                 valh |=3D FIELD_PREP(APLIC_xMSICFGADDRH_HHXS, priv->msi=
cfg.hhxs);
> >                 writel(val, priv->regs + APLIC_xMSICFGADDR);
> >                 writel(valh, priv->regs + APLIC_xMSICFGADDRH);
> > +               priv->saved_msiaddr =3D val;
> > +               priv->saved_msiaddrh =3D valH;
> >         }
> >  #endif
> >
> > @@ -106,6 +229,7 @@ void aplic_init_hw_global(struct aplic_priv *priv, =
bool msi_mode)
> >         writel(val, priv->regs + APLIC_DOMAINCFG);
> >         if (readl(priv->regs + APLIC_DOMAINCFG) !=3D val)
> >                 dev_warn(priv->dev, "unable to write 0x%x in domaincfg\=
n", val);
> > +       priv->saved_domaincfg =3D val;
> >  }
> >
> >  static void aplic_init_hw_irqs(struct aplic_priv *priv)
> > @@ -176,6 +300,23 @@ int aplic_setup_priv(struct aplic_priv *priv, stru=
ct device *dev, void __iomem *
> >         /* Setup initial state APLIC interrupts */
> >         aplic_init_hw_irqs(priv);
> >
> > +       /* For power management */
> > +       priv->saved_target =3D devm_kzalloc(dev, priv->nr_irqs * sizeof=
(u32),
> > +                                         GFP_KERNEL);
> > +       if (!priv->saved_target)
> > +               return -ENOMEM;
> > +
> > +       priv->saved_sourcecfg =3D devm_kzalloc(dev, priv->nr_irqs * siz=
eof(u32),
> > +                                            GFP_KERNEL);
> > +       if (!priv->saved_sourcecfg)
> > +               return -ENOMEM;
> > +
> > +       priv->saved_ie =3D devm_kzalloc(dev,
> > +                                     DIV_ROUND_UP(priv->nr_irqs, 32) *=
 sizeof(u32),
> > +                                     GFP_KERNEL);
> > +       if (!priv->saved_ie)
> > +               return -ENOMEM;
> > +
> >         return 0;
> >  }
> >
> > @@ -209,6 +350,8 @@ static int aplic_probe(struct platform_device *pdev=
)
> >         if (rc)
> >                 dev_err_probe(dev, rc, "failed to setup APLIC in %s mod=
e\n",
> >                               msi_mode ? "MSI" : "direct");
> > +       else
> > +               register_syscore_ops(&aplic_syscore_ops);
> >
> >  #ifdef CONFIG_ACPI
> >         if (!acpi_disabled)
> > diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/i=
rq-riscv-aplic-main.h
> > index b0ad8cde69b1..969319242dbc 100644
> > --- a/drivers/irqchip/irq-riscv-aplic-main.h
> > +++ b/drivers/irqchip/irq-riscv-aplic-main.h
> > @@ -31,6 +31,16 @@ struct aplic_priv {
> >         u32                     acpi_aplic_id;
> >         void __iomem            *regs;
> >         struct aplic_msicfg     msicfg;
> > +       struct notifier_block   genpd_nb;
> > +       struct list_head        list;
>
> Rename "list" as "head" and make it first variable
> in "struct aplic_priv"
>
> > +       u32 *saved_target;
> > +       u32 *saved_sourcecfg;
> > +       u32 *saved_ie;
> > +       u32 saved_domaincfg;
> > +#ifdef CONFIG_RISCV_M_MODE
> > +       u32 saved_msiaddr;
> > +       u32 saved_msiaddrh;
> > +#endif
> >  };
> >
> >  void aplic_irq_unmask(struct irq_data *d);
> > @@ -39,7 +49,9 @@ int aplic_irq_set_type(struct irq_data *d, unsigned i=
nt type);
> >  int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
> >                               unsigned long *hwirq, unsigned int *type)=
;
> >  void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode);
> > +void aplic_direct_restore(struct aplic_priv *priv);
> >  int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void=
 __iomem *regs);
> > +int aplic_add(struct device *dev, struct aplic_priv *priv);
> >  int aplic_direct_setup(struct device *dev, void __iomem *regs);
> >  #ifdef CONFIG_RISCV_APLIC_MSI
> >  int aplic_msi_setup(struct device *dev, void __iomem *regs);
> > diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/ir=
q-riscv-aplic-msi.c
> > index fb8d1838609f..c9b4f7d5e6ea 100644
> > --- a/drivers/irqchip/irq-riscv-aplic-msi.c
> > +++ b/drivers/irqchip/irq-riscv-aplic-msi.c
> > @@ -281,5 +281,6 @@ int aplic_msi_setup(struct device *dev, void __iome=
m *regs)
> >         pa =3D priv->msicfg.base_ppn << APLIC_xMSICFGADDR_PPN_SHIFT;
> >         dev_info(dev, "%d interrupts forwarded to MSI base %pa\n", priv=
->nr_irqs, &pa);
> >
> > -       return 0;
> > +       /* Add the aplic_priv to the list */
> > +       return aplic_add(dev, priv);
> >  }
> > --
> > 2.17.1
> >
>
> Also, please address the issue reported by the kernel test robot.
>
Will apply the above feedback in the next version. Thanks!

Regards,
Nick
> Regards,
> Anup

