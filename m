Return-Path: <linux-kernel+bounces-734637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE9AB08438
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8075E4A6C59
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 05:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA90E1DC9B1;
	Thu, 17 Jul 2025 05:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="BeYvIPUS"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6F1DE4C2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752729325; cv=none; b=au81SpRZBN+VlWkPeGRMm2u2tnnIJ/+SQMA3DwxmHF06VpEMpZ65TTQPRDnS3MnUFA05XqO+VgYeAVU6gy6pz9OL7J9sWzDQC5M9lmT6O1BhyFsR4vSSd4RbZzvc2mTtZlLM3BRUv67WebzYqpqEL1pZvPepkHup8msh38tGDLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752729325; c=relaxed/simple;
	bh=b4GPk84v3xP3/Mwv2IvMdmxDJoql6eSTH0zijOWYAb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tToq5+rqMcdvm2DIyJwQT2B2goZFV1PoNZXNfJLUhscLDz8n+u83YgxnO8wP2trK06ltgFeg1XRKAXpHd7UktFNivZuN88LwyFBtYl2bEBP8FaCwdSeCY9TEpcEz/2pP7KVEjNdcl83avikZaQrkHBJOq5rGEX9Bz630dJ/ZCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=BeYvIPUS; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-879c737bc03so15753539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 22:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752729322; x=1753334122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8IAPnSKwDQOlGk9G/75tYz76vRg1bqHATIh+iOtDx8=;
        b=BeYvIPUSluEfZOx0qriCKVZ/y6bF9QagCfrWhtB2V/kL9oQUR/Grw1sWSW7yAZEB1d
         HYics26X7B12pEqJhUNuJsM+DcsoOcFB0ltyHTJRjp8NyfhUbFq4tOinj7moiE3VyrG8
         JHrI2ELzOmpSXanvd4ZPglEXlMo+c8KNEGLBsAmuRPMxlyVXmsH1w+6UyJpgDB3vjE5Q
         S5q+PQ6uvDd5S4heqkbC5HqutMG8Jypnvjmgohaimh4XvxEJX806XeLnFwusmxjhA3Wy
         3X9dprDWowrxWZv92iMhJZlSS87v939XV+0bIzw9hJRB/2Dgqz03sTrwIGxrbidjBvA2
         LpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752729322; x=1753334122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8IAPnSKwDQOlGk9G/75tYz76vRg1bqHATIh+iOtDx8=;
        b=S8cdKFZLqKulAuKThmdpBxooO5uIRFhH5g4YZ/57Hket+sbRhafi0UlcA1ROw5AE7k
         s9/aJOrxBQkZNYQy+tMw2WcTD9ZjF86a6ekolHtNijN+waNYFC9vLV/T+agkMsjeMfe8
         PeBK7TNZru7Hsl+SboC9Qvywv1m9ZrJPicfvIjst92vtq07ac0hX81Mt8wpKOtcNYlHa
         sZmlSjJfKWgwd7lnt5CYZ2AgtCHzUYgpixFxeZ38JESjUgvaWSj8Nqna2XToxIly6mVf
         p53vI6yt9G9w5uj+moB/UHVays2bcTugrkCq+PfADxOylqd5YfcFiAuMbYaqAwfhsvLW
         sKeA==
X-Forwarded-Encrypted: i=1; AJvYcCXJK9mMSpjdiMTo3hyxshZzzv8jf5uIGqxEoH7S6CS6QXBMKWOXeAHnChXt/dMpEs72Pv2adFnY7cdLTuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzCqcqF8kfVdLBlg9sdHrTppr1OaAe9QBLsAK/h1wUPuicdTRT
	p3OJkaYuldXDVM3nZB87bI0WkWJdNBPpqkwuNSDUO1Bgnr/Fi62GZ7HaJiJO6Wp3SexyMeJScwr
	ncGyJKR3IP29Qz9UxKGpKNmH0+T/M6jJEoF3iO/HDOg==
X-Gm-Gg: ASbGncvca3G9Ii/6Ys8OTSL9HwjNMNoVpyvEfi3Ql7usQOFaWko2labMuR+6ZCm79u1
	NuMZpNHJZhNSWD90IVtiJ505yKOBsAKibROKmmhdipr3jh0SuwSEZcMYMJNwqVhCgTWo+Rmq9N3
	MQjUXgJlUkEQSv2lLuGZz/eNwVf3Q/7nWZC8SzUlr1WPsTGY/cpllskh4lZs8NvI1pwCxuB0Wrs
	vB9UQ==
