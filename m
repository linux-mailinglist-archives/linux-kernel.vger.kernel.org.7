Return-Path: <linux-kernel+bounces-784711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBACFB3402C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31B61789F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79F51E6DC5;
	Mon, 25 Aug 2025 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="b6hHUyVz"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3F83B1AB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756126614; cv=none; b=ozjjNDAnCS5iX+bPSWg3PYMY/gH8TStOlb4E16T1t9vDrpoy6inWOwIVF2mGiwzULtRItvBlXWVZ3MPIN7FD+t0s1RwNxTAUeQAYHx0kEL5dbMJL6Q4PG8VSPzS7xYpbLXQP7+ZfmsZq+cMQ31naE3DIGsl70M8vQANOBdWGM7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756126614; c=relaxed/simple;
	bh=AiRdSUneN/IHEMxz/2390+MMo6RGIcoLqIA6r4/MmWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xdd6BF8oRPqq5JpLNnietoWHRwP2pF/1xXEP34bleknyIAzxfmOFwv8iGo0u17XGOYAuXDp5/LpReoUt6FnAM0JtNZqZgZqmd4USGDEEunvRbGp4H9mkzXLM4s5hakuUbvnIjhOIw1BDuFrWdjXEX54+TN3eRBCfFHx0+NVIhuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=b6hHUyVz; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-336674f95e7so11998521fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 05:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756126610; x=1756731410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnMFRUI7OrpeFHOHQnTbYDUskSBfz/K49TJPo7jgp3o=;
        b=b6hHUyVzMJlduq3zU7G/7jfkvA+1tI33ljc7jbxBddnIN18QwkILh7NfmU/hTEX54G
         LV+Yh1e9/uAcSwlxO+sdw7BBzzVD3I+hpU5dKwaB7U0x8BYdSFQUduEPaJwJElAGtNP6
         nVvPVjTnEP0wCTbJIWrB6UtBVKuL9wWnZbiDv8k0k4fRZ/wYnKUL8MiLS7+Vj92iP2Ah
         WA+0ezRfXgoEKKaoERSTlrr36WxK5t6tJLZQh+JHhQNvVDmejudMT7RMPrf2tr7ve54m
         FB6jRxvByMSkJeQBDb6FZXCcNBxeH1jA+0Wt01V3A2C/iY2Q+RqsLTRqvY7S6+Il6stu
         2ovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756126610; x=1756731410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnMFRUI7OrpeFHOHQnTbYDUskSBfz/K49TJPo7jgp3o=;
        b=hfA3n2nTo8hVOgc5W/TlHAvCO3wY35juExJUK44V/zTI2FTDGSCxXsvBAg86opANeU
         yHINUfAW2qIRlnXq14VQ7+OlOroiWamkfXq9Cdi3b8HRrPFfMyWKeexvHslbP+uglhGS
         HQoXlrq06Ki7HgogY4lwzk616qs8L/oUBCcZiEGM2T1QEwd5a88fcBkA3n1T5Muua5kZ
         cqef9Rt1cg/+W9jGNmLbN6Ne7vTAn/S7KWND9EBpFxd6pb4JFWOxeJ7ymKnBFBFo1+xx
         FHD755hRh11iflGHucY48AVbJip38jw4bju06aRTlKMuqM7pHoFpPDfMXjAxIZcA2GDj
         aGhw==
X-Forwarded-Encrypted: i=1; AJvYcCUBsLPeXWxv8GAF7+2zbeBiQOMA+d5X8yY3ADox5W2GrrET0P3XBKr09kOGkJ20TJKxQjXBOPBklAAjwjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4uqh+jhWgVtVMsJnNx3D6fCO5Oh+RTaq1uPGfv2HWQS3zaSJc
	kEkNUWnxhSq8qiu2RvZmWFcUyEHxZGEPh/1tNZptv6Xwkyx8oikPGWQ9ufvnCQpCNFpco5t2fUs
	GNeQIGypiU4WuMFQRQ28nsQdzLYfwkhw47IXCAGpVzw==
