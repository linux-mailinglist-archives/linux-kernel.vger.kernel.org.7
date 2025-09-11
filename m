Return-Path: <linux-kernel+bounces-812705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B76B53BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D8667B4311
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7F235FC1D;
	Thu, 11 Sep 2025 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTvls2y3"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFA32DC76D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615930; cv=none; b=fBf8YbxQ78gji4csgnrL8zw6uCn/Y3njgrhKipzmietlxYw9e1gEY8NLbu7LyeoKIFCDqyR5uqxLr+e3TmnG0rtREF/tTqlxsz5A7/3oRz80NtgNRRU6OvtKuwh3tTo8X/vIgn0tb8z8eXP/HIyoo+LAPpUqsK+3V2hjz4YS2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615930; c=relaxed/simple;
	bh=lhy1VcmKCOKs2kPZLsxT9iR7fBKv8yka30yVgDt2xNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cp/HuvUv3IA0vXStyS59APn77dvs1GAwpHaCa090RiLjQp7VnuBGjRMPjtPdQldZUEmoki6bHhXWoJZ6BvRgi4Y6DC1x67yKZx6dkzqlhjzearOyFhhdFPSfYCv/dqWEWK5vlBD5b+e/zKHu2I6Of2Bpdny8ATxE7Ki/do8lWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RTvls2y3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b042cc3954fso198137466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757615925; x=1758220725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTsAmyj/JOYYUEo4xJmHVkBDh83ZUOk02bdsqrMVGp4=;
        b=RTvls2y3RC6CYbhIpKY+HlSzZ7eNYiFV5/CKVNib4bkoqbDSlJ+GRlQBmQ/sfrnwOq
         2Eezevgziwl1wci9uWAi96tJ+R5CdvZPv77o370Bb2AR1eiGIJ5ZzsxE41IaqlCHw2oN
         3w6Z6ZcNxZ3iYyp5y5f5wLmw1ppFVZyNFoAz68Gx4ZA68C/0YqHbzL93I/7ie3dBy/U7
         HU3xaGGNHEWK347947mENF+GxzKFxG2rWny+D/8zMMT/ZhUzu47zZHUsufkQpTHi+/KR
         7nVtGb+ccLMsCJKEInGMViVyK8c4ABxi1Z5YVR0JutbPZy7xjUcq/5b6txroS6hD0ko4
         cbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757615925; x=1758220725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTsAmyj/JOYYUEo4xJmHVkBDh83ZUOk02bdsqrMVGp4=;
        b=GSet5gvYzLUPL1N8IA39cTqIxTj9lNNPbjJ4UkfnEqf5wetpU4KJHt1cRgc8Xz6Y8a
         Ui4xIqcKp2PhztCOq/ra6+1TcAnL19UywIbfcbohuZdI5XYr04dGAQ5UOMNKrFyAehiY
         GTinHEbxdiM6cmydAO3Sl7zVpd6Lwf+OFhVzJLwFJZw/C7hRIW5qc2oBNFmDPGJCtl9c
         Z8s6ev3T6nekUDokEWoWV8vwejyyQXQkpGVlrihGakcFrYLPdzK+kZrAPRzIIBTwDBcs
         CHEZfvqqeICDe+NYSXaqJGgcsLrU4C7mGuQhqrvLoe25tfslwWHgLaBX2MBYEpoH8Zzj
         EHug==
X-Forwarded-Encrypted: i=1; AJvYcCW5+97HgpvMu06wCh68ZhyIFadexBawenRe86RlkHEzFwHSWjM8+MSy+fLs18KkiCkIpkG1fa8oD09Pz80=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi6Cjy/jX8VFD+FYcW5LMDmjuuSB2WqMoLjTSpYBxOpYOf/5w7
	7jXS0rKXrvPfZKI/dfyVs5L6Pp96y6s6qu/vjIgRBpo3GO7tkBINFnXCd8qC9KCg/T0=
