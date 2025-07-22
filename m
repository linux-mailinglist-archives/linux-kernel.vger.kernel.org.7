Return-Path: <linux-kernel+bounces-740321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0E3B0D2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BE66C1F61
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2042C158A;
	Tue, 22 Jul 2025 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jA2DS2cn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687652BF3F4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168968; cv=none; b=mvcnYA4LgZ/QMZ9yQ732/+JwpARQtvtZMR0QZ9aAzHJwoheloJAncabRXSBLHTl/MO8wDT2k3IGCApXooTl6DBmCN9h12mCzlz62inGUvMhT8EEgjrIgYGQMFgISVmvOVaw6K28w9yQBSTdoho7Qp3fV85d1TYlGD05GkJrIYX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168968; c=relaxed/simple;
	bh=71nsNROW8nOruef5bHMWdW3ozXU/NjQImv6aKmL0T24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7xo+XsajdFIVsdszwUKuDLFccvOXggq0fddWBvYbkMICHZXuE5lDaBqIrRbvN64vkr+JRMaAqfIF1HGwtuK3gBN5htPCFFn7jLCg+je6LOFRh+y9ZgvU7QHaR7amq+JeIic1EsB1TS7R4McEQuXIMb+ZrVfUMIHaGdYnGeW/Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jA2DS2cn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M2NwA7005512
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	95HJf98jrYhdOK50h5t/HTsn+deQ8bx6DN868zwIVWU=; b=jA2DS2cnWB8l7V+7
	ogovGQRFNcB+J1U2DHnr6lCDgPuP+LaiSlHoY9OGragpXdHErAz5aooOIGibHDz7
	lAxWJCWTqQVC9Fy4lIVdLmzs7AeNn4qZ6dMDJu5LahAW3WMrtU6zykcMOJu3e9ye
	YnnG2YS0+AHnYDN8V1rDbU8WAC427KpQ/znWKBfUhnoRGrdP9z1E0DwwmPjsjlGn
	g0WK5/4Dh2bR0x6Nq3PjEyY5SPi71obxzceQpxdnremrXZkrG7ij7lhgJlZbWltG
	F7Dq9usQPg2ntgfCtsggjoyMfyIbrna6HZwrCZCrnASStYPSCbSajRAzBALJ9cWn
	AcEWrw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48047q8h6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:22:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2348a5beb24so1581495ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 00:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753168965; x=1753773765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95HJf98jrYhdOK50h5t/HTsn+deQ8bx6DN868zwIVWU=;
        b=sjalEj3z6raSob4bmM7N+MQ8vs7JrioQnwgWCK94ddFZb9el8FUzjCjyVCnM3ipZqs
         HoLbjCIwxh6H5lTOR4V/norTAFjVU3ngp5plqEjMd/1iik3IqJuUI5j/HEhUd1Z0KPbf
         67vqUtGjpy67+HAi0j1NYf4yOCJjoEpvBwBgF/V+Og5hsUn2Wria1qKuSnhb9b0X7wqj
         gZs7FPGWg7CWmgsldCEB3lKQ9Wofd1ZHBRVX5PhI5C6hvoV1FbqFHf7EdChqA8DlpZFI
         cQDPbnDJp24j2VQ2+ipdP1lkhEBFONvLRIumXwpAZdae9iFEDWR6yzS+ud0lbtVV5gPy
         2Kow==
X-Forwarded-Encrypted: i=1; AJvYcCWX99kkvD2N/FBhpkRNMWnomKcv3/ERGLFNHskSwK4xsNHj0ZF5qF7+ITt5STfw4r0mZsqyEdbjA0vXWzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOCCdhAc667tF7cszfhToO0lWF1uxInraVEHwkA7JnSBnEpfCB
	ncoWCzq9iPDo92Fjv3NQfq9oyTU2LiDLN8Gd+7YXTp1jy+WDMwhY1qrA7a9vV9FhprLL3KN1FMj
	KDfghIo7M9/LP+tQYXWrKbMF3QGd4q9bQcsBkD68w8wZXL9Mt8wcYkgFdPTUScktDMBY=
X-Gm-Gg: ASbGncvJ+62fR5F2zTuCi98qx8yP38X19R5HAx7fV0Fuz4FB66K4y/ynnQnLT3loPq/
	ro9DgwNbEVrc+GphX1+djJkihhzgRQFoxicZau2kWiRBbvm+y71Ou6FDgnLKGOOZVNIF9Y+mJLq
	23Ev9ReVFTAP+MJPYJWZZWfbzwT0CaIsZSpnDWR6vO5ZzwltY9jbFF+aI7SHHRdWgP9pIC0/1nc
	rps8Ijj6M1E7AmmLJRsMmxJVn/4qKnxLgH4CVb6uOG+PychmuU+8JPx6J++SZIVYchX0RjU9ak6
	tbqI2JRzyX6JrKfcGgGnL7aDy2u9tOe2kFy3lBrtACGGqyIxRY7VEyN7Yku1D8fycNeGyQIj+bU
	J8JeVNPMwSlehj+JSYWFLbRSpRrwwv4pZjUduVVhHOCaW9XhrCqwuGs/M
