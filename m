Return-Path: <linux-kernel+bounces-856652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159E9BE4B19
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874AF4861C7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7EC32AAAA;
	Thu, 16 Oct 2025 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7JQQOus"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E122E2F04
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633559; cv=none; b=bz4UtCMqhchTVs7oYdPMrKk4O9LD0zy2SjRxT8zwp/xB6eLYhS2BzQ/D8x/tcq0jw88M5nwKJSfMmFwJ+7CG6OjzrcocgMcY9B9lkfGx4pPACWmI/2jOsCNTuGsdUGMZB94Wfk+H28yk39K+bcJhz8BCiJqsbKn0kiN62s8gQLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633559; c=relaxed/simple;
	bh=xNlMfyS21EmSnFZhxFwEfdgGPJ9F6nSclwnkMoIhtUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRd+4h0pU+HwJV58n6+ueIkjShy/bPw1kFVMfDtO5IMAb0LIMaVndqQTpgnf8Ztd7YUkH9w0oUfc780hRtypLPvIzEuM2FuA67dXSW9/9c/oXAkbHhVFgZG51bU/Bq1pq+OCvVUefoD2oIyp1KWOkHqsMy0YV389jdlKKhW4MQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7JQQOus; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760633556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3G/38K/f4KvIWBGZQcPCv+KujPEoeANOPy5LdUWYVA=;
	b=F7JQQOusNzMS2mRRrBhVK2fWDBrcgtU4N16elNsQ84zrPPggdqa6kOx+G1MVljQ+qmg9aR
	aYzXCfrLFt+WcnstpHVjTRgR3ztjKpARbliwX7T8ZBtdNpjmtZCyCAyqmsCO1lPUWwHFTM
	ZGF2LS+CySoEa3abOALOmD8hZoB1MKs=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-FrczNEL8NVadwpfq7eMqYg-1; Thu, 16 Oct 2025 12:52:35 -0400
X-MC-Unique: FrczNEL8NVadwpfq7eMqYg-1
X-Mimecast-MFC-AGG-ID: FrczNEL8NVadwpfq7eMqYg_1760633555
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-92eb7ac6c06so1565852241.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760633554; x=1761238354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3G/38K/f4KvIWBGZQcPCv+KujPEoeANOPy5LdUWYVA=;
        b=uOLh+EjGzoe3M5Pa32bAo1bbk/dg3DSk/NI4bpbvG450owGmrUZB8iWNqZNJPBFSfV
         Uk6MNLDvvvtIQjbbrsUE+tWS7tCOJLR6erZRTSSpdPEixq4F6mP1RcaPJOf+Lq9aU5mi
         Sx2h7dl27lJhwkkKPKlZz+w+GBfOQuTeTMaPn3o1N883D1+5JWcCKv38oLcSEIf0yChR
         pIgFnmE5Serz7j6kPt9AAjoMKBMMwvjnrfTan5nlTv36QE8brdyV5pNNFAMcj1gNOn7h
         GTkDKvD7WpeD344M23agVanYC03o3mBVTlKWgwtgGUEXgpdFfO0CmhSybl1y6DaCtd1Z
         DjYg==
X-Forwarded-Encrypted: i=1; AJvYcCXdw2x2M9/7jhaBZthbDRqbZAfN+E+X+BbN4vs5732TPPiFinm+SUCDiO1YFhtXL3bSY5jAphXbrGhGrFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9PzRTPOd2G1vcZlgAUG1AmjXcU1uXj8nzhGHxNk73yUxo19d
	mFF9O82CMU+YvL8uRreWmlt2gV5t8pDTt7FNZITN4aR7xfLcoYzsRUioi+EGzPJOreDTSXf/Wz/
	kMNYPwhJR4lBicNMLelJMBGTiHPuIKmyxAo2OF2dQurk6PI5my/CMdfLIicXSTkD+0jt6SvGgtG
	z/jExf+TJcNe3tuSfBxnafS/XH7CHup/0S8lTldeAE
X-Gm-Gg: ASbGncthlUtBIaoyoAxENts+Z7HkTbGqo9GRtD4KO+Mve4aiMXB/aW04RB+X9VbSSGQ
	0AYA9E5M2f8LiNx/6N2T01DUT5RBkkpJC/DG0lTGdzwG4pTBiAvR/x0UkEP5k/jRo6955nlpQW9
	vADHlttd3nk8Sq3oGm0NG03FAYT1SpiF6/E6IdE3+gzk7OuwOopBT9Huwk
X-Received: by 2002:a05:6102:510c:b0:524:c767:f541 with SMTP id ada2fe7eead31-5d7dd6a440cmr495876137.35.1760633554631;
        Thu, 16 Oct 2025 09:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD5WG63fxuNfl/7xxXAKVY2shuG2V6JHbtY86SZeR5UI/cxt6xfRaVkEChSU6aorSQmSIXD4dsjkpgYhIzU+E=
X-Received: by 2002:a05:6102:510c:b0:524:c767:f541 with SMTP id
 ada2fe7eead31-5d7dd6a440cmr495868137.35.1760633554224; Thu, 16 Oct 2025
 09:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016084301.27670-1-lzampier@redhat.com> <20251016084301.27670-4-lzampier@redhat.com>
 <87plan0yvd.ffs@tglx> <CABe3_aGj68qM1bNZ3LExbexO=9FO4RzJxhUy2T+HKK1qZfBmtw@mail.gmail.com>
 <87ms5q25cm.ffs@tglx>
