Return-Path: <linux-kernel+bounces-807967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EFDB4AB7E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 13:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF43B170A01
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9555E322A33;
	Tue,  9 Sep 2025 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="blNrwbJv"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F6B322A08;
	Tue,  9 Sep 2025 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416435; cv=none; b=uW0tD/rfHR4XeI89IYl2SNl75HQf5c4AO6a0cm+0eLL0ljLRu4ZXPTH6bz61dKVHComLuHj3YxjmH5fqJwUIAy7FgGfdqMO8vEDR1kcEuRSY7muQAAl1NVvpRvoFoy025bp6CKtzqpf3uN8ls/w9Cd2GNR9ymHOQRsDaZn4m100=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416435; c=relaxed/simple;
	bh=QPBd2rmHbEVccc1KwUlqm2+3s1NAlCKOZ5yQGVmON0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofOkcsJmXrmUpIpEjljZMN3OchHNUfOINknXQjxYwxgjy6/00AysZGqGoA6RutFI6tFeA8v8DfMthE/l7ueGsbiUFfnXEKvhPFEisSkfFMs3KDn3rvdUBMuUJE/L6gHjG01S8ntNgCujSsrMWRf39eBu8tHdJDvqOupq5CQ2VS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=blNrwbJv; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757416433; x=1788952433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QPBd2rmHbEVccc1KwUlqm2+3s1NAlCKOZ5yQGVmON0s=;
  b=blNrwbJvAREeQh5AjJJKvOFWaBRXIG13JQ+H1IPaDEMYYNM3Uphp0gz3
   IQCHoHq+GFrejFTh7QNq2WRxSk5Ux9qdf1oIqcRJMeIToZnQPBlMeKPD6
   BRuyc0fIiWmOT1VK0HPkIFUSJ7FAV881cDrdf80/r/wE1vxnv6T5VHsOR
   5LmxvaNvP+7PR/f77Uux8Apu/lIVRqjJQVo5DT+TkPI/cqu2muZagbhf8
   PRUqOfjioZSO1YO2LcohrUBbRqMgpEXa6F3OFWrsU4x0H2qK5pxVXJ+0C
   p18NnWvmUxYDARZ8SJaQVTC2m5zRyM2hWyf8If+cYP+4/ZfAvoR6+d7LR
   Q==;
X-CSE-ConnectionGUID: ARS+qEZySeuUoMKxmSXXIQ==
X-CSE-MsgGUID: QF6Fn9i0SsiX6+92XeCY2A==
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="52018064"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2025 04:13:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 9 Sep 2025 04:13:52 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 9 Sep 2025 04:13:46 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
To: <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
	<Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <balamanikandan.gunasundar@microchip.com>,
	<nicolas.ferre@microchip.com>
CC: Durai Manickam KR <durai.manickamkr@microchip.com>
Subject: [PATCH 1/4] clk: at91: sama7d65: add peripheral clock for I3C
Date: Tue, 9 Sep 2025 16:43:30 +0530
Message-ID: <20250909111333.170016-2-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909111333.170016-1-durai.manickamkr@microchip.com>
References: <20250909111333.170016-1-durai.manickamkr@microchip.com>
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


