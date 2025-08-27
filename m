Return-Path: <linux-kernel+bounces-788512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDB1B38587
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7235E1B23050
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F17C227EA7;
	Wed, 27 Aug 2025 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GCh0mveR"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E306224B05
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306545; cv=none; b=inSLRG+59QQQzhqzUv2exjBTA1kc7jcr/vfhG/npm8DmpV5sexYc9E0025kCXlOWDIsxSX7QH8caIHtculMcp3qmzBmB4bDF6gAWPkTO8zolfgkCqqSnPO0SDCgpZmyak+cbs+q44+mrHCbD9np85i4m8DEI7ytQwEJcA5NG11g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306545; c=relaxed/simple;
	bh=RASQzDEjrALc3K/YuT5UvThKt2BVAZIxpTZ+5exrzzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huijDajygnDPIngf5E8XKJBVDM65v1kZcfbc49UcO6tsJkc4Jd3gTwybAl27Cculsxv2G3VDE0f5rdED9TF0zBx7C+D2j//wVPF+sLdAOIG7eT8cLrz3nV8EC4bWiHrNCHZRjOLQUNY+bzszXIkrZ6rWptGy8zEGdnbwoSbx+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GCh0mveR; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756306544; x=1787842544;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RASQzDEjrALc3K/YuT5UvThKt2BVAZIxpTZ+5exrzzU=;
  b=GCh0mveRmFhwL3Mt3E4lNTM8HztRQGc33ECG/JteXucpMaNg++xmlTs5
   Lm3HEUiPF4hSpLJwwmI4rkckmFLW6wTkwM/dJpbL2s8yOm+8BqbjYfUTz
   cd5PVGlPnCTlv/7OTQcT2ePBByHLJyHrWdahdXMjSpTtTLteuoD9TyRuE
   jhXt9E9i9EB777oLrBLSUDOFFl05EQ8YEUAOUIqBukMiQZ4ENZ0gHd/fM
   YHrwVEbku0AahoEFUIian4vjcIVFA65PzD5HDrK2s/IR9G+G4HakYXMfZ
   yETv1Y3rgY3GZ+yyH06A+cumcLdjbsDXpxZDBl2JazTiH/L53tIXLfH4w
   Q==;
X-CSE-ConnectionGUID: qmQ3gJioTdWJF8Sch/45rg==
X-CSE-MsgGUID: FPpwuLK0SzS4wq4WK45RWQ==
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="213136671"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Aug 2025 07:55:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 27 Aug 2025 07:54:39 -0700
Received: from ROU-LL-M43238.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 27 Aug 2025 07:54:37 -0700
From: <nicolas.ferre@microchip.com>
To: ARM Maintainers <arm@kernel.org>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Ryan Wanner <ryan.wanner@microchip.com>,
	Varshini Rajendran <varshini.rajendran@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 1/3] ARM: at91: pm: fix .uhp_udp_mask specification for current SoCs
Date: Wed, 27 Aug 2025 16:54:25 +0200
Message-ID: <20250827145427.46819-2-nicolas.ferre@microchip.com>
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

All SoCs using this structure field .uhp_udp_mask in configuration
index 4 don't have the bit 7 specified: sam9x60 nor sam9x75.
Remove this bit from the mask definition to match register layout.

This mask is used in function at91_pm_verify_clocks().

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/mach-at91/pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 3aa20038ad93..35058b99069c 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -1364,7 +1364,7 @@ static const struct pmc_info pmc_infos[] __initconst = {
 		.version = AT91_PMC_V1,
 	},
 	{
-		.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP,
+		.uhp_udp_mask = AT91SAM926x_PMC_UHP,
 		.mckr = 0x28,
 		.version = AT91_PMC_V2,
 	},
-- 
2.43.0


