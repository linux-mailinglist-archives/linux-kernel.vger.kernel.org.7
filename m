Return-Path: <linux-kernel+bounces-875859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AE8C19F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB0D426762
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B2532ED5B;
	Wed, 29 Oct 2025 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="d/6wY/Zy"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B831E0E1
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736862; cv=none; b=hVYlnHBdit35hONynFVGI6jDahDge89W3BANW7YK8H8STWX89WQbxPu57DKrt8uXMXEwM0RHjS3I/1BbCOzZ6c1A0yCM+1p8wAW9Eu7Ml705y+8mmXal0xWhz/Pu/1rweYG5YIEP4M4zbQz8fSguHBWEVfaSJwtBPHHDOp3iAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736862; c=relaxed/simple;
	bh=bgbw2Ft4/u1XwJQBHfFlQ3MV2AqD0Imvh5HsmytZj4c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TEp3km2uNbEiSoYLfHHJRv2Xu896fZbCtUGmJQD2HlQt/0naWk7H5uL0WsrAzOVVz6HnqfDAOKorUeF12oj1SrKZjP92MkZmtU2WhYOzUFLO55+m9aETM9wxk1CijlI8K15YDeC5Ha/9715ycpdAjB7RU3Z5bLYlew8yosFyH84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=d/6wY/Zy; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4298b49f103so2523510f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761736857; x=1762341657; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=drLJ70XtGpDzIlyNv3z+1we52syz/zd9JPxUjCCEh6E=;
        b=d/6wY/Zy7IzTe6QzrRPVbRXNrwryBdOWGVJTcm03U//Qj9jLEzgBAoUABXsGtblrQ4
         mm128tqQbBx8+sqCYmHNoxLgOvBkWJD32O//cbaHkg0KTgzVFe67iEFcjl4MquxGNERV
         qkNlzFUPGSSqmkcxuLcgA4GKvEHghycAzlcskNS51Oyzqn5kEKVLOctMvPZn4AkG6u3A
         gxVIvAOY6dqanOUBpOphlOvZi6tJn9RmMDVKlD0i/wFoPLoK4pQiYKonHl6YJvV2NDiE
         cgu0NLX/8kvxGLMkTilNQvRWZNB1cCL1iAIDD7UKCkRw36INL/RoCddJY18toyulNjRm
         EHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736857; x=1762341657;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=drLJ70XtGpDzIlyNv3z+1we52syz/zd9JPxUjCCEh6E=;
        b=LQd6tPhu7AF/8L41Wv194HTSzR81HT4Jg09zH7n5fiIF7mujRrZHBRCu6K3bbeS2Av
         RfQB8FUHtqo300bCDlKb9d20ycrm9h5Zkl93iKtTBhccmWa8QSkjkcdTyF/AZTA4ziGh
         /NS5WJNwVFKW5A7nAWZEOU/6pnNbqyrfHlQBZ02wUMVWYNA6R/wJ3JpCOA5Dmlmgp0v8
         RsJ8q+UabJqY3eUh6dYABjiO1h1Lg1bH5ez22TBRKLnWBfhEbx2KLyGNYshqMuSmp7B2
         79HY/Dq53Av44xeuZqVR5EYFztSnj2AMerJOMvUWY0nsKBsZ5LfzFRlAf/lA/vL+n2BP
         vI5w==
X-Forwarded-Encrypted: i=1; AJvYcCU42xD7Zkntb6qoXB4GjJn9SIo0mkqkNYBSkb9j95Bd6VIepZWR2GJZhcwpHhzEy7oF03bwnaeF80ncVHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkojJdhkw20dyisyZJLevgbJOfYYqX77r6fNTEXwv2vIdAhKC6
	xaF6kkDuCy1kwET4gsZnqv4JNiAtKhRtEikpeRNCSYsurwxjtG2kPh+bg6NaIu490/A=
X-Gm-Gg: ASbGncu95ipe5diIBLRjoOmjOqpR0zOAT1AHoE0mjCriCrmvt/vFpzADxgVBHDcMUkU
	VFS9U6Pexph4e9VulxZS/6ref25Ign+xhtyuOrQnB7Qm7rKF+1tadYLI/n0T09bxCq14lD4yRuc
	m828m6duhtKPMpzTiCWG9TZNj6cf0r7fv7QzQzkHgihIJcoTwlLvxRDTNDtVD3mBiBRQWtw3w6U
	JYneFTqRdGLUSYoybfeoyWP4Ylj4I0hgqRtcziAMHAZfq++/HV294nViZ8GrRaPkXaycB5+er/b
	Bqecu9XVI3fVfu4Vi/aox57UIGpUvLShh+z0lBbdkL98/5o7n5mPaKWiAaiqXPE6cltKckpCH64
	H/j6a6kFSg23YxApMhy2JszjoG73M6Vf+7LtgmM4onLQqFcXqRZcXgiAy0pbOWi07WH1m0Q==
