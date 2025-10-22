Return-Path: <linux-kernel+bounces-865054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B9FBFC240
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9368566F32
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63792347BC2;
	Wed, 22 Oct 2025 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="i1FCsYHM"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5180A34679D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138660; cv=none; b=Zi6fTA6kuxrc8C1nw0Src4oZEnXoOiDC8RiU5KmvWrqsDS5/x6awAy7s01af3u//Zc50hpAaz/4gJcGe1OCwSyjOLOQuoQQ0+OLNMCzb/lb37q2CkFBVrWHXAbq6g/GPk0AZM69Q6YyaKV1vmJUFyq8xPLPsUeEvw5ZEJE/uY9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138660; c=relaxed/simple;
	bh=ahWl67TQ9XpBLPshdCkjxixfaIbnhlzVC6EeMq2/mus=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QhS0P2soFabVgRDa2T5rjfGAKu01ZAnyp9tJ6/NBmN36PG4xTY4wxL+9Hrr4BvTxMkz3VSJ5i8woWHeToY6Sy3SQYeeUIPtYGptqapnZo/ZdEsvQW6sbxqd1hrcR1FGGoJi8hmoQ9IM2QUtgzCAO33EwTBqiOVfyvwTIZXdasXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=i1FCsYHM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47118259fd8so43224925e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761138657; x=1761743457; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QXbhE5WpAHG+UuY9oJTJMeHQhbXeGIA/P16dT2l+d0=;
        b=i1FCsYHMdPJD7bStbNA/0d7P1MRbi/6RiPJRcSUSBHOhw5yWJKTleIj3hLncOPzHHB
         FFr8QRYSTy0tciL+Uy0yhc5F0VwqmQ7sjj6LK1Zps8VdESH47efdtrF1ivBmiePwe5uT
         35vs2olm3OTTCnk0CQRSXfpvi4FJ37IBejmY4cryCJ7U8fMFTOKuqK1qjYwXz33XCkIF
         9iV7fAMwG8F0sv1dxwhCUWci3aX3QirchtHIDfc37sOAy6Uo1iofmAK21oC5EOdH7ZXo
         fYbRJ+wiUmf8uIdd6c9czkvt/b9v0KvCGtUU6sOFhymw3084wA3LMST4d1ITxHteZ0md
         q2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138657; x=1761743457;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QXbhE5WpAHG+UuY9oJTJMeHQhbXeGIA/P16dT2l+d0=;
        b=IZGWL8T8WLwbJh/Bs5SZieLUWzDwN1kjgmA5hauf9DL9qqY2QmTSKr0WNOyO19XDFO
         SmIApZsSeDeNnLlxdTZc5l55VlHf4dtavmpIIG0Zxb+jMo2SNLm73ZCzwpMLROjA5XL7
         wVn0ZoqgHyL9IzV/8n95Hh+rdLSbY7JDHaZxWClrZhlI0U8aY6A8oV3iWaVAKxawIn2E
         RYsZzSqHnH/x/QPE30+Dc/rFczgr6IzQ/88p6a1+atDmretelhILCHB4ef2FXIOmncwD
         AR+ogXlhDp00Pq/QUxc4A82sE1b10p1N/Qhc0Lp0SlZ3jC7WqqdciOUqgNGkOlPC+fqg
         JVQg==
X-Forwarded-Encrypted: i=1; AJvYcCVxAte+LT8wSrq3tGxaqN0P8aEiZAP4XyRPag7u0chzgI472AlDLmP51W+FD3990/46ejZeMh5nN6Ek+Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd5fsHz1jCbgP4DXBU8BuH/mGpSLTTAqSv3Yw34j5t1JLHM2uR
	t70F+ViBGNSn4h/HG2n64KgtZ2irN5WoujQUtSg9f3909J8RhoqLMTSM1FqYeYY6klI=
X-Gm-Gg: ASbGnctnJTHORP93XqE0ndJXUJkKbQ3/9isxeMDujT/pOim0e3y2rNV+HkqzzlOBfyq
	zd6k1Ss8Y5c9AtT9TFQMkGlRrw0fvx23x8xLVfK90S4NR2cSoV/DcujouZtX/KAoocJON9o3An7
	cjT5NzmAYoKYJAqFGkiTATHcy18I49IOjS2bzVbp7aOb5CmFzjgJvxWzrZm4lUx0zoxCKQNL5cP
	gkNnirhZrA49rYiXvpuYs9v+yQgMGRU4HimH7aSEkS1hROlJHZpde7Eyf6ZItRUTXLsfQ1ykIQQ
	qBY2S3y3bCrtKMBPw8kzo68PIdFtpAzJtvelJfJVcopfJpxQYoL5B4TxSKTSE2gsruPpT1fGNg9
	1LgVobRAw10tPWDqESIqXmQY2i1IWV8zttGw4hHOxSkfyVRJrWqMV0JIN7d3f9zRTYCnKZiWhmA
	41g9FxrA==
