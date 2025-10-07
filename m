Return-Path: <linux-kernel+bounces-844468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA45BC1FF8
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95703AB58F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A6D2E62C5;
	Tue,  7 Oct 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBzY8QPT"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C1B42AA3
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852543; cv=none; b=i97Zb+TdkOQczBmQbH9YvdazF1jGVbnbgt8ONEZclFy2GbyxxSuK+cL1Db+axwP/DKXoVlLwjHJ5RuoEXa/fGP9R8QlnrxEjA2327uhGk6XfK9yuK1s/a+EC4GfvjAYxhE+rlzwlldCUtlTD8POEdatAxqGhJjo8ID6QeA+wul0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852543; c=relaxed/simple;
	bh=8o6wECU2r8eQjWVca8+lslnsDKGla1WAKTSkfJPXvAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YeiPYlcX1cMH0oCgiTXKdQzi16yk6yZLdh2GD8edu4d0EqHQSu2JlUVdqeLD5Z6U8psvJJTcvl4JqFEvS/u1GEfuyYEt8+uAyS9ByhL7Hsc1Z1uTYzkPF/vegrTy3gAzGxa8aHpec3TJDCQ4JiTap8kaFNDIBWsqjqci1rPXM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBzY8QPT; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-43feeae5e8eso945686b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 08:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759852541; x=1760457341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xof2tFKmaTymsxVN0RanLSHPf+F5CNG7NxDCoHKcFSQ=;
        b=LBzY8QPTKtV7OZXR+PuT6cgNBiv9RE33eSsw+YsFfyFxqg51EU07UFLOz8S527GctA
         mHguj7Fcm7Mv09lk8geIu0dB7/20tuYeORe+8YISrApFxlKpoJgBLBWtsUehfp9ubysF
         pnzm79R+S/4l9V3YQdbO3xgY16xmDcannF62TiL79Pxe/u6fXC1sZCxomvSTxqMpaDgD
         3y4io091mbE0qdPx/379DkmUd+1/Iff0n9ww/uDcH13J02ummpTC7yFYiUtvehldJHHs
         un1FJ98kkQrpU6bmqosQPsU8zuA2fJUO3cE3f/dwQkp9ZInZnpSnHOJcg2thcbOWisU/
         jO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759852541; x=1760457341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xof2tFKmaTymsxVN0RanLSHPf+F5CNG7NxDCoHKcFSQ=;
        b=VNFqt/k5HPTuYq74O6xD36L3PG4qUN9ejUV+8lXD5LKGMQbMtk3J7czrcSZcizZZta
         A7Iv1Nngg3mu5tOYsFIREED+cvI7A+fsEu/kUNXY2MMEGG3cWUlOSyMjJogg7Q/v5O7Y
         pwBBuPneGwEL8LqULRMY993Xy45dCDYpH3W2/BeIiZUb8k1NdLNocPoMCSTPTdm7ObIo
         EV29tjbXTOOIniqH0VM0CMQ5mxj1n4zOb4lMYK/mA5VVYhrNXdPw3AAyLpxlWQ005tFH
         C4cmsVZpggHNp/aLHXraU6JKUnWI1LKfozbIVTbplZqU+bRzGNhZ7wQ10u/8b9JEhlFQ
         9YqA==
X-Forwarded-Encrypted: i=1; AJvYcCWvKzSNHO5/mAy4Vrh6LyhciqZ+JUvV1b5/3tgnrqnGfHyjMAXLCLLfD7etwv4y1x9ykvHX4vhx5OxnPIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6i7vNNvDuypY1ICiJRlGnxMvQFTYi/iHtUk3CFHlAdzC8DzDh
	E3o56wTy3qROEzlqfXkmAy9ppb9ClAD3brQ9dKoZvQStR/gz3h6UO/CUV1jPTsquVcME1UIWZ2J
	y7O4NR78Id1U3F1GuZ1udzQSE92c9WZA=
X-Gm-Gg: ASbGncvNrpud4FOBtAb8WWdtXkaO+Wz2FpdMAgJETfcbexPwJ2pvOnhcmtuP2QNczr2
	CxvpExaZNbS/eD643a/U7dNzZjn+NCVfd4zb2Ah3yiOamPlWsgXjSROZ1mh3sDdh3sNVERmhp+/
	hpswbcVolrRpXxdAcR2/TEloQwLLpvlCV4eUQ65KmMnPsKhJReXMMCY34L2TFtc3XKmAZ7u4CeJ
	zIQnEpvbKbpb4z+8bpYeEO+125h3RY=
X-Google-Smtp-Source: AGHT+IFJimNV9JVgADZJ6RJzxomRrr+CRKdYe/O1FKTvw0V5/gJ+hI8NK2oaENlvJwyX9Byxq2NQUHrpHGruAFl/v18=
X-Received: by 2002:a05:6808:1815:b0:43f:5e26:6638 with SMTP id
 5614622812f47-43fc17852d9mr8662263b6e.4.1759852541127; Tue, 07 Oct 2025
 08:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007145028.1845-1-briansune@gmail.com> <aOUv69rMkyYFiHae@opensource.cirrus.com>
