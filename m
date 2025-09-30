Return-Path: <linux-kernel+bounces-837430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F7FBAC521
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0AC3192724C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0526C2F90F0;
	Tue, 30 Sep 2025 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJiebdhS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D212F5467;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759225051; cv=none; b=A7H0isnnWl2lcXX/MqTECnmMosbL/kKYu6vh31vXVEWIS1dI93Ytnz2DDe14ih36gFsseh1hzLqPqrmyEttnB6HzssIURoGysu2bhAa0NpGU0tAmM6DcJPpO4SqbZFkrCZx9psnW+5hnfg8qkesUk6VyWgy/ReH2IIPVXkNOogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759225051; c=relaxed/simple;
	bh=xSFNma5kv9uRMjcs2Zg6YvItQ9oibLK1g7/ya6UY/2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PxcfJ3sOzz0mpKg6FWV5WvEVWEoI6jTj/xDHwnkm0q0Wvsp8KlS+NbQAnHy5MfYnxAX9CMuNdQCuhBNe22neK+w6XnHpR63VS6P3BxxOwxVNuEnyBnNFFQTcESzDXPybsvhNa89mPqnf1pq9ZCe7uxyAbbnyzIlQidmYI/wVw8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJiebdhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7786FC19423;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759225051;
	bh=xSFNma5kv9uRMjcs2Zg6YvItQ9oibLK1g7/ya6UY/2A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kJiebdhS0iQfAhEkjbQEgoG2Sh0gi62VOzBEuVqM4RFGw75EDopbk63HcNcytp0Nh
	 1P0RXoqRZt6morH+JNGzTUvkOoVyHRTxgyxI61weKOFreti8pXVEVC7NX+2jM461Qb
	 pp3KncumjN9m1V00ZTCqgLm+qy/1G4vdvYiTj3gko4amtBmdSxHVXb5tVgmY8a99e9
	 HYGNOWF9/OkwYsErwUsScTk88H7O2bce3hbJdte+eXz7oMLgr5ZF7uZbjSmOk/Faf1
	 CqEXUC09IqNnewtaviL5g+Kb1gHvNNxyF3Qhm37msSGRjDaOpVBFV6TNTHQzrqRWLr
	 8vuOswk+AbjfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7111BCAC5B8;
	Tue, 30 Sep 2025 09:37:31 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Tue, 30 Sep 2025 17:37:17 +0800
Subject: [PATCH 04/19] clk: amlogic: Optimize PLL enable timing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-a4_a5_add_clock_driver-v1-4-a9acf7951589@amlogic.com>
References: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
In-Reply-To: <20250930-a4_a5_add_clock_driver-v1-0-a9acf7951589@amlogic.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759225047; l=4402;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=PzFaqdiB29ZTMBFFJF+oqAAIU1PhzxewgE9YIWzfRkU=;
 b=ONDU8yztC1N/PHzG/ebRAKgecCq6KD0moKrXNxd9ZqXIVzWLO8oVq61BriGtki7XdS++VNYOd
 7PEyWpTaHlXD6U2Z8E39QXg14Ky38eYdTlXUGLX5YF6VSCPdAbzLYHu
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Amlogic PLL locking procedure shall follow this timing sequence:
1 Assert reset signal: Ensures PLL circuits enter known initial state.
2 Deassert lock-detect signal: Avoid lock signal false triggering.
3 Assert enable signal: Powers up PLL supply.
4 udelay(20): Wait for Bandgap and LDO to power up and stabilize.
5 Enable self-adaptation current module (Optional).
6 Deassert reset signal: Releases PLL to begin normal operation.
7 udelay(20): Wait for PLL loop stabilization.
8 Assert lock-detect signal: lock detection circuit starts to work.
9 Monitor lock status signal: Wait for PLL lock completion.
10 If the PLL fails to lock, it should be disabled, This makes the
logic more complete, and also helps save unnecessary power consumption
when the PLL is malfunctioning.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/clk-pll.c | 68 ++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 1ea6579a760f..8bddd44d4738 100644
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
@@ -366,53 +383,48 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 	if (MESON_PARM_APPLICABLE(&pll->rst))
 		meson_parm_write(clk->map, &pll->rst, 1);
 
+	/* Disable the PLL lock-detect module */
+	if (MESON_PARM_APPLICABLE(&pll->l_detect))
+		meson_parm_write(clk->map, &pll->l_detect, 1);
+
 	/* Enable the pll */
 	meson_parm_write(clk->map, &pll->en, 1);
-
-	/* Take the pll out reset */
-	if (MESON_PARM_APPLICABLE(&pll->rst))
-		meson_parm_write(clk->map, &pll->rst, 0);
+	/* Wait for Bandgap and LDO to power up and stabilize */
+	udelay(20);
 
 	/*
 	 * Compared with the previous SoCs, self-adaption current module
 	 * is newly added for A1, keep the new power-on sequence to enable the
 	 * PLL. The sequence is:
-	 * 1. enable the pll, delay for 10us
+	 * 1. enable the pll, ensure a minimum delay of 10μs
 	 * 2. enable the pll self-adaption current module, delay for 40us
 	 * 3. enable the lock detect module
 	 */
 	if (MESON_PARM_APPLICABLE(&pll->current_en)) {
-		udelay(10);
 		meson_parm_write(clk->map, &pll->current_en, 1);
-		udelay(40);
-	}
-
-	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
-		meson_parm_write(clk->map, &pll->l_detect, 1);
-		meson_parm_write(clk->map, &pll->l_detect, 0);
+		udelay(20);
 	}
 
-	if (meson_clk_pll_wait_lock(hw))
-		return -EIO;
+	/* Take the pll out reset */
+	if (MESON_PARM_APPLICABLE(&pll->rst))
+		meson_parm_write(clk->map, &pll->rst, 0);
 
-	return 0;
-}
+	/* Wait for PLL loop stabilization */
+	udelay(20);
 
-static void meson_clk_pll_disable(struct clk_hw *hw)
-{
-	struct clk_regmap *clk = to_clk_regmap(hw);
-	struct meson_clk_pll_data *pll = meson_clk_pll_data(clk);
+	/* Enable the lock-detect module */
+	if (MESON_PARM_APPLICABLE(&pll->l_detect))
+		meson_parm_write(clk->map, &pll->l_detect, 0);
 
-	/* Put the pll is in reset */
-	if (MESON_PARM_APPLICABLE(&pll->rst))
-		meson_parm_write(clk->map, &pll->rst, 1);
+	if (meson_clk_pll_wait_lock(hw)) {
+		/* disable PLL when PLL lock failed. */
+		meson_clk_pll_disable(hw);
+		pr_warn("%s: PLL lock failed!!!\n", clk_hw_get_name(hw));
 
-	/* Disable the pll */
-	meson_parm_write(clk->map, &pll->en, 0);
+		return -EIO;
+	}
 
-	/* Disable PLL internal self-adaption current module */
-	if (MESON_PARM_APPLICABLE(&pll->current_en))
-		meson_parm_write(clk->map, &pll->current_en, 0);
+	return 0;
 }
 
 static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,

-- 
2.42.0



