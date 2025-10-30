Return-Path: <linux-kernel+bounces-877555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C461AC1E69C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C125E406BD2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFCE32C944;
	Thu, 30 Oct 2025 05:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Re3PalxX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFB132D44A;
	Thu, 30 Oct 2025 05:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761801858; cv=none; b=Hj8+Dxqwgya1+bHyO4nY8nSBebDESEPDnXMByn9VVEapoFumGdE/InYz+7Io3U6mqaIplULnVkifXTGacSlGjl9xicxezPWFKbc1mcNXyvYQ+DGPg4zUpJxX6b7K3vpah5Q1HxYDGRlN2tDRFFq1tioXefoHsFQdA6FgHJp7ju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761801858; c=relaxed/simple;
	bh=zzksamsMZJOf1VT2cpshTei0QB7OGy3UaCYmRF0l4+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i10stj/ylXsYAywOcobpKqKojGZPqzjXuDtHs25Iy8z6rJP05hr/8+VWbInSFaKRWG1uhyZlXIya3iAtrQ7uBlZsG20awelRxu1gerp/3V7nl60vDOkhBj+y5ZIzze6sbeDcRntp5zbsnBBIUrtYfTgl+L2muGxbs4pH4x29YV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Re3PalxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEB10C19422;
	Thu, 30 Oct 2025 05:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761801858;
	bh=zzksamsMZJOf1VT2cpshTei0QB7OGy3UaCYmRF0l4+I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Re3PalxXppg+X4cVfexljdnK7Rq7OkfLbTIsQpYACW5uPSmp9dwiuqRk/owTZwAz/
	 ZvZNS1V714JLYIR2jWFh6W++HPwQcTGIgNhxt8aAwcrOFpt8tVnCDxAtO6JSEWcy0T
	 wbEecwKaAoepL3qNOJG7A9aslcpoKnUsY+wOemOxm3Jz1O9/s3TxMBxFLQ7lkOR1iD
	 pRg2/Jx+oVmMTtIrbWYjDqe8C7TjVKhi7Dvavzbu8k59p96SgLyOrGx76cZAIQhhvb
	 jtesJy/LMawdLz/d0VXxknKYgCW7gc8GH+A6P4ZyhQQM8dkXe0oG4N4FQyPeFC6Ilb
	 p2hIcnSa4h5gA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B6FCCF9F6;
	Thu, 30 Oct 2025 05:24:17 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Thu, 30 Oct 2025 13:24:15 +0800
Subject: [PATCH v2 5/5] clk: amlogic: Change the active level of l_detect
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-optimize_pll_driver-v2-5-37273f5b25ab@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761801855; l=2920;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=EZQlp+ntQWH8wulP13OMEjecr2IO8R7gTLRrdJNlJqE=;
 b=tkTJCiK33Lo/TFJ+LelyksSbZKnetVKLe70d7ctvoJhRiAucDH840dF3/2GnHDeDNQika1syG
 p2IuaWbAkHsB2RTAIEHlBjlOt/J8081nbUxgd6kHxUu9KBv1e/jPZwI
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

l_detect controls the enable/disable of the PLL lock-detect module.

The enable signal is normally active-high. This design ensures that
the module remains disabled during the power-on process, preventing
power fluctuations from affecting its operating state.

For A1, the l_detect signal is active-low:
0 -> Enable lock-detect module;
1 -> Disable lock-detect module.

Here, a flag CLK_MESON_PLL_L_DETECT_N is added to handle cases like
A1, where the signal is active-low.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/a1-pll.c  |  1 +
 drivers/clk/meson/clk-pll.c | 16 ++++++++++++----
 drivers/clk/meson/clk-pll.h |  2 ++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
index 1f82e9c7c14e..bfe559c71402 100644
--- a/drivers/clk/meson/a1-pll.c
+++ b/drivers/clk/meson/a1-pll.c
@@ -137,6 +137,7 @@ static struct clk_regmap a1_hifi_pll = {
 		.range = &a1_hifi_pll_range,
 		.init_regs = a1_hifi_pll_init_regs,
 		.init_count = ARRAY_SIZE(a1_hifi_pll_init_regs),
+		.flags = CLK_MESON_PLL_L_DETECT_N
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "hifi_pll",
diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index c6eebde1f516..d729e933aa1c 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -384,8 +384,12 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 		meson_parm_write(clk->map, &pll->rst, 1);
 
 	/* Disable the PLL lock-detect module */
-	if (MESON_PARM_APPLICABLE(&pll->l_detect))
-		meson_parm_write(clk->map, &pll->l_detect, 1);
+	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
+		if (pll->flags & CLK_MESON_PLL_L_DETECT_N)
+			meson_parm_write(clk->map, &pll->l_detect, 1);
+		else
+			meson_parm_write(clk->map, &pll->l_detect, 0);
+	}
 
 	/* Enable the pll */
 	meson_parm_write(clk->map, &pll->en, 1);
@@ -413,8 +417,12 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 	udelay(20);
 
 	/* Enable the lock-detect module */
-	if (MESON_PARM_APPLICABLE(&pll->l_detect))
-		meson_parm_write(clk->map, &pll->l_detect, 0);
+	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
+		if (pll->flags & CLK_MESON_PLL_L_DETECT_N)
+			meson_parm_write(clk->map, &pll->l_detect, 0);
+		else
+			meson_parm_write(clk->map, &pll->l_detect, 1);
+	}
 
 	if (meson_clk_pll_wait_lock(hw)) {
 		/* disable PLL when PLL lock failed. */
diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
index 949157fb7bf5..83295a24721f 100644
--- a/drivers/clk/meson/clk-pll.h
+++ b/drivers/clk/meson/clk-pll.h
@@ -29,6 +29,8 @@ struct pll_mult_range {
 
 #define CLK_MESON_PLL_ROUND_CLOSEST	BIT(0)
 #define CLK_MESON_PLL_NOINIT_ENABLED	BIT(1)
+/* l_detect signal is active-low */
+#define CLK_MESON_PLL_L_DETECT_N	BIT(2)
 
 struct meson_clk_pll_data {
 	struct parm en;

-- 
2.42.0



