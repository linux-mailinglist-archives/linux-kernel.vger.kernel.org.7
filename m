Return-Path: <linux-kernel+bounces-831092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1FCB9B85B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3891C19C769B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7301531B817;
	Wed, 24 Sep 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JDso2loU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8431771B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739091; cv=none; b=ZRALhIGO45IEgKJiS0MJashnM8V2CSkL0i47r7iKXVhdiRuAtb5ExeRsOCtTSvJw4dMb3LLVxpPwxRLA/TnBUBKkOcoG/i4W/bcFqKaIXEaB8367oanG9mJe+RTQokjcm8pVfhfUt9FiR1TopyEiAmJsxJiVoLFgkPyZ+lYE7ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739091; c=relaxed/simple;
	bh=dWgRWKg9c1JS8VUIKBovpHGwX2fAT4eNnMOUTyOCEnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R15ope6dKtpH+8hYQXdiZ0cSUAHqNDb9XG0nLDxXj7qpAh+0s/kBdY/BHPZRXMJKpQHyTHA8FZ4jRIl4zAj9HAER7/qrdN5j8Wwro8ziAAf4nAEGiMWnspVNSVKUKZuWAt7i+wI/XpxuasgP5lRo02Ug7EySE/YpiodOCleGQc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JDso2loU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCDYs0002665
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2QgtMUT3ZcJ
	WxmG8dCgxr0VkowdSceCN1072QlAo8co=; b=JDso2loUSBk3hQ6nJsXjz2z2CVY
	mJw0O1Ul9o1SPoHPP4OPKSlJ+b8RHNXzf2NeqYe4F8m8KvP0kG+/r0CbrrZq98UK
	FD1FAPDAWPmoFLDU3H5b229wrZ+a4dLlHKJ0hXplO5UU0YHGq6OYvHNeSC1BU7H+
	s0hI2uicRkz7Y0NeaKc+qkejjYlAY0+WFRC1rHWxdXX+NyeRibmP4VVGdPh13m0R
	ZhL1fiTripmGVbPPMqgNMj5jkA5bqdUVf1dyzQvDfKotlAHrrscIhtpAyK8bd69T
	W6ivgyJrOcQB5xB03+B+Ppy6hWVWmP+4yBq/NEw3L2FpIGvLcey035sqbfw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajf007b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:38:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-269af520712so1395565ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739088; x=1759343888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QgtMUT3ZcJWxmG8dCgxr0VkowdSceCN1072QlAo8co=;
        b=EG7jMxPnE2/8VXzxt4hbTO6HH9wFxcvSVn0C6JUT4Y588DuKbyvOD9WaQNJzTRDXtA
         Me+Ssit3xOu2TVjW6DELQDIH4zhIWJjlWeo+iPTTr5m0RqRz0J3z3ZkJivANYDT3TH9b
         y90DeoQDSE79hqNT5BHIbUp3ueRjGU5ZMsJlG/h9GcZLMoRIVsdVej2a8gFP0lXU+kkf
         u2oJ7iRTbA3nossxnf8r6SQHHTAzf8PkGGw44LAi3t8lbmGED1daPvlTCZGbc0ZzWdf/
         f4wB2zSRa08JWI7Y+fkJl15D8m51wlESRvaxczHnPzzbDLDQ/06SXBgsRXsLh2FIzppe
         44tQ==
X-Gm-Message-State: AOJu0Yy3TF8g5rwCd6YHHpiQ/hlfR9kOZz6TJ959lEuQTuhJF6PJ4OKB
	IivK3MkHr6YN0ioTZpVF5d7mN7pifQAgRN+/VwBdEPbF7nDACnAj11ShgFguqWSWm1vpWGsbteX
	1Xgqi6h67za/V2DD7Y9WUgdf2R2EB49O8q/hmTL6azBj0Mrv6XEwPfz2xubM6KAJNjkw=
X-Gm-Gg: ASbGncvg6MTBCJnY8KcDlsX3nLYGhpTWJqwl+8iw/BZKOd7D1/c0oK7C/jLzf29HuYx
	dUW1EWn/Lia9mwwLNI/FJ0o2rCjUrno+6qsleQuMmJnRorhea9IMU+Jq1qPVS5Okp+pjcwo7eey
	yMpolWj7mqTE7sS0GXNfohJMe3zhuuqh4bk6XyttRkDZEi2t/3360j7gJ5QP/QkiGpAJFUai9mb
	6S8PkgWy127RPcn9QaNcUwZjb0sKo6DNdYqYCqPiwlqBfCsO2pMCMG6aIGK/xBmf0aji5Q00fgr
	mg/rhe6546Rf4i54zDYtJKKjLmWUteAX9COD0cxKYin52B8Uef/0BZMPmqNsEc676oZCagy8d50
	D3XP/kcbsTJ63eEDKXqNOgsz1Wx2PHfzRxuFdv3eYRGvtAs1bKugCimo=
