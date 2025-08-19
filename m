Return-Path: <linux-kernel+bounces-774884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8CEB2B8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB444567865
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B887E3112C4;
	Tue, 19 Aug 2025 05:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YCxSDkLu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873603112B0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755581719; cv=none; b=G42CDiMkfAifXbDl084hRvhOaUmb95H/FvaALEXFZ0GQJ83KbqfkEMHGfBulSJOdS0tXoMx/4+73mCNldZj8Kw44tH+g7ucbJwNJ6UN+CIOzvJAhiQ82gtmeoIKbUC8/9PdjsXBgeoQgfCP5vSai9p520g+oCDKyrzEtT632h44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755581719; c=relaxed/simple;
	bh=2rSyjnOXNH6jZxqRWat3S+IfaQ+klyL79lUq0adK6VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f1XZWkhxaQ9efKdfEZ3vvhxNiODZRlLjZpWyufpReeb+RYuxeE07ZdMbK6IGM24DSOlNc0nUqBYUahaS7QLRsh1Tq5SUHnx4FhE/aT7ByXcKLUlGqz+SUoDGxwW95efqy0R2gZfHcUagEoLWZi921mNfoFeqrx9PnbH4rGKxPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YCxSDkLu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J2A6f9015639
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B8vAYM0Ri6HzYPqPusEESOhjr79e1ErFVtCFN1cMUUQ=; b=YCxSDkLu5yz2f4Q3
	RcDI3dRVpQtdarphXwI7VUURtKhFouxoneOiEpR6SkW/U/Om50feVe2HUmcbm+nZ
	AUbOtfMWinS5JdeFxIYwfirwbeCPQ0xZMVT0tO2TwJqOn9rreFHikevzQXnCC0V/
	JT8Hnz6t18U/n+JlgPRQ0jyjUnmr3GuMSP35QNI5xoMgwc8eMfsTYE3L6qRUk0Nh
	Vv3qsJvZ/tZkFWIwDJh3Y0h+u9uHnSJ5LShHd9yhjF2P3Q9/2LnQUZZX962t0yoR
	SiIM94zAQGblgcawe1ippuoVDNQIMr0QxGBDrQv240dmXijMZc+Pc2G8+PTw5ZRP
	z6HoIQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk5mf7jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:35:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24457f4f3ecso58060735ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755581707; x=1756186507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8vAYM0Ri6HzYPqPusEESOhjr79e1ErFVtCFN1cMUUQ=;
        b=pOnCx8lHQyFS9fs4mebIw4ajYTq3A95ZFAOUQuWNUdHhU7qq8eh3vQRR9peW46I+w+
         oYcaB1Z4BqocWM+wxCXQkmG7cnhzduni97MDpi0f5ePalgKlLbQDIflAEBckMHHBf5H6
         C1aIXbrOh6GkTeDKzPN/FmYiuRcsoWsO5Q/QxGUnWjo6l0b/b04qzZFTPvvYL0OpWRg9
         hGIbSYGm/dCAICkvxYwvxnV2P/qDT9w4gi3K3W6STFCGFDJsA6vUxPcB3cR1UWoKxQo2
         B3JctErG+Hj7BCZ6nc8SwcmL5dhcliYSr+e7u0vDBjtNXCzp/vCGdFSyVaS1PAvbUqPB
         TxrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHLUiuTaWUt/PXXOKhQ3nDnNNmkfd2HXsdJSWoXP8H//Sjl/l8SE85V5eBn8fq9beoQvxjYs7MZ2Qtox4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+KzqkL9Mw41wK5JXEEYPycZMtgyrQiKY2kpT/IMir9be1HOi2
	ewKbBP1Vg7ARfONwLg+N1epO2xa/gjcJzJ0muN6ujCn4fSjtVf1BqSg/3unkfNjoVpGEMyaf3vV
	FjXsvwNzcbCbeGrMMMpa9z8Zkv3NCCYF4i9/aPgAoCaPPZeKFjzPOle/7j+atfWEM36s=
X-Gm-Gg: ASbGncuDLETI0xcCgdLY+nl6u0+lU13f73yA5AXUC+Zwb1FDkdxA85smtC2CrG1PDHs
	aW4Twi71Q+z/DdVFNS1HpyneXddHdh9AKJhMAbZ+yNAiSTbLPpj+ndy+AxnOqHpnjOaiKeY89SN
	437E+7Z8LITXVPS+yr+nZF5wQ0idT/MIUKAf0A9CcPqB4pfEhuETU45GuBfV13UyWzly8Ov+VON
	rxleOhx2+9z+I1yLLvI41I7BLHM/pa2BaGGj1N5kzmnqGgCNxi8rC5/LjaP/kF8H0WmNgpF5Web
	8qp2BUu3L6Wz+0mhXxxZ+rZ6VTafq+7jU7GhQT+BoMireuZRhZAvzd3bOAKze8bV+Qr0jkGF7hk
	=
