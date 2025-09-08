Return-Path: <linux-kernel+bounces-805302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4F3B486CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8D93C3115
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D052E9ED5;
	Mon,  8 Sep 2025 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XZbStJ3e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A672FB0AD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319669; cv=none; b=tBQE+vLLudPYX0sw/xnDthjqag/b9cAs2OFiNAlo0A0p+FgUf0raKnS59zzYGyTaHNNSmAaaSn7/a18KSjFULvu1HUJJkdn+SdrMc/8crbC7wZTLvtLSaagz+ZNPYuhHkIaa+KR4R+9qupsPHUcxPE1DFZW6iToAdsE9FP+Itjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319669; c=relaxed/simple;
	bh=uT1RQTZ8HcdDiPZOvVJtf44HkHxuTXRz/oiN9/qCASg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PyB2BxdXZKYRDVw3D+DGiLl82a+B19kVo5kDpbFKm/Z1owX8pItDVAnPQeVlDEtOydTsycGXEK0itWXt8vlm/M62y0hpAWwpBAl+bKe3WGWNjS6U39BXzbS4a57HaIQvONlEbRRqtJTA8wafbff0Z0GcGeiKJyMYrNzKwTq+ETU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XZbStJ3e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5883lOVw013554
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MzF3Foo3tIflXdtMvnJY/IPP1JEHUdPK3n0iEo31wt0=; b=XZbStJ3eSGPBUDMN
	88HUUu+ve2w24Yc3pl4aXO9fi0zOwwhGT7XZ9Rsf5e4CKGn+kkfullrWpPc4bPQl
	IsIme+7CQL5ZVbQVChzJMixULRaF5KzTJaj+k7JQlKolToadcQQsE8eSPt6SMYNE
	WcrxXfdGs9ErxnufjVLVPYNZ1QDpjzKL2hqV1qWUM9D2wB4PKNDqvIKnO3KP70zD
	/HNnEcZi86UiP7OcxK+nMPV6XAk8OvBKIbEhioxKl3vj4XxR8/8APj7j+bQnYJ9F
	tdk43cCDQZPqnDSnq0IKDGYkeoEJIwuHXi+t6GGjurk/h5z+GyakOyFo/PHcAe3Y
	21H3BA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdrmnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:21:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24b4aa90c20so52339165ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319666; x=1757924466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzF3Foo3tIflXdtMvnJY/IPP1JEHUdPK3n0iEo31wt0=;
        b=PmykWDmVv/WKlpl+cYmI16nVp8SWHPj++8rUnjeuOOetkDEaGa9My7LDccm/Ty7Jgt
         jk0+t6VRqBDObs6YKXWA2bJuyqeERkOAYlJ7FRt2e/jdyGA61jSJ5HJ9b91B9k2O7Ddy
         ZrHBia9sFzv+G0ckDU4Qz8q76rCx27RMhpwqz3VxYtSU8jOlsV5f3ZMFO++FYiFAxqRE
         EhWlxMsHJxec+AI0RT4Op+B+A8hURCmzct/Mzdr7PBz4236SqTQebwGuYCEsdZTksZYm
         edeQ8X0wuQXHDljd/qYX6SuRna086WQhHNbKYZR8VRs+X/mjWe0fiPaq0YLZBrzOqCVD
         L2Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVzuYkrf9SpFWZOrzAwepxKyXJcBEykcWhaPWDV6TY0Zb97hzypH0uVBtHqLTZy+SGy8ASURG4corR8uzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXTGZuWzpJ4pJ1aec+ILdclEBQlywuN32fix5yO5Z1QswQpvY
	mCzVyUc0tqBg8/KNlUisZQy4M01H1KGeNS9GRb3Ft1ZzQoGNvOZ/WF30kseUs/21e+SVvs0BeyY
	wGs4tHWXGaUZ8kYpQH3kCzdKAKwcChNSkOC/VwZdS3+n4opsTArAoZyVM1ePoUtxaGIk=
