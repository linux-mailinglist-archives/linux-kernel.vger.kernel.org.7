Return-Path: <linux-kernel+bounces-856167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53618BE34A7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90BAB4813AF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7622DF129;
	Thu, 16 Oct 2025 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="cC9hcMS6"
Received: from mx-relay47-hz3.antispameurope.com (mx-relay47-hz3.antispameurope.com [94.100.134.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040C323403
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.134.236
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616856; cv=pass; b=oYGxeRUKpRJQd6xMrNBFxwthYRqSGVYdiQf+B0ydSa2V+yO/VUzq5vkqsJDvvNO3IubgBAaJKeGJrkuvB+NigiRKW07uKSesHx0N4WivjcvMdeTkYwJQKR+aN/CPTTtTuDog2gXiARlZS4A8uFMLk5mUtpma+1B5D+cS6iVescU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616856; c=relaxed/simple;
	bh=gDYliFVKRhzKFyez/NM73UnYvTN0Nsle6RRiOViOM1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKDNSU2tNDSopYuHML9em0iOhHY2i0HxNfDHz9SBN2iyXkfnR8CtCABdKKM9OM8fuQtmCRrFa3khzrHfAYcjuBnNeYJ7bKyUH+XBcdYBeki5PeqcQf6Wdr0jKvbSss6vDGOPuZ6d23y+auTohVUY1LECBroFbCxM/LRq9ju64qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=cC9hcMS6; arc=pass smtp.client-ip=94.100.134.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate47-hz3.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out01-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=9v+GKfyCbjyqac8yEXZL8Yy4DrfcjhzklQMFWwfGwu8=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1760616843;
 b=cVqba+KmQjxuxnGvrNW3dT6hlaa9ygRABTqd+t+C34LjNUjJyzpN4YVMu8kiDtVLQVIDboj7
 3V+QQ2PzIhJ/UTYx3dVZhlb649pNcLkIl9a9tnQZ10Bd4P7D6sIDhUFnQiWfpESmFnzncmW9uhf
 ELVqBHyjCOW9PjglL0jDArdWByebJAjaw4DiJlSOj438zUswVyT26e0cdtVxxduRx2l3PFQ0IDd
 vfMvvAm6bVvr/AyqfdjL5TWIt8iogCudS6EQuM8E4PUBmuiyb6bqhBgQqSGOeUVtO18mYyQuT+I
 GkUFpeCQNp5coOVD9C/ckxNlCXSEyabOo2HLk1sj6eeXA==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1760616843;
 b=nYv1x54m5LXBBsRw99WFopp67wDGTl9J1iEtfTzw7bYZPMpE5fWtUbNfxK3DozuuvKX3Ja71
 lto9k7NLlV6Fy1IDKCYZMGdKeGu5az5FNW385hweXXCFLifTrwh1zNwjOrZ5c6sN1y8Dq54cGmC
 /Owm2TsL/hJNKvmixzoanaU+mxhY/6bVZEDGgabPsfizlwtBKckuUwARCR3pcZ52vCfIXTMl+fR
 Ku1b8ac4kQDmIuk1TsYe0u4joTBBIN8C8II/VZp6SpoSRtWVZ02cEP+bx9Q/QnqFhCFmoe32iEU
 iFBBRlojXwfhlCeuvNMG9N5YIqU/NnDpQEFBjQDHPghqA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay47-hz3.antispameurope.com;
 Thu, 16 Oct 2025 14:14:02 +0200
Received: from schifferm-ubuntu.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: matthias.schiffer@ew.tq-group.com)
	by smtp-out01-hz1.hornetsecurity.com (Postfix) with ESMTPSA id D8D49A40F89;
	Thu, 16 Oct 2025 14:13:49 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andi Shyti <andi.shyti@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 2/4] mfd: tqmx86: refactor I2C setup
Date: Thu, 16 Oct 2025 14:13:27 +0200
Message-ID: <844cb5c9559f957abe676e1f8fccc70d77038c5f.1760601899.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <5855f15ad83617d3a71b40d89d61273722c6e15f.1760601899.git.matthias.schiffer@ew.tq-group.com>
References: <5855f15ad83617d3a71b40d89d61273722c6e15f.1760601899.git.matthias.schiffer@ew.tq-group.com>
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
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay47-hz3.antispameurope.com with 4cnRgy2sjWz4MZyH
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:0699ac2813d803ef0eccfdc786415e08
X-cloud-security:scantime:2.575
DKIM-Signature: a=rsa-sha256;
 bh=9v+GKfyCbjyqac8yEXZL8Yy4DrfcjhzklQMFWwfGwu8=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1760616842; v=1;
 b=cC9hcMS6wrI8WqWFfp2NRg4ug3Q7roehZLZir1e7aI3g1tpn+TCwrQfTQJgebmTwISxfdNuI
 tnWpBT5LmTO9IO9v/zoBPLgfS0/89HzZp3EHrfAHfr3/6UruATTjkEU2Pf8e5OQi+w9JkrcJboS
 cTcxKizB3t9U5onjTUhXlbl/Px91eKQe6NjHesjt1iDQirg4o3fDCdNIPCAvNMnKmLXeja6qDzK
 KNIGpPmu6a6K0VI1YFHlmkD2KBHD8/o5jsqPRTge9sJes+jkdzGDBuXzfpZGHuxHAMGAD+GsRr3
 C2UM8mD/Ro5D7YbuciEgJ+Oj1GC7CQaxOy2mkieEI+cpw==

