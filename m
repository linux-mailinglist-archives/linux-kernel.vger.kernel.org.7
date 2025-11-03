Return-Path: <linux-kernel+bounces-883047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD0BC2C5A3
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40BD1897FA3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA6A3090D9;
	Mon,  3 Nov 2025 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eHeOqSJ1"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F9230504A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179099; cv=none; b=iTiD6inDhYj+RMlQB9TwwhfM+BZyvdD9/f1pKsw/WZnNFCed0h34Sb74zmJwZjnPQMoMOr3avLugBOmRgUPIMm2hKO9iOAcgGW5QQdHTrCmG9Zwrw8cPs4VFq+ByLNwm1Aket8E+xF86H9FhTBYE5JJCs91TCEHBKaxQ/65ihzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179099; c=relaxed/simple;
	bh=HQnWneIti34UKpZAUQ/is57Ufibb6gI6JwNgJWCLHsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/8BKYARGSy0U0l6e5wTcmYdmhxi66OCdmHQCc2qnCQtnrQvMKSuKXH2N/NQJMB4wDnn52DXBKxNCwPvaOWMWGvE7awliF51fQAJpCWKETDtxkWXrJtgKygWPE0CF17w1gCgvZBtr2EhB8DYeB+EDJVf2bcuGPixiKCzR9R8qEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eHeOqSJ1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429c82bf86bso1922302f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 06:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762179096; x=1762783896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kSzljl2vSfB2KsK4vQvqhLRyJ2e5/WktwTioP6a1UuA=;
        b=eHeOqSJ1J+eWEx40aYlL64jAFrNCmuCkEb4bURwQDUjfs8MGhcD60ZHQhN57PXaPqE
         GL+3eLHZ+psvGeNjmxY7TArU6TwFv0iAwzkdDmn5eOUFIhWINiy94gYB3OJ3bA0DNHEn
         Z6d51sl5U8Ka8jbpeDRn8XcpD+90zfJ3iNGDSYLxmla3K2UY2fHARriHd92/FJO6cIJT
         NN5Nr92ENXzywkVeik+A2CvKG9+6xk2K+MEaTsbVLeTrgNZIZYVnVvehtx7ZJEfSPw6K
         DdXDtqgbz+sY6W7aVDJtyyS5x7YBmfOpgQsoggNpRVkQrVwpWc0KeGZ9Hi7ykljYCZOu
         MZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762179096; x=1762783896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSzljl2vSfB2KsK4vQvqhLRyJ2e5/WktwTioP6a1UuA=;
        b=FYrDO8mwG+bSAmfx3A5SHUjKUZcJdJLk/xksJKnagQblgVp4n1ZNTYcHC/Z+hNQSb1
         j/idUq0IhZZaxwezOTXKZ/5fFuUt5tj6heQOZ1bLpo2zKXkn+vBOjxIky7imZ3yvWqm1
         ju7SBqzJGw6lGMdr5DVT0QFfO0hbzGf3iC/J4GUTvQcB5lpIKMamJRnek0+FIPCif4f3
         E9frrBlGNu7ODNgSkW7YIYaL1Ks87BdtoErwJ8NKMLcXmPAD+Ah7kLBHR9OLS7xi+KdX
         p/EGJzLw1CpNfCEnUvXP3hyIb3QNa6Q/wMh89vSM1QJXffDn3q3FTqtPcjf2bPILaytN
         iNog==
X-Forwarded-Encrypted: i=1; AJvYcCUZC3D5RLDQjMt/CmSlVjafQ2a+kquTK/IKCJpdnCdTghIIuwVqymj3fhciYyBEjIrscnePRuDtZT1rJfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlqoE3fHj7ZfC6T0J+E0odelerEFG0IZxMS5cwyw0rQvEbEXTF
	NzHzSHAZNtHy5AyWv18Kc8syomXKlQ1jAceOpBwmVtAJ7L6VCGXOERNVLcP7ykvFND8=
X-Gm-Gg: ASbGncuYuQNgZ40Vbhr/WdUc3svKG3u5XSN0NXGE0D4n/hprlqppHF/UJOqKbfHlpy5
	9vvS9RsAWahMMKdqBC+ecaHcaTRRdTgTUJxgfB0/hVN0Ebf2zfnfi09pRWK1PwzBN0TpKogWJP6
	D5OFcUhcko1mODwbJnygDFmKucXG1kspYhWtVDrWPXwhm7Huxc8fgCwql8RZHdE4kzmnXHvHNB1
	1unu732qQY0zNtbcAVy/NRgniM0OLhzybECkTkyjGY7NCDX1xG+97CoCTCpEMKLEIdpQ9In1dTZ
	+8KtCGcDjVlA1xjMa/Vj65t7hrRtlB46LSgReoPK0dTFvMnKjfQUQMQTOkyS1ecLOoJ2vEU+GBg
	3Gx6bR6VjgEu8AhLoUbk/V/jwp49nwQh2qYvHhcZMDX3lcb3jNlX/s8AgEDa/lHJcvn541GB9j9
	+qJgua
X-Google-Smtp-Source: AGHT+IFqqYKfmT7bErWcbRpXlobX5gBcmK7QP5Ztc3+1VYs+/djdxU9hq3cWC/5L3Nbzh8ctVpY7xQ==
X-Received: by 2002:adf:e197:0:b0:429:cc01:c6a1 with SMTP id ffacd0b85a97d-429cc01c791mr4262232f8f.28.1762179095990;
        Mon, 03 Nov 2025 06:11:35 -0800 (PST)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e0311sm20284249f8f.30.2025.11.03.06.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 06:11:35 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] gpiolib: fix invalid pointer access in debugfs
Date: Mon,  3 Nov 2025 15:11:32 +0100
Message-ID: <20251103141132.53471-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If the memory allocation in gpiolib_seq_start() fails, the s->private
field remains uninitialized and is later dereferenced without checking
in gpiolib_seq_stop(). Initialize s->private to NULL before calling
kzalloc() and check it before dereferencing it.

Fixes: e348544f7994 ("gpio: protect the list of GPIO devices with SRCU")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- Initialize priv right before checking it for NULL in
  gpiolib_seq_stop()

 drivers/gpio/gpiolib.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a81981336b36d..3659acc600d96 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -5303,6 +5303,8 @@ static void *gpiolib_seq_start(struct seq_file *s, loff_t *pos)
 	struct gpio_device *gdev;
 	loff_t index = *pos;
 
+	s->private = NULL;
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return NULL;
@@ -5336,7 +5338,11 @@ static void *gpiolib_seq_next(struct seq_file *s, void *v, loff_t *pos)
 
 static void gpiolib_seq_stop(struct seq_file *s, void *v)
 {
-	struct gpiolib_seq_priv *priv = s->private;
+	struct gpiolib_seq_priv *priv;
+
+	priv = s->private;
+	if (!priv)
+		return;
 
 	srcu_read_unlock(&gpio_devices_srcu, priv->idx);
 	kfree(priv);
-- 
2.51.0


