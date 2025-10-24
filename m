Return-Path: <linux-kernel+bounces-868399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D28C051D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B5AE566124
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184A9305E32;
	Fri, 24 Oct 2025 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8OYVLkf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF0D305E2E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294904; cv=none; b=Q49BkUnFjdEt4DvqaZBMwlt5T/A0RvQ9bGiGsxY5XuqD0gpxgf26vSO0JJ8paYxNZ6EC0uLamvAInL+QNVRkFntNBNtIdlb23OF7ulnMYT6lpfgIA5ioB+HX7OwhlIKcqGEQD0paPDX4/xIMi7gmnUG9z8S/rJOLC27PAsFK8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294904; c=relaxed/simple;
	bh=M2SzRXTzZ912bnvsnzX8KTcPiQoMOXHFj449bF5Uwl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3sZbCOR8h9BLLqrU3RVPt2k9E08Jo6TlKOV0kp233E17uMZ9nsHN0aT8JhxAJ/aWISvJk3TKu5AjfS/CFidtxNwH+pRlHpUgCWGI832kto4zGTc4M4kfz/iKMFGdukWg6/JoCCtu8Wqs2CY9Vhl5x+AEXJV6HJH9U1OsSpXnIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8OYVLkf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761294901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMiM7iwLyLoXC8XMxApEUes6hHrQXoxnQoRnHPw1Y6A=;
	b=g8OYVLkfwqEWybw/+Q4CUDSishLDBQ02IggVLYxf97il+TgPus1QF/903KkcDyBU+KqBkn
	K9sBZ4HLM26OHDPc2hVJOCHM9HVSbLvzanUMIvV6r8b8fNYTrRLMjRbT6U+azL8yWW3TAl
	mcEamtf3GSj5CHGWgTNgvDucW2KUYSo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-iizRHZUDPUqt4AxpOWb03w-1; Fri, 24 Oct 2025 04:34:59 -0400
X-MC-Unique: iizRHZUDPUqt4AxpOWb03w-1
X-Mimecast-MFC-AGG-ID: iizRHZUDPUqt4AxpOWb03w_1761294899
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-426d4f59cbcso1979307f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:34:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761294898; x=1761899698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMiM7iwLyLoXC8XMxApEUes6hHrQXoxnQoRnHPw1Y6A=;
        b=N5r/Ih/dLioLK12fPLaPyVi6hlEuCGEIV55UTpB/2hT0i+9C0a3wqO+naeTaGH/8+O
         VkFyT6ZGC5Muvdgz5xdl5YI1YSGcBAAUCHfpfUXsMSKsO6rJnRiISXfXmEnbK/HG2ECb
         p5HfqylLb2B3+tinPloJSG9x+HWt4tdfADR0Zpgcsx7cnllgR6QC3gJix9bs40XjxQXj
         vJeozl0SgGOd7JbntveNRfukVv+id6uHEE1vj/p/4PI5S412HsZifdM6jInsoDIq+hDl
         h0arpsgwfEM8hb0HLich863sP6ytef+tLCwka5qKSE8XDQLGxwBaLQ0pdvDUZsb/NPmd
         rBog==
X-Forwarded-Encrypted: i=1; AJvYcCWM8C7qEcTi70O6A6+Yo7Y2VSAn5lFZB4hoYvXLwUUqFVlFHRmFc45IwJrLmagw1x6r+7shs/CH/K47fwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYBeKzilKQ35WiPVvwnQomzDZeKyq2nyBdYmRWkxE3+Z/cTLHt
	QsYNTN30WJm5S9uM6aRynYlJUCf2zzlpgC/OiC/NfOvW1Qz3qALstO5yNZLIYkAmexDP5UatfmS
	8mSj3LhlMAuJTH7ZC2wByaWiz3QtlzLez9stm3Z5n6pukagHUATSFPkQiMYJO1b5ZA8s1hbXcKP
	K+VEYSe51XOG4v20fR4MJs4b7zdWuawjbg97nX1P0H
