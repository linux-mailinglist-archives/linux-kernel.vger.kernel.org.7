Return-Path: <linux-kernel+bounces-735334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEABDB08DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E032A17D798
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5DC2DCF7B;
	Thu, 17 Jul 2025 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OLFAvT/E"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588602DCF55
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757979; cv=none; b=UweApFn1JUN+E8KsJ8X1OaZioS6Ok7R/3VOfVXpj4Wb/wJc1+7LDKw10YNbk8dFvmp2wZqnZmJTqTyT6bqAAFaqrUBYU1RkvOqu1onLloRARIGGbuKGgue2uRyD0rKybIN59QSk08rdAngnEylSEKOPGMuMJi6jbjyJBp1e3Ak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757979; c=relaxed/simple;
	bh=XXBDhyeql4d8L4NnZLa/IrO0hHUtAG0BnynKMTdeYXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWWkV4uJgXx/XKabk1wZtJ0z6ihSs0RvRUWA4EiZtCwfAvFVF97KkdUb87M+55DvqOMF5dX+DWkwfjbKPUnrayTIrVSZWaH47cXK2Zjb/l7wK6dZBa76Vh86lx96K/usn9LafsliossNp1Of35jB+gd+aLtiGLKho+8ciDu39b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OLFAvT/E; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso638262f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752757976; x=1753362776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/WjiuYscpN2Frw7QNF5oguxnwNIqkFQCOHsWhejWjU=;
        b=OLFAvT/EYyjma1n7i0R/jvARc2qXq8nwLKuXMvTh5SAHPHkkEatHNDzfTJqTt2SKJF
         kTKig15XPBBe92IwsvrupNKgKYfHhpDqr6GRhcNqlEA3sIbHDHSCpbyYBZ3XA94XO/lR
         /B+r3+hYaHicTb5hXVcYgtRo2IloCGxH7/qmwHFsa1phorx3X8Kx3xd8ktkvCTElUI8n
         CVjWKWx7Wnr7Dzkvon9AjYJz/X5hQtlQ3wChN6aYsAK/+OsLska6X0HctMwjZ4U8AVQQ
         GYYdBIUFhdz+bbXo3dUz/xJVNUkxEtvwyiQFAXPJdXQVoV1mEAElQV+Z/CCZ/597K6On
         yR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757976; x=1753362776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/WjiuYscpN2Frw7QNF5oguxnwNIqkFQCOHsWhejWjU=;
        b=qJZIHyfOfAGe4LYpCg8BnwHO8dXa0SckQlCPjQH4VR6M6pPfnVn0pJvFSAAnSw8Spw
         mkOxAZIkEcQKUTta1G2ZJA0PNEGCaxaxg7Unhu00TqXk9tZpZqU1W/46zBcZ1t9On3M/
         kzF7H0xzKaauanmoEQzhr6bGQ+eTl2u88ht16277UQhNFBPC5SEiWNv6mvG+GGA0CVLa
         Ql7sNAh267X7qIzu0XoDBs+iiEoi51VF2TjpP3z3J+wu13pKGF5b54ICmNwW7cjryE18
         gPZYaQQTT9PA7HMgC5hAbnZLUoiXQwUG+InqEZgJb3p3evTWW7vI2DYVYe35tZLaO/TK
         q7bw==
X-Forwarded-Encrypted: i=1; AJvYcCWY5XPMhPX9Hb3Ziytnu4mgqDfbXVynRyvHY+uDYEndutBLMvaM2hOH3E8PuPQlLy0inBqrkg6uBJ1Ho3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCCy+sUtL5XDIHqmogGy51/tML8dd7RHKPE9RedGokTqZm+frd
	CL+tZ8vrZ9k50OdhmBIRCFysOWNnii+qWOpQDPS5AON2XQw7n7uw2A65d2TIjSa4oMM=
X-Gm-Gg: ASbGncvtKmptCJp2E5JKb9r36MVakRJt6s1NQ00q0i7qBc+BWJA6ZxYe5TlN6qXjnJx
	JwkZU7qLy9ZnzPocqA0GCY4j4PFhiIoywQg8vAW22X7/CtxkcGsI0xlfO54DcS8e07bjjau1p2a
	X0EGqFLz5w48g4WYkxnnnB0pCkedIljSG2oRflFT4ZlLOgpdYozY25cZr2wFFrWbFVc6+7PHMMq
	jrt3r2phyYc7BhBSfpT21AxW+ZeeZe1WReTaIAXnjyYitlM6J4npmWefH9WV9WQFMazvV6L9R7p
	+zfPn88GTRjuFQIaYFUPUfg6flOS6j5svh4HIF/z+tFtIszVdokOQEMEBqLNb24+SfHTdzJLWWe
	XNvGLB6zjY2WDLLBl8GHeNw==
X-Google-Smtp-Source: AGHT+IGzGFx0tsRUxwRORKkDw5ZC2MRWFY5SkSaXRSiW1UMJIHxvelt78CwR5yC1NaYkh2sDPGCCyA==
X-Received: by 2002:a05:6000:310d:b0:3b6:c6b:e4e6 with SMTP id ffacd0b85a97d-3b60e4be9b2mr5583358f8f.11.1752757975718;
        Thu, 17 Jul 2025 06:12:55 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:9e61:4694:c621:5693])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1ecbsm20574252f8f.25.2025.07.17.06.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:12:55 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrea della Porta <andrea.porta@suse.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: inux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] pinctrl: rp1: use new GPIO line value setter callbacks
Date: Thu, 17 Jul 2025 15:12:51 +0200
Message-ID: <20250717131251.54021-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Another driver we missed, that should be the last one under
drivers/pinctrl/.

 drivers/pinctrl/pinctrl-rp1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rp1.c b/drivers/pinctrl/pinctrl-rp1.c
index d300f28c52cd..6080b57a5d87 100644
--- a/drivers/pinctrl/pinctrl-rp1.c
+++ b/drivers/pinctrl/pinctrl-rp1.c
@@ -779,12 +779,14 @@ static int rp1_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	return ret;
 }
 
-static void rp1_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+static int rp1_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
 	struct rp1_pin_info *pin = rp1_get_pin(chip, offset);
 
 	if (pin)
 		rp1_set_value(pin, value);
+
+	return 0;
 }
 
 static int rp1_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
@@ -849,7 +851,7 @@ static const struct gpio_chip rp1_gpio_chip = {
 	.direction_output = rp1_gpio_direction_output,
 	.get_direction = rp1_gpio_get_direction,
 	.get = rp1_gpio_get,
-	.set = rp1_gpio_set,
+	.set_rv = rp1_gpio_set,
 	.base = -1,
 	.set_config = rp1_gpio_set_config,
 	.ngpio = RP1_NUM_GPIOS,
-- 
2.48.1


