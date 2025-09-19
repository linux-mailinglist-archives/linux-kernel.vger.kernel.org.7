Return-Path: <linux-kernel+bounces-824402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6884DB891E9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC27A3AD207
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2BD3081A4;
	Fri, 19 Sep 2025 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lZGA1Zzy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C398D303A31
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278422; cv=none; b=csOhDndzzwOMb1mACTQVtcMjwFqIR69rLfvTr8YVjoRBoyzmJj3Piqn74xaZ00owujSmSNmDWgT4LeFb1omxbfvnEXQCYaFbAHojKOc+DXNorK00bGwx+HOHGbgxYsq2TcLQChd7VG1w42E+kU+dagjZTvbD5lMapmvyNMi+p/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278422; c=relaxed/simple;
	bh=jTpABLSEawOw9mvwoIuCbs4/XDey+tgLtwUcUUnw6U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TL+UytOrFpKQYbDoUAOL6j3SwyLu8X5EB+ejWuY+CHZeDWTq6myKTNB1uNsKr0fmOz1JLPJqJLAmuhiIun9H37Bs1fORI1IjvKt4sBnt0ZFpmNzp6GxalVRigCU1/D3ZCwje66DwalWbYHa2Lzy92B4JHkkABPPlw671lE9Cd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lZGA1Zzy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J85frs027129
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dXfKxZCGajcsFmUbhfW1fP
	TYCliid4RKFmwYUMeNAJU=; b=lZGA1Zzyv85w/Hj9+bbc4JesZ2U9Ke6UAJ+h4z
	hAHR4/D5Qr5xEPbRzvWEqfWFTFrs3S6PX8DEGuSBrYEO/Iri2Y/bjVilsnHm2lO0
	BWJuXhA7R6OEoXAD8RwQFcdK/SwaleuK9EVePaFDvmAdC031/61COka+Y/wXiQqz
	6AtHpBW3TEo19SB/n1eELnWbNMUYnmGnC6KiopIxt4uvM3wJJdnlfVNkuPa7xN9s
	GPn69VaWQlzg40CNk4Br2Zo7byft9ND57crxfmVWX1CWrvTMDsyjiTwqvdzcRRKD
	+2+Cje6yu3nQTVwaLpvCp0JN5/w0AY+ZE8pudrPjXOjKzMRQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497v1jg2gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:40:15 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54c46337c9so2593243a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 03:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758278414; x=1758883214;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dXfKxZCGajcsFmUbhfW1fPTYCliid4RKFmwYUMeNAJU=;
        b=o2MmoDrZyyGVHTQ/uBaxUOvB0KO9xGnm9OfaoZfdkDANl5FZo2QUTgvYndeo4ceuqu
         Cui/OsA+gQL2+w4spzjJEsMfJqThASazZZpW5QRoc7MpKhHxjJ3lneCUdgY0EYHD1NhX
         qdHIhFG0S6y9OiG8Tjrq+N4skF7T9cH+j71wbyeItia1Q56V8nwkmHDoDe3PnQv4ug5z
         C1+657ikZmG6TcgcjTv68PlXwiiSUSCrxDuz5+RhOJpb/01/jzknZpc45D6oNITueGli
         U2PJEPoEp61fLfWBdt3+CoGaAj0woJzyv6ZBgGQ5UWozvWvEtSF+hhXrNltC4jSeaGPV
         ZniA==
X-Forwarded-Encrypted: i=1; AJvYcCVb+RsU7kdWNfBdfx7JgsODf43GSGVUSt6v2yTcn0IdWjV9VoKN7dfOFc/8Lyca0L/YuKvrDYfmhcF3mZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWioh66PMkcQGYkEyLpTHUr0lYa4v5J3ipnPWoJxL9t4c9MCaF
	uASKNrq6/FiEmCwpOCUpnWFJpCJS1NobJE6eqKvxkcizMq7tX/uGAl0l8nj+wbSU5DOLqEVJzBM
	z0ebuAB1FQThfpZ/t+rUwcsPTwUmv+8oNkvKVeCkzXU3D2a6+JLoEo0mn3Q5xVzVdyQ==
X-Gm-Gg: ASbGnctzzSXGQ8NOV7H+zgqhNdRMUAU3VeOQkk74/pnASEEQx4VDUQLVtH9hRh3J0QU
	IhY1QBkd0NOFz1c+pk9vvht4En/DA72P8kFX9lEh3MsFKCGq1YFvwP1yMdVBYACgyDtFBO7Q0fR
	M2avsNQ1DjMm4UhBGjMKx763Axl2DZ7Fh3HxA+PY8ahxsJnFEji6Aplj+XJUhWTJNNbOHgcNS/t
	av05kBFcMcNYpF8XBHE4LpjRQinkcx0Xg4Q8BOLLFJu9EK2ca7qU9FykBZS2dXyARTHMCH3f9Ut
	cOKns7EaLYqW+PueZKHcMaqtzHcAycYE+wZ6zKfWoCW8HWw2XOBAbLg5umL5Jz2sah/omg==
