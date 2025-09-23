Return-Path: <linux-kernel+bounces-828814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E302B958D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C09B19C1C35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9D9321F31;
	Tue, 23 Sep 2025 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WaSiKoVK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE2A30DD1C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625339; cv=none; b=vB+9iDSqFRfNaPdXZH7LyxGFUB5J3jUDLADdiRSQsMh9+lAsQ8+OkKkwgNELHeTpxOW4eKCpYKvM4LuBNtVlI+l3/9MKcaWo3CdgHhkyXBqkdoGe0DFBP/FEwussds+d47IE6eNckY9/Kh97OYsauZ+/A1mNjdT8BXKZKls5+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625339; c=relaxed/simple;
	bh=co+VeRrT5ygqSWlps4tz7VS9I24hEaV1T9pihpVqRYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J8Uzn0k06p2QTLUlCNj/iMpmsqn2VRd/7Blv9NQfdjkoPNcA55kM3so3agYArg98Hrjwpo4hWHYY0MPzyg9uRNrGRKj+p/ICyv8ARDY68UCFj0KmEEEDwuAVfL7v9gfV0VriZNWcU2SF5XTfRZGCBW9sd+ggg48kCbEk2g6aj6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WaSiKoVK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8HC5e004522
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ymPFTOpdlR/08rMAnNErS8qNHddP60a2XKzYX7gAGZk=; b=WaSiKoVKuN59LdmT
	PZBR783DpLo0qysLlY9GA8ldPNcHBC07XwPSNXt4nSox6C1JIWXPj8m0fKsOeYGa
	LPL0IvA6qlXOllVG6hTCy14wMtzl8oAnBjrkMST59U9rr6K+KtxlaLJgAS0ZS1r7
	c65ozGKpwcVlLw9BgTbi7JA+1Rp+5IRanLVLIRPdF61DePJt5/g70PRlkQWgBJcS
	qiqtP1GsERgp2Z5y5bVJreMLx17So2hIAXNzoEYT/7Z9xmTUWojLDM8eVVBT99ZZ
	/pC6/Ix4MpPoSgBbTS4aC/MJxA4XO/0C+LciMWDkMS0SL5OSJlPADfORJKyJVRgS
	U2lW7Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmnrjhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:02:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d2a73f02c3so15923141cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625335; x=1759230135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymPFTOpdlR/08rMAnNErS8qNHddP60a2XKzYX7gAGZk=;
        b=FMjsFGBhs8sdCc5QcBM6MC0MwOzKs6PdaxCOEM3Ifege66ieysbfCpl9ddrFu0T9DU
         WCUvte/mcAv2yg5blQeit4zn2eOsil/d5h3DxcKNrKcNdRodFaoWKdw81qgraFCRbHrL
         61jteb3A1kJEjAkdxQt/sbKWnu5WLokWvA7rG4mjH4+cWDJTV3GiSkVsH9+MGPSeEp5U
         GcO2s6D+huQgjhhjYi9Hug6KrjSGo2Kdpd+osoxNt2w9Ah5K3mT/dfW2KOqcffJISn/O
         Zv4/zqrHoia83m+4GPFaPibHJiPbQtxP0sSic4L0F8S89hg9ciuC70Io+D90KVjGFHbD
         1EPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgtcfDBHxFoK9JFtlUyfT0/+t91YN66rIpSRggEfGKYInX0mPcFJLm9LazOznSBaXO6uzWrm2YGYr+kI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymy7it88srnoeLptqpW69MCnwjlaBv+96JauKf2J9TowhK6zKr
	YIN1jSoNOnlHlDQPrPDXFgbAK9pP/bcKEvBo/pTZjyuc0qtWulJcqTvX9FtfRkyMXnLYDpXQs0s
	bZR4VuPXRXtsFv293ugphOOjOoQS/E/4tMoORhoCbmFU3bwNFrHL+Q77bu9LKlteQoQurpmdvxj
	Q=
X-Gm-Gg: ASbGncv7OtnaM3Cld71Rb3/wnlvI9NYc9runG4kg4MWgIELzZnu+kjV+HcAd5cCPhnE
	LkML8r4EKU8KQyZyG+A/CbClO5KxlS+XoeObOOlDfa1aZyoXukDiLYlmAR/qFbrSetuuWdOq9dP
	J1rrE85DXk2ycsDujm5gCo0Ahs/nUixA11ia/boZ9nXLpuqq3abC9V5x1VmKMOzu9BRLtHlkwG6
	hQxZscqP6k7C/L1r/oq0K5lZIk2oIdR84l2w6h4M45DkUkqyVLX2rq0KkBXdSYf8Ff5r9wRzhLz
	/3uR5XxXUpwkOqMPC5L4twuDUaRPtC9xkKA3leEM80HUV+qo99KTFyXkLY5ypadoIk95BsDIOe3
	r8c9ZnXKW30tZ03Jtv7sUQn5l4TdzuDfYmyVaGzGH7CNC3fLiU5Xz
