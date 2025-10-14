Return-Path: <linux-kernel+bounces-851996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3574BD7E81
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A73424F6020
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EB530E0E6;
	Tue, 14 Oct 2025 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e50EonGE"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511630E0EB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427022; cv=none; b=grv1rnR3lK8VZOjpXibUTmEdv4mUVlMIqUuHoQA1edbdWnSREFoyxXHsookhAZ6S/M7ZphyLzt/+aRhQnAFFNuQjHcOf6qW6aUyH8YbLAT6c+6WK4leCz+aeh9CHIdHOunkV9ujHm65ZdBpxh/UI06nsrtic8k3jQuyegtvysAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427022; c=relaxed/simple;
	bh=81NIS2/I72XFASdail0a4m5/ef/jzz2CXXhiC8R4kbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEimjUvxetJeyDzyIxAoyJqEZQifFR4FlGz3/e+uFP1A67DCTuLZ7odXjhZ0jq8u8sy+FU7Tof6tJGLIVDbW4b6FipNJixa4yKWHpulTI5w0wU/tvdUxVT6f4/N4ra0srz19BHcrLRvGpOxllcTThPzxV9RLyxLJb3i/2nwWeM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e50EonGE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-426edfffc66so356572f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760427016; x=1761031816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjsmQsAWKR+AO8bY1bzFnlPN5sRWXcF5EVgjOHKuI0M=;
        b=e50EonGEjNkh0UPEI0QCgtwaqZVjMhrZZUPlBTn3sionV+1bpFkhzsOhxQz6FHEQzB
         4s0JsV6ZLO1+MPAbTHQoNETQRja0JCp2rDFvOkSZOsUo6c7aSeIyeH6bs6aW1iWzUkiG
         unTypavVglBMmX0Yslyc8FbFUsk5fXl4DulWG3gK9sKL4GaKU6SwsOntx3Ozb1tF4Dzo
         0Jsou2OI0utnnVSBxSXnO5kCBqCq6gu5aCXwm+dfjT6V42a4rEZ64cFDlO/cxCR06kAv
         BW9xzHiSLc1+HwdTDVTVy/6Y/CMCkwPE3ZQ1+CmwNUytRFxPxmDCy/lJYDlhOcPCnI/s
         jN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427016; x=1761031816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjsmQsAWKR+AO8bY1bzFnlPN5sRWXcF5EVgjOHKuI0M=;
        b=BCSOSXTmM4m/fj4EWxK96Vv7e5uGQU3Ath1KXq5JhbdzJW6J5JG5agGJjYa+IMRPuR
         cYIInrKoP1CQkTfoqejb+3HuRAFJiW0pk6xcIEglul3ompD4sk5ujpOqy9EBqjFXyVDY
         OKyZwosVcJAbQfKc3sDdqf6tYSX++AaDee4PuiTJtOPzLfJnGiWy4EAUdv4rw3L+FzU8
         NnOPtY/vTvIzv+V3elqfdS6PW1jMqWUgWIRHvNIVTHuQUM8Xnx2WnzJEIsLQ7pKcr1ms
         8QpVKO2eoVnfY9jSy4pxJtu8x6FnndcEsfD8bgVhyy9xXV9JV/rWOAg0F++pNCvf3+mO
         L/mg==
X-Forwarded-Encrypted: i=1; AJvYcCXXGxqmSoKir2Sg6XcpyVpN22pmuu91CrXhvlkV5ibRyJJSsmMb2+bqRb5Q6Xb+hApiMMAm3rIICqUvby8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVJ7M4q6oTB/8bnxY5ChhAXoxiM9Wi3BtpcIbdVyQKGnH30qXT
	mfzRl5Ie0do3Wq7CW3pUkd/XPeb0bIYrpuIykI30VEpbFMgUjpmGR1zZRCqHAt17uIqdZtZh/W8
	jySexFYHsOOH1a6GHVcFOFDcXhAQ+I0o=
X-Gm-Gg: ASbGncsNlCdmDle+80vvj/Z8/B/y2bMllFDxdY3aSp0VO7Ap0cWm1Q5ldtoW6ClVegD
	2P7oZmcFINXMB8rwjAS9lD+2n37Q2gh7DrY6aiWyOf78+qqn19HJJps+B5oLZ6g3xjhtpBsy08u
	3e4iK/NiSoIdZUcZDwKb9fiBaDdQPn9UL2/JtGgA4Vq7yrJVl2dxY7TcZxZ4eClK3fLl/yO1/7n
	fzhSZ2wseaAcuLmcd1u/8CgmLcNSDQvSAX8lWCGWo4Cr9RC0ywuzM00B8LQisBcG2QaLec=
X-Google-Smtp-Source: AGHT+IGo7dR5zdkJW3D/xH2KEeFf0lt7zeOM+boGa6AgEN+BBljNynuJv9D8o0+h3AZSmE1WSPqAQ/2P1ihf02bfAdk=
X-Received: by 2002:a05:6000:2504:b0:3ee:11d1:2a1e with SMTP id
 ffacd0b85a97d-425829b0d45mr20308975f8f.10.1760427016268; Tue, 14 Oct 2025
 00:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929112324.3622148-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXz0ThdhjeeurjE6TLXjVLXUy-ie-PqXHrTYExQ6TpeLA@mail.gmail.com>
 <CA+V-a8urG_e4yZXg9VH-cOPeK62qPGR1L2Zbbc3O97WB22hcRw@mail.gmail.com> <CAMuHMdWNnmmXPxPiuO4r66Mc78gPQ7ticuKt3y5pJ_DqRu_aLQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWNnmmXPxPiuO4r66Mc78gPQ7ticuKt3y5pJ_DqRu_aLQ@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 14 Oct 2025 08:29:50 +0100
