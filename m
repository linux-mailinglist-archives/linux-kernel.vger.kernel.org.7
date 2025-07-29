Return-Path: <linux-kernel+bounces-749186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FB7B14B34
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 11:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530493A6B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6127B286402;
	Tue, 29 Jul 2025 09:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fEHAybb3"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4FB27FB3B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753781049; cv=none; b=Gg0eHAKpKMadvV6poFrj/akvp6/h+2642WBLfvYdf+iXLgCYpn96LmchN4Gs5o91iwzrzaUgGo30BrCO3sj53HFfJYOklI09bOSAXT+xuyZWK+vzYHK7cG6GclfkPL2OQ11f1Fov5G8fBKDHIrIzlz43QfBVHc7QDYfY1zNORaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753781049; c=relaxed/simple;
	bh=1XbJXYOtfiKvD5ix8X5FxAD5vsw1x7eclqIkLeXimps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mW/8cS5lNWVRBYepbWxvk24Ghy0EumaR4q+jdhL0f1/mFpONWRsuPq5cnh47FJOGhbtHC6McyEQeYUjp87uZPnDQXNO8XQaTeVtwUQboBssbRN2jTPY9wCMfh1KV+D/bMZubBeDmiBWhGHxXm4BJYaedy1E5Tc9avdRkbZQ2/nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fEHAybb3; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55b72633aaeso1336770e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 02:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753781046; x=1754385846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvMriwwuRsxStr2YyKe5TWPbRI0lQN4j3ZQYt22kpLE=;
        b=fEHAybb3OuY7x+gjbN/XKz8qEKAN0mQ9y4DGFfnXysVJzJwBu4iLULXuGicbjpx3D3
         dtLhEKLl7J8VYDuc3D6tKDZw6iMkzJJpnTc+ZaATB+6uRKw/7SGeTrPwEd2pjTLLTdAB
         igfmKdMOgFcyGEZqedATfYQOT0p2O/Ahkz/gXp6Q7OdnmD3OT7EitbbBE4oBtgTlryVM
         gUMoQIS0sW4+bFi80TrW1fX+DN7lQwKQyzFSza/Jm+48xcga5AH2GdoWJUI2ga6zauQz
         s7wrDKdw8RqIk9GQgQrBuyWmT9Z3xz4gZJo3u8T/aReQHNRczFczjzO2OXujQ7bZpSIK
         X4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753781046; x=1754385846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvMriwwuRsxStr2YyKe5TWPbRI0lQN4j3ZQYt22kpLE=;
        b=Szysy84Z0yEUYnVj5b69E41beCcJVFlpmXoT0kWZp7L+znRjiuslPezRLTP86eSuUY
         DWyaVOc2WD9O++BaMaomhIA/MWXcUNwuXQCQhHpq8KZgQ6TFOKXGkR9Ggo2lAxCrRsl7
         TTq5DSAL9KqXra4EsQsbolebQGW1vrYhANicdLy8WOiV5/mxy9gL37KrifMcmGtYKvdN
         YFOcvoHzK7N21r35leF9EAPnScJ5WP1VhEJ42MwGrYr1EAp+NnU8wyiq3RBCFEPq8di8
         Uept56AJ6hUifi3f+xM1CwPsGCHAW2JqMFxuXeh8/HMYrsxvmfrCNDp9FTVDMCYGuvjn
         NNzA==
X-Forwarded-Encrypted: i=1; AJvYcCUv/is44kwxccEkpC+lupM18g1kmAz/G9lUmfzN5ASBOqhNmVVtpwkqd/sL8R4GxLW3apICMfvPlJghzTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8veX3BgH8eSo504WBV6JAX+WONIlIlkKTryI4LswX9PEwCToN
	z1eGPsvNcfRCD/z9s0y5JxN/Q+vV1XD0FXXNgHS7DjR+lZGcnUj1txaq9agdEsEDnPNc+o++JrY
	BxUx/ShDzajAxX8mjc1hDY9U3Ete40T/fEPTQiisbBQ==
X-Gm-Gg: ASbGncsV0L7fzTxLvA6gayjLl702Pzb2Bt8bTfXr+00kWTFiywPTqa9akac4BAAd3wi
	0ypFlKumiXBEGHfWu52A9tr02MCkOHFenoSQb3WgWSViTGvOyf9Dwb9GokZozvIHWjo8V+EY9Y+
	iTCCvyp3c7JX5h4qvyYBPElYGzHryRIIwgOhgqavZMS2IcJ3rKrtzAeZRYn77ISCDWSI/BvtQmz
	kK73+0rmcX+7TdVJkwP9SUlaS4Wuq+4MZe54m231JbFN4Xx4w==
X-Google-Smtp-Source: AGHT+IG4d8eX8f04SwumbDn+t8ORtzgwAVwNB5BHKdmUryIfl8eqxh2e3123W81layXfFQt1IEka9/bpWuzrKar7j3E=
X-Received: by 2002:a05:6512:3a86:b0:553:d910:9334 with SMTP id
 2adb3069b0e04-55b5f4df595mr4041752e87.46.1753781045533; Tue, 29 Jul 2025
 02:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724-pinctrl-gpio-pinfuncs-v3-0-af4db9302de4@linaro.org>
 <20250724-pinctrl-gpio-pinfuncs-v3-8-af4db9302de4@linaro.org> <CAHp75VdMmfV=z75K9AmB7GsWV8C1bZPLGi33duTCt+CM79spJg@mail.gmail.com>
In-Reply-To: <CAHp75VdMmfV=z75K9AmB7GsWV8C1bZPLGi33duTCt+CM79spJg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 29 Jul 2025 11:23:54 +0200
X-Gm-Features: Ac12FXwkqCsphx3p10ZENgy5ARM9FowTyJPFq-nwB_5x6uw2mPSH_J_dgheu8yg
Message-ID: <CAMRc=MeEo6p=6Tp5kORi9y5tGNJKrzh0kq7tpe_E=5TasMjgbg@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] pinctrl: keembay: use a dedicated structure for
 the pinfunction description
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Alexey Klimov <alexey.klimov@linaro.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Cercueil <paul@crapouillou.net>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Tony Lindgren <tony@atomide.com>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, imx@lists.linux.dev, 
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 1:11=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jul 24, 2025 at 11:25=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> >
> > struct function_desc is a wrapper around struct pinfunction with an
> > additional void *data pointer. We're working towards reducing the usage
> > of struct function_desc in pinctrl drivers - they should only be create=
d
> > by pinmux core and accessed by drivers using
> > pinmux_generic_get_function().
>
> Any link to the discussion and perhaps an updated in-kernel
> documentation and/or TODO?
>

The discussions happened under v1 and v2 of this series. The "reducing
the usage ..." part refers to the need to avoid memory duplication of
struct pinfunction really but it's a prerequisite.

> > This driver uses the data pointer so in
> > order to stop using struct function_desc, we need to provide an
> > alternative that also wraps the mux mode which is passed to pinctrl cor=
e
> > as user data.
>
> ...
>
> > +struct keembay_pinfunction {
> > +       struct pinfunction func;
> > +       u8 mux_mode;
> > +};
>
> My gut's feeling that this type of construction will be in tons of the
> drivers, perhaps better to provide an alternative like
> struct pinfunction_with_mode {
>   ...

Nah, literally only this one so far. And I bet we could rework it to
avoid it altogether. Your proposal is too specific IMO. Let's cross
that bridge when (if) we get there.

> };
>
> Or even with variadic arguments... (just saying)
>

Oh please no. :)

Bartosz

