Return-Path: <linux-kernel+bounces-831851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB437B9DB49
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4E04A730E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696812FB964;
	Thu, 25 Sep 2025 06:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f+4nF7Fu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7222EA159
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782068; cv=none; b=RHSAXp9v10XbFVleAP5D8+qmyKPbNPsVw73fot2725RuC5tTBNxIOtFevHs45o4kCsWNBIbSHBfHrOkrV4An7qidiFgw/4JUS/yTaAHS6wXq1D173gLrrBAx0VCkSAvvpNdokWpLaNC/wFaueeCgyn4SZH2lG3uB/BFc8AGV3Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782068; c=relaxed/simple;
	bh=TpwtaDCgHlivPpLqL9/Qjhh1d5fBRL34j4LQ0tY0CRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pV8aNOQRPwKbYmAgfjo/NMYs6VabiJb1MjkfLMl9lRTdUqlpMK7FqlRKtpyCCY8dhpl9kNuc09b+BxpXzcXYmrvNKsCXkeYkMJ9HD3vwuGOCepjRcw1js7ZJD3XflMH2AGngxj1xvc+CJotzlVw1ucZRUCiPFeW4qwob/Org+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f+4nF7Fu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1K36v002255
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zftByufi9VJbnQvCiyTLuLuPz4flDxNwxk0G+B2C3oY=; b=f+4nF7FulxMp9fms
	/UvKus+RY6t8j6CExvUwlojxdnYsCC7H4/0zRr/3zXZHfZzpbtSHiE6rgrw0kHgT
	L/nPeabl9/59ukJvxXWMUhG+0ge5bvTyKma9Z1kGLzMZD82xO11ed04DICuBPeET
	ORp2+PW7ieZZuTKwDz25amqhJhWssegVN+CqDUdpgFdAwRyWizRnP1y5k3ZCA9JV
	pLIPC/gBj2HqP9zSVQlM0+hJ323XCCiOLn93shUf3EVTBZBGkzDZc38jUAo+bW5P
	ENzQmfrn/pTw8WCoL8rqhJCUW8Tar6g6XHAnR8YNmAn3xFMPguXfeQ1sEIbzxGgB
	Zm506w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98q127-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445806b18aso6723305ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782065; x=1759386865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zftByufi9VJbnQvCiyTLuLuPz4flDxNwxk0G+B2C3oY=;
        b=JKvOGCftzWTFBno74yg1ayBAyQQmJcMW/RJAJt8ejhiJHc5AamhWi4JyLeT4oGvBKq
         QE7gLQK4fesQt/9b53HrwyMcVVTH10vkkDnW0fL91O5gMkYi5aDY+tXChLrn0sOGn+s9
         aqWndqZweNV3twlJnOyevdK1IVyzgFWleuvyqfvm6hoo0CL9WEG1RW7caIXETi+G+5m6
         GKOs1UnNpvbD9hBkachRr/UID7D1zVidUuj8V/FD4chj4MzICUzMa48Dk95q8Ba9Zqev
         5wSTNDSLQPYhay741RK/abehgXnKwrfGdauGpW9GLqH15SKVdaZT6Ro0rZZCbD0hPeV+
         RGRg==
X-Forwarded-Encrypted: i=1; AJvYcCVRuzScWrz5g39qf/3ZxQ3Yz+qgjokWcmHzsDH0tnxBv7q6rHAE6uRglodB29/eFo3HkOunuYi6kqcyS4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO3kKuvb813oJanxPpekFHvpLHys4gPNvELTeqPnZYiachUPEA
	u6Kq/xsqpxTbP1z6enCoQjcbxOy6uPZwVh8+OSmlB4CV7G81A+q2cdRqAO1CpDQ3d2yU+QgilM8
	72o44NDAR7PPHOEf2JxtC3bzhumaj6qG7VzVUVjf04ec+CDx30MCTnt3Aj61JwuO0vf0=
