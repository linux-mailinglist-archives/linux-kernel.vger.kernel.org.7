Return-Path: <linux-kernel+bounces-727408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0860DB019BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC7D27A7471
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C03288524;
	Fri, 11 Jul 2025 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZGEOgZ6p"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474DB284B5F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229571; cv=none; b=oQmjoywe99C34tS0MfpKBE4mLJpeb+srN0PgabA1TDYL1bq7r196ojg+OV2KGoS+T7sNPM9FqPauVnWttZcTTclMV6cjn9UA1Fe67m95zcjFGH+SM4fhxUkfJXl2xWQxEd1PRl8XUoy1kIqzplat8/BiGY0tq/PlfIA9xrS/H0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229571; c=relaxed/simple;
	bh=+SidfXCtxcuv3rbxX82jTyg+sTVUFkKJQD1qs/h+H5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QPqpQAQ8X2K3gSRmcZAsE9E2ZD7ILq2XCjlhG3WUi4c5xLPdtnwhrNuauJ5Y64KRMikBndf4MiLtSd+dN/rUVwYFav863Rgy6Sy/YvsSYn5t22sdbmZKnylx7h5s+XntrvuI1uODTYae64PegYOmoqAgh5LhGZjZ5HVOFrXNbIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZGEOgZ6p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1X6j7016277
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JY1eENzJ9CN
	UOF8nGSxTlYX4EawIkdpuIjS76hAatz8=; b=ZGEOgZ6pp+7u1yfsSJHWazGjx6L
	IAjfEUtdPkIzMqtC9JnlH9b9s5J/s1G3NlIgWkp4oIeG0lynJ6/3HeP84P6GXGeZ
	kre3UhQkptIyoNoIOWcrOcy5ZBmntGnNyl44DUsnp9W5t8TxNUFRWiFiVZ8uxbAY
	JjRJquQIGUxuAy9bwr8a12qXOCyFTXEaR30QDaTclq6b6HWNCbDNOJWgmtFes7F0
	VVcft0I4odSEyJTCBBpoPvvcFS5XV0Z9/NkI8DlJTH810ES3QYmQUhYqLU09B+OS
	34fhSh8QsQvzM/eh+udb+L+TLqTMTi1GdRoYOzs7LYTRDZOik4T/Fc7eJJQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47t83u4j43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:26:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-234fedd3e51so19406385ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752229568; x=1752834368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JY1eENzJ9CNUOF8nGSxTlYX4EawIkdpuIjS76hAatz8=;
        b=eYzsNUBK5Itpv02Brf6AaOgfsam0Ubf7achFIUFpq6cKA8QbXm25edB7YisN+Qc9GH
         DwUfBrAc3KkOeaRrYUqau0nSAt3Q6BAEXfxWsz1w8JOCRwo8pSxI1WMDD171MsGw3yH1
         sbF5GaXC3cDsGqRN2L8BLzvYNTp8H1T1kyujE8+tyzbJihQS/QyU1vDdIM3jtzK1iAH2
         mf8nQE1H25faLOW2gKUuX8U2bPU6Nj8pwja84SWaOXFNb+FxxLGQFY1z3lcNNInoWEK6
         oGT2F/seOinx6I95OL+PgaHm3YlRby0CyYDm5SSvWPLo4g0J9SP2qVoudkKMjvFytwIG
         yigg==
X-Forwarded-Encrypted: i=1; AJvYcCWY5VhJEHjmcpcw97lqO3Re9SkAwLef6Bx22iSxWaY5JIQEOXweV0f8sKprCvvDk7NWyezzXlJk/o/Sc7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHe+rBsZYG4MOVX2WWQMmk7FVvaggCQ1WabS2VaQx8YSzHLgw
	jDOItCNzabsu3oqsn868KLz6eTVDZHkiBZdNvm9rdKG2NBQjXtQIcC7DULMFr0Yscf94tGZSzuk
	ONkZHEupn48Bc6sbJu4PsD7uZrla5ptspqTUfmDDZqAz9H4ZpvDWuxzjgvjTsZ910v/k=
X-Gm-Gg: ASbGncs8Qouai5PoGKIuylJfbPU541cYn3aNpenFYaJ1zkny8KhlXh5YuIinnZovTUO
	WNVFwlHQ7U6RUicB6DxVWYfmmso2WyD0R1GFsGH3C6f65QSzV1pPp7GvQDuNSC6z8AaSHPdlMSi
	dy6myDeDoV1Xa4tDKNxZy8Vb4fMVgM+wOjrOKFR/V8bwsc/MnSJYp3nSLZxyI6fL5A46eGgpgX8
	on4Hso+GYCOs15P/h0H644bJSqY/WJT4ILlfYj03HnuZG9WAO0YjTYvSHls2FwQpMCThbek4ZEy
	MPRR8+vM0u/RIPi4EaDHLZ48euWUzC5t/YMrO3dSuVBmEZdk9VEpsJse/TCNNCW84+4qlJjd8Hc
	SSeo=
