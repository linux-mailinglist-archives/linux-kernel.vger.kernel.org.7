Return-Path: <linux-kernel+bounces-846291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E5CBC77B1
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BE6E3B66D2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90026292938;
	Thu,  9 Oct 2025 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wVbt1zqE"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8248628DF33
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989818; cv=none; b=W851BMuZL8KKhT8RmtDXhdhIAD4/uyjg5XJnTZVLzvgXR1YiZbbIpGJ/rKwZ17Et8LPR4V4im9L6HWrwFaNPz83zJmFOrCxCU5P1gEOmlKwDiriFJM7GW4/8nW5PYRpRY9jVs/8Mtt6w5cmnGXQRE1Z7uhJiRL1+r4WBwJkOoaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989818; c=relaxed/simple;
	bh=MO1SDeQA9t1DkNg2aixIg76CzdGOr64AKdY70lbrvoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+RB76yGQ23Dl/rke8PPhXO9rIDjr7VENt88u+UFmcLZpVzSuVhDMQPLqDyZwdjWWd3nOxNGdfhhsaPTcygwAmNi3WIRsVTNsfcWfBnPvkLZMRs/X82Fnx8qjQzX8PoSYM4mQknZ3nZEQ31ahwnCHy+LCMTaUhIma50/ZNMf6uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wVbt1zqE; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37612b15a53so6064311fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759989814; x=1760594614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCL+z+W9XFOkD374E5iJXvaS65d++XBiHfJ4fB0e9ug=;
        b=wVbt1zqEqrFTExcPRQUUgdia6fKRyPXVv4qnXFV/TVQ0aw+mt2mrnQLIBkxL9TUZLm
         31MOCZZIQrfSbvZGGKp0VP+pwMbNZrrWaT9aKRS2rxvI/ZGhOB4qdgJUIcTgT++0uihM
         TLBhzRZXeY9FKMYJduLlX7VXX6c0DMYFME97Um3dYCkzovUsHqx3OnVur2Bu8b72s/Ui
         LI2f1U5esHQa55gal+zs7tG34Rf9MxuL23BTjGb0F350zuiE7lPybM5qK7z/GarHjfdH
         VfGgrdtgwg0gyCfPIrpPQ5esBozUUw/m+dJAU36lo6a+b6BrESXWRlIKVPf5FEYxm4b3
         hprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759989814; x=1760594614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCL+z+W9XFOkD374E5iJXvaS65d++XBiHfJ4fB0e9ug=;
        b=GbQksm2acEKNL9ZyxAYP85p33acXBhutTTQwg6F8LDpuTQQ5/GgCZrLjohtqa5sQ1x
         08baJvkUIofSvqZDh1rbZC8CB5SHzAeTNYPhHjZ5t8EIVnn6aC+Vl2AFM44lKWEfHxqZ
         OLDxxLsYVmxGvEaLtDB4R/CNRq+Pwm8q57Eo5oTYQl3hwulLvlVYHL9GnFZzcJxku+C2
         yVdF9iX9p61/Ka55L5JXBUeHZ0BSznzaGy9Qsn3oXVDvgtVyEVxiPHVTSebt66LMmf3/
         gbGFkaKjKlmSqgVIkAkYnOTRFd9YmS3og1oDzVhvbbvTeTq/3SZDzKaiBDqzhxHSmEf0
         OYEw==
X-Forwarded-Encrypted: i=1; AJvYcCWK0PoH7HexTLl9NbxFnnAz8B/NSIDPIIjG68dV5SiiCfQScEtB7mbEfSQHcXkCwdKIYjWvqtMsqRvD30w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLUTs4XeHU+dR1ML2H5bouUZryI+ZC2V+4Tzoguf3PWt+DclT3
	1EavDYQhbE3GBEHPUFxm2dPaCqTDKekJSfJpNuYlw2HjP9rvIO/ctyjBuhl5vn0m82QIAAEUBMt
	4RAwvA38ru9JySer4f+JIm+zt+YvImr9OFDCDEauDig==
