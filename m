Return-Path: <linux-kernel+bounces-877554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89C3C1E68C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 06:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A190D18925A2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 05:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BEE32E143;
	Thu, 30 Oct 2025 05:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fqct62np"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCC332C94F;
	Thu, 30 Oct 2025 05:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761801858; cv=none; b=XNZAzvD1pKAYZNS5GJ5rrwn29hfTvpQMGo+96Uu7RtDXI0VRkiWB0WDUnELBblDYS9RJPAjG4Xe2C3rzhwdsZzUGmsjYUY6VQGTcX1BIjt0O3H1BemycGrffMDGZX4Qy9K8S0F3u84PkZGcSRuiL5kt4QDr+99cy6f7DsdXERjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761801858; c=relaxed/simple;
	bh=2jU1k23psQLoti835WJhUi8hPO5zOMCVn1KLTW6Gx7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JiX9FsGKRMkKxs0LdIvimyXrjIblczOLq3rgWyuopzu/ulx7BB+m0Zx4c1PXDD2bHIEjcKBg88uZN7T9FBYF0szi7y3jHeMfQnFRJKSNu1TwAlmsMzSCyPp7o/SCffVrPHJPFg8LSuv6zFy2lTYkLFq35WMAdTzc9oozfStqAQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fqct62np; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C27FCC4CEFB;
	Thu, 30 Oct 2025 05:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761801857;
	bh=2jU1k23psQLoti835WJhUi8hPO5zOMCVn1KLTW6Gx7o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Fqct62npqZNU+7aZwsQZWh1JWHKkBg0YVUWAGL+i6XEbL232ekVUazCOU0HaAR0BD
	 fYn8Zp9ku2mPyqXsQ7ga1lJPG1sQuWmBb7U5Ct0cRa7lq8pf7w5swmYJE/k5gNz/BM
	 YhO9IS/JzLvmVvjE6VVBiAzz1RrbYlWudw4yeIC9+YEUWq8n4DegFGe5cMjCMb/fqh
	 8f4VYoV9BU/WxYmvCQOLj1dnLobZJ/Aim7AueiiF2q+D4+O9FqFQ/dCKKwFslC43uD
	 /rl+FO5cWp/+8hT9quRlpMAj3Sbb74Ip7NZIz4bD3zWIByIxmdW4pEFuRWoqznm8nm
	 ybfwXVyuNfiEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE968CCF9F6;
	Thu, 30 Oct 2025 05:24:17 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Thu, 30 Oct 2025 13:24:12 +0800
Subject: [PATCH v2 2/5] clk: amlogic: Improve the issue of PLL lock
 failures
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-optimize_pll_driver-v2-2-37273f5b25ab@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761801855; l=1329;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=By36+5Xc3F4ZCx2+oODMEZ/7arVOVHo8uzE39j79UAI=;
 b=uZ6pe/g6+Kcpzahmm37OY/aCUYb8QAGsQ9XhgLK57CE/ZIYOWn0w0solOn5GWD1DFWNqs20OZ
 DbfMN8DGCptAdPPnCDKIoA1yjDdyQRO7hVdZKe6PPNqGayQVvll6NrY
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
 drivers/clk/meson/clk-pll.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index 629f6af18ea1..f81ebf6cc981 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -368,11 +368,16 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
 
 	/* Enable the pll */
 	meson_parm_write(clk->map, &pll->en, 1);
+	/* Wait for Bandgap and LDO to power up and stabilize */
+	udelay(20);
 
 	/* Take the pll out reset */
 	if (MESON_PARM_APPLICABLE(&pll->rst))
 		meson_parm_write(clk->map, &pll->rst, 0);
 
+	/* Wait for PLL loop stabilization */
+	udelay(20);
+
 	/*
 	 * Compared with the previous SoCs, self-adaption current module
 	 * is newly added for A1, keep the new power-on sequence to enable the

-- 
2.42.0



