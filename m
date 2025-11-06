Return-Path: <linux-kernel+bounces-888976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B488DC3C69B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 600835073FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670D734EF18;
	Thu,  6 Nov 2025 16:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V3AHeMsc"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7099234E764
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445802; cv=none; b=to7CzYlaDO9whdr+F1nNf0Gqg/bBMFQfYd8wOj5SNxwytN4ZBpr1GOLED0udjiPUW1YFlkwczd9GzCT7w7bqNGdIo38kEo9yCRkDNxrDlof2SNR0qGjQoRiYvQD3rxgV0Br9uRaQ04w80vnZnrdDF6uk0LXT3SRx7lor1x90jA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445802; c=relaxed/simple;
	bh=bV1csp2rWHEChhH2wtc+ipip96VeBDB9QOyjlvKNG/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qB8qUcC8OGjERGVYXIh+65WK4kb7wxNLSdd7TU4IfZoLuA1nmHHz/ebA6YPYoXGT/XgtVne5YVa5qwnmLMJ2FkgxApBox1TXYehffm/jqYaP80BjPm6yZ/5FtjvPXYvkTzsRmd5p8MEM04zcxVSLP8ywNYyOkBpFri4izv+SLAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V3AHeMsc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64075080480so189798a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762445798; x=1763050598; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iuhfmQr7uINSDkC4BFuRhNQ4HVMgm7l+cfZeaeFW1fQ=;
        b=V3AHeMsc8mlt2GLfF+cHOG9j3kVISlP+olnI9TeRS5QqO+4alXKPP1SmlkcvcD8S+G
         s0hB1CMnejKP9vtvK0ZIg4wVTu5q1+QaIFQJJvQLTpzicF4bG2f1q02kBTutJdAvR5Nt
         U6LnOzU+U1Vy9veEyYDLIMCbSZL+opfv+2SDdhZL+P/U9N2N/p6ebIMESI4yNWy6poP7
         D1oK74FJVy0faUWXxTXMT1p0HY+DNtf0jxXKJuqEf01HTNilXrs8G5+fhL4wd+HRM5Xs
         vORGushxRGUtRRm9Bt14QGgkm/psww1YoNELS/iwFE4MwVM9ZgOsT7RVg1eyMqQ+UmgN
         4E3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445798; x=1763050598;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuhfmQr7uINSDkC4BFuRhNQ4HVMgm7l+cfZeaeFW1fQ=;
        b=X+6xxTVAmF9ZpqH7TNqucOAmq0YtkEx3BeJkT0RWq+rgHpZPfJ3KDBfSxTM/pBKest
         A0eQLnLmUAC/h/0swNMDdr9Jv7usmIX/Bqpigc7bCTBbSkjLXrqI90ylVXKlomwGTPgK
         WfpxdRVGhJVOsbuYIrxwLwJsHf9pQkL9p3JtkYQneg4CjK6g2VuRZNf8i3/qYQ60v9Xe
         2cKnRPexfPN4WDPMRI0QQOlJ/iWzAct3iEjkU0a9HC+ThwjxpIiP1DlRKuhVls3vU2+/
         zw160Lh6Yn4ggdgKNHZZNugPY3GF3ltiIlWyZwN2KC4/DcNVvrCwMzZ+7zBHA/pxkHXC
         34Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXufXRO9ghPB5DNOHaeLYI/qAI/qpaJJs9lTOb/4Erhjx+3MRGk1Gc5Fa9wmqokbabliHwTh0qguNrZpkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxltPazrzzoDcglnQiRaK60h1PbVi7s4muDaOpY0hpiEeMUe36r
	5jtbUfFGhuCOfTEEaebtFEZn7hJqMcUX0uWrRuZdNmJbz9V81NhDtdDZFyDjzz+vVpk=
X-Gm-Gg: ASbGncsOsuWxDCohnl+BABnNVSo8O0PI7tTxU71cOZcrg7/bb8c5XBBalpSOkNBfiFz
	OHiS9EqKUJKRGIpeBbH+m9R2D368KxkkDvp0o8emoOOL4o6mMEMuvbevmrT+8mN0bjfqfXokh/M
	UZMv1uWjuKr6fjHv/tdCUkj9A/+lN+fOn5InpAdS2QmVvk27LSjuAXtMrN54qoEbg6G7E4JGx8K
	Dzc2Mz5vtqKQI4o0wHV1hYf9pFck8aA4kqnvui3U1xzYl6EQVucRP40rM3tFi/oquTg+2krcTv3
	7DC+eEgiWqZ8YH2S2tCbdxgeWKNJLwP2afmj35rf8/ZTAH1LKiIbiWSnoJR3NpPeRhmPaw7E1pa
	2367AudW+Ps+QBDC4fIpA2DjSb7lxWtGjS0BlBdYxYdnutEP4gxNccFan/NHySTgGqfq6fPZhVz
	j2W3ymsoFi7xIoAXeiuEdbE2pu38E=
