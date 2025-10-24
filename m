Return-Path: <linux-kernel+bounces-868800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82079C0629A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9023ABEBC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58646313524;
	Fri, 24 Oct 2025 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FAr0OUgF"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C61F273D9A
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761307413; cv=none; b=RYIPIHigOwOieKFSueJrbVOUoievbb2yDsAO1Vwl2+1vMYuXxBm430xnGe6KAvnfFvHWEpKke3iBHgimgz4fOiq1Gf5urnXE6DllSKihoJFo3P4u9GjPDiKqvcbMwkucSdqvyv5+LLQxquYbCR3fUWBHyiX4jhFrkcXC/pxnBXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761307413; c=relaxed/simple;
	bh=Men9/wmG/ZUUgBBI72/KEQEc4VGPzum8/bYIlfv7Ops=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svE/wLYqfpUT5HFyys8szYUXcbUEbnOrvL8Ang9o4TljyiQdDPIW1X0xxvdZOqFvU4T+YZMtcoSbLdHZmtLhHUA5QMMXWiE0Ffi+LaDFav4yvnQ1ja5cazjmMreEqX4vmA6F8XWZDRJySqA9rv0KAX8Q7ztC2GBbQSq4uF4as4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FAr0OUgF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4711f156326so18149305e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761307409; x=1761912209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mPV5ihUnHr8u4lnMxWNUS59GCM6jDnONUSLo0YK3wR4=;
        b=FAr0OUgFlkAkDbdHemYPcLFoMPCHOolddCr7AeeC9ZGHjtXklnrXvzHrgcj8u69sQ+
         F9/5HaUrJ3XTJkO9HpTyMHzA5pxAVgAXVhYHIc/fLniv4BuUGsJQHw8RhcqrUNsKQ2zt
         trARhMm0lXTEdn54YFdtGNGoTsbCNUVsc5VYzBAO1Z3bYSSHmNoW81Ol8wB2QtIaNl6g
         ZQoi5ux5wCVm+CLZV7JendX2wf8OOs2k6jznTSOXsesuSpn40MwZEpmMkiKjUnkC0mCp
         oP2QXrcOLfZTNg38dZRi2IO374wdLH16pjQxY3O8xMkmK07r4XVvZ2xxVlBrYSghGKSe
         kf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761307409; x=1761912209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPV5ihUnHr8u4lnMxWNUS59GCM6jDnONUSLo0YK3wR4=;
        b=XYJRDAsGdAlIrJiA74jznRRdTyOVcB+0102+9nv72hlny6c9Ow/Y/sVDOW5frk6rpg
         b+RblYQEG4Fa2JsR43tHx2l3W3XnNDSK/QXKpa8SHd6JQ42UpbCZU8x8E0niP9sCvnms
         lv/Cl3ne/CoM0l1oXOh3S+E/Ya3yF0CBcy50ULRskSK/oTPqLuIMwD/oUZn5JqSEa2oK
         tYU5DH5d/7Ife+O5+otdD88BpbiT6fx/z3kQVhZ084V8rQ8u4QgBfmxZM9teeIjAhJ7c
         igWjLZ+vtBlu98CC+kgen0c3wrqH/InbgVXEiTzXNBj5Y8SDjibDl1mpgKya1u03gM5p
         2IBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5CoDs+llochrZwF7jMDLXuoIEzMDKWlh5nAcBJohFS4gy91Rb6TnflFhFPS+HLZrDKyjX+eHGbcFjjeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1p3XYV2GzVfgqtCfkt8dlTiDY0xkUIqSNf4VwTMob7FKADExM
	AfuAYzFuuClcunQwOmdCMCGAP6ggEBHQ36A4/G5wMpuFcQmrYpe3LwwjxoODumhC30E=