X-Received: by 2002:a17:903:384c:b0:27d:69cc:990 with SMTP id d9443c01a7336-27ed4ad102cmr8561555ad.49.1758739088483;
        Wed, 24 Sep 2025 11:38:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwx0Y5BNx/AZf0UKl2QB41ev/gZCluSWgmL2NlPqiBpOXayzifxVIa2OG4y7bWAT1hFew8XQ==
X-Received: by 2002:a17:903:384c:b0:27d:69cc:990 with SMTP id d9443c01a7336-27ed4ad102cmr8561265ad.49.1758739088033;
        Wed, 24 Sep 2025 11:38:08 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b555adca754sm6523412a12.16.2025.09.24.11.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:38:07 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, mani@kernel.org, andersson@kernel.org,
        mathieu.poirier@linaro.org, konradybcio@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH 4/5] dt-bindings: remoteproc: qcom,sm8550-pas: Document Glymur ADSP
Date: Thu, 25 Sep 2025 00:07:25 +0530
Message-Id: <20250924183726.509202-5-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924183726.509202-1-sibi.sankar@oss.qualcomm.com>
References: <20250924183726.509202-1-sibi.sankar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SJB9zLcerl-yMHKJa4T8iPkrYmY2fvFm
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d43a91 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Z4uQfrFFlNbWx1whHNsA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX+7UvQG1NURuh
 ayK1IHsLFphXdaj2ja/3i7qEgRvvR6xdXPxvZZuquewkA64pYvVPYJj0Iiq2ENTBjNnHvutXsp5
 Io8zogiMKVTY9Sntx65zOGzvyDQiIbhLGkRLJ+vVXryps8Y6IsRxklpzzCU8O+3uriDpbyeY0f9
 ZDgxlrpgSpcHfzXBxdi4AZr8G2ZXrhrbt9cIbka8EAbMK2o22M1wdTPSkdqePK9blk3uH7y1J5l
 R+e4D1pnEG9pl0E8GNNRl/swVkIozqSJ7V+lTN64JP3mb7G6nloCLABLEkHXnO7QqMboo2uslGJ
 dBJH61xB7JWaG9ikcllZvG2SEsaq6X2Gh2X/UsYT8YfK86Dqy+6lQTXlHHRC1ZUMsjdV8rAKY8/
 ueUylTir
X-Proofpoint-ORIG-GUID: SJB9zLcerl-yMHKJa4T8iPkrYmY2fvFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

Document compatible for Qualcomm Glymur SoC ADSP which is fully compatible
with SM8750 ADSP. Also with the Linux Host running on EL2, the remoteprocs
need to be hypervisor independent, the iommu property is mandatory to
ensure proper functionality.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---

Dependencies:
Peripheral Image Loader support for Qualcomm SoCs running Linux host at EL2:
https://patchwork.kernel.org/project/linux-arm-msm/cover/20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com/
This patch has a dependency on the iommu binding added in ^^ series.

 .../bindings/remoteproc/qcom,sm8550-pas.yaml     | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index 2dd479cf4821..cba45ce2865e 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -28,7 +28,9 @@ properties:
           - qcom,x1e80100-adsp-pas
           - qcom,x1e80100-cdsp-pas
       - items:
-          - const: qcom,sm8750-adsp-pas
+          - enum:
+              - qcom,glymur-adsp-pas
+              - qcom,sm8750-adsp-pas
           - const: qcom,sm8550-adsp-pas
       - items:
           - const: qcom,sm8750-cdsp-pas
@@ -95,6 +97,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-adsp-pas
               - qcom,sm8750-adsp-pas
     then:
       properties:
@@ -185,6 +188,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-adsp-pas
               - qcom,sm8550-adsp-pas
               - qcom,sm8650-adsp-pas
               - qcom,sm8750-adsp-pas
@@ -238,6 +242,16 @@ allOf:
             - const: cx
             - const: mxc
             - const: nsp
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,glymur-adsp-pas
+    then:
+      properties:
+        iommus:
+          minItems: 1
+          maxItems: 1
 
 unevaluatedProperties: false
 
-- 
2.34.1


