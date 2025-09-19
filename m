Return-Path: <linux-kernel+bounces-823789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47747B87713
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC2EB7BB984
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC441EB5C2;
	Fri, 19 Sep 2025 00:01:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24924A01;
	Fri, 19 Sep 2025 00:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758240087; cv=none; b=VaqzNvQPm94/Tg4XdSpQlGfloFPRQDnXtRMayI7OMP2DAJjBWdYJ8NZm0G5bQjYvNa1Lm417hQU66aaiWZfHh7lHDvVogMbi68jBTfDnpvl3Wxx+LzttCj+bnkMjAVoJgniHB98E5divdTWb3dJippaXeavSvs/1DCJ056gjZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758240087; c=relaxed/simple;
	bh=cdIxo26J50n61tBpp0c4Fy/shWP6orIMRcVXxPYBqAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dm/INOk649gFqupJL070EKJaJiDptXT7DCbGNJbaQKa1nIKPqW56NFXhci5VdaSlKh7q0el65A6MU80Ua2t7rZQGbgOwfYXQLQ3CutlNyAcoqJ6try+1P8sKLSg1v0R0DVOSqxvAPNH5G0b3aL6a/DErvr61UKNpdziUnm8DXb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F191A1764;
	Thu, 18 Sep 2025 17:01:16 -0700 (PDT)
Received: from minigeek.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5E343F673;
	Thu, 18 Sep 2025 17:01:22 -0700 (PDT)
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
Subject: [RFC PATCH 3/5] mfd: axp20x: Allow programming dual-phase regulator pairs
Date: Fri, 19 Sep 2025 01:00:18 +0100
Message-ID: <20250919000020.16969-4-andre.przywara@arm.com>
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
a multi-phase fashion. So far we don't actively program those connections,
since the PMIC reset default for the multi-phasing setup was always
correct for the existing boards.
Now a new set of boards appeared where the reset default is not correct,
so we need to actively program the multi-phase setup.

Use the new data structure describing the dual-phased regulators, and
the new "x-powers,polyphased" DT property to enable or disable the
dual-phase setup on the PMICs that support it.

This works by checking how many regulators this DT property list:
- If it's none, this means any existing poly-phase setup should be broken
up.
- If the property references at least one other regulator, we can use our
dual-phase regulator table to find the register and bitmask required to
establish the dual-phase connection.

This supports only dual-phased regulator pairs so far, but we will
somewhat paper ov^W^W fix this in the next patch.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/regulator/axp20x-regulator.c | 68 ++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 19c9a98d1835a..e3acc4635a0ed 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -1549,6 +1549,70 @@ static bool axp20x_is_polyphase_slave(struct axp20x_dev *axp20x, int id)
 	return false;
 }
 
+static int axp20x_find_polyphased_reg(const struct regulator_desc *regs,
+				      int nregulators,
+				      const struct device_node *np, int index)
+{
+	struct of_phandle_args args;
+	int ret, i;
+
+	ret = of_parse_phandle_with_fixed_args(np, "x-powers,polyphased",
+						   0, index, &args);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nregulators; i++) {
+		if (!strcmp(regs[i].name, args.np->name))
+			return i;
+	}
+
+	return -ENODEV;
+}
+
+static int axp20x_parse_polyphase(struct axp20x_dev *axp20x, int primary_reg_id,
+				  const struct regulator_desc *regs,
+				  int nregulators, const struct device_node *np)
+{
+	struct dualphase_regulator *dpreg;
+	int reg_id, i;
+
+	if (!of_property_present(np, "x-powers,polyphased"))
+		return 0;
+
+	reg_id = axp20x_find_polyphased_reg(regs, nregulators, np, 0);
+	if (reg_id < 0 && reg_id != -ENOENT)	/* not just empty property */
+		return reg_id;
+
+	for (i = 0; i < ARRAY_SIZE(dualphase_regulators); i++) {
+		dpreg = &dualphase_regulators[i];
+
+		if (axp20x->variant != dpreg->axp_id)
+			continue;
+
+		if (dpreg->reg1 != primary_reg_id &&
+		    dpreg->reg2 != primary_reg_id)
+			continue;
+
+		/* Empty property means breaking any polyphase setup. */
+		if (reg_id == -ENOENT) {
+			regmap_update_bits(axp20x->regmap, dpreg->polyphase_reg,
+					   dpreg->bitmask, 0);
+
+			return 0;
+		}
+
+		if ((dpreg->reg1 == primary_reg_id && dpreg->reg2 == reg_id) ||
+		    (dpreg->reg2 == primary_reg_id && dpreg->reg1 == reg_id)) {
+			regmap_update_bits(axp20x->regmap, dpreg->polyphase_reg,
+					   dpreg->bitmask, dpreg->bitmask);
+
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
 static int axp20x_regulator_probe(struct platform_device *pdev)
 {
 	struct regulator_dev *rdev;
@@ -1703,6 +1767,10 @@ static int axp20x_regulator_probe(struct platform_device *pdev)
 					rdev->desc->name);
 		}
 
+		if (rdev->dev.of_node)
+			axp20x_parse_polyphase(axp20x, i, regulators,
+					       nregulators, rdev->dev.of_node);
+
 		/*
 		 * Save AXP22X DCDC1 / DCDC5 / AXP15060 ALDO1 regulator names for later.
 		 */
-- 
2.46.4


