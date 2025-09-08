Return-Path: <linux-kernel+bounces-806695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122C4B49AAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21964E1BC9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4212D7DD4;
	Mon,  8 Sep 2025 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kaxq5pcp"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A41C219A86;
	Mon,  8 Sep 2025 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757362035; cv=none; b=vDwIGjP2c72aiZmJEAA7WLJLaYhbgPnVdM+NtXf60/r4N+wvsw4+OxLZzgba1jyudK5p5sv0f1/EluC04mLdF0wti5H3l7WRuvhtSxT0P8qorP2HeW6Emt+5zGVltT5jQUDft99TRfjlM/CoYhUzyu6crZTwp7QgOnWDiE0ga88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757362035; c=relaxed/simple;
	bh=BoqMfXbExT7t634yESc/SibX5EIdQetlbFOZlCukLw0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B7i4nfVICqgUJIudW1zJtFqs5LiNdhimtshGgkNBs+IBu1OCNtVb4uUutReCZ8giBDMxZc2fTJ0xxPWDE+gh4aL3WqqSijvoWdjVSNH572C825nUmZEijzA6ALDR+afJN7m44Ubmw1CRSkO/UPRrb29JS6k0BJ+9+Fu/AOBfDuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kaxq5pcp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757362035; x=1788898035;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BoqMfXbExT7t634yESc/SibX5EIdQetlbFOZlCukLw0=;
  b=kaxq5pcpCug2K8NkfBFZe0rqgNJY8RQU2vXA29a172zw1nyv54tesbn7
   LlCguINCf/b0F3B4S1ymznq2xDU3PMytvizKzsH1JPEOQqzDmYpGz5C1z
   FiGlRkWHm07+zLOqZ8ZU3tP+juckoN3m5UgCVmU358ouCb31/PrxXPDjZ
   mCSpysqnUBkLbJaJ8TH4skphrnH990yigMX8UkejcV/uhZlscpdfN66/V
   mPwTM4mHXPGqeNS5TBGesmGWjAvLSR7KXHEUBaBr7UbSy22NlHm6UwI1a
   azfAqiukbPcfhsEnmqDdC+LWGcOCxmcRR1ALqJacwVQKeKLdpjSDN8DxQ
   Q==;
X-CSE-ConnectionGUID: EMpCwBz3Ssqhzk3id+g8NQ==
X-CSE-MsgGUID: Z2lHKD+gRSG+WU2V/cbPIA==
X-IronPort-AV: E=Sophos;i="6.18,249,1751266800"; 
   d="scan'208";a="277602015"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2025 13:07:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 8 Sep 2025 13:06:37 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 8 Sep 2025 13:06:37 -0700
From: <Ryan.Wanner@microchip.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>
CC: <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH] clk: at91: clk-master: Add check for divide by 3
Date: Mon, 8 Sep 2025 13:07:17 -0700
Message-ID: <20250908200725.75364-1-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Ryan Wanner <Ryan.Wanner@microchip.com>

A potential divider for the master clock is div/3. The register
configuration for div/3 is MASTER_PRES_MAX. The current bit shifting
method does not work for this case. Checking for MASTER_PRES_MAX will
ensure the correct decimal value is stored in the system.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
---
 drivers/clk/at91/clk-master.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/at91/clk-master.c b/drivers/clk/at91/clk-master.c
index 7a544e429d34..d5ea2069ec83 100644
--- a/drivers/clk/at91/clk-master.c
+++ b/drivers/clk/at91/clk-master.c
@@ -580,6 +580,9 @@ clk_sama7g5_master_recalc_rate(struct clk_hw *hw,
 {
 	struct clk_master *master = to_clk_master(hw);
 
+	if (master->div == MASTER_PRES_MAX)
+		return DIV_ROUND_CLOSEST_ULL(parent_rate, 3);
+
 	return DIV_ROUND_CLOSEST_ULL(parent_rate, (1 << master->div));
 }
 
-- 
2.43.0