X-Google-Smtp-Source: AGHT+IFSaBy7/rXCT6Lk/9EvprSJ8A0I0iPzPP0zknKgIuixQ+5Bs7H/W5B7g4hc3kaViHAi2hdyxMT+RtcGFPo0t5M=
X-Received: by 2002:a05:6602:3e88:b0:867:6680:cfd with SMTP id
 ca18e2360f4ac-879c284b4famr486753139f.1.1752729322103; Wed, 16 Jul 2025
 22:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709025516.28051-1-nick.hu@sifive.com> <20250709025516.28051-3-nick.hu@sifive.com>
In-Reply-To: <20250709025516.28051-3-nick.hu@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 17 Jul 2025 10:45:10 +0530
X-Gm-Features: Ac12FXxH7zWRc78wqgAQfCd4XAc-OmYyBR8IBHwZsAOftNAMAJDYwG9JwI2h_Xg
Message-ID: <CAAhSdy3SE8wcjaYmQ==HZ9B9qx826=T8dD4bJ9DDtGh_Rrsc4Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] irqchip/riscv-aplic: Save and restore APLIC registers
To: Nick Hu <nick.hu@sifive.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 8:26=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote:
>
> The APLIC may be powered down when the CPUs enter a deep sleep state.
> Therefore adding the APLIC save and restore functions to save and
> restore the states of APLIC.
>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Reviewed-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Cyan Yang <cyan.yang@sifive.com>
> ---
>  drivers/irqchip/irq-riscv-aplic-direct.c |  14 ++-
>  drivers/irqchip/irq-riscv-aplic-main.c   | 143 +++++++++++++++++++++++
>  drivers/irqchip/irq-riscv-aplic-main.h   |  12 ++
>  drivers/irqchip/irq-riscv-aplic-msi.c    |   3 +-
>  4 files changed, 170 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/i=
rq-riscv-aplic-direct.c
> index 205ad61d15e4..df42f979d02c 100644
> --- a/drivers/irqchip/irq-riscv-aplic-direct.c
> +++ b/drivers/irqchip/irq-riscv-aplic-direct.c
> @@ -8,6 +8,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/cpu.h>
> +#include <linux/cpumask.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqchip.h>
>  #include <linux/irqchip/chained_irq.h>
> @@ -171,6 +172,16 @@ static void aplic_idc_set_delivery(struct aplic_idc =
*idc, bool en)
>         writel(de, idc->regs + APLIC_IDC_IDELIVERY);
>  }
>
> +void aplic_direct_restore(struct aplic_priv *priv)
> +{
> +       struct aplic_direct *direct =3D
> +                       container_of(priv, struct aplic_direct, priv);
> +       int cpu;
> +
> +       for_each_cpu(cpu, &direct->lmask)
> +               aplic_idc_set_delivery(per_cpu_ptr(&aplic_idcs, cpu), tru=
e);
> +}
> +
>  static int aplic_direct_dying_cpu(unsigned int cpu)
>  {
>         if (aplic_direct_parent_irq)
> @@ -343,5 +354,6 @@ int aplic_direct_setup(struct device *dev, void __iom=
em *regs)
>         dev_info(dev, "%d interrupts directly connected to %d CPUs\n",
>                  priv->nr_irqs, priv->nr_idcs);
>
> -       return 0;
> +       /* Add the aplic_priv to the list */
> +       return aplic_add(dev, priv);
>  }
> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq=
-riscv-aplic-main.c
> index 93e7c51f944a..9054ce7a7256 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.c
> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> @@ -12,10 +12,130 @@
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/printk.h>
> +#include <linux/syscore_ops.h>
>
>  #include "irq-riscv-aplic-main.h"
>
> +static LIST_HEAD(aplics);
> +
> +static void aplic_restore(struct aplic_priv *priv)
> +{
> +       int i;
> +       u32 clrip;
> +
> +       writel(priv->saved_domaincfg, priv->regs + APLIC_DOMAINCFG);
> +#ifdef CONFIG_RISCV_M_MODE
> +       writel(priv->saved_msiaddr, priv->regs + APLIC_xMSICFGADDR);
> +       writel(priv->saved_msiaddrh, priv->regs + APLIC_xMSICFGADDRH);
> +#endif
> +       for (i =3D 1; i <=3D priv->nr_irqs; i++) {
> +               writel(priv->saved_sourcecfg[i - 1],
> +                      priv->regs + APLIC_SOURCECFG_BASE +
> +                      (i - 1) * sizeof(u32));
> +               writel(priv->saved_target[i - 1],
> +                      priv->regs + APLIC_TARGET_BASE +
> +                      (i - 1) * sizeof(u32));
> +       }
> +
> +       for (i =3D 0; i <=3D priv->nr_irqs; i +=3D 32) {
> +               writel(-1U, priv->regs + APLIC_CLRIE_BASE +
> +                           (i / 32) * sizeof(u32));
> +               writel(priv->saved_ie[i / 32],
> +                      priv->regs + APLIC_SETIE_BASE +
> +                      (i / 32) * sizeof(u32));
> +       }
> +
> +       if (priv->nr_idcs) {
> +               aplic_direct_restore(priv);
> +       } else {
> +               /* Re-trigger the interrupts */
> +               for (i =3D 0; i <=3D priv->nr_irqs; i +=3D 32) {
> +                       clrip =3D readl(priv->regs + APLIC_CLRIP_BASE +
> +                                     (i / 32) * sizeof(u32));
> +                       writel(clrip, priv->regs + APLIC_SETIP_BASE +
> +                                     (i / 32) * sizeof(u32));
> +               }
> +       }
> +}
> +
> +static void aplic_save(struct aplic_priv *priv)
> +{
> +       int i;
> +
> +       for (i =3D 1; i <=3D priv->nr_irqs; i++) {
> +               priv->saved_target[i - 1] =3D readl(priv->regs +
> +                                                 APLIC_TARGET_BASE +
> +                                                 (i - 1) * sizeof(u32));
> +       }
> +
> +       for (i =3D 0; i <=3D priv->nr_irqs; i +=3D 32) {
> +               priv->saved_ie[i / 32] =3D readl(priv->regs +
> +                                              APLIC_SETIE_BASE +
> +                                              (i / 32) * sizeof(u32));
> +       }
> +}
> +
> +static int aplic_syscore_suspend(void)
> +{
> +       struct aplic_priv *priv;
> +
> +       list_for_each_entry(priv, &aplics, list) {
> +               aplic_save(priv);
> +       }
> +
> +       return 0;
> +}
> +
> +static void aplic_syscore_resume(void)
> +{
> +       struct aplic_priv *priv;
> +
> +       list_for_each_entry(priv, &aplics, list) {
> +               aplic_restore(priv);
> +       }
> +}
> +
> +static struct syscore_ops aplic_syscore_ops =3D {
> +       .suspend =3D aplic_syscore_suspend,
> +       .resume =3D aplic_syscore_resume,
> +};
> +
> +static int aplic_notifier(struct notifier_block *nb, unsigned long actio=
n,
> +                         void *data)

