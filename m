Return-Path: <linux-kernel+bounces-731207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE973B050EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FCC16786C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17452D46BF;
	Tue, 15 Jul 2025 05:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g5pjkeah"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DBD2D46C9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557276; cv=none; b=tdxtcxYjLdvlwW8+CedxmKG6jgUYIP7MLjCUFPuCi5rDBIC43HCMQGT28NTvHvOmIiD3rIFHvwjRcONqlrSPHiDEebJ1YxUZJf1sREPGPksuxXpBsbexN1JIrPXJ3eR4LBNzE43vM7i6EBIw5YHP4nC46bNfCgABz2OGfOlVvVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557276; c=relaxed/simple;
	bh=vainm/xNRpN24g2SmNn9CA25Khfl60n8jqCt7ca7nNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1itL8dWYr5GLgTdZRnz68gMrUfwEX/b8Zf2MXWlXFtUrPE4vBI15BT8FyH8Mvjab4RHyxPECZkF8hiBe9i70GUjSCpcm+dH7/uSyCdnxJKJKSIcXZNS2oI87Z7ZrtJXN1ecjHKd31RK8SEg2Oj3ZQ+61sFa+tW4srXGGoqa+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g5pjkeah; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGJs6J015971
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=52sZ/EqAgkg
	D1L1ASELuhg4WdghQGw/3nAe5HaeLCDU=; b=g5pjkeahSlPM3eZfFDYk4KJDRR4
	h5va7lOGiiJjzECK+cvmATOxowpelDnx02mSHqoyb8qlARAWG5XDrKmnKlFC2rh6
	IcaNA3iy/obQpe7mrNAGO7fpF/rFRA+Hus41shHNwSiFp+SaJSkgc7jYO8ikBIxd
	Qz2QtMRflpOJGcblrWIY5f5Qb1AUVKflk14sAxKDX6Z4LREUjldydWQFA2WTnQj8
	eotEknotVmTjtWT9iHKspWu/SYcVtjt4+n34jTH9NAMCeMkmqcKJIgJE7y0VhqQy
	4Cax6dspb4kwz/pUuTpI+O1KqkPxcd59nYwfWWU0ly3egeOX0/ruQcsQ1RA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxaxyq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 05:27:52 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-74928291bc3so4369391b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752557271; x=1753162071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=52sZ/EqAgkgD1L1ASELuhg4WdghQGw/3nAe5HaeLCDU=;
        b=NGclbbd6cZQdZnMaHeFraeQPkW3E24O7zifBn5lF80fqU4UdFlh5EM+pE89G32oNfE
         I08y2axDS6csH0Q15/WtpSmqZnK7QLFVxFEfSvPI8ZsmFvZcNuO1BXCMVkNrT52HrSWP
         XG04OVAIPOH2Dizu/dLUIb7crpO81EhYqRr8/y0tkjIMdDuJ6ePnTqV5AJcGDI93ZYCp
         gRvIJ+BCpoXnl4Hffq07WgFVILaf18ERM+2OrJX6e5ZS+Iy/F5LZqTvJ/bwip1ivbILc
         kYIhnr/DPjxXguidBZShf2ZyQ+i7T/IJCf/LnFmJksQlCHWG3qYxLh6etWAGN66QUGHX
         6WUQ==
X-Gm-Message-State: AOJu0YwXgj5kzn5si5PwAXZcPvMiJk2Kn4MoZhwkMMBcIZfgga4xQgqA
	yIVCXwP+WYVBYv7Zx/Tn5z1Xf44vFFvJ+aqOffCNoXOKwhFg+/Fi/J1/jgLKkSUTDKCWHy2L2XG
	y3MXLvNlF90v3QnLuyhWlbNZTInPdaFJcysQNf2FA8ZVqdILXX/7g059Az7D53/QXZQE=
