Return-Path: <linux-kernel+bounces-790835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DF9B3ADD7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B67583BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707B82EDD45;
	Thu, 28 Aug 2025 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ibNKvDax"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB282E229E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756421318; cv=none; b=TEpwQaA0gjC7EXrj3orNDggn33hur9017YgrBjwHio/8p1fepFtaj5THb/+b+2wo8oEDEa2/WNagSz9DqEKizW70fr9DUATpirsgt4HC8QW354B7WEj60Fm9iYzXS4P3yhfaT78Dw7iagcu7Ga+047/rbPkeCoDYX7LQfZl1V9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756421318; c=relaxed/simple;
	bh=ckYO6kXK6LPmIWp1Ow/ZA2uLvZp9U+rQduyPy8DeDKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jg8UGUROwuPtY0DVIJzpMDDXPjBouyvlr7dYLlvRP/N1nrvmIp1hI8tFbehIh6OLdXPGNZ1hQuxouX8LOe3sRLm5IRs2iM9sJa0HqVZRt+cU68ASUUILcWbLlRll+eW4+sFJ+UO7NLmNPIvdhyMBwmK83ImRJMIpxuGKvwoo0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ibNKvDax; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SLWauL024755
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qOieTx33OYOAntck1pu6Ux3Fbf2SwcnRNN/9vHg8FaY=; b=ibNKvDaxNya5Qw3k
	HJivG8SC466TDvAr0uW0N3WHRG98/trU+OCA0F7l4GnobpgvAf9k/s8YtsCR9eSs
	gdexfLJtpeKMMkxNQR2kz4nXcix0vwSSNqRWraRwtWs/4Ool2Lj8DabWf5rqhnwi
	1Cppzx/cEVb89x82LuwxwvJaA2PngdhXqtVIOi7JEc7YBXSxB4I6PcyOMtHdCSBp
	oqCraLSy6EaU3Q4auoPGwxzvz0v2uOxbqyVLST4n/AiiyvfPZVsDNasfOiCJXZeb
	BB2PCKfXw7VAqKyeMgGjWnqYO4yRPY5dva9QZAklIe9v2eFnTkqo/OmRaz2+p81P
	K+EWRA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5up1v3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:48:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b2a1344b36so28299231cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756421314; x=1757026114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qOieTx33OYOAntck1pu6Ux3Fbf2SwcnRNN/9vHg8FaY=;
        b=C82uK2u1kh0BsbaKWECbSqiH4+zkQqNRk2HB2AA2tVy676bOmrbMk2mATgNHCvKM4O
         Y1Sbk/OLKIkcAV8Hp70dWaDXDN2oHa4ditBn7e83gjyn0Cl89Uf8ZeLl99TRz4X2lzrt
         /zTDjkO6eyfYyRxN8OLdq8VxHBM1JJ3noTb8+MM57WK3cAKmQRZNcWEkecDkURLtrTDo
         c5paT77ICvOZP+B5+nOT3WegFHTI70FQ6Ot7fWwRcK8BQv7yumKuq6NScYe/iVwRZaeu
         tb2bQTL477Hwv4SP2Y4CRyxcP8MpCKzBiRBD6GqptxCPvudExllBexLIJ0VD+/Q2mJPO
         r5Bg==
X-Forwarded-Encrypted: i=1; AJvYcCU9+dzj2MJ5HCyU4nGKBD6iYvQZHNed4cXJjKpAShZoLDOQq9LJa4jBOW8TZ023JGFlm9Jfo+LVYnPu590=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrhZAKn0iKr2QlAcHeRHeBuHBTD2kUnEyS5lhESUk0TxL+vn4S
	N/x6GagnXP/Itg8MbeWL4gC0cbKRZLfr3DM3MfJ2asb6wFDetiVJ7e5fpYdOrmc8ffNgL4VbETm
	96uS6MjBKq6xyW2I3WY5EHRq09Ji3mIZRRRDE+h64ITHgQcdFQ1SK/1uWY7mnztGm2jo=
