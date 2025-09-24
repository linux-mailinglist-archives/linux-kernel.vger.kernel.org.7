Return-Path: <linux-kernel+bounces-830726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B4DB9A66D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881383A8461
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8611F30C605;
	Wed, 24 Sep 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="a2HYio+i"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C7F30AABE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725517; cv=none; b=n7DPKPHfk6LCUfun68Z4A1EgO2qHs/7HNa9gm3lM4iAHI3O6h5CmPI+pey3Ccr0EC5OrxBZAQvPjIdbt01HlCc5M7jR1L8FtOmqjGWerodSyM6FCXZbfe1M8C/o5At9qqo5juKZCgRlcimSxMMhj7tggKd08oFJZ2cNCR9zd3tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725517; c=relaxed/simple;
	bh=84D0nu1o6zLXy7/rW3cCWSeFHZtjl2QkEFrkBynjieY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CrX0Rd0moNYma0usjJT1q5NqS2LgaIz+unYD/SDh4NziqJKX8nbJWA+vOMSvVhSiWZSNwTpiyfdQlb6xrwYkaDR6WJiZLAk3NAMEGr0aRx6tlehV4cZIyZ42BxG54btGDch9KUcFOFQycs06l4lzpdHjvUiMeDFqvoynHnBszu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=a2HYio+i; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so638759f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758725513; x=1759330313; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q74mWuldAlo64ndeRNS24oI/Ec4V9vS4ecuV71IZKSE=;
        b=a2HYio+iT1LETyOe9TWuQPLsLgj8918AHgxKBUedccgf5IU49jZDMIf+L7+PrxjUe/
         WuBR3Ue6cWUZyHloGr5QPLasm9wWa6Faa69zU36xzPvklwjLSHAoBjGlcZSrAY1k5SHG
         GBF1OaQq4z7P94dqcGFqjLyjdQWG8poelYUp46NAGl+Uubzj9gT4ZzJEKJV+Jx3udytQ
         q0e5V/2/1BcDx8JxnlqaPswU1fIf/cIQfrdbG5yKHTjN49AfSVzpqfk3hX+MZ2QTKy0T
         TI6SdUzHDGzAXL8MX4AtGnXqU4KIU1xNds0VPO0pAhmwtWzjOXoDSk+iGYdzQoCbfYnc
         5DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725513; x=1759330313;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q74mWuldAlo64ndeRNS24oI/Ec4V9vS4ecuV71IZKSE=;
        b=OwsX/n7KnZFimSp4gPOUI5N9C+WQxRxqX1A4nEjYp269RbXnZtCU/VbmCleWY7dB5m
         Am+bM65ghRxLKZ9jhGVChooD7fUpMn2wl7VRnWG2lsY5cd0Q/N26PBC5z/tufHwOyJBi
         AN3wIUMF1FCMxl8v3jJSSuDOSXUx9eny1X5Kytmi2vLoMWHBMlUhY/BNo+XHEgBsygTe
         SpPaq9EOg3epn8bL2kP8oMgAD6r5XNmj8iVC4pz6fnWlQ5AD7BdOzW1JWDr3h6tShEO0
         x4We4G1+VDcl7JrQLy2qZNELK9Dl3oopxbyoj+Ka4wipcPIpwgeI11aJyksDpnJ05IsZ
         GTlw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ8RSWoB9Kqrt1A1c+/e95Ne1GvBWoyHhksx3osYxOKgxovBMfOBl7j13wj2uwu6soG22yHQZXqT5Xxiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCY++VqaZBImGdwmCS3X9u3gOCo4v+i6p3VQIjggpWMfoKdAPZ
	Hm6UIggYnJtE0Ozf30kUN3tyAUq9G6z1RzL1dUdUzBRownkhBvygb/tmHhKAZbglY6E=
