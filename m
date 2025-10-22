Return-Path: <linux-kernel+bounces-864263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A4EBFA52F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A47664EE65E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED6E2F2610;
	Wed, 22 Oct 2025 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MMgqM8N9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C22F2608
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115835; cv=none; b=MmRvBZWmj3Yhc+hz1hgH9E2HAmfRLf/NESHoIargXGE6ZnLtuzIPavJx11HtI2v+LUoP+LK55wqW0gNLujPNbDOAYLU/jbvX4W54W9wpL9WT6UAsP+AWky55bBQGemwrEPPdCcqpFn0/urewfqJ/55SNiq46BRZFlEAhotgbTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115835; c=relaxed/simple;
	bh=bMveLn8qXGEXMOOXqLmYG2oX6+KBs0Vzyv7XgzdwA4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kASlqftkFPuVbAW8P8c3ozg4S+7RrI3TtVpiHXg46sqRGF/U2Z9YT35EMfWZ1jfP4QbkJT0+u+PjLtQcZbjMGtrbc1UduwPEXLS8v+GP8kQjqmKsOwlDBwWWFuL/Sy2w35bUnf5gpGa0v1RN1Etj7gx9opzom+eZPLLZMfe/6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MMgqM8N9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M1h62H018736
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GfF19aO8xny9L39JuzD8Gu3or8NnMTbYbN7iD67kX3Q=; b=MMgqM8N92f10wjjQ
	3hWg5vMx/IFvH7roUEaeSLuVfeAkuliOuRgyNytcolmYTgqk5T72Bgp/T/M94S2l
	5Ne/uJKCur3t1nDuzHpzsaDlf3JJSQ2ZWJQSejrPpe7L4lPyEsF2sF/+vrSxU2w8
	zodJbSJ5RvLCQ3rscebtK9D+igwahWDhuK1ccx/KEnsibVXxtQdyT7ly6KJ4E9wy
	78oREBay6JoavJi4tH6GaIPwNGwmTMUGUfSbHankmXC8zbSwy1YBmH3uzyTiAuMh
	+2whizrPlDJd97JOrq5cT1Dr4iKXUdLI45YuBtWaWZA/Q4Dc7FFg4tf8/eLlNeRt
	7j385g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469kgmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33bcb779733so5642909a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115832; x=1761720632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfF19aO8xny9L39JuzD8Gu3or8NnMTbYbN7iD67kX3Q=;
        b=iZ+BzEfQ32Mffzt6XnianKCe5DCuQUqFD+NQdY7VUhMK5otNGrBdH6mLfMbe2RizrC
         Qkyv02eupZho+Rq3ZFyw4diU4QaH81bgrbTw6Glog6yA6eTQLcydcyXUyO1f8NWEnTsG
         o4WO+2IGJJUjrxxYt+Qxd7sqnfBX9fqS66EQU+7e0vUqO93I2zmosQvfrWVX2Rta0ovD
         tl6Y+qy0ThAUHvrHKLHB0UGd8OX/X+eZtPsoRVHczDIVD3TokWKoAsNHVR9FQyWnZMcp
         VQ+ju6U0TKr8rVxKZv/ef6MR8zJZBmA6t6Uzx73kMS2DTNCyoToRUk7gZw0kEliXUlaj
         Npeg==
X-Forwarded-Encrypted: i=1; AJvYcCV4wvP9eTMCRomf2M8hSVjolHBrB69hlP4Rfk6l/e301iRIq+HLc23rcyot9uCubG9eo3C+BGG+fggRHjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuwlk/wN/pwopZEWAdAxAekoszuUg1lJhq/DU1CcYMhF4xYZNT
	ovJKqHdu+m3uePQg/SCC8gNTz4/JvMytE9RME8uK6VeTdbNdW6/El47LTK62TbF8+fmhcSuPmoB
	0ssVnB/9a4MXwDS94k4d7JpIFlIWpr5Nt4/567VNvAjKB4bw5bCDOszcukK0iB2QE80Y=
X-Gm-Gg: ASbGnctDvsk7+buvgisvhsvjaEP8736m3gbtJnTkbYynBN4olEZT6MfuM5MZXsZ9RMZ
	Z6sGoUIT6V5EE0AAWf/9TxUwuquvfrK/2b9COjJaQJ9Ep5CbPJVZgsjGV6wZWGVVdXUWgClAzJ0
	sMEc9jiSIiV4UfMoCJAiFxuRbLGWJMg1xea1cM8mszMOs+ukCycKWmtthrzK7EVUk0uZ/iejPMf
	AFl7AFHhnrMBzokmCA8W9pMgmy3dCHQBp4rCThGjZCjWB0hMX0XMvWQkpGwZoc9QWdVU8jc3lH9
	WSYO/QZZ7GNL456pmi/JMkjGyZw7+f1Qw8NplkFqUAz+D1hU4D2g7ekNhCPZlNgT+KfwaMlJTTH
	tM2KaldGzuZUXLpBCvhw7m22j7Tpp81xEHC4ApHrcd5WY7X+E4w==
X-Received: by 2002:a17:90b:2d8f:b0:339:f09b:d36f with SMTP id 98e67ed59e1d1-33bcf8f8ca4mr24582324a91.28.1761115832277;
        Tue, 21 Oct 2025 23:50:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyOzdwa6M6+VonTKVpn/1dRGshyVGeAEj3HtpwTzivtN28WxG1KsX0bk+9YqsiFARG7CtuNQ==
X-Received: by 2002:a17:90b:2d8f:b0:339:f09b:d36f with SMTP id 98e67ed59e1d1-33bcf8f8ca4mr24582286a91.28.1761115831768;
        Tue, 21 Oct 2025 23:50:31 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223e334fsm1560285a91.8.2025.10.21.23.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:50:31 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 23:50:27 -0700
