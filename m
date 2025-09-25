Return-Path: <linux-kernel+bounces-831535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4237EB9CF0E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F293BB320
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287A82D8797;
	Thu, 25 Sep 2025 00:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FSWa39dH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D00266B56
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761562; cv=none; b=ZbQHFXEubQHYnbcJk+c4L95mKy8DsCcUXRHv4taf1nOqtevMg1EBM/NeZjm7YwMuvGaQHQtwt8Hr5PsNaIJu4QB5zu8aL5BHNM0BMXIgB5eKDYSp2/yT7z1g7l1FuN6OevnSuwswlUO24vLWYVrwiTmGv6QFHs0A0h3iHDR3qwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761562; c=relaxed/simple;
	bh=cfM3s21T8CQ3sOfi9Dc1sx2mJ27UuKxMJmEc0kjDpws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RzaQTlFkdf11yfjgfPfTkWC2Ieq5/ZkwgEVzAGka5d7MIXwPmjaH3iUL8pqU4BoqwS7VYbYtFglzrFAIlL2J0orKUWZ3CACmZcfuB9T1Oi4VBkRnB+HuF2ULrocikNbC7p23EZbGjeqKouEYyL6sS6hhX0QJSENSRK9qc+Azon0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FSWa39dH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODGTa6018069
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YaQd3cF9DM3
	ZawONJKkUUZT5oOk1utb/PQbw+Tb9ZII=; b=FSWa39dHzVr5D1x7oDJ1YZOq1NR
	kqC4z3QlZD4ysF3as5fPvv/NXIKMrPywjeMZbY0nbZQSfgazk1HfpAT8TSwIK6KD
	kmI9zgYXBqwa457Mrrzk0xS1Z3KOT7GvopGTikzmBkLl1oRWyRzMXAQerbek79my
	OEqrxDnX8b1+MRoemETvUc9wrFGay82wkKOZOzlTenaqd6bD12A5IHM/n6JfXdIW
	SEAaifaeNf4hJWjC1hx2XQs01fAebtceiybHFljzC2J7F98+XLd906ndR4JBzy6k
	lIvsityAVOhvII5tP4Iw8XtTOV+nwtzjINiWt2MkDCG/gt8b8dYCpNG6pKw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kka69j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-269af520712so4873075ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758761557; x=1759366357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaQd3cF9DM3ZawONJKkUUZT5oOk1utb/PQbw+Tb9ZII=;
        b=Zs1bhW68I+F74hS9gtnUWmmde1cdOjPuitrm91xhtECg2BDK53QOhgsEsk3EaG0uXc
         +n7xyeUHpLP37563LkWXDvIhfKLpviguakyuZK8IKlpLN1EMgt/vosIpSrsw77hPG33l
         vYI0EmuIlL2LHh5Ca3qc3TjZnennpsaYudXWU5lI7XigSAE5CGftKxtFitpNDOvd/in8
         Jlq5X6p06OW4elnYReksC7K5lgaD8PRl/saungNMvvQyATNaSKX+gxHhH7JDht2SMdpW
         3/t39ENItyFLbyoDE3vVeN3/BZFCnqjB2/UmL6vi0jKEpVc/1fPSMtmTyoFj0qQYiYOc
         BtIg==
X-Forwarded-Encrypted: i=1; AJvYcCXa3A6zLrJr4JxlWg+nboCTZzzQw0GEvEMPOTtMoFbXtqAnQL/fIHyIFQjYqGrDuBeN6sUA9dsa7XXyItQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YycTQ5cpGn+wqBOb++0eqLuF5Ko8xL0D0J1yl/CCGG8p+Vs5/WO
	JIEwPaUAkM5FnSyGA3Lj1L4OeWJIyLMFpqPPsXzFbY2ma8hWgozuM1h/lm0G+3Kyqpzhrvu8fGx
	VDYgejLSJZn/oXYK08DIbhfPXWjZsrc4l31zDo7TnBDgGRS+EBtmPvDeScXhpRq7jI0Q=
