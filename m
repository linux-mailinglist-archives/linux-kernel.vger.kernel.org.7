Return-Path: <linux-kernel+bounces-820288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FCCB7D9F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18F71BC342E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0051430F804;
	Wed, 17 Sep 2025 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WxBMDprV"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DBF2F260E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758099265; cv=none; b=hBxgTzuqiLmFUyxqj+BtInKhSSUifi8be9E9fmSV3VDajjMZD79tHszdRyLVXf5LGFx25Ym5qB5dtGHejK/Yt9RqU8lTD/1aai/8byvjcc/k2SvgRlmkCxdpwcWgG2qdmP+8RbvIFZtqHKnpwr6pj/qMondwsUx/4YM/SaH6FHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758099265; c=relaxed/simple;
	bh=hUhYQ3o/M+sX4jatw+2DoAMHDOL25WcfNBSVENg0Izo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rQyZsuO/ttT3Np9RL9mq1ZTFMgprFnTo+CXMfH9srqpKX74njuRmK8Bal7RqeQKtQKUl3fw/rIxgSkda3addB1aFRddbqeY6tZDkSf0E59g3nOeOmae37+IcXYkc5u35wD/QfN1vhpz2qKIjOkSdmLvw28gvhPUYIkQjB6TC0eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WxBMDprV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso5067379f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 01:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758099261; x=1758704061; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KeQP50ZvGCY5I9+ObXf6A3yi4w63rBPPsRO9IvAIXss=;
        b=WxBMDprVOtrfRMi/yT6yuibeJcI3xxgc+uLS3qD6Wbuuvudq8reofrrncCgsssh7RX
         kNLsYWd4TqBFuh1AU2RiZulHZg7GoRxxmOwCyH+tfvGOFJh0UtEzYx4TQcxfccPRq8vU
         kqrW0TUGZr4S/yOAu37DE1zU1Dd2AYCBEAjeON+vjbbFJPltRLB8L7zgbRFtdYpv+5zk
         xGRciKmyWYoRWzNHITpRjjV8hd4zgi2mqCA5D6RlhMpZK40v3ppfsDaUGRa2Zh4RVxIA
         QDCiqKqegoVvJv0WvHKo9fuhmrFpNG5qz+DAJ8dZ6iCvogcKprWrSXSVXZgPHyW2YWIU
         /MXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758099261; x=1758704061;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KeQP50ZvGCY5I9+ObXf6A3yi4w63rBPPsRO9IvAIXss=;
        b=AJFoicfxKDIuA3tlZKi0pmMc6X+54zmpHgguaSQVgA8lIO76tAr100RmpZK54BnpxJ
         deRrGwt6y1qxIjC97exCbK5sY6C8zw+rkWL6VwlwVwSmjeHQ9jzyX4qdXjotkjFdH7cO
         H0H3Q3Dl8V/izPLGiNrMy6ufMxpDo/mBOOx8OJdP3c67tzduC7jW2DxqUfdfCeUPQs/Y
         24BQv2c/sjOm0kMjgC43QVwUbkVJ7pPdXcKTgGgpn4ojdVV4WUOMw4uqzexSiDMjmIRU
         E55S26D8dQVhYkPH12Rr9wOmtjMND7N83yaqmTXkfstNrD6MH+2ZLUWoosGLX5Zk3F4M
         v09A==
X-Forwarded-Encrypted: i=1; AJvYcCXssKe6Dtlq6hZD14vkp8zGmSX6hay0PIqXx/W5V8nt8Ueiw1XJ/CW7JMp8PXPgTTJRdvD/i/suJQlSZlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqbvkUQN31TE+OJm3TjloYlsZGEDK8LcIElG3QeAIP0zhejVWc
	b/kZCRU+wB/bBLcyadCLuf9GuDsmgxendFq5gkHBJkMYPIcs51vRHxKKzAZxC3WdMTkqOQFNmvn
	shxGX/gOyVw==
X-Gm-Gg: ASbGncuDZnx7kEQXfHDTUaPk4lfb16qFelTET4AtLo2Rl4LzS3xcpAnOzR8L4eUqqhy
	ECYRJsqa/zhWaktO9uyu+1AJgZ+xHSTRqFi43ocDhkjaIPrhq4n0V906VsL9/XR2iUqxPmpTTX5
	5RLjd8pRYZU8+OLMRExtzl66xOIapncFC6poqWN5rk5YehhXt612pqTa9Mgegw0g6mrzJj+y6dD
	Z6Y7JvqJiP0wDXXXmVxnDh7e6kWiBEKEw7+EU5y7WOBqAw3YTddgLs1f/18kbFYEb5/5IKE3kKK
	6tsdu8LDqptL+Nci7/iNNp4XslUTsxZGr7YjrQyfiDmCpRCp3Nm6AZsroC+Ga7CGKxarRzjargW
	qbFYxD9CXXTAUDr4/1uXu3U+ZrQp429C0MrKf2YamcginGRxJEackScIIjONlXuzjd71f
X-Google-Smtp-Source: AGHT+IFVDxRLRayEBGoIaR9EiPgkO8IS9+oXed/tTpG5MFBofx4nIX3tq33Dye7W90C+SoEF0J1Urw==
X-Received: by 2002:a05:6000:400c:b0:3e5:47a9:1c97 with SMTP id ffacd0b85a97d-3ecdfa357bfmr1657780f8f.43.1758099261454;
        Wed, 17 Sep 2025 01:54:21 -0700 (PDT)
