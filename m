Return-Path: <linux-kernel+bounces-811930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C06F6B53041
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FF23AF7C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5682C3191C7;
	Thu, 11 Sep 2025 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BqKg6IrP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C2231D379
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589870; cv=none; b=m8fhYNbnjQfMlpB55iv4O9ZcPhosunjHTLYmTBWoMRmBQwmO7YPdKXE1Y1WaxK5DqSSTj4vLO1JecE8w+UnchoUpTuQb1UiLEcg+JW8PayQSQSjS//BXBEzPNwW4fes14Qj5DVBjC09wiM0TW7JhhtZgxvNGGKbjlKCQPKM2oWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589870; c=relaxed/simple;
	bh=4NxcNPcdZQwrNtW6aZHc1wxhueG2DBgaJO6CuwtD5lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D3flMCte1uivWx7IFmO0z9qXdmrBittQV2bf4Lu5jtt9oHTL6cSufbGdS7JicO7qC+RIDcZagJlvJxyUhOQ1HnmQLQfN6+PZMh10Q1lWQ7gZ40wuH2jUhLc2viPp/y3u/vE1nWGcorhxpYZvotl9vjHKkBhZBkyMXCCToGW1bNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BqKg6IrP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BBIpeG002361
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RIm/FeZHB5M/ZxlpskEh0DOJRMp0J1LnIz0T8jbvq2o=; b=BqKg6IrP7ksbjhNx
	qUq+ScJ5X6x6zGWzLKsu17PvB5HrueS81NxC+sJZa4CSWl+fpLQ1i+fF4YsiqN7J
	shL5DTpDCCkW0syzBS200rW84fXlIGxM6mmHmx4qr68lx5KrZkgkxyJ/QlpKbzRS
	a0Ces7kuoIwm1s13q/WjdR1/fVM/NFG6syzo2+Kz1GfCaiszMHdCBjIYNvjdbAZt
	SiZltamuJ28KpK43nZCBZ5dLV+7396jc5nmyMiQCVwhLgJio2cqRuWcN/RmI6Lny
	7Rf1u8XmIJ9YFJA6rk9P6Jl0iTAu4LxrCzIRQRHQLKdZEbfE1Ld/A/A75478ZPFv
	Hmn25A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490bwsfhra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25177b75e38so8019835ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589867; x=1758194667;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIm/FeZHB5M/ZxlpskEh0DOJRMp0J1LnIz0T8jbvq2o=;
        b=lXfWQH8UqhwCF2Ec28ueIukyEm4x16bygYNmXbeUhAoaK8uilcgsbaXSfr19BRxNiP
         iAJdZm2kkUQK0Wo2uWRNHcVw0D9/UPB4HMB6xwL04MUSYs9R50X3Jj7Gbmm1WRb3b6Ep
         huP4I9iKLSZM1vShowS0gh5/eH7OgzGgI7r06M2p/85ax9yytb3y4gvZyQOTiGQfii7o
         5RaHwkp+yw39wtUeq4i3PBBeKAVbRqIgVV5ulm9bfuSxwI9TtOlZiw1nZPt0sCRM6YFZ
         bvBX/fN2kNatw0cgYkbVlOX/Tz2YUwRJDMT/qM+VOex//gRgjcQ++biAV8ahF1H7g9GA
         tivQ==
X-Forwarded-Encrypted: i=1; AJvYcCUObP5GTS0T6JxgFDDYNf+dsccs8VWDg4+0O9QGptGC1e8bzvrleycpPRpT9eKRDrkbTcDGfXe3yuwKrFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9pNS+80EXjv7zbh0BZNDvETP3KkwrGX014KqPtaU+0y2H/UTk
	AqBW1z+2pZOz80h5eIDfrEGdxYInKbIV2ffAyvpw1+UJE3G6kgU3ION7IAgltdsDtIfa+Pz7FUM
	zAaTFmPS4w5JNQScBoM1G7nHs8mSoOBFBKtotmvdeDAuardp3z2xcretk9ycN3GsjUNU=
