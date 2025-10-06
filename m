Return-Path: <linux-kernel+bounces-843529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA057BBFAA4
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66963B1302
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A21CAA85;
	Mon,  6 Oct 2025 22:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oOZwfOCB"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA3E1F2B88
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759789215; cv=none; b=FWtvn9Ec9V04P9vKEeSRJ4DlLe+q6NbZ+5BrzDFgAb1A+FBPFyh0+pczbu7ejIpKVQEO4b8E7RdCkpxmEgukEu/sqZyesVMZsAaWUu8xamgC5E3JD50qL+mKLCh1ZFXaft6vdKk77mKnRgp7kxYR5pkDFx4Bw2Vz0UGWJ/Bh5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759789215; c=relaxed/simple;
	bh=cfM3s21T8CQ3sOfi9Dc1sx2mJ27UuKxMJmEc0kjDpws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TEiW509kotBeTehAowZOGK7Dz4w2MAaKwCwTGSaSMsu4XrLp3tpacCuR86/VwvI6ptIyN+Ewmpq80Yglp91zS5KJ5ELzAdNg6jpjsTDPUPjuiajjlfHKr6+/zRLoCMduSc3lpN3wb0UAydM57toaKyV4vokqHEP1+tifTeyVImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oOZwfOCB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596FUaCJ012073
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 22:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YaQd3cF9DM3
	ZawONJKkUUZT5oOk1utb/PQbw+Tb9ZII=; b=oOZwfOCBwgDoryc4mTe3JY8fHqi
	y5LqzEC/ozhIgi3WVGovhl/N8dTil69mpmCsP8FhRydMymbvvth1/C2JAuIr5cnh
	iQle4YBINg08PIQSkjyC5XJ+9EUUrNi6jJkw47wYmQrEcbdj/ymDIwxUj9tEiZFC
	Ry4jNI4Pkc2USTQkQEOThPEKiCkUJpbu8LJHZNMGsr6pQhU7wIfpbRqvkKrRc6PP
	DztODVrdpzUeWPx8IMdIBFDRTH+o4upmZNqRc1nJUghL//exiRcpZJTYsJ/Ay4xI
	9UwNem4aN59CH/hXCTFMCsCm3QANu+/kHtc5c1QO3/FgQGSxteu0QKPMQlQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxn5mdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:20:12 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78106e63bc9so5264653b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759789211; x=1760394011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaQd3cF9DM3ZawONJKkUUZT5oOk1utb/PQbw+Tb9ZII=;
        b=fbehzRdpjIh9WmEL265Xz0tKcnMIUdBNVnZNY3+uRI/SOYfT8MMpvhE2UfcL2JNNkZ
         Ddypojil1en4IyxUfnnEchzS3ZgtN3fFfFzpdQcTo4cFYwB+zL0ST44GzC8jOEyMgDAw
         CeR/muifZV8m/CZq8Y+Ge1IQ9dMUCEpN5x0XLJdoACaZ8TLIDX/TFInhXYnN86rFsh0W
         tltclmkt59Rhc+Z5AmV2UHC6jwLHsFj5byEtGCmj/JBSUPicvEwmhg6VX8rkjPq7GfLt
         tgbqlTmp/yTYmKoD3lGSGtcDLruli5PwAUHFFzV3z4mO/PCZSBaN0s777Qf0aeNZkgkb
         lgNA==
X-Forwarded-Encrypted: i=1; AJvYcCUoEqzP8OP0e/RfaP8w/gGW5S+j4eTZRRaG2zH5MXGH867d5+V8OT4hqhGm/tPYMRKONIGuYEnEq93KkZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFZb0INyTM+ihMUjfu/87kLlv/d0WqENV6Yez9KFTU8o/y4/DW
	vG9hLUwYUEahrRHaJrUs7lNrYvTIiBJdTcqjvyDxGus+XYlwiXwCfobZf1FDfP7DxytQNDRrat6
	5G/b3nzXIch+HLewHLd+t+GTmLP/2WF6Pb8SkEz5ft9ia+bBudDp09Fyuk2kRw6hLpV8=
X-Gm-Gg: ASbGncsFJEdu09RKLLPTDya7HHWy/9BJKe9dz+8/cchWcroyZd1AC8dujlFiGUn9ltC
	9m0j1ZxHTdJbJli/baWPcQtcbVwxLZd8pFmo/YweUWblWKkQR2xgTsSXz4vGLSiZD2eJMfUEceP
	PFtQNMyjODev7R9AiV/9/LwpkUgUbVHq1ETw+fjTlw2mF2z6UBDa7+A4mAG4shCgrDfQuutWOFw
	N8tesZzJakkj7ceQbRjc3uGKWLJwcUmwWaVoX9RVGR/nHKbx7343xg4B1NN/PqaENGG3jgw6c2S
	zyINEwOCTBOBbUrNNWRMmJxCD2G2cUKhU7wnhl+ML4TIyE5vwxbTBELn4uUWJs99ocPPyzhFtAH
	7sw4d3Bqj5dj0S6wQyLxbuA==
X-Received: by 2002:a05:6a00:2304:b0:781:1e91:fd8c with SMTP id d2e1a72fcca58-78c98d5d579mr15544428b3a.11.1759789211235;
        Mon, 06 Oct 2025 15:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIm8mI+7X+Hd2BCDb5Dl4LJU7yRAMUsvYgqVVINq5kq0s+hlHcmFW7vgYhMca0ppEpo7MuMA==
X-Received: by 2002:a05:6a00:2304:b0:781:1e91:fd8c with SMTP id d2e1a72fcca58-78c98d5d579mr15544404b3a.11.1759789210762;
        Mon, 06 Oct 2025 15:20:10 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb281bsm13734968b3a.37.2025.10.06.15.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 15:20:10 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v5 03/10] dt-bindings: phy: qcom-m31-eusb2: Add Glymur compatible
Date: Mon,  6 Oct 2025 15:19:55 -0700
Message-Id: <20251006222002.2182777-4-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
References: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX7/0VqiNHuYJv
 QZnrOghdDSnm2/R/0KrcoXPPlvH+jiv/O24kv/37BD9jOg2KRiEv7hz4Y17KoUfoD7WcmjCI4sP
 QMbz45fc725m+C5TYtk9ETx3l6QOTdrqfxMipH6MscapOzZo6HjsuBZIDBqVBcCGEfEljg76eo6
 Hae2dbOQFgU5zpWyGdy9C7/TtQp31Onz5YU4DhWZ5AAiVaxnE0dfhI4S0Wy/mVHuV74kjoaYOGr
 hYJhF5PGwajJzxU5b+x7yRUqClLswT2cnfrYs+djQzKo0k7jhNNprCmJYJVrv44/plcC9yzFhOS
 6AHkQwTE2F/MDhxgB6zljgLbGA1XtgDnytaf93hzIkOHyptXBwu0bNF9TtWe6YVWYFJuR5PZWi0
 fCZfaiBbpJaiHgP5opmUQi6cr/1E7A==
X-Proofpoint-GUID: 3acZ-vz1mvsryyqE0b-AUf3lfbEvyjjS
X-Proofpoint-ORIG-GUID: 3acZ-vz1mvsryyqE0b-AUf3lfbEvyjjS
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e4409c cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=dJG6SERxbJy7wEyxA2sA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

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