X-Gm-Gg: ASbGncusctupewCQWg2h9WPwThTVK3d381Vnqjv6ZUTmyUTVmDDFWmQ6fhUMCtfvfK/
	PM4DJjq0qoRlbJV1V3z1nMWy8P14PAgiAqMdnejrnel0E6bVjls4dc81ItRzEP0RCmd6WFqfqtB
	Ty9T7e03VO9h1AGFZcp/dZ62KwbtMKw84p4DKATYHCvnFUxnQyXRz56oOwlh78zz8milEeVU9iq
	thZAx/hASuJoHepMw7bNCpo/5Vzng3hJ9AzortOgjkd5UdKJGUk+6waU+dKeS6fD3IjBoTZPiTi
	5baw2yhXXc7ilhZT6b0wddORdIBA4fj97T+aL1SoLEvlSWlMTiGJvXQ0WIVlUbo+kKuwL2n12N3
	xNDhBxe/6cBzOsriaasA/tQXLqWqQcORRowtsSszhGNvju/lHY3gz
X-Received: by 2002:a05:622a:1a0f:b0:4b2:987d:3992 with SMTP id d75a77b69052e-4b2aaa27e0fmr265756881cf.14.1756421314186;
        Thu, 28 Aug 2025 15:48:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfyvHqUxvJLfJeMWH5JgSwxE/VCHcSLym5cm/Ee7aWYkPEXlZsbqvRqR+C+qyKVz+azHQCjQ==
X-Received: by 2002:a05:622a:1a0f:b0:4b2:987d:3992 with SMTP id d75a77b69052e-4b2aaa27e0fmr265756491cf.14.1756421313597;
        Thu, 28 Aug 2025 15:48:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f678452e1sm143807e87.85.2025.08.28.15.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 15:48:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 29 Aug 2025 01:48:20 +0300
Subject: [PATCH v7 7/9] dt-bindings: display/msm: expand to support MST
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-dp_mst_bindings-v7-7-2b268a43917b@oss.qualcomm.com>
References: <20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com>
In-Reply-To: <20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, Mahadevan <quic_mahap@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14870;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=C2VsL6/7386lEMyPGm3O80Fg6Ts6b/RJXYqdb7O+DBw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBosNyxInvewydByX657ZIdq5YnisT50x/iMvVoR
 6vtA+85z4mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLDcsQAKCRCLPIo+Aiko
 1el3B/4+gw71d+6H6vzQlsJHjRbJ6xmik/0xR5d9Bj9fWRC7xbHwKuxz/fiP1iceYFVjj+g4qUH
 8z4fnn7gaWzTp42H+kSB7xqcuHEVmUXUhtnLKiCOsyoi3E7Gm2eyMWoxLcSj7AffVEvHBPdVKQM
 HmgD9kv8zH/Gtbs6errqaCRlEeNHWu349dOiNdM9b8iDpuRh+Pb8mrQ6KHcMd5E0ohhrlQSSdeN
 AZ3Y+ddwE65V+RtIGjLQGiEncfeNUUDl2TX7yX9gX2llZS4juWXe0XbOvaITGXdUYt5Dg/m8FDb
 48LXjUC1LjEoldlYPbbgxmmOdnjdnDLRO7FsIMhTUh7jFSks
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: KahPPpXkiVy_UM_FR4IrE0KuPdt1rgja
X-Proofpoint-ORIG-GUID: KahPPpXkiVy_UM_FR4IrE0KuPdt1rgja
X-Authority-Analysis: v=2.4 cv=JJo7s9Kb c=1 sm=1 tr=0 ts=68b0dcc3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=uRafYTt1GBQvBzODlV0A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMSBTYWx0ZWRfX05jCRKYETlOP
 JkYtvj6tHpCgMnwTHgtMje9OPZsRCOQoeIQkIhIRKQ4L++0rJWN3azXWVttQxuJ38tt7omWs2IB
 2LqwxCoc9u3iwHQXgU6giGcpr8wy3azdx7us8TMqDSpTAKQQNxPB5dGTFcf/7MfGXN36Ks8yG1w
 f5dBz6M22n0ZDQza5QvIJWsIMaGb/dGDiCGUDbK4bdzuO7azsLxI/uACWdWTke/j1H9Bd6esNWw
 Chjy9Qt1hWC0GEWGOtLjYhLGBUARfGjhAcZ+qXVe8KSZuAHxcf0gCr13qBwNBv8YBQpgF8Cthm9
 Rs5NVzP+GEkh4ZrSrptvhCGIOXDHYb9t59EZ76xT0yr8PMD4abMhs5NT5ktol0T70NOKZE3R8Jq
 pLCufs9k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230031

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

