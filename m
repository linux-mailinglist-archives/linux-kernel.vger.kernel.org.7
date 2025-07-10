Return-Path: <linux-kernel+bounces-725777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A26B003DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8088356227E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFBC259CBF;
	Thu, 10 Jul 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vm0E40b3"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D995F2594AA
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154753; cv=none; b=nzR6TZGnWjVVGzqyHmwwsbOdUUpfbFzz4/OTprNaU0ntzk8NM7cSaRYN58sUj52zYzwkAATgA2FYlSP06f24zb1xyS/x5uZqFD7laUmm2/EW5Zx9RWApwBpmPlY2qgjZBsP/qhoc19EldD2yRHYpXKAi5k7SRYTnT0BFwOMzxQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154753; c=relaxed/simple;
	bh=AKXQs7l/JnXnGET0gMtJ1sU9EPmcS39N6hUdQpcxAYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KrGnvZcaQoiP/obgd3Pj8tFMY0cotNV3inYyx5vRbxAk20rGiZxibbtviatdeAPsqWD+rWfXullOm9Hu/lXMQHk/7Z+O0ylvpHnGgRPHnciDt09GxVL6e6tjWPtY/tbZw3cH1RpfQQKC7yu1Wkz5DQ2a4RLbXcRWWrpFfKcxHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vm0E40b3; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553d52cb80dso989323e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752154749; x=1752759549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrVJz6seKnsGWdk+TcTY9r2vqG/4YZecUgijiRF40No=;
        b=vm0E40b3KJdBYURwDB2SGyiajheBsl+ABER84/3zfU8FaDh4lF6D+Y/bDXTVWCd9Ls
         wQfPH4WyJavgbd8gLpfhWeorCRWjjAyQcxsQtlmdoTuhFAaXygoHlpbIkAatNIyqGeYf
         hMUuBVb+N5evrFuB/8yu1RKA8mSwBKBtq0yHfBL45cazgVdQZ8RQfLEguPTL+dFVFh1E
         64e8JIl8v4CJLQ1lapFPopee8/ozT93rpi/nuBbxFyskVLYXtfpmtq53J99V+8182n/d
         V42bW7RcFbcLGnUAPuYz/umho+C3YZ4eCMWc4dndAKcTvXekjhXd+80++2qIoBdAAnbh
         Wq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752154749; x=1752759549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrVJz6seKnsGWdk+TcTY9r2vqG/4YZecUgijiRF40No=;
        b=OGuZ9T3sI0OqU6XbVhjCtA4gmk/kWCRgw+Nz4OAcmtAXJdlULNV4mf+1NOPE/sriPc
         B2jnSsAbldVF0PUTR4NtapwXrBpy1kwY7+9711LqCl57ZW8999+9aRD12QYJHsSEZdiS
         dNuAO+n0go+wSCUMcvm0mBWPCAk3sKd5w1uZ4cPDGBb+tFcf9C745NI5ksRWwW6ogiaY
         dFluxuIr+Pt+U8BMXL/L6VB6DpQKWul6R4RUJd6LuUF1RLvvnz40TdwVl71Oo5iyBTeq
         b4U8qXsi7u+TVRt+nAMUaDRZHnjfoc9KJuLKw8PXYC1QpnIXcpeK/iaPkjWz8lGP/lDQ
         H5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZTwbR57ZKPhCIsOabyolxmOBIco1S40mRen2zB+IxFfRrVTTOHqsqIQE4YOl3ML/o9S75OHIu7p5f3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS1e/YO4ZU1p5+dbTsu8Kjs5dX8l9iziMmKRSbtpccMzPssMWR
	g9S0c3Wj1mCa6g7y4n9q1CoBCSaeBRLsl/u0TtqQ/49p8HarIm0SJP4G4porEVX3yv4YI1WGECH
	2hRSWB0Lgsx/ph2i7BlucD10in8jscOhNPDUAwADP6g==
X-Gm-Gg: ASbGnctyWcVwNHgf0aRoapozbG23ixAW50ha3aOOoDDzgpY/KqD7M3GFsv8FGnARq6E
	SFUDctN8BiQwsIbZOWJdLB8UE2ZAcuwppF69o5HxxiTBOgU1DN2pfIsT1M1e4ZhLoB94bvIqHLo
	l5n423/DpqrdDHw5bBmB6aLycxh/0OzMz1zdTGhy73pTpwUC/PXlmvX7NxPLXUxGtWDo4S7ElRV
	uA=
X-Google-Smtp-Source: AGHT+IGB6UUmFZhzqKjRvGV4lr9BeyGDE6WH9O1sGiazwi8CZoRnZBbYDI50VNLpbqgC1sRg+VYVXXWLsDZF+CuXQF4=
X-Received: by 2002:a05:6512:1587:b0:54a:c4af:15 with SMTP id
 2adb3069b0e04-5590071b7c3mr1264610e87.19.1752154748737; Thu, 10 Jul 2025
 06:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-pinctrl-gpio-pinfuncs-v2-0-b6135149c0d9@linaro.org>
 <20250709-pinctrl-gpio-pinfuncs-v2-8-b6135149c0d9@linaro.org> <46a506ee-0472-4c7a-8fd8-b3a1f39105b5@oss.qualcomm.com>
In-Reply-To: <46a506ee-0472-4c7a-8fd8-b3a1f39105b5@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 10 Jul 2025 15:38:57 +0200
X-Gm-Features: Ac12FXwUS6h2JE4LNA_vmGF3f9mhet3j6NKR8eSjHb_k-YJ2CoyhrM-67s3nQ-g
Message-ID: <CAMRc=Mc7KSSTF=Jsu-_1C6eWrTXNKB=_Q9fnZor8K_4nnQ5m4g@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] pinctrl: qcom: use generic pin function helpers
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Alexey Klimov <alexey.klimov@linaro.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Cercueil <paul@crapouillou.net>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 2:25=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 7/9/25 4:39 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Use the existing infrastructure for storing and looking up pin function=
s
> > in pinctrl core. Remove hand-crafted callbacks.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
>
> [...]
>
> >  int msm_pinctrl_probe(struct platform_device *pdev,
> >                     const struct msm_pinctrl_soc_data *soc_data)
> >  {
> > +     const struct pinfunction *func;
> >       struct msm_pinctrl *pctrl;
> >       struct resource *res;
> >       int ret;
> > @@ -1606,6 +1581,14 @@ int msm_pinctrl_probe(struct platform_device *pd=
ev,
> >               return PTR_ERR(pctrl->pctrl);
> >       }
> >
> > +     for (i =3D 0; i < soc_data->nfunctions; i++) {
> > +             func =3D &soc_data->functions[i];
> > +
> > +             ret =3D pinmux_generic_add_pinfunction(pctrl->pctrl, func=
, NULL);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
>
> It's good in principle, but we're now going to house two copies of
> the function data in memory... Can we trust __initconst nowadays?
>

Well, if I annotate the functions struct with __initconst, then it
does indeed end up in the .init.rodata section if that's your
question. Then the kernel seems to be freeing this in
./kernel/module/main.c so I sure hope we can trust it.

Do I understand correctly that you're implicitly asking to also
annotate all affected _functions structures across all tlmm drivers?

Alternatively: we can provide another interface:
pinmux_generic_add_const_pinfunction() which - instead of a deep-copy
- would simply store addresses of existing pinfunction structures in
the underlying radix tree.

Bartosz

