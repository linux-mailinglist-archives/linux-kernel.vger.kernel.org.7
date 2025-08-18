Return-Path: <linux-kernel+bounces-773150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9248B29BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC027A5268
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9662E3019D0;
	Mon, 18 Aug 2025 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IjYZ7N7v"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023823019A6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505402; cv=none; b=swB+bkfukXwM1cg8Nr5l8czk0ylPziz5wRVVZGlxiTc5NZNfVqWgPSgupH6nEbsWrDh+ZgYV2vrbVMA6LginBJNKpfm6M/5Gn+7+iunkRqXylo7hCM+QLRhD4MqOw5HHt2mHKG8+B4J8fvyX2ZiPnUOo/uFTzkZg2qml2QKrf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505402; c=relaxed/simple;
	bh=/X43xNieWg9p6xglDxCtvVV/02zea64o7yV7vb+s+f0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWnkIH5A9hRjpXginaSOHf6Cdej2uUXuNsLx6vqkTZvS+VPOYIVpnYiapjbAD6aA80f09oARSSLblD7v1EU0Fziko0kMgq89ki3yF7qzpomFPiahRpIvWcLo3q8wBjAhSqbEIo3ohsVsSKd1m5V+zvvbjz35j3Mnse+GhNoeCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IjYZ7N7v; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HM9AWu012131
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MjaZn4/0sl0sfWCsd1j/C7M8oP9Y3C9g5KguV1fncJ4=; b=IjYZ7N7vjZEAUgs1
	+XdfvbrDL1BuPxpWDVrkcNSGqh4g3/9HeyJXKKNqfvL2EejwYXiVd8uckDJ9yZeS
	WAnJMoy7dBAAv4qwh4+KDCPlX/9f59olE3Fij2/g3hFxtu6pK9GhIygtx+VdKcIZ
	9uhmjZG9ojQvFzLQ6X0+jmjHID9MqV/N9k2fAvTbfSzaRD9Kycz9DJuZAsd7UtLo
	+xhOYrD3XTPZKN3MIFJg9ijXw8g2DYYCvHgavY3ILuP9T2+3uEVbaRfE9fWCdPR2
	CbcNu8k/5oN9LBsq4PalGLCqN2t+pWCCzzhQ9PDVf7SbH1207ls8twK/CMSyEDA5
	Ji4z/Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjc7uwh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 08:23:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-244582bc5e4so45882965ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 01:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505398; x=1756110198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjaZn4/0sl0sfWCsd1j/C7M8oP9Y3C9g5KguV1fncJ4=;
        b=imaVHJcH71qrs6pEDnkfnin6VJbc9psrbwI/k9o81ZsTtR+JntFHC7eLUP/S4QNIxS
         D4VBlMDXcdR/PVdSYgw1AlYBIBmWdEUFrVAL5Ilrkb9rnWU1Lx5+RPlNRsq4pfXPP807
         1eNLktI4v2qCfQoDKiAqGsmvFs4n+eBpu0fJ4AkcLsGHn3vIp3Fqb+1xhoRnZtYIU/UG
         ym7MR+hWH3Z1E55TUv5i61ZYs1OnJ9eVRfQYL7nSgYZ3OzrckoTwLMtcZzEZdJtwvM8o
         o2mNDeLL2mHR1sDvDVMkCddb8pYBT1d0CbtLUUVf1NQ3CsVQr/FUM8Qh6USLgAXZIFIR
         Xt4w==
X-Forwarded-Encrypted: i=1; AJvYcCX55sVy6JDEqQo9u3wKiE/bolEAkH8pQiq7gwC1zhW79ZMMciM39UP5lZeIMxDajYbunqEm5q0l6WETBmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvafB7cN50RpvNEV9rpVUlDTbG4hstlpxclyRVY82vZLFaSKxK
	/z17V9KsMUprvi0StOFXHwaK8MI9a7MoFAusmQa15yd6Ua9Tmx644pPQrxBH0ZHbmZhreNCkqCS
	W1MGcHl6l1FJM+KDSlp11ZrvjpUJaoc0BVuqKmKjymdq0aq+DwVaiB5TLF/a4egtrkijhF0wAIw
	8=
