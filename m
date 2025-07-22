Return-Path: <linux-kernel+bounces-740301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12601B0D263
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3554A546FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FF028C5AC;
	Tue, 22 Jul 2025 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GmLsYwfE"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051E1DB122
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168553; cv=none; b=pWEh47IsAKpeR81Bh3uVO+hSEQo4AV0lal5h8nReBI/15PhvaSSEGiDPtOjJa6Mzm5PudPM1YofxaOpOHQg99vknKLAY6KmNrhY8OwDmHGAEL+n8eX+6PbIaOugLp/H3xbifh7TyKsJNU4yMJp67K9o2rbfEkS/UbjMP7WMW5r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168553; c=relaxed/simple;
	bh=j3SEh17yKJdtaTA6jlli22VQ1COpA7yRszYPMxwE5ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q6PRCdgw30ZRRMLLiVS+wqaMHkS4VQGjEUYIWJSjKTe79DoXMpmlOjQ59oHgDwPLxHMacAigxgPHFihBEgHAvbikZfyYaLE/ARxxtNJeREQjbAQZm60BuHHOK7XZtU18AFKJ35YC04Cs09ixUV0H5KIN5dWp0QAQAe8pMvVFx/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GmLsYwfE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so3584474f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753168549; x=1753773349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yQ3vEmjwKiSfWo9bCKh2Tpilewzv/3IegJxtxqqielQ=;
        b=GmLsYwfEZt2DxPLbUbEpaM+uBrXlN3zh4WmYZS8AdHX/DOEAaZUTYpyXoawmqGjg9b
         UsOnA/k0djcWLvz/BibjV8yHSqlxv2xcPDz+MRWyyvb846obFzPMHXLhGqC30rpz1nMS
         kitUX3FhbD4Ec+FJ0NI98wlkAjr8HShYdsaZ4ueRmOolVE/IjPciwdiOpt0fy9xi8USu
         Bt2icd2yIj7gonF7Z93qNkdeeIJSFEmX6uE8Rjqwz950XMjNxR0h3BMAbDUa3y3NDzrg
         +MTStH7bfn1H1Y+/Ws7EsGm5C9l4fb77kH+B8nBBXtedKTvEkq6KL4ZI7smHpph4So4k
         F55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753168549; x=1753773349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQ3vEmjwKiSfWo9bCKh2Tpilewzv/3IegJxtxqqielQ=;
        b=oXpnLFFP3NKWWaiXYqBF/dnfm8ZJGgapgEUsHnMHC6vLCde0Ekn76eUw3lxFE8GvL0
         rp+btdFVOQlVFOvYDj6ENjBx55J0ZIddvu9AUpM8jgqwcl/vUfbjs9anXgx4yFTFOvrp
         DR/WDeFDRoIa2cuv5OPazCAUrTtY2iEamghT+ODWq4A5vkpoNmVoi1qcrSMMHBUCiI4s
         tW22Kbk8JKq+mYBDctJzDk0pxNJ14gSQc8oePDW4VjsOJbXVJgLgF1Mou1Fd6V975kvS
         D1z7jD4YOLRNP33YXLC22asz8OpB7BLs8Tm6XHaWRJWQ15jStYjrs7o6tO0ZRUMNzeH0
         FfBg==
X-Forwarded-Encrypted: i=1; AJvYcCWt787g5VZSaglrcUgqC6VFYuP54RWTSZMsoGTzV4gW+ZC5twr8iEy624nJkqtpkt3sRMV69G11GLIk2EI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8r7EcMOvNGMEQXrDKDp/5HYsuoQgrNNXMkFtcRJkBRGWe12wW
	84AnXo0GqwgpQHJzpGakm/2C2H25AYz0/5pG0dXbkUFBducudy62UWALWHcyt9cCN30=
X-Gm-Gg: ASbGncts4xqdd9fN1jItlR49ZBSWrLWkznMM2BeJ7K+Sd6+rNvyU+soiSm5EUZJUtya
	TrUdgkQb5it7AqbjY++BbjjiQxWwQjWK0KbScPGhilbSuBrP2BOWmGgUT+tNfR3eD6CizF1lAyw
	Hw5w0++MKe8qMJkrnii+lpIvpk7q1wZXUd3mQzCyMW5s9mj7l6eMKyNfTK12hAXf24fcqsWMShM
	oA5fd0gFpJm8qVxUGNfw2jZEO7qXSEuvz1RAMpCvX+7iZW9QMwPhCXLGZq0oMMVqkVuhXi0tE/r
	k5LR6Df/4RJrt+Tw55z4b2pmy87ZFJfgjHUrZ98/1YvgcZD2OKTdxkp34WN7yEXW+MU0Sm0ICDC
	2XxByGJyWjaCcd+BXmCly1Nte/chwrLdi
X-Google-Smtp-Source: AGHT+IHYIREMnXqJzvIrKSlpu72TKoCe2oI41qKi1zUISJbrlyCEP1q0OUDLmdmVYJabSs5VX3PelA==
X-Received: by 2002:a5d:64c3:0:b0:3a3:71cb:f0bd with SMTP id ffacd0b85a97d-3b60e4d2b7amr16271092f8f.23.1753168548308;
        Tue, 22 Jul 2025 00:15:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:2548:4ac:d051:6197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c632sm12725706f8f.80.2025.07.22.00.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:15:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] ARM: sa110/gpio: convert set_multiple() to returning an integer
Date: Tue, 22 Jul 2025 09:15:42 +0200
Message-ID: <20250722071542.19030-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The conversion to using the new GPIO line setter callbacks missed the
set_multiple() in this file. Convert it to using the new callback.

Fixes: 9c3782118a57 ("ARM: sa1100/gpio: use new line value setter callbacks")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm/common/sa1111.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 86b271cc29e1..d7e2ea27ce59 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -578,8 +578,8 @@ static int sa1111_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
 	return 0;
 }
 
-static void sa1111_gpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
-	unsigned long *bits)
+static int sa1111_gpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
+				    unsigned long *bits)
 {
 	struct sa1111 *sachip = gc_to_sa1111(gc);
 	unsigned long flags;
@@ -597,6 +597,8 @@ static void sa1111_gpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
 	sa1111_gpio_modify(reg + SA1111_GPIO_PCDWR, (msk >> 12) & 255, val >> 12);
 	sa1111_gpio_modify(reg + SA1111_GPIO_PCSSR, (msk >> 12) & 255, val >> 12);
 	spin_unlock_irqrestore(&sachip->lock, flags);
+
+	return 0;
 }
 
 static int sa1111_gpio_to_irq(struct gpio_chip *gc, unsigned offset)
@@ -616,7 +618,7 @@ static int sa1111_setup_gpios(struct sa1111 *sachip)
 	sachip->gc.direction_output = sa1111_gpio_direction_output;
 	sachip->gc.get = sa1111_gpio_get;
 	sachip->gc.set_rv = sa1111_gpio_set;
-	sachip->gc.set_multiple = sa1111_gpio_set_multiple;
+	sachip->gc.set_multiple_rv = sa1111_gpio_set_multiple;
 	sachip->gc.to_irq = sa1111_gpio_to_irq;
 	sachip->gc.base = -1;
 	sachip->gc.ngpio = 18;
-- 
2.48.1