Subject: [PATCH v2 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy:
 Add Kaanapali QMP PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-knp-usb-v2-1-a2809fffcfab@oss.qualcomm.com>
References: <20251021-knp-usb-v2-0-a2809fffcfab@oss.qualcomm.com>
In-Reply-To: <20251021-knp-usb-v2-0-a2809fffcfab@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761115829; l=3168;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=wyxSRIp6b2YrRKpZKlLcX2lrCBRNwJtuTyhh+0I06cw=;
 b=WfGOp1rFR/PQ0DC7AXBJXKQ5YWGLmn3QByRcDCNfXH+p43IEdWO+k1Zkx/lfO5PztnyG3o4bN
 dSW/2yFfwZTC6ouw9RtmFBhOxE1Faix6EtiB3S19NbYSpwSTKzdKx3g
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: 3FqBkXeg2PD5Kdsot2s3GRI4Ezlmn3dg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX7fzCO95d5tVj
 JlncJDjhM3KEOC1MhkbqbSa8WvR+0caM7INWyggX6FfZaQq47Ebn1QW7wvQH/UrVrX9k56cMzc8
 r/1hMTBxA5OmCOi1tK5ONnyrosTVbDCer7azcPBAuz/cOOBSCJcEA736iCwxydi/HbKHsN1rN75
 gXR8n40FuisX+9GzW9u/yCm/pf/adKUObj7RJd4YsE4qXgSu36yy6MeM5OI/xd+FseiBCRLtWVY
 H49z+F9ukwzzSICYcJrdYf2RkEtSNB2bISJOND1CfyfarZeYnEbUc9pR8RShyrXuXl/SjkZSgSX
 FYuW4vhgD/6kTFqcfXmvhzXeuXwrDZAeMh/8d8Ya3A5LNOZdl2SqkAZ+WiREiaqkmbZZhuTLg5T
 lIA5hroN0CvVNhC60eQB+Wf02BzjEg==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f87eb9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=2IkYd7TCTIqYiAcLhPQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 3FqBkXeg2PD5Kdsot2s3GRI4Ezlmn3dg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032

From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>

Document QMP combo PHY for Kaanapali. Use fallback to indicate the
compatibility of the QMP PHY on the Kaanapali with that on the SM8750.

Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         | 54 ++++++++++++----------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
index c8bc512df08b..8fa919ea3318 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml
@@ -15,22 +15,27 @@ description:
 
 properties:
   compatible:
-    enum:
-      - qcom,sar2130p-qmp-usb3-dp-phy
-      - qcom,sc7180-qmp-usb3-dp-phy
-      - qcom,sc7280-qmp-usb3-dp-phy
-      - qcom,sc8180x-qmp-usb3-dp-phy
-      - qcom,sc8280xp-qmp-usb43dp-phy
-      - qcom,sdm845-qmp-usb3-dp-phy
-      - qcom,sm6350-qmp-usb3-dp-phy
-      - qcom,sm8150-qmp-usb3-dp-phy
-      - qcom,sm8250-qmp-usb3-dp-phy
-      - qcom,sm8350-qmp-usb3-dp-phy
-      - qcom,sm8450-qmp-usb3-dp-phy
-      - qcom,sm8550-qmp-usb3-dp-phy
-      - qcom,sm8650-qmp-usb3-dp-phy
-      - qcom,sm8750-qmp-usb3-dp-phy
-      - qcom,x1e80100-qmp-usb3-dp-phy
+    oneOf:
+      - items:
+          - enum:
+              - qcom,kaanapali-qmp-usb3-dp-phy
+          - const: qcom,sm8750-qmp-usb3-dp-phy
+      - enum:
+          - qcom,sar2130p-qmp-usb3-dp-phy
+          - qcom,sc7180-qmp-usb3-dp-phy
+          - qcom,sc7280-qmp-usb3-dp-phy
+          - qcom,sc8180x-qmp-usb3-dp-phy
+          - qcom,sc8280xp-qmp-usb43dp-phy
+          - qcom,sdm845-qmp-usb3-dp-phy
+          - qcom,sm6350-qmp-usb3-dp-phy
+          - qcom,sm8150-qmp-usb3-dp-phy
+          - qcom,sm8250-qmp-usb3-dp-phy
+          - qcom,sm8350-qmp-usb3-dp-phy
+          - qcom,sm8450-qmp-usb3-dp-phy
+          - qcom,sm8550-qmp-usb3-dp-phy
+          - qcom,sm8650-qmp-usb3-dp-phy
+          - qcom,sm8750-qmp-usb3-dp-phy
+          - qcom,x1e80100-qmp-usb3-dp-phy
 
   reg:
     maxItems: 1
@@ -127,14 +132,15 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - qcom,sar2130p-qmp-usb3-dp-phy
-            - qcom,sc8280xp-qmp-usb43dp-phy
-            - qcom,sm6350-qmp-usb3-dp-phy
-            - qcom,sm8550-qmp-usb3-dp-phy
-            - qcom,sm8650-qmp-usb3-dp-phy
-            - qcom,sm8750-qmp-usb3-dp-phy
-            - qcom,x1e80100-qmp-usb3-dp-phy
+          contains:
+            enum:
+              - qcom,sar2130p-qmp-usb3-dp-phy
+              - qcom,sc8280xp-qmp-usb43dp-phy
+              - qcom,sm6350-qmp-usb3-dp-phy
+              - qcom,sm8550-qmp-usb3-dp-phy
+              - qcom,sm8650-qmp-usb3-dp-phy
+              - qcom,sm8750-qmp-usb3-dp-phy
+              - qcom,x1e80100-qmp-usb3-dp-phy
     then:
       required:
         - power-domains

-- 
2.25.1


