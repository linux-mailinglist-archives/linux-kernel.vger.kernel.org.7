Return-Path: <linux-kernel+bounces-814711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB662B5579B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 22:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6066C3B4E08
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7DC31691E;
	Fri, 12 Sep 2025 20:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQw90EGT"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3930DD0B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757708860; cv=none; b=Q/7ey6fEZAoF5S+Wj55iuCvb7P7mXSgX2hcXYLs5twruAcFrovhQQuFecnlfG9amjbqxVftehoiwQp3ZxByiwB81JUK+Nepuhc1B5jwiYk2xnvgHWtJ8Vb0jkKiZuBtsm/BqzFQjaiAQml/bjdPm9pcdBk0PCNa9uDxBPv1HIPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757708860; c=relaxed/simple;
	bh=KdBVnZAxu/f0jdaREIsPWjWbUPo+9pZ4VL2JdVmsAR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amvJy/Vk3z1X12NUunjVhOQA3gYYFdLeXzwGBDRzjyoTrC/eLdrJ29CbmFdunXf4t7u0z2YM/5ZgwkPsKA51mjgP5kzQuPHGqfm+efi4efIj2l6bDkoeyJdL3nBGD9MiG0zQwbVFuW+YjOt+mJKeXu2ZcLeU+M2flR4hP0ad4aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQw90EGT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7761a8a1dbcso831255b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757708858; x=1758313658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE3GYubdo1braKo3QL8VbxJmRniOCS+YTb/GoUUCFKU=;
        b=nQw90EGT9todIan2zMOrfchq0m2ZAwSxEw50Sv6iwTBTyTo57pDGwWm4b9VwHRfXq3
         7r9/A+Cd4+IdHdd7adVUH1HzB/Rbcfaxj7WrO5rEU6o1VZejXJJbfAm6+8i2YC2qoPg2
         40rrRS0bhrrRckv682kQCl8ysrzy7gHMkKy9xHSa+HcqraahHWV0f8Gnu7U8VEZqVvpS
         nfY/QiyFah1AdgkjJIU40f6wW0d2EtS1KSkUqVO6UdeE20DcFTTw+CXSpssDsRnLqxB+
         2utTuOWDyMFrsdeLa1g3i/eQCL+lBljarhddfeneuGK9b3kdn7vwtigZUgRqLEhrsvQ2
         47VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757708858; x=1758313658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YE3GYubdo1braKo3QL8VbxJmRniOCS+YTb/GoUUCFKU=;
        b=gv0xRYOKPPRFKSPr+1lrmVLfCNs4xf2o9gpxWmxT3obvQC6QGu+Q6925cm1hbZdQIL
         O66eUQB9xchtLyI74CkAH+2moA7eGVLV2SGStezFnxvZtwty0KkBo/NwWg7wdA7ezzhB
         j2VVSkktVeOqZCbTcynOaFYk0kr4UciOPydCjD8crCEnIRs3PIr5F0CjC5QtQB7VVweo
         JiTdnqLeHWfeaobiHZtWya3X+SYv8E0EqC1bypMafgyrJ/HYBmlbNw5FyYmbWQ1wCxZj
         g4JW6avMlWaL/65eEaEYVw9A1OZUYSfhWkr0aJQDb20FgG9xxJoDH0IQSbog/aCV3CGh
         VyLg==
X-Forwarded-Encrypted: i=1; AJvYcCXnwyndxeUoMpWlMoyXlbXlopU3nODQFqHdkRJrbWR96rnOxClZU3e7UDLAPZBEKEx7DyJeSKOOVhhpA5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1aHCeWDS8ryewtxqgBmhstQv/YqL6gAvXJg8fNPvw3JGczO+F
	o5xUw+ZRAvw61RhCOSU71ESxzJG6P5hbU5HFDXCT4l/nxO4l85RWlB7a
