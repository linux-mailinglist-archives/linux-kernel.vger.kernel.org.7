Return-Path: <linux-kernel+bounces-804489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DAAB477C2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 23:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B202D1BC1153
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 21:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F16A29A9C9;
	Sat,  6 Sep 2025 21:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IqZD1af1"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0D5315D3C
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757195338; cv=none; b=lFd/f1dWsCeDXHhLSqAxkHeslR16/OSPd/XkC1usVEW1rAKfMlqTWiyEzasBTup9ZJJqU/nMDwKJUXpC+wTcXycQW+0RXCiDzsk+06zxuclq63ZjiBhH76h8/8pl6Wqhbm1cVKH8EceNxyDClHRDrqlh/VrLmSXWU5dW+H6S91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757195338; c=relaxed/simple;
	bh=zhvNXMGegR9yDlqQMy/XBI510R9HnhJWonOW2z5xNgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R8xojTbgQKiHhg84KUHeY/byA1riDF1z2bsth4davfLbzdHBnaPpJD+d7D7OpyQdZrVNI+o6cGvlo15dm8UZVPc2VfsfPMxl+HsEdjJZ31ACekaHyEMQdMZK+DGzkoE6oVR0O7Xh5FC7U1RnGg+L2IquSOYNEpJ6kD8K9V231zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IqZD1af1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 586LUgUd017971
	for <linux-kernel@vger.kernel.org>; Sat, 6 Sep 2025 21:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=duMhnqfLjphXvSjGPmTHVE
	iWVH5TfJsRlnBS37ltgSc=; b=IqZD1af11hEkr87hulsqTECR3UaKxSYelzyHG3
	RwCshDicpENhAFMWWfxaWNfzXWEea9ECh+Rh2Jxn7t1vvrLzc49RqQQhD8s8SS/1
	nBxymMmN8jwz+GBlipGsHeTiSzESi02jJYlYIv8saTTHu+Y84GRg7BY7Z3lC2XY2
	jcLCfPZFnSgXllb9pug/cUztJu7W16YGlbVqYJ5u8sHkKyyjF6npuNxoy+FhU5y5
	Q8HMf/rCMXZbG4UGdhXUvO5SRskojjbalI9aBLTFB6nikjS5RXCa39qO5xUzXgxW
	x27YnA2TVK3EtdMU9+0BKKuuV28YvvCPJhgtf0lNOP/hg68Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d1v9845-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 21:48:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5f112dafeso44119471cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Sep 2025 14:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757195335; x=1757800135;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duMhnqfLjphXvSjGPmTHVEiWVH5TfJsRlnBS37ltgSc=;
        b=csmyU1pho3MfVg6UNS+azjs/VknBHBMdRxCJz8uB8CAcUPpv+TE/MBrG3Mr7kYbFGX
         SYCeTbo+yfhi7sfzk4MzhvbIHZA5H9aQ0/J81oYlqbuskqkiRsWsJWGk/rQRccWoQYnf
         iblG/lzWJmtvKtSzToHx9RMpCityVTOgioOAupNO/+5QxRDc7tNT3cpn3opIpUi5QAhz
         EdFaq53RNfI5YyFW7b06A9Ypvz5DCOwQtd3LK9YAzUS9tFa+vvW1P6NWEM1/pH7mutTT
         KM9/jrFgYbcIwipZereMvbAshe83YTl5OQvX2hYYmp4iD/+oCwP+MVvuiXSBgBqu0lnK
         9O+g==
X-Forwarded-Encrypted: i=1; AJvYcCV4DmzABN6DNAG0bjZr/wqBEE7YH+L37OUpGLdy2ZbFeRBzNRS48gwwcS5ptRvHSdZVQuCQG5V3XM38NXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzhq2EwNYG4xpP3lNNSbdxR+0e4f/aR482JsHZebcPLO82wZaB
	zbUDTzei5bHCK428mYnOAgS9Gq2EAaQteS1GF34+Y0E+5sjTG0wUdX/EnjdXaWhZJ21Bs5RmkZC
	EOpcfO8i7pTFLHsNXmcMeR/67tCUDeY1z71cDFXz6dxyl+yC50jRp7GBF5iS/VVfDwLt+arMqV+
	Y=
X-Gm-Gg: ASbGncvCQ6CW8blMKqF3wagXGRsG/mwtfR2UXS+6Dthe6DF3M7kxWa+dZeqPEyCuEnP
	a3v0dzeLSpyF0l0Fa6NCYqVmBqjO/SGroEqf6LVLzuBQ5OS1sevGB9iYboBB0miRVXFcjsRYmi5
	gee55qeI/kD5nxCSzSjhvC8xu3DCcTxvquK/htVsZ8uB2Bmwz7l2nEWcuAmjZfgvayhFf2++iWA
	KFy8rimLjk/ExPubBtB+ca4chsgV91onA8t7W6Y70GOrUUOp+QLzc7cQWnvZ1WtbTRXM/wT65Vp
	iXPKpwKtE4iiIThmHI4hM2TxQqLKK8av6cq1dzBGgBg0afU5f+T5a00kjkIKKDea6Jzt+RfEtHf
	F7meujnSLo886QwhzZ1tWL3thkMxg13TRGXeoP2i2kx6lJwWWlPIf
X-Received: by 2002:a05:622a:15c8:b0:4b3:50b0:d80 with SMTP id d75a77b69052e-4b5f8569a7bmr33521141cf.57.1757195334705;
        Sat, 06 Sep 2025 14:48:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx9lboS5t/Woj+bBQjp+nx7XVjfxf9kWYu1057+otiUbzZVI1hnBUp93/r4IT74n7N+b88yA==
