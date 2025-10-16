Return-Path: <linux-kernel+bounces-857058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6450BE5C94
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F2001A6620E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38032E6CA9;
	Thu, 16 Oct 2025 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6n4gdTy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2782405E8
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760657145; cv=none; b=sXc8oSLIgwUjnMkj6+PTzWeiHYcKGRefU3Kipdh+WHCJtjo1UuUKhoAp/FWmqNT2BLYtAWky6P7d1P4d3BOYWyjy8O7Z5OiRmSrqy3YTHIrB4PtC6QnBBwaXl1rXEn5Pp1VNR78bnw1abCf9ZD12b8itt5/Ac4I5HVexLf3Tu8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760657145; c=relaxed/simple;
	bh=Xsn6UVnGc+oaOHI29Lins+2t1HZQ5YuSPXszPweziPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFhAevCDP2xUoNQixSzFzRZ2jhLEUqkMlrgOsZ4rEkYFn7BxwJ3RqDNIXsgY609RSuacqNC90ixyLP4uS0Dxfmbqw3e8S/9fL780zTW+0KhO1LRO8wPQPPRBQzZ4bTGN2x5M6dmpgiKrt/GUcelxflldyyUS0ERBCSdXbgDpPrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6n4gdTy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760657142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJhAVKZC+aZs77CV/WAdMmKIhxUs49JrlN6++V8EjLM=;
	b=O6n4gdTyMiit44CCh62XjhdKev9Pnh4k+YfJzbbt5AFr5ZVgr+BdqlSw3tM+PH3ysUFMnl
	milFBzE+yVVE6rdeqvWq6M5FkFNjB4PHbt9vr470S5UybXE5i3/agGRdXKt76dy7C+vRf8
	gsCepnWkQo3tKmExOARaX2nijJFP+dg=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-p87IYPAqM8Ou3KsidePEIQ-1; Thu, 16 Oct 2025 19:25:41 -0400
X-MC-Unique: p87IYPAqM8Ou3KsidePEIQ-1
X-Mimecast-MFC-AGG-ID: p87IYPAqM8Ou3KsidePEIQ_1760657140
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5563f974409so2528198e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760657140; x=1761261940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJhAVKZC+aZs77CV/WAdMmKIhxUs49JrlN6++V8EjLM=;
        b=WEFSo7lWdf++ZV3Vj5HWUFGAoJQF3KrbK7gK8kI5+Ui4ELwv9ZW3abUog3CuAyZx6r
         cp8TQNk46WqILwO6ZmEH/+2qGb6odY3e24vbd+tVEVbPbWROr8szUgUndfvft5sAcI4l
         BERlDdrqY4TbgwOGh2dohGR37iNgHkyeYlj1xkI+4U4iZWXY2MO7On9/Qsg1NOv2stj1
         1vmaNK2eXNwFCN6OlgGcnSl0hMza+E1S6FHM0RVQqc1U1xCd1uwGY6CHPQaVd8rn+iOt
         IhTQm+LI7Kxb0/oxSmi9+m47Ypof66Na4sGLpHSlWPNLrhnfip4wo0HfoZKPN3c7pdJj
         hxxw==
X-Forwarded-Encrypted: i=1; AJvYcCXa/raePPkDCwyzJOHvGc9OuqTeji/mTUQLyQVIFK+ec5BLveKWz+4zbsAuBYkOQ09RDj61W/F19tAAPAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyHBxFfuLvmjkTSRE4LEMExJCS9egFYymy2JZtTpyQE+DRg2b6
	dfizuaRiKYAianDR7lIGr3tpPSFpkBzoXkJByY+uEWryxFw9mqthCdJAXuODEOmkIBnBTpZPPL4
	+ifaNX0anGYLo0ua3Jjbh++HnpzdthxYzkXAPybJZUeAcBnr2Qgq6BqxJ7RHqDPCHLM2ESMi8IQ
	JMAttiEorDSlzA7AAzqD/c6DrAYa2XY6sVG8fPP06n
