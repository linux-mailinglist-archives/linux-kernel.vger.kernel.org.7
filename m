Return-Path: <linux-kernel+bounces-777191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A15C5B2D664
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373D316260D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DDA2DC333;
	Wed, 20 Aug 2025 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="APlLwN5b"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4A2DC329
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678561; cv=none; b=M7UlipxT2HmBUkWE+rQum9yOAM1TSk42bGl1CgsunHHrg2oDfCO8spVp/BEbV3M/pxlDfAhxuPkmmKzwjaQQg3sgZ1yhYAVX9pocFxWioAfWTsuG8Kgsx2J+mbcqFyuA817HwVySmyfMc5W5Dt5CgMTz4rLtBrS1/ETHixh58SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678561; c=relaxed/simple;
	bh=RCqLqzAj0VbpAlvyc8i8vBnL4zMGPgKy7ycod+X79zI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VTNyu03+ztBlpg28M0QGKCZnlEUdntCCdw5sYmCh+0scj265Yxm9fWcIZWqOAXJbFK65pD5R2/QbQu8rVw7YH1lHjSqypn7pvqLFv+lczN+755LlHx9965KU6finJf5GKwIf9mTJJX2o80gUrUfjITTCnq/kF1X8P3QhvH751ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=APlLwN5b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1ofTq025326
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JJBFPCt+L+VnPnU7H1DGRHxwQbocBi4RyukAe2zpcSA=; b=APlLwN5blKMPb1o8
	SBR515M+e3z6V4MqnG9qvl8WWgkTlMYz/JHWI6dBW/BJYKNPnzHcT0jdUDCW0Rdk
	81gtcBjKNGsBJ6TIo/bL6bnMZIvARlW+j/aXQs+3SaAMORSQw79dJUf3VUfTVYJD
	dnCB5jdz85QiNu2yvtRNHRg2G03wehAv9ID7lDD5DthEtxADlhSyipr2ipZIjp9Y
	XqNul/f3+G1ydSYrpLpZr4Bga/Pb6zQhD4DsZAE4iGmJXufpYCaf9pZjwlYZb8wr
	WakIH0yyFp58zYTIQnbmMk0tmKuu1PqsJQ+8KThjSp4o8b8zonUeO3mTsuaEToeY
	Zkmgfg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a90bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:29:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2445806eab4so66132715ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755678559; x=1756283359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJBFPCt+L+VnPnU7H1DGRHxwQbocBi4RyukAe2zpcSA=;
        b=vAcuIMHHstkjAGiCA0BaqyypQekum0sEte2jaWPD67JcApdaLcjoHT+fdkWMnv3aV4
         FDgZP9xAL27ZNhvKdCxkVqw/8tJnXYyndGvBNVJ7M5s1c1fayG13ffbg39sxLEAv7zO/
         FDy995NrrZr2pGTBuadxhmZIaHeKT86ngMK78FA6SUElwr/CpsD2Ry+/0YmtQrqxUZ88
         Cj5W1szoK6Kqkb8Ygf2/5Z2ujITxh1SXP45cL4Is8ux+snmJf0iPYzoluQCs1nM9onzZ
         oEeSExIgZXZi9N2ZBucb9A0yj7yT/bPt/OOfBO+wAmH60YIera0yV42Z1e4T/AcqK25U
         nuyg==
X-Forwarded-Encrypted: i=1; AJvYcCWKfTzQvsAWI7VMVzbwfXZfrSk+RiCTANDjudg3zkHA5BFZF336EkQU7wCFWwrm6mfH2YBQDOpg/Wh4hTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGu8FIOTk5rMUSg+COXr2pPvXt8cOy7mtKj3yqrF9gz5gWbecC
	0bBYy9WEP6NYoqqgRhaeMmhWtTgC7m1+sJziQzArwemvV1mnj2Ib9ioRHdvW1BwO4nWPaTeH/w+
	WAjuTCHmwY52T7pYtn7oBS/F4aVAF3OkhI2cBj7kaRXTCV5cW7AdbVA+tEF1I+9se1r4=
