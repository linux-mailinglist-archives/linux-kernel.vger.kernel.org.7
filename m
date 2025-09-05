Return-Path: <linux-kernel+bounces-803223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD571B45C55
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A229B16E4F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117FA31B803;
	Fri,  5 Sep 2025 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogeoxe37"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567BE31B835;
	Fri,  5 Sep 2025 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085455; cv=none; b=pzPwatmIWNKNDlV+R05zRRKSefUV6Yj+a0r5U5UfdiH5bZkOB5EIJxQEEWQS4VCz7EVPWgHF+OuAJP0UQoj+yEEOsuX08Lby8JDzDiixugfuKyQfd3pEXXWj/GSa2o5ws/kre0KBGMk/PbD95N9lwOFdc1P70iDd9xGPpqyXa7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085455; c=relaxed/simple;
	bh=dr+T2rwp5B5VrM1rUBLT6viu/Q1Jhzb6unLFntNx2/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezGnHePKgqwFNRccoYFNoZcEs4oCj7hVf+csIorIVOvvP/tD+mIovKRXslbLaB98/mK86sgzjHN+moqDFbL9uBh0UE3Lo6S7s8X6YsCuzOYIiXjuEZjIdEAYRujDPqsMkl5hjTMcNJkY+lDhUJXXV7ICHdB2m+4H3xy1dWBq+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogeoxe37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84D8C4CEF4;
	Fri,  5 Sep 2025 15:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757085454;
	bh=dr+T2rwp5B5VrM1rUBLT6viu/Q1Jhzb6unLFntNx2/o=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=ogeoxe37ksPcj8h2cL77V8KZpT6J9875/nOiZH8QepCfGPkYjNt4/oEh+JrcY9A7z
	 N8GUmBWx/xFZ7LADTDAO5JNKmlzxSn+KnCpRDfdgT0T3OitF2zcX1sG3gl2zeo+6Ac
	 UjySxmwlZ+kb8C4NrmUhr3oVsV/nngOC+NTZNgyGJs1Y9rW6b+whoMLEvD5y4DfnTB
	 Zx3gi2SljRWd78NWlgL6BzJNH7EUwe3eaMG8HXLH/2zElwL0K0nfFojueWpIuh4u24
	 714E5DefpgOSSuvuJpI+fsSLn6UDl4zcleFT2LH1YdVqjOhmNj7dafCIE/85utTudH
	 z6t6IugrwJkfg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-336dc57f3f2so22264221fa.3;
        Fri, 05 Sep 2025 08:17:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUV+jKgaBUjJyD8pylkxggLh4gAz5LdM/ngjEc883bmDH1X3D4FZRscVtu4UojzW/yC9A2dSy4NUqHy@vger.kernel.org, AJvYcCUgrNY+jE344RS/2EALE1ofqtssmBWmd0QBP9YDxWoCP76P8Hk+G+ag0kKWVNu5D8RfA3wPJ8SbwrAKIpdG@vger.kernel.org, AJvYcCWlayOM5zFXEi2e+l3PnsqLQ+zoQzeDvLXt50AEukCD6Oy5oGEjkJ6G2Qj0a8eVrMRMIs9I9HiA7aNg@vger.kernel.org
X-Gm-Message-State: AOJu0YztXxpuJk6upK7IEytpALJDr0odqkL5Rhkvb7p54Z3aqW0Jxzwe
	fGK5cw/19b0QssSmQ7CiTrpSMcxt2X3gI8oy+w5j60IvzWUbF2FOe9KozLp/Sbr3Yfy5QWp+QqC
	UBZ7CjLti/w2sTLCFqkmEbKlTLJoAqqM=
X-Google-Smtp-Source: AGHT+IHuctgvaReJVM5L6lLElO1ujTh+IJ3xit6qqIlU8KTDuhaXRGGAdYM2dar503Kj7x8VhbLVORGMlP0Lcie3F3I=
X-Received: by 2002:a05:651c:b23:b0:337:e410:cb1d with SMTP id
 38308e7fff4ca-337e410ccf5mr52525011fa.43.1757085453105; Fri, 05 Sep 2025
 08:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830170901.1996227-1-wens@kernel.org> <20250830170901.1996227-4-wens@kernel.org>
 <20250905161236.51b6ecee@donnerap>
In-Reply-To: <20250905161236.51b6ecee@donnerap>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 5 Sep 2025 23:17:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v65utA6PsoAS-wLPskYy9GGXfESvtiwOBC4qSdi1XvLeKQ@mail.gmail.com>
X-Gm-Features: Ac12FXx524PiYu7fy0CjI9wjWYIIgWKZl0OQuhFEwY-L-xvtcN5IjLcA6m5m72w
Message-ID: <CAGb2v65utA6PsoAS-wLPskYy9GGXfESvtiwOBC4qSdi1XvLeKQ@mail.gmail.com>
Subject: Re: [PATCH 3/8] clk: sunxi-ng: mp: Fix dual-divider clock rate readback
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 11:12=E2=80=AFPM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> On Sun, 31 Aug 2025 01:08:56 +0800
> Chen-Yu Tsai <wens@kernel.org> wrote:
>
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > When dual-divider clock support was introduced, the P divider offset wa=
s
> > left out of the .recalc_rate readback function. This causes the clock
> > rate to become bogus or even zero (possibly due to the P divider being
> > 1, leading to a divide-by-zero).
>
> Ah, a nice catch, thanks for that! Just curious, how did you find this?
> The MMC clocks use the dual divider type as well, but I didn't observe
> them being wrong?

I was looking at clk_summary in debugfs and kept seeing some of the audio
clocks returning 0 and dumped the register to get the actual value. I then
did a printk trace of the .determine_rate callback and saw that one of the
dividers was always 1. I guessed that the .recalc_rate callback was to blam=
e.

> Regardless:
>
> > Fix this by incorporating the P divider offset into the calculation.
> >
> > Fixes: 45717804b75e ("clk: sunxi-ng: mp: introduce dual-divider clock")
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks!


> Thanks,
> Andre
>
> > ---
> >  drivers/clk/sunxi-ng/ccu_mp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_m=
p.c
> > index 354c981943b6..4221b1888b38 100644
> > --- a/drivers/clk/sunxi-ng/ccu_mp.c
> > +++ b/drivers/clk/sunxi-ng/ccu_mp.c
> > @@ -185,7 +185,7 @@ static unsigned long ccu_mp_recalc_rate(struct clk_=
hw *hw,
> >       p &=3D (1 << cmp->p.width) - 1;
> >
> >       if (cmp->common.features & CCU_FEATURE_DUAL_DIV)
> > -             rate =3D (parent_rate / p) / m;
> > +             rate =3D (parent_rate / (p + cmp->p.offset)) / m;
> >       else
> >               rate =3D (parent_rate >> p) / m;
> >
>

