Return-Path: <linux-kernel+bounces-775818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FBEB2C560
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DA21772D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB39A346A1E;
	Tue, 19 Aug 2025 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrq2nev5"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A83469E6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609446; cv=none; b=ueAJJRXAD1xyb4rZkE1FRKTHc2ONIEntZpaSPThDJx/1FZjoUPeg7IsFt+t7hdDHtbzJAfSklIrTJjQKyeX5GU9RJGXF3epAbWTjT/FwcRSbRR4uz3B+aid47ItwG3VXde7WfCJzQXBGXZcI6hs336pcaUiW0HRUOuYEI4V73vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609446; c=relaxed/simple;
	bh=Pnpje/yD2mbu06fLBXKGNz7nmahkchdYzCpSWoY4WVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsrzvUiPYScMm0TOSyfi59H3O4UpRkc5ZHYrGVpo+wyY/wh/uNpfgMLJ59BBEuqSsSTYwZvx/SOGnYmFU9v8S2T7biADPQ66yx4l9SKCL5c7lm7KRltpdEvbChY7Ff0IOqRPojkw5L6bT3vV9I4HcU4DLUbLC+bdYXeyjmbpkQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wrq2nev5; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6188b7895e9so758722a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609443; x=1756214243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLWaF7HuIdth5pkaPfonJRs/KLOso2d0qPaTSC6KAgc=;
        b=wrq2nev5WL3VomReOPL+JzKBmlBGvgLJe9wOHzBgLLrYE7VYwmsPnGgG//hWb54/Xn
         sP+vrdx4+HQw761pOR9QE5y6b+jXwkRCNsaO+yxqzEcxgceH1RohzWFo0VRSVU/JAfxQ
         2DeYaE5NMaxLxuU8kK3r5DjuMpCxXav3P/SJuv3gTjhwqWwar3iyfMBRhRDUMvez09Lu
         ndCzOpmkpKqimf/Rn4vR263NWr1S9+NmOUJqvPtus9aoc23KF/1eWfqxDjaFs1e9LtDR
         2jnvI0wlyWHUiT9TkpTRKzM7XdCuut+WQkC+is7TKaI+7KSwzioTjQH6DZQ5Ga4EL3S9
         wYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609443; x=1756214243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLWaF7HuIdth5pkaPfonJRs/KLOso2d0qPaTSC6KAgc=;
        b=FWhqwgbDzaumEY7svUEmiJDLS5Q4kpkPMuC4WsjG7ytAEk8d3KynOGoy/Qn7Scll+E
         VMtY9+6FCBx8tLwrc50q09g61Mxtx6Wa72TEwa4ks8W5E2OlcoKjOUk8/emKBQtR5IJy
         FRbOBtAp9hz/9JZzu7AqUl3fCQybOTZaTEFMR1h9oYYoZxzHk8R79Ui9MCA+Ao1VfsR6
         30DA9Wdf5+z4NfDf6AL3WhyDjCEcNpxpfSzWZR22H/+bgBT3kPYK5azUnJ7VGD8joSK9
         kbjeLVDF47p9LK+QYVmzkSx4iDKMJJTt4bcpk6XL5sAvr911QKXwryFVqWCKJ7AgLiLD
         tTjA==
X-Forwarded-Encrypted: i=1; AJvYcCVDCsii6yPJoMN4HTILDXKurXiBzqlkmwEaq6TfJxD11PsRYfbwZorQGI5iGjMpUDdVUoQmoVfICzlNJic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoyFgWyJ8gcCHuH6TpcvQ3anWuBaFUt+4eoB6TUd4XsFprrjy9
	waxUfoiG9txRZMcr/36/zRJiMCK7bYRqlPrzRDdHMgvabmyakZ/j1+024j71nB89EGs=
X-Gm-Gg: ASbGncs++7s3RHCl0SbrnYyl99hFuFsu+5lAQ6LVcz9w64pyYo8du+bVLIUf93aeEZK
	0vSQpFEp+Q0Bxsxl2Ohxlenlf0o9J+5hMAmwSjbd4l5nypj6U4EqnoUE3C8lvmL1f8oxkd/y9hc
	yRGclhusnOAh8ItKVK5JKxzdn6pTRtxkQgiv1aTemsmoyn8ZTGi/O5rUwmLbwB3LDCtBBf6sF7N
	VTP1v2CcIkC12v07t5oXfGEIOd4f/GIf2o+dNPp5Ss7WzfMqvSt+0vwmFCAAs+4crVaCHctZfCt
	9zjHwpRvV9FRlgGDRlhyE3MsWCtlwJVicJk8TojjAIBQTBgOK90lYyRvMdbFOw2vNNvn70i66Xv
	wxjdhBFoops+yVVelWPuit3eBKjadg90p+w==
X-Google-Smtp-Source: AGHT+IFqVdFx8dYdzxew5mBOuHFWE4MTA2mlVIIIVmrCsF7ZiusdnuYpAiAtFVAeLfdmwIhLAm4dcw==
X-Received: by 2002:a50:ab41:0:b0:61a:927b:a79c with SMTP id 4fb4d7f45d1cf-61a927bbad5mr67491a12.8.1755609443185;
        Tue, 19 Aug 2025 06:17:23 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a758b8efesm1694229a12.50.2025.08.19.06.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:17:22 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:17:19 +0200
