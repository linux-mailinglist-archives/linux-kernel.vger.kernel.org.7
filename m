Return-Path: <linux-kernel+bounces-856561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AE5BE47C3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7287718873D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C4932D0C5;
	Thu, 16 Oct 2025 16:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZRO9mP/8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f4I884pQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DDA32D0C2;
	Thu, 16 Oct 2025 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631150; cv=none; b=XnuQNuQBUx63BOZ90G+iG0+51bl/rlBbfEAZewDqHtOxzR5ENn4Xbltc7455CUnZ0g7ZI1oeZ6G7BsZYklBKGtUtxVyj6yRGSzLx9g47JWSAoibezE9rG+naADeHwhuMclzRJ6vCvf75C1DcVDZwuVe3kp7wA3j8H1VcHxB4AfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631150; c=relaxed/simple;
	bh=XW6k3Gcar3ovV4dpcje4zQ2uk6r9dgawRYEicfegPf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FKdPHytYTLsW3hIrgNp4F8pKxIrZd0WAXphkqPHQo8AzMsMAZFvnw94EORAIDHSIbtiLqOhJBoGXyLNt2pUh+C02NRy5twjSjiUt2mM54oxwh7jmXcdDVG+OI9OXCsnOUNDl34zpRSV1VeMuccIUDs0Ca0aO5Htnoa84yy0mk/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZRO9mP/8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f4I884pQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760631147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EimfC5YBQZ0kq/Gz52aWdB6vLjbMGcafw2nhUU8MVtE=;
	b=ZRO9mP/8ehCkUpZqmBe1rgk54JZHc29ccwtTz5j954OrVqClG6R+uVRDYkbJp7hC1gdJJZ
	y5PEOhujG1srTiKm+IOooIdhhs0kUZTBg4no06GdwWfYS9c5mWtbD/4Vm5ajrzxPau/bM9
	9V1jlggPXINSOLbxqr8l4O4HJFubXNqMmKD9mxQ4/xIWvOz1XaQ+GtxT9E4rcZGj2ur6Ob
	wSufpZsQHWCSIZlhRNhxoBXc712/TuEeRpyRjjoavVOhCa2rUqh8BW7FCpL+7ZOryAWmxx
	AoFp07wqU0/WHcI9Qum/mmpesYmxTEZ1yG++4KX20YvDIBCM3mP0+nBORDZNSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760631147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EimfC5YBQZ0kq/Gz52aWdB6vLjbMGcafw2nhUU8MVtE=;
	b=f4I884pQCh72NrW5bcmy4HgTPvI5ho0GNW8nxlBno/OTw1sTWSsWqoRojjYlPDOcm2wPbr
	9w2ELHaEq06LBtBw==
To: Charles Mirabile <cmirabil@redhat.com>
Cc: Lucas Zampieri <lzampier@redhat.com>, linux-kernel@vger.kernel.org, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Vivian Wang <dramforever@live.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, Zhang
 Xincheng <zhangxincheng@ultrarisc.com>
Subject: Re: [PATCH v5 3/3] irqchip/plic: add support for UltraRISC DP1000 PLIC
In-Reply-To: <CABe3_aGj68qM1bNZ3LExbexO=9FO4RzJxhUy2T+HKK1qZfBmtw@mail.gmail.com>
References: <20251016084301.27670-1-lzampier@redhat.com>
 <20251016084301.27670-4-lzampier@redhat.com> <87plan0yvd.ffs@tglx>
 <CABe3_aGj68qM1bNZ3LExbexO=9FO4RzJxhUy2T+HKK1qZfBmtw@mail.gmail.com>
Date: Thu, 16 Oct 2025 18:12:25 +0200
Message-ID: <87ms5q25cm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16 2025 at 11:54, Charles Mirabile wrote:
> On Thu, Oct 16, 2025 at 9:17=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> > +static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler,
>> > +                                     void __iomem *claim)
>> > +{
>> > +     int nr_irq_groups =3D DIV_ROUND_UP(handler->priv->nr_irqs, 32);
>> > +     void __iomem *pending =3D handler->priv->regs + PENDING_BASE;
>> > +     void __iomem *enable =3D handler->enable_base;
>> > +     irq_hw_number_t hwirq =3D 0;
>> > +     int i;
>> > +
>> > +     guard(raw_spinlock)(&handler->enable_lock);
>> > +
>> > +     /* Save current interrupt enable state */
>> > +     for (i =3D 0; i < nr_irq_groups; i++)
>> > +             handler->enable_save[i] =3D readl_relaxed(enable + i * s=
izeof(u32));
>>
>> This is truly the most inefficient way to solve that problem. The enable
>> registers are modified with enabled_lock held, so you can just cache the
>> value in plic_handler::enabled_save and avoid this read loop completely.
>> After claiming the interrupt you restore from that cache, no?
>
> You mean touch the other functions where the enable bits are modified
> to keep the cache in sync so that we don't need to do this read loop
> and can have a proper set of values cached?
>
> My concern is that this obviously has an impact on other platforms
> which do not have this quirk since keeping the cache in sync would get
> pushed all throughout the driver.

The irq_enable()/disable() callbacks are not really hotpath and caching
the bit in plic_toggle() or such is just not measurable overhead
compared to the register access.

>> Now for the search and disable mechanism. Of course you need to search
>> for th pending interrupt first, but then you can make that masking loop
>> very simple by having a plic_handler::enabled_clear[] array which is
>> zeroed on initialization:
>>
>>         unsigned long pending =3D 0;
>>
>>         for (group =3D 0; !pending && group < nr_irq_groups; group++) {
>>                 pending =3D handler->enabled_save[i];
>>                 pending =3D& readl_relaxed(pending + group * sizeof(u32)=
);
>>         }
>>         if (!pending)
>>                 return false;
>>
>>         bit =3D ffs(pending) - 1;
>>         handler->enabled_clear[group] |=3D BIT(bit);
>>         for (int i =3D 0; i < nr_irq_groups; i++)
>>                 writel_relaxed(handler->enabled_clear[i], enable + i * s=
izeof(u32));
>>         handler->enabled_clear[group] =3D 0;
>>
>> No?
>
> Sure that would also work, but why are we using ffs (slow) only to
> shift the result back to make a new mask when (x & -x) is faster and
> skips the intermediate step delivering immediately the mask of the
> lowest bit.

Because I did not spend time thinking about it.=20

> As for making another caching array, I guess, but again that is just a
> time vs space trade off with its own invariants to maintain that would
> also impact other platforms.

It's a pointer in struct plic_handler (or whatever it's named) and you
can allocate it when the quirk is required. The pointer is definitely
not a burden for anyone else.

>> Is the device B interrupt preserved in the interrupt chip and actually
>> raised when the interrupt enable bit is restored or is it lost?
>
> I am not sure how to verify this other than to tell you that without
> this quirk (i.e. trying to use normal plic behavior) the device does
> not work, but with this quirk I can boot to a desktop with a pcie
> graphics card and storage, use networking etc that all obviously
> depend on the correct functioning of the interrupt controller.
>
> My reading of the spec for PLIC also suggests (but does not explicitly
> confirm) that the pending bits function irrespective of the state of
> the corresponding enable bit: "A pending bit in the PLIC core can be
> cleared by setting the associated enable bit then performing a claim."
> (page 14 plic spec 1.0.0 [1]).
>
> This sentence implies to me that it is possible for a pending bit to
> be set even though the corresponding enable bit is not, which lends
> credence to the idea that the pending bits operate independently.

Looks like that. Please add a comment to that effect then.

Thanks,

        tglx

