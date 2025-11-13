Return-Path: <linux-kernel+bounces-899620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3286BC5883E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 852DB4EE1F2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7917359FAD;
	Thu, 13 Nov 2025 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dCIPrlIJ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3F0359FA0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047107; cv=none; b=ZSM8BS461338ih9CUdGDlSmkNE4HjZS/K2ZV8FSbBFNw6XNUVW3SCi96KVSZ8i7wcuPfsaYFwLhAhYip7vvaO0yCA1DZ+7BW1h/9yjlJy0Jln/K14Q6s2pGS7Xppdzm0X/zsUzl/SRwI2HQKIbdhQck4bVoFnRpVwrusIqESAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047107; c=relaxed/simple;
	bh=daocqsfvu8Z8kCaDLBia8szq+kH6UH3vBZEp8A48nc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAngux/xn057wmdIdsO/SCGISbqj69qEC8EtSKyFobtOmY6SKHFOcHo7TySTbsyM3j70G2k3rs8zcYU2hrFu/jN60GUkWthkenz3SP9oXWuk8Nt6e1UdJYeXg2ifebRlpgIEDAwrsQEytRR1NKiA7mHcLRWsGYLOY0zDlSkGC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dCIPrlIJ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59583505988so368584e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1763047104; x=1763651904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRYm2EAMV6902qJ3Pk+J6ovgxi/kpUbCnbc3oiRtnOo=;
        b=dCIPrlIJsAhu44TXZ7TMFdn9UcYehHRBafoN0dwLxhtWavEr1RsLmizwMS8X5HwO4y
         pvMK8IlNx9X01Xq1/mFBmrpLsquLZCjRCkUnXJ0l0impsl+iUn5BStH/63RjmvG93H6Z
         cUi7UVm9hNcFZ/mDRY2hkoGFuSAJNPNVg/7VVRYOP3pFs+Vu5pgwa0BIkJypwRnZ68fB
         qPjJjSTY4urrdAQEth2LGOTDljRE1SjdbirlUUMYpgTZJ17/DnUKA43md8QqvLfA2kDG
         RTViFgBg7FimEfGujtCHhIJGMOmuLt7SzBNYW3G/6lRhDLDvVA6LyR6FydTMH0gf3g09
         rmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763047104; x=1763651904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QRYm2EAMV6902qJ3Pk+J6ovgxi/kpUbCnbc3oiRtnOo=;
        b=JRbjvX7bTwNqeciy+RKAYC2y9YFfZ7nVFOYsz7ti7n93s9J9ibkGdzZBFgCT4E3WG9
         LFMbg1z7k1LO1BV1R0WlAFAcdzzfkZw+iS+0Y/gtVmbaNH2hJNMIpCAkRUlPuzqqVvFo
         HB7Vyy4DQmg94Qx8nT9q2JBo3DfSkY+eesSz9uHkt73WR6QLe4KEZJMtcyAwZMb5zG9c
         ZdfE8DYzxQRHCMHFPoDbU+IvDlS3CztOmKej5h4QSApezovAoJYVchp5rcmjeaxMZOPz
         ZuHNPpoSQVzPzhVKv0BzsYOL4xFr6Y+5f/h9V7bkPTF45SUjRU/G92XO/g68l8VmFIO5
         /IFA==
X-Forwarded-Encrypted: i=1; AJvYcCWJSkVcGn7e1R4fMLGauiRO3c4ZZJn3G1MTHvLrgEYO7s8NUExeZXqWLS5ZIb1ywyGK13OrrmGlMDH/RnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSItIFO5QsytNZ3LLV8trmND/f18kKSRDOkJWkLM4EmM5KHA+u
	/P+3pHKX0NlZz1qgEidOKOT8AJl6AVXYYBlTAK/TMU3fN6LG77u8pHQbyM73zJKAb8UKAGJjMIA
	WN6oGSrhejNOH08wFovu6YjC75Jl6KsCGcpgMDJer+A==