X-Gm-Gg: ASbGnctmu3eJ3J8FmxnuTBdwuWgJHcblE6iqkF2s8//UOMTNJfCVlnfXgszn5TXlNVS
	foBmN0Gmkaqm2I/iDCbQ5pndDvgq1CaxSWlGnQABby28o9kmsG/kKskhrhzJyftaNyA2/GzOCBV
	Iz+n1C6eCiPvuo5bhxgKRGKbXnlamkRS+8uiLL8kiJb8zMYV19FtjjKxdCr34TZEjhNVqGwei8I
	Cp0MxOZmwcq0565YL5c8wmQpHg3VW4XCUILtgoJf9BfU4FLbKwlSDjY9MY3NGcG+Pxszy0bS37i
	mhRYglIpYBpQUtxqlutumNTuuiINVBSe8MwBDcEtRBumbjXOMZhZgAnn+G7nMYnXNsvs
X-Received: by 2002:a17:902:e788:b0:249:1f6b:3268 with SMTP id d9443c01a7336-2516f520906mr101902475ad.18.1757319666142;
        Mon, 08 Sep 2025 01:21:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtEcObXeeS6q2IcvPfNPJBnf2iAPFVQ1ZO9r/1M/JfZ2eGQGxjoJQj/+y2pFDgvex94Mgosg==
X-Received: by 2002:a17:902:e788:b0:249:1f6b:3268 with SMTP id d9443c01a7336-2516f520906mr101901715ad.18.1757319664998;
        Mon, 08 Sep 2025 01:21:04 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:21:04 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:50:01 +0530
Subject: [PATCH v4 11/14] arm64: dts: qcom: lemans-evk: Enable SDHCI for SD
 Card
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-11-5c319c696a7d@oss.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
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
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=2103;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=MDJChDydQoup+AQ4stXZYHqRNLvdQ06UIqjeVzxFUuc=;
 b=wR7ahREHx0KuEoAte6tk5BSWjlaOXiHNgFfN4HxxkzQLWC8yORbt6Mhc908CDcr+wTYG0tDBY
 Tyb+ex5UVqTCq4C2nujd/yIBpqTGi0oLGZIpiaBFQtZBevShEWwLxaU
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: upJXFpoUrHKmU9IGZgMR8kquQEWOaYKo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfX2RMxSu3xg0VQ
 mRyrKTxxyptBydk9IauUwSkdcN33DuYbCIhNTHdQYRhVriUBTV9wBcj34otTh3ywdHoaUHHYnnT
 rdg9HqxxtnUP8QsKKP1AVEveyeiZWvP0+IN/mH95zWxFyX0NX0/6J2TJNU3IBBk0V8bznJ0iDRH
 WitHuw042EM31v2D4w5vQ3FCB/aahNtcUq4qduRxUpU4mSsNo65nnNYToRgoHbTYNqdbq27mbGg
 Y50Z6RG4HyJmLrFO6BACm/55e7LybaF3wLUnjkQSBiWyJ+U8epnLi8hdpx5kVXvWAyPkdRIimH8
 MMOmZiu95CFi9Uo0zaut2XRznVygc3fkcYkz7D52LTt3aTriNsvv9PiKCS6kFpAY09EOBaLojWx
 tXipWGC0
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68be91f3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=yrLL4yFEfc0NwOpttVsA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: upJXFpoUrHKmU9IGZgMR8kquQEWOaYKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034

From: Monish Chunara <quic_mchunara@quicinc.com>

Enable the SD Host Controller Interface (SDHCI) on the lemans EVK board
to support SD card for storage. Also add the corresponding regulators.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 6ec6f9ed1ec9..60e365a13da3 100644
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
@@ -461,6 +484,22 @@ &remoteproc_gpdsp1 {
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
@@ -511,6 +550,12 @@ wake-pins {
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


