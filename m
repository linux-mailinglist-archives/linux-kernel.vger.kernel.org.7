Return-Path: <linux-kernel+bounces-730340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889F8B0435F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB52B168902
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6954B2641EE;
	Mon, 14 Jul 2025 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3BsqeoQ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D901E2609FD;
	Mon, 14 Jul 2025 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506090; cv=none; b=cFRTdNU5DkvRK3eM+XRLFvClx5F6yVIaJDXiyM8US4OVtcID1saniy1vjRbxT/GVdErXwZjHHPvcPDNImWRxMi67xcrAnFO7cRbfHp1fHB7s/lSb4NPZvfvZYWaws0Ft9MiogaP2GDp1j3PF0Lnbvt/g9P7jpfAypAznZQK/5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506090; c=relaxed/simple;
	bh=REUBT2XvKcDY3YC6MdDeukEJT67Rl4GIi5UkMsK2Ais=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AFNZ8C1+7MQ4VbcqDtQUlF9JPncvN9UXkir3EnvmLQa16MS6wlwmwqqZtcRvYhGKejDrBly0cAeXrP/z81S/O/9t3T9CB/EtGzw65W4VYLJqXNFx2V1mHHIDgScq91yCvLatY4pG5wi8Qmw58md7WoYutNPB9aOSs+4jUoKE6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3BsqeoQ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso1135954666b.0;
        Mon, 14 Jul 2025 08:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752506087; x=1753110887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwBMlHHy2zuqqOIt3wM/gII1DkI956IRm4le60WaIXc=;
        b=T3BsqeoQrcdxpT1N5KOkz3JXACLBK2IM0nw1feQEA1EWkhXi9bSzNZLZewoHSzmPzD
         zYqp6Fb9DA0JVLxM9ZX7yc46DnqItFm2N9HVYGY48dOhFhEvCJNfMLN6Wsq0FSxnHXm7
         qDuCkdh4iNhFjhThuif0extJ2aMkNC57vKQor90XV6KO1TQYK5baQavw18eTg2OrPYTI
         yuqDNgZe6JMbSqALkG8Vf9SwKo2HhC0Ji6OYJL9M8x7mZtyEgRHGf7qYh075RJtLDIBe
         Ej4+VYAnQUPzvH7zSpvNCk7mhMDJjQHTVJrkHSZCq5hTsn+ntL6WtoPiv7VFsA6jKeGt
         vRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506087; x=1753110887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwBMlHHy2zuqqOIt3wM/gII1DkI956IRm4le60WaIXc=;
        b=LHyIbI+DmqJhxhMBktOmjuoqwnicxNHoo6hkigRu+xPJKkp9SabJMfTayc+LaoQLW8
         3jfgeAJhM/sOwhBSXJppBKa0RtNMZkZUyYNmtzwUN9Q+hAUxjVUuy2KVV9KwXUn+8qT2
         r+AkyfPs+1eXBXNUQnySmwJgD5UaO3Xj2bC8rsw5OfFNlcaVuyr5u1rQMYz9SgSR4k0h
         MzcYozPCN1iyZS/Ovm+fGeYVMjvAE9WX1wAZbS/Rfr5bqPd2HwNAyobK9o7zE9l7+OmQ
         hKPqwmV3LvSqFelxsymS4BwDW7Vx1Hm68mjH76ImOPUNT8xMAMl/xylWGNRwgFIABIA9
         FYlg==
X-Forwarded-Encrypted: i=1; AJvYcCUnBmU1PoE2DpZQl2QJRHO40HYW9f/9AuODzirS5XMVsM9DN6gAgF7e0fB7CLu5b6JuA7xiHkpbBbuF@vger.kernel.org, AJvYcCUxBPcJWPK/gds1WFDum8i2YT2IfexpqShsqzE+FVpdGEX0iHyhpAZl4VuUV3eFv+X8ycx24cGXgPUkzTcg@vger.kernel.org
X-Gm-Message-State: AOJu0YxRGI78d3hIWTdHLI70KzFK15IVv5q8IdZ41ULmlQvnoneGGwny
	KeoJvHVnZoAJg+pJUw+L9zCog9CzW1VS2Klu8nZq2yVUcpZMrcTF5BEK
X-Gm-Gg: ASbGncs/YTO3Ljpv0NkHjDK4VDcErICviwT+9GZDSpM7U2/2OTuThkZrjt1kDk7jUoC
	eaYuQIfB3ImWE+g97gONuHI0vqLZwlKX3tDsgNHo5YMKP+PtxKKcm4O4DKUym+/OOmYZkQPUKDr
	urkdv1zeBABQ3KSg8mlw2HyihoEhq5pgeW1wjNHenBsqT7+9OtsqQ1LqOWTKb2JOt1to0/dQqD+
	Ae0mLkVHGT7W0tePsMjs6hXDWCjRYnS+c8r5rX9QkZMEBzxef6RjJ8oeIo3BGaUY30KeA63Ot5B
	mYmTaJ+vjteOa6Zmw62An7Dp61yuM8mCXYruKCK/CAleKsyKFAkKllRhs3dOVX1WhCgDy3v0PHz
	akoRn8nqvmsZY32apTBlBQZNpCNDr4a1MJjr3zywaPbMy+5kbGFBDerrLJYsrQl+VMsA=
