Return-Path: <linux-kernel+bounces-877550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023E8C1E689
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B446C18925A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFAA32E13A;
	Thu, 30 Oct 2025 05:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba0sn1gg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283412D063D;
	Thu, 30 Oct 2025 05:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761801858; cv=none; b=Pdxm1phoufvKryhexvnZ8pjqddx165lpMyrp2N11j7nWSeFZCvtoeAh1RC3K/coclEpKclzIyTJr6+xccAvFIYn72PfMhoAlSz9EysOoGQL2O58Z8ECqLKk7NeiEZOOMqk/FDCNQy5s1ybFnRE8H5yuqMiZC75h+d3oFbEYjvtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761801858; c=relaxed/simple;
	bh=7PrPtqlO+xwMN6puDCOh8Tf+yRQi8msCbeKY70lBqSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ja56smi5MWd4WdUfKcEmZanPTXK39/ij/HAbcZk2ijYisFZuKlm4ZmKc23VbMqA4/wF7kD4w0JA+bVQOuTsuAnHEVV1ERlQ7GUb77knW0qhKJs2iAJ9OJzM7O+0rLTP6WlipFhR3MZkQP+fI4Sc8/lLmU5iNuHUbCOJtIaK6mt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba0sn1gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB1EEC113D0;
	Thu, 30 Oct 2025 05:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761801857;
	bh=7PrPtqlO+xwMN6puDCOh8Tf+yRQi8msCbeKY70lBqSA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ba0sn1ggI/79H0CiA2KfZtb+PuJZfu0J6FUZhhW/kSpdorEYmTY5veZhUeycILUuB
	 UcL7ghxSH9Epb5IloiBr/MklFdp5Dc12GnK0/7bAuhm7ZjGczYrhWeO3Xt/HPxnmfd
	 OgqV7y8PG06UoOYdxabsXtfDTJ+3sVexvebrS0LyC3okbCUlt7QT9tBMnnwKMhBPgH
	 hE88iu134EiV5UPHwVQiuTnjwRp1aOhS06jv5WhohA2F/ci+hHzUIxB47PqwG4H1Xi
	 HIWxyzvEr1R9PtSWJQ7D5Rl3DHPqx7ta/BSd0yRBHWyY8UR2dFcGeaGlCPtvfTIhMK
	 EWe7v5WzMD0kg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE853CCF9F8;
	Thu, 30 Oct 2025 05:24:17 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Thu, 30 Oct 2025 13:24:13 +0800
Subject: [PATCH v2 3/5] clk: amlogic: Add handling for PLL lock failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-optimize_pll_driver-v2-3-37273f5b25ab@amlogic.com>
References: <20251030-optimize_pll_driver-v2-0-37273f5b25ab@amlogic.com>
In-Reply-To: <20251030-optimize_pll_driver-v2-0-37273f5b25ab@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>, da@libre.computer
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761801855; l=2331;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=vrUlJ1HmRnCEyEkq2xDw1ggVFh4RddetWLmGLf94sV4=;
 b=cSkp9cTFFGr5sg6ASQ8L33zSJKDZR942ZJ8M8anl9qJse6qqWwezMYBS2WJrFMSpurm2Vpguh
 xbNHhPo/ZlBCEu/7QDJNyKvbgOsc82743NVagBbUZHSXjb5k+QBmYDc
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

If the PLL fails to lock, it should be disabled, This makes the logic
more complete, and also helps save unnecessary power consumption when
the PLL is malfunctioning.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/clk-pll.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index f81ebf6cc981..6c794adb8ccd 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -353,6 +353,23 @@ static int meson_clk_pcie_pll_enable(struct clk_hw *hw)
 	return -EIO;
 }
 
+static void meson_clk_pll_disable(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
+
+	/* Put the pll is in reset */
+	if (MESON_PARM_APPLICABLE(&pll->rst))
+		meson_parm_write(clk->map, &pll->rst, 1);
+
+	/* Disable the pll */
+	meson_parm_write(clk->map, &pll->en, 0);
+
+	/* Disable PLL internal self-adaption current module */
+	if (MESON_PARM_APPLICABLE(&pll->current_en))
+		meson_parm_write(clk->map, &pll->current_en, 0);
+}
+
 static int meson_clk_pll_enable(struct clk_hw *hw)
 {
 	struct clk_regmap *clk = to_clk_regmap(hw);
@@ -397,29 +414,17 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 		meson_parm_write(clk->map, &pll->l_detect, 0);
 	}
 
-	if (meson_clk_pll_wait_lock(hw))
+	if (meson_clk_pll_wait_lock(hw)) {
+		/* disable PLL when PLL lock failed. */
+		meson_clk_pll_disable(hw);
+		pr_warn("%s: PLL lock failed!!!\n", clk_hw_get_name(hw));
+
 		return -EIO;
+	}
 
 	return 0;
 }
 
-static void meson_clk_pll_disable(struct clk_hw *hw)
-{
-	struct clk_regmap *clk = to_clk_regmap(hw);
-	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
-
-	/* Put the pll is in reset */
-	if (MESON_PARM_APPLICABLE(&pll->rst))
-		meson_parm_write(clk->map, &pll->rst, 1);
-
-	/* Disable the pll */
-	meson_parm_write(clk->map, &pll->en, 0);
-
-	/* Disable PLL internal self-adaption current module */
-	if (MESON_PARM_APPLICABLE(&pll->current_en))
-		meson_parm_write(clk->map, &pll->current_en, 0);
-}
-
 static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long parent_rate)
 {

-- 
2.42.0