X-Google-Smtp-Source: AGHT+IFdFKFen7tV5F5VONCvLyYsh80AvPduy1QT8kUGqdlbVQ4K9dlnnT93BxJMM7KKevL6B+Uz8g==
X-Received: by 2002:a05:600c:3e8f:b0:46f:a95d:e9e7 with SMTP id 5b1f17b1804b1-471177ab11dmr157009085e9.0.1761138656539;
        Wed, 22 Oct 2025 06:10:56 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm38839905e9.1.2025.10.22.06.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:10:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 00/10] gpio: improve support for shared GPIOs
Date: Wed, 22 Oct 2025 15:10:39 +0200
Message-Id: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM/X+GgC/1XMywrCMBCF4VcpszaSppdEV76HdJG202RAmjKRo
 JS8u7G4cfkfON8OEZkwwrXagTFRpLCWUKcKJm9Xh4Lm0qCk6uRFGuE2CiJ6yziLXuPUdMqYduy
 hPDbGhV6Hdh9Ke4rPwO8DT/V3/Tmq/XNSLaTQukONC461bW4PWi2Hc2AHQ875A3Ok0EWnAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4494;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ahWl67TQ9XpBLPshdCkjxixfaIbnhlzVC6EeMq2/mus=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo+NfYNqmF4drtJq0Z6oJq+JwZ4haDxyCaNcoG9
 hkxD7YiG8yJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPjX2AAKCRARpy6gFHHX
 cpjtD/4/vho3ipov3Dx5Y/4GxVEafxt6SamY2SVevdOPyKVbKtxd61VbE+zPenLYIVbaV1oj+eL
 ynoWZ+1NQBqGrvwkHD7glUlhTbHSgEpgwGGhw7nyG83I1fRy5dPF6nvsx5MpJfkKlxFslMi59nU
 b/GmBNPzvOXSiNMXZpUgWHQY/ZuPYiRIEGbHh2iTaN4aY8oCiA8iKmM44xm724yXXZOeaej3uJB
 rjH92H+R5jtpHfhWIfzUoRtfNTa9GFdNzjNyrAXstJZchwwPpdAGZ6tIeyGh6imd7jBVBHXvley
 RcyU0+zJ+pbXAGmZEYdZVetTIOA0w1ieMwyp6XSlmVcr6u+B0fwf+rZVDNFPfcr7iIcF0b/0GJY
 CnYRooG9rhhd5kq4/nXV1XFXT6SL5to2XrEpRMwvIQyoEIvFuCUEnj5js8aknvhlj6MQ48vrhdp
 ctTQ55YFo4DV1UuWTJWvWwRWGW7KqewirICWUaJElWOYyCkD7ciyoAZnmULnrK1xBQ/4uLT+kQt
 RW1l3pssUgaQ9HCLaIxbXV7SpPYeQrczIHh2g1VIDCl4yZ6gLwlMP5O6NQkBAcd+cAwfw0IOaxB
 BFHd9m/paQktx4JHi5buXXAmR9fAarg0cDzF++xhOakTscMp1cR3toj0sGqdcNXVf1HYG8yF5/N
 60fFoddfTjDxa+w==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

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

Merging strategy: patches 1-6 should go through the GPIO tree and then
ARM-SoC, ASoC and regulator trees can pull these changes from an
immutable branch and apply the remaining patches.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- Fix a memory leak in error path in gpiolib-shared
- Drop the gpio-wcd934x fix that already went upstream
- Free resources used during scanning by GPIOs that turned out to be
  unique
- Rework the OF property scanning
- Add patches making the regulator subsystem aware of shared GPIOs
  managed by GPIOLIB
- Link to v1: https://lore.kernel.org/r/20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org

---
Bartosz Golaszewski (10):
      string: provide strends()
      gpiolib: define GPIOD_FLAG_SHARED
      gpiolib: implement low-level, shared GPIO support
      gpio: shared-proxy: implement the shared GPIO proxy driver
      gpiolib: support shared GPIOs in core subsystem code
      gpio: provide gpiod_is_shared()
      arm64: select HAVE_SHARED_GPIOS for ARCH_QCOM
      ASoC: wsa881x: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE flag from GPIO lookup
      ASoC: wsa883x: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE flag from GPIO lookup
      regulator: make the subsystem aware of shared GPIOs

 arch/arm64/Kconfig.platforms     |   1 +
 drivers/gpio/Kconfig             |  17 ++
 drivers/gpio/Makefile            |   2 +
 drivers/gpio/gpio-shared-proxy.c | 329 ++++++++++++++++++++++++
 drivers/gpio/gpiolib-shared.c    | 530 +++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib-shared.h    |  71 ++++++
 drivers/gpio/gpiolib.c           |  70 +++++-
 drivers/gpio/gpiolib.h           |   2 +
 drivers/regulator/core.c         |   8 +
 include/linux/gpio/consumer.h    |   9 +
 include/linux/string.h           |   2 +
 lib/string.c                     |  19 ++
 lib/tests/string_kunit.c         |  13 +
 sound/soc/codecs/wsa881x.c       |   3 +-
 sound/soc/codecs/wsa883x.c       |   7 +-
 15 files changed, 1067 insertions(+), 16 deletions(-)
---
base-commit: 304d18863e6e62a8f2d0350ce0a59596e2e42768
change-id: 20250908-gpio-shared-67ec352884b6

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