X-Gm-Features: AS18NWCxsWOjy_XXbh2jQTyRM-GYEcEmaxy6wnT40dQ2eoo0RQ-PYJ_CEFPFTxU
Message-ID: <CA+V-a8tvd1uWNWqLSt4TQ-rD4Odfy0SiFX-4tWA2wsqae1wTeA@mail.gmail.com>
Subject: Re: [PATCH v4] clk: renesas: cpg-mssr: Add module reset support for RZ/T2H
To: Geert Uytterhoeven <geert@linux-m68k.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, Oct 14, 2025 at 7:46=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, 13 Oct 2025 at 18:45, Lad, Prabhakar <prabhakar.csengg@gmail.com>=
 wrote:
> > On Mon, Oct 13, 2025 at 4:46=E2=80=AFPM Geert Uytterhoeven <geert@linux=
-m68k.org> wrote:
> > > On Mon, 29 Sept 2025 at 13:23, Prabhakar <prabhakar.csengg@gmail.com>=
 wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Add support for module reset handling on the RZ/T2H SoC. Unlike ear=
lier
> > > > CPG/MSSR variants, RZ/T2H uses a unified set of Module Reset Contro=
l
> > > > Registers (MRCR) where both reset and deassert actions are done via
> > > > read-modify-write (RMW) to the same register.
> > > >
> > > > Introduce a new MRCR offset table (mrcr_for_rzt2h) for RZ/T2H and a=
ssign
> > > > it to reset_regs. For this SoC, the number of resets is based on th=
e
> > > > number of MRCR registers rather than the number of module clocks. A=
lso
> > > > add cpg_mrcr_reset_ops to implement reset, assert, and deassert usi=
ng RMW
> > > > while holding the spinlock. This follows the RZ/T2H requirements, w=
here
> > > > processing after releasing a module reset must be secured by perfor=
ming
> > > > seven dummy reads of the same register, and where a module that is =
reset
> > > > and released again must ensure the target bit in the Module Reset C=
ontrol
> > > > Register is set to 1.
> > > >
> > > > Update the reset controller registration to select cpg_mrcr_reset_o=
ps for
> > > > RZ/T2H, while keeping the existing cpg_mssr_reset_ops for other SoC=
s.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> > > > ---
> > > > v3->v4:
> > > > - Renamed cpg_mrcr_set_bit() to cpg_mrcr_set_reset_state() for clar=
ity.
> > > > - Updated the parameters in cpg_mrcr_set_reset_state().
> > >
> > > Thanks for the update!
> > >
> > > > --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> > > > +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> > > > @@ -736,6 +754,72 @@ static int cpg_mssr_status(struct reset_contro=
ller_dev *rcdev,
> > > >         return !!(readl(priv->pub.base0 + priv->reset_regs[reg]) & =
bitmask);
> > > >  }
> > > >
> > > > +static int cpg_mrcr_set_reset_state(struct reset_controller_dev *r=
cdev,
> > > > +                                   unsigned long id, bool set)
> > > > +{
> > > > +       struct cpg_mssr_priv *priv =3D rcdev_to_priv(rcdev);
> > > > +       unsigned int reg =3D id / 32;
> > > > +       unsigned int bit =3D id % 32;
> > > > +       u32 bitmask =3D BIT(bit);
> > > > +       void __iomem *reg_addr;
> > > > +       unsigned long flags;
> > > > +       unsigned int i;
> > > > +       u32 val;
> > > > +
> > > > +       dev_dbg(priv->dev, "%s %u%02u\n", set ? "assert" : "deasser=
t", reg, bit);
> > > > +
> > > > +       spin_lock_irqsave(&priv->pub.rmw_lock, flags);
> > > > +
> > > > +       reg_addr =3D priv->pub.base0 + priv->reset_regs[reg];
> > > > +       /* Read current value and modify */
> > > > +       val =3D readl(reg_addr);
> > > > +       if (set)
> > > > +               val |=3D bitmask;
> > > > +       else
> > > > +               val &=3D ~bitmask;
> > > > +       writel(val, reg_addr);
> > > > +
> > > > +       /*
> > > > +        * For secure processing after release from a module reset,=
 dummy read
> > > > +        * the same register at least seven times.
> > >
> > > This comment is waiting to become out-of-sync with the actual value..=
.
> > >
> > For the reset operation no, for this I would like to keep this as is.
> > But for the MSTP registers I will be adding a delay. Or did I
> > misunderstand something?
>
> How to make sure both "#define RZT2H_RESET_REG_READ_COUNT 7" and
> "seven" are updated together?
>
>     /*
>      * For secure processing after release from a module reset, one must
>      * perform multiple dummy reads of the same register.
>      */
>
Ahh got you now, thanks for the clarification.

> >
> > > > +        */
> > > > +       for (i =3D 0; !set && i < RZT2H_RESET_REG_READ_COUNT; i++)
> > > > +               readl(reg_addr);
> > > > +
> > > > +       /* Verify the operation */
> > > > +       val =3D readl(reg_addr);
> > > > +       if ((set && !(bitmask & val)) || (!set && (bitmask & val)))=
 {
> > >
> > > Perhaps just "set =3D=3D !(bitmask & val)"? Or is that too obscure?
> > >
> > Ok, I will update it to the above in v5.
>
> No need to resend yet, I could make these changes while applying
> (when Philipp is happy).
>
Ok, thank you.


Cheers,
Prabhakar

