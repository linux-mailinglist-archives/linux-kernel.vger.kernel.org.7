Return-Path: <linux-kernel+bounces-808239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49822B4FCB3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC66F4E4323
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB833340D8F;
	Tue,  9 Sep 2025 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yX0NCeeV"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4BE21FF39
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757424268; cv=none; b=jHAO0I7DTDyyeAKiwHDQiivnc3T9znBhCkMHFV1AqtXbkJ953zBR8Q3bEsM0nYwiBflaw0/4GkU7ODrbe93vgO/gtjtqFdc1sVzRfeebg3yCufJWY9LEOq/ab0l9bXsnkaP8d6Qy+muoex30gw+O3fW0QaGVoqriArRwDFLHI5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757424268; c=relaxed/simple;
	bh=aL39VkMmivSGMWcKiJqE5dHy96jTtUDz0EmE+LQfAVc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiyQFsjrzgQQwdRuJuc3S04NjJiSaneA/wQa7Pka3OyyyJFk10rhvJN0PgU2rA5i3IuDX8Jgmydb9JydVi3yHbGnHdH8a5ahE0wTAjI/Zc9QnkeyfBm05ReLccVJQDL8BJcCMOLjciBzD1SUZ1Hc4FJo96tCr2DwrYOqEY7PY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yX0NCeeV; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-336d3e4df3eso44287121fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757424265; x=1758029065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhvoYavio6XW9UGp4dKzH+wlvXL0CQx3DgO+74W6ths=;
        b=yX0NCeeVUA047Wwl9BBnoW3hMITaa7MVngj5UvwE1WL7NK0lufp4cO5pzquYqyxm4l
         9CoMz7H8fZ545hvMiUNd+gOGxPWcoYTCMEmaqqjtE3u4YW4v7RXIKgnQqCM25MI6SJd1
         BIDbag6ybU/9bIDZ00gSeG28gEmO5/Bvld/2qpua6JtnEVT1baNYqw6r3FrO+PGu6pKT
         YfME2aA4uFssH0bKZGaNZkrKcXopMBiqB40PgPs2l1UwlsR8JfidLuncgLOlGBCwFE+2
         XzI6pFfDGg2wWSMI+sIr1bCRepwE2iMnNfR/dHBbe6pwx0E8zW+nyNPYFMB2ssckbHeE
         2t+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757424265; x=1758029065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HhvoYavio6XW9UGp4dKzH+wlvXL0CQx3DgO+74W6ths=;
        b=sE5HontscN/LMT8N094YEU4w28AN+Y9ofRSeqoTroJAud/nUCPJkYPWZmfOYZ5fb0A
         opgQg4a14AFVkqI2+QaRu673urbc+hynjKQES8yn+vDvYBF0XJlmE5u32nsCgKjjO4OU
         bfoGmLUYYMs/1mb+T0gJHT+DilgF+UvYlL0+FZ5MnubFv8HYkJXS5dpZwkWu6lptwxBy
         gKmCL1L/HxyX3aNyMgiDM/XDgGRlvNT4j4ovuqW05Xk/LEkWcImfEd4mcBzVEhPJ5w+h
         498ZgXCcSjsiUeGnmqBDD0HlOvM7Poyu9GIFDrpw2y/Hee4Xl/PS7yCt9KL0/wOWHcTv
         SG6A==
X-Forwarded-Encrypted: i=1; AJvYcCWgEa6dkcjy7kq8BxJE5Kp5kLszz3VP7o/MM4RYKQEdG59DX2KTdyWOVEi5aLvaZJuN1CRkmlFXsm7R8YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSxtRgDvpsYRnt+QpGDWGxRyhJCTTSLaVUY/95fTf7nWKwC033
	85dkmXg4USA4ooJ7XWpjdI0AtwZsgiOVgERH0qPigyfBsioek7ZvJc8xsERwMZZ7hJse/pMpWlA
	B3wBxExpdxM7vPcb68GMO2pnOvOOHyDSPelroEdUs/Q==
X-Gm-Gg: ASbGncs3L6zMxLmhJwGBsGFfprkQ075p/Qr7Asr95IdQYcxD+kt2HrsyUJR71v/6vGf
	mjEZJ7PYnRHuVU13I5u8lY8+vacSYBYOdqY1Zrukno4YNjY6M9R9xLt1pI7Bxi3HLLUdTNF4qXX
	89Ju87wKbScMja21uSXXt+CRAH39mnkMVuIvX5K2R0aN7sjxjAa7MMCUjjBr7dMZZSTyuUdSZ+t
	Q06sZrmza8g36wKzSaqjvOo6uWooYIv9pTQi/U=
