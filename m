Return-Path: <linux-kernel+bounces-769976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3CEB27589
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AECB5C5537
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E01C1F22;
	Fri, 15 Aug 2025 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="k5RK7Wmg"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF03FC2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224328; cv=none; b=RGP7gPIfnHhuCwUWYMUktwVdsybQkSFXkCCeMumZA50BDoWj6Jpy/AEmR6PCWBjKhqqgr7mk1MPHaes/55Ilt+OpcLyhyvvauxGMQrc8kLt9chUrUC/9w0r3TnydPSGse+WW8+blVrMiO/yt5nGtKjGZYri5g1Uwt/93mBZwXh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224328; c=relaxed/simple;
	bh=t8RSHZ6OjPUsMtSaT3pq/sRRfGQPHrnQwa+ouSZv0dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tp9NgGqXYBu4/pgwAf/QG9S0OCz0PAkGN5pA3NNWRf8n00KIq4sFM5OuKgLAzvIHrtGWr1lYmn2F0I8Gmn7ZyNaeJF5JQ0grrD92f2kBOoDoU4ttC0JyxRUvHgh0XevtpsN1FKKoIeZo3ooLzTX1G9h4hQJEce0LgYGrVcBHHfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=k5RK7Wmg; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e931cc2ab5fso1381895276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 19:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1755224325; x=1755829125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOZvgVfE+JUn9uYJ2foRS0Df6ye2j3Q55Mkq9l/JFHQ=;
        b=k5RK7Wmg/BDNxHQxHEavQ7zFnbTtDASjGQXx59YKibqyhWv5BA9/HVwSVWi+X+or0s
         fOY+mPz8B66szcv4sHdJSu4MsEUGQMlWPNKrTt47n1pjoJ30fdx1oeHRb2m2XxS6xwwg
         tYfUfl7SV7DYVqSDxn4N2OhFxuvs0rtsPigxSbx3rndokba4QPmIRpoEaFWaKhYx+M6C
         mOBz0LZ9LXWsinNSfPGlye1i7FSOcEc1AYSEbUs82sMy+gZmi7WXG9Sau+EFmzdyuH0v
         Y2ubz7TeOR+hHQrQ7XcebglmR0RGbcq94NR3qwKEx5qLr/y3P2rJQ/MFBEZvENGgjjnj
         U5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755224325; x=1755829125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOZvgVfE+JUn9uYJ2foRS0Df6ye2j3Q55Mkq9l/JFHQ=;
        b=u05jP7fEeEPjE/LHblTu/0zwo3OnEbVM0ntFNF0++Z4gOEhn/jMJoXLd65bDZxpQ/2
         6+J0qdXK/+8ajD9vY1HrMrFMmtzacuF9NVoFv4hMKni2MbEvbQeyxL58uNCTbJQJRa02
         sncQyQq1VCNvNxf90ljr1wK7C/feoTwH0ZlmM9wxXwhu8XzTQ5jLqUtVmUeiwcAc3GUT
         M70LacrIwnSE2jKvHb7kDt9lracjtZaO+LieiWVRIjhuHnfgnvsY3xK4ggZ0DoMzsq4K
         KdUwg/Vt7XZJ/bAbNu2+YTkGzHQ16UoxPkOqSWnARN5azIwXYx055FzgW1jzu7llxIoA
         PMug==
X-Forwarded-Encrypted: i=1; AJvYcCX+9zR5F7DM2MQyq6TwiZi2hrOA0ySMnFCHr71lq5CKaBP8T0kKofw3VqV3lyvgr3aEKeU4n6w5DiwwFFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2eZ2epazHs21C/QJRQjizpcqHNGPP5y3nnQ1s15Ic1e0eafD+
	q2qT7D6biWG41B+DCud4Cg6mfgmXst4FjBRHS+IMKAp+3SoD4WcvBFiE4IG93QzoVLbvj6Td1WM
	9eieJj5e64wYsq4AgQ3Fe/cdQ/K6fqmpvFcFIKeI1dg==
X-Gm-Gg: ASbGncuhoJ9Sizk+HihAjuqMpwSE8suqqVhhxU5lBrmvECs0B3P3f97MvWYtD0HcC3g
	nkl6qB9o8zmRVVmlapVKWbgoOwUv7NeMO08VRWu+naZmFIMzq9xWsud7OI/cFGFgkdVfTWF3EMp
	Vghy8DvG8MCAFwyBj3qBnACajRjCDAP+xdr8tL/BnSq1pvBb/5DBkmJnQ8cPYikQFvYZouTmG2l
	LmtmZR7/w==
