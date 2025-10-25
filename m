Return-Path: <linux-kernel+bounces-869637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B32C08605
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C72C4E7F3E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9222AD3D;
	Sat, 25 Oct 2025 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B2bqQIeQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2618E3F
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761351021; cv=none; b=Vn66zUC7Alx+nWUhWuwMoCSnzdoWtqZArTrAhvWiNALaGRKGo3K9Cv3H05ArHO5txjsCfe5IJe8H6WcDVn9SuF6bkW9f2P/kjlp9SqjOOsBX+npg//ZJdaWEOvRFPlh8BpH4Z65dsGFhHKA2YjXV8C4s/D7XKGvFnU//PylKSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761351021; c=relaxed/simple;
	bh=8PnTazA4dzV2y9nHuOhCjNJe3e82OR5ccqp936rFihg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cYWfbGJUfa7Cf9/LT3OQCubo5mjNmYJuYlJCT01DUjSw7qr/vhUe4GpeE6/eOwu9VcjxAJ/uOfFALIratdkqWYEWOUt8r9praMUkGyUaKqdWYk1nrmQRywHljULFNW+3vKHa6tEq7HF+ClTL59IiMdN9et8/SqKLY8cEtBlTrcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B2bqQIeQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59OI9KeA020691
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ANsLFbLhxWAijrZcc2ERGH
	28beR1/GNXIV7Rze9qcn8=; b=B2bqQIeQ6bU/64Y0+jVb8+csXbc35aBVVytB1Z
	3uRBzPpweYI/aGGCkl30cW9lrTgsvRKjOMgN9H4LF+0/OLhDWMkZhMgqCc4dc680
	rkt/TGtd5/KzxNQpTeYmuMh/fFf7ybLLxfW/xdtBKtxXGlsn8YcdaQy3ECluK4hB
	EZQGC/HRbwtsCJg4usV7opAWzwi2qfmTKaugZpjKhS46X5+Ri2A3XWZrCuezCtpa
	cc6rvTBckqQyZNuNZ4qQIlE43DyUAzRCA+lS+jWto/6tS+gH1jLeKvayA8msBSFa
	cXTXGpLpf4ax0avw2hYErZbA3r9qb3BpSm79yLG7B77Ayy3g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pwsje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:10:18 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33baf262850so2480834a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:10:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761351017; x=1761955817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANsLFbLhxWAijrZcc2ERGH28beR1/GNXIV7Rze9qcn8=;
        b=eMRwyxW4vnwTuNOw9hrruPFv6wo6q4BB+/3lns80MlSzhfk4ZFGkP0CsDqqE6NjTHr
         pcA1kkN/RrMvk5tr70ZHTYo/2NwDR/C/pmXW5UNNGW5g+vx/FZjTLnSntVhmXFWlU3XJ
         436wNnTlGGdgME6TyZ/o3yjEUO+tIwK2VczfJ+EVv00x0P64CaGSoC7qidY7KIgZ4ccy
         cgUC8puDfeqHKBRnMCZ9PsBOVN3MuhyvkPePnfiPGnJ7zfkuHCYtM34rasWuOnNS7Hwf
         WsxhgkdkMZP08/pQZ6692R7EYUnoUi8pFkBAINDukSHsbonX11DsQrjb6jMYcgTFvICp
         GAwg==
X-Forwarded-Encrypted: i=1; AJvYcCWvlcQqFEf5Bo8aBM+g5sdIQwNCQqkYq5g7sh8BpBkelfnL+ZJkF9dpKNtZaUgWAKs0HbdAHOltZpvP554=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnRVzAEhqTcLUN8COjQ1EljY5HZONMfPJKRv8INEbqwNOSV16J
	Dh6IVxIi/HqFesL4RGEssNXO9XqsGCIb1KK2BPc6UEJuKME6tSq+wKVJYLc+CFLSmxJCgK1oTEr
	HSP4PLGhLe4V/6Ml92pW+cEj7fYtAiJuIEdNn0yFHEItLiVz7B0ze3Qax8VhACNIpr7s=