X-Received: by 2002:a05:622a:15c8:b0:4b3:50b0:d80 with SMTP id d75a77b69052e-4b5f8569a7bmr33521021cf.57.1757195334306;
        Sat, 06 Sep 2025 14:48:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608abc1798sm2561252e87.57.2025.09.06.14.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 14:48:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 07 Sep 2025 00:48:52 +0300
Subject: [PATCH] dt-bindings: dp-connector: describe separate DP and AUX
 lines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-dp-conenctor-sbu-v1-1-de79c0fcd64d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEOsvGgC/x3MQQqAIBBA0avErBsww6SuEi1qnGo2KloRRHdPW
 r7F/w9kTsIZhuqBxJdkCb6gqSugffYbo7hi0Eob1SuLLiIFz56OkDAvJ7ZMzijd2s4QlCwmXuX
 +l+P0vh/V9OMjYgAAAA==
X-Change-ID: 20250907-dp-conenctor-sbu-3ecd5023765c
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2782;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=zhvNXMGegR9yDlqQMy/XBI510R9HnhJWonOW2z5xNgY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBovKxFW1OreFn+SDGcBNbj5YDp1tiTmrYKC8QOh
 LRNOdYOP5qJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLysRQAKCRCLPIo+Aiko
 1YfFB/96xRXM190qb0+pTgJYpZsWQibT7naZGcx3Y3dPL+uoae2fdGjO3vswImhQjRo4bX2agkI
 xzfyKV3O7ZGqN8Ew12McEVJe0wWcvMPdk9jRgUN1smnGC0gPXhyhoQqsK6WW56KPRefdRhIWEd9
 Es5Wo+xLSsXY9jZpBpSaB8VkRsoCWU7qdOJ3Jxme2p4unncD9wrtvfAJpdzEsLql1RMKXcit0x/
 hdUioxI2WwhPZVTfm55CAE3eGQ1p0R5Me9C+yfMPa1IF5u4764Lp4118IJYrCzdLNX3mQLCalrs
 U6115TK1DU3V4QUgJbWFH6z0wea7AyhpUbLT+WHeM1yl8yB0
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: Cl0_jpJ2MpwVNPsS84htfTAmJq4YnIc2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNyBTYWx0ZWRfX5hp5o1rMVtiZ
 wVD0X1boXVQU5BHAuk5G5G9ZA57hVVMV8yVyEFbrxQYc5FN9e+oYuuxWGENbU2VtMuhjcd6jyBT
 2ZTVAl4kEONb+ckshC6dwVqUVxh7LSPsZ5pgnEhopp/rsFs3hgIhZj2AV3DUSRgOgZ1I/C19nHR
 0BhAPbZc5Dz+Js6sXi2ezsG7YTL8LMfOzjHAmu0VvzNkF+3ffe0dk4qfq14R0IZ+daohxdc8loc
 QXRkSGplOKiLHOj6SnBcmS6dWdaTTTwCAiH+6wLxo51EFKg0gwuQ3J04ALDeorF7rfDlUl0NGzA
 BlykIWUfwNlZAKgsWRqCb2gfTDUFwNRFBuK1sUE3EvKTyL4TUUt6uTDApKAhAa8YdZCfMtTCOyd
 uDhxceN3
X-Authority-Analysis: v=2.4 cv=cYXSrmDM c=1 sm=1 tr=0 ts=68bcac47 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=5inRAbP7wB7EHgTAESYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Cl0_jpJ2MpwVNPsS84htfTAmJq4YnIc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-06_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060027

In some cases it's reasonable to describe DP lanes and AUX signal lines
separately in the DT. One of the typical reasons is if the source of DP
signals can support either USB-C or DP connections. In such a case the
transmitter of DP signals have separate ports: one for SS lanes and
another one for SBU / AUX signals.

Instead of leaving AUX signals from the controller unconnected, add an
option to the DT schema to AUX signal lines separately from the main
link lanes.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/display/connector/dp-connector.yaml   | 52 +++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/connector/dp-connector.yaml b/Documentation/devicetree/bindings/display/connector/dp-connector.yaml
index 22792a79e7ce5177113f17ab472048c220dbb3c3..1f2b449dc9102c34ad015bbe7beae0d67a2df5c5 100644
--- a/Documentation/devicetree/bindings/display/connector/dp-connector.yaml
+++ b/Documentation/devicetree/bindings/display/connector/dp-connector.yaml
@@ -31,10 +31,32 @@ properties:
     $ref: /schemas/graph.yaml#/properties/port
     description: Connection to controller providing DP signals
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: OF graph representation of signales routed to DP connector
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Connection to controller providing DP signals
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Connection to controller providing AUX signals
+
+    required:
+      - port@0
+      - port@1
+
 required:
   - compatible
   - type
-  - port
+
+oneOf:
+  - required:
+      - port
+  - required:
+      - ports
 
 additionalProperties: false
 
@@ -52,4 +74,32 @@ examples:
         };
     };
 
+  - |
+    /* DP connecttor being driven by the USB+DP combo PHY */
+    connector {
+        compatible = "dp-connector";
+        label = "dp0";
+        type = "full-size";
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                endpoint {
+                    remote-endpoint = <&phy_ss_out>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+
+                endpoint {
+                    remote-endpoint = <&phy_sbu_out>;
+                };
+            };
+        };
+    };
 ...

---
base-commit: 8cd53fb40a304576fa86ba985f3045d5c55b0ae3
change-id: 20250907-dp-conenctor-sbu-3ecd5023765c

Best regards,
-- 
With best wishes
Dmitry