X-Google-Smtp-Source: AGHT+IGqxpMTWwovk8l5WQ5dYhWUYy4ZcII/K/jrdWFPYe7kT1CZQHo3Y8LCGp8PKQqEA3qrGlITiYRoPcmLayU54qE=
X-Received: by 2002:a05:651c:b12:b0:336:dd88:69e0 with SMTP id
 38308e7fff4ca-33b57c39f8cmr32465971fa.29.1757424264537; Tue, 09 Sep 2025
 06:24:24 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Sep 2025 08:24:23 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Sep 2025 08:24:23 -0500
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <aMAn4MM_Fs8q8qwj@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-gpio-mmio-gpio-conv-part4-v1-0-9f723dc3524a@linaro.org>
 <20250909-gpio-mmio-gpio-conv-part4-v1-13-9f723dc3524a@linaro.org>
 <aMAP9hAWars0T83r@smile.fi.intel.com> <CAMRc=MeLTGq8Qu2aT43tkt3vaYCSaJPJPLmaUQ1SAyD_OgVr_g@mail.gmail.com>
 <aMAn4MM_Fs8q8qwj@smile.fi.intel.com>
Date: Tue, 9 Sep 2025 08:24:23 -0500
X-Gm-Features: Ac12FXwbBQSlPLH49oae8yjyXj1ugyDMbkjsHTtBWh1WBSZW49QTty0I4jg5ioo
Message-ID: <CAMRc=Mdr4oW2d7XZ90rRr_fKC7WToz72v=_kW-s8=Urd0g8k3g@mail.gmail.com>
Subject: Re: [PATCH 13/15] gpio: sodaville: use new generic GPIO chip API
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Keguang Zhang <keguang.zhang@gmail.com>, 
	Alban Bedel <albeu@free.fr>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Yixun Lan <dlan@gentoo.org>, Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Sep 2025 15:13:04 +0200, Andy Shevchenko
<andriy.shevchenko@intel.com> said:
> On Tue, Sep 09, 2025 at 01:35:04PM +0200, Bartosz Golaszewski wrote:
>> On Tue, Sep 9, 2025 at 1:31=E2=80=AFPM Andy Shevchenko
>> <andriy.shevchenko@intel.com> wrote:
>> > On Tue, Sep 09, 2025 at 11:15:40AM +0200, Bartosz Golaszewski wrote:
>
> ...
>
>> > > +     config =3D (typeof(config)){
>> >
>> > This looks unusual. Why can't properly formed compound literal be used=
 as in
>> > many other places in the kernel?
>>
>> It is correct C
>
> If it compiles, it doesn't mean it's correct C, it might be non-standard.
> Have you checked with the standard (note, I read that part in the past,
> but I may forgot the details, so I don't know the answer to this)?
>

It's a GNU extension alright but it's supported in the kernel as it evaluat=
es
to a simple cast.

>> and checkpatch doesn't raise any warnings.
>
> checkpatch is far from being useful in the questions like this.
> It false positively complains for for_each*() macros all over
> the kernel, for example.
>
>> It's the
>> same kind of argument as between kmalloc(sizeof(struct foo)) vs
>> kmalloc(sizeof(f)).
>
> Maybe, but it introduces a new style while all other cases use the other,
> _established_ style. So we have a precedent and the form the code is writ=
ten
> in is against the de facto usage of the compound literals.
>

It may not be *very* common but it's hardly new style:

$ git grep -P "\(typeof\(.*\)\) ?\{" | wc
    108     529    7315

Bart

>> I guess it's personal taste but I like this version better.
>
> In kernel we also try to be consistent. This add inconsistency. Am I wron=
g?
>
>> > > +             .dev =3D &pdev->dev,
>> > > +             .sz =3D 4,
>> > > +             .dat =3D sd->gpio_pub_base + GPINR,
>> > > +             .set =3D sd->gpio_pub_base + GPOUTR,
>> > > +             .dirout =3D sd->gpio_pub_base + GPOER,
>> > > +     };
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>

