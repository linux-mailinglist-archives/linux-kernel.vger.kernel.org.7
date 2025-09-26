Return-Path: <linux-kernel+bounces-833688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1ABBA2B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 09:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE37E17D308
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 07:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA3B2882CD;
	Fri, 26 Sep 2025 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XVd4pMNv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067572877F7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871583; cv=none; b=pQ+3k+ozhIJ9wYRr/IwQZrlj8QbLH4Mu+8T0+832rSv5B32yXWoFzI4nw3+mI56LLaDubT4jW1M48CSg4PvKHmNvJ6Lb+2XGIDVyR+V2v0ucWMBEX80pObLp8aYdR/IasZSM3ZFUkl0d65EdfDOWNQIGGYeQMQyhawJJ+NNHx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871583; c=relaxed/simple;
	bh=upWyBh8lqfmu6LV7sTpbUr+WwNLCQ/FfInBDAu5O+9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qc5nclz461ONv77Xo/q9hP/ue9Mnn6Du6opdjSlDXCevvbTE9F34S+Ag9EpURRH0pZnvszVhbBENeg2Ufm4lgLhutVLlT9XYTdRFYenkX5jqwdVOvK15gqSr7YqErhjNGHCCc7DdHaDVvMLnwnNp7R+d9bcoz4QJn4ftr8B8QZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XVd4pMNv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q6x4qK015888
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2e7Hy87wIaFmYTkT/SRJPCIfc6N0tMOhDASgzvKcFpk=; b=XVd4pMNvfugGo4ho
	rsQfGkE9d6MGZmPhUheVr4VWV6ar7uge2eUpr1UnNvtruQoLX4pQ/RcgCRTW+7a5
	OgaU7isGRulQf+1XolJPPBBikmIXPhPmpYHmqk5gd5gQBt6TZzm982CRo6k9sZAX
	X6FbeWzSI01RLoaJQ+KdIjJCvPCRk/WSBsoT2kdRxNdkQQITLGjgJrkD7PdvPbAw
	mDOtsE/pUPRJXRbS6BvKqyeRlqITZSXQK3XgQXAS6t7WjOrMHPo00PENgfVC93Mx
	5EybkFVLjdts/fprbM53MgoKXN1f6SW+hJ+ILirsRlVk9QqjFYTMlS58OTFoyC3i
	MwPH/Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db0t9wkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 07:26:20 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eddb7bad7so485804a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 00:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758871579; x=1759476379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e7Hy87wIaFmYTkT/SRJPCIfc6N0tMOhDASgzvKcFpk=;
        b=Roz8cvEwoDSy2ZCJqnTcNAO6G4GQoJi8wLTCcTH3D4ISMa7W5Ptcsv/wlHDPn0fn7k
         WXPkHRVXrOaYbt1nWY4u6Cpd00KvMFw8cWNehXBo/Op5uMnuybxYbDrEr9NTp5DRrzRF
         Io7EdMikUJM7EyS13drgaCDqBHoKSlWSVyZFIJJ9U9StGPStrJ9bkr61CVq8VFrD60to
         vUqmtE/Pbldtt3jWth4j7TneRFgHkZdNr/KrKOsILmWw8Yd4LX3A/y7n7fn74aoRebMN
         Tp7CivXA+LQw/nuBveYhUkL7hBTqX26M/LUbTDfq1bOadfJS0vxK3sLc7WkSM4EUCaOU
         SqSA==
X-Forwarded-Encrypted: i=1; AJvYcCVu+UdksMNeErZ8cuFZ7cakq2Yzu3r9cY0bF4EGgj7iHZlnAYhwydSvI+bfweRUmH8CQU+XsbNRF4vKGkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMu4Pd8OP5gj4qp43LHpHM5nSxRS0Um1435N0QcyHpM/EyvRPk
	q3MGnZukvDKxeCcvuT0GIOtlLgY9i2RF7nJcjm87FcL4VZGMhW8ypg2Ms3jgJTu4x8QZFHbCQAU
	As/b3vmYzKutiqeOFzeGZ9B5icQYPnIyRSMSYI4zRnnrlT9ioI09jN3lgGOwii3aToEc=
X-Gm-Gg: ASbGncsAs1EWygq119vx62mVh2Qu3UQ/N70TcMrG0Hx8/+tIupXnHMkQUji37UoXres
	8ogLaTp8VCXb+ulduMX2Rj2FmonTpER2NfRJTZ+Q29GbPbr1CruaFY5HS6WlA/ajG9iBLsEWbSO
	8trMrkwSQ8LIMj0vtLdc7MJjGyeutNfQPivFDueTxvepRWha/1l0ATebmfjZzp9Tuzxix4f5wKW
	N1DcGsCfwT9a/p03fYc/MTM8JTxKZrNZNYJ1N/7XW6yMupxGgZ17iQoKsjIUusUrXfpNz5fD8fp
	6NtaS3RXRVvN40gQTc+nqeAVPo+6WL5hoyPxqqoDNd43njUj3jPcrmlyANcucvXr8X2GCQYRefc
	BY0PFD4EynTee4YEZPVv3mxfSm3H7W9Prnhck+Sp52rWF86PUV3y02RTY
X-Received: by 2002:a17:902:8210:b0:27e:eabe:7604 with SMTP id d9443c01a7336-27eeabe7ad7mr12133745ad.9.1758871579494;
        Fri, 26 Sep 2025 00:26:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAa2bZIUvZ/fMfkpjyLvaZZws4+i1XtR3RZF24APnyUt8R5PXamasJ9KugA1kJ8xeGnyatmg==
