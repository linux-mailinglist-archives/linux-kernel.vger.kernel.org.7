Return-Path: <linux-kernel+bounces-879688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F9CC23BE7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF9C563F71
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51E6338592;
	Fri, 31 Oct 2025 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baDVtwGw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295E73358D3;
	Fri, 31 Oct 2025 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898232; cv=none; b=S2++ZzFdHku9eGkkBxR1j20TO7qm/MaWStrdjRJ2YpVZ9TL3jzrHt2w76SYIubFZbe2lG5Shnh9DrsxO8eH8m64XSyfy3K+gpFyq87T2qvFSOoGRrM3KoQqNHmbVfwY4CfHKLy8QcWiq+Ymdx5Bq+FuO/BDZtyDD7mxMKYk5dU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898232; c=relaxed/simple;
	bh=vGQHDMPDFqEek7AC7vioPrkUtMWkS6rFq2XnbYgZrn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DyghyAnGYDroAFvzso/Zm55fysplFfFKL5HnJXq4OEJuNdeb2h0NkMtzvuDHumUG/b0T0w0TR0VaPSR0d3NWGij0NuzxXqKObLnt05Bq16ed0p9kjbOnb/1cT1yKcrCkrAgplWCUsFujrdF3O8NyVazQDYA2GGRJgBnQo3eGJbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baDVtwGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D85D0C16AAE;
	Fri, 31 Oct 2025 08:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761898231;
	bh=vGQHDMPDFqEek7AC7vioPrkUtMWkS6rFq2XnbYgZrn8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=baDVtwGwWEZYt+UDEM1ar6vK3vKVjULz9eLKORPnskN2po4rxCskU8oFZenmpRKkr
	 qs14Pz+dSqjSVp2Jhh5SXuTiPua8NeDGm43iSI0QKdZ83Nms1S67eaylQ4QKcoCSc2
	 RvtBpF5jtR21A2OvzBiOlYe8c2l4ua+Zq5R76SnJ/n/H7v6h0/q97KeefItvZVruLQ
	 CcrYPFXGr8b1eqzFqbDIsogDr1KBNllpGrpHmStINcgRVd1P9+KPD89J/QFz37gpzj
	 blqY/wtXsqdGU58bMuzu4ybC/bGybzSZLWuLU6Jvn6kUr7QuV7rb6qJjJX98xyJ01T
	 mc2Gnog6RucHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB94CCFA03;
	Fri, 31 Oct 2025 08:10:31 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 31 Oct 2025 16:10:10 +0800
Subject: [PATCH v3 3/4] clk: amlogic: Add handling for PLL lock failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-optimize_pll_driver-v3-3-92f3b2f36a83@amlogic.com>
References: <20251031-optimize_pll_driver-v3-0-92f3b2f36a83@amlogic.com>
In-Reply-To: <20251031-optimize_pll_driver-v3-0-92f3b2f36a83@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761898227; l=2329;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=hkOzDZETVE19YzYRyq9fWVkEGr8gDuc+o46inhx8Qtg=;
 b=0yISSorwaI3PsvRLs+sLpQCAQG8APu1fcHkVfPqejUNW58Qb+QbEUwch0hht03EjjJUmhPrDL
 YPlIXd+xxd+BAdMzBnAflA8/WX+agqrhOJvNxWA2XSdMK3A0BrXGNW+
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
index 70c8c7078046..cdb39a723bd0 100644
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
@@ -399,29 +416,17 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 		meson_parm_write(clk->map, &pll->l_detect, 0);
 	}
 
-	if (meson_clk_pll_wait_lock(hw))
+	if (meson_clk_pll_wait_lock(hw)) {
+		/* disable PLL when PLL lock failed. */
+		meson_clk_pll_disable(hw);
+		pr_warn("%s: PLL lock failed!\n", clk_hw_get_name(hw));
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