X-Received: by 2002:a05:622a:1109:b0:4b5:d932:15c5 with SMTP id d75a77b69052e-4d3686a36ccmr25344531cf.25.1758625334405;
        Tue, 23 Sep 2025 04:02:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfZBsdETUls+ifyGSQNXyqNKWpAbA0H6TxDOcIMpq0o5AVEd2d+Lc+xmskxJ22S8vTkWOofw==
X-Received: by 2002:a05:622a:1109:b0:4b5:d932:15c5 with SMTP id d75a77b69052e-4d3686a36ccmr25343781cf.25.1758625333763;
        Tue, 23 Sep 2025 04:02:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f4537csm4075975e87.27.2025.09.23.04.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:02:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 14:01:55 +0300
Subject: [PATCH 2/3] arm64: dts: qcom: rename x1e80100 to hamoa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-rename-dts-v1-2-21888b68c781@oss.qualcomm.com>
References: <20250923-rename-dts-v1-0-21888b68c781@oss.qualcomm.com>
In-Reply-To: <20250923-rename-dts-v1-0-21888b68c781@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=13285;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=co+VeRrT5ygqSWlps4tz7VS9I24hEaV1T9pihpVqRYE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo0n4xV801y1o+yByptBLww7pQ+I32TtRs0Gw5M
 SzOql45zeuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaNJ+MQAKCRCLPIo+Aiko
 1WisB/9vWdppuxj0ZqL3je51Mg0XUQOylSinGq2N3azZR85MH9P3hk6HxAVUiOA2hsnJ9emRxvS
 mbTyzCs8PIfXwpntnSa7uMhDmxN/R/yf0U1GiAR8STAp5qVMBUxzfIl+l0x2CRI75SF2Nbd4Uks
 niTS5BR+HsKMmMeBC6M8LpwIdrtdx6r7o9hCWNsdxIPqCYuHcDO2EGwf3Vy3tztT/OfRISGpvxl
 YMqdEhXDKs54WbxsVyJBJCcd0DsEaeEIN075clKDWmi3S6GzkHoBvPFqGOgUh7/ZUY0j1yDgXvs
 m9io1TZVVyLT3IcZb33Ma8TFjH+bpT7kxUy9fV748j4UuE0I
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d27e38 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=x-Oks8asmbJDW6zTWl8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 16PiUhTwq1tzV62yqyHplzlLqbc_MJ5z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX2dTPORWd2Ac9
 gRF8O/FqBphgYWU07bwZDDONUNCbIUhBpHEKP2oNEQ4CAZY5CXORt2lJEiTzGHSDZdvnvDinNYa
 F+/ni9nhpWHgD/v9fLANaAMuQRtcdAr4U/sGk54Y8jeLaJy8jsxIEtFj6wA5JLYeAhGl8wV+pph
 JC+9TkfaRYRTLzmXkwNnUcg1Bi2+f8u4REMSvz/c7a0cXFzzks6/lZ14Oc/tpQSrGxk3zQmFfxZ
 cVzOBNNuvGacF1AoWi+axrZhJcK+tiwIO5O3MKpmrhrXF5OcDBaSF9t1eC/IHJv4C8hH13YqCFC
 67+Uc/iqpkOjJjgvmknRjw57jyl9g8QyvuZzgxyhmumxKpZtV8i1T++ZAr+pVnkoXNLbYq9Qioy
 Y+qOyaKy
X-Proofpoint-GUID: 16PiUhTwq1tzV62yqyHplzlLqbc_MJ5z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