X-Gm-Gg: ASbGnct2t1drgktDBsHA1kmRzwPAgPrLfIhfx8Lg0FoeEdyeXOS8GyqAQN2TEwm17kZ
	haM5ebvyM8goPu1F4GFJjWJ4QHmbLnarPgitpjF780d7TCTMnL5hy1YAj7dgFqW6+nFAbXirLvh
	b1DtiQuXgkagea21x9UWpu0OuccBkBtTsVwmeR0lFlXFtwiF81XdMk0ek=
X-Received: by 2002:a05:6000:2283:b0:3e7:6424:1b47 with SMTP id ffacd0b85a97d-4298f51e6c7mr1615352f8f.6.1761294898406;
        Fri, 24 Oct 2025 01:34:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHneq26JtjC7v0qH5eo9W4vFieyRgtLB+lIw8JjnfPG0eDTw3SOftuEUINlVQTBND/drYvIkk+yrtxFaM/VtJ4=
X-Received: by 2002:a05:6000:2283:b0:3e7:6424:1b47 with SMTP id
 ffacd0b85a97d-4298f51e6c7mr1615312f8f.6.1761294897890; Fri, 24 Oct 2025
 01:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87zf9hwh5j.ffs@tglx> <20251023201721.549563-1-cmirabil@redhat.com>
In-Reply-To: <20251023201721.549563-1-cmirabil@redhat.com>
From: Lucas Zampieri <lzampier@redhat.com>
Date: Fri, 24 Oct 2025 09:34:47 +0100
X-Gm-Features: AWmQ_bkjLCK7rYokvdeJT5wSgmJ0C1bDhIh6rvdCrhkYGtz_4gZYQEXFLd46qyU
Message-ID: <CAOOg__AcRVPRXsDdPPe3QkJybiTYSRCLLHR59qVnH2burfRaNw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Add UltraRISC DP1000 PLIC support
To: Charles Mirabile <cmirabil@redhat.com>
Cc: tglx@linutronix.de, alex@ghiti.fr, aou@eecs.berkeley.edu, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, dramforever@live.com, 
	krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, 
	robh@kernel.org, samuel.holland@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas and Charles,

Yes, missed the cc list to on that one, sending the v6 series again
with the correct headers.
Sorry about that.

Lucas Zampieri
Platform Enablement Team

On Thu, Oct 23, 2025 at 9:17=E2=80=AFPM Charles Mirabile <cmirabil@redhat.c=
om> wrote:
>
> Hi Thomas=E2=80=94
>
> On Thu, Oct 23, 2025 at 09:29:44PM +0200, Thomas Gleixner wrote:
> > On Thu, Oct 23 2025 at 15:00, Lucas Zampieri wrote:
> > > This series adds support for the PLIC implementation in the UltraRISC
> > > DP1000 SoC. The UR-CP100 cores used in the DP1000 have a hardware bug=
 in
> > > their PLIC claim register where reading it while multiple interrupts =
are
> > > pending can return the wrong interrupt ID. The workaround temporarily
> > > disables all interrupts except the first pending one before reading t=
he
> > > claim register, then restores the previous state.
> > >
> > > The driver matches on "ultrarisc,cp100-plic" (CPU core compatible), a=
llowing
> > > the quirk to apply to all SoCs using UR-CP100 cores (currently DP1000=
,
> > > potentially future SoCs).
> > >
> > > Charles Mirabile (3):
> > >   dt-bindings: interrupt-controller: add UltraRISC DP1000 PLIC
> > >   irqchip/plic: enable optimization of interrupt enable state
> >
> >     That one never showed up. Neither in my inbox nor on lore
>
> Looks like the CC list was missing somehow from that patch=E2=80=94I didn=
't notice because I got it in my inbox because of my Signed-off-by.
>
> The indexing on the patches was slightly wrong anyways, so we will resend=
 tomorrow. Sorry for the noise.