X-Received: by 2002:a17:903:17ce:b0:235:c9a7:d5fb with SMTP id d9443c01a7336-23dede468b9mr45540885ad.16.1752229568154;
        Fri, 11 Jul 2025 03:26:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmI00xrUh99K4pgQvetVoxMNX9SAHA68gstkYI9J2o3S/QZh7Nsy9BahOdnTQSE8IWKtLR9g==
X-Received: by 2002:a17:903:17ce:b0:235:c9a7:d5fb with SMTP id d9443c01a7336-23dede468b9mr45540395ad.16.1752229567661;
        Fri, 11 Jul 2025 03:26:07 -0700 (PDT)
Received: from a10065738a1d.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de436839bsm42861375ad.253.2025.07.11.03.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 03:26:07 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mdtipton@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH V2 3/3] arm64: dts: qcom: qcs8300: Add CPU OPP tables to scale DDR/L3
Date: Fri, 11 Jul 2025 10:25:40 +0000
Message-ID: <20250711102540.143-4-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711102540.143-1-raviteja.laggyshetty@oss.qualcomm.com>
References: <20250711102540.143-1-raviteja.laggyshetty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 85-vIPD0kd2l2g6mFNGGlwauw0yVOXyZ
X-Authority-Analysis: v=2.4 cv=OotPyz/t c=1 sm=1 tr=0 ts=6870e6c1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=PerH0Zu0CQqllubMy4oA:9
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MyBTYWx0ZWRfX7NZpZVOJafzQ
 qz7bOD3u0RQgf/5q+jcGINvDqzt9CuOOqphxzoM8uJDXGi0lmTzZ7SjUDBdNd6BQDs3dHMppJsc
 fsrjSAN3+WAhpF1YGYl5ercxft4aRjv81+NDn2ePFzbNatkr4KDSUeaS6VsWeQaI6YkzeNd6id7
 NYyjYFCl6077pGSQRjrzRNMg9chR5W8mmf6vtpG8r0ErqwxGPEeWywTKYl21CMM2P+QLaDHDpgT
 bjpvtTpifvQLHCkDv4oNkEJFFzQxZzf1BygmxI8iSZDLJXRsaLdDbAGaeezO1cKbU4S0THmUADu
 sqxkJcq4kmdHrpy5ERipYOVkKotGPK8BMzkLkhrzxj1FJaR8ESwH6LxOgAl0BYkW/gZxw/vGSYC
 sGEnCDDyKHWU/gbfI8buLe2eYsGnHLvj5UgTgMQpWSVFtpo2ZMkXeuJhCD42hvsJKXDC7tBw
X-Proofpoint-GUID: 85-vIPD0kd2l2g6mFNGGlwauw0yVOXyZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110073

From: Imran Shaik <quic_imrashai@quicinc.com>

Add OPP tables required to scale DDR and L3 per freq-domain on QCS8300
platform.

Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs8300.dtsi | 282 ++++++++++++++++++++++++++
 1 file changed, 282 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