X-Received: by 2002:a17:902:d4ca:b0:244:9a88:bf6 with SMTP id d9443c01a7336-245e0526b3dmr20781835ad.38.1755581706739;
        Mon, 18 Aug 2025 22:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3T2DWF0sM5aMCv7IQ1WuvOo+eJnBtoWO3vhU5xsD6yPrx9RP8y2lOdkUyfyrc1jBjsJmiIg==
X-Received: by 2002:a17:902:d4ca:b0:244:9a88:bf6 with SMTP id d9443c01a7336-245e0526b3dmr20781465ad.38.1755581706220;
        Mon, 18 Aug 2025 22:35:06 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f710sm97004785ad.86.2025.08.18.22.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:35:05 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 11:04:43 +0530
Subject: [PATCH v3 2/3] arm64: dts: qcom: sm8450: Add opp-level to indicate
 PCIe data rates
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-opp_pcie-v3-2-f8bd7e05ce41@oss.qualcomm.com>
References: <20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com>
In-Reply-To: <20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755581690; l=3189;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=2rSyjnOXNH6jZxqRWat3S+IfaQ+klyL79lUq0adK6VI=;
 b=JlhlQ7TUFYilxYzRYBEH44c1xz4YIwI0fcVfxHuf0FM5xfY9kBMX68LMdQPURjW1d48qfMVRb
 jBzsfMXLcBvDWMTBKEoi+XFYXQByPcCDsCWFyRQW4zGN/lvwwIpaDi7
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=Sdn3duRu c=1 sm=1 tr=0 ts=68a40d16 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: IcZHRM59g1Lo3p1rsFysleVHuDtedSZo
X-Proofpoint-GUID: IcZHRM59g1Lo3p1rsFysleVHuDtedSZo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0MiBTYWx0ZWRfX/DFMJbnL0jBe
 PDynM5LO6Ry0rf7uPgM2HlcfmQKSpAd6sYwgpBuolNUusW3JC021dkAaowBD5r9KG4IEoUIGRUD
 HQ7YHtEyAtaFkRcZnvZzDOkJZuRUuMlKPLgXUUHlXG9M5Z6ALonBCD8d07hMJCc/vpTxX5fn/DR
 85pixwuotFnuNBeCeBDP7sTn7UdV3jFACFi7Q174PRu69GES7Fg8SJ8KVMlDIdHv7dsegWHWucg
 v/0zYcfHQPeCqOfcIlKbakW7uvu59KLhXFIqGK6kEF2xjNIfsPxj7w29IlWBvjeASyJFWRQKBli
 +i8qX8WLVp9KbDZ2hwvboau2ygEC8WK9JGU/9gLZWUI6jcL9Lo1MCZn0CMOwo7p33cf1Me70SW8
 ulEjnCOY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160042

Add opp-level to indicate PCIe data rates and also define OPP enteries
for each link width and data rate. Append the opp level to name of the
opp node to indicate both frequency and level.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 41 +++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 33574ad706b915136546c7f92c7cd0b8a0d62b7e..d7f8706ca4949e253a4102474c92b393a345262f 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2052,6 +2052,7 @@ opp-2500000 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
 				};
 
 				/* GEN 2 x1 */
@@ -2059,6 +2060,7 @@ opp-5000000 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
 				};
 
 				/* GEN 3 x1 */
@@ -2066,6 +2068,7 @@ opp-8000000 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
 				};
 			};
 
@@ -2210,45 +2213,67 @@ pcie1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				/* GEN 1 x1 */
-				opp-2500000 {
+				opp-2500000-1 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
-				opp-5000000 {
+				/* GEN 1 x2 */
+				opp-5000000-1 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
+				};
+
+				/* GEN 2 x1 */
+				opp-5000000-2 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <2>;
 				};
 
 				/* GEN 2 x2 */
-				opp-10000000 {
+				opp-10000000-2 {
 					opp-hz = /bits/ 64 <10000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <1000000 1>;
+					opp-level = <2>;
 				};
 
 				/* GEN 3 x1 */
-				opp-8000000 {
+				opp-8000000-3 {
 					opp-hz = /bits/ 64 <8000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <984500 1>;
+					opp-level = <3>;
+				};
+
+				/* GEN 3 x2 */
+				opp-16000000-3 {
+					opp-hz = /bits/ 64 <16000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
 				};
 
-				/* GEN 3 x2 and GEN 4 x1 */
-				opp-16000000 {
+				/* GEN 4 x1 */
+				opp-16000000-4 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
+					opp-level = <4>;
 				};
 
 				/* GEN 4 x2 */
-				opp-32000000 {
+				opp-32000000-4 {
 					opp-hz = /bits/ 64 <32000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <3938000 1>;
+					opp-level = <4>;
 				};
 			};
 

-- 
2.34.1


