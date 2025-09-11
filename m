Return-Path: <linux-kernel+bounces-811862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D44B52EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74ED316C4EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BB230F559;
	Thu, 11 Sep 2025 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wCe1K3kg"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596B619C54F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587232; cv=none; b=FvcuvMg0TFEeSliH4qNjgwXMq8jnpJMaEtv6mWc/2DHvc3l8u+1Ib+Mvr5jpUCb/E3Ju7kjuVSv9mJXxh9i4ErdFN8lag7blaYwOHvTslj07Atwjy8ViygwkR1gpRv98/tX/OQkKGN0UtxFP3wc0KykEeWNCC9Zix/RGiFAJWEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587232; c=relaxed/simple;
	bh=IgQMjKlxFUBBT5mGRk3osvw4oAvRvmOZA/0K/Ils3NY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRZMaeyyBA4KY/G3B0AW5sdupYTaJFK1Ien3a/aN24WOFM5Y0CPrgX+YsOaSFg+naEldIw6DsnlluRl97Dhs/HzJAQJ6Lr9th4bpAPTgDPPIlpG+5weHapZ0g6aQrMLz712AeDHO/hGqMOaZoH8qTlUR9THoPTAM/WESdqKIn/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wCe1K3kg; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-336ce4a8bfcso4342161fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757587228; x=1758192028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xhofByKOJZBUxzzCwJz7ILtLFgJS+emxFXnUeLfugk=;
        b=wCe1K3kg0A4/UiNL4wpvBnYSc9qwqaIHmx/8CMmLf+j7YgjccoM/QGs/pBKUY9sovJ
         c0VPhfhktikWqVOPX2dCFa+jSnptq0k1Cb2Nllvs8VX8PFpCzBs80Kn4IWmpF+96bFc2
         XsW+qP4ccGUcyKYJVNMZ9c2MauLuNRozM0rElIOlz0bQGg66nfO9TBx0chBWtIzwXGnP
         XDqIyGu4KcUB3TCh4V2mW8zgA1rzdt57vbTS+SWeybJG2qY7FrfOu+FjRg3EJ3zbO7de
         S/MndF7YZbtTcyjq6lL45pEb/tJ/XIZCURUrom1FUDdE4vf1UAKpGobDNDewCABg0Y/2
         HAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757587228; x=1758192028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xhofByKOJZBUxzzCwJz7ILtLFgJS+emxFXnUeLfugk=;
        b=NcElaGOVktrSyuERw+ergx5ByQRjHAqzqm+AbxeIBBQwYAQfV7n2kaNOx/wFj3J6Og
         oULkqnbPfqomI9yqlvt1dd00c8hGUvf8BaHIwrNyspi3KrPrIkiOgjGJvhKFhMgrDO74
         AXu2vAw08UU6n7euY3BiqXPyZ8NblFYeUWnH65olNUUcAsRxhqsSBQYx6dswkUYAoPiZ
         cQUiJBF8s5E2GFta4G/tnPMKlEpeUvld0CM1e/PeqRZ8QDvcUHklbBaUQ1+T2J61X+pL
         AjlzrkQmH0aQFqvVk55BBIOU5m8wa0nyd08bN8vdRd2oPuFcub8pORMqW+ES54+xBkri
         fOng==
X-Forwarded-Encrypted: i=1; AJvYcCWZf/6yysZbcjWYxIoF7R2+vDDAsEg+ICpTGw1+sFxirL+CNAnejTPWAkkPg5PAidl0iIAHBsWO859ddxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWFfJ9SD4TOck49z/9iH9mf1+kyO01bvcOlx7pH6AHAmN18qOI
	r53uk4oJ1mCpJTia/bIzQtsd359ILb/GQ6tW/2rO9GOcXrVOX9HQDzOG8ecMU0FBwG3GHP6Li08
	y0pz+R8CyIaJI8SQituoCHDd0vHZIxVHxTcMrG8nPgg==
X-Gm-Gg: ASbGncs4bL0zSeJNzGk0RGL9qRI7775u3kbt738LuK6rwKE4indpP7nkK243rScjNdS
	srdyE5ky/Y7wBwofm2bxUn85jW9CIkn6FydmZvjlcDr+R0BAxN1IQ8xxO4vx7MFwjOh5odtPinJ
	NKlI0CKTjH3NJ+aUs5TBVsC1ZKR0iIiTJaYcFGo7vaCTlwfjTc3x1gbeb76rSMvCKY6fTCn1CTq
	GzFwMnDwawHP13gl/pl/fJupS2DjJN6jsepMtg=
X-Google-Smtp-Source: AGHT+IGPBV7ZUshYcZ++bfkHR8WoSLgks047FDwY5y0u82+iY8L6qmzhXMDwyO2eqt5HUBKGwgQk4xCTnYrT4A3qljM=
X-Received: by 2002:a2e:be1d:0:b0:338:166:6b87 with SMTP id
 38308e7fff4ca-33b5edc397bmr47551441fa.35.1757587228237; Thu, 11 Sep 2025
 03:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904130516.72266-1-brgl@bgdev.pl> <20250911103147.GI9224@google.com>
In-Reply-To: <20250911103147.GI9224@google.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 11 Sep 2025 12:40:16 +0200
X-Gm-Features: Ac12FXzJUv-DtTTwMxm9Tw3SjH4bJmVAMD-5PcnaHNxBA2feO9XIwHgckN9WRfU
Message-ID: <CAMRc=MfcSkwr+EL2E2wshuNvTLpWXsftLwX6uA_Y5Wmok-ojyQ@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable branch between the MFD and GPIO trees for v6.18-rc1
To: Lee Jones <lee@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 12:31=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 04 Sep 2025, Bartosz Golaszewski wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Lee,
> >
> > Please pull the following MFD changes that depend on commits I already
> > have in the GPIO tree for the next merge window.
> >
> > Thanks,
> > Bartosz
> >
> > The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15=
d585:
> >
> >   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpi=
o/mfd-stmpe-for-v6.18-rc1
> >
> > for you to fetch changes up to df6a44003953fb23ad67f82d299e439e7ff7150a=
:
> >
> >   mfd: stmpe: Allow building as module (2025-09-04 15:00:53 +0200)
> >
> > ----------------------------------------------------------------
> > Immutable branch between the MFD and GPIO trees for v6.18-rc1
> >
> > Allow building the MFD STMPE driver as module.
> >
> > ----------------------------------------------------------------
> > Alexander Stein (1):
> >       mfd: stmpe: Allow building as module
> >
> >  drivers/mfd/Kconfig | 10 +++++-----
> >  drivers/mfd/stmpe.c |  6 ++++++
> >  2 files changed, 11 insertions(+), 5 deletions(-)
>
> Pulled, thanks.
>

Now, on a second glance: this won't fix the linux-next situation
though, right? You would need the gpio patch as well in your tree
which is the prerequisite but I can no longer put it in an immutable
branch as it was literally the first patch I applied for this cycle
and I've merged several other branches into my tree since then. I
think this PR doesn't make much sense on my part. :(

Unless there's a conflict you should probably just ignore it.

Bartosz

