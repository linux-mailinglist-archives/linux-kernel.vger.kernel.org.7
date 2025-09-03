Return-Path: <linux-kernel+bounces-797792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90748B4156F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B321B26212
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B902D97BD;
	Wed,  3 Sep 2025 06:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdzZTuYk"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAA22D9493
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756882047; cv=none; b=HrSd5/V+4hGN2FfZVzcsKpiG5vSNSfJtNYsbdayq2KunNvpmQNAQ/vgl54R/g41j/ENNXGjK8Y0Q+LLyY2WoIAENXFyxwNTf8EeYtbiCFoLuDkZ601drsiO1a1Uv0PQ9Ii6KWQY19zhjx3qRNwkQ+7ayv8dT0+JOvo9g4taIg1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756882047; c=relaxed/simple;
	bh=JPf9MBwFsXDqpcdtjQzlVagg9Dgm72GKmuu+o+i6Jps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzjJSa0wqb3W7IQJXmzibV6j9a4UZHVc8bqdpXxD7xSEyC6IiJhMOEAg+NwoCPxGqPyLp2mNnmAiRG6PjuP7aai/ESVD2M8DZ3otlDA6e6mrJGqBEAfQ+Na46zMaN4DVBKTzqSG2Zh4HnxCxB8HQ6VO+oWFWcDM4WHq+VloBUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fdzZTuYk; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-560888dc903so1075782e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 23:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756882043; x=1757486843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPf9MBwFsXDqpcdtjQzlVagg9Dgm72GKmuu+o+i6Jps=;
        b=fdzZTuYkF29QgBigJfqqWon5n83S460gZRV2f4jgqqMtXu/gzDeqg+NYLgPQ0RV38P
         Sk/Jako15oRICnUN33bJMaU1upbbGzl3acZCpyGWq1NP56J4hY38LB9F9wkMgJuv5bR5
         OOFIq3ZOdI3Hb4toCnPk9ls5Jt5jswt2WXIrFoRtz3i/ZvkQp0aKas+BS5k50Vc8XLvh
         MhUvkvcLieCyIPaaZvTUu9zsK0eaJxlocxMgEqvisIEgL1DfJXauJAislBcZbusE5JcC
         sGBwcDp/0bfqxQjB4ucerRbjw+pJJvi5YnVOqGjmbTfM4u0RQV33fizl8MW0mIYGRT+W
         surg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756882043; x=1757486843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPf9MBwFsXDqpcdtjQzlVagg9Dgm72GKmuu+o+i6Jps=;
        b=EkGZAPdyqp3MiWZnjyUxS/R1/iZFjaOJmTBw/VDYxc1zCitV+Ja0DCwJiW7TuexIZQ
         cS8HdcfQ1D0O9dBRkYowtKL8cOScZ2sUx47xThd3M2Qx2KLm0O0nduiVzODO9hqiii5d
         tA6CvGl6enzIbjkj+UiVNNWqzGT2CAacJ7Rf01jndHUjbVkYdCybOPnWqR1MJd3XmKUI
         MSGsZx9hTTxuiaQj6bHGQQN71NP4Cyh4mqBmyDj7s4RI8i6Fy1jGQNa/lMb1KH4swY6Z
         ME0AmDK7kSfzOlxSVITouH5XAb0hZkeqRGf5+HfBAyF2tgkvDlhHQG3A21jNAPWAqiPg
         q3DA==
X-Forwarded-Encrypted: i=1; AJvYcCW8wySaySNuStnJUy32rTXK59XT+ZbIuFk9XDOSG2z6XflsxxQM2A4BTNVQj+fUHhrkSwY3ehr74NCTMTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp4LmipK1SrgPUBbMKzY9d1R5BiKZZbmFpk6NtNOgbN+Am527D
	eFw0mA4wcSNrqm4rBa1cZaPDzBE5E+U3Qq9sZFj01TtlqrPQTbSS4V8yyG65M1MjNLHuewh+Mz+
	gNk4dVbVp/ykBKqGOHCBzTqT876CDNccnoRxdxQmxbg==
X-Gm-Gg: ASbGncv+wh2W4RTnsjDg160T33jCBWHkIKROdWwe0iC+XKouNEuc7ps2SxSbfLfIl5V
	wgyRzDjrUh1OcylHkOX6s0veM6GlN3GyRZW6+x2khrEnKI/sAyGRV31qs0ge91LAKcry6NKb4uN
	EbaCBw/1yg9kcjOsYVNHKwbbr3/8MOkDa9bd19g14o6n3mnNUDeBwAPhikfg9pqniNeSrvZji2O
	h4bC0VGjrWJYKRbww==
X-Google-Smtp-Source: AGHT+IG4YC4WaIVhdE/SO0C9kkujplv36YQBR7QppVwWs93lEzjQRfRa2semDZGhdaQs2p7GqIs9i0ivFJhWbHX0Rek=
X-Received: by 2002:a05:6512:2508:b0:55f:4b53:6fc3 with SMTP id
 2adb3069b0e04-55f708b1a85mr4516238e87.16.1756882043464; Tue, 02 Sep 2025
 23:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756813980.git.mazziesaccount@gmail.com>
 <08929460fe11dd0b749c50a72a634423f13f4104.1756813980.git.mazziesaccount@gmail.com>
 <CACRpkdbOhm4PawYZUxU1SMi8WGr-LxhR1jhSVPDvPh3TTp8SWQ@mail.gmail.com> <ffef0fa6-45e4-467b-b264-1df15754d213@gmail.com>
In-Reply-To: <ffef0fa6-45e4-467b-b264-1df15754d213@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Sep 2025 08:47:11 +0200
X-Gm-Features: Ac12FXz2kUTuIK7Qu_UhO-ePUCmnG1GuzLVWHurE-uLTn1uN0blwAJJV5wrS6c4
Message-ID: <CACRpkdbPzq6yKMHJXaFmXZSsttUkt5OAKRTSc_pjLwZZiZr7Gw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: Support ROHM BD79112 ADC/GPIO
To: Matti Vaittinen <mazziesaccount@gmail.com>, Michael Walle <mwalle@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Tobias Sperling <tobias.sperling@softing.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Esteban Blanc <eblanc@baylibre.com>, 
	Ramona Alexandra Nechita <ramona.nechita@analog.com>, 
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>, Hans de Goede <hansg@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 7:23=E2=80=AFAM Matti Vaittinen <mazziesaccount@gmai=
l.com> wrote:

> Anyways, fast-forward to this day, I don't see it handling valid_mask. I
> think it is a must for this device/driver, where pins can be either
> GPIOs or ADC inputs.

Why not just add a .init_valid_mask() to
struct gpio_regmap_config so it can just pass that
down to its gpio_chip?

OK I don't want to load you with too much extra work for
the driver, but it seems such a small thing for a blocker,
and Michael who wrote the library is really helpful
with extending the code, so consider it!

Yours,
Linus Walleij

