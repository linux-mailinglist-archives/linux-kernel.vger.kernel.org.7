Return-Path: <linux-kernel+bounces-880089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F76C24D96
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D9B461D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05599347FC2;
	Fri, 31 Oct 2025 11:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E1cCQ/JM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K/bkJT2I"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE21346FC9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911313; cv=none; b=aDeEkTv/K/dQZsV3PlpVU8itj62ED5qA4ddwM1gDip3XcUptrQZtRVUoymQag6Lxy1skxZ3R0CgYUVnscZNa4XqcaCxMjO1oFK3kirB/m6dnmq+Spy7okwPu5LLIefi9lYFu5AGtY2hwN+cYf2oE+OaU3shLUdXgq5/npwr7qVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911313; c=relaxed/simple;
	bh=exPcFwTkKob1Kvtn/KJIwEEHNtSYPJUVpMm1QHlPqwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHCGZQinNkBHpKKTO//qJm31Ve27IWPPK9nmLo/sNnR1n36sjsfr9+QN1BQkCJGfo5Fbx5MledVCwayFRp/TxVmHmqFAJlh+0jXArS47rIyZSVB2ZKKaym8SWciFH6EHo+riWwHkaReVmuHUNZ9C46Qxm2mfJPdYi1+BtCIw9xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E1cCQ/JM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K/bkJT2I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V8Ik3I832863
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=MlpYleSVISD
	gz2HE7RgANuLdkU0REzZ/tp6gPxx4A68=; b=E1cCQ/JMW+9ZFzhg6+xOOMfjuBZ
	Xcgp39WXsFWlAaQ7LtY0gR6pcHy3Bd3pg6KudxYPUm5+DEX8TDINtnqSSYgKudsC
	8B68asWuc0ZczkmN59Gv2EXj9ayJd5O3+puS5D3WCAGmKNJU/gP/cO5MZVMgFhIV
	nQe/30QVXJ8oMmHQp3NZ2Sdzz4DJFzDcn+ccI846arEtuUtCuWzAb6ZiXk8cSuNC
	2MC3UCKxhHjiG0zfQc4ObJHzNFaYBE8erpUbZKpPXkTo9Wwagucu0ifEzhOUTBmQ
	eCojS2tgrPaP2Fga8EEGOZdRlX8rlhvYppKzSiSI/v8mtGyrsnDh/3/roNA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ffb231q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e892f776d0so96158431cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761911310; x=1762516110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlpYleSVISDgz2HE7RgANuLdkU0REzZ/tp6gPxx4A68=;
        b=K/bkJT2IUKPpVgCSPZ7TBMhNAY4Bt/n7ln7mMOtJSdjSd6FlhgNW8GPNBGRStt5XEV
         ekS5b+WEXLF54piFXqlZqKUavcf4Y6bT8zMdnXkWUn+TLaq4D8WmjnEDjqEYcmnFWumX
         /NhkkQxqZaDV/Z9CMZG/toP/9ci9dNhbRxIXAMBH4AOIWaXP6GmUKA6zHOu7K4MxsOAs
         qxFBT2+dAOoobdo0kGsF5tV/gBWDUJiU3WEFQXIGxBN+AONDR5YbicYb+fDfmbpc9hQ9
         WovvziABVQVt+V40lD4yzcOweXMHC2dQtq3bD9sN+vCAJeSOe1vlNP405UBABC14VstA
         StfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911310; x=1762516110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlpYleSVISDgz2HE7RgANuLdkU0REzZ/tp6gPxx4A68=;
        b=SGzojvUptOkqIjGgAeETLVHlAvo+59M+y3rzJZOCPn6EFNp9fibkKQX5E0wEMyePM/
         eocNGuSUBvBcjJbn9VIfolp3gxQ7Q3aUqAIMDsD8bnAwWSGve42OCVM7s0NoKdKAzQKE
         KtmytibpPsFzIQoJzz8zaWjGRzkYAPx7ByrqO6YNylkVq9f2qnITcOTlnCRst28to1El
         ZfSlMjlukxneI5u2aZdt4tqhXl8kS4KS7hNMFXE3i4poFa31jWbNnLW8rBSMmoajBofh
         WE6yfK6GTDpnLlOz2YIm3Q2fLO9PQ6+vh89LlfZkjSnIbKimkrb4yiFolkNRXFK53MP5
         Z3oA==
X-Forwarded-Encrypted: i=1; AJvYcCVXANSswZ9pmyY4hy8oj7bQXyjoa7AbwxZXsrLT4mslo9bmTg0PQGI8qOzC1X/sGI2c8NhGtggGfRW4CZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRL6GwAbaszwT+hJKXY8U62AbaPVtYfFQfznOZBed5ic9/d+S0
	tq7Aa5bVWQQsFvOVePmfKIbgVK6wlJHP3ptoCq14MU5sC50E7RYKOb2b/QAjRKkBrF7Lo2C+OVx
	8EZxVGF9wHWVrF4lNArSg+uBST2QZH3fHCOTebFiyX54tSPvaYlNJXRRaMzLrqMY2wuY=
