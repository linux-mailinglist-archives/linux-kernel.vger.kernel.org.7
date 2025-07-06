Return-Path: <linux-kernel+bounces-711792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D17FAEFF8E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 18:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C50E7ACF56
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28EC27B4E0;
	Tue,  1 Jul 2025 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KQ8PAisH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF427E7FC
	for <linux-kernel@vger.kernel.org>; Tue,  1 Jul 2025 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386883; cv=none; b=YBzrD/9nJxJzeDrXLmgdxII6NVD+Nn4Ym+A9RQy41RpMzhorV3nPp2xdTl73z6UNd/ZfKKjU+ZIp7PDsK3iWNt6Cx6nHROJU3xzuzm54BsHFHlv78XmNRT6jbICCa2KZ8iPS8V5Rp0nzon1RHcZC1Xwu2Bs+NiGPx0wB7xhsfLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386883; c=relaxed/simple;
	bh=iXh1qfjmRxzFSEp5Qe43klnLYUlFeXvUPZ+Uu96OpqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HCIGmzI0wwAVSbOCbW1mrJI0g6qHUvpFzYUFcXJkxOB4FT87+CNUOjNrEXZq7nse0E9FY+zJ98HWAac5DErXgSB9Tr+S2vDE1ffr0XU6tCg6VWLEXwKAAwu3IEM4Ty1IQHwHtEht7j5RdK6TgcG2wwk6aToWbInVuFp0heMeja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KQ8PAisH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561AkV1q024877
	for <linux-kernel@vger.kernel.org>; Tue, 1 Jul 2025 16:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ECxHJdh089e4eirAYjIbtiZqI6yOfBriOuAruldttXw=; b=KQ8PAisH45UI77lp
	RbssAwdt+58kpI+c80gw3XOddJyGrj9mFP2O8phh5d7/G4+eeOcpMQo8O4ugscxK
	AdxXTRzyqUQYGNOE+eFDsLCU8EKc6CpsqLSR5V8e2GediDblNu50FJsbLm+fH7IP
	9/Nj2ikuOSxvj/m9fp1yrdifVZWRm9ZptDYLwQI1cvND8pM2ffNzdnYo3XjxR0+b
	gm6Eb4OmQuwAXSNkic6f3UjWep/5TPKPvrNW+7LYeXO1J1zRLLEGlv3H2K3/AkS+
	+2ngknjmXTXGVRniaxuhf4QkqsCeNJ39+XQOUMpcuv7b3dDRsb1au11JcABVpmbM
	qLu0cA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8021fds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 16:21:19 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2fdba7f818so4200946a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jul 2025 09:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751386878; x=1751991678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECxHJdh089e4eirAYjIbtiZqI6yOfBriOuAruldttXw=;
        b=sWl+5TJV7gbzFoRe0Ws8XT7oDw8rHetWOo9W8NSWynQWBkanrClTMPH9VN7voSHoiO
         c1/crBbFizl3Xx7VYZmaEUOSNPZlVciJO0Gwa2CYo6lwAEQcUuRXBA6rgf6AmtHYXA12
         +dvsOkM5aXEvoYUn6wCUeAqVta0x6EJ8m4vh8X2koa4GkuFjh202DFTjmjMPVHpJw07u
         xbqnbYriYd8GfZ4/kDB5GffogZbH8jdUL/SBBh/M2JVKNWUD7A94F3GlKFGxkPz0ALTZ
         fWbZqbjHE+ktTNxqa6F+Uw/v5iBbo5Pq9R+4F94yeIOOSE3n4wRWtLVpOw/xnxVzwi31
         7piQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSqUYjuIBqhK2EG8dmLBeQmMIvGhWF3dXM/iMVxYZUCb2hjUa9pjqwttw2nqNPEdgML2iob55ApAXlHoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9z3F2MJvzq+TOdSFxrKxt/NbLXFMrI3Q8KC/xNrdLgDtRLsAN
	IH9FgsO6mgdttMPEp0eT21KRbFWedeTecDoufagvYxbTGTu3jbqYXdTkLgT1jYDbz5qw9psFfz/
	/10bWLxXdBr3Wi3sEWrVvVvL8w0PtDEQVXzq5xAZUg6fct0yc7gc7FvxsrzM6t2bpq2k=
X-Gm-Gg: ASbGncspoUucSoQWkW5KV0OSZvEWPX6UjkJe/PapaK5lVOrOOMU1kq4Tf4/p+UXivXc
	Sltw5FBbkv/X1oGMbRQBohkKQVl26gDjwecdGzZg8glpI81HWUkc1i8tY/iaJn+j3uGaRMIkaXM
	U0mmvtcxDxUbd6oxIXr9VHkbFRrWWwE/yAuIBdzxdepIe39bXwc5iZxbwUyu7DzgFo3q4AF7pAQ
	rAFBMonj2sFwFXl2HzUPYuNjlIP0FZjyBi6MHEcbz/3MsYooA+DD3+xSpq37IyhmJfLbhSXP+a1
	c4zGTQ0H95ejbUsCA6Ut3W0lxC3JOUX/Gsue/K2oii1IDaw=
