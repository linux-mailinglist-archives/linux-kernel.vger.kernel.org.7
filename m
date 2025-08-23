Return-Path: <linux-kernel+bounces-783206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8667B32ABC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379215E046F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3762ECD28;
	Sat, 23 Aug 2025 16:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AmW3KP9S"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E312F2EC57B;
	Sat, 23 Aug 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965461; cv=none; b=J/IlpA3V3xvA4Mr5PzC+fF3Czi5uUWWt5fbbusI7yCmALGoqZn4G4VVYH6zMblcApAaZEilhZ6PkWPNJ4LvOpZlN2Iel/6fJm0CoNHsPNxPay8Fpp6MJDiqjGM2rQg9q7MCn7n5gG5S3e9j8yTFWFRSzS6gTzxBdwK5oBXUYu4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965461; c=relaxed/simple;
	bh=yYvQawtfdV6hKcmgRCWo8Xer37MqgjbTYuH1QLR0xBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mv2U6Ttj1IxYE46pbOPdvbm3PT0qM2ZEH3/W5T5Wa0yBBUEhj2FqWjfhuSdj0paVyQvopV+ONXy6KvNv/9uW3Oa1FuvZQ+F26Ck7WeobIiczMRp2eFrx06NeL2omYtu8ogaINcycIwPu200/uK2AKE2A3STvaZjls2hq6XIof+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AmW3KP9S; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57NGAsAD944482;
	Sat, 23 Aug 2025 11:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755965454;
	bh=meB4SXxOaExG0FE0I2lm4S0UkhTM91G25ea19AS5BeA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=AmW3KP9SRmdvGsnAD6ZYHNDfDvxDwhYN4rNefM5hpjjG2HUPSZcLpDH2fjzxEg+OU
	 AcLpqCAteHi/bukV6c3iJg8TKeD6TsZIQZX/gZucPscL0+EcmjW323Oh9pzin47Ulg
	 k35an4uI0yYRrDb823HMoHE3nTsNNCPM+95MtQ9I=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57NGAsFH239759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sat, 23 Aug 2025 11:10:54 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sat, 23
 Aug 2025 11:10:53 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sat, 23 Aug 2025 11:10:54 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57NG9Exa1274978;
	Sat, 23 Aug 2025 11:10:50 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 20/33] Revert "arm64: dts: ti: k3-j721e-sk: Fix reversed C6x carveout locations"
Date: Sat, 23 Aug 2025 21:38:48 +0530
Message-ID: <20250823160901.2177841-21-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823160901.2177841-1-b-padhi@ti.com>
References: <20250823160901.2177841-1-b-padhi@ti.com>
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
v2: Changelog:
1. Re-ordered patch from [PATCH 03/33] to [PATCH v2 20/33].

Link to v1:
https://lore.kernel.org/all/20250814223839.3256046-4-b-padhi@ti.com/

 arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 62b9c13a91e7..5d60aa9bc42b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -120,7 +120,8 @@ main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
 			no-map;
 		};
 
-		c66_0_dma_memory_region: c66-dma-memory@a6000000 {
+		/* Carveout locations are flipped due to caching */
+		c66_1_dma_memory_region: c66-dma-memory@a6000000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0xa6000000 0x00 0x100000>;
 			no-map;
@@ -132,7 +133,8 @@ c66_0_memory_region: c66-memory@a6100000 {
 			no-map;
 		};
 
-		c66_1_dma_memory_region: c66-dma-memory@a7000000 {
+		/* Carveout locations are flipped due to caching */
+		c66_0_dma_memory_region: c66-dma-memory@a7000000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0xa7000000 0x00 0x100000>;
 			no-map;
-- 
2.34.1