X-Gm-Gg: ASbGnctiFfRriIhcMJWmVyaSBD08T1CCxsjtRlOHW0FAREKfXvx4R/rwW7KVFDdGfyk
	Lr6mNNLDkVHbXZ5uyYKSaoIMfaePF8CIYaE24reV2ZRjAKlmqt1XK3rcIQp4vxpMIXQsnP7+WTS
	/i2dWp5X90ffs/h4bpycQETiI1ypnP5xYgHC1qwCtrK6S/pmJjiWClQjogkCwKhdHyQQhXnXoHZ
	KcxTqr2/seMjnaztbYEHwBGZZ4dZl0ujIwLLO+MDDwSuzvsyAlelsJT2p/QJKPlaeyv2d05/r0X
	joaka2KncOVQUxxVHQxZMIIjYdHnJxnvjr9HZfV976bfZzOUB8IvG7sSRU8yv5jk1YT6VYsyOUy
	o9rZJ8d4tstgH1p8ZiUE8Ng2rs1brS1Y391dswDt1HcFWjaj8UPBlNfLJ8r+h9gEPkIgntJmkWz
	4=
X-Google-Smtp-Source: AGHT+IHzLJMr2J1r+wANIYV3joHu+TXVlgpo7zfV0xKNG+Ayhr2mf56CMgyvBQhzNYKPRT/tLgXu/w==
X-Received: by 2002:a05:6000:26d1:b0:427:45f:ee2a with SMTP id ffacd0b85a97d-42704d49857mr16223381f8f.9.1761307409258;
        Fri, 24 Oct 2025 05:03:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7ac7:4d3b:a7b2:b32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ec1dfsm9094123f8f.43.2025.10.24.05.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 05:03:28 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio fixes for v6.18-rc3
Date: Fri, 24 Oct 2025 14:03:26 +0200
Message-ID: <20251024120326.48028-1-brgl@bgdev.pl>
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

Please pull the following set of GPIO driver and ACPI fixes for the next
RC. Commit 00aaae60faf5 ("gpio: regmap: add the .fixed_direction_output
configuration parameter") is technically a small new feature but it's
required by commit 2ba5772e530f ("gpio: idio-16: Define fixed direction
of the GPIO lines") which fixes a reported regression in LTS.

Thanks,
Bartosz

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.18-rc3

for you to fetch changes up to 4c4e6ea4a120cc5ab58e437c6ba123cbfc357d45:

  gpio: ljca: Fix duplicated IRQ mapping (2025-10-23 14:30:11 +0200)

----------------------------------------------------------------
gpio fixes for v6.18-rc3

- fix regressions in regmap cache initialization in gpio-104-idio-16 and
  gpio-pci-idio-16
- configure first 16 GPIO lines of the IDIO-16 as fixed outputs
- fix duplicated IRQ mapping that can lead to an RCU stall in gpio-ljca
- fix printf formatters passed to dev_err() and make failure to set
  debounce period non fatal

----------------------------------------------------------------
Andy Shevchenko (1):
      gpiolib: acpi: Use %pe when passing an error pointer to dev_err()

Bartosz Golaszewski (1):
      Merge tag 'intel-gpio-v6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-current

Hans de Goede (1):
      gpiolib: acpi: Make set debounce errors non fatal

Haotian Zhang (1):
      gpio: ljca: Fix duplicated IRQ mapping

Ioana Ciornei (1):
      gpio: regmap: add the .fixed_direction_output configuration parameter

William Breathitt Gray (3):
      gpio: 104-idio-16: Define maximum valid register address offset
      gpio: pci-idio-16: Define maximum valid register address offset
      gpio: idio-16: Define fixed direction of the GPIO lines

 drivers/gpio/gpio-104-idio-16.c  |  1 +
 drivers/gpio/gpio-idio-16.c      |  5 +++++
 drivers/gpio/gpio-ljca.c         | 14 +++-----------
 drivers/gpio/gpio-pci-idio-16.c  |  1 +
 drivers/gpio/gpio-regmap.c       | 26 ++++++++++++++++++++++++--
 drivers/gpio/gpiolib-acpi-core.c | 31 +++++++++++++++++--------------
 include/linux/gpio/regmap.h      |  5 +++++
 7 files changed, 56 insertions(+), 27 deletions(-)

