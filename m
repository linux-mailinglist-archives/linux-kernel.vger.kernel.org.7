Return-Path: <linux-kernel+bounces-844264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 182A1BC167F
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB79F4F5FFF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7229B2DFA40;
	Tue,  7 Oct 2025 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpnpWjyb"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B82E03EF
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841333; cv=none; b=uFLhTGHPBTKxjkUiEPMjWE+oXt1pll13mTBsaaH/mPgiZnHaGmoD2eKhBYXfw/2cx8soN6ZKOnoqx2Dh7BfJugvyVA/ENjAYocQdZ9mtTo7l3ufhj05OH8sgP/iCttyt5/u/hRB5Dx4J5Z5glemqWri6FrGpcQoam5RH2lj/UCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841333; c=relaxed/simple;
	bh=9HmWPMv2U+/E83yndjpVpT6Vcq9ASGLRPH8pDxp34V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoLM7RAuMaZsuci9DKgkYV1GxzeGd+iPg4u9gyN9Efl1EGC/QJOL8040AT0GEeB7omQJqWjIUrBHn+/bDawPQ/ICc3nLzi5zV6tmRmGgLkWT/fq297WSwH2GcwLFdukH9iPDGN3IQYQJOkGH2OkZaMZOu23NWxbV/btxjRWI424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpnpWjyb; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-649a715fcaeso1562248eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 05:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759841331; x=1760446131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKZEZkWITt2dtndJOL13JwsxNWGFhaYy4o+MDasr+AY=;
        b=FpnpWjybThJivBBaxbjPUe1G9m1hyaifSRCffM49JWzMfszDa53eiD/XuoDBPzEJFD
         A+5sPBmqMtJvLH+cWDLurorB8nkOdZi4aGqe1K/VnvIdZ1FedeJPr92Hmrs9cYVHLko7
         lhN4htTAje/fR+AiUBq0+LhHvYgIomnhHW4a5henUqZp9cLG4DJAnDt/OetJuPvPFbJO
         6XUv04dEKlqkpvBoA5vhosbgKYHNjwaoRvMoxDCwhsgy+q7a5dTOUgbZ29Zp03pbfz3w
         rIna5J45ygEGfIN3qLXNwGqL6jjbXTIjEnwaAf83t4h+FFBrZhTPDuDPIQX19tXLDDZH
         1xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759841331; x=1760446131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKZEZkWITt2dtndJOL13JwsxNWGFhaYy4o+MDasr+AY=;
        b=BJ7WjQ/HEIkBeGGQPwYSNe9gGfy2gltkvbEPIfY8hw3CO8OsZAXeGFwEGX7ZIIK813
         u2FsnUoP7pKsoXiB0DesCg+Td/GzRi5bLNJINliJ8NhUZvcdLmy+VJrnSYG4cx3amjgA
         eqojjO/h7VnkEy5LCGnxELWhEWLVh9rGEcHRDhqL6WbeAr0h4ilhbhWnnIkUmCbPW6lW
         Mxs79HJu6NBzNzilCxIL5asMGKpxUYmOoJmBB69+1w56VvSzX/+Ftr+OsqRJak9xOB66
         xdK5tt4eRppwihWRGm+0FImm/mY8lpMUcj2I+s+SlGw9BGttuHU1+JudvZIUXgBTEioO
         tNyg==
X-Forwarded-Encrypted: i=1; AJvYcCXUC3ZUkeBLEjrBv/VI1ArTBwOEFdE0TJzE4dkt8I9SOWI6wTtkrabupU8/lGCT7c/O+XtBZYHpWnKrOMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJsIrKuPMYH+e2NR7vYjyqz/N00Eujax6nXL4tQqLABIL+MIU5
	GzJ3UYbI8O916oNllnZtFJ+3dihMtE+7P72R5353NE8yFgzgzI0ZhJbmwXqhLey/IZqijFltiCM
	T/0ws5QWUb8qSClXfSzIWEGLuQVTUjts=
X-Gm-Gg: ASbGncs6S5RCjavTyGh2mn3iVnZjHyxcMDwxBQ9tfC6WfErzR0eMP5RWVl1u3GRLSMu
	0CipXbhA/QFwSY9l4kuQ59vPgt+iz/s0tyJDvikA9zE6AKmSMx1VG18aAhJy4ZeZOzYEzjv8iG0
	M7D+txTXhGGkySP5rz3zO/7QTSf7dnUk+ebYe3nl4IB4foGzzEUcBZ/dmX5UqpGREr43UI+mSM9
	F4uBZxAdDAMX7NnI770wgAJi8vSTwc=
