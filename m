Return-Path: <linux-kernel+bounces-866632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E60C004C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0213AFAED
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00763090E5;
	Thu, 23 Oct 2025 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="t77gdKo6"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCDB3093DE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761212295; cv=none; b=NFv/eSUG8fXycRB/k9+hP0mrvTvitvtjMZSxpsWITtY93cIyvimkIBNsuUEryITxyHWaGbMCd+5ckC5p1B4McAfd/wgJgpuA/8A2kgKrd4fbGy47Gi+vwrgAzRaKcNFnp46MVVJ/Ggszs/2xuyWK7ln4DF/rvlVHPwjrs48wDN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761212295; c=relaxed/simple;
	bh=FVhPIuwvuLptQuHFQTFgTVKX2ix+VKy8esMcqqCSasw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qg5VUAdhDFeV6AujivPQTB6WMT/jUkbwOfnY4KLDz8+mqukUP6NexIXI0XP7vGHcWAOorYqDLNcUMF5iYCG+mNkITvII4vz7GCXc5vLEnZZ0pZKnxPethgR8yEsgxQyL3Wod+IomBux0yTYGbxkJiceHX0maDLvKKBNE3Tcdo3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=t77gdKo6; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso369314e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761212291; x=1761817091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVhPIuwvuLptQuHFQTFgTVKX2ix+VKy8esMcqqCSasw=;
        b=t77gdKo67//NOrQqDbGYp8NOnxu+I1AawdX2YqbKMd4yYAjUpLVqP8MCfHVx4T+Uv4
         KDSzsw6D2HU5ad/XJjxlDUhOKeg/0SKqCz9w8Fme5sZbMz1uTjb989Y8j00uueEpKQCE
         iGBW2VBw+KJROfjHLqLZmxdFvlVi7fd/Isi9dXmGNg8ADJEVPgebitEJtot/AirdlpHN
         hMyxTZHmwRTJ3YyiCaEpYG4AG62f8NdvCerN3cCnKqH5UOG0ZG+9+Md/mmU/PdaaTu7O
         Y98d6M1DHcLxAyO8PiS3xrgSqwQ8V1wSouyizQkn7Cm1yj8R3xDMnYyBVnR36wpHawtM
         QkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761212291; x=1761817091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FVhPIuwvuLptQuHFQTFgTVKX2ix+VKy8esMcqqCSasw=;
        b=hX7KNaRrWKxxZocRTKbwrWw361pSLGWdXgXlKtJ0Y75W4t+vwp29fZRLaJk5TU9vlY
         3bSFWTarwP6YeaJY84ZXw9/y59Lvuw24VY6kuaM8K+mMszbJ8B+PRn4jXFc9ZDlcF9Co
         TGXU35T1G6sGAK5P+QGWKozxEHo7tc5Q22A9i7N1/LARz93yZ86BoXOK2GgJJwmPbQUl
         KPR0FrfuYhTb284fxt+ZFhXzk9W+gUIQ0pilfcwbW4CFEymewEvkNsUSeSMpwi+24kK3
         cIowpJHX086wb5gAhWDhxJqNztFIQQ/Xfzxm7C4tAAo4uRqIttAiZj0OSfYvY14rdaEr
         NtcA==
X-Forwarded-Encrypted: i=1; AJvYcCWOUWDyq50NMgg30Xd78PPgHDJW3pCXvJZbVO8A5rFONaS7+B1U2655cknlR3U4dQxN23Tt3/Op2umtV+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxQEaAJazhoqCdWcDg5YUdxxIcfT0DlQB6taoj2Zv+EH8eKJiP
	1JByWA1UxEzUK5sQTKlS3vdoVi8AH+MenYWEwLGOE4z+QimfOGCY0UYv4g+LzmHbp9w9FBOMYXv
	epO4AW26VtZpa0ApweZg8xK766LADaaK7KKZX6U51fw==
X-Gm-Gg: ASbGncvcng4ZH5UKo6f5Vm0Now1Hj64y+ZZWGbFPKDxOXif48P65LWRB2Wsj7jOVC9/
	uxo0B21P0zQ3erPiZad7YGwZx6RoxbRGKLOuzHEvs8aDzA6xp3x1Hsv+APQyg7+SjiWx9sKFRgZ
	v8vfT8982DloYVANzJhK0QNg3AeVFjnlahahKK2pB1b4rNWjHHX0koVWWlTveGM3xmY+olpEmVn
	oqrlbshRb3ZHKfGLtMgl1d+jMPi1XEcGWjmwqg9iI0DZc4Y0ovDKK8tZFkypheh7DAhUaz8QYDx
	E7C4zGqdey382/B9U/ngml9TDg==
X-Google-Smtp-Source: AGHT+IHvued6APKHSuhZW+U5ogxN76QdmgJk0+xSehag34epjDmyx7iYvyVhmHhVufJMQ4zetnHzORBL85OdiThnUlk=
X-Received: by 2002:a05:6512:3085:b0:57b:5794:ccd9 with SMTP id
 2adb3069b0e04-591d84eb75amr7545365e87.9.1761212291492; Thu, 23 Oct 2025
 02:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015205919.12678-4-wsa+renesas@sang-engineering.com>
 <20251015205919.12678-6-wsa+renesas@sang-engineering.com> <CAMuHMdXqHncXxBZ00mxV=pzdgQEU4ju2F9XMejnibbu=QnLfDg@mail.gmail.com>
 <aPEAx8ZGHBcWZKJF@shikoro> <CAMRc=McsbAirEYjoo455mbKU495VEvPmMEqBmZCq2hw113YHOg@mail.gmail.com>
 <aPIfF-3SgzW5V_gs@shikoro> <CAMRc=MfVPO292xmnXBWJzWuhNADA_u1yvpJ4kkK8TgZyQgaP+A@mail.gmail.com>
 <aPInv9NELU7N9QDn@shikoro> <CAMRc=MdWS2OSeJAkTRnAFMtXcVukwQ=JAWwJ3OHxogmgZnan6g@mail.gmail.com>
 <5c9761d5a6a14d4c250df6cc4201bca72d963133.camel@pengutronix.de> <aPnz6U-fcodRoobU@shikoro>
In-Reply-To: <aPnz6U-fcodRoobU@shikoro>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 23 Oct 2025 11:37:59 +0200
X-Gm-Features: AS18NWBd32y6WQwlZDUB-bYljhxAaJsH-bovfKz7DtPPPXHzv_tRrFcKoye_mtE
Message-ID: <CAMRc=MejA6DsnOW3hS+aFtecXn38UypJU2TUrAWPoo9Ly341uw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] reset: always include RESET_GPIO driver if possible
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-renesas-soc@vger.kernel.org, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:22=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi Philipp,
>
> > > > I dunno for how many drivers this is really applicable, but I reall=
y
> > > > liked the cleanup of the pca954x driver.
> >
> > That cleanup might have been a little premature, given that the reset-
> > gpio driver currently only works on OF-based platforms, and even there
> > only with gpio controllers with #gpio-cells =3D <2>.
>
> I see. That kind of spoils my assumption that it is a fallback supported
> by the core. Darn, I would still like to have it, but it seems more
> complicated than I have time for it :(
>

As soon as my two other reset series land in next, I will finish my
work on converting the reset core to fwnode which should help.

Bart

