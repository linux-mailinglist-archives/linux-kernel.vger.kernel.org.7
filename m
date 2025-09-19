Return-Path: <linux-kernel+bounces-825137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39332B8B17B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF75A065F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96D828751B;
	Fri, 19 Sep 2025 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="du/t96Rq"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1326B256C70;
	Fri, 19 Sep 2025 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758310496; cv=none; b=upkEq75dmt0y6e9CFCt9lObdoiDfavCqcZJ/jKHr/0K1yKFsC569LG4R57/Vuq834QGKBSlOmMe414CnSKCRf5LblF2dqGUkHlbJ6XUE+l1IojCq5TvYr11aaiCiK2+x5HaxoeAr7Bnc/RL4cAojfkaBrLIk09mDEUHR4aaJu2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758310496; c=relaxed/simple;
	bh=rRgtaSBogQ9OXl3HAtx2DncBhgZdCZT7YigyFbtUo5k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ojKiQNVdaxbs5P8RWUhVm6DhlA7U7MWCGoeGebXxZn9yicm3VHb6QROZotMhKk7UybsXRMBt0rsVazO8q367lT4zLeJLQp15vd5ny60/7eWE8rD1KLjZrzzS4urcgT8mkidchzEpTNAu+MUHz/U1QGO7CO3Xd4PtffpPtH2DxPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=du/t96Rq; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58JJYVnd309082;
	Fri, 19 Sep 2025 14:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758310471;
	bh=4e+vM8y65RFB7t9z0rUFFvypiNgEA9GqKV1KkIOAjaw=;
	h=From:To:CC:Subject:Date;
	b=du/t96Rqu8z/S9y/E8DMnrXo9Sdt/i5dE5RVObEXS3ejwua+k1Lq79523nhCeQO00
	 ZTmqtS+kG6lNgNqsEfrcU27dzoW1qNEIWWd8RWZqj+7JPVHmUBOs5eBKU/bCqM9cxS
	 ekflEfqY3L+UCV/UvrVkoudRIAEFrA47KMcRj04g=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58JJYVIE2559652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 19 Sep 2025 14:34:31 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 19
 Sep 2025 14:34:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 19 Sep 2025 14:34:31 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.144])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58JJYVKA3079903;
	Fri, 19 Sep 2025 14:34:31 -0500
From: <rs@ti.com>
To: <mwalle@kernel.org>, <afd@ti.com>, <conor+dt@kernel.org>,
        <frank.binns@imgtec.com>, <kristo@kernel.org>, <krzk+dt@kernel.org>,
        <matt.coster@imgtec.com>, <nm@ti.com>, <robh@kernel.org>,
        <vigneshr@ti.com>
CC: <devicetree@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <detheridge@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62p: Fix memory ranges for GPU
Date: Fri, 19 Sep 2025 14:33:42 -0500
Message-ID: <20250919193341.707660-2-rs@ti.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Randolph Sapp <rs@ti.com>

Update the memory region listed in the k3-am62p.dtsi for the BXS-4-64
GPU to match the Main Memory Map described in the TRM [1].

[1] https://www.ti.com/lit/ug/spruj83b/spruj83b.pdf

Fixes: 29075cc09f43 ("arm64: dts: ti: Introduce AM62P5 family of SoCs")
Signed-off-by: Randolph Sapp <rs@ti.com>
---

Requirement for the following series:
https://lore.kernel.org/all/20250915143440.2362812-1-mwalle@kernel.org/

 arch/arm64/boot/dts/ti/k3-am62p.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
index 75a15c368c11..dd24c40c7965 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p.dtsi
@@ -59,7 +59,7 @@ cbass_main: bus@f0000 {
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x01b28400>, /* First peripheral window */
 			 <0x00 0x08000000 0x00 0x08000000 0x00 0x00200000>, /* Main CPSW */
 			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01d20000>, /* Second peripheral window */
-			 <0x00 0x0fd00000 0x00 0x0fd00000 0x00 0x00020000>, /* GPU */
+			 <0x00 0x0fd80000 0x00 0x0fd80000 0x00 0x00080000>, /* GPU */
 			 <0x00 0x20000000 0x00 0x20000000 0x00 0x0a008000>, /* Third peripheral window */
 			 <0x00 0x30040000 0x00 0x30040000 0x00 0x00080000>, /* PRUSS-M */
 			 <0x00 0x30101000 0x00 0x30101000 0x00 0x00010100>, /* CSI window */
-- 
2.51.0


