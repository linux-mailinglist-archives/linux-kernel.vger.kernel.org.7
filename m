Return-Path: <linux-kernel+bounces-853133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A8ABDAB4C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 091344ECDE6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DFD3043AC;
	Tue, 14 Oct 2025 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpXzwKzW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752F3019CA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760460703; cv=none; b=LS8DqE4W4ybaa999Sjy8KDc9xV7DqqnX0+sdsA5iDo1JEzgEtiMXkX+PHn5EWANsDjKYMVQmwC1SNHUgj2tJ6FXYm3CzBa8YmMIx4+lobzVtQt7ipXUMonhbuCBHyAgFxqupcYQAfhn85i9VtcQFbWSp/XLW1Nso0GH2ZLM3y/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760460703; c=relaxed/simple;
	bh=FqLHyn+kcSG/pPhD4201u+zMcHJOXceqcnmimy65GeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQF7NKoLtJy7+7u253IhWBG0m9MgR+UoXfLlH2CGb+3B+GMfyGRdso4p5QfN4y9Cv08nWtjE4CRaLzP4KfhGQ3gzdYODYeIeHupAVQGzXT61tJ1GTTy/u0NWpslil1P8i4g7tsEoxBRulHzYcX5FaDLfxA7VtCY0iYVFERuDpzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpXzwKzW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760460700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycdWC3IxzhlHIs9R+uoqlv17qbOhbwGECzmbvPYJYgo=;
	b=HpXzwKzWHjc2KQgtPMy4nQqkodpYBvP/q1048YZnfzCMycW/vPMUAptZIq4hFtNrBJTbAv
	txF2jv/Vlkko4N49SukfsdhoP/pegwtgvxd2EzBoqgf49v6qTZ5l8miBSrfZpM8uA6MsMX
	5AGszejXs0Zkd7jTpOgZao36gXi/I+s=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-rBl_47d_Pd2beSjIwrcdWg-1; Tue, 14 Oct 2025 12:51:36 -0400
X-MC-Unique: rBl_47d_Pd2beSjIwrcdWg-1
X-Mimecast-MFC-AGG-ID: rBl_47d_Pd2beSjIwrcdWg_1760460696
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-8e428d7ac90so2310840241.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760460695; x=1761065495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycdWC3IxzhlHIs9R+uoqlv17qbOhbwGECzmbvPYJYgo=;
        b=RqaWdrHg/lrXJVL0lx3ICrj1VNYgN7+yj/7AAcencitp/fJyQpyrRik2VxJMM2rVd2
         Vq1Ye64ZPtu3lI3Tj4p3DX5hGPNOw3zjByHrBUQvtyVUe7G6bMQ0x0UtSyFmuxVOeG6v
         Ika3le93W4wK6wl9GWtUJzdES4eykjisV6bu0pxPaSHTEu4anHo7KhRpld4OzfxR3e4d
         FmV90Yfi+pQPfeposWKvPj5MOiNNj99kyPBoQlUNuzRPx2UM1WWXj1/DRWd0Vik38XWm
         HAJcdPTDV1r9e7Gn+YIQ2qTQdJ1BxcJgVDH0PFB3eR6/AYRHGLGaXqqiWyi79ddZ51sI
         Us+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPsa+sC3cfjJsodMC//jh0JGq5WX5ot74r+vnL+VseU4KZT1Ro5vq+yEP8nshxvXxmvk9HjNjlDXZsWuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfXOZpXfriIq1UGVuOW9ao4rFxVfCTOiqCIGbyeizVUPs8AX5l
	qMpetAs+rc1ReBtyrdb3JsuVoYnZnSuH5axG1EPA5aVF8DnGgN5ovbzNk0xBvnDrtlQ8Cv62MNP
	try3Spx/GIVeO5d2cUQkW0pGC7kJIkfvSWi0MSuPxch3aTt0DfIq+HGaOnGT6/upcrQm9L7B2sg
	z7fSUhL7asThuzTdruzXiJnRhPSDgM4IcPL1kdF57Z
