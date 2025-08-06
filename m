Return-Path: <linux-kernel+bounces-757728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F8BB1C608
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B807212FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0C128C022;
	Wed,  6 Aug 2025 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOEEBW2g"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72E289803
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483928; cv=none; b=OLCrRznXn4/WqL63UZgWwOtNxMvSBOqOVkp8I1LpOl1tq2sSGto79i0CDs74I3UixkVp2UQhF7InUmnkj65G++H4qsRLApWrAztzFm417+yc1u+CVnAX91TNHQq9NInQpXLNmEzSxEU0qMolaKKJtXDgot5VXV97dFU5zXiBb7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483928; c=relaxed/simple;
	bh=ckCBBYQJsML80sFucr4APIoykaSAsm3OKq2MQyMsH/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bbqju29TeoKeSQ0lp77mo8OjZ25+5oLDpmuH4DbazM0i/Z/KWpE7YAhHFK62pPavnF/JOuwKm6vaNc2wqAgNBZW4fuFgJBcPwKl05NyVyEpTG0c+gqYVq5/L+ELYsFwmrmNTXDf1o2HIcuOOK6Xapp6lnY8F3THbkxHjo6+C8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tOEEBW2g; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61563789ab7so843600a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 05:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754483924; x=1755088724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=890R0MkuSmiEQg4TF89couHoIqQ3yVOTLI8M06mtKRY=;
        b=tOEEBW2gcqhcJTEgfQJpi/uk2+SNuUejCuZkQEcBT/uN2b3hWlEIDHv/eJ6jR79C//
         vxJQjV0bflPA1TT97G5UGzrmYGKNmXIJPrpRzvjxN7INSnO4N3B/w/i9PRS9p2gjtzXo
         uuToQomJqpdGyP6lSn3+exPnefryPyecpezpCyV2jmwx/2ibRQfRLLuAoQFY6LHVgvII
         O7dJb3SnEODGeIlXKpUS4zgUt0s4wkrCniYqXD2T5gHpqSrzUWlaisiNyHlqX/z0vJQJ
         4SxhFijsY1qGfWVY/Jby4VHbygnt7B0xMRx9QVF2I51Hxs5mG6KD4DMOkymuS6W3MUT2
         eKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754483924; x=1755088724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=890R0MkuSmiEQg4TF89couHoIqQ3yVOTLI8M06mtKRY=;
        b=Qr8YjA8kkxKtdDanRJIZR6ynuHM5rIhkmgKBBJDhptaSqw/PLNASjfJoyOqRwbbOmS
         pwFlng9g4HtJyHPkl3kt4cfufhXAS6l/9YOIWDY22xJiimx+eI5r8NJl4zM/cAUCfWWy
         a3jN/dIxFaRIMZg58CH0fFqyMqXGB0IRM93YZv9AjJcF3UQ+EDYY9jz2wyVOVyZPGZrK
         G41X4Lu5cviRYwZ0jvGhb1GPY1Fp8evms9ls0ITe+xqGbUJXPSbEvZ2hKmwpQGo9gita
         ssnQ3wJfLMTE17P8dlXMMtLnyhyd4ECGDOw+NzMUmPNMtN1JtEOpyD58LywsfA5Dtn+Q
         C9Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUGA+yThtd4Dnhu/k8giJxfC5tKu6CZaECx0JiCuskYJqP1Uay+b0iSqZvrXzNEr7GbyAtUYFmlGzFKc1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+M8rL8jkt20142mOfZlV/sTw+u3NUCNbBaHJRZczNLliBTFo
	FlgBs9gBYk3WSgR5bSORT5HqmIArssHTj1zSYv28QL2/JRsWRsGUnNzE2qu9JIcO+9SB7SNtuGj
	JxVBS