X-Gm-Gg: ASbGncsq5S0sBtsC0w/SV52EaJzLUOpaWipiFa3Iit0duHSk+5yk+WBA8DD8fGPSc5c
	aazo0koo2G4QUhwGPOqdYn8wVSYS/GxR5RkYVlkuymZtB4TKosf5Nw4IMLbAightKO0BDCC5MYT
	zuDBDKp4omvrZt31tg6lrX6Zb9t366R8Agg4+2HKFrvo4xZK/pjFzoi53c4st++htr41ssRXmyj
	Adr0vQN6o177XoeOPXkYcb+MAoUqr2p8bA2eDLOSiwcrgg7A6dhX6Qds0cxe/+ylsOXQjVs2RnJ
	mappeilv6IkDrH3yEnX5fUEHLimFQM3YedlkkZlI4vC5c04uEYBFSxVbG8PkeSf0Km2qGRw6Jza
	fLYgMeDXEPRg+
X-Received: by 2002:a05:622a:1dc4:b0:4e8:afdb:6f5e with SMTP id d75a77b69052e-4ed30df22c9mr38840631cf.24.1761911309796;
        Fri, 31 Oct 2025 04:48:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoKpOm4SAtLAUUcr6TFmMPzErmIDM7Fd3YcuKI+BAGtXEJ88JJutOrY2elxmC5mM1g+Nkiyw==
X-Received: by 2002:a05:622a:1dc4:b0:4e8:afdb:6f5e with SMTP id d75a77b69052e-4ed30df22c9mr38840241cf.24.1761911309256;
        Fri, 31 Oct 2025 04:48:29 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728aa915asm86831165e9.16.2025.10.31.04.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:48:28 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        konradybcio@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 3/6] ASoC: dt-bindings: qcom,lpass-va-macro: re-arrange clock-names
Date: Fri, 31 Oct 2025 11:47:49 +0000
Message-ID: <20251031114752.572270-4-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031114752.572270-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251031114752.572270-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: omu_wya5WZzXgam0whox8O6TObkpohdv
X-Authority-Analysis: v=2.4 cv=fpjRpV4f c=1 sm=1 tr=0 ts=6904a20e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Zn4RAEFE0_yfxgg1y30A:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: omu_wya5WZzXgam0whox8O6TObkpohdv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwNiBTYWx0ZWRfXwcDi3ZySsJay
 1wlctv7LAlKG32yq3LCeF5k7gTunXFwhCbdMPQUFK6UuHqLCJ3hE4YBGhnEiJyLGC9j6EK+8qXD
 9WUX5KWDjCqfkwmGu0kuASf28V9AKBzttJO66THs8thgjnBfG/jw8XgJnnfPhEohQ7ZtiBb/5WY
 JXWeymjAkec/WEn1VAsM4R/rHRHU9pSso8ovfIKHicz0FbzxImssXiUibGEryvOJX7XCYo3UqyS
 md/Q4J84DrqB6muy3sXV4ep/ZirWkR8+xkfK15Dgg98Ykxm5XumNvXLgZD+89Y/x+Nda3eokDvD
 93lkd8/XQGS4/+NwSq7IGEtC2qCqPBDt/ByQCjOwvVUWuauYh7WyaW9frpj6k+BesigGly4iBmX
 WN4cwd+V8oOBYEiiBjOElrpYsbOF0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310106

re-arrange clock-names in the bindings to be more specific to the SoC
compatibles, this will give more flexibility to add new SoC's which do
not support some clocks.
Move all the clock-names under the SoC compatible rather than keeping
int on the top level, this makes it more align with other lpass codec
macros.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 .../bindings/sound/qcom,lpass-va-macro.yaml   | 35 +++++++++++--------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
index 5b450f227b70..d3851a67401e 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml
@@ -42,11 +42,7 @@ properties:
 
   clock-names:
     minItems: 1
-    items:
-      - const: mclk
-      - const: macro
-      - const: dcodec
-      - const: npl
+    maxItems: 4
 
   clock-output-names:
     maxItems: 1
@@ -91,16 +87,18 @@ allOf:
           clocks:
             maxItems: 1
           clock-names:
-            maxItems: 1
+            items:
+              - const: mclk
       else:
         properties:
           clocks:
             minItems: 3
             maxItems: 3
           clock-names:
-            minItems: 3
-            maxItems: 3
-
+            items:
+              - const: mclk
+              - const: macro
+              - const: dcodec
   - if:
       properties:
         compatible:
@@ -112,8 +110,10 @@ allOf:
           minItems: 3
           maxItems: 3
         clock-names:
-          minItems: 3
-          maxItems: 3
+          items:
+            - const: mclk
+            - const: macro
+            - const: dcodec
 
   - if:
       properties:
@@ -128,8 +128,11 @@ allOf:
           minItems: 4
           maxItems: 4
         clock-names:
-          minItems: 4
-          maxItems: 4
+          items:
+            - const: mclk
+            - const: macro
+            - const: dcodec
+            - const: npl
 
   - if:
       properties:
@@ -143,8 +146,10 @@ allOf:
           minItems: 3
           maxItems: 3
         clock-names:
-          minItems: 3
-          maxItems: 3
+          items:
+            - const: mclk
+            - const: macro
+            - const: dcodec
 
 unevaluatedProperties: false
 
-- 
2.51.0