X-Google-Smtp-Source: AGHT+IGnKjqzbkhuvdWC2zI52BeV7MMIvf9OsVAI4XiKB15JDfOLSX5YIo7aBUdC8ZUdmjSM/iA6Sw==
X-Received: by 2002:a05:6402:358a:b0:640:be87:a86b with SMTP id 4fb4d7f45d1cf-6411f6b3baamr1693540a12.5.1762445798504;
        Thu, 06 Nov 2025 08:16:38 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eabsm2113408a12.11.2025.11.06.08.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:16:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 06 Nov 2025 17:16:25 +0100
Subject: [PATCH 1/4] gpio: tb10x: Drop unused tb10x_set_bits() function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-gpio-of-match-v1-1-50c7115a045e@linaro.org>
References: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
In-Reply-To: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 Srinivas Neeli <srinivas.neeli@amd.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1295;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=bV1csp2rWHEChhH2wtc+ipip96VeBDB9QOyjlvKNG/s=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDMne//1G4nx6sAjk0fip9F0NwApN5hshBoZuD
 RHWNh/iIoOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzJ3gAKCRDBN2bmhouD
 15IED/0XzrXZAYuaXb8FfmaclQ0RY6jfzxQrHGsf/WmuK02ww2efB75Exltpwwtm91fHOTkDU+T
 d2Kykn+OUAn6bPtd7LG5TSjCDI1tyM+/Nmd1wpAecJLUwG74wFPmu/ofjaxFh7lT6wZihV7lyHt
 8YmM+qnYuUolGhcqcfv7MDurJ8J2Bsqpat4m7N5nHOw++bPTo+SUOojVuhOwrXUI+9kKJ7myKLI
 cKXvLFDL0IOZDKcsJ6iq5nunmneht/iT7YFCKW6+gD1WTJpoziwV/6SXm8XJ6upKBSlnq9KxPSj
 NJ5fAe4+xkXGcBrd5oN7v7sbLM7FSPVyKlmrmHlv8YD3Vxl/t+0CwfwD/YkXVuUYFGOhPzRq1p1
 2eYQ0DqHsM9ulF4ZqHMFaRpLmHwNu1noNDT8MzzuoMNAWW4XN5JJtqeYlHHvlrcSFufrmyWAMpm
 5gZv8IPPiJx3Zw/XyFAwIepY+evhUcdg39kj+D/DVwWnTUGrdKgT/OYrpvvcE3Lxa+MjtAD3lji
 3DB8a4wIM9Y6xyQDaN3gtz5pxIPJGG+kyoN1ctUWXZlnUPRzzb20y01PoVvuhmiyPqOvVHa4+8O
 qGOKxXXWJBJOE+bPEc1yIlencBqk4SY4CpcNcxsvQ8A5Av5IswK60aumWzlZL+3v+oM/XHcxZeo
 xNC7jP93MIRL56Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

tb10x_set_bits() is not referenced anywhere leading to W=1 warning:

  gpio-tb10x.c:59:20: error: unused function 'tb10x_set_bits' [-Werror,-Wunused-function]

After its removal, tb10x_reg_write() becomes unused as well.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpio-tb10x.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index 09a448ce3eec..3c8fd322a713 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -50,25 +50,6 @@ static inline u32 tb10x_reg_read(struct tb10x_gpio *gpio, unsigned int offs)
 	return ioread32(gpio->base + offs);
 }
 
-static inline void tb10x_reg_write(struct tb10x_gpio *gpio, unsigned int offs,
-				u32 val)
-{
-	iowrite32(val, gpio->base + offs);
-}
-
-static inline void tb10x_set_bits(struct tb10x_gpio *gpio, unsigned int offs,
-				u32 mask, u32 val)
-{
-	u32 r;
-
-	guard(gpio_generic_lock_irqsave)(&gpio->chip);
-
-	r = tb10x_reg_read(gpio, offs);
-	r = (r & ~mask) | (val & mask);
-
-	tb10x_reg_write(gpio, offs, r);
-}
-
 static int tb10x_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
 	struct tb10x_gpio *tb10x_gpio = gpiochip_get_data(chip);

-- 
2.48.1


