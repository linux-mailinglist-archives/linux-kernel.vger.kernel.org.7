Return-Path: <linux-kernel+bounces-804773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE472B47CD9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7255A17A09C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E7129ACC6;
	Sun,  7 Sep 2025 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cER3PteX"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823E425D527;
	Sun,  7 Sep 2025 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757269724; cv=none; b=oAaLeYyRgNwqMHwPxtrbPoOGWhiydPrgVpXHbEvzCcGtT0sguIF9U7NtAKZSs6mpatARumgObzGcs5jY+J6jR87wPKDos6p5QPJ/dwA3af1Kr2raHW6j4cGpSI2Afhu6XOrIuj2texHAEC5kbGjmTmRnv2uE0xsmhaHgd/Ar7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757269724; c=relaxed/simple;
	bh=u7lAx7risE9wh0OsAVZ4k2AFRMSASbNKZw6qOah5sx4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGN2bF7fCHlsfEbh2SioyKwab33xWa7/7U/WDdF5ETAxlD0REydSedhnjR4BzrVO+UvZch7c8AeylofY3pdapV6aOJ+a3RECKA/ic/5Fni7z3vM+iOnnzwB4niGZuBKo8m25UcRiQK9wgMD6/tAzSnjTjzkGTwySLmiy7vaDViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cER3PteX; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 587ISJ9r3702481;
	Sun, 7 Sep 2025 13:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757269699;
	bh=ktGsUtmB88ADFILG3x8Ae9YK/YVKSqVzoM9tBkqdlWw=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=cER3PteXWvpV8UuHDOaxv8QvXxu8T3yvG24uZYFjcbZFIkijHuJUusPkTUK9KJYaY
	 vJv2Eg2tQ3Vk6bWzgrdPBDzNxZxgIx0idtzQwUejmflEZk402AVPLI+frdGrZAcAbq
	 AcjyylsgcyHQquR3Xk38fAFxdp2rlaqnzGTR4Ud0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 587ISJXq2429718
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Sun, 7 Sep 2025 13:28:19 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Sun, 7
 Sep 2025 13:28:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Sun, 7 Sep 2025 13:28:18 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 587IS7UR3565173;
	Sun, 7 Sep 2025 13:28:13 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <r-ravikumar@ti.com>,
        <m-chawdhry@ti.com>, <b-padhi@ti.com>, <u-kumar1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <tomi.valkeinen@ideasonboard.com>,
        <aradhya.bhatia@linux.dev>, <devarsht@ti.com>, <s-jain1@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-j721e-main: Update DSS EDP integration configuration register
Date: Sun, 7 Sep 2025 23:58:05 +0530
Message-ID: <20250907182806.1031544-2-h-shenoy@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250907182806.1031544-1-h-shenoy@ti.com>
References: <20250907182806.1031544-1-h-shenoy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Fix size of DSS_EDP0_INT_CFG_VP to 256B as stated in
TRM Table 2-1 MAIN Domain Memory Map.
Link: https://www.ti.com/lit/zip/spruil1/SPRUIL_DRA829_TDA4VM

Fixes: 92c996f4ceab ("arm64: dts: ti: k3-j721e-*: add DP & DP PHY")
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index ab3666ff4297..3fa7537d5414 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -1863,7 +1863,7 @@ mhdp: dp-bridge@a000000 {
 		 * the PHY driver.
 		 */
 		reg = <0x00 0x0a000000 0x00 0x030a00>, /* DSS_EDP0_V2A_CORE_VP_REGS_APB */
-		      <0x00 0x04f40000 0x00 0x20>;    /* DSS_EDP0_INTG_CFG_VP */
+		      <0x00 0x04f40000 0x00 0x100>;    /* DSS_EDP0_INTG_CFG_VP */
 		reg-names = "mhdptx", "j721e-intg";
 
 		clocks = <&k3_clks 151 36>;
-- 
2.34.1