X-Gm-Gg: ASbGncuOaLh4xZywz01kEIA4jcMPNLsiMLktzbYRTRrT1Yrl2xKdWGz/jQOVKPRJtjU
	kc6u0JFOWHrgEKTCjaw89T7dQ3AJ+MeX+O3vhvIYyRzsiTnnOFN/78rP7YJTogylEOsLQDWYfdM
	ZQNuOYNyBgs8mwIHp3qKaSbydgEPOU+3qg9Hj3ZItNuel561P0hnTfd91m
X-Received: by 2002:a05:6122:3296:b0:54a:1ec7:ab0f with SMTP id 71dfb90a1353d-5564ef8025fmr983289e0c.16.1760657140461;
        Thu, 16 Oct 2025 16:25:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkS4jG4vbz2PifIGt1xjjts/2Zoci6XzcxG0rh7HQlY7yF7JfxB+fbPAMzBGh/PJuwVpU82OjvU9cqo8xji1I=
X-Received: by 2002:a05:6122:3296:b0:54a:1ec7:ab0f with SMTP id
 71dfb90a1353d-5564ef8025fmr983274e0c.16.1760657140029; Thu, 16 Oct 2025
 16:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016084301.27670-1-lzampier@redhat.com> <20251016084301.27670-4-lzampier@redhat.com>
 <831744c6-ba89-4029-a035-9a70c3f57465@gmail.com>
In-Reply-To: <831744c6-ba89-4029-a035-9a70c3f57465@gmail.com>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Thu, 16 Oct 2025 19:25:29 -0400
X-Gm-Features: AS18NWAnHpvyoTgIPxBsL1mrhktAopFW74BhAlX-4nXByyl7E_t_N2moAd-fZkQ
Message-ID: <CABe3_aGjCBX2VVdV5dLwQ2g+N+c6mMf-eFqkViD2BhMaxRvq6Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
To: Bo Gan <ganboing@gmail.com>
Cc: Lucas Zampieri <lzampier@redhat.com>, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang <dramforever@live.com>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Zhang Xincheng <zhangxincheng@ultrarisc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bo=E2=80=94

On Thu, Oct 16, 2025 at 5:25=E2=80=AFPM Bo Gan <ganboing@gmail.com> wrote:
>
> Hi Lucas, Charles,
>
> I just realized your last reply and sorry about the messy formatting.
> Please disregard the previous one from me and use this one.
>
> On 10/16/25 01:42, Lucas Zampieri wrote:
> > From: Charles Mirabile <cmirabil@redhat.com>
> >
> > Add a new compatible for the plic found in UltraRISC DP1000 with a quir=
k to
> > work around a known hardware bug with IRQ claiming in the UR-CP100 core=
s.
> >
> > When claiming an interrupt on UR-CP100 cores, all other interrupts must=
 be
> > disabled before the claim register is accessed to prevent incorrect
> > handling of the interrupt. This is a hardware bug in the CP100 core
> > implementation, not specific to the DP1000 SoC.
> >
> > When the PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM flag is present, a spe=
cialized
> > handler (plic_handle_irq_cp100) saves the enable state of all interrupt=
s,
> > disables all interrupts except for the first pending one before reading=
 the
