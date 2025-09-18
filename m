Return-Path: <linux-kernel+bounces-797864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6D2B41669
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8F81B26882
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 07:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B1E2D9EE1;
	Wed,  3 Sep 2025 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nxtaAlCZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9635B2DAFC7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884492; cv=none; b=SwcwYu0jw3wAHtoum4dcFpyua6CBamrIqKYM6t6sXoPfxRiNJG3znJL7dscQZPUP1llSxOXD5Q+fmzkBW/cUscVB3Z0qMh0kWVUekgbBz25OnGLuPRiGtYYnRgknK9kewxuhe4+9QSznuqVD5KPfqEFhV8ubdB/M2VAGvkF7BmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884492; c=relaxed/simple;
	bh=cwE7/hmyX8UH5OzRGuGAS5C7QSgaWfMDwt7W1tOQ3CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X6T3HkHhpS2bI9f2yIYMem961YNA3COGUIj899SuuASujVUWvr/VjrIpLgBDrBI0mVf9tKRBXpasOWYCVW1y3M/ib6zGgq80QspOc4jaloPUYCxs9JoOi3D5b8VqtwA8F44fhmFCLcW7YG/SDGjNiK+e5DjinUzYi6UWrYwECxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nxtaAlCZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832ULUP012671
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 07:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s6RCE0oFSw/M/VrGZ8bCR9/69BdlFN0iWVK2GbkrQO4=; b=nxtaAlCZHjjRVyXz
	B0+UIxeqesRnHUZ5eId1sbImJpfiKSLk82e8GmdgAaG+n5+f/AcIiDVL5K778J8e
	2tji+nagnjx2kAY6nwh4a25YuCpHNv2OrQmnlEyqa342TwrtWbwM2/zfoiCYxFCM
	oAzTi/eXG2xt6OBvrUd+WOyJpqNVhqtPC+ForhVrnKc4DfdT6r8s2xJsNudpX83t
	Jw0UE6Lgry8VwCj/d0qx9tidzUNjjT7XSvnMBGASgXK96xxD/qsfY0C+062yQk6B
	srL9L4BmTewFUIlYlyVJ2lUHpI7g8NjPI6Gm8+azBkpeKvWgZ3HHqaTgi6x7EvC6
	GHWq2Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk92djb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:28:09 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7724877cd7cso3661279b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 00:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756884489; x=1757489289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6RCE0oFSw/M/VrGZ8bCR9/69BdlFN0iWVK2GbkrQO4=;
        b=afc3bKfr3bbG9UvigXT2H6FUoWOlAPLqG2XGbWlX9WISSpCgBamKBjq/daJ68ScMg7
         yayei0Xvdq1t5PYMdsvXjOTPRTT5ypSv9Jf6y3qt688HS0BIQ11jYx+xH8R3H3FTJmaJ
         1u9G2yNxMVv/BvIzRzwPIaw4QZPS+djm3zgObtikaa9fVasZnEAZizZga6tlDRbW6De2
         c1Hf3CI+9ZQVH853ObyQp20ITi2Wjr3fWoyxBXg0pwoQmYNBvMKJwmsdBLMMWVrKSOr7
         KhH8IAccgszzaec3ymWujla0SCh2pQvsiw1E3uRWbjpjQpAunc9doUHCxDBO3uEdHedu
         RPEg==
X-Forwarded-Encrypted: i=1; AJvYcCX1/VjXsDs8l+CB1TbTPIh0eimnEknwztTVUFpE1dvOiPrpc+OSCPIDXUk+bdy9WuMuW11YW/phmEHdpPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw97I64zBw+iOo7A8BsE3V/VS9FHr1RvtiXq3XhAlJ8n06pXJjO
	tot5FRsafwyRfZNx5wcThT9TpmRiN2arEIeq96XNKXSPlgfq4UrqiQpKHzrawdI6n/KSRviZ4Gz
	Pu3z/1eZ1HJuB212Uxxe2PLcPi+il9thlQiHzzC6+wxYvEZJ824888VYB3avOoqhLwMg=
