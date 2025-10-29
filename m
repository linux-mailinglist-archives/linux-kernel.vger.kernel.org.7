Return-Path: <linux-kernel+bounces-877029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C4AC1D03C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5891D1A23259
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53EC35A920;
	Wed, 29 Oct 2025 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUZmMkZ3"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D79A35A12A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761766157; cv=none; b=DlSQfGnQH/J2IAGjAmYHlWzcbe0afyHvlLhTIWa5i/xMBqF5bpHUR94I8o9CZWwYvqh76m3wYXDzuKI//jvVqoU6/Q75k8qrPCsBysZgvPDY6cyFC9WjAfQlV1rFE0dH9V+umUas89gMP+ADDavlxSLViU0xUi98mQfe8GKpYOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761766157; c=relaxed/simple;
	bh=TBS7ZMz/huddl9pLh96AmfhkHxVmvREzsHwTliKCOsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyYvs9PQ1MnCz18wQOGcjL5oEQS9DSKFkfuDROuKIPp+WzDsBH6+xOy6rR67xjhX1wmgH+8butOGv/okRsyHI8uBMR2T7ncT86QmMSTLNbTFCOsVc0wdgXN1fyFMl8RwVXwXzNElIkgAyEAYirOZdRw2Xn0aryS/TIFY4MgNYc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUZmMkZ3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b6d83bf1077so50548666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761766154; x=1762370954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drvlRfVB/NoPKWYb6A7Zkbz4VYcKiU0cQ5EAHKwC8TU=;
        b=JUZmMkZ39iMJbFiULSQsrQpuA8x9zkAGnJQcW2KlU7izme11Lj/4GlALEvMHVT2VrY
         ok7T/TTr54A3oUhqkhzMgQT0691ejORxMCYan7kETuXC7tJgfvNMatJ8ykzD4wUZIOm8
         lK5k12BgrNVu0LgqZQUlFEDD6K+14BFCzhq5oyVaQq5caJtohk8tPFw05yXsQIKk+tK8
         GGkAzo5NVrWkKOuO98+dBJFPP/TjE+JxF325Ua6Fm86wvpUr7VZBaXSnungHnZ2LrtFz
         NjTXDOQMaB1Lid87rEqY0/MpxUbAj5jS7c99SVeG3zcn1YV7XZWShR+v4TlFW7lcsyty
         K4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761766154; x=1762370954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drvlRfVB/NoPKWYb6A7Zkbz4VYcKiU0cQ5EAHKwC8TU=;
        b=VgCnZamJzSUAz4ZgiFh0Crqp+KDFLrir2s6M7E3m6ceJcPUuNkJJb438xySkpkz/ZD
         DU/ULX6r7ZdJzzPg2QiBR+lWinTobcF3CuLxwAYP4mxCld3vHzWqcIXAdPhRcMWS3/CT
         4tNu4l3+4RgsB5aFZ4K+hBD3oDgAG/nJQaJjG1ODjOY872zTh0yQqscUK4pNNXHTL/xg
         NwmHrnBDPDi12CWDZL74hLB3Xg5/STiugQZUFcYatYcdUbh/HMlswdzcvJtc91NZ4pnf
         frGqOWvzkoUYMMZoXEODED+YqlmNGJ22KWhn0NxfWlV6sUBdsMzNqGQICC3j0Fid3+FZ
         VKHA==
X-Forwarded-Encrypted: i=1; AJvYcCXhSfVhk3qqUHShmx2tP1VDHdumHX5AmIrnVjJA+CDRDbpdI2TGBfEnGvWp6zZieGDimJxU0LlHfjNc1Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK0f++ThfRODOmWZiDa0PmlXRxXiD7dbMdAYNg6Ir2/lk8o2yz
	NnrFsh1ZcV20/daUULl3MzlqoTXvOZgvd0PWRphUOf3xr7IxGvdIm4lL
