Return-Path: <linux-kernel+bounces-877553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3387C1E692
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41AEA3BE7CF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E273B32E151;
	Thu, 30 Oct 2025 05:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVSYNWZP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD3C32C950;
	Thu, 30 Oct 2025 05:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761801858; cv=none; b=jLNOYxRSRKBVdxmMF/wQAHm2maMiTZ9BBUB5/e0eaALTSuE4IHhf4lWwT6A/mu/H2mV/E39ZrQnypHm12xt8ClL2OeIKlf5iwVC6Y4XzLG4u8IegUsp/H55wO9SW9rAg3vSDn8LuDGjG5PIWPdUKKctOdyIp0ebecY7zp+suYUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761801858; c=relaxed/simple;
	bh=ITtznf4V3PEOG09w+PdAv94v0LkRnn8G5sFFZCmhyck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9zLM3gxUqdYU8MjTIEX9Hfe7j/jBaj0wcBWWIB4a9BI1Wb4I+mcV5eRpxY7HFk+M0SuBDe05AdRPvE7LXy4gRDX9Sm+Po4zInRvp0uu4Ut803QtAk1ETFwTdrzHNTIJAfRglNxsQ7LprrG9PtRwkViEu80Fjmi6cTTFvtaqBAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVSYNWZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7FC5C116D0;
	Thu, 30 Oct 2025 05:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761801857;
	bh=ITtznf4V3PEOG09w+PdAv94v0LkRnn8G5sFFZCmhyck=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZVSYNWZPkLnDYVbMBDi9vqQ7BEnDOH5Xdx1ZOQaQln6Nu62mSuMvbRO1LuGPraB8E
	 bhV8LVHREktlWtCPSAyukwhAQ48l0W8txy7SqyOSkf84xTn8EH3qBGYaq9m4WlO22W
	 9HS/mzufrkEdWTX4JtrJ3T8FC1eqe2uXty/T4P5OSvo8tlnzN3X9SwxJm0bbiNCI4M
	 oDHBhF78/5UnaJV4emf/FCMimW87bhsj24rQTjUEpkWgt7MvaKtaNnXUnTbfXHvkSU
	 PAODCMtoFvaTG14g74vpbuBYBCO7tT/udVPAKKx0XfAbdn9YCWZuNdJzPqNRsMMIoZ
	 27wFX4Ox0TFSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD02FCCF9F9;
	Thu, 30 Oct 2025 05:24:17 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Thu, 30 Oct 2025 13:24:14 +0800
Subject: [PATCH v2 4/5] clk: amlogic: Optimize PLL enable timing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251030-optimize_pll_driver-v2-4-37273f5b25ab@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761801855; l=2564;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=DjnEanujLZY4RuGc42rl8hj7g33ffwSvffDuoLJcxso=;
 b=sTga/WVc91PpMaP5RpP+aJzcq1fHbdkptD2tzxJ/anIj6LHmeSDy9p2tUGqkohJmzO2ldf8Bk
 OsA0vBqz2nqDsOLShEcZFUKNQw3jhmY3tuftag8o15yNCYsVdSJ+jvT
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

l_detect controls the enablement of the PLL lock detection module.
It should remain disabled while the internal PLL circuits are
reaching a steady state; otherwise, the lock signal may be falsely
triggered high.

Before enabling the internal power supply of the PLL, l_detect should
be disabled. After the PLL’s internal circuits have stabilized,
l_detect should be enabled to prevent false lock signal triggers.

Currently, only A1 supports both l_detect and current_en, so this
patch will only affect A1.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/clk-pll.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 6c794adb8ccd..c6eebde1f516 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -383,36 +383,38 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 	if (MESON_PARM_APPLICABLE(&pll->rst))
 		meson_parm_write(clk->map, &pll->rst, 1);
 
+	/* Disable the PLL lock-detect module */
+	if (MESON_PARM_APPLICABLE(&pll->l_detect))
+		meson_parm_write(clk->map, &pll->l_detect, 1);
+
 	/* Enable the pll */
 	meson_parm_write(clk->map, &pll->en, 1);
 	/* Wait for Bandgap and LDO to power up and stabilize */
 	udelay(20);
 
-	/* Take the pll out reset */
-	if (MESON_PARM_APPLICABLE(&pll->rst))
-		meson_parm_write(clk->map, &pll->rst, 0);
-
-	/* Wait for PLL loop stabilization */
-	udelay(20);
-
 	/*
 	 * Compared with the previous SoCs, self-adaption current module
 	 * is newly added for A1, keep the new power-on sequence to enable the
 	 * PLL. The sequence is:
-	 * 1. enable the pll, delay for 10us
+	 * 1. enable the pll, delay for 20us
 	 * 2. enable the pll self-adaption current module, delay for 40us
 	 * 3. enable the lock detect module
 	 */
 	if (MESON_PARM_APPLICABLE(&pll->current_en)) {
-		udelay(10);
 		meson_parm_write(clk->map, &pll->current_en, 1);
-		udelay(40);
+		udelay(20);
 	}
 
-	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
-		meson_parm_write(clk->map, &pll->l_detect, 1);
+	/* Take the pll out reset */
+	if (MESON_PARM_APPLICABLE(&pll->rst))
+		meson_parm_write(clk->map, &pll->rst, 0);
+
+	/* Wait for PLL loop stabilization */
+	udelay(20);
+
+	/* Enable the lock-detect module */
+	if (MESON_PARM_APPLICABLE(&pll->l_detect))
 		meson_parm_write(clk->map, &pll->l_detect, 0);
-	}
 
 	if (meson_clk_pll_wait_lock(hw)) {
 		/* disable PLL when PLL lock failed. */

-- 
2.42.0