X-Received: by 2002:a17:902:f547:b0:234:ba37:87a3 with SMTP id d9443c01a7336-23e24ecc5bdmr132166345ad.3.1753168965176;
        Tue, 22 Jul 2025 00:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG70wgcxv2Og+kPKUjYru/eTK2MCHabUKt0QBDH4BfkImjNq4j8b/P4oRqYxZYzHj6XtGxz9w==
X-Received: by 2002:a17:902:f547:b0:234:ba37:87a3 with SMTP id d9443c01a7336-23e24ecc5bdmr132166155ad.3.1753168964744;
        Tue, 22 Jul 2025 00:22:44 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e45e6csm7490753a91.3.2025.07.22.00.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 00:22:44 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 15:22:04 +0800
Subject: [PATCH v2 03/13] dt-bindings: phy: qcom,msm8998-qmp-usb3-phy:
 support dual TCSR registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-add-displayport-support-for-qcs615-platform-v2-3-42b4037171f8@oss.qualcomm.com>
References: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
In-Reply-To: <20250722-add-displayport-support-for-qcs615-platform-v2-0-42b4037171f8@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        fange.zhang@oss.qualcomm.com, quic_lliu6@quicinc.com,
        quic_yongmou@quicinc.com, Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753168937; l=2537;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=71nsNROW8nOruef5bHMWdW3ozXU/NjQImv6aKmL0T24=;
 b=dLa0B1WM5pUjkW4SwnkHpZoEZpTLwSATWGvvZEls9+EyqvaTXc0lRt/0UyqWmrJRqq5wLe/z9
 j/MpgPhJxb5CZpHDFqsNvkHX+TzWVnCqfLppugMnbDEfKk+5I/8/cZX
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA1OSBTYWx0ZWRfX0S4+ChcIOxPP
 MsMMIoqdrUoQwPyJ4Mq8J1/qqedG5fi0twtLxi2UbyI8lx1FVSaoD4jQztXfocKIioVsJq8FOdH
 0b4uJzSKyNX5efj1a911HOYIW2yjeRM5xzbjzmKj0Ktn93sg4TjWdzk9fwZsW5211hk6/fdp4+R
 Ent+1hoD8RBILD9lAm+NWajV9Dm/bwBXqDFbVOqAKE+96avENYu6hWVLpd1ZaLRitim/oTmB7HQ
 Im9xanbehHCVuOqwdJgQyzXdiGqCNn583irAqFoGvyx6ZCzQ8S5V1siuMLDRItROF6yW5sHLiZq
 M4qwYgMlUCZLeNZrq2cg+VpUd+SPjQ0/bJWBEeNBFVpz7v+3hWf4RzDxVTDIQ9oTZL+gohQKh68
 usOxpFVuBe7UZTRHTCoAhbYEpdz8zpNUOO+7oT+oqWQlqW9Z3smcHS+tfG1J7CdJ7022zuNk
X-Proofpoint-ORIG-GUID: pfH0T4EOhFI69tpLcC0Kiy_hEb8MJuVR
X-Proofpoint-GUID: pfH0T4EOhFI69tpLcC0Kiy_hEb8MJuVR
X-Authority-Analysis: v=2.4 cv=IrMecK/g c=1 sm=1 tr=0 ts=687f3c46 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=nxDEYaoXc1MktuKintAA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220059

Add support for specifying two TCSR register addresses in the
qcom,tcsr-reg property to enable DP-only mode switching. This change
maintains backward compatibility with the original single-register
format.

Also update #clock-cells and #phy-cells to <1> to support clock and PHY
provider interfaces, respectively. This is required for platforms that
consume the PHY clock and select PHY mode dynamically.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 .../bindings/phy/qcom,msm8998-qmp-usb3-phy.yaml    | 28 +++++++++++++++++-----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8998-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8998-qmp-usb3-phy.yaml
index 1636285fbe535c430fdf792b33a5e9c523de323b..badfc46cda6c3a128688ac63b00d97dc2ba742d6 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8998-qmp-usb3-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8998-qmp-usb3-phy.yaml
@@ -44,13 +44,21 @@ properties:
   vdda-pll-supply: true
 
   "#clock-cells":
-    const: 0
+    oneOf:
+      - description: Set to 0 for legacy platforms without clock provider
+        const: 0
+      - description: Set to 1 to expose PHY pipe clock.
+        const: 1
 
   clock-output-names:
     maxItems: 1
 
   "#phy-cells":
-    const: 0
+    oneOf:
+      - description: Set to 0 for legacy platforms
+        const: 0
+      - description: Set to 1 to supports mode selection (e.g. USB/DP)
+        const: 1
 
   orientation-switch:
     description:
@@ -59,11 +67,19 @@ properties:
 
   qcom,tcsr-reg:
     $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
+    description: Clamp and PHY mode register present in the TCSR
+    oneOf:
+      - items:
+          - items:
+              - description: phandle to TCSR hardware block
+              - description: offset of the VLS CLAMP register
       - items:
-          - description: phandle to TCSR hardware block
-          - description: offset of the VLS CLAMP register
-    description: Clamp register present in the TCSR
+          - items:
+              - description: phandle to TCSR hardware block
+              - description: offset of the VLS CLAMP register
+          - items:
+              - description: phandle to TCSR hardware block
+              - description: offset of the DP PHY mode register
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports

-- 
2.34.1


