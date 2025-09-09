Return-Path: <linux-kernel+bounces-807873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB89B4AA9A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D094F4E7E3D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC4E31C58C;
	Tue,  9 Sep 2025 10:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PJkkAKNf"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A3B31C561;
	Tue,  9 Sep 2025 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413614; cv=none; b=Zo857vA5mo+6gbINzThscrZIKVJFJ/tMBX9YYKxEYqPYuBGbsvfJnVS0j7VYfd+HOCw8JvYxWuhKOS2x6hgFJj5L17Ld0GVtWfdoV7Q3VeEkDKuJ7jnVWDPf8ocs9HbcB8OaR8kzJOfydEke3KWngf6ZHslL4zLN4dbyBpj7cdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413614; c=relaxed/simple;
	bh=TsHx0E0bZEcU25DoRIWksMw+4boTtgCMbcApd7sVvVM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t6k47WYLizlNkuTIxgfrKnH5awuIN8Rob5ro2vtHgCNaR8Rkqu/1rhaCh5DeMaDZaDF5q8ZCPTSWEwPejN3VvTEsjOWdKfbtURlLlnNIpuK2kah8WSsXuPRrCrq0ri33Z3EcUXxNr9/aGqb/StSXL4OLRVKok8PQQhdpGCczK5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PJkkAKNf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757413612; x=1788949612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TsHx0E0bZEcU25DoRIWksMw+4boTtgCMbcApd7sVvVM=;
  b=PJkkAKNfX90M/eslB4I6klkyyQ+95rHLgTQT2m0T/SEpEF7bbgMVgESV
   KhE/Hmwmn+tiin2CdKDQDHxDTG00oGzM3FvRUCTXWlamIdv1+2PgnsaU7
   Nghqs3W2wRRci/SWLiLrdtnpDjZ8Xm9+xFvyUIjMhfaTVYM9u+PQB8Z2A
   bcABEFOudVpdqCV72fADp/4GMBG1KlHmde7ql8UKaGSWIdobEmbPsql/W
   7ap2+pm3jmqi/PwEQjptyavVGQ5i6bgIGl5FxPb2nydhSwnf3K/5lmgC4
   1pFivSUvev+GCXa+vwtUeImhlWkNf1Q6i2cRDnEZnSvq+urAWUFW/KxgE
   Q==;
X-CSE-ConnectionGUID: 75xiUm+nRtary3wX5uzH4g==
X-CSE-MsgGUID: eSJAwpQATcGykHA1prwJMA==
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="52016379"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 03:26:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 9 Sep 2025 03:26:11 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 9 Sep 2025 03:26:06 -0700
From: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Balamanikandan Gunasundar
	<balamanikandan.gunasundar@microchip.com>, Varshini Rajendran
	<varshini.rajendran@microchip.com>
Subject: [PATCH] clk: at91: sam9x7: Add peripheral clock id for pmecc
Date: Tue, 9 Sep 2025 15:56:38 +0530
Message-ID: <20250909102638.47624-1-balamanikandan.gunasundar@microchip.com>
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
Acked-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
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


