Return-Path: <linux-kernel+bounces-778856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A10FB2EC17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A72C7B214F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B85727A906;
	Thu, 21 Aug 2025 03:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HCHRZkIe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34952E7BDD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747422; cv=none; b=CmYNTVdZWOSfRxyCq+6QVOIQgpaBxWzREDf8vY9zK7WfUi93GPEraIuo9MG7QvB9r+9eIyCrssXa9AxhMR0YDnwzD92F1tG+qG4tcyVabNYsPveSEKxOURR724DGZv+oqg/LB1yTQaY69/wj9x8qodycHzH/8GWyXnZQhrFYQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747422; c=relaxed/simple;
	bh=Vcbndb0BitXQXBCCDy5phydPWg7MwP6Brhlf2YVSZNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mEcIx0PM5xt/90aiJuM/emo/aAAniv6wyzN8yta+nwMTZwV08spzgUWoCG12JC+5z1aOeq3Uy6PcsjRFJKGhbHILRAb9jFLR8EcsFVDpJUB96+KCHr0vN9YyJ41dyAxce5VbXOBNNDT/VeyWv9Rtt36ZFWRZ1mdVCbvUh6thOII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HCHRZkIe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KIhLmM025217
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0Yg/2s8cwpHYy/pmAzzHeffOyyjabiwQv6sxOo7TaLA=; b=HCHRZkIerCrMIhrc
	87VO+DoEZ6hB0/0EeyyvC3X4A3eGq5t6RZDk2aw6QOCt1EYvaT+EYWhiM+LE0bnu
	jGRnHpleK5IPrsILfVxEfQS/se6idJMqUK5LNd2LqAc4VEPdMBr5fIOYepvh4vFm
	IfeNnzpzz0MptC2e+sOnQXXVxQZ3UwrZnXXwR4Z5qkYQZ/cnm6eI43agHp+pX0oY
	h+tJggu38AV589419Hk2pHHVeP2lHPart0Q64cTCF/oQgXcd1bCn2ifYDBbzySZZ
	mBQueGiLaiPADakgYGThtmIIjGyAfOShcr05MHC/EmlEF9mM7NDomKZPPvZ4iLqB
	60PumQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52abva7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4716fa1e59so438535a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747419; x=1756352219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Yg/2s8cwpHYy/pmAzzHeffOyyjabiwQv6sxOo7TaLA=;
        b=JlTA//B0ydPXyZEHTQiDWgE8osBFHs0ux1z19A3YBcawVz0DaoXgRg1SeNKE3NFCZZ
         vZP7QlOfatRrTrSPIrCNDRG9vhPL6bDBvcTxuM+h5l3Erz0+j4T+UJ0if85meU47AAw6
         1oj8BsagVTig49mTMsCqpCZk48lTYxWImcCHsh9yKZcwsrmTh1cOi4+QZpf1I+IOMbul
         VyTbJJ2bre+4WDksTpuLoa4f7Y395HNFE0ez3w4bDjIAfWBw2FfsZguKP8dlfvtOK0P2
         qKkq7FO+0ce1bQEWB5YF8ntEqzlI/Yh81aTzHk2aKrjYNx3Ar+Ia4EeR4kefC7hS5JKU
         syyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn4YibSvSdtTeA+y1/379CCl5b+pyiZlOxRML5OxSJx/tLpJRve9AXWqszBcGejxQRkFNsSe4zxs/ke/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy24LsDPUXB/sRqwBmZ+Za53f8w31t+lv6A/5ck4g/u3Qhp7Z/J
	ULIalzA6xAXqJPHLh8RdHQb84lc3i116zOFmmj0wpd7lZlp0/g1twPiKQN090a14Rrf+f40blEB
	C6ZXBI3X+DUFLGJJfza27zO0p0L2pq15zKXHbXaUSVucBRZ3dzsU3BIADu2O3soso5Bk=