X-Gm-Gg: ASbGnctuxF8iDdmn7biRjqhK5T5qSJe38mM9uuoPhkAacgWBQosMctt0dgjbnADaZlW
	JsONgqlqedneiD4UqNUyuBLHoeJEN13l6JnxDlrnNWZ90vKgVvFdHYtv6GCV7IHM4jWJnC47HDy
	1Z+N5wOQh80+zyYAjWIX6XGMqUsFGNHkFoAX2DONNEKTAylS9r+ea95/O4Eh6VxbT1UXu5/ZE8C
	Y26ggaw3a3WiS+Vu1Fk84vI+35AaIvSK4Df7OP38Ipwi9LRf4KgNgbNOLjvQmikjDK2zWr5N2pW
	PG3otk/KrL0bB6dXwH526dNGyHMeaR8Pf2xO2eGHtn0lvxRV2g1gWaciaRsy1XwOUba9C589MfY
	GXz6yPMPibwd8NcXzhscBVXNMzEd6DEPppp/izjhpdBZQ
X-Google-Smtp-Source: AGHT+IGnScMky1jaQN3N/9d83yEP3nqexnNHEitwDorxUh2bbjPeWQGbEG2JLh4duXeqBh2zoFg6XQ==
X-Received: by 2002:a17:907:e98a:b0:b07:6454:53f7 with SMTP id a640c23a62f3a-b07c3833aebmr13158866b.52.1757615924986;
        Thu, 11 Sep 2025 11:38:44 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:725:1e09:bed1:27ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31715fdsm183999166b.49.2025.09.11.11.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:38:44 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 11 Sep 2025 20:38:24 +0200
Subject: [PATCH 1/4] arm64: dts: qcom: x1e80100: Add IRIS video codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-x1e-iris-dt-v1-1-63caf0fd202c@linaro.org>
References: <20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org>
In-Reply-To: <20250911-x1e-iris-dt-v1-0-63caf0fd202c@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2

Add the IRIS video codec to accelerate video decoding/encoding. Copied
mostly from sm8550.dtsi, only the opp-table is slightly different for X1E.
For opp-240000000, we need to vote for a higher OPP on one of the power
domains, because the voltage requirements for the PLL and the derived
clocks differ (sm8550.dtsi has the same).

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 87 ++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index ba602eddfb54616ad38205570bc56a1f0e62c023..d6914165d055cd0c0e80541267e2671c7432799e 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5234,6 +5234,93 @@ usb_1_ss1_dwc3_ss: endpoint {
 			};
 		};
 
+		iris: video-codec@aa00000 {
+			compatible = "qcom,x1e80100-iris", "qcom,sm8550-iris";
+
+			reg = <0 0x0aa00000 0 0xf0000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+			power-domains = <&videocc VIDEO_CC_MVS0C_GDSC>,
+					<&videocc VIDEO_CC_MVS0_GDSC>,
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_MMCX>;
+			power-domain-names = "venus",
+					     "vcodec0",
+					     "mxc",
+					     "mmcx";
+			operating-points-v2 = <&iris_opp_table>;
+
+			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
+				 <&videocc VIDEO_CC_MVS0C_CLK>,
+				 <&videocc VIDEO_CC_MVS0_CLK>;
+			clock-names = "iface",
+				      "core",
+				      "vcodec0_core";
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mmss_noc MASTER_VIDEO QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "cpu-cfg",
+					     "video-mem";
+
+			memory-region = <&video_mem>;
+
+			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
+			reset-names = "bus";
+
+			iommus = <&apps_smmu 0x1940 0>,
+				 <&apps_smmu 0x1947 0>;
+			dma-coherent;
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
+				opp-192000000 {
+					opp-hz = /bits/ 64 <192000000>;
+					required-opps = <&rpmhpd_opp_low_svs_d1>,
+							<&rpmhpd_opp_low_svs_d1>;
+				};
+
+				opp-240000000 {
+					opp-hz = /bits/ 64 <240000000>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_low_svs>;
+				};
+
+				opp-338000000 {
+					opp-hz = /bits/ 64 <338000000>;
+					required-opps = <&rpmhpd_opp_svs>,
+							<&rpmhpd_opp_svs>;
+				};
+
+				opp-366000000 {
+					opp-hz = /bits/ 64 <366000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>,
+							<&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-444000000 {
+					opp-hz = /bits/ 64 <444000000>;
+					required-opps = <&rpmhpd_opp_nom>,
+							<&rpmhpd_opp_nom>;
+				};
+
+				opp-481000000 {
+					opp-hz = /bits/ 64 <481000000>;
+					required-opps = <&rpmhpd_opp_turbo>,
+							<&rpmhpd_opp_turbo>;
+				};
+			};
+		};
+
 		videocc: clock-controller@aaf0000 {
 			compatible = "qcom,x1e80100-videocc";
 			reg = <0 0x0aaf0000 0 0x10000>;

-- 
2.50.1


