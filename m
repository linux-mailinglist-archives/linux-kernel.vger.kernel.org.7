Return-Path: <linux-kernel+bounces-882705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D3DC2B2E4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20CC3B3D8C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68C2301004;
	Mon,  3 Nov 2025 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UCIvXGY4"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA25A2FFFB5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167204; cv=none; b=ZkI0l+iinzr9pEhwyaf9N+8UGD4dug81iRLTG/wlKqBQe6cZhK+bwReVCWr0MZdfYnF4cXyLQHAP7WDIS7KY4gB5Eu7/KuMom3Rv9V7Snknttg2POGFIhpbgzyGrWwZYQ1YriNIKSQEtDBCUnKtmAtAatMlkDH5073cgm6SsaSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167204; c=relaxed/simple;
	bh=EY4jDPbNPmr5PzA9GSYwh54Yw35fl5rlzQYnUs6Iusk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBk3pEGylfouIeUIcdPdL6fPaJCWI9D8BQx2L+3/v71jvMlKjWYSHzY7YtUItQ44pJb+LknpqdHOHY92AgE4S2Tqms1bBRYOyWkEGnMu8WROOZoF1tAi+LyFXbqrnwiLVEGaMWWlJAvdwyHuqc8RaHiUVlkXaPQ5lfrwFsonum4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UCIvXGY4; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-36d77de259bso28867771fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762167200; x=1762772000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY4jDPbNPmr5PzA9GSYwh54Yw35fl5rlzQYnUs6Iusk=;
        b=UCIvXGY42sups7C267nt135b6IGwZCedTHICPhayhHMPbplbJQj+iOC6BAtOb9Lj8E
         fhyks2qEOtJoDm+KKTNHfuL4jPTr6I5WF1m6tIkzroGPEVlg4JJSNfFGe1iMdFfLEuKo
         MybiOA76NyK7Y+ynd0E+ZbZJqO03HqinL/RyIhCzNYUd0CCL48SaVATHZDRPRfnWkBar
         0oCOvGC28fCNYArTetHEUb6A61qG0ym2cKVcMvlIn9ouVfqBOhnv6E4wVE1zef0IqAJW
         UERR+FbO8XOafCTeIRIQ906SuvwNCwL45ZBDbi14zEQyGp0MLFPjUcNqMUQLIEyUtlg+
         kCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762167200; x=1762772000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY4jDPbNPmr5PzA9GSYwh54Yw35fl5rlzQYnUs6Iusk=;
        b=CYaff24c7l7OuBU9bwS6EoKTbFhs4weMdgoCN6zeqKpsm8VT/CIxvKX+g3kPTAHVEF
         VxVhH4a9nCQHUXN4+2cGeMEIIpG7aLuAvm00QSp08hLB4PP+EHRuDR884ARbHblc3qdi
         5QIPr7bpqt5QIz88Rh9By5iLs8pLjU1PxpurVokPIKvgF9v9DPRjojpLjnSmtgTvmIlB
         0eYVUrZ97pN8o3YW8ICNRQ6tmDWHtoMpmQHBlSyfM+/HRmxmhCe+1aKhR3hfp8weyRsH
         2G5+1ZWxXIoFnYdbVhApIrY5NzEaqMJX8QLGbSawYVcfGuSKX3WbqbyYXIZ62rHSxl8b
         yf7w==
X-Forwarded-Encrypted: i=1; AJvYcCVunZflw2K8NoA5KlK13so3b29r4H7pidAgTGp3IC2rQ9ewKk1oAfwqTSuSq4TEfCqvbE8V2EcWMYFNNRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+dH3J7xdmuU0TXH2GruimMOLY3sNKBUqlhdml+yVPEdviCSDp
	RBszZQ8F14/CFU5Pu/JAfeo/wcrtwiX/zCDt5UHUNZFVFV0PPFoUDse4jfogo0rTH3IIWk5QGOj
	cfQpVbnQl8GM2+6CdEZmcVgH3vMrNpoczt8lYSpmaYg==
X-Gm-Gg: ASbGncvV+j7cBKTieVQpMWD210wmFA93VC3wHpGXqq3l252P5i0iC8ssuVcUJ7YfbG8
	Mz5lrhoyZE3PX6ytnTKmmw7yczW4hXU/HHmAFaznfEyI6IgvCLRMrvXmwFX+mPshCnt1K0auiHZ
	QnEeMktvAd/UP25eR0/uqI+77eOTDDmou26uH2zA+Br4u4arMHyWniO8IaSFnd5jNnZxMtgkExu
	+GG+dnxxCjumHzOEhos7co8gsB5aAOACx298Nwn2jAikbrU2sxtvTf0WztAyH5h8wkIs5p1C3jy
	6TnBAdQS+v0jK1r2
X-Google-Smtp-Source: AGHT+IEShcGLq+8nFRRZ1S7fCAIIXDtScTJ8z36zHz5pLUhN35vmGlC0mMXVLA08DstbNEHUwTHKGlgAvk7gFq8+FWI=
X-Received: by 2002:a2e:9103:0:b0:36d:114b:52e2 with SMTP id
 38308e7fff4ca-37a18dd5390mr27978041fa.34.1762167199608; Mon, 03 Nov 2025
 02:53:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
 <20251103-reset-gpios-swnodes-v4-4-6461800b6775@linaro.org> <aQh7JUeQ84WwUzW9@smile.fi.intel.com>
In-Reply-To: <aQh7JUeQ84WwUzW9@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 3 Nov 2025 11:53:08 +0100
X-Gm-Features: AWmQ_bkPWbySIvFJ536kZ_G3NlC3s3A6TPy9KXNNHgvuSGjsmX4rbxmg-1iSaYU
Message-ID: <CAMRc=MdpX+jHQWqFAgOuHB0E3Sdge92=vcjm=xcS4Asqm8_3Xg@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] gpio: swnode: don't use the swnode's name as the
 key for GPIO lookup
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 10:51=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 03, 2025 at 10:35:24AM +0100, Bartosz Golaszewski wrote:
> >
> > Looking up a GPIO controller by label that is the name of the software
> > node is wonky at best - the GPIO controller driver is free to set
> > a different label than the name of its firmware node. We're already bei=
ng
> > passed a firmware node handle attached to the GPIO device to
> > swnode_get_gpio_device() so use it instead for a more precise lookup.
>
> Sounds to me like a ready-to-go patch and even maybe with a Fixes tags, b=
ut
> it's up to you. So, why not apply it so we have less churn in the next ve=
rsion
> of the series?
>

Yeah, makes sense.

Fixes: e7f9ff5dc90c ("gpiolib: add support for software nodes")

