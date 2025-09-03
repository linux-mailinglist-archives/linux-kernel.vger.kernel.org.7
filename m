Return-Path: <linux-kernel+bounces-798410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 067ECB41D8A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BA21884655
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95393009ED;
	Wed,  3 Sep 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Di6ovHwc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FADA3009FC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900104; cv=none; b=sgnp1iUYaSqWbCm+j6ObHOwNrWE4HS+aXdaQQAsd1+N1Xi0h0WE9DmRcuHwof9KagiwAK925KUcGlT17EgqBj4Tk7ZLweKsX9BbB2aC7L512SgCWp81ejlUhcfEfTLAJ+ZAOAX+cJYiLxV+jG2OhFWQB21Xbgp8xD0H6eBFGTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900104; c=relaxed/simple;
	bh=vgKvMK6y/VPKyttLGSjpHqgq/bQ7Y/dk0CJOwFyaiAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X45V1NzRFXiEQfWJGAvC0rcLNnoNxV+G0HyTtezO11np9xm3Jmuf/Uv0IvgL/oTe6D5gi5yupNWDm5pJ2lW3WEKU1ZqzLamPC6LdTQxAxE7XOk08KG5YzdoDXJbLMinATIN8yqXMfN+DI3O4ydhHdqIAxW73iIdZsgauvUN+Pb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Di6ovHwc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEqGK009331
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:48:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mjZ3r1HUnM84qXtwvypQUlVDZydeq+NJjZUSJGbaimY=; b=Di6ovHwco6mWZuEN
	LZnaHk93AeeNNy227jX6WcjYLsCOyKRnXIZNIzi7eXNGVSIPkJSSQ3tAIkVXq16K
	w7AoikW9qQOCXH/cIfZm1TbaULKV5lrMzCy2CajBVwzrGqYBhE5FFCg/cHB7sS3k
	98zzsuVLcrvJ1wvDKEe7T18UIZsmgE4wVJ5bOGNXAd0a6sfET50G3mhCLeARVYmR
	vaEICHcsExrZR4bpvw2wMTKQsG9tpZnndI04PHFp5olYpZDCrn6hmU+xgqqOdRXh
	X+GAQsuuN+PI5zkrg4oLPf1FTmbYM8n7LRuh51M/fY2qJ1e1LaYLZpUyOWIW/vmZ
	MIfbDg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8uep5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:48:21 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7723aca1cbcso3836164b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900100; x=1757504900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjZ3r1HUnM84qXtwvypQUlVDZydeq+NJjZUSJGbaimY=;
        b=l6UsCK+lGrUldwtUS8TBB/yGNJZenBzkyBINOlCMvBLVwNNXJBTq/0G1yMa+bZq8t5
         jstft483Y1KvwJC6v9//PJa45P9qqY3mRZU2i7C2y1Bs3guYhSykAUvF3Tbp4IsX5JXU
         Cj/NWx7N2F7BrpkVEFThpfCYqgvTrMIXgUmTaLXVERpX2dA2Hn/ZzZzH7/qhGfkM826S
         /WNQEMgU5rqvEnDjStb5G3YR8G3AInMcmGJ7h1UemLQ5yaRoPr1qNd0tlZZdhHl7+2Za
         SzwFmRQJh28fQzdnRbKZpx9V7xPG1vRjuCAosJ18+Sds3alTzXa9Wu6MrpQqLhUtSkIY
         zgDw==
X-Forwarded-Encrypted: i=1; AJvYcCUXWOOr4gv+aS0X665yE/m3FkS+XkgvAlaVsu/JM5Yziq+h+z2pQpBKYnd9lksOXbzqMgywcmgkoDADdxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ieymT3KTKqg0Z0NsbkCTFVw1q36uL3G66YBDzN5QwD59MYKu
	B80AEZaQ/KHzq5B3SeHRLpzzlDhpqeKiFmPSeyw+bZ5AwSsoTeYvAlzjsDRWozWIeDqymg8m32C
	CED2TbJOt6My+2+9IkmZbv291OmIPw2OqbVtn2iCnSzoIDabNRMZgT6x/qFw9HGKuZ0E=
