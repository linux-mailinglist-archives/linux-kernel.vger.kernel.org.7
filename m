Return-Path: <linux-kernel+bounces-784427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A1BB33B99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 11:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C291B257F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88242D29C3;
	Mon, 25 Aug 2025 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="1gq8ooi8"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9EB2D0C95
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756115336; cv=none; b=df6JHeTwFSyvUDyzw2Gwss1cOSwod+6BcuR/fFs6MoclI9o3CvOFxP9FBhvPCd+4+Ao45fLRpWuslIOpji37IrT2NVjdQPVmpNZnLXxFRJn1CFETfBoSNaoHcd6PnIh+Ckb7AhN7uoM7OBpJkv4i2q6G9SLInm8sUxNg/abmGh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756115336; c=relaxed/simple;
	bh=gsmPjfJ2QmHUYm2T6GbsR3/AGbz0mExN80EXjsadE2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RlOKPx+KY3pER751BBLr25ewM8iYcLEw0LwjLIQ8Cik7sCsrQyflMHzWEY9sQi0CxSx3dyEp0noXaFlcSFKR3IYtAkln3DZZ2cVjRNyov4cuvYNsWxhXne9GXRwF9ZreQ1djwR67IZkFKwldJ2n284PNROsSVVuQPOfsU7hbS4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=1gq8ooi8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c68ac7e238so1274393f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756115333; x=1756720133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1M2z9RjV0ZuXBRlE0vMWSKVCPkQUD2amGo6k0F1OlA=;
        b=1gq8ooi8d/eYqlMHVdifNqmt0133hfexOz/d5aiksX+etxbqfIpM3bdTMR5f39wiV5
         pgvhEbMKL/smgBYF2mOcgSsB8a8DXp9ZSdpFVPqKP+GIw/jtuVkhP0lJkwi97zGG4CSp
         4eAIapRIJCFrvxHhDNrmbyvD7mX7qn8watEwpn3P9ZS6H/dIUikVs11oXDusK9ib3S9Y
         nIDvA+9hc29SMyQLHhwiOUvwHzpgUXXKVKf5LtkfOhxtAvLtD9lAHhnei+mLPx0XX5ZF
         O9cpNg14SsyzJf+akfXAB69YJFnLbpRnDWXKynN+VocVSJAIG/NNRKRTpBMTT4csCYhS
         4PLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756115333; x=1756720133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1M2z9RjV0ZuXBRlE0vMWSKVCPkQUD2amGo6k0F1OlA=;
        b=mHbkx+d8jd7oewMYdK//tvbpoCZVHLxJOAQhn1JIJXZ359XkifNqtetFX1zG6/ptZo
         Ix29VE3U7G9g46aGmFQjTdcZMIQwvZPNOU+avjxkcXlYS/qhoBsH9tDW6us+bJl8k+F6
         VA28zuVO8LG6yBTYrMAJOtjw2AZhq9IBBg4TS0nHL3puZi7g50XZgSmmQJSO4r7ujkWg
         M7FuYiRySLWzCoKZtbfLBuEKa0uej79+DPadOEwnE8jfcyXwlFCe8s/+u16u3TL/zwUE
         XUoYEh+MjhQqP9QAR5L+9yfyLsrYtSM2YAtQUXaeqF4+XLYkA6aPj+LVR6wZ+0v8V+52
         xo2g==
X-Forwarded-Encrypted: i=1; AJvYcCVh54kCN0V0Gm/fmWkRWj+DHHWNHHhI0rkNwJFQog1VyVCxws0nMkc0743Xde3e4gw6AEZJHfsc5m7R8rU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2R6CNoOt0HROQ8deQ3/2822laiW87Jjc1nOVe4mLTUn/0O8R+
	bnji9uFP/1MrLA+pX/E8F0fW9oXNaApaaB5eWGiqPPEIoKof6MywBnyA00Q4WfbZNw0=
X-Gm-Gg: ASbGncsWthe3w2YzN+oDheF+c9mpRMkJttUuOxbAVwHn+tV1pRrFnD6CRxgbmaR+xCI
	VZNLrKNvgvdwZhenKC3szFP/o0HB7KaiN/hI+Cdrviplo5xZD0LvohzlRelz38UD9Q3Px9AGbG3
	ntWsTP6VcJYECC8nhKdoOcC4ipflCTDU9GGOG4JBvHcswXFzokmIOfjdlwk1+2zgsvFyo3MrFK+
	tZzxXjJq4D3U28UiLMzjgZwU0Pb2HJweQnYZI05gEXIj73WaS4iU/BcpmqN6O2AKv6rzpbnHCg4
	pjFWGh2lm/tvd0hX1ueTHRzHuQcxUnQfxNYEVASOJgUP5UtQ/oDFi722oqy/ODhu3nJkvd1jmjy
	fQ8Lb98Dq9OSXplUlUTh0LIOvztqV
