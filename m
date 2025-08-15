Return-Path: <linux-kernel+bounces-770391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2633B27A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C4EB5C33DA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56856267AF6;
	Fri, 15 Aug 2025 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="N94eDJr4"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A01F03C7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243253; cv=none; b=qYYWA0AgLH4kNvlBUnNmy8ctjouAMRiluxSemC/1cnxpLZ+MM1yTGq/wBSUteoPyRobcOCCF8KXxwOzsoFkr+4Y9fnoP0quiYb44Zo/3FcUtf4fv6WRjEf8plyXI0EWmZeLQak46XOv7f9SXm6bK53itZzFuxykxB6liXs9eCos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243253; c=relaxed/simple;
	bh=e50c7Uup1z0Upxj5K4vJwXaGy2wQmlZze5SoekmVLMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p67PJi/04S79CKqOKQCNTh8/ft7kNC3PJIKxMNROGaR+KIEKVPTvbfsJ6brlKA91FhDCFvNfF2QXTREZC6zk4RK2+agCGmfJZPtKUxtEX8n9jpdI5tIitJJP+hQuDg05hpQOxHLjHI0jXDYrKAXdK8OvrBJis8DCtBU8A5Mahh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=N94eDJr4; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71e6eb64991so1531937b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1755243249; x=1755848049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92PkWaFX23l+UZkNLsil3/CxaHPOnZgxH7QivRtJkSA=;
        b=N94eDJr4AzQ0qOhyyB6VHyu2Qup4Q3gUzqrFBHFIlzzOf4vVB7RnRjN+e+rpE9Q0xn
         HaB+wJhkyAQc8fEpwOXrAbdkTuSqlSFa3L52vnH5lx+N9YMmaLBsG/OgQ/wf3SpztdZH
         UvulK+Zg75ieNNnZipVyuV9aQ0lfiAnFzCu0Fd0ASDlL/z3F7WlMyr9W4tUf30s8dJiv
         on8WW8fpbaNEHx0twLOIVrTucK66dNlurKuTikMKn0/aSn0JGEIppI9FpfLkGHtgYV1N
         sS+Z4/qm/4we0Y/1Xqz3MHHySqaGKmhTigY02RkVHj8qyCpRRZIIonXcS61LfVbeVITZ
         LT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755243249; x=1755848049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92PkWaFX23l+UZkNLsil3/CxaHPOnZgxH7QivRtJkSA=;
        b=LZBkcC7TwezpY7R00+iPHhGPzhYATxAiK6i/jDu9STvPXHE0M0T6y0q7WZlkUoQdI1
         APmyBS8G5fXx9H7PPEmfTBJ9ZFFFQHVYHpLbxYvVRUf4h4lri4oCOjBOEUczwge9ye2z
         QVzHCHGPZOJfJUTt6qtOwBux+ucaD4nEFgt7hDjLQ5xm0l+zamENnXWiW/0tkZ8BnabW
         q0opr1KixtlV8kqEGQDdr/NhAJYpxtQtzbpjaRe+JaQWLL0E4K4SdSUqMXCkwVKNG+w9
         P3o2T7m9qHNzBjTGQLfGw7EOsI5rzw12xZ2E9rnHjsmvpe6FpUkTPi1X7+YRnyEOAaME
         R2tA==
X-Forwarded-Encrypted: i=1; AJvYcCVrsv28gyI0W6JIKeH/odYxqAb0qPtEJ6UGLlwd/cKehDA3yCjbVpy/7BGYKz7K/lpAie+lTt5hy97JG+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznv1nvUCWrKp4gBoutyxW4qWfC7ayDGHEyKbv47T4nYkG21/7D
	UIEHSkt/JA2TUeWVSQS/ChurNmWOLCeVAtUt4E13Nxnpt7Fo4QQ5/3nVVRfMh+PDXbGCfgjFMBZ
	yfF5MfAmDrR1FXTjV+HrQgMkJIMac2YNPzrfKOYWE3g==
X-Gm-Gg: ASbGnctmK49qy7ArOB6rBesmvndBFhx7YIPttneGE1IDM8i/SQKIxd+NuUTzbOeN3e8
	loxnwkzoziA/UH+0J5Q4z+RjAYgMk2kNFVbABAPOItfDjeNqjv2fFDy9EqYc760nq3u6sITk7wI
	47IEYIqSdBWbYKYb7I+ysg4hXwe67CKtoqofOkoZc6zlEWBa876noHXM8K/NmWvJ9IzTcCtueyZ
	ZskJOtIMg==
