Return-Path: <linux-kernel+bounces-757254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 547BAB1BFE8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733DB18376A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864D71E230E;
	Wed,  6 Aug 2025 05:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BYE6srI5"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A121114
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 05:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754458036; cv=none; b=oSy51spcx3rgyEF0wCHdMNkVJgDj7C7xXMq3KyBmKPpIfbra9s2lDsYMfsGr3Fzh5i2EWoVsSJQme9PwQzJ6MIMEGH5Kaa+n4JZTgFNMnVxEq3XQSLiNzpkXNDmLU83AOAkz+RM6AnzNMvllbuGndl9JWYYWKiHxiHeuw8u+bzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754458036; c=relaxed/simple;
	bh=lnfWdOtgLbeYWzyGafPhV3wWTam7JfNgZ8dc0TOuBQY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sb4TjzAaT7lXkuBppuj8lWir8Rt8TInkvlaxjCNOl5wSEkE7G5EA/Q2dSTefaAUuisz3KymXVLqBbjUrmm0hYbraXoEMqrDuKqiNwktz9qptvsHDpJ6IbysNl6IV5EqyieoLEZbq6j+O6lp9tmP5/oZRmbd622mNP6Ikmzd1Utw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BYE6srI5; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5765QsMJ500127;
	Wed, 6 Aug 2025 00:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754458014;
	bh=xtP22jOcasrwuM2KFGtNR2dD4crpfIXusnWFCfSQm/8=;
	h=From:To:CC:Subject:Date;
	b=BYE6srI5MCYd7fqWFuNEG9v8pbeWra8aehDEnw3oNfBaKVO2e2G24DqMdjjDa2n3Q
	 MsR9RLodSu22ydtHuU7WVm/yBuZWqRTM6OmnZJTfMofwgTUvQgwIYZoYFBKgDMbRhs
	 6wa+FS+zUJgBdblBsuKONiRBfn619WNRwpsR8QIc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5765QsPI4098841
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 6 Aug 2025 00:26:54 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 6
 Aug 2025 00:26:54 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 6 Aug 2025 00:26:54 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5765QpP13010314;
	Wed, 6 Aug 2025 00:26:51 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <u.kleine-koenig@baylibre.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devarsht@ti.com>, <u-kumar1@ti.com>, <s-jain1@ti.com>
CC: <h-shenoy@ti.com>
Subject: [PATCH v2] drivers: phy: cadence: cdns-dphy: Enable lower resolutions in dphy
Date: Wed, 6 Aug 2025 10:56:50 +0530
Message-ID: <20250806052650.429767-1-h-shenoy@ti.com>
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

Enable support for hs_clk_rate between 80-160 Mbps cdns dphy
as mentioned in TRM [0] by setting the pll_opdiv field to 16.
This change enables lower resolutions like 640x480 at 60Hz.

[0]: https://www.ti.com/lit/zip/spruil1
(Table 12-552. DPHY_TX_PLL_CTRL Register Field Descriptions)

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
---
Changes in v2:
- Updated commit message and title.
- Added Reviewed-by tag.
- Link to v1: https://lore.kernel.org/all/1ebb82ea-4b6c-4496-b7c0-17d4168d8ddf@ti.com/

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