X-Google-Smtp-Source: AGHT+IHJ6rI2i+ynX6AlOMcC1L9DubGba4dH9C14YMhZnd+DNhMtpSBjmYNVey1S91mBt/C7vXaflQ==
X-Received: by 2002:a05:6000:1ace:b0:427:9d7:86f9 with SMTP id ffacd0b85a97d-429aefca833mr1978121f8f.47.1761736857377;
        Wed, 29 Oct 2025 04:20:57 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df682sm25657486f8f.43.2025.10.29.04.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:20:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 00/10] gpio: improve support for shared GPIOs
Date: Wed, 29 Oct 2025 12:20:36 +0100
Message-Id: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIT4AWkC/1XM0QqDIBTG8VcJr+fQY2Xb1d5j7ELzWAdGhg7Zi
 N59FmPQ5ffB/7ewhJEwsWu1sIiZEoWpDHWqWD+aaUBOrmwGAhpxER0fZgo8jSai463GXjXQdbV
 tWSnmiJ7eu3Z/lD1SeoX42fEst/fnQH1wsuSCa92gRo9WGnV70mRiOIc4sA3K8I+lADjGUGKna
 mOkt86L9hCv6/oFjFofyOQAAAA=
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
 Takashi Iwai <tiwai@suse.com>, Alexey Klimov <alexey.klimov@linaro.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4883;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=bgbw2Ft4/u1XwJQBHfFlQ3MV2AqD0Imvh5HsmytZj4c=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAfiO0lKX2uiEhxK9yUquvK25+YyEc4xHnn5Di
 6uUrJIyD/uJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQH4jgAKCRARpy6gFHHX
 cllaD/9iCWfjjy9wCBEUEy147bi9+0/W1kuNnYZ+UDEaCjVYFMrc3rnAyXaayf35gvRx0wqUxb9
 aF2MptBGcVL2dTzCve7ldmBTQxHRYosBuTHZNDe/XakCnVLKYFDNujY4wFvDmm8dSOmPOtpa5vc
 mdATGn9cS9Ua4WlnEXGhPiUL1V1O52C76xYn1eWlYwNVCnaeB0yeqW3NZjh9Waw9hNU2LKXkA0S
 OqSBFUrtF1AgLzoFKeBS1F+gdItxUUqhMgNCeNsRyhc851bmLDSxr7bp7WuteA7X39az6KIFfFD
 lpLW6X1Ey9Rg0DdG5mOdk16BiW4tWHYX/vbWoHNY4jd74uY9THR82FG5ZUIsLB7WKUK965A6MDe
 taNJDPnzdrjFOgwxbAc6egfn0yY8fYpnkKsdo2po44r8P1N63fJHNobX0XXuasoudCGQ4Zny5Oz
 LgWo6bQh4ukHof7dBFhLOImgSXZvqZSkl6A3yEf4eqmHFZ9rL6Kjn9x2a4GGQvqW9JjF5FtpKzU
 biXyJi8q9yFoiL7Bv9xEhJ0fmpNjy/W2mfMtWi3BREAIAwXUXZJI77sUacAaJ4YuuiSDvd8VUIg
 bkZRRywzwADq/pwIL3M1CgOYGhYWYMtJexXyJYaD2aBKBVKStP5HExBXO5tXSbgi20Hb7Qih8G9
 d6Q/OI1u4kZr6/g==
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
Changes in v3:
- Make strends() a static inline function
- Use an empty release() callback for auxiliary devices
- Refactor the code for finding the shared descriptors in the GPIOLIB
  shared module, split it into several smaller functions
- Use str_high_low() where applicable
- Use non-atomic bit ops where atomicity is not required
- Link to v2: https://lore.kernel.org/r/20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org

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
 drivers/gpio/gpio-shared-proxy.c | 333 +++++++++++++++++++++++
 drivers/gpio/gpiolib-shared.c    | 558 +++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib-shared.h    |  71 +++++
 drivers/gpio/gpiolib.c           |  70 ++++-
 drivers/gpio/gpiolib.h           |   2 +
 drivers/regulator/core.c         |   8 +
 include/linux/gpio/consumer.h    |   9 +
 include/linux/string.h           |  18 ++
 lib/tests/string_kunit.c         |  13 +
 sound/soc/codecs/wsa881x.c       |   3 +-
 sound/soc/codecs/wsa883x.c       |   7 +-
 14 files changed, 1096 insertions(+), 16 deletions(-)
---
base-commit: 2a3cf7aa49244fafeedf9f334d3e88fe8ee05b50
change-id: 20250908-gpio-shared-67ec352884b6

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


