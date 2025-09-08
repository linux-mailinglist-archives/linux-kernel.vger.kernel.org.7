Return-Path: <linux-kernel+bounces-806078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76C9B491A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB04E162C27
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225EC30F53B;
	Mon,  8 Sep 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hnHWpCru"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B9A30F535;
	Mon,  8 Sep 2025 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341849; cv=none; b=kpSSXBO8/zrupwaXgOwh6nMpJSzG2qCdCDmuZ1wMTN3aMpdHVis19XZdvflEK6rntwNqHdaTa1fiOQn0HprjsfymU6misoYee4cSVmtUjnZGgCrkSSRMLZRL1kukItrS6fMLIMo/GTdtSAt4PS3UrKlBH2odDMM4vKCRVzBGpZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341849; c=relaxed/simple;
	bh=v37Fazm71dtNjfM2tRuMilBIRTqKO4qZhsLPOegwi2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKd2I0I4y54YnhjTO3Wi0SXNlvWhEIBADJiSGm9gF5eMMU8jcZAASpdGHcxOvfxzgFvSwCyfLIqhGEckvWzMDiFS51pPupnRZYyOfxii3H5QIxTCCSlZZFJEXGRgiDwtK/KKt4DoN3yyEQfGKWFiSPU4n0G95/TDDnstaegvbLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hnHWpCru; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588EUhc7071678;
	Mon, 8 Sep 2025 09:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757341843;
	bh=Zo14xNjz2r9AcMZBRCHyJE0PzkloRDSfzfKMBl+WDBg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hnHWpCrudUoYB99ijoB+UAS3NaWVv5XYOZqQasiEsl42XXa5rUONUMLHqV+YrXTqr
	 TjMtD07o5pnXSzU44wO7PifMZWExjoJncgD53jbXi5PP/vVucR2kWZu2CJgIStl71b
	 aER03IyFykKoSJ61Ds5qd+Tu9P0Js3ErYy9AXIbU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588EUhoU2466049
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 8 Sep 2025 09:30:43 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 09:30:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 09:30:42 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588ESecx1037553;
	Mon, 8 Sep 2025 09:30:38 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <d-gole@ti.com>, <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 21/34] Revert "arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout locations"
Date: Mon, 8 Sep 2025 19:58:13 +0530
Message-ID: <20250908142826.1828676-22-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908142826.1828676-1-b-padhi@ti.com>
References: <20250908142826.1828676-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This reverts commit 9f3814a7c06b7c7296cf8c1622078ad71820454b.

The C6x carveouts are reversed intentionally. This is due to the
requirement to keep the DMA memory region as non-cached, however the
minimum granular cache region for C6x is 16MB. So, C66x_0 marks the
entire C66x_1 16MB memory carveouts as non-cached, and uses the DMA
memory region of C66x_1 as its own, and vice-versa.

This was also called out in the original commit which introduced these
reversed carveouts:
	"The minimum granularity on the Cache settings on C66x DSP cores
	is 16MB, so the DMA memory regions are chosen such that they are
	in separate 16MB regions for each DSP, while reserving a total
	of 16 MB for each DSP and not changing the overall DSP
	remoteproc carveouts."

Fixes: 9f3814a7c06b ("arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout locations")
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
v4: Changelog:
1. Updated carveout node names to generic 'memory@addr'

Link to v3:
https://lore.kernel.org/all/20250905051846.1189612-21-b-padhi@ti.com/

v3: Changelog:
1. None

Link to v2:
https://lore.kernel.org/all/20250823160901.2177841-21-b-padhi@ti.com/

v2: Changelog:
1. Re-ordered patch from [PATCH 03/33] to [PATCH v2 20/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-4-b-padhi@ti.com/
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 0f05e65f7bf7..37bc33f2cc26 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -120,7 +120,8 @@ main_r5fss1_core1_memory_region: memory@a5100000 {
 			no-map;
 		};
 
-		c66_0_dma_memory_region: memory@a6000000 {
+		/* Carveout locations are flipped due to caching */
+		c66_1_dma_memory_region: memory@a6000000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0xa6000000 0x00 0x100000>;
 			no-map;
@@ -132,7 +133,8 @@ c66_0_memory_region: memory@a6100000 {
 			no-map;
 		};
 
-		c66_1_dma_memory_region: memory@a7000000 {
+		/* Carveout locations are flipped due to caching */
+		c66_0_dma_memory_region: memory@a7000000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0xa7000000 0x00 0x100000>;
 			no-map;
-- 
2.34.1