>
> I have attached it here in case you want to take a look.
>
> >
> -- >8 --
> From: Charles Mirabile <cmirabil@redhat.com>
> Subject: [PATCH v6 3/4] irqchip/plic: enable optimization of interrupt en=
able state
>
> Optimize the PLIC driver by maintaining the interrupt enable state in
> the handler's enable_save array during normal operation rather than only
> during suspend/resume. This eliminates the need to read enable registers
> during suspend and makes the enable state immediately available for
> other optimizations.
>
> Modify __plic_toggle() to take a handler pointer instead of enable_base,
> allowing it to update both the hardware registers and the cached
> enable_save state atomically within the existing enable_lock protection.
>
> Remove the suspend-time enable register reading since enable_save now
> always reflects the current state.
>
> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 36 +++++++++++--------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index cbd7697bc1481..d518a8b468742 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -94,15 +94,22 @@ static DEFINE_PER_CPU(struct plic_handler, plic_handl=
ers);
>
>  static int plic_irq_set_type(struct irq_data *d, unsigned int type);
>
> -static void __plic_toggle(void __iomem *enable_base, int hwirq, int enab=
le)
> +static void __plic_toggle(struct plic_handler *handler, int hwirq, int e=
nable)
>  {
> -       u32 __iomem *reg =3D enable_base + (hwirq / 32) * sizeof(u32);
> +       u32 __iomem *base =3D handler->enable_base;
>         u32 hwirq_mask =3D 1 << (hwirq % 32);
> +       int group =3D hwirq / 32;
> +       u32 value;
> +
> +       value =3D readl(base + group);
>
>         if (enable)
> -               writel(readl(reg) | hwirq_mask, reg);
> +               value |=3D hwirq_mask;
>         else
> -               writel(readl(reg) & ~hwirq_mask, reg);
> +               value &=3D ~hwirq_mask;
> +
> +       handler->enable_save[group] =3D value;
> +       writel(value, base + group);
>  }
>
>  static void plic_toggle(struct plic_handler *handler, int hwirq, int ena=
ble)
> @@ -110,7 +117,7 @@ static void plic_toggle(struct plic_handler *handler,=
 int hwirq, int enable)
>         unsigned long flags;
>
>         raw_spin_lock_irqsave(&handler->enable_lock, flags);
> -       __plic_toggle(handler->enable_base, hwirq, enable);
> +       __plic_toggle(handler, hwirq, enable);
>         raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
>  }
>
> @@ -247,33 +254,16 @@ static int plic_irq_set_type(struct irq_data *d, un=
signed int type)
>
>  static int plic_irq_suspend(void)
>  {
> -       unsigned int i, cpu;
> -       unsigned long flags;
> -       u32 __iomem *reg;
>         struct plic_priv *priv;
>
>         priv =3D per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
>
>         /* irq ID 0 is reserved */
> -       for (i =3D 1; i < priv->nr_irqs; i++) {
> +       for (unsigned int i =3D 1; i < priv->nr_irqs; i++) {
>                 __assign_bit(i, priv->prio_save,
>                              readl(priv->regs + PRIORITY_BASE + i * PRIOR=
ITY_PER_ID));
>         }
>
> -       for_each_present_cpu(cpu) {
> -               struct plic_handler *handler =3D per_cpu_ptr(&plic_handle=
rs, cpu);
> -
> -               if (!handler->present)
> -                       continue;
> -
> -               raw_spin_lock_irqsave(&handler->enable_lock, flags);
> -               for (i =3D 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
> -                       reg =3D handler->enable_base + i * sizeof(u32);
> -                       handler->enable_save[i] =3D readl(reg);
> -               }
> -               raw_spin_unlock_irqrestore(&handler->enable_lock, flags);
> -       }
> -
>         return 0;
>  }
>
> --
> 2.51.0
>
>


