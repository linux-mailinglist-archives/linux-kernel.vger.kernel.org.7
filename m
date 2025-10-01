Return-Path: <linux-kernel+bounces-839569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7F3BB1EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BBD7B1CB6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420AB3128A0;
	Wed,  1 Oct 2025 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DueehUeZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD743126A2
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356347; cv=none; b=MpsXHoDyYeKqOLYXDfFOaJ3Yhho5LhzSlhh26EmaQ1ZrtjNNin4tUU5fNsxjDb/bnKA9OemP6bp1ViWbPbTKcUNJziYS3xg2tHUS2sJqoGoNeMava1JreVXSmOqJa1JCFrOsmpQ/NDXgzwDqRcxgAGYEhD/WTzbe+cvi3ClYbkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356347; c=relaxed/simple;
	bh=y84fa6fvuCZpJxjEsWR6XfroWoXIZOXTyVARiLBoUh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SEZuAXRZ7AzqYEMcc4QXjuzMYRnBc+SXT53accg7JJCRaz3ocSteHLyFuZdoQJ6GKiPo+tGw3vLXEWnwBSKlpV54E4KLgRnb91NbrHCSELmHbX39kDHlqgb/sHDzjsIo4KXzOGSxSuPZXRIlsjAYjPFWkGMMaKjdC+0YST6M4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DueehUeZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IbxOh008317
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 22:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=g6hGIMMv3wb
	uPomMpx8H8k/GiKEKmx7JPEl9gfJaIng=; b=DueehUeZ+4geCNy8yp8SwdJiyHg
	Hz6h6cptSo4H/sSW4inm8OTiTt3cCWtnX7UpCJEJPk2scrUTJYOipJpUSH3tvbGM
	aZxZXI1Ozk1V4+EwGrkJ2mpkcgOgYfAl8n/Vz+yT64fJuOQEs946BY38DEFkyV3z
	8hrxMYo/0K0m9z/GejFvm/Aw4TNSZj6XllFb4Xiyr3UUPr+VhiDP1REzDPqeuxCH
	KmXzTOWqMjdeJKHvMaDV1bT5EhOAeUCu9aOYsi9jo2fZYFvz2Gkfm9umx9awLsTp
	lWKhRuvacWb60rmdLCeWOMd/G86OVUBS2y6HXRK7i3ELrlbRACyi/lIbj2A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49fppr9dj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 22:05:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eddb7e714so296102a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759356343; x=1759961143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6hGIMMv3wbuPomMpx8H8k/GiKEKmx7JPEl9gfJaIng=;
        b=F3f3dprhcJPnwvdkWzmFbGq6Jq6e2S9dIHoes/75OzXRv6M5E6O7/8Z0na7wlkNKKb
         Fzcobg8x7rV44RbDAQVcuyFccqgMT1MfOXSnny1gOU30IrmG0xrpoGPajFONfsEhL3M3
         mf4UVhxCMv2Tofzgk0lJ3YM8EZInC3AcWf5bdhtzVsJY+ORv3zDLehXh/zaQEOkLsPgr
         Ud+xjDuUcjRySRie70CN8STrBFJ5qVQR7GpXq4SbG5wujzrDc16BuzsKLUrvIRvqM2cH
         6OnOVlldrPeicsJMzHfZqaKULgF5vDp/olHYAh1pOcY5IH3yccdg3k+6e/cRpN41y48L
         CgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0jYPNExCTTlG+k6Ksl485O5iJ4f1aGSBBStEircTS+ei+Le6lTl70wOSUqoLfhdbLjURATMpAwLTk9dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQzscus2TOmYhVlm3WbysD4zmg8qw1hhqLvewC8iDvf0ZRrdIP
	rhIeIbSQhHHymMLEFcTyIktvw+8w4J54FTQ7W4nPTh+bXJdps4I+WODvv1NrTGioHEz9Fy5Ix8X
	jyH+EhJtatDoJrPyCHDnV1eTQYCtT7HbTwkKG22QyxKINEI5KrcFod3VXCO2aC6EF/rg=
X-Gm-Gg: ASbGncv6D+XC6giNMgDafo3dljom5c0/y2R3zAswNoHSgV2dna2/ma++OnXK6Q+RgLu
	wUHsuAfXpf1MHnUbIyFhjgkg1VJTOi+gHenUXqHGUTA2QxKEyTfIrU09G5lSMaxMBUfdhO0o+uD
	L9Il9JI+Xrn/gFE+sFOSWAyvmZ33G8U6F64jt4NGSTY7nyYa8MMV2omd8XXrj+W5KiJrL9S/z5N
	m39BxxkbIzFXd7u+M0tJVN6geJoeu2XKlA2OJYRAmU5DeqkuHDYsYqOp8Hwj34uvHsoEoYcdDeO
	N2UOvQgHHE8WIdRDzzG+1I/4fzdTU30BqQweqQXMntPhtwIQ2RXOO4iZxVELLT0lEru5kqgtwC+
	pCYi4cWBBW1Zh4Wi6Oo4/1Q==
X-Received: by 2002:a17:90b:1b0f:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-339a6f3cde1mr5653501a91.21.1759356343295;
        Wed, 01 Oct 2025 15:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMYMlMROsnj4h+It/s+6vj6sTVkjqirS+NPrscbKY0wqq9o3/qEeNlWw+iTriGWj/gWEZ7vg==
X-Received: by 2002:a17:90b:1b0f:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-339a6f3cde1mr5653469a91.21.1759356342817;
        Wed, 01 Oct 2025 15:05:42 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339b4ea3c3dsm702085a91.5.2025.10.01.15.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 15:05:42 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v4 04/10] dt-bindings: usb: qcom,snps-dwc3: Add Glymur compatible
Date: Wed,  1 Oct 2025 15:05:28 -0700
Message-Id: <20251001220534.3166401-5-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001220534.3166401-1-wesley.cheng@oss.qualcomm.com>
References: <20251001220534.3166401-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA4MiBTYWx0ZWRfXx4aSIjnZAePm
 1xI2njtMcKt2AGExrpDBFTTgLEQoKoVKbX4OJ2vzp5tId9vsRx6KImYO2RRs1cnEbkVZo+dgSv4
 lIpDRMzXSf2oIx8IOJSPeGKeskoL1OsYu6vYOO9lBmRKPFb9PxzJbgvWzNOBxRpSOM72Djw4nx/
 xwW9w3dM7LVAKj4iiwTucBZFjSN5A5MDyFTr5pgGCaWXFG3BP7GaNnTFyDNiehAziNNWgDqphAz
 QW6NYpPODG3GM7EGWZ99ZgSBiUih2XJWZBHWg1njX1cZUCBqPDI4+3JFj+wzTiH1xOo3OpIZO27
 DYLvo2+c2dUs55es00Bx4zKU6GRASvSFX/ZWOVA/0H3RGvaF/eCa5oE2o8XC2VLXst0PLa+b3dO
 4eec4ZGijKl0Xtr0Z5UNN6paNIy1bw==
X-Proofpoint-ORIG-GUID: PNEVBzUeHx0az-w4DJ0eRkZXkXjchVnj
X-Authority-Analysis: v=2.4 cv=GLoF0+NK c=1 sm=1 tr=0 ts=68dda5b8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=JYTQWVwI1XGucIoeipMA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: PNEVBzUeHx0az-w4DJ0eRkZXkXjchVnj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_06,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509290082

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