X-Google-Smtp-Source: AGHT+IH2LFFegs5JS9UiuhUCPayCqDGf++Ze7qnjUj1rm/x6t7ji4MvPzt0QjO9ZTprrztOcJcseBYfT7JweI6K0E8M=
X-Received: by 2002:a05:690c:f82:b0:71c:333:d6a3 with SMTP id
 00721157ae682-71e6d900809mr13519537b3.0.1755243248798; Fri, 15 Aug 2025
 00:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806082726.8835-1-nick.hu@sifive.com> <20250806082726.8835-3-nick.hu@sifive.com>
 <875xf0eho8.ffs@tglx>
In-Reply-To: <875xf0eho8.ffs@tglx>
From: Nick Hu <nick.hu@sifive.com>
Date: Fri, 15 Aug 2025 15:33:57 +0800
X-Gm-Features: Ac12FXznVlEEwxlbZmzL1Q0VWN4b55cFLcy580QOm-2zbP0ENMsPRMda359wA5Y
Message-ID: <CAKddAkC11Hr=5jVpYvoMd2FeKvULn8mHcuey3=0DGEjAf7Q+8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] irqchip/riscv-aplic: Save and restore APLIC registers
To: Thomas Gleixner <tglx@linutronix.de>
Cc: anup@brainfault.org, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 8:52=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Wed, Aug 06 2025 at 16:27, Nick Hu wrote:
> > The APLIC may be powered down when the CPUs enter a deep sleep state.
> > Therefore adding the APLIC save and restore functions to save and
> > restore the states of APLIC.
>
> Same comments vs. subject and change log.
>
> >
> > +void aplic_direct_restore(struct aplic_priv *priv)
> > +{
> > +     struct aplic_direct *direct =3D
> > +                     container_of(priv, struct aplic_direct, priv);
>
> No line break required.
>
> > +     int cpu;
> > +
> > +     for_each_cpu(cpu, &direct->lmask)
> > +             aplic_idc_set_delivery(per_cpu_ptr(&aplic_idcs, cpu), tru=
e);
> > +static LIST_HEAD(aplics);
> > +
> > +static void aplic_restore(struct aplic_priv *priv)
> > +{
> > +     int i;
> > +     u32 clrip;
>
> See the documentation I linked you to and look for the chapter about
> variable declarations.
>
> > +     writel(priv->saved_domaincfg, priv->regs + APLIC_DOMAINCFG);
> > +#ifdef CONFIG_RISCV_M_MODE
> > +     writel(priv->saved_msiaddr, priv->regs + APLIC_xMSICFGADDR);
> > +     writel(priv->saved_msiaddrh, priv->regs + APLIC_xMSICFGADDRH);
> > +#endif
> > +     for (i =3D 1; i <=3D priv->nr_irqs; i++) {
> > +             writel(priv->saved_sourcecfg[i - 1],
> > +                    priv->regs + APLIC_SOURCECFG_BASE +
> > +                    (i - 1) * sizeof(u32));
> > +             writel(priv->saved_target[i - 1],
> > +                    priv->regs + APLIC_TARGET_BASE +
> > +                    (i - 1) * sizeof(u32));
>
> Sorry, but this is incomprehensible garbage.
>
> Why are you starting with i =3D 1 when you subtract 1 from i at every
> usage site?
>
The AIA specification states, =E2=80=9CThe number zero is not a valid
interrupt identity number at an APLIC,=E2=80=9D
so I thought it was intuitive to start with i =3D 1 up to
`priv->nr_irqs`. However, you are right, I should start
from 0 so the index doesn=E2=80=99t need to be offset by 1 in every iterati=
on.

>         u32 __iomem *regs =3D priv->regs;
>         for (i =3D 0; i < priv->nr_irqs; i++, regs++) {
>                 writel(priv->saved_sourcecfg[i], regs + APLIC_SOURCECFG_B=
ASE);
>                 writel(priv->saved_target[i], regs + APLIC_TARGET_BASE);
>         }
>
> See?
>
> > +     }
> > +
> > +     for (i =3D 0; i <=3D priv->nr_irqs; i +=3D 32) {
>
> Off by one. This needs to be i < priv->nr_irqs, no?
>
We need to preserve bits 1 through priv->nr_irqs of the SETIE
register, so this should be i <=3D priv->nr_irqs.

> > +             writel(-1U, priv->regs + APLIC_CLRIE_BASE +
> > +                         (i / 32) * sizeof(u32));
> > +             writel(priv->saved_ie[i / 32],
> > +                    priv->regs + APLIC_SETIE_BASE +
> > +                    (i / 32) * sizeof(u32));
> > +     }
> > +
> > +     if (priv->nr_idcs) {
> > +             aplic_direct_restore(priv);
> > +     } else {
> > +             /* Re-trigger the interrupts */
> > +             for (i =3D 0; i <=3D priv->nr_irqs; i +=3D 32) {
>
> Same here
>
> > +                     clrip =3D readl(priv->regs + APLIC_CLRIP_BASE +
> > +                                   (i / 32) * sizeof(u32));
> > +                     writel(clrip, priv->regs + APLIC_SETIP_BASE +
> > +                                   (i / 32) * sizeof(u32));
> > +             }
>
> And this can properly be combined into:
>
>         u32 __iomem *regs =3D priv->regs;
>
>         for (i =3D 0; i < priv->nr_irqs; i +=3D 32, regs++) {
>                 writel(-1U, regs + APLIC_CLRIE_BASE);
>                 writel(priv->saved_ie[i / 32], regs + APLIC_SETIE_BASE);
>
>                 if (!priv->nr_idcs)
>                         writel(readl(regs + APLOC_CLRIP_BASE), regs + APL=
IC_SETIP_BASE);
>         }
>
>         if (priv->nr_idcs)
>                 aplic_direct_restore(priv);
>
> No?
>
I'll update it in the next version.

> > +}
> > +
> > +static void aplic_save(struct aplic_priv *priv)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 1; i <=3D priv->nr_irqs; i++) {
> > +             priv->saved_target[i - 1] =3D readl(priv->regs +
> > +                                               APLIC_TARGET_BASE +
> > +                                               (i - 1) * sizeof(u32));
> > +     }
>
> Oh well...
>
> > +
> > +     for (i =3D 0; i <=3D priv->nr_irqs; i +=3D 32) {
>
> Off by one again ...
>
> > +             priv->saved_ie[i / 32] =3D readl(priv->regs +
> > +                                            APLIC_SETIE_BASE +
> > +                                            (i / 32) * sizeof(u32));
> > +     }
> > +}
> > +
> > +static int aplic_syscore_suspend(void)
> > +{
> > +     struct aplic_priv *priv;
> > +
> > +     list_for_each_entry(priv, &aplics, head) {
> > +             aplic_save(priv);
> > +     }
>
> Superflous brackets
>
> > +
> > +     return 0;
> > +}
> > +
> > +static void aplic_syscore_resume(void)
> > +{
> > +     struct aplic_priv *priv;
> > +
> > +     list_for_each_entry(priv, &aplics, head) {
> > +             aplic_restore(priv);
> > +     }
>
> Ditto
>
> > +}
> > +
> > +static struct syscore_ops aplic_syscore_ops =3D {
> > +     .suspend =3D aplic_syscore_suspend,
> > +     .resume =3D aplic_syscore_resume,
>
> See documentation about struct definitions and initializers
>
> > +};
> > +
> > +static int aplic_pm_notifier(struct notifier_block *nb, unsigned long =
action, void *data)
> > +{
> > +     struct aplic_priv *priv =3D container_of(nb, struct aplic_priv, g=
enpd_nb);
> > +
> > +     switch (action) {
> > +     case GENPD_NOTIFY_PRE_OFF:
> > +             aplic_save(priv);
> > +             break;
> > +     case GENPD_NOTIFY_ON:
> > +             aplic_restore(priv);
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void aplic_remove(void *data)
> > +{
> > +     struct aplic_priv *priv =3D data;
> > +
> > +     list_del(&priv->head);
>
> How is this list operation serialized?
>
I'll add a lock to prevent the race from binding/unbinding the driver
at runtime, Thanks.

> > +     dev_pm_genpd_remove_notifier(priv->dev);
> > +}
> > +
> > +static int aplic_add(struct device *dev, struct aplic_priv *priv)
> > +{
> > +     int ret;
> > +
> > +     list_add(&priv->head, &aplics);
> > +     /* Add genpd notifier */
> > +     priv->genpd_nb.notifier_call =3D aplic_pm_notifier;
> > +     ret =3D dev_pm_genpd_add_notifier(dev, &priv->genpd_nb);
> > +     if (ret && ret !=3D -ENODEV && ret !=3D -EOPNOTSUPP) {
>
> What is this magic about? Lacks explanation and rationale.
>
I=E2=80=99ll add the explanation:
It is okay when the platforms doesn't enable CONFIG_PM_GENERIC_DOMAINS
or define the
`power-domains` property in the APLIC DT node.

> > +             list_del(&priv->head);
> > +             return ret;
>
> ...
>
> > +     /* For power management */
> > +     priv->saved_target =3D devm_kzalloc(dev, priv->nr_irqs * sizeof(u=
32),
> > +                                       GFP_KERNEL);
> > +     if (!priv->saved_target)
> > +             return -ENOMEM;
> > +
> > +     priv->saved_sourcecfg =3D devm_kzalloc(dev, priv->nr_irqs * sizeo=
f(u32),
> > +                                          GFP_KERNEL);
> > +     if (!priv->saved_sourcecfg)
> > +             return -ENOMEM;
> > +
> > +     priv->saved_ie =3D devm_kzalloc(dev,
> > +                                   DIV_ROUND_UP(priv->nr_irqs, 32) * s=
izeof(u32),
> > +                                   GFP_KERNEL);
> > +     if (!priv->saved_ie)
> > +             return -ENOMEM;
>
> Seriously? You allocate all of this seperately? Ever heard about the
> concept of data structures?
>
> struct savedregs {
>         u32     target;
>         u32     source;
>         u32     ie;
> };
>
>         priv->savedregs =3D devm_kcalloc(dev, priv->nr_irqs, sizeof(*priv=
->savedregs, GFP_KERNEL);
>
> Yes, I know you don't need as many ie registers, but that's not a
> problem at all. You just need to write/read to/from index 0, 32, 64 ...
>
> And your restore muck boils down to a single loop:
>
>         u32 __iomem *regs =3D priv->regs;
>         for (i =3D 0; i < priv->nr_irqs; i++, regs++) {
>                 writel(priv->savedregs->source[i], regs + APLIC_SOURCECFG=
_BASE);
>                 writel(priv->savedregs->target[i], regs + APLIC_TARGET_BA=
SE);
>
>                 if (i % 32)
>                         continue;
>
>                 writel(-1U, regs + APLIC_CLRIE_BASE);
>                 writel(priv->saved_ie[i], regs + APLIC_SETIE_BASE);
>                 if (!priv->nr_idcs)
>                         writel(readl(regs + APLOC_CLRIP_BASE), regs + APL=
IC_SETIP_BASE);
>         }
>
> That's too comprehensible, right?
>
I can update it to:
         u32 __iomem *regs =3D priv->regs;
         for (i =3D 0; i <=3D priv->nr_irqs; i++) {
                 if (i < priv->nr_irqs) {
                         writel(priv->savedregs->source[i], regs +
APLIC_SOURCECFG_BASE + i);
                         writel(priv->savedregs->target[i], regs +
APLIC_TARGET_BASE + i);
                 }

                 if (i % 32)
                         continue;

                 writel(-1U, regs + APLIC_CLRIE_BASE + i / 32);
                 writel(priv->savedregs->ie[i], regs +
APLIC_SETIE_BASE + i  / 32);
                 if (!priv->nr_idcs)
                         writel(readl(regs + APLOC_CLRIP_BASE + i /
32), regs + APLIC_SETIP_BASE + i / 32);
         }

> >  struct aplic_priv {
> > +     struct list_head        head;
>
> Why needs this to be at the top?
>
> There is no reason at all. Not that it matters much as this data
> structure is a trainwreck vs. cacheline efficiency anyway.
>
Does it make sense to you if I put the hot data together ? Like:
        struct aplic_source_regs {
                u32                     *target;
                u32                     *sourcecfg;
                u32                     *ie;
        };

        struct aplic_saved_regs {
                u32                     domaincfg;
        #ifdef CONFIG_RISCV_M_MODE
                u32                     msiaddr;
                u32                     msiaddrh;
        #endif
                struct aplic_source_regs    *srcs
        };

        struct aplic_priv {
                struct list_head        head;
                struct aplic_saved_regs saved_regs;
                void __iomem            *regs;
                u32                     nr_irqs;
                u32                     nr_idcs;
                u32                     gsi_base;
                u32                     acpi_aplic_id;
                struct device           *dev;
                struct aplic_msicfg     msicfg;
                struct notifier_block   genpd_nb;
        };

Or any other suggestion?

> >       struct device           *dev;
> >       u32                     gsi_base;
> >       u32                     nr_irqs;
> > @@ -31,6 +32,15 @@ struct aplic_priv {
> >       u32                     acpi_aplic_id;
> >       void __iomem            *regs;
> >       struct aplic_msicfg     msicfg;
> > +     struct notifier_block   genpd_nb;
> > +     u32 *saved_target;
>
> So you aligned @head and @genpd_nb, but then you use random formatting
> to turn this into visual clutter.
>
Sorry about that.

> I'm amazed that this lot has received three Reviewed-by tags and nobody
> found even the slightest issue with it. Oh well.
>
> Thanks,
>
>         tglx
>

