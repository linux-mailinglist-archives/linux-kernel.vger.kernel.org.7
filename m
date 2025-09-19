Return-Path: <linux-kernel+bounces-823788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34583B8770E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA491CC17FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D78C1BCA1C;
	Fri, 19 Sep 2025 00:01:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DBA3987D;
	Fri, 19 Sep 2025 00:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758240085; cv=none; b=eQ8b8zwKojF9aXiNwrbcHnrj/YqEjH/1E2ql2EuUJn04QnoMWK7VSPNprKGDv1Tfk9KzQ33d3kpWuwrwknIO7qmviOj/DA7fMxJn9zAwaaPbU7ecrwXyW38N0Eem2tFHEviUIrNtRccO10BJXN2gsdOKHnukaCRFlIvDzPmHW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758240085; c=relaxed/simple;
	bh=AGLpL8ozHA74H8FAdvO2M1aEr9vo4KPtCeJmMIG6cpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSYNPUIYGBqdAhF1NSNP7JEMKw+OIjuXCp4p4UWZymvf0rp3AonZDXz1JMeXy7gQFUgUQWWhofG/3SKAhReR7OeVK3BqSHgwId+9yxWF5d+7IwicBG8FW9nDLY+wVcDtJDRTApYbkQWaWwoG3BonQrjjiZS/PiUlP+3WD+jwqa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D3A11762;
	Thu, 18 Sep 2025 17:01:14 -0700 (PDT)
Received: from minigeek.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51FE83F673;
	Thu, 18 Sep 2025 17:01:20 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Lee Jones <lee@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: [RFC PATCH 2/5] mfd: axp20x: Refactor axp20x_is_polyphase_slave()
Date: Fri, 19 Sep 2025 01:00:17 +0100
Message-ID: <20250919000020.16969-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20250919000020.16969-1-andre.przywara@arm.com>
References: <20250919000020.16969-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some X-Powers AXP PMICs allow to combine certain DC/DC rails together in
a multi-phase fashion. So far we don't actively program those
connections, but we detect the existing setup, and prevent the connected
regulators from being re-programmed or turned off. At the moment this is
done in a switch/case construct, listing the known regulator pairs for
those PMICs supported.

To get rid of this ever growing code section, create a data structure
that describes the relationship, and have generic code that iterates
over the entries and checks for matches.

This not only cleans that function up and makes extensions much simpler,
but also allows to reuse this information for the upcoming programming
of those poly-phase setups.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/regulator/axp20x-regulator.c | 91 ++++++++++++++--------------
 1 file changed, 45 insertions(+), 46 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index da891415efc0b..19c9a98d1835a 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -1481,70 +1481,69 @@ static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 work
 	return regmap_update_bits(rdev->regmap, reg, mask, workmode);
 }
 
