Return-Path: <linux-kernel+bounces-726388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05414B00C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03C63A1E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3F43074B4;
	Thu, 10 Jul 2025 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mIKsCFcy"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10D6303DF4;
	Thu, 10 Jul 2025 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178081; cv=none; b=gJioLY+YbAMYPhmrQ/NDx3DHgdMbInlLRNm5kvRSJD9BqWf2ToG/hTQpaeRVo1ds+2RUyptYC2lXxm/WlLwagZz2/xaQ6noaRoSbnAIT4fnGM8trkg3lBuU1/jSgZeLI9wj8IBoQ0vIj19nOpqD36ABQLJXtJ4ZBPxQBls84QMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178081; c=relaxed/simple;
	bh=Zv0CC3WYKH/36O9O0t/SOoiKrmvlfng/rt5RJxB0L+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdmqT3BIpm+W+bRs/mgl3YHnbqs8YZE9qj79Lv3yOW+nExv6IgoflYjmBW2B8RFk/nNQaFrXUXhpGCTQ5r/CSdhRrHswsg7FxR5PfwMWKzrXksPmpKUp6yIT/B/LhfCLnjz10CpDM8kCrwN9m7qlOAy7WmZQOl9hHZKLuLyKtqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mIKsCFcy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752178080; x=1783714080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zv0CC3WYKH/36O9O0t/SOoiKrmvlfng/rt5RJxB0L+A=;
  b=mIKsCFcymSpO5x63OUtpavnqF/B+sgxjmkPorh7bE+zYvz9mnJhTZsnY
   RjhQCGsIMD+x2/AiXhlUoIBV6u6FWqJ+Shiv8tQISQKjH57apQtQVbWUF
   QZf9G1HjfZQ1//t23u4/lXR8S1goBdITrkBD2WZRDq0itaubAnDAC3syT
   gfMCfXofNZWZbw1pdWFkv/7HRtkZMMfCl3LefkgS7e5AzH/nnIPOvlflh
   VjGbbiHuCcO+MDh1OI6wbmkIkRwU+BEYaPDpkALABEXQSfu7piRyac1d4
   2tb6qC1XprfhNS4YmvQ1QDqfALw0wGJ3c83qzrpWALxMYwTiumltboSK6
   Q==;
X-CSE-ConnectionGUID: VcY24SkbRKSMnNSaLxS1vA==
X-CSE-MsgGUID: zr4ioYhrTsmq9eXidwg21Q==
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="44448156"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2025 13:07:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 10 Jul 2025 13:07:30 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 10 Jul 2025 13:07:30 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <varshini.rajendran@microchip.com>, <linux-clk@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<robh@kernel.org>
Subject: [PATCH v3 01/32] clk: at91: pmc: add macros for clk_parent_data
Date: Thu, 10 Jul 2025 13:06:54 -0700
Message-ID: <f3ef0275345578c504b41710c67bfe1238c44c21.1752176711.git.Ryan.Wanner@microchip.com>
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

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

Add helpers to set parent_data objects in platform specific drivers.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
[ryan.wanner@microchip.com: enclose complex macro with parentheses.]
Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/pmc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 4fb29ca111f7..0b721a65b77f 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -15,6 +15,12 @@
 
 #include <dt-bindings/clock/at91.h>
 
+#define AT91_CLK_PD_NAME(n, i) ((struct clk_parent_data){ \
+	.hw = NULL, .name = (n), .fw_name = (n), .index = (i), \
+})
+
+#define AT91_CLK_PD_HW(h) ((struct clk_parent_data){ .hw = (h) })
+
 extern spinlock_t pmc_pcr_lock;
 
 struct pmc_data {
-- 
2.43.0