On a vast majority of Qualcomm chipsets DisplayPort controller can
support several MST streams (up to 4x). To support MST these chipsets
use up to 4 stream pixel clocks for the DisplayPort controller and
several extra register regions. Expand corresponding region and clock
bindings for these platforms and fix example schema files to follow
updated bindings.

Note: On chipsets that support MST, the number of streams supported
can vary between controllers. For example, SA8775P supports 4 MST
streams on mdss_dp0 but only 2 streams on mdss_dp1.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/display/msm/dp-controller.yaml        | 91 +++++++++++++++++++++-
 .../bindings/display/msm/qcom,sa8775p-mdss.yaml    | 26 +++++--
 .../bindings/display/msm/qcom,sar2130p-mdss.yaml   | 10 ++-
 .../bindings/display/msm/qcom,sc7280-mdss.yaml     |  3 +-
 .../bindings/display/msm/qcom,sm7150-mdss.yaml     | 10 ++-
 .../bindings/display/msm/qcom,sm8750-mdss.yaml     | 10 ++-
 .../bindings/display/msm/qcom,x1e80100-mdss.yaml   | 10 ++-
 7 files changed, 138 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index afe01332d66c3c2e6e5848ce3d864079ce71f3cd..8282f3ca45c8b18f159670a7d8c4d9515cdb62ca 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -66,25 +66,37 @@ properties:
       - description: link register block
       - description: p0 register block
       - description: p1 register block
+      - description: p2 register block
+      - description: p3 register block
+      - description: mst2link register block
+      - description: mst3link register block
 
   interrupts:
     maxItems: 1
 
   clocks:
+    minItems: 5
     items:
       - description: AHB clock to enable register access
       - description: Display Port AUX clock
       - description: Display Port Link clock
       - description: Link interface clock between DP and PHY
-      - description: Display Port Pixel clock
+      - description: Display Port stream 0 Pixel clock
+      - description: Display Port stream 1 Pixel clock
+      - description: Display Port stream 2 Pixel clock
+      - description: Display Port stream 3 Pixel clock
 
   clock-names:
+    minItems: 5
     items:
       - const: core_iface
       - const: core_aux
       - const: ctrl_link
       - const: ctrl_link_iface
       - const: stream_pixel
+      - const: stream_1_pixel
+      - const: stream_2_pixel
+      - const: stream_3_pixel
 
   phys:
     maxItems: 1
@@ -166,7 +178,6 @@ required:
 allOf:
   # AUX BUS does not exist on DP controllers
   # Audio output also is present only on DP output
-  # p1 regions is present on DP, but not on eDP
   - if:
       properties:
         compatible:
@@ -195,11 +206,83 @@ allOf:
       else:
         properties:
           aux-bus: false
-          reg:
-            minItems: 5
         required:
           - "#sound-dai-cells"
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              # these platforms support SST only
+              - qcom,sc7180-dp
+              - qcom,sc7280-dp
+              - qcom,sc7280-edp
+              - qcom,sc8180x-edp
+              - qcom,sc8280xp-edp
+    then:
+      properties:
+        reg:
+          minItems: 5
+          maxItems: 5
+        clocks:
+          minItems: 5
+          maxItems: 5
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              # these platforms support 2 streams MST on some interfaces,
+              # others are SST only
+              - qcom,sc8280xp-dp
+              - qcom,x1e80100-dp
+    then:
+      properties:
+        reg:
+          minItems: 5
+          maxItems: 5
+        clocks:
+          minItems: 5
+          maxItems: 6
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            # 2 streams MST
+            enum:
+              - qcom,sc8180x-dp
+              - qcom,sdm845-dp
+              - qcom,sm8350-dp
+              - qcom,sm8650-dp
+    then:
+      properties:
+        reg:
+          minItems: 5
+          maxItems: 5
+        clocks:
+          minItems: 6
+          maxItems: 6
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              # these platforms support 4 stream MST on first DP,
+              # 2 streams MST on the second one.
+              - qcom,sa8775p-dp
+    then:
+      properties:
+        reg:
+          minItems: 9
+          maxItems: 9
+        clocks:
+          minItems: 6
+          maxItems: 8
+
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
index 1053b3bc49086185d17c7c18d56fb4caf98c2eda..e2730a2f25cfb0496f47ad9f3f9cbf69b1d4649f 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
@@ -375,7 +375,11 @@ examples:
                   <0xaf54200 0x0c0>,
                   <0xaf55000 0x770>,
                   <0xaf56000 0x09c>,
