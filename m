Return-Path: <linux-kernel+bounces-788511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF472B38584
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E211B23A11
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1CE21A94F;
	Wed, 27 Aug 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dXjBSr79"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BD522541B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306524; cv=none; b=AyYu5yvWnDLf/lKeKKOCT9+2U+0WzJOcC/29HVNKy1AVKxph581kFdntXRIakhCYoI82mAnR2U61r0X6xhx9hfPZHvH9utb5C38bMMD5rjzuwi415gV3867wp7iDiJObdCTBuuZDoUl6l8xPYhbEjv0ADN2TrabIyp1dfXtyQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306524; c=relaxed/simple;
	bh=VVTD+gRkSYL1zFC/AuUFrbB6yo9BKBx9w+JU2+HE7nE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkrrCA7xsJVxzlUQS4uGgM3Ip3vX+1TiIkNTdeEt1pJ5/76I6RXL8DzG+OAcsODGZ29qdJ+ATxTq3Y0etxTQdVcgnTQXKQWiUZuhrltuL2BY2D9zbhE1s8hvHXZfcqq/VjIjEBVXVBbDVr4j0soMleG9b/NDCMUwahtcp6X4K6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dXjBSr79; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756306522; x=1787842522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VVTD+gRkSYL1zFC/AuUFrbB6yo9BKBx9w+JU2+HE7nE=;
  b=dXjBSr79l1rg4y/PB85wHxPT8yWPjeLlhPs32jID3xeYn4W7YDzqFhVa
   p9AicCd4sa4b89FnPa5xJAmm2HaqtXZFxYy58cbxgmiITdM2kke1ny3C9
   zQUOm4eJgTO8gH6SrzSMBIA9lEclUDJ54WZD/Id43yeVDyjP49KvzdnZH
   3eYZgJG4MH7hVEMUQZZ7rs0lGntuEndd/96pJ+3yKZlqfe8VbJcweaBXL
   uolHhzMyLuXmGJGisRLIymfcdVsJflTZensjPoPmAbb+KDo1VesFbOl89
   WbpLPcJDlu9r0JHnkKfO1SS1xvJ8eCJCBHGf6J4twkcjyiHoN0TW4y2/m
   A==;
X-CSE-ConnectionGUID: 4yuHX6b1S/u7TSh6v5Gw7g==
X-CSE-MsgGUID: BUnd2GltR5uNF4z6Farg4g==
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="46291227"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2025 07:55:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 27 Aug 2025 07:54:44 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 27 Aug 2025 07:54:42 -0700
From: <nicolas.ferre@microchip.com>
To: ARM Maintainers <arm@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Ryan Wanner <ryan.wanner@microchip.com>,
	Varshini Rajendran <varshini.rajendran@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 3/3] ARM: at91: pm: save and restore ACR during PLL disable/enable
Date: Wed, 27 Aug 2025 16:54:27 +0200
Message-ID: <20250827145427.46819-4-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827145427.46819-1-nicolas.ferre@microchip.com>
References: <20250827145427.46819-1-nicolas.ferre@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Add a new word in assembly to store ACR value during the calls
to at91_plla_disable/at91_plla_enable macros and use it.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
[cristian.birsan@microchip.com: remove ACR_DEFAULT_PLLA loading]
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 7e6c94f8edee..aad53ec9e957 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -689,6 +689,10 @@ sr_dis_exit:
 	bic	tmp2, tmp2, #AT91_PMC_PLL_UPDT_ID
 	str	tmp2, [pmc, #AT91_PMC_PLL_UPDT]
 
+	/* save acr */
+	ldr	tmp2, [pmc, #AT91_PMC_PLL_ACR]
+	str	tmp2, .saved_acr
+
 	/* save div. */
 	mov	tmp1, #0
 	ldr	tmp2, [pmc, #AT91_PMC_PLL_CTRL0]
@@ -758,7 +762,7 @@ sr_dis_exit:
 	str	tmp1, [pmc, #AT91_PMC_PLL_UPDT]
 
 	/* step 2. */
-	ldr	tmp1, =AT91_PMC_PLL_ACR_DEFAULT_PLLA
+	ldr	tmp1, .saved_acr
 	str	tmp1, [pmc, #AT91_PMC_PLL_ACR]
 
 	/* step 3. */
@@ -1207,6 +1211,8 @@ ENDPROC(at91_pm_suspend_in_sram)
 #endif
 .saved_mckr:
 	.word 0
+.saved_acr:
+	.word 0
 .saved_pllar:
 	.word 0
 .saved_sam9_lpr:
-- 
2.43.0


