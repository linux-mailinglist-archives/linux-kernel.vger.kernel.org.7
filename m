Return-Path: <linux-kernel+bounces-823790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC90B87719
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00AE1CC1E40
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F333E20468E;
	Fri, 19 Sep 2025 00:01:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246481EF39E;
	Fri, 19 Sep 2025 00:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758240089; cv=none; b=T8ad7ryAW07NZfTRWNMYuOxqbktNhTVBgZYuNifBO6hwS40BRY90XKuK2LhecEOAlXNgGj4L8uKkf1PYZVXhrW4XlTVkvw8KvVohKFs2TV3ZASTpHcgf2Y0ohfLinvVybzgc+0U8txK+Zj2zaaUiE1TD3dekHPvIDMo5CVZdIp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758240089; c=relaxed/simple;
	bh=hWfeolTkLmLOZzrDK+LL+Wr5aDUFlhHnjGWW9bVTJ70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLZOthCu2ZkQ+2fU3xfzxkhn9t9AoMr8ML4PhJYzijeKXCDNpj56gz+Vj7slaI3eRUaFDa5c/Gf5DigsFVhickyU+qzeVPifpZ7UuUiRACIyp9dMPWweLLhhn2A5L7pxsmDSSOshVqJ5DQH/uP0qAcpk5Q9uwMQN9dQhF0Lo0/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F7C11762;
	Thu, 18 Sep 2025 17:01:19 -0700 (PDT)
Received: from minigeek.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 760DB3F673;
	Thu, 18 Sep 2025 17:01:25 -0700 (PDT)
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
Subject: [RFC PATCH 4/5] mfd: axp20x: Support tri-phase setup
Date: Fri, 19 Sep 2025 01:00:19 +0100
Message-ID: <20250919000020.16969-5-andre.przywara@arm.com>
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

Of the PMICs that support multi-phased regulators, all but one just
support a dual-phase setup, with exactly two regulators tied together.
This allows for a simple data model, since just two is somewhat of a
special case.

However there is the AXP806, which supports a triple-phase setup, that is
also used on at least one board: the Cubieboard 4, where DCDC-A+B+C
together supply the Cortex-A15 CPU cluster.
Since this is just one case, and a fairly old one now, let's not boil
the ocean by coming up with a complex data structure that allows
describing arbitrary combinations, but instead handle this as a special
case. This is supported by the fact, that the AXP806 only supports two
specific setups: DCDC-A+B or DCDC-A+B+C, but nothing else.

Add a function that checks for the regulators on this PMIC, and handle
the two cases, plus the one without any poly-phasing.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/regulator/axp20x-regulator.c | 45 ++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index e3acc4635a0ed..9dd666f228b1e 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -1569,6 +1569,39 @@ static int axp20x_find_polyphased_reg(const struct regulator_desc *regs,
 	return -ENODEV;
 }
 
+static int axp20x_handle_triphase(struct axp20x_dev *axp20x,
+				  int reg1, int reg2, int reg3)
+{
+	if (axp20x->variant == AXP806_ID && reg1 == AXP806_DCDCA) {
+		/* no other regulator listed: single phase setup */
+		if (reg2 == -ENOENT && reg3 == -ENOENT) {
+			regmap_update_bits(axp20x->regmap,
+					   AXP806_DCDC_MODE_CTRL2,
+					   AXP806_DCDCABC_POLYPHASE_MASK, 0);
+			return 0;
+		}
+		/* only regulator listed is DCDC-B: dual phase setup */
+		if (reg2 == AXP806_DCDCB && reg3 == -ENOENT) {
+			regmap_update_bits(axp20x->regmap,
+					   AXP806_DCDC_MODE_CTRL2,
+					   AXP806_DCDCABC_POLYPHASE_MASK,
+					   AXP806_DCDCAB_POLYPHASE_DUAL);
+			return 0;
+		}
+		/* both DCDC-B+C regulators listed: tri phase setup */
+		if ((reg2 == AXP806_DCDCB && reg3 == AXP806_DCDCC) ||
+		    (reg2 == AXP806_DCDCC && reg3 == AXP806_DCDCB)) {
+			regmap_update_bits(axp20x->regmap,
+					   AXP806_DCDC_MODE_CTRL2,
+					   AXP806_DCDCABC_POLYPHASE_MASK,
+					   AXP806_DCDCABC_POLYPHASE_TRI);
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
 static int axp20x_parse_polyphase(struct axp20x_dev *axp20x, int primary_reg_id,
 				  const struct regulator_desc *regs,
 				  int nregulators, const struct device_node *np)
@@ -1610,6 +1643,18 @@ static int axp20x_parse_polyphase(struct axp20x_dev *axp20x, int primary_reg_id,
 		}
 	}
 
+	/* Special handling for the AXP806 DCDC-A/B/C tri-phase regulator. */
+	if (axp20x->variant == AXP806_ID && primary_reg_id == AXP806_DCDCA) {
+		int reg3_id;
+
+		reg3_id = axp20x_find_polyphased_reg(regs, nregulators, np, 1);
+		if (reg3_id < 0 && reg3_id != -ENOENT)
+			return reg_id;
+
+		return axp20x_handle_triphase(axp20x, primary_reg_id,
+					      reg_id, reg3_id);
+	}
+
 	return 0;
 }
 
-- 
2.46.4