X-Google-Smtp-Source: AGHT+IHIMKnTNpqJDxY3v0bo2WYrU4HSwD3uCw03bQshJpV99EtaA9dPr7btQW2fPifZaqFAm2Ao2A==
X-Received: by 2002:a17:907:9604:b0:ad8:942b:1d53 with SMTP id a640c23a62f3a-ae6e2540128mr1509141166b.27.1752506086795;
        Mon, 14 Jul 2025 08:14:46 -0700 (PDT)
Received: from playground.localdomain ([92.120.5.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7eec2b1sm847701266b.68.2025.07.14.08.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:14:46 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] arm64: dts: imx: add dts for the imx8ulp evk9 board
Date: Mon, 14 Jul 2025 11:13:46 -0400
Message-Id: <20250714151346.7575-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250714151346.7575-1-laurentiumihalcea111@gmail.com>
References: <20250714151346.7575-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add DTS for the i.MX8ULP EVK9 board. Some notable differences from the
i.MX8ULP EVK board include:

	1) M.2 header uses SAI6 instead of SAI5.
	2) Ethernet transceiver chip (KSZ8081RNB) uses different pads.
	3) USB0 ID/OC signals are tied to different pads.
	4) USB1 ID/OC signals are tied to different pads.
	5) EVK9 board integrates the 9.4x9.4mm SoC package, while
	the EVK board integrates the 15x15mm package.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../boot/dts/freescale/imx8ulp-9x9-evk.dts    | 69 +++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8ulp-9x9-evk.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 23535ed47631..cbcabdfb324c 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -332,6 +332,7 @@ dtb-${CONFIG_ARCH_MXC} += imx8qxp-mek-ov5640-csi.dtb
 
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqp-mba8xx.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-tqma8xqps-mb-smarc-2.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8ulp-9x9-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx93-9x9-qsb.dtb
 
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-9x9-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-9x9-evk.dts
new file mode 100644
index 000000000000..5497e3d78136
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-9x9-evk.dts
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2025 NXP
+ */
+
+/dts-v1/;
+
+#include "imx8ulp-evk.dts"
+
+/ {
+	model = "NXP i.MX8ULP EVK9";
+	compatible = "fsl,imx8ulp-9x9-evk", "fsl,imx8ulp";
+};
+
+&btcpu {
+	sound-dai = <&sai6>;
+};
+
+&iomuxc1 {
+	pinctrl_sai6: sai6grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTE10__I2S6_TX_BCLK  0x43
+			MX8ULP_PAD_PTE11__I2S6_TX_FS    0x43
+			MX8ULP_PAD_PTE14__I2S6_TXD2     0x43
+			MX8ULP_PAD_PTE6__I2S6_RXD0      0x43
+		>;
+	};
+};
+
+&pinctrl_enet {
+	fsl,pins = <
+		MX8ULP_PAD_PTF9__ENET0_MDC		0x43
+		MX8ULP_PAD_PTF8__ENET0_MDIO             0x43
+		MX8ULP_PAD_PTF5__ENET0_RXER             0x43
+		MX8ULP_PAD_PTF6__ENET0_CRS_DV           0x43
+		MX8ULP_PAD_PTF1__ENET0_RXD0             0x43
+		MX8ULP_PAD_PTF0__ENET0_RXD1             0x43
+		MX8ULP_PAD_PTF4__ENET0_TXEN             0x43
+		MX8ULP_PAD_PTF3__ENET0_TXD0             0x43
+		MX8ULP_PAD_PTF2__ENET0_TXD1             0x43
+		MX8ULP_PAD_PTF7__ENET0_REFCLK           0x43
+		MX8ULP_PAD_PTF10__ENET0_1588_CLKIN      0x43
+	>;
+};
+
+&pinctrl_usb1 {
+	fsl,pins = <
+		MX8ULP_PAD_PTE16__USB0_ID		0x10003
+		MX8ULP_PAD_PTE18__USB0_OC		0x10003
+	>;
+};
+
+&pinctrl_usb2 {
+	fsl,pins = <
+		MX8ULP_PAD_PTD23__USB1_ID		0x10003
+		MX8ULP_PAD_PTE20__USB1_OC		0x10003
+	>;
+};
+
+&sai6 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_sai6>;
+	pinctrl-1 = <&pinctrl_sai6>;
+	assigned-clocks = <&cgc1 IMX8ULP_CLK_SPLL3_PFD1_DIV1>, <&cgc2 IMX8ULP_CLK_SAI6_SEL>;
+	assigned-clock-parents = <0>, <&cgc1 IMX8ULP_CLK_SPLL3_PFD1_DIV1>;
+	assigned-clock-rates = <12288000>;
+	fsl,dataline = <1 0x01 0x04>;
+	status = "okay";
+};
-- 
2.34.1