Message-ID: <20250819131717.86713-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250819131717.86713-3-krzysztof.kozlowski@linaro.org>
References: <20250819131717.86713-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4596; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=Pnpje/yD2mbu06fLBXKGNz7nmahkchdYzCpSWoY4WVk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHleU1tgOrkzKvXPYz9ORrBJeJVCc5TtrDkTu
 A1rgL26bbuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5XgAKCRDBN2bmhouD
 1wP0D/0XWmx607jRKjb2i6NISVgGXZs0lofJ5ZbOAamm730NJbCsRsRuTw1u5nXtnX2lJMC6uxS
 qEapC1HnsnEIwMkyS28lLpAFsC0Elf3hUwknWdwpWelV/Z8fKIS/+SOiMr5Sr8QQcwK3pNRIxzS
 E405ujMDiq7ITWFTymvwm9WGmdmtnJcHwH1PbUWAIpQohhYEK/kAvaoL8E+wnHEHeI74VIf0T54
 COAk1mxfS3PWkHkecMM37irr4EbuxN7ZC6eutMq9Ys8GXTAMMpyDokk2PZp34te2h1n80njaOAj
 Lra1m8pVrhuFsC3kf2EYoslxKFNBVPOcYhhRE7fzNU69mJCP/ee9f3+iVJRNe5RVjJXecpTfDhu
 733Y5hRBBCGRJlN8oFQzGWd5uzEKSsEgVlJcgpuqofvV+eVOWBuJNxS6QznjSSUxo48ycTQDtdZ
 yD+Uj4QhiW8F29Of3FPitQp0irbuZBTegKC0W29W9qKkim8emMRu7siqrl0SlHQj2vrAU/8gFEc
 oprS8JC4R+99P/iIzbGqhyHWzj3G8F/Km+t838dT1nTVd1J7CuT04jhtXQjarvB8JwOSUyGYJ6H
 jOSxD62//gJE55Rhekl0nXli1FUi+abMh6yDVs48EdgOyI0VJxtLv7eLU674aEapHUxtXOf1SCO XBty1EZm1ZDeYhQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi                   | 4 ++--
 arch/arm64/boot/dts/qcom/msm8998.dtsi                   | 6 +++---
 arch/arm64/boot/dts/qcom/qcs8300.dtsi                   | 8 ++++----
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 4ddb56d63f8f..2c7d74d9388d 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -717,7 +717,7 @@ pcie1: pcie@80000000 {
 			max-link-speed = <2>;
 
 			phys = <&pcie1_phy>;
-			phy-names ="pciephy";
+			phy-names = "pciephy";
 
 			ranges = <0x01000000 0 0x00000000 0x80200000 0 0x00100000>,
 				 <0x02000000 0 0x80300000 0x80300000 0 0x10000000>;
@@ -818,7 +818,7 @@ pcie0: pcie@a0000000 {
 			max-link-speed = <2>;
 
 			phys = <&pcie0_phy>;
-			phy-names ="pciephy";
+			phy-names = "pciephy";
 
 			ranges = <0x01000000 0 0x00000000 0xa0200000 0 0x00100000>,
 				 <0x02000000 0 0xa0300000 0xa0300000 0 0x10000000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 0b0a9379cb05..5c75fba16ce2 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -3082,9 +3082,9 @@ mdss_dsi1_phy: phy@c996400 {
 
 			mdss_hdmi: hdmi-tx@c9a0000 {
 				compatible = "qcom,hdmi-tx-8998";
-				reg =	<0x0c9a0000 0x50c>,
-					<0x00780000 0x6220>,
-					<0x0c9e0000 0x2c>;
+				reg = <0x0c9a0000 0x50c>,
+				      <0x00780000 0x6220>,
+				      <0x0c9e0000 0x2c>;
 				reg-names = "core_physical",
 					    "qfprom_physical",
 					    "hdcp_physical";
diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
index 3cf1d4bc7e4a..5edb137d1471 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -1100,7 +1100,7 @@ uart1: serial@984000 {
 					    <&qup_uart1_tx>, <&qup_uart1_rx>;
 				pinctrl-names = "default";
 				interrupts = <GIC_SPI 551 IRQ_TYPE_LEVEL_HIGH>;
-				interconnects =	<&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
 						 &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>;
@@ -1267,7 +1267,7 @@ i2c4: i2c@990000 {
 				interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interconnects =	<&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
 						 &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
@@ -1340,7 +1340,7 @@ i2c5: i2c@994000 {
 				interrupts = <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interconnects =	<&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
 						 &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
@@ -1413,7 +1413,7 @@ i2c6: i2c@998000 {
 				interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interconnects =	<&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
 						 &config_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index 9076d8eb4d50..03b63b987a18 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -701,7 +701,7 @@ &sound {
 	pinctrl-names = "default";
 	status = "okay";
 
-	audio-routing =	"RX_BIAS", "MCLK",
+	audio-routing = "RX_BIAS", "MCLK",
 			"AMIC2", "MIC BIAS2",	/* Headset Mic */
 			"AMIC3", "MIC BIAS2",	/* FM radio left Tx */
 			"AMIC4", "MIC BIAS2",	/* FM radio right Tx */
-- 
2.48.1


