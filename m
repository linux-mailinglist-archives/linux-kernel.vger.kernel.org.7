Return-Path: <linux-kernel+bounces-842902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FE9BBDEE8
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 13:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66B8F4EB9F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC80A26A0F8;
	Mon,  6 Oct 2025 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1B+Ndkfz"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D22594BD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751716; cv=none; b=MgUFHDReF86uwSwKdGHQAUJC4+w0zL34jdXjW+0yVhfTp0Wm4xuLbx84xbAa+dcyqTOnqTvtlKUR1N6McGY0AssULmrUCCMjZvoWHocP9E/DBRxXOIWv+HJRGGxn3OJr6ddWSz4R92aNcb2SysJ7Zc1om41zyZP1R4j3Xg1SRBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751716; c=relaxed/simple;
	bh=o88ha/e4gk/j47+reFyIn+VgsrMXI5uaxH81XcB5pnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlN8by3eIuEsEVEKizBzRRASMxJC7NHPJxH4eM4GSH0dF5SGP21uaHn9aPvxoSc+SqzkpyJJFx4p7Cmhq8/xKjQOuDXogHaSLvCsamQ9y6M6W1iZ86qkTZUm9zR2ZF0p4aZ8OfnftLZIZDsxbvTm1m/yLBvliz58T9cHeHFrhdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1B+Ndkfz; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3696f1d5102so26811281fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 04:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759751713; x=1760356513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o88ha/e4gk/j47+reFyIn+VgsrMXI5uaxH81XcB5pnY=;
        b=1B+NdkfzkKQImgJQQdFsgUKPpm8sBT3nizg6TZCsth3g6ipK1whKp5EaPdCR3SKyrj
         rRHbCnQ9D3FKPIbu7B1+CCNAcQ7mC3/cgjs+aL01zXGYynq5zeGzP2Sgu4LKEU7H+ghG
         BKBT2Vj1nl5PdArvm+xbi495HG80nQxdIWjCCgWnj1no0USINVQpoSP4EyyfHE1rHsAB
         7sP0OzVUR7gA5JBvFDjsqC/Wxqv+AFxQv/DaGLgFAhgSlc6eOO1mVyg/N0mqlA2GIe5l
         jX/6ZOkqGpYzNVBppW28NuoAWD2hqjYlsXMQcOWjgHHlOm7VOjXesOS/2BoTidx5br08
         qEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759751713; x=1760356513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o88ha/e4gk/j47+reFyIn+VgsrMXI5uaxH81XcB5pnY=;
        b=wDSmBz5x2bkkTTc5XGgb9Qu9uiugAuWFzPS0IAUnfZNKUnUUwTxaRAy4va2xg8gMDK
         78rTfUBh+cn8dVxtb4xvn83MW0QY0FRo2cffm2CssttyTcPZH7bJMndCzOCJlePwyFlm
         qr/x7eFgFLUxwJDguZThHSGUrt94sddSzI6zM1VHJzTl0v/p8PNndIa4VEO3KQ7frLBP
         b8vcRLLluVKVWk3gwF3iJZFVm+aXjhDCBYLLV+31HwASdPRRZRTc+iPHHsQ1Dsnxtovs
         3mc+200PkVHj2pKm9IV6wBpFYYYhtbSlC9nzE8r6t3/+6xweWxQIITLrj4BUZOhP14XW
         CbOg==
X-Forwarded-Encrypted: i=1; AJvYcCUJvfPWcA0lXGfRqHKePTQV22/DB3yqUIJngFTOEyKNI2bN6MX0BXYg6mTJMxKUP8pP1/90wZLA/+SHNqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx28je5z83dMfXbUxhQGSHOvezqXBdI02Zkk4suChzzKiC9pqez
	uHTjzv6IrnBB2UivwDF8mTT8zWEoQ4HV++EqsnRAxIGrzax/wN18txSRSrfzc2766O3HggS5lK1
	rtcw42THnMRXOoofwSNOalIlW5/rMyM8SiopMcKAlDw==
X-Gm-Gg: ASbGncvrUW4E1mfG3suBA0lkf8MNEucp0Wgt9FNpshp/zuLreWpHe7kIBK1OVw0zyfg
	Vb1yQSzyRpvYOKvqSLnKEuT9DayBuaE31JIGrkOs8lHhFQszYDIYMB5ngj+C618dvPVil0ra4Vr
	0fGosZqe2w7CUgwP0t6WXVpmVx5wTu9IBcX4gbfuXQu+NdJrclmZkas7qiVMWLty09oVS88Qh5y
	kl5GAmLe2AYJIWNMs+CKFzOEfKyVScoec2MNLMeZ/Mn3nqFB3g1Frb2pvuiA+0HRuQhPkOOiw==
X-Google-Smtp-Source: AGHT+IFimUYcDrg2G1TEWgg30XOxFQcNPZ7in8UOx4Uq0QD6a7uE0edrd5tvO1JATw877D2GtEmmVeOuzKJjG1mqPQE=
X-Received: by 2002:a05:651c:1b0f:b0:36f:4c94:b585 with SMTP id
 38308e7fff4ca-374c3727355mr34984151fa.17.1759751712890; Mon, 06 Oct 2025
 04:55:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org> <0b402bba-0399-4f93-873e-890a78570ff7@kernel.org>
In-Reply-To: <0b402bba-0399-4f93-873e-890a78570ff7@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 6 Oct 2025 13:55:00 +0200
X-Gm-Features: AS18NWCcgxeUyOPczJhdeT-2OxosYn-Q0vbiWg2Io_Y9VuYPbgrPQiw2FGc9xs8
Message-ID: <CAMRc=MfwEHGV-HZQURR3JNg1HatAeWO17qbRmkWUXTSBWj5jSg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] gpio: improve support for shared GPIOs
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 4, 2025 at 3:32=E2=80=AFPM Srinivas Kandagatla <srini@kernel.or=
g> wrote:
> On 9/24/25 3:51 PM, Bartosz Golaszewski wrote:
> > Here's a functional RFC for improving the handling of shared GPIOs in
> > linux.
> >
> > Problem statement: GPIOs are implemented as a strictly exclusive
> > resource in the kernel but there are lots of platforms on which single
> > pin is shared by multiple devices which don't communicate so need some
> > way of properly sharing access to a GPIO. What we have now is the
> > GPIOD_FLAGS_BIT_NONEXCLUSIVE flag which was introduced as a hack and
> > doesn't do any locking or arbitration of access - it literally just han=
d
> > the same GPIO descriptor to all interested users.
>
> Isn't the main issue here is about not using a correct framework around
> to the gpios that driver uses. ex: the codec usecase that you are
> refering in this is using gpio to reset the line, instead of using a
> proper gpio-reset control. same with some of the gpio-muxes. the problem
> is fixed once such direct users of gpio are move their correct frameworks=
.
>

If they were called "reset-gpios" then we could (and should) use
Krzysztof's reset-gpio driver here, but we have many cases where
that's not the case and the names (and implied functions) are
arbitrary. In the case addressed in this series, the GPIOs are called
"powerdown". The second big user of nonexclusive GPIOs are fixed
regulators where the line isn't called "reset" either. There are also
various other uses sprinkled all over the kernel for which no good
abstraction exists or can even be designed in a generic way.

> Am not sure adding a abstraction with-in gpio framework is right
> solution, But I do agree that NONEXCLUSIVE flags should disappear and
> users that are using this should be moved to correct frameworks where
> they belong.
>

I'm open to suggestions but DT maintainers have not been particularly
fond of creating "virtual" devices to accommodate driver
implementations.

Bartosz

