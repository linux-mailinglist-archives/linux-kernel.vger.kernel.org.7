Return-Path: <linux-kernel+bounces-712827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED49AF0F83
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 11:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193101C26D72
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 09:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38CC24C06A;
	Wed,  2 Jul 2025 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KKDCfopX"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4322924886F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Jul 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447657; cv=none; b=J/6XbCAbgUHJw9KrewUQaW5a5HPFaxfGthoLVjLOgBDjU4PIIp75T+N64NuECraEgt7wTLgjneh5dAExtHYaP5EzDJPx26x5HlvZE/jkwnJXWt5WdIsbOviHcp/necTt3y53FWGgATqCbMisnIz6dMhEXN5I3DDRqDjhrKxGmZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447657; c=relaxed/simple;
	bh=+nVfuvhqkPVOVmugfFAWLkW4UOX/+j89Gr6pFORnwZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rqnpIU59s9USqYiEet2ATHsC0mvGlkoCgfm+l2N9l6bXOMzOojspvL9ZlFnvmf7FbDb/8qZaHl8SUaChm6b1CcwhrHd8aBhP0XWt/gLirMgA8ZxEoYPwWmsRYeByvmw6vx/uYnFxv0vHA5nP7Rb0WG2qIia8TO55VBjS45tz9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KKDCfopX; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so4853507f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jul 2025 02:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1751447654; x=1752052454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9px667tsfsWvUcAYLU3o61szQ9B4CZ4odfTl2msW8zY=;
        b=KKDCfopXZPHGH8oT0E61+DZR1+mgHhNbUsthAdhfpq+5QlntbOF1rTh4RwTLhMeKKl
         TwxnM3npbJJFxChHHQXZZu+U3qzYVsTjkVrACmtoWCVJwZFeCWLAih1nYFaZRh/J1B0R
         OvdpsjQ5eAhDLe2/pCvzaaovQC4vamBrGywzglgnKCDd7tDpAPr7s6yMS/ABn9jAV2kM
         J/9JU2NknuHtRKOtfDJpSQtb4DY44xXjeRoYCJ9CXacUzYGwwbl6JpFxOLaOSeabBb7O
         /yPSXb0S+HLQdeSGfFJh8hcUkxxVbvToyEugze08T6Fy4d51qZIyq7BLSpS/93vBWhMY
         gXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751447654; x=1752052454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9px667tsfsWvUcAYLU3o61szQ9B4CZ4odfTl2msW8zY=;
        b=H+uuHK6YHyWNEU6+5hoyT+Sc+1jFFI2n0m8KHctKbhnDPOHu6V8OidBoogHKR8wYso
         wLZTE0Vce4yyTxRywImIW8i6AR5kbfx89v3ACe3Zr4edPBLluKeKWKYCpxZmjZf7iwOu
         FkmdKDAN57/nlnaBOYH21E7IuDCEx8PJkNNgEvnsW4CmbqQhTFwAFopcmWQxVHRXP+kL
         eFf8vQ6KsGBcMdOfOIP+0oqDiI5jFPUFpl0s3DzF1/izXgoVt1D/hq7mglp8j+iDP56m
         byhWI25mP5UM1gLKTOPbCJ9arMAnB4VvkHr6mW45yoTDHv/a1hGvNK2DZ+JNzkRYhrJP
         ktrw==
X-Forwarded-Encrypted: i=1; AJvYcCVJvgaR0VkQP+GK6t2LA0C240YB86/219TRCGasSdAtTwHiyaReGCwFqc9oNcKB/c1MJsinO4RQ70gbNwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx7ix5rQZDB1pfDhF3vZ+0kDZ8EJ8QlqHHQOD/SR+HvhMTaTRl
	J9iFH/Jho/TMbDHuRZuhOb/bsOAeH1cX2917ECnbZTqTFCGbx1/STdqH2RiliM1VNgQ=
X-Gm-Gg: ASbGncsq5zd3UCV9IIbi3MJxTyqZPWZcQUN8MSFOs3a6IepA2+s5vo8lmUCymAB3uZd
	ps9H+RY3hdJiekLJgn4+daYhxdxVXhyVs2w8e4vBsC0SQiCVhhCofhprc6fs4RxjWEdcf1Ek8AK
	ZQqNOhCg745grPJZASSuFk7MSMq5bsvdCZbKyIlcY4Oo9JNyJd/QVRiZQ8VYDufMFe91n1jF42n
	3WEfo7grsjlN59Ij67UliAzLiuc0Z2+0ypNvlRm876/7z3howiM+WmkswFBEGuF/Qr23ueYBMM4
	P5jGOHn/e2cQzN1di3ypEF3mjVPAGNj2mjS3AB049A8JOLDAOaFKHqZeLHEDmMra
