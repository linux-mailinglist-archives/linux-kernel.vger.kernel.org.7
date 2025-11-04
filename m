Return-Path: <linux-kernel+bounces-884150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8ACC2F76A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12BF14E8FE2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CC72D4811;
	Tue,  4 Nov 2025 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ggf3KeFv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ha2P1lau"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4ED2D2499
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238526; cv=none; b=iGMMOrOFNiZ1/yOQerOjsRFvkSF78O7GEFe/viOl3SYgC/fMNd8HQ+HO6D5Hoh77oz8LdQEv6jweW7HmwARdxFXoseBejVK1HPpq+WBN2lCjpv0PgZcwGhASBxZ2iOcR4Z90FkjzS5xYiXo1/MIL6DhSA9eoANjRnMciqjpGleQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238526; c=relaxed/simple;
	bh=6Pzw9XXpeVrVHdyn7PQA+dMkYy+qF7npAxHC8n5Z9ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZuHUNOn6VtnHIyuXrSyjOQCsLElngAqmObJAkEUrSmH2ugVrFgteJC4WmuadTitsb0vMa/w+RGPtmtjvkXkhgLCpVQrCHYnoCvQz6LAywPwj7gS5WK1LptcmcGtZo0Roe7HxxsLj8mU+mmfZ1cakyS1q7cW5p4sHwgSfmAjdSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ggf3KeFv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ha2P1lau; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A42o1oW3616996
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 06:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dtax6evXA18
	JgMiwfTdHJ38nVYuISnLOVRzsprq6aY8=; b=ggf3KeFvOnDRJ5toBl+4bbXCFCd
	3jdrEnzfgQuZB1a98J2wQEz4+TJv6Q4JDXIl8Xl/VjM/DR0AVhPDRT8vqN4N3G23
	/+bnzhvofbbmiWw5VxrocEGtjfsXCgUlFP8Wg4g5zxQqmoSsc1aTAn/HspSsC9Wh
	AwPouumNG7itEig0o3J9GRfR/mWi6vIgZgs7zz89nCf1eWmYyq1V8cqxqgcXlpD6
	X1fHFtXwDXd872o8aptMtRSB/VII7IGmMuY1R3uDp//N7w1q3hODztmfcL/fAjSX
	1GtKXTLcoNjqDUgARVwdTw6AzvyRSMzut5tLWLbfkBRnvq03R2otNjlDIIA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70fhsx1h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:42:03 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so4435977a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 22:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762238523; x=1762843323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtax6evXA18JgMiwfTdHJ38nVYuISnLOVRzsprq6aY8=;
        b=ha2P1lauN1OYYMb71BPhFU0QxGFekCcUSEqjtRTpGvFpAKNdlqs8p7p21DvmqwTaQa
         LCHM70FL2cHtXGPb5kC+jfx35Z7EONuiqKj/Ea3/84KE5Zjs4R/DwJDJKFJaFjKNMOkK
         wzITPBaHcX30+dUsb/BGH42HkULoYkoDTHaRUUfH9Lv62dNk9iwy4lnVMZCTXETgrIdI
         E1lypLret86Zpb0GC5Rp2yPSRSdBMJ4cyrqoaa7d0MvDbDVVWsRt/KDhB6tJRt7jqJXs
         Lk0yfrjt6CcTvDfVOhgsA4FZqfSdSOdWxVjsy8+0J+R9yNK5X4Z1uf5z6wHOPCbUPKeo
         uw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762238523; x=1762843323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtax6evXA18JgMiwfTdHJ38nVYuISnLOVRzsprq6aY8=;
        b=XBmWyGxLa26zcKfnYtTNlGcf6gnWhzsjleBiEZ29uFfdFIfKyfjLgmKUhBhHeHPWId
         C1iXmmTlvhnHHXHCuEYCiRjCVjGQ/CywVZYKaBhhDd8DQvYBQnHm8ugEMpFpBlIAX/Ol
         GhN46VbxD1gXIk35Oxb1hVlXzlAYxDAjkSGcySv2vWkGg9VeQRvA2++yoCQoPbI5Kmj4
         XXBW9VgTiIhiC/3CfBlp5ypJfGj115+XJzTLnQsgyxdMHzjkOrk9EUD/obyLkviLZHD1
         fgwVd23HSCpxCRKfK1/xJIis+AICgZmqpsV410l/niiKjxuR/jN/8CwrokQTDAmDGL4H
         dMgw==
