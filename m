Return-Path: <linux-kernel+bounces-747007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08A9B12E90
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 10:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C4A17ACFA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 08:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6661E1E32CF;
	Sun, 27 Jul 2025 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="gIkkdEN6"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8D4148850
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753604690; cv=none; b=cETR+iqwJiVOMY7DXmO7zV2tkO/lfAbqfS+Jls6hXWRajGyaeSQPsHb9b9G5EiZPo8vKF+jlbR5kZtjThU1JYdNozACIRw7Xykt/7y/xGiyrB3pjrqJOXzlyYs/umeOMrqHOgjsfkpBfJTru+VGQ6LBGJXc9Kv7XHYwAtPngZIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753604690; c=relaxed/simple;
	bh=pCDzxxUimKSB3EwsfWX+tNITt36sdeo51kdPivLWWcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=US6qPw9ITeIP/vMM9GtwOFvYxKxKsS5MaPZYUjWOAQkzVIow+dmNk1WCZBzu6KdOLDmdM0Sk1XfKnPfV78XVF6o6bxaHFDD3wy96AWIaer8WmP3zSINWbSXycbE6ybxVyogtWqxKbocAkcbbFzgw21v7JSDRBuxyyAqmTk5JCNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=gIkkdEN6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-456108bf94bso20066765e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 01:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753604686; x=1754209486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Zp8NqMfP+9ZJxnvW6z72aJPcVY++D23DSoUHtspQxU=;
        b=gIkkdEN6Gwjh9Hj4j2CXqy/8h/LtGxx9uhA9h2zrfJkxY5EBOhB/H3MOmklfJdUYpH
         dLSW4JpB0D34Gy23PD9hCuVUIGZ+litflM20RC8rmaIW1Z8fRw0aBpm3AZzT44gba2E1
         sSUTg1JzyHJv7R4AkI1lUS6bP0udCvXG3ph9IfONLXcMTbILEcZFCk7e0z0x+FnUupWD
         ouWrbjUhOB8JJIqSmwYFCAPaKzAR4RwCLPC8RdDTGp4da+VK7ZQ0AyGBf3dxAfc+ZNPD
         57XOC3vTxeMPa2MTM9q+7K3D490X9kjsspnx/SBMpeWv9WEKA9byC/nI3jCaVD3k91HO
         Tabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753604686; x=1754209486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Zp8NqMfP+9ZJxnvW6z72aJPcVY++D23DSoUHtspQxU=;
        b=UAT6mKf9/Zyw4Z10qeTf+LhhxzDLiCfWeKUTxQc2SgmbwXiIYEJBO+1S2UhknF78Rk
         HvWq9F8irtMP5FGe/F/2ao8dtg4TYJsbBGknwXLgioysC0szB7jdlsnS0dvJb71zNE2V
         BKPquoE7PaElawjAutQOK/ndOt+gJR2JuDb1KNjcmsykuwcw8zmrfyYGsTw9ui0s6f4H
         cF5IF/e/8Fnfp+GIf+MUVUBnYHY8ro5wGq8SlWbfNwKa7+nhUGmSyuYS+6Io6tFDfHPe
         DULe/OEs4GeBBhhMfpYNAAl8HLajbPQRR9dGfu9n3XaovdVKDTXVSkc/7Mlt7K4U424T
         XNBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCvm895EjazGna30Rm5Uf/tXRPW8FZWbB60/rrnouD9RDsisauMSDGBeoMVDjQKgeDOzXyB10e8EIZj1U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx93Mc/9jkktmWH59cXr8s0FSFeXKm2nwJZWeIc4P5eNqxM2tgt
	TvC5FWy6eFeWgKo0zzUppi5to8v7ceuO64aXmm5PDyGMy8AUVFjwclXo5AIiSI8sevE=
X-Gm-Gg: ASbGnct2I8rXmK6sxxgYDt/QXPrTwl/46ugsfgMydlG3RzVVRYec9Iar/tUhiNqhukx
	knTn+IUWucTtGdSrg4GH48HhtRFXcGWBljg7eMUY0KrZTqP2jFeVHM3y2+rlBcv4gfTQTNemRG8
	jWatzu1j9qPKciSDPMOT7E9Ui97KktZIecoIy3ogG0PVGQu4qcDBDm9V3NNRH/UViUYmL6BLEAS
	gFkX/EL8b/8/11YuwWgpy3fKckNIE2AL/pBI4QcRKGFInZmF2azs/xB9H3cRTjYQyXzqdjI3XlL
	3qk1WC8YGGR2hF0AkjIzTLnHqDTuFHLPXyzH0I5+nfFp+3DNUVEqTn/66BmvGs8rIo/fAs4+6RC
	SaU5C0QcIagxJCeMZ4y+V
