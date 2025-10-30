Return-Path: <linux-kernel+bounces-878076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A39C1FB6D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AEC74E9492
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91F6285CA7;
	Thu, 30 Oct 2025 11:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="q+BhJWHT"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1CE330313
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822557; cv=none; b=aSAooQGlUa6sjjL/C1cQABk2AeSDnzi5GdD9MWQHnoetdRkAQollEouQGOgG0m6JqJmlbCl7GS4Rgl8cnNSIL20ZV1CT6k9wOZEJ58NowU3TXP9ByRSqphubd2zqiY9SBHnMkx3BdDbWneE3P95p4mB2gH/72jsQCeW5zhcCu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822557; c=relaxed/simple;
	bh=lspB7RW7m6TpdktIGZC3YX0kjoD9OZFXwC0IzO50tGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFGLDPib2W1uOzSHHwqftKaU42CVX9yiLBVc33fFQQeVFXayD9v8XgTQRWCbjI8I0hQcYEPrxBVFJNqU0cBc61PObv93PRwJ1SngwKc5UfqduQor42liyHVJHEikbmKLv0/p+R2/YuRsnbPXAcHm7bvoF0lISmqj+sf8BQt8tkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=q+BhJWHT; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d6014810fso10769397b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 04:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1761822554; x=1762427354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DJFGmdbrbXbI5goBpoJRAMd0no0Sakj9t3g1Y9OJXDo=;
        b=q+BhJWHTwmgN3+sf2/+aDh1+VX/39KY6h5wYi1dWRu2WSyLq3RUYKZ5mYKx3M6f92l
         QWDiHP7lZHWZvaa0pgYC/KPm0y74/+dXiKQN2iRP9fXCEZHOHTRXpbsB+6rWShVpcLQm
         MLY5M1gwaP0kBlmG1SlC2LosPuigcSmgPGmjqSsIKz5P6NusMBICEnPrYU/tC2ItIeL5
         QWuCa91aAYxWmeCYTdDWAGgpCL+kvJUfCcjf5nccG/YFMxGS7yLHZZf1iUTjUO+MvBn6
         2pY9FeGjSaoyc4Lu9Gto8iJDjAwUm2bMAWr1KPBPWuMCV9FqaO6hLrRb3q3SN5PQWPq/
         hTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761822554; x=1762427354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJFGmdbrbXbI5goBpoJRAMd0no0Sakj9t3g1Y9OJXDo=;
        b=bk9ZplMh7ZwxJwbIatl96jgVM/23MdqYK17NAlVw+1xifGzQ/Aizc6ENLzWaQVVYln
         clxEjTim8q0Cecpmjhu/iXKFMxIZ2gON5YXSWea13VWhq8I/SA14cx3aqkYEajfYRUor
         keJcsUUnJsDvlpwDXqT1SuY+vyfzK9Q0g0I7r37fv6Icjfod+ofyfIimKqCJI9HVTZeS
         8KR3B16aASAZW7y5Gu7XsbbhPld87gMb/xN3OI++4nmr9XCORDPqWc8ocZ33tNLwGviN
         hNbll94BojPci3AuDvhDZA0JafUvVH+Nm4/hDn7TXvgkfuaGiBhOX0ZUlZltfJjry1TL
         LsGA==
X-Forwarded-Encrypted: i=1; AJvYcCVqELdOWBpT44EIuFz9TdpUKoGFCURNXnqyI8HR5ECebjGQEsvVYoMhGIy1ycH7EXCjculi6xlNtXFutBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0rCTkQaoQ/424uFgFbO4HnWo4envZi5GRSG8/Dk6y30tglMUV
	WV32+oFAc82HG9IT4joOV26pQvdwGTWhLC3jabnzspgBp8Wf0SXtVU60czhE4tJQZjGRtRPIxRE
	IIhWz3903DdR+dR6lz3q3tW0W2kByc+GGaEVEUGoTkg==
