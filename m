Return-Path: <linux-kernel+bounces-831464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9912B9CBDC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FBBF7B1774
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E74E2D23B6;
	Wed, 24 Sep 2025 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Av1MGkWJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6FD2C2369
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758225; cv=none; b=K1tlfpb5kfF8KucPCfd1SaaRQXttKAUGT4AxDGRNL7WY7FcdL962fnUUYHxVKajghDG0N2LK9URC/QLBa5Gp49HfnzeQb7UMUpP+y1tyeiqzSb5zaOHMLNHR0otJ6F+jwjD23Z/bq36t7Iq1V7sObKYNKq+rUWgUBl8m46QrbLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758225; c=relaxed/simple;
	bh=vxtCqEBXFxTSszZwXPBtJqekhBLKcmhPlBp9HR1oeIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BfbI6vweK3LipQDPS6XoIhgNaz7YHO/61MJHJu4ZAV5NViCa4dOvepv0sKHW28zmUzyA3042uAnVEb1iUn0NXSuvmf+faHmqymiOZHjifrlmqLh0sRO/upfDFnjtxQ/+KS9o1sXYIi1QNeUlXjG2FncEYiiUBw6raUYm6Nqmg0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Av1MGkWJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONeU30027304
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pk70erFYcO2AfKKE1Z7dwoVNONUYzVa0slzE3uRgPDI=; b=Av1MGkWJ70XVj0nm
	6HHG1YbZ7o2pEheSiQC9+IH9tkgrnYvyMZkmhZadYH2LfcdGe5Tr3Xufno0k9h+q
	bwDkAStGyTIkmMnhB+auBc4pWLmz3xWv4G3oq2Abq7j2MIJ9NnRiBVVZ2Zv0dM1j
	BBU6lYnn6FrlCWZhHUjuId7rMrtV9RpfHUD6gO8LCnhx5gWf++JDU+kbP2MwgiJs
	kX0ERGKgaxm/+Q65D+gXB4QO8RxBlVdEQm2W5wI/1EH5V2yvItODyHxQjtzXrELG
	mMuhCrk1YR41I8/0qi1iFVAQ2BEspTgnvQNJIN+lu+PNqs/9atcubZtoKjH6obEF
	bOX8BA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv1649r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:57:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-268149e1c28so3356595ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758221; x=1759363021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pk70erFYcO2AfKKE1Z7dwoVNONUYzVa0slzE3uRgPDI=;
        b=njPlsAyAC8xquhTCXA1m9+PPDQLWfNjd7kyFNoJeqrvFP2xM4R5lbvni+wZ+ZpHLKs
         IVgvt6j8i0Uy+mRQ+rAHF2POKe/Pg9CIb6TRD40Wd4uENaUWhIoDGbRHXVcq9F9r/kpP
         pulEwI3yDOGAgb8doPuyKLQRiTEWdE3vv+PwNfvhSQWHJpIvDImR0+1rAmx9YxJ2Jqe9
         TqaUBLQzbI3pRzb55NaYsirP9OgUcKLh6DoBghemshCXfzvBLL2nSvpJm+MCZ+U6Cb61
         m5xGpPeayOX9TH2LDKdbFgvYdTMQ181di1iFrd77JPqVnoiXQ2SsD1HEj2R8wI9Zywxx
         UuaA==
X-Forwarded-Encrypted: i=1; AJvYcCV9RXUsxWJ6Hj/+dkWfnoHce7z3NcK2TbZWgZceE9FKxILTIFANRUgB/u+GGUXxjZ3a30pK9F0r/uvGJhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy07M5DxXwaPp12oIuX7DP0fqDGZLWLmkYxHYTdq2ay3TQ7XtMg
	tMG4nJpa8tYru0F4M/Q1nB6FnuzquITxIt9jgigyLHz9HpbCTzKmLjWPTaC2T6AroOUbg8SPEif
	WvT/tQ5kJKNGKIKBIzuMp4Dams7PzmMMrIGeu+JbBdLoNH1dFewmEcjOxDdfTkydezFQ=