X-Google-Smtp-Source: AGHT+IG0veFybI//mpXDZL/MaqbtHsXicikTiM5496C0+N6+f4l7RapcJmOC2qPj/0wNY7u3GXYAYQ==
X-Received: by 2002:a05:600c:34cf:b0:450:d3b9:4ba4 with SMTP id 5b1f17b1804b1-458763032b6mr69544875e9.2.1753604685682;
        Sun, 27 Jul 2025 01:24:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7619:fb4:5db:aeb8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587ac58162sm54201335e9.18.2025.07.27.01.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 01:24:45 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] MIPS: alchemy: gpio: use new GPIO line value setter callbacks for the remaining chips
Date: Sun, 27 Jul 2025 10:24:42 +0200
Message-ID: <20250727082442.13182-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Previous commit missed two other places that need converting, it only
came out in tests on autobuilders now. Convert the rest of the driver.

Fixes: 68bdc4dc1130 ("MIPS: alchemy: gpio: use new line value setter callbacks")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Thomas: this flew under my radar until it came out in autobuilder tests
now. Thomas: if it's too late for you to take it through the MIPS tree
for v6.17, can you Ack it and let me take it directly through the GPIO
tree? This change is needed for us to complete the rework of GPIO
callbacks during the next cycle.

 arch/mips/alchemy/common/gpiolib.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/mips/alchemy/common/gpiolib.c b/arch/mips/alchemy/common/gpiolib.c
index 411f70ceb762..194034eba75f 100644
--- a/arch/mips/alchemy/common/gpiolib.c
+++ b/arch/mips/alchemy/common/gpiolib.c
@@ -40,9 +40,11 @@ static int gpio2_get(struct gpio_chip *chip, unsigned offset)
 	return !!alchemy_gpio2_get_value(offset + ALCHEMY_GPIO2_BASE);
 }
 
-static void gpio2_set(struct gpio_chip *chip, unsigned offset, int value)
+static int gpio2_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	alchemy_gpio2_set_value(offset + ALCHEMY_GPIO2_BASE, value);
+
+	return 0;
 }
 
 static int gpio2_direction_input(struct gpio_chip *chip, unsigned offset)
@@ -68,10 +70,12 @@ static int gpio1_get(struct gpio_chip *chip, unsigned offset)
 	return !!alchemy_gpio1_get_value(offset + ALCHEMY_GPIO1_BASE);
 }
 
-static void gpio1_set(struct gpio_chip *chip,
+static int gpio1_set(struct gpio_chip *chip,
 				unsigned offset, int value)
 {
 	alchemy_gpio1_set_value(offset + ALCHEMY_GPIO1_BASE, value);
+
+	return 0;
 }
 
 static int gpio1_direction_input(struct gpio_chip *chip, unsigned offset)
@@ -97,7 +101,7 @@ struct gpio_chip alchemy_gpio_chip[] = {
 		.direction_input	= gpio1_direction_input,
 		.direction_output	= gpio1_direction_output,
 		.get			= gpio1_get,
-		.set			= gpio1_set,
+		.set_rv			= gpio1_set,
 		.to_irq			= gpio1_to_irq,
 		.base			= ALCHEMY_GPIO1_BASE,
 		.ngpio			= ALCHEMY_GPIO1_NUM,
@@ -107,7 +111,7 @@ struct gpio_chip alchemy_gpio_chip[] = {
 		.direction_input	= gpio2_direction_input,
 		.direction_output	= gpio2_direction_output,
 		.get			= gpio2_get,
-		.set			= gpio2_set,
+		.set_rv			= gpio2_set,
 		.to_irq			= gpio2_to_irq,
 		.base			= ALCHEMY_GPIO2_BASE,
 		.ngpio			= ALCHEMY_GPIO2_NUM,
-- 
2.48.1