X-Received: by 2002:a05:6a20:3d92:b0:215:ead1:b867 with SMTP id adf61e73a8af0-220a127df83mr30988021637.14.1751386878003;
        Tue, 01 Jul 2025 09:21:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGikc5hlYAw77wNpsHSmV1xvhSCkmessjBjU4c3k6bkM5aZC4AkaSqdgr7kwRC4ZvzWgHmXUg==
X-Received: by 2002:a05:6a20:3d92:b0:215:ead1:b867 with SMTP id adf61e73a8af0-220a127df83mr30987961637.14.1751386877516;
        Tue, 01 Jul 2025 09:21:17 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5805265sm12573010b3a.168.2025.07.01.09.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 09:21:17 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 01 Jul 2025 21:50:46 +0530
Subject: [PATCH v2 3/3] arm64: dts: qcom: x1e80100: Update GPU OPP table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-x1e-speedbin-b4-v2-3-a8a7e06d39fb@oss.qualcomm.com>
References: <20250701-x1e-speedbin-b4-v2-0-a8a7e06d39fb@oss.qualcomm.com>
In-Reply-To: <20250701-x1e-speedbin-b4-v2-0-a8a7e06d39fb@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751386855; l=5522;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=iXh1qfjmRxzFSEp5Qe43klnLYUlFeXvUPZ+Uu96OpqY=;
 b=Hzh38TN2ttV1DlAByOF1pUVt5sRr71VhCRAno+AkCnms4Y+O9p6yTAiU8WkntITjn1FmwhNCi
 qoxaXTAsCEvDEl0z9YyGuUfVzc5XWsv/5Ph7Gyo+WjTHBffxxaykJND
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 7u5amBNTTPFwIUJjOcdEFtIjNLyyXgmD
X-Authority-Analysis: v=2.4 cv=YPWfyQGx c=1 sm=1 tr=0 ts=68640aff cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=y21bc7L5uEJNErKunEYA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 7u5amBNTTPFwIUJjOcdEFtIjNLyyXgmD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDExMCBTYWx0ZWRfX3M1ayS9K+H8O
 6Ca/78BYUSGyoFazmQTMwwVEePXnXz2fisNSFA6lzpZfc1/VlKiAIOpcA4Ne4MI+FkYpsgGZLZM
 4hiLmB+4Sl2VgJFmCcsFy811N3C8fjNrIFyRzRLSE2RevRtXi2kybaNhZ2h0xJvogjY7g13DCH2
 eVCmbo6A1EG6VMf8L0AougS7V2ojY0XfjvwPi6PEKUgkcWW+zz0dmJzLFkzNQZTUQNjaustZQvC
 AQw8gCqoI7U5aLqh+K6Rt14K9+AGO70k+FrYWOiR/reKZ6NbBd+G4+k2k35WJBQM0rkZ7ldOfmJ
 InQ35nsc4LiSrWG8ibTjQRXmRoMXRC6BEg/zi58jRfsc9hg2i1qummbkYB0PEIYUzvwaiNQP9sA
 uGGtfWOmmkigxAn0EUCmlBPPESSm57NStKsb//xJ2wl57E6ByU7yP2jPxyuOEOKDzQEeDzXq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=903 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507010110