X-Received: by 2002:a17:902:8210:b0:27e:eabe:7604 with SMTP id d9443c01a7336-27eeabe7ad7mr12133375ad.9.1758871578931;
        Fri, 26 Sep 2025 00:26:18 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671d8a2sm45117985ad.55.2025.09.26.00.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 00:26:18 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Fri, 26 Sep 2025 15:25:37 +0800
Subject: [PATCH v7 01/14] dt-bindings: phy: Add QMP USB3+DP PHY for QCS615
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-add-displayport-support-for-qcs615-platform-v7-1-dc5edaac6c2b@oss.qualcomm.com>
References: <20250926-add-displayport-support-for-qcs615-platform-v7-0-dc5edaac6c2b@oss.qualcomm.com>
In-Reply-To: <20250926-add-displayport-support-for-qcs615-platform-v7-0-dc5edaac6c2b@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758871562; l=3580;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=upWyBh8lqfmu6LV7sTpbUr+WwNLCQ/FfInBDAu5O+9Q=;
 b=JfaeqU3+hlJ1OLbENBUNv32kEiS9ilat5jb4eIX6JV/6qs0s1jIEQdNeG7Q3eHdAOyUTNVxcY
 Ifpbu8NIITtBig+3IbyNrnLGoEmW0ri2aMMjpaGkCrpcwkZhzWWhzrO
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-ORIG-GUID: 8Rv7VpPy1ciOp938m9zHvOeUcl9ymTGa
X-Proofpoint-GUID: 8Rv7VpPy1ciOp938m9zHvOeUcl9ymTGa
X-Authority-Analysis: v=2.4 cv=Jvz8bc4C c=1 sm=1 tr=0 ts=68d6401c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=z8W1oWq9hX_DlPyfQGsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX346HaDMrawWC
 h6HyOyqKDIZ+qSklaRX8XKPLkKcAHYAViGKR5EGzTNfjJUTHkPz5iJlkigwMlhFFFwPY+m2lUZX
 yibsBy/oH2fuXlLSW/uYxDhFIAeeNjHeAEEk/qze6RZGC7fishdE7CPMqTAjkIRuDsiKa0TtmlN
 JKNOoN0O4VStQKOQ2BIDYg/695yod8UxnwoeZq1Kg/27BA6NjTCVDiR9lN/2KMPIfOpTxkuNKS9
 bsb+m3ZD5X0c+bWIgA9TEc0mD4Xu6U/ZdZuZQM2W3f3RqxrZfQVRRQhdJRRPEU9zZXQtfdEQ6/J
 +KAbOG+LoUDlQE/BjxU9BSNa/bo6iDVud6NZvNrv7ahgUExQshoQg/DRoDdvQfbl0pZhyLykPWJ
 Bw6lvFuo8Gsy1twZ3w+g1bmqQaIcPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

Add device tree binding documentation for the Qualcomm QMP USB3+DP PHY
on QCS615 Platform. This PHY supports both USB3 and DP functionality
over USB-C, with PHY mode switching capability. It does not support
combo mode.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 .../bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml   | 111 +++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..efb465c71c1b5870bd7ad3b0ec215cf693a32f04
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,qcs615-qmp-usb3dp-phy.yaml
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,qcs615-qmp-usb3dp-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QMP USB3-DP PHY controller (DP, QCS615)
+
+maintainers:
+  - Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
+
+description:
+  The QMP PHY controller supports physical layer functionality for both USB3
+  and DisplayPort over USB-C. While it enables mode switching between USB3 and
+  DisplayPort, but does not support combo mode.
+
+properties:
+  compatible:
+    enum:
+      - qcom,qcs615-qmp-usb3-dp-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: aux
+      - const: ref
+      - const: cfg_ahb
+      - const: pipe
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: phy_phy
+      - const: dp_phy
+
+  vdda-phy-supply: true
+
+  vdda-pll-supply: true
+
+  "#clock-cells":
+    const: 1
+    description:
+      See include/dt-bindings/phy/phy-qcom-qmp.h
+
+  "#phy-cells":
+    const: 1
+    description:
+      See include/dt-bindings/phy/phy-qcom-qmp.h
+
+  qcom,tcsr-reg:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to TCSR hardware block
+          - description: offset of the VLS CLAMP register
+          - description: offset of the PHY mode register
+    description: Clamp and PHY mode register present in the TCSR
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - vdda-phy-supply
+  - vdda-pll-supply
+  - "#clock-cells"
+  - "#phy-cells"
+  - qcom,tcsr-reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,qcs615-gcc.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    phy@88e8000 {
+      compatible = "qcom,qcs615-qmp-usb3-dp-phy";
+      reg = <0x88e8000 0x2000>;
+
+      clocks = <&gcc GCC_USB2_SEC_PHY_AUX_CLK>,
+               <&gcc GCC_USB3_SEC_CLKREF_CLK>,
+               <&gcc GCC_AHB2PHY_WEST_CLK>,
+               <&gcc GCC_USB2_SEC_PHY_PIPE_CLK>;
+      clock-names = "aux",
+                    "ref",
+                    "cfg_ahb",
+                    "pipe";
+
+      resets = <&gcc GCC_USB3PHY_PHY_SEC_BCR>,
+               <&gcc GCC_USB3_DP_PHY_SEC_BCR>;
+      reset-names = "phy_phy",
+                    "dp_phy";
+
+      vdda-phy-supply = <&vreg_l5a>;
+      vdda-pll-supply = <&vreg_l12a>;
+
+      #clock-cells = <1>;
+      #phy-cells = <1>;
+
+      qcom,tcsr-reg = <&tcsr 0xbff0 0xb24c>;
+    };

-- 
2.34.1