index d6a58e228091..7d38ddd2cc9e 100644
--- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
@@ -54,6 +54,11 @@ cpu0: cpu@0 {
 			capacity-dmips-mhz = <1946>;
 			dynamic-power-coefficient = <472>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl0 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl0 SLAVE_EPSS_L3_SHARED>;
 
 			l2_0: l2-cache {
 				compatible = "cache";
@@ -74,6 +79,11 @@ cpu1: cpu@100 {
 			capacity-dmips-mhz = <1946>;
 			dynamic-power-coefficient = <472>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl0 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl0 SLAVE_EPSS_L3_SHARED>;
 
 			l2_1: l2-cache {
 				compatible = "cache";
@@ -94,6 +104,11 @@ cpu2: cpu@200 {
 			capacity-dmips-mhz = <1946>;
 			dynamic-power-coefficient = <507>;
 			qcom,freq-domain = <&cpufreq_hw 2>;
+			operating-points-v2 = <&cpu2_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl0 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl0 SLAVE_EPSS_L3_SHARED>;
 
 			l2_2: l2-cache {
 				compatible = "cache";
@@ -114,6 +129,11 @@ cpu3: cpu@300 {
 			capacity-dmips-mhz = <1946>;
 			dynamic-power-coefficient = <507>;
 			qcom,freq-domain = <&cpufreq_hw 2>;
+			operating-points-v2 = <&cpu2_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl0 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl0 SLAVE_EPSS_L3_SHARED>;
 
 			l2_3: l2-cache {
 				compatible = "cache";
@@ -134,6 +154,11 @@ cpu4: cpu@10000 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl1 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl1 SLAVE_EPSS_L3_SHARED>;
 
 			l2_4: l2-cache {
 				compatible = "cache";
@@ -154,6 +179,11 @@ cpu5: cpu@10100 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl1 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl1 SLAVE_EPSS_L3_SHARED>;
 
 			l2_5: l2-cache {
 				compatible = "cache";
@@ -174,6 +204,11 @@ cpu6: cpu@10200 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl1 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl1 SLAVE_EPSS_L3_SHARED>;
 
 			l2_6: l2-cache {
 				compatible = "cache";
@@ -194,6 +229,11 @@ cpu7: cpu@10300 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			operating-points-v2 = <&cpu4_opp_table>;
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&epss_l3_cl1 MASTER_EPSS_L3_APPS
+					 &epss_l3_cl1 SLAVE_EPSS_L3_SHARED>;
 
 			l2_7: l2-cache {
 				compatible = "cache";
@@ -324,6 +364,248 @@ system_sleep: domain-sleep {
 		};
 	};
 
+	cpu0_opp_table: opp-table-cpu0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-902400000 {
+			opp-hz = /bits/ 64 <902400000>;
+			opp-peak-kBps = <(681600 * 4) (921600 * 32)>;
+		};
+
+		opp-1017600000 {
+			opp-hz = /bits/ 64 <1017600000>;
+			opp-peak-kBps = <(1017600 * 4) (921600 * 32)>;
+		};
+
+		opp-1190400000 {
+			opp-hz = /bits/ 64 <1190400000>;
+			opp-peak-kBps = <(1708800 * 4) (921600 * 32)>;
+		};
+
+		opp-1267200000 {
+			opp-hz = /bits/ 64 <1267200000>;
+			opp-peak-kBps = <(2092800 * 4) (998400 * 32)>;
+		};
+
+		opp-1344000000 {
+			opp-hz = /bits/ 64 <1344000000>;
+			opp-peak-kBps = <(2092800 * 4) (1075200 * 32)>;
+		};
+
+		opp-1420800000 {
+			opp-hz = /bits/ 64 <1420800000>;
+			opp-peak-kBps = <(2092800 * 4) (1152000 * 32)>;
+		};
+
+		opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <(2092800 * 4) (1228800 * 32)>;
+		};
+
+		opp-1574400000 {
+			opp-hz = /bits/ 64 <1574400000>;
+			opp-peak-kBps = <(2736000 * 4) (1324800 * 32)>;
+		};
+
+		opp-1670400000 {
+			opp-hz = /bits/ 64 <1670400000>;
+			opp-peak-kBps = <(2736000 * 4) (1401600 * 32)>;
+		};
+
+		opp-1747200000 {
+			opp-hz = /bits/ 64 <1747200000>;
+			opp-peak-kBps = <(2736000 * 4) (1401600 * 32)>;
+		};
+
+		opp-1824000000 {
+			opp-hz = /bits/ 64 <1824000000>;
+			opp-peak-kBps = <(2736000 * 4) (1478400 * 32)>;
+		};
+
+		opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			opp-peak-kBps = <(2736000 * 4) (1478400 * 32)>;
+		};
+
+		opp-1977600000 {
+			opp-hz = /bits/ 64 <1977600000>;
+			opp-peak-kBps = <(3196800 * 4) (1555200 * 32)>;
+		};
+
+		opp-2054400000 {
+			opp-hz = /bits/ 64 <2054400000>;
+			opp-peak-kBps = <(3196800 * 4) (1555200 * 32)>;
+		};
+
+		opp-2112000000 {
+			opp-hz = /bits/ 64 <2112000000>;
+			opp-peak-kBps = <(3196800 * 4) (1612800 * 32)>;
+		};
+
+	};
+
+	cpu2_opp_table: opp-table-cpu2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-940800000 {
+			opp-hz = /bits/ 64 <940800000>;
+			opp-peak-kBps = <(681600 * 4) (921600 * 32)>;
+		};
+
+		opp-1094400000 {
+			opp-hz = /bits/ 64 <1094400000>;
+			opp-peak-kBps = <(1017600 * 4) (921600 * 32)>;
+		};
+
+		opp-1267200000 {
+			opp-hz = /bits/ 64 <1267200000>;
+			opp-peak-kBps = <(1708800 * 4) (921600 * 32)>;
+		};
+
+		opp-1344000000 {
+			opp-hz = /bits/ 64 <1344000000>;
+			opp-peak-kBps = <(2092800 * 4) (998400 * 32)>;
+		};
+
+		opp-1420800000 {
+			opp-hz = /bits/ 64 <1420800000>;
+			opp-peak-kBps = <(2092800 * 4) (998400 * 32)>;
+		};
+
+		opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <(2092800 * 4) (1075200 * 32)>;
+		};
+
+		opp-1574400000 {
+			opp-hz = /bits/ 64 <1574400000>;
+			opp-peak-kBps = <(2092800 * 4) (1152000 * 32)>;
+		};
+
+		opp-1632000000 {
+			opp-hz = /bits/ 64 <1632000000>;
+			opp-peak-kBps = <(2092800 * 4) (1228800 * 32)>;
+		};
+
+		opp-1708800000 {
+			opp-hz = /bits/ 64 <1708800000>;
+			opp-peak-kBps = <(2736000 * 4) (1324800 * 32)>;
+		};
+
+		opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-peak-kBps = <(2736000 * 4) (1324800 * 32)>;
+		};
+
+		opp-1900800000 {
+			opp-hz = /bits/ 64 <1900800000>;
+			opp-peak-kBps = <(2736000 * 4) (1324800 * 32)>;
+		};
+
+		opp-1977600000 {
+			opp-hz = /bits/ 64 <1977600000>;
+			opp-peak-kBps = <(2736000 * 4) (1401600 * 32)>;
+		};
+
+		opp-2054400000 {
+			opp-hz = /bits/ 64 <2054400000>;
+			opp-peak-kBps = <(2736000 * 4) (1478400 * 32)>;
+		};
+
+		opp-2131200000 {
+			opp-hz = /bits/ 64 <2131200000>;
+			opp-peak-kBps = <(3196800 * 4) (1555200 * 32)>;
+		};
+
+		opp-2208000000 {
+			opp-hz = /bits/ 64 <2208000000>;
+			opp-peak-kBps = <(3196800 * 4) (1555200 * 32)>;
+		};
+
+		opp-2284800000 {
+			opp-hz = /bits/ 64 <2284800000>;
+			opp-peak-kBps = <(3196800 * 4) (1612800 * 32)>;
+		};
+
+		opp-2361600000 {
+			opp-hz = /bits/ 64 <2361600000>;
+			opp-peak-kBps = <(3196800 * 4) (1612800 * 32)>;
+		};
+
+	};
+
+	cpu4_opp_table: opp-table-cpu4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-844800000 {
+			opp-hz = /bits/ 64 <844800000>;
+			opp-peak-kBps = <(681600 * 4) (921600 * 32)>;
+		};
+
+		opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			opp-peak-kBps = <(1708800 * 4) (921600 * 32)>;
+		};
+
+		opp-1209600000 {
+			opp-hz = /bits/ 64 <1209600000>;
+			opp-peak-kBps = <(2092800 * 4) (998400 * 32)>;
+		};
+
+		opp-1305600000 {
+			opp-hz = /bits/ 64 <1305600000>;
+			opp-peak-kBps = <(2092800 * 4) (1075200 * 32)>;
+		};
+
+		opp-1382400000 {
+			opp-hz = /bits/ 64 <1382400000>;
+			opp-peak-kBps = <(2092800 * 4) (1152000 * 32)>;
+		};
+
+		opp-1459200000 {
+			opp-hz = /bits/ 64 <1459200000>;
+			opp-peak-kBps = <(2092800 * 4) (1228800 * 32)>;
+		};
+
+		opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <(2736000 * 4) (1324800 * 32)>;
+		};
+
+		opp-1574400000 {
+			opp-hz = /bits/ 64 <1574400000>;
+			opp-peak-kBps = <(2736000 * 4) (1324800 * 32)>;
+		};
+
+		opp-1651200000 {
+			opp-hz = /bits/ 64 <1651200000>;
+			opp-peak-kBps = <(2736000 * 4) (1324800 * 32)>;
+		};
+
+		opp-1728000000 {
+			opp-hz = /bits/ 64 <1728000000>;
+			opp-peak-kBps = <(2736000 * 4) (1401600 * 32)>;
+		};
+
+		opp-1804800000 {
+			opp-hz = /bits/ 64 <1804800000>;
+			opp-peak-kBps = <(2736000 * 4) (1478400 * 32)>;
+		};
+
+		opp-1881600000 {
+			opp-hz = /bits/ 64 <1881600000>;
+			opp-peak-kBps = <(3196800 * 4) (1555200 * 32)>;
+		};
+
+		opp-1958400000 {
+			opp-hz = /bits/ 64 <1958400000>;
+			opp-peak-kBps = <(3196800 * 4) (1612800 * 32)>;
+		};
+	};
+
 	dummy_eud: dummy-sink {
 		compatible = "arm,coresight-dummy-sink";
 
-- 
2.43.0