X-Received: by 2002:a17:903:24e:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-269ba46450cmr45873925ad.18.1758278414159;
        Fri, 19 Sep 2025 03:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCTTuWw3CFA0FVOYTgIav8eEeDbH9S7p+c9gr9IeuB21hOZoiQBATfw7jGkBXR8igiNxwIUg==
X-Received: by 2002:a17:903:24e:b0:24c:7bc6:7ac7 with SMTP id d9443c01a7336-269ba46450cmr45873555ad.18.1758278413697;
        Fri, 19 Sep 2025 03:40:13 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df446sm51191745ad.68.2025.09.19.03.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 03:40:13 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 16:09:24 +0530
Subject: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Update regulator
 settings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-b4-rb3gen2-update-regulator-v1-1-1ea9e70d01cb@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANsyzWgC/x3MwQpAQBAA0F/RnE2xSOtX5LDDWFNamkVK/t3m+
 C7vgcgqHKHLHlC+JMoWEso8g3FxwTPKlAymME1hS4tUo1LlORg898kdjMr+XN2xKbbUkBldRXN
 tIQ278iz3v/fD+343FaULbQAAAA==
X-Change-ID: 20250919-b4-rb3gen2-update-regulator-7b5b2ca3bf49
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        tingguo.cheng@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758278409; l=5263;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=jTpABLSEawOw9mvwoIuCbs4/XDey+tgLtwUcUUnw6U8=;
 b=4bp5h2BTOBGk7AVkBG/wo9T3jCaT8Pe8qv8M6TrUEj5qeeB3JHfnKweATGznKiLjl/PwBTZ4t
 /xSlfPXfha0BSuLR+Ywbjbe7hcrSnJoRsxogADV3sphybaMvSEJA2I/
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-ORIG-GUID: uVXic_YAKIgAihmYNCkPhLp4OIJqbJ2p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDExMCBTYWx0ZWRfX5Jo0H/E9oDlR
 mBfb75YAbsixtUCYHRWkDS2t2aDefGy3COmrL99XmNstmvDLBtYszGZStn5f/ji6q1p+jFGWds0
 8nQqhcP03EJc2o70vp3tOu9VCsR2OH9JvEioZ34jVNULKEuiNH1xlWSOmnJ801yRn1GMntiMgz1
 /vkBSixaP20QPL4CoA7DwPUv8b4A8b2c4x1xB3Yyf3I5nF19beK3cV7ogiCnPputeE6DuqZZgOp
 OHfqSONyrVDhJARqk9yjJqLD4xLqW+P8LEOfq46oK3zY8LWRB9uOGKD+02oDVjxBfgWd1ckolzG
 PlYS3pXK6FOls2H1FJm3MZtvJtlJohQjl8upRYJ5TnjAebdTWElhEFBuN92GjNSQ3k03NKa6OY6
 Gbt7KMz3
X-Authority-Analysis: v=2.4 cv=AeqxH2XG c=1 sm=1 tr=0 ts=68cd330f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=xy6SXK4bz0Lwp-duAgIA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: uVXic_YAKIgAihmYNCkPhLp4OIJqbJ2p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170110

Update min/max voltage settings for regulators below to align
with the HW specification
vreg_l3b_0p504
vreg_l6b_1p2
vreg_l11b_1p504
vreg_l14b_1p08
vreg_l16b_1p1
vreg_l17b_1p7
vreg_s1c_2p19
vreg_l8c_1p62
vreg_l9c_2p96
vreg_l12c_1p65.

