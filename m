Return-Path: <linux-kernel+bounces-873478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0C0C1406B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26C3A401BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57780305946;
	Tue, 28 Oct 2025 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vvc9m+mf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195FF304982
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646333; cv=none; b=JW6H7yEJ+LyH+tz5IU02I6lXTTfACcsNfakceZYbBZrpIq3EaqPJnl2zQKGul07a00zdxn+mm8+bdr9Z/IJM0QPY5yk1Xmw7lHI6z6D8N3v1dzAVxE2HV6xLZ9kOTl2TfJewRcz6qYFgRGdOPS2fZ8GaYuxdBXOhydWei49xyFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646333; c=relaxed/simple;
	bh=ril99Wt36AaQWNv+PDjT8BlLjpjvdFqefjO73sSkLmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C0eVzD8HCbqcldt8rj9MUCXSTJKSnT6BheA3G86hB85KCw9Tyw9L3TBoYbOOlDxXXh0rCwXMKPq/9ewOgdtUT+di42lcUjVEGEWrwuC6vRIKs5Sp48X6mk/lEpPd7QWY/+cDtTBrCoKyhaKfz7bnUdhpcan2tU5BtuVnS87Jqkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vvc9m+mf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S4AR0a553425
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iYDtPrC3G6SjHluGEZkqxO1EAHQjQdzxEg9eUYrW+6M=; b=Vvc9m+mfS8OT9S8t
	5RaG6Y4QXH0PSMcW6M8yaHZfd2mhdkovxcLjjOiL6ul42Re4WpoylwkUgCy2TKvj
	Gg5twFbuk2b1SdsD4umkFQoEb9EcjTIcbimYGW+gHkvUpzWsfh4cI2CckKOnFk++
	k4gq0awmMIa37G1WSiuIQuMPDPkjMvBQTljzxRJ40kjzQCFpCOBJXL9QoRE20OwG
	/7B5A9brzZ2CgcPFkQbZlAKXAxt1TSSZHKy9wWu1I99U4SyA/akBS6XCpBMqst2r
	IeRGRj5GlsfTTT0EUUhm0r0KFvsaECh+ZZfHgl5dHcgCPjZNpZgcQ8jLpI42/hCs
	P6CEFA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2pjf90q3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:12:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-27ee41e062cso65629675ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761646330; x=1762251130;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYDtPrC3G6SjHluGEZkqxO1EAHQjQdzxEg9eUYrW+6M=;
        b=KAKD3xeZlGeS0A6o9KclpAATu4QZw2dFI8pUog4m1X6ZAj8d+O6bfcQ4aEAJigfgXr
         h05SKVsCiZpof6EtlHARw+5iIpuWHWGQCge2/rRmcwOWSBQKYiCFUzAhv/nYLTqBbrjD
         Ce/17MNEEPXrNI2P9gx3budjk41x4Q5JT+b5eBVuSz8CWzXs5bxIm22+ERh6bVn4fxjJ
         hVPeEjmAga4ncs1hFnZsTnsciZqQI1kCBGU0ycph6GYReebcmasGBbWELjhO3U7T1pGx
         z32yFjVUskPGD0GjN1zLE2q7Dg7fu1n4LBKlw9U8hXE+jB/H/c4ngGpqTKE/ZCB3Gx7v
         wfyg==
X-Forwarded-Encrypted: i=1; AJvYcCXQufeX7Vbg4efdURlYYucGrv7SiYc5kTeElJG0M+RQeSvcP2jHW95wEJasq3ZHGarnaWDQcJLcG8FRt9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhmqxg4zxPe7bBleC803HpZgeFWCN8nJ6ULVsVDXXmPf5/CLUs
	yatE5l9iKXn61yvxn7gskXGnsmciDfNitaFvmGLhTHVWNmb3qe5g8KddhZjI9G8P+7iqy0lgQJ0
	OgnLp+0IXJ8hpRjisCZW/JSGsA+daSKNYCE7iUKUJoPy1yppI5IftMdg+KDZFFLb7gco=
X-Gm-Gg: ASbGnctk+tfXpD+d5NghC2PtOQIAuaY4sPz4YnSlGYoyhpg9xdgDzI6zGv57GOTakAN
	IT/j456S7UALib7RB9sJSJ7PyJ8GSQLv7GAxxclfLqF4GpfFs8iPRCxF1W+dovgLbvXs37UbwRa
	Esu0YguM4qnQ1KUJLEyLu9puH97Wy6o6BdXOMiBHV9KIKUFUDGge0p1RITh/5SjgaeNqWL0DLys
	6gUho7LANm3nUE1+hcfXcss6/Gm+N49K1/+w2o62Js6u2BSCEDlWWMDwG46pcMCpAS/ikR7kU0U
	0QMmJQtXcPNj1PCKpq2+xM6q61+OUyktMixueJcleBP9aRmoWybj2beOGBTaKqDcUIssSQdE932
	tGzWN5hPXOk9jwxEzvgjYuQtKiklV3xzeDUihOmI9tYwrQ+V/e6ScuwG35Lg+UQ==
