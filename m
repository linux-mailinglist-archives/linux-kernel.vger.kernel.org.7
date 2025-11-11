Return-Path: <linux-kernel+bounces-895728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE02EC4EC85
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9821888D91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906EE3659F3;
	Tue, 11 Nov 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnr41e1e"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332A93064AE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874760; cv=none; b=QhdiqaG0JhTBBkiHOcVozO0hUvTdmTilFxxMRtY/ya/V4fq3estEJyAalIAtzoPB60vHhitAs9yatERdKtACTMyj5odq0Si0R9OnmN1FNG7zF+/59S3Sscubb9zeaxHOZDA0GU4UnlbItemvi+QUSC4iYr1cDULbb8SY4toXfK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874760; c=relaxed/simple;
	bh=GFL/z+mAMfM+rN6KRMvwtyrqWMuq/0oUqc7eMK13QvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHtmHhWsJasHnB2ZFr9uFLVjO2XDRzIX4AWE8+MELzNyQHbtalvMaj8l82haShP1/ZCeNYUBP0/L0IHun3O3F+Pgj30fHYoDT9ga5zIuO16FvBPN2mKnDwyYc8Rui64Lo88vdO9gnQqLWGM9i7yJNght5SaAejnFhd/gtQL1ues=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnr41e1e; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775638d819so24715245e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762874757; x=1763479557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eIlBlRtrd1p+0MZfDvGmwpPkD/U37bHYUkIvdxe1/E=;
        b=dnr41e1eoXKAK7vbQ4+LuEwBMwsxpqRCK2O9L61dJ0oBeVBN5uSFZ6+TiK21D7fqbW
         73caZyMBgnW/jjQHqKHf2LvSVrGq4UljdzGvsdO2q5s/vpvNu3rKoX3QtFyDbW9twwm7
         tYIGwmKqFILuL7soI1Kc3vq70p0TKZFyP7LgcrJdQcm+kkK4qsOrKq1qosQZk1tjm/pG
         qJ7Z0xyGFrlcqDAUuZlQacpyMlecYjXFd279PwXlov8oh24/UFKWYBy2i9cXHel4s3hu
         8k6QK0bEeqTHoG9TTTqdInZ+2xmpz3/r3WGas7v44jJF4dwa9iA3LpWoNZCwKDCqOaRk
         QqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762874757; x=1763479557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+eIlBlRtrd1p+0MZfDvGmwpPkD/U37bHYUkIvdxe1/E=;
        b=rT0SwBJOTm/365lhFtpXffsue5DYpn0c3HJ47BEDEzyaZH3M2qOzOEkcIGDFP4DyQc
         OSz29rh3iMyfkXwC6M5kAI7Kjitoj6ot4A6kfkRtLx3zVQ7Kf7KriJXL5zexpgyQ4Kvg
         yuCkcBHp69H5QzrYby/7t2CoQ0uM/dk7xJHI3kSFj1V9w6qNC0scqqmxITW3GrNenpp9
         i+asj5L/WdNIPpyv508W0klMwN6jUzQ32sUue9ivQBPysaEE/ZTw+wZYIHfJnPSsIzLB
         zSUBkwDNIlfCgVvUty7uDxwmOlPWNrDcyDpUtn5DGUQeioKd+QCBhzCy4nwwWHJ3KY8e
         3puA==
X-Forwarded-Encrypted: i=1; AJvYcCWV6WEcmchXccEBzQH31aPmrMO3y1MqUWDcpMPHuyJdIVoTdNMH/xlj6BLOT7WqNoK6aggQlmdgy2Q8twU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVB+VQ/lFEFuauI80RddVNea6VtTKDCVmHl7gATetRXw+6cTYQ
	Myvud/ot0mKM00aEl/MKqebSWy1VObg1kdqLHb7VfQ7peRl1gz3h9m5WaQG+ylZZrVL4L8bKgto
	nsZ+KFpIRWVhysG5Krt+4wI052iK2ALI=
X-Gm-Gg: ASbGncuvfpaoaOGO+BeWJK2iUQxSFycIx5Vpn81cRNyVHoZH2BUHanKD0NJesrYZjep
	BUJu3lXmpot4161v/0MIgRBjYl8Bq4h1aFAnFlgChM0wBdehACzfrjz+DF2HcyylHU1TrHVa1uA
	JWoqB9as5d30IHL2zeC1hPIS0uQBJ5nPeg7XFLJCYV8jQd2zL6C64s6gsSc9Cl5NalWcnyZk6WD
	imS7cTSgC5fCRHwiJIeJpmirRN5O2z3Dc7FmgrljiJCopQXUp1lNbia6S3e2dmO2IEbmKwD9iMx
	28t9Xqr/
