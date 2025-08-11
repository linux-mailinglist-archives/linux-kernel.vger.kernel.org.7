Return-Path: <linux-kernel+bounces-762767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B13B20AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400E5189D8CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1AE1F3BAB;
	Mon, 11 Aug 2025 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PEZgrkD8"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4E1E501C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920287; cv=none; b=ncdaEEFbp41G3HkWmlQKW/tek3uNeLO9s+s2FbUPi0342mLcEYoQ6zwJ29cYSIQq1AI/jkqpt+nbo1BfTa25e2UhHMOstGXcmMCvfSuwAm1Uonvthw3BmuBrRCSwVN53VbnPfBDMY4MzKOvPtl8A+Xl6re1yZq4EhaMeBQes9Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920287; c=relaxed/simple;
	bh=CT9X4h9G4kjZOvWJPdcMAMFlsua7bmKxmk6w4I0kbuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqYlgmyPxoKhiUr/QxCnNepymefRt1wgsnrws7AIzbFI6Y1bjsWoQpP2mlYFQGy6t9AgAfBq1PhZbnKYTckqfSNkDBlZuZV9C+b/F55AaZ4eG1QX6uMr9CEhvd5RB2mJK6MeFAUyMW6gQhuqr4O/MpvfHAWzYE3rK1L9kWVEozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PEZgrkD8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78127c5d1so2882690f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754920284; x=1755525084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mkHomn73KtcskPUwX6BNDBx/JMbgC4+EHUqJc1nM+WQ=;
        b=PEZgrkD8JVTVztG6gIZRoe+gwnNNOEGtOO33L5Pe0aqSYwAG5HMlIAWKzK7shD/m+1
         VCSMI6V67X0xR1LsUE099Om3sMBkcuW/s89XFPlr1Qr4gprDcK+6brMY80A5rvQ9xbid
         YY5iZg4GN3a63m/NLcqJgihblVPWcBVu+wsEJPtmlYfhjTXKfoZfMQFrCnz8OfzzbGAc
         3ArGiidmwU5U9hB+7asmD4P4OPSNJd6XodxIBvJgQF/k//8W4CbQFud2O84MnyJP20hU
         plGingWDnG0+J3sHki71irRcTNebhOsRQkRyeHCcO9EI/t8ue/Y+Kp5Vkr1YW7wRgMGf
         7Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920284; x=1755525084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkHomn73KtcskPUwX6BNDBx/JMbgC4+EHUqJc1nM+WQ=;
        b=ewoLzOMwCkWpxiHWCoEnugqOww19lVVoZ534wn69mrgbYzUKp+oF2irzreivIwlDXa
         QW1v0083k0xEbKsvsjneU5lvcVV0jZJlJsA0cFT4PS4HBmvcSiX2/I2rp7Ccmf9Ba/qD
         TqpbFQ7ry/xWzBk5rY3w7zNp8E2KQLXQ5IKuabaePshF3sNHFitZlyw/aKgl59FtQ86p
         JOMl5udw+ZtUJj0wWkfRzctFuCDWGSUOgQjOFNwy37Y6NnYgbYvu2TVgFFTMIJmsy4ss
         J7ugsu5sZGRUL+KN/GPRaxkb9GugrV27frubXH5dIX89e/KwE5jqgJxDKaM5g+Jb6aOc
         Lzow==
X-Forwarded-Encrypted: i=1; AJvYcCVeVRV9kE7DmD5xoaxRiwoWW/W+7Am16QjaM2nC4kjv5RbS8E7WlDNjV/G3Hl8O6QNUoTsVTG+XKyKqpK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZynux8v2/esy8ezWOf+G3V1/w4elhAD7mIj/yaALJn+yHX5sG
	hrE9DZc+xeU/R4Nfm6od9PeGoomqtkfdNuaq6EJuZOy2zDJbJRBhvjo+dugkAaxfgjE=
X-Gm-Gg: ASbGnctoed9ynIrDsmsjFlGLN1q8sotpjSKGG1S2+aCg066sEhv3N7cme/kSjTX00H8
	4MQ94kyBZ86Em4MznR1qWMywoKFS5ARr64pJjNQsQTR04YVo4OBdgTslb/ncjWyCfFZLmgqPKCP
	tGhPjTlqa4LE04iRMlNtDJIlgo6pUMuNOoL1PKs6Y/h8gsTdKl41PRdxYoChWz6AXxDR0De/sHz
	jY8G+rx5DdgMb5n+PPDgTx34iY5b8DH3SQX2Z+oxfKqNUjrCvEmOvNIn4qyr8ecJ4SRf4bRmjf2
	0DjXN71kjPUKlnYphX3djHXJlSfuBDL+Mvqks4AN3Ou8PczW/RmS4GpAi9BRR7BsGviFU4NzfhI
	yadDrcVQwpUYfxe7t/Iq38gsa
X-Google-Smtp-Source: AGHT+IHgJl5hQvjEJ1bGPy/x1A2InalaL8MJldJyT+CZ55qH+gRDG4zVjSseg1WZYvxhnFuqybE2hQ==
X-Received: by 2002:a05:6000:230f:b0:3b8:f8e6:867b with SMTP id ffacd0b85a97d-3b900b4bb03mr10345585f8f.31.1754920283630;
        Mon, 11 Aug 2025 06:51:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6841:8926:4410:c880])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c51e2sm39611747f8f.32.2025.08.11.06.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:51:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thomas Richard <thomas.richard@bootlin.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] Immutable branch between the GPIO and pinctrl trees
Date: Mon, 11 Aug 2025 15:51:14 +0200
Message-ID: <20250811135114.70119-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of gpio-aggregator updates into your tree.
This will allow you to apply the final patch in this series containing
the pinctrl driver for AAEON UP boards.

Thanks,
Bartosz

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-aggregator-refactoring-for-v6.18-rc1

for you to fetch changes up to 53ec9169db1345f04174febb90f88a871fc28d9e:

  lib/string_choices: Add str_input_output() helper (2025-08-11 15:39:31 +0200)

----------------------------------------------------------------
Immutable branch for the pinctrl tree to pull from

Refactor the gpio-aggregator module as a prerequisite for merging the
pin controller driver for AAEON UP boards.

----------------------------------------------------------------
Thomas Richard (9):
      gpiolib: add support to register sparse pin range
      gpio: aggregator: move GPIO forwarder allocation in a dedicated function
      gpio: aggregator: refactor the code to add GPIO desc in the forwarder
      gpio: aggregator: refactor the forwarder registration part
      gpio: aggregator: update gpiochip_fwd_setup_delay_line() parameters
      gpio: aggregator: export symbols of the GPIO forwarder library
      gpio: aggregator: handle runtime registration of gpio_desc in gpiochip_fwd
      gpio: aggregator: add possibility to attach data to the forwarder
      lib/string_choices: Add str_input_output() helper

 drivers/gpio/gpio-aggregator.c | 406 +++++++++++++++++++++++++++++++++++------
 drivers/gpio/gpiolib.c         |  29 ++-
 include/linux/gpio/driver.h    |  51 +++++-
 include/linux/gpio/forwarder.h |  41 +++++
 include/linux/string_choices.h |   6 +
 5 files changed, 466 insertions(+), 67 deletions(-)
 create mode 100644 include/linux/gpio/forwarder.h

