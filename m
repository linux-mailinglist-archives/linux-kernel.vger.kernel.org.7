Return-Path: <linux-kernel+bounces-822460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E51B83EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF203BF8B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E0D2F25FD;
	Thu, 18 Sep 2025 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z/7ryx7x"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741D729B8EF;
	Thu, 18 Sep 2025 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189337; cv=none; b=BpQt/Z3n6MJESdFgHk8eNYqkYugOkOVpLnUeXI7UPgexU72BN+QAdnRniM9mf8sPhZ3uBG7V3pv+5yiW+KoCPNt8yAdymD4rTwb89U81dbL5c/aNQ9D6ojq9ZIedt83u6Q2xbd2O16zej7E/0g5HJ5nXrC0cmIjwnjwYeNjaluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189337; c=relaxed/simple;
	bh=QPBd2rmHbEVccc1KwUlqm2+3s1NAlCKOZ5yQGVmON0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRxzy+14Y+c9tXQwJzSuufDU61JjM+NmeULT/MhbPedCDdMQY2tBiQZdrbps8uGnWoVjeO1aaXCSaSTakcLubVThJf0WhcIauO0L1ul6mQtVzys5CRqeYPoUUDX3uOiuRotE2Lp60DovnnL2puIU21VWGCfq9+YLmKaDhNmgC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z/7ryx7x; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758189336; x=1789725336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QPBd2rmHbEVccc1KwUlqm2+3s1NAlCKOZ5yQGVmON0s=;
  b=z/7ryx7x+c6w+iBMcL4pX8nxU+c+Z7l/qpDmAzuzzQMdXq8WiDzOge7T
   htq6YSDr4fOPrSVH4400E+d+hB/nyc08Y67MFc9/HEw76Oe2GFzgN2kY9
   7MRokU9n4hu90UmBkRkIJZl6AHzK7WXa1x4/ENaWTrSP8xm37alU3jwep
   awUnPg9FLtxRvKzVrbx/pdNPLaGcUc0ZDYKvQANcbuncm5L/rEHKVpYAS
   1MCd8mMM4Mglb8u+nY5TiXKStScPfS+Kk4cHV5mlmgAF0fo7x/sybDgtc
   EICiejtq0nMz2nHFt2Uylc0fo6yqUKRPt1RzQDFceVHbeFMzU9FybEH/A
   w==;
X-CSE-ConnectionGUID: C2CLuXmBRGGskdefAW9nyg==
X-CSE-MsgGUID: Tfws/mIkQSq4rDARAglOJw==
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="214047280"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2025 02:55:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 18 Sep 2025 02:54:41 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 18 Sep 2025 02:54:37 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
To: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
	<Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <balamanikandan.gunasundar@microchip.com>,
	<nicolas.ferre@microchip.com>
CC: Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH 1/4] clk: at91: sama7d65: add peripheral clock for I3C
Date: Thu, 18 Sep 2025 15:24:26 +0530
Message-ID: <20250918095429.232710-2-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918095429.232710-1-durai.manickamkr@microchip.com>
References: <20250918095429.232710-1-durai.manickamkr@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add peripheral clock description for I3C.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 drivers/clk/at91/sama7d65.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/sama7d65.c b/drivers/clk/at91/sama7d65.c
index a5d40df8b2f2..84c6bbe20873 100644
--- a/drivers/clk/at91/sama7d65.c
+++ b/drivers/clk/at91/sama7d65.c
@@ -671,8 +671,9 @@ static struct {
 	{ .n = "udphsa_clk",	.p = PCK_PARENT_HW_MCK5, .id = 99, },
 	{ .n = "udphsb_clk",	.p = PCK_PARENT_HW_MCK5, .id = 100, },
 	{ .n = "uhphs_clk",	.p = PCK_PARENT_HW_MCK5, .id = 101, },
-	{ .n = "dsi_clk",	.p = PCK_PARENT_HW_MCK3, .id = 103, },
-	{ .n = "lvdsc_clk",	.p = PCK_PARENT_HW_MCK3, .id = 104, },
+	{ .n = "dsi_clk",       .p = PCK_PARENT_HW_MCK3, .id = 103, },
+	{ .n = "lvdsc_clk",     .p = PCK_PARENT_HW_MCK3, .id = 104, },
+	{ .n = "i3cc_clk",      .p = PCK_PARENT_HW_MCK8, .id = 105, },
 };
 
 /*
-- 
2.34.1


