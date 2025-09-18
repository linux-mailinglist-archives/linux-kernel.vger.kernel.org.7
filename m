Return-Path: <linux-kernel+bounces-750497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A472B15C94
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4483AAD70
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2712698BF;
	Wed, 30 Jul 2025 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ducq74cA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E5293462;
	Wed, 30 Jul 2025 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868613; cv=none; b=khISuENNmW+XYAO3QxEfC5PWxvIrJyw5ejwkyy1B5p2C9dd2dTLUosGU0Rj/kj/thxb8SgTxGcwViZROgAk1YIhPTEHCPNGky0Nob6rPt+C8Q1VglexPxYt3YBIuzKnHtd0uFetV8/iXPVZLtE4mql5Hjg2dTF3kOmmfwMRaYsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868613; c=relaxed/simple;
	bh=SjAq6bLNvcWMvRM1PrtiR3cKDyM0qSbohpfr/uRk/0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SW9lIPzGoiAAFjbZ/kfBqsXljBCTr5p5lhQc5PFAEzwwpLtyo499kfhVDUi0yRo3F9sKhApOP4gLE4qNjwBSyQ/F/XywpFfIQrw8ck0twu6ROZF+XNQApaPSPofyCJusdyPyKCkc/CWZc/Kk844OkvFiaqqZ5/tFu92i1rygXKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ducq74cA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U70ndJ017611;
	Wed, 30 Jul 2025 09:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3jsENSXLbo3dAV/GnrG6l2upHqJbdcmHuZcYPU8mbYM=; b=Ducq74cAJQ2y7xCM
	SkgXFeIOzVi8hiCEu7DMBYTxp9g7rCt57oOKNg7G3r/6n06x8KH2sBe7bmYSMogO
	azotvEbVmPEUfKhaDXLZefnMl6L9ViFCsc4ncZsRliAVR/R7MXyr834NzCBwbNYg
	i9ExjafxWjoCf8Pp/XkuRe0Idd410u3tFLv3ulCCKEsI7V3iyqVG+Hu956+ScWhR
	c+LDkjgPjHetMMtHhsFIOIzebPTl82Gu3/s3XJ4UalUDg8GepC01bKjpTTI9QO7E
	7Pcyg0ZqHzD/iM7LdZlMBs/td9YsANl5fveCPqT4A85p5Z1f4LQ5+jWUkn9aQesM
	WTwoeg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484p1ak5qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 09:43:17 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56U9hFqA008921
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 09:43:15 GMT
Received: from cse-cd01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 30 Jul 2025 02:43:10 -0700
From: Yongxing Mou <quic_yongmou@quicinc.com>
Date: Wed, 30 Jul 2025 17:42:27 +0800
Subject: [PATCH v5 2/5] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250730-mdssdt_qcs8300-v5-2-bc8ea35bbed6@quicinc.com>
References: <20250730-mdssdt_qcs8300-v5-0-bc8ea35bbed6@quicinc.com>
In-Reply-To: <20250730-mdssdt_qcs8300-v5-0-bc8ea35bbed6@quicinc.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
	<lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang
	<jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Neil
 Armstrong" <neil.armstrong@linaro.org>,
        Kuogee Hsieh
	<quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753868577; l=1263;
 i=quic_yongmou@quicinc.com; s=20241121; h=from:subject:message-id;
 bh=SjAq6bLNvcWMvRM1PrtiR3cKDyM0qSbohpfr/uRk/0w=;
 b=pBy+bdwsUj6lgqKVQeNE4EDscpQRzklGXqT5M2X5owK22uTxI+v7xgGBjD1vK8k4KvFHoezVx
 QrYfaMsE/jQDSIsPzy+G/7ijNWijRmJFhVtoQ6cAMcYsvYuqlFmC/T+
X-Developer-Key: i=quic_yongmou@quicinc.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: haN9si5IguWL0fV9r1mvo2UQq3rOdFyL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA2NyBTYWx0ZWRfX+qabqXbPi4oR
 fQ30AE2eT7wjaJVt+zqAvJxQabOUYTONyV5NioA+Fmal3Y3MeuBF2XsLdl/AGD0t783VX5LztG5
 eTUgPqSLzjX9n6Rz8/cAcwb241c2CEXyr0oowAkfUh/qt2odw8T/x3GysZ3jgoUNYO0mimvUsFV
 BJqfPspWajzr3p+8YHzBineH9QiLeCHKpm+cUZxujr/jO/IF39TZzmAS9icmQMqi7gNi/FkUpWe
 UKRrRJ1+DYWslsQghp7AL9OTB5KgGmsqsa9wbHxv9IAZDgi3JXbRun9Dp2Ycr4nd1Lzkw52RXxb
 bqKt99pK0xhAHTfXX/4Dp5xFPFhKcUrSVjgHKJkVvGSnPA70efNBDFTApb295rzExsOlYGdhHcr
 A6i55bRneRzgU8W1jXkMCA+mCIwXm6V3mWcEuA4oPARSuXBOdX8dHxI5ZmxiL2c6aRIM9liq
X-Proofpoint-GUID: haN9si5IguWL0fV9r1mvo2UQq3rOdFyL
X-Authority-Analysis: v=2.4 cv=KtNN2XWN c=1 sm=1 tr=0 ts=6889e935 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=2t1bcwrjeadYucq94KYA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 adultscore=0 mlxlogscore=910 bulkscore=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300067

Add compatible string for the DisplayPort controller found on the
Qualcomm QCS8300 SoC, which uses the same DPU as the SA8775P. While
DP0 supports 4 MST streams, DP1 has been removed at the silicon level,
so SA8775P/SM8650 cannot be used as fallback compatibles.

Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 2893f097df826a5f941fbb754fb4a96a1e410a70..f5930f29c91ec95e9182c7b8ee83c0549c6657cc 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,qcs8300-dp
           - qcom,sa8775p-dp
           - qcom,sc7180-dp
           - qcom,sc7280-dp
@@ -186,6 +187,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,qcs8300-dp
               - qcom,sa8775p-dp
               - qcom,sc7280-dp
               - qcom,sc8180x-dp

-- 
2.34.1


