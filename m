Return-Path: <linux-kernel+bounces-795988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE26DB3FA5A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E3E188CDB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F002EAB8E;
	Tue,  2 Sep 2025 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="k34K1Z/m"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D32EAB73
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756805345; cv=none; b=OMoQ9gstBYkgaQGuEVWB4iscdfKZXQtbgL9QVC323yXIgETQWqkqfiyVVHPLRnVI5/HlxcS8o8U4LJKYcpCH46Qadf9xwa1lIXVzsMCJGbcyiNhFADeRYh5cEcTPhILs+ASVageqp6giLV3XuSNdb0/VlOWzkFkXYBKOC78wCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756805345; c=relaxed/simple;
	bh=//HUxWX8DeQeqsCEd7QC8ijoCC/MOXp9FJU6m8p+/e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwtOpzSAT1e9Q2LvgfiMrFW4kgM+/ZxIvjsKPrh8Y0o/IMjPLFs3N89+RiyPco17xe/A4kRBpM+0MQNPUbw4BTOagMpAv6ahkOsS15g9mIbLOh6ypxQaNMLe7AEdcdf3ZpKwJ7J2G73qmE1jpkIRpst15z44YN1ZoNA/DMgQA88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=k34K1Z/m; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-55f691c9febso4023824e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756805341; x=1757410141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sgn/vJYsBdxnr7Nj+togafj+OMxwmvaU1XUkgIJUYhQ=;
        b=k34K1Z/meQJ4VwbmjIRA5E7E1EAZQSmf4hhxBKjJvEUxPYANVxFPc0MuXLkiH78xaN
         zZBqLDyqSZhOcX1UOxWr3//0S2O/R1o4V1Y8co1WX4XnIYjGfqqjrC471Vvy1rzVoc6d
         zrYeJ9vSg7Qvy76HW1ROt8PNYG2c60YolX4/Geyn81v0bNfoGWsyGlRuoSZJ2dTiDeQI
         oZ7R0VMNFnC9EcUf+tyBgfQN88Pq6Xby2o+4v6N/EZNonhrIMGRNiVJgylr7vJvfpkSr
         t8qPkqXByTYlZNhSs64A8kcLoIknaJqJxTNRROoVapQ5j48nfioGZ8Iep5/JQIYX65Hq
         ZiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756805341; x=1757410141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sgn/vJYsBdxnr7Nj+togafj+OMxwmvaU1XUkgIJUYhQ=;
        b=l5GnWJe7sjUvLoG0Tp1Bxe66OWUa9SX7i3m9rERWW4O3fdvziidH3Pc0zPLS696Apn
         QobB9/STu5cguOxCBvjcB7GIixCoLMQ6F+1e38f975p6SsMBWZ3+gpdZDNJUeYdvesQ8
         GtnFHTn4rk9V/3Z/HCxapSgs0eV8uu80+z86Yz7ktCZoSBqjmr9a066nl9mCcl8tDYDL
         uT0q8kh51X1GAO5iaNqco3rnoxGa3QRRrgZo6W+34T8dwGSrYZ20vveMNzdc1UeKQ/A8
         qAqbeGOleB5wRoz7/B0GzuMrVklOHxzXFq69mF1PyDZnwqDdA3ZQ8JmxMSVVi9BcY+Ot
         9ngQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgbAf3w8RG8jhMYVN5wL8uy45zIvWh1C7Udb4Ohfp0ukiVgMSIzCNTBW+a/Yt6WC5FoB9GfAkgNfOo09Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCA/72fc/BEn38552l+wS46pCdeWqwL+Xrv/SCyGf99QIuvtBR
	ulZ6F+7gbAa2wTJgjrWuhsDRH/q6QAXsdXv/UVhWfxaclcxFEaMgc50L9jzzHOlcrQrVK+/dUSW
	U4TXHSs99/2IrHem4RSRqrA4ri4sl5w5ti5gMXz81ZA==
X-Gm-Gg: ASbGncubeQpS+0PfAhfi1Vz51LY8s215Q6T42PQ/XSxf34fGMnMJdnuyLUZYoiVlfR3
	MYqNo+yE+7J8d/1bfb0YB0unmmqYGxjDo4YvsIvgd8GIiik6v9WMpErwaWcm0lxd+NMJuXf4LQq
	vaAj94ajrqZJFB/EXv7YGaBiNxns6q2kNspwqwoxO98FfxhIUBI/Lkvu9VIeyGt6+5dTBGPGz3I
	f1Cf0DyRHpD4OK5vRcliO0fG9H7uWai0i+xWE6g1As49NK3nA==
X-Google-Smtp-Source: AGHT+IEbZleDaAu1wkbBHOjnlGL8C0lL2XvTBcBG1o0Yu7ShYVTEpic0xTaWFK07gn8fwR7JGIFClShl9m8jNgG1o5M=
X-Received: by 2002:a05:6512:680b:b0:55f:4e62:f0ca with SMTP id
 2adb3069b0e04-55f708db56bmr2636846e87.29.1756805340472; Tue, 02 Sep 2025
 02:29:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
In-Reply-To: <20250811-gpio-mmio-mfd-conv-v1-0-68c5c958cf80@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 2 Sep 2025 11:28:49 +0200
X-Gm-Features: Ac12FXwyTg5R9QK3KWUxLTr3m9eLRisbXrlkPr4WlpAVjY7_RF2FsWzkYU59lb4
Message-ID: <CAMRc=Md+2_3w5kdaUF9-nGdHv9C+tGRfN9TTu6E4+hSdFbwGBQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mfd: vexpress: convert the driver to using the new
 generic GPIO chip API
To: Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Pawel Moll <pawel.moll@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 3:36=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> This converts the vexpress-sysreg MFD driver to using the new generic
> GPIO interface but first fixes an issue with an unchecked return value
> of devm_gpiochio_add_data().
>
> Lee: Please, create an immutable branch containing these commits after
> you pick them up, as I'd like to merge it into the GPIO tree and remove
> the legacy interface in this cycle.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Bartosz Golaszewski (2):
>       mfd: vexpress-sysreg: check the return value of devm_gpiochip_add_d=
ata()
>       mfd: vexpress-sysreg: use new generic GPIO chip API
>
>  drivers/mfd/vexpress-sysreg.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250728-gpio-mmio-mfd-conv-d27c2cfbccfe
>
> Best regards,
> --
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>

It's been almost a month, so gentle ping.

Bart

