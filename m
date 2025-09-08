Return-Path: <linux-kernel+bounces-805301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40ECCB486C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08E83C0C68
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026192EBDFA;
	Mon,  8 Sep 2025 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mjAEl+OR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85462F83D7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319663; cv=none; b=Tm1E2Ey+YEao7b7Z1S9xAynWWYligAM2qAbH5M1kHu5RR56PEMyyJpuUg4jsPtpUMGZZFJa7/pTSpWLWKtw2VqYwmnG7ddniyUDBsE+AFgFAqgVal4IBe6kDYYavj0nde55srASRi9k/1qjxSAYGGPoGpmw+2176gJ6QoUQQLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319663; c=relaxed/simple;
	bh=DReB+wH48YHUiIdLLRI8NEeerw2EPpJutPmXdgkgDSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cy+p+LCJcEQX9NoieTyU6Cc6epBfwWhJq7YTroamcofNBXLTal2k/2dAkdK+uvvFCSkozA70NP4b3JP0wifQf2slgvd2v8t6HaQkJaVL5Rh+q9T+5S32vtiYkM5Ug2YuNQW69KeTmbXrYg6i3Vhvvt2Pmwtpmta+JeT/5kpfUiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mjAEl+OR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5880TBg3029318
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u1tyGhzDi96QNYeghxsLZJ5KgCIEwyKJS9JeiBQnTVA=; b=mjAEl+ORbcTqorCA
	SgVdmnkj8ZuZnC9dGdoDdRs6bhocQSysgtPHOjmABvC2TziV5S7s6+UeFRdVHKYK
	f6WDK8SYOc/csDrovQpDiwm6+LIhQcr1Uaq3wCTPudRjifqJ9KcxZVpP87odnlha
	uuHOJDARexhyFS5Ss0m2iFJXSafg6uaR6TeAY6ssCrpa+MmX5VbZIDyl6D8v8KPV
	SZoLwAiwSqp6P7NWGSGdOETgWCB3VkFcfICwwO/022dlNLqxw1448+t18dGlT9B7
	gAxYMrM/fcsznsDeM5hUdMdql++Pd+/gOGrV5MNj9Zc2z0+ncbRk3zBNsTAJo4Cc
	bW7HIg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqfuq5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:21:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47174bdce2so3273779a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319660; x=1757924460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1tyGhzDi96QNYeghxsLZJ5KgCIEwyKJS9JeiBQnTVA=;
        b=CdvtB3XYmEAqQr5AFW3DEs2SeF+yICDq8UXdABonBzSk0TWXdnJNF+RzM6bD4+AjwJ
         FYKWVuT4vZkSsq3g4hWV1nqpIEI6tADoCmXFChjlkmIEfmHsHy0JkHazVKJWTuu7VGwp
         JPDGI/CZar07x/yzHZ+O/W4N6IBHmLUS0puOZSOzFKYrzIskQOEBQvl98rdMLD1tndmb
         sE/tNjW8O5Ynv7QJ5TnDkKlfhEVggNm3xi02fh38cUWiy0txh006sOj3ryU3iQYIKA98
         lvbDILZav1yKxhe2SjBIZyY6zVYZzUS1HDamDK2iB6VfOfjOzuYOVRHZFdZbKBz/4RBt
         1GWw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ5dp4eATmtlgYAkxrhpN5pDWiz97j5rIqHdVZG9+LPywWXWQL85DEpzda8NlxBjdPqMAVuXIEbgmsj7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI4ihLhnwT4TCS7T8u7S7I0kv/cxBeT9pwfrJl/lmufUpRVhWJ
	2WaSVuRh/VBxRbHKfL8hX8fGQ7AFDAN5bRbQcPjQoqHxj/oB4vwDFN2QMZXUm+qjUwaeS748zTG
	2/EpwveRBonXCsiwcXqwXc3uykoVes3X501upopkK3KqocvkbM/2rAwjZu1auZbbQ75I=
X-Gm-Gg: ASbGncsMZwYA/9da5tYZ5IfR7q06b/Z7C3sCQfOCJ/QPKa0OTi1u23CKQccPoLxTJ7O
	L9lOJnLuiwahIOa01YIdhSEU+V5x2EbYYJu0ztQaz6IgEBT4emvEjtQtf8KSySD/GPrP8vRa4JL
	19FKttU2Arv/Zb1jc+Qu/FXqE5Ya1LfaBB5dSVI7Ikv6Xtmynw6i6w8iTEo2v7+Z0wrKvApHM3h
	yRgMJPBFpAkxN3SVZq6Df6nvRSIy0XCl+n/8S6s3XpiTITpjUmJXlSngV7jY8z/RttNblRoVDXC
	oo74nyOW5N8AfUdpb0RZwKG31WUVa6If60LrnA7yogfRl87nr9F1SKSKbai4PVPQw78R