X-Google-Smtp-Source: AGHT+IElpzlua+gVZHtnvJL7hFwHgS462GQjnAnGMOd/xRwASet4kts+VonpOCNzZY6qEMZ52yEfTGFEq5Y7BbXpjRY=
X-Received: by 2002:a05:6902:15cf:b0:e90:42e4:e094 with SMTP id
 3f1490d57ef6-e93324a14d0mr603903276.38.1755224325105; Thu, 14 Aug 2025
 19:18:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806082726.8835-1-nick.hu@sifive.com> <20250806082726.8835-2-nick.hu@sifive.com>
 <878qjwejpr.ffs@tglx>
In-Reply-To: <878qjwejpr.ffs@tglx>
From: Nick Hu <nick.hu@sifive.com>
Date: Fri, 15 Aug 2025 10:18:34 +0800
X-Gm-Features: Ac12FXx_CtgmkrWHwUuo7-39L6uF5EOVU6mDaTufWbFl3BC8HFHO0YbtV49FZxk
Message-ID: <CAKddAkBfBn7TPWB_nbSbPzH+Rgjcci1N4wR3FJ8kxh2QCTWQEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] irqchip/riscv-imsic: Restore the IMSIC registers
To: Thomas Gleixner <tglx@linutronix.de>
Cc: anup@brainfault.org, Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 8:08=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Wed, Aug 06 2025 at 16:27, Nick Hu wrote:
>
> "Restore the IMSIC registers" does not tell me anything useful. When are
> they restored?
>
I=E2=80=99ll update it to: =E2=80=9CPreserve the IMSIC states after PM=E2=
=80=9D

> > When the system woken up from the low power state, the IMSIC might be i=
n
>
> is woken up from a low power state
>
> > the reset state.
>
> The real important information is:
>
>    When the system enters a low power state the IMSIC might be reset,
>    but on exit nothing restores the registers, which prevents interrupt
>    delivery.
>
> Or something like that.
>
> > Therefore adding the CPU PM callbacks to restore the IMSIC register
> > when the cpu resume from the low power state.
>
> This is not a valid sentence.
>
>   Solve this by registering a CPU power management notifier, which
>   restores the IMSIC on exit.
>
> Or such.
>
> See
>
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#change=
log
>
> for further explanation.
>
I'll correct it in the next version. Thanks.

> > diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/=
irq-riscv-imsic-early.c
> > index d9ae87808651..62bcbcae8bd4 100644
> > --- a/drivers/irqchip/irq-riscv-imsic-early.c
> > +++ b/drivers/irqchip/irq-riscv-imsic-early.c
> > @@ -7,6 +7,7 @@
> >  #define pr_fmt(fmt) "riscv-imsic: " fmt
> >  #include <linux/acpi.h>
> >  #include <linux/cpu.h>
> > +#include <linux/cpu_pm.h>
> >  #include <linux/interrupt.h>
>
> This does neither apply against Linus tree nor against tip
>
> > -static int imsic_starting_cpu(unsigned int cpu)
> > +static void imsic_restore(void)
>
> This function is used for both setup _and_ restore, so naming it
> restore() is misleading at best.
>
Will rename it to imsic_regs_init()

> >  {
> > -     /* Mark per-CPU IMSIC state as online */
> > -     imsic_state_online();
> > -
> > -     /* Enable per-CPU parent interrupt */
> > -     enable_percpu_irq(imsic_parent_irq, irq_get_trigger_type(imsic_pa=
rent_irq));
> > -
> >       /* Setup IPIs */
> >       imsic_ipi_starting_cpu();
> >
> > @@ -128,6 +123,19 @@ static int imsic_starting_cpu(unsigned int cpu)
> >
> >       /* Enable local interrupt delivery */
> >       imsic_local_delivery(true);
> > +}
> > +
> > +static int imsic_starting_cpu(unsigned int cpu)
> > +{
> > +     /* Mark per-CPU IMSIC state as online */
> > +     imsic_state_online();
> > +
> > +     /* Enable per-CPU parent interrupt */
> > +     enable_percpu_irq(imsic_parent_irq,
> > +                       irq_get_trigger_type(imsic_parent_irq));
>
> No line break required. You have 100 characters.
>
> > +
> > +     /* Restore the imsic reg */
>
> One IMSIC register? Can you please write proper sentences and write
> words out? This is not twitter. Also use IMSIC uppercase as the rest of
> the code does in the comments.
>
Sorry, I=E2=80=99ll be more careful.

> Thanks,
>
>         tglx

