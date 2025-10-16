Return-Path: <linux-kernel+bounces-856517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D25BE45EE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDEB81A645C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DDB350D4E;
	Thu, 16 Oct 2025 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUqvMjPd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E85434AB04
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630098; cv=none; b=SiAekGiQtzU5q3SjNy3YTda4lzzWL230dkNz92sTCTMmh1lgf8stogHW6rI/BX267W4Dklv3e1XV0Y4SctwKnAXKuJ4rtJWaSRsfX7nc4U8omT9yBEOJrQprt4GFp/favGHBiHHxA8yKOE1+K2mSD58UO4OIF8HnRA6lQ1Fo+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630098; c=relaxed/simple;
	bh=M3XVnMU46p309A+ES/SPrKYTi7RsCqOO8URRr3vSRaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VosoTYnCW6xGgPMOxVQmcoehKV5Om7eWZTezMZhBQ7c0lHcW4rsU33kb7iTpXs3soM1xn9WXM7VZ1FMraLi0MVOnoRQxsmRTrEVm6oYec68ax2AFKfnAFBac6WKeCqLVNg3kwXnQaRItpv80Hs9OtrsXEsdddSigFnbJNWK6WYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUqvMjPd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760630095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RrUhomfRKtXP1TwC5ktPjSwJlqeR6Qy+1bL0w2VHOPI=;
	b=KUqvMjPdTPl/k8LqYinlyUuElrSO9LRVYvVpGKxLz9NSYsSEyJW+5UM6aViykpycOi9gZj
	SLj+6Z3HVq3OFJ36gw3ubAgDGW4JmMgSPR8eG2hpq3EjAPAXC6X3HtXhUDstR9c1BrfuUR
	cDmaHO+uvN0E7Tz6WfhZRZTnIWK2fzk=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-c0-xL2JxOzi8VuszlLa20Q-1; Thu, 16 Oct 2025 11:54:54 -0400
X-MC-Unique: c0-xL2JxOzi8VuszlLa20Q-1
X-Mimecast-MFC-AGG-ID: c0-xL2JxOzi8VuszlLa20Q_1760630094
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-54a7d8436a4so433523e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630094; x=1761234894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RrUhomfRKtXP1TwC5ktPjSwJlqeR6Qy+1bL0w2VHOPI=;
        b=J/OtLdJg4soYqjz99njwU58XvSFyN+KNIgZeQYovEEI7TrGtVTgxUITXgP4lhDZwrQ
         oLXFwBFXx0ppzLJmq+CCy8Ol6rTQHPA+x7rSKivXE+p3rRiig7POJWcQsEbb3+U7uhho
         3t9lLcNEr0YIEF/zzF2xDCEXH96U+8j8XZweTdzhOuqVGfJUiNBGNTK2woTj2oQF8JHO
         cPZPgoAGMX+a4+XGnZiZH8Dx3ZQ15oIgT/LknGuL+iiv+VIoTS18jkRRKBHfODRMguZU
         tWIt5QTAyGiHmq8QldgYRhCYXn1VLgCaK3tEfsgcC9jqdhVIhpas/o7shiBGgG4JWely
         Um4g==
X-Forwarded-Encrypted: i=1; AJvYcCUG0FbV3CI9dW8ZuVked5SxdBeLa6jSzA/0BHU260QfG2SoCBYsskD7gn1XkwZ2tGJdv1nfhG9R1DpjKWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCGkN6ByLVtUQVZo5AYHJPmhvUPZKgOpI2ah05Rhf8PfGJIzU5
	4WnuuDV3YAFhn2FrXtLMgRUJiUEa8wAuJt26eW50C9eFZGF7OEXHsozE2oZH1AoTGR94g73b/Lc
	IZ3yRtC8tUZ/lgmpzcJN3Z6zw7mYuGNtZE3rXXoS70meaLYDCCdBuEd/SFeeKxm9WtVcsQaZU3I
	oHFkIwl2G8jgr8YbIXXIOmjtq3i7XZq/gzqZZlebWu
X-Gm-Gg: ASbGncsGEqW9HsDTuLN6eEb4qArd5ylnKzOYg6OCXWPPg3osbJoQH5lNPfjg0I6YrxC
	CQa3EU77RRipDCvi1SZ8d17XU5Nhyp+PnPjflSD4U/+UkQ3pI6ZJQeTAbY7Ust5+wCwbgvmWBHK
	XMdVfNS/t6yr6C7muFJJkjmxs9OkNfq2D02Jr/1v4vam/TxJ+GyI7qMfQt
X-Received: by 2002:a05:6122:3183:b0:54a:9927:7ab7 with SMTP id 71dfb90a1353d-5564ee4b9b8mr500777e0c.4.1760630093593;
        Thu, 16 Oct 2025 08:54:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqVcrxd7JjTSzdjEeIgvpIHT5+8pHGXMFeawBOH1308WaBPClx/OBwQfclDPZgbGRF+ueXjuKCpAcm6AGF1FQ=
