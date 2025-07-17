Return-Path: <linux-kernel+bounces-735365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A2BB08E51
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD661C2439F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3833B2EBBA8;
	Thu, 17 Jul 2025 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LXDpy/LE"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3512B2EB5D1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759141; cv=none; b=WZWQxTkN4jhCAnesADGmV9ohB7D7TMIoJdHfHZNZp7gb3G003FOa9wx4jgtY5NbMs6/R3QuYf4idWcvdwUTVMWWfUnidZN+UH/5quJcnXlvGMiFqaO+pKUFV8wPsBtd+Yt09RrZNUvp2kDJNwppEcODtJjvySJpyGOmPvhdNiTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759141; c=relaxed/simple;
	bh=2COzNJUWK6NXKJgnzIL/4QytxebvWRPGY869OILBGjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAHRJhoPhmKGtJZi4Ts6CtEetA4XrAX+fdydb5eCzHOh8XZJtrX6/JtjgXZ4tY9xWAfOwl6TydlX0HhryeoTHSNCwRFAeq/LM4Dz1yU4hVBeRLfQZp1Da5tmDfBh9j9jCAdUze8X0W2Ff52hHmnHlYBrifpaxHdQBrJi3DAiMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LXDpy/LE; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55622414cf4so852913e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752759138; x=1753363938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2COzNJUWK6NXKJgnzIL/4QytxebvWRPGY869OILBGjY=;
        b=LXDpy/LERUFh3Xk4yKB3u/Iz1UtuBdMT+wopaYy38B5vdJq1f4E6+LQvBXU6T0nl+G
         EuoUzm7J5lDYqxOCgJpGNWwP981X7W//UqvakFGVDp5zKKYYPPa4r0tt9pxNu5YQ9WvR
         ZaHZiMxFNr8KHdfOMoUEejxaOdjMQ4RYwosBn66xKAw8dCkXDFmDtEugtYNJNMJGBp4k
         xeJlYep6yiEg2crJKhEN37rlotOn+CmB69GpBzltg97ZZQXJY+wgns2y1X0sDz/fIwtv
         BuhBX56dbkWh/znZKeat9PouaXOswRJqFGsjdHGu3IHtyaUQm86ERJk8cNRYhLrvfHG5
         jhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752759138; x=1753363938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2COzNJUWK6NXKJgnzIL/4QytxebvWRPGY869OILBGjY=;
        b=vkxe4BCIMLENrn//h+/FtkC/xy3DOeWywCg0EDLnknoX2vEcoXQdENtL45PqwtDL4R
         4bP+smPXm3rVoDVAWCLG5tQFf0eCdXu1BLCmXaBVWx+FQ/02kGUqlYrlTWEE+P8y5vgo
         2InTigHVN902Js5snGyWE/nEdba9POQDk2U6Uku6DrEEz/P5pCixgaRktYMat2ftvYAV
         m6naRJmYAP4tjhciYtVfD1wScS1r8QdCD5kKZ6S5XTGw5e+gkbMFmemkjAY6jUqWwQjx
         w4Fb/3oyxpTlOiBWjivqD9S4t7090pUYmVucxjfrIp20zB7L1qaO8YT674ijov4DbdAs
         0IAQ==
X-Gm-Message-State: AOJu0Yz3Fjwssq9LW0k13fN7uHX5u6/7isr6WwYeUKZ9glV8pBqI8dfN
	PATZks+CKS9keKOdodYzsxfguOI0JiCk2ThF0CbvMCk0uO/2VnJBsrzrySRqy6YLWC8cj+2j3wm
	21E7REEgSzL6PEEo502DLHcaQ2mnnsriTPg/TULTZ1w==
X-Gm-Gg: ASbGncvGVZZmWF6SN3xE/mP+EcDlg4W/GbpeNP0th3Q7paiR+lmPegqk6j9MXLLzz0l
	6/7WNzwk3hq5nFD0rWE+U7gHod4xb6bleK6NnN9Amlrldv/WxNaKer3pTTMBDmH/k9j8LuVNRlr
	/hV9/mA6rhrPqrgjllAJ+8mfTfngLi5CEsThe2KniXpQ92y9d0Lf3Abe4TiuftvFUxc7QuMirlD
	WNIPMPiSjiMacQmXcv8BPi3hRrNgcpP3TydQ+A=
X-Google-Smtp-Source: AGHT+IHT3PtD6npdrbFrtvXjL0dHEAYy2QX261hi82tHR+AHdc/G9o8TJQapTwo0gQJBJob1bFp1eZmVKThdFoqXeBs=
X-Received: by 2002:a05:6512:32c6:b0:553:3770:c91d with SMTP id
 2adb3069b0e04-55a23300188mr2624433e87.4.1752759138065; Thu, 17 Jul 2025
 06:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717130357.53491-1-brgl@bgdev.pl> <20250717130357.53491-2-brgl@bgdev.pl>
In-Reply-To: <20250717130357.53491-2-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Jul 2025 15:32:07 +0200
X-Gm-Features: Ac12FXzS1YV0ZsodWalyOcb9bv61iHiIR9_cWAuIM6ifnXF6pwzJ_JHOc34xXDo
Message-ID: <CAMRc=MeMyocMa6eCOw--uBic4Zk9OG9A=VKvMP+T6bnEuOttng@mail.gmail.com>
Subject: Re: [PATCH 2/2] misc: ti-fpc202: use new GPIO line value setter callbacks
To: Romain Gantois <romain.gantois@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 3:04=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Greg: this patch comes in late into the cycle but the driver in
question got merged for v6.16-rc1 despite the set() callback in struct
gpio_chip being already deprecated and it went below my radar. This is
one of the few remaining conversions and if we get it queued for
v6.17, we'll be able to complete it next release and drop legacy
callbacks. I know you're busy so if you could Ack it (and I hope I can
get a review from Romain and Linus), I'm more than happy to take it
through the GPIO tree to speed up the process.

Thanks,
Bartosz

