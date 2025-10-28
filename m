Return-Path: <linux-kernel+bounces-873114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CD1C13255
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9E194F72B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9E2BE7CC;
	Tue, 28 Oct 2025 06:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FM4dVzLG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0643028751F
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632897; cv=none; b=apE7/jq59l/BTFCt/1raVRleUwJfIEdXnGCAdS/YoLngqTh4YhV1L2LQxxySVZhLXrMi5vVPl8wUiSzS6Wo4m7pk2lg+a/uEyiayo9tCLBBoqgpza0l9xBnpONjw5Csdp0EnomVPyNnV26Nt3gYUumX0QLJOQgC1m+zLI5ObMf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632897; c=relaxed/simple;
	bh=PPtBIz8qEFvPp66GNhz5hdu3RpRfVBfYsLuidxR205M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uo/mYZPGOdS54sbu8hOALBr9sr+OWlyu+FB7kQFKYju3lz+dWz7DKv/iWafal0keZeFoOMpKNIJtDymDWyvAHTujdWvfd1/8a10xdlxYGLDEF5LJpqW5oHDwYTNNjupV7Av67UBCgt7odBYBOpRxl2ONblfnPn+HxglBakHEfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FM4dVzLG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RMY0ts2752236
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cfzo+zhajCDy5YoRs8Kez4QqmFzyjmbKPNgTAWkNhwg=; b=FM4dVzLGC7j99Mox
	3ZyFb8DhfHrblRfE49VgmXsWH7fS1hh5ezbI5Q/+l7oHyMwQSAOtcEKD2hq2nS+3
	5kMe1mlpT+s3EiPtHNoXhz2PR13wbfB6nq0BdN3BdODxjUfjc57r428SKmgFPcr3
	TxWsB2c+8lHYLXkyZWlUXUvy6yJ2/KOJT2ys2ytDpnf5zt5tZvTcsojtg6KWBcJf
	DVZLx+r31e4RYMs7w0gB6YJw6IXQ0A0zesP+L6tFMGBBc8Tq1NCtQAHjKgvZ7MJX
	BvPmhl0SiCnJEXYcDTQhe2sA4zBnDmCOARcWlLIfwAoz23c9YBdmeSLX4jEvg7E+
	xiksTw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a28swjw2b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290ab8f5af6so35430545ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761632894; x=1762237694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfzo+zhajCDy5YoRs8Kez4QqmFzyjmbKPNgTAWkNhwg=;
        b=tsJxAbpiTP73E+5ZsjD6LujunAXzwasY43yzckln7hBahcpO71tkxNOXaMuvArzEYN
         xSTq+7o/WKFCynGu6I26iuleVZlA7sbMzFGUCfsCa3QUOrR3pbXNHcndwToJNy3fwtmX
         /ftAbhKdk67Eydy0ime9uWUZn6kV1lbUDhwY84HdtPKoM2Z++PzdVcCro7guaaM4QE/j
         S7VKasM+ExRlsnKAFryDFvPYiWfcwoVBPRfWMjWFaFV6Gh6Sq5snuQK/a7Li8Usq6Ey9
         RKqPnBUczwQ75ss8BWzQlG0EN77GRnM5HNhT8+OxG1iAxAzaKlKOUeZc3DzDab2r9yNb
         cxNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUphuGLyLFhsACj72x2D11Mhlovu0ovrP75oY1ppgXvw57Kp06/c+VEyD0BshN3Mr4X42o3yrfNDvNtWHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNaZ4xi1O2lWnXqCpPch/uHuRD8K8exmXhsGoFK7XAmyCcZ1tG
	7sDUhuhkiqR2rOaLFcndawjls2bZ2TwjUomIwk4YeLkaeoMVwb9LrOOMYHD4hS3zpe0TEci0/Hd
	C3bYGkItj0PUvys00r5hCnI+jQRUXYpAdqASIzUdhLtTOP+AyoFE0B9cc7dwNsfFbGZc=
X-Gm-Gg: ASbGncswJRazmhKCA6oY0m6PRRjLlEGtIw46yKaVIijv3J3fGSWfiIFeXdelVdeb8Va
	Lhj/+8V8Hu6Dh0TrKioyxZWEiccZVQFTPk3jxOLMusQhi05mCeIieb+uVbG1UWcsQ4qACK+NAzu
	lD9G59rO+/2G/nCyJIa4C/fxMSdbpnk6hg+Z7DFBoQ/1JQdEe2YEUUcWc/IiwL/w9SfH2i2wTD1
	4tmHve1OKAjSVPKBv5xH5JIh47d2zO4pU2iO8+Ocq1BBS9FRhPC0hujWGst2LGT4u02bggz21o/
	g6KVZniqwU7MloZYg0bX3tfvNmP71S95OR5CjGRzJrOooHQVP+uRsEpVZsx6GZgJJfQpHeYptH8
	d9Klx6MAj3Y7EWAgVmJgzJz/+ZeWQc4kudNGnbZAdXs9HzHhfVjOksmXE
X-Received: by 2002:a17:902:e5c6:b0:290:b53b:745b with SMTP id d9443c01a7336-294cb5232d3mr38383875ad.39.1761632893878;
        Mon, 27 Oct 2025 23:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLMay05a+vAXuQxOkbTQFiIgxcmfZljtBPlP7Po1PvPoXnE7k7Y6n0QTmLswWPRio4+BUB6A==
X-Received: by 2002:a17:902:e5c6:b0:290:b53b:745b with SMTP id d9443c01a7336-294cb5232d3mr38383555ad.39.1761632893438;
        Mon, 27 Oct 2025 23:28:13 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf359asm102503265ad.12.2025.10.27.23.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:28:13 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 23:28:03 -0700
