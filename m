Return-Path: <linux-kernel+bounces-798921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54FBB424B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C66587B9F36
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D05321432;
	Wed,  3 Sep 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yu/rHzUM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8113320A2C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912447; cv=none; b=pS4YTSnpiu9L9UwrRffynMOLVzX2SLb+Qo9vRE19wlvNSP3evADJMytt9nachykljvlcuW1m5na/aL6vvGLM4DrFJOn5Jpx1z4oNhvEg++w+krUqYy6SMgHRZDNr1mzJjcizpcLA1DF7JtpPPy2lrs/F/gVabRCCKLl5iHFr1H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912447; c=relaxed/simple;
	bh=apwKk+ikM3l/V1EQQjFWc2jNPkFZenZw1Re+pEBEENs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eOgumGgm2LWAvmrCJ24n2WMIw2+V9Fln8UbAoqCUGFeni4HRZmBtEi7qyF74et5XzJvqwiOsz6mIKANo3xbIJamIWL/egSNmT18uZob1qkRzN+R/SEodcJsn96R56710lz2QNy8nGiW5+5gJeiP3hxj1UzmP9gVjL/yFIOFF7R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yu/rHzUM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583Dwqip005254
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 15:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=VZTZQqgdtSX
	dHRS6Xhizb7R5zVIthwUpM+I82rokNQQ=; b=Yu/rHzUMtnnrgXAPEP0W5+0cUEG
	zIqf3rivDfhLME/e/StUh907hMugCjr2YrrAlzdvSKf5IbT7UIaJ4EyO7tPC0uxe
	fLav7e0a3dpPIgN+MhsaFq+4B/gUwdZereF8+JKCR0I1m/Mj0PbE3VF8D3+v8+iw
	6Gnnxo7VczFMUB+GMYYPfZby8EPa2sSBJUTi3n6wTjnNRMzSw/hgau8ZfKHTSejp
	rPVy+iAkZGOrddNsUtjuQx1wIxXO4JaWBIA5UaJHBG1wyD6GpjAojoH1Ww1onToI
	flRnx7iyk+NnPzVbYH5ZNzncoXr3DfH4syrEM5y1zjPtbCi7O344ahGAI4w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjm39b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 15:14:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-248d9301475so687655ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912443; x=1757517243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZTZQqgdtSXdHRS6Xhizb7R5zVIthwUpM+I82rokNQQ=;
        b=JbqcrhdGrf/p14fVqwHu2u3NjRHedKVo2p7J2D0y/aaU58foz8zj1suul3Jg+VgS4a
         +HvL1K/kscCY6bg/YsXTm/0AngWj7dEYKmPuGmYC/IlxrN6DPW0PgQmhf8fgrfHDuW7s
         moNO7XKhHTw5OLjSW7gxMikXwIhIjX/GNizmD8fJ6YmAzcZkwVcyL6/6f24Jz0/aAISg
         Lho09+eLoWJuNUeDJ0M0tClQND1hd0B9+TpgYYjcgnmS/L6ezNTklV85Ffif5DSajDEq
         bq/rOgY5cDZg4mMcQ8oXnhUqTvHdHJisryomZ0oZjH1JwqUU9pyZQWny1n50dgQa0bvG
         dv5A==
X-Forwarded-Encrypted: i=1; AJvYcCUyQuDKb1CW+xr24hinMx0yiGC/6j4qpr8hAS37FhjPjRihVjPOTfSULYT+bhaS9kdtFsadL736ro+sw9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJElkZwoTHwAgGo5oXtUjxSVBIibTYLUSp1QjHmOMc3y/CHQhZ
	uHOyYzrEk6cVjBn793e6+1tKYywRdTPaggP9Gol9voLD7K/6bf/RV+fDJ0DpRJ2tCja6jeIaLb1
	8Gq53w2qHLOV61YGbldm2YAAXoG+iB6A35Wb7HFXpPiShca89ANi1RXGs+LRL/f0RhYU=
X-Gm-Gg: ASbGncvnrva0kc9t0aAze3JWeW2wrvOWVOxEohjOp392651SXE+F1Mm9MliXv8Hbzps
	tsx6ZtAio9Zspx892PZlytIdx5mXWrlY3U7Hrsxzni5C2Mj9l/H9bLIBEYSjACiftF3ZSmdxmkg
	H3kh7W2BZ1l0rMYotbBzkKihmo+501olXjCRgkSpYxWc3l6tGtAA9Rshdux9+tNv25a0Evl1cER
	+w21Yxxvmbc+EsI935JXUCWe3cx84lW1nJBNkijYqtIPovcCIV20ijt5nYkZQBhH9P3sYGl4eVJ
	g6yME9a3TzMg5As6PPuOl7mDNREHyMYzO3HFVD+p7Bj+N8rkDQB9WCqKcRzioaLll01WSiFJVt7
	g
