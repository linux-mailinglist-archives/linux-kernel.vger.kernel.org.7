Return-Path: <linux-kernel+bounces-769664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C94D7B271B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A6CA2037A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 22:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C1D283CB0;
	Thu, 14 Aug 2025 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FyDM8ek0"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DC828314A;
	Thu, 14 Aug 2025 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211170; cv=none; b=pZbqkphBh+CH3Zax19D7VLR8dfTsPf46sp/gDN8m2CPPiWm0wThq03Xy3pyRbtktS5g0jcGCyTy/7TyDd2KtAVssHi0tkkeqQP4k5j5ZFBy50NBG8xfDUrCzxbUxx+xihCG8XlE2yJd8xARQlDK9ZF5It5t9dPEnbEmr531LcTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211170; c=relaxed/simple;
	bh=52HUKjk/GO6AhjRiPFXK/Gg70bGSSfqbNfV7upwva5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxAAFgNIzeLE2CytSZ7ackk2Ort+yA0268Z5CnWmrv4mY6gAnOrbYQOjZhslm7HI9s7O21z7rZ5UyeFWaWv4zaXMrvRHI01MA15OpSuE8B5+zwbGRNaOMhzBiiy0PuUqjmVvBPsoERbyHT1h0Lm0kovdkZqkeyV5i6VHUDUNvC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FyDM8ek0; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57EMdOFC2027438;
	Thu, 14 Aug 2025 17:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755211164;
	bh=bniBPJk4StiAeVO6R3OJD92Bo3U3qAOLTgjCEzwYWcw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FyDM8ek01b7mbLZHz5POzKEAQkSwN0Zmt0QCBOOmV1ibmMYNX6LjCucDdxK75uZC3
	 t6a/3bp1AlcZZFE718f+SGgYFylyeEvaLiCV4cGPNIxhDON3msjTuYiWuQEOEBRq3R
	 CAAnWe8xwfhrOtpvUKEXbXQQOfe2+8S/H6qhFirM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57EMdOF22015563
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 17:39:24 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 17:39:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 17:39:23 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57EMcw4d096792;
	Thu, 14 Aug 2025 17:39:20 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <afd@ti.com>, <u-kumar1@ti.com>, <hnagalla@ti.com>, <jm@ti.com>,
        <b-padhi@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 04/33] Revert "arm64: dts: ti: k3-j721e-beagleboneai64: Fix reversed C6x carveout locations"
Date: Fri, 15 Aug 2025 04:08:10 +0530
Message-ID: <20250814223839.3256046-5-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814223839.3256046-1-b-padhi@ti.com>
References: <20250814223839.3256046-1-b-padhi@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

This reverts commit 1a314099b7559690fe23cdf3300dfff6e830ecb1.

The C6x carveouts are reversed intentionally. This is due to the
requirement to keep the DMA memory region as non-cached, however the
minimum granular cache region for C6x is 16MB. So, C66x_0 marks the
entire C66x_1 16MB memory carveouts as non-cached, and uses the DMA
memory region of C66x_1 as its own, and vice-versa.

This was also called out in the original commit which introduced these
reversed carveouts:
	"The minimum granularity on the Cache settings on C66x DSP
	cores is 16MB, so the DMA memory regions are chosen such that
	they are in separate 16MB regions for each DSP, while reserving
	a total of 16 MB for each DSP and not changing the overall DSP
        remoteproc carveouts."

Fixes: 1a314099b755 ("arm64: dts: ti: k3-j721e-beagleboneai64: Fix reversed C6x carveout locations")
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index fb899c99753e..6e7f321f3e8a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -123,7 +123,8 @@ main_r5fss1_core1_memory_region: r5f-memory@a5100000 {
 			no-map;
 		};
 
-		c66_0_dma_memory_region: c66-dma-memory@a6000000 {
+		/* Carveout locations are flipped due to caching */
+		c66_1_dma_memory_region: c66-dma-memory@a6000000 {
 			compatible = "shared-dma-pool";
 			reg = <0x00 0xa6000000 0x00 0x100000>;
 			no-map;
@@ -135,7 +136,8 @@ c66_0_memory_region: c66-memory@a6100000 {
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


