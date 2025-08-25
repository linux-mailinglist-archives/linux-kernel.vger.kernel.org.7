Return-Path: <linux-kernel+bounces-784449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB924B33C17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C908B188C863
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0F92D94B3;
	Mon, 25 Aug 2025 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="U58yHuRf"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9692C21E8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116024; cv=none; b=INleCz2UJ0wfD6tWTX9EKiQZdTz4aCz1+ufIQ+6NJQudjTunat3k3unM6uGLcd8MWkx7oCoyemtAP8IYmyYvDBrG4i1PBfoqfRfPm0vWC8YfkeydNfF89dZGcG4vUD61Ufrgi6lsgFlRZMef5zhE9kAlspt6NHx6cjH/3Va6jTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116024; c=relaxed/simple;
	bh=wxd1C9NmIuG0GH6DNDBUAnY/nN4ImOhyji7flawOOL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kKScc3OWo29SVXMR6vJ6tpWSZKilBtvJ2TA3ynZw2uDs1bosbFpgtvr6dYrx9sjUucvwf5TFy9HdmmSUwGO8ON4xzWhoQNGL1HCuVd7icgf8LyvzlpHsJCpsW5NWps4Jc867Dsv8Mcb2arcIo+4UB6Bgu2iTAzTXtvYSd8SOTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=U58yHuRf; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55f3e4dfcf6so1521791e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756116021; x=1756720821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJ6AWb1IvRBO6bay4aNSpk7sMubJEIQ+ss4WOdc9//U=;
        b=U58yHuRfvRe2FRdugymVTh6CcEXeuVfqZLnbJ1bb3aQL6NqkkVji3WsjJI3UEbdAUA
         SrFasuJfP53xutiX5MGilguMJJ1dG9yjG7s+tDDCoHNpO01SbmWwmOxdsX/4RBJt3C00
         hx7QSiJ/wYfAfDfeDnEjKE3Ae3pshpTnPl0p4eDploTxTw6EXMnpaICCoxI3FILiJtau
         9f7UvOria2WI5DDY3QU5K0a2qyRUBuLAQ9gXL/NJiVVNbxw8JFeZLrxUqRouJixk0fbU
         3JGUb4ZFkkTlCH1flGQ158pJdKd8wHh4O/1xF+cZwcqf+/yNE8yZfd6Vyg015ZafWJom
         Yj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756116021; x=1756720821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJ6AWb1IvRBO6bay4aNSpk7sMubJEIQ+ss4WOdc9//U=;
        b=CwjGFZMO+QwvFJIVw345/AplvYn/n/4DLTsxAUW+h26ob4Vq8BU7oHTdDVBF/03gwe
         dtM5Yb5YGvQsq6bxAQpVSoLyKD/QvAW5jA0sg0tB5Fj/WFVu8jzD28ATV72A6yMzebc4
         wC4oalw2Zllx0km0+It3EvCsBsCZP4bBueshB+2rPExZJ5fIlPXnsMtwo+ksCyiaFcOO
         abwn9VE784d0QaeUsiHpZU2rKq4ljyMqZWDeelpdu0qMNhBua2phrw5FQRJgeLp/D7QX
         PjGy7PmHBNPndlODq/Z1iCdluVwpxB2opaTP9aWdAkbCm7mR2VD8UpySxDn+BUDWXNRk
         Ldmw==
X-Forwarded-Encrypted: i=1; AJvYcCV91HlMjsvscnoh5a9dA+P2yM0aaLW+N1NyudWMBo227XM17trQfC86ERXUYWLy3u/E8mUdr5+Ic1F3dXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBBVrYbzpHz2MNsTWsNhLA62Gv5waM1fwRCZWpYeMD3zEqzlq
	FC1awaje2hoEoSlFwY6RFQTe+uFL1je8xcJnPEEvIH9664yxiQfP2Qs83sX53km7zTCWViRe03L
	8GO2HRi8amkUik23oe/AYsKxX6LfzDuup18oHX6MNvQ==
