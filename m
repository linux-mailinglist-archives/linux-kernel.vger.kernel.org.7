Return-Path: <linux-kernel+bounces-851915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F949BD79BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 131F54E5405
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F97526B765;
	Tue, 14 Oct 2025 06:46:42 +0000 (UTC)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D172A1D5174
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424401; cv=none; b=Grp7F8Ys9s5RBpdmgdvUNn90W78fCFLq6Uhw0w3wODK0S13DFPU6ovkCP9QONNgDN+KT6y/4yGDBnCjKzm0mDWxximvb2fASjl22euoA3UkvaXSt3cvZv6d4BJ1v0aEy8fDtComkCxSQvhSNDiG5An7LLH49f73fEGqDq3SHe/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424401; c=relaxed/simple;
	bh=N2ks0n64tB+/FE5YWhzQDWYySPPBMlfvugbK4YvBEKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LY4SbuzWk4zXpAwu7cdOGphdSdodzdsUwvAfiMTFGP8x/sa+LE5ryj7KZuRcf35u9+C9XaHbKa9ECrfE9p3/BaoQXQux5Usr0Q2+xYs+bj3X+GWMk0iilaypYm0Tjp6xg5jAEO/4k0/iFl5sFL/Gx/1xi4e46g0VXbKyBZi6HyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5aa6b7c085aso5656003137.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760424398; x=1761029198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSfE2Jj3hv2EA56oukoN3SzLUHfSpfGkpiKMB1tE1Ec=;
        b=JlvWLOQOssDCXL66lFAFo4V/GQg1cs6rltwxlToQ9vrJBEMfct35TJ5ibzr+cbRUC+
         dJm+TgBNMreO48gUxSuBroBg/w7NhUWwCLD8lVTehRt2UpPw4PTc7Sg/gu0BaRauNPPE
         z8j24GKXoG4bRTs8znbfMFY7hkqPFPo464KByrNEQcGYBlYogrzR0o2/SWd3JLbqdUpi
         ooqXuP4+xfAAULz1PaZJ8fpE3BCF9Ibetm/C40ZMHuSneRV5D/kmYrkbACDfeiUjs+LG
         5JguRbdNItcqRVORm2SF6eyeCoq5NJNAZrUPhTRmNSt/+rDkOzNs+qF4levmtUZR/uSR
         lHtw==
X-Forwarded-Encrypted: i=1; AJvYcCX9dH8Q32J1Hz1EGTDcwtFY7SShgyl+l1yklruMxt4cWQC2yuZ8TMSY+i4cJdGS67P/OWtfyUIS81Uxdc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcuQhg7c47LnBHaUkyLIPUI6vUrxOydpf2QPq+/q1IH5DNTopx
	+LDOMntBx66dL5XqgMcmC1haIiSlbShHqTh1egKEbGcfcNtWFRnMzgpHHN1ObSyj
X-Gm-Gg: ASbGncuR19z0C6F6sltyqpkL8EtUfzDw+nV8srdDk7qkK6FM1hmSbgk47gcMWHr2MoL
	XCLhGxICJigXAbArMOtd9jWeq0Iknhqq9GAjRBIz4qacwZhznjwc94/6Z7UmTkelRNMSjPU9hsm
	JH6BgsKLRYBYCaChRUlXkZDm8YYmfgt3DMyrcVRACDFKF+QKhnyOB689pHavPacLL2PeLwBFK2I
	3CEivY0x0yAiIBQIKHSNle6QsxwXd+EA7TQVyHFmazILQs2aiWwvXcEePF+dLN1EgQAOfjYxCw+
	c6kJ5X5RdH46JSBMa2JsTkf9qTJNngF58fYw95qY6Bmo2KVHra7YWsx/VrqwWu+rUzuvEZHXFTD
	uE1ogAQUlCe5ELs7cCOJP0NOugqz5MR8badlTsKZbTL3bkDyz+tCZSB9XLD16mI0zwLFSybS4MI
	UUlfFV5hk2Lq45xc6mnRJByC9x
X-Google-Smtp-Source: AGHT+IHoH4F5pUTAr70CkeeXJtQfA6Nlo/8RBwczghtL0mPgT3pWFHr4mwdUGBa+nTct0gk3M/U0Xg==
X-Received: by 2002:a05:6102:290f:b0:5d5:f6ae:38f4 with SMTP id ada2fe7eead31-5d5f6ae3ec7mr6680935137.43.1760424398151;
        Mon, 13 Oct 2025 23:46:38 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d7ecf4a4sm3788710e0c.3.2025.10.13.23.46.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 23:46:38 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-930c4cd6ccbso2290822241.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:46:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdDqZCipRA5b8uUlUa13TuvFEfazoycVptXYkGyCW6hX2q88rqWR/n8U/j40iSJo9XCRizGjJigXrZfME=@vger.kernel.org
X-Received: by 2002:a05:6102:6c3:b0:5d5:f6ae:38f2 with SMTP id
 ada2fe7eead31-5d5f6ae3eddmr6835548137.41.1760424397767; Mon, 13 Oct 2025
 23:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929112324.3622148-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXz0ThdhjeeurjE6TLXjVLXUy-ie-PqXHrTYExQ6TpeLA@mail.gmail.com> <CA+V-a8urG_e4yZXg9VH-cOPeK62qPGR1L2Zbbc3O97WB22hcRw@mail.gmail.com>
