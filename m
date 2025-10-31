Return-Path: <linux-kernel+bounces-879687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3589C23BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847ED563F12
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5169337BBA;
	Fri, 31 Oct 2025 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TA0APZqY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296DD335BB4;
	Fri, 31 Oct 2025 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898232; cv=none; b=eOBM5bJ5d/G474J6arx7ERjxGuEg066jMOBRDioKrmKRIwa3HV/6sq/2ZfzFiKS0OP4rbuvdTYDfOZgk4gUh5r7Bd9Z54FP5Eyo0XXRtjTFRkuQzZYTASlwGLl/4/kLZW0RlkHvDGvRDUeC6SCyrL2tYRKnHWYPqzd6VsuOfsl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898232; c=relaxed/simple;
	bh=6ESWC7weu+fkakS/P318zzkxwK20bhDH2SY7HZ3vBd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VWuJG9ADdBaTZVm4LGn7rXj1WmxaIcnwKfiQySfYVry9WAn8MrQOzN5G7ZRyHNFFACdScgbHJ0BEx7Df3hJAUmLGI9uFIlr/93nUSNuQxnH29JwtfQHD+FI7HtLM+wgaYICJaOQquetE2C/REHHbSxJ69aaLlLYKRPCyGftxbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TA0APZqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9AF6C19424;
	Fri, 31 Oct 2025 08:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761898232;
	bh=6ESWC7weu+fkakS/P318zzkxwK20bhDH2SY7HZ3vBd4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TA0APZqYRrCONMPdDPvTaxyKas30+zpO3qlC5h0QacSccmboZAZwOmgto7v+aINr0
	 RquKFP8xA1ZM4h0z6SJ8CaDXbEyDhB8nfvBsJTFCs4O/gvlv5MTS2fC0BCJS/H8TUm
	 8upEULcZZcKPynxXnmfgMD92mVO6+jyGkFsRfZ7aCIuFZGSSGpGUlkTYJHRGYoEZ0/
	 0K8YwZQF4J4kiqlhiO9iFiiL8j6FzUn7R3zoE8YmjSSiQDwHrh2qvYQMYM+CsKqPZT
	 fFursmhuoa7zdd7nUr7yXo3QbqaQZKFg91r9m8W/gZ/9qyQ3rYlZPOc/KywCo3snA+
	 NZFAGnBDl2k5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1091CCFA00;
	Fri, 31 Oct 2025 08:10:31 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 31 Oct 2025 16:10:11 +0800
Subject: [PATCH v3 4/4] clk: amlogic: Optimize PLL enable timing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-optimize_pll_driver-v3-4-92f3b2f36a83@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761898227; l=2090;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=3bVoQCKgnuZ/IY+cWp9z2timk+2eNG6PU6hMfKQ9QKc=;
 b=PaR4cC+nx1zlBGR24Xc20vUT2lEJgJbv9J7AWiZu9QbNIDq2BkxtlT0lPMVoKhLR7ofEt/Xpz
 XzFQVzImYksCF6+t+rElWpS5+OSqL/J/xLPNCqFmzWFOpoFoJvkbaTD
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

A 20 us delay has been added before enabling the PLL, so there’s no
need for an additional 10 us delay before enabling current_en.

Currently, only A1 supports both l_detect and current_en, so this
patch will only affect A1.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/clk-pll.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index cdb39a723bd0..c9b941adf688 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -383,6 +383,10 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 	if (MESON_PARM_APPLICABLE(&pll->rst))
 		meson_parm_write(clk->map, &pll->rst, 1);
 
+	/* Disable the PLL lock-detect module */
+	if (MESON_PARM_APPLICABLE(&pll->l_detect))
+		meson_parm_write(clk->map, &pll->l_detect, 1);
+
 	/* Enable the pll */
 	meson_parm_write(clk->map, &pll->en, 1);
 
@@ -401,20 +405,18 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
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
 		udelay(40);
 	}
 
-	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
-		meson_parm_write(clk->map, &pll->l_detect, 1);
+	/* Enable the lock-detect module */
+	if (MESON_PARM_APPLICABLE(&pll->l_detect))
 		meson_parm_write(clk->map, &pll->l_detect, 0);
-	}
 
 	if (meson_clk_pll_wait_lock(hw)) {
 		/* disable PLL when PLL lock failed. */

-- 
2.42.0



