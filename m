Return-Path: <linux-kernel+bounces-819094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B9AB59B5E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783DC484AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D943629AF;
	Tue, 16 Sep 2025 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dn+F4eCw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAD635FC15
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034830; cv=none; b=SN2i5sDChlnAd8FAYfWetVtq1NWSYpAEE1/lL56GcZhYKOW+pZMaONcQtJSg9+8if+HIEwDH/cQDN7p1JEcHk9gfbFq0mFwrdn9soEwb9qMeEBPZiSJ9sZw66SPSMHzyuNbMgmDhqDMUEHLl+2x0zCP/C/GNYg7l/xGAGFHTTaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034830; c=relaxed/simple;
	bh=D+MI1yBSPD0wfaK64wdrIx16i0xhge1W8zq7BamNICI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cxdm3ELzLYS44jlD8PtHPUIJvUvxkNiO2ebRHPc4+htqhPPtXgpJtf6ItDGmXP2r2goQ1odt53F2ShhVqVpPYQddl4rh8hCsT3m6Oo4a7y0lZNfyS4ZjGhBfBxQPFAnbsAK5DGYkuUZUw4CiUef+piKC8eUrWXV6V1LyTeLUj6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dn+F4eCw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA6AZP004961
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c2Wl9Ei/DIdqaCb3FT29b9bLmkPceZ9goQF1SjIPoN8=; b=Dn+F4eCw6jihG5yr
	pMwLMbSQkJ2EoH4uunNiOUHS7/ns8U/ttw0h0VsHsXDxIpJc05bxDMEWL/R7CQkV
	lAYGz3FWgwTmFasHMhppKtHrN+d6+bIcLoEMhrF8KcDNL4agkOa0BRVHjOja4d/j
	hXdUTU5rx3/6VjHUkEntJaopwOr5ITtV8BFfXVJANvBrl1bX1BzwMnaE6XXiZJTi
	QsdaGOqicNAIjSlTt2upu6MiAPdUIwiBKJn3ePeYvaREmcWMK5xg3n1hTUQNV9MI
	enn6G0oSDws+h2B3r6GmtTpPGKkAstpJNFzlKdGLdYb8FNQ06RCQjZj+Y0TvuIBl
	1wP+FA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4950u596b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:00:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-248d9301475so81758545ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034827; x=1758639627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2Wl9Ei/DIdqaCb3FT29b9bLmkPceZ9goQF1SjIPoN8=;
        b=X6kOb9aEPxlHSEbnRcgfk1sfV9olgY8HuxDb5NpoKl8k/yDcroiI5ePJko93cCXM5N
         b7fGzbk6z0z62Xzut+hcR65UlhnPF1HvfEPINu9iDKWwlq4tsuqkI+haS5ST6b38CN6B
         zASCHDudMV63tLylViB6TgAANXYzBEoLtcUgv/+l3+GTQUy1mGETztjsiPp8p92TdeoY
         VUTWxNtDwKfOEIdErwVtrG/Em/EUeQPU3UHF7++Yc/8BILhbUQqFKD06KEcbfKuG5o0h
         afZIGE63s84Fk+8xKlAjcC5fn3wR0nsV65EHDfTEPLzCYgcUt/dyHJYvF8tZnputr98p
         NDzA==
X-Forwarded-Encrypted: i=1; AJvYcCVa33kRL4ZUXbMstLINYxlN/SxXQgEcxrTeRsJ1pOtdYPuDKvyaUy06Oeand4uOGzwkvKe10IH2c7qdxJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFV59VepzRYa+OvBPdREz6SiCMsSa7sGM5Vjj1w3HukG2q8DJI
	jqOc2FJA6xg3diTo1uVVR7eKLG9ere71iOf68atAzU6GfievxhjUpdvcJ/83ayT7KplXUNZpNkT
	f50OEYPrdBo1/EU8qwp51kMiFhzP9KQ5PPftkBhHcjl4DVxCYkB0xf1rUyvHFXn85OXc=
X-Gm-Gg: ASbGncsP7j698tVZryckfP93kd25azQ+U67u6p9nu5jeXTJVBJhlXqmgyY6dnZwQsvy
	9phnpWXoz78xO4Isb7pse+K31z96XpToMyTarg0pUVABqa/zir4aF2twX4GRsOKTVl+wtQttj6R
	HjLUAO/wyVqnerele3h50rxBaE+/Azzx0q3gHoNrPsQVire8xq8524ogYePgYGlY+LGTRqS0mwz
	8mM8jC4wSR3jT+G8HgaC+3QFlGIYyRfmvNQO42a7TkAXfE0jY9sG2vRvYI3XpaN3Bk0/PQUW+GR
	uTIyZKxgouPHp7gBJcGmCVLNOaIP1IfsPeqwqdWYTE4xMuVwontrfaOr7uNJ3UF/u4F6