s/aplic_notifier/aplic_pm_notifier/

The "void *data" parameter can be on the same line as function declaration.

> +{
> +       struct aplic_priv *priv =3D container_of(nb, struct aplic_priv, g=
enpd_nb);
> +
> +       switch (action) {
> +       case GENPD_NOTIFY_PRE_OFF:
> +               aplic_save(priv);
> +               break;
> +       case GENPD_NOTIFY_ON:
> +               aplic_restore(priv);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return 0;
> +}
> +
> +int aplic_add(struct device *dev, struct aplic_priv *priv)
> +{
> +       int ret;
> +
> +       list_add(&priv->list, &aplics);
> +       /* Add genpd notifier */
> +       priv->genpd_nb.notifier_call =3D aplic_notifier;
> +       ret =3D dev_pm_genpd_add_notifier(dev, &priv->genpd_nb);
> +       if (!ret)
> +               return devm_pm_runtime_enable(dev);
> +
> +       return ret =3D=3D -ENODEV || ret =3D=3D -EOPNOTSUPP ? 0 : ret;
> +}
> +

Make aplic_add() as static and directly call it from aplic_setup_priv().

To cleanup upon device removal, use devm_add_action_or_reset().

>  void aplic_irq_unmask(struct irq_data *d)
>  {
>         struct aplic_priv *priv =3D irq_data_get_irq_chip_data(d);
> @@ -59,6 +179,7 @@ int aplic_irq_set_type(struct irq_data *d, unsigned in=
t type)
>         sourcecfg =3D priv->regs + APLIC_SOURCECFG_BASE;
>         sourcecfg +=3D (d->hwirq - 1) * sizeof(u32);
>         writel(val, sourcecfg);
> +       priv->saved_sourcecfg[d->hwirq - 1] =3D val;
>
>         return 0;
>  }
> @@ -95,6 +216,8 @@ void aplic_init_hw_global(struct aplic_priv *priv, boo=
l msi_mode)
>                 valh |=3D FIELD_PREP(APLIC_xMSICFGADDRH_HHXS, priv->msicf=
g.hhxs);
>                 writel(val, priv->regs + APLIC_xMSICFGADDR);
>                 writel(valh, priv->regs + APLIC_xMSICFGADDRH);
> +               priv->saved_msiaddr =3D val;
> +               priv->saved_msiaddrh =3D valH;
>         }
>  #endif
>
> @@ -106,6 +229,7 @@ void aplic_init_hw_global(struct aplic_priv *priv, bo=
ol msi_mode)
>         writel(val, priv->regs + APLIC_DOMAINCFG);
>         if (readl(priv->regs + APLIC_DOMAINCFG) !=3D val)
>                 dev_warn(priv->dev, "unable to write 0x%x in domaincfg\n"=
, val);
> +       priv->saved_domaincfg =3D val;
>  }
>
>  static void aplic_init_hw_irqs(struct aplic_priv *priv)
> @@ -176,6 +300,23 @@ int aplic_setup_priv(struct aplic_priv *priv, struct=
 device *dev, void __iomem *
>         /* Setup initial state APLIC interrupts */
>         aplic_init_hw_irqs(priv);
>
> +       /* For power management */
> +       priv->saved_target =3D devm_kzalloc(dev, priv->nr_irqs * sizeof(u=
32),
> +                                         GFP_KERNEL);
> +       if (!priv->saved_target)
> +               return -ENOMEM;
> +
> +       priv->saved_sourcecfg =3D devm_kzalloc(dev, priv->nr_irqs * sizeo=
f(u32),
> +                                            GFP_KERNEL);
> +       if (!priv->saved_sourcecfg)
> +               return -ENOMEM;
> +
> +       priv->saved_ie =3D devm_kzalloc(dev,
> +                                     DIV_ROUND_UP(priv->nr_irqs, 32) * s=
izeof(u32),
> +                                     GFP_KERNEL);
> +       if (!priv->saved_ie)
> +               return -ENOMEM;
> +
>         return 0;
>  }
>
> @@ -209,6 +350,8 @@ static int aplic_probe(struct platform_device *pdev)
>         if (rc)
>                 dev_err_probe(dev, rc, "failed to setup APLIC in %s mode\=
n",
>                               msi_mode ? "MSI" : "direct");
> +       else
> +               register_syscore_ops(&aplic_syscore_ops);
>
>  #ifdef CONFIG_ACPI
>         if (!acpi_disabled)
> diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq=
-riscv-aplic-main.h
> index b0ad8cde69b1..969319242dbc 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.h
> +++ b/drivers/irqchip/irq-riscv-aplic-main.h
> @@ -31,6 +31,16 @@ struct aplic_priv {
>         u32                     acpi_aplic_id;
>         void __iomem            *regs;
>         struct aplic_msicfg     msicfg;
> +       struct notifier_block   genpd_nb;
> +       struct list_head        list;

Rename "list" as "head" and make it first variable
in "struct aplic_priv"

> +       u32 *saved_target;
> +       u32 *saved_sourcecfg;
> +       u32 *saved_ie;
> +       u32 saved_domaincfg;
> +#ifdef CONFIG_RISCV_M_MODE
> +       u32 saved_msiaddr;
> +       u32 saved_msiaddrh;
> +#endif
>  };
>
>  void aplic_irq_unmask(struct irq_data *d);
> @@ -39,7 +49,9 @@ int aplic_irq_set_type(struct irq_data *d, unsigned int=
 type);