X-Gm-Gg: ASbGncv9fbWsM13QBstyosLzlumuLXCPc3xnWhPwPElFSOfHw2cLp0/N/ANFBNUud6n
	aV5ll2gOaB9C+Q6dFR6kTAOhTNm1/nuFwVtr+y5LwzGCOVvYF7NWZ3QCDD3C+K8ZNc0MALfhdPg
	h0vo2y8HCZ/1A+2FOrtSiGTRpIfmDWXnUnXLab4/18Av7vuSsILX0NS0H+fh250mtROI6R+IWkv
	jdS++kHym1OFoOJ7+aFPw7MQHBhAyRv4Rc/dHGAm+5KXxpGZTUwtQedM+Mly1/c/BViUwpdftPs
	Vx9gQ+3MrZH0BvMwzHDvswB2JIn7DK7Iz+mOP19AWkK9mME6GIWvcCaJq0FFlScFzvdujUq5SqJ
	fssfS402BV/GUYC/tmbxNEEV4P26Qs3vJl5UYm28eJXoCRn1nzPRN9zKrzNWL
X-Received: by 2002:a17:902:f64d:b0:259:5284:f87b with SMTP id d9443c01a7336-27ed49d0965mr28733575ad.16.1758782064497;
        Wed, 24 Sep 2025 23:34:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRMrtfbUYMmvipJcaZAjG/PAf36/y1JXJmZcKD4A+f+AbJNuyywZoka5EsJsGc4UHDgbii5Q==
X-Received: by 2002:a17:902:f64d:b0:259:5284:f87b with SMTP id d9443c01a7336-27ed49d0965mr28733295ad.16.1758782064078;
        Wed, 24 Sep 2025 23:34:24 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:34:23 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:28 +0530
Subject: [PATCH 20/24] arm64: dts: qcom: glymur-crd: Add power supply and
 sideband signal for pcie5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-20-24b601bbecc0@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: eD8uyekn3I7vW5N0PNw8EXJsikGvVpLv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX6BkMA2E1p+Ff
 99h0w+wmbItqbmfhFXF9BD1IyfOfsmFWU8krPt6cShuoKwkBNnpkuqx6YegMb+MjZjYYYtFmZV5
 f3oUxCDlRrHvXy98rTx2YHSjltGTjZWm57xQbDcZzoOJSS1/asmBRUXpV/55p5lRJq7QBrhshEX
 JUOD/2AMXjaoynyfm6THNkioVFQMY1O6QqQHD4Wlqj+4sBquxAobtYu3I7RsiDaQVDpbmZdV+e+
 2Y0FoTDqZDJ5dCZRpWliyj0HrH7S7+X1RyIlWVcRDViEPhoEABr1jWoYzwDjuuPJIBl4Usor/yL
 /k3olgGcNCSUqnGw8QRVJkUqK2xm/kM2PZPCMV+ZzmTum2NVaGckxDF+9hrYmx+GyG+7Bxw2xj8
 oEC8/bc1
X-Proofpoint-ORIG-GUID: eD8uyekn3I7vW5N0PNw8EXJsikGvVpLv
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d4e272 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=p3KB_V4m9cBtC7zP5zwA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

From: Qiang Yu <qiang.yu@oss.qualcomm.com>

Add perst, wake and clkreq sideband signals and required regulators in
PCIe5 controller and PHY device tree node.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts | 68 +++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index 3f94bdf8b3ccfdff182005d67b8b3f84f956a430..03aacdb1dd7e2354fe31e63183519e53fa022829 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -107,6 +107,20 @@ port@1 {
 			};
 		};
 	};
+
+	vreg_nvme: regulator-nvme {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_NVME_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pmh0101_gpios 14 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&nvme_reg_en>;
+		pinctrl-names = "default";
+	};
 };
 
 &tlmm {
@@ -461,3 +475,57 @@ vreg_l4h_e0_1p2: ldo4 {
 &pmk8850_rtc {
 	no-alarm;
 };
+
+&pmh0101_gpios {
+	nvme_reg_en: nvme-reg-en-state {
+		pins = "gpio14";
+		function = "normal";
+		bias-disable;
+	};
+};
+
+&tlmm {
+	pcie5_default: pcie5-default-state {
+		clkreq-n-pins {
+			pins = "gpio153";
+			function = "pcie5_clk_req_n";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio152";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		wake-n-pins {
+			pins = "gpio154";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+};
+
+&pcie5 {
+	vddpe-3v3-supply = <&vreg_nvme>;
+
+	pinctrl-0 = <&pcie5_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie5_phy {
+	vdda-phy-supply = <&vreg_l2f_e0_0p82>;
+	vdda-pll-supply = <&vreg_l4h_e0_1p2>;
+
+	status = "okay";
+};
+
+&pcie5port0 {
+	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
+};

-- 
2.34.1


