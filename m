Return-Path: <linux-kernel+bounces-793174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D499B3CFC7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 00:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0833520658E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 22:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83C25B302;
	Sat, 30 Aug 2025 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc5no/gx"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381E7231C91
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756592056; cv=none; b=XUayutNc36TzfYhx5XwUbYE/ze7IxBHsZrco5HrGfYkWyxj41fLbhwf64TWl6aGBMBP7GQ/MJ9lxDXoGzb7l0eY3tX8WvjObM/Vca1W1sbYVBshgTIau3bRmULagjncvUBFg/YzjfXUTrQeQ8WJy4OaH/SpQLuvOagjiv45IOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756592056; c=relaxed/simple;
	bh=D2HxL40Dgm4l1q2zEU2i9dHna8lkUx68aBpCEXsJgRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kSraz4rjtFt8eSVQ5Te+Khmx7CthbiqlOgLtihvz5UUttuH207vseQ83EyCNY4iU8oZqQQTzgEjkqkAULrhwtiBQrt9A/ufLt5SY62/te2+L5EvqT2dngEVIfFnPBIgSPuIkq9WlVTivaEVo1XirTHPMfOiRW4ZZqPkBSQC7ozU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vc5no/gx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afeee20b7c0so423631566b.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 15:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756592053; x=1757196853; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YNGjlJl5Qdfixvejv/BUl73WC2NG2Hs0Tn9jzjM9Chc=;
        b=Vc5no/gxC5bDp2GpJaVkbRbTUAaI/B4ZcCDBcA+xdHZ87k2zYFQFZ98gDNlqnSInTb
         OXYoQ9WmV/hFIUcg0eZ0MZAlYqf3rCaz2TjUAP+r2sD5a8m2mtFGMHKU2T9kFR/JnN0y
         YPaIivU35qYq+fo1sIlIa9fMvtK3UkmOyfl4RP2mz6brubxFGelfvmiaVwJT8TRqkpdV
         87czRMDUJi49CWzdneoPHuO5ZeIcIElO7fxz//33JqOlAjUlrNus04Ocsw8hX9Y90COr
         9og0m3I7JoB8b7Awa1pWLJJ62U9QUCkeP4JejMADU5aJkZj+Co+4iWjfKgg+anHX+vQo
         1Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756592053; x=1757196853;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNGjlJl5Qdfixvejv/BUl73WC2NG2Hs0Tn9jzjM9Chc=;
        b=VN92jih51awuda4FbaQ3K64vw/Yol9PFUnZnPvZs+AfhqAOjLJ/+omQNZFyjinslpc
         eS6ajd7MpLUGpK+6Uey+ijjR8vXUrH+NescWLZ0a5b7Ptnj0SIsVt01Arly9wbPBeZsS
         h5mCH/w8v6xucTd/5IFpicSFqZT6n9Nb9DRpbcSXuaI19CRpM+WBpx3b9Qi4M3Gq130d
         G91cpRnx7F0YvD103b+6BmUAk6uY0B5HNBmbVKTtTTDj/k9EMpUU4Bzqw3m27JbXaZTN
         UmwC5EGKTI7wEEuWJE/UQKu47hEdPb9kOpaQgwR+4gU/5/dtJKakZmLGFUOfMkq39qvx
         kaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbrE8km/qw1x94OM0oHzd3w5NPhYD7d7OM5/xyjHIpZpH2AXUEIBgNWk6nKiD5Lo6W6rtMUFLL7ZVhYWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVso0B+4BSV3CkbxbFGIlGEIdFIargDp/jLFFhWmUvBoRphYND
	W2rNrC+PeasaGaCawEgua9fxb/Sw1Njboukjz9eS0BXL9CK96W9b70MC
X-Gm-Gg: ASbGncsyW8s+K0gTQLNYXickk9QeD99qS+KHyRay6xES8vz/Fc05macrItv9ibELOum
	0CcZjboZAJopHbeGt4EjPrfrF5U5t9UYtdp0VnNAjBduxU2stljIyAd0JapNyAQFxppA3YSPc1Z
	1e6pO4FlGZTz2qGuCrzXRPBuUEwnVegrVWt/NrzLrn5/9IXYh+x3gtLgsbgpCCb3lIkWbRL9tB9
	MtjM4dCFzAhxlCvMf2y1SNX64OwpLuclNhSNUYgOiq8bWRkEyz0isPgf9MgWA4GyVhDpsrLlCFF
	Qn45mPgQKtUesDDqsLYiHReMQhV5zfYgZWgOI1C4LwgdLg+KRViYDStvObSVVtxXF51eSZ3zY7W
	LfrRfGKID92IHeibYRcHF
X-Google-Smtp-Source: AGHT+IHqi78E3a2KwFegHRRZMDud3ybIwvKBd2z4JvO4tPnf3z6ZAYdUlR5/YcFnKn6YIfR5t0Ouxg==
X-Received: by 2002:a17:907:948a:b0:afe:93e2:3984 with SMTP id a640c23a62f3a-b01d8a321f3mr267308166b.8.1756592053372;
        Sat, 30 Aug 2025 15:14:13 -0700 (PDT)
Received: from [127.0.1.1] ([46.53.240.27])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b018fe7c638sm240170966b.6.2025.08.30.15.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 15:14:13 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Sun, 31 Aug 2025 01:13:55 +0300
Subject: [PATCH] mfd: max77705: rework interrupts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-max77705-fix_interrupt_handling-v1-1-73e078012e51@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKJ3s2gC/x2N0QpAQBAAf0X77OoQd/yKJLnFFkd7SF3+3eZxa
 pqJEJAJAzRJBMabAu1eIEsTGJfBz6jICUOu81LbIlPb8BhjdKkmenryJzJfx9mL61bys9LW1iN
 iVReVA6kcjGL+h7Z73w9J8UAbcQAAAA==
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756592052; l=2880;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=D2HxL40Dgm4l1q2zEU2i9dHna8lkUx68aBpCEXsJgRE=;
 b=BKyduRRKUwTUjM5hjwLv1Rzxrz/d/PoJpL7I67nTbXjspcGuTTO0NWZ9+2eWtJDzEXbIzYtz4
 52d/1GtkbIjCL9m2rYdVDpsO1OJELScMXNyz5jehfwrkDZy5HKebfqD
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Current implementation describes only MFD's own topsys interrupts.
However, max77705 has a register which indicates interrupt source, i.e.
it acts as an interrupt controller. There's 4 interrupt sources in
max77705: topsys, charger, fuelgauge, usb type-c manager.

Setup max77705 MFD parent as an interrupt controller. Leave topsys
interrupts unregistered, because currently unused.

Fixes: c8d50f029748 ("mfd: Add new driver for MAX77705 PMIC")

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Max77705 has a register, which indicates, who is triggering irq. There
may be 4 irq sources in max77705: charger, fuelgauge, usb type-c
manager ic, and so-called 'topsys'. Hence, max77705 mfd parent device is
an interrupt controller. This series implements interrupt controller in
max77705 mfd.
---
 drivers/mfd/max77705.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
index 6b263bacb8c2..076357cb77a9 100644
--- a/drivers/mfd/max77705.c
+++ b/drivers/mfd/max77705.c
@@ -61,6 +61,23 @@ static const struct regmap_config max77705_regmap_config = {
 	.max_register = MAX77705_PMIC_REG_USBC_RESET,
 };
 
+static const struct regmap_irq max77705_irqs[] = {
+	{ .mask = MAX77705_SRC_IRQ_CHG, },
+	{ .mask = MAX77705_SRC_IRQ_TOP, },
+	{ .mask = MAX77705_SRC_IRQ_FG, },
+	{ .mask = MAX77705_SRC_IRQ_USBC, },
+};
+
+static const struct regmap_irq_chip max77705_irq_chip = {
+	.name		= "max77705",
+	.status_base	= MAX77705_PMIC_REG_INTSRC,
+	.ack_base	= MAX77705_PMIC_REG_INTSRC,
+	.mask_base	= MAX77705_PMIC_REG_INTSRC_MASK,
+	.num_regs	= 1,
+	.irqs		= max77705_irqs,
+	.num_irqs	= ARRAY_SIZE(max77705_irqs),
+};
+
 static const struct regmap_irq max77705_topsys_irqs[] = {
 	{ .mask = MAX77705_SYSTEM_IRQ_BSTEN_INT, },
 	{ .mask = MAX77705_SYSTEM_IRQ_SYSUVLO_INT, },
@@ -111,18 +128,11 @@ static int max77705_i2c_probe(struct i2c_client *i2c)
 	ret = devm_regmap_add_irq_chip(dev, max77705->regmap,
 					i2c->irq,
 					IRQF_ONESHOT | IRQF_SHARED, 0,
-					&max77705_topsys_irq_chip,
+					&max77705_irq_chip,
 					&irq_data);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add IRQ chip\n");
 
-	/* Unmask interrupts from all blocks in interrupt source register */
-	ret = regmap_update_bits(max77705->regmap,
-				 MAX77705_PMIC_REG_INTSRC_MASK,
-				 MAX77705_SRC_IRQ_ALL, (unsigned int)~MAX77705_SRC_IRQ_ALL);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Could not unmask interrupts in INTSRC\n");
-
 	domain = regmap_irq_get_domain(irq_data);
 
 	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,

---
base-commit: 3cace99d63192a7250461b058279a42d91075d0c
change-id: 20250831-max77705-fix_interrupt_handling-0889cee6936d

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


