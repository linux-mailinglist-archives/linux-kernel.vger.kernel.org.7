Return-Path: <linux-kernel+bounces-827003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC95AB8FDCF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A2E421C62
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9079B2FF65C;
	Mon, 22 Sep 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vmM5zUI1"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7802FF142
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534863; cv=none; b=sc5Zfhb16cSN5tgLnJYLvKH5RRCtXebIE7avLLwJ7sBIa3Kc0ooD+Z88DZJyoMP0C8b4FCH01qYCOzE2Rwfk4RHJPrVlAqd0/FdsmVkQvUc3uIksvRQVf0oeK7Y1mOPURqmWcXbeGs6d7T/ztLFXIW33oyTYt+Le6sUqbqUZHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534863; c=relaxed/simple;
	bh=ofltCFGl+Fn0+xwFt5pJ6CBY56G2B9bdV+Mhu9zJhTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALF70HPOaL19fcWQkPSbqsgOIOmxsN9Fdmp20E1/KWbctObcHAD65VAxWVEZnJU70gxzhSTksKO63DvI86+QbTgcbPkqjp4W0ZErtYnmU/vMSIOPSWric+Ftp8ywJoNoZuvQIUYIseCwc+/QVaGDj9g/Z3ZsqoeX1UzmIwYZaeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vmM5zUI1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45f2acb5f42so31340885e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758534860; x=1759139660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aY7gg6UvtyCZjbjLbPkoMruJoAlaJpYh2FM5wNJH29Q=;
        b=vmM5zUI1pmJOO+jQacKZWRMHF6bf4Yohb3MyScrhW8yP4dDEe8FD/F0nOJUXa+OESt
         JKac4RUkRHLTUw8JbHjxroaYaLuYBbLbUSE7MK1V0JxVFPF/l5TpmA1qXyD8b1IzEeic
         CaRfNDkXluQVweGVjnyCO8qvrmyYHHXCuX5ParxTyWkJ4fPEKxij4VrGR+c+W0Zsg8Og
         TsSoS9Voc4r+SlXlHrZEtwuevpGU+7gHUGbgAS7k1Y3xN3dJJFmZDAqOcyTy4Uo+kBsi
         9yaBJkq98urkd1ZIqXaLbWWigrRoBW1+Oe27MK3sEsSFElICIBHgFsoKu3UXOyS/CIvx
         4pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534860; x=1759139660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aY7gg6UvtyCZjbjLbPkoMruJoAlaJpYh2FM5wNJH29Q=;
        b=iLqfNZoAsinsP8AmGydu38NWRAKmMY3ssEc2gwXEjOW89Z2cnRvAQYWeGev38ISdFH
         /9nZ5li5/GuvoNBwW8lSrywAiLrDG/KHKq1hRTxNJsuZIIC8hDpJJcrMz6AWESk5i56p
         tIWJjxZiG6aMoHCXkpkZ+R2YffkbNijSRk1YwgcfayphVp+zbcwP/v2iuKaEPI4V9Kmr
         BIvN+xuFvKB5pT3au8GBeRJtpXCFo3mr18sbuE2qimAhDPTKBsAi0V4PEVAIsAuzRNaX
         gsBJGxoL6564HyBzSPzSqB3CtUtUEiyJCepYYA5xQdbdrVOJj0b6dOqk+dBY+cWy2J8a
         sHXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2NQepH70pHCB77+3bPaFLdSVLkpTcPnCjd84X8u24VvYhzJIBxCtB3SElGPCStnf5zcFekur8L+zQLxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbgijz72In2LIBE5uvvE4OJ20UIoiBYiIacIs0piuA2E4FSSdW
	/lQ9mkxgLrl7albsFbKGSQcMABPNZXDzfB1JPI2v2gbt4Q/MjwmUeLwlxnIetIXTaokPu8WFLul
	VxIVcnYQ=
X-Gm-Gg: ASbGnctKus5InQUVWHE9HB2MSKZILS1hPzV15kjrBn3JR5nDmeOMBiOxN/288Mz4b5e
	911u224demmi/3Z/eBBtKLaca0hXZ4kl2VDlypM5f6e7004PXqcsmktA0X1cJxcpduSbOPYPKqu
	V7eJGRWfVztf4WSTofm1b+FRwt5dyHgvtDDlBDwcc8ket5XqER1Csv4Vjw1aDLZe10HS29jEGjG
	KPxH5o5fmdNzB005TX8CE228ccGDVbeZA75n7k9S2Eb6bTkx/v/LypQ3LdXwLcy4hH3hnMsvQg8
	untRLM84kXxaW6Dx1sdN4+biiM4Dr4fTokIOgRaFrx/d5lvSzut42S6BimdymW2jnL9LaYzEvha
	2IGAGrm80yrWR4Pn5
