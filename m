Return-Path: <linux-kernel+bounces-775313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0728B2BDC4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736FD18842C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EBA311C3B;
	Tue, 19 Aug 2025 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mFCVi/vu"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9761A3A80
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596652; cv=none; b=S1uQSHHNeU5JXXBf1FCF5/bQYxZF7Ut+0xMn5bB1pZEmOq1bNJVhw0z7+7F5E3JWDG//dxZEZAuwpanKhECExMAj4paqd6cPhZ5mRDRlG1PF4BBxN9IagEk+HOdgdDgjmbkK7cKlaFfjGTPyzSI1sP3VTBw+5KHVQWVdamOMO4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596652; c=relaxed/simple;
	bh=OOZDAaZrI66ydwRO+2rFbEiHfOOLnYyWJFOFD28ZEkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rasd2u6laVnTdNd/f0SzOmlWUm+eMdZzYdAmLWqOeJ9/7MaseqB4IzBX3uEJe1LDch20MSE2cjQ42+uhSrqjQhQbQgxbSWXpsSGGI42NSL6DQuOplrhAjN66x8c/yWCV1o8J/nyi/iaoxmrdrxVCP9KN1tSuL5tZSwXc1ZUBF2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mFCVi/vu; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55ce4b9c904so5729716e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755596649; x=1756201449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOZDAaZrI66ydwRO+2rFbEiHfOOLnYyWJFOFD28ZEkM=;
        b=mFCVi/vuIFYlZZ1cLIFUqyzkYGLhxDoRqcDy9cD0TsD8OZXniljtD66sn7Qc3sFS98
         wP80kxA9himGXp9qKdYudJPJflEzZA+H/uiWdcaeatgTAdhNFOY2xfZlRNYeIbJ1WQPB
         snMDHcqbzTiMd4lRk04WsqVS1nFYK5baWaD9frHez0OFiFJb2Am5fpdq6AKFA2WejnCa
         8B72mPzTmEmgummURROiVbgzmOaFk/LU4Ybr0m7QtNQZ+kIgU/bvlDzqdyq3CmYnzPiP
         jLrGk1lh++gxG0FQ+6R2DElxtJkxSwGf4vg4U+MXSMLKYhUPhYoVl2mPZG1cTAk61aQv
         lMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596649; x=1756201449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOZDAaZrI66ydwRO+2rFbEiHfOOLnYyWJFOFD28ZEkM=;
        b=p+fSBLTZih2lsLEPNhWqjSM1qCg2v/vOfgsyx4isu73ctju+4gKnvCwXpBj2H+HnnQ
         dJo6lpCwE8VHWD0s/LrZAqClLk1ExGHfxBFjaZzag08QDF/rhuk+4qAAx+FC/BV4k2ao
         X+l5h5CVmdtKV53INPEuxdsl7yO1eT3GWZ+eiu0Gs1jvNhnA1F1l9cbjnj9dvw1fBbi/
         EE0C/18uniW7Pv7f6PJpmMF7oi48zKKdBFVsNd04T+wIaSW16CJ/l5SzPvrLrIlV368M
         IIwnSvpEI6hl7LCgXJMbWftsXAzOvUeQPoU2DeFcNn0FFvZ3ynti6zn/ZCgKShcdDql5
         jv+w==
X-Forwarded-Encrypted: i=1; AJvYcCXDP0spitKljeUQCIqN0pWaqFUZM1Uu+1M3PuaQDiAO8tU+DUhiKf1BJRGWzyLVtyErwhKpsQMHSCmabuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YylsmG1Uvl01jM0p96nHRNV6uTZuZgBPwChyDRzi03KXAsmaEw3
	zKGsY2zg3t6hHRuhoask+8wAe0/JhY0Fh8/rnrQpeYgxEXQueJ43zM3OWrMJYkv6kHauS7tpKwF
	uvLZlsqvi8IsUU3Fj1P/l+yaM5DrsUvDqQ9nUQXPsyg==
X-Gm-Gg: ASbGncsHA0c44chur0KzfLLXjzgzdjXBD9m9HUkq8EzvTgTJB1+pg+F19G3YoPkS6jf
	HNtD6aySsqUOrBV3hwrx/hIwMrvzkaL+X+nxlVaUOVo8U7WWNgutXpyWPClJzRfQvFLB7JDuKNJ
	HYHAoOIGpldWZhcnd49AsOBJrKppXj0f9PET0rxrGEUjD7vKxTVqdMUA7ZVlVcRbhdnLtcN3Pw0
	Z1pTIDsf5DV
X-Google-Smtp-Source: AGHT+IEb5axoDvieP94ahUcvQF4Cdj/DI1kgL87CBZO05dhRfNXWtWdEPdVzxE8EKpKiDOV7nU9/phOY4imeW35mO0s=
X-Received: by 2002:a05:6512:3984:b0:55b:79e8:bf83 with SMTP id
 2adb3069b0e04-55e00e3ab16mr476219e87.14.1755596649121; Tue, 19 Aug 2025
 02:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-gpio-mmio-pinctrl-conv-v1-0-a84c5da2be20@linaro.org>
In-Reply-To: <20250811-gpio-mmio-pinctrl-conv-v1-0-a84c5da2be20@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 19 Aug 2025 11:43:58 +0200
X-Gm-Features: Ac12FXxWHK9Y341YvKoMtvojeGQDJurTuXUIgTK46n0rp4Sv0-QLWOBJFmGfpkc
Message-ID: <CACRpkdYungF_01g0XO=u7meo7pq+9y2YHP5XCBDtKHByee8yPA@mail.gmail.com>
Subject: Re: [PATCH 0/5] pinctrl: replace legacy bgpio_init() with its
 modernized alternative
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
	Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
	Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
	=?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, 
	linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 5:02=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> We are in the process of modernizing the gpio-mmio interface. This
> series converts all pinctrl drivers calling bgpio_init() to using the
> new variant from linux/gpio/generic.h.
>
> Linus: Please create an immutable branch containing these commits once
> queued as I'll have some more changes comming on top of them - most
> importantly: removing the old interface. I will need them in my tree.

All patches applied to this immutable branch based on v6.17-rc1:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/lo=
g/?h=3Dib-gpio_generic_chip_init

Then I have merged this to my devel branch.

Yours,
Linus Walleij