>  int aplic_irqdomain_translate(struct irq_fwspec *fwspec, u32 gsi_base,
>                               unsigned long *hwirq, unsigned int *type);
>  void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode);
> +void aplic_direct_restore(struct aplic_priv *priv);
>  int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void _=
_iomem *regs);
> +int aplic_add(struct device *dev, struct aplic_priv *priv);
>  int aplic_direct_setup(struct device *dev, void __iomem *regs);
>  #ifdef CONFIG_RISCV_APLIC_MSI
>  int aplic_msi_setup(struct device *dev, void __iomem *regs);
> diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-=
riscv-aplic-msi.c
> index fb8d1838609f..c9b4f7d5e6ea 100644
> --- a/drivers/irqchip/irq-riscv-aplic-msi.c
> +++ b/drivers/irqchip/irq-riscv-aplic-msi.c
> @@ -281,5 +281,6 @@ int aplic_msi_setup(struct device *dev, void __iomem =
*regs)
>         pa =3D priv->msicfg.base_ppn << APLIC_xMSICFGADDR_PPN_SHIFT;
>         dev_info(dev, "%d interrupts forwarded to MSI base %pa\n", priv->=
nr_irqs, &pa);
>
> -       return 0;
> +       /* Add the aplic_priv to the list */
> +       return aplic_add(dev, priv);
>  }
> --
> 2.17.1
>

Also, please address the issue reported by the kernel test robot.

Regards,
Anup

