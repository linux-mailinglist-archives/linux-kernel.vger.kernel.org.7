Return-Path: <linux-kernel+bounces-775245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A1B2BD19
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02CAE7BB9B6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E4031AF10;
	Tue, 19 Aug 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="OFB74465"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A531A071;
	Tue, 19 Aug 2025 09:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595139; cv=none; b=H/4HgPASZm+K/c9MnC6YjbUNmkCFW11TRSrwi+kuXj1KQu4dWPdd1Sj78e5JoHzfU5b4J47pEoh4tmeHy3Ktxv6ZiNyqXufYw+U9EzdkoY6IqXm+07f697Scw1L7mUmhuYDgBK/nd8Hea5KHYrwjDYc1aJS3hQUGS62RQiDVKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595139; c=relaxed/simple;
	bh=t6+ZLM0gvWSmTtAFy/th6kbMHKJpRX/QXS16XEK9HPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OQW1ocQKQjIaSaA2VyglMXoX2zp4TwIgOuyX9OssDptMqv07X9gxKwUsxBhscWN3O2YGEeD7vUuekqesGm5Ki5joAcfn1TTefJMiPTpUz24Wewrm578Lnl2safX8R1FD9JAcsj8w+vw1WP0VRiG0YqySQd7sWWmU8WAb6jAvQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=OFB74465; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J8BtZr032500;
	Tue, 19 Aug 2025 11:18:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	r+8zNdQhsELNVTCqoDyv7ptRsFjNWXK/YZ/09FrMas4=; b=OFB74465rD8x1IIM
	qYfYMczvzSqt5ATAiBzQT3j7mrMJVVkk/r6aOCzClSULAYKHr/Cu5GZVIEokILXX
	h+6qwDKi9qTeHB11NjlspQSK5KpIDziA3+4wzlussHt5Gv9O5ODDP33NVXiRwM+i
	6AMFjB+zCQt8JfG5YRJ6J4rOq1mR/SNq0oY9wVoVPZp1lbYS+O0LXChpnwjDrrru
	2YZnezprgTadeYCk3/VSGC2fcNHbvJzo+1DKyQ9e00oJITgyriSzGxe/sTqg4CaB
	0ThRuAZEb0s8Di08Nd496GPN9AoFhu+6wGMutbXEKyCzRsmUky0D5pfrdkw8B09+
	u1ijBQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48jhb1t8q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 11:18:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B19184005C;
	Tue, 19 Aug 2025 11:17:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F32FE71CDB4;
	Tue, 19 Aug 2025 11:16:04 +0200 (CEST)
Received: from localhost (10.130.74.180) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 19 Aug
 2025 11:16:04 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Tue, 19 Aug 2025 11:16:06 +0200
Subject: [PATCH v3 13/13] arm64: dts: st: add loopback clocks on LTDC node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250819-drm-misc-next-v3-13-04153978ebdb@foss.st.com>
References: <20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com>
In-Reply-To: <20250819-drm-misc-next-v3-0-04153978ebdb@foss.st.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01

ck_ker_ltdc has the CLK_SET_RATE_PARENT flag.  While having this flag is
semantically correct, it for now leads to an improper setting of the
clock rate.  The ck_ker_ltdc parent clock is the flexgen 27, which does
not support changing rates yet.  To overcome this issue, a fixed clock
can be used for the kernel clock.

Add the clocks needed for the LTDC to work.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 6 ++++++
 arch/arm64/boot/dts/st/stm32mp255.dtsi | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index 6d9c0a430a8cc82542029f18b8a1a954a7c4fddb..24823bbfee31f15e813573ad1a0c4f67a125ce51 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -52,6 +52,12 @@ clk_rcbsec: clk-rcbsec {
 			compatible = "fixed-clock";
 			clock-frequency = <64000000>;
 		};
+
+		clk_flexgen_27_fixed: clk-54000000 {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <54000000>;
+		};
 	};
 
 	firmware {
diff --git a/arch/arm64/boot/dts/st/stm32mp255.dtsi b/arch/arm64/boot/dts/st/stm32mp255.dtsi
index a3b5ae25d28c83ade12c2ff69b82c9cccfd29b00..07c200470b2cedde771ae987f2267d6097ea78f0 100644
--- a/arch/arm64/boot/dts/st/stm32mp255.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp255.dtsi
@@ -5,6 +5,11 @@
  */
 #include "stm32mp253.dtsi"
 
+&ltdc {
+	clocks = <&clk_flexgen_27_fixed>, <&rcc CK_BUS_LTDC>, <&syscfg>, <&lvds>;
+	clock-names = "lcd", "bus", "ref", "lvds";
+};
+
 &rifsc {
 	lvds: lvds@48060000 {
 		compatible = "st,stm32mp255-lvds", "st,stm32mp25-lvds";

-- 
2.25.1


