Return-Path: <linux-kernel+bounces-750762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61561B160C2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941881AA0F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5FE2989A7;
	Wed, 30 Jul 2025 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="N/kuqWZ+"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E3294A1B
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880033; cv=none; b=Zod0MP9K5uE5MN/sgsN4IDHgsVQbCRaUBzTLewYqyZ1uFwyD+4M4a7Wq92tZtBVMaP/z4n0m7nFRpsLzsJvywpBOoVjJewI89snvUu8wVyKVrCxzl8RONZyYn5Kb049RFCF15gWX+vEloYLPUnvzr5ujoJBxMA3eE2y/53mE9u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880033; c=relaxed/simple;
	bh=RNeM7UB4fAERU2LPOJtuWeYJSG/9TTk9Yot9abhDF6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QeWWh7lYNl/0gUctfN5l4O+yQW7pHWrw6NDi45ovfAHb3hg4goN0xtZ2l5zfUTPt9zBaPfa/qJHEfVNTdGLbV8bLCHLxP/leJAcFCVWenkL6gudcGgXNhsdoVCX6QIdQIK2icXRcOh85qfiDg6ULgRYCXjOqDDpkG4Ty6KWm2sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=N/kuqWZ+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553d52cb80dso991738e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 05:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753880029; x=1754484829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUTEvgPr5pDo52lKZf6mOXPWs0RWvEkRiwEoyLLTu3o=;
        b=N/kuqWZ+n2E10szoUZ24/6F4JuCqCRJgIiSJ+13vx4RL08ntqRjKnWOUv3CReInxOU
         RHq+XhAf2t/ltRbFuhsbgN6TO4nPzRBRVuYk9xYDQMSzjwBn4vRQklSpSF0n4x13/Akp
         HltCRODxOSbnP3MX3m0jV2K0dfXv6tdEODM+V8GbBhMQAjLnJ4mC448itgqV7a32K2zG
         6huj2nFU0UyK5TCqYfapyzNciidjWGBZEhjUPUxsGrUibrXSt1YcgTE/WVtg8c93RDxU
         cNIJuMLyavB5KXHA8bfnDrlGWvHGd/mWQHprk+vfnlwGskSesPW+AbY6GuMT3nAC2BlH
         1dyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753880029; x=1754484829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUTEvgPr5pDo52lKZf6mOXPWs0RWvEkRiwEoyLLTu3o=;
        b=gA49KLio6LaORugG/fV4pIscmK3LYcvMDPbDlrqclIsWa1LN8y0P0YXgd2Zc4FPAdD
         a5p2svY/zAott2wNyIWxmIrOL1S9OpZ5BOAlfaxTnywtTl0vD5Lbgp9q7LaU1xnaGkZO
         pdLazyynxvHbgyPPHK7k9xNecVcIvVfvRuMv+0h8Xk1IXf0oF57FKi+5gVtRhQGUwusW
         BirEGSXv74Ux+Reb5MHbTG5dAycWre1hqA1AoTTkdHQGJN26HmVt0q37x+k3fX/hxseX
         1rUsuIqs26n1HsO8nUaxg5sNgoNVGm0k7JUT3nEITN6rvG9/9MUJGbsyEoSop17g7vTa
         LPQw==
X-Forwarded-Encrypted: i=1; AJvYcCXsFqCAFK4cBEwvaL1FQ03OSLhs1EB0OHc9MHq+pI1CclFjsb2MTi8uPx7v0dME7fQMBeYsKC+Y6qLvORk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WiOHInEdoV3TJDvhW0p6Mb6jJNZIW1jNmL6x/JEBEgG6xRl/
	GU+deJOW2oVQZWjrznaaYgivRbp5FY11ATY1RDZ2ko7qHe7YTEUEAOSjUOQEEKxOi7QN0plNsb4
	Fuz3LMp9yYR4LOdP2HL/muVRP5aPe1NdKduYG+fF0vw==
X-Gm-Gg: ASbGncvx0g/5Q03gcz3XpB7AOsJwCn4vEIbTRSLGaADy5lpxX+IA95CbJ/on7Scbyhz
	nFKGiZ10xPbcCWlkMbZ/MqnH1NT+bsVtqiOlTK6KcmAMNZ5AZaPTktNOmAtZsnOnNDun4LTES3p
	TptkneKmXogApBKqZKAukAdOSrmkdXdraq+eiZgGCOZQv0EAXIcp7i/o8Sjp3mCf81Bthu8lnni
	bEztM6Bw9GXFjG+/q4H9gcabiactFSjGsDHqCI=
X-Google-Smtp-Source: AGHT+IGSuyPnAInz8gQT37fKK4pgrT4+RIAYI9IrKjK2MWPd45oP6K0zUhD/GSonCiRI3dzBbJ8n7cWJZ+qNt54xgoU=
X-Received: by 2002:a05:6512:ba1:b0:55b:83cf:b260 with SMTP id
 2adb3069b0e04-55b83cfb693mr305928e87.11.1753880028944; Wed, 30 Jul 2025
 05:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724-pinctrl-gpio-pinfuncs-v3-0-af4db9302de4@linaro.org>
 <20250724-pinctrl-gpio-pinfuncs-v3-12-af4db9302de4@linaro.org>
 <CAHp75Vc4vsJh_-GbP+YO50veoGoGtfAPL4tjcF+73uophfmnGw@mail.gmail.com>
 <CAMRc=Mc1ophkofB6MmtD4adBAi69C3JyovM-S9YD_y7UA3V1qA@mail.gmail.com> <CAHp75VcV=K-DfOGs0z64==nO+wQNoEB2Ngd2vc+dLYr3WLChjg@mail.gmail.com>
In-Reply-To: <CAHp75VcV=K-DfOGs0z64==nO+wQNoEB2Ngd2vc+dLYr3WLChjg@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 30 Jul 2025 14:53:37 +0200
X-Gm-Features: Ac12FXya2mYA_HSI46S7KktzTvTwdWuT-o4vBrrr3z0vtr46fp0gRnU_ZqynDBk
Message-ID: <CAMRc=MeVOEFkdqf+SwQ-a=7ZPvpoerb4G_kn-aZgNLR3aTTUog@mail.gmail.com>
Subject: Re: [PATCH v3 12/15] pinctrl: allow to mark pin functions as
 requestable GPIOs
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

On Wed, Jul 30, 2025 at 2:50=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Jul 30, 2025 at 11:54=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> >
> > On Thu, Jul 24, 2025 at 2:22=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > >  struct pinfunction {
> > > >         const char *name;
> > > >         const char * const *groups;
> > > >         size_t ngroups;
> > > > +       unsigned long flags;
> > >
> > > Not sure we need this. If the function is GPIO, pin control already
> > > knows about this. The pin muxing has gpio request / release callbacks
> > > that change the state. Why do we need an additional flag(s)?
> > >
> >
> > I'm not following, how does the pin controller know that the function
> > is GPIO exactly, other than by the bit set in this field?
>
> AFAICS the gpio_owner !=3D NULL means that. No need to have a duplicate
> of this information.
>

No, that's not at all what this series does... gpio_owner is the
consumer label of a pin used by the GPIOLIB framework. The flag I'm
introducing it telling the pinctrl core - before GPIOLIB is ever
involved - that *this pin can be requested as a GPIO by GPIOLIB*. It's
the other way around - without knowing this, for strict pinmuxers,
GPIOLIB would never be able to request this pin if it was muxed to a
function (even if the function is called "GPIO").

Bart

