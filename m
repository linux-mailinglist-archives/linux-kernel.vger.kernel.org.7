Return-Path: <linux-kernel+bounces-843531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A982CBBFA9B
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1A8189DE1D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B232325B1D2;
	Mon,  6 Oct 2025 22:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CClnthBI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E00C2135AD
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759789217; cv=none; b=ixykGFP0OTuA4vUk0wi0kdaoUioxnWilEF8KLh1xFTkXg22AKPoBCcZnpHyJzkmRXUqIAAeI1oAl9xqFg0pTy1kNI6yc99A+DSAMPDWtuKYuTh1D2oYM+9XjCPoTq+KDzFhncfqLxD/LRcGgVbWAL1wVIg7LkmwjjyeFj+uEejE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759789217; c=relaxed/simple;
	bh=MCbqnX73P4uJn/n4jiAlTVZO9e/LGJ1yW50aiT4ZX9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/9JuXm7aGO3Tovngh0hkw02zqClGf6SW99xCrWNf2cUirW2kbZttZt0TKydoHkMkttJZWadxZsWKseD3p1JfwWupdGjXBIZHnkJbNnGxUdGrMZ4rHuigqz194V5MeLk4TYyrnNqSUoV9GYlcId2/CgD/5FqU8lNl5J/oFVnmL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CClnthBI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596F510Z001346
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 22:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YYQJM1FZM3o
	3DDgyVmJ5oX4Xtvn4+xxewRNc42qivew=; b=CClnthBIO3iEJu2ARKji9JHH1mZ
	oYZrU5EOAG++sJKc75hxLdQoFQQybFbSMEDTxbrn1f7xdz0+o3/pAqWmmbjwx7/D
	fH9JtGQp2BRLB/y6qnFnV9FVqdv0k854dRr/2Ie50gOF7GAR+PA2yyumMvYOYPuB
	BXGtAe89GTUGxI2RWWGj4MZXi05BiNxLeanXdvZWPjT2TCV2mgnnHfmliN1f5Syf
	gZzT6YxVH/EvOTlMGKBLJ2Q6XBVq47rGFY1yQH7/06OTdF4TIBBf2B0rlAWHDKRF
	LRi8JioD+LSEIcgM/LYdgFkIPLiGrWLNG0q9+EfuYAV4bR+cl42hYV/Fkkg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jut1n9y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:20:15 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-780fdbbdd20so4323153b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759789210; x=1760394010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYQJM1FZM3o3DDgyVmJ5oX4Xtvn4+xxewRNc42qivew=;
        b=diHvGhJvMpBbc/pLunl+nSwel+RVvVDgIaUjnYOiviJCIoCelAlb8Dxyuds7jDF6I1
         ZqMFgHSWj1UVjk7CtyPg9ceEdWfRcnwme8pdG2BmKUiX7dlmpYxxw1iVCf0ClJjvqGC5
         8dfWmVLBjuaf0UzD0YFA4bL3NcHI3bPXbg7p3fv1I2kcq2Uh5BXKzRi4V6SLFQVWsI91
         r9dkEOyhdSbdFUgGagAQsJRIBRb62/QUSzyvVmxoE05lRXswIO19/vKTEjqCUkiwyUOV
         vF+nXFhBSm+lwAdXTcH5BD905K+YnyRYQLpb3rS5VCkL0dQmwuTeQuW0MznxFdi+jUOY
         z7Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVG2ZdJa8GZ7VWluaqdmacZb8DpFkDUyEYLDWHrrIpU/6sYm7A6UY5r2o0+4yofX7Fqv2s07zBA9i9Rq1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YznYnDKv7Yez9ia7MWxzmCa10beWsM+X86HRA5tWDMBIecrO7iw
	4+EBGXLa2SCQCRTQfQNiZ/ZFSpa3YQHPrT33Y+84WyieGTBy8oJ19NNJPaLf3hljx2c3wGRhv09
	m53hTrB0KJ++Q+YtLWbc1Z0rfSmJo1P0YQJNgUMcqBZBRLpUJRHRdsi92PATADKXO/+M=
