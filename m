Return-Path: <linux-kernel+bounces-723061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BA2AFE24F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 10:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1832B7B9CCF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 08:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DA923B619;
	Wed,  9 Jul 2025 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="b2hOwPrF"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FAB23B61C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752048791; cv=none; b=Y5Ux3VSSIoS/33rgkPxjzvE6iIbTtjN02K5TjI3aPYqKzSlj7Sp2/9YnMUz/JfYQmAUrNI5Le3qmH4ZzGlBzsDLj0BV/ZbdpXfZ6tifXMnUvF8CUoQVmM6nLNCL+S1aAAvoFzvzDR4kvnN4vH6Hn3ZFuwkL7imaT1kF1RuO8+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752048791; c=relaxed/simple;
	bh=DH9NUD8mzU5ovthvNp8ZKZYQRFFPM1EeEMXe9n7EirA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLik/QzeKMhUfWuFruJVrUeWZP9tUcCuBdBcj+UnbsNlhIWvp8PuUUys151mrCuzvbWnuYiPpxdyf1itT5S4Ms/NB+QrMoN5AlCyUEfUzeGaWqjJvUvK9BfcF2m27vNghe51YyUasFSYIa1bhR1nvfyxQwNdB2PSIR6z8MqvIsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=b2hOwPrF; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-32e14cf205cso43780861fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 01:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752048787; x=1752653587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=865uQGi3JHs9gU6SJdGaHyOjW16oPlGySA+XL9vzYmY=;
        b=b2hOwPrFTgRG0MGHTN+J0+KxYyJHJh/GJuJHifKKlR/x/o1R+O8LGbeizacvpVQC0z
         VP5pLEgEYfV5dug8jHL6S1lzAo2UEITF/uNaRx3n0oT7iAq5uphjcJOx8Qa0gD8twSTG
         DnGOx6yTVuP50JNgnA9d7nb69htAAGW02S0oGcTaYMGpMo+cqsxlaMu/iQH0ezL6iXFb
         i0Nip6eS/Y7XRL7Xnu4gUxdRAgUjYi7Vp2DPoR1oiSlEkpjnlMyjJ2ml0xx+SxNaYggu
         rv2QXZx7brS53Npv3agLLu4OleM+gSR5nLpY5EamojJlBIr6KNyziHduczrwqfONcZnf
         EMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048787; x=1752653587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=865uQGi3JHs9gU6SJdGaHyOjW16oPlGySA+XL9vzYmY=;
        b=B10eriBJPH4kFEMIwn1d4fxVenxVnf69Z5xRlEzVaf62NveAmWBMfp5SQMGpfX6cWl
         JLLnF4U/Bw9Y4UuvtcGW/drZoXONCpqERrUxWpK4rQhpPRMV4klFts9Pwu5LaGn2y9Qn
         N3qqJjVzD9m4IQhe+KSn3OEaRHgH+DTiCPSJNelOhhk45guVg9RccE65qPKZkjzfYcxf
         6jH0gmtiKEDoshaeY9uUC4brV7ROsSaDlFyjvPScjDEMc5uhUaIHYzmv2EnqiXpc13Xt
         f19MKttk6Uqnf2SbtaSRFYTVdLPGJlNRtoKWNiUf5FuMqcLztlGuymbRI+2kQsB9ssd7
         xWXA==
X-Forwarded-Encrypted: i=1; AJvYcCWoTXYFrjoBOEijdGnmW2Wn/RtfJz2Bg2nLC/rKk3SmB2ow9wrD8hQsxh0/fdR2JtVXc/qrNolJB4CCwhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcg3dNUqeoW1sj4G7JBpAsRCOvRA3YKm7VlibRFqL9giXayGYN
	D7mgQTfI/BiPdZsuzlGH6AjsJ+8glQVC7hPgSYMahmWL4G3p+vEWqzmIsx+BOhzcIim1s9zInAz
	KCmHP0cSAWHYCRxO70KXnoJVB8fvl78H4pFxZEsyl9YnwOMrkczacNPw=
X-Gm-Gg: ASbGncsiK6pJH4AqlFywAsi0lULwHW/dcDBLqYVPxy6Epyg/teSKWrV8oCcwMvYrK+M
	OHqA87wnlflXoO71uYeuigXGing3qfawAtmWTGrtuiphE2/xCmXYbgz3/5BIKzgLT+Jt+EwD6H+
	KLbbxhV2D6DEwKa1QCwdVa2PzF3sULLiANXHk+/+6dsw/KQEi0E7PDVqJoj7gcV06hp1zucIf5s
	XQ=
X-Google-Smtp-Source: AGHT+IGdXHk9MOPcJEsIkrUcBBcrbdbZTeRRspKa0o7hVMdnKdwLyq1jVJADdc+lM8sJtrMggELmxg/v0AA8YEwt7qk=
X-Received: by 2002:a05:651c:3044:b0:32c:102a:f02d with SMTP id
 38308e7fff4ca-32f485c5877mr3801891fa.30.1752048787410; Wed, 09 Jul 2025
 01:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709071825.16212-1-brgl@bgdev.pl> <aG4eT557hI8AT38G@archie.me>
In-Reply-To: <aG4eT557hI8AT38G@archie.me>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 9 Jul 2025 10:12:56 +0200
X-Gm-Features: Ac12FXy7aI3Qs7lgagRv3GPU9z2XcHjmSgG0_MnFsJ-CNXmaAn1fS4KYQmiWBC8
Message-ID: <CAMRc=MehnbMsYj9EW3P6T-20-tYBBJ1CeKUCf8qRxva3UFdpzw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove bouncing address for Nandor Han
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 9:46=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com>=
 wrote:
>
> On Wed, Jul 09, 2025 at 09:18:24AM +0200, Bartosz Golaszewski wrote:
> > -XRA1403 GPIO EXPANDER
> > -M:   Nandor Han <nandor.han@ge.com>
> > -L:   linux-gpio@vger.kernel.org
> > -S:   Maintained
> > -F:   Documentation/devicetree/bindings/gpio/gpio-xra1403.txt
> > -F:   drivers/gpio/gpio-xra1403.c
>
> Shouldn't the driver status be orphaned?
>

It falls under the higher-level GPIO subsystem umbrella.

Bartosz

