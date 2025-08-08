Return-Path: <linux-kernel+bounces-760343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B472B1E9E1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E15A06C10
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BD527EC73;
	Fri,  8 Aug 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XkT+Hxdu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CDF27C162
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661838; cv=none; b=MjQwagdh07nF5gRn0JxDLNXCK2X490443ea7fBhXHE7yE/WB273w8SN588Urz3GcgxYRfKgER7TGzx7V82gGoDy7zIFoY3qmn8r73KaBOC5W92hhSl2Z/QvhIO+GJ9carJaibGE8eAJWLl48uazYhe32y4AsBQOzfwJd1K1jNPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661838; c=relaxed/simple;
	bh=NIUgvFjTnufpMaUkhepDMTHRYMdG1B9PZQLZLAxkW70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Vj/v9JuCQeFCYFBnfWMWDhC11CPozeguiqOvbilWg8a/5bKl1Vjgx8YN7oNo+fZKuBLH/QAlLadNx3MK+RMgvvOUd+tU1HYGWRnzk2VROq8IbOh6r42u6Udc9J1u2DXApWpc/EBJYh30FlvAmsBnaXf5BBh+92iub59Gr7ZTj8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XkT+Hxdu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5787P3ng007824
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 14:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=cnwUV/QDjexBy5i2zSATpYmuz01jPJJmOp4tvR0Fjy8=; b=Xk
	T+HxduDoSB2QQmVB7zz54+Mo7dYHn/AApzxrJE1mNG/dPhFcIo2Z6QWFDef6pgrO
	PTzTqeBGVnzDaFfALKMtniB0lgPPQB2ox0Cc8LYD64IJs89LXZMEbDRS0qIzw2Fz
	gdBz1CADWa+Q7BmejfEFsB1aJAE0d5BuKoWunBjzLygXVKOkmgo2ZYV/W+vxUZrD
	3Ggkzn88o6gx16g+tDTABZYa2sHrkGqFHtFqPG4Rvo5yFN6hUUsN1pyCxke0TSuL
	rpCEMVrQog1NRx1F9HQaOW96+qY3eZ0TPwcuP4Hx20xe7hF7NRUprG4Fyl/iRXLA
	EZFEjNHNprdPInLi4Wlw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48c8u278pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 14:03:56 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76b6d359927so1538378b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 07:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661835; x=1755266635;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cnwUV/QDjexBy5i2zSATpYmuz01jPJJmOp4tvR0Fjy8=;
        b=EVKJ/Wk4w96ibfbKuetIZ+N5Y8+ujUtb/8RCPyaT+ZLaYu3BBmXAiGvX6Xw6vqEpyX
         fCbBnhUMKFZe/7ijflsIjaRNphx+SMzsimv35SA0LuRQ9dwcKBih+8T1uwYEhpVUF0rr
         Q58h/Q6On1UPrRQEr4LF9exQyqndajuAjomxxLCxQBAUzXOIbDwsS+WVEeXMFSbQ7s3a
         70L8SLzxfea4mE6vBvoxUFunNd4E1P6ewLEfRC8WCOxu7ba+6QXVCsdZ8AVhVorB/BEN
         LKcu7DIqyOWiW40EhBOvCSGZdIn0LwDt0Du8AnSfDUepuUA46ayIz9qEgm9m19abQGKM
         wD1A==
X-Forwarded-Encrypted: i=1; AJvYcCV3xjk0LmZZJwyCohFo4+PxicipzhfA8E1fgsOL3MxEwV11f3eCdm+p50bjOAoa/RuqX6dhGMdzMsgXMls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLsq/8QCYWDlkucEWWW+qVu3tm4fy9OLgdkE33Lmrg4l/tFsx
	EdoCZ1EFOMRfkRqW9/SVeKMAd6Ba46JcLaT1LsNXPZWEHZ/HItrZGVi+z4Hms3FueQ78zNb3OPd
	y3/vrZAQZdOHX+2D3a5Fe/ObfiWWSheqntnqljrgIQHVmC4qmqalmz8Gp81ke+6dhLtg=
X-Gm-Gg: ASbGncuFlb+YXWm8TBIQQQXPDMJuI7WxhN9oqLu4FYeiEiFOOKfzQkvGnhoXGeY+CLM
	MMyv2nu56jugUnQz7xn64ZlCrVtl6uKJxYWxCHOTAYDwcP6oiL4HIHID0QLrlmmk1H8+oR2iWHg
	uM6oWQ9ifvug6swutHsytWwRT8yehVhH/p+JSy8dCr1K5lIRz47p/OGn7jF87tCl6Utbq9V5dg6
	e+SQCxZnLEwLNHBoDwWfJLkHZtDHzK9fjIVjrgcay3D8ZbM4hSNVW8+3gE2ywT7wV13sF+1yh2J
	gpwAOn7ryTmedAUwqcVUsRpUAmyrE1z28Cf4NuGZzS+Yya54ME+LnUgDOGzwnTLddWsz9MuMCA=
	=