Subject: [PATCH 01/12] dt-bindings: arm: coresight: Add cpu cluster
 tmc/funnel/replicator support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-cpu_cluster_component_pm-v1-1-31355ac588c2@oss.qualcomm.com>
References: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
In-Reply-To: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761632890; l=4225;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=PPtBIz8qEFvPp66GNhz5hdu3RpRfVBfYsLuidxR205M=;
 b=xr2MpTWnfc1z9/DYs0lmEaPgzO67s3OtRkMFlUDMRC0QKViHGXoLtClSlhp7erTCm29OL1zn3
 8IE3NPo0bKqDB+lxtdSRdV7bNd5lvpqfA9voMhVZAzwas3ZA4x0zJFk
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Proofpoint-ORIG-GUID: vrqk3Bxa0tMZkptu2RExKjCmxNrhruOr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA1NCBTYWx0ZWRfX9vTqt8hzFmWy
 AxLCXwkDzHPMb8Nw5UuD6wjZILdRdU2txEJR42T6d9mumb9a9IjjrAUmCGTLvo1M6wwJdNloOVb
 qN22U8spyEwOuBoeCY4FOkBFpNWx/hZ9WHmyiA/TTsbIzWIfLCBmKbbQMT/jkZ4iOKB+YbPvfRC
 ICDDAs1qsiLS1GQ+pAX907CMV8TMyeWYQyQ3jPw9dGNLDCQbCKj48zzaMWDs8XaRr/RSbQ3uGt4
 SMoh+kLSghm3lCFdlnkowoYh0mehHfV9auFT+g7/q+n6R3mHY6M0bhSyi51DsS1L1zqj1cDScTD
 0BDICfl123XVpdweaxuC5EeeqettFCSMV4Wxdsgmfp53Tk3Honxj/HUpZ9zYxOVkoQxG1j0ThB+
 C/ZpQL7dWrRTatr7wrtnzh7Hg2XDMw==
X-Proofpoint-GUID: vrqk3Bxa0tMZkptu2RExKjCmxNrhruOr
X-Authority-Analysis: v=2.4 cv=fL40HJae c=1 sm=1 tr=0 ts=6900627e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=G4amIDmpmRGM4OpAro8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280054

Add the following compatible strings to the bindings:
- arm,coresight-cpu-funnel
- arm,coresight-cpu-replicator
- arm,coresight-cpu-tmc

Each requires 'power-domains' when used.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
 .../bindings/arm/arm,coresight-dynamic-funnel.yaml | 23 +++++++++++++++++-----
 .../arm/arm,coresight-dynamic-replicator.yaml      | 22 +++++++++++++++++----
 .../devicetree/bindings/arm/arm,coresight-tmc.yaml | 22 +++++++++++++++++----
 3 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
index b74db15e5f8af2226b817f6af5f533b1bfc74736..8f32d4e3bbb750f5a6262db0032318875739cf81 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
@@ -28,19 +28,32 @@ select:
   properties:
     compatible:
       contains:
-        const: arm,coresight-dynamic-funnel
+        enum:
+          - arm,coresight-dynamic-funnel
+          - arm,coresight-cpu-funnel
   required:
     - compatible
 
 allOf:
   - $ref: /schemas/arm/primecell.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,coresight-cpu-funnel
+    then:
+      required:
+        - power-domains
+
 properties:
   compatible:
-    items:
-      - const: arm,coresight-dynamic-funnel
-      - const: arm,primecell
-
+    oneOf:
+      - items:
+          - const: arm,coresight-dynamic-funnel
+          - const: arm,primecell
+      - items:
+          - const: arm,coresight-cpu-funnel
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
index 17ea936b796fd42bb885e539201276a11e91028c..5ce30c4e9c415f487ee61dceaf5b8ad12c78e671 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
@@ -28,18 +28,32 @@ select:
   properties:
     compatible:
       contains:
-        const: arm,coresight-dynamic-replicator
+        enum:
+          - arm,coresight-dynamic-replicator
+          - arm,coresight-cpu-replicator
   required:
     - compatible
 
 allOf:
   - $ref: /schemas/arm/primecell.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,coresight-cpu-replicator
+    then:
+      required:
+        - power-domains
+
 properties:
   compatible:
-    items:
-      - const: arm,coresight-dynamic-replicator
-      - const: arm,primecell
+    oneOf:
+      - items:
+          - const: arm,coresight-dynamic-replicator
+          - const: arm,primecell
+      - items:
+          - const: arm,coresight-cpu-replicator
 
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
index 96dd5b5f771a39138df9adde0c9c9a6f5583d9da..d7c0b618fe98a3ca584041947fb5c0f80f1ade6e 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
@@ -29,18 +29,32 @@ select:
   properties:
     compatible:
       contains:
-        const: arm,coresight-tmc
+        enum:
+          - arm,coresight-tmc
+          - arm,coresight-cpu-tmc
   required:
     - compatible
 
 allOf:
   - $ref: /schemas/arm/primecell.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: arm,coresight-cpu-tmc
+    then:
+      required:
+        - power-domains
+
 properties:
   compatible:
-    items:
-      - const: arm,coresight-tmc
-      - const: arm,primecell
+    oneOf:
+      - items:
+          - const: arm,coresight-tmc
+          - const: arm,primecell
+      - items:
+          - const: arm,coresight-cpu-tmc
 
   reg:
     maxItems: 1

-- 
2.34.1