X-Gm-Gg: ASbGnctOz2nv+7nIJHIt+5rcjHwpRn5lNRpFa62CFzfO2R0x2Qz5QUisnu+ZcMY2vH/
	hnk83v1wKR3cRR1QPOKd5OaDX2FGYpj2YE2p40uY0pE7sDlat6n7zOps36WTFNm6pVU45DO7Wjp
	hsnrf0eDLmeEkwtDVUirZe2nFEs0USxB7xNy5AmluiVfmzXLVxddwHTmRQNnZmqMTRd69knMQ0x
	dI5tIt1ztEagTPJNIzcK1+W5FiKCP0oLnhq3StEShHoTcS5AuFk7MUFZVyL
X-Google-Smtp-Source: AGHT+IH9ePhQCjWvQTbPgBVRMyGJ6ewOVBKdWZSNN9fANLpqouH+J7xUFyuxRmFM83J/G1xeLyH2OppMIvqphrJZwdM=
X-Received: by 2002:ac2:4c46:0:b0:592:f390:1bf0 with SMTP id
 2adb3069b0e04-5957ebae691mr1281548e87.8.1763047103605; Thu, 13 Nov 2025
 07:18:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-fix-plic-amp-v2-1-f077b9439112@linux.dev>
In-Reply-To: <20251027-fix-plic-amp-v2-1-f077b9439112@linux.dev>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 13 Nov 2025 20:48:11 +0530
X-Gm-Features: AWmQ_blP9j-crZuwtE4BM2ZNTxUI7mgqjVhDsoYDOra9IW9nQar5EykYgy5O37U
Message-ID: <CAK9=C2XSmeCQLrQY51jJRD+Mnph4a0h8BiPEEaFai+5jBC6jHA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv/plic: assign context ID based on hartid
To: Troy Mitchell <troy.mitchell@linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>, Paul Walmsley <pjw@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 12:35=E2=80=AFPM Troy Mitchell <troy.mitchell@linux=
.dev> wrote:
>
> The PLIC driver for OF-based platforms currently assigns 'context_id =3D =
i'
> within the context loop. This implies an assumption that all harts are
> numbered contiguously starting from 0.
>
> In Asymmetric Multi-Processing (AMP) systems, where Linux might boot on
> a non-zero hart ID (e.g., hart4), while other harts (e.g., hart0) are
> running a different OS, this assumption is violated. This can lead to
>  different system inadvertently sharing the same
> PLIC enable_base register. Consequently, this causes configuration
> conflicts and incorrect interrupt handling.
>
> Assign the PLIC context ID based on the actual hart ID provided by the
> OF node. This ensures that each hart context maps to a unique enable
> region within the PLIC, thereby resolving conflicts in AMP setups. This
> change preserves the correct behavior on Symmetric Multi-Processing (SMP)
> and Uniprocessor (UP) systems.
>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>
> ---
> Changelog in v2:
> - add comments
> - modify commit message
> - use `context_id` instead of `i` when skip contexts other than external
>   interrupts for our privilege level
> - Link to v1: https://lore.kernel.org/r/20251020-fix-plic-amp-v1-1-defe2a=
99ab80@linux.dev
> ---
>  drivers/irqchip/irq-sifive-plic.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index cbd7697bc14819cbe3b77096b26901b605491f75..2289eb2f77bbd0da460d22ad3=
ffcd3e7ef2bde40 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -487,18 +487,18 @@ static int plic_parse_nr_irqs_and_contexts(struct f=
wnode_handle *fwnode,
>  }
>
>  static int plic_parse_context_parent(struct fwnode_handle *fwnode, u32 c=
ontext,
> -                                    u32 *parent_hwirq, int *parent_cpu, =
u32 id)
> +                                    u32 *parent_hwirq, int *parent_cpu, =
u32 id,
> +                                    unsigned long *hartid)
>  {
>         struct of_phandle_args parent;
> -       unsigned long hartid;
>         int rc;
>
>         if (!is_of_node(fwnode)) {
> -               hartid =3D acpi_rintc_ext_parent_to_hartid(id, context);
> -               if (hartid =3D=3D INVALID_HARTID)
> +               *hartid =3D acpi_rintc_ext_parent_to_hartid(id, context);
> +               if (*hartid =3D=3D INVALID_HARTID)
>                         return -EINVAL;
>
> -               *parent_cpu =3D riscv_hartid_to_cpuid(hartid);
> +               *parent_cpu =3D riscv_hartid_to_cpuid(*hartid);
>                 *parent_hwirq =3D RV_IRQ_EXT;
>                 return 0;
>         }
> @@ -507,19 +507,19 @@ static int plic_parse_context_parent(struct fwnode_=
handle *fwnode, u32 context,
>         if (rc)
>                 return rc;
>
> -       rc =3D riscv_of_parent_hartid(parent.np, &hartid);
> +       rc =3D riscv_of_parent_hartid(parent.np, hartid);
>         if (rc)
>                 return rc;
>
>         *parent_hwirq =3D parent.args[0];
> -       *parent_cpu =3D riscv_hartid_to_cpuid(hartid);
> +       *parent_cpu =3D riscv_hartid_to_cpuid(*hartid);
>         return 0;
>  }
>
>  static int plic_probe(struct fwnode_handle *fwnode)
>  {
>         int error =3D 0, nr_contexts, nr_handlers =3D 0, cpu, i;
> -       unsigned long plic_quirks =3D 0;
> +       unsigned long plic_quirks =3D 0, hartid;
>         struct plic_handler *handler;
>         u32 nr_irqs, parent_hwirq;
>         struct plic_priv *priv;
> @@ -569,14 +569,15 @@ static int plic_probe(struct fwnode_handle *fwnode)
>
>         for (i =3D 0; i < nr_contexts; i++) {
>                 error =3D plic_parse_context_parent(fwnode, i, &parent_hw=
irq, &cpu,
> -                                                 priv->acpi_plic_id);
> +                                                 priv->acpi_plic_id, &ha=
rtid);
>                 if (error) {
>                         pr_warn("%pfwP: hwirq for context%d not found\n",=
 fwnode, i);
>                         continue;
>                 }
>
>                 if (is_of_node(fwnode)) {
> -                       context_id =3D i;
> +                       /* each hart has two contexts: M-mode and S-mode =
*/
> +                       context_id =3D hartid * 2 + i % 2;

Deriving PLIC context_id from hartid is totally broken because there
is simply no relation between context_id and hartid and PLIC spec
does not claim any such relation.

For example, in SiFive SoCs with one E-core and multiple S-cores.
The E-core only has M-mode so there is only M-mode PLIC context
for the E-core.

Due to this reason, the "interrupts-extended" property has one
entry for PLIC context.

To address the AMP use-case, you can simply disable the HARTs
not available in a partition. For example, if you have two partitions
(A: hart0, hart1 and B: hart2, hart3) then the FDT passed to both
partitions will have same PLIC DT node but partition A will have
hart2 and hart3 DT nodes disabled whereas partition B will have
hart0 and hart1 DT nodes disabled.

>                 } else {
>                         context_id =3D acpi_rintc_get_plic_context(priv->=
acpi_plic_id, i);
>                         if (context_id =3D=3D INVALID_CONTEXT) {
> @@ -594,7 +595,7 @@ static int plic_probe(struct fwnode_handle *fwnode)
>                         if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
>                                 void __iomem *enable_base =3D priv->regs =
+
>                                         CONTEXT_ENABLE_BASE +
> -                                       i * CONTEXT_ENABLE_SIZE;
> +                                       context_id * CONTEXT_ENABLE_SIZE;
>
>                                 for (hwirq =3D 1; hwirq <=3D nr_irqs; hwi=
rq++)
>                                         __plic_toggle(enable_base, hwirq,=
 0);
> @@ -694,7 +695,8 @@ static int plic_probe(struct fwnode_handle *fwnode)
>
>  fail_cleanup_contexts:
>         for (i =3D 0; i < nr_contexts; i++) {
> -               if (plic_parse_context_parent(fwnode, i, &parent_hwirq, &=
cpu, priv->acpi_plic_id))
> +               if (plic_parse_context_parent(fwnode, i, &parent_hwirq, &=
cpu,
> +                                             priv->acpi_plic_id, &hartid=
))
>                         continue;
>                 if (parent_hwirq !=3D RV_IRQ_EXT || cpu < 0)
>                         continue;
>
> ---
> base-commit: fdbc36b17e9f2fa24c940959e39df90f53ccce2b
> change-id: 20251020-fix-plic-amp-72bd94969ca4
>
> Best regards,
> --
> Troy Mitchell <troy.mitchell@linux.dev>
>
>

Regards,
Anup