X-Gm-Gg: ASbGncuO9IXUAgzNWH0Vn+s3yYTCVy0rfDuQgJFz0XpRzJxiVd+7YnF/A8qz3GmZb+D
	IHCMZrfh7WQ0EPWxQm9dCxIJkF3inpfFFtYsEbGY2nEylqReG53Ih8/kBF+tcuWW7xU8YRE3AzW
	GNpXMzE9GjV9JMYsjxruRVnYpahI/orIzIqzKFKUXCOfTpyA7mtbV++wwBHUr8yFgnC6YKxKCgS
	hYLrglii9XuJdxexUcT07DdfN3y/J+yOdNUFffOE3vqAlUhG1F5xZM9G29dgCEMymFl2ol2Rmjx
	EGmDaX6bCGn1aQvJoG0b4yUhQ+7ikHfQciXjIC3iT96BS7LfZnxKkWmjBQAGECkn
X-Received: by 2002:a05:6a00:1acf:b0:772:6235:7038 with SMTP id d2e1a72fcca58-7726235744amr9450665b3a.10.1756884488893;
        Wed, 03 Sep 2025 00:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcdfxNVz1GvMDQcgdqVPYJv6jhFmgyrPp6EB/PmgvtznZE+NpuHBXykbZcEj+2cOoATCFOqA==
X-Received: by 2002:a05:6a00:1acf:b0:772:6235:7038 with SMTP id d2e1a72fcca58-7726235744amr9450640b3a.10.1756884488372;
        Wed, 03 Sep 2025 00:28:08 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b65a2sm15833787b3a.34.2025.09.03.00.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 00:28:08 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 12:57:54 +0530
Subject: [PATCH v2 1/2] dt-bindings: clock: Add DISPCC and reset controller
 for GLYMUR SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-glymur-disp-clock-controllers-v2-1-af174559aff5@oss.qualcomm.com>
References: <20250903-glymur-disp-clock-controllers-v2-0-af174559aff5@oss.qualcomm.com>
In-Reply-To: <20250903-glymur-disp-clock-controllers-v2-0-af174559aff5@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-GUID: rqcl1OUJqZXTNG8haq6Vr0HV0TfpsM1L
X-Proofpoint-ORIG-GUID: rqcl1OUJqZXTNG8haq6Vr0HV0TfpsM1L
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b7ee09 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=vLIBROXKFhWHEpkJx9gA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=sptkURWiP4Gy88Gu7hUp:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfX6Nui8gRvnTDf
 3LaQZila1xNzFpOkiddoTM0gsNXEaHzW2B+4wr7PnOTN0VLHwBlCZyVAKzI3kChVHFmUmWgnrZW
 UO45MtwdewJf2MkL3dGEIq7W89kTdv5gJJd8PiL97jMC4XdAyKu05dKcVCCf0QfiwlZ/qcgYG5h
 ouTQ8CrvoF155T/1a2d3vkrwcJnO1UCVuGeo1178E5NxIJTfT+GfqFmcBwJySvz4b6vXmMxXgfR
 GK1aaKn12dKHAOoKWFqyRFtQ6Ct1by25z5jPvc7HHwgl5lRXWY8tsdAOA7Qpw4heK0PkXaZFSkw
 dffwqw3VW5WCJkukORgmglAhi3UptvjwlZF3oY2r+toGCoYjH0YxyHFZwI8KABkmjV9aeDWo3vs
 5N5Ks4ao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

Add the device tree bindings for the display clock controller which are
required on Qualcomm Glymur SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 .../bindings/clock/qcom,glymur-dispcc.yaml         |  98 ++++++++++++++++++
 include/dt-bindings/clock/qcom,glymur-dispcc.h     | 114 +++++++++++++++++++++
 2 files changed, 212 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,glymur-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,glymur-dispcc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..45f027c70e03f99487a1bedad6075217ee81ca4c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,glymur-dispcc.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,glymur-dispcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock & Reset Controller on GLYMUR