X-Gm-Gg: ASbGncslL9EKoFTkTAz3V+FUKl+2JDx9F3Lx33DqfRl0C1O5A2R1lVsRGZMO4eULVNI
	iSmSUDIIt01La+Np/Oq03RYQWsKz+TJCk9rtU4koxjsTJ7SqOz0K2GT0fveJD/Serp3JncGJoXE
	gbonafSxNuOQKORmZuwsaA5U5jSmBSyqru+AyjujwoLV89LQZTRSrthm44BrvTXL0sACyay4yIC
	MFqyRy8T3C2wPTZh2bTrvfzPCIpnZd3iGBfltxHezL58Zxk9G+Aua2pxDbMN17duWQnQkSq95a3
	RPy8/f6rRkLW62HP1QmGTcmt6Faf3JB/M1365aLDrkzgZodW3YRWnKAjdX5N3oL4ZyU9zQ/iPGd
	vIg==
X-Received: by 2002:a05:6a00:21cc:b0:742:a334:466a with SMTP id d2e1a72fcca58-74f1e7deaffmr21401121b3a.12.1752557271060;
        Mon, 14 Jul 2025 22:27:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjHHRCqb843TFZouUVb+ppsFdAQ5P9WglVKciLnWHuaOIeW3ZTU6Z7D0yDvKTFScJr2cVt6g==
X-Received: by 2002:a05:6a00:21cc:b0:742:a334:466a with SMTP id d2e1a72fcca58-74f1e7deaffmr21401093b3a.12.1752557270635;
        Mon, 14 Jul 2025 22:27:50 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f8f24dsm11071535b3a.156.2025.07.14.22.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 22:27:50 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, neil.armstrong@linaro.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v4 1/2] arm64: dts: qcom: sm8450-qrd: add pmic glink node
Date: Tue, 15 Jul 2025 10:57:38 +0530
Message-Id: <20250715052739.3831549-2-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715052739.3831549-1-krishna.kurapati@oss.qualcomm.com>
References: <20250715052739.3831549-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gFleQJyDceasbEoj7gAAvrMscL6C2Zgw
X-Proofpoint-ORIG-GUID: gFleQJyDceasbEoj7gAAvrMscL6C2Zgw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA0NyBTYWx0ZWRfX9YU8JdIvLK+q
 dtjQRd+2+zzkHkFCN1YLtZDWn2cGPOzxYeMVobkc2qFAUaalYwrc0Rw2NJYjb+5PhdZJABV4i84
 T6nwksRU5+WwT81UyVHJl3Tjh/nvC3Es2VQo0oj4ck6WM5S/Q+tfZ4iA6OiyIryTG1kJXrfkjhA
 zEGq5M+t1Pl/3cwgejhe2uyR40k4EggxpURSx63cZPUSDmNm0Sm+CcvZu946e39jUMEqc+L4IsW
 CVu1x27/L5hr24xvFB4eHdWdg4WX1WrFfjcbPyj4UpAJSXBYyMLWlACW9zzLUvyik3JaMKZ4rPW
 i0aRVHZ2hw1ubgeJEJDe/NFZS6eOc0FtmwdxPpS4uqzNiUgwHIULB1l5ix4OBBde+sANUHUoMnO
 Yipd3tNfuSNQqanqe0/WtybSUbeMir1R5FjThhP2GupGVEVbcnOAkHz99ndUbQ4FALmAqEu/
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6875e6d8 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=z-YkvCHTclE8bPj8c4IA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_03,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150047

Add the pmic glink node linked with the DWC3 USB controller
switched to OTG mode and tagged with usb-role-switch.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 51 ++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
index 8c39fbcaad80..56db5f79f59d 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -28,6 +28,49 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	pmic-glink {
+		compatible = "qcom,sm8450-pmic-glink", "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		orientation-gpios = <&tlmm 91 GPIO_ACTIVE_HIGH>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_hs_in: endpoint {
+						remote-endpoint = <&usb_1_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss_in: endpoint {
+						remote-endpoint = <&usb_1_qmpphy_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_sbu: endpoint {
+					};
+				};
+
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -461,8 +504,8 @@ &usb_1 {
 	status = "okay";
 };
 
-&usb_1_dwc3 {
-	dr_mode = "peripheral";
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_hs_in>;
 };
 
 &usb_1_hsphy {
@@ -487,3 +530,7 @@ &usb_1_qmpphy {
 	vdda-phy-supply = <&vreg_l6b_1p2>;
 	vdda-pll-supply = <&vreg_l1b_0p91>;
 };
+
+&usb_1_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss_in>;
+};
-- 
2.34.1