+struct dualphase_regulator {
+	int axp_id;
+	int reg1, reg2;
+	unsigned int polyphase_reg;
+	unsigned int bitmask;
+} dualphase_regulators[] = {
+	{ AXP323_ID, AXP313A_DCDC1, AXP313A_DCDC2,
+		AXP323_DCDC_MODE_CTRL2, BIT(1), },
+	{ AXP803_ID, AXP803_DCDC2, AXP803_DCDC3, AXP803_POLYPHASE_CTRL,
+		AXP803_DCDC23_POLYPHASE_DUAL, },
+	{ AXP803_ID, AXP803_DCDC5, AXP803_DCDC6, AXP803_POLYPHASE_CTRL,
+		AXP803_DCDC56_POLYPHASE_DUAL, },
+	/* AXP806's DCDC-A/B/C is a tri-phase regulator */
+	{ AXP806_ID, AXP806_DCDCD, AXP806_DCDCE, AXP806_DCDC_MODE_CTRL2,
+		AXP806_DCDCDE_POLYPHASE_DUAL, },
+	{ AXP813_ID, AXP803_DCDC2, AXP803_DCDC3, AXP803_POLYPHASE_CTRL,
+		AXP803_DCDC23_POLYPHASE_DUAL, },
+	{ AXP813_ID, AXP803_DCDC5, AXP803_DCDC6, AXP803_POLYPHASE_CTRL,
+		AXP803_DCDC56_POLYPHASE_DUAL, },
+	{ AXP15060_ID, AXP15060_DCDC2, AXP15060_DCDC3, AXP15060_DCDC_MODE_CTRL1,
+		AXP15060_DCDC23_POLYPHASE_DUAL_MASK, },
+	{ AXP15060_ID, AXP15060_DCDC4, AXP15060_DCDC6, AXP15060_DCDC_MODE_CTRL1,
+		AXP15060_DCDC46_POLYPHASE_DUAL_MASK, },
+};
+
 /*
  * This function checks whether a regulator is part of a poly-phase
  * output setup based on the registers settings. Returns true if it is.
  */
 static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
 {
+	struct dualphase_regulator *dpreg;
 	u32 reg = 0;
+	int i;
 
-	/*
-	 * Currently in our supported AXP variants, only AXP803, AXP806,
-	 * AXP813 and AXP15060 have polyphase regulators.
-	 */
-	switch (axp20x->variant) {
-	case AXP803_ID:
-	case AXP813_ID:
-		regmap_read(axp20x->regmap, AXP803_POLYPHASE_CTRL, &reg);
+	for (i = 0; i < ARRAY_SIZE(dualphase_regulators); i++) {
+		dpreg = &dualphase_regulators[i];
 
-		switch (id) {
-		case AXP803_DCDC3:
-			return !!(reg & AXP803_DCDC23_POLYPHASE_DUAL);
-		case AXP803_DCDC6:
-			return !!(reg & AXP803_DCDC56_POLYPHASE_DUAL);
+		if (axp20x->variant != dpreg->axp_id)
+			continue;
+		/* Is this the second regulator from a dual-phase pair? */
+		if (id == dpreg->reg2) {
+			regmap_read(axp20x->regmap, dpreg->polyphase_reg, &reg);
+
+			return !!(reg & dpreg->bitmask);
 		}
-		break;
+	}
 
-	case AXP806_ID:
+	/*
+	 * DCDC-A/B/C can be configured either as a dual-phase (A+B) or
+	 * as a triple-phase regulator (A+B+C), but not in any other
+	 * combination. Treat this as a special case here.
+	 */
+	if (axp20x->variant == AXP806_ID) {
 		regmap_read(axp20x->regmap, AXP806_DCDC_MODE_CTRL2, &reg);
-
-		switch (id) {
-		case AXP806_DCDCB:
+		if (id == AXP806_DCDCB)
 			return (((reg & AXP806_DCDCABC_POLYPHASE_MASK) ==
 				AXP806_DCDCAB_POLYPHASE_DUAL) ||
 				((reg & AXP806_DCDCABC_POLYPHASE_MASK) ==
 				AXP806_DCDCABC_POLYPHASE_TRI));
-		case AXP806_DCDCC:
+		if (id == AXP806_DCDCC)
 			return ((reg & AXP806_DCDCABC_POLYPHASE_MASK) ==
 				AXP806_DCDCABC_POLYPHASE_TRI);
-		case AXP806_DCDCE:
-			return !!(reg & AXP806_DCDCDE_POLYPHASE_DUAL);
-		}
-		break;
-
-	case AXP15060_ID:
-		regmap_read(axp20x->regmap, AXP15060_DCDC_MODE_CTRL1, &reg);
-
-		switch (id) {
-		case AXP15060_DCDC3:
-			return !!(reg & AXP15060_DCDC23_POLYPHASE_DUAL_MASK);
-		case AXP15060_DCDC6:
-			return !!(reg & AXP15060_DCDC46_POLYPHASE_DUAL_MASK);
-		}
-		break;
-
-	case AXP323_ID:
-		regmap_read(axp20x->regmap, AXP323_DCDC_MODE_CTRL2, &reg);
-
-		switch (id) {
-		case AXP313A_DCDC2:
-			return !!(reg & BIT(1));
-		}
-		break;
-
-	default:
-		return false;
 	}
 
 	return false;
-- 
2.46.4


