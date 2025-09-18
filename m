Return-Path: <linux-kernel+bounces-797884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B93B416AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 839AC4E3615
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499532D4818;
	Wed,  3 Sep 2025 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="or+O9yqi"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3A414A4CC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884830; cv=none; b=qzYWa/PAFa6Y0COl7CCo1yatSoTOlFghiOrmd7YzyhnPENn7kMtxuW8POOqCNYA8ACYhY4koV/k0ZqcaP4vejCJDfZWL1Wr+SxM9mVxb5/T0DqfZ/ZdDUMnC9naEaGXTT+HKwQdUhfCvcoaD4BlI7rfsotUYJgpU51xKFY90qcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884830; c=relaxed/simple;
	bh=YNYvzh/kc3+s5XJiH2jNySFaGPSj6mlg48FZqtmCTZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulj+FndezMFygK+VG8+DX5KmYKmUj9nRgRuBJ7hQfW19xW3re6obE/z64OffuEiJwOb3NOqwP7GEU4RfMo/wJeQIofXv/E/Ku5ETgCldDFOYadlaVkH8YJmbiZIQGJJN6KQE9XBG0+rB24c+9ojiY4I6GH+fkcJbO1fxAse+r/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=or+O9yqi; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-337e714b3b4so16052351fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756884826; x=1757489626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNYvzh/kc3+s5XJiH2jNySFaGPSj6mlg48FZqtmCTZw=;
        b=or+O9yqi+Fme2yw28jrJWT8dtYwgRPniIwPzJq/SW1Nz+gCVTeyG6kXv/ETbj6pAhP
         PfQwrdCC0J8IPpaDld0dGTwBdTo8HgnCEkfxiGdnUigPylEtYkHH2IXCnVKHreljZ7Nk
         yHXifcsd/RJwRpJCpaQE+Sf2RjCLIX11vWitdQbTjymxY5bZipIdoVLk6nUFtZwlsSaz
         vVuiSathFGm9kWh20Hjen/wxlqVIDx0Hhapdh62TMS/Az+TzXdY6phHYf1p4+FACfmNQ
         a33uBd4f12xTbiEtFTsqIEUUIOQCbxgmPtVspR8B+qHxFZeR4C9svVPCUa/bD4YF8ja4
         SW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756884826; x=1757489626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNYvzh/kc3+s5XJiH2jNySFaGPSj6mlg48FZqtmCTZw=;
        b=Cep8lyoRzK7Ox/dpZ1GrYIbMcBHmAUFRMKJ+KiZZYnygZE9mk1N8Jeh72SqoUrLCv6
         LcqrfHmtvW+Yy++0ujgQRye4YiaiexxFmygyi/XFFEV7mSOiJYmuQ2TBqR1swLOA0Vaw
         jXnqUScQ7CeJugMepBLt6LAQWmW3BUo2c4IIVX+QYGBvY6Y2crEsTzkbowACOfCmu1/t
         Eyl5kYCQ9oMmH0rL8eZ6i0TearZVeijl0c+t6+SO4rpCoG/MicV35NQfY/0U0ar08vSe
         Z66pQbH5XzBA6wD/St43G3v75ijKVnvqEmre+YAdWHWp5dCRT+u5l+L1CFu9/V4HPD4n
         hIbw==
X-Forwarded-Encrypted: i=1; AJvYcCVFd6K5N9k6RDv96g6KIvo/i2CfJk/p3s23k6I8sHLqi/NGX13B+eSc1YQ9n49Tr1DZVB8BHI47pNhIE+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWayCHzh5m4rTFXBr8XREfuYM6SEF2QSqsBj/y4XmDby2GVI2u
	JpaBs4+mp0N4boS1sXOgabGwCuX09+kYYupfZQpblfMZNsHtJ1Qa8tKOOb2C/HQcF0tDDOti3dD
	YQXOsSpemNKAiyGWpKd7HMYQq9xoP48+tF/UboMNCOQ==
X-Gm-Gg: ASbGncsHKHCxQPQaxCacWy3RRtfNOPvTv5RcOIYFdDyiZy97UiApew2VtsxLFgxwUnq
	sH2iyaCsvHX17Np8lwxJruiCR58+0UzJ4zAOLckCh/MGW6G9C6e22hVHbBEjCkno3ynpI1yTqEa
	nJL5y3H6JfqC3CKQbXwThMO3q29ycQO1YY0qdzk18DAhHKDTSkxV+CwPiETXPOwWwO4E8GvN8kt
	YNnLVaeP7gua2MV6QBNBTegkymOZTzOgb85AU3IzyGio+EEcQ==
X-Google-Smtp-Source: AGHT+IHQMDojBvXdcYFr83Du1enPEHK0Ti//rRC94x6rK+6MbJgsPNbFLU1zOeSW5BOM5GJv9hHYWvwxYnse2nh/rU8=
X-Received: by 2002:a2e:a58a:0:b0:337:9e3b:895f with SMTP id
 38308e7fff4ca-3379e3b9b47mr24730131fa.0.1756884826262; Wed, 03 Sep 2025
 00:33:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902-pinctrl-gpio-pinfuncs-v7-0-bb091daedc52@linaro.org>
 <20250902-pinctrl-gpio-pinfuncs-v7-16-bb091daedc52@linaro.org>
 <aLcBcjvMbrxoDYoC@smile.fi.intel.com> <CAMRc=MfcFMgkNqWNZV5o0NxkAvxBTjC3vv56Cr98n0R2CkxuPw@mail.gmail.com>
 <CAHp75VcgaqnDrPH27wxfgyK6zz4RAKJQB0r7G2vbTONTxkEzTw@mail.gmail.com>
In-Reply-To: <CAHp75VcgaqnDrPH27wxfgyK6zz4RAKJQB0r7G2vbTONTxkEzTw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Sep 2025 09:33:34 +0200
X-Gm-Features: Ac12FXwfTFesdkv2AsVGJLh1I6xBKdxxPYffotwRnf3CookQp3k-WXkxYMLzaTo
Message-ID: <CAMRc=MfhhX2NJ0fhhX8u+7=sdyUy0G27n7caGf9=TpHxUDJVxg@mail.gmail.com>
Subject: Re: [PATCH v7 16/16] pinctrl: qcom: make the pinmuxing strict
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Alexey Klimov <alexey.klimov@linaro.org>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, imx@lists.linux.dev, linux-omap@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 10:46=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Sep 2, 2025 at 8:42=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
> >
> > On Tue, Sep 2, 2025 at 4:38=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > >
> > > On Tue, Sep 02, 2025 at 01:59:25PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > The strict flag in struct pinmux_ops disallows the usage of the sam=
e pin
> > > > as a GPIO and for another function. Without it, a rouge user-space
> > > > process with enough privileges (or even a buggy driver) can request=
 a
> > > > used pin as GPIO and drive it, potentially confusing devices or eve=
n
> > > > crashing the system. Set it globally for all pinctrl-msm users.
> > >
> > > How does this keep (or allow) I=E6=B6=8E generic recovery mechanism t=
o work?
> >
> > What even is the "generic recovery mechanism"? That's the first time
> > I'm hearing this name.
>
> "I=C2=B2C generic recovery mechanism" (I dunno why you put away the I=C2=
=B2C keyword).
>

For some reason it was displayed like that[1] in my client. I see it's
correct in lore though.

Anyway, what is your point? I don't think it has any impact on this.

Bartosz

[1] https://postimg.cc/7GFtxzzR

