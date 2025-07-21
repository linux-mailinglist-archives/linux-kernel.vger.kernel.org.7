Return-Path: <linux-kernel+bounces-739090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FA8B0C1A1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02757189A5F4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FB02949FF;
	Mon, 21 Jul 2025 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mCMBux5e"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82E12951C6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 10:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094666; cv=none; b=a2fXjbJHaPeb46Sy47eA0PXxec3PKda7gCHcce/H/8GwH29X/0vh7xozxs0Ai0egn2P+KYgXS+wPUIHAnu+Kox1EsiAHFue6JfPkY8d3rb13vZE/dwibeWJFcn5IBSIsdS/5C61B5+C/gmPN8gT95S/px0Wl/YMQqdhiSEy3vZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094666; c=relaxed/simple;
	bh=eeZcPHFZpOhD4zGpk7fZOIrm0FhI2Ay4ZWryebwV3e4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bJbpjEjbun40kKo2CBXdzhvhCO3led8LaQi2XWkRyGVke91MgkCmc3kH3zNlDekJLYZT0WDSZdy5Ev9DQpunrRIGewXqp3w049W7UIPzdk1e3/URhyGa3hMSCfk08hinSu6gSQNIhcbhT/XToKspei7V4p8iW8Ken0iAtMIZcJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mCMBux5e; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753094664; x=1784630664;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eeZcPHFZpOhD4zGpk7fZOIrm0FhI2Ay4ZWryebwV3e4=;
  b=mCMBux5eo6yh0J1pouDGlZL1b5domwyzcnfSoVYjYQISbuAZthp6BvZB
   bzqNeTBawzt/BxOOWIL9lk8exrpJu4jDC+ccUllnD4OLjFI3ZQ9SCaCYQ
   DbUfma87yvINrMIx8PQF8nQCFSKXuEuSpigeATYrrm7QPxFu6OKRofmpm
   VInHPV0Qjphd5KUs3FFQQm+jCMY+iAi+4GD8km++K0r3HI7G0JPV13cbG
   rHECISbDGXX7u3Nz7fJbVfTQ6MYo9ni2u5AOXpawC8xVYC+jF0LELAn/O
   +foH2RaufTB4XOo27tcg00JNQj//vrTQ/Z7Cpz9O2sjKB5KNc1cHVWCrA
   A==;
X-CSE-ConnectionGUID: CsUIskr/T/eitnidkJP48g==
X-CSE-MsgGUID: 0iSy9X3VQZalEvopVExI4A==
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="44829020"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2025 03:44:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 21 Jul 2025 03:44:05 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 21 Jul 2025 03:44:00 -0700
From: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <dan.carpenter@linaro.org>,
	<bbrezillon@kernel.org>, <linux-mtd@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
	"Zixun LI" <admin@hifiphile.com>, Ada Couprie Diaz <ada.coupriediaz@arm.com>
Subject: [PATCH] mtd: rawnand: atmel: set pmecc data setup time
Date: Mon, 21 Jul 2025 16:13:40 +0530
Message-ID: <20250721104340.113581-1-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Setup the pmecc data setup time as 3 clock cycles for 133MHz as recommended
by the datasheet.

Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
Reported-by: Zixun LI <admin@hifiphile.com>
Closes: https://lore.kernel.org/all/c015bb20-6a57-4f63-8102-34b3d83e0f5b@microchip.com
Suggested-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
---
 drivers/mtd/nand/raw/atmel/pmecc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index 3c7dee1be21d..0b402823b619 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -143,6 +143,7 @@ struct atmel_pmecc_caps {
 	int nstrengths;
 	int el_offset;
 	bool correct_erased_chunks;
+	bool clk_ctrl;
 };
 
 struct atmel_pmecc {
@@ -843,6 +844,10 @@ static struct atmel_pmecc *atmel_pmecc_create(struct platform_device *pdev,
 	if (IS_ERR(pmecc->regs.errloc))
 		return ERR_CAST(pmecc->regs.errloc);
 
+	/* pmecc data setup time */
+	if (caps->clk_ctrl)
+		writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
+
 	/* Disable all interrupts before registering the PMECC handler. */
 	writel(0xffffffff, pmecc->regs.base + ATMEL_PMECC_IDR);
 	atmel_pmecc_reset(pmecc);
@@ -896,6 +901,7 @@ static struct atmel_pmecc_caps at91sam9g45_caps = {
 	.strengths = atmel_pmecc_strengths,
 	.nstrengths = 5,
 	.el_offset = 0x8c,
+	.clk_ctrl = true,
 };
 
 static struct atmel_pmecc_caps sama5d4_caps = {
-- 
2.34.1