X-Gm-Gg: ASbGnctwyo9cWX06HmHO/0UpWt/WOtqI7LE64Z7SVuuC1qx1g6k/of3B+MnH2mNVVnc
	VCfjxr7xleA6B/WwFc9l+QbjaUcZ0lrssbQ1fanbHKCVhbsqGqvxketcprs+V3jkiUsRyLVGdUS
	LxAwoJjcRPIPHsxK+dRWBs652QBZYRXtpnvDNU0i1Xv7Orli47yjiCPwH7ysvRVMSKFWTfoAVzZ
	4WqSYDwdOfq+HPr3ZJduM+4PxMh+4xquZ8ANgLuexlvLglf3UuQYGe3X7lmcykwzGifm1XL9v3L
	7LuuwtXG1oAwf7ZPLJ4JMLpuXA68XrCVr53GoI/aZzfvecYw5JyW+Vfcoa3ItmK9YzY/IhICwPU
	=
X-Received: by 2002:a17:902:c950:b0:240:3584:6174 with SMTP id d9443c01a7336-245ef1557d1mr26588375ad.21.1755678558861;
        Wed, 20 Aug 2025 01:29:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2FNLCe31c4QhhpjPtyR62p+yyy0HN+CAztXKtXBb/uTVv/7m1TwUNP0egRlhYzKGL2hQPuQ==
X-Received: by 2002:a17:902:c950:b0:240:3584:6174 with SMTP id d9443c01a7336-245ef1557d1mr26588165ad.21.1755678558413;
        Wed, 20 Aug 2025 01:29:18 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed53e779sm19037735ad.160.2025.08.20.01.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 01:29:18 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 13:58:50 +0530
Subject: [PATCH v4 4/7] arm64: dts: qcom: sm8550: Add opp-level to indicate
 PCIe data rates
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-opp_pcie-v4-4-273b8944eed0@oss.qualcomm.com>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
In-Reply-To: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755678529; l=3994;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=RCqLqzAj0VbpAlvyc8i8vBnL4zMGPgKy7ycod+X79zI=;
 b=L5GD4S5OqH9uGalT9rHWcMkO5a+pC4X5lxTx1KJMhz3RMeEGQLlfog18M+QxVjbG3SoCXYy6K
 3NhuUQzWlP6DJhMbNAoCuVzzrYhprt68D+hFNIDn34vIqlRQmH916Vz
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: jEEZ7dGlESTR1Iukvuqbp5lfGbhbuBmi
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a5875f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=qQkGquXN9PvF_GGjQ98A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: jEEZ7dGlESTR1Iukvuqbp5lfGbhbuBmi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX5Is9iRZM2im0
 hf8cHyM8A5PYUhhvdvEk+Lk6QicFT+HHcKPlQGhnOC5plVuE+mCx0dLeCDaNQXcxcGa3nJjupS6
 O3paYXRhqBd5OmI6gMUD6u4ws9qiMmos1eSviDXFehdU4lzCeGSO1lDEm7j9+sF85BZTcbSww1I
 npOHPnPLLGhbszCla2bhO4pXrl2VDnBdC2LJQgByYtd82gBM/AxdfYVP1V/uwPG2jZ4qvR0CWeJ
 JyS6Ys5wrHMniN7w18xCEwUbiEDHFHeTgygFK73ck1q9rIdiKeNTKka0YIC2By4cL3nDmrfATo3
 qUbV/U4UdkRO0CBjTQ40iQicoYwT8ai59R//e8Ws6qsgR5mJwFguDUu+k1u64SyGLSKxbn03e4w
 /CeLhlAB+yzIXWrs3zVl67aa4QmKqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Add opp-level to indicate PCIe data rates and also define OPP enteries
for each link width and data rate. Append the opp level to name of the
opp node to indicate both frequency and level.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 63 ++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 45713d46f3c52487d2638b7ab194c111f58679ce..c51489b5cd8a5e73797f9a4381bc7588259a8bf5 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2028,38 +2028,51 @@ pcie0_opp_table: opp-table {
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
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
+				};
+
+				/* GEN 2 x1 */
+				opp-5000000-2 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
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
 				};
 
 				/* GEN 3 x2 */
-				opp-16000000 {
+				opp-16000000-3 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
+					opp-level = <3>;
 				};
 			};
 
@@ -2195,45 +2208,67 @@ pcie1_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
 				/* GEN 1 x1 */
-				opp-2500000 {
+				opp-2500000-1 {
 					opp-hz = /bits/ 64 <2500000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <250000 1>;
+					opp-level = <1>;
+				};
+
+				/* GEN 1 x2 */
+				opp-5000000-1 {
+					opp-hz = /bits/ 64 <5000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+					opp-peak-kBps = <500000 1>;
+					opp-level = <1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
-				opp-5000000 {
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