X-Gm-Gg: ASbGncsCSjWTO5fkbbn0+0LOiNbJGrvZVzdo9vD0nZehlbAkf0YtNXHMvC+O18//gso
	BfCrSgSAzHEm/yyCXljT1oWh+f7Rm3P9dArUhXbch+T+ODqogKg2cM6DmqE9Bz3meOvuGP7JRZK
	0TkGmq7kU9Ai0LzRN4OVZ5YwTY+6Wc1LtcrrPzSU5nNm4UtDOOrSjWsR1m5vtxvY5g/8Y0ScZyK
	VGN7plaV/BTSf33eX0KcsC1o2BL2RrdMpDV+FdjZwQRiO/xNUujlKNvWORcIvX42c23LqV+0G5p
	0sWh/QUZpqaWxqwhoy1cRYeBj2uOmE76a/+6rPPf8YyPbrU9t8O/5G5OAT/NXA975LubcY0=
X-Received: by 2002:a05:6a20:939d:b0:238:f875:6261 with SMTP id adf61e73a8af0-243308a4f58mr1229023637.23.1755747419174;
        Wed, 20 Aug 2025 20:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRCZqNHbcoR5WRlRmiFsb0AFvSf5jLDkfv0v1YD2XuyCm5lD5AFBOU5mVx8s9zqhkJarHeSw==
X-Received: by 2002:a05:6a20:939d:b0:238:f875:6261 with SMTP id adf61e73a8af0-243308a4f58mr1228977637.23.1755747418755;
        Wed, 20 Aug 2025 20:36:58 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b6554sm3497780a12.48.2025.08.20.20.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:36:58 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 11:35:56 +0800
Subject: [PATCH v8 1/6] dt-bindings: display/msm: Document the DPU for
 QCS8300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-qcs8300_mdss-v8-1-e9be853938f9@oss.qualcomm.com>
References: <20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com>
In-Reply-To: <20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755747401; l=1231;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=Vcbndb0BitXQXBCCDy5phydPWg7MwP6Brhlf2YVSZNE=;
 b=mOoNvDKKUBqUis++AdmyjQhAhpayazMlyAI7h/rxX74lbKBENchjmD48LzidbrrwemcyCDR8E
 ikJa/jGaKlYCBVOdRSYFe87K0ezatz8sbGSHwxJljoVUp4+/RX7rYnL
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-ORIG-GUID: 37_jfLyqQ6_yD2OI-xn1DtFk5xHbLQOR
X-Authority-Analysis: v=2.4 cv=B83gEOtM c=1 sm=1 tr=0 ts=68a6945c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=5ixSZjX4nqodb9qzXsEA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 37_jfLyqQ6_yD2OI-xn1DtFk5xHbLQOR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+0UhV7DkA7eO
 hFYeAejZVVTfAbworrWWqoE1J5ZocGvUZyDVEWewhsb5wZSG+l7/OK5KcaPABUM4Z3nBi9qSAww
 Sy9WZ8TCTAhYNiixNlnfoggcW5fDGFoPEVMT5Jepku9GMrHETzc7URufb446qUVedvVVMGZQmir
 pPlrAKEgNZRO3nJshs1SUxmxLI+i0geFnigoaxAl8BFbg9iEMnAopqIEDelh/NYfTIBo9DQfFuJ
 HRKAVwgPQo3C3q6s8CWyLM12v6SMjH6RQsk8WcXcuSdHC1QCb9SPi7nEX749vbktc8C8WgOsawl
 fSmm4NMteDKfmj03uiW065bBzjD2lJvSBc5bhyIC+h5SvRlWK3TrVxhT9sjtPnZ5d1DfGn7H+Bx
 1J19zswB6NYlqtUudiVrBEo3g4MZGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Document the DPU for Qualcomm QCS8300 platform. It use the same DPU
hardware with SA8775P and reuse it's driver.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml  | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index 0a46120dd8680371ed031f7773859716f49c3aa1..d9b980a897229860dae76f25bd947405e3910925 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -13,11 +13,16 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    enum:
-      - qcom,sa8775p-dpu
-      - qcom,sm8650-dpu
-      - qcom,sm8750-dpu
-      - qcom,x1e80100-dpu
+    oneOf:
+      - enum:
+          - qcom,sa8775p-dpu
+          - qcom,sm8650-dpu
+          - qcom,sm8750-dpu
+          - qcom,x1e80100-dpu
+      - items:
+          - enum:
+              - qcom,qcs8300-dpu
+          - const: qcom,sa8775p-dpu
 
   reg:
     items:

-- 
2.34.1


