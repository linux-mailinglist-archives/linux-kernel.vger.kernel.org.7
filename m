Return-Path: <linux-kernel+bounces-802682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE8EB45574
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53BA04E0218
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8213330FC0C;
	Fri,  5 Sep 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Zaby/7yi"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB830FC3A
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757069839; cv=none; b=q3dIM6DXLtyhK7zp+D4vFhFKknGCZ2Bt4GRFjn4W68NNpKzayWVsGhzRJKHBTvow8cqlFc0njL96+Iryt5YZf1v4CaLEJRhIY+H36CbUidOws9UI2My+o0eplDCbjVxND85AX+pmKsJxlhn6qtZBzel75G4SVUPcDa+UkQz6nOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757069839; c=relaxed/simple;
	bh=5edbOCQMtLRQq2l4Rm2FRKkM3DjktkJh4nczA1zq4ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=A3/LLDhux+ZdYJbOUNerkG9f813zFNCRjqYFamo15nGrJ+UyyA5g0c5k+R4h9HkXKEag0+u/PnqPCpForI1P+9XVs8g1w7GheY80l6OTPBI1Z3qdUUG3S+yCnt30E7B/N039YQnUOpjYZOId2m1xqcFKeaOfpuolxPRuLR3Nq2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Zaby/7yi; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250905105715epoutp02d4b6f7e4e66b9978444804b1842cb87e~iXbTaF9r52619326193epoutp02H
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:57:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250905105715epoutp02d4b6f7e4e66b9978444804b1842cb87e~iXbTaF9r52619326193epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757069836;
	bh=lGnEjjbaS1OmPNQ8V5HQyZUVH5+J/3jA4HeWoaYuixw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zaby/7yiaFcQrKx54lHPtwy2b1avPMjshfxTOgPuSP3xI77v9frni0pNLIsSsZ/1Z
	 RPKLKuFAb3jJ3WQ5GRFU2hlQmQ3rpFfxdNJ9fTrImlIR6g7fxDWF+qlddMua0iAFtw
	 76zqHRQLTMRwKcuT4nugaJZKl2q4S5U4bccy5GCE=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250905105715epcas5p3525197234eca0bff4fb9264d60431b2c~iXbTFLUet0553305533epcas5p33;
	Fri,  5 Sep 2025 10:57:15 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.89]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4cJCwV4gwGz6B9m9; Fri,  5 Sep
	2025 10:57:14 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250905105714epcas5p4bb26e232702a9dff37e87dfd07da3946~iXbRtr0H72481624816epcas5p4E;
	Fri,  5 Sep 2025 10:57:14 +0000 (GMT)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250905105712epsmtip2945c1e7aa059913f7664206cbb887168~iXbQHHdeh0831308313epsmtip2U;
	Fri,  5 Sep 2025 10:57:12 +0000 (GMT)
From: Devang Tailor <dev.tailor@samsung.com>
To: alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, alim.akhtar@samsung.com, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	henrik@grimler.se, faraz.ata@samsung.com
Cc: Devang Tailor <dev.tailor@samsung.com>
Subject: [PATCH v3 3/3] arm64: dts: exynosautov9: add RTC DT node
Date: Fri,  5 Sep 2025 16:35:54 +0530
Message-Id: <20250905110554.2212304-4-dev.tailor@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905110554.2212304-1-dev.tailor@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250905105714epcas5p4bb26e232702a9dff37e87dfd07da3946
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250905105714epcas5p4bb26e232702a9dff37e87dfd07da3946
References: <20250905110554.2212304-1-dev.tailor@samsung.com>
	<CGME20250905105714epcas5p4bb26e232702a9dff37e87dfd07da3946@epcas5p4.samsung.com>

Add DT node for on-chip RTC for ExynosAutov9

Signed-off-by: Devang Tailor <dev.tailor@samsung.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts |  4 ++++
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi     | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
index de2c1de51a76..5f5167571f7a 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
+++ b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
@@ -106,6 +106,10 @@ &pwm {
 	status = "okay";
 };
 
+&rtc {
+	status = "okay";
+};
+
 &serial_0 {
 	pinctrl-0 = <&uart0_bus_dual>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
index 66628cb32776..afa6b258153c 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
@@ -1633,6 +1633,16 @@ pwm: pwm@103f0000 {
 			clock-names = "timers";
 			status = "disabled";
 		};
+
+		rtc: rtc@10540000 {
+			compatible = "samsung,exynosautov9-rtc";
+			reg = <0x10540000 0x100>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&xtcxo>;
+			clock-names = "rtc";
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.34.1