X-Gm-Gg: ASbGncvrBErGIHD/DfCxy81kNoSJxZCr0ObApFMyepiObCdaSASeY6X7vDz1A5Fv79L
	SZytmwCFQDWLP93l8LUsurCnETgEv7NrxZXd6km6epJC6kowWI9K7ZBTG6WEczxwSByjJzBoD78
	gMRUAcrYu4chCfQKhaOBNrWblsbw0D9pP1oGjDO2D2Cv7pnIx5vRqie9nGJ29De9HGDACuPtlzJ
	UgGvMHvaHgSErbzzrpsHV2q9cs7B6eaKE5v8DZHBnEW2+Rb0tdZF8/mTomVNWzP/5ul5a7eWFYP
	0L+iWo+A18gnv4rsWGjtExAg+8GK7jxPCPhlnn1r/uF9k80B7UUG+bmIo6nYk462+dqsRyL59rL
	uoaRUCzDcrVtxwfUB2j3xgaU4+XWYHfp0ZGud9973+GcKEe9adjs=
X-Received: by 2002:a17:90b:3f8d:b0:32e:6fae:ba52 with SMTP id 98e67ed59e1d1-33bcf861b1amr37765323a91.6.1761351017421;
        Fri, 24 Oct 2025 17:10:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSm8h4NvRrjWOJX+Cx7vUoe1BpJGKUKqYtf8siu0vobIYTvOkbI39G92U0hrTcdKBmU0SyBA==
X-Received: by 2002:a17:90b:3f8d:b0:32e:6fae:ba52 with SMTP id 98e67ed59e1d1-33bcf861b1amr37765303a91.6.1761351016968;
        Fri, 24 Oct 2025 17:10:16 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7128885524sm374772a12.19.2025.10.24.17.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 17:10:16 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: usb: qcom,snps-dwc3: Add Glymur compatible
Date: Fri, 24 Oct 2025 17:10:14 -0700
Message-Id: <20251024-glymur_usb_subsystem-v1-1-bf6faf63b566@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251023-glymur_usb_subsystem-6ee90473506e
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX4SnDphO+G7pr
 Wxl/LmFHl2Ge0d0kO+/PzDgwO2A2fCPvUa2vjOn8RcgedNp7p83A3mnWBrjIgBdeHI+4JBc/Z3I
 oDKefPBmuUsVkA1PJfxQTyttuTn/uW+lqGntXQFqpxsFAQ2WbPVjnMYxnod/j0NKq4mB58hddZe
 Nndlr3Cgud6g1nH3PonWlkpG7d3t6S6czEndbC8oD3pNDMdVL/rEP3pXNhmJRcj7VxZWiGYMarc
 eKvQm3Nr7uN62Smq/uzHl0dGgBngDU65C/8D1Itktx7SQgQTOyKBj4EyyLskJ1M6akU44EZY9Ta
 QnDKdEF/G8jlN+yVvtV+Eb6wcj24za0QMvvRMcfyL7j4hVySS8iJtXqyc0b5bHplRPhhoWhF3pL
 b7tgbVoQ6L/Db12p7e5b8MRRi4YGtQ==
X-Proofpoint-GUID: IYGJudSBYb1v0ikU-KdG15eljRP8mFIW
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68fc156a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=d0k8rClLaaXxmoyBG9AA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: IYGJudSBYb1v0ikU-KdG15eljRP8mFIW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000

Introduce the compatible definition for Glymur QCOM SNPS DWC3.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
Requested to split from original series.
Link to original series:
  https://lore.kernel.org/linux-usb/20251006222002.2182777-5-wesley.cheng@oss.qualcomm.com/

 .../devicetree/bindings/usb/qcom,snps-dwc3.yaml    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index dfd084ed9024..eaa0067ee313 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -24,6 +24,8 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,glymur-dwc3
+          - qcom,glymur-dwc3-mp
           - qcom,ipq4019-dwc3
           - qcom,ipq5018-dwc3
           - qcom,ipq5332-dwc3
@@ -386,6 +388,28 @@ allOf:
             - const: mock_utmi
             - const: xo
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-dwc3
+              - qcom,glymur-dwc3-mp
+
+    then:
+      properties:
+        clocks:
+          maxItems: 7
+        clock-names:
+          items:
+            - const: cfg_noc
+            - const: core
+            - const: iface
+            - const: sleep
+            - const: mock_utmi
+            - const: noc_aggr_north
+            - const: noc_aggr_south
+
   - if:
       properties:
         compatible:
@@ -455,6 +479,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-dwc3
               - qcom,milos-dwc3
               - qcom,x1e80100-dwc3
     then:
@@ -518,6 +543,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-dwc3-mp
               - qcom,sc8180x-dwc3-mp
               - qcom,x1e80100-dwc3-mp
     then:

---
base-commit: 5d603d197cef9339ba640089f17aa415b514dfaa
change-id: 20251023-glymur_usb_subsystem-6ee90473506e

Best regards,
-- 
Wesley Cheng <wesley.cheng@oss.qualcomm.com>

