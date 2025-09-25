Return-Path: <linux-kernel+bounces-831833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274F2B9DA92
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4F63AC409
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD3E2EBB8B;
	Thu, 25 Sep 2025 06:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MzVvYRPx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696602EBB88
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782015; cv=none; b=V99uudPpJDlrZQUVcQIemML+2xRH6M7iei4chXfrCCAOQIu5XO4Ch2oRHQqoWQLDgRPSJAHkOMAlFDdDOh9FoXQ07cmQmaasHGQyMNZIkkMeCRBxORnoqoXN5UM+NS7TVwgsY6LraFabpH8HxjOSkvja/zEynXuQ2HpyDIGq8/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782015; c=relaxed/simple;
	bh=y1KAlkTOCBgntJgwsl/EQn2CIotqxTtOa6IhzSVU1WE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jiSUVJ8Npblu3SXLGdlP1s0vH5kM3TbMrvdd0VTH42IF1rCMx7lmJ8wmihSM7hPRCE6Wp4H8gJ2HstETe3ORsY7IzqGfIIdj/fSLUwIyA6/+tGUOHYWeNSUTzPjLLtfLdTNDmk6zPkosZNNKIebTTp5iI92cPcqmjWPJXmam00c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MzVvYRPx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1J9So029706
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bh6wCkg1yAQg9QN4up5i38Q+ntJf5pCotwhugAYTJek=; b=MzVvYRPxYd5K78Jo
	JFDl4p20uLrmFuIa/apHoSpcJ5cq8fG72S46qgHqMSDuOuNk8vSvhVE06euUVCG4
	WVdFrSvi7/DVxoQyP/GtEK0D/Q86Ae60xLQdaZz/uR3tnxfZIQmdQ/a9ZTYOTE2B
	MO76sGKjlYeH1561AfTjlPL1PBk/wyIP2ZkRwd3IWpN+U3RXGzAQYAHGMhR8uu+O
	MMYbPlkI1b6YfKSpYD2xHBtKx4YhKTVpMkmKDLtjui0ZSzZzbc01dcjVjRD9TDnF
	HE8eqgI/69aTpxf6j7gTuDD7QgM5fMUX49XT9laSe6EPFaDXNDVmZ15nPaEDWal9
	mWfxkg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fpwst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b55251a4309so496442a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782010; x=1759386810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bh6wCkg1yAQg9QN4up5i38Q+ntJf5pCotwhugAYTJek=;
        b=HwNAVhpW9K+4d/9kJlQCJb47Wg0nRRId8biPCL9Da+B6aWAv/lkmSmywHhcEEACgRY
         X2l14v7guiWSPm2ikJK2mZ6LSTwbM49u2Sso4QSdfwX9TgnqDaZIE7UiP+fzlmU/ZBAe
         nauHEx8Aw+LFPEPBEBp7Sgo6JBClQAfq8YXTZeh0VozmNeXwU0fqMO+DEKQNIgZDNqw2
         0pbUYo/Fv6RUKaBudajl2Iu3C3mI4yDc+PQ7Sfub90xILRC1wvtGfiF/ANIXLSAlxcVu
         sQRvdemjs6mpKhjCBNkSLrJs4MLlIb8jAl5N+BwMbNUzizzjNDYCFBVplTFnG+Gi5s+D
         yaOg==
X-Forwarded-Encrypted: i=1; AJvYcCXhIHhgBPQWjSEkGKPlJ53bbG9jOcvWhSq64XY1XNoopq69G6KqR2XE8Q+3XNY4IaddcptTbm9sOMyjyKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rRFc0FO0TRySFgT/l2Ccz66s7iXwPiqXdqMcADV2ClPX1KQL
	DwD1djkR3IIR0Yb1PPtW7sVh24PtNWh4cdqPCxpA6hYOYRCIjbXyRbDUVh+W3U4Tpp1FGupMnH0
	9WgJxPPOu9K2jRAQD37viKSGJpf42qGnghA0tstVdlAUfFY6/lW39Lk16y7c4KrFeYlbtyAzqgz
	s=
X-Gm-Gg: ASbGncvk+ean2zwbWB36yRO4GuyY0sARd71F4PbfZzmOMFWf534w41Eu2wIB7mKKQxX
	LAfSzaArnEr1ioWMMCrVtfE4PzeAZJltMz2leO3EXCVd9AhzTA9NcJ+KOtnSeV/u2CgBd8UAHGv
	jVXtMO9JsTDhJeDC9TxvtKes0XaFRo65dEFLBg14J1qwT5Dzqdljt08eXEyxVIyPkU/vQe17KW2
	qlrZsju3S/4gf4CMq86KrjwNmMSX6DJu3vWPSivc3nlrIL7ieYJ7By+AhkSTvZvwAMj1RONMgg7
	gmd1mCmUT7s5sv0TnoZ1xcxDeACWLTNU+lxz3MD+olAQOEUi8ccnJ5ufZT2MYhSgl4k3CkhoH6C
	D2RujQg84JHw3WNtOslAUbNnAoVoRd7blwum4gaq4FSp5mn4rDohPlldaVsDn
