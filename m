Return-Path: <linux-kernel+bounces-864549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AE3BFB0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D94A582CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C763101A9;
	Wed, 22 Oct 2025 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ZN6z/0po"
Received: from mx-relay02-hz1.antispameurope.com (mx-relay02-hz1.antispameurope.com [94.100.132.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3B230F54C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.132.202
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123786; cv=pass; b=nI8kLZ8g/vk+2QzGpAyhyGyMiHt6uACC+Pc655HBjecWTWLCBLlzJ1gOyyvfavmxbeI7K8N1SMf99Okfjgku0uERUBQOW8HqWKKhs6L9CF15LJUHuF3kaKI1SdGTO/mmC4+ED7gAWoyDhlx08VRDgdPVlIzHSvr47mEzHf7QbyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123786; c=relaxed/simple;
	bh=OVh0ZUwx27cW7RIRa1zzhCPbRQKVVM/TG+TpYX7rzsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlNEeFh0BsVuowim0Oy5apTot2hfIeKLU1hmvGuj/Klw3BX618S4IqQNkYsQoDnbIThJXebnKvE/Z+iN04KbSxMY3+q1RDtB/nxDXRpgK4FfNSgL+LhvNqR0ExNOAmwKbmlS42cqoADWKqc8Ey0uurvR3KiF/DpdxtKwr5BoCZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=ZN6z/0po; arc=pass smtp.client-ip=94.100.132.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate02-hz1.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=z9MN8x1a3dmQkT2iCoRwYtoRNiqkW2k/qHJlG0OXDeM=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761123716;
 b=RY0pNMGbmqw+dCrjRZeNW2nzGtl7hTD2kW0+PaPq92hhzH1U4GaEeFqVRm5hD6UjxrUfrrch
 OwLtTOxkGpHX1E/4zk/hlm4hLqBGkz/t413FFOjuK968JN1aJXs6UVJe9KP1oLz13O0LPpbh4rE
 fJ0G7ZLO2O1rr90Su3tVFEz0r5wVxy+jJudVkxmS1t1M+vlk9NTlm/+NbBNPVcFpGBnr+NgR9u9
 u5jHjZES/jjkza43bIDoFyOwY4+fBoZj1ljhvD98llcoHNYtu3/JS9QkK/eA3uFWeY+GvYxRJ0d
 gxUNOHPsmz5u40XFjZKVtDnlkLh4hTeOnGpr8Hydy5fUQ==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761123716;
 b=GG7iGWUCEdGdJK3Vn4AiB9Ho1paFKz6RMPNYYqy41zo2qoKIZipKaHQnerjC7hG8h2jIj6J2
 eKMKx5gr1ktv09a1Z0DtcojpIwlkluzELPEPeQnQ+EoUQKtrL9BL0o/+2GFOX5KcXC1zCOBa8D7
 s+gP51/VWEOSTR94vOM7WsMg/v2eX9WeDXXbXiTBTrHS/cUu0eWK4qcyZWA1OLqHsrY2GI5vr3U
 3SW26YQ4UCDMWBwurSU8XTsKBZes3ZTJ/8Ds+du1S/ZTrM+jdHLuIv0vkwgthfTuuuibgIAi/Z5
 /Abrnefw5lNMi9IZW1NyzWDrVTJcMECSCrYi3m/rGSOZw==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay02-hz1.antispameurope.com;
 Wed, 22 Oct 2025 11:01:56 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 390095A20FB;
	Wed, 22 Oct 2025 11:01:36 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 3/4] mfd: tqmx86: add detection for MachXO2 I2C controller
Date: Wed, 22 Oct 2025 11:01:15 +0200
Message-ID: <0f08a5785424e23a99aea82e539cc2fcec61b71d.1761123080.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <bc9ce42883d10d54bc0954024d7e2312ff45fdb6.1761123080.git.matthias.schiffer@ew.tq-group.com>
References: <bc9ce42883d10d54bc0954024d7e2312ff45fdb6.1761123080.git.matthias.schiffer@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay02-hz1.antispameurope.com with 4cs37N5kWZzR1JG
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:fcd2d86e937189137eebea87f5b8cfd6
X-cloud-security:scantime:3.441
DKIM-Signature: a=rsa-sha256;
 bh=z9MN8x1a3dmQkT2iCoRwYtoRNiqkW2k/qHJlG0OXDeM=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761123715; v=1;
 b=ZN6z/0posNBu0+MqNy7jUn3taqcVmMshwso+Lv7uqZPMvIr0iww8+Owz97edhOtdWoIaIgDC
 ZDSuB0lTHyS1XHy4ws6beJ6dncq5ZLvgT+VBODvzEY+F1zoZLGYTf/olUaO6McFAkDjkPGpUIFy
 wZSWNlmEydOUzjkK/mkusdldtLNIamiemVMZMiJ0gN2Se1SR+rSa0iBse+PCuvw4qrlD5tdkTrh
 a76L0joM8YLGG4l6RJM65341DWmLCYrpzBMrknLYVd6sU2aXwXw7Duy/SKN32QCBCXdmBegf1nL
 Ag1gpuwAW+abGGLbeYqJDe17qe3CkHW/LzHgGiEXBFK1Q==

The TQMx86 PLD may contain two kinds of I2C controllers: the previously
supported OpenCores I2C, or the MachXO2 I2C. Add support for the latter.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: no changes
v3: no changes

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