In-Reply-To: <87ms5q25cm.ffs@tglx>
From: Charles Mirabile <cmirabil@redhat.com>
Date: Thu, 16 Oct 2025 12:52:22 -0400
X-Gm-Features: AS18NWAJZGulCtwHsjeP4T38yEVHSOQmEhV7m0unjSLxlvw7p4A-SpEylNDrO3o
Message-ID: <CABe3_aH3YE9wWonH1j09-eCarhzhhRReNAOwmEMs5YjkOvvoiQ@mail.gmail.com>
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

On Thu, Oct 16, 2025 at 12:12=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Thu, Oct 16 2025 at 11:54, Charles Mirabile wrote:
> > On Thu, Oct 16, 2025 at 9:17=E2=80=AFAM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >> > +static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler=
,
> >> > +                                     void __iomem *claim)
> >> > +{
> >> > +     int nr_irq_groups =3D DIV_ROUND_UP(handler->priv->nr_irqs, 32)=
;
> >> > +     void __iomem *pending =3D handler->priv->regs + PENDING_BASE;
> >> > +     void __iomem *enable =3D handler->enable_base;
> >> > +     irq_hw_number_t hwirq =3D 0;
> >> > +     int i;
> >> > +
> >> > +     guard(raw_spinlock)(&handler->enable_lock);
> >> > +
> >> > +     /* Save current interrupt enable state */
> >> > +     for (i =3D 0; i < nr_irq_groups; i++)
> >> > +             handler->enable_save[i] =3D readl_relaxed(enable + i *=
 sizeof(u32));
> >>
> >> This is truly the most inefficient way to solve that problem. The enab=
le
> >> registers are modified with enabled_lock held, so you can just cache t=
he
> >> value in plic_handler::enabled_save and avoid this read loop completel=
y.
> >> After claiming the interrupt you restore from that cache, no?
> >
> > You mean touch the other functions where the enable bits are modified
> > to keep the cache in sync so that we don't need to do this read loop
> > and can have a proper set of values cached?
> >
> > My concern is that this obviously has an impact on other platforms
> > which do not have this quirk since keeping the cache in sync would get
> > pushed all throughout the driver.
>
> The irq_enable()/disable() callbacks are not really hotpath and caching
> the bit in plic_toggle() or such is just not measurable overhead
> compared to the register access.

Fair enough, if you insist. This will probably require a second patch
refactoring a decent amount of code (since the suspend / resume path
for which this enable array was added becomes simpler).

>
> >> Now for the search and disable mechanism. Of course you need to search
> >> for th pending interrupt first, but then you can make that masking loo=
p
> >> very simple by having a plic_handler::enabled_clear[] array which is
> >> zeroed on initialization:
> >>
> >>         unsigned long pending =3D 0;
> >>
> >>         for (group =3D 0; !pending && group < nr_irq_groups; group++) =
{
> >>                 pending =3D handler->enabled_save[i];
> >>                 pending =3D& readl_relaxed(pending + group * sizeof(u3=
2));
> >>         }
> >>         if (!pending)
> >>                 return false;
> >>
> >>         bit =3D ffs(pending) - 1;
> >>         handler->enabled_clear[group] |=3D BIT(bit);
> >>         for (int i =3D 0; i < nr_irq_groups; i++)
> >>                 writel_relaxed(handler->enabled_clear[i], enable + i *=
 sizeof(u32));
> >>         handler->enabled_clear[group] =3D 0;
> >>
> >> No?
> >
> > Sure that would also work, but why are we using ffs (slow) only to
> > shift the result back to make a new mask when (x & -x) is faster and
> > skips the intermediate step delivering immediately the mask of the
> > lowest bit.
>
> Because I did not spend time thinking about it.

Sorry, did you mean "because I had not considered the original
approach carefully enough" or "because this other approach, while
slower, is more self evidently correct."

If you meant the latter, I still want to argue for the bit twiddling
approach. I verified that clang and gcc are both not smart enough to
recognize the pattern of ffs followed by shift and optimize to x & -x
(even on -O3 [1]), so using ffs is definitely slower and relies on a
bunch of machinery (alternatives because risc-v does not include a
dedicated count trailing zeros instruction in the base isa). To me
anyways, the logic of x & -x is pretty obvious, and even more so with
a comment, and this is actually in the hot path.

>
> > As for making another caching array, I guess, but again that is just a
> > time vs space trade off with its own invariants to maintain that would
> > also impact other platforms.
>
> It's a pointer in struct plic_handler (or whatever it's named) and you
> can allocate it when the quirk is required. The pointer is definitely
> not a burden for anyone else.

This I still don't understand how this is particuarly helpful. Since
we are doing mmio, this is going to be an explicit loop and not a
memcpy. The code is branchless in either case (set equal for the check
of i against j negate and and with mask before loading into the mmio).


>
> >> Is the device B interrupt preserved in the interrupt chip and actually
> >> raised when the interrupt enable bit is restored or is it lost?
> >
> > I am not sure how to verify this other than to tell you that without
> > this quirk (i.e. trying to use normal plic behavior) the device does
> > not work, but with this quirk I can boot to a desktop with a pcie
> > graphics card and storage, use networking etc that all obviously
> > depend on the correct functioning of the interrupt controller.
> >
> > My reading of the spec for PLIC also suggests (but does not explicitly
> > confirm) that the pending bits function irrespective of the state of
> > the corresponding enable bit: "A pending bit in the PLIC core can be
> > cleared by setting the associated enable bit then performing a claim."
> > (page 14 plic spec 1.0.0 [1]).
> >
> > This sentence implies to me that it is possible for a pending bit to
> > be set even though the corresponding enable bit is not, which lends
> > credence to the idea that the pending bits operate independently.
>
> Looks like that. Please add a comment to that effect then.

Will do.

>
> Thanks,
>
>         tglx
>

[1] https://godbolt.org/z/eofozYjPo