X-Gm-Gg: ASbGnct2XgSZyv/ZWAq5qbqeO0ek8GjiyTCN2tvplJnZKhXKLuVD0W8EH9PPnb5xK29
	fetw8RvC6cT6PiLGKXeZImk6Z281bwBqhNpto62SW8qgew8FH+D1gk9/vurbkLPA9TLCQ2hei0C
	/TjTnM62QqhtZ0AdB/PxKpbJQxHlnm/g==
X-Received: by 2002:a05:6102:26d1:b0:5d5:f508:f255 with SMTP id ada2fe7eead31-5d5f508f286mr7394306137.32.1760460695555;
        Tue, 14 Oct 2025 09:51:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlsFFnYObT5WdiLiUIFmy//KE2FISl7QcMw9dQgfJW/pbylJzZwDu4nsN15MSpszcfld0Pw5CSpLIPZj5y56o=
X-Received: by 2002:a05:6102:26d1:b0:5d5:f508:f255 with SMTP id
 ada2fe7eead31-5d5f508f286mr7394299137.32.1760460695049; Tue, 14 Oct 2025
 09:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014154100.168236-1-lzampier@redhat.com> <20251014154100.168236-4-lzampier@redhat.com>
 <b58b2705-a1b4-4d71-8b76-e2bba4df6987@sifive.com> <CABe3_aECh-d9=O7yJjKuCffBMQ4c2XBYOoqAZa8vqR-PSfWnbA@mail.gmail.com>
 <b50745b9-6b45-4364-aff8-3c10c7cadf3c@sifive.com>
In-Reply-To: <b50745b9-6b45-4364-aff8-3c10c7cadf3c@sifive.com>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Tue, 14 Oct 2025 12:51:23 -0400
X-Gm-Features: AS18NWC4BpT3nBj6j5lcMLwetwGPKLisYvBHqHHDsHDn3aca6_26ZAjnT5MQSlg
Message-ID: <CABe3_aF2OYXUWdQHa5ZR5cohB6m5uPpAj3Yg5GDFtK60NBoXSg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Lucas Zampieri <lzampier@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Vivian Wang <dramforever@live.com>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Zhang Xincheng <zhangxincheng@ultrarisc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 12:45=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Charles,
>
> On 2025-10-14 11:28 AM, Charles Mirabile wrote:
> > On Tue, Oct 14, 2025 at 12:09=E2=80=AFPM Samuel Holland
> > <samuel.holland@sifive.com> wrote:
> >>
> >> On 2025-10-14 10:40 AM, Lucas Zampieri wrote:
> >>> From: Charles Mirabile <cmirabil@redhat.com>
> >>>
> >>> Add a new compatible for the plic found in UltraRISC DP1000 with a qu=
irk to
> >>> work around a known hardware bug with IRQ claiming in the UR-CP100 co=
res.
> >>>
> >>> When claiming an interrupt on UR-CP100 cores, all other interrupts mu=
st be
> >>> disabled before the claim register is accessed to prevent incorrect
> >>> handling of the interrupt. This is a hardware bug in the CP100 core
> >>> implementation, not specific to the DP1000 SoC.
> >>>
> >>> When the PLIC_QUIRK_CLAIM_REGISTER is present, a specialized handler
> >>
> >> You may want to name this something a bit more specific. Every PLIC ha=
s a claim
> >> register, so it seems a bit weird saying that this is a quirk :)
> >
> > Something like `PLIC_QUIRK_CLAIM_REGISTER_ERRATA`? Or
> > `PLIC_QUIRK_CP100_CLAIM_REGISTER`? Or
> > `PLIC_QUIRK_MULTIPLE_PENDING_CLAIM`? I guess the trouble is that they
> > get pretty long pretty quick. Hard to summarize the issue concisely.
>
> If I had to suggest something, I'd say PLIC_QUIRK_CP100_CLAIM_REGISTER_ER=
RATUM,
> but it's really up to you. The function name indicates it is specific to =
CP100,
> so the flag probably should too. I don't think being long is a problem if=
 it
> helps the reader guess the value/effect of the flag at a glance.
>
> Regards,
> Samuel

