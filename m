Return-Path: <linux-kernel+bounces-717020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3C7AF8E3A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 11:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D839764627
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 09:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EE22F3C04;
	Fri,  4 Jul 2025 09:10:20 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665422ECD11;
	Fri,  4 Jul 2025 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620219; cv=none; b=FcPAJAv+CHP33YSQFsVcHEkBOYq7oZiviJO72vVh2ZAGsu+BDCu6J8xfN8DEaxiPA96tl1rbCMiFiROxBJXF4+hA/vxA2jQ5hN97hb1IX2oImI9YL0VtV+Pn49fx6KpZ4TzuxnT73Auv+mri8VZIC/t8pJO9pir7udZO1Y8NQ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620219; c=relaxed/simple;
	bh=d9lZVmd4XH7n0sjf9M69HUWeelAlzudTMhKAxFx+ugE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rsRuktfVIhgCi5KxFryv0cVGhFdPDoUZL1sX3gva/kP1Q9/0muzMlT7LLmCerzqYMcz22gWJavomdEfDo4IJqU1LwM6R3VoU3J3W1wsQYZHVwbwh7RjRILgTTW0ioEBD4xaj+EjCG5nUvGpBroU2TW31UOfxeyD1qgUFuKcZUhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: +Utn85pHRWuLYDxHkUNrkQ==
X-CSE-MsgGUID: cLA0TSjoQhOFDnOa1yf9Qg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Jul 2025 18:10:14 +0900
Received: from localhost.localdomain (unknown [10.226.92.122])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 08CBF401008A;
	Fri,  4 Jul 2025 18:10:11 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH] clk: renesas: r9a09g047: Fix typo
Date: Fri,  4 Jul 2025 10:10:06 +0100
Message-ID: <20250704091009.58821-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the typo et0_rxclk->et0_txclk for smux2_gbe0_txclk.

Fixes: 17dc02f7d293 ("clk: renesas: r9a09g047: Add clock and reset signals for the GBETH IPs")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a09g047-cpg.c
index a50961dd2ac6..26e2be7667eb 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -104,7 +104,7 @@ static const struct clk_div_table dtable_2_100[] = {
 
 /* Mux clock tables */
 static const char * const smux2_gbe0_rxclk[] = { ".plleth_gbe0", "et0_rxclk" };
-static const char * const smux2_gbe0_txclk[] = { ".plleth_gbe0", "et0_rxclk" };
+static const char * const smux2_gbe0_txclk[] = { ".plleth_gbe0", "et0_txclk" };
 static const char * const smux2_gbe1_rxclk[] = { ".plleth_gbe1", "et1_rxclk" };
 static const char * const smux2_gbe1_txclk[] = { ".plleth_gbe1", "et1_txclk" };
 static const char * const smux2_xspi_clk0[] = { ".pllcm33_div3", ".pllcm33_div4" };
-- 
2.43.0