X-Received: by 2002:a17:903:2310:b0:267:c172:9734 with SMTP id d9443c01a7336-27ed49b30e7mr27278555ad.7.1758782010072;
        Wed, 24 Sep 2025 23:33:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGafmDI/RK7TPqk/s34cquzaFF/4kuG7htVKUPjQbXl/udAmF4M+wsvklP+/IiRBOMmeERaEQ==
X-Received: by 2002:a17:903:2310:b0:267:c172:9734 with SMTP id d9443c01a7336-27ed49b30e7mr27278265ad.7.1758782009349;
        Wed, 24 Sep 2025 23:33:29 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:33:28 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:11 +0530
Subject: [PATCH 03/24] arm64: dts: qcom: Introduce Glymur base dtsi and CRD
 dts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-3-24b601bbecc0@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: YcbQ7APfKtNdatvbVIugJlJFg2P00ymb
X-Proofpoint-GUID: YcbQ7APfKtNdatvbVIugJlJFg2P00ymb
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d4e23b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=u8QSHVIs7zAJj7ClaysA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX176i0bXJoGZ1
 KG2QotjQGX1/0i2ydiV/SgslIuOWiZZwjMs6ABd+aYF37o3ieTB1zWZl/CnDOOMBgQwdUhCsldv
 41uHk+uxtNdD6FKO/gxvhrF57KsrPUkviIq0CDgv2NKKkRMqgd1oKlO4qd4soNPATP4vbC0Myfo
 GQxHQM06YPChYYwRoEJa3jKvQ70AQHzyM4VsGtbwQcJRCYMupXpeoDbOY+C3G4y+tb5VP0oNKeb
 fdND99KY1XedfqN/B9zuDGn49IiLvGmiNrgNCGyYFgY5msQpFkz6Gpa7HMVlKW6sI8DT3SRIAxh
 iGc5bdH/N0chNQFwwVb9HU5517ZGpC0tmOKHgS2pu53ZfpTmqn9k9dvH9kwsnXSsG0IDoOKEr92
 +eAQxGqt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

Introduce initial device tree support for Glymur - Qualcomm's
next-generation compute SoC and it's associated Compute Reference
Device (CRD) platform.

The dt describes CPUs, CPU map, GCC and RPMHCC clock controllers,
geni UART, interrupt controller, TLMM, reserved memory,
interconnects, SMMU, firmware scm, watchdog, apps rsc, RPMHPD,
SRAM, PSCI and pmu nodes.

Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile       |    1 +
 arch/arm64/boot/dts/qcom/glymur-crd.dts |   25 +
 arch/arm64/boot/dts/qcom/glymur.dtsi    | 1320 +++++++++++++++++++++++++++++++
 3 files changed, 1346 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 296688f7cb26550f75bce65826f234bc24110356..15f31a7d3ac4a60224c43cfa52e9cc17dc28c49f 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= glymur-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= hamoa-iot-evk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-tplink-archer-ax55-v1.dtb
diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
new file mode 100644
index 0000000000000000000000000000000000000000..a1714ec8492961b211ec761f16b39245007533b8
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/dts-v1/;
+
+#include "glymur.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. Glymur CRD";
+	compatible = "qcom,glymur-crd", "qcom,glymur";
+
+	aliases {
+		serial0 = &uart21;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <4 4>, <10 2>, <44 4>; /*Security SPI (TPM)*/
+};
diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..f1c5a0cb483670e9f8044e250950693b4a015479
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -0,0 +1,1320 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dt-bindings/clock/qcom,glymur-gcc.h>
+#include <dt-bindings/clock/qcom,glymur-tcsr.h>
+#include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/phy/phy-qcom-qmp.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,rpmh-rsc.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	interrupt-parent = <&intc>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	chosen { };
+
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			clock-frequency = <38400000>;
+			#clock-cells = <0>;
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32000>;
+			#clock-cells = <0>;
+		};
+	};
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu0@0 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+
+			l2_0: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+			};
+		};
+
+		cpu1: cpu1@100 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+		};
+
+		cpu2: cpu2@200 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x200>;
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+		};
+
+		cpu3: cpu3@300 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x300>;
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+		};
+
+		cpu4: cpu4@400 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x400>;
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+		};
+
+		cpu5: cpu5@500 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x500>;
+			enable-method = "psci";
+			next-level-cache = <&l2_0>;
+		};
+
+		cpu6: cpu6@10000 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x10000>;
+			enable-method = "psci";
+			next-level-cache = <&l2_1>;
+
+			l2_1: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+			};
+		};
+
+		cpu7: cpu7@10100 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x10100>;
+			enable-method = "psci";
+			next-level-cache = <&l2_1>;
+		};
+
+		cpu8: cpu8@10200 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x10200>;
+			enable-method = "psci";
+			next-level-cache = <&l2_1>;
+		};
+
+		cpu9: cpu9@10300 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x10300>;
+			enable-method = "psci";
+			next-level-cache = <&l2_1>;
+		};
+
+		cpu10: cpu10@10400 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x10400>;
+			enable-method = "psci";
+			next-level-cache = <&l2_1>;
+		};
+
+		cpu11: cpu11@10500 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x10500>;
+			enable-method = "psci";
+			next-level-cache = <&l2_1>;
+		};
+
+		cpu12: cpu12@20000 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x20000>;
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+
+			l2_2: l2-cache {
+				compatible = "cache";
+				cache-level = <2>;
+				cache-unified;
+			};
+		};
+
+		cpu13: cpu13@20100 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x20100>;
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+		};
+
+		cpu14: cpu14@20200 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x20200>;
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+		};
+
+		cpu15: cpu15@20300 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x20300>;
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+		};
+
+		cpu16: cpu16@20400 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x20400>;
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+		};
+
+		cpu17: cpu17@20500 {
+			device_type = "cpu";
+			compatible = "qcom,oryon";
+			reg = <0x0 0x20500>;
+			enable-method = "psci";
+			next-level-cache = <&l2_2>;
+		};
+	};
+
+	cpu-map {
+		cluster0 {
+			core0 {
+				cpu = <&cpu0>;
+			};
+			core1 {
+				cpu = <&cpu1>;
+			};
+			core2 {
+				cpu = <&cpu2>;
+			};
+			core3 {
+				cpu = <&cpu3>;
+			};
+			core4 {
+				cpu = <&cpu4>;
+			};
+			core5 {
+				cpu = <&cpu5>;
+			};
+		};
+
+		cluster1 {
+			core0 {
+				cpu = <&cpu6>;
+			};
+			core1 {
+				cpu = <&cpu7>;
+			};
+			core2 {
+				cpu = <&cpu8>;
+			};
+			core3 {
+				cpu = <&cpu9>;
+			};
+			core4 {
+				cpu = <&cpu10>;
+			};
+			core5 {
+				cpu = <&cpu11>;
+			};
+		};
+
+		cluster2 {
+			core0 {
+				cpu = <&cpu12>;
+			};
+			core1 {
+				cpu = <&cpu13>;
+			};
+			core2 {
+				cpu = <&cpu14>;
+			};
+			core3 {
+				cpu = <&cpu15>;
+			};
+			core4 {
+				cpu = <&cpu16>;
+			};
+			core5 {
+				cpu = <&cpu17>;
+			};
+		};
+	};
+
+	firmware {
+		scm: scm {
+			compatible = "qcom,scm-glymur", "qcom,scm";
+			qcom,dload-mode = <&tcsr 0x3000>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		llcc_lpi_mem: llcc-lpi-region@80000000 {
+			reg = <0x0 0x80000000 0x0 0x600000>;
+			no-map;
+		};
+
+		llcc_lpi_reserved_mem: llcc-lpi-reserved-region@80900000 {
+			reg = <0x0 0x80900000 0x0 0x500000>;
+			no-map;
+		};
+
+		cpucp_log_mem: cpucp-log-region@80e00000 {
+			reg = <0x0 0x80e00000 0x0 0x40000>;
+			no-map;
+		};
+
+		cpucp_fw_mem: cpucp-fw-region@80e40000 {
+			reg = <0x0 0x80e40000 0x0 0x5c0000>;
+			no-map;
+		};
+
+		pdp_mem: pdp-region@81400000 {
+			reg = <0x0 0x81400000 0x0 0x100000>;
+			no-map;
+		};
+
+		tags_mem: tags-region@81500000 {
+			reg = <0x0 0x81500000 0x0 0x360000>;
+			no-map;
+		};
+
+		xbl_dtlog_mem: xbl-dtlog-region@81a00000 {
+			reg = <0x0 0x81a00000 0x0 0x40000>;
+			no-map;
+		};
+
+		xbl_ramdump_mem: xbl-ramdump-region@81a40000 {
+			reg = <0x0 0x81a40000 0x0 0x1c0000>;
+			no-map;
+		};
+
+		aop_image_mem: aop-image-region@81c00000 {
+			reg = <0x0 0x81c00000 0x0 0x60000>;
+			no-map;
+		};
+
+		aop_cmd_db_mem: aop-cmd-db-region@81c60000 {
+			compatible = "qcom,cmd-db";
+			reg = <0x0 0x81c60000 0x0 0x20000>;
+			no-map;
+		};
+
+		aop_config_mem: aop-config-region@81c80000 {
+			reg = <0x0 0x81c80000 0x0 0x20000>;
+			no-map;
+		};
+
+		tme_crash_dump_mem: tme-crash-dump-region@81ca0000 {
+			reg = <0x0 0x81ca0000 0x0 0x40000>;
+			no-map;
+		};
+
+		tme_log_mem: tme-log-region@81ce0000 {
+			reg = <0x0 0x81ce0000 0x0 0x10000>;
+			no-map;
+		};
+
+		gpu_prr_mem: gpu-prr-region@81d00000 {
+			reg = <0x0 0x81d00000 0x0 0x10000>;
+			no-map;
+		};
+
+		tpm_control_mem: tpm-control-region@81d10000 {
+			reg = <0x0 0x81d10000 0x0 0x10000>;
+			no-map;
+		};
+
+		usb_ucsi_shared_mem: usb-ucsi-shared-region@81d20000 {
+			reg = <0x0 0x81d20000 0x0 0x10000>;
+			no-map;
+		};
+
+		pld_pep_mem: pld-pep-region@81d30000 {
+			reg = <0x0 0x81d30000 0x0 0x10000>;
+			no-map;
+		};
+
+		pld_gmu_mem: pld-gmu-region@81d40000 {
+			reg = <0x0 0x81d40000 0x0 0x10000>;
+			no-map;
+		};
+
+		pld_pdp_mem: pld-pdp-region@81d50000 {
+			reg = <0x0 0x81d50000 0x0 0x10000>;
+			no-map;
+		};
+
+		secdata_apss_mem: secdata-apss-region@81d60000 {
+			reg = <0x0 0x81d60000 0x0 0x10000>;
+			no-map;
+		};
+
+		qcskext_mem: qcskext-region@81d70000 {
+			reg = <0x0 0x81d70000 0x0 0x20000>;
+			no-map;
+		};
+
+		qup_fw_mem: qup-fw-region@81d90000 {
+			reg = <0x0 0x81d90000 0x0 0x18000>;
+			no-map;
+		};
+
+		softsku_mem: softsku-region@81da8000 {
+			reg = <0x0 0x81da8000 0x0 0x9000>;
+			no-map;
+		};
+
+		pdp_ns_shared_mem: pdp-ns-shared-region@81e00000 {
+			reg = <0x0 0x81e00000 0x0 0x200000>;
+			no-map;
+		};
+
+		acpi_ta_smem_mem: acpi-ta-smem-region@82000000 {
+			reg = <0x0 0x82000000 0x0 0x200000>;
+			no-map;
+		};
+
+		soccp_sdi_mem: soccp-sdi-region@823a0000 {
+			reg = <0x0 0x823a0000 0x0 0x40000>;
+			no-map;
+		};
+
+		lpm_violatordata_smem_mem: lpm-violatordata-smem-region@823e0000 {
+			reg = <0x0 0x823e0000 0x0 0x100000>;
+			no-map;
+		};
+
+		tz_stat_mem: tz-stat-region@82700000 {
+			reg = <0x0 0x82700000 0x0 0x100000>;
+			no-map;
+		};
+
+		no_reclaim_xbl_scratch_buffer2_mem: no-reclaim-xbl-scratch-buffer2-region@82800000 {
+			reg = <0x0 0x82800000 0x0 0x1c0000>;
+			no-map;
+		};
+
+		reclaimable_xbl_scratch_buffer_mem: reclaimable-xbl-scratch-buffer-region@829c0000 {
+			reg = <0x0 0x829c0000 0x0 0x1540000>;
+			no-map;
+		};
+
+		no_reclaim_xbl_scratch_buffer1_mem: no-reclaim-xbl-scratch-buffer1-region@83f00000 {
+			reg = <0x0 0x83f00000 0x0 0x100000>;
+			no-map;
+		};
+
+		ncc_mem: ncc-region@84000000 {
+			reg = <0x0 0x84000000 0x0 0x400000>;
+			no-map;
+		};
+
+		spu_secure_shared_memory_mem: spu-secure-shared-memory-region@84900000 {
+			reg = <0x0 0x84900000 0x0 0x100000>;
+			no-map;
+		};
+
+		adsp_rpc_remote_heap_mem: adsp-rpc-remote-heap-region@84a00000 {
+			reg = <0x0 0x84a00000 0x0 0x900000>;
+			no-map;
+		};
+
+		smmu_pt_mem: smmu-pt-region@85370000 {
+			reg = <0x0 0x85370000 0x0 0xa20000>;
+			no-map;
+		};
+
+		oobdaretag_mem: oobdaretag-region@86e10000 {
+			reg = <0x0 0x86e10000 0x0 0x360000>;
+			no-map;
+		};
+
+		oob_secure_mem: oob-secure-region@87170000 {
+			reg = <0x0 0x87170000 0x0 0xbc0000>;
+			no-map;
+		};
+
+		oobdtbqc_mem: oobdtbqc-region@87d30000 {
+			reg = <0x0 0x87d30000 0x0 0x20000>;
+			no-map;
+		};
+
+		oobdtboem_mem: oobdtboem-region@87d50000 {
+			reg = <0x0 0x87d50000 0x0 0x20000>;
+			no-map;
+		};
+
+		oob_nonsecure_mem: oob-nonsecure-region@87e00000 {
+			reg = <0x0 0x87e00000 0x0 0xc00000>;
+			no-map;
+		};
+
+		spss_region_mem: spss-region-region@88a00000 {
+			reg = <0x0 0x88a00000 0x0 0x400000>;
+			no-map;
+		};
+
+		soccp_boot_mem: soccp-boot-region@88e00000 {
+			reg = <0x0 0x88e00000 0x0 0x400000>;
+			no-map;
+		};
+
+		soccp_boot_dtb_mem: soccp-boot-dtb-region@89200000 {
+			reg = <0x0 0x89200000 0x0 0x20000>;
+			no-map;
+		};
+
+		soccpdtb_mem: soccpdtb-region@892e0000 {
+			reg = <0x0 0x892e0000 0x0 0x20000>;
+			no-map;
+		};
+
+		soccp_mem: soccp-region@89300000 {
+			reg = <0x0 0x89300000 0x0 0x400000>;
+			no-map;
+		};
+
+		cvp_mem: cvp-region@89700000 {
+			reg = <0x0 0x89700000 0x0 0x700000>;
+			no-map;
+		};
+
+		adspslpi_mem: adspslpi-region@89e00000 {
+			reg = <0x0 0x89e00000 0x0 0x3a00000>;
+			no-map;
+		};
+
+		q6_adsp_dtb_mem: q6-adsp-dtb-region@8d800000 {
+			reg = <0x0 0x8d800000 0x0 0x80000>;
+			no-map;
+		};
+
+		cdsp_mem: cdsp-region@8d900000 {
+			reg = <0x0 0x8d900000 0x0 0x4000000>;
+			no-map;
+		};
+
+		q6_cdsp_dtb_mem: q6-cdsp-dtb-region@91900000 {
+			reg = <0x0 0x91900000 0x0 0x80000>;
+			no-map;
+		};
+
+		gpu_microcode_mem: gpu-microcode-region@919fe000 {
+			reg = <0x0 0x919fe000 0x0 0x2000>;
+			no-map;
+		};
+
+		camera_mem: camera-region@91a00000 {
+			reg = <0x0 0x91a00000 0x0 0x800000>;
+			no-map;
+		};
+
+		av1_encoder_mem: av1-encoder-region@92200000 {
+			reg = <0x0 0x92200000 0x0 0x700000>;
+			no-map;
+		};
+
+		video_mem: video-region@92900000 {
+			reg = <0x0 0x92900000 0x0 0xc00000>;
+			no-map;
+		};
+
+		reserved_mem: reserved-region@93500000 {
+			reg = <0x0 0x93500000 0x0 0xa00000>;
+			no-map;
+		};
+
+		oob_cached_heap_standalone_mem: oob-cached-heap-standalone-region@a2000000 {
+			reg = <0x0 0xa2000000 0x0 0x5000000>;
+			no-map;
+		};
+
+		bert_mem: bert-region@d6f00000 {
+			reg = <0x0 0xd6f00000 0x0 0x100000>;
+			no-map;
+		};
+
+		hyp_ac_config_mem: hyp-ac-config-region@d7000000 {
+			reg = <0x0 0xd7000000 0x0 0x19000>;
+			no-map;
+		};
+
+		xbl_sc_mem: xbl-sc-region@d7019000 {
+			reg = <0x0 0xd7019000 0x0 0x60000>;
+			no-map;
+		};
+
+		xbl_sc_reserved_mem: xbl-sc-reserved-region@d7079000 {
+			reg = <0x0 0xd7079000 0x0 0x107000>;
+			no-map;
+		};
+
+		qtee_mem: qtee-region@d7180000 {
+			reg = <0x0 0xd7180000 0x0 0x680000>;
+			no-map;
+		};
+
+		ta_mem: ta-region@d7800000 {
+			reg = <0x0 0xd7800000 0x0 0x1c00000>;
+			no-map;
+		};
+
+		tags_mem_2: tags-region-2@d9400000 {
+			reg = <0x0 0xd9400000 0x0 0x9c0000>;
+			no-map;
+		};
+
+		display_buffer_mem: display-buffer-region@f9a20000 {
+			reg = <0x0 0xf9a20000 0x0 0x2300000>;
+			no-map;
+		};
+
+		oob_nc_mdm_standalone_mode_mem: oob-nc-mdm-standalone-mode-region@fc000000 {
+			reg = <0x0 0xfc000000 0x0 0x2000000>;
+			no-map;
+		};
+
+		oob_nc_wlan_standalone_mode_mem: oob-nc-wlan-standalone-mode-region@fe000000 {
+			reg = <0x0 0xfe000000 0x0 0xc00000>;
+			no-map;
+		};
+
+		oob_nc_glink_always_mem: oob-nc-glink-always-region@fec00000 {
+			reg = <0x0 0xfec00000 0x0 0x180000>;
+			no-map;
+		};
+
+		oob_nc_glink_assisted_mode_mem: oob-nc-glink-assisted-mode-region@fed80000 {
+			reg = <0x0 0xfed80000 0x0 0x140000>;
+			no-map;
+		};
+
+		oob_nc_mdm_assisted_mode_mem: oob-nc-mdm-assisted-mode-region@feec0000 {
+			reg = <0x0 0xfeec0000 0x0 0x10000>;
+			no-map;
+		};
+
+		oob_nc_wlan_assisted_mode_mem: oob-nc-wlan-assisted-mode-region@feed0000 {
+			reg = <0x0 0xfeed0000 0x0 0x10000>;
+			no-map;
+		};
+
+		smem_mem: smem-region@ffe00000 {
+			compatible = "qcom,smem";
+			reg = <0x0 0xffe00000 0x0 0x200000>;
+			hwlocks = <&tcsr_mutex 3>;
+			no-map;
+		};
+
+	};
+
+	clk_virt: interconnect-0 {
+		compatible = "qcom,glymur-clk-virt";
+		#interconnect-cells = <2>;
+		qcom,bcm-voters = <&apps_bcm_voter>;
+	};
+
+	mc_virt: interconnect-1 {
+		compatible = "qcom,glymur-mc-virt";
+		#interconnect-cells = <2>;
+		qcom,bcm-voters = <&apps_bcm_voter>;
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the size */
+		reg = <0 0 0 0>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	soc: soc@0 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges = <0 0 0 0 0x10 0>;
+		dma-ranges = <0 0 0 0 0x10 0>;
+
+		gcc: clock-controller@100000 {
+			compatible = "qcom,glymur-gcc";
+			reg = <0 0x100000 0 0x1f9000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK_A>,
+				 <&sleep_clk>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		qupv3_2: geniqup@8c0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x0 0x008c0000 0x0 0x3000>;
+			clocks = <&gcc GCC_QUPV3_WRAP_2_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_2_S_AHB_CLK>;
+			clock-names = "m-ahb",
+				      "s-ahb";
+			iommus = <&apps_smmu 0xd63 0x0>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			uart21: serial@894000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0x0 0x00894000 0x0 0x4000>;
+				interrupts = <GIC_SPI 587 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
+				clock-names = "se";
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
+						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
+						<&hsc_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
+						 &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+				pinctrl-0 = <&qup_uart21_default>;
+				pinctrl-names = "default";
+			};
+		};
+
+		cnoc_main: interconnect@1500000 {
+			compatible = "qcom,glymur-cnoc-main";
+			reg = <0x0 0x01500000 0x0 0x17080>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+		};
+
+		config_noc: interconnect@1600000 {
+			compatible = "qcom,glymur-cnoc-cfg";
+			reg = <0x0 0x01600000 0x0 0x6600>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+		};
+
+		system_noc: interconnect@1680000 {
+			compatible = "qcom,glymur-system-noc";
+			reg = <0x0 0x01680000 0x0 0x1c080>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+		};
+
+		pcie_west_anoc: interconnect@16c0000 {
+			compatible = "qcom,glymur-pcie-west-anoc";
+			reg = <0x0 0x016c0000 0x0 0xf580>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+			clocks = <&gcc GCC_AGGRE_NOC_PCIE_3A_WEST_SF_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_3B_WEST_SF_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_4_WEST_SF_AXI_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_6_WEST_SF_AXI_CLK>;
+		};
+
+		pcie_east_anoc: interconnect@16d0000 {
+			compatible = "qcom,glymur-pcie-east-anoc";
+			reg = <0x0 0x016d0000 0x0 0xf300>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+			clocks = <&gcc GCC_AGGRE_NOC_PCIE_5_EAST_SF_AXI_CLK>;
+		};
+
+		aggre1_noc: interconnect@16e0000 {
+			compatible = "qcom,glymur-aggre1-noc";
+			reg = <0x0 0x016e0000 0x0 0x14400>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+		};
+
+		aggre2_noc: interconnect@1720000 {
+			compatible = "qcom,glymur-aggre2-noc";
+			reg = <0x0 0x01720000 0x0 0x14400>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+			clocks = <&gcc GCC_AGGRE_USB3_TERT_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB4_2_AXI_CLK>,
+				 <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>;
+		};
+
+		aggre3_noc: interconnect@1700000 {
+			compatible = "qcom,glymur-aggre3-noc";
+			reg = <0x0 0x01700000 0x0 0x1d400>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+		};
+
+		aggre4_noc: interconnect@1740000 {
+			compatible = "qcom,glymur-aggre4-noc";
+			reg = <0x0 0x01740000 0x0 0x14400>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+			clocks = <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB4_0_AXI_CLK>,
+				 <&gcc GCC_AGGRE_USB4_1_AXI_CLK>;
+		};
+
+		mmss_noc: interconnect@1780000 {
+			compatible = "qcom,glymur-mmss-noc";
+			reg = <0x0 0x01780000 0x0 0x5b800>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+		};
+
+		pcie_east_slv_noc: interconnect@1900000 {
+			compatible = "qcom,glymur-pcie-east-slv-noc";
+			reg = <0x0 0x01900000 0x0 0xe080>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+		};
+
+		pcie_west_slv_noc: interconnect@1920000 {
+			compatible = "qcom,glymur-pcie-west-slv-noc";
+			reg = <0x0 0x01920000 0x0 0xf180>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+		};
+
+		tcsr_mutex: hwlock@1f40000 {
+			compatible = "qcom,tcsr-mutex";
+			reg = <0x0 0x01f40000 0x0 0x20000>;
+
+			#hwlock-cells = <1>;
+		};
+
+		tcsrcc: clock-controller@1fd5044 {
+			compatible = "qcom,glymur-tcsr";
+			reg = <0x0 0x1fd5044 0x0 0x48>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		tcsr: syscon@1fd6000 {
+			compatible = "syscon";
+			reg = <0x0 0x1fd6000 0x0 0x20000>;
+		};
+
+		hsc_noc: interconnect@2000000 {
+			compatible = "qcom,glymur-hscnoc";
+			reg = <0x0 0x02000000 0x0 0x93a080>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+		};
+
+		lpass_lpiaon_noc: interconnect@7400000 {
+			compatible = "qcom,glymur-lpass-lpiaon-noc";
+			reg = <0x0 0x07400000 0x0 0x19080>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+		};
+
+		lpass_lpicx_noc: interconnect@7420000 {
+			compatible = "qcom,glymur-lpass-lpicx-noc";
+			reg = <0x0 0x07420000 0x0 0x44080>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+		};
+
+		lpass_ag_noc: interconnect@7e40000 {
+			compatible = "qcom,glymur-lpass-ag-noc";
+			reg = <0x0 0x07e40000 0x0 0xe080>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+		};
+
+		pdc: interrupt-controller@b220000 {
+			compatible = "qcom,glymur-pdc", "qcom,pdc";
+			reg = <0x0 0x0b220000 0x0 0x10000>;
+			qcom,pdc-ranges = <0 745 51>,
+					  <51 527 47>,
+					  <98 609 32>,
+					  <130 717 12>,
+					  <142 251 5>,
+					  <147 796 16>,
+					  <171 4104 36>;
+			#interrupt-cells = <2>;
+			interrupt-parent = <&intc>;
+			interrupt-controller;
+		};
+
+		sram@c30f000 {
+			compatible = "qcom,rpmh-stats";
+			reg = <0x0 0x0c30f000 0x0 0x400>;
+		};
+
+		tlmm: pinctrl@f100000 {
+			compatible = "qcom,glymur-tlmm";
+			reg = <0x0 0x0f100000 0x0 0xf00000>;
+			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-ranges = <&tlmm 0 0 249>;
+			wakeup-parent = <&pdc>;
+
+			qup_uart21_default: qup-uart21-default-state {
+				tx-pins {
+					pins = "gpio86";
+					function = "qup2_se5";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				rx-pins {
+					pins = "gpio87";
+					function = "qup2_se5";
+					drive-strength = <2>;
+					bias-disable;
+				};
+			};
+		};
+
+		apps_smmu: iommu@15000000 {
+			compatible = "qcom,glymur-smmu-500",
+				     "qcom,smmu-500",
+				     "arm,mmu-500";
+			reg = <0x0 0x15000000 0x0 0x100000>;
+
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+
+			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 181 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 318 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 319 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 412 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 690 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 691 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 692 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 693 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 695 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 696 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 488 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 489 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 490 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 491 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 492 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 493 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 494 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 495 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 497 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 498 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 499 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 500 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 501 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 502 IRQ_TYPE_LEVEL_HIGH>;
+
+			dma-coherent;
+		};
+
+		intc: interrupt-controller@17000000 {
+			compatible = "arm,gic-v3";
+			reg = <0x0 0x17000000 0x0 0x10000>,
+			      <0x0 0x17080000 0x0 0x480000>;
+
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+			#interrupt-cells = <3>;
+			interrupt-controller;
+
+			#redistributor-regions = <1>;
+			redistributor-stride = <0x0 0x40000>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			gic_its: gic-its@17040000 {
+				compatible = "arm,gic-v3-its";
+				reg = <0x0 0x17040000 0x0 0x40000>;
+
+				msi-controller;
+				#msi-cells = <1>;
+			};
+		};
+
+		watchdog@17600000 {
+			compatible = "qcom,kpss-wdt";
+			reg = <0x0 0x17600000 0x0 0x1000>;
+			clocks = <&sleep_clk>;
+			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		timer@17810000 {
+			compatible = "arm,armv7-timer-mem";
+			reg = <0x0 0x17810000 0x0 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+
+			frame@17811000 {
+				reg =	<0x0 0x17811000 0x0 0x1000>,
+					<0x0 0x17812000 0x0 0x1000>;
+
+				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+
+				frame-number = <0>;
+			};
+
+			frame@17813000 {
+				reg = <0x0 0x17813000 0x0 0x1000>;
+
+				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+				frame-number = <1>;
+
+				status = "disabled";
+			};
+
+			frame@17815000 {
+				reg = <0x0 0x17815000 0x0 0x1000>;
+
+				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+
+				frame-number = <2>;
+
+				status = "disabled";
+			};
+
+			frame@17817000 {
+				reg = <0x0 0x17817000 0x0 0x1000>;
+
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+
+				frame-number = <3>;
+
+				status = "disabled";
+			};
+
+			frame@17819000 {
+				reg = <0x0 0x17819000 0x0 0x1000>;
+
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+
+				frame-number = <4>;
+
+				status = "disabled";
+			};
+
+			frame@1781b000 {
+				reg = <0x0 0x1781b000 0x0 0x1000>;
+
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+
+				frame-number = <5>;
+
+				status = "disabled";
+			};
+
+			frame@1781d000 {
+				reg = <0x0 0x1781d000 0x0 0x1000>;
+
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+
+				frame-number = <6>;
+
+				status = "disabled";
+			};
+		};
+
+		apps_rsc: rsc@18900000  {
+			compatible = "qcom,rpmh-rsc";
+			label = "apps_rsc";
+			reg = <0x0 0x18900000 0x0 0x10000>,
+			      <0x0 0x18910000 0x0 0x10000>,
+			      <0x0 0x18920000 0x0 0x10000>;
+			reg-names = "drv-0",
+				    "drv-1",
+				    "drv-2";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,tcs-offset = <0xd00>;
+			qcom,drv-id = <2>;
+			qcom,tcs-config = <ACTIVE_TCS 2>,
+					  <SLEEP_TCS 3>,
+					  <WAKE_TCS 3>,
+					  <CONTROL_TCS 0>;
+
+			apps_bcm_voter: bcm-voter {
+				compatible = "qcom,bcm-voter";
+			};
+
+			rpmhcc: clock-controller {
+				compatible = "qcom,glymur-rpmh-clk";
+
+				clocks = <&xo_board>;
+				clock-names = "xo";
+
+				#clock-cells = <1>;
+			};
+
+			rpmhpd: power-controller {
+				compatible = "qcom,glymur-rpmhpd";
+
+				operating-points-v2 = <&rpmhpd_opp_table>;
+
+				#power-domain-cells = <1>;
+
+				rpmhpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmhpd_opp_ret: opp-16 {
+						opp-level = <RPMH_REGULATOR_LEVEL_RETENTION>;
+					};
+
+					rpmhpd_opp_min_svs: opp-48 {
+						opp-level = <RPMH_REGULATOR_LEVEL_MIN_SVS>;
+					};
+
+					rpmhpd_opp_low_svs_d2: opp-52 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D2>;
+					};
+
+					rpmhpd_opp_low_svs_d1: opp-56 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
+					};
+
+					rpmhpd_opp_low_svs_d0: opp-60 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D0>;
+					};
+
+					rpmhpd_opp_low_svs: opp-64 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
+					};
+
+					rpmhpd_opp_low_svs_l1: opp-80 {
+						opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_L1>;
+					};
+
+					rpmhpd_opp_svs: opp-128 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+					};
+
+					rpmhpd_opp_svs_l0: opp-144 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L0>;
+					};
+
+					rpmhpd_opp_svs_l1: opp-192 {
+						opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					};
+
+					rpmhpd_opp_nom: opp-256 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					};
+
+					rpmhpd_opp_nom_l1: opp-320 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
+					};
+
+					rpmhpd_opp_nom_l2: opp-336 {
+						opp-level = <RPMH_REGULATOR_LEVEL_NOM_L2>;
+					};
+
+					rpmhpd_opp_turbo: opp-384 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					};
+
+					rpmhpd_opp_turbo_l1: opp-416 {
+						opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					};
+				};
+			};
+		};
+
+		nsi_noc: interconnect@1d600000 {
+			compatible = "qcom,glymur-nsinoc";
+			reg = <0x0 0x1d600000 0x0 0x14080>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+		};
+
+		oobm_ss_noc: interconnect@1f300000 {
+			compatible = "qcom,glymur-oobm-ss-noc";
+			reg = <0x0 0x1f300000 0x0 0x49a00>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+		};
+
+		nsp_noc: interconnect@320c0000 {
+			compatible = "qcom,glymur-nsp-noc";
+			reg = <0x0 0x320c0000 0x0 0x21280>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+			#interconnect-cells = <2>;
+		};
+
+		sram: sram@81e08000 {
+			compatible = "mmio-sram";
+			reg = <0x0 0x81e08600 0x0 0x300>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x81e08600 0x300>;
+
+			cpu_scp_lpri0: scp-sram-section@0 {
+				compatible = "arm,scmi-shmem";
+				reg = <0x0 0x180>;
+			};
+
+			cpu_scp_lpri1: scp-sram-section@180 {
+				compatible = "arm,scmi-shmem";
+				reg = <0x180 0x180>;
+			};
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
+	};
+};

-- 
2.34.1


