Return-Path: <linux-kernel+bounces-788510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BD9B38586
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E9943B3DB4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD5D22A4F8;
	Wed, 27 Aug 2025 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="u8Pe1lK+"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE98C224893
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306521; cv=none; b=O6MBvRFyD6kg+jOTEY8eKaiWlKQMHmvSP5z8btgmxu7iEDehFRYPpD7r3ZUXJiJLVHN9wUMynELuVKAISUMoJX7dWV1SEDdoEvp/Bl8TO9OOx/b6qJAwul3EobW+tz+m0e7IVMGLvTvQV7E4rEE0r1mraqU8lGNDjoti5gh8qGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306521; c=relaxed/simple;
	bh=uwD7I3Vk5NcXfozUcavy0K+Nxxxwd8y/BEigyn9nl4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCo/UAZ9eg4Y1f+Wcp+vHeDSdoxaFE6rUsJbY+VA+qfViZ5lA3wfHtN3H+2OA4JiKtMbLGjcfP1pLptchkhdsHZ9CMPUXhjF3GvYde6NAvfWDneQl18DTNMfo8Dyz5XTsp/DEBPJ1hgsl34Ux2mCxH6DI9DOlMsBObpreFppxr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=u8Pe1lK+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756306519; x=1787842519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uwD7I3Vk5NcXfozUcavy0K+Nxxxwd8y/BEigyn9nl4g=;
  b=u8Pe1lK+xNpWS/UOpJsbS7lERhunHAhXyxYKt/Zrk7p99gXxJGaD9MEG
   GZiDizV2AzIL4RIBLm66+sFORhFgN1nx94iRbtleFQbYTvb9pPh/LrZAz
   BR3fmdvWy9dEbZ1Ihy92vBhmWUHtDsukpZlstYQsf8d2Z6ztSHhRLSWGG
   VL+4zA+wvhUR0byOqqGNHvz++3ErQ0XKVgGYjh4DeVpW3R5e6ylHC3wmu
   Ae90W+OFN5lfQPxeUKup9XQtTJgDZP0k/L2EWNQDwHRJ2kaV2DvAZHZ7g
   bJ8p2J0ito543GvczgE9G88b5rw+qogvyxO/RH5/1dKYinGNY7VLGqLnr
   Q==;
X-CSE-ConnectionGUID: 4yuHX6b1S/u7TSh6v5Gw7g==
X-CSE-MsgGUID: tIBq8RwESmygDYS25zfFeQ==
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="46291226"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2025 07:55:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 27 Aug 2025 07:54:42 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 27 Aug 2025 07:54:40 -0700
From: <nicolas.ferre@microchip.com>
To: ARM Maintainers <arm@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Ryan Wanner <ryan.wanner@microchip.com>,
	Varshini Rajendran <varshini.rajendran@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 2/3] ARM: at91: pm: fix MCKx restore routine
Date: Wed, 27 Aug 2025 16:54:26 +0200
Message-ID: <20250827145427.46819-3-nicolas.ferre@microchip.com>
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

The at91_mckx_ps_restore() assembly function is responsible for setting
back MCKx system bus clocks after exiting low power modes.

Fix a typo and use tmp3 variable instead of tmp2 to correctly set MCKx
to previously saved sate.
Tmp2 was used without the needed changes in CSS and DIV. Moreover the
required bit 7, telling that MCR register's content is to be changed
(CMD/write), was not set.

Fix function comment to match tmp variables actually used.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Fixes: 28eb1d40fe57 ("ARM: at91: pm: add support for MCK1..4 save/restore for ulp modes")
---
 arch/arm/mach-at91/pm_suspend.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index e23b86834096..7e6c94f8edee 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -904,7 +904,7 @@ e_done:
 /**
  * at91_mckx_ps_restore: restore MCKx settings
  *
- * Side effects: overwrites tmp1, tmp2
+ * Side effects: overwrites tmp1, tmp2 and tmp3
  */
 .macro at91_mckx_ps_restore
 #ifdef CONFIG_SOC_SAMA7
@@ -980,7 +980,7 @@ r_ps:
 	bic	tmp3, tmp3, #AT91_PMC_MCR_V2_ID_MSK
 	orr	tmp3, tmp3, tmp1
 	orr	tmp3, tmp3, #AT91_PMC_MCR_V2_CMD
-	str	tmp2, [pmc, #AT91_PMC_MCR_V2]
+	str	tmp3, [pmc, #AT91_PMC_MCR_V2]
 
 	wait_mckrdy tmp1
 
-- 
2.43.0


