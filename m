Return-Path: <linux-kernel+bounces-854500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDC2BDE851
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3DB402E73
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A95B39FCE;
	Wed, 15 Oct 2025 12:43:18 +0000 (UTC)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693741AA1F4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760532198; cv=none; b=lPk5cC+bf99xw4kz254xtY1pmjMhBSwupgU4NFl5FGH8s807lFoaPNPcvJ2NqFkzPkGsKDIsNI5608XrMpue1otubfEYfnEK+aIryPjhVxL9Gv197Y/HaaqmRWLGtMK6d6OS6XfcTfODfFTCsJaDleJQBR93VPMFX54ciZ7JceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760532198; c=relaxed/simple;
	bh=+Yoaw7rpYRqS6kyY0+V936fRl/rDGieCIgQeJif9Qus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtjhK30oMb19jiQEhug0E9/+p6UBsgubh9a7Scq9TUCzF/NHYRhrBjin9CTDCL+BcTEq08Qw7Acfkmo0+uWWQ2unZE5XFUxgBtIrrJQhmM/fGw0+NrmcBPoCsGWUwwVtbCOwzpHxTOhMhX3t3H3tqNalBb+thVI+QoveXWgit2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-554a627a257so2079690e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760532195; x=1761136995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6EImZFjleK3ggl+qc+EhSd4wqIwp2WAXLxGf2J2zAzc=;
        b=vb/RypIxdLOW+Bqj9uBsoMB6d31qsGhwipYrlh9Sj9ONJwoHFIw7RPQV7iXuFtQmIJ
         jvjg5Rs0isNiH7cPxHGCd45kg6DiFBGrW5Eh8/JtG45y9auCZ6gux6RZSPi3rvK8B8QM
         f2CQ3N+/Llamq/g0C7/A/fIfzn88GtP3I49dj+3a0Y10YE4MPURRKEQjyR+CH57dC1ut
         DfCW9/gCGa9WwXHc0S8Mpl7Azuli2RLlmy5b0gE5LIwzD8OPxQHW4Sa9LyOX4OIXx/FS
         S0TL/RLnY5AaxJq4VPJxzPDGRPGjUYo0KWW7+cxGeOb0kVW/lULSzcVcwfoSAfMupqUE
         MW6A==
X-Forwarded-Encrypted: i=1; AJvYcCUN8/cyJXHxFwYLH4IKKWdUIUbF4JzP1D9WyzDf9pa7ZEAawzsAYCKin4Uz2DdRSZZ8wlXsmWoq0upb34I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXrJ6/xW2C3yfdeaMyZsdVQZcSZLuCt9FtQ8PwnUsRcVSf80xp
	lghik+rXOAsSypSRUbaTZaHSXyV/OC4LC3gYvffsFgBmQHLEA2SiiuLm7mHWcaKA
X-Gm-Gg: ASbGncu8tj76Q9QVevSljZ03v1XbIHBqA7zg+gbuqMjx8fkszbhxDe2n5nkR//NGCZM
	M6lJGn0DTD53rUVncaM/4SiJ4t0vJQjDfYXlcs/WcvrcNBsEJt9zyUXlbUuhFlFfDCzNhGOOKRa
	ftRjYixpR26OfFO2QRs6/f5eyojeFmyHgZQSY8Vows0mPS4LAambhAz+xEu87mNtbd8OU5PsyfC
	DlB0iU0rcLtFAyZsuvLBkx+ufZ3drN+Rp8Yfz6z2uakCIa4Wk4wA+tcZKgi4TwgweyBSlSIXOcd
	9Dl8xmFrcLdRBkE0FO9O1zkTq5FQSCbFqCwBcOFcgkqAz7RI5CcmxiOCStptXfxGdqFZvTgCxPi
	X32OAt8KgIaBwzMT4cnHes2LxXNe9opm5HS8v3F8dYHMlQruQzEIJRoWL7d6/z9ujQ8G3Lbtx0F
	AM/0djGxTVm/HXXw==
X-Google-Smtp-Source: AGHT+IGBzv6kfx/YZ+dHBFg7wmZDsb574xEYgEkNz/2BmZOdh0qUVBJyZZfSloZy9yNNU1J3oE3ctw==
X-Received: by 2002:a05:6122:310e:b0:54a:23dd:5a9e with SMTP id 71dfb90a1353d-554b8b3e3b5mr8161854e0c.3.1760532194921;
        Wed, 15 Oct 2025 05:43:14 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7ecf564sm4978224e0c.2.2025.10.15.05.43.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 05:43:14 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-59dff155dc6so3158532137.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:43:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU89zUrNULU3b4UQX/lkPpZhE1bQ0kL7BK2AdInjfo7eWdhdFjgmE7s0Ab7oKN8wqqAknmahpJWTr1Nr8s=@vger.kernel.org