X-Received: by 2002:a17:903:240d:b0:267:ba92:4d3a with SMTP id d9443c01a7336-267ba924f53mr55752085ad.6.1758034826298;
        Tue, 16 Sep 2025 08:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzVwiO2rpg+4Oduh271gIE5EJgVxIPETHc/7YFjqcVMjYk69yT8M6FE0sDePh7YrEWkPJSxg==
X-Received: by 2002:a17:903:240d:b0:267:ba92:4d3a with SMTP id d9443c01a7336-267ba924f53mr55750955ad.6.1758034825496;
        Tue, 16 Sep 2025 08:00:25 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm74232615ad.45.2025.09.16.08.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:00:25 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:29:31 +0530
Subject: [PATCH v6 09/10] arm64: dts: qcom: lemans-evk: Enable SDHCI for SD
 Card
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v6-9-62e6a9018df4@oss.qualcomm.com>
References: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758034770; l=2151;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=wTUKv5iuUm44oYSXkoHnDdPei2RDohsGfjquUCYOO7w=;
 b=1NB1AhnzEB/9+2GIL0JUL6Q8Ie0ZvVJAQ//XKFFLSSQ4J0ZdEwVGBVLskYVRXlR8Q9J5Q/0YP
 nJfTAVZr+x1DdWQr7wl7aqjhYCYat5eQOrhBeh7tdXNL83zicUM8UKG
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: IMQr4B7OINWS7EVZaIzBYdF0pCnln-S6
X-Proofpoint-ORIG-GUID: IMQr4B7OINWS7EVZaIzBYdF0pCnln-S6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAzMSBTYWx0ZWRfX81hXA9joXS2H
 SqFxEvU5G07OqTTp5CgdIZhQrRiP7T4zm5OoRhsUHAFj4JOl8gNuYqMKzBrNhEQSNeHaFMDpE5/
 nUJQSPmZlmFTDuI0QdEEQ/FiIZF50dNjBglmTYyqVFA0ItJekQ0eWXeREe1hKDES8HKZDrrXjvy
 iUJMz6hXt+kAMz+uu7Jx3ELw1Th3LoaPzOZrcRpZuzZkLxu65a3A1X7ssRkWfySBebZVUrBX1yy
 SY0+1WVxE+QGiUJ5r2HS1No8dq7b8hT1linN7StLJIOgztdtc048F5tzrm50lPdQD5Y0VvRUi5F
 OdcHct8QXtX+RPXnwScef66LFJytYWvOo6v8FawKc6GGym/lld/q9oAPiwEVyzAdqHqOcXTh8FL
 szdPz4EF
X-Authority-Analysis: v=2.4 cv=JvzxrN4C c=1 sm=1 tr=0 ts=68c97b8c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=ZiJiVGjlRZjjTBZS6bkA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130031

From: Monish Chunara <quic_mchunara@quicinc.com>

Enable the SD Host Controller Interface (SDHCI) on the lemans EVK board
to support SD card for storage. Also add the corresponding regulators.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 3a0376f399e0..0170da9362ae 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -17,6 +17,7 @@ / {
 	compatible = "qcom,lemans-evk", "qcom,qcs9100", "qcom,sa8775p";
 
 	aliases {
+		mmc1 = &sdhc;
 		serial0 = &uart10;
 	};
 
@@ -98,6 +99,28 @@ platform {
 			};
 		};
 	};
+
+	vmmc_sdc: regulator-vmmc-sdc {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vmmc_sdc";
+		regulator-min-microvolt = <2950000>;
+		regulator-max-microvolt = <2950000>;
+	};
+
+	vreg_sdc: regulator-vreg-sdc {
+		compatible = "regulator-gpio";
+
+		regulator-name = "vreg_sdc";
+		regulator-type = "voltage";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2950000>;
+
+		gpios = <&expander1 7 GPIO_ACTIVE_HIGH>;
+		states = <1800000 1>, <2950000 0>;
+
+		startup-delay-us = <100>;
+	};
 };
 
 &apps_rsc {
@@ -513,6 +536,22 @@ &remoteproc_gpdsp1 {
 	status = "okay";
 };
 
+&sdhc {
+	vmmc-supply = <&vmmc_sdc>;
+	vqmmc-supply = <&vreg_sdc>;
+
+	pinctrl-0 = <&sdc_default>, <&sd_cd>;
+	pinctrl-1 = <&sdc_sleep>, <&sd_cd>;
+	pinctrl-names = "default", "sleep";
+
+	bus-width = <4>;
+	cd-gpios = <&tlmm 36 GPIO_ACTIVE_LOW>;
+	no-mmc;
+	no-sdio;
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };
@@ -563,6 +602,12 @@ wake-pins {
 			bias-pull-up;
 		};
 	};
+
+	sd_cd: sd-cd-state {
+		pins = "gpio36";
+		function = "gpio";
+		bias-pull-up;
+	};
 };
 
 &uart10 {

-- 
2.51.0