X-Gm-Gg: ASbGnctoKWjqcePm+aBRlIr6MrCAUn4NEk4dTbUia2H7wVpbmAs8Th7Ut8Wo+ODs41H
	fJBjV6aZdrBE0BXGM8N8Qxi3CKDpN6dBJFYwsipeq69NqwbDNeMzxANuTITefZ4TKbO16xGxkE7
	7VsYN3MCJifjZEp4SjHSKpI9OcwjvZEGYNJFlgAWDi+WsqHtqkm3fwkg834F+zsk69SOHzPefeg
	m3nJxvKxeF/rvPNwJkRvxGofoexKsFG9Q/+cS2rZYMKD3ZkNkHdKWWQQvSpbjxI56Vs59KgMo1V
	uP9SKw1nYEsbG8TtcZXb/unDNNrQ00ZdL46cRSZc7zN2N+g59XY/CtBYeX+fY6gKbPIfDgp6nqY
	GHbgd7ciFUibCSRXdm5ur7chzJJrWnNxe
X-Received: by 2002:a17:902:f693:b0:248:cd0b:3434 with SMTP id d9443c01a7336-25170c41671mr260681625ad.36.1757589867403;
        Thu, 11 Sep 2025 04:24:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH63LOEnM0/9yJJk+9ZQU/OYiv5OWDqETgfKsJUjkwvSFJMDA0nSC3vhgmxSerAXE0+xyeKbA==
X-Received: by 2002:a17:902:f693:b0:248:cd0b:3434 with SMTP id d9443c01a7336-25170c41671mr260681305ad.36.1757589866899;
        Thu, 11 Sep 2025 04:24:26 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37294b17sm17005365ad.40.2025.09.11.04.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 04:24:26 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 19:24:02 +0800
Subject: [PATCH v12 2/5] dt-bindings: display/msm: dp-controller: document
 QCS8300 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcs8300_mdss-v12-2-5f7d076e2b81@oss.qualcomm.com>
References: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
In-Reply-To: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757589847; l=1035;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=4NxcNPcdZQwrNtW6aZHc1wxhueG2DBgaJO6CuwtD5lg=;
 b=Yv0UlU8te3uLa+M0miLX218hpaQHvae7QoWDa5xnVhgy4kK/K1R8ctuX5xgeGWBo64hQZOoGN
 3bUH8bIGNC5DZdOxa/8f3UiqemI3/n7/4sxV3qoHkB1r+WtLos5vvG/
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: ItJwG1W_BGqY0jwWMb5cZx7eEnmoGOqJ
X-Proofpoint-GUID: ItJwG1W_BGqY0jwWMb5cZx7eEnmoGOqJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX67RrPW2lmMDX
 ElJcgm4plWqZL6c0FRsChzfCeBEc5x5L+6OB18r1PCHMCzaz2haHFFgerXbQhtzeGijLKwXqhk1
 QvGBaVr3T9j9HU2LdZHaf/lgAiCk8PPxCJNAUk9uFAGo2Qd6q0SatewoI/ugU3o0YZ/OaA/Dabv
 XZTJMTzcfCgG2CRq98mDWPAs5vOgt5jrIP2SW7QPtBgByIrKVdxX1SXW4rD/5K6vB/5tXV7QggL
 AlDLiF9+NfAJFSUjgo/+6Os5uHG3geM+z3/my1x/4EjB3Vskb5Lfy1yNfVDoARDsCH2ZcXXfSzh
 wnezYM0IQUowYoXZ+tsPW57s92Q0fWB9v+S0nBvGrwPUWVMFKGq98DpMWCJhmFCALWXNErX3iZB
 O/RHpYOb
X-Authority-Analysis: v=2.4 cv=G4kcE8k5 c=1 sm=1 tr=0 ts=68c2b16c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=W7hmKyP8XuOziMQ-xZMA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018

Add compatible string for the DisplayPort controller found on the
Qualcomm QCS8300 SoC.

The Qualcomm QCS8300 platform comes with one DisplayPort controller
that supports 4 MST streams, similar to the one found on the SA8775P.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index aeb4e4f36044..ea88e1903f26 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -31,6 +31,11 @@ properties:
           - qcom,sm8650-dp
           - qcom,x1e80100-dp
 
+      - items:
+          - enum:
+              - qcom,qcs8300-dp
+          - const: qcom,sa8775p-dp
+
       - items:
           - enum:
               - qcom,sm6350-dp

-- 
2.43.0


