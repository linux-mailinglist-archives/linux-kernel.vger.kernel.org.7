Return-Path: <linux-kernel+bounces-735314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF06B08DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C551A6561C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9702D46B3;
	Thu, 17 Jul 2025 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iAv5pDUo"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED42292B53
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757085; cv=none; b=QWIQIIwAy4hiPMkElFon0fxEGWD1kPeC5okA4KTWoeUcslm01i98EUCMW/sfpyWb0GOQFC/Pr8zC8QsNjSERQoaI/xnSHW7OkOVgyU5Y5SUY1Um7E92290/tUo0RJiZLo36UnZndVsCQ81sEZyY8v/2N2SDsa38soPdRh2L2d1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757085; c=relaxed/simple;
	bh=RsggvlbXuKQUjDvIXhfAw6fZmnRVxzpAcnV8aFDPl70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q9bIncqVVM+WM6HEyHUjX4fVChXGUrLjpphuGU//JKzx5rGWzhFk96euSluDzqcViKYxoqH1P2+x5HyY/jKaRQVVpf580B32mediXIz2T/mnsrw7BcRMjkOo4+cI5amqw4y3cmAtclyEtVON9RwGapJjBiu10K8mIA6OnH8x2Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iAv5pDUo; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b611665b96so521107f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752757081; x=1753361881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hkmEdAi1mYXLj0GumaAbmFTj8/Vf6pdxJ9LxWbK4qIA=;
        b=iAv5pDUoSbWKnTwE1NdQhTe6JblAWVuilGZwDGhRDWbaRsJ60kC8wOJJgIO2QlbAMh
         16Yx50nmV9FHWkb+wlUwTphOQzG8rmbGMxq+VRSD4+SJB0iXeEadhqA/JygNIHubVrOt
         wZpqRNJPZFfwHa0LbZUXOCtiX4SQhi2dgL5dOKjUXvaGUFwS+RezSNYiUpHcGnU1JCun
         Fpj4u8W9OyhVaNjGYbXS1UejotrqseNOTeVceUi1dqQ2h78LMNazVyS0Jqz0bch7/51H
         mkG3Mj+vLXmXqzzUCiWPfCYginhnY/iEq7zAsoLVrEXl1ezZUCveQoYmaPh3buh46JaI
         kIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757081; x=1753361881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hkmEdAi1mYXLj0GumaAbmFTj8/Vf6pdxJ9LxWbK4qIA=;
        b=MzdH5xAMLKmV9PZ0Oi9ftgeL7X5q60zO/3oZJpOcxbu8hB20NDuuwdYjKytL5Mvw/d
         UXOvwWIzAIBg7HdEqqOtzdbN+fd8cd2NoYUDKkYX9zBUAiAsNWUGCYpweFMVCGlgedl4
         ukhll/9wRf6yDaK5I+FSKhI5dzKGrE7LpzkLY8cXvUyEYUD4TD9s6m0QKfcpZwm4UfXC
         Vf1G8Rqoo8MRIZlpVRK7SJ17t8GBoOliMklLzKfPx3v3HertOdc9aUjp2c/aeRrcbdD1
         NbK88XwOMbZ5yM6W+URdhUZgXCHmXeqEF985hBuFgs9sJzf3z8QhWVCOW9zSraiHEB0X
         a92g==
X-Forwarded-Encrypted: i=1; AJvYcCXqDQUraeclwj+WhyEAhBYOrT4OHwLaGsniXS6oO3fbmPcrhdDmeGkVhd/lHPKUdbX3PvynkHlRf/qlrw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL3CfOaTdhoz1deB9DPBFVpoKcpGFceyOwBBDo3Urr6BhdOPMZ
	5eL4wdmRX7tJbKrvJ4wXXVFQyB8Tl8UHvMa+nz9W29nHlNE/b489MnvKGT/QEz4eNTc=
X-Gm-Gg: ASbGnctjRW8UNDnptpUDVOUMvs+2c4JzQ0tf8GPLW9w4iRPrPT1S0hzDyuy7PNyZc/5
	OTQ0mfBCzBJLUPxDp1oOAP98+02hYgIaZC6sLcz2nNOvNFkAfepsUvOqn5ekpN9HBMavx+XqBKE
	h0BKyv+oHAAeyLZdF7KD7wrrvwvJ3OQVwsf9WIrdqTyq3G8lbzj2A7UWtQOwrRCWrLSwNGrLbyo
	36lfqHwQo/3CblzfnSZHwSL654Pi7xX6swQbZG5ydRz5TBofQQZ41ZMdo+gYChXvJRpynsXk7j5
	4Dt/OqvLIQiwsC1hOAcxLeI0ODz9x+MxZvj44JUq7uPRKx2wCZkcSvmQI9wMpd1mf3FREtothxF
	IT7uyVL00oxp6OQ/MosE/kUwcqlNZ0HzCmw==
X-Google-Smtp-Source: AGHT+IEUUPM2Bn3BQQTqraXEIB2Jm5m5lpH7CokHPg/MliMMzl3/KP587ZU4bPNjNv333+jZ1/DKow==
X-Received: by 2002:a05:6000:290f:b0:3a3:6a9a:5ebf with SMTP id ffacd0b85a97d-3b60e4d0841mr6039464f8f.20.1752757080738;
        Thu, 17 Jul 2025 05:58:00 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:9e61:4694:c621:5693])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e89c308sm50080735e9.30.2025.07.17.05.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:58:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] pinctrl: ma35: use new GPIO line value setter callbacks
Date: Thu, 17 Jul 2025 14:57:58 +0200
Message-ID: <20250717125758.53141-1-brgl@bgdev.pl>
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
I realized one of the pinctrl drivers was missed during the conversion.

 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index b51704bafd81..da5220da5149 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -361,7 +361,7 @@ static int ma35_gpio_core_get(struct gpio_chip *gc, unsigned int gpio)
 	return !!(readl(reg_pin) & BIT(gpio));
 }
 
-static void ma35_gpio_core_set(struct gpio_chip *gc, unsigned int gpio, int val)
+static int ma35_gpio_core_set(struct gpio_chip *gc, unsigned int gpio, int val)
 {
 	struct ma35_pin_bank *bank = gpiochip_get_data(gc);
 	void __iomem *reg_dout = bank->reg_base + MA35_GP_REG_DOUT;
@@ -373,6 +373,8 @@ static void ma35_gpio_core_set(struct gpio_chip *gc, unsigned int gpio, int val)
 		regval = readl(reg_dout) & ~BIT(gpio);
 
 	writel(regval, reg_dout);
+
+	return 0;
 }
 
 static int ma35_gpio_core_to_request(struct gpio_chip *gc, unsigned int gpio)
@@ -524,7 +526,7 @@ static int ma35_gpiolib_register(struct platform_device *pdev, struct ma35_pinct
 		bank->chip.direction_input = ma35_gpio_core_direction_in;
 		bank->chip.direction_output = ma35_gpio_core_direction_out;
 		bank->chip.get = ma35_gpio_core_get;
-		bank->chip.set = ma35_gpio_core_set;
+		bank->chip.set_rv = ma35_gpio_core_set;
 		bank->chip.base = -1;
 		bank->chip.ngpio = bank->nr_pins;
 		bank->chip.can_sleep = false;
-- 
2.48.1