X-Gm-Gg: ASbGncuG3jXDyjn9uYlFlPhJ4KNUD5Zi22cgfjnc0EDtdhWuTGCaie6hpTF3XbA0EeJ
	GBdti+x6fEbKRckB09ws+RvgoyNsUnukaDC8EiyF9vxhx3UWbrMydfCHO6pTDgoQPBnp56q89iY
	057TT0X+nF5j8yTmHVghf7SdXQkDq+iz3A1z3CuNY4OnDv/QCS0OyNs76STQs98fPXJ+LQJT/Fu
	9O96H8f2mdAjUPejVocmLrW0W9dnAGsytLsnzLNVWPbmUBuX3DY42YBZo+t3Wh9QM1Zl4I5ft2U
	U7EHxWzPB6nuCI/412rrqFwgqpSwkW/d1DW+FkHfUrf9EjZQFj5SX7jQjlzQymqYIbnx
X-Received: by 2002:a05:6a20:431a:b0:243:a682:9d1f with SMTP id adf61e73a8af0-243d6dff535mr20746143637.19.1756900100368;
        Wed, 03 Sep 2025 04:48:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKlZFAPXjo11ONNgyjTG4Em+10bWJ4qImiiRsEKou0DfbxCAQ12ZIlEmIHEIKkikQaarj5YA==
X-Received: by 2002:a05:6a20:431a:b0:243:a682:9d1f with SMTP id adf61e73a8af0-243d6dff535mr20746109637.19.1756900099859;
        Wed, 03 Sep 2025 04:48:19 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:19 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:11 +0530
Subject: [PATCH v2 10/13] arm64: dts: qcom: lemans-evk: Enable SDHCI for SD
 Card
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-10-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=2019;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=e4UGRGci1o4NHHD8fAyrLZlNVC7z+j0/9/IXHZK3Mrw=;
 b=ICtwKqzBUI8DnoAfdFtTbF6z6xI87ochkmdFtCaZRSqZ8SnbpmEpFlk+xVEDBMsw3mOSDvp0p
 oNtX60FlEzkCc1SQZqvnOPWma3bB5PuPmot87BngWv/hwS3Y3ThiO7X
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: MpKw7gMyNoOTdRy2Eg3yOJ68ostzXpP9
X-Proofpoint-GUID: MpKw7gMyNoOTdRy2Eg3yOJ68ostzXpP9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX9D51z0QXdVTR
 8rJgsugdMj5NSzzv39fb6zffnFw6qDbMjfnBVP4WrY3hUSqln/viHc+WOVSfbBM7s/JE1ZYKA0Z
 SNTyl7CAZk+8AlphxHVeS4O4H+64Hp/q92bOHNkf21rPMWVE5tMqCEZU9MSHBuWAaUWiNAHaeGN
 j2xDuMbVIix11wdiYgjNcsnfHgexpbYtFSY913lbKBa4lSclWkzMpYMHx02x96UI9Do3y9UJ+4T
 XL/MozZIxJF63UvcBH/DZgck83bj0nfzr3PbJh0BWOkaonYt9d2LdVTlzlLAS3oqQmU0F1sD1vN
 eWB5oE1DKkT03q9G4rz+kXcqslDM5a7OyavcdqeuJ5V9AB2exr1kI5poAzwgyXsYqRnrxh8lpv5
 FJSymB48
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b82b05 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=JaNxBooIv5ZhbLa6QxEA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

From: Monish Chunara <quic_mchunara@quicinc.com>

Enable the SD Host Controller Interface (SDHCI) on the lemans EVK board
to support SD card for storage. Also add the corresponding regulators.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index b67b909fb97f..c9e7977466b3 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -16,6 +16,7 @@ / {
 	compatible = "qcom,lemans-evk", "qcom,qcs9100", "qcom,sa8775p";
 
 	aliases {
+		mmc1 = &sdhc;
 		serial0 = &uart10;
 	};
 
@@ -46,6 +47,28 @@ edp1_connector_in: endpoint {
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
@@ -461,6 +484,20 @@ &remoteproc_gpdsp1 {
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
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };
@@ -511,6 +548,12 @@ wake-pins {
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


