Return-Path: <linux-kernel+bounces-858497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD9ABEAF57
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9BB0345F63
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8542F8BD0;
	Fri, 17 Oct 2025 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HKt+D8t5"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B630A2F83DE
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760720574; cv=none; b=TGsLP2mVNt839IHCADy+8lSzwcmeKymNO7kPoXzWvagNVRX11d4lYUpXChFaT7p3R/b4GdLVr2GDLdPWz7tvM0XocHUir8R2oHgI+mIShGjG0R4WSIRPahD/6ks3vHMTEZ1zXG69RbuW4d2raXIvA71oCQOPE5CClBV5BakocVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760720574; c=relaxed/simple;
	bh=s+DfsSyxoZjkavdlNnP0h25P6XFkog0IcVoyYYb6tYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYLeU7dZemtBE93ayedgJGVxrEEIMNS0ukz9LdvSbvfGu6hIhQVC25F8nC6ILEMzypomHo4RwG7t89uxMZPLDjVpcBMsAOS2Xaz3CjEREsky+CO8xaykCcn8aNS1ply6qGruqXt28/O3Eu0ZDBE2Vx67tE7qfXb+SRgc0Kh9lkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HKt+D8t5; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57f1b88354eso2508477e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760720571; x=1761325371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+DfsSyxoZjkavdlNnP0h25P6XFkog0IcVoyYYb6tYs=;
        b=HKt+D8t5u2aiP96/Fh4I7bz9mQRuzxhG5Xfsn01F4PDLQSeCUoN57xFUYcxBeuj1iG
         UxEa+4AKf/Bh5k/CbrkcDK26gAcmD0ClFbNQ6KpFs1HQTbQtkR7IDql8WkIuogIw0cY4
         yHViRTas983wnoiTPfA5IFWdDhDkyR8vLjvhq38OEJw2txXaBcMLTjpaRuRUgowrlfxM
         BwGi9SpVe9nyDTUt93cAtPjoNuC+LTwtTW9Vn2Et6HCEOmiFxqPwXWVhRdWAvlQo5btr
         naN0bW2kS6FIBYcIgvE0UehxBxRM0pKadkudMc2dLG/LsYquFoBlJIZu7hEc0u60UfvR
         9EuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760720571; x=1761325371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+DfsSyxoZjkavdlNnP0h25P6XFkog0IcVoyYYb6tYs=;
        b=w6Yy8r2G4MSqftkIUMUjaVbxgcJzPCZ3yGiAhkiXNh279Yx4bzT+XRTjC9qJAP9X3g
         bbZd5F4cmuigSTX2FcPZMHaoyjqxbKQy5KXCvq6tmGS02QgLUfTxoj0OCBh7YUnFmrXh
         TOWYjyKVg3cv+FOvxU71JCErTWncYWlaUoSuuLTo1bBZjn2YV78f2GVYhXol26HuyMWm
         22tw1xkZNXO92s4TTmNE+IYR1xCv7pi2EEKG5NSTCVCDQp4GFFP5Pnsjj3T7LWOb7I8M
         s6kxW37YNLXxK8cTs9sCZa3uw387BSYPct7d1C5hGO2eEXN6ArSX8/qwixF9tLLsr6CG
         gFlg==
X-Forwarded-Encrypted: i=1; AJvYcCU/tUkCvGuFLao+NHeS+/vRbXhaAMLEhTg2fKbVXLbC96oJ2jQ7YQ5LNNmqZ/QdlXhIHJqXRjUG8u7agno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2/6ErJfecKZK38lo43i2fv9g3FVE/4/viHzJ9LVEhbEpH9O7Z
	2LmacuzgDC9NZEwt7VLMNm7YqX21c9maB0OWRMzOSQZuGqxdJdHbVOEp3EZlta8cACXckcP/gDw
	luKIginkG99afJ3+y358I3jV8mxTPoeIRg5I+FUrqnQ==
X-Gm-Gg: ASbGncsaavz9vScL4jt8t0dGlWnFjK/6tvYtmsrQsJdoWVm0DUPJBozKZNIxfEib2Zt
	OD5j9rndftd3ag85/SMU2SMnyCGpvQCHhLWFoC2WG41Z5bCcThNNkuoUvm08p6wXZ5QeZs++ja/
	hmTytsh+vefDbAr+6BL4nee5PaP/dsmswF6zemd320rirAUpXwK5ptTIUW8DIvHGeMYDMoMUuXg
	kOArda3GwoHB4cS48Ntv6GTwZZMg+/Qy+bVLi3QhUa+ElN0z9DSnoUTDEEAQC5welNzsEfU3Ymu
	f/2tk86EmhrO1YWwV+QK9Ij4B3Y=
X-Google-Smtp-Source: AGHT+IE/jXqKTloLZ/aopfjxfCXoZv13PiX76YKj0csvsveMFfoiQWw14YejNOM2QPMlqcPqBUNH95FgcM8u82UXJiU=
X-Received: by 2002:a05:6512:1041:b0:560:9993:f154 with SMTP id
 2adb3069b0e04-591d854626dmr1423123e87.35.1760720570725; Fri, 17 Oct 2025
 10:02:50 -0700 (PDT)
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
 <aPInv9NELU7N9QDn@shikoro>
In-Reply-To: <aPInv9NELU7N9QDn@shikoro>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 17 Oct 2025 19:02:38 +0200
X-Gm-Features: AS18NWDzZOn6Pi6ARdErmuy19hYF3sE3l-jPlZ2FtA0A_r8ld1z1r728Uxqt9Xs
Message-ID: <CAMRc=MdWS2OSeJAkTRnAFMtXcVukwQ=JAWwJ3OHxogmgZnan6g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] reset: always include RESET_GPIO driver if possible
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-renesas-soc@vger.kernel.org, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-kernel@vger.kernel.org, 
	Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 1:25=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > > I think the fallback mechanism of the core should work without any
> > > module loading infrastructure. It should be there whenever possible.
> > >
> >
> > It's not really a fallback, is it? This is the path we'll always take
> > if the driver requests a reset control on a firmware node which has a
> > reset-gpios property. If the driver goes with the gpiod API, it will
> > get a regular descriptor. It's deterministic enough to not warrant the
> > term "fallback".
>
> I dunno for how many drivers this is really applicable, but I really
> liked the cleanup of the pca954x driver. Don't handle GPIOs internally,
> just get a reset, and it might be a GPIO. I think it is very useful and
> I would like to see it wherever possible.
>
> We could now make these drivers depend on RESET_GPIO. This would make
> sense in a way but is uncomfortable for the user who has not RESET_GPIO
> enabled before. The driver would just disappear because of unmet
> dependencies. Yes, this can happen all the time because we always find
> new dependencies and describe them. I just hoped it could be avoided in
> this case.
>
> > Then I believe the platform's config should make sure the driver is
> > built-in. I don't think it makes sense to just cram it into the kernel
> > image for the few users it currently has.
>
> For Morimoto-san, the PCA954x update resulted in a regression. It is
> worth thinking how to avoid that. The driver is so small, I wouldn't
> mind the extra space if it saves users from disappearing devices. But
> mileages vary...
>

It's up to Philipp but I'd personally go with "default m if GPIOLIB".

Bartosz