Received: from [127.0.1.1] (94.red-217-127-72.staticip.rima-tde.net. [217.127.72.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3eb9a95d225sm10117552f8f.54.2025.09.17.01.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:54:20 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/2] gpio: generic: rename BGPIOF_ flags and move them to
 the generic.h header
Date: Wed, 17 Sep 2025 10:54:04 +0200
Message-Id: <20250917-gpio-generic-flags-v1-0-69f51fee8c89@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACx3ymgC/x3MTQqAIBBA4avErBswyf6uEi3EZmwgTBQikO6et
 HyL7xXIlIQyLE2BRLdkuUKNrm3AHTZ4Qtlrg1baqLkb0Ue50FOozCGf1mcc9NgbYlYTa6gwJmJ
 5/um6ve8HahqLO2QAAAA=
X-Change-ID: 20250917-gpio-generic-flags-62745eff08f2
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=hUhYQ3o/M+sX4jatw+2DoAMHDOL25WcfNBSVENg0Izo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoync3l8Kf7F8ZZhV3a+5cvtJQKtcESCESbhwQF
 vqfVZ6bpPqJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaMp3NwAKCRARpy6gFHHX
 ck+2D/9XoLVanK63YA8/MVefthjRelwG0voUjuZSMqFyD5/YGNV1qZlDJ/F9JJ0TvnZcVwDVjBi
 3/as7wSXDdKqO4NgB4gav0n98x1kxbLLgH+YW1EBzKnUFM4NGwb8jP79FWcbKlprqXSFzBVW/kX
 r25rbZ/brs6WU0DMs3/CDhKQ96HiKjiIw37hfzBvMgevaKClzjMSxR3lLVQ/dDgnWE7HzxYTm9z
 DntxcsgN/349AFBIayPKrbn7RIY5oJmIe6sMexjTi58ngeR+m8pLxRhfayN0M6IMoi53fxzIdUc
 Gr5TVUWChF0o1mBEIhujTAKL6wbOSwMB5iuDB+3RQff6d1D9g9Mcxoy3rtRms0CvyYI1OjhwicP
 JP0LkXEZeHeqP1XC6KBHNp5E90gpaqx6oxAha0qag1LOKT8jyFNi8duLdo4ovuZiNl5G5RAy7d4
 qluWUtHevRalM5IpaAIH68IsMoBG3QNG+rA6cdJ6h8OWbWWqeLhj++5fl4NEIYrMyIY0euqukRr
 +xAHfZbC5kfLJSjcTkZXAUQfQMK7i4lLPXexGQEKnZGkXk+CpUuopUlEsQZOtOCyRX1a9th1Kyn
 qJ82s7CGCd8Pwxsz0LVW2EMvbPmfqS+cqCGN+mAwYPZb6LEnc9TzpBgbD+8RHRsUtbLHreDIgHz
 yAbKByV8tVM2+fA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

This is a follow-up to the conversion of gpio-mmio users to the
modernized API: we globally rename the flags called previously BGPIOF_
to use the new prefix matching the gpio_generic naming convention and
move them to linux/gpio/generic.h.

Linus: if you don't mind: please Ack the pinctrl changes as they
obviously all need to go in together through the GPIO tree.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (2):
      gpio: generic: rename BGPIOF_ flags to GPIO_GENERIC_
      gpio: generic: move GPIO_GENERIC_ flags to the correct header

 drivers/gpio/gpio-amdpt.c                 |  2 +-
 drivers/gpio/gpio-brcmstb.c               |  2 +-
 drivers/gpio/gpio-cadence.c               |  2 +-
 drivers/gpio/gpio-ge.c                    |  2 +-
 drivers/gpio/gpio-grgpio.c                |  2 +-
 drivers/gpio/gpio-hisi.c                  |  3 ++-
 drivers/gpio/gpio-hlwd.c                  |  2 +-
 drivers/gpio/gpio-ixp4xx.c                |  2 +-
 drivers/gpio/gpio-mmio.c                  | 28 ++++++++++++++--------------
 drivers/gpio/gpio-mpc8xxx.c               |  4 ++--
 drivers/gpio/gpio-mt7621.c                |  2 +-
 drivers/gpio/gpio-mxc.c                   |  2 +-
 drivers/gpio/gpio-rda.c                   |  2 +-
 drivers/gpio/gpio-realtek-otto.c          |  2 +-
 drivers/gpio/gpio-sifive.c                |  2 +-
 drivers/gpio/gpio-spacemit-k1.c           |  3 ++-
 drivers/gpio/gpio-vf610.c                 |  4 ++--
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c |  2 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c |  2 +-
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c |  2 +-
 drivers/pinctrl/stm32/pinctrl-stm32-hdp.c |  2 +-
 include/linux/gpio/driver.h               | 10 ----------
 include/linux/gpio/generic.h              | 10 ++++++++++
 23 files changed, 48 insertions(+), 46 deletions(-)
---
base-commit: 05af764719214d6568adb55c8749dec295228da8
change-id: 20250917-gpio-generic-flags-62745eff08f2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


