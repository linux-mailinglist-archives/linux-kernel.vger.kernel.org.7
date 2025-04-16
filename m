Return-Path: <linux-kernel+bounces-602747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACE6A87EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 13:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582AB171101
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 11:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896092BE7D7;
	Mon, 14 Apr 2025 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="H2k5u3hO"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26A2980C0
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 11:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629156; cv=none; b=YITGn3wZC2ZTMuVMmwOKH7gY4LJ25GDFufC11gqHUNa7ftH2D55xuRBrxe75riVPfsN4Qs9sXCmPaiCRuds94oJMMmEwab5cx+a2PIpO2WYEzLKAhiCZpNm36cKccUcqdmsUduiTS9XupnhIQ4xk6WNmPXVsMFQOp9PWYiG5Irs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629156; c=relaxed/simple;
	bh=YOFz63JzljKPD78q10dTnyaY1ocLDBf5kpnKoq+T+4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otcUz7CD6Kl4aY/R7BU2yNzMD9vHz0c8/jdVGiru9JByHTlgjRw7VBiTfG12L7pd0kmXHMSuWv+YfILXLRmaJ6r1y+RAfgmI34V4xWTMAu0yZbxrUdKVIp5dZ+d02y7BU4ZRLqMj8v9N/ZtwUuv5dcyGi27ftvwFUd2mtGdEUMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=H2k5u3hO; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6D7A51A78;
	Mon, 14 Apr 2025 13:10:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1744629018;
	bh=YOFz63JzljKPD78q10dTnyaY1ocLDBf5kpnKoq+T+4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H2k5u3hOftjAQmGa8qUUHi/ikYQBY0ovIVPZ7c9vNxa8TFyB08paZHsB0iJNUSyU0
	 JuAHJfnBwf4gyPHuzhg2AxIDiIF+jOR/cJWmZ27RKVvNJuk1AJDsF7QF7SilCH9oIq
	 CtHnN5B+pBxyHhCik64mF8FbjcUqPppNqODvf5Kk=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 14 Apr 2025 14:11:22 +0300
Subject: [PATCH v3 13/17] drm/bridge: cdns-dsi: Fix REG_WAKEUP_TIME value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-cdns-dsi-impro-v3-13-4e52551d4f07@ideasonboard.com>
References: <20250414-cdns-dsi-impro-v3-0-4e52551d4f07@ideasonboard.com>
In-Reply-To: <20250414-cdns-dsi-impro-v3-0-4e52551d4f07@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1914;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=YOFz63JzljKPD78q10dTnyaY1ocLDBf5kpnKoq+T+4w=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn/O2A3rPjfcdggqDjJDVvwAexTdYOx6yKZjOo8
 N+p47bA3eyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ/ztgAAKCRD6PaqMvJYe
 9TxwD/0WCSjrtl3JIf92rhufeilD1pCHWl23FMfXyELuBPt+ovfNWAbWqn5tcOtkvWbdF2C0SBC
 BLdVIUqg8gA+2/SCQZduNcvAIwJ5TLLncbeGnlTkOLy4ouOMvAACG1AnFT2RJRzEPZtP4K8lRSw
 yhePNIxEOXrBYuhORcWlJO216rC7fPVvv/OimdJyIdQGX44K1KZM+JDKlfKShUId8XUxkOXGC4y
 BP6PpO/bhuGGqC6M1xSCEMrjZy12vHf2behjIbkLVAFWcCw3JKM5Xkg3ID7qzI5M+6xOfjsRgEm
 AB6L2HMwmAYmBdJH/jdtOo3h52sLQc2vO3KtEMPbhqeREduNUCb+jreGaMcRV61yzyOeNAXvhV9
 gWhaRgegIIXjJFTYX5bVSUWesSCIh3nk86T9f5bY3b+ynlXJCVZPiVpCjRCWcJUvEMLGOwFsN0g
 ab2dYnggImHqmCoo/ZQgqIdYuHwVEFPVfIaOfeEgeVMI0OK2MrmpIjb1yay5DwW6sWDVoScmdTl
 wJ71QtLwP3KFbsJt4sbT6GH17Q5q2C4TJqRuaYGKqTge9vWwv4HMM7V3XBT0HT9D8TehrBx+7Bv
 n6KBM6h9/h+Pd3hv9EWN+gPfIO69QbUidX8z0dHCKcE+oaPdCr1nb6gpfCOtwwwn9nMbSp8xJUH
 EKT8aMUKJcCJffw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The driver tries to calculate the value for REG_WAKEUP_TIME. However,
the calculation itself is not correct, and to add on it, the resulting
value is almost always larger than the field's size, so the actual
result is more or less random.

According to the docs, figuring out the value for REG_WAKEUP_TIME
requires HW characterization and there's no way to have a generic
algorithm to come up with the value. That doesn't help at all...

However, we know that the value must be smaller than the line time, and,
at least in my understanding, the proper value for it is quite small.
Testing shows that setting it to 1/10 of the line time seems to work
well. All video modes from my HDMI monitor work with this algorithm.

Hopefully we'll get more information on how to calculate the value, and
we can then update this.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 182845c54c3d..fb0623d3f854 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -786,7 +786,13 @@ static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 
 	tx_byte_period = DIV_ROUND_DOWN_ULL((u64)NSEC_PER_SEC * 8,
 					    phy_cfg->hs_clk_rate);
-	reg_wakeup = (phy_cfg->hs_prepare + phy_cfg->hs_zero) / tx_byte_period;
+
+	/*
+	 * Estimated time [in clock cycles] to perform LP->HS on D-PHY.
+	 * It is not clear how to calculate this, so for now,
+	 * set it to 1/10 of the total number of clocks in a line.
+	 */
+	reg_wakeup = dsi_cfg.htotal / nlanes / 10;
 	writel(REG_WAKEUP_TIME(reg_wakeup) | REG_LINE_DURATION(tmp),
 	       dsi->regs + VID_DPHY_TIME);
 

-- 
2.43.0