X-Gm-Gg: ASbGncsafCvDk/gkzLKDqIjSDZ5cMg1hsnQb9sQpK5OcVLXQfK1qfT+yh87zdPN/o3f
	0cJLDz2lJ3MHBUtAwEGzEUw+PtiXcUbvqTBe42k9qJotW4l1DBLGSdd6Mopvly3ECDncNPBgJxl
	FLh0Aq0KW9TUfruT7K4sEI/vCsvueBDg/XJw8F7nT/NYXzvJfQ6Y/xj5y5imH5fB3SsJSNgaeRs
	X+6gX21PF1vt020AqMHFH/m53Ab5VOuQFxS7w4=
X-Google-Smtp-Source: AGHT+IEKuRSYDRBEFcUoSaQJpuUMdlcesI/FHii7hOjk4oxM01a0EqmTFPiCYNu0z4GmlScnxLvw71vWU7C0gmCrYWM=
X-Received: by 2002:a05:651c:e0a:b0:333:faea:760e with SMTP id
 38308e7fff4ca-33650e28035mr29572141fa.4.1756126610386; Mon, 25 Aug 2025
 05:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756104334.git.christophe.leroy@csgroup.eu> <e05a0959d794016bde79e48e25ff71253cf51aae.1756104334.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e05a0959d794016bde79e48e25ff71253cf51aae.1756104334.git.christophe.leroy@csgroup.eu>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Aug 2025 14:56:39 +0200
X-Gm-Features: Ac12FXyribtDrV6nGrkt8B-SxFaigB01Pq-K7rMjlp_S8j2j5Cn5-EuT5Gchlm4
Message-ID: <CAMRc=MfPTtdFtE63UKfbuK3h1mLEk2aUGazBsbRS-OLZzm7e9g@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] soc: fsl: qe: Change GPIO driver to a proper
 platform driver
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Qiang Zhao <qiang.zhao@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 8:53=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> In order to be able to add interrupts to the GPIOs, first change the
> QE GPIO driver to the proper platform driver in order to allow
> initialisation to be done in the right order, otherwise the GPIOs
> get added before the interrupts are registered.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Hi! I retracted my review tag under v1 because...

[snip]

> -       return 0;
> +       qe_gc =3D devm_kzalloc(dev, sizeof(*qe_gc), GFP_KERNEL);
> +       if (!qe_gc)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&qe_gc->lock);
> +
> +       mm_gc =3D &qe_gc->mm_gc;
> +       gc =3D &mm_gc->gc;
> +
> +       mm_gc->save_regs =3D qe_gpio_save_regs;
> +       gc->ngpio =3D QE_PIO_PINS;
> +       gc->direction_input =3D qe_gpio_dir_in;
> +       gc->direction_output =3D qe_gpio_dir_out;
> +       gc->get =3D qe_gpio_get;
> +       gc->set =3D qe_gpio_set;
> +       gc->set_multiple =3D qe_gpio_set_multiple;
> +
> +       return of_mm_gpiochip_add_data(np, mm_gc, qe_gc);

... I believe this can be dropped now and replaced with
devm_gpiochip_add_data().

Bart

> +}
> +
> +static const struct of_device_id qe_gpio_match[] =3D {
> +       {
> +               .compatible =3D "fsl,mpc8323-qe-pario-bank",
> +       },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, qe_gpio_match);
> +
> +static struct platform_driver qe_gpio_driver =3D {
> +       .probe          =3D qe_gpio_probe,
> +       .driver         =3D {
> +               .name   =3D "qe-gpio",
> +               .of_match_table =3D qe_gpio_match,
> +       },
> +};
> +
> +static int __init qe_gpio_init(void)
> +{
> +       return platform_driver_register(&qe_gpio_driver);
>  }
> -arch_initcall(qe_add_gpiochips);
> +arch_initcall(qe_gpio_init);
> --
> 2.49.0
>

