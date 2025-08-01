Return-Path: <linux-kernel+bounces-752981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B865DB17D5E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EBA587212
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF851F37D3;
	Fri,  1 Aug 2025 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Q/gE5Hqe"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CCD3C26
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754032747; cv=none; b=EQzEv2qDdGu3MlNbvag06fZOWakQG9/AWo5WUBloMaUAG5Mf83kpIyWQNpkE7AsI2ShATa92+BIqSnMLgo7PqUXBWs93nMfFSKViq19oIKVyh1I+aw99mvLaMXCcpYK021KCAst9bbDak9/ZQ2UyMB9pfulae06SSQS7vSNmwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754032747; c=relaxed/simple;
	bh=TYjLHC/Pp0ytAq/FGSdF8xCtocdkWfrMCnL4dVfmpek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pkNwxp8ntPwXnlOe/n2PTTTYDDsOQJaHSwZqPRqpt5MuWfjufaHrkPsicqUsVSgn3gPJSoPIsp0azn454ivb2QiYLbNxYsvG7i4n1xTUGkHIqx6oNOUkj80vys+/FgsRtdMyBC6ZiU6/jt7xnoJ9FK8ah02OsOjf8fPNdyvS5Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Q/gE5Hqe; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45555e3317aso2719005e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 00:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754032744; x=1754637544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6yXoFBX87IgNPakRa1KKSp0Mi46FaeH8eAGWkq4o2TU=;
        b=Q/gE5HqeJnWUs+tMwL+u2zW6Mncsjy1lfI6SGsW8pO389PAug8xln5jfj77TzNBE19
         o+t39+oVhXePvu4iSPDFIkuHmHi8UDfjuTjUoNlsq90sYYx5/OcZ8o+CEPU4xAUkbxU7
         qd45WPrCyLyt+pA7zs+r6c1OTlouXmdqzD9KW3PQdI0itiKmPMTpPN8qshjpps+SAW3P
         N3p6ohgBAufI+lkd0FnQOPmhK0J9J9Ek1vUZiHBrVRZ+JhLfc37no7sjUYaIuGqdSUbg
         eg+Yy53qCXprmmFkBtEFZhKMCZGm5oQaHPIxy/XttzXhBxBQcAjfw6yDGYj99gFUUNJ9
         d3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754032744; x=1754637544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yXoFBX87IgNPakRa1KKSp0Mi46FaeH8eAGWkq4o2TU=;
        b=DNMcZLF1HXErBD1g9yLrlQDOuFgbrICti7Z6gX5LQmUX66lohjCGpBFayz9Xv8lYKW
         rk3LoIUIQIJsZnrkeRP46Pr/bCCC0fge8Fg8rW3CCZ01T9mkjLMIQnMmEa9nV5UPH89f
         y4xDSSvD+pTLVet3kJDlW4+PXg2hg3ue5NuZMtBl2KR3blTaEzX34PC+dUPq9r0fSU2r
         EeGM96HBDxcuye1JJLNDipOT2Y3lSVf1LST92EdXqn9MBKbhdSQtfqL7myYQt6yxoTja
         2aV3YVhBXhfN+LlmgTsmNmG2beZZ/gv+350BmaM0s1gHzAuo6wRdgJXGX40e0qvCV3sm
         UizA==
X-Forwarded-Encrypted: i=1; AJvYcCVeSVrNeDYNhLzuN6hy2nedYdbPWlWZeYU4ywST4NKNy6dzjMsYSqaYMk3waU7qybblovxJvuBi0HH5OmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSijpcGdBI5NDn7DCE/8WVaoEp17TTX+pc2yDoSeGQKz3rzHON
	mFKIAkz0fouE4owNgorkJcar2oiV2c3loZB+GU6LC2rz76q3FOfTDoMQc8tq5nnLV9Y=
X-Gm-Gg: ASbGncu5HuFPIvmzz6yxozBiKhY3LQXIj2dgK5YETG1ZYzk+mL6mDOez0dNh9LtFSce
	I7t2sg3Xw0IbsP2e6gYfXRMFag4APLf0XLBiq814GmX+6INnM+kk+zLFhh1VSKuw4FMiwVBdxs3
	dO6Af6kevy8+MtRE5loY3365DyYrfK9NVE7nhThHDdbxoLwqZSrjqq3E0ILpK37K2wct8AZlOcJ
	iWEq654chG6nJPGrKi2eNYfA6CxU44tW4FkwsT5LHfaknP+BR1DkoGDDciOyIYecbqe8UVlD3dW
	7ypD5eb2RLNM/bDezt4kyBIVYmdIf8hfvbHaWsOQgDfCvegXHMQvEnQ3Yaa+F7AVjids4YBsSqh
	NYnvHEWOyGmARiqA73ULVfPnT
X-Google-Smtp-Source: AGHT+IFrM+1qPEm/v+IAgtQORrTytS39rb8W00LNW0JxurkZHcD7rv5qHPyt47qa17w0y5R6I+pY3g==
X-Received: by 2002:a05:600c:4fcc:b0:456:1a87:a6cb with SMTP id 5b1f17b1804b1-458a963c968mr15328055e9.19.1754032743750;
        Fri, 01 Aug 2025 00:19:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:a700:e8fb:ed3d:8380])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589edf5683sm54621895e9.7.2025.08.01.00.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 00:19:03 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Robert Jarzmik <robert.jarzmik@free.fr>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	=?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Subject: [PATCH] Revert "gpio: pxa: Make irq_chip immutable"
Date: Fri,  1 Aug 2025 09:18:58 +0200
Message-ID: <20250801071858.7554-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This reverts commit 20117cf426b6 ("gpio: pxa: Make irq_chip immutableas")
as it caused a regression on samsung coreprimevelte and we've not been
able to fix it so far.

Reported-by: Duje Mihanović <duje@dujemihanovic.xyz>
Closes: https://lore.kernel.org/all/3367665.aeNJFYEL58@radijator/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-pxa.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index 13f7da2a9486..cbcdd416f8b9 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -499,8 +499,6 @@ static void pxa_mask_muxed_gpio(struct irq_data *d)
 	gfer = readl_relaxed(base + GFER_OFFSET) & ~GPIO_bit(gpio);
 	writel_relaxed(grer, base + GRER_OFFSET);
 	writel_relaxed(gfer, base + GFER_OFFSET);
-
-	gpiochip_disable_irq(&pchip->chip, gpio);
 }
 
 static int pxa_gpio_set_wake(struct irq_data *d, unsigned int on)
@@ -520,21 +518,17 @@ static void pxa_unmask_muxed_gpio(struct irq_data *d)
 	unsigned int gpio = irqd_to_hwirq(d);
 	struct pxa_gpio_bank *c = gpio_to_pxabank(&pchip->chip, gpio);
 
-	gpiochip_enable_irq(&pchip->chip, gpio);
-
 	c->irq_mask |= GPIO_bit(gpio);
 	update_edge_detect(c);
 }
 
-static const struct irq_chip pxa_muxed_gpio_chip = {
+static struct irq_chip pxa_muxed_gpio_chip = {
 	.name		= "GPIO",
 	.irq_ack	= pxa_ack_muxed_gpio,
 	.irq_mask	= pxa_mask_muxed_gpio,
 	.irq_unmask	= pxa_unmask_muxed_gpio,
 	.irq_set_type	= pxa_gpio_irq_type,
 	.irq_set_wake	= pxa_gpio_set_wake,
-	.flags = IRQCHIP_IMMUTABLE,
-	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static int pxa_gpio_nums(struct platform_device *pdev)
-- 
2.48.1


