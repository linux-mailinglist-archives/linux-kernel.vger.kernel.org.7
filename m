Return-Path: <linux-kernel+bounces-753305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB74B18151
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D602A582D25
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302B31E9B0B;
	Fri,  1 Aug 2025 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V3byL7I5"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCAD14F9D6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754049222; cv=none; b=dpzwQ7VppN+ZY3ypqE0bS8ST7lCuwfmt4uIglzaI4mNlomGAd7ys/gn8oSzrjb/xvboakbJEU69cAGwtqrIqUw6mVhqR9Q7lX5TfsYvZv3E08TmmxzIBRU5bpeQtDT439RyzJvx2wesJmGgDFbl3NjV9CQhh9vYbiafEdp3gtm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754049222; c=relaxed/simple;
	bh=+9VhpLqZ71jKXW8X+QVEUjnFt0lOgtYpKgrRTCvzVjI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c8KAeR+4FF8sLFAtmYDlMN/umgTgjwAGEP5dwW1RDbrHdUSIzXw3/9BqunS2l7q+b/MRDKF0bwBr0Kj1peqi2fGN3Fn76MDiosxMzLURKmWabskO2lKfb4w4h6ncc+BtI1XY1rpSDIRmj8q1vAZ3OfGOeT6/fOQgp8bfZfPH/Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V3byL7I5; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 571BrGib3234765;
	Fri, 1 Aug 2025 06:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754049196;
	bh=Mkzg6uJU8Hf0C2C7tC4oO21np+7EsTtwbHlVIynuKkQ=;
	h=From:To:CC:Subject:Date;
	b=V3byL7I5E6inGNFnzOoN+vQ7fijvH+6BtQKh/INpvu3J4qqOwuW+hPql2+dHDwXp/
	 NR1P9c7GdR3QrXNkWSaqpxuL/gfEO2K8JGW9ld3en2Px6xqZkxdFphR0nEUtk3XRMf
	 x2pX3zXGiy/AiysNwtwo7nk0+qFbsDSOi4n2Imvo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 571BrG73751037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 1 Aug 2025 06:53:16 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 1
 Aug 2025 06:53:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 1 Aug 2025 06:53:15 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 571BrCUg334601;
	Fri, 1 Aug 2025 06:53:13 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <u.kleine-koenig@baylibre.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>, <u-kumar1@ti.com>, <s-jain1@ti.com>
CC: <h-shenoy@ti.com>
Subject: [PATCH] drivers: phy: cadence: cdns-dphy: Enabling lower resolutions in dphy
Date: Fri, 1 Aug 2025 17:23:11 +0530
Message-ID: <20250801115311.1384313-1-h-shenoy@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The patch enables cdns dphy for hs_clk_rate in range between
80 Mbps to 160 Mbps as mentioned in TRM [0] by setting the
pll_opdiv field to 16.This change enables lower resolutions
like 640x480 at 60Hz.

[0]: https://www.ti.com/lit/zip/spruil1
(Table 12-552. DPHY_TX_PLL_CTRL Register Field Descriptions)

Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
---
Test log: https://gist.github.com/h-shenoy/3975156baf403a0ff8dbcce5b49b2b89

 drivers/phy/cadence/cdns-dphy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index ed87a3970f83..9abed2ece9b0 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -139,7 +139,7 @@ static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
 
 	dlane_bps = opts->hs_clk_rate;
 
-	if (dlane_bps > 2500000000UL || dlane_bps < 160000000UL)
+	if (dlane_bps > 2500000000UL || dlane_bps < 80000000UL)
 		return -EINVAL;
 	else if (dlane_bps >= 1250000000)
 		cfg->pll_opdiv = 1;
@@ -149,6 +149,8 @@ static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
 		cfg->pll_opdiv = 4;
 	else if (dlane_bps >= 160000000)
 		cfg->pll_opdiv = 8;
+	else if (dlane_bps >= 80000000)
+		cfg->pll_opdiv = 16;
 
 	cfg->pll_fbdiv = DIV_ROUND_UP_ULL(dlane_bps * 2 * cfg->pll_opdiv *
 					  cfg->pll_ipdiv,
-- 
2.34.1