X-Gm-Gg: ASbGncsIN1k8kUNdgEAb0LkMhcnxmeJob73diix1ikhz6/Zy2QMF5AgJoAaL0+GfLcU
	OkgCAbror+7z+EqWSncE0yNkbzzI2rNEEZLN62RRLxYKaZwGqVaV7ZvCOnOlXGf0r4p+Jkz7iV8
	P+mP0dCn93M0LgJAVtRxsI3qZ8LwUMh8GkA4EXb4mNIntn1KhxsBQXZsEczStqKfkHxnN5gGiAG
	lWs8ys6cEdqYx6qWykjL8oFWDrHZFRB5Xkltz20VGNODDl8C7vsNqYcUbgrBbMOtoncFu/ulDDd
	O9tUYEsTcvNgVF7preYk5B5VEHAkdCNXa045G5m0oup47C4sZkAfKeAzHHDzelPBbtKAI+rWBd9
	i266CGVyIfSN8dlY=
X-Received: by 2002:a17:902:fc47:b0:264:1afd:82e6 with SMTP id d9443c01a7336-27ed4a60f9bmr13196255ad.53.1758758220450;
        Wed, 24 Sep 2025 16:57:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbTbTp2me/2Ozbja2PwjyojwjJ05KsAp6cuIPrATe9oMmVCAbQuTu3rQBw9zmosE+LnsGZKA==
X-Received: by 2002:a17:902:fc47:b0:264:1afd:82e6 with SMTP id d9443c01a7336-27ed4a60f9bmr13195805ad.53.1758758219947;
        Wed, 24 Sep 2025 16:56:59 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6881fd6sm4557185ad.87.2025.09.24.16.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:56:59 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:56:45 -0700
Subject: [PATCH 4/9] dt-bindings: clock: qcom: Add Kaanapali video clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-mmclk-v1-4-d7ea96b4784a@oss.qualcomm.com>
References: <20250924-knp-mmclk-v1-0-d7ea96b4784a@oss.qualcomm.com>
In-Reply-To: <20250924-knp-mmclk-v1-0-d7ea96b4784a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758758212; l=3732;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=0aHzA87ne9/I9u0KuPsqyfzOGqP9ZE4Qht8AQaI9SGA=;
 b=bfaEOWxv1PpaU5TCtCim6m8Ui/1XV/Z5ELraJs8RZIFMQHjsxdCFjvh14YtqielMA/B97NvTr
 OAtVVOXv3NOBInq0arVHFQzREhI8KWLdmxqYVb/o1gaV5NHfMBA/fl3
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: VzTTpI1Be8b77VnLBNLbPvXiiqNNxKNO
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d4854d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_xnZC5tmkvlqoiR1VIgA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX52qGGTMv29RV
 6s8Q/nAeuxYYuHwvPQOr0Y03koZV0fjGg7qZBgX8MQHuDs4fO2RA9m7EIDiyatXe5R6sQvQil1M
 Qj5xzke0MBe0oqUmBfUHrCZGMEv1yYEA52QFMxp1vRwFG1byst0g4JwnCg7p8RofH+kgWkNavXh
 XYu+EU44Z/GMcBXFf5Xsp+adsXPstOFTu4TV4rDdynrsGqCymR+hnBzVfuAWX9zOH+o0z4Paawf
 dTUZh8r32gdf7/zFnguodFgNG6Hjb8Hn4CNzIjXi0ljZZk/6H/KzAFtJZ0G7RkNThJHrG73Dyiu
 nnCnOye7dTFiseGWG4Op9xNfvyYk+eNsUnEYk2KjPZqR9MqqWqsTDxIKwvF8G4rp3zZ6CDOy7+g
 8tMQfw6Y
X-Proofpoint-ORIG-GUID: VzTTpI1Be8b77VnLBNLbPvXiiqNNxKNO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

From: Taniya Das <taniya.das@oss.qualcomm.com>

Add device tree bindings for the video clock controller on Qualcomm
Kaanapali SoC.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 .../bindings/clock/qcom,sm8450-videocc.yaml        |  3 ++
 include/dt-bindings/clock/qcom,kaanapali-videocc.h | 58 ++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
index b31bd8335529..e6beebd6a36e 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
@@ -15,6 +15,7 @@ description: |
   domains on SM8450.
 
   See also:
+    include/dt-bindings/clock/qcom,kaanapali-videocc.h
     include/dt-bindings/clock/qcom,sm8450-videocc.h
     include/dt-bindings/clock/qcom,sm8650-videocc.h
     include/dt-bindings/clock/qcom,sm8750-videocc.h
@@ -22,6 +23,7 @@ description: |
 properties:
   compatible:
     enum:
+      - qcom,kaanapali-videocc
       - qcom,sm8450-videocc
       - qcom,sm8475-videocc
       - qcom,sm8550-videocc
@@ -61,6 +63,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-videocc
               - qcom,sm8450-videocc
               - qcom,sm8550-videocc
               - qcom,sm8750-videocc
diff --git a/include/dt-bindings/clock/qcom,kaanapali-videocc.h b/include/dt-bindings/clock/qcom,kaanapali-videocc.h
new file mode 100644
index 000000000000..cc0d41b895c9
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,kaanapali-videocc.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_KAANAPALI_H
+#define _DT_BINDINGS_CLK_QCOM_VIDEO_CC_KAANAPALI_H
+
+/* VIDEO_CC clocks */
+#define VIDEO_CC_AHB_CLK					0
+#define VIDEO_CC_AHB_CLK_SRC					1
+#define VIDEO_CC_MVS0_CLK					2
+#define VIDEO_CC_MVS0_CLK_SRC					3
+#define VIDEO_CC_MVS0_FREERUN_CLK				4
+#define VIDEO_CC_MVS0_SHIFT_CLK					5
+#define VIDEO_CC_MVS0_VPP0_CLK					6
+#define VIDEO_CC_MVS0_VPP0_FREERUN_CLK				7
+#define VIDEO_CC_MVS0_VPP1_CLK					8
+#define VIDEO_CC_MVS0_VPP1_FREERUN_CLK				9
+#define VIDEO_CC_MVS0A_CLK					10
+#define VIDEO_CC_MVS0A_CLK_SRC					11
+#define VIDEO_CC_MVS0A_FREERUN_CLK				12
+#define VIDEO_CC_MVS0B_CLK					13
+#define VIDEO_CC_MVS0B_CLK_SRC					14
+#define VIDEO_CC_MVS0B_FREERUN_CLK				15
+#define VIDEO_CC_MVS0C_CLK					16
+#define VIDEO_CC_MVS0C_CLK_SRC					17
+#define VIDEO_CC_MVS0C_FREERUN_CLK				18
+#define VIDEO_CC_MVS0C_SHIFT_CLK				19
+#define VIDEO_CC_PLL0						20
+#define VIDEO_CC_PLL1						21
+#define VIDEO_CC_PLL2						22
+#define VIDEO_CC_PLL3						23
+#define VIDEO_CC_SLEEP_CLK					24
+#define VIDEO_CC_TS_XO_CLK					25
+#define VIDEO_CC_XO_CLK						26
+#define VIDEO_CC_XO_CLK_SRC					27
+
+/* VIDEO_CC power domains */
+#define VIDEO_CC_MVS0A_GDSC					0
+#define VIDEO_CC_MVS0_GDSC					1
+#define VIDEO_CC_MVS0_VPP1_GDSC					2
+#define VIDEO_CC_MVS0_VPP0_GDSC					3
+#define VIDEO_CC_MVS0C_GDSC					4
+
+/* VIDEO_CC resets */
+#define VIDEO_CC_INTERFACE_BCR					0
+#define VIDEO_CC_MVS0_BCR					1
+#define VIDEO_CC_MVS0_VPP0_BCR					2
+#define VIDEO_CC_MVS0_VPP1_BCR					3
+#define VIDEO_CC_MVS0A_BCR					4
+#define VIDEO_CC_MVS0C_CLK_ARES					5
+#define VIDEO_CC_MVS0C_BCR					6
+#define VIDEO_CC_MVS0_FREERUN_CLK_ARES				7
+#define VIDEO_CC_MVS0C_FREERUN_CLK_ARES				8
+#define VIDEO_CC_XO_CLK_ARES					9
+
+#endif

-- 
2.25.1