X-Gm-Gg: ASbGncv8JL9V1FDaCUGcTXLsY6kfSYzd4SHyQqSRWwGSSFAFK9L8TsOCBdCtBUGZNMj
	mgmE3t4PoXluVVJpXaEjGCMXQ4vlLDwMiFvanAqtKDuxKqgBL//Bhn+0HbZJpC1w65ZNDMupCGG
	5dRWgkhzvHf+c0gJjnfpI+9Ob/9f4xKAbBWos83PvTEQ0bptBLP5JUwhKwtmK1jlZ4h7L7cw67d
	IK3xOLc0zd2sbpvwhX6zIgfl4+pVhyKCQLTqzGYNpL8AbEeCN5J3hgx5COu2oOcXc+7RWfRrXRS
	9a4w4pWmfspz1b0Rv00TSCLqgWeubwUL0EeQJMJgAOMv2rUrTm8LMK7IFj7HfsLQenYQVKVDfDK
	+WUW5va5QDZhzqFI5
X-Received: by 2002:a17:903:1a06:b0:269:8f0c:4d86 with SMTP id d9443c01a7336-27ed4adeeedmr12621335ad.53.1758761556910;
        Wed, 24 Sep 2025 17:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkdWp6F5xl7z3+kp7g4Jtt7h4BtMeBXJCqbB57Ib1mwFswvS7CDTGv4fLa3p0hqGsMWqWbYg==
X-Received: by 2002:a17:903:1a06:b0:269:8f0c:4d86 with SMTP id d9443c01a7336-27ed4adeeedmr12621135ad.53.1758761556419;
        Wed, 24 Sep 2025 17:52:36 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ac27d4sm5238105ad.135.2025.09.24.17.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:52:35 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v2 03/10] dt-bindings: phy: qcom-m31-eusb2: Add Glymur compatible
Date: Wed, 24 Sep 2025 17:52:21 -0700
Message-Id: <20250925005228.4035927-4-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
References: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PUmznXZkOW4lkU4so80d7ikkKHMldAl-
X-Proofpoint-ORIG-GUID: PUmznXZkOW4lkU4so80d7ikkKHMldAl-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX5kHSK66nMEo1
 BNlo3JH9iQZDhvPtxHGLr4JUiHxNl6kAx2BXrYKye8RH/HjroVlGdt/m93hF0rs0RcpTb39PSGD
 8jf3hVJM9ge3DUXTGxoV7mLy5g+FcAsW3QE8PZ0k/yd80b3yRi3dpivMwh9+4B0N0HrH7g4P4ZE
 CBnMxEGTGNxJzGa8Q1SYSvOHDT4R+231bs3r+IJTf1qUvr3ofwVJSGlberBUxNjkkfSklsIfC1z
 YFAWB7jYOC+W5fgi60i2g55SvLU8n6edefqhjf2U4Qo2/OqbmxwuuW2v7wqYivd7uaiVcyB2RD5
 2cAQW35al7YJXk4d2gn1Si5x8rhIbCcCu7APPltdNBjFMBkW5gBPJGd9wjrqF2BFmglAcz4XgLu
 qqQm2hxq
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d49256 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=dJG6SERxbJy7wEyxA2sA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

Add the Glymur compatible to the M31 eUSB2 PHY, and use the SM8750 as
the fallback.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../bindings/phy/qcom,m31-eusb2-phy.yaml      | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
index c84c62d0e8cb..0d5db71e0ad8 100644
--- a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
@@ -15,9 +15,12 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - qcom,sm8750-m31-eusb2-phy
+    oneOf:
+      - items:
+          - enum:
+              - qcom,glymur-m31-eusb2-phy
+          - const: qcom,sm8750-m31-eusb2-phy
+      - const: qcom,sm8750-m31-eusb2-phy
 
   reg:
     maxItems: 1
@@ -53,12 +56,20 @@ required:
   - compatible
   - reg
   - "#phy-cells"
-  - clocks
-  - clock-names
   - resets
   - vdd-supply
   - vdda12-supply
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: qcom,sm8750-m31-eusb2-phy
+    then:
+      required:
+        - clocks
+        - clock-names
+
 additionalProperties: false
 
 examples:

