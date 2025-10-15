Return-Path: <linux-kernel+bounces-854365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE28BDE2DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC67819C2C74
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55AC31BCB0;
	Wed, 15 Oct 2025 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="JH/A75Rc"
Received: from mx-relay67-hz1.antispameurope.com (mx-relay67-hz1.antispameurope.com [94.100.132.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F32315D4B
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526308; cv=pass; b=NDIRCVA+ERQJ0Q2V02FeVTExw7REtnqnK1NjVSGbN1dC+9tC6A1fD2xDyTiBnIysO8zZBnh18LUdt1773NM7wfla7/t2q8apejgdTnq5NBAlEebln+OhKP0jICXarNDRcY9h+NsdfpGVi0ow7T9R1CEs8Mvy4t/qHHHs/tgE4YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526308; c=relaxed/simple;
	bh=OCvfcbXuoCpeZFGmsuQFKHkAfBggH+KCZIYz3kkFP9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F2tgM/o6zaSjBkuBrJRcUIqw1X1axSsOcq6G3EEvjXqBK/FZgt3sG49sqxSlHbfq6OD514M5ZOfYDzsoAxbJF9J+s5HDJkI4FydWzhbrB4AP/Rf/BdPNcyH2IRPsa6Nwo5kZ01S/qvhAJuV/OEOQywiThYkcha0CuWdu2d7pfXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=JH/A75Rc; arc=pass smtp.client-ip=94.100.132.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate67-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=V452y9Hfsr5irYMFqPrKWAs2TWQwteCPJNKBahTxZRM=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760526254;
 b=OLh9SnkbHcFkIIKX1ANuc5mUx/Ts3dUIP7DjmaM3SpX0MsZ6EUKW7m7Fh8K8EW7CO9WNuz92
 H8OFbvSbuxgO0IctcVnH4m35YXZV4GBLO4zmeMoePN0jM72dsB83OW01uzxROfRaMWIZALuQ2cv
 BvPHQyy+u3GzT6Dt0O/OvCS5A+KHeUR+ZaYJf7ysw4n33IG6OZN6CNJLDCYfkic0cV+7vyRnBHG
 s5gPiQfAIYiaGIwNvOjZPLc9oYSJBvepCTVE+0VDvrr1LlCTg2GFDAMjaBxV2rlyLsbb7cO+ana
 tQhVq7+pqXlBwKqKt6VUkJcoVWVtssghZIhszfh/30jmw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760526254;
 b=dJGipc5TH6u4o3fvX1einzwbpldSlpf+yrVCqn7H3TFpAmJ+3BqI72TAmwPyYUa9ODEsKn8S
 d8dBHqavpx2CqLRNZLipoQwFwcvrJNdq+xrCD3AMDwpBvsNBcSNuJFCBoFaPrr6fzNYBTLfpdJL
 igm8CsG3M8nu2hoDUxoRoIhmqbZ8FHA4OJmq3LJaKPkLUw2BfvM8dfBJ84QtRC3PMz1k4i+GGuN
 dG6KlnP+KKwn/IRtFhLqD+q+gFt71u55AbfDn/ZtFI+aQTHUdSJ+0cSYrLq03pjtynWJ8HAGnU5
 3Z652H0+6GWNVZYipa1TgmbT5mChQ7AiGoiZeCU0MN3yw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay67-hz1.antispameurope.com;
 Wed, 15 Oct 2025 13:04:14 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 01F7CCC0E57;
	Wed, 15 Oct 2025 13:04:03 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 3/4] mfd: tqmx86: add detection for MachXO2 I2C controller
Date: Wed, 15 Oct 2025 13:03:08 +0200
Message-ID: <932c7e543ced2fa8969453ba9685445d7ef0c9ad.1760525985.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <9e00b0ff4e90e4fb31c3012bd7a753d06ae21b45.1760525985.git.matthias.schiffer@ew.tq-group.com>
References: <9e00b0ff4e90e4fb31c3012bd7a753d06ae21b45.1760525985.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:matthias.schiffer@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: matthias.schiffer@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay67-hz1.antispameurope.com with 4cmp9w2V7tzKp1y
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:c43876b5d7da1c449cb7ee17c3553cee
X-cloud-security:scantime:2.675
DKIM-Signature: a=rsa-sha256;
 bh=V452y9Hfsr5irYMFqPrKWAs2TWQwteCPJNKBahTxZRM=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760526254; v=1;
 b=JH/A75RcGUVQQ/V+K0i5q6/JkDT0180Zw7q76aM1eZBp5HzC1aUEC3frTjvohlRgpevrlDvk
 Cw4nbNGVlUkLLPMaUa33xXSwQQUVym6ScIGj7p0JGJvYvwvbTwAU4bc7U4RNbtWl4Pj1d6S0ffs
 q0HYiNWUpv+UKY8WL34kZcuqV34dBUr/ieWYfv/TDsbpqWbRDngvn5HagRkE37Q3GRKcivz/V1a
 p1vEa8bi4ubolz6g4iW/yyZlaXfAzRG5OLwoQ717a7TMzAczaW2wTl9ffE5g1sMzM2/elYBRdsT
 koDu5IliqMNPkyVazzH7weKzx+tMbTzfn/IwhbKNKawVA==

The TQMx86 PLD may contain two kinds of I2C controllers: the previously
supported OpenCores I2C, or the MachXO2 I2C. Add support for the latter.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mfd/tqmx86.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 3c6f158bf1a45..6447406f5026f 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
+#include <linux/platform_data/i2c-machxo2.h>
 #include <linux/platform_data/i2c-ocores.h>
 #include <linux/platform_device.h>
 
@@ -57,6 +58,8 @@
 #define TQMX86_REG_I2C_DETECT	0x7
 #define TQMX86_REG_I2C_DETECT_OCORES	0xa5
 
+#define TQMX86_REG_I2C_IEN	0x9
+
 static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
 MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
@@ -248,27 +251,53 @@ static int tqmx86_setup_i2c_ocores(struct device *dev, const char *label,
 				sizeof(platform_data), irq);
 }
 
+static int tqmx86_setup_i2c_machxo2(struct device *dev, const char *label,
+				    unsigned long i2c_base, int clock_khz, u8 irq)
+{
+	const struct machxo2_i2c_platform_data platform_data = {
+		.clock_khz = clock_khz,
+		.bus_khz = 100,
+	};
+
+	return tqmx86_setup_i2c(dev, "i2c-machxo2", i2c_base, &platform_data,
+				sizeof(platform_data), irq);
+}
+
 static int tqmx86_detect_i2c(struct device *dev, const char *label,
 			     unsigned long i2c_base, int clock_khz, u8 irq,
 			     const struct i2c_board_info *devices,
 			     size_t num_devices, void __iomem *io_base,
 			     u8 irq_reg_shift)
 {
-	u8 i2c_det;
+	u8 i2c_det, i2c_ien;
 
 	if (tqmx86_setup_irq(dev, label, irq, io_base, irq_reg_shift))
 		irq = 0;
 
 	/*
-	 * The I2C_DETECT register is in the range assigned to the I2C driver
-	 * later, so we don't extend TQMX86_IOSIZE. Use inb() for this one-off
-	 * access instead of ioport_map + unmap.
+	 * These registers are in the range assigned to the I2C driver
+	 * later, so we don't extend TQMX86_IOSIZE. Use inb() for these one-off
+	 * accesses instead of ioport_map + unmap.
+	 *
+	 * There are 3 cases to distinguish:
+	 *
+	 * - ocores: i2c_det is a TQMx86-specific register that always contains
+	 *   the value 0xa5. i2c_ien is unused and reads as 0xff.
+	 * - machxo2: i2c_det is the data register can read as any value.
+	 *   i2c_ien is the interrupt enable register; the upper nibble is
+	 *   reserved and always reads as 0.
+	 * - none: both i2c_det and i2c_ien read as 0xff if no I2C controller
+	 *   exists at a given base address.
 	 */
 	i2c_det = inb(i2c_base + TQMX86_REG_I2C_DETECT);
+	i2c_ien = inb(i2c_base + TQMX86_REG_I2C_IEN);
 
-	if (i2c_det == TQMX86_REG_I2C_DETECT_OCORES)
+	if (i2c_det == TQMX86_REG_I2C_DETECT_OCORES && i2c_ien == 0xff)
 		return tqmx86_setup_i2c_ocores(dev, label, i2c_base, clock_khz,
 					       irq, devices, num_devices);
+	else if ((i2c_ien & 0xf0) == 0x00)
+		return tqmx86_setup_i2c_machxo2(dev, label, i2c_base, clock_khz,
+						irq);
 
 	return 0;
 }
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


