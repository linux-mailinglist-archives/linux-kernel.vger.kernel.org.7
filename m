Return-Path: <linux-kernel+bounces-734636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FFFB08437
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481AC4E7A31
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 05:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B2F1FF1A1;
	Thu, 17 Jul 2025 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="C51gx1T8"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227FFC8FE
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752729315; cv=none; b=Hzg7+9XgIWHUqP/XzaBefTJaokoz081n2GJDAajgHeFM4rfAsXyJfSsMiuaw2wGVhC1qzUHFaPHOk/5pr5Ltr2njxCZ5smNWG7OjJuLUFw0aeXfWk8BuDff+W+TZGeWRHz/6bzUNmxAf6XsDjP8QtSwqFuaEemuznRI7DmNJ85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752729315; c=relaxed/simple;
	bh=q3g+DJhG05vSGCDg7tpItIMG5I2aniqxyjOHPGtt+8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMuIg3NLgjAdRxUa+icpQ9ITHob3Seyv0squR432P0YxFyDKpbrelI9qH0+PGyRiIw+fHOeu97L8WS9OjNBx1FtiBqoquf8tgNYTA1JKVZZ49/QOynrADp5YI6W0n0ByiIEwyOrsMt4iFY9ZAx67V6RCaGm5JCKauG4rWVoo5q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=C51gx1T8; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-873501d2ca1so13906439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 22:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752729313; x=1753334113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVRqC63NQkzRhsguny4WRGvreqzSucOKM3zJQeUVsOE=;
        b=C51gx1T8Feyhlzl0MGuFIOjNB8FH+bCDY52OKNtIVhmFCnEwSk5fCn8mnV+mqG89V6
         XwEchoAlr9PRw8yAMAhiD8ZFpOddrBGuQbs+Aute2SwIL545F7iKObyU1QencJ24w4PV
         9DRv2FLvRDreiTUhkr7rF3pzb4tcqseCX6wChet4mh5uKQwZ7vFkqFSUaZbH0Nim8jLW
         YFB9kxKGWvwo+EyG5gI+IaF2glZ/AzYHvnXG8jmmCtgbaOXARUMlomNfJqzeq2hnceQ6
         YOdyuGIvBsUcKAktcM/tsQPyYG6zzDQFRgB8FeYoWRHejjazkMvrHwuS+iq/Qcb4hcCE
         agbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752729313; x=1753334113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RVRqC63NQkzRhsguny4WRGvreqzSucOKM3zJQeUVsOE=;
        b=KmNVIjlcGBTz60IK4LsfFN6IcDJDp61sfk+y2UIeRppB3/PtQSsS6H9KSk+6k0sdj8
         /Qzids/u6TNZKOF2w/Qa7xMpln9H/bQZ4DsSDIO9/zbn+wpcLg7CzDTUMk9vNxl6wdS5
         nkSZkm94aCOp2PtTyMufA4GVV4LmVPp096bj3Su/aFpte/Ll8Ucf7myx3LODwmlBCOmV
         DGLgsfeEg/y+j+YkCK0mCf7qEkb2Xhfb4BUKRR1aUwnneFepZpaQBQ3YpZUtzforOu97
         6A+GcsPGgmQVwHwulgjB5UcxhTWusyE/zx5NGBDLncRLkNr0sAXIvC10V/ZMxv0NWvNy
         fL8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPuzJCFJdSUbWH/oqZNNWWhScuwdg0kzH/hTZVtxCZOHiW2gR0MQvHSjB80EPhaxhO7iVhPPUNtN6pHKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YysndYGr559fRRHg0wzLY3HKCRyXzcRmhSfQVfqQqatBKoCm/T7
	eTDVAEJYA6kOWqikHDVd2R3lyOSz7ol1ZLcj6hfJvK7wfxU+ubqesLRtgryt1wp66dHVklLtzmw
	hlmkWrjQoF4Eh6YuN9SgvG8z5TNZwuR9t+XBF57TPsYr24GUHZ7uk
X-Gm-Gg: ASbGncvtH3a9h3yqqyDsYxGUQN3q8RBFY8QmekdCnKlw2Qxl02hVOHil0WsT5pD7OmN
	uUAkGZ7eRk11+/ioc1c0y+UzmejJktyJLGEyKHFZzRG3TXWaJ2oiCvX/twifmZkTI3GnAX2WF9Q
	ImZtj1OxXFXE7FRwIIT9P1t8df2I6wHZuu3aXwFe/iICRfMe4AaQQPFxuH7OsKaSBLL41a6JwVL
	lAx2w==
