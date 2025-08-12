Return-Path: <linux-kernel+bounces-764511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B853B223EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2531350849F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA552EA72F;
	Tue, 12 Aug 2025 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JySaj/KK"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A2C2EA499
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992775; cv=none; b=LsegJU4d0mfBGXwfHar1oQhy6f6Horlr3EogOJuNkEzuR7FTECjygZrIveHtM0L9KULHPjYjcJ8jBmm5JWUBJMR/vvIE++Qnm6jwe5iwFQBEIk9Hh0VMDLd6BdAyuRrsLxXIPfHqSKtu4BketR4XYUzYzaJRQ+oVKEpTq7BOo2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992775; c=relaxed/simple;
	bh=fdw+3Gh+VFRomWVLfv0e7HTdn397jxovmsPiCFpOtlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muID7r/u/kTVZwMK0rQzZauSOzyGY7YpDp9UREurTsbsNchVz6EI04UlsFlGUJ8RFWmju248fVHyk+ah/+kTgfEbeNus7MH/rn59bzx79rfw066xOhJiEceCH92WwuEwvwGIFRVFGKEbxuXt92sSLkO/IMt84ylwel3KQWdY12A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JySaj/KK; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ccc6964c9so2558286e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754992772; x=1755597572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1mDrWuohEgopTPInI6sA+uoNinbrVfmWIHEgismuPk=;
        b=JySaj/KKE+Jr1HqFK+9h+6f78vADIvRNx7h2I0SQQ9/mZIJ06IDEocguSaS8LneuXb
         alFHu/eZDE7znbTuFWwPowjlWOfLDvC6QupeWEi0WUMO2LPuSOKlcOR4AWA3VR+3QTP9
         aq9eo88KBaIs8bsYBaFck7jVj6Ax4sE2k3MztTD57u3hVqLt//6AwlAVe5l6B29o+Dap
         rRvUOlpDxFhVnLQDnyiNCyX+FJ34EJJWBQUbOdYzuep+TnezDTEJeQ0jkBxucHNEYn+a
         mX/hsf8PlX7N0GUPPaMNsmSgihW4hfn60sFyZAOS4jbRP/APNhisuqG7PL8Zv/gUvyXY
         KpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992772; x=1755597572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1mDrWuohEgopTPInI6sA+uoNinbrVfmWIHEgismuPk=;
        b=r4unWLR5M1Rd7iGj116Y9b9DQ2O7gjj8119OMC+6Oi93cBvGc/dWWPo1eLNuduNUe3
         CZhDkxvAW9OQRs2FIqCRZ8b6rn9vWy5GnmaDR1kaM9liS2rNIbER2xr0E6N1lc8c3oTj
         B+4mowsrn7hNwYYUrmFiG9Rb33JAuCtF9Kr0UI7c4XPzcZKTEaPOeSgTL3lV85/H5ELY
         0jXNL/LBI3uPkDtSY4lu1ajM2t529Ed4yBFo6iR7+RfOVZzsfT6nVtjfI0/SM1eV/JZj
         Bti8P608yUbfFwpwTzEcSz15ht9x453QbBo/B1XOgrsrEuO3Rz2DA/yt9TE23HDiQJ06
         UYew==
X-Forwarded-Encrypted: i=1; AJvYcCXoei94K1n9rgT4j5LREiqT6iIh2QxLWIRDhws94vJbkHdkZj5G/YJd9xaO0c2X/RrPPm8qtiG2xBZlBhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPRWrASPNarTflJm/AL4Rfa+tKTyRFsclMt0EPbHoTHt1WLCp
	qwtinAnFk0Zluft7Ks91So6gb7P/b1Sd3DuYr7w/lu/extGO72YMJzUwv42zhyMAom/vr112Sw5
	41qBFyrAkPqOIA63XKUpU8RjXPljQtteTBA1etfox2w==
X-Gm-Gg: ASbGnctME5WYYxEczKqFjPzM8T+zeKvNX0/4XYE2mVj+JUhPUtdpypZzn3hVnbHQBM6
	aa5xhBONTlt6eN3Q7nYhBX6JHXzh4GLUh/nOVwOYkdFOfw+mvp41uDCDHQgfEtiSW7S9moMBnPX
	ojSpjTPB2AfEpisn2AGZ6xDYXxBIf/yF5MgvBQkFRdMdKFQsnAW9h4xYAIQ9/7SQXoiglP1YaQx
	7vCDVRW3mtPaAW0TyYao8Y9Ag1MxAXvhzmR
X-Google-Smtp-Source: AGHT+IF3WgiehWnZQLfMQrcxniMNK/2fuKGhQA/XqVGq1OCbr4PDYFcEG0ahDGLz1N6K7QygM6mYjF0gHE1SQR7cH3A=
X-Received: by 2002:a05:6512:3b07:b0:553:cfa8:dd2d with SMTP id
 2adb3069b0e04-55cd766f8c4mr730147e87.55.1754992771830; Tue, 12 Aug 2025
 02:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-gpio-mmio-gpio-conv-v1-0-8492f4a4c1e4@linaro.org>
In-Reply-To: <20250812-gpio-mmio-gpio-conv-v1-0-8492f4a4c1e4@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 11:59:18 +0200
X-Gm-Features: Ac12FXytMUHnfMvorE7AaIZ4tQn_RJRgw5kgUrTE9wtdfJEknR5-9y8JUWSkapc
Message-ID: <CAMRc=MdTWpdQp22yf7w5zNhfKBdWKJAX=rvAG-bkYxtCfLSFAg@mail.gmail.com>
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

On Tue, Aug 12, 2025 at 11:58=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> I hit a network error when sending for the first one, retrying now.
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

Sorry for the noise, I'm hitting some SMTP errors with gmail currently. :(

Bartosz