X-Received: by 2002:a05:6a00:23d2:b0:76b:c557:b945 with SMTP id d2e1a72fcca58-76c461f7dfcmr5163483b3a.24.1754661834240;
        Fri, 08 Aug 2025 07:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTzksWDnpE2o7+ZsFPvW6Wq4obz7S9H+b2kg5hFSWzEbMcyjh4qUMKtT2DtOoa8U5Mt9x6nQ==
X-Received: by 2002:a05:6a00:23d2:b0:76b:c557:b945 with SMTP id d2e1a72fcca58-76c461f7dfcmr5163411b3a.24.1754661833734;
        Fri, 08 Aug 2025 07:03:53 -0700 (PDT)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2078afd8sm8595621b3a.117.2025.08.08.07.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:03:53 -0700 (PDT)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH 1/3] dt-bindings: interconnect: add clocks property to enable QoS on sa8775p
Date: Fri,  8 Aug 2025 19:32:58 +0530
Message-Id: <20250808140300.14784-2-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
References: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
X-Proofpoint-GUID: 1br3pG57w0N8FCWoOf8Ss4yRty_DbyuY
X-Authority-Analysis: v=2.4 cv=Q/TS452a c=1 sm=1 tr=0 ts=689603cc cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=kq7KVtybw__Sne4F7ZAA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 1br3pG57w0N8FCWoOf8Ss4yRty_DbyuY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA5MCBTYWx0ZWRfXzyrMsKcMJbuH
 QZEiVkOrOhwpYeqcPwhzSyWFLyWhJEFqHEVY3vsLTPBgz/bFTSjZ6STXEnVn7pFXQxN6wTqLaBM
 UQ76sNCrJOXRWJEWFwMKXPUZgAb2/NwbPGZRwWwAArrSlvla7F1mR8j/saRhz3gVP/A1SRH+rCP
 SuR1ie8sYOrwuL5KLqz0Ln+j6RaRbDwPz7qFJn+vqYu1qRhS+eVCi3PjgvPXOnFKjiswewAAkAF
 dXfgpD1lpeChrtM5OUq3cbXffDs6QpnWymuPD8v7qmaYGoPjb83cR8fxTtHCZ1055RqpE6zLBKj
 Ndy1601ywuUlpF6IYE39S5i62wE6UKsrByj8rzun/d/BMWVr8Q9UHjuw4Z+Hs5neoZ05nqT7bwN
 W+A7efdB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060090
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add reg and clocks properties to enable the clocks required
for accessing QoS configuration.

Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
---
 .../interconnect/qcom,sa8775p-rpmh.yaml       | 78 ++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
index db19fd5c5708..be3d02fb73a4 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
@@ -33,18 +33,94 @@ properties:
       - qcom,sa8775p-pcie-anoc
       - qcom,sa8775p-system-noc
 
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 5
+
 required:
   - compatible
 
 allOf:
   - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-clk-virt
+              - qcom,sa8775p-mc-virt
+    then:
+      properties:
+        reg: false
+    else:
+      required:
+        - reg
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-aggre1-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre QUP PRIM AXI clock
+            - description: aggre USB2 PRIM AXI clock
+            - description: aggre USB3 PRIM AXI clock
+            - description: aggre USB3 SEC AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-aggre2-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS CARD AXI clock
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sa8775p-aggre1-noc
+              - qcom,sa8775p-aggre2-noc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
 
 unevaluatedProperties: false
 
 examples:
   - |
-    aggre1_noc: interconnect-aggre1-noc {
+    #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
+    clk_virt: interconnect-clk-virt {
+        compatible = "qcom,sa8775p-clk-virt";
+        #interconnect-cells = <2>;
+        qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre1_noc: interconnect@16c0000 {
         compatible = "qcom,sa8775p-aggre1-noc";
+        reg = <0x016c0000 0x18080>;
         #interconnect-cells = <2>;
         qcom,bcm-voters = <&apps_bcm_voter>;
+        clocks = <&gcc GCC_AGGRE_UFS_PHY_AXI_CLK>,
+                 <&gcc GCC_AGGRE_NOC_QUPV3_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB2_PRIM_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
+                 <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>;
     };
-- 
2.17.1