> > claim register, and then restores the interrupts before further process=
ing of
> > the claimed interrupt continues.
> >
> > The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
> > SoCs using UR-CP100 cores, regardless of the specific SoC implementatio=
n.
> > This has no impact on other platforms.
> >
> > Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
> > Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
> > Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> > Acked-by: Samuel Holland <samuel.holland@sifive.com>
> > Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
> > ---
> >   drivers/irqchip/irq-sifive-plic.c | 94 ++++++++++++++++++++++++++++++=
-
> >   1 file changed, 93 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-si=
five-plic.c
> > index bf69a4802b71..0428e9f3423d 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -49,6 +49,8 @@
> >   #define CONTEXT_ENABLE_BASE         0x2000
> >   #define     CONTEXT_ENABLE_SIZE             0x80
> >
> > +#define PENDING_BASE                    0x1000
> > +
> >   /*
> >    * Each hart context has a set of control registers associated with i=
t.  Right
> >    * now there's only two: a source priority threshold over which the h=
art will
> > @@ -63,6 +65,7 @@
> >   #define     PLIC_ENABLE_THRESHOLD           0
> >
> >   #define PLIC_QUIRK_EDGE_INTERRUPT   0
> > +#define PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM      1
> >
> >   struct plic_priv {
> >       struct fwnode_handle *fwnode;
> > @@ -394,6 +397,89 @@ static void plic_handle_irq(struct irq_desc *desc)
> >       chained_irq_exit(chip, desc);
> >   }
> >
> > +static bool cp100_isolate_pending_irq(int nr_irq_groups, u32 ie[],
> > +                                    void __iomem *pending,
> > +                                    void __iomem *enable)
> > +{
> > +     u32 pending_irqs =3D 0;
> > +     int i, j;
> > +
> > +     /* Look for first pending interrupt */
> > +     for (i =3D 0; i < nr_irq_groups; i++) {
> > +             pending_irqs =3D ie[i] & readl_relaxed(pending + i * size=
of(u32));
> > +             if (pending_irqs)
> > +                     break;
>
> No need to start from group 0. Only readl on the group with ie[i] !=3D 0

You mean put something like `if (!ie[i]) continue;` to avoid the readl
if the mask is going to obliterate it?

Sounds reasonable.
>
> > +     }
> > +
> > +     if (!pending_irqs)
> > +             return false;
> > +
> > +     /* Disable all interrupts but the first pending one */
> > +     for (j =3D 0; j < nr_irq_groups; j++) {
> > +             u32 new_mask =3D 0;
> > +
> > +             if (j =3D=3D i) {
> > +                     /* Extract mask with lowest set bit */
> > +                     new_mask =3D (pending_irqs & -pending_irqs);
> > +             }
> > +
> > +             writel_relaxed(new_mask, enable + j * sizeof(u32));
>
>
> There's no need to write the register if the value isn't changing. You ca=
n
> check new_mask with the value in ie[].

Something similar like `if (!ie[j]) continue;` in this loop too? We
know that this will not interact poorly with the i =3D=3D j case because
ie[i] is by definition nonzero if we hit this code path and so when i
=3D=3Dj ie[j] =3D=3D ie[j] !=3D 0 so we will hit the rest of the logic. Als=
o
sounds sane.

>
> > +     }
> > +
> > +     return true;
> > +}
> > +
> > +static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler,
> > +                                     void __iomem *claim)
> > +{
> > +     int nr_irq_groups =3D DIV_ROUND_UP(handler->priv->nr_irqs, 32);
> > +     void __iomem *pending =3D handler->priv->regs + PENDING_BASE;
> > +     void __iomem *enable =3D handler->enable_base;
> > +     irq_hw_number_t hwirq =3D 0;
> > +     int i;
> > +
> > +     guard(raw_spinlock)(&handler->enable_lock);
> > +
> > +     /* Save current interrupt enable state */
> > +     for (i =3D 0; i < nr_irq_groups; i++)
> > +             handler->enable_save[i] =3D readl_relaxed(enable + i * si=
zeof(u32));
>
>
> I see that you start to use handler->enable_save to track HW in the last =
reply.
> I'm about to suggest that. Please send out a new patch, so people can pro=
perly
> review it. There's change to common code path.

Yes, a proper patch will come soon, just have to respin the whole
series. Two separate commits, one for refactoring the common code,
another for adding the quirk.

The changes do not overlap - the first patch will be hunks 3, 4, & 5
of the tentative diff I sent to Thomas, and patch two will be hunks 1,
2, 6, 7, 8.

If you have any concerns about the changes to common code, do let us know.

I will also pick up your feedback about avoiding the mmio by checking
ie[] in the loops.

>
> > +
> > +     if (!cp100_isolate_pending_irq(nr_irq_groups, handler->enable_sav=
e, pending, enable))
> > +             return 0;
> > +
> > +     hwirq =3D readl(claim);
>
> Possibly missing a io barrier. readl isn't going to enforce the ordering =
of
> readl/writel_relaxed above and itself. There could be other barriers miss=
ing.
> Please check.
>
> > +
> > +     /* Restore previous state */
> > +     for (i =3D 0; i < nr_irq_groups; i++)
> > +             writel_relaxed(handler->enable_save[i], enable + i * size=
of(u32));
> > +
> > +     return hwirq;
> > +}
> > +
> > +static void plic_handle_irq_cp100(struct irq_desc *desc)
> > +{
> > +     struct plic_handler *handler =3D this_cpu_ptr(&plic_handlers);
> > +     struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +     void __iomem *claim =3D handler->hart_base + CONTEXT_CLAIM;
> > +     irq_hw_number_t hwirq;
> > +
> > +     WARN_ON_ONCE(!handler->present);
> > +
> > +     chained_irq_enter(chip, desc);
> > +
> > +     while ((hwirq =3D cp100_get_hwirq(handler, claim))) {
> > +             int err =3D generic_handle_domain_irq(handler->priv->irqd=
omain, hwirq);
> > +
> > +             if (unlikely(err)) {
> > +                     pr_warn_ratelimited("%pfwP: can't find mapping fo=
r hwirq %lu\n",
> > +                                         handler->priv->fwnode, hwirq)=
;
> > +             }
> > +     }
> > +
> > +     chained_irq_exit(chip, desc);
> > +}
> > +
> >   static void plic_set_threshold(struct plic_handler *handler, u32 thre=
shold)
> >   {
> >       /* priority must be > threshold to trigger an interrupt */
> > @@ -430,6 +516,8 @@ static const struct of_device_id plic_match[] =3D {
> >         .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> >       { .compatible =3D "thead,c900-plic",
> >         .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
> > +     { .compatible =3D "ultrarisc,cp100-plic",
> > +       .data =3D (const void *)BIT(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERR=
ATUM) },
> >       {}
> >   };
> >
> > @@ -664,12 +752,16 @@ static int plic_probe(struct fwnode_handle *fwnod=
e)
> >               }
> >
> >               if (global_setup) {
> > +                     void (*handler_fn)(struct irq_desc *) =3D plic_ha=
ndle_irq;
> > +
> > +                     if (test_bit(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRA=
TUM, &handler->priv->plic_quirks))
> > +                             handler_fn =3D plic_handle_irq_cp100;
> > +
> >                       /* Find parent domain and register chained handle=
r */
> >                       domain =3D irq_find_matching_fwnode(riscv_get_int=
c_hwnode(), DOMAIN_BUS_ANY);
> >                       if (domain)
> >                               plic_parent_irq =3D irq_create_mapping(do=
main, RV_IRQ_EXT);
> >                       if (plic_parent_irq)
> > -                             irq_set_chained_handler(plic_parent_irq, =
plic_handle_irq);
> > +                             irq_set_chained_handler(plic_parent_irq, =
handler_fn);
> >
> >                       cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTI=
NG,
> >                                         "irqchip/sifive/plic:starting",
>
> My rationale of the above comments is to achieve minimal overhead with th=
is
> "read pending[] -> disable IE[] -> claim -> enable IE[]" approach. In gen=
eral,
> the fewer interrupts enabled on a hart, the lower the overhead. If there'=
s only
> 1 interrupt enabled for a give hart, then there's zero reading/writing of=
 IE[],
> and you can further optimize away the reading of pending register.
>
> I'd imagine that if the user truly want to avoid the overhead of this qui=
rk,
> they can chose to spread out the irq groups onto different harts to allev=
iate
> the slow down, or better isolate a single irq to a given hart, and we sho=
uld
> make it possible.
>
> Feel free to point out any of my misunderstandings.
>
> Bo
>

Best=E2=80=94Charlie