X-Google-Smtp-Source: AGHT+IH1QC/cjAF6tAcY4UP7T/bOkdOaaWCl+W55z+nwhrvgmRvt0U0bCNjMBdcWT3uUlVMnIYmNSg==
X-Received: by 2002:a05:6000:1786:b0:3a5:1241:afde with SMTP id ffacd0b85a97d-3b1f698b0b6mr1658079f8f.9.1751447654412;
        Wed, 02 Jul 2025 02:14:14 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:8827:d0e:25e:834a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a88c7e6f8bsm16027213f8f.17.2025.07.02.02.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 02:14:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 02 Jul 2025 11:14:04 +0200
Subject: [PATCH 03/12] gpio: tegra: use new GPIO line value setter
 callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-gpiochip-set-rv-gpio-round3-v1-3-0d23be74f71d@linaro.org>
References: <20250702-gpiochip-set-rv-gpio-round3-v1-0-0d23be74f71d@linaro.org>
In-Reply-To: <20250702-gpiochip-set-rv-gpio-round3-v1-0-0d23be74f71d@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Richter <rric@kernel.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=HP7Yi8c7fDJPX4fseLL/Dk6Apx29Ju0fVjgFf8RTbyo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBoZPhf8gmKFSaXX7IeqCZpSR62rItMoRyX3Ll52
 GaBrA8i2KeJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaGT4XwAKCRARpy6gFHHX
 cpipD/9ZCqiP/Ka35haybWi/fJQD7VgmwcJH6e8qA5gI0s6RYK6nB9Ug6hf3Qhm4Tgu4VnPmKTb
 GKAMNU03hZi8K5XloglBm0mvgD6A0KNpvFgvW/8vU4oXNcrjaXnuSaLPO3x0sTQAOHSWSyUeIXB
 YQyYHZLCJYEyrxd92RKqXeowUhQ7dV8x+ZdaSTnT8fexROi0K0NL7Mx6/1ECe5vKlzHMCeAcEcj
 +Husx1YJ/H3oz9DyUg8VDlSC/AKoJoL+u35VTgFWXUecIBiTKGJzSDVFshKf7+pGq3w/JpL+oxY
 IGmdZ7wkj4i1NhcFxg2+lL6rJ8SMdr6fsKMSsS3D68gihWiKZI3Pk0MWrZUlHlUYop6mA3DROGa
 4wiQfCpd8I9BkWbUx4WmRWneDBKf8Nmm/Iyi2WufNwY/wojH+gKqCwcuPP4tJp0v/YMrdeGN/j+
 8gWVbpOfAsrKUOmysuSU1mijLwUdBF1jXLk7uIzLNRA+L+SDoXfNdAbMlK+vxusSd51sKvMjBQ8
 ehM/EyjRiEv8T/C9K+euAqiRO/LzhVUftgXOgSZExEh0THuwLawJbMWe8E7ymA7ItudFcZkvUbS
 Vp6FXC3mUe4j63quBVYmrFEDeIRQKuofv5dZg09XMkhpnunTPqBqXIuqFrcDq1rHPHHeraf4/sc
 603ds1BGz2FtQiA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct gpio_chip now has callbacks for setting line values that return
an integer, allowing to indicate failures. Convert the driver to using
them.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-tegra.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 9ad286adf2632f300ee981185ea32d79ca012df5..126fd12550aa8e6bb812bb38a56d37c38114cd15 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -146,12 +146,14 @@ static void tegra_gpio_free(struct gpio_chip *chip, unsigned int offset)
 	tegra_gpio_disable(tgi, offset);
 }
 
-static void tegra_gpio_set(struct gpio_chip *chip, unsigned int offset,
-			   int value)
+static int tegra_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			  int value)
 {
 	struct tegra_gpio_info *tgi = gpiochip_get_data(chip);
 
 	tegra_gpio_mask_write(tgi, GPIO_MSK_OUT(tgi, offset), offset, value);
+
+	return 0;
 }
 
 static int tegra_gpio_get(struct gpio_chip *chip, unsigned int offset)
@@ -718,7 +720,7 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 	tgi->gc.direction_input		= tegra_gpio_direction_input;
 	tgi->gc.get			= tegra_gpio_get;
 	tgi->gc.direction_output	= tegra_gpio_direction_output;
-	tgi->gc.set			= tegra_gpio_set;
+	tgi->gc.set_rv			= tegra_gpio_set;
 	tgi->gc.get_direction		= tegra_gpio_get_direction;
 	tgi->gc.base			= 0;
 	tgi->gc.ngpio			= tgi->bank_count * 32;

-- 
2.48.1