X-Forwarded-Encrypted: i=1; AJvYcCUacoTkgS3Qc10th3A2qbL+LCix5A/5/7xU/NcELA//kd3NPZVW8zxEm/91XSselHhSoL4dxFuDwK9jy1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YypgNDBdUjsw/lGwco3cjymCaWVoFyLzqbVZ/GTCrVXuIIct5Ft
	n8Ya6WK3lcTp1ziM/61ORuWTgPrqGgTjxoFohAqXjYPVpCzP6NaXKyHye4o3sJX85TMjPWcGEyB
	+WLa14pRxsyqiohFe5I9YMF6lKoMFaAtQdLw5CCLsm/buLIaelN9SD7KAtkrGjHZ2K+M=
X-Gm-Gg: ASbGnctkUniDjKD2OZ17iiQoWkDKGjcNO+ulCC34v4C7bgUUlggSPrNwehAWBl9iAWA
	SIR5BC+x8njF7PEld2k8Qmoh2k1Vt6gt1hX1I64l+eN3s0YbGgIMQYfssgroTYWUhRqSng6DxPB
	gyzZHDtCoTxNy50s3/BhOu9BAPTbJlyeNV/CylnLCpJinAf9tBlt1hqaoK7j0zn0zx6R++uVLwr
	itxHfzOsZGIOtGVOdhD23fC1CKBUtwH7ElPipT5RLBUGNGbfAXO5TX+dNSJPd/W2poK4ANWxx19
	N9PUr79LRa9xhJdtUKKH7PwqiQoQZHGy89jLWXizsaWcUZ+soZDrcXI7xPw8MAnmo+oArTQ46Hc
	E00PWl9PbVH9SJ6ddOOyG2bvXObSZB4RKjVLnL5LwfPzkG7n3BUEJBw==
X-Received: by 2002:a17:90a:ec84:b0:335:2747:a9b3 with SMTP id 98e67ed59e1d1-34083071b13mr18546208a91.32.1762238522937;
        Mon, 03 Nov 2025 22:42:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwUI0wwzlgz0De3UdP/FfiAu48+hXZm3cz3iyrJp1zGf8iWSt+PEVNytu5+xTU0YODrYKhVQ==
X-Received: by 2002:a17:90a:ec84:b0:335:2747:a9b3 with SMTP id 98e67ed59e1d1-34083071b13mr18546175a91.32.1762238522456;
        Mon, 03 Nov 2025 22:42:02 -0800 (PST)
Received: from hu-songchai-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a0780dsm3294791a91.16.2025.11.03.22.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 22:42:01 -0800 (PST)
From: Songwei Chai <songwei.chai@oss.qualcomm.com>
To: andersson@kernel.org, alexander.shishkin@linux.intel.com,
        kernel@oss.qualcomm.com, mike.leach@linaro.org, suzuki.poulose@arm.com
Cc: Songwei Chai <songwei.chai@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        coresight@lists.linaro.org, devicetree@vger.kernel.org
Subject: [PATCH v7 1/7] dt-bindings: arm: Add support for Qualcomm TGU trace
Date: Mon,  3 Nov 2025 22:40:37 -0800
Message-Id: <20251104064043.88972-2-songwei.chai@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104064043.88972-1-songwei.chai@oss.qualcomm.com>
References: <20251104064043.88972-1-songwei.chai@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA1MyBTYWx0ZWRfX8iFtHmZnIJKC
 LkAEpCe8XGG41lnpNJfFSm8agwRuc0wSsvFOexF0SmuSit1Td/00bfLhwsEzi7OUe+2fjrU3IlY
 v+SXD4aPyHiLmQyfFTj+HvLT2JMkPltxJI1fSK+kxFPWYavOHCSiXzTnH+CNSvNz0Dp7tNVbyAO
 3ejZns62I4PzbTYoBnDHTBH4I9f6m1Ufn2BSZjIm5kj+rQDf3tUfev7FcQpdzi6QOQ6c22mEWQF
 PSeTeCpRwed9Ie8k+zQivpR8yIz5n/jfXj6XmxUltpL/gFZgC8D1R9waAhWCcpyXdUY2tiR/zYC
 Nb1ImKPm2zeoYNTY06BLN248nStbblsZh6HGgqPquPCQ+Ys9RxwqB3vL+H3qoYWIkIhEPQarIho
 byNQe0yjnZDFfCL55weBjULKNsFDwQ==
