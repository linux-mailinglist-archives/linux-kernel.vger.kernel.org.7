Return-Path: <linux-kernel+bounces-851036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9469BBD5629
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3126D3E7D59
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3881926B971;
	Mon, 13 Oct 2025 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUqE/1Ks"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936B1213237
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373922; cv=none; b=cmmKeLtHcPer2OK2ZcOwrq/bPYZZI/sdIvSqfPJ28hcmy22zyxgxpp9WyEo37WgIYEVwD68Z/nRSIgZS1Vn0PWZd80cjsxWbq2eCvcdhka/7da5v6blDxX3PgzHS17VocDwvMeuwIu1E7cSS+mSPIJwpStX8ndOvvFB7bV1KiUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373922; c=relaxed/simple;
	bh=0wTihLOD99fRq7kWBMtjXLXmc8J0Akxg7M80xoV5nnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FumwiQKVqFac4VlHLwt6fF09wdCSCmwVqx1unkS1T5kEycOeu+FOgXC9u3i6vajWXHcJF2jxZX2OEC80sjeK0X5O2TTN0RNVPkD2GvQY4gKyWAu6KiWaHl8KKdb8VFR5D7dAauOkVPTBwLXw6iAHGCafP2t2ALf3wYBu39FAeTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUqE/1Ks; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee130237a8so3564330f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760373919; x=1760978719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bm/7+n2mKW42M8RxL5Oj+vsywNFzwHrxsNk7zzkAZi0=;
        b=OUqE/1Ks5LUsaO1cITsVFTzTfZ5bikpUOuGvvxer7crCYxJJoC8EPq21TH95WNn3e9
         oc2kq21tildUCXFmqTjhUg6Wi2QWGt7dfGT4uNUFKZ1BGVdkjZmKvKKVzYeJr2g+PPlT
         bU0U+qz3tizok054Eahr+7BBXFXjg1xAyASCaN6S0QZFnD/m8qVArPVjApTa2QSH6sAT
         Ha506+HLugASfms8rhLX2RheSiWWkufBE3zFzWIrr69upQZjLXgjNw9GQ477wJbNq/kB
         Vuq5JMxIxlIDiQVp8SDvJieVkjG6C0jTOqq2r18qHpdZ1tfqIiZ49Q2vG9x97wRRupKu
         3ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760373919; x=1760978719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bm/7+n2mKW42M8RxL5Oj+vsywNFzwHrxsNk7zzkAZi0=;
        b=WymfJvFvx9hscHFSXAebAZx2GXt3bZ+Ra0mxr4d9hWk+8BQhpDqV+N7okwdahsc63x
         E+yU+KlUwPoHdNvTqvP3dpOrokClC8dlG2zshcmxXN3Uts3wfkCOcF4Lw9vgcZ5oN4u1
         kb3IVgfHoBuVZ1yLWNpOn/iKPDrBtFgtSVWM1TLxJ/vIaU585oIyQyRaL/bS9zF4Rhlu
         JCOFxND4jGvE0O02fKO2o0QFwG8FDZCxO2IbzRloWsohP5+xLg3hN3+EzbkwjFrCiIIT
         gdryKdb2LYfrVFf+lsv8+Tu5NMwzJ4QuIXqyeJb1wuKa/KPUnLtjfXKe+Cr0x6L5TYkz
         e+eA==
X-Forwarded-Encrypted: i=1; AJvYcCWG271JfKMbdrcrF2epQDqFadUjEoFn6Ip3mWAY+pUVLAywPrQ82qm87FgFvqZo8euu9nq+B+77X23cUms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGJr9+tQ6JH3fVr8I7ymBOzy9Rr1jL/Nmsku4A7ch/x+VlcA/U
	4aP6L6ibb0rSUPQZAlhzZ8uo1kToV2vftz/UObR6w7t8zau3uxHrxEaqMhtlYLE12BoKcKGFTZ/
	GUeiknBHeYPXt9pZb2XJgTBN4J/Tb/bk=
X-Gm-Gg: ASbGnctRsLG7tQThbQ2cPBKLRUywgjIc93CX1VcTRMIRbfKDot6EJldgVCJHfNqFEY8
	mciLt7J9a9ovYIrP0zQ0vWyZ4Cmx6RHTpRUKZ7QM/5ic/3WNtB0/Oki25bd66ueceBK0vPEYa28
	C8xgYTd7UWZr9/9+SZHJgwazHv9STKw6lpGew+C9xm122sH6GRE8uzaf7fmu6RreQmfFc9Cyg6S
	bk4fnYqufGzMTTgMB9lY8l1z1WcfjUCydJUsx4yiNUz7Ywc6r4AjZAQxavN
X-Google-Smtp-Source: AGHT+IFAeGAh4Wpnp3B5IRkMFfhupqiBX/iiJ3P/+Yj20ZzS6IuDiZo7IhU/1z0XLJ7PY/lxRHpoJi84zX1pyuIRQLg=
X-Received: by 2002:a05:6000:460b:b0:426:d51c:495b with SMTP id
 ffacd0b85a97d-426d51c4abemr6608215f8f.27.1760373918503; Mon, 13 Oct 2025
 09:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929112324.3622148-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXz0ThdhjeeurjE6TLXjVLXUy-ie-PqXHrTYExQ6TpeLA@mail.gmail.com>
