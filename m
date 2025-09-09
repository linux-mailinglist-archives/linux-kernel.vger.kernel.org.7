Return-Path: <linux-kernel+bounces-807896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784A5B4AAD4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346EA344EF7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEBB31AF3B;
	Tue,  9 Sep 2025 10:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DjS7wI6p"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6D631A56D;
	Tue,  9 Sep 2025 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757414279; cv=none; b=AQ4nPYa4c+AcOOGZ0E7+osJMW7r2p+SKLJOtouSeP8ksy6PyZtXrpFMRwqYX/MA0GGi00Y+dROmDUdV87opwG0kUcvmpAuqEM5Ljjclg4eLZiz7boX/0VsdnwijAhFe98uC9svoFFcjhvYexF5GYrUNGXaEugL9mwAL2Z1MD7KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757414279; c=relaxed/simple;
	bh=75ANhpaW227bGu0JKhRJlzVZJZScwakaz/wvhDzumdE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AqtiDJ6ghOLJMdVg3lvAPCQR57vlmrXnwKx8pkw908WnOp7NSnl5GQxzNWibMMmmv049qy2qaKZobkqR8xdpPKw712GSItY5KEAPGFJKjp4iXDlcix/gS9acXhxWXW81YiV8is4R0dWE9LZ9+lFp74bUa4Ehda5Yf5rUq5bDIUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DjS7wI6p; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757414277; x=1788950277;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=75ANhpaW227bGu0JKhRJlzVZJZScwakaz/wvhDzumdE=;
  b=DjS7wI6p6a1i7PRiHshI7rRMC4L8QRpVOLpWWhKnDVviDmXyTyiT9OV0
   /FVY+7uPVf7TG7pKpxWZtQ5zhxZaMgdkS/42ZqB97o3+vb2lWrVcL8TNS
   2bEf5y/aYG6kE1Xdw7HB+pysOWffxg3MZx/6s3Ca1f32OorgnfBfXnvrf
   yj1mEw+7P1lxXHin4OzWqKDtznSRUorGzDwtO4SvqJy3MBIcyXu8jvFL9
   Q4mNgEoCV3vcMio2AXvbUFaOROa8ZNRpswd8t2sK9o4o7Q64zOXr2dxvO
   hX4IIE9j1lde8SMC5wVRWNaOf7oZxujwdno82Vc9CfEZJP6pGOABAGXJM
   g==;
X-CSE-ConnectionGUID: 4S6DztCWTLSzrCQS5AblUg==
X-CSE-MsgGUID: XXV7pOUQR5KQenWm5l5WqA==
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="52016856"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 03:37:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 9 Sep 2025 03:37:45 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 9 Sep 2025 03:37:40 -0700
From: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Balamanikandan Gunasundar
	<balamanikandan.gunasundar@microchip.com>
Subject: [PATCH v2] clk: at91: sam9x7: Add peripheral clock id for pmecc
Date: Tue, 9 Sep 2025 16:08:17 +0530
Message-ID: <20250909103817.49334-1-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add pmecc instance id in peripheral clock description.

Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
---
Changes in v2:
- Removed Acked-by tag that was added by mistake

 drivers/clk/at91/sam9x7.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/at91/sam9x7.c b/drivers/clk/at91/sam9x7.c
index ffab32b047a0..bce60f7393d5 100644
--- a/drivers/clk/at91/sam9x7.c
+++ b/drivers/clk/at91/sam9x7.c
@@ -403,6 +403,7 @@ static const struct {
 	{ .n = "pioD_clk",	.id = 44, },
 	{ .n = "tcb1_clk",	.id = 45, },
 	{ .n = "dbgu_clk",	.id = 47, },
+	{ .n = "pmecc_clk",     .id = 48, },
 	/*
 	 * mpddr_clk feeds DDR controller and is enabled by bootloader thus we
 	 * need to keep it enabled in case there is no Linux consumer for it.
-- 
2.34.1


