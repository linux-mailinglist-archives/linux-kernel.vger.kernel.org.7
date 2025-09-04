Return-Path: <linux-kernel+bounces-799946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 563F0B43183
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 732777AF162
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F5B230D0F;
	Thu,  4 Sep 2025 05:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EwMy7hb6"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6421C84B9;
	Thu,  4 Sep 2025 05:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756962614; cv=none; b=b7InfQXiONXrKHkNLT5WIJo+qI8FB6+PycewIo1x9QVRlRIyORZ3SWN+gCh75bzEtlE7PeaVW+Yqb2+DJaD6cAEpN513j5ZlXD5WhcbSQ5rp8J9jBjV5WvWmXkyUGpgr7jFfDOsPNGsuNG90TLQyuEPCUh5khYdTXJA+uIbQ+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756962614; c=relaxed/simple;
	bh=INwx13AqAfiN/OmTXiGiepnbnsp4tughoNEj7zAlXII=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QuaHUhdDHzjyzZsMwbVObqn3QeTu3QszKjIHfAM7RlNO9ILKophwp+nCN2zwFNLQYCekovcP4aY7YnaRZLCKtELyQK/IGLKxe65s+xXJNIIXBz+t5DDLGSTNHEOoCOiogSNNP4i7LGfHOdqbgURXwVZpdxfDw3NXKQ8KnCLI1cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EwMy7hb6; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58459kqr2998806;
	Thu, 4 Sep 2025 00:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756962586;
	bh=2ePqsIFvvYXVPKunzCWZj6k6JrCoCIdpXe0VE1H9j9g=;
	h=From:To:CC:Subject:Date;
	b=EwMy7hb6LPeas8NhOMzBlwbpr1jbEbdzD9Iaz5h3PyHSko/zNEkTsu/9HttRw0hlC
	 mzE7pgRYgyZK0XOn9IUbjZsYhbAM5eP9OCritrAPuaIeCVgAgaS5WczexQL3BaM8WM
	 amGfb4Lq6FvjmJ2qKM+larVywwVGr/RCf0w3xT8E=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58459k7n4067249
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 4 Sep 2025 00:09:46 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 4
 Sep 2025 00:09:45 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 4 Sep 2025 00:09:45 -0500
Received: from hkshenoy.dhcp.ti.com (hkshenoy.dhcp.ti.com [172.24.235.208])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58459eOw2720567;
	Thu, 4 Sep 2025 00:09:41 -0500
From: Harikrishna Shenoy <h-shenoy@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <r-ravikumar@ti.com>,
        <tomi.valkeinen@ti.com>, <a-bhatia1@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <aradhya.bhatia@linux.dev>,
        <u-kumar1@ti.com>, <devarsht@ti.com>, <s-jain1@ti.com>
CC: <h-shenoy@ti.com>
Subject: [PATCH RESEND] arm64: dts: ti: k3-j721e-main: Update DSS EDP integration configuration register
Date: Thu, 4 Sep 2025 10:39:40 +0530
Message-ID: <20250904050940.2913567-1-h-shenoy@ti.com>
X-Mailer: git-send-email 2.34.1
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