X-Received: by 2002:a05:6122:3183:b0:54a:9927:7ab7 with SMTP id
 71dfb90a1353d-5564ee4b9b8mr500759e0c.4.1760630093139; Thu, 16 Oct 2025
 08:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016084301.27670-1-lzampier@redhat.com> <20251016084301.27670-4-lzampier@redhat.com>
 <87plan0yvd.ffs@tglx>
In-Reply-To: <87plan0yvd.ffs@tglx>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Thu, 16 Oct 2025 11:54:41 -0400
X-Gm-Features: AS18NWChDcnKUn9SfERgPxeS2QxBz3ndg7E1h3wN_hP1ifuWW7TmfF6Ys7GQBsE
Message-ID: <CABe3_aGj68qM1bNZ3LExbexO=9FO4RzJxhUy2T+HKK1qZfBmtw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Lucas Zampieri <lzampier@redhat.com>, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Vivian Wang <dramforever@live.com>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Zhang Xincheng <zhangxincheng@ultrarisc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas=E2=80=94

On Thu, Oct 16, 2025 at 9:17=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Thu, Oct 16 2025 at 09:42, Lucas Zampieri wrote:
>
> After fixing the corrupted patch up I had a closer look and decided not
> to merge it. See comments below.
>
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
> This is truly the most inefficient way to solve that problem. The enable
> registers are modified with enabled_lock held, so you can just cache the
> value in plic_handler::enabled_save and avoid this read loop completely.
> After claiming the interrupt you restore from that cache, no?

You mean touch the other functions where the enable bits are modified
to keep the cache in sync so that we don't need to do this read loop
and can have a proper set of values cached?

My concern is that this obviously has an impact on other platforms
which do not have this quirk since keeping the cache in sync would get
pushed all throughout the driver.

I do agree that it would save this loop, but the way this was written
was intentionally designed to minimize the impact on other platforms
at the expense of this one because it is the platform with the bug.

>
> Now for the search and disable mechanism. Of course you need to search
> for th pending interrupt first, but then you can make that masking loop
> very simple by having a plic_handler::enabled_clear[] array which is
> zeroed on initialization:
>
>         unsigned long pending =3D 0;
>
>         for (group =3D 0; !pending && group < nr_irq_groups; group++) {
>                 pending =3D handler->enabled_save[i];
>                 pending =3D& readl_relaxed(pending + group * sizeof(u32))=
;
>         }
>         if (!pending)
>                 return false;
>
>         bit =3D ffs(pending) - 1;
>         handler->enabled_clear[group] |=3D BIT(bit);
>         for (int i =3D 0; i < nr_irq_groups; i++)
>                 writel_relaxed(handler->enabled_clear[i], enable + i * si=
zeof(u32));
>         handler->enabled_clear[group] =3D 0;
>
> No?

Sure that would also work, but why are we using ffs (slow) only to
shift the result back to make a new mask when (x & -x) is faster and
skips the intermediate step delivering immediately the mask of the
lowest bit.

As for making another caching array, I guess, but again that is just a
time vs space trade off with its own invariants to maintain that would
also impact other platforms.

I could definitely adjust the clear loop to move the mask preparation out l=
ike:

/* extract lowest set bit */
pending &=3D -pending

for(j =3D 0; j < nr_groups; ++j)
    writel_relaxed(i =3D=3D j ? pending : 0, enable + i * sizeof(u32));

but I am quite sure that the compiler is well able to do this exact
transformation as an optimization pass and I am not sure that it is
more readable than what I originally proposed.

>
> But looking at this makes me wonder about the functional correctness of a=
ll
> this. What happens in this case:
>
> Device A raises an interrupt
>
>     handler()
>         ....
>         disable_groups();
>
> Device B raises a now disabled interrupt
>
>         restore_groups();
>
> Is the device B interrupt preserved in the interrupt chip and actually
> raised when the interrupt enable bit is restored or is it lost?

I am not sure how to verify this other than to tell you that without
this quirk (i.e. trying to use normal plic behavior) the device does
not work, but with this quirk I can boot to a desktop with a pcie
graphics card and storage, use networking etc that all obviously
depend on the correct functioning of the interrupt controller.

My reading of the spec for PLIC also suggests (but does not explicitly
confirm) that the pending bits function irrespective of the state of
the corresponding enable bit: "A pending bit in the PLIC core can be
cleared by setting the associated enable bit then performing a claim."
(page 14 plic spec 1.0.0 [1]).

This sentence implies to me that it is possible for a pending bit to
be set even though the corresponding enable bit is not, which lends
credence to the idea that the pending bits operate independently.

>
> Thanks,
>
>         tglx
>

I am very sorry about the corrupt patch, I don't know how it happened.
I hope you will reconsider taking this code. We can send a version
that is not corrupt (or with the slight modification to bring the mask
preparation out of the loop) if you would prefer.

Thanks for the review.

Best=E2=80=94Charlie

[1] https://github.com/riscv/riscv-plic-spec/releases/tag/1.0.0