X-Gm-Gg: ASbGncuiBhoeRUgrmWV9YKgbUDnuTbUgnDP8/OBotM8DGrzaV+aHh7eBDT/w45HRpeb
	ub1f36CyJoIA9WhSOuHHehQX2wv0e8KGggOygAMoTty5o2X9XVyXCXw7RQ8C3s9OPqJNCbm82iM
	clLRhiG4Ubco4qWguZoGieZDAkATkK2YUzUOJojqN2zy8V/t019DSQTQYJ99MI2KR/7HQ2y6sdv
	rDeNd+9aU0n2SyXiG6U+/1IasmiHUQTLHjuANsREV3zwj0/nWeVCXp7KSd6I9Y2Pc+cFndm1uQN
	wrfkF9YpoUNT+PTPTafiMHFZICnm4g4+zgziHM7pe9ZLTJzoFQhxezoJwxPzkjSqCwQkO6jzhT3
	3utlEZWtqNsYlfe1stNGOc62AEvKOqA==
X-Google-Smtp-Source: AGHT+IFvw6M81Uqea3q9MeDb/2jUwHTBlTDeDpS8zi1x5lzGzLpgoV9d8rW9kBVAsGB1U+PHiHpc5g==
X-Received: by 2002:a05:6a20:42a3:b0:249:d3d:a50b with SMTP id adf61e73a8af0-2602cd277f6mr5318090637.59.1757708857959;
        Fri, 12 Sep 2025 13:27:37 -0700 (PDT)
Received: from archlinux ([152.245.61.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a32ea462sm5603995a12.0.2025.09.12.13.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 13:27:37 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
Subject: [PATCH v9 1/1] arm64: dts: qcom: add initial support for Samsung Galaxy S22
Date: Fri, 12 Sep 2025 20:25:57 +0000
Message-ID: <20250912202603.7312-2-ghatto404@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912202603.7312-1-ghatto404@gmail.com>
References: <20250912202603.7312-1-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add new device support for the Samsung Galaxy S22 (SM-S901E) phone

What works:
- SimpleFB
- USB

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 145 ++++++++++++++++++
 2 files changed, 146 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 94a84770b080..d311e637327e 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -285,6 +285,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx214.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx215.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-samsung-r0q.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx223.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-sony-xperia-nagara-pdx224.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8550-hdk.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
new file mode 100644
index 000000000000..b7533c2287b7
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+
+#include "sm8450.dtsi"
+#include "pm8350.dtsi"
+#include "pm8350c.dtsi"
+
+/ {
+	model = "Samsung Galaxy S22 5G";
+	compatible = "samsung,r0q", "qcom,sm8450";
+	chassis-type = "handset";
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer: framebuffer@b8000000 {
+			compatible = "simple-framebuffer";
+			reg = <0x0 0xb8000000 0x0 0x2b00000>;
+			width = <1080>;
+			height = <2340>;
+			stride = <(1080 * 4)>;
+			format = "a8r8g8b8";
+		};
+	};
+
+	vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reserved-memory {
+		/*
+		 * The bootloader will only keep display hardware enabled
+		 * if this memory region is named exactly 'splash_region'
+		 */
+		splash-region@b8000000 {
+			reg = <0x0 0xb8000000 0x0 0x2b00000>;
+			no-map;
+		};
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm8350-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+		vdd-s11-supply = <&vph_pwr>;
+		vdd-s12-supply = <&vph_pwr>;
+
+		vdd-l2-l7-supply = <&vreg_bob>;
+		vdd-l3-l5-supply = <&vreg_bob>;
+
+		vreg_l2b_3p07: ldo2 {
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5b_0p88: ldo5 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <888000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8350c-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l12-supply = <&vreg_bob>;
+		vdd-l2-l8-supply = <&vreg_bob>;
+		vdd-l3-l4-l5-l7-l13-supply = <&vreg_bob>;
+		vdd-l6-l9-l11-supply = <&vreg_bob>;
+
+		vdd-bob-supply = <&vph_pwr>;
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
+
+		vreg_l1c_1p8: ldo1 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <36 4>; /* SPI (not linked to anything) */
+};
+
+&usb_1 {
+	/* Keep USB 2.0 only for now */
+	qcom,select-utmi-as-pipe-clk;
+
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	/* Remove USB3 phy */
+	phys = <&usb_1_hsphy>;
+	phy-names = "usb2-phy";
+
+	status = "okay";
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l5b_0p88>;
+	vdda18-supply = <&vreg_l1c_1p8>;
+	vdda33-supply = <&vreg_l2b_3p07>;
+
+	status = "okay";
+};
-- 
2.50.1


