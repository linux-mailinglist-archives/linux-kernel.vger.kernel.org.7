Return-Path: <linux-kernel+bounces-726387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D0FB00C9A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC02C6448B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D46306DB0;
	Thu, 10 Jul 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="g5pW/LLR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DC1302CAA;
	Thu, 10 Jul 2025 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178079; cv=none; b=AvmdIBurNSOg2bfSuG7R4xYyyEvwQrPqMZ1HTdMoiNFsA/9JvGunNzPd2nW6VJUrdKFpLjcfnISWy6+KgTGEt35ZWP7Mx3/7WBRPAkKpGdLypioCI5/eP8lWEyDk02+xdV2XoRDfRshp4IfXUlOjpxLO3v+ry905yqJQLsJpan8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178079; c=relaxed/simple;
	bh=lA2OIDdTOCkwdk+6eUUqk+oLgsWQashBUKnhjCCsbEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZQG54uGEaTDSy+/mzP+YGroACMuHJax61jwfDHT0/4/vgOCHklO9KN+kd/ra51glTs6ginHnIs9U7CGToBQFRZZeZfEWZ05Bpt270Wg3Ee+xL5vmsEbYHP1wEiw3KEe8dngUl1BnLAe6kNF2NVzZtu8VwQ7AVyIygd12aRoYlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=g5pW/LLR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752178079; x=1783714079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lA2OIDdTOCkwdk+6eUUqk+oLgsWQashBUKnhjCCsbEc=;
  b=g5pW/LLRPv3rAVWH6ES3TL7NPnBs3qd4XNzYiGfeVVLHQjtLfXB5ZeyL
   i4Fb0a37J93ImaQtA/wyfpBtE4eyy33+E6N0/mZZf3hXAlLw/WoFvAvCt
   m4NlRp/AVwrih4Lxr81kyxCCCQrIVRMe+1xFKrDX5RN3w/guDdT+pgIqE
   A9WxfIckHze6T0WcybYuIeKSHkKS3QhxfPKr7HJdh4qaCecrngoq1+Hmk
   iIMQneaEiSydkrOEQGW1E4qQNzks1wFJESFH3mdAFkuGACM8YNIn3+4Bk
   Ka9oczkWobC7I3Rm/MSKZ1gzY+3fL0PNczVOVSAaZzMkkwjgCyenTfT23
   A==;
X-CSE-ConnectionGUID: qOQSLemoQZOGUxBCHa7nXg==
X-CSE-MsgGUID: 1J0KURvdTXiUsa0PWS/rbQ==
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="275215690"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 13:07:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 10 Jul 2025 13:07:35 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 10 Jul 2025 13:07:35 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <varshini.rajendran@microchip.com>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robh@kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 32/32] clk: at91: sam9x7: Clean up formatting
Date: Thu, 10 Jul 2025 13:07:25 -0700
Message-ID: <6e904e4dbb0f591e0fd8200e948c3c0d8debec6f.1752176711.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1752176711.git.Ryan.Wanner@microchip.com>
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Clean up variable formatting as well as add an extra space to improve
readability.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/sam9x7.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
index 56243f6f7e65..ce6ad2a0be98 100644
--- a/drivers/clk/at91/sam9x7.c
+++ b/drivers/clk/at91/sam9x7.c
@@ -739,16 +739,16 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 {
 	u8 td_slck_index = 0, md_slck_index = 1, main_xtal_index = 2;
 	struct clk_hw *hw, *main_rc_hw, *main_osc_hw, *usbck_hw;
-	struct clk_range range = CLK_RANGE(0, 0);
 	const char *const main_xtal_name = "main_xtal";
 	const char *const td_slck_name = "td_slck";
 	const char *const md_slck_name = "md_slck";
+	struct clk_range range = CLK_RANGE(0, 0);
+	struct clk_parent_data parent_data[9];
 	struct pmc_data *sam9x7_pmc;
 	void **clk_mux_buffer = NULL;
 	int clk_mux_buffer_size = 0;
 	struct clk *main_xtal;
 	struct regmap *regmap;
-	struct clk_parent_data parent_data[9];
 	int i, j;
 
 	main_xtal = of_clk_get(np, main_xtal_index);
@@ -943,6 +943,7 @@ static void __init sam9x7_pmc_setup(struct device_node *np)
 		PMC_INIT_TABLE(mux_table, 4);
 		PMC_FILL_TABLE(&mux_table[4], sam9x7_gck[i].pp_mux_table,
 			       sam9x7_gck[i].pp_count);
+
 		for (j = 0; j < sam9x7_gck[i].pp_count; j++) {
 			u8 pll_id = sam9x7_gck[i].pp[j].pll_id;
 			u8 pll_compid = sam9x7_gck[i].pp[j].pll_compid;
-- 
2.43.0


