Return-Path: <linux-kernel+bounces-764717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23182B2267A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF796427607
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 12:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66BB2EF67D;
	Tue, 12 Aug 2025 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VHg0GuDW"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A9D2EF669
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755000774; cv=none; b=ldyQ+1CzlrChaPXPYeBGrJ0L6C//nyAZ208uk7vfspV5ZojYAPCpRDj98nTA+RfK1sABh166fqxXFSBSAc3IkDvAHnwKYGxhpvU6ngvn9wQSIwmFYioUegju61rOQ6eXQ4qCVO8Z2yRbZPLZg4NJhMFzNj4RmKehKdhdi3R5VZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755000774; c=relaxed/simple;
	bh=ufruTN/rsMjpZogkg1bX/2fwukSGxpr2NY77MLQ1ScE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mC2rfSNY9z7+fS0OPL7EzBK79KZo5WMaaDyVLEz0nKMV/dZlpJBshyb5+sQPu67BlP7nOwhBBY0gJNrroSkxv+4WXFbpwfCpRIrGCMVT19r7uVeo4kfCaLwGo7/vx7JYsFrq1WTFQpuOEA13uaVHhEiNijNYN1HjbEuO/MEfwXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VHg0GuDW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-459eb4ae596so49503555e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1755000771; x=1755605571; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eptxpJ0Yx0wWZW9/nNNpkoZdSzIonCkt4KahodklTGQ=;
        b=VHg0GuDW7vkCLR3aBnFdS+Hb8ddJ69DTgnq/knrKwrBaKlwMYdA6k5N2XIefgvQbRg
         FLZH0eyD/Bjgd5fAftGIWx2yhlqLq+xq2GoBnnlctHTcbDE3f4Ylhnzzb6WK+1Cdc9qe
         Kh73Khe3GCTGZsHJiF8sg5sYHbZPXlkAxs17zdM8AOdmgC8kSmMVpAEbU8Gf4pcFk5wN
         7QQQ5ikeiAf9uVGOCRVSeQmAZfzosyYJeOCvYf2XCTOKMGTJyE51svAhJQRLtS777oAk
         HkV0cezupfRsLIMv3rNu08QTC3myb5AGj6va7oDQOkynE9dMxAp99ibQ3ZnB5BMze6pk
         dQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755000771; x=1755605571;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eptxpJ0Yx0wWZW9/nNNpkoZdSzIonCkt4KahodklTGQ=;
        b=Q9CxMgMNOhnB6DZoLlu6q1zAUiefheSEhFl1p1O/TNFI4CAx8oEA4D6fXwDImsPy48
         RUstaB6CE1qBhnNGToYmxrQ/iyHWsnMLXzwQMkvAJgUqyfJEq/3pCtuY1/mquORtVza5
         4hV56VEeu3w8wAGiILVNVsB/v/jct5CeYD3Cc8bzNeaLiFEN/t0w43BPuTOsHBm1u9yo
         3zIU9MSx0TmCXCB0BU8N6tnniQ30In9bbY7/KUwUPoIL1tOO8q1Sdq/JX3RW55qMUfQA
         zaiJxt78LrQ6z5iP5ekZwo/DEJ9a0VNluHluS9VK7AUeX2mYp3Cu1OjcnlwK2opJtbh4
         xEJw==
X-Forwarded-Encrypted: i=1; AJvYcCWMpIm/HYNho56AIh6+bba+X9MyILBPATZhpzfI9wcTP9HFAZ282tUfm2GJoVgY6AVkuWakWlPsgsqvOFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI+ux2iwiXCeuQzin2t+Wmn5kuG3vJNEP5XUSkjwn0W4GmtAJq
	lZ5tiWpLuQnmh89WbWCd5jh7UNYhe27eWAiSS/vmCtSfksu7fvYBdXojK2orUlBEDKvTjK2cyrI
	0cVhI
X-Gm-Gg: ASbGncsQ7/IY/1KFqdXEoCeOECqHe898g3v4Ei8tU5SoT9To5iZEszJH/od+dNz29kx
	kDHj+XB7VU2BtbNedSYA+UT4Yj9mdnE4r45aJbcL1uRDSK12AybiCSjlJ7sKtyVgaiysusKZojO
	nzRT+jRTSsEb4fkDmE+kmj840qfrgSvbbo+aNlUabh9r+aBbK36DBXBBaHFakp9guuTWHWU55e7
	L3+UQ6StQcX/av7RS0O2fc6pWriHfyDPvANZeZjplTLaWx6BvwRMWrrCi7w+s7/J73Gv03uelqQ
	NhnzZXvtrkLc9O3QUSOHZ7PuRIcxmyyN6lsI+DyMJ7vrmtKsCB8ugu0zs8uhdttPGYPOyB6GrmZ
	ZeHvenH9JDpzMWHo=