X-Gm-Gg: ASbGnctw99VfRy83GJR/1QgwILtKJ0n/Q1MTrxJAEJz3UBzLC+4eU/CuJZno0q36Vlp
	qfjnOqgUFulcfXrBe1X80cB1P1dPXgai5lUY2pjRDG7At3ZYxliXZvzFUDcEBA9RNluiXOryxum
	WlcADlok6F1ewhJnjBPg/3i5SSqiFzkHAZ/14wWXbsdx8MU9nmxA5x4COsQa2SOesiwGRyMFlZD
	L8ymcxZ0mbUz5Dxx5t+rd8XciYwZqGjdw2ilo2yPe/azPwXrg6R/vCkpW4NVK0RTIxZ6bMIdkoP
	d2k9UpeY1l+94CDcwgiB6bJK1VwNNriFrUgI13oERw4BEVQHNUvlsi1bX4SdoS3bjrMsw1ae4hh
	CUKHGrA4s6wwH1nBYp3tH7YlGhtIXn/3/6BQfuJyye9pfzuEg+g==
X-Google-Smtp-Source: AGHT+IF+dqD/MPDlG/cgIeiOetWE1eRUuddVOmgIVM5Gw6JswuP8slLKBhNCa3RvDXfSUR11Llxhrw==
X-Received: by 2002:a17:907:7248:b0:adb:2ce8:686a with SMTP id a640c23a62f3a-af9902cf7eamr110973266b.12.1754483924405;
        Wed, 06 Aug 2025 05:38:44 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.218.223])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c081sm1083866766b.97.2025.08.06.05.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:38:43 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 06 Aug 2025 14:38:30 +0200
Subject: [PATCH RFC v2 1/3] arm64: dts: qcom: sm8750: Add Iris VPU v3.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-b4-sm8750-iris-dts-v2-1-2ce197525eed@linaro.org>
References: <20250806-b4-sm8750-iris-dts-v2-0-2ce197525eed@linaro.org>
In-Reply-To: <20250806-b4-sm8750-iris-dts-v2-0-2ce197525eed@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4667;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ckCBBYQJsML80sFucr4APIoykaSAsm3OKq2MQyMsH/g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBok0zOt2M+enfTOT3YnWSwEyo61cZxEy4NyjuPu
 mwtu96tbgKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaJNMzgAKCRDBN2bmhouD
 18x3D/9MJFOcGVCQeEPv+J8d5nYLfy7VA76MSfT5o2pWIX5g1TAKjBtm2Jfvlpw89YvxQnk+fu5
 NMwySyOckLl1juOT+rW/AeZWl95jxj/98nuN8VhLXaWbJIRrWt88m1qV+ro+jBzQQJFDcHF+yFM
 VCqOvYnrg/qJOwFvRYYtCZYjLAh0MUTcYU+5XKK6PRAEhr2LiJBmTcCUSoA0/G1ssq7NxiP0i6t
 k3Cw0HEpQITmluUSvhoH9/vxT5fcjpYQPAeSJzw8Bb16SS7XMAjXfUOn1rNzeZw1RTdnpechBnk
 L9pnp+Ui6y5ZR+yuG/R2E+tP1q6boEhqPIvvCpMopbs6HMe55zCiCNX9btkY4cYTDs2JuNMb1TY
 47+MHZzsUNt3ihGehEWPwnY2GhCc0P/oh1KApjLtxQtJdGOdl9J2v+f0RIo0vsJ5BZd10bbXqM2
 beshs2+bQY4/MzQBdQeEUGeDX+v/63yqho9vZJOl7xCT+RMAYfTu+94qNEe5gxXjcqg+Bv91r22
 ogqaarq/xl2zRd/X5xTdgtfl4Ds45gZVb7PuKyPIzQZ8N6PPnxNsi29Rjp7wrKpKviyJYtShoKb
 v7V57r+nyLUkwoiWAbIQGCEVaEiP5b89MTehvDWbJ4vjZeI2N6wNl+GHm/yKAY+IbEFZ+qYFCPe
 Xqe3N8qUewnnTSg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add Iris video codec to SM8750 SoC, which comes with significantly
different powering up sequence than previous SM8650, thus different
clocks and resets.  For consistency keep existing clock and clock-names
naming, so the list shares common part.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

qcom,sm8750-videocc bindings and clock headers dependency (will fail
build):
https://lore.kernel.org/all/20241206-sm8750_videocc-v1-0-5da6e7eea2bd@quicinc.com/

