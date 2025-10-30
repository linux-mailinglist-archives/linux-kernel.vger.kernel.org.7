Return-Path: <linux-kernel+bounces-878748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CBBC21674
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECD0400170
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EC6368395;
	Thu, 30 Oct 2025 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hFRYfQqE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LFna9eFe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9363678BA
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844158; cv=none; b=TDoWK2p0wn5I0JugU8yWPSDmUdpQuQmaspd3NbsWx/pF+2Uppt+3s+STWcYVIArWrhR5qTqmOIefAthf03JpblikiGVUA7mxJ6OFpCYe4Vhgxt/kWwgHBpYfxiJcWNagv9EKQ2oY4dviFkFRrs2wzXol0Xy2QLSIJ0PHipcD9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844158; c=relaxed/simple;
	bh=284oZJrprtqqJvI9jzjB9aag+XYMV+eNVnrWIJN+Y0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AflR7K+Os0AUvHHRWZO9cTmqZ1K8waqHgEb3tqD2qX94F5/oCVLJWw8Uld3KIIoOKzyBXtOepin/EX8cbtDAXI8sHHOheAMnuhT43WoTOXnGeQmL66k89QKBOwvBQJubqix4JjaQQnAMGrKC/Ro33PTxhXmHj24FaT/LB02wsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hFRYfQqE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LFna9eFe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UG6SUm1693360
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uqgEoLygmGvqSS/ZSw83qfxke5a611yzjwt2jNER7Ko=; b=hFRYfQqESdsR60wW
	WEdUpu6r0/GZOd8qW7gip9n9EsiXUScJVLiVX6HGJUZ/7KQj3LGPAGGrbWgBG17/
	yyIDFHDktjttnQTIHwxoBDz7IcSfZdjRyX+yE9ux1tmiX2X7Ja0Rrd1MlVl2qYjj
	ivC8T8Wx1YUwZxNLWjvnYcNskFZBDAip2pdqPH7mR0dEzlLMFL/5BqYm2O3r93vd
	bbKLboceXUYaC3l4838KWFYWVmOe2SAJotm5TlGvmVtmuPu0vYbTMWO7XtYinGeP
	VAjuMVeGb2cWD2v011LwXf08mqvItfUH+J3zHpt8kdLaVnbOUz8Zo3OkkSoarOpe
	txoMtw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3trv32yj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:09:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6ce15aaa99so977633a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761844155; x=1762448955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqgEoLygmGvqSS/ZSw83qfxke5a611yzjwt2jNER7Ko=;
        b=LFna9eFelvELsMo71A3IzINiEbg5uujVJYuTZYFzHrr3LEKUh/AmRgPQowrNqxTcoP
         6K1SbuyR9p/MchiyCcNlrFNO71nUyz6yeDYHzGW37Qpy5LJ5IFRh2t0Y4ZjLXlsw/U6M
         xqyHM+GfPDDOECihWjUSXeh3i0FLqpfW+SZ/H3FeiNTKCae4njgb6JsXVIM0A+Q+s5nE
         yU5/4Wbf+S3myfhoODsHbDYL3lXk+xPBKHg/LBRKvNgZYLim2exiGvsaZXF0pZevLjCc
         vGZSmtWrOJ6XLZYdISoLnWzxzLrdRXBDfFwdx+L1Ab269A4WJfeBDlpG7Wf8Y2YI9/Ap
         4GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761844155; x=1762448955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqgEoLygmGvqSS/ZSw83qfxke5a611yzjwt2jNER7Ko=;
        b=Y0zpd3F2jRqjKAH05u5QZ2op6f9TYS1Mna9ztdaQTPVkd51nw803KIKLlGa3zT5dbm
         sXO7Rq6Bhzxv19OOjIpbGfcufO1T4KHmSyrHmT1vsqe4of4M2tNFUdMz5LgmdK8P3xqx
         xvGxuCeQbvvATYf7Us5d6A/8ZqzGMHGjdn4JCDU9LLhYjQBCNxo1X0P4Vrk30eLDK2lH
         H5XsPGBOweVL31rn0EnOM2a+pQOA8rSrnqYtgMzzE4Lj1T44tL74zP/WDTqQslEdyZSu
         AImalilWXeLiJHDy878WDRa8UFEF6ESt0M0jw5TctHVv+emJpgNhjrun79dfyZq6jr7p
         nCug==