X-Google-Smtp-Source: AGHT+IFZRkp3yQb+hAsG6r19lZiP+SsWQRLfndiVx65XjBARU/yVpKjFGkGSzHEkduqec7SW1Qc1Yg==
X-Received: by 2002:a05:600c:c0d7:b0:45b:9b9f:88cb with SMTP id 5b1f17b1804b1-464fdf4425emr112848235e9.16.1758534860304;
        Mon, 22 Sep 2025 02:54:20 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:824c:ead0:65a5:c51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-467fc818e00sm156496835e9.0.2025.09.22.02.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:54:17 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Sep 2025 11:54:05 +0200
Subject: [PATCH 4/4] gpiolib: reuse macro code in GPIO chip printk helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-gpio-debug-macros-v1-4-d99739dff711@linaro.org>
References: <20250922-gpio-debug-macros-v1-0-d99739dff711@linaro.org>
In-Reply-To: <20250922-gpio-debug-macros-v1-0-d99739dff711@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1596;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=O0thVIKyYLe+KZxugdYojp6zmN2ZinwZZo8q3GtWnQ8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo0RzBwHBNnfnUgbrI7iQmF5iEIfyvMwZrkluZM
 H2fvYPCC5iJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaNEcwQAKCRARpy6gFHHX
 ckMtEACP4qOB8drJaVklPS0jwn0SwPGitzkS2g996cRJd7yYmzpznpFyFLdMJhho9PqrxBzMC8a
 kCPcZ26V6f6oJzLzd0Nn8jFPOexjhmEdvZYOCFPR4+rl2NTRu1rIJDAtdMZ0yWrtCcygPImOgkI
 GBZdbgm8SiQYYVTEOs2sNvK57pqUdV0ndQGGvGRP48adctic3D0tOnQwroIbl9U7arC2yhJMPKD
 q6S9OiZc+z0Tyu0uJzOaInDPCVTBfA4it3ukDgprOCfav1hee2j0alFjyQN+m5oS0KMrqY0qmPh
 0z3V9mciLSUmsYMdvfN0P71KRS/SwQjNab/4Q9Uchr+8rn7cmX80rezENv47Mpwk3nDf/V0cFwz
 n5FofuzAb9u18ufK5tER6cfqeaE1qVuiXFGZAFQZMz3LqLO+ESAfYLaU+/e469PT5QRYaL62rsx
 x6LxK4+Lxti/sy4+bYpvqS4efpln7J7cIJcOi8euK+Mp7bybMOlEQNdmyC8pGYVk0TFpd3kyBua
 2WwyeCEqAORwL2oqD5CGF1blB5sq1eIZzKffbu3+S9CXVRY0UJ4uuOlvCYSYtSCbNq8g4TLRN/N
 JfhCiJyuCqjHG8uTaY7+k5jCF5dpQ9j0LTkvLOa1/JokBArIAAHLHxcpyW4EGHVL1Oe4rjdQJ7f
 ThLOMa8bBI9dRyQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The arguments passed to dev_$level() macros are duplicated across the
gpiochip_$level() macros so put them under an intermediate wrapper.
While at it: wrap it in a do-while guard.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index dd96b2c2e16ed1cad2a573e0dfec3ab7260da1a8..b4c5369f8a3314244424d0c90ba006f7568b314e 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -297,13 +297,14 @@ do { \
 
 /* With chip prefix */
 
-#define gpiochip_err(gc, fmt, ...) \
-	dev_err(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
-#define gpiochip_warn(gc, fmt, ...) \
-	dev_warn(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
-#define gpiochip_info(gc, fmt, ...) \
-	dev_info(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
-#define gpiochip_dbg(gc, fmt, ...) \
-	dev_dbg(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__)
+#define __gpiochip_pr(level, gc, fmt, ...) \
+do { \
+	dev_##level(&gc->gpiodev->dev, "(%s): " fmt, gc->label, ##__VA_ARGS__); \
+} while (0)
+
+#define gpiochip_err(gc, fmt, ...) __gpiochip_pr(err, gc, fmt, ##__VA_ARGS__)
+#define gpiochip_warn(gc, fmt, ...) __gpiochip_pr(warn, gc, fmt, ##__VA_ARGS__)
+#define gpiochip_info(gc, fmt, ...) __gpiochip_pr(info, gc, fmt, ##__VA_ARGS__)
+#define gpiochip_dbg(gc, fmt, ...) __gpiochip_pr(dbg, gc, fmt, ##__VA_ARGS__)
 
 #endif /* GPIOLIB_H */

-- 
2.48.1