X-Received: by 2002:a17:902:e852:b0:24f:8286:9e5d with SMTP id d9443c01a7336-2516e888f00mr114225195ad.26.1757319660227;
        Mon, 08 Sep 2025 01:21:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOm9oyHz7eArHf7le7cOTQbtPGtuJHkezBgAQ4pxeV9ZrtP5p/AHDFAsCUqrBlCJP/iC7gVQ==
X-Received: by 2002:a17:902:e852:b0:24f:8286:9e5d with SMTP id d9443c01a7336-2516e888f00mr114224905ad.26.1757319659706;
        Mon, 08 Sep 2025 01:20:59 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:59 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:50:00 +0530
Subject: [PATCH v4 10/14] arm64: dts: qcom: lemans-evk: Enable first USB
 controller in device mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-10-5c319c696a7d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=2173;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=z27bhvwE4WO+i5gLrSyuU2f2AH46I3tPsZa6gmg+phI=;
 b=r+be/V+o+GWn6P8M40r3SbCL4X1xTEgUmekg+5QuSjA/ov/k2d1W2GQ6NEfhfIl6xmreh6dB4
 8EqpfDdjqmABjgMphCC/q+/GnUOsifp7fJfv7vLTYuvmQN1p9M1WQO+
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: N6uSG_iwAYHZzHjKyCoC4xBTS5NHQ6sB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX66eSkisGDLu8
 g/3cLIFdnaIuYBqKEfT5m4W9ycU3jvYgBuqZAlhnjBRYN4K8MjbZROMKd9o1x+NWcygL582MGY4
 mS6GQ9lAsH1FSDzJiSR904X3QohEGCagMJvommLv0P+M9gvAWExsTpu8UdulearUbCjrGRO4EzW
 Wb0isc4ABOawlu/6r4svvv+PC6NUshYCjX2n54cLg2O4gBh4GckoZEmwgHuqUdTx1WjBiKHNrsO
 n9paGw/UrEtX4l/hsDOiL2PcDwM6c6hIW0x6PIgIgWHExnn4N2jA9yuyvAxV44S7ykylXM+WESF
 3kcmbnEqPUXH7OJtefr1BKFn0Md9MeOW3QP1XLwRTreXcnfSoMLA3VGVUwfdsxuJxE+5oI242CP
 lmCI/i3t
X-Proofpoint-GUID: N6uSG_iwAYHZzHjKyCoC4xBTS5NHQ6sB
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68be91ed cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Nk2SLWWF8xhsZ517u1EA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>

Enable the first USB controller in device mode on the Lemans EVK
board and configure the associated LDO regulators to power
the PHYs accordingly.

The USB port is a Type-C port controlled by HD3SS3320 port controller.
The role switch notifications would need to be routed to glue driver by
adding an appropriate usb-c-connector node in DT. However in the design,
the vbus supply that is to be provided to connected peripherals when
port is configured as an DFP, is controlled by a GPIO.

There is also one ID line going from Port controller chip to GPIO-50 of
the SoC. As per the datasheet of HD3SS3320:

"Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID
pin low. This is done to enforce Type-C requirement that VBUS must be
at VSafe0V before re-enabling VBUS."

The current HD3SS3220 driver doesn't have this functionality present. So,
putting the first USB controller in device mode for now. Once the vbus
control based on ID pin is implemented in hd3ss3220.c, the
usb-c-connector will be implemented and dr mode would be made OTG.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index d065528404c0..6ec6f9ed1ec9 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -538,6 +538,29 @@ &ufs_mem_phy {
 	status = "okay";
 };
 
+&usb_0 {
+	status = "okay";
+};
+
+&usb_0_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_0_hsphy {
+	vdda-pll-supply = <&vreg_l7a>;
+	vdda18-supply = <&vreg_l6c>;
+	vdda33-supply = <&vreg_l9a>;
+
+	status = "okay";
+};
+
+&usb_0_qmpphy {
+	vdda-phy-supply = <&vreg_l1c>;
+	vdda-pll-supply = <&vreg_l7a>;
+
+	status = "okay";
+};
+
 &xo_board_clk {
 	clock-frequency = <38400000>;
 };

-- 
2.51.0