While at it, remove RPMH regulator rails (listed below) as
these are not to be used on APPS, and any client accidently
voting on it can potentially cause issues.
vreg_s2b_0p876
vreg_s2c_0p752
vreg_s5c_0p752
vreg_s7c_0p752
vreg_s10c_0p752
vreg_l4b_0p752
vreg_l5b_0p752.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 58 +++++-----------------------
 1 file changed, 9 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 18cea8812001421456dc85547c3c711e2c42182a..6355c1e2c58165757a9a20ab4368e93545904693 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -335,8 +335,6 @@ regulators-0 {
 		vdd-s8-supply = <&vph_pwr>;
 		vdd-l1-l4-l12-l15-supply = <&vreg_s7b_0p972>;
 		vdd-l2-l7-supply = <&vreg_bob_3p296>;
-		vdd-l3-supply = <&vreg_s2b_0p876>;
-		vdd-l5-supply = <&vreg_s2b_0p876>;
 		vdd-l6-l9-l10-supply = <&vreg_s8b_1p272>;
 		vdd-l8-supply = <&vreg_s7b_0p972>;
 		vdd-l11-l17-l18-l19-supply = <&vreg_s1b_1p872>;
@@ -349,12 +347,6 @@ vreg_s1b_1p872: smps1 {
 			regulator-max-microvolt = <2040000>;
 		};
 
-		vreg_s2b_0p876: smps2 {
-			regulator-name = "vreg_s2b_0p876";
-			regulator-min-microvolt = <570070>;
-			regulator-max-microvolt = <1050000>;
-		};
-
 		vreg_s7b_0p972: smps7 {
 			regulator-name = "vreg_s7b_0p972";
 			regulator-min-microvolt = <535000>;
@@ -385,27 +377,13 @@ vreg_l2b_3p072: ldo2 {
 		vreg_l3b_0p504: ldo3 {
 			regulator-name = "vreg_l3b_0p504";
 			regulator-min-microvolt = <312000>;
-			regulator-max-microvolt = <910000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		vreg_l4b_0p752: ldo4 {
-			regulator-name = "vreg_l4b_0p752";
-			regulator-min-microvolt = <752000>;
-			regulator-max-microvolt = <820000>;
-			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-		};
-
-		reg_l5b_0p752: ldo5 {
-			regulator-name = "reg_l5b_0p752";
-			regulator-min-microvolt = <552000>;
-			regulator-max-microvolt = <832000>;
+			regulator-max-microvolt = <650000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
 		vreg_l6b_1p2: ldo6 {
 			regulator-name = "vreg_l6b_1p2";
-			regulator-min-microvolt = <1140000>;
+			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1260000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
@@ -436,7 +414,7 @@ vreg_l9b_1p2: ldo9 {
 
 		vreg_l11b_1p504: ldo11 {
 			regulator-name = "vreg_l11b_1p504";
-			regulator-min-microvolt = <1504000>;
+			regulator-min-microvolt = <1776000>;
 			regulator-max-microvolt = <2000000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
@@ -457,7 +435,7 @@ vreg_l13b_0p53: ldo13 {
 
 		vreg_l14b_1p08: ldo14 {
 			regulator-name = "vreg_l14b_1p08";
-			regulator-min-microvolt = <1080000>;
+			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1304000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
@@ -521,26 +499,8 @@ regulators-1 {
 
 		vreg_s1c_2p19: smps1 {
 			regulator-name = "vreg_s1c_2p19";
-			regulator-min-microvolt = <2190000>;
-			regulator-max-microvolt = <2210000>;
-		};
-
-		vreg_s2c_0p752: smps2 {
-			regulator-name = "vreg_s2c_0p752";
-			regulator-min-microvolt = <750000>;
-			regulator-max-microvolt = <800000>;
-		};
-
-		vreg_s5c_0p752: smps5 {
-			regulator-name = "vreg_s5c_0p752";
-			regulator-min-microvolt = <465000>;
-			regulator-max-microvolt = <1050000>;
-		};
-
-		vreg_s7c_0p752: smps7 {
-			regulator-name = "vreg_s7c_0p752";
-			regulator-min-microvolt = <465000>;
-			regulator-max-microvolt = <800000>;
+			regulator-min-microvolt = <2200000>;
+			regulator-max-microvolt = <2208000>;
 		};
 
 		vreg_s9c_1p084: smps9 {
@@ -600,7 +560,7 @@ vreg_l7c_3p0: ldo7 {
 
 		vreg_l8c_1p62: ldo8 {
 			regulator-name = "vreg_l8c_1p62";
-			regulator-min-microvolt = <1620000>;
+			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <2000000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
@@ -608,7 +568,7 @@ vreg_l8c_1p62: ldo8 {
 		vreg_l9c_2p96: ldo9 {
 			regulator-name = "vreg_l9c_2p96";
 			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <35440000>;
+			regulator-max-microvolt = <3544000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
@@ -628,7 +588,7 @@ vreg_l11c_2p8: ldo11 {
 
 		vreg_l12c_1p65: ldo12 {
 			regulator-name = "vreg_l12c_1p65";
-			regulator-min-microvolt = <1650000>;
+			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <2000000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};

---
base-commit: 8f7f8b1b3f4c613dd886f53f768f82816b41eaa3
change-id: 20250919-b4-rb3gen2-update-regulator-7b5b2ca3bf49

Best regards,
-- 
Rakesh Kota <rakesh.kota@oss.qualcomm.com>