X-Gm-Gg: ASbGncvl3QSnGSDhVpZ/RRfdDJpdLU6bE3kFFYJv/cW3+a6GoW0S2Te9yQiZhfs/ukc
	h51vwravNcDUmMy5xe+i6zdFD/A+sv/oaE9lI6l/H5lbQQ5eXz+P+Q5c0Cws6RzmnWFmYUamYro
	rFWfZ94/XylI6Qqe2QARO4D4GyMx8mLY3WaByPt74Pj50sV9WubUSgdpGLBhRtIV2zFC/4go3AY
	Qp18mNqbq1fss5mbUmHSPbOayPNEQ3BqqI+EgR6oH4Ew934kwgceI7ran2beCu9ER3R2SslqT54
	9T0ZIXk/8nENpgLfBaRONwejBw==
X-Google-Smtp-Source: AGHT+IFuTMLOTolcz1ih1tX8KQ/LGSjNE0neUSn4nBbaiWoYmL8ZYnKwIkXkaBP7j6uiitZ9AoUgXfcE4Z6vd/RKjbU=
X-Received: by 2002:a05:690c:490b:b0:786:1e02:632e with SMTP id
 00721157ae682-78628eaa1dfmr59219877b3.29.1761822553795; Thu, 30 Oct 2025
 04:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027132219.2f3274f0@endymion>
In-Reply-To: <20251027132219.2f3274f0@endymion>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 30 Oct 2025 11:09:00 +0000
X-Gm-Features: AWmQ_blem8KraUcOmb8_BdMvNigDn4Fgv4zcI-uxi-ucBdNZFXDsqb83RrFBtb0
Message-ID: <CAPY8ntCTuTBU9PRkt-ja540ir+0HUZCuYvPpFgKhWpFsOvM8Ww@mail.gmail.com>
Subject: Re: [PATCH] regulator: Let raspberrypi drivers depend on ARM
To: Jean Delvare <jdelvare@suse.de>
Cc: Marek Vasut <marex@denx.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jean

Sorry I was out of the office for a few days.

On Mon, 27 Oct 2025 at 12:22, Jean Delvare <jdelvare@suse.de> wrote:
>
> The Raspberry Pi drivers aren't useful on other architectures, so
> only offer them on ARM and ARM64, except for build testing purposes.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> ---
> Marek, Dave, would you be OK with that change?

These regulator drivers are for a MIPI DSI display, so they can work
with any platform that has a DSI interface. Currently that is mainly
ARM/ARM64 SoC, but there's nothing stopping RISC-V or x86 having a DSI
interface.

Checking and [1] says the Intel Alder Lake 12th gen processors support
DSI, although presumably that would also then need ACPI support in the
driver.
[2] says the OrangePi RV2 is a RISC-V board with DSI interface, and
there is at least basic support for the board in mainline, although
not obviously the DSI block.

Personally I see little point in reducing the scope to just ARM/ARM64
as it may well need to be extended again. What's your reasoning for
saying they aren't useful on other architectures?

  Dave

[1] https://edc.intel.com/content/www/us/en/design/ipla/software-development-platforms/client/platforms/alder-lake-desktop/12th-generation-intel-core-processors-datasheet-volume-1-of-2/010/mipi-dsi/
[2] http://www.orangepi.org/orangepiwiki/index.php/Orange_Pi_RV2

>  drivers/regulator/Kconfig |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- linux-6.17.orig/drivers/regulator/Kconfig
> +++ linux-6.17/drivers/regulator/Kconfig
> @@ -1144,6 +1144,7 @@ config REGULATOR_RAA215300
>
>  config REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY
>         tristate "Raspberry Pi 7-inch touchscreen panel ATTINY regulator"
> +       depends on ARM || ARM64 || COMPILE_TEST
>         depends on BACKLIGHT_CLASS_DEVICE
>         depends on I2C
>         depends on OF_GPIO
> @@ -1155,6 +1156,7 @@ config REGULATOR_RASPBERRYPI_TOUCHSCREEN
>
>  config REGULATOR_RASPBERRYPI_TOUCHSCREEN_V2
>         tristate "Raspberry Pi 7-inch touchscreen panel V2 regulator"
> +       depends on ARM || ARM64 || COMPILE_TEST
>         depends on GPIOLIB
>         depends on I2C && OF
>         select GPIO_REGMAP
>
>
> --
> Jean Delvare
> SUSE L3 Support

