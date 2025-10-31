Return-Path: <linux-kernel+bounces-879686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3323AC23B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9631A24B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA97A337BB8;
	Fri, 31 Oct 2025 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCjhTnB7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296673358D5;
	Fri, 31 Oct 2025 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898232; cv=none; b=RRdt9qtlzHbfcnx7X0OhO76tBMkp6Myh7le9sKrFoB5CK6nf1t3zf37/C3B2f+io+XCcQ47umZ1uG15vtBjuig1IadJEjtd1C80LYk6pFlsQOTdwQhw/TOMxh7iVub5pJvwZ4w5m6la6Uwl82TSQza4RuLriIoFbabExYISOdzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898232; c=relaxed/simple;
	bh=1nwGVO3Zcpwv2pMSFVgY8O3SNOwGFq6oSEOulqqDP4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hhwus25z1qnd7FSZHvLKDJSo0/ocE81NUAwHxjVNpVjeo4dfWHcU60OizEKDnYmEIn4goY2bXwQFDptXnl3QNuLFC+AmZ5OTRJ6wJrmyJMGe6KMfOtr8rA4n7WuGY2+JqLbf/1cjcpZn259mId2DLI/UbcKpAnEqBIxVG3cAOX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCjhTnB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C230AC116C6;
	Fri, 31 Oct 2025 08:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761898231;
	bh=1nwGVO3Zcpwv2pMSFVgY8O3SNOwGFq6oSEOulqqDP4g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OCjhTnB7jSnhLcmJ7VtvvseYnBLme3xRFIwGaVusZkch//5kW/wh8rfiA8SkwHoE6
	 a9S6E8NuavPmKYq9WR/KlEutmjvCmSvQCYHd+JtLr/2LuG7IVjNxZii1Ryu9Tk9JPn
	 mIi3KzMUNZ7HtkWKeEV7VYVlc2Lw9r1iXziqI+D23YUk1z+kvAG3Bjuy8EtFeOeLEH
	 Fh8DINuV09NA2PpsRMGsKCZQUJY9M2+NtseMUN5dXChkM+7wkQr9BUYTHihiWMNqT4
	 jdvdXbJg2Dlc/cDgJxJB762tStticMvzAm8ndPoD6TbhfN5Hw8+RXiC9RQZOG8MobY
	 ySg0YMJBwU45A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8343CCFA00;
	Fri, 31 Oct 2025 08:10:31 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 31 Oct 2025 16:10:09 +0800
Subject: [PATCH v3 2/4] clk: amlogic: Improve the issue of PLL lock
 failures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-optimize_pll_driver-v3-2-92f3b2f36a83@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761898227; l=1398;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=D0Ch0klWiiVBvP2nT1dWsPIBdVptw/u95TcZFxvGJ48=;
 b=DFTPIpZdSO64xPMi6d1dN9YKt56tCq1oo7YedKHM2Vk59/bE+owHEUbdaDAlE8itMPMMh1Xdy
 t1Z8vWX+hKYDRPWTkbvGi2VhLlPZnlaiFKx/mnKCdN2qQMzjD8T7dGO
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Due to factors such as temperature and process variations, the
internal circuits of the PLL may require a longer time to reach a
steady state, which can result in occasional lock failures on some
SoCs under low-temperature conditions.

After enabling the PLL and releasing its reset, a 20 us delay is
added at each step to provide enough time for the internal PLL
circuit to stabilize, thus reducing the probability of PLL lock
failure.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/clk-pll.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 629f6af18ea1..70c8c7078046 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -369,10 +369,17 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 	/* Enable the pll */
 	meson_parm_write(clk->map, &pll->en, 1);
 
+	/* Wait for Bandgap and LDO to power up and stabilize */
+	udelay(20);
+
 	/* Take the pll out reset */
-	if (MESON_PARM_APPLICABLE(&pll->rst))
+	if (MESON_PARM_APPLICABLE(&pll->rst)) {
 		meson_parm_write(clk->map, &pll->rst, 0);
 
+		/* Wait for PLL loop stabilization */
+		udelay(20);
+	}
+
 	/*
 	 * Compared with the previous SoCs, self-adaption current module
 	 * is newly added for A1, keep the new power-on sequence to enable the

-- 
2.42.0