The X1E80100 and several other similar names (X1E78100, X1E001DE) all
belong to the platform now known as 'hamoa'. Follow the example of
'lemans' and rename the x1e80100.dtsi to hamoa.dtsi and
x1e80100-pmics.dtsi to hamoa-pmics.dtsi.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi                        | 4 ++--
 arch/arm64/boot/dts/qcom/{x1e80100-pmics.dtsi => hamoa-pmics.dtsi} | 0
 arch/arm64/boot/dts/qcom/{x1e80100.dtsi => hamoa.dtsi}             | 0
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi                  | 2 +-
 arch/arm64/boot/dts/qcom/x1-crd.dtsi                               | 2 +-
 arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi                        | 2 +-
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts                       | 4 ++--
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi        | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts            | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dts             | 2 +-
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts                          | 2 +-
 arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts   | 2 +-
 arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts           | 2 +-
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts              | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts              | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts           | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi           | 4 ++--
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts                          | 4 ++--
 arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dts              | 2 +-
 arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts          | 2 +-
 arch/arm64/boot/dts/qcom/x1p42100.dtsi                             | 4 ++--
 21 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
index 1aead50b8920b557ca5bd1405da4a9ca658f4417..4de7c0abb25a12f349ab859fd9e5c68600be42c1 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-som.dtsi
@@ -3,8 +3,8 @@
  * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