X-Google-Smtp-Source: AGHT+IGPrNBzklP5kU7kCk9ZhQ7ap8j+rNi1icSnorCaRG2GECK4uVIZY7FIeoy1KAiCLUeJbGu8O8gRc19pWyk1+C0=
X-Received: by 2002:a05:6820:4209:b0:624:b767:e1c4 with SMTP id
 006d021491bc7-64e601559c5mr7975745eaf.0.1759841331189; Tue, 07 Oct 2025
 05:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003091304.3686-1-briansune@gmail.com> <aOTrsYllMst3oR03@opensource.cirrus.com>
 <CAN7C2SB5Re35yGYsqr14hGXde3nTKLX2Aa3ZbuJ9xuT0m07uxg@mail.gmail.com> <aOUDbF/i4+9PXc1j@opensource.cirrus.com>
In-Reply-To: <aOUDbF/i4+9PXc1j@opensource.cirrus.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 7 Oct 2025 20:48:40 +0800
X-Gm-Features: AS18NWCSlsbFTKbdtzoAuhSxzpfZ4XQDyqXz9owOit9VAub9xbVQ3v6Pj590Ir8
Message-ID: <CAN7C2SBsFQJ2qNe0HLfpG+6cuONtpChBnq6fuFkd_CGkLt2c5g@mail.gmail.com>
Subject: Re: [PATCH] sound/soc/codecs/wm8978: add missing BCLK divider setup
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Charles Keepax <ckeepax@opensource.cirrus.com> =E6=96=BC 2025=E5=B9=B410=E6=
=9C=887=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:11=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On Tue, Oct 07, 2025 at 07:22:10PM +0800, Sune Brian wrote:
> > Charles Keepax <ckeepax@opensource.cirrus.com> =E6=96=BC 2025=E5=B9=B41=
0=E6=9C=887=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:30=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > On Fri, Oct 03, 2025 at 05:13:04PM +0800, Brian Sune wrote:
> > > > The original WM8978 codec driver did not set the BCLK (bit clock)
> > > > divider, which can cause audio clocks to be incorrect or unstable
> > > > depending on the sample rate and word length.
> > >
> > > This isn't totally accurate, the driver expects it will be set
> > > through the set_clkdiv callback. Which one could probably argue
> > > is a bit of a more legacy approach, but probably worth calling
> > > that out here.
> >
> > According to actual hardware tests and the WM8978 driver study.
> > There are no bclk register setup in the entire driver. So I am not sure
> > How could this even set through the callback? The IC itself requires
> > 2-wires register load and this can't be done via software level.
>
> /*
>  * Configure WM8978 clock dividers.
>  */
> static int wm8978_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
>                                  int div_id, int div)
> {
>         struct snd_soc_component *component =3D codec_dai->component;
>         struct wm8978_priv *wm8978 =3D snd_soc_component_get_drvdata(comp=
onent);
>         int ret =3D 0;
>
>         switch (div_id) {
>         case WM8978_OPCLKRATE:
>                 ...
>         case WM8978_BCLKDIV:
>                 if (div & ~0x1c)
>                         return -EINVAL;
>                 snd_soc_component_update_bits(component, WM8978_CLOCKING,=
 0x1c, div); <<---- HERE
>                 break;
>         default:
>                 return -EINVAL;
>         }
>
>         dev_dbg(component->dev, "%s: ID %d, value %u\n", __func__, div_id=
, div);
>
>         return ret;
> }
>
> Its not missing its right there. That said your way is probably
> slightly more standard these days, but we should take care of the
> interaction between the two.

What my missing meant is if run with DEBUG flag on that case had never
behave as expected.
MCLK and LRCLK both is correctly outputted. While the current
unpatched version will generate
wrong BCLK complete break the codec. As such I proposed the BCLK patch.
I had not investigate deep why it never calls but the "int div" is
loaded and computed by where is a bit puzzling.
And the loaded it simply with div on actual mclk/2/bit_per_channel is
also incorrect.
As mentioned in previous explanations, the clock register is a fix
table on dividing # that is a LUT with restricted # allowed.

>
> Thanks,
> Charles