X-Gm-Gg: ASbGncuhScRE+5/twLcMxDOMGSh5wAhmo3tf+nJK+4oRPBC4F4DobRb4jFM4uGqCL2m
	2wrEOaXPxDuZ035YgqdSODtpAB1QqYQ6Tky5LJizcex9kpXevLZqxDLJD1XsMNgtDAriYfOJKGZ
	9npho97voHzNGvc2kkwTxq4es6lj0PPH34tndqKNqj7aF4H4mLaQxJDFAIqDlWQ430b5neX1y5I
	O0gYJJmrqaeX7VVpWzLk9D+MEqzBfLjDCy9k723UxCwFn3ry9MSMEVxGBvm7Jn4qiSVou6NaDv8
	0lvnu/n3VSMUjvudglG1u1qcZsYvgr5Kg1K/2X1A1mWqc9s75LfOBiq9w/83XbFU1WPT4ZoK8qo
	FIKxySNoBPQG8107ROICPpq0RZITBzNCys6hlEsHPya9ofz0+JqRNBFTo0e818N0hlAT2toCywu
	Kpma4optL+2sq2QIlkMCT8NsehIXbnj8DxIZT/akov3Vz3gJQvCJhBl/K6Bcm98w==
X-Google-Smtp-Source: AGHT+IHVJORke3FbLcazCdqb6IzzPmDXwSbtp/S5D/AcSmwvYP+0vUHCAfCC9o5lV9yehDEJzSKsyQ==
X-Received: by 2002:a17:907:9342:b0:b4a:ac1e:7866 with SMTP id a640c23a62f3a-b703d52573cmr367554666b.45.1761766154134;
        Wed, 29 Oct 2025 12:29:14 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-146-98-100.cust.vodafonedsl.it. [93.146.98.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8548eda6sm1496673266b.75.2025.10.29.12.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 12:29:13 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 4/4] arm64: dts: freescale: imx93-var-som: Add support for ADS7846 touchscreen
Date: Wed, 29 Oct 2025 20:28:49 +0100
Message-ID: <20251029192852.656806-5-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029192852.656806-1-stefano.radaelli21@gmail.com>
References: <20251029192852.656806-1-stefano.radaelli21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VAR-SOM-MX93 integrates an ADS7846 resistive touchscreen controller.
The controller is physically located on the SOM, and its signals are
routed to the SOM pins, allowing carrier boards to make use of it.

This patch adds the ADS7846 node and the appropriate SPI controller.

Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
 .../boot/dts/freescale/imx93-var-som.dtsi     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
index d94b40d1d804..01adf7b5ac12 100644
--- a/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-var-som.dtsi
@@ -212,6 +212,38 @@ wm8904: audio-codec@1a {
 	};
 };
 
+&lpspi8 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi8>;
+	cs-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	/* Resistive touch controller */
+	ads7846: touchscreen@0 {
+		compatible = "ti,ads7846";
+		reg = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_restouch>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
+		spi-max-frequency = <1000000>;
+		pendown-gpio = <&gpio4 29 0>;
+		vcc-supply = <&buck5>;
+		ti,x-min = /bits/ 16 <125>;
+		ti,x-max = /bits/ 16 <4008>;
+		ti,y-min = /bits/ 16 <282>;
+		ti,y-max = /bits/ 16 <3864>;
+		ti,x-plate-ohms = /bits/ 16 <180>;
+		ti,pressure-max = /bits/ 16 <255>;
+		ti,debounce-max = /bits/ 16 <10>;
+		ti,debounce-tol = /bits/ 16 <3>;
+		ti,debounce-rep = /bits/ 16 <1>;
+		ti,settle-delay-usec = /bits/ 16 <150>;
+		ti,keep-vref-on;
+		wakeup-source;
+	};
+};
+
 /* BT module */
 &lpuart5 {
 	pinctrl-names = "default";
@@ -307,6 +339,15 @@ MX93_PAD_GPIO_IO29__GPIO2_IO29                  0x40000b9e
 		>;
 	};
 
+	pinctrl_lpspi8: lpspi8grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO12__GPIO2_IO12                  0x31e
+			MX93_PAD_GPIO_IO13__LPSPI8_SIN                  0x31e
+			MX93_PAD_GPIO_IO14__LPSPI8_SOUT                 0x31e
+			MX93_PAD_GPIO_IO15__LPSPI8_SCK                  0x31e
+		>;
+	};
+
 	pinctrl_lpuart5: lpuart5grp {
 		fsl,pins = <
 			MX93_PAD_DAP_TDO_TRACESWO__LPUART5_TX   0x31e
@@ -316,6 +357,12 @@ MX93_PAD_DAP_TCLK_SWCLK__LPUART5_CTS_B  0x31e
 		>;
 	};
 
+	pinctrl_restouch: restouchgrp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO4__GPIO4_IO29                  0x31e
+		>;
+	};
+
 	pinctrl_sai1: sai1grp {
 		fsl,pins = <
 			MX93_PAD_SAI1_TXC__SAI1_TX_BCLK                 0x31e
-- 
2.43.0


