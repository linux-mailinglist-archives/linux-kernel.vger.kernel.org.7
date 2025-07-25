Return-Path: <linux-kernel+bounces-745568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F99B11BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 493B97BE4C8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C012E6120;
	Fri, 25 Jul 2025 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="P5/N2NqU"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E682E5B3E;
	Fri, 25 Jul 2025 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438052; cv=none; b=GVSEYhlYUqkyvaJ/rebY993Z5QDOASLKR+74ZrSW2hrPh79thPb/+461xNQQFf1+LFpKYck3G+L2jrjA5t5BWbDiUf1rAC6oCs5qouT+3iz6syTCV5jL5SfqodjJvwnUnsmhKSr/NXuibeDAmW+C1lknYzs1Hv7YPXXB21mCixs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438052; c=relaxed/simple;
	bh=1e+UAkMMoq6wxbeaZRiZiS3SdmIXecYKdN0+850Zq2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pS+rthULpY4j6bfM1TwFQjNMKD8zyzPZ4NIseVpzZ0JjpVEdedZc7PYEjELPmdwOJ01DLxZiEaHYsl01z3xvgkPuEBmxhwS96t8JM7wj2i5udVGPEv1b82GqSkBTpKYt3H6bQvpEAkupa3w+AYcPT6BDbvHjaTlAohumqibZPqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=P5/N2NqU; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P9cSdj007814;
	Fri, 25 Jul 2025 12:07:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	W1KDXoh5LDTtJ7+frb/wxVL20UcusznPewWOmjzvoSg=; b=P5/N2NqUWvzWCv3R
	stbsbjLB2ACbZ1qfozrK9ZLyn9RHBOLGCwhHSYMjHBuvL5opd13raNkM3QSrL05G
	6jRbwyqly2tT04FlXo9+FfzfHDq7gnUIJVIyVKdjsnTiS6pnt/asQ2Nm4et0BgyN
	po8qNUemwoodHakrbbMsLvcerUBGjY9jjJuF4/1L2SkfvZImDPOvVjuQkeQkRA4q
	bqZKmfmuv4tWwO25aa9sG9ywuafaj99kCYihwbzZFCjNvKR63SiH5djApWngti8A
	f+0P4hGtnM8ZOwriOP8zNK4J+g+PQEMU1st2hYY4CRSk7f+92xPnAbIPLLGiTdA0
	F/hZUA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 483w3m2hdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 12:07:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2A7F940060;
	Fri, 25 Jul 2025 12:05:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CD1607A19E6;
	Fri, 25 Jul 2025 12:04:37 +0200 (CEST)
Received: from localhost (10.252.19.90) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Jul
 2025 12:04:37 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Date: Fri, 25 Jul 2025 12:04:04 +0200
Subject: [PATCH 12/12] arm64: dts: st: add loopback clocks on LTDC node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250725-drm-misc-next-v1-12-a59848e62cf9@foss.st.com>
References: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
In-Reply-To: <20250725-drm-misc-next-v1-0-a59848e62cf9@foss.st.com>
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
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
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_02,2025-07-24_01,2025-03-28_01

ck_ker_ltdc has the CLK_SET_RATE_PARENT flag.  While having this flag is
semantically correct, it for now leads to an improper setting of the
clock rate.  The ck_ker_ltdc parent clock is the flexgen 27, which does
not support changing rates yet.  To overcome this issue, a fixed clock
can be used for the kernel clock.

Add the clocks needed for the LTDC to work.

Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 6 ++++++
 arch/arm64/boot/dts/st/stm32mp255.dtsi | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index c561df51a6001004e45fb53a56d5d42c310e6b61..54dd57e0a98eabbbcfe89459e6d63eb287f5ca04 100644
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
index a4d965f785fa42c4597494010855aec7e1b9fdd1..82c2fa67b6b91f67d51872ed098aea897fab0197 100644
--- a/arch/arm64/boot/dts/st/stm32mp255.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp255.dtsi
@@ -5,6 +5,11 @@
  */
 #include "stm32mp253.dtsi"
 
+&ltdc {
+	clocks = <&rcc CK_BUS_LTDC>, <&clk_flexgen_27_fixed>, <&syscfg>, <&lvds>;
+	clock-names = "bus", "lcd", "ref", "lvds";
+};
+
 &rifsc {
 	lvds: lvds@48060000 {
 		compatible = "st,stm32mp25-lvds";
@@ -34,4 +39,4 @@ venc: venc@480e0000 {
 		clocks = <&rcc CK_BUS_VENC>;
 		access-controllers = <&rifsc 90>;
 	};
-};
\ No newline at end of file
+};

-- 
2.25.1