Preparation for supporting the second I2C controller, and detecting both
ocores and machxo2 controllers.

- Avoid the confusing "soft" I2C controller term - just call it the
  ocores I2C
- All non-const parts of the MFD cell are moved from global variables
  into new functions tqmx86_setup_i2c_ocores() and tqmx86_setup_i2c()
- Define TQMX86_REG_I2C_DETECT relative to I2C base register

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: no changes

 drivers/mfd/tqmx86.c | 130 ++++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 56 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 1cba3b67b0fb9..3c6f158bf1a45 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -18,7 +18,7 @@
 
 #define TQMX86_IOBASE	0x180
 #define TQMX86_IOSIZE	0x20
-#define TQMX86_IOBASE_I2C	0x1a0
+#define TQMX86_IOBASE_I2C1	0x1a0
 #define TQMX86_IOSIZE_I2C	0xa
 #define TQMX86_IOBASE_WATCHDOG	0x18b
 #define TQMX86_IOSIZE_WATCHDOG	0x2
@@ -54,8 +54,8 @@
 #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
 #define TQMX86_REG_SAUC		0x17
 
-#define TQMX86_REG_I2C_DETECT	0x1a7
-#define TQMX86_REG_I2C_DETECT_SOFT		0xa5
+#define TQMX86_REG_I2C_DETECT	0x7
+#define TQMX86_REG_I2C_DETECT_OCORES	0xa5
 
 static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
@@ -65,17 +65,6 @@ static uint i2c1_irq;
 module_param(i2c1_irq, uint, 0);
 MODULE_PARM_DESC(i2c1_irq, "I2C1 IRQ number (valid parameters: 7, 9, 12)");
 
-enum tqmx86_i2c1_resource_type {
-	TQMX86_I2C1_IO,
-	TQMX86_I2C1_IRQ,
-};
-
-static struct resource tqmx_i2c_soft_resources[] = {
-	[TQMX86_I2C1_IO] = DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
-	/* Placeholder for IRQ resource */
-	[TQMX86_I2C1_IRQ] = {},
-};
-
 static const struct resource tqmx_watchdog_resources[] = {
 	DEFINE_RES_IO(TQMX86_IOBASE_WATCHDOG, TQMX86_IOSIZE_WATCHDOG),
 };
@@ -91,28 +80,13 @@ static struct resource tqmx_gpio_resources[] = {
 	[TQMX86_GPIO_IRQ] = {},
 };
 
