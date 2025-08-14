Return-Path: <linux-kernel+bounces-768329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67671B25FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F57B1CC4928
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89E52F8BED;
	Thu, 14 Aug 2025 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J2FiVVJ3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6772F6582
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161744; cv=none; b=dYsZvTOHlZT1UpR96dvGmW+Au3/k0yChlflDbRGXSoorU75OF0imbf2L3zgKitnvrgwuOUMIpMJI0jjy15EakAeuBAd3QDigPM7x36UdGMlcim5VEyrrSUNC/2eONM5RwLZg2ZKqKQgAXyJFRA9LNbe2RZ+rCkfvh7bf5syU0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161744; c=relaxed/simple;
	bh=k5yys5S/tOzjXlgUJKQ4zkuQnkiWv7sLoLchynvE9P8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gaeOjjdWOLHPVfsmMPolajvPwYc69AHzBWcXQgIzuA3kLEQdz7ecNyV09scxO7QwbCoARvjBxSydVhC9BNJyX9pjuA/YT8b9s7Xuoi/b0v0sbje5AcImsVqTddZVe5F6SqyYPohoGZs4jvBFkSvy7+j1T9YIg1VcgqThPiDfaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J2FiVVJ3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DM1oI2011413
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EbEF90318nog9hDoCsADIQtD0XbfSf3YmxtO0d/NH9Y=; b=J2FiVVJ3mJIYPWZW
	J0stjzC/mNXyM7gPtnfIlldM3Lsn/lJzZ3InfgRuBfjzoPhG3lqMdc91Rf1WfB5F
	NwW0YYuiGagQiQbFfP/Aj1APCt9QOUXjWL2bqEWHqK03dPxEaDk/jsy8eWoBG83x
	nr4TXMUfiPP7xMw7Mc3xXzPjhDR8PH7QOlk7cLUU86XlO87uorPwog0YdYCezC+F
	iwijy6CX4TZQ837JKYUnhEWykLlGWquVJOajjEhy3EQzUn1HHqSFwoa0uEdFZWP9
	5ur01dSBIG/ByVznwpiBL2a9o17P8k6NAUIxo+3aPxk49Oz+JAvgV8pTaBX6ALTP
	S0zCzQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbj6jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:55:42 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24457efb475so9245645ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 01:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755161742; x=1755766542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbEF90318nog9hDoCsADIQtD0XbfSf3YmxtO0d/NH9Y=;
        b=At7WU9xrQGdnAr/EZZCqI3MfboLxoRu198FcGy9LyLbcuhyaLl15pj24drt1k6MJYK
         SwOkWwaqdtiJ+gCWqXaZqT0mAUspLnsQVg2lEnI7sgVt82wyQ70kL+EP1Vkv/FOKV4NE
         O/ldrDMyz3Hmpuy+Ry+C0Z9gEVtxyZRTymznhATbw6qzeRO/8LAOqDSCTDtUWALAmF9y
         ommpc0iwVUJlsXEXMWEiQzw/xYirduY/zJcC/Nwe/1R0lAdIVP7RaU2nI5RjCEhPcuOk
         RURNmKlfHUDMfKMNrxeHiPfIrl0OtO7XoGVnJUHVQ+YHLAT1BrANQ9E8jbGCMYexN+Zx
         DHLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6OrhM58qn1k1WbQ0LtQJV2qeb90iSIesGtq1XwiQSP5bK0udnE2MrurQ3iriIxJQ3yY6wrEcUO0nyjbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1oDWqiywKAZm8iOJREnKzqEnQU5Dm/qZXIfv980H1lkdl9tjY
	9u8aaoacMYgFREWPw1e1m9PjMMhOigcboXZOzgoiEztjU3Jur8bUEHfBEhhg2iun6GoGGuBvGRs
	7ajRMjNldVEvGpquRqQ1dzdF9E3YqQJnuq2pt/ZrSoqUhE8ZsDMp4BwcK0cz9qTtXyiE=
X-Gm-Gg: ASbGncvGP2Xa1yPcd8ZUeRQrhWyuKqWm4t1EpPCqlIlU5wsfc4+2JTz5UHU+q/uWNeJ
	2n5dq4ltzQ1Zr4tQSisj8dxWYnI8gRVaUVwByjg7nxIOI1h2YVgH1mBZGXKxmcrHaqJ6lNaVmCF
	sKi5/dYumGVxdiOv6EWLxQ230jpKsl1dRM8UdeS8ETyQ5o+FvzoeN/9P+Kl4pskOATwGF2vBNu6
	g2oUk/z80s2oDeQq6ChhgG1tAkuK/M1/x2aS96hE92luMPs4JEqCFMDyDVY02JLUBZcHFBELLDi
	aAQk6ctPl59fp0Db4GmYYBXR1ivYzoL4/ITflQn9XGI22LtVEpmKAWlQlS42skh8
