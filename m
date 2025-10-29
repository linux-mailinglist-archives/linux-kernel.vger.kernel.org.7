Return-Path: <linux-kernel+bounces-875572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E88D3C19522
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5101AA6444
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FEF31E0E1;
	Wed, 29 Oct 2025 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sNZQQqO3"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19677311C31
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729107; cv=none; b=YUBz0U0j24olo2kozuGyG5DY+sq2qtYYfbIaye+Q44OcGvDRo8WYj+vCPxbVmw2NKwhcXuE+8xRDuYwfy4FYcrozGI8svo0IrBq8MJRThWLHQi6Ru8M99dAOhw/LEggMWIR92w+G0/KiyE3+qZy88UcYQ7J+kYBHT3WchQnMmJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729107; c=relaxed/simple;
	bh=v1RlcqU+jzCZ92shMGmfN/CxGCYCmXWYYW9AKLagie8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TiFjX1MloXADG6wLk4+xpmqhVBkWPYQ/QtZ8jQI6j+cTbYxWwgQ0fHjATq6qZEqjqda8OmdagwQCvWP6SBIKb6RmCWijyKIz02iryQ+OzspSqHX5e941hIDamIZ/OmotVdAbNozvPrOdTewGm8FVEf763X1SZErHLv41Lw0DviA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sNZQQqO3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42557c5cedcso4375074f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761729101; x=1762333901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h7yTOb0DBw1VbIj1gPXYjKXMO6PHiSPU/ZLQwHA7s8I=;
        b=sNZQQqO3F+ZglloCZfPP7PJSzuKSGkq/5reOBp4lTzUfGKROViFmtSNMGUXDkZ1Wbs
         D4skoB2nrt2Saw6qShitrbOBQdSb+D1YhKY6mYrgv0qyegvdUMgKNViKoo/S3wObOzAh
         A//GOEsFBto6G5XacRjnl9HHlQSV9xAvcT8xSxmeVj7dq2uct6EoHBfuK8hYGlAGU662
         iN30hLCbHYT4iOJCO2iqe7e+jQNt8+TXK3yOl0vI2ZkDsi5iyTnUQRUo2Z3n6/15AmYH
         o31mRk2BBCh5Jy1clUSpB3mavkn8Nae9tKu8Uki4YzBADLYf/c0mSzGqGcV58fKf+qi7
         YQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761729101; x=1762333901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h7yTOb0DBw1VbIj1gPXYjKXMO6PHiSPU/ZLQwHA7s8I=;
        b=Sxz+DaaxPWjwtUtI7ADHDXiFjBkZzf88zndMJsbdGBm7h+Fzi4nHwmFdbOwFvgvGsw
         66UZrFkipgEuvdlJb6Cn1PNUEnaORsCQOv0cO4akRih5vP7qsW2DJD16cWKmsFvCujFw
         N4fM9I7T3tKCSJ8RArpAb21FCHy/WHugyX1Ci4IUBhBq6uTaew0tkNMC02VX1jczEhh1
         CGRqBj9mpj45tkVmJDvm1MnLVJrPuqyu/DprDt46qiQaBGv5iuoanjt9OmwFy7sRmHFZ
         jwtCyqK/iWW2zpQfKfGhqHtjpOkS/b36iIE+CgWRacd4FBgazxiTAZzhVBJa+8zjGNIo
         5qXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9J+GLbwa8HcbpRla790NGPcM37Zo5EmBSL0evRwy19k7/yh1I7heus/XkxoaXQPbbfLeEcMqaffUfdhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlCSlJHmWC6pG/IE6iCleParsH94MK+i3aGyI889fbFJfUkWhQ
	bbq556GlWmKvEu5WgO5k+1RtbqpxOt/QNX1RAmcET2npTS8Xr2deEGlWL0nWE2bs09E=
X-Gm-Gg: ASbGncvyxJ/mfxI02cyulibnEJE4/v5pAdaFSbhxlbbl2dvades4NW6EbLP+04EfbD+
	jdptdtDtQJCaAuGbPm7GHhpCPAxZBYRWK5URKI6kYk8OP07mqRWD3yFrXMWdrVK1sk3kILkSTYY
	R8EBr4XrjWPYzWBkGmBObZF3vPMy/g1+tMYe+o1XMxAmCWQ5kg9a6b6fOF7KQMVxUKwLAjNo5TP
	F9li5bt5kzcp0HtLvaPzL8xDHAhD4yOFbG4jEMdQSrX9NS/XaRaLd/6s3cH+XoXWVCe2A3IPQ3g
	CtlKRQkXszP3Ldj5oJzfG8x+xgbj8q7RltE48DU6QqBiP+qd9WLy58764BYj30Jx3BNMixmdLzX
	r2lQ2vJ5gJb2As/sLoWIElGCKrnS/u7C9QZFws73TI2Y/QsTLMrMU1K5glW7o0pyYZIKqEBZMjV
	01IKQ3wGCcLhA=
X-Google-Smtp-Source: AGHT+IGDyulGoYcyx6jU9Pxepcswwi8toc9gOJoAK0Kv095CCsZqF5B43vi69L++DfHx0JIkYMss0g==
X-Received: by 2002:a05:6000:2c05:b0:428:55c3:cea8 with SMTP id ffacd0b85a97d-429aefca395mr1382550f8f.50.1761729100844;
        Wed, 29 Oct 2025 02:11:40 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e196b27sm39871275e9.8.2025.10.29.02.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 02:11:40 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] gpio: mm-lantiq: update kernel docs
Date: Wed, 29 Oct 2025 10:11:38 +0100
Message-ID: <20251029091138.7995-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Update kernel docs which are now outdated following the conversion to
using the modern GPIO provider API.

Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Fixes: 8d0d46da40c8 ("gpio: mm-lantiq: Drop legacy-of-mm-gpiochip.h header from GPIO driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510290348.IpSNHCxr-lkp@intel.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-mm-lantiq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-mm-lantiq.c b/drivers/gpio/gpio-mm-lantiq.c
index 3d2e24d61475..1bd98c50a459 100644
--- a/drivers/gpio/gpio-mm-lantiq.c
+++ b/drivers/gpio/gpio-mm-lantiq.c
@@ -52,8 +52,8 @@ static void ltq_mm_apply(struct ltq_mm *chip)
 /**
  * ltq_mm_set() - gpio_chip->set - set gpios.
  * @gc:     Pointer to gpio_chip device structure.
- * @gpio:   GPIO signal number.
- * @val:    Value to be written to specified signal.
+ * @offset: GPIO signal number.
+ * @value:  Value to be written to specified signal.
  *
  * Set the shadow value and call ltq_mm_apply. Always returns 0.
  */
@@ -73,8 +73,8 @@ static int ltq_mm_set(struct gpio_chip *gc, unsigned int offset, int value)
 /**
  * ltq_mm_dir_out() - gpio_chip->dir_out - set gpio direction.
  * @gc:     Pointer to gpio_chip device structure.
- * @gpio:   GPIO signal number.
- * @val:    Value to be written to specified signal.
+ * @offset: GPIO signal number.
+ * @value:  Value to be written to specified signal.
  *
  * Same as ltq_mm_set, always returns 0.
  */
@@ -85,7 +85,7 @@ static int ltq_mm_dir_out(struct gpio_chip *gc, unsigned offset, int value)
 
 /**
  * ltq_mm_save_regs() - Set initial values of GPIO pins
- * @mm_gc: pointer to memory mapped GPIO chip structure
+ * @chip: Pointer to our private data structure.
  */
 static void ltq_mm_save_regs(struct ltq_mm *chip)
 {
-- 
2.48.1