X-Google-Smtp-Source: AGHT+IGrKlosN22orMav7f+vJj0S00uwK1i7LZju2ODkMixHCeR7FanAHC/Iu6OLgDLOv4uYkqeKQg==
X-Received: by 2002:a05:600c:524a:b0:456:1204:e7e6 with SMTP id 5b1f17b1804b1-459f4f517dbmr134199135e9.11.1755000770984;
        Tue, 12 Aug 2025 05:12:50 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e6867193sm298878535e9.6.2025.08.12.05.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 05:12:50 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH RESEND 00/14] gpio: replace legacy bgpio_init() with its
 modernized alternative
Date: Tue, 12 Aug 2025 14:12:42 +0200
Message-Id: <20250812-gpio-mmio-gpio-conv-v1-0-aac41d656979@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALovm2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyML3fSCzHzd3FwgAWYl5+eV6ZoZGZsamicbp6SZmygBdRYUpaZlVoB
 NjVYKcg129XNRiq2tBQA5H9IJbQAAAA==
X-Change-ID: 20250728-gpio-mmio-gpio-conv-623517c3df74
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Hoan Tran <hoan@os.amperecomputing.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1929;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ufruTN/rsMjpZogkg1bX/2fwukSGxpr2NY77MLQ1ScE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomy++n89pg/9ESyGDJ0sRR4xk/Cmg/ARiF1xR9
 QgmE1/ouKWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJsvvgAKCRARpy6gFHHX
 cjOxEACZJpWWPGUL9CfHiHTHVE1TDp9GRb5oraK1gn34WFUDtudWF/KwjDYDi1lguczQxt+c7Dd
 IqnXpHRgrc8ncZmbUskDlzhu54x85mdlun89rTwhTrS0Y3bVQcGyagxVBep4QkzBoCOvdzeWbgi
 9jBraop/CGfr8bbZc96GBP4A1eyAdt6zINaWqHZOWG90ylNJWRAacUiWAVedcG9X/gA2+eX7tnr
 yTF1LmdMVJjAubARxEO5T4/lgevQtBxvlUtNqRoI5IK9vk8wG6l457u4JPHby2jMYoNfrsjZttO
 KSaRdBBT5VzDKOJxcysnZkTvww0zewKCemWKXsF9MFDb5znPOjg9824NKyw4JB51Fc9aRa++JUm
 qbvsQq5skDcO1O+8L5ghkDriXZaHeYxOFnFlDjrax63RTwb7V71bksIhrdcjsf/r/pxy7o/5/nZ
 rXvn6JM9dDW7NavxZSoA9cfPg/7mftwO6rfrGdUOoh2IQye4X/3JLo5Gy2hp4kau1fSPH+GrSz0
 1bPijJE+EwbMLxdmUmse9dB+Mv8FYgEQlQhmqijTAL4KC2cnURSWoMMzvInCJ/y0fPkfJI0mDXS
 FfN6KDFWdmXgI50RWaslZYkunzL191aZUv4ZQNGjUawpagr7W/s5nlQKNDo0q8ua5lcCKC33OtM
 NnksUq3oJlC07aw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

I hit a network error when sending for the first one, retrying now.

This is the first round of GPIO driver conversions to using the
modernized variant of the gpio-mmio API.

While at it: sprinkle in some additional tweaks and refactoring.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (14):
      gpio: generic: provide to_gpio_generic_chip()
      gpio: generic: provide helpers for reading and writing registers
      gpio: hisi: use the BGPIOF_UNREADABLE_REG_DIR flag
      gpio: ts4800: remove the unnecessary call to platform_set_drvdata()
      gpio: ts4800: use generic device properties
      gpio: ts4800: use dev_err_probe()
      gpio: ts4800: use new generic GPIO chip API
      gpio: loongson-64bit: use new generic GPIO chip API
      gpio: dwapb: use new generic GPIO chip API
      gpio: amdpt: use new generic GPIO chip API
      gpio: rda: use new generic GPIO chip API
      gpio: grgpio: use new generic GPIO chip API
      gpio: mpc8xxx: use new generic GPIO chip API
      gpio: ge: use new generic GPIO chip API

 drivers/gpio/gpio-amdpt.c          |  44 +++++-----
 drivers/gpio/gpio-dwapb.c          | 160 ++++++++++++++++++++-----------------
 drivers/gpio/gpio-ge.c             |  25 ++++--
 drivers/gpio/gpio-grgpio.c         |  87 ++++++++++----------
 drivers/gpio/gpio-hisi.c           |   3 +-
 drivers/gpio/gpio-loongson-64bit.c |  42 +++++-----
 drivers/gpio/gpio-mpc8xxx.c        | 102 +++++++++++++----------
 drivers/gpio/gpio-rda.c            |  35 ++++----
 drivers/gpio/gpio-ts4800.c         |  39 ++++-----
 include/linux/gpio/generic.h       |  37 +++++++++
 10 files changed, 337 insertions(+), 237 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250728-gpio-mmio-gpio-conv-623517c3df74

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


