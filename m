Return-Path: <linux-kernel+bounces-726389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F97B00CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2576C7BE2A7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 20:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7808E3093AF;
	Thu, 10 Jul 2025 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ylb/ntb0"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9D2FD892;
	Thu, 10 Jul 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178083; cv=none; b=l2RbruYCHCzZJcEAK8GOhJ5GOS2WGaiV2UFdsnsBVvkcaaFAmHg37tzRyHMWntJGl4S2KR41t0jq5TOrfY3pGFqdYQA7v8RosHHBdatF6SQCklcet9DDJBMTsPPmiU2fifJ/W6HqAtHXeEQhDrqd3gaETdkocIKQUyP+KHPwj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178083; c=relaxed/simple;
	bh=9aK4jdZmF1ToqNiZetoB/6dP7GUhww2O/JrrrKTukA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWwd6IfBoLiAKJS0/iNiFRwn8vmaihjpNhQ5G2AP6K7uEOiRcJOA8Ca5IzGrPf5BOQsFOomO5k1JITCS2ju7HghZbBQnZAbdasPvIfItgSZF19UtyCZsmMo57i+il1VG2+G4vyzQboimlT8JXL5EpHCwra8tliLVcWb6Bum0AdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ylb/ntb0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752178080; x=1783714080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9aK4jdZmF1ToqNiZetoB/6dP7GUhww2O/JrrrKTukA8=;
  b=Ylb/ntb00jkwPklDqgwMUMtJlhoFX6iAvl9Y9boKMihsBnPVDzl8E+tf
   xTvdgBrxuN64V1YzmUZdlNeQyOqu8RwVeSpDnqk4skt/YeHapHORDukSs
   cZmI54PUfzEP+YBf940zIetFj+YXnhCpyjAWM3bpzcsh7zuC8TLA8TaXF
   V1h4w+fCPXH7YGlrGMItFNCeuWCWd1z2NVm8dvUB/gqWY8YKGWmF2M7T/
   lvwH+7rkgzNy6q7nSCsl1u/QLJ1cETiMHvdOyTlH/DEeEMlE0Rjwgj7Ob
   tjY5G4rf0C8floMcFG4eGwGyMrog+1INt5IZF3RZBjYOkjQnTF7Q2LwZv
   A==;
X-CSE-ConnectionGUID: VcY24SkbRKSMnNSaLxS1vA==
X-CSE-MsgGUID: NpbT3xu2Tfe2nS8n08xCCg==
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="44448157"
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
	<robh@kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 02/32] clk: at91: pmc: Move macro to header file
Date: Thu, 10 Jul 2025 13:06:55 -0700
Message-ID: <6776f06473d3be71882ef938a4314947f565e26f.1752176711.git.Ryan.Wanner@microchip.com>
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

Move this macro to the header file as it is used by more than one driver
file.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/pmc.h      | 3 +++
 drivers/clk/at91/sama7d65.c | 3 ---
 drivers/clk/at91/sama7g5.c  | 3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 0b721a65b77f..63d4c425bed5 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -21,6 +21,9 @@
 
 #define AT91_CLK_PD_HW(h) ((struct clk_parent_data){ .hw = (h) })
 
+/* Used to create an array entry identifying a PLL by its components. */
+#define PLL_IDS_TO_ARR_ENTRY(_id, _comp) { PLL_ID_##_id, PLL_COMPID_##_comp}
+
 extern spinlock_t pmc_pcr_lock;
 
 struct pmc_data {
diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
index a5d40df8b2f2..b74813a288a8 100644
--- a/drivers/clk/at91/sama7d65.c
+++ b/drivers/clk/at91/sama7d65.c
@@ -428,9 +428,6 @@ static struct sama7d65_pll {
 	},
 };
 
-/* Used to create an array entry identifying a PLL by its components. */
-#define PLL_IDS_TO_ARR_ENTRY(_id, _comp) { PLL_ID_##_id, PLL_COMPID_##_comp}
-
 /*
  * Master clock (MCK[0..9]) description
  * @n:			clock name
diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
index 8385badc1c70..bf6092fea217 100644
--- a/drivers/clk/at91/sama7g5.c
+++ b/drivers/clk/at91/sama7g5.c
@@ -341,9 +341,6 @@ static struct sama7g5_pll {
 	},
 };
 
-/* Used to create an array entry identifying a PLL by its components. */
-#define PLL_IDS_TO_ARR_ENTRY(_id, _comp) { PLL_ID_##_id, PLL_COMPID_##_comp}
-
 /*
  * Master clock (MCK[1..4]) description
  * @n:			clock name
-- 
2.43.0