-static struct i2c_board_info tqmx86_i2c_devices[] = {
+static const struct i2c_board_info tqmx86_i2c1_devices[] = {
 	{
 		/* 4K EEPROM at 0x50 */
 		I2C_BOARD_INFO("24c32", 0x50),
 	},
 };
 
-static struct ocores_i2c_platform_data ocores_platform_data = {
-	.num_devices = ARRAY_SIZE(tqmx86_i2c_devices),
-	.devices = tqmx86_i2c_devices,
-};
-
-static const struct mfd_cell tqmx86_i2c_soft_dev[] = {
-	{
-		.name = "ocores-i2c",
-		.platform_data = &ocores_platform_data,
-		.pdata_size = sizeof(ocores_platform_data),
-		.resources = tqmx_i2c_soft_resources,
-		.num_resources = ARRAY_SIZE(tqmx_i2c_soft_resources),
-	},
-};
-
 static const struct mfd_cell tqmx86_devs[] = {
 	{
 		.name = "tqmx86-wdt",
@@ -238,13 +212,74 @@ static int tqmx86_setup_irq(struct device *dev, const char *label, u8 irq,
 	return 0;
 }
 
+static int tqmx86_setup_i2c(struct device *dev, const char *name,
+			    unsigned long i2c_base, const void *platform_data,
+			    size_t pdata_size, u8 irq)
+{
+	const struct resource resources[] = {
+		DEFINE_RES_IO(i2c_base, TQMX86_IOSIZE_I2C),
+		irq ? DEFINE_RES_IRQ(irq) : (struct resource) {},
+	};
+	const struct mfd_cell i2c_dev = {
+		.name = name,
+		.platform_data = platform_data,
+		.pdata_size = pdata_size,
+		.resources = resources,
+		.num_resources = ARRAY_SIZE(resources),
+	};
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, &i2c_dev, 1,
+				    NULL, 0, NULL);
+
+}
+
+static int tqmx86_setup_i2c_ocores(struct device *dev, const char *label,
+				   unsigned long i2c_base, int clock_khz, u8 irq,
+				   const struct i2c_board_info *devices,
+				   size_t num_devices)
+{
+	const struct ocores_i2c_platform_data platform_data = {
+		.clock_khz = clock_khz,
+		.num_devices = num_devices,
+		.devices = devices,
+	};
+
+	return tqmx86_setup_i2c(dev, "ocores-i2c", i2c_base, &platform_data,
+				sizeof(platform_data), irq);
+}
+
+static int tqmx86_detect_i2c(struct device *dev, const char *label,
+			     unsigned long i2c_base, int clock_khz, u8 irq,
+			     const struct i2c_board_info *devices,
+			     size_t num_devices, void __iomem *io_base,
+			     u8 irq_reg_shift)
+{
+	u8 i2c_det;
+
+	if (tqmx86_setup_irq(dev, label, irq, io_base, irq_reg_shift))
+		irq = 0;
+
+	/*
+	 * The I2C_DETECT register is in the range assigned to the I2C driver
+	 * later, so we don't extend TQMX86_IOSIZE. Use inb() for this one-off
+	 * access instead of ioport_map + unmap.
+	 */
+	i2c_det = inb(i2c_base + TQMX86_REG_I2C_DETECT);
+
+	if (i2c_det == TQMX86_REG_I2C_DETECT_OCORES)
+		return tqmx86_setup_i2c_ocores(dev, label, i2c_base, clock_khz,
+					       irq, devices, num_devices);
+
+	return 0;
+}
+
 static int tqmx86_probe(struct platform_device *pdev)
 {
-	u8 board_id, sauc, rev, i2c_det;
+	u8 board_id, sauc, rev;
 	struct device *dev = &pdev->dev;
 	const char *board_name;
 	void __iomem *io_base;
-	int err;
+	int err, clock_khz;
 
 	io_base = devm_ioport_map(dev, TQMX86_IOBASE, TQMX86_IOSIZE);
 	if (!io_base)
@@ -259,13 +294,6 @@ static int tqmx86_probe(struct platform_device *pdev)
 		 "Found %s - Board ID %d, PCB Revision %d, PLD Revision %d\n",
 		 board_name, board_id, rev >> 4, rev & 0xf);
 
-	/*
-	 * The I2C_DETECT register is in the range assigned to the I2C driver
-	 * later, so we don't extend TQMX86_IOSIZE. Use inb() for this one-off
-	 * access instead of ioport_map + unmap.
-	 */
-	i2c_det = inb(TQMX86_REG_I2C_DETECT);
-
 	if (gpio_irq) {
 		err = tqmx86_setup_irq(dev, "GPIO", gpio_irq, io_base,
 				       TQMX86_REG_IO_EXT_INT_GPIO_SHIFT);
@@ -273,23 +301,13 @@ static int tqmx86_probe(struct platform_device *pdev)
 			tqmx_gpio_resources[TQMX86_GPIO_IRQ] = DEFINE_RES_IRQ(gpio_irq);
 	}
 
-	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
-
-	if (i2c_det == TQMX86_REG_I2C_DETECT_SOFT) {
-		if (i2c1_irq) {
-			err = tqmx86_setup_irq(dev, "I2C1", i2c1_irq, io_base,
-					       TQMX86_REG_IO_EXT_INT_I2C1_SHIFT);
-			if (!err)
-				tqmx_i2c_soft_resources[TQMX86_I2C1_IRQ] = DEFINE_RES_IRQ(i2c1_irq);
-		}
-
-		err = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
-					   tqmx86_i2c_soft_dev,
-					   ARRAY_SIZE(tqmx86_i2c_soft_dev),
-					   NULL, 0, NULL);
-		if (err)
-			return err;
-	}
+	clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
+
+	err = tqmx86_detect_i2c(dev, "I2C1", TQMX86_IOBASE_I2C1, clock_khz, i2c1_irq,
+				tqmx86_i2c1_devices, ARRAY_SIZE(tqmx86_i2c1_devices),
+				io_base, TQMX86_REG_IO_EXT_INT_I2C1_SHIFT);
+	if (err)
+		return err;
 
 	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 				    tqmx86_devs,
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


