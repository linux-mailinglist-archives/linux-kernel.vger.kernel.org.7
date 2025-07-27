Return-Path: <linux-kernel+bounces-747008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13D5B12E91
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 10:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6763A730D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 08:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC651E1C36;
	Sun, 27 Jul 2025 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Q5rJ4rmT"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6292148850
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753604839; cv=none; b=Afnsfpd2ebGWkz7NFpD9/Rz2AUeIZVD0wwJ11X1amzfhSAxZ+W3Xgaj8dJ4umnzCa2ebPwSrlWI6v57410Skcb8sLcj35FyyDXwFArZyVaI6c77erk4R5Tx56ilRGjKp7V0pel2ElujetauLujARPTzjkEXCwW62xoShKyChr/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753604839; c=relaxed/simple;
	bh=2yW6F0SuaePRX+XJnoLUrfzD8GqWoKdPySZUHNTjfzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRr+Bw/+OubRMniUbG1ar4j6oXA4HCN6RfYDpiVpuZIWWa8p5QVdWRfBe5yoXc3y0mSs2MRIBvB0OMAS/qIc0UvXX/wlSjBI3PfPBNdMrgJhCaywu8tM+YgcuRMO04Tmrnv+zuRiPu9aD+bXNlLdwYOehkjJo2vgHq1WDEiUKvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Q5rJ4rmT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b77673fd78so1351565f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753604835; x=1754209635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TW3xho10EIPnvZ4KYenh6Yy4Fz3bJ4mpd7+jKQ1KV1E=;
        b=Q5rJ4rmT2fLMQ8nZy2i1JKN6KvOJxR0emFtxpONzjkuUxbgC5o6+eYzLNyVnxhl9YR
         uKPBb4n6RAjqAxC5r0HLTHiWu7uGr9qSdRiCgXMFYj5sKmf641+W6hQfROGakC5lmq8f
         2feChzwZrd69OvxbzFsq/8wW1xuoGMim1Axj7y4H65BGI8Eg6RmFkrbbSN1e4CwO291V
         RPtekujJCwr0IVZAdcuo64Il75IsCbi0id6ASbhf2znEDNB859zVmGDItb8NVfFXMOcc
         5VNGU3jD/4g0qCAlCbKAGteT3CCu0ZzvpZ6ojIqV3G95pfNz6mDGwUo8MPUvjDysJ2GA
         ST+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753604835; x=1754209635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TW3xho10EIPnvZ4KYenh6Yy4Fz3bJ4mpd7+jKQ1KV1E=;
        b=cyhCID5Vh4By78wURvBkwlCPPgMilj59aDAWGkblb8/PmSaRmPpw59MNEN+PTThYQI
         UNQpe9WR3X37rlRzR1vUfzoUl6L/DEilsHNRXx/j9U+NV2Ye+P0ugd4o+pry47J5I4Ym
         04eOnPKoy/2/f6x/y5B8ly2Jbht62P5T18cgXbDMRm0EVVJOB9HZ72jEt61evJLkXJvQ
         7quGaRMOWLJqd69sZjFC9hxyIi1wJCrbLp9iClmTJ7xHy1BNcjIjrA0gLoohBWhsrTdg
         sc2jx3THObONDI8Dp/10h3P6I2PJcfNPsFAW8ZWKX0sH4xHfgtnz02qoyFbFsFeFv78x
         J7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtI0DILEbCOxrGDvghJImxr6rXU5Lv5ww+16j1FOYICoX7MrWXy3wTv28hbJYfIuY/5Z24qOYPcSRhEOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfZPM8irXrJ+/GLNIll20z/Q5MPyYjPmKjTiuJbab5KE+Li+iG
	FySpxozQiDd5aThzlYKQxgbYHMu6Bs96YADSGsBnB5tszgMVO2Z4HU3Su//vggyXacc=
X-Gm-Gg: ASbGncs+iN3n1EgupW5oA/JsYelgglXRBI+EOb1Eg2ul6/sZ+dq23hNphn1NU2A+F8v
	+XVa27p8+IvOZaJRQjwsOpIYtsZFish+MaUYTFfPVqZldakYqyDi2ZnVtpWUhz0fL5minA4pLmQ
	HAzv/I36TOISWc3xsaFC9UUHgLlVE2yli6yLqao1JLFm0odTL73Vb/fuV6XTqBaEqCa+39ngpmw
	NAXiP3m6iRpCOrDIeaSX9HWEAJZZkt7u5QpVdvOhmdgKHQMw7FhYAnJe5xNRckejfPfXcw+9wU6
	JhiCC8KsojUvUXMX6TPnUIK6D5Wm/qZR612TlYkTYXRwAJBzXtptxQxhXLs15eH6zzqxQGvZUaZ
	RvBhn4UtHfI+59mmtQn36
X-Google-Smtp-Source: AGHT+IGDSjDWcXxGHw4HEIXALzynIM5/MFW46g3P5oBEHhtKwI65MmFJo31QX3dQsgxN+1sbjU401g==
X-Received: by 2002:a05:6000:4410:b0:3b7:7870:125a with SMTP id ffacd0b85a97d-3b778701569mr2899660f8f.43.1753604834943;
        Sun, 27 Jul 2025 01:27:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7619:fb4:5db:aeb8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587abc2ccesm54245945e9.3.2025.07.27.01.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 01:27:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Arnd Bergmann <arnd@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel test robot <lkp@intel.com>,
	Peng Fan <peng.fan@nxp.com>,
	Koichiro Den <koichiro.den@canonical.com>,
	Lee Jones <lee@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Yixun Lan <dlan@gentoo.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: enable CONFIG_GPIOLIB_LEGACY even for !GPIOLIB
Date: Sun, 27 Jul 2025 10:27:11 +0200
Message-ID: <175360482875.14160.11906905197800681738.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250726211053.2226857-1-arnd@kernel.org>
References: <20250726211053.2226857-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Sat, 26 Jul 2025 23:10:43 +0200, Arnd Bergmann wrote:
> A few drivers that use the legacy GPIOLIB interfaces can be enabled
> even when GPIOLIB is disabled entirely. With my previous patch this
> now causes build failures like:
> 
>    drivers/nfc/s3fwrn5/uart.c: In function 's3fwrn82_uart_parse_dt':
>         drivers/nfc/s3fwrn5/uart.c:100:14: error: implicit declaration of function 'gpio_is_valid'; did you mean 'uuid_is_valid'? [-Werror=implicit-function-declaration]
> 
> [...]

Applied, thanks!

[1/1] gpiolib: enable CONFIG_GPIOLIB_LEGACY even for !GPIOLIB
      https://git.kernel.org/brgl/linux/c/a86240a37d43fc22b4e4953242fca8d90df2c555

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