X-Forwarded-Encrypted: i=1; AJvYcCVNQrjqfkZw1n7YEZvkZ+Dtduh7lBnI0/9VUUwb7U1EaSn4QEUtNd+P/KSiGJZXjNQBjW2NTjDZa/KfRdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWnt2lXGRWFRYZQAp10sWCGLON6y9DWh/z15kbhhluERBHH5H
	YBVieFW7bZShuO09wuDXToj/QYnRELNKhXKGoY7oq9dpU0/i7GGYeiP2ZV6dZ7iwNVW9DfYxvnI
	yXeJOaSdf/iKtqnpDVHTiPUttYVyzZooN3niOY8pgOayb7pDaeR42jwQ2d+zWNgGG2Fs=
X-Gm-Gg: ASbGnctbCyQT805I9gQ2bPWzDnSx1O+g6sr6skHAg8ob0Eyp23i++pq9hrjEI+BcraT
	lUNS6CgXYRT94K81jePuqDX4C5ERdvDqcbTUOFhCZduAU0YZJUeAz40cW22hV2Ch2aSQk7CPIIU
	jkHlomM9Ko1Nth203nHQeJNgFLUb5dH8EK7TFKaWrIPIXBjTv6Zgu5Yn7jPf5qZfYb0ZGW6KssO
	Kg1jB8ZvPqL8rhgh5TdMGMdg2H5cp2Y16hpJDPPGOKj3k4y8R8rCMMX6GqrGr157GGaKr7x5Ntg
	voIoepa6VAgRkLbWu+XBIoE6j7cE7aRUhPM0P4qWw0gbPsgNPuwSuGxhlGBbKbwDdcqgQ4D73Q1
	OtRjkPe9b2xZkwnghMSLtXw==
X-Received: by 2002:a17:902:cecc:b0:290:5601:9d56 with SMTP id d9443c01a7336-2951a477313mr6675695ad.46.1761844154854;
        Thu, 30 Oct 2025 10:09:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdXDZ/g2T7IuFuhWkteyh4ODmvatZFX8zLNCmCIujP2X/GJtEb95oBrlWAgUtbKOEV4OtcgQ==
X-Received: by 2002:a17:902:cecc:b0:290:5601:9d56 with SMTP id d9443c01a7336-2951a477313mr6674945ad.46.1761844154174;
        Thu, 30 Oct 2025 10:09:14 -0700 (PDT)
Received: from [169.254.0.7] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d09855sm192828595ad.30.2025.10.30.10.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:09:13 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 17:09:02 +0000
Subject: [PATCH v3 1/2] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Kaanapali SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-knp-interconnect-v3-1-a084a4282715@oss.qualcomm.com>
References: <20251030-knp-interconnect-v3-0-a084a4282715@oss.qualcomm.com>
In-Reply-To: <20251030-knp-interconnect-v3-0-a084a4282715@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: T_gx-gf3FEUk8tDa53pg_OltTE3BfIxq
X-Authority-Analysis: v=2.4 cv=D+ZK6/Rj c=1 sm=1 tr=0 ts=69039bbb cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=0nnlnVUgiuWpLmFhrigA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: T_gx-gf3FEUk8tDa53pg_OltTE3BfIxq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE0MSBTYWx0ZWRfX/xYcFPkODUiY
 U1PAnU/CBpns+uY2zBv7CAZtSyxxNp4Hv9M4GSqP/kG7stK1f8Xxu31Nx9Gt+BChzJWYQ/7Gzgy
 pW+pvztPpdCV/FNMJkldhGwDahXI0m5R4FMHbv4mRW0rLFR2huy+O9JEFVZaZPU2B+VG1oG3ZxF
 oDYw9B59JOBgQWdM6XWpFxS+DGiewVot4n50iITKyOaTFOSwYuFsbocyxuIkf9u/+UrJ22xtwcq
 8IGl2Z5nkXN0JHNHDPPCYPsJ2h4a5z3M3lTi2GVhViUCxUvk9h+IcaOD8m1CGN8O/6+A/hpDUdD
 i4zBgzvK6mnYwT94sy8lKI+4qjYfV1Yl9z+bZQlJJGcEeRs1eezR9KdAb3Kt3EPz6Wd+WSaLHmi
 iXdWWntLBKA9Y3UBC5TI0z/9Z7sbmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300141