X-Gm-Gg: ASbGncuvH0mBX/ANhkbKV1A3XaVliolV4fumWSFraRvTgEB+BPq4aU7X8JIwo9ekAwx
	o1XO8KvN50PV2atJdoJEoJZ9hM1zi13RTL79srgtxJ7oRB+zgeZlyMfLnkzrwCT+a4fjUeTJS/T
	5JdGLM+4bgETKqK4AwPWtv4ZzHlOIyZI4tU3BOjqG8paEhRaq4qTwKxCCSTUxLllkHwQ1p5qjto
	ZTMeRmbpVEI8g2jJteD28v9QftNX9RV8+mWRBdguEFF7txfPRhyObeDqpCQoF2IC7HBz69d+TQl
	0NZxYaYf8Fd3H1hMEMWwIvMyTNVOsK/Q1jxNL5dyUTLpYMDSAb3JwPUR8JOZ3zwqa5mG0TE3IWr
	M7obPGVtI7ALrkrDctg==
X-Google-Smtp-Source: AGHT+IFQeBCV46NXhKbKLlcmg+QGzwkfzCrC+Z1TfxjaOV8Luib9zmG856AySVQTu7v+7Px+UQrdaw==
X-Received: by 2002:a05:6000:310f:b0:3e9:4fe4:2621 with SMTP id ffacd0b85a97d-40abdea7feemr2892437f8f.7.1758725512830;
        Wed, 24 Sep 2025 07:51:52 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:1729:c9b6:7a46:b4a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm29514750f8f.37.2025.09.24.07.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:51:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH RFC 0/9] gpio: improve support for shared GPIOs
Date: Wed, 24 Sep 2025 16:51:28 +0200
Message-Id: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHAF1GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwML3fSCzHzd4ozEotQUXTPz1GRjUyMLC5MkMyWgjoKi1LTMCrBp0Up
 Bbs5KsbW1AO4oTHxiAAAA
X-Change-ID: 20250908-gpio-shared-67ec352884b6
To: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4112;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=84D0nu1o6zLXy7/rW3cCWSeFHZtjl2QkEFrkBynjieY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo1AWFf+k+eImY9E3OI4PtgZTFadj9Fn4NB0Kxg
 s5bwRG+2vSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaNQFhQAKCRARpy6gFHHX
 ctapEACFn/UkK7jIWi7jXPt0E5cF3KVi5VZGT73mQQW43dksQn1fyC2UVMk8XaulHFGwvLw+yZb
 wj4R9fv4Bo6siyXgTWKeyqcU9YM8RNpwLwG0YxHucWJkuiwTrz0H9sppVD8bf/hSinh/XXJlWQN
 41hwSgWEw8weBI+Vf0uFpxVk6dVJ7dnKZdqW3m0l5Xqjod6Mkpwd+vGxfswA4LIT1viIxQQax/3
 fOQ8PacaVQm27KXJyr5zL3qdcwzLR8Gy5WL6sFED2g7RPJTaCDnGiWQTQh/XuKkScJ7U6Nl7fRL
 r5387UfAFhQXv/Ez2UX5FTlRnlLwZuMi3mKu0kZ3u1oAae7VfhaUh6f4RVx0WWhUjyNCgzRiVyy
 y2ZgIpPJWoQPH0m6oozMhINnl+z/Ulc/+s0119GRjmrIaxoqGz1i1elFN0pEojZzEQ8Yq2OF951
 lMh1H61C1bxS6r57/+Wa+NFeY8mboQx1b0hkUGmu5quMUqmunlrJ8NwpjUKxQ7+zyHvAODSefXK
 E/zxac+j4MtxBpwS26bGEfI4dZ/HhLZDy9c66naiSnKICVXDZf+cKKYeZEk8BE1fbddl98YP+13
 zRR6vzGIJe5aPsNExffDFrWtRGZswH8oIdIO23nOkLi/f9W6AEmsc1FVJU66sL6MF4dsBxfSafn
 AqEXD8rwqZdzNUA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Here's a functional RFC for improving the handling of shared GPIOs in