In-Reply-To: <CA+V-a8urG_e4yZXg9VH-cOPeK62qPGR1L2Zbbc3O97WB22hcRw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 14 Oct 2025 08:46:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNnmmXPxPiuO4r66Mc78gPQ7ticuKt3y5pJ_DqRu_aLQ@mail.gmail.com>
X-Gm-Features: AS18NWCq45AWdwHRPSKHrYKOvzjULBWX8ax2oWaB6g9V2rbkYgBc5E0MPDXBfwk
Message-ID: <CAMuHMdWNnmmXPxPiuO4r66Mc78gPQ7ticuKt3y5pJ_DqRu_aLQ@mail.gmail.com>
Subject: Re: [PATCH v4] clk: renesas: cpg-mssr: Add module reset support for RZ/T2H
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Mon, 13 Oct 2025 at 18:45, Lad, Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> On Mon, Oct 13, 2025 at 4:46=E2=80=AFPM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Mon, 29 Sept 2025 at 13:23, Prabhakar <prabhakar.csengg@gmail.com> w=
rote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Add support for module reset handling on the RZ/T2H SoC. Unlike earli=
er
> > > CPG/MSSR variants, RZ/T2H uses a unified set of Module Reset Control
> > > Registers (MRCR) where both reset and deassert actions are done via
> > > read-modify-write (RMW) to the same register.
> > >
> > > Introduce a new MRCR offset table (mrcr_for_rzt2h) for RZ/T2H and ass=
ign
> > > it to reset_regs. For this SoC, the number of resets is based on the
> > > number of MRCR registers rather than the number of module clocks. Als=
o
> > > add cpg_mrcr_reset_ops to implement reset, assert, and deassert using=
 RMW
> > > while holding the spinlock. This follows the RZ/T2H requirements, whe=
re
> > > processing after releasing a module reset must be secured by performi=
ng
> > > seven dummy reads of the same register, and where a module that is re=
set
> > > and released again must ensure the target bit in the Module Reset Con=
trol
> > > Register is set to 1.
> > >
> > > Update the reset controller registration to select cpg_mrcr_reset_ops=
 for
> > > RZ/T2H, while keeping the existing cpg_mssr_reset_ops for other SoCs.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> > > ---
> > > v3->v4:
> > > - Renamed cpg_mrcr_set_bit() to cpg_mrcr_set_reset_state() for clarit=
y.
> > > - Updated the parameters in cpg_mrcr_set_reset_state().
> >
> > Thanks for the update!
> >
> > > --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> > > +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> > > @@ -736,6 +754,72 @@ static int cpg_mssr_status(struct reset_controll=
er_dev *rcdev,
> > >         return !!(readl(priv->pub.base0 + priv->reset_regs[reg]) & bi=
tmask);
> > >  }
> > >
> > > +static int cpg_mrcr_set_reset_state(struct reset_controller_dev *rcd=
ev,
> > > +                                   unsigned long id, bool set)
> > > +{
> > > +       struct cpg_mssr_priv *priv =3D rcdev_to_priv(rcdev);
> > > +       unsigned int reg =3D id / 32;
> > > +       unsigned int bit =3D id % 32;
> > > +       u32 bitmask =3D BIT(bit);
> > > +       void __iomem *reg_addr;
> > > +       unsigned long flags;
> > > +       unsigned int i;
> > > +       u32 val;
> > > +
> > > +       dev_dbg(priv->dev, "%s %u%02u\n", set ? "assert" : "deassert"=
, reg, bit);
> > > +
> > > +       spin_lock_irqsave(&priv->pub.rmw_lock, flags);
> > > +
> > > +       reg_addr =3D priv->pub.base0 + priv->reset_regs[reg];
> > > +       /* Read current value and modify */
> > > +       val =3D readl(reg_addr);
> > > +       if (set)
> > > +               val |=3D bitmask;
> > > +       else
> > > +               val &=3D ~bitmask;
> > > +       writel(val, reg_addr);
> > > +
> > > +       /*
> > > +        * For secure processing after release from a module reset, d=
ummy read
> > > +        * the same register at least seven times.
> >
> > This comment is waiting to become out-of-sync with the actual value...
> >
> For the reset operation no, for this I would like to keep this as is.
> But for the MSTP registers I will be adding a delay. Or did I
> misunderstand something?

How to make sure both "#define RZT2H_RESET_REG_READ_COUNT 7" and
"seven" are updated together?

    /*
     * For secure processing after release from a module reset, one must
     * perform multiple dummy reads of the same register.
     */

>
> > > +        */
> > > +       for (i =3D 0; !set && i < RZT2H_RESET_REG_READ_COUNT; i++)
> > > +               readl(reg_addr);
> > > +
> > > +       /* Verify the operation */
> > > +       val =3D readl(reg_addr);
> > > +       if ((set && !(bitmask & val)) || (!set && (bitmask & val))) {
> >
> > Perhaps just "set =3D=3D !(bitmask & val)"? Or is that too obscure?
> >
> Ok, I will update it to the above in v5.

No need to resend yet, I could make these changes while applying
(when Philipp is happy).

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