X-Received: by 2002:a17:903:2c7:b0:236:9726:7264 with SMTP id d9443c01a7336-244589fd996mr26058245ad.5.1755161741889;
        Thu, 14 Aug 2025 01:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhhmn6pyRq7PhG+dhIixzmgtZrhrr/8b1TGvv1xeW4QasfrlEgHNF+mHspELB38yIpIlLm8A==
X-Received: by 2002:a17:903:2c7:b0:236:9726:7264 with SMTP id d9443c01a7336-244589fd996mr26058065ad.5.1755161741440;
        Thu, 14 Aug 2025 01:55:41 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6713sm345395075ad.12.2025.08.14.01.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:55:41 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 14:25:23 +0530
Subject: [PATCH v6 1/2] arm64: dts: qcom: qcs615: Add clock nodes for
 multimedia clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-qcs615-mm-cpu-dt-v6-v6-1-a06f69928ab5@oss.qualcomm.com>
References: <20250814-qcs615-mm-cpu-dt-v6-v6-0-a06f69928ab5@oss.qualcomm.com>
In-Reply-To: <20250814-qcs615-mm-cpu-dt-v6-v6-0-a06f69928ab5@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689da48e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=eX7r7zjc-4eniw70hzgA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfXxGfftzS8S4Ec
 lOlMmk8p8PFLDiJGBYcPgF/A8pUqorNZr4/sGgb/52WTnIKaaSdfpbzt0tTf/pSJPXJxEYQcOTe
 BXjx6f0F/m9PhZ4UAksq2R46iOxTc305d5zJ59zOSe+5s9KlLuUiLJGN+8VxeOFzFAjpv7X0yen
 SSgNCIX7fyHrgYlP2EyCPogWsT0MRRarWKPZv2jHx+Ph92maZ4/ldArpqLv27KDqEyFpCDx/r8q
 KB76i/dj31fbUN8e667M/c5aZ4bG1COb6RE6Qpc5z5RhhWGYTXIKHblyZ20s6Jofe7Iw/7RHUHQ
 9bHgoApXMx+OELga7ovY+NrhvzlN2WJGc8Cv/JFuhCPJKQkFS/63sS93yPmbYO8oa1wvN+iL4gJ
 ylHsPhur
X-Proofpoint-ORIG-GUID: COuWrxa91XR2eP8D7l1B_k8m_-CRmhJQ
X-Proofpoint-GUID: COuWrxa91XR2eP8D7l1B_k8m_-CRmhJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

Add support for video, camera, display and gpu clock controller nodes
for QCS615 platform.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm6150.dtsi | 57 ++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index b66bc13c0b5e337bf9a95b4da4af33b691c14fb5..917d67a6a237a0aee3445212e3457cc723ab4276 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -3,7 +3,11 @@
  * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <dt-bindings/clock/qcom,qcs615-camcc.h>
+#include <dt-bindings/clock/qcom,qcs615-dispcc.h>
 #include <dt-bindings/clock/qcom,qcs615-gcc.h>
+#include <dt-bindings/clock/qcom,qcs615-gpucc.h>
+#include <dt-bindings/clock/qcom,qcs615-videocc.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
@@ -1659,6 +1663,19 @@ data-pins {
 			};
 		};
 
+		gpucc: clock-controller@5090000 {
+			compatible = "qcom,qcs615-gpucc";
+			reg = <0 0x05090000 0 0x9000>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GPLL0>,
+				 <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		stm@6002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x0 0x06002000 0x0 0x1000>,
@@ -3520,6 +3537,46 @@ gem_noc: interconnect@9680000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		videocc: clock-controller@ab00000 {
+			compatible = "qcom,qcs615-videocc";
+			reg = <0 0x0ab00000 0 0x10000>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&sleep_clk>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		camcc: clock-controller@ad00000 {
+			compatible = "qcom,qcs615-camcc";
+			reg = <0 0x0ad00000 0 0x10000>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		dispcc: clock-controller@af00000 {
+			compatible = "qcom,qcs615-dispcc";
+			reg = <0 0x0af00000 0 0x20000>;
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_DISP_GPLL0_DIV_CLK_SRC>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>,
+				 <0>;
+
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,qcs615-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x30000>,

-- 
2.34.1