Great, I agree that that makes sense. If we have to send a v4, we will
fold that change in, and keep your ack. I guess if we don't need a v4,
we could make a separate commit or the maintainer could make the
change while pulling it in.

>
> >>
> >> Anyway, the code looks good, so:
> >>
> >> Acked-by: Samuel Holland <samuel.holland@sifive.com>
> >
> > Thanks!
> >
> >>
> >>> (plic_handle_irq_cp100) saves the enable state of all interrupts, dis=
ables
> >>> all interrupts except for the first pending one before reading the cl=
aim
> >>> register, and then restores the interrupts before further processing =
of
> >>> the claimed interrupt continues.
> >>>
> >>> The driver matches on "ultrarisc,cp100-plic" to apply the quirk to al=
l
> >>> SoCs using UR-CP100 cores, regardless of the specific SoC implementat=
ion.
> >>> This has no impact on other platforms.
> >>>
> >>> Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
> >>> Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
> >>> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> >>> Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> >>> ---
> >>>  drivers/irqchip/irq-sifive-plic.c | 94 +++++++++++++++++++++++++++++=
+-
> >>>  1 file changed, 93 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-=
sifive-plic.c
> >>> index bf69a4802b71..1d528904b353 100644
> >>> --- a/drivers/irqchip/irq-sifive-plic.c
> >>> +++ b/drivers/irqchip/irq-sifive-plic.c
> >>> @@ -49,6 +49,8 @@
> >>>  #define CONTEXT_ENABLE_BASE          0x2000
> >>>  #define     CONTEXT_ENABLE_SIZE              0x80
> >>>
> >>> +#define PENDING_BASE                    0x1000
> >>> +
> >>>  /*
> >>>   * Each hart context has a set of control registers associated with =
it.  Right
> >>>   * now there's only two: a source priority threshold over which the =
hart will
> >>> @@ -63,6 +65,7 @@
> >>>  #define      PLIC_ENABLE_THRESHOLD           0
> >>>
> >>>  #define PLIC_QUIRK_EDGE_INTERRUPT    0
> >>> +#define PLIC_QUIRK_CLAIM_REGISTER    1
> >>>
> >>>  struct plic_priv {
> >>>       struct fwnode_handle *fwnode;
> >>> @@ -394,6 +397,89 @@ static void plic_handle_irq(struct irq_desc *des=
c)
> >>>       chained_irq_exit(chip, desc);
> >>>  }
> >>>
> >>> +static bool cp100_isolate_pending_irq(int nr_irq_groups, u32 ie[],
> >>> +                                    void __iomem *pending,
> >>> +                                    void __iomem *enable)
> >>> +{
> >>> +     u32 pending_irqs =3D 0;
> >>> +     int i, j;
> >>> +
> >>> +     /* Look for first pending interrupt */
> >>> +     for (i =3D 0; i < nr_irq_groups; i++) {
> >>> +             pending_irqs =3D ie[i] & readl_relaxed(pending + i * si=
zeof(u32));
> >>> +             if (pending_irqs)
> >>> +                     break;
> >>> +     }
> >>> +
> >>> +     if (!pending_irqs)
> >>> +             return false;
> >>> +
> >>> +     /* Disable all interrupts but the first pending one */
> >>> +     for (j =3D 0; j < nr_irq_groups; j++) {
> >>> +             u32 new_mask =3D 0;
> >>> +
> >>> +             if (j =3D=3D i)
> >>> +                     /* Extract mask with lowest set bit */
> >>> +                     new_mask =3D (pending_irqs & -pending_irqs);
> >>> +
> >>> +             writel_relaxed(new_mask, enable + j * sizeof(u32));
> >>> +     }
> >>> +
> >>> +     return true;
> >>> +}
> >>> +
> >>> +static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler,
> >>> +                                     void __iomem *claim)
> >>> +{
> >>> +     void __iomem *enable =3D handler->enable_base;
> >>> +     void __iomem *pending =3D handler->priv->regs + PENDING_BASE;
> >>> +     int nr_irqs =3D handler->priv->nr_irqs;
> >>> +     int nr_irq_groups =3D DIV_ROUND_UP(nr_irqs, 32);
> >>> +     int i;
> >>> +     irq_hw_number_t hwirq =3D 0;
> >>> +
> >>> +     raw_spin_lock(&handler->enable_lock);
> >>> +
> >>> +     /* Save current interrupt enable state */
> >>> +     for (i =3D 0; i < nr_irq_groups; i++)
> >>> +             handler->enable_save[i] =3D readl_relaxed(enable + i * =
sizeof(u32));
> >>> +
> >>> +     if (!cp100_isolate_pending_irq(nr_irq_groups, handler->enable_s=
ave, pending, enable))
> >>> +             goto out;
> >>> +
> >>> +     hwirq =3D readl(claim);
> >>> +
> >>> +     /* Restore previous state */
> >>> +     for (i =3D 0; i < nr_irq_groups; i++)
> >>> +             writel_relaxed(handler->enable_save[i], enable + i * si=
zeof(u32));
> >>> +out:
> >>> +     raw_spin_unlock(&handler->enable_lock);
> >>> +     return hwirq;
> >>> +}
> >>> +
> >>> +static void plic_handle_irq_cp100(struct irq_desc *desc)
> >>> +{
> >>> +     struct plic_handler *handler =3D this_cpu_ptr(&plic_handlers);
> >>> +     struct irq_chip *chip =3D irq_desc_get_chip(desc);
> >>> +     void __iomem *claim =3D handler->hart_base + CONTEXT_CLAIM;
> >>> +     irq_hw_number_t hwirq;
> >>> +
> >>> +     WARN_ON_ONCE(!handler->present);
> >>> +
> >>> +     chained_irq_enter(chip, desc);
> >>> +
> >>> +     while ((hwirq =3D cp100_get_hwirq(handler, claim))) {
> >>> +             int err =3D generic_handle_domain_irq(handler->priv->ir=
qdomain,
> >>> +                                                 hwirq);
> >>> +             if (unlikely(err)) {
> >>> +                     pr_warn_ratelimited("%pfwP: can't find mapping =
for hwirq %lu\n",
> >>> +                                         handler->priv->fwnode, hwir=
q);
> >>> +             }
> >>> +     }
> >>> +
> >>> +     chained_irq_exit(chip, desc);
> >>> +}
> >>> +
> >>>  static void plic_set_threshold(struct plic_handler *handler, u32 thr=
eshold)
> >>>  {
> >>>       /* priority must be > threshold to trigger an interrupt */
> >>> @@ -430,6 +516,8 @@ static const struct of_device_id plic_match[] =3D=
 {
> >>>         .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> >>>       { .compatible =3D "thead,c900-plic",
> >>>         .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> >>> +     { .compatible =3D "ultrarisc,cp100-plic",
> >>> +       .data =3D (const void *)BIT(PLIC_QUIRK_CLAIM_REGISTER) },
> >>>       {}
> >>>  };
> >>>
> >>> @@ -664,12 +752,16 @@ static int plic_probe(struct fwnode_handle *fwn=
ode)
> >>>               }
> >>>
> >>>               if (global_setup) {
> >>> +                     void (*handler_fn)(struct irq_desc *) =3D plic_=
handle_irq;
> >>> +                     if (test_bit(PLIC_QUIRK_CLAIM_REGISTER, &handle=
r->priv->plic_quirks))
> >>> +                             handler_fn =3D plic_handle_irq_cp100;
> >>> +
> >>>                       /* Find parent domain and register chained hand=
ler */
> >>>                       domain =3D irq_find_matching_fwnode(riscv_get_i=
ntc_hwnode(), DOMAIN_BUS_ANY);
> >>>                       if (domain)
> >>>                               plic_parent_irq =3D irq_create_mapping(=
domain, RV_IRQ_EXT);
> >>>                       if (plic_parent_irq)
> >>> -                             irq_set_chained_handler(plic_parent_irq=
, plic_handle_irq);
> >>> +                             irq_set_chained_handler(plic_parent_irq=
, handler_fn);
> >>>
> >>>                       cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STAR=
TING,
> >>>                                         "irqchip/sifive/plic:starting=
",
> >>
> >
>