X-Received: by 2002:a17:903:3d0b:b0:24a:c62a:dede with SMTP id d9443c01a7336-24ac62aea77mr145251135ad.26.1756912442902;
        Wed, 03 Sep 2025 08:14:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVvxveVOhkQWe2XBaZgNd81gr3PM1rlr7IZRl+AQORLEL7olQsqnPY/Lmo+ZFAIsPUQi/Fdw==
X-Received: by 2002:a17:903:3d0b:b0:24a:c62a:dede with SMTP id d9443c01a7336-24ac62aea77mr145250685ad.26.1756912442311;
        Wed, 03 Sep 2025 08:14:02 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903758b89sm164818945ad.59.2025.09.03.08.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:14:02 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v9 2/8] arm64: dts: qcom: qcs6490-audioreach: Add AudioReach support for QCS6490
Date: Wed,  3 Sep 2025 20:43:31 +0530
Message-Id: <20250903151337.1037246-3-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903151337.1037246-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250903151337.1037246-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b85b3c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=RwPLVlW_fRfmQ7ZdlRkA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 8sdOAG0ky-mobwO8GQiYMu97Q8asHwzs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX6H6M0xKHrVDV
 kh04iKteRSKdSsguiVz209rLlmfPSX90a2flaNAEZhFKnZBj1vW3yDpVOzur0QWCSFPfNEB5HZX
 K4MFdPQlbzIqWMkrSxNQvnIqXvFJYj02i6HPBoZ40bf5Qtb2Hksj0LaWLTj/Eb6NNHQ/buwzdp3
 /Oj/ff/9l5+0sJLUZN9FG0T1EbVCzUgJw+VHI3NrlwDbwEJB0b+n/L0kQPiq0RQBqYLFZSmU/9e
 66bL/W6E1vy1gj8+vXJXvDljkM7382yXuMbVI4N4dGkBoSAnU2YocOa16zxpSc44vHFMxQgDxIu
 yTciVG+b5nheienhsMD2ttUpORocaCXvpcFQ6x9GE9DeJCpX2/L6NMZoY53TA+YlaXOsIW+wl6M
 U0WNNXSx
X-Proofpoint-ORIG-GUID: 8sdOAG0ky-mobwO8GQiYMu97Q8asHwzs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

Introduce qcs6490-audioreach.dtsi to support AudioReach architecture on
QCS6490 platforms. The existing ADSP Bypass DTSI files such as sc7280.dtsi,
which is tailored for ADSP Bypass architecture as they lack DSP-specific
nodes required for AudioReach. The new qcs6490-audioreach.dtsi file defines
nodes for AudioReach specific components such as APM (Audio Process
Manager), PRM (Proxy Resource Manager), and GPR (Generic Packet Router).
This change enable the audio from the legacy ADSP Bypass solution to
the AudioReach framework.

Co-developed-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 .../boot/dts/qcom/qcs6490-audioreach.dtsi     | 52 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280.dtsi          |  2 +-
 2 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/qcs6490-audioreach.dtsi

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-audioreach.dtsi b/arch/arm64/boot/dts/qcom/qcs6490-audioreach.dtsi
new file mode 100644
index 000000000000..980499fb3c35
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcs6490-audioreach.dtsi
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Common definitions for SC7280-based boards with AudioReach.
+ */
+
+#include <dt-bindings/clock/qcom,lpass-sc7280.h>
+#include <dt-bindings/soc/qcom,gpr.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+
+&remoteproc_adsp_glink {
+	/delete-node/ apr;
+
+	gpr {
+		compatible = "qcom,gpr";
+		qcom,glink-channels = "adsp_apps";
+		qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+		qcom,intents = <512 20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		q6apm: service@1 {
+			compatible = "qcom,q6apm";
+			reg = <GPR_APM_MODULE_IID>;
+			#sound-dai-cells = <0>;
+			qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+			q6apmdai: dais {
+				compatible = "qcom,q6apm-dais";
+				iommus = <&apps_smmu 0x1801 0x0>;
+			};
+
+			q6apmbedai: bedais {
+				compatible = "qcom,q6apm-lpass-dais";
+				#sound-dai-cells = <1>;
+			};
+		};
+
+		q6prm: service@2 {
+			compatible = "qcom,q6prm";
+			reg = <GPR_PRM_MODULE_IID>;
+			qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+			q6prmcc: clock-controller {
+				compatible = "qcom,q6prm-lpass-clocks";
+				#clock-cells = <2>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 8561fc217229..9fa294cc9a3e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3944,7 +3944,7 @@ remoteproc_adsp: remoteproc@3700000 {
 
 			status = "disabled";
 
-			glink-edge {
+			remoteproc_adsp_glink: glink-edge {
 				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
 							     IPCC_MPROC_SIGNAL_GLINK_QMP
 							     IRQ_TYPE_EDGE_RISING>;
-- 
2.34.1


