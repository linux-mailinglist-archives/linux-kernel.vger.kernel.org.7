Return-Path: <linux-kernel+bounces-742253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10E3B0EF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710E196102B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EDC28C2CD;
	Wed, 23 Jul 2025 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nn2QlpMx"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A2628E610
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264960; cv=none; b=W4l+8VBHahTCl4ERKlDHU7H+I7Fy07Vo2H/PXHOk181AnBU3OLiDjL462SV/RvdpvoVPiu7CjkrlamTk97EdMkYDAlCUgtRkwT09ZRUXuC9QSVQ5RtKdIm4UApv19x+Zq88bhF3lJ1BsZ8XYCCbBT97POILEvDSfarBD4NfZssA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264960; c=relaxed/simple;
	bh=ubLhijbPFpmnKtpMPd2eMRomUhKyh3UJpvvcvParxTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IaxOz7pYA3w2+0hqX+ZQHcdnfytCg2nDCfHjJVMzCi745dv5xmwRez+0CgW9SdWf1uW9GuKavzEB8wiJsoXo/KL92ZlhkZh8jSXEUKDW6RT5E7Ua+Jd2DktXSouYkzMGZu++uSCOSsjaMR8/8j2B76YKcuqyDeTmFm1K/1rGmeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=nn2QlpMx; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 89BB2F0B;
	Wed, 23 Jul 2025 12:01:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1753264915;
	bh=ubLhijbPFpmnKtpMPd2eMRomUhKyh3UJpvvcvParxTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nn2QlpMxwtJrNobp3egnfC+cSiif2h4aMklMu1ALmLW9yq1N83masvUj9gxNE3cbt
	 Np7gLOFSHB8ifTTwufdbUcYemL6BfRrIABiT1aXP4H1H/mgsU+fkuQDfu89xmk2X6i
	 ADQCITZ+EVRCmP1B9CIJCS4ChNTGVONZ2zD42rb8=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 23 Jul 2025 13:01:29 +0300
Subject: [PATCH 2/2] phy: cdns-dphy: Remove leftover code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-cdns-dphy-hs-clk-rate-fix-v1-2-d4539d44cbe7@ideasonboard.com>
References: <20250723-cdns-dphy-hs-clk-rate-fix-v1-0-d4539d44cbe7@ideasonboard.com>
In-Reply-To: <20250723-cdns-dphy-hs-clk-rate-fix-v1-0-d4539d44cbe7@ideasonboard.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Francesco Dolcini <francesco@dolcini.it>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2424;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=ubLhijbPFpmnKtpMPd2eMRomUhKyh3UJpvvcvParxTk=;
 b=kA0DAAgB+j2qjLyWHvUByyZiAGiAszaiEm1o5niwWdlRP1o0/dLv5mQAyuYraUhEINRMvLG4g
 4kCMwQAAQgAHRYhBMQ4DD6WXv2BB5/zp/o9qoy8lh71BQJogLM2AAoJEPo9qoy8lh71Rs8P/RNO
 CxjDTLGNiQyEic6a6DKs3HawdH3SYQSbZG8uZJcM8S47wgQzWrOKx53aUQvLF/l6xrA8s7/ZMAb
 UCRqxfRVuijRjvG09z+JrUTkyWR4EhvXBjXwomzn15ol7/N36YyJyjQxyFZc69vT8DsGF3nlWmx
 BtprOepyyUkeknqoXiSvw58+c0LV7pvClLTqIyL413iaiHSPw0txGOgc9QY1qdwpkDBpu2kYzmh
 2f/H6x+3kwjxwfax02ZRgFWGI/LT5IhlB1Mkql5sEPfZG76vhmMHkSQiTeLZduz48NIE0FDqZzb
 9D2jaJIekz0LCY4dEp9L3al982mEqNWVgjOndgKiBT7KWGvNQKKnF4zgERHb80xSOlkx5n7HlWb
 crRQCdE4Y5SR7TsjWeiucokiXgtc+vEU4DiDYug5tmAwlmnpMspi/SLPUZZM/6Zb1ZLnUvetSup
 c1aK2pqI8YJ1GsNFMZcF7TmPbOpQzZeLUPBFJNKp6jNcsYYL+xxyk5YWhFHSzQemDuyLBHGmTgn
 uhiQ8wSHdbYjkAZxKd0QPX3IidhZUZPvS8CC2nybJ2lZdK40TYkT4bveTKeXek2/nE2VRmY+X3Z
 HbmwPvbOoxSkWzsIWnNIqL+jbaBh1RQ/xZZXvZFJl0botqQO1SOKrs/NyaiOlqR1T0BW4KaFD6O
 QyBvS
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The code in cdns-dphy has probably been part of a DSI driver in the
past. Remove DSI defines and variables which are not used or do not
actually do anything. Also rename cdns_dsi_get_dphy_pll_cfg() to
cdns_dphy_get_pll_cfg(), i.e. drop the "dsi", as it's not relevant here.

Reviewed-by: Aradhya Bhatia <aradhya.bhatia@linux.dev>
Tested-by: Parth Pancholi <parth.pancholi@toradex.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Tested-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/phy/cadence/cdns-dphy.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index f79ec4fab409..33a42e72362e 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -55,14 +55,6 @@
 #define DPHY_PSM_CFG_FROM_REG		BIT(0)
 #define DPHY_PSM_CLK_DIV(x)		((x) << 1)
 
-#define DSI_HBP_FRAME_OVERHEAD		12
-#define DSI_HSA_FRAME_OVERHEAD		14
-#define DSI_HFP_FRAME_OVERHEAD		6
-#define DSI_HSS_VSS_VSE_FRAME_OVERHEAD	4
-#define DSI_BLANKING_FRAME_OVERHEAD	6
-#define DSI_NULL_FRAME_OVERHEAD		6
-#define DSI_EOT_PKT_SIZE		4
-
 #define DPHY_TX_J721E_WIZ_PLL_CTRL	0xF04
 #define DPHY_TX_J721E_WIZ_STATUS	0xF08
 #define DPHY_TX_J721E_WIZ_RST_CTRL	0xF0C
@@ -117,10 +109,9 @@ static const unsigned int tx_bands[] = {
 	870, 950, 1000, 1200, 1400, 1600, 1800, 2000, 2200, 2500
 };
 
-static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
-				     struct cdns_dphy_cfg *cfg,
-				     struct phy_configure_opts_mipi_dphy *opts,
-				     unsigned int *dsi_hfp_ext)
+static int cdns_dphy_get_pll_cfg(struct cdns_dphy *dphy,
+				 struct cdns_dphy_cfg *cfg,
+				 struct phy_configure_opts_mipi_dphy *opts)
 {
 	unsigned long pll_ref_hz = clk_get_rate(dphy->pll_ref_clk);
 	u64 dlane_bps;
@@ -289,15 +280,13 @@ static int cdns_dphy_config_from_opts(struct phy *phy,
 				      struct cdns_dphy_cfg *cfg)
 {
 	struct cdns_dphy *dphy = phy_get_drvdata(phy);
-	unsigned int dsi_hfp_ext = 0;
 	int ret;
 
 	ret = phy_mipi_dphy_config_validate(opts);
 	if (ret)
 		return ret;
 
-	ret = cdns_dsi_get_dphy_pll_cfg(dphy, cfg,
-					opts, &dsi_hfp_ext);
+	ret = cdns_dphy_get_pll_cfg(dphy, cfg, opts);
 	if (ret)
 		return ret;
 

-- 
2.43.0


