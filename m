Return-Path: <linux-kernel+bounces-825476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C8CB8BE1C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 05:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE001A07558
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39CA23B63F;
	Sat, 20 Sep 2025 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PyDhJLE+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AD6215F6B
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758338483; cv=none; b=F6HLBzpQkGZPxdK3I6RCPrwvfkgN8I8hRMoyn6tZ6G8CQaltMEnfFVC95MKwxMvl9LcVBLfWVKSos3ccsyzFysSBs/eIckrrk8gb3holQhPZ+TPzFjrp7L9uhIQqzUhWWgfsTL6ywrX9utE298kgYQb2kv5LqkaMiKsc/rkmqYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758338483; c=relaxed/simple;
	bh=y84fa6fvuCZpJxjEsWR6XfroWoXIZOXTyVARiLBoUh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u3Z1IQklJ1lwJGeUiq4iKcHo9qwaKEdnrp+DE39bH/WmQu3R1pL6C8hBSR/uhg+oUtA/++vu9btbhXr4l4UHyNdobD4XHYSJIerZagGC7ANXaX6lUzK3ErWfNDWatJUwnL2qnmyKtHZKR90U7ARTDBaT3wjDc2rljEkyXdbcJdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PyDhJLE+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3FSL3023742
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=g6hGIMMv3wb
	uPomMpx8H8k/GiKEKmx7JPEl9gfJaIng=; b=PyDhJLE+UFGTK2DP0UZR0iYLQcs
	NBnVt5bmN4Jm7ZJ/Y+yWzTgtv78XS+fUkAruXHkKOiWjdi3y3tvUGoBuJV5Zi58y
	dpw3Bivinq3lm6qkgYEucNQ+d0eUMyIsvEmIa+4ienTbKFAUhrxOaTD4a/ssNudU
	INNdgP9YjzR6pB3vsjj1xMBf8zu7kUwkDC+p3iUfPSscZus5JYwHD+Ts4lzUNrH+
	Fw/H6aMGwQ4c0wtwMrb8u5yC2EOXrXhDVpb9SjGq3EcGlo7kmEBlJ14ZObFaqcTO
	EGW6TXeqcr2BnviTPb1Zl2dVZI4djNevrc0FITijT114mulYRfEuhnFT8Ew==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxwmfxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b54a2ab0f2aso1893209a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758338480; x=1758943280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6hGIMMv3wbuPomMpx8H8k/GiKEKmx7JPEl9gfJaIng=;
        b=DrFOagsxlv7T9mA0jnhV0+mW4YEoL8HCHQ9s8lpbaqnyJ3j85pwUMZL3V0WlkS/I1n
         nEXbQQeyBNpSFyFmHJyQNceRd7IMwdPxmo7sr4MC5GVTcnQzDm5KBx6QVHNW6yc+prjN
         f2alkqYVR2E6ybVKy/T5aJmkKDTwDAOa111QOvcTTxjoloeWBQ0vNgQUXvPxkfY/IKiX
         HaC0uyC+ufO8fT2dKf64oRde5Anw1fsRvx7cXUsHET/H9aGMvhOjVmDXabTnpu5IoSF5
         n1xxQOcNtU7h6md2HsqIdBfPnuQrtGf1Fm5qnkRH//oSmxggloPO/lb4YR8Xm53qP2Lg
         W06g==
X-Gm-Message-State: AOJu0YxtJJCvwDz2z/wuJFd8BpsLgZF3Wr/fy+3wyCFXQm69TIbtFXyy
	ekDs7ptqNya4Du3R9TclSaOxXovppCVFclXUBYUsq/oV6u32SDSSNYF9L9bidCmBB+ijgGOec9i
	iKRyB+/a5/KdCnXYvF9APr8/sa62ZPc5XshP2lvVwCSrLrL1b7a+5/+ikL4fSOanzeVA=
X-Gm-Gg: ASbGncvcyCneYCQWAdt1Z1hh4WExmCzdxaNKpn92Eg3zSNC6fZASr6PUzshevj/rUCb
	4yD+nEawndPEwRM6X+j86RZVgOvBnNM14mpNn1p5maVd/3i4J14zCk1UlyJJwiMUf3lX8jywzm9
	8NyNC7+o5CLQoGHnIPEo0u1Uds1RbDlz3VBn+QxUh1C/d7irFm9u6GSEaLoFbPlkaIRnOV2iJO/
	yttx/uFiuIllKStN19VnKt8KkkT8Mn0uO6x2dQzI0E3GloKOUOFUNKRDLTyTzBfiAGx1CqRwrxU
	uyrncIjHTBf6z8Qx/USICwyzZOn8hvIDSvV4oE2AI+Aj1ZuJqRRQKyJE5s3hzzSduSj6jerXZNl
	7Xfl/6cXG5qfBHds/
X-Received: by 2002:a05:6a20:72a2:b0:249:d3d:a4f0 with SMTP id adf61e73a8af0-2845ed1da85mr16281156637.14.1758338479845;
        Fri, 19 Sep 2025 20:21:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFetA3WDam0Qho0OajI7y40pyPQFuw0lP5o44u6ANcRyJ15kqRkUGW2DaxpCx9AGXT0Vc6BNg==
X-Received: by 2002:a05:6a20:72a2:b0:249:d3d:a4f0 with SMTP id adf61e73a8af0-2845ed1da85mr16281090637.14.1758338479024;
        Fri, 19 Sep 2025 20:21:19 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff448058sm6178807a12.54.2025.09.19.20.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 20:21:18 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH 4/9] dt-bindings: usb: qcom,snps-dwc3: Add Glymur compatible
Date: Fri, 19 Sep 2025 20:21:03 -0700
Message-Id: <20250920032108.242643-5-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HbIUTjE8 c=1 sm=1 tr=0 ts=68ce1db0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JYTQWVwI1XGucIoeipMA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXz4V6qTCi3fcj
 /JZfXEhxsgHHGjXHxWFpi4BwG7cuXjgwwI2JMKW1roavMKIzVfEhM0t2axF1oARV25wT7BEr1EE
 95Xwc4nTxreUEKn3DWqaaOaL+CqcZbnzKF47dHCBUHqXH8JFcuimgZXEFI2Sk8RiyGYpOgZEVTb
 4pHrK7sDOFapBmC2rfaBGaA078JztGyZTpSXIHtVYePOkVJYGPgLJ88hF/lGqeImLyZzbZ7PCjH
 FS/fIGz+5vRJHuJqX3FuUEH0g8np+TTxMwhGW+INIjBI4Oroupv+OblmjTfNTP4J6CyuiFeaAdc
 dsZLfxxlmbKpWcQLHMuzS0ggHPZ4Y1u/hzepDI+dY6tb3w65aq7kweBiZ0kfRBjnXInBjsWFjiF
 9A0qc99W
X-Proofpoint-GUID: -gjjCGgUBOZAI2L0Dk3i6LircezAoHf6
X-Proofpoint-ORIG-GUID: -gjjCGgUBOZAI2L0Dk3i6LircezAoHf6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202

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

