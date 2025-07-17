Return-Path: <linux-kernel+bounces-735326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A77B08DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABE5A463E2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FC82D878E;
	Thu, 17 Jul 2025 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vc5/Gba0"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D9D2D8777
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752757445; cv=none; b=uQ6YhMKBLBwpCBdIE4u5EDaO6QccFjdTAryGS0x+kgH4xctzLMC8OxNP9eLIfnGIZShzFkZKQHodTTAWoc0JoW0VNOhXae0E+9nL0RkLK9SmNT8ap0Tji8qO8oRAQFC50WXLGLY6vgyUlbXEuPNQDrgdsFcmGUiExUq9+iMz5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752757445; c=relaxed/simple;
	bh=AFcCS+w0Cz7CndWltXjGc+kkqbIxFsPX1odzGepppzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9G6bQc9MlDBsAL+7ihPjOkai32QRx0Mi4KQzXRFDOdo+e6IdWWVeFTvWp7bD8sGSOvyU5KsUEHJvhdP4vrG8QPWSLW6XnNXB4NDhnC4Gc7ld6slNA7HU9iRwbuTILaZ7sU1Yycrk+nxizVPjH3Zf6XWEOPgYiptsPwZ+/e8cBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vc5/Gba0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a528243636so594159f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752757442; x=1753362242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qtr+pfCZgLfpaJQ5aT4/VqRIXgnSOtEIkqPvTgB65ks=;
        b=vc5/Gba0JEp+aST/cSfom6v2mee1cwIiOvHpxxYjvmg0v2WYMj2cdLjymKAycaiRyR
         sQVnbM1ZSuvBUwq4e1ZjP4T0E3OHcXKzW+PXcuBu1WW1qRWqSbLdx+AvGqG0i8Q+QmSG
         J3Xq1rzvf/RQO5iXjXvPxfUGfrchNz6fdJWZm54BqHMcXM0fWYM5VWtdUYvrMheGhVcX
         pBfZc6k17Kb128u5vmfTnnRsSfNFxic77MIKJPvo5AHxv6E8qZYAXR0xjx4ASD3q4Oxp
         Isa32hIWwk/eMrOc0RQuPLF7vkHhRUBBvOjGly7urjh3nqt+gPvWQ3iMpx7I8FekYaCP
         CQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752757442; x=1753362242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qtr+pfCZgLfpaJQ5aT4/VqRIXgnSOtEIkqPvTgB65ks=;
        b=pRDUWjkwAbDWq92a4yn8XTqBh1Cjc8nyDzuuMAu2qtN+N81qFFxcqaQgvbSXemNmGp
         u7SlvxQC49zoRoe1oRe6c0NG2njJXCUWz+YDJwaR4OAolzr00jL8FllcdAkur8kWlprg
         cJAUgprAf17OJRDH5WlsoM5jlXmgxnNeb5bwbXBP8tha5TzbNeEl0nyikLKATqnVWJrB
         KdGbq7uAUgFfugiql/w+Kj4XDSpSn+zEQfPfz0E9Ofttgi4UE3T6IxSTqaiSiJurlNgv
         2nO7fVIYdKcIdpu81+wtEmJucFiqg+1+oPWVWLOrwWuWsnE+hfmBtqzx9UAXEujJUOWn
         811w==
X-Gm-Message-State: AOJu0YwJT70gOotuN9sjwN6ECMMwntvNtZp0ANOKQbBKAT+wv7HTwQRq
	mbP3vnkbPly1Y7qgjdnO6NZFNbE2pvBA/I2BgBBeWK9xefJBSscx12vZrR6qlrXcUOM=
X-Gm-Gg: ASbGncsnR7WCDrGhhDZBro2iydPy5867dzV6hf1eG7GsdOSu41wUvjaYYBxcWUzCpFA
	06nSiAfmquPMS6yNjoN14VkINvJjd6qkzaw87WFIkKEbGlasZy9stPBPnBOdnA8dIee1kj4jEas
	q/QCnmwHE/XKgg/VHJM0RlDPfXSQdcID1uhxkFsQI8E21VdrEkX7HFvI6spvHWyIG0vdYtsQwb3
	48+WClrp3TZahDjGPPb0OFKjU1/lRZ0RBuSIq+bfWsfJt0Tbh8ZqYCiNHqqlUyQsUT9AXhIWPXY
	a6/XyOyRVRiSEZQh714WLENJnsK4na5Myf7O2RW1e1tBk+TU60tsVxIkBqxfC3bpA39QhFQabO+
	6BcA5aq9ohQBg7JqycWuwTOg=
X-Google-Smtp-Source: AGHT+IE04+auEv0UXbVWZTmvn9ylSJZHD22lR7ax27VAICTmsQMA2XnnDWxUWxlnCuXNer9xkubZxw==
X-Received: by 2002:adf:e183:0:b0:3b6:18e6:22fd with SMTP id ffacd0b85a97d-3b618e6235cmr205109f8f.13.1752757441713;
        Thu, 17 Jul 2025 06:04:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:9e61:4694:c621:5693])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc22a8sm21113548f8f.34.2025.07.17.06.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:04:01 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Romain Gantois <romain.gantois@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] misc: ti-fpc202: use new GPIO line value setter callbacks
Date: Thu, 17 Jul 2025 15:03:56 +0200
Message-ID: <20250717130357.53491-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250717130357.53491-1-brgl@bgdev.pl>
References: <20250717130357.53491-1-brgl@bgdev.pl>
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
 drivers/misc/ti_fpc202.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/ti_fpc202.c b/drivers/misc/ti_fpc202.c
index ca415ef45cbe..f84cae50e2c9 100644
--- a/drivers/misc/ti_fpc202.c
+++ b/drivers/misc/ti_fpc202.c
@@ -118,8 +118,8 @@ static void fpc202_set_enable(struct fpc202_priv *priv, int enable)
 	gpiod_set_value(priv->en_gpio, enable);
 }
 
-static void fpc202_gpio_set(struct gpio_chip *chip, unsigned int offset,
-			    int value)
+static int fpc202_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			   int value)
 {
 	struct fpc202_priv *priv = gpiochip_get_data(chip);
 	int ret;
@@ -128,7 +128,7 @@ static void fpc202_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	ret = fpc202_read(priv, FPC202_REG_OUT_A_OUT_B_VAL);
 	if (ret < 0) {
 		dev_err(&priv->client->dev, "Failed to set GPIO %d value! err %d\n", offset, ret);
-		return;
+		return ret;
 	}
 
 	val = (u8)ret;
@@ -138,7 +138,7 @@ static void fpc202_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	else
 		val &= ~BIT(offset - FPC202_GPIO_P0_S0_OUT_A);
 
-	fpc202_write(priv, FPC202_REG_OUT_A_OUT_B_VAL, val);
+	return fpc202_write(priv, FPC202_REG_OUT_A_OUT_B_VAL, val);
 }
 
 static int fpc202_gpio_get(struct gpio_chip *chip, unsigned int offset)
@@ -333,7 +333,7 @@ static int fpc202_probe(struct i2c_client *client)
 	priv->gpio.base = -1;
 	priv->gpio.direction_input = fpc202_gpio_direction_input;
 	priv->gpio.direction_output = fpc202_gpio_direction_output;
-	priv->gpio.set = fpc202_gpio_set;
+	priv->gpio.set_rv = fpc202_gpio_set;
 	priv->gpio.get = fpc202_gpio_get;
 	priv->gpio.ngpio = FPC202_GPIO_COUNT;
 	priv->gpio.parent = dev;
-- 
2.48.1