X-Gm-Gg: ASbGnctcIbLPYPg9MUWyppeaetabDj8M8KKCAL7fSCWi9RNNT8yXGXaQERqxo2YPZsM
	JSyb5kk300s+YH+krPHE9bkCCKin8AxVyBUois/jfgEXaYaLlxAUhOx43H+ypJHv9H8y/7ESaA/
	diRw+Xf6LBV+bjDsnaVunIWMDkDaEb3ysxbYh2ouVV+g8TuMYAH1eUUdeWH2RNgZQ5vtxojG6z1
	OZUtuOBu4jgADk7TBAyTXdin3fTSQg8O5b90EYuVb28smwuyA==
X-Google-Smtp-Source: AGHT+IEm/27Fjesp8I1iWaRVfRS4o6ubuyYXLf3VGmJD68g+F+2NqcP7oTbMplKzgA4i6aEsqRoV/RmDLiZU7vv5W1M=
X-Received: by 2002:a05:6512:260a:b0:55c:c9d5:d341 with SMTP id
 2adb3069b0e04-55f0c6f6e83mr2791627e87.4.1756116020888; Mon, 25 Aug 2025
 03:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
In-Reply-To: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Aug 2025 12:00:09 +0200
X-Gm-Features: Ac12FXzlFRD8xnoHzxDbgloRnldi4vgsYITe61pwJ6-xPGt6zuFYA_t_OLE3l4w
Message-ID: <CAMRc=MeUuHMjvKtsK+oC2L0VPRBY=dbiJetzX8D+pBrxFNZ3=Q@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/14] gpio: replace legacy bgpio_init() with its
 modernized alternative
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, Hoan Tran <hoan@os.amperecomputing.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:48=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> Resending due to some patches missing in lore.
>
> This is the first round of GPIO driver conversions to using the
> modernized variant of the gpio-mmio API.
>
> While at it: sprinkle in some additional tweaks and refactoring.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Bartosz Golaszewski (14):
>       gpio: generic: provide to_gpio_generic_chip()
>       gpio: generic: provide helpers for reading and writing registers
>       gpio: hisi: use the BGPIOF_UNREADABLE_REG_DIR flag
>       gpio: ts4800: remove the unnecessary call to platform_set_drvdata()
>       gpio: ts4800: use generic device properties
>       gpio: ts4800: use dev_err_probe()
>       gpio: ts4800: use new generic GPIO chip API
>       gpio: loongson-64bit: use new generic GPIO chip API
>       gpio: dwapb: use new generic GPIO chip API
>       gpio: amdpt: use new generic GPIO chip API
>       gpio: rda: use new generic GPIO chip API
>       gpio: grgpio: use new generic GPIO chip API
>       gpio: mpc8xxx: use new generic GPIO chip API
>       gpio: ge: use new generic GPIO chip API
>
>  drivers/gpio/gpio-amdpt.c          |  44 +++++-----
>  drivers/gpio/gpio-dwapb.c          | 160 ++++++++++++++++++++-----------=
------
>  drivers/gpio/gpio-ge.c             |  25 ++++--
>  drivers/gpio/gpio-grgpio.c         |  87 ++++++++++----------
>  drivers/gpio/gpio-hisi.c           |   3 +-
>  drivers/gpio/gpio-loongson-64bit.c |  42 +++++-----
>  drivers/gpio/gpio-mpc8xxx.c        | 102 +++++++++++++----------
>  drivers/gpio/gpio-rda.c            |  35 ++++----
>  drivers/gpio/gpio-ts4800.c         |  39 ++++-----
>  include/linux/gpio/generic.h       |  37 +++++++++
>  10 files changed, 337 insertions(+), 237 deletions(-)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250728-gpio-mmio-gpio-conv-623517c3df74
>
> Best regards,
> --
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

