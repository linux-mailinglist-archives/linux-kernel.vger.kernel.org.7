Return-Path: <linux-kernel+bounces-793934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD65B3DA6C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C870F189B6DF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF6525F96D;
	Mon,  1 Sep 2025 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WDUyUbYg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7F11E9B3F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756709904; cv=none; b=iHHdrXkeDqkewDIa0UNWqPjdWTVfHK31vq7QHtOQ1tlKZcKKFOTleTeBuRimB1Y1CsXutSr2mYKRIBnZ/0hseXNnMIDUHgYfRW//KbVwERxfP+JYv4PGmxdHWBQDcZH4gkeDQRYhTQHagITPqPiqY9EwOKa6lzHqfuc4aLpWx2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756709904; c=relaxed/simple;
	bh=Y867aF4IBjLOR2gpmZC8PqfLpe9/4Juk6DhmSLbLZ8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W73iOe0rKiUzysTE+pkv7UeL9h9MTDgsHYDj3TjRWQoFaOmC61AajtbGV3lSe/cUiuoRoi+IPVvI680rZzSEHqyUo/+0FfdokgsxwEM5fNPzaUdKisEnCVDA0IR9qKXOxp6CVWmIyU/UM+R7gnO+esGMNg5UjFxIprq+14DIBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WDUyUbYg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VNoGbN021277
	for <linux-kernel@vger.kernel.org>; Mon, 1 Sep 2025 06:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R2ZenOczyNRPh+gBJvOKUiI+2zJ13iDNHmu85jEHTew=; b=WDUyUbYgRLl7jdI7
	Kof+UedANVrgMe07x+uNpGBTUGIZeOIClybm8bgH+915O0qHldXZwwmRI4PA2diy
	7halh5sos5IXlC1CQdE6LFySw+LPnZgcXv76WAS6XIFXIdfIVULP42iSCFZWCIMp
	XTZ/MN/+u6TLFOVD3Ug7eMnqYmSno9Iq2GvGRTEM8x0/3MvIwH6Z5YnSAhCnb/U6
	iA89cqIJBkbJkpihO5Z/V+oGtKuxC50DNs/h/XoZkvI+oqMMgCW6K5wvUXd6+z2i
	ZQ+w/3Bv9kCzeKx0oIVilh0BF4pmFJqD6jic8ubRKqAyiiIrXv+n+7Q32sNU1E5A
	uCoDdw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp3sh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:58:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4c724d27f8so2235223a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756709900; x=1757314700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2ZenOczyNRPh+gBJvOKUiI+2zJ13iDNHmu85jEHTew=;
        b=MoMFRpmDruzsLI7ScAbkF/U7kQ6Pi/mTzNHCGcOIX2VqQXFnEfmEEs5dasCbYz5CmC
         lRo8nSKPETN0oWHhf1oIt9sxaPFzSEv3yfS8a+1esaKnO9UkwOi3HFQXgChodua/lP7E
         +AMrCy1Bl5wc84FgKvUASh92RiVXZL8SOHGj6lRNxmTdyTSLwpzGeWngHUXF9mLJr+LQ
         Kx+yIij15egV0SB1yNaKUlgASVwfvP9gHZVL/xw3RxI03d/h4IJTfbpzNtCJ7zgLkJra
         Vu/06FjjRz+vxuoYRRmed1D7C9j38NIhz5fpqfSK5AbaUT1P7+zxk+8ml3RdFpTi5/nz
         I9uw==
X-Forwarded-Encrypted: i=1; AJvYcCU6eEOK37wnaP14B/tuuGuvHKC0igmt0QFDsw4HSW1Kr3Ks5JR4wAlNoHl8R4jgUOm8gLQeLAaP8850OSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+qnvL2C0n3fNdBCDs2k6UHMog4WR8agJ1w4g0QFuCshQeQPl
	Sl/eFAkcy2d89M3uQFS2AB3cIj1hS+11AWDVYtLQOZXnhEIPy/n/8CfUy/s0Kg2a1eUPAg03O5J
	Q8fVUfLJidREKLqoeWQG3t7aVaFCYDJRzum9gjhX/D92hYIx3bXkg/F76jE7oiS0tr80=
X-Gm-Gg: ASbGncuWURUSd6+/UwnvkB9jhsqpjQjlWRkWiVVCBM1nmeXS833zVKBkoUSiH4Qwvrl
	h/V+/OzojgbSlBmvRs7eUaY8uNB0jl/Ik3VhdjLjfyOYAIo+GwMKVP6rLXvpEId8gu6AcrIgxAW
	aZD85TBd5AlZccR2e2GbcMeYsrJ7wRxRoV7RnZ8fkfy+YRhtBfbH7bAGJmo0W/fCJNR2AlcVdoc
	OplaO30JJzdUZWUvqDxKenOTySLJI6IbcVXFgRxE/LWapWJm754fPhgZcCdSQQ4oSnfNVpoWW3c
	pLILVBo/xXhSggmVnFn4OQzHSlb/MU8Cgi9moJMWdc4D72jlJkhstgqlU6NCx5mjCpZ/e4jhsYW
	FRTmg44RFunHPSGwAr/QSCA==