qcom,sm8750-iris bindings:
https://lore.kernel.org/r/20250804-sm8750-iris-v2-0-6d78407f8078@linaro.org
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 113 +++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 4643705021c6ca095a16d8d7cc3adac920b21e82..cea4df8b4673c938428ce1b6f3f5cc9e5be3d3ea 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sm8750-gcc.h>
 #include <dt-bindings/clock/qcom,sm8750-tcsr.h>
+#include <dt-bindings/clock/qcom,sm8750-videocc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
@@ -2581,6 +2582,118 @@ data-pins {
 			};
 		};
 
+		iris: video-codec@aa00000 {
+			compatible = "qcom,sm8750-iris";
+			reg = <0x0 0x0aa00000 0x0 0xf0000>;
+
+			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
+				 <&videocc VIDEO_CC_MVS0C_CLK>,
+				 <&videocc VIDEO_CC_MVS0_CLK>,
+				 <&gcc GCC_VIDEO_AXI1_CLK>,
+				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK>,
+				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK>;
+			clock-names = "iface",
+				      "core",
+				      "vcodec0_core",
+				      "iface1",
+				      "core_freerun",
+				      "vcodec0_core_freerun";
+
+			dma-coherent;
+			iommus = <&apps_smmu 0x1940 0>,
+				 <&apps_smmu 0x1947 0>;
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mmss_noc MASTER_VIDEO_MVP QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "cpu-cfg",
+					     "video-mem";
+
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+			memory-region = <&video_mem>;
+
+			operating-points-v2 = <&iris_opp_table>;
+
+			power-domains = <&videocc VIDEO_CC_MVS0C_GDSC>,
+					<&videocc VIDEO_CC_MVS0_GDSC>,
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_MMCX>;
+			power-domain-names = "venus",
+					     "vcodec0",
+					     "mxc",
+					     "mmcx";
+
+			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>,
+				 <&gcc GCC_VIDEO_AXI1_CLK_ARES>,
+				 <&videocc VIDEO_CC_MVS0C_FREERUN_CLK_ARES>,
+				 <&videocc VIDEO_CC_MVS0_FREERUN_CLK_ARES>;
+			reset-names = "bus0",
+				      "bus1",
+				      "core",
+				      "vcodec0_core";
+
+			/*
+			 * IRIS firmware is signed by vendors, only
+			 * enable in boards where the proper signed firmware
+			 * is available.
+			 */
+			status = "disabled";
+
+			iris_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-240000000 {
+					opp-hz = /bits/ 64 <240000000>;
+					required-opps = <&rpmhpd_opp_low_svs_d1>,
+							<&rpmhpd_opp_low_svs_d1>;
+				};
+
+				opp-338000000 {
+					opp-hz = /bits/ 64 <338000000>;
+					required-opps = <&rpmhpd_opp_low_svs>,
+							<&rpmhpd_opp_low_svs>;
+				};
+
+				opp-420000000 {
+					opp-hz = /bits/ 64 <420000000>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_svs>;
+				};
+
+				opp-444000000 {
+					opp-hz = /bits/ 64 <444000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-533333334 {
+					opp-hz = /bits/ 64 <533333334>;
+					required-opps = <&rpmhpd_opp_nom>,
+							<&rpmhpd_opp_nom>;
+				};
+
+				opp-630000000 {
+					opp-hz = /bits/ 64 <630000000>;
+					required-opps = <&rpmhpd_opp_turbo>,
+							<&rpmhpd_opp_turbo>;
+				};
+			};
+		};
+
+		videocc: clock-controller@aaf0000 {
+			compatible = "qcom,sm8750-videocc";
+			reg = <0x0 0x0aaf0000 0x0 0x10000>;
+			clocks = <&bi_tcxo_div2>,
+				 <&gcc GCC_VIDEO_AHB_CLK>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>,
+					<&rpmhpd RPMHPD_MXC>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm8750-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x10000>, <0x0 0x164400f0 0x0 0x64>;

-- 
2.48.1