X-Google-Smtp-Source: AGHT+IEzPBRol6ngRIiwBwafEdbjwrW6XPSWfLq8zxY1VDXJdLBaFNn9Mck8nqFBhHeSS6beuJE3Yg==
X-Received: by 2002:a5d:5f96:0:b0:3ca:10aa:ea82 with SMTP id ffacd0b85a97d-3ca10aaf4c9mr1072885f8f.13.1756115333081;
        Mon, 25 Aug 2025 02:48:53 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ef52:fc8d:34ad:9bfe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711bb1e3asm10877449f8f.57.2025.08.25.02.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:48:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 25 Aug 2025 11:48:44 +0200
Subject: [PATCH RESEND 03/14] gpio: hisi: use the BGPIOF_UNREADABLE_REG_DIR
 flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-gpio-mmio-gpio-conv-v1-3-356b4b1d5110@linaro.org>
References: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
In-Reply-To: <20250825-gpio-mmio-gpio-conv-v1-0-356b4b1d5110@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Hoan Tran <hoan@os.amperecomputing.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Yang Shen <shenyang39@huawei.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-unisoc@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=LGZlUs6AQDs8ng5Nn7ommqnFHh3w6/vhUJqzq5JniBE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBorDF++jCG//VSmX9rtXyjEtDWZYRz4QSoScANu
 IK+WVARy/SJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaKwxfgAKCRARpy6gFHHX
 cnBED/4wgp55EodYkNBwqOjqiRN9M99fAcanaozgJqRlQ6HPSTZm65M8r55yUsHnL3eaalhzCkY
 q5x5HujE/m+jFPnJh62GmPp+Efs62oOw9MJvF04gW+M9yKCEPBZjOUOnQXpVrlSm1GslyqhpAj5
 Jt9k8/5wWjYUbKIwt343yCHgNbYwm9UCGp9oWeH3faWThhxe3KDZtRi9iU+BLmFtqz5h1CEY/4M
 tUFXNsPpwioCRKDCAu+nsnaeIP3tIt+Ez07yyDerqF74fK0TIB6cjn+Tv+8KCz9Byf1bzTZcbEg
 ZUNPrmRJtfkv9q5DBkSB7Cfj6o7EhjvuTG7hEzcxx0zTJ13CEF/yD+VpxnI6V7T1gRrK0xRy0um
 zjiudnsQRpqzkvjQ9pbBSAmR7GbieSo7K8Hq01YZij2Hc0UleRJxWq5Bcvt78abclVn9Mh26hJ9
 T/Ykt3NKI4F1IcfLrTJHlAhkYO4wHmVw2g78JF/BPXhMzHR6rgn76f+tERkHRUSPLPVSsNG4efs
 qOSYjv/xO39rLGb4UKDJei9qCw7ssl2tez4WYUWOORldfzUShAw+dkbUwjsWXd4PXSpO3P1BeQd
 SeeCebsxhkQlIFAQk8aJODB3ZgOmvWZ1SsCAdOCPDXHhn9fs9Vb2sGIYPRGsc8STeDPjLIXgPE/
 yyaad6906fNYAww==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There's no reason for this driver to touch the gpio-mmio internals, we
have a dedicated flag passed to bgpio_init() indicating to the module
that the DIR register is unreadable.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-hisi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-hisi.c b/drivers/gpio/gpio-hisi.c
index ef5cc654a24e2327510b872563e68fb0b9aaef71..6016e6f0ed0fb80ea670ebb575452d9ec23976fa 100644
--- a/drivers/gpio/gpio-hisi.c
+++ b/drivers/gpio/gpio-hisi.c
@@ -295,7 +295,7 @@ static int hisi_gpio_probe(struct platform_device *pdev)
 			 hisi_gpio->reg_base + HISI_GPIO_SWPORT_DR_CLR_WX,
 			 hisi_gpio->reg_base + HISI_GPIO_SWPORT_DDR_SET_WX,
 			 hisi_gpio->reg_base + HISI_GPIO_SWPORT_DDR_CLR_WX,
-			 BGPIOF_NO_SET_ON_INPUT);
+			 BGPIOF_NO_SET_ON_INPUT | BGPIOF_UNREADABLE_REG_DIR);
 	if (ret) {
 		dev_err(dev, "failed to init, ret = %d\n", ret);
 		return ret;
@@ -303,7 +303,6 @@ static int hisi_gpio_probe(struct platform_device *pdev)
 
 	hisi_gpio->chip.set_config = hisi_gpio_set_config;
 	hisi_gpio->chip.ngpio = hisi_gpio->line_num;
-	hisi_gpio->chip.bgpio_dir_unreadable = 1;
 	hisi_gpio->chip.base = -1;
 
 	if (hisi_gpio->irq > 0)

-- 
2.48.1


