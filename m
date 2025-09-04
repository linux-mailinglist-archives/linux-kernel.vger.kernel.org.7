Return-Path: <linux-kernel+bounces-800361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD63B436C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04ED91BC192A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665832E1EFF;
	Thu,  4 Sep 2025 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="lN4LhAr4"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644142C1587
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977295; cv=none; b=OW415oQmICyPNBhcSjPvrXBxEK/6sCj+H/0jyE2FLlEAi86nkUCoB8qWAONXy+8H/DmnHO8lmJXA/r7cpgqxlBLsEcNMSH7bkhLaU/Y79l8dwv3R6RO6KbCO6ZJY8QKPaBNTSyueFDd1KjeGhh15gkh/w/3Ft6EZmiVw1ksdmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977295; c=relaxed/simple;
	bh=Js9WKlGR54rxKtb9FSB7t1WvKne4eF2EaDwjcYm16mE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MKGqOOiOMOt72jljsxEqNNHprA36Y5BZuIaeNzpgyn3o2Fiqm7jQmJrjccYi9CsbZomuQ7GZ2Heo9Qa0EBGKdF1e5HqSz0u5DtE9mQZGy92IQi/7ZB1C2ih76p4fDlBy1mkleUiCbrM2D3nNmycloK2b0RO/H2v3NkTMiae8nUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=lN4LhAr4; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 33BDB14805E7;
	Thu,  4 Sep 2025 11:14:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1756977290; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=B6QZEQAGrZ6/3rkKC265OmTZsvazFci2LpzaEltMG8Y=;
	b=lN4LhAr46QA2PDMQsbmJLuOwfONCabS9l0jHr5Jt7hNcIJ/ySJurLYYB+fRyOH40yRAWzp
	JyTt+STxlouZpYfPWOsjd02Fn+BGAXsSEI+rUayHPiArwkcT+30lA4eXbgqFrSfpG6OZbD
	sVF1RaRWjjyNYcC9ZAMU158SaXpDN3mxomDSDzLpQA9DiA24bIph3hMIbEWfQ8Zln9PriB
	ZdSWLgLO8CSPY7mV0BAgr8HiLbwqH+n6VEVsoe2zLRIBfNuxRM6vmD6WztEO9y/0ryHvLv
	QswgSpdoW88nFRKhNAxwvoqLoalqFIskmtZsv7vm4C5jyUzcielj0sq3NOWMFQ==
From: Alexander Dahl <ada@thorsis.com>
To: linux-mtd@lists.infradead.org
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
	Li Bin <bin.li@microchip.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Thomas Fourier <fourier.thomas@gmail.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: nand: raw: atmel: Fix pulse read timing for certain flash chips
Date: Thu,  4 Sep 2025 11:14:41 +0200
Message-Id: <20250904091441.351805-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Prevent PMECC errors when reading from AMD/Spansion S34ML02G1 flash on
SAM9X60 SoC, after switching to ONFI timing mode 3.

From reading the S34ML02G1 and the SAM9X60 datasheets again, it seems
like we have to wait tREA after rising RE# before sampling the data.
Thus pulse must be at least tREA.

The previous approach to set this timing worked on sam9g20 and sama5d2
with the same flash (S34ML02G1), probably because those have a slower
mck clock rate and thus the resolution of the timings setup is not as
tight as with sam9x60.

The approach to fix the issue was carried over from u-boot, which itself
got it from at91bootstrap.  It has been successfully tested in
at91bootstrap, U-Boot and Linux on sam9x60 and sama5d2, for several
months here.

Link: https://github.com/linux4sam/at91bootstrap/issues/174
Link: https://github.com/linux4sam/at91bootstrap/commit/e2dfd8141d00613a37acee66ef5724f70f34a538
Link: https://lore.kernel.org/u-boot/20240415075755.780653-1-ada@thorsis.com/
Link: https://source.denx.de/u-boot/u-boot/-/commit/344e2f2cd4a407f847b301804f37d036e8a0a10c
Cc: Li Bin <bin.li@microchip.com>
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    based on v6.17-rc4

 drivers/mtd/nand/raw/atmel/nand-controller.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 84ab4a83cbd6..87481b60f315 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1240,7 +1240,7 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
 					const struct nand_interface_config *conf,
 					struct atmel_smc_cs_conf *smcconf)
 {
-	u32 ncycles, totalcycles, timeps, mckperiodps;
+	u32 ncycles, totalcycles, timeps, mckperiodps, pulse;
 	struct atmel_nand_controller *nc;
 	int ret;
 
@@ -1366,11 +1366,16 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
 			 ATMEL_SMC_MODE_TDFMODE_OPTIMIZED;
 
 	/*
-	 * Read pulse timing directly matches tRP:
+	 * Read pulse timing would directly match tRP,
+	 * but some NAND flash chips (S34ML01G2 and W29N02KVxxAF)
+	 * do not work properly in timing mode 3.
+	 * The workaround is to extend the SMC NRD pulse to meet tREA
+	 * timing.
 	 *
-	 * NRD_PULSE = tRP
+	 * NRD_PULSE = max(tRP, tREA)
 	 */
-	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRP_min, mckperiodps);
+	pulse = max(conf->timings.sdr.tRP_min, conf->timings.sdr.tREA_max);
+	ncycles = DIV_ROUND_UP(pulse, mckperiodps);
 	totalcycles += ncycles;
 	ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NRD_SHIFT,
 					  ncycles);

base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.39.5