X-Received: by 2002:a17:902:e5c6:b0:293:e5f:85d7 with SMTP id d9443c01a7336-294cb5186efmr37248055ad.55.1761646330535;
        Tue, 28 Oct 2025 03:12:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb29YgEWk2tLkfhGz57DmwvdMAhUJDCMmBCcvIBnASLKQ2A1aNC//pQlo+JzoyOuG/gwC8nA==
X-Received: by 2002:a17:902:e5c6:b0:293:e5f:85d7 with SMTP id d9443c01a7336-294cb5186efmr37247615ad.55.1761646329885;
        Tue, 28 Oct 2025 03:12:09 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf423esm110408755ad.19.2025.10.28.03.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 03:12:09 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 18:11:40 +0800
Subject: [PATCH v4 1/3] dt-bindings: arm: document the static TPDM
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-add_static_tpdm_support-v4-1-84e21b98e727@oss.qualcomm.com>
References: <20251028-add_static_tpdm_support-v4-0-84e21b98e727@oss.qualcomm.com>
In-Reply-To: <20251028-add_static_tpdm_support-v4-0-84e21b98e727@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Tao Zhang <tao.zhang@oss.qualcomm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761646319; l=1550;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=ril99Wt36AaQWNv+PDjT8BlLjpjvdFqefjO73sSkLmU=;
 b=mC9O91ScEQM7m0k2xJ3977SHUKVvtGlMU4RgMcCTUIhDtXcp4RUl8RyAH0i257VDDl+paWKOZ
 Ud/cYhe0oszCVKf4JALO09nYTVsuzQS/TGrgVZkmPzzzxnohyEVD1zM
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Authority-Analysis: v=2.4 cv=Ut9u9uwB c=1 sm=1 tr=0 ts=690096fb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5Z_N_GBq0btHVWfAyk4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA4NSBTYWx0ZWRfXzmA5HgoBQv3z
 qURvs3wLPXbJzvaUQ6akZaFumZ12CsJiunhHWgfqhRw5LPJMAHa+RD+MhUI/6Up44qrl5BYYiHZ
 FViJiK1vmYXVMoPSphqXi1l5yAJYN00QOfNlla+JNaGcq6VwEOktGqHx2i0wD4LoL+EBlAl+6el
 31i/T4MDAVJp05+AzDjRovk3gH6e1gkp6yH0al4BQkQlcM41BjTyAGS35UxXqDOUrq0guZR/x91
 mped/LJuTXoiNZrAjm2qtZUqvpJ14D6i+0NInG71YaKB5Geyft+nKiThKfyJqm+YQs9c7tA8egn
 pm3lfOctC65anqGBgiF+kYBqGHZxC+PhgXDWb8Musgd7PbRroFKvGrzR6zF7Ru/K0B22P0ksFez
 u8Odm1J9uRs9DeTIvf3hLRxiP1dgZA==
X-Proofpoint-GUID: 41CyZZamrTb21hv0PiNmyfzb9lbe66cw
X-Proofpoint-ORIG-GUID: 41CyZZamrTb21hv0PiNmyfzb9lbe66cw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280085

The static TPDM device is intended for sources that do not require MMIO
mapping. Its compatible string should be documented clearly, along with
an example illustrating how to define a static TPDM node in the DT.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../bindings/arm/qcom,coresight-tpdm.yaml          | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 4edc47483851..c349306f0d52 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -36,9 +36,12 @@ properties:
   $nodename:
     pattern: "^tpdm(@[0-9a-f]+)$"
   compatible:
-    items:
-      - const: qcom,coresight-tpdm
-      - const: arm,primecell
+    oneOf:
+      - items:
+          - const: qcom,coresight-static-tpdm
+      - items:
+          - const: qcom,coresight-tpdm
+          - const: arm,primecell
 
   reg:
     maxItems: 1
@@ -147,4 +150,18 @@ examples:
         };
       };
     };
+
+    turing-llm-tpdm {
+      compatible = "qcom,coresight-static-tpdm";
+
+      qcom,cmb-element-bits = <32>;
+
+      out-ports {
+        port {
+         turing_llm_tpdm_out: endpoint {
+           remote-endpoint = <&turing0_funnel_in1>;
+         };
+        };
+      };
+    };
 ...

-- 
2.34.1