linux.

Problem statement: GPIOs are implemented as a strictly exclusive
resource in the kernel but there are lots of platforms on which single
pin is shared by multiple devices which don't communicate so need some
way of properly sharing access to a GPIO. What we have now is the
GPIOD_FLAGS_BIT_NONEXCLUSIVE flag which was introduced as a hack and
doesn't do any locking or arbitration of access - it literally just hand
the same GPIO descriptor to all interested users.

The proposed solution is composed of three major parts: the high-level,
shared GPIO proxy driver that arbitrates access to the shared pin and
exposes a regular GPIO chip interface to consumers, a low-level shared
GPIOLIB module that scans firmware nodes and creates auxiliary devices
that attach to the proxy driver and finally a set of core GPIOLIB
changes that plug the former into the GPIO lookup path.

The changes are implemented in a way that allows to seamlessly compile
out any code related to sharing GPIOs for systems that don't need it.

The practical use-case for this are the powerdown GPIOs shared by
speakers on Qualcomm db845c platform, however I have also extensively
tested it using gpio-virtuser on arm64 qemu with various DT
configurations.

I'm Cc'ing some people that may help with reviewing/be interested in
this: OF maintainers (because the main target are OF systems initially),
Mark Brown because most users of GPIOD_FLAGS_BIT_NONEXCLUSIVE live
in audio or regulator drivers and one of the goals of this series is
dropping the hand-crafted GPIO enable counting via struct
regulator_enable_gpio in regulator core), Andy and Mika because I'd like
to also cover ACPI (even though I don't know about any ACPI platform that
would need this at the moment, I think it makes sense to make the
solution complete), Dmitry (same thing but for software nodes), Mani
(because you have a somewhat related use-case for the PERST# signal and
I'd like to hear your input on whether this is something you can use or
maybe it needs a separate, implicit gpio-perst driver similar to what
Krzysztof did for reset-gpios) and Greg (because I mentioned this to you
last week in person and I also use the auxiliary bus for the proxy
devices).

First patch in the series is a bugfix targetting stable, I'm surprised
nobody noticed the lockdep splat yet. The second adds a library function
I use in a later patch. All remaining patches implement or use the
shared GPIO support.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (9):
      gpio: wcd934x: mark the GPIO controller as sleeping
      string: provide strends()
      gpiolib: define GPIOD_FLAG_SHARED
      gpiolib: implement low-level, shared GPIO support
      gpio: shared-proxy: implement the shared GPIO proxy driver
      gpiolib: support shared GPIOs in core subsystem code
      arm64: select HAVE_SHARED_GPIOS for ARCH_QCOM
      ASoC: wsa881x: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE flag from GPIO lookup
      ASoC: wsa883x: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE flag from GPIO lookup

 arch/arm64/Kconfig.platforms     |   1 +
 drivers/gpio/Kconfig             |  17 ++
 drivers/gpio/Makefile            |   2 +
 drivers/gpio/gpio-shared-proxy.c | 328 ++++++++++++++++++++++++++
 drivers/gpio/gpio-wcd934x.c      |   2 +-
 drivers/gpio/gpiolib-shared.c    | 481 +++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib-shared.h    |  71 ++++++
 drivers/gpio/gpiolib.c           |  50 +++-
 drivers/gpio/gpiolib.h           |   1 +
 include/linux/string.h           |   2 +
 lib/string.c                     |  19 ++
 lib/tests/string_kunit.c         |  13 ++
 sound/soc/codecs/wsa881x.c       |   3 +-
 sound/soc/codecs/wsa883x.c       |   7 +-
 14 files changed, 980 insertions(+), 17 deletions(-)
---
base-commit: b46f7370d4a0f0b55f05b854e73b2a90dff41e1b
change-id: 20250908-gpio-shared-67ec352884b6

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