X-Received: by 2002:a05:6102:5086:b0:535:af8c:ba68 with SMTP id
 ada2fe7eead31-5d5e23b904amr9889952137.33.1760532194287; Wed, 15 Oct 2025
 05:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012091000.1160751-1-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20251012091000.1160751-1-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Oct 2025 14:43:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXJfSoU-160BmD-obd7YZRdKT4z-P1YnrvvR1dq7XKaDg@mail.gmail.com>
X-Gm-Features: AS18NWCUqZtnjb3YrOJg9WSKYkypgBOIOyBo-RtC55Gk-E59ZzxvngTKEVnZ788
Message-ID: <CAMuHMdXJfSoU-160BmD-obd7YZRdKT4z-P1YnrvvR1dq7XKaDg@mail.gmail.com>
Subject: Re: [RFC] clocksource/drivers/sh_cmt: Always leave device running
 after probe
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

Thanks for your patch!

On Sun, 12 Oct 2025 at 11:10, Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The CMT device can be used as both a clocksource and a clockevent
> provider. The driver tries to be smart and power itself on and off, as
> well as enabling and disabling its clock when it's not in operation.
> This behavior is slightly altered if the CMT is used as an early
> platform device in which case the device is left powered on after probe,
> but the clock is still enabled and disabled at runtime.
>
> This have worked for a long time, but recent improvements in PREEMPT_RT

has

> and PROVE_LOCKING have highlighted an issue. As the CMT register itself

registers

> as a clockevent provided, clockevents_register_device(), it needs to use

provider

> raw spinlocks internally as this is the context of which the clockevent
> framework interacts with the CMT driver. However in the context of
> holding a raw spinlock the CMT driver can't really manage its power
> state or clock with calls to pm_runtime_*() and clk_*() as these calls
> end up in other platform drivers using regular spinlocks to control
> power and clocks.
>
> This mix of spinlock contexts trips a lockdep warning.
>
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>     [ BUG: Invalid wait context ]
>     6.17.0-rc3-arm64-renesas-03071-gb3c4f4122b28-dirty #21 Not tainted
>     -----------------------------
>     swapper/1/0 is trying to lock:
>     ffff00000898d180 (&dev->power.lock){-...}-{3:3}, at: __pm_runtime_res=
ume+0x38/0x88
>     ccree e6601000.crypto: ARM CryptoCell 630P Driver: HW version 0xAF400=
001/0xDCC63000, Driver version 5.0
>     other info that might help us debug this:
>     ccree e6601000.crypto: ARM ccree device initialized
>     context-{5:5}
>     2 locks held by swapper/1/0:
>      #0: ffff80008173c298 (tick_broadcast_lock){-...}-{2:2}, at: __tick_b=
roadcast_oneshot_control+0xa4/0x3a8
>      #1: ffff0000089a5858 (&ch->lock){....}-{2:2}
>     usbcore: registered new interface driver usbhid
>     , at: sh_cmt_start+0x30/0x364
>     stack backtrace:
>     CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.17.0-rc3-arm64-ren=
esas-03071-gb3c4f4122b28-dirty #21 PREEMPT
>     Hardware name: Renesas Salvator-X 2nd version board based on r8a77965=
 (DT)
>     Call trace:
>      show_stack+0x14/0x1c (C)
>      dump_stack_lvl+0x6c/0x90
>      dump_stack+0x14/0x1c
>      __lock_acquire+0x904/0x1584
>      lock_acquire+0x220/0x34c
>      _raw_spin_lock_irqsave+0x58/0x80
>      __pm_runtime_resume+0x38/0x88
>      sh_cmt_start+0x54/0x364
>      sh_cmt_clock_event_set_oneshot+0x64/0xb8
>      clockevents_switch_state+0xfc/0x13c
>      tick_broadcast_set_event+0x30/0xa4
>      __tick_broadcast_oneshot_control+0x1e0/0x3a8
>      tick_broadcast_oneshot_control+0x30/0x40
>      cpuidle_enter_state+0x40c/0x680
>      cpuidle_enter+0x30/0x40
>      do_idle+0x1f4/0x26c
>      cpu_startup_entry+0x34/0x40
>      secondary_start_kernel+0x11c/0x13c
>      __secondary_switched+0x74/0x78
>
> For non-PREEMPT_RT builds this is not really an issue, but for
> PREEMPT_RT builds where normal spinlocks can sleep this might be an
> issue. Be cautious and always leave the power and clock running after
> probe.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>

Thanks, I gave this a try on various boards, no issues seen.
I also force-disabled the TMU on R-Mobile A1, to make sure its known
splat is not hiding any other locking problems.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