Update the GPU OPP table with new opp levels along with the
speedbin configurations.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 57 ++++++++++++++++++++++++++++++++--
 arch/arm64/boot/dts/qcom/x1p42100.dtsi |  1 +
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 558d7d387d7710770244fcc901f461384dd9b0d4..ae3a84e95bbbb282edcd8e42a860618ca9873b27 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3773,6 +3773,9 @@ gpu: gpu@3d00000 {
 			qcom,gmu = <&gmu>;
 			#cooling-cells = <2>;
 
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
+
 			interconnects = <&gem_noc MASTER_GFX3D 0 &mc_virt SLAVE_EBI1 0>;
 			interconnect-names = "gfx-mem";
 
@@ -3785,11 +3788,28 @@ gpu_zap_shader: zap-shader {
 			gpu_opp_table: opp-table {
 				compatible = "operating-points-v2-adreno", "operating-points-v2";
 
+				opp-1500000000 {
+					opp-hz = /bits/ 64 <1500000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L5>;
+					opp-peak-kBps = <16500000>;
+					qcom,opp-acd-level = <0xa82a5ffd>;
+					opp-supported-hw = <0x03>;
+				};
+
+				opp-1375000000 {
+					opp-hz = /bits/ 64 <1375000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L4>;
+					opp-peak-kBps = <16500000>;
+					qcom,opp-acd-level = <0xa82a5ffd>;
+					opp-supported-hw = <0x03>;
+				};
+
 				opp-1250000000 {
 					opp-hz = /bits/ 64 <1250000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L3>;
 					opp-peak-kBps = <16500000>;
 					qcom,opp-acd-level = <0xa82a5ffd>;
+					opp-supported-hw = <0x07>;
 				};
 
 				opp-1175000000 {
@@ -3797,13 +3817,24 @@ opp-1175000000 {
 					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L2>;
 					opp-peak-kBps = <14398438>;
 					qcom,opp-acd-level = <0xa82a5ffd>;
+					opp-supported-hw = <0x07>;
 				};
 
-				opp-1100000000 {
+				opp-1100000000-0 {
 					opp-hz = /bits/ 64 <1100000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
 					opp-peak-kBps = <14398438>;
 					qcom,opp-acd-level = <0xa82a5ffd>;
+					opp-supported-hw = <0x07>;
+				};
+
+				/* Only applicable for SKUs which has 1100Mhz as Fmax */
+				opp-1100000000-1 {
+					opp-hz = /bits/ 64 <1100000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					opp-peak-kBps = <16500000>;
+					qcom,opp-acd-level = <0xa82a5ffd>;
+					opp-supported-hw = <0x08>;
 				};
 
 				opp-1000000000 {
@@ -3811,6 +3842,7 @@ opp-1000000000 {
 					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
 					opp-peak-kBps = <14398438>;
 					qcom,opp-acd-level = <0xa82b5ffd>;
+					opp-supported-hw = <0x0f>;
 				};
 
 				opp-925000000 {
@@ -3818,6 +3850,7 @@ opp-925000000 {
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM_L1>;
 					opp-peak-kBps = <14398438>;
 					qcom,opp-acd-level = <0xa82b5ffd>;
+					opp-supported-hw = <0x0f>;
 				};
 
 				opp-800000000 {
@@ -3825,6 +3858,7 @@ opp-800000000 {
 					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
 					opp-peak-kBps = <12449219>;
 					qcom,opp-acd-level = <0xa82c5ffd>;
+					opp-supported-hw = <0x0f>;
 				};
 
 				opp-744000000 {
@@ -3832,13 +3866,24 @@ opp-744000000 {
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L2>;
 					opp-peak-kBps = <10687500>;
 					qcom,opp-acd-level = <0x882e5ffd>;
+					opp-supported-hw = <0x0f>;
 				};
 
-				opp-687000000 {
+				opp-687000000-0 {
 					opp-hz = /bits/ 64 <687000000>;
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
 					opp-peak-kBps = <8171875>;
 					qcom,opp-acd-level = <0x882e5ffd>;
+					opp-supported-hw = <0x0f>;
+				};
+
+				/* Only applicable for SKUs which has 687Mhz as Fmax */
+				opp-687000000-1 {
+					opp-hz = /bits/ 64 <687000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <16500000>;
+					qcom,opp-acd-level = <0x882e5ffd>;
+					opp-supported-hw = <0x10>;
 				};
 
 				opp-550000000 {
@@ -3846,6 +3891,7 @@ opp-550000000 {
 					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
 					opp-peak-kBps = <6074219>;
 					qcom,opp-acd-level = <0xc0285ffd>;
+					opp-supported-hw = <0x1f>;
 				};
 
 				opp-390000000 {
@@ -3853,6 +3899,7 @@ opp-390000000 {
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS>;
 					opp-peak-kBps = <3000000>;
 					qcom,opp-acd-level = <0xc0285ffd>;
+					opp-supported-hw = <0x1f>;
 				};
 
 				opp-300000000 {
@@ -3860,6 +3907,7 @@ opp-300000000 {
 					opp-level = <RPMH_REGULATOR_LEVEL_LOW_SVS_D1>;
 					opp-peak-kBps = <2136719>;
 					qcom,opp-acd-level = <0xc02b5ffd>;
+					opp-supported-hw = <0x1f>;
 				};
 			};
 		};
@@ -8250,6 +8298,11 @@ qfprom: efuse@221c8000 {
 			reg = <0 0x221c8000 0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			gpu_speed_bin: gpu-speed-bin@119 {
+				reg = <0x119 0x2>;
+				bits = <7 8>;
+			};
 		};
 
 		pmu@24091000 {
diff --git a/arch/arm64/boot/dts/qcom/x1p42100.dtsi b/arch/arm64/boot/dts/qcom/x1p42100.dtsi
index 090659b8bb8942cdcc46f8d4a3e7dbcc043a0f78..c64727e3c00db1e4f8f34da2701061255caa620d 100644
--- a/arch/arm64/boot/dts/qcom/x1p42100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1p42100.dtsi
@@ -18,6 +18,7 @@
 /delete-node/ &cpu_pd10;
 /delete-node/ &cpu_pd11;
 /delete-node/ &gpu_opp_table;
+/delete-node/ &gpu_speed_bin;
 /delete-node/ &pcie3_phy;
 
 &gcc {

-- 
2.48.1


