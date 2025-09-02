Return-Path: <linux-kernel+bounces-795557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB22B3F485
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C6297AEA66
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F7E2E284B;
	Tue,  2 Sep 2025 05:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="by4bClOc"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4081F32F751;
	Tue,  2 Sep 2025 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756791033; cv=none; b=urpjQP37Hfm6AEbKc1Bom5YVa8ZRqG7gOdKVKwtCjDXWck5qPwZYNot42PCmp7pit7LEGev5H7QYEL4MtkfZ0EWkZd63mRZPPfVAyamKClzzby2Q/GbXrmaH4L1CCPDXEHy23maSlKb+FscuJ3Te9jFUTZOIv/UgbC7b0K4b5FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756791033; c=relaxed/simple;
	bh=4gWufUOCoFrNwiZ+yhS1w9Ie/+lG1JLAiMZFWDyqX4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbh8f+XRV7YAdbUZKn6NVRGYirwrhHBNbqtUkQ6wx9Xgf3wBt+GvvsYIMvI64QqMeKEGWBfJQJJDqypK8uCRGpJRegCw1JRPw2RfLewspH2GzLf9ZEVLYFOowxU5lbr+k+ijXHGykFv6VnotEjssT3ZEy03bpEfvLVyvvifbjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=by4bClOc; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5825UMH72947801;
	Tue, 2 Sep 2025 00:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756791022;
	bh=H5nbL/l98g1pHtQE59r8sDNdSX1a0LDiNJsSpW5LKDM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=by4bClOcHqKF7OTI1ypaEDF6sQUs8masYTgf90nMt0qWyha7epBUDvQzGA85Jowwb
	 /P2lIQKJmZlzZjdGR3o0BXsOseWvpIidHksVria915zCBnY7n5Vr0Ntc3yRJbe8f05
	 NmLQk9Bta+ZR2Ov8lADT561MiLKKMEyh9rfZ7RhQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5825UMH72049180
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 2 Sep 2025 00:30:22 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 00:30:22 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 00:30:21 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.231.157])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5825UAWp3551148;
	Tue, 2 Sep 2025 00:30:18 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v2 2/4] arm64: dts: ti: k3-am62p5-sk: Add bootph-all tag to usb0_phy_ctrl node
Date: Tue, 2 Sep 2025 11:00:07 +0530
Message-ID: <20250902053009.1732607-3-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902053009.1732607-1-h-salunke@ti.com>
References: <20250902053009.1732607-1-h-salunke@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add bootph-all property to the USB0 PHY controller node to make it
available during all boot phases. This is required for USB DFU boot.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 899da7896563..57808e36dae0 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -607,6 +607,10 @@ usb0_hs_ep: endpoint {
 	};
 };
 
+&usb0_phy_ctrl {
+	bootph-all;
+};
+
 &usb1 {
 	dr_mode = "host";
 	pinctrl-names = "default";
-- 
2.34.1