In-Reply-To: <CAMuHMdXz0ThdhjeeurjE6TLXjVLXUy-ie-PqXHrTYExQ6TpeLA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 13 Oct 2025 17:44:52 +0100
X-Gm-Features: AS18NWCKBDqvR-oZRgUD7Bn15GS9DM_WwNfwWczE6IvmlyY-mHebH_EDvOspORg
Message-ID: <CA+V-a8urG_e4yZXg9VH-cOPeK62qPGR1L2Zbbc3O97WB22hcRw@mail.gmail.com>
Subject: Re: [PATCH v4] clk: renesas: cpg-mssr: Add module reset support for RZ/T2H
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Mon, Oct 13, 2025 at 4:46=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, 29 Sept 2025 at 13:23, Prabhakar <prabhakar.csengg@gmail.com> wro=
te:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add support for module reset handling on the RZ/T2H SoC. Unlike earlier
> > CPG/MSSR variants, RZ/T2H uses a unified set of Module Reset Control
> > Registers (MRCR) where both reset and deassert actions are done via
> > read-modify-write (RMW) to the same register.
> >
> > Introduce a new MRCR offset table (mrcr_for_rzt2h) for RZ/T2H and assig=
n
> > it to reset_regs. For this SoC, the number of resets is based on the
> > number of MRCR registers rather than the number of module clocks. Also
> > add cpg_mrcr_reset_ops to implement reset, assert, and deassert using R=
MW
> > while holding the spinlock. This follows the RZ/T2H requirements, where
> > processing after releasing a module reset must be secured by performing
> > seven dummy reads of the same register, and where a module that is rese=
t
> > and released again must ensure the target bit in the Module Reset Contr=
ol
> > Register is set to 1.
> >
> > Update the reset controller registration to select cpg_mrcr_reset_ops f=
or
> > RZ/T2H, while keeping the existing cpg_mssr_reset_ops for other SoCs.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v3->v4:
> > - Renamed cpg_mrcr_set_bit() to cpg_mrcr_set_reset_state() for clarity.
> > - Updated the parameters in cpg_mrcr_set_reset_state().
>
> Thanks for the update!
>
> > --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> > +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> > @@ -736,6 +754,72 @@ static int cpg_mssr_status(struct reset_controller=
_dev *rcdev,
> >         return !!(readl(priv->pub.base0 + priv->reset_regs[reg]) & bitm=
ask);
> >  }
> >
> > +static int cpg_mrcr_set_reset_state(struct reset_controller_dev *rcdev=
,
> > +                                   unsigned long id, bool set)
> > +{
> > +       struct cpg_mssr_priv *priv =3D rcdev_to_priv(rcdev);
> > +       unsigned int reg =3D id / 32;
> > +       unsigned int bit =3D id % 32;
> > +       u32 bitmask =3D BIT(bit);
> > +       void __iomem *reg_addr;
> > +       unsigned long flags;
> > +       unsigned int i;
> > +       u32 val;
> > +
> > +       dev_dbg(priv->dev, "%s %u%02u\n", set ? "assert" : "deassert", =
reg, bit);
> > +
> > +       spin_lock_irqsave(&priv->pub.rmw_lock, flags);
> > +
> > +       reg_addr =3D priv->pub.base0 + priv->reset_regs[reg];
> > +       /* Read current value and modify */
> > +       val =3D readl(reg_addr);
> > +       if (set)
> > +               val |=3D bitmask;
> > +       else
> > +               val &=3D ~bitmask;
> > +       writel(val, reg_addr);
> > +
> > +       /*
> > +        * For secure processing after release from a module reset, dum=
my read
> > +        * the same register at least seven times.
>
> This comment is waiting to become out-of-sync with the actual value...
>
For the reset operation no, for this I would like to keep this as is.
But for the MSTP registers I will be adding a delay. Or did I
misunderstand something?

> > +        */
> > +       for (i =3D 0; !set && i < RZT2H_RESET_REG_READ_COUNT; i++)
> > +               readl(reg_addr);
> > +
> > +       /* Verify the operation */
> > +       val =3D readl(reg_addr);
> > +       if ((set && !(bitmask & val)) || (!set && (bitmask & val))) {
>
> Perhaps just "set =3D=3D !(bitmask & val)"? Or is that too obscure?
>
Ok, I will update it to the above in v5.

Cheers,
Prabhakar
> > +               dev_err(priv->dev, "Reset register %u%02u operation fai=
led\n", reg, bit);
> > +               spin_unlock_irqrestore(&priv->pub.rmw_lock, flags);
> > +               return -EIO;
> > +       }
> > +
> > +       spin_unlock_irqrestore(&priv->pub.rmw_lock, flags);
> > +
> > +       return 0;
> > +}
>
> Regardless:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

