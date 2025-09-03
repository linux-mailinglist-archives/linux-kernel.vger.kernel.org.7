Return-Path: <linux-kernel+bounces-798295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83C6B41BF2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E781C541808
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB032F1FCF;
	Wed,  3 Sep 2025 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="S4+HAp7P"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56A02EA483
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895655; cv=none; b=VyC07ZSiLJQy2WUL8M4buEihjwWEOVkJcJJS6b7SQsj/Ktx2FDscxNHx45A4LXQzjNN7WVO1BwGIScEGKw0zjSNR7+Drdu+iCDWSPeBGDiwc5tAGhzHQ0xLkhJeWre1hvVBFL52bfJgQ7Xd9T4y6geJXtC4PLzgb35vqYQNhTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895655; c=relaxed/simple;
	bh=AVAB3SPxcLA6cClsIyttHLnupSB+I6SCJnu7WODswL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L93Suj3KMePXhwbKJzbdTHPhBmrCg/01j9heYFALnQ4E00rWap0XbZHWmlSyNUmkTFIrIfQk6NUVDcwzhQJMXb2o52VV1hvrx9vYLRSGbp12nXnZvluBJjFyHUQTJZTtfZojyUW3fFwHG5fHzVQG8x6caY+iFxTZ2BDPZmrvfQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=S4+HAp7P; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-336cee72f40so33862271fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756895652; x=1757500452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVAB3SPxcLA6cClsIyttHLnupSB+I6SCJnu7WODswL8=;
        b=S4+HAp7PfnL+7xT3FUacCfdWe4tC9q7HLKsUbv5UGPDfDaAYUtVsjTDSx3VCkMGHdx
         gn5lEhOcgYEjdftLOzcobBZzTHfb1cq/4Fj6sSHClvRBh0lEB/NHSCOjsWwlCgD932dz
         gxNGvfqPGarlOwH8J/5fZdSoyaLy7C7OTULWZbdXui9IMOM+PRiXLCLngjMmQCQ6x2Zp
         WBEjHaf5unGtOE0boSEf2Na5o8rP2ZvithVHAlnQ6WOIrndRC+2L8IWJ/DemcHWBkDRI
         pVYV9JNhY8gb/3Tzeuljoteyy/ZR03rTke7wP+AdAgOxK8ZmtkrAu04ZH5dj01swXs4o
         7GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756895652; x=1757500452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVAB3SPxcLA6cClsIyttHLnupSB+I6SCJnu7WODswL8=;
        b=Bxvuuf8ae3U1OidkwL60oqzfDQ4LBL7yQRWYDsnlSgJUooMKmBH+QFu25OIVYwoVtr
         aL/+58aJIqXoif6AU8NkZo44x2ZIAUPlxTGjgcpsyJI3Rjv2Kcap0sPsmQIesH8wnAp9
         XcP2/so7XlfNyiH39Hvs9oFgxg4kzgOy+HmIVN5yi34skHxKSZEjLRKvFmOeX3QcwtFz
         Kb0Qa3dYiL5E9WFvn71hhFMe4uKiLZNHVqIY8xrv++xoP/QP+Z/fXC7/ZnOTNNF+REkS
         MullrtoB0OzDrMj6fHUDx9LBBLNXTvLeWNFeEKY+A19JNQNc7XX7DM0EWA7ibwWLlSvh
         XCcA==
X-Forwarded-Encrypted: i=1; AJvYcCXGhvwmhpe7b1GBe8EEDHk9XGHm3W6EFWrSdwpVTnac6p6kaUzQaImF+wLptkNIjM1xTsNHTviwR3KtyhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKOM9mDvjXo+DpHbOSjk1Ese49zRo/ZMGUIWJ02Jo6cwNBo6j/
	/QKRi0jimUNuBhbkZL15oc2j6NcFqRoVKwNPnqarkXXwAQhKbqIew2Hkr6OqeVY9VqJgYVQfrKe
	tH3o3FwO4fQo3wzJO+1Ju2LdxiyLXClmNgFyKWv+3tg==
X-Gm-Gg: ASbGnct1cbQuzE1RclIdK8OrTfgTZmPI0nSLcEsIqQ3Ni7uvb+nTBvVTd0b4G8Po4nn
	unY3Vd0bqo72OMkGHWomrlWaJ5KYHMWynbXKUeROerPzxu0ugQ2XwPE+nipJ86x+iqGZ7/Aa6Be
	Kpl1+AnZa/6uxDz/2dZr2UISZqGhRpEI5C5KlR391DmMmO2KBU6uv9U/ZuFdCgiAUFHXg/Tv5Fk
	zvfgqAKhDJyqfoyjCAf3EIEyOR2QZBgPSKPXYwXibgAfPhgdg==
X-Google-Smtp-Source: AGHT+IGoaflavucoSX1WEgopzKKcdrinu9KA/FkcvAd1RueKhs+WVyWiixXNe2xfLOG4W6BWq8swdn67NOOrJeNUBug=
X-Received: by 2002:a05:651c:40d5:b0:336:8fa8:e03c with SMTP id
 38308e7fff4ca-336caf36f96mr24077381fa.31.1756895651781; Wed, 03 Sep 2025
 03:34:11 -0700 (PDT)
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
 <CAMRc=MfhhX2NJ0fhhX8u+7=sdyUy0G27n7caGf9=TpHxUDJVxg@mail.gmail.com> <aLgW7J-j4nn0u8uo@smile.fi.intel.com>
In-Reply-To: <aLgW7J-j4nn0u8uo@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Sep 2025 12:34:00 +0200
X-Gm-Features: Ac12FXzivaaUXd08fTdsNp_v1t2v6QHg93m25vorvolXWMo4UMb6c0rxngkBDGg
Message-ID: <CAMRc=MdA21fwnamymG6YhqBjKDso_nJs_4xefPNONQNfEcPHXA@mail.gmail.com>
Subject: Re: [PATCH v7 16/16] pinctrl: qcom: make the pinmuxing strict
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
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

On Wed, Sep 3, 2025 at 12:22=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Sep 03, 2025 at 09:33:34AM +0200, Bartosz Golaszewski wrote:
> > On Tue, Sep 2, 2025 at 10:46=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Sep 2, 2025 at 8:42=E2=80=AFPM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:
> > > > On Tue, Sep 2, 2025 at 4:38=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@intel.com> wrote:
> > > > > On Tue, Sep 02, 2025 at 01:59:25PM +0200, Bartosz Golaszewski wro=
te:
>
> ...
>
> > > > > > The strict flag in struct pinmux_ops disallows the usage of the=
 same pin
> > > > > > as a GPIO and for another function. Without it, a rouge user-sp=
ace
> > > > > > process with enough privileges (or even a buggy driver) can req=
uest a
> > > > > > used pin as GPIO and drive it, potentially confusing devices or=
 even
> > > > > > crashing the system. Set it globally for all pinctrl-msm users.
> > > > >
> > > > > How does this keep (or allow) I=C2=B2C generic recovery mechanism=
 to work?
> >
> > Anyway, what is your point? I don't think it has any impact on this.
>
> If we have a group of pins that are marked as I=C2=B2C, and we want to us=
e recovery
> via GPIOs, would it be still possible to request as GPIO when controller =
driver
> is in the strict mode?
>

Yes, if you mark that function as a "GPIO" function in the pin
controller driver.

Bartosz