X-Received: by 2002:a05:6a20:3949:b0:243:25b0:2321 with SMTP id adf61e73a8af0-243d6f7e6d2mr10335746637.52.1756709900287;
        Sun, 31 Aug 2025 23:58:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBrdSMOV835ZSodM/ToG95GYGlvM5rcn6Xyqn5yubD8Vrxqydn7Qb9jXXaPnNnhXEEII5VfQ==
X-Received: by 2002:a05:6a20:3949:b0:243:25b0:2321 with SMTP id adf61e73a8af0-243d6f7e6d2mr10335712637.52.1756709899850;
        Sun, 31 Aug 2025 23:58:19 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd366f95asm8559358a12.51.2025.08.31.23.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:58:19 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Sun, 31 Aug 2025 23:58:13 -0700
Subject: [PATCH v4 1/3] dt-bindings: arm: qcom: Add Coresight Interconnect
 TNOC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-itnoc-v4-1-f0fb0ef822a5@oss.qualcomm.com>
References: <20250831-itnoc-v4-0-f0fb0ef822a5@oss.qualcomm.com>
In-Reply-To: <20250831-itnoc-v4-0-f0fb0ef822a5@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756709897; l=3075;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=Y867aF4IBjLOR2gpmZC8PqfLpe9/4Juk6DhmSLbLZ8U=;
 b=2EFvjtdW0aDYQylD4PeK2l7hUEXE+8EE2A/CHNTTApxMR4JJgxpAITja7UdmxovLQuemCM2f7
 vkq81UZFpmkBtY40PzRN6vSsQT2Uuha1jQw9G1gNBiAYZXLQiXJ90kB
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Proofpoint-GUID: B1tDPPVMLefUDafj_7t09GiMkWYs2nRh
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b5440d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=-QmmxQN2S_yWG1-YAlkA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: B1tDPPVMLefUDafj_7t09GiMkWYs2nRh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfXyxQ/cvpWIbYK
 qIxKE5k5mU5ecg15rpOYOl1KKYI83sxmkUszs8WSyLutQPPmrU3JduL6xTALnxfGjFGHulE3gKP
 099aU63jVu90HEblBc9oSmlc3kTrKtwOmk9cTjVpY1LaZK+vwxl5NFt7w1zeiIy4miVJc1R8Q34
 vfQugzV7j2cH9Ycmo0JGcHBQSW6tegS6XOd4S3zAQhByeK9FudjalWD50uunjrIAgBBlv7Ek9aM
 duvWiKr+6C+AdoiCy/eyCtyU1yoiY9IJxvr1azqLnVG8/53znsB8p8RBDdrEe72cOrUDnCYE5+e
 WsZUfw5dLgCLQ9JP4u4GBY9/28zGOYoEWx3kcIL9QGV9dIyFMc0Ucg7c8PpfksKLPAfU3KUfRNu
 KBmUUj6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

Add device tree binding for Qualcomm Coresight Interconnect Trace
Network On Chip (ITNOC). This TNOC acts as a CoreSight
graph link that forwards trace data from a subsystem to the
Aggregator TNOC, without aggregation or ATID functionality.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/arm/qcom,coresight-itnoc.yaml         | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-itnoc.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-itnoc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..8936bb7c3e8ea267ca66e0cc3fc4dac33ba6de30
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-itnoc.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/qcom,coresight-itnoc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Interconnect Trace Network On Chip - ITNOC
+
+maintainers:
+  - Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
+
+description:
+  The Interconnect TNOC is a CoreSight graph link that forwards trace data
+  from a subsystem to the Aggregator TNOC. Compared to Aggregator TNOC, it
+  does not have aggregation and ATID functionality.
+
+properties:
+  $nodename:
+    pattern: "^itnoc(@[0-9a-f]+)?$"
+
+  compatible:
+    const: qcom,coresight-itnoc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: apb
+
+  in-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    patternProperties:
+      '^port(@[0-9a-f]{1,2})?$':
+        description: Input connections from CoreSight Trace Bus
+        $ref: /schemas/graph.yaml#/properties/port
+
+  out-ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    additionalProperties: false
+
+    properties:
+      port:
+        description: out connections to aggregator TNOC
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - in-ports
+  - out-ports
+
+additionalProperties: false
+
+examples:
+  - |
+    itnoc@109ac000 {
+        compatible = "qcom,coresight-itnoc";
+        reg = <0x109ac000 0x1000>;
+
+        clocks = <&aoss_qmp>;
+        clock-names = "apb";
+
+        in-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port@0 {
+                reg = <0>;
+                tn_ic_in_tpdm_dcc: endpoint {
+                    remote-endpoint = <&tpdm_dcc_out_tn_ic>;
+                };
+            };
+        };
+
+        out-ports {
+            port {
+                tn_ic_out_tnoc_aggr: endpoint {
+                    /* to Aggregator TNOC input */
+                    remote-endpoint = <&tn_ag_in_tn_ic>;
+                };
+            };
+        };
+    };
+...

-- 
2.34.1


