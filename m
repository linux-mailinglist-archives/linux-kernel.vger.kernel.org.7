Return-Path: <linux-kernel+bounces-823631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D00B870CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BE13AD956
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B995A2FA0ED;
	Thu, 18 Sep 2025 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qog+rh7t"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978952F3620;
	Thu, 18 Sep 2025 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758230191; cv=none; b=AqEMz8rFki+4141wCnQ1xaRlUn94SLvZlmkCWyNXyC1ly6ygNk4T0Trbk7AsObNX+hXATc7EtZo3/B3kEKeSQzY4eIDrPrfuU9ztjxj6HIV+6IpK7SzjYXG4gmsmOkTs64rZtIDhzUb1oED18ZBgcyzfiffAl8V91tf3+gmmD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758230191; c=relaxed/simple;
	bh=eiAbsnGms6AR3/Kbu9EsaYVOqnu8+/1DgwnZm9I3Xpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0aA5cHBh0EAZ5MUq6PAz3F83hVgOCa9oNyebdQec/jY1ZszEKjPjOLloyAgH3rbeG1gl5SEAoyTw2mTIDoDCF1pHwfJ9cgMcONg1EXNR930yogDvxeOlPEr2nwBz+4Od3PZRuuVHtUYYoeHjxsmDp1HodW9ZvhVWuFdf0Jhv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qog+rh7t; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758230189; x=1789766189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eiAbsnGms6AR3/Kbu9EsaYVOqnu8+/1DgwnZm9I3Xpk=;
  b=qog+rh7tjVqpD5sqnCZfMHp8+2/fQWwGyC8IOWf6inlIH8b5S6kAmPBu
   u0I9RJHtM/4hgJiQojASvtXDHJcCsXvAra5ckFt3GHIwZUqtACaZrIVSx
   iHkcqP7D/1XL7D20EgYPGfW8f45iqv+xQbj1d153xqAaw2vfeERbEyXjm
   jRtqy+/VrxXrMe8OGPJT3Hvv14VBsUbZibBcHaRC8ZSZJ8amiAgLHP/av
   n2Ae3ilf9HR+KkomKPDJjVKAN1yL/hAnBkncvKS5/jjwPnTBX604StGlO
   /LGuMdGtM9scMgfq3OfYh22s5Ue/jJms1evTjNCcwBMN1+/nd6wr0Q2yV
   Q==;
X-CSE-ConnectionGUID: 1s1RKV33Q2arVnZUGnGVZA==
X-CSE-MsgGUID: ME2EnWGiRN6AnUXUU3fLVg==
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="214079911"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 14:16:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 14:15:50 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 14:15:50 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<nicolas.ferre@microchip.com>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <varshini.rajendran@microchip.com>
Subject: [PATCH v4 01/31] clk: at91: pmc: add macros for clk_parent_data
Date: Thu, 18 Sep 2025 14:15:43 -0700
Message-ID: <0221c90ab3025c8e72fcdcf54c685da058c0fe4d.1758226719.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758226719.git.Ryan.Wanner@microchip.com>
References: <cover.1758226719.git.Ryan.Wanner@microchip.com>
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
 drivers/clk/at91/pmc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 5daa32c4cf25..4a416d227c50 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -15,6 +15,14 @@
 
 #include <dt-bindings/clock/at91.h>
 
+#define AT91_CLK_PD_NAME(n) ((struct clk_parent_data){ \
+	.hw = NULL, .name = (n), .fw_name = NULL, .index = -1, \
+})
+
+#define AT91_CLK_PD_HW(h) ((struct clk_parent_data){\
+	.hw = (h), .name = NULL, .fw_name = NULL, .index = -1, \
+})
+
 extern spinlock_t pmc_pcr_lock;
 
 struct pmc_data {
-- 
2.43.0