+
+maintainers:
+  - Taniya Das <taniya.das@oss.qualcomm.com>
+
+description: |
+  Qualcomm display clock control module which supports the clocks, resets and
+  power domains for the MDSS instances on GLYMUR SoC.
+
+  See also:
+    include/dt-bindings/clock/qcom,dispcc-glymur.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,glymur-dispcc
+
+  clocks:
+    items:
+      - description: Board CXO clock
+      - description: Board sleep clock
+      - description: DisplayPort 0 link clock
+      - description: DisplayPort 0 VCO div clock
+      - description: DisplayPort 1 link clock
+      - description: DisplayPort 1 VCO div clock
+      - description: DisplayPort 2 link clock
+      - description: DisplayPort 2 VCO div clock
+      - description: DisplayPort 3 link clock
+      - description: DisplayPort 3 VCO div clock
+      - description: DSI 0 PLL byte clock
+      - description: DSI 0 PLL DSI clock
+      - description: DSI 1 PLL byte clock
+      - description: DSI 1 PLL DSI clock
+      - description: Standalone PHY 0 PLL link clock
+      - description: Standalone PHY 0 VCO div clock
+      - description: Standalone PHY 1 PLL link clock
+      - description: Standalone PHY 1 VCO div clock
+
+  power-domains:
+    description:
+      A phandle and PM domain specifier for the MMCX power domain.
+    maxItems: 1
+
+  required-opps:
+    description:
+      A phandle to an OPP node describing required MMCX performance point.
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - power-domains
+  - '#power-domain-cells'
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    clock-controller@af00000 {
+      compatible = "qcom,glymur-dispcc";
+      reg = <0x0af00000 0x20000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&sleep_clk>,
+               <&mdss_dp_phy0 0>,
+               <&mdss_dp_phy0 1>,
+               <&mdss_dp_phy1 0>,
+               <&mdss_dp_phy1 1>,
+               <&mdss_dp_phy2 0>,
+               <&mdss_dp_phy2 1>,
+               <&mdss_dp_phy3 0>,
+               <&mdss_dp_phy3 1>,
+               <&mdss_dsi0_phy 0>,
+               <&mdss_dsi0_phy 1>,
+               <&mdss_dsi1_phy 0>,
+               <&mdss_dsi1_phy 1>,
+               <&mdss_phy0_link 0>,
+               <&mdss_phy0_vco_div 0>,
+               <&mdss_phy1_link 1>,
+               <&mdss_phy1_vco_div 1>;
+      power-domains = <&rpmhpd RPMHPD_MMCX>;
+      required-opps = <&rpmhpd_opp_low_svs>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,glymur-dispcc.h b/include/dt-bindings/clock/qcom,glymur-dispcc.h
new file mode 100644
index 0000000000000000000000000000000000000000..a845d76defe282d953e82e8b595433c5f9cd364a
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,glymur-dispcc.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025, Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_DISP_CC_GLYMUR_H
+#define _DT_BINDINGS_CLK_QCOM_DISP_CC_GLYMUR_H
+
+/* DISP_CC clocks */
+#define DISP_CC_ESYNC0_CLK					0
+#define DISP_CC_ESYNC0_CLK_SRC					1
+#define DISP_CC_ESYNC1_CLK					2
+#define DISP_CC_ESYNC1_CLK_SRC					3
+#define DISP_CC_MDSS_ACCU_SHIFT_CLK				4
+#define DISP_CC_MDSS_AHB1_CLK					5
+#define DISP_CC_MDSS_AHB_CLK					6
+#define DISP_CC_MDSS_AHB_CLK_SRC				7
+#define DISP_CC_MDSS_BYTE0_CLK					8
+#define DISP_CC_MDSS_BYTE0_CLK_SRC				9
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC				10
+#define DISP_CC_MDSS_BYTE0_INTF_CLK				11
+#define DISP_CC_MDSS_BYTE1_CLK					12
+#define DISP_CC_MDSS_BYTE1_CLK_SRC				13
+#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC				14
+#define DISP_CC_MDSS_BYTE1_INTF_CLK				15
+#define DISP_CC_MDSS_DPTX0_AUX_CLK				16
+#define DISP_CC_MDSS_DPTX0_AUX_CLK_SRC				17
+#define DISP_CC_MDSS_DPTX0_LINK_CLK				18
+#define DISP_CC_MDSS_DPTX0_LINK_CLK_SRC				19
+#define DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC			20
+#define DISP_CC_MDSS_DPTX0_LINK_DPIN_CLK			21
+#define DISP_CC_MDSS_DPTX0_LINK_DPIN_DIV_CLK_SRC		22
+#define DISP_CC_MDSS_DPTX0_LINK_INTF_CLK			23
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK				24
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC			25
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK				26
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC			27
+#define DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK		28
+#define DISP_CC_MDSS_DPTX1_AUX_CLK				29
+#define DISP_CC_MDSS_DPTX1_AUX_CLK_SRC				30
+#define DISP_CC_MDSS_DPTX1_LINK_CLK				31
+#define DISP_CC_MDSS_DPTX1_LINK_CLK_SRC				32
+#define DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC			33
+#define DISP_CC_MDSS_DPTX1_LINK_DPIN_CLK			34
+#define DISP_CC_MDSS_DPTX1_LINK_DPIN_DIV_CLK_SRC		35
+#define DISP_CC_MDSS_DPTX1_LINK_INTF_CLK			36
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK				37
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC			38
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK				39
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC			40
+#define DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK		41
+#define DISP_CC_MDSS_DPTX2_AUX_CLK				42
+#define DISP_CC_MDSS_DPTX2_AUX_CLK_SRC				43
+#define DISP_CC_MDSS_DPTX2_LINK_CLK				44
+#define DISP_CC_MDSS_DPTX2_LINK_CLK_SRC				45
+#define DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC			46
+#define DISP_CC_MDSS_DPTX2_LINK_DPIN_CLK			47
+#define DISP_CC_MDSS_DPTX2_LINK_DPIN_DIV_CLK_SRC		48
+#define DISP_CC_MDSS_DPTX2_LINK_INTF_CLK			49
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK				50
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC			51
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK				52
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC			53
+#define DISP_CC_MDSS_DPTX2_USB_ROUTER_LINK_INTF_CLK		54
+#define DISP_CC_MDSS_DPTX3_AUX_CLK				55
+#define DISP_CC_MDSS_DPTX3_AUX_CLK_SRC				56
+#define DISP_CC_MDSS_DPTX3_LINK_CLK				57
+#define DISP_CC_MDSS_DPTX3_LINK_CLK_SRC				58
+#define DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC			59
+#define DISP_CC_MDSS_DPTX3_LINK_DPIN_CLK			60
+#define DISP_CC_MDSS_DPTX3_LINK_DPIN_DIV_CLK_SRC		61
+#define DISP_CC_MDSS_DPTX3_LINK_INTF_CLK			62
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK				63
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC			64
+#define DISP_CC_MDSS_ESC0_CLK					65
+#define DISP_CC_MDSS_ESC0_CLK_SRC				66
+#define DISP_CC_MDSS_ESC1_CLK					67
+#define DISP_CC_MDSS_ESC1_CLK_SRC				68
+#define DISP_CC_MDSS_MDP1_CLK					69
+#define DISP_CC_MDSS_MDP_CLK					70
+#define DISP_CC_MDSS_MDP_CLK_SRC				71
+#define DISP_CC_MDSS_MDP_LUT1_CLK				72
+#define DISP_CC_MDSS_MDP_LUT_CLK				73
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK				74
+#define DISP_CC_MDSS_PCLK0_CLK					75
+#define DISP_CC_MDSS_PCLK0_CLK_SRC				76
+#define DISP_CC_MDSS_PCLK1_CLK					77
+#define DISP_CC_MDSS_PCLK1_CLK_SRC				78
+#define DISP_CC_MDSS_PCLK2_CLK					79
+#define DISP_CC_MDSS_PCLK2_CLK_SRC				80
+#define DISP_CC_MDSS_RSCC_AHB_CLK				81
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK				82
+#define DISP_CC_MDSS_VSYNC1_CLK					83
+#define DISP_CC_MDSS_VSYNC_CLK					84
+#define DISP_CC_MDSS_VSYNC_CLK_SRC				85
+#define DISP_CC_OSC_CLK						86
+#define DISP_CC_OSC_CLK_SRC					87
+#define DISP_CC_PLL0						88
+#define DISP_CC_PLL1						89
+#define DISP_CC_SLEEP_CLK					90
+#define DISP_CC_SLEEP_CLK_SRC					91
+#define DISP_CC_XO_CLK						92
+#define DISP_CC_XO_CLK_SRC					93
+
+/* DISP_CC power domains */
+#define DISP_CC_MDSS_CORE_GDSC					0
+#define DISP_CC_MDSS_CORE_INT2_GDSC				1
+
+/* DISP_CC resets */
+#define DISP_CC_MDSS_CORE_BCR					0
+#define DISP_CC_MDSS_CORE_INT2_BCR				1
+#define DISP_CC_MDSS_RSCC_BCR					2
+
+#endif

-- 
2.34.1