X-Gm-Gg: ASbGncu8Ff6B69ozNGL6AIfL6QLA54Tmtf18+eAel7Pp2XZts24MNtVipO6FRrDfiXE
	rj72uGSN0eImO58CKgj5knX29y+73Ts3Vdz+cfUy1Q7lD0MiqecR04FmEXHiP16N4VHCqyihvWL
	qiUvef5gkf8V4oDUpADthc4UEk4nNJkX0eO2hUlqIeqEgdur6ORsEUAyz/ojhiVAi6OCus5WGzo
	dMhYB7ZE5uFb0II+9qYB1U5w/zF5GhYw6uZqObtFmwBaOmxGgYGDdSYe2LQQ4YaYB4uEe5kxryk
	hzvmyoka2pN1Hwpf14GgwpJMoSIy5p58XL02d5S0n4y+IaujgU32I0731Un7ePz2XNWcd1GvaQM
	=
X-Received: by 2002:a17:902:f552:b0:243:b39:285f with SMTP id d9443c01a7336-24478e3f3c0mr115899275ad.13.1755505398492;
        Mon, 18 Aug 2025 01:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjM9999RIy2fJin1SHXvFdklmTkclCch5/YsnRm8ExcVp78juvsGQ9GjFRyzBF8Qyf9n8ySQ==
X-Received: by 2002:a17:902:f552:b0:243:b39:285f with SMTP id d9443c01a7336-24478e3f3c0mr115898965ad.13.1755505398040;
        Mon, 18 Aug 2025 01:23:18 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5536c3sm73225155ad.137.2025.08.18.01.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:23:17 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 13:52:54 +0530
Subject: [PATCH v2 2/3] arm64: dts: qcom: sm8450: Add opp-level to indicate
 PCIe data rates
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-opp_pcie-v2-2-071524d98967@oss.qualcomm.com>
References: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
In-Reply-To: <20250818-opp_pcie-v2-0-071524d98967@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755505382; l=3105;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=/X43xNieWg9p6xglDxCtvVV/02zea64o7yV7vb+s+f0=;
 b=PNegfLcDn+vRgoOvgCOON5K7THth5AJ+iM7ASzt/+qoDm+LVJ/pBIFpxEapuXEegUpZg2vUVm
 53Fhsi90TCtBvoi62bR06F8U/1Y/d71u5pTsnQG8KQ7AlZ8br6qB+Io
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX/9vvsKSUctT5
 E+OrGGl5s+hboxZTms6ME7+PmFMdBVNQ4Z33UbiqvshcwXwIZnXlN6V8uDi7myIuC5xmytGtjxq
 f36KsGvb+gJDp64tj7ijrlpvOFK8ADpkDUynQXPdMDZaPhX4KmSrFMR0ZLbHut2DPK+PCOtvQBQ
 U+Y2ozAEwZ6Mcd62KXwv7SUpk9CrPJJRXEcEDgHQLxbvbLb1t074OHAnR2jlU0LNZy3EEHd56Z0
 6LEwOy1RBjiP7pUz6B1ZhUSwSoH4jMhO/BXH1+TmcwicXzZzNxt2zeAKFnGQU1/oV8TY+k50kLq
 sw7AzDv+0IZPIysp1pn0+HMDo0UE3Hhhqu6M6D3e6S3WznCGnKK6pOCrSBcvhPc4oHZ6hm9ZnXB
 RgM48ixr
X-Authority-Analysis: v=2.4 cv=c4mrQQ9l c=1 sm=1 tr=0 ts=68a2e2f7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=bvY3E1ByFFb03tV5gjAA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: 6gsVGZs2yJ6XH4kea-y1LPTRVRWvN5c3
X-Proofpoint-ORIG-GUID: 6gsVGZs2yJ6XH4kea-y1LPTRVRWvN5c3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160033

Add opp-level to indicate PCIe data rates and also define OPP enteries
for each link width and data rate.

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


