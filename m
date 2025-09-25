Return-Path: <linux-kernel+bounces-831627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22DBB9D2BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF415188875B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680842E5B26;
	Thu, 25 Sep 2025 02:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TgTyJgEz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20272E8B76
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758767344; cv=none; b=O0GzBbVmRkVIV52YW+TKHQ4M8jJkA65FghbIZKPT4QZR+zvTQbTDDg7Bla2KjG9HUj8iUe7DCB7bo+xUMkPL5GV7gFKUS9HUl8G/7AQO6MCfrtzRTmKfIIPdLzYX7ecIUJftrOOU9sJ3mNy2U0FE+kz8zLyq+tUBT5M7aGxQNYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758767344; c=relaxed/simple;
	bh=y84fa6fvuCZpJxjEsWR6XfroWoXIZOXTyVARiLBoUh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jK8swWWuzY9GHIF6c6aDY1EW7xFYlPsxVDN7ekw6d7LRHeXdSofOOAzYnfY0Fd5KAGB+dIpeeydd3wIbOQGZezeaqvFrOl56kLcusRQQUiuYv+nfC1+GGU07Xun3GphP4/7O04q+hEmKd83f79873FOp5GQHqFD96EZMYc881dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TgTyJgEz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONhlBf025089
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=g6hGIMMv3wb
	uPomMpx8H8k/GiKEKmx7JPEl9gfJaIng=; b=TgTyJgEz5m3fgPKD4Sl7yF9a9ZV
	TAVlyJzb+FBraXJmeOMvYMgh4Nvixsx2BSJgtQ1dLDCIFdrhvmEqreb9wJaE6sKK
	0P8WF0Ip2xQVyGz4TeT60GwAEivy9JynXu4eFlYiE92HuVxCb8rIQVigRa6IgdlW
	Oy2criHyD8gRzubKKH/iLjWfnfcs4j5VdLix/eJ4qtX6aUlEU992zwPrEURjHe5F
	5YqkvCC+i+mnDOP0WphR6eoRxeUNsZTTW7Q3Yf1CdiaY+fO069rHNj7U0gHP3eUj
	v2vzpbv3daSFvq2E5DYNTv6MeCpHuoqrK//6pqI4NIH6BipcEDZEMR5Bf2A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyexrn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:29:01 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33428befc08so890945a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758767340; x=1759372140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6hGIMMv3wbuPomMpx8H8k/GiKEKmx7JPEl9gfJaIng=;
        b=vVuPB+BGk+3uozgTOwzfTPeCI54rNqDdHRbgrATnjukBUmGcmM5tSJC+h3bQtLC2Pm
         fnpY8Zf9VNkUqeGKcDsA9tZPkO88PC6bc2t8b/Dv6ZZpyOiHFacsXiyLBL30+1imcGB5
         PzZxe0o7JI/imJyQn6al71AsQdgUw60QIzjP2kr58C6WwKUSfepgbwnFFx1BLcmFUhqk
         NVY/wvtgNzIaIpkZPqfxXqsXTk+idD6D6Ph4HUUhbmEgGdlJydAQ5pKcCruFHtdHzkBl
         IQ6Xxo+o9V80rsoMlToO9wG8Wf2N5+r6bl97cP1aJm0a3PIIDtN+Dme53sOOqx65FKZ+
         jhoA==
X-Forwarded-Encrypted: i=1; AJvYcCVJk81hPyEq/9RDx9mCUKJ7xyPUDM1leIZuHAnHv3rbTA1U+LUGHs7Chi6zdCJJD4ddYtgDz8iYXsvtJrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1tY3XPZ9h8d4YIceBLgBvMWVW8Fkb/oYGx3CuTlhq+loP6e0q
	0xxV5DcsVa649ql7X64GThCJ3dL6I7JtKdSvz/F0gkiD8BWAqFglG3vP/Uds4nZkXIa87njLE2y
	t0wWA0rPni6xkPRNPPltmSnTIXxUT73z0+t9sTcHKdHAVoxBLuQvzxB+MO/BzYAhhPAg=
X-Gm-Gg: ASbGncvzJLcxaLrAbp8AdjdSMyi5UMyVCiuyCie4r2hui9Yi2/C7z4i1y95DsUOieOk
	bAF7Ie28dFc7w3E8nStVoTQxhVIH+9eMyVvdNPt1OgMWY+MOOsnf7yniPH+Q4BEpcg118/tN0qP
	wWhEMO11jE1fAlIBwWpIImzfEyeRz7L0R3FWUdYsGLPRuQAYvtLx3+TRqhzXuite8ajoUB6YXMp
	T0uHSxJ2a0pyn8dE0N4LaPXGGu0aIHMa5FitS2RzoDpby8OcY9sL2ihcMNqGIlhx1bKgu66MbR4
	roPO+liCuIyFK+euEIc0EOedE53EMtXof5xaAMVLN4qQOJ5uf0Uht0bLViACYaw74w9EcdwH8Rh
	yjNb7dGZ9VJfP5Xpx
X-Received: by 2002:a17:90b:4b43:b0:32e:e150:8937 with SMTP id 98e67ed59e1d1-3342a98796amr1499463a91.6.1758767340230;
        Wed, 24 Sep 2025 19:29:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgS7ZXVL1SYRcZLxlWvLQ8xVEim5+C7vl+IPW388/ukbhvZuVXDcTXahI9NwjzjZtEvK8rZw==
X-Received: by 2002:a17:90b:4b43:b0:32e:e150:8937 with SMTP id 98e67ed59e1d1-3342a98796amr1499441a91.6.1758767339749;
        Wed, 24 Sep 2025 19:28:59 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d711ecsm499881a91.4.2025.09.24.19.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:28:58 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v3 04/10] dt-bindings: usb: qcom,snps-dwc3: Add Glymur compatible
Date: Wed, 24 Sep 2025 19:28:44 -0700
Message-Id: <20250925022850.4133013-5-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
References: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XjcLIKy51nuS_2lrUZUb7NiDnZUlp-iX
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d4a8ed cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JYTQWVwI1XGucIoeipMA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfXxfoSgFrd/ULE
 9LOJgmONBeFsHrja3K5jCM23FPM80xkasuLMgx+OqwwG9yZbA1NQbALF3/nu/BHfk9FL3aAH/GZ
 6BVDgDHiWxJp61lM1bi2fuiV8MXzYaQj0fG0kI68JIeE3qpj4uEP3e91gBDNG63Au8o/TSROFLc
 oHD5POEM8akYAF132Df2pitmyT49uepQT6cacnS1rMT4/FT8SGyXB+Eh1mw0YN5/Aw3pdMk5BYI
 7AZenWCjRBmV8h4vMAySi53fYlRq7PZdHTSgUF85ClGh+iCBnxL4hYistmWdlPoc4ga8DeDgS5m
 fBsMNd23myml6PHl6NBjnrNCT9I6c6pJox0ODKENeCV0OzCMBo4nh5YJvoF4fyciK1zjLJSTzLH
 tHsETbd1
X-Proofpoint-ORIG-GUID: XjcLIKy51nuS_2lrUZUb7NiDnZUlp-iX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

Introduce the compatible definition for Glymur QCOM SNPS DWC3.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../bindings/usb/qcom,snps-dwc3.yaml          | 26 +++++++++++++++++++
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