-                  <0xaf57000 0x09c>;
+                  <0xaf57000 0x09c>,
+                  <0xaf58000 0x09c>,
+                  <0xaf59000 0x09c>,
+                  <0xaf5a000 0x23c>,
+                  <0xaf5b000 0x23c>;
 
             interrupt-parent = <&mdss0>;
             interrupts = <12>;
@@ -384,16 +388,28 @@ examples:
                      <&dispcc_dptx0_aux_clk>,
                      <&dispcc_dptx0_link_clk>,
                      <&dispcc_dptx0_link_intf_clk>,
-                     <&dispcc_dptx0_pixel0_clk>;
+                     <&dispcc_dptx0_pixel0_clk>,
+                     <&dispcc_dptx0_pixel1_clk>,
+                     <&dispcc_dptx0_pixel2_clk>,
+                     <&dispcc_dptx0_pixel3_clk>;
             clock-names = "core_iface",
                           "core_aux",
                           "ctrl_link",
                           "ctrl_link_iface",
-                          "stream_pixel";
+                          "stream_pixel",
+                          "stream_1_pixel",
+                          "stream_2_pixel",
+                          "stream_3_pixel";
 
             assigned-clocks = <&dispcc_mdss_dptx0_link_clk_src>,
-                              <&dispcc_mdss_dptx0_pixel0_clk_src>;
-            assigned-clock-parents = <&mdss0_dp0_phy 0>, <&mdss0_dp0_phy 1>;
+                              <&dispcc_mdss_dptx0_pixel0_clk_src>,
+                              <&dispcc_mdss_dptx0_pixel1_clk_src>,
+                              <&dispcc_mdss_dptx0_pixel2_clk_src>,
+                              <&dispcc_mdss_dptx0_pixel3_clk_src>;
+            assigned-clock-parents = <&mdss0_dp0_phy 0>,
+                                     <&mdss0_dp0_phy 1>,
+                                     <&mdss0_dp0_phy 1>,
+                                     <&mdss0_dp0_phy 1>;
 
             phys = <&mdss0_dp0_phy>;
             phy-names = "dp";
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sar2130p-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sar2130p-mdss.yaml
index 870144b53cec9d3e0892276e14b49b745d021879..44c1bb9e41094197b2a6855c0d992fda8c1240a4 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sar2130p-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sar2130p-mdss.yaml
@@ -207,16 +207,20 @@ examples:
                      <&dispcc_disp_cc_mdss_dptx0_aux_clk>,
                      <&dispcc_disp_cc_mdss_dptx0_link_clk>,
                      <&dispcc_disp_cc_mdss_dptx0_link_intf_clk>,
-                     <&dispcc_disp_cc_mdss_dptx0_pixel0_clk>;
+                     <&dispcc_disp_cc_mdss_dptx0_pixel0_clk>,
+                     <&dispcc_disp_cc_mdss_dptx0_pixel1_clk>;
             clock-names = "core_iface",
                           "core_aux",
                           "ctrl_link",
                           "ctrl_link_iface",
-                          "stream_pixel";
+                          "stream_pixel",
+                          "stream_1_pixel";
 
             assigned-clocks = <&dispcc_disp_cc_mdss_dptx0_link_clk_src>,
-                              <&dispcc_disp_cc_mdss_dptx0_pixel0_clk_src>;
+                              <&dispcc_disp_cc_mdss_dptx0_pixel0_clk_src>,
+                              <&dispcc_disp_cc_mdss_dptx0_pixel1_clk_src>;
             assigned-clock-parents = <&usb_dp_qmpphy_QMP_USB43DP_DP_LINK_CLK>,
+                                     <&usb_dp_qmpphy_QMP_USB43DP_DP_VCO_DIV_CLK>,
                                      <&usb_dp_qmpphy_QMP_USB43DP_DP_VCO_DIV_CLK>;
 
             phys = <&usb_dp_qmpphy QMP_USB43DP_DP_PHY>;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
index 2947f27e0585216ca0e1eab6a79afcb21323b201..b643d3adf66947095490b51625a03635c64c37c2 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
@@ -281,7 +281,8 @@ examples:
             reg = <0xaea0000 0x200>,
                   <0xaea0200 0x200>,
                   <0xaea0400 0xc00>,