X-Google-Smtp-Source: AGHT+IFNVrHlhP0Ql13bgsDdcB8lXgcsY0rs+9SGgl/ejSJ1whACt+m7DGFiuz1nodGFp4dmMelD/JHxBtIkiat016o=
X-Received: by 2002:a05:600c:3552:b0:477:fcb:226b with SMTP id
 5b1f17b1804b1-47773230abbmr107163815e9.2.1762874757383; Tue, 11 Nov 2025
 07:25:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111091047.831005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251111091047.831005-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <40e744b5-cc17-4b33-8d0b-1e9987eece7c@microchip.com> <CA+V-a8t5Ac_pb3iUGsQSEiJ_Ji-TrKGr-E6xCJEcx_cK2nKeFA@mail.gmail.com>
 <59e68865-fc18-4180-8e18-91ba78b40118@lunn.ch>
In-Reply-To: <59e68865-fc18-4180-8e18-91ba78b40118@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 11 Nov 2025 15:25:30 +0000
X-Gm-Features: AWmQ_bkAJ4OwXXVvGDL_HW-K6Mcyz8rG5DPp2DppCygHFFbqMH6e7uWDQGK-CEo
Message-ID: <CA+V-a8u1V=vEZz0FVVK6mtN9HyVaDkwdQ7fzFVsoxcbCnLMS0g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: phy: mscc: Consolidate probe
 functions into a common helper
To: Andrew Lunn <andrew@lunn.ch>
Cc: Parthiban.Veerasooran@microchip.com, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Horatiu.Vultur@microchip.com, 
	geert+renesas@glider.be, vladimir.oltean@nxp.com, vadim.fedorenko@linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, biju.das.jz@bp.renesas.com, 
	fabrizio.castro.jz@renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Tue, Nov 11, 2025 at 1:25=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Nov 11, 2025 at 09:56:12AM +0000, Lad, Prabhakar wrote:
> > Hi Parthiban,
> >
> > Thank you for the review.
> >
> > On Tue, Nov 11, 2025 at 9:50=E2=80=AFAM <Parthiban.Veerasooran@microchi=
p.com> wrote:
> > >
> > > Hi,
> > >
> > > On 11/11/25 2:40 pm, Prabhakar wrote:
> > > > +static int vsc85xx_probe_common(struct phy_device *phydev,
> > > > +                               const struct vsc85xx_probe_config *=
cfg,
> > > > +                               const u32 *default_led_mode)
> > > > +{
> > > > +       struct vsc8531_private *vsc8531;
> > > > +       int ret;
> > > > +
> > > > +       vsc8531 =3D devm_kzalloc(&phydev->mdio.dev, sizeof(*vsc8531=
), GFP_KERNEL);
> > > > +       if (!vsc8531)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       phydev->priv =3D vsc8531;
> > > > +
> > > > +       /* Check rate magic if needed (only for non-package PHYs) *=
/
> > > > +       if (cfg->check_rate_magic) {
> > > > +               ret =3D vsc85xx_edge_rate_magic_get(phydev);
> > > > +               if (ret < 0)
> > > > +                       return ret;
> > > > +
> > > > +               vsc8531->rate_magic =3D ret;
> > > > +       }
> > > > +
> > > > +       /* Set up package if needed */
> > > > +       if (cfg->use_package) {
> > > > +               vsc8584_get_base_addr(phydev);
> > > > +               devm_phy_package_join(&phydev->mdio.dev, phydev,
> > > > +                                     vsc8531->base_addr, cfg->shar=
ed_size);
> > > Don't you need to check the return value here?
> > >
> > Good point. The orignal code didn't check the return value. Would you
> > prefer a separate patch on top of this series or fix it in this
> > consolidation patch itself?
>
> When refactoring, it is best to not make changed, keep the code
> logically the same. Then add additions afterwards. If something
> breaks, a git bisect then tells you if it was the refactor or the
> additions that broke it.
>
Agreed, I will add a patch on top of this patch (as you have already
reviewed it)

Cheers,
Prabhakar