X-Google-Smtp-Source: AGHT+IHtwxqogAVRzQ8j1+KbbVuIoYbtsJ1fOLV0VDFJKcFWTOFvEqs94CnUExP9Tm6R/KKSaLyay9LOuriDebGeu/I=
X-Received: by 2002:a05:6602:4144:b0:879:49e9:5156 with SMTP id
 ca18e2360f4ac-879c293fbf9mr662815839f.9.1752729312911; Wed, 16 Jul 2025
 22:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709025516.28051-1-nick.hu@sifive.com> <20250709025516.28051-2-nick.hu@sifive.com>
In-Reply-To: <20250709025516.28051-2-nick.hu@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 17 Jul 2025 10:45:01 +0530
X-Gm-Features: Ac12FXwk4EceTVPyJlthvo-soULa5ZkAI9paRpA2zqEiUTLhOp7I7S7jrgHdYxU
Message-ID: <CAAhSdy2J6C8LvBCB0LKd2np47qBQ2EFXXnDvb2OjYKqSOF7EbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] irqchip/riscv-imsic: Restore the IMSIC registers
To: Nick Hu <nick.hu@sifive.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 8:26=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote:
>
> When the system woken up from the low power state, the IMSIC might be in
> the reset state. Therefore adding the CPU PM callbacks to restore the
> IMSIC register when the cpu resume from the low power state.
>
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> Reviewed-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Cyan Yang <cyan.yang@sifive.com>
> ---
>  drivers/irqchip/irq-riscv-imsic-early.c | 41 ++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/ir=
q-riscv-imsic-early.c
> index d9ae87808651..f64d9a0642bb 100644
> --- a/drivers/irqchip/irq-riscv-imsic-early.c
> +++ b/drivers/irqchip/irq-riscv-imsic-early.c
> @@ -7,6 +7,7 @@
>  #define pr_fmt(fmt) "riscv-imsic: " fmt
>  #include <linux/acpi.h>
>  #include <linux/cpu.h>
> +#include <linux/cpu_pm.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> @@ -109,14 +110,8 @@ static void imsic_handle_irq(struct irq_desc *desc)
>         chained_irq_exit(chip, desc);
>  }
>
> -static int imsic_starting_cpu(unsigned int cpu)
> +static void imsic_restore(void)
>  {
> -       /* Mark per-CPU IMSIC state as online */
> -       imsic_state_online();
> -
> -       /* Enable per-CPU parent interrupt */
> -       enable_percpu_irq(imsic_parent_irq, irq_get_trigger_type(imsic_pa=
rent_irq));
> -
>         /* Setup IPIs */
>         imsic_ipi_starting_cpu();
>
> @@ -128,6 +123,19 @@ static int imsic_starting_cpu(unsigned int cpu)
>
>         /* Enable local interrupt delivery */
>         imsic_local_delivery(true);
> +}
> +
> +static int imsic_starting_cpu(unsigned int cpu)
> +{
> +       /* Mark per-CPU IMSIC state as online */
> +       imsic_state_online();
> +
> +       /* Enable per-CPU parent interrupt */
> +       enable_percpu_irq(imsic_parent_irq,
> +                         irq_get_trigger_type(imsic_parent_irq));
> +
> +       /* Restore the imsic reg */
> +       imsic_restore();
>
>         return 0;
>  }
> @@ -143,6 +151,23 @@ static int imsic_dying_cpu(unsigned int cpu)
>         return 0;
>  }
>
> +static int imsic_notifier(struct notifier_block *self, unsigned long cmd=
,
> +                         void *v)

s/imsic_notifier/imsic_pm_notifier/

The "void *v" parameter can be on the same line as function declaration.

> +{
> +       switch (cmd) {
> +       case CPU_PM_EXIT:
> +               /* Restore the imsic reg */
> +               imsic_restore();
> +               break;
> +       }
> +
> +       return NOTIFY_OK;
> +}
> +
> +static struct notifier_block imsic_notifier_block =3D {

s/imsic_notifier_block/imsic_pm_notifier_block/

> +       .notifier_call =3D imsic_notifier,
> +};
> +
>  static int __init imsic_early_probe(struct fwnode_handle *fwnode)
>  {
>         struct irq_domain *domain;
> @@ -180,7 +205,7 @@ static int __init imsic_early_probe(struct fwnode_han=
dle *fwnode)
>         cpuhp_setup_state(CPUHP_AP_IRQ_RISCV_IMSIC_STARTING, "irqchip/ris=
cv/imsic:starting",
>                           imsic_starting_cpu, imsic_dying_cpu);
>
> -       return 0;
> +       return cpu_pm_register_notifier(&imsic_notifier_block);
>  }
>
>  static int __init imsic_early_dt_init(struct device_node *node, struct d=
evice_node *parent)
> --
> 2.17.1
>

Otherwise, this looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

