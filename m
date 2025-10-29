Return-Path: <linux-kernel+bounces-876044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 387B8C1A7E6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E05C656552D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEDE3590AC;
	Wed, 29 Oct 2025 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zLaB1x6e"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DD632D444
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741590; cv=none; b=pm4MNZZLDBh1SQ9J0xCsaq7EREehuYIp//uiGuwo7IM1rIUjgjGgwChf1a68Yy8woPo3LnpH+814excNwVJjWVa8i9X+vln4W4pizBJUhQCFES+MSsiai0CSHBuQ3F3Z5frwYeCzPSqd6GJI/QG3mVtPvgZt65GNvbqLuDcXrvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741590; c=relaxed/simple;
	bh=vepLqSyPiapW1CscUULDIr1ukJTRIyuoFYsiHMuP74c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWu5TZHlVintzGJflLphNmnUQlCnNcKry+BuZe3dVmxNmgnJ0KALChCaXt933Eurk5EXpr7yVm/W5vOSuch+PKXv6GY8MO66DiFMC2r+bI0YUU6eMdi0PDSR20icvz1Yk81OJOkLQCzI3RbISa+uk3jKM+CLOu1U/OkXNk2dlfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zLaB1x6e; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-592fa38fe60so8726721e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761741586; x=1762346386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vepLqSyPiapW1CscUULDIr1ukJTRIyuoFYsiHMuP74c=;
        b=zLaB1x6eVAZ9zfhQy6mSs3ecSMXcJ+JVEo1zGzm3hfwCYi/HQPwtjF72mbfH497Zos
         xLTx+if13zunBkqctues7h4Vq6i8shg9uN1pakRywLuKUZer555LgPwgdcYeWKSo9Nmb
         KDTgh0KR/tgB2EXzcoD0VHK1j8VR9nzrc3nG699wYLtd3oinPDd6FTFfJX10mLL4od5p
         MqyNXtgOeAXut5OzP+7XwcQ0h+PaBKbGOH42g2TdWx3tkQB+YCqi8ddMEiH6MFK3jLjW
         jutS4B1dSTvCuVY7MPgEAShWU3b0dnc4EG7I5u9Z744+QV9cYocrSEJhIhgvzQ/uBOAQ
         nlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761741586; x=1762346386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vepLqSyPiapW1CscUULDIr1ukJTRIyuoFYsiHMuP74c=;
        b=VGoRimQwJVPxvRNRTnP/p97neVlwXJbMsvUDyyElTLiAGrsUiyfvcqYw/ee8hpTRui
         RPVl+RGprXqa/GQ0LjLyVNAM8+oEMg3qC9q1TuErg7NYSxqt2bIn7KJkLrJH1G2xUAPQ
         fZgycQSUSIzD8lVTE6HcUlG+YuuoHwJsRG6wAE0xv0ykj4bjD2xBgw7ARk/Tv8p7IWcK
         yv5287GFTVXZTlhbRj+GRj4yYXJA2zh9GbfiGoYwoCqxdtrDtvx1Gp0iRUx0uGIVoX4R
         NAP3x6xwZ4ef6rAtEWV80ZkssNzjcvMpB8XvZDgr/oC09slbU9gHgMFadIbV5kyYmFLc
         Ihiw==
X-Forwarded-Encrypted: i=1; AJvYcCV58wUWz5GQA9gfk8rYbPb7IjzQCCbFjfmud9EJhl51lBeM3rxZi+h3fl7QA4Qp/baN+gLE7LuADBFvkSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRHSobWhgc6KrT/rk2Y98SQ+1QRl9S8H5Qa9mGpfFSrLbD//C0
	pYdWNE2HgJCsHpOerUcP1Bdi06Yd8GapxjsJx5drHZ2FuXH9WIuI1rchzMnL5BMoU68+f6QR+BS
	8VPVeaNqQnkb412nIbx/IX4gX7zcvTI6d8IIsVK08sQ==
X-Gm-Gg: ASbGncupBzwFmRGAsVSDC5DN1W8Fd2Het9qGHlFIeFPK+bMVpdSZdLtVD/wM8EEtykV
	Bh6UOdmm+A0xNc6lVNsnIE2TNBf1SfUH7HktX+8VRk9MM572zgyYfjmpnxjvTZdl6YiGg+rnJfY
	WOklORfgN09kmHCcpTcVMWJ1lAZGJiNcS6/N4JwIEyzugTak2dRSK/RVOplwd73tSuSOINFdgwp
	o/SH0dsQWnAXzovJ8qU4yA0oIBOQf9L+GNmdzGDcjaJniTKaaz81PA290U/viHKXU3ECu9hlG1S
	iV1UlHMGd/eL+iMoEb/ylNS8vkE=
X-Google-Smtp-Source: AGHT+IEhlmDPn2tgHOCgKXhItr9HaCh2am9KNpwJ0IjxOJ3YFVumxgTyoy/YlwjIRIN8akgjhohEFSM52fM0JyvB8BA=
X-Received: by 2002:a05:6512:1383:b0:592:f315:843 with SMTP id
 2adb3069b0e04-594128f53f0mr1119595e87.50.1761741585982; Wed, 29 Oct 2025
 05:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
 <20251029-gpio-shared-v3-3-71c568acf47c@linaro.org> <aQH-NcXry6_IlqXQ@smile.fi.intel.com>
In-Reply-To: <aQH-NcXry6_IlqXQ@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:39:34 +0100
X-Gm-Features: AWmQ_bmg8NCddAGmpteBxJYDcYFplccsm6nERfQwYpmUT3SY-Zt_nlxAn9CZjjE
Message-ID: <CAMRc=Me5qPS2PhLK5hpK8BbTS8b9q3T-+86mq6rVDpyKZZUfoA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] gpiolib: implement low-level, shared GPIO support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Alexey Klimov <alexey.klimov@linaro.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 12:45=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Oct 29, 2025 at 12:20:39PM +0100, Bartosz Golaszewski wrote:
> >
> > This module scans the device tree (for now only OF nodes are supported
> > but care is taken to make other fwnode implementations easy to
> > integrate) and determines which GPIO lines are shared by multiple users=
.
> > It stores that information in memory. When the GPIO chip exposing share=
d
> > lines is registered, the shared GPIO descriptors it exposes are marked
> > as shared and virtual "proxy" devices that mediate access to the shared
> > lines are created. When a consumer of a shared GPIO looks it up, its
> > fwnode lookup is redirected to a just-in-time machine lookup that point=
s
> > to this proxy device.
> >
> > This code can be compiled out on platforms which don't use shared GPIOs=
.
>
> Besides strcmp_suffix() that already exists in OF core, there are also so=
me
> existing pieces that seems being repeated here (again). Can we reduce amo=
unt
> of duplication?
>

I'm afraid you need to be more specific here.

> ...
>
> > +#if IS_ENABLED(CONFIG_OF)
> > +static int gpio_shared_of_traverse(struct device_node *curr)
> > +{
>
> I believe parts of this code may be resided somewhere in drivers/of/prope=
rty.c
> or nearby as it has the similar parsing routines.
>

I don't think this is a good idea, I want to keep it within the
confines of drivers/gpio/ and the use-case is so specific, there's
really no point in putting parts of it under drivers/of/.

If I could only iterate over all properties of an fwnode, I'd have
skipped using OF-specific routines altogether.

Bart