X-Gm-Gg: ASbGnctQ/I9GsuXB7ufbWV8ucmVuNgpFW21r5fdqCZ3LTlK4vvKnjFdMWsw3N9+36XI
	Kd7VkDg77wbCjoELjH/dcLoDxDiUaBMF79wH0wRRKcUasaAsCgChejmjYk80VBQq6mXZP949NSa
	JcqJhNV80eDKmyvKFWDKGOE0h0q2ZJ59+0AqfFIjclwQJ46y7J+mrkYhDSpdjLoXOl0fjZ6AzNB
	nQ2KlxamIMnq4knpgDcmqAML+VyRGo5h9DFJsW8dUTh0A==
X-Google-Smtp-Source: AGHT+IEZNfWeF+b5dDJpmeQ9pgKxktrF0BB+BUcoJ8owg5gpVJldbNcnyiTvgwBoTKGPhDfTehGzOVi3suhz2fLA8Xk=
X-Received: by 2002:a2e:bc8c:0:b0:36b:9ecc:cb36 with SMTP id
 38308e7fff4ca-37609e4d28amr18386291fa.23.1759989814463; Wed, 08 Oct 2025
 23:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008104309.794273-1-flavra@baylibre.com>
In-Reply-To: <20251008104309.794273-1-flavra@baylibre.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Oct 2025 08:03:23 +0200
X-Gm-Features: AS18NWD_o6hLF8XWxXYwfE1hyuq9u4NNivtpBLU3fjyrNwqbetS_Su7z682Jp1I
Message-ID: <CACRpkdYDMRZMb+bDUgK5yiKU1Toy=S_ebo2_4WRasHxCqv+4xw@mail.gmail.com>
Subject: Re: [PATCH] gpio: pca953x: enable latch only on edge-triggered inputs
To: Francesco Lavra <flavra@baylibre.com>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Maria Garcia <mariagarcia7293@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Potin Lai <potin.lai.pt@gmail.com>, 
	Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>, Fabio Estevam <festevam@denx.de>, 
	Ian Ray <ian.ray@gehealthcare.com>, Martyn Welch <martyn.welch@collabora.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Francesco,

thanks for your patch!

On Wed, Oct 8, 2025 at 12:43=E2=80=AFPM Francesco Lavra <flavra@baylibre.co=
m> wrote:


> The latched input feature of the pca953x GPIO controller is useful
> when an input is configured to trigger interrupts on rising or
> falling edges, because it allows retrieving which edge type caused
> a given interrupt even if the pin state changes again before the
> interrupt handler has a chance to run. But for level-triggered
> interrupts, reading the latched input state can cause an active
> interrupt condition to be missed, e.g. if an active-low signal (for
> which an IRQ_TYPE_LEVEL_LOW interrupt has been configured) triggers
> an interrupt when switching to the inactive state, but then becomes
> active again before the interrupt handler has a chance to run: in
> this case, if the interrupt handler reads the latched input state,
> it will wrongly assume that the interrupt is not pending.
> Fix the above issue by enabling the latch only on edge-triggered
> inputs, instead of all interrupt-enabled inputs.
>
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index e80a96f39788..e87ef2c3ff82 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -761,10 +761,13 @@ static void pca953x_irq_bus_sync_unlock(struct irq_=
data *d)
>         int level;
>
>         if (chip->driver_data & PCA_PCAL) {
> +               DECLARE_BITMAP(latched_inputs, MAX_LINE);
>                 guard(mutex)(&chip->i2c_lock);
>
> -               /* Enable latch on interrupt-enabled inputs */
> -               pca953x_write_regs(chip, PCAL953X_IN_LATCH, chip->irq_mas=
k);
> +               /* Enable latch on edge-triggered interrupt-enabled input=
s */
> +               bitmap_or(latched_inputs, chip->irq_trig_fall, chip->irq_=
trig_raise, gc->ngpio);
> +               bitmap_and(latched_inputs, latched_inputs, chip->irq_mask=
, gc->ngpio);
> +               pca953x_write_regs(chip, PCAL953X_IN_LATCH, latched_input=
s);

This driver is used by a *lot* of systems and people.

It is maybe the most used GPIO driver in the kernel.

So I added a lot of affected developers to the To: line of
the mail so we can get a wider review and testing.

Yours,
Linus Walleij