-                  <0xaea1000 0x400>;
+                  <0xaea1000 0x400>,
+                  <0xaea1400 0x400>;
 
             interrupt-parent = <&mdss>;
             interrupts = <14>;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.yaml
index c5d209019124da3127285f61bf5a27d346a3d8a1..9b0621d88d508fb441f004261c42c2473bea2bcb 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-mdss.yaml
@@ -394,16 +394,20 @@ examples:
                      <&dispcc_mdss_dp_aux_clk>,
                      <&dispcc_mdss_dp_link_clk>,
                      <&dispcc_mdss_dp_link_intf_clk>,
-                     <&dispcc_mdss_dp_pixel_clk>;
+                     <&dispcc_mdss_dp_pixel_clk>,
+                     <&dispcc_mdss_dp_pixel1_clk>;
             clock-names = "core_iface",
                           "core_aux",
                           "ctrl_link",
                           "ctrl_link_iface",
-                          "stream_pixel";
+                          "stream_pixel",
+                          "stream_1_pixel";
 
             assigned-clocks = <&dispcc_mdss_dp_link_clk_src>,
-                              <&dispcc_mdss_dp_pixel_clk_src>;
+                              <&dispcc_mdss_dp_pixel_clk_src>,
+                              <&dispcc_mdss_dp_pixel1_clk_src>;
             assigned-clock-parents = <&dp_phy 0>,
+                                     <&dp_phy 1>,
                                      <&dp_phy 1>;
 
             operating-points-v2 = <&dp_opp_table>;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml
index 72c70edc1fb01c61f8aad24fdb58bfb4f62a6e34..4151f475f3bc36a584493722db207a3dd5f96eed 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8750-mdss.yaml
@@ -401,16 +401,20 @@ examples:
                          <&disp_cc_mdss_dptx0_aux_clk>,
                          <&disp_cc_mdss_dptx0_link_clk>,
                          <&disp_cc_mdss_dptx0_link_intf_clk>,
-                         <&disp_cc_mdss_dptx0_pixel0_clk>;
+                         <&disp_cc_mdss_dptx0_pixel0_clk>,
+                         <&disp_cc_mdss_dptx0_pixel1_clk>;
                 clock-names = "core_iface",
                               "core_aux",
                               "ctrl_link",
                               "ctrl_link_iface",
-                              "stream_pixel";
+                              "stream_pixel",
+                              "stream_1_pixel";
 
                 assigned-clocks = <&disp_cc_mdss_dptx0_link_clk_src>,
-                                  <&disp_cc_mdss_dptx0_pixel0_clk_src>;
+                                  <&disp_cc_mdss_dptx0_pixel0_clk_src>,
+                                  <&disp_cc_mdss_dptx0_pixel1_clk_src>;
                 assigned-clock-parents = <&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+                                         <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
                                          <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
                 operating-points-v2 = <&dp_opp_table>;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
index e35230a864379c195600ff67820d6a39b6f73ef4..8d698a2e055a88b6485606d9708e488e6bc82341 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
@@ -183,15 +183,19 @@ examples:
                <&dispcc_dptx0_aux_clk>,
                <&dispcc_dptx0_link_clk>,
                <&dispcc_dptx0_link_intf_clk>,
-               <&dispcc_dptx0_pixel0_clk>;
+               <&dispcc_dptx0_pixel0_clk>,
+               <&dispcc_dptx0_pixel1_clk>;
             clock-names = "core_iface", "core_aux",
                     "ctrl_link",
                     "ctrl_link_iface",
-                    "stream_pixel";
+                    "stream_pixel",
+                    "stream_1_pixel";
 
             assigned-clocks = <&dispcc_mdss_dptx0_link_clk_src>,
-                  <&dispcc_mdss_dptx0_pixel0_clk_src>;
+                  <&dispcc_mdss_dptx0_pixel0_clk_src>,
+                  <&dispcc_mdss_dptx0_pixel1_clk_src>;
             assigned-clock-parents = <&usb_1_ss0_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+                  <&usb_1_ss0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
                   <&usb_1_ss0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
 
             operating-points-v2 = <&mdss_dp0_opp_table>;

-- 
2.47.2