Document the RPMh Network-On-Chip Interconnect of the Kaanapali platform.

Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,kaanapali-rpmh.yaml | 125 +++++++++++++++++
 .../dt-bindings/interconnect/qcom,kaanapali-rpmh.h | 149 +++++++++++++++++++++
 2 files changed, 274 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1cf12521eab1cb7e0666162c9e49562e13c43172
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,kaanapali-rpmh.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,kaanapali-rpmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPMh Network-On-Chip Interconnect on KAANAPALI
+
+maintainers:
+  - Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
+
+description: |
+  RPMh interconnect providers support system bandwidth requirements through
+  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
+  able to communicate with the BCM through the Resource State Coordinator (RSC)
+  associated with each execution environment. Provider nodes must point to at
+  least one RPMh device child node pertaining to their RSC and each provider
+  can map to multiple RPMh resources.
+
+  See also: include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,kaanapali-aggre-noc
+      - qcom,kaanapali-clk-virt
+      - qcom,kaanapali-cnoc-main
+      - qcom,kaanapali-cnoc-cfg
+      - qcom,kaanapali-gem-noc
+      - qcom,kaanapali-lpass-ag-noc
+      - qcom,kaanapali-lpass-lpiaon-noc
+      - qcom,kaanapali-lpass-lpicx-noc
+      - qcom,kaanapali-mc-virt
+      - qcom,kaanapali-mmss-noc
+      - qcom,kaanapali-nsp-noc
+      - qcom,kaanapali-pcie-anoc
+      - qcom,kaanapali-system-noc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 3
+
+required:
+  - compatible
+
+allOf:
+  - $ref: qcom,rpmh-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,kaanapali-clk-virt
+              - qcom,kaanapali-mc-virt
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
+              - qcom,kaanapali-pcie-anoc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre-NOC PCIe AXI clock
+            - description: cfg-NOC PCIe a-NOC AHB clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,kaanapali-aggre-noc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: aggre UFS PHY AXI clock
+            - description: aggre USB3 PRIM AXI clock
+            - description: RPMH CC IPA clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,kaanapali-aggre-noc
+              - qcom,kaanapali-pcie-anoc
+    then:
+      required:
+        - clocks
+    else:
+      properties:
+        clocks: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clk_virt: interconnect-0 {
+      compatible = "qcom,kaanapali-clk-virt";
+      #interconnect-cells = <2>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
+
+    aggre_noc: interconnect@16e0000 {
+      compatible = "qcom,kaanapali-aggre-noc";
+      reg = <0x016e0000 0x42400>;
+      #interconnect-cells = <2>;
+      clocks = <&gcc_aggre_ufs_phy_axi_clk>,
+               <&gcc_aggre_usb3_prim_axi_clk>
+               <&rpmhcc_ipa_clk>;
+      qcom,bcm-voters = <&apps_bcm_voter>;
+    };
diff --git a/include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h b/include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h
new file mode 100644
index 0000000000000000000000000000000000000000..dde3f9abd67764421f54f8d222979727905a0a73
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,kaanapali-rpmh.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_KAANAPALI_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_KAANAPALI_H
+
+#define MASTER_QSPI_0				0
+#define MASTER_CRYPTO				1
+#define MASTER_QUP_1				2
+#define MASTER_SDCC_4				3
+#define MASTER_UFS_MEM				4
+#define MASTER_USB3				5
+#define MASTER_QUP_2				6
+#define MASTER_QUP_3				7
+#define MASTER_QUP_4				8
+#define MASTER_IPA				9
+#define MASTER_SOCCP_PROC			10
+#define MASTER_SP				11
+#define MASTER_QDSS_ETR				12
+#define MASTER_QDSS_ETR_1			13
+#define MASTER_SDCC_2				14
+#define SLAVE_A1NOC_SNOC			15
+#define SLAVE_A2NOC_SNOC			16
+
+#define MASTER_QUP_CORE_0			0
+#define MASTER_QUP_CORE_1			1
+#define MASTER_QUP_CORE_2			2
+#define MASTER_QUP_CORE_3			3
+#define MASTER_QUP_CORE_4			4
+#define SLAVE_QUP_CORE_0			5
+#define SLAVE_QUP_CORE_1			6
+#define SLAVE_QUP_CORE_2			7
+#define SLAVE_QUP_CORE_3			8
+#define SLAVE_QUP_CORE_4			9
+
+#define MASTER_CNOC_CFG				0
+#define SLAVE_AHB2PHY_SOUTH			1
+#define SLAVE_AHB2PHY_NORTH			2
+#define SLAVE_CAMERA_CFG			3
+#define SLAVE_CLK_CTL				4
+#define SLAVE_CRYPTO_0_CFG			5
+#define SLAVE_DISPLAY_CFG			6
+#define SLAVE_EVA_CFG				7
+#define SLAVE_GFX3D_CFG				8
+#define SLAVE_I2C				9
+#define SLAVE_I3C_IBI0_CFG			10
+#define SLAVE_I3C_IBI1_CFG			11
+#define SLAVE_IMEM_CFG				12
+#define SLAVE_IPC_ROUTER_CFG			13
+#define SLAVE_CNOC_MSS				14
+#define SLAVE_PCIE_CFG				15
+#define SLAVE_PRNG				16
+#define SLAVE_QDSS_CFG				17
+#define SLAVE_QSPI_0				18
+#define SLAVE_QUP_1				19
+#define SLAVE_QUP_2				20
+#define SLAVE_QUP_3				21
+#define SLAVE_QUP_4				22
+#define SLAVE_SDCC_2				23
+#define SLAVE_SDCC_4				24
+#define SLAVE_SPSS_CFG				25
+#define SLAVE_TCSR				26
+#define SLAVE_TLMM				27
+#define SLAVE_UFS_MEM_CFG			28
+#define SLAVE_USB3				29
+#define SLAVE_VENUS_CFG				30
+#define SLAVE_VSENSE_CTRL_CFG			31
+#define SLAVE_CNOC_MNOC_CFG			32
+#define SLAVE_PCIE_ANOC_CFG			33
+#define SLAVE_QDSS_STM				34
+#define SLAVE_TCU				35
+
+#define MASTER_GEM_NOC_CNOC			0
+#define MASTER_GEM_NOC_PCIE_SNOC		1
+#define SLAVE_AOSS				2
+#define SLAVE_IPA_CFG				3
+#define SLAVE_IPC_ROUTER_FENCE			4
+#define SLAVE_SOCCP				5
+#define SLAVE_TME_CFG				6
+#define SLAVE_APPSS				7
+#define SLAVE_CNOC_CFG				8
+#define SLAVE_DDRSS_CFG				9
+#define SLAVE_BOOT_IMEM				10
+#define SLAVE_IMEM				11
+#define SLAVE_PCIE_0				12
+
+#define MASTER_GPU_TCU				0
+#define MASTER_SYS_TCU				1
+#define MASTER_APPSS_PROC			2
+#define MASTER_GFX3D				3
+#define MASTER_LPASS_GEM_NOC			4
+#define MASTER_MSS_PROC				5
+#define MASTER_MNOC_HF_MEM_NOC			6
+#define MASTER_MNOC_SF_MEM_NOC			7
+#define MASTER_COMPUTE_NOC			8
+#define MASTER_ANOC_PCIE_GEM_NOC		9
+#define MASTER_QPACE				10
+#define MASTER_SNOC_SF_MEM_NOC			11
+#define MASTER_WLAN_Q6				12
+#define MASTER_GIC				13
+#define SLAVE_GEM_NOC_CNOC			14
+#define SLAVE_LLCC				15
+#define SLAVE_MEM_NOC_PCIE_SNOC			16
+
+#define MASTER_LPIAON_NOC			0
+#define SLAVE_LPASS_GEM_NOC			1
+
+#define MASTER_LPASS_LPINOC			0
+#define SLAVE_LPIAON_NOC_LPASS_AG_NOC		1
+
+#define MASTER_LPASS_PROC			0
+#define SLAVE_LPICX_NOC_LPIAON_NOC		1
+
+#define MASTER_LLCC				0
+#define SLAVE_EBI1				1
+
+#define MASTER_CAMNOC_HF			0
+#define MASTER_CAMNOC_NRT_ICP_SF		1
+#define MASTER_CAMNOC_RT_CDM_SF			2
+#define MASTER_CAMNOC_SF			3
+#define MASTER_MDP				4
+#define MASTER_MDSS_DCP				5
+#define MASTER_CDSP_HCP				6
+#define MASTER_VIDEO_CV_PROC			7
+#define MASTER_VIDEO_EVA			8
+#define MASTER_VIDEO_MVP			9
+#define MASTER_VIDEO_V_PROC			10
+#define MASTER_CNOC_MNOC_CFG			11
+#define SLAVE_MNOC_HF_MEM_NOC			12
+#define SLAVE_MNOC_SF_MEM_NOC			13
+#define SLAVE_SERVICE_MNOC			14
+
+#define MASTER_CDSP_PROC			0
+#define SLAVE_CDSP_MEM_NOC			1
+
+#define MASTER_PCIE_ANOC_CFG			0
+#define MASTER_PCIE_0				1
+#define SLAVE_ANOC_PCIE_GEM_NOC			2
+#define SLAVE_SERVICE_PCIE_ANOC			3
+
+#define MASTER_A1NOC_SNOC			0
+#define MASTER_A2NOC_SNOC			1
+#define MASTER_APSS_NOC				2
+#define MASTER_CNOC_SNOC			3
+#define SLAVE_SNOC_GEM_NOC_SF			4
+
+#endif

-- 
2.43.0


