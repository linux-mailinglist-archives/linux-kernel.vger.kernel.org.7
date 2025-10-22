Return-Path: <linux-kernel+bounces-864268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D20ABFA572
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D314E5075F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D035E2F39BE;
	Wed, 22 Oct 2025 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="G2SblonT"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D872F2911
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115849; cv=none; b=tJpsRQgxQvONwI0i+fUy4e+pUAq9RnI3QTiArnc+5phOBHmc90zvnzUtT4t3YCsjsfUjLLGwVwIIHLZkZg7ySX99FdAABSEyAiO466LGjXG+W1/6zKW1guCSGYm4nwNhbem+Cd+zcPi2b/B655Hhr7s4IgjCgIc0Px7FIIK+GkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115849; c=relaxed/simple;
	bh=98PAuLdi5bAL91h4qCl8dx1pL2En1aNP3Fd0W9MUOXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTAd7GrEBOJTL5RK/53bJg1KuyChBQhxd6sZ9wkFA18g2t8Iq+9HbgbferxW6weO7vdFXnyWLjLPAhx2wBxWY+Cv+0sl1CErchJDQAJAqUBIzdIIlobJJHNpI0zwg8PF3zmNCEghjLdUiQTeDKXOdb9gOXLXtG2B9i25I2ZmuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=G2SblonT; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-591c9934e0cso7236806e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761115845; x=1761720645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98PAuLdi5bAL91h4qCl8dx1pL2En1aNP3Fd0W9MUOXg=;
        b=G2SblonTD+zIs/XsqYGOF6Ti/V1CReKuYkzBOP1SuUtgTrEziaWZX66J0NV6Sj8tL9
         OtEVUmckZVsP3Q5/EJAFqafD6bvdxk6nY55LAArQY7IFYei5c3f11IGkrkwNfgoNrfri
         NWGSR6q/+HuZI8YnRYQcwzOYM80vIKpah9C07SMtYpP0CEcOuM4f/hQG8VIRAh3iK8XD
         VMlzkfJFNICGexHODWZyLRQ6O5dy5V3iOnyRlMcB3L04M6JtA/UpaLInqHjgzO6UDtjs
         eVFV0AOU5svhNjIpMW69cb/OvgBjeMRF1Udzo2R65nDIQWRCldu+yTPAU78Qag3X6Mif
         jGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115845; x=1761720645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98PAuLdi5bAL91h4qCl8dx1pL2En1aNP3Fd0W9MUOXg=;
        b=lHM83UCvmLHsq3x+sIotyfOvOHotoQFrvUUscfETMLgeNk0cTMJBVu4q01z9PFHe/H
         c9+ubvcmIV0zMYl/471cJYvUmTIGNOtnwiKUsYRZqUB5rr3x8XGPe3FTdbpMIgy92E/g
         hlYjnZtvOkrUyHwlXZuNhfBtINawGJROWTggnYJwxtWrtQBuDs30UiO2hCt0pWtZ3PWu
         wWGDpf6hk1FBf3KXhkZ/QHAOuaJMzyqT3wksike/4PnsCRvTGFhMkXyLipUgSWEy6x5H
         USvOw/8/SIQ1nzzX2UUjJjGTSWB8oMeTfSBLhhQS94gViGToHyxxdGfEi389eCYwFNda
         kcgA==
X-Forwarded-Encrypted: i=1; AJvYcCWZPaW57/DQEPMKeCO4gqJ2SG7hBoMMu/92MSrMyJVC9WcPTkdgIpvw2CEojXXUI1shDvF9p7Hv/8SoEvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL8Hn/PuReNHAP/YufwAi2DdeVfAwqGcgn8EQl6BqrrOv9h2gS
	tUPInHVlMd2ct2D2mXPJK6yJns4QWDey4U5z7Sz6L/ahw5MqXFKTzaPXCY2YjyWXMAGhruWAzZx
	grH/ysgHD49ddqM592UX1euLFNOFvYsHLdGmC0HeRVg==
X-Gm-Gg: ASbGnct7tcBJrqp9fyID/eDAwfP66dr7AOkfLAFswOAoywED29HqEH4N0Mla/k4MHKF
	yuamno8kGFPUtCqYdtUPupSN/POqAdIJJ0OgtRWqcT/ZnA1vjLCBMR2/z5clmt1ShF58X2qSnQ6
	BrvwpSDT8NDlStdr5nX+XFEbkOq57TZ7jz8CsLN6ECV32SA3hZxz2bLDL15oNtFn0PaHgiwAtCG
	A5dCD+z9ref2hqIUxd46nJOTilGYrfnsQIoIc876ZKtf14B142qAmmanmGwE3PpQuHQNhUiRI0t
	gzxBtkSLxa5WDdlPbK2G6QpABeM=
X-Google-Smtp-Source: AGHT+IGr3zukKNYzeyIqR+TYPmYQbS3OFcssWzGNvaljz37h2jEpar009J9nuKk8lRLqnblAhVZVoA4VbyVfP/oprbc=
X-Received: by 2002:a05:6512:318b:b0:579:ec3a:ada2 with SMTP id
 2adb3069b0e04-591d84cf71fmr6407192e87.4.1761115845419; Tue, 21 Oct 2025
 23:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMRc=MeFZTDk4cgzEJNnkrJOEneFUBLwtKjkpV3-cLSm=xsxNg@mail.gmail.com>
 <20251022021843.6073-1-wbg@kernel.org>
In-Reply-To: <20251022021843.6073-1-wbg@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 08:50:33 +0200
X-Gm-Features: AS18NWBBs20dJ04q9W8nyqQ0zArr1FQChkJ-T0_854tkBtyhYXLfHhbwUGei9wE
Message-ID: <CAMRc=McqqxWTf4CbZJRSBSD1BnLNZmed_G0OsMNob1wTZmj=pA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpio: idio-16: Define fixed direction of the GPIO lines
To: William Breathitt Gray <wbg@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Michael Walle <mwalle@kernel.org>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:19=E2=80=AFAM William Breathitt Gray <wbg@kernel.=
org> wrote:
> >
> > Turns out, this requires commit ae495810cffe ("gpio: regmap: add the
> > .fixed_direction_output configuration parameter") so I cannot queue it =
for
> > v6.18. What do you want me to do? Send the first two ones upstream and =
apply
> > this for v6.19?
> >
> > Bartosz
>
> Sorry for the confusion this caused. It looks like `b4 prep --edit-deps`
> will add explict dependencies, so I'll use that from now on to hopefully
> prevent this kind of problem in the future.
>
> So we'll need this fix in v6.18 as well because the IDIO-16 drivers are
> completely broken right now. In theory we could revert the entire GPIO
> regmap migration series [^1], but that would be a far more invasive
> solution prone to further regressions. Instead, picking the commit
> ae495810cffe dependency with the remaining patches is the cleanest
> solution to this regression.
>
> William Breathitt Gray
>
> [^1] https://lore.kernel.org/r/cover.1680618405.git.william.gray@linaro.o=
rg

Eh... Ok I will pick ae495810cffe into fixes, send it upstream with
this series and then pull v6.18-rc3 back into gpio/for-next and
resolve the conflict.

Bartosz