X-Proofpoint-ORIG-GUID: xCsRcH-z_jZuv8Ypnkq8zGCk9tolV_jD
X-Authority-Analysis: v=2.4 cv=CbsFJbrl c=1 sm=1 tr=0 ts=6909a03b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=N3VNWiZ0WD7Ir0aJMQYA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: xCsRcH-z_jZuv8Ypnkq8zGCk9tolV_jD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040053

The Trigger Generation Unit (TGU) is designed to detect patterns or
sequences within a specific region of the System on Chip (SoC). Once
configured and activated, it monitors sense inputs and can detect a
pre-programmed state or sequence across clock cycles, subsequently
producing a trigger.

   TGU configuration space
        offset table
 x-------------------------x
 |                         |
 |                         |
 |                         |                           Step configuration
 |                         |                             space layout
 |   coresight management  |                           x-------------x
 |        registers        |                     |---> |             |
 |                         |                     |     |  reserve    |
 |                         |                     |     |             |
 |-------------------------|                     |     |-------------|
 |                         |                     |     | priority[3] |
 |         step[7]         |<--                  |     |-------------|
 |-------------------------|   |                 |     | priority[2] |
 |                         |   |                 |     |-------------|
 |           ...           |   |Steps region     |     | priority[1] |
 |                         |   |                 |     |-------------|
 |-------------------------|   |                 |     | priority[0] |
 |                         |<--                  |     |-------------|
 |         step[0]         |-------------------->      |             |
 |-------------------------|                           |  condition  |
 |                         |                           |             |
 |     control and status  |                           x-------------x
 |           space         |                           |             |
 x-------------------------x                           |Timer/Counter|
                                                       |             |
						       x-------------x
TGU Configuration in Hardware

The TGU provides a step region for user configuration, similar
to a flow chart. Each step region consists of three register clusters:

1.Priority Region: Sets the required signals with priority.
2.Condition Region: Defines specific requirements (e.g., signal A
reaches three times) and the subsequent action once the requirement is
met.
3.Timer/Counter (Optional): Provides timing or counting functionality.

Add a new tgu.yaml file to describe the bindings required to
define the TGU in the device trees.

Signed-off-by: Songwei Chai <songwei.chai@oss.qualcomm.com>
---
 .../devicetree/bindings/arm/qcom,tgu.yaml     | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,tgu.yaml

diff --git a/Documentation/devicetree/bindings/arm/qcom,tgu.yaml b/Documentation/devicetree/bindings/arm/qcom,tgu.yaml
new file mode 100644
index 000000000000..557bc16b422b
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,tgu.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/qcom,tgu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Trigger Generation Unit - TGU
+
+description: |
+  The Trigger Generation Unit (TGU) is a Data Engine which can be utilized
+  to sense a plurality of signals and create a trigger into the CTI or
+  generate interrupts to processors. The TGU is like the trigger circuit
+  of a Logic Analyzer. The corresponding trigger logic can be realized by
+  configuring the conditions for each step after sensing the signal.
+  Once setup and enabled, it will observe sense inputs and based upon
+  the activity of those inputs, even over clock cycles, may detect a
+  preprogrammed state/sequence and then produce a trigger or interrupt.
+
+  The primary use case of the TGU is to detect patterns or sequences on a
+  given set of signals within some region to identify the issue in time
+  once there is abnormal behavior in the subsystem.
+
+maintainers:
+  - Mao Jinlong <jinlong.mao@oss.qualcomm.com>
+  - Songwei Chai <songwei.chai@oss.qualcomm.com>
+
+properties:
+  compatible:
+    items:
+      - const: qcom,tgu
+      - const: arm,primecell
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb_pclk
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description:
+          The port mechanism here ensures the relationship between TGU and
+          TPDM, as TPDM is one of the inputs for TGU. It will allow TGU to
+          function as TPDM's helper and enable TGU when the connected
+          TPDM is enabled.
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    tgu@10b0e000 {
+        compatible = "qcom,tgu", "arm,primecell";
+        reg = <0x10b0e000 0x1000>;
+
+        clocks = <&aoss_qmp>;
+        clock-names = "apb_pclk";
+
+        in-ports {
+            port {
+                tgu_in_tpdm_swao: endpoint{
+                    remote-endpoint = <&tpdm_swao_out_tgu>;
+                };
+            };
+        };
+    };
+...
-- 
2.34.1