X-Gm-Gg: ASbGncvFpde1n5Bh2BYaImWMRTp5NG5F08pG2OkrL0jf89Z69hKdGDsdjtzBAsm/xo5
	1Tt5y7rNnLFlxbWWPc1glRtbVu0O+yQ4HHsZNMVnEaTwKQlwxHfRtYn+EnGpM28jQjsyl6CgnXs
	sqIgQCiC8fng16qTE6dcAoj8XayvebvqodOIfu9LJw6BvsrSfu14cmnHKRmsYU8IXJqtsYhX+3P
	kwLnL/qmBtyX7pITsWnTy5FqUhBS1WtcZaXJM7tV8LfV7lJau34jtKsPQUAPgxjWmgy0ohvqaQa
	b9B9rsrKmUUBLsmqlUEwqMpopnrpd6lF7NWfE29g5WYgSsEFFqM69HF8+ADh+lXjOZWRZDH18+S
	YN1lSjW6+LAhe5mvXkINEAA==
X-Received: by 2002:a05:6a00:17a7:b0:77f:2b7d:edf1 with SMTP id d2e1a72fcca58-78c98dc4de8mr14323536b3a.16.1759789209671;
        Mon, 06 Oct 2025 15:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXaDx8BsYyj47bbtSutFI7Rk0z0Yzk+5Yo1y2hw0obgjXnbc1IezB2I/5mfA3p0GATJPUQIw==
X-Received: by 2002:a05:6a00:17a7:b0:77f:2b7d:edf1 with SMTP id d2e1a72fcca58-78c98dc4de8mr14323509b3a.16.1759789209163;
        Mon, 06 Oct 2025 15:20:09 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb281bsm13734968b3a.37.2025.10.06.15.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 15:20:08 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v5 02/10] dt-bindings: phy: qcom,qmp-usb: Add Glymur USB UNI PHY compatible
Date: Mon,  6 Oct 2025 15:19:54 -0700
Message-Id: <20251006222002.2182777-3-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
References: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: A8Ij92x26sqfviz04drqhHTkFNAJEd3E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyNyBTYWx0ZWRfX3gSZFx0CxiB/
 /AaHMAZg/kPfAbA2JRVeXSCKfkiJCv5WzEuT1/fhT18PBi1BOe5QBxu6AViZjWm7lZ8TnhQ8hZU
 qQkxq4zVtYii1y1v/XqfC76GoMDpinAR+6Cs8viWFny66buUYd1ulBlUQOYprdjn+NGLK7jNkU5
 RlwxVkMcSUpY5OlSVxWw93SSYbD+fST/cHIBVaexrRNYQNK/HoBlwTHhYOS3w/PEqin7YlqTmYh
 4QO8I6I+7njxHH6+0BJOBDFfINYorxPd4Nn34CdcSlYpvjzn5zljm7jNgIi4UO6LpH0ulpbWRKI
 b1CXeHogdBemp0Sp5s0LY6wPwWlA51goZA49wjhWTQG0kptmiAOfnwpyjp8ukOiINAvRBSvQnNJ
 mwA2wMP1EwUKJ3PXQ1DSyqpDsHVDcQ==
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=68e4409f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=e4LYGitkWRZSOGXTHbEA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: A8Ij92x26sqfviz04drqhHTkFNAJEd3E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040027

The Glymur USB subsystem contains a multiport controller, which utilizes
two QMP UNI PHYs.  Add the proper compatible string for the Glymur SoC, and
the required clkref clock name.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
index a1b55168e050..b0ce803d2b49 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,glymur-qmp-usb3-uni-phy
       - qcom,ipq5424-qmp-usb3-phy
       - qcom,ipq6018-qmp-usb3-phy
       - qcom,ipq8074-qmp-usb3-phy
@@ -62,6 +63,8 @@ properties:
 
   vdda-pll-supply: true
 
+  refgen-supply: true
+
   "#clock-cells":
     const: 0
 
@@ -157,6 +160,25 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-usb3-uni-phy
+    then:
+      properties:
+        clocks:
+          maxItems: 5
+        clock-names:
+          items:
+            - const: aux
+            - const: clkref
+            - const: ref
+            - const: com_aux
+            - const: pipe
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-qmp-usb3-uni-phy
               - qcom,sa8775p-qmp-usb3-uni-phy
               - qcom,sc8180x-qmp-usb3-uni-phy
               - qcom,sc8280xp-qmp-usb3-uni-phy
@@ -165,6 +187,19 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-qmp-usb3-uni-phy
+    then:
+      required:
+        - refgen-supply
+    else:
+      properties:
+        refgen-supply: false
+
 additionalProperties: false
 
 examples:

