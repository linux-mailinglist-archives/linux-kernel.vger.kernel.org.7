Return-Path: <linux-kernel+bounces-808333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCECB4FE72
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2CD1652E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A051A341AC3;
	Tue,  9 Sep 2025 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WshGuwoP"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F4B34166D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757426217; cv=none; b=EeueoBkolvEWuCK3s8BwWYHmOfrgrxYzJxFANiz+5SbM1Fj8nuuC0J48Pk1piACe7UkgELrGMGQpk+4B1SQcLyDa+MhAC6XKQnkUFIk+2Atam+C2d8JiTTXFe1HYrWh9v1l4XRIXE4L47JwaVVRY0+jm+kNJIVVZPGmnu9kTTEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757426217; c=relaxed/simple;
	bh=WHJeyQoxrfPmUkZrw+WhWWyRIvgBswo4VP/FGQPO7jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8ft3yNqzIppt584s4KkReu+T7lmRtcDQ8pRHA9mnLeQA+lgXFXR/PiC0KdvgJwjpHTKNpeB+VBxnnlK12R6G1+FjQYjmTEzyTNUdIC29yKFFojqOV/niKWN8hhldDKhJrjOKktEv/VU9QHxzx0Yp7nw9rev6NulHMiBzc/TWs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WshGuwoP; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f76454f69so5340213e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757426214; x=1758031014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHJeyQoxrfPmUkZrw+WhWWyRIvgBswo4VP/FGQPO7jw=;
        b=WshGuwoPIVsb9lFy2eO/07IyciUutK7uuQEzLrSTUSjfNKPS5wMpQEXrjv0NeaGdI4
         c3TspzI3Xx4JxsLMCrHx2SjoAgubjCg4jQgdrlsl1oXQFC5P852zHoPA7bR24/YCbBcA
         I1XdtZlv9Xjv2ATUJk3NEB8lgddayESWcvn1bKOltvSyl6zwIQM0DbITSlBHpsyWne5y
         HUuK6CgsEu4Xqyp1Ym+0rMJS0UlW5r2c2TVaKifxEMAA2IXIfVCAulOl4gbCWJDT48iN
         gX8xeYRZdAxI0Bx8h1SIaS6Pv9DarT+jOs+0IaBBNvPI2xTr9Xzi+WkMAhhjGCABzpu/
         tz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757426214; x=1758031014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHJeyQoxrfPmUkZrw+WhWWyRIvgBswo4VP/FGQPO7jw=;
        b=QEuv4OcVUHj03cU8tS15WltjDxbU01OmLcsQ9458KGZsa/Mjf1aZtAX6W5H5iEc+Md
         SBQgoXb/mU2WsDlWcmGpsgumfHcSy1rISNGDGBYzTE8OBMmvoxhoKPRR4eCxwR4LkCGd
         eWwJxxbvJ0Dcsy7xVvFO7NvMJgWR2ACm1eFFPyN5wYp0tEmf1FCZF2F2UFdLZ6iBdA7d
         NUTaK3DtdrItK/Fhwf/4hSgcEn3NTW1a1bsoAYy+HEQ9yoDEAkKiS/RTqjJr/IGpHnl8
         ZKjsyWstFIIBOiy+mCI+ss3c6w70HbfP0W1dg7BAlauOqxp+aOa3IvGKaEbpD4dUDA6t
         J0VA==
X-Forwarded-Encrypted: i=1; AJvYcCXiJgN+eQd0kaPkkQSFktj6+36Fpjz249JNH745xEIa9caueVqc22qZHWwoT4WsmMnB5ZcpT4PpYA2Pu5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVirI/VJTjp5rk2kj8P45mQ5lfEEQKxnQa8iitX4kVIPqdv+V
	12emEXKAGtKwn5ryK+k4RO/xtELyXs90o8S0SbC9B+/llM52sOUgh2yMU45k38HckLmQs1alRu4
	XaCpH87GvHIkC1xuS6rbSPlDTzQWpHTnpwSH46E7mOw==
X-Gm-Gg: ASbGncsqp8wOnQZPq+ZyZ47CRRxOsfg3Oc3+fNKR4y2k+FLAzfzDv6YEDA9kxEFkbgM
	zH4iGZ/HwPP3EK341Iw0gSXy1JPtRUIH4ivXz2LhuiqIvT1ZrAfI3WUVOFZhiTlqR3WY2gNuGfE
	reRekcLGEBXU8B9EBMwoi6HUmpNCY6XaduGxIPMdO0mtToz69R/VaDefewpDcqDdHyi8gFIdXrF
	lRWWqMLJkit+/+y116eNyi4wzq9Bja0VC5jQO2ow+XqLkl6Qw==
X-Google-Smtp-Source: AGHT+IHBxkyJPoP3osXnpgBU6pdsryw/ot72GCgtbXz1ukCkdeMh24NQ6AJOJ87AcYe5pD0xcM8OlZUSXTQKermPfKE=
X-Received: by 2002:a05:6512:b8a:b0:561:9635:5af5 with SMTP id
 2adb3069b0e04-562619d971fmr3883543e87.48.1757426213571; Tue, 09 Sep 2025
 06:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909-gpio-mmio-gpio-conv-part4-v1-0-9f723dc3524a@linaro.org>
 <20250909-gpio-mmio-gpio-conv-part4-v1-13-9f723dc3524a@linaro.org>
 <aMAP9hAWars0T83r@smile.fi.intel.com> <CAMRc=MeLTGq8Qu2aT43tkt3vaYCSaJPJPLmaUQ1SAyD_OgVr_g@mail.gmail.com>
 <aMAn4MM_Fs8q8qwj@smile.fi.intel.com> <CAMRc=Mdr4oW2d7XZ90rRr_fKC7WToz72v=_kW-s8=Urd0g8k3g@mail.gmail.com>
 <aMAve1MbONmKVjjg@smile.fi.intel.com> <aMAv3STeZUdSQ14p@smile.fi.intel.com>
In-Reply-To: <aMAv3STeZUdSQ14p@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 9 Sep 2025 15:56:41 +0200
X-Gm-Features: Ac12FXw-xJdDcWBTzEH08jjeniZk8zNeWwiQ6jDsDwHAH3I_S_ZPt9IHyI66KLg
Message-ID: <CAMRc=MeA87p0QAzq_3MACQM90MhN0eRccr7u-VzcfyP8b90AaQ@mail.gmail.com>
Subject: Re: [PATCH 13/15] gpio: sodaville: use new generic GPIO chip API
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Keguang Zhang <keguang.zhang@gmail.com>, 
	Alban Bedel <albeu@free.fr>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Yixun Lan <dlan@gentoo.org>, Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 3:47=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> TBH, I think those 6 all made the same mistake, i.e. thinking of the comp=
ound
> literal as a cast. Which is not!
>

What do you suggest?

And are we not allowed to use C99 features now anyway?

Bartosz