In-Reply-To: <aOUv69rMkyYFiHae@opensource.cirrus.com>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 7 Oct 2025 23:55:29 +0800
X-Gm-Features: AS18NWDFCcK6DUbobDCPvOQRxCjKu64V5pX3ZLLOvkZRLgyvns-GKpJ1g0-K9No
Message-ID: <CAN7C2SDUiuMfPs_X5r0RDC56313aJsfhfx0-juhZRKGTb1OKuA@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: wm8978: add missing BCLK divider setup
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Charles Keepax <ckeepax@opensource.cirrus.com> =E6=96=BC 2025=E5=B9=B410=E6=
=9C=887=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:21=E5=AF=AB=E9=81=
=93=EF=BC=9A

> Apologies but just realised there is still one small problem here.
> You want to match the closest BCLK that is over your target rate,
> if the BCLK is too slow the system won't work. As your bclk_divs
> array is sorted I think you can do something like:
>
>         for (i =3D 0; i < ARRAY_SIZE(bclk_divs); i++) {
>                 bclk =3D wm8978->f_256fs / bclk_divs[i];
>
>                 if (bclk < target_bclk)
>                         break;
>
>                 bclkdiv =3D i;
>         }
>
> Thanks,
> Charles

Not too understand what is the issue.
The idea is setting the initial value to max any diff that is smaller
will update bclkdiv index,
If the maximum LUT 32 still not met then it is what it is.
mclk / 32 is the bclk, unless you want an error message.

Charles Keepax <ckeepax@opensource.cirrus.com> =E6=96=BC 2025=E5=B9=B410=E6=
=9C=887=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:21=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On Tue, Oct 07, 2025 at 10:50:28PM +0800, Brian Sune wrote:
> > In previous WM8978 codec driver versions, wm8978_set_dai_clkdiv
> > might not have been called for BCLK, leaving the bit clock
> > divider unconfigured. This could cause incorrect or unstable audio
> > clocks depending on sample rate and word length.
> >
> > This patch adds a check in wm8978_hw_params: if the BCLK divider
> > has not been set via wm8978_set_dai_clkdiv, it is dynamically
> > calculated and configured at runtime.
> >
> > This ensures that BCLK is always correctly set, whether the
> > machine driver configures it explicitly or not.
> >
> > Signed-off-by: Brian Sune <briansune@gmail.com>
> > ---
> >  sound/soc/codecs/wm8978.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
> > index 8c45ba6fc4c3..8dfce6ede8cd 100644
> > --- a/sound/soc/codecs/wm8978.c
> > +++ b/sound/soc/codecs/wm8978.c
> > @@ -99,6 +99,7 @@ struct wm8978_priv {
> >       unsigned int f_mclk;
> >       unsigned int f_256fs;
> >       unsigned int f_opclk;
> > +     bool bclk_set;
> >       int mclk_idx;
> >       enum wm8978_sysclk_src sysclk;
> >  };
> > @@ -590,6 +591,7 @@ static int wm8978_set_dai_clkdiv(struct snd_soc_dai=
 *codec_dai,
> >       case WM8978_BCLKDIV:
> >               if (div & ~0x1c)
> >                       return -EINVAL;
> > +             wm8978->bclk_set =3D true;
> >               snd_soc_component_update_bits(component, WM8978_CLOCKING,=
 0x1c, div);
> >               break;
> >       default:
> > @@ -717,6 +719,11 @@ static int wm8978_hw_params(struct snd_pcm_substre=
am *substream,
> >                           struct snd_pcm_hw_params *params,
> >                           struct snd_soc_dai *dai)
> >  {
> > +     unsigned int bclk, bclkdiv =3D 0, min_diff =3D UINT_MAX;
> > +     unsigned int target_bclk =3D params_rate(params) * params_width(p=
arams) * 2;
> > +     /* WM8978 supports divisors */
> > +     static const int bclk_divs[] =3D {1, 2, 4, 8, 16, 32};
> > +
> >       struct snd_soc_component *component =3D dai->component;
> >       struct wm8978_priv *wm8978 =3D snd_soc_component_get_drvdata(comp=
onent);
> >       /* Word length mask =3D 0x60 */
> > @@ -820,6 +827,23 @@ static int wm8978_hw_params(struct snd_pcm_substre=
am *substream,
> >       /* MCLK divisor mask =3D 0xe0 */
> >       snd_soc_component_update_bits(component, WM8978_CLOCKING, 0xe0, b=
est << 5);
> >
> > +     if (!wm8978->bclk_set) {
>
> Yeah that looks good.
>
> > +             for (i =3D 0; i < ARRAY_SIZE(bclk_divs); i++) {
> > +                     bclk =3D wm8978->f_256fs / bclk_divs[i];
> > +                     if (abs(bclk - target_bclk) < min_diff) {
> > +                             min_diff =3D abs(bclk - target_bclk);
> > +                             bclkdiv =3D i;
> > +                     }
> > +             }
>
> Apologies but just realised there is still one small problem here.
> You want to match the closest BCLK that is over your target rate,
> if the BCLK is too slow the system won't work. As your bclk_divs
> array is sorted I think you can do something like:
>
>         for (i =3D 0; i < ARRAY_SIZE(bclk_divs); i++) {
>                 bclk =3D wm8978->f_256fs / bclk_divs[i];
>
>                 if (bclk < target_bclk)
>                         break;
>
>                 bclkdiv =3D i;
>         }
>
> Thanks,
> Charles