-#include "x1e80100.dtsi"
-#include "x1e80100-pmics.dtsi"
+#include "hamoa.dtsi"
+#include "hamoa-pmics.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi b/arch/arm64/boot/dts/qcom/hamoa-pmics.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
rename to arch/arm64/boot/dts/qcom/hamoa-pmics.dtsi
diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/qcom/x1e80100.dtsi
rename to arch/arm64/boot/dts/qcom/hamoa.dtsi
diff --git a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
index ee3c8c5e2c50c405937730c2f7feec43f809af6b..69eccad1a09c240ba721ecfd50d1558aaa1a633a 100644
--- a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
@@ -11,7 +11,7 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
-#include "x1e80100-pmics.dtsi"
+#include "hamoa-pmics.dtsi"
 
 / {
 	model = "ASUS Zenbook A14";
diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
index 3c9455fede5c09d90e00c98db35d49e8738e6acc..5e324f35547a4c803af51e64328b6fb72b4bf7e9 100644
--- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
@@ -9,7 +9,7 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
-#include "x1e80100-pmics.dtsi"
+#include "hamoa-pmics.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. X1E80100 CRD";
diff --git a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
index cc64558ed5e6fa30bef549d076db41ac22faa5a9..10dc191c193adf2d6cf0d6a237cc0fa245d04ccc 100644
--- a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
@@ -12,7 +12,7 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
-#include "x1e80100-pmics.dtsi"
+#include "hamoa-pmics.dtsi"
 
 / {
 	chassis-type = "laptop";
diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
index bfc649d4b643ca5d0d12565bf147b9b1df90095c..701f35af7d5cd080de48cb70db3bb9bea3e46264 100644
--- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
+++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
@@ -8,8 +8,8 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
-#include "x1e80100.dtsi"
-#include "x1e80100-pmics.dtsi"
+#include "hamoa.dtsi"
+#include "hamoa-pmics.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. X1E001DE Snapdragon Devkit for Windows";
diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 0a989e9d3d23146cb9689b68ba6c5779283b3c98..84dc764657f10c2742bcc3205c44e59be18bda4f 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -12,8 +12,8 @@
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
-#include "x1e80100.dtsi"
-#include "x1e80100-pmics.dtsi"
+#include "hamoa.dtsi"
+#include "hamoa-pmics.dtsi"
 
 / {
 	model = "Lenovo ThinkPad T14s Gen 6";
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
index 0113d856b3ad4e9d1b15dc6a32b4572867a794ac..f2960953e608fb81be9b941115df6ba2c9913663 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
@@ -11,8 +11,8 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
-#include "x1e80100.dtsi"
-#include "x1e80100-pmics.dtsi"
+#include "hamoa.dtsi"
+#include "hamoa-pmics.dtsi"
 
 / {
 	model = "ASUS Vivobook S 15";
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dts
index 0d0bcc50207d7540285d82304dbc99e82858f6f0..c3cd04c9703d3df6b04ef4a1393e92aa6b60a5a0 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-zenbook-a14.dts
@@ -6,7 +6,7 @@
 
 /dts-v1/;
 
-#include "x1e80100.dtsi"
+#include "hamoa.dtsi"
 #include "x1-asus-zenbook-a14.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index dfc378e1a056a8af27ef4b646f7589e7198dbaf8..429deffcf3e9dfeb92c9f6141e7611bdec996c8c 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -5,7 +5,7 @@
 
 /dts-v1/;
 
-#include "x1e80100.dtsi"
+#include "hamoa.dtsi"
 #include "x1-crd.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
index cf2a7c2628881e44f093d73e6496462c22326d9a..75e10d97c38674fbe4affabff7d1079de095af91 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
@@ -4,7 +4,7 @@
  */
 /dts-v1/;
 
-#include "x1e80100.dtsi"
+#include "hamoa.dtsi"
 #include "x1-dell-thena.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts
index 32ad9679550efce1fda1182bd874d6a3c53d8f03..a8ff7ef258a13398679894a14bb3333437717816 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-latitude-7455.dts
@@ -4,7 +4,7 @@
  */
 /dts-v1/;
 
-#include "x1e80100.dtsi"
+#include "hamoa.dtsi"
 #include "x1-dell-thena.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index 58f8caaa7258077d2c267048ca048279109ddb71..c1f49cba61fc40c764122f365f2e4b418579a73b 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -12,8 +12,8 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
-#include "x1e80100.dtsi"
-#include "x1e80100-pmics.dtsi"
+#include "hamoa.dtsi"
+#include "hamoa-pmics.dtsi"
 
 / {
 	model = "Dell XPS 13 9345";
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
index e5a839d458402c46e45a2cba9b92d3eb1e8438c2..b79e59e1c413aeb9f24466cedc2c9abea48a3d52 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
@@ -6,8 +6,8 @@
 
 /dts-v1/;
 
-#include "x1e80100.dtsi"
-#include "x1e80100-pmics.dtsi"
+#include "hamoa.dtsi"
+#include "hamoa-pmics.dtsi"
 #include "x1-hp-omnibook-x14.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index e0642fe8343f6818e1e10656a1d8fec8fb09e7e2..56e4d13cca11165c30dcbed8a1e0a4d7f8fa5cc2 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -9,8 +9,8 @@
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
-#include "x1e80100.dtsi"
-#include "x1e80100-pmics.dtsi"
+#include "hamoa.dtsi"
+#include "hamoa-pmics.dtsi"
 
 / {
 	model = "Lenovo Yoga Slim 7x";
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
index ed468b93ba50e1943671d9e7d8b77d181a7c2658..3b319f65dde1e0df9e53191acfa161ccb49dff7b 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
@@ -9,8 +9,8 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
-#include "x1e80100.dtsi"
-#include "x1e80100-pmics.dtsi"
+#include "hamoa.dtsi"
+#include "hamoa-pmics.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index 4a9b6d791e7f475eed8940cce633ca000bb2ae09..5a121fc4494014f01be5d6e3ab95060581ec83ad 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -8,8 +8,8 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
-#include "x1e80100.dtsi"
-#include "x1e80100-pmics.dtsi"
+#include "hamoa.dtsi"
+#include "hamoa-pmics.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. X1E80100 QCP";
diff --git a/arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dts b/arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dts
index 6696cab2de3ec899d7ae5498f2f4b75e2131a19c..47ab0c5b30341ee791fd3976da50ada54617a8af 100644
--- a/arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dts
+++ b/arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dts
@@ -3,7 +3,7 @@
 /dts-v1/;
 
 #include "x1p42100.dtsi"
-#include "x1e80100-pmics.dtsi"
+#include "hamoa-pmics.dtsi"
 #include "x1-hp-omnibook-x14.dtsi"
 /delete-node/ &pmc8380_6;
 /delete-node/ &pmc8380_6_thermal;
diff --git a/arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts b/arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts
index 1ac46cdc4386120ee18cd60380c1fcd10fbf472e..f7d372d2e96129eaee072504514272f8ae34cb32 100644
--- a/arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts
+++ b/arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts
@@ -14,7 +14,7 @@
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "x1p42100.dtsi"
-#include "x1e80100-pmics.dtsi"
+#include "hamoa-pmics.dtsi"
 
 /delete-node/ &pmc8380_6;
 /delete-node/ &pmc8380_6_thermal;
diff --git a/arch/arm64/boot/dts/qcom/x1p42100.dtsi b/arch/arm64/boot/dts/qcom/x1p42100.dtsi
index 10d26958d3c66a5a4faf2ca6065e7b661f967b4e..2cecd2dd0de8c39f0702d6983bead2bc2adccf9b 100644
--- a/arch/arm64/boot/dts/qcom/x1p42100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1p42100.dtsi
@@ -3,8 +3,8 @@
  * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
-/* X1P42100 is heavily based on X1E80100, with some meaningful differences */
-#include "x1e80100.dtsi"
+/* X1P42100 is heavily based on hamoa, with some meaningful differences */
+#include "hamoa.dtsi"
 
 /delete-node/ &bwmon_cluster0;
 /delete-node/ &cluster_pd2;

-- 
2.47.3


