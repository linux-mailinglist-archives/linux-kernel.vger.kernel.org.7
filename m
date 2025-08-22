Return-Path: <linux-kernel+bounces-781683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE0BB31571
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947B81CC7F17
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E172C2F5491;
	Fri, 22 Aug 2025 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="boOos+9C"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94202F49F8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858624; cv=none; b=bfmRZL2MjbxkmQQDuTEe6Bog6AE2freoGYpCgBLv5NKx66GmVgqONwQsYmDF1pJi7l2YLrrFw3maEvcKKP52qsMZKOpZTTjIRVMQxVSiAL7gX1bMoHnJglu5iFHFDhK8xDCInwKoTomO6LsKw/zjyE499HIn0Yk5VBCpf3lWFEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858624; c=relaxed/simple;
	bh=lupYMam9LLXLp3lz2yHeBjn375m15PN8RsLr1il2qz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VsO8l8DLbmEfLAcaW0HJ779QE6qCGbuLRYb2eB27E3QFs8Oriy3DSGDPpog3VrS1kh+BI5H6jLCJr7rqu0ZiF9vzPHWSX9dUR7eS62Ivs59kVlc5RS1FBScLht26OTE00NiQVd44W8Ce/FyJeuzHV/iEbDn4Sg8S7CkOjMLGBt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=boOos+9C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UPuZ006206
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gCwy3dvuIrM
	dK1MGJRfo/KSQbLvNU+8cRJsdk8nhlss=; b=boOos+9CSb0d7q0j2KpZIC3i8sx
	Om9eaEQEiOdoPPDmEtMO3Ym65g96W4d/O3nxB4YM/6EYKea06xwiEUEPt1kS/Vch
	0O2G0NOXDP4CvevG3gWcMQU2Mo/7BThNNVIUKCo5ozl49Vrt4sh/qm58Jgpslfya
	iZZFQlecBZxjDvagnLXjsmRPhRHLVdI7mWjCsnUg/1ZKVmBMo9wtVfR9lbVlIMDv
	ukBQqy2VnGxC62Q1gF2bLMo0k57yWfc9VbxwfT25RhC/34GlTeia1g2zrcK40HqV
	EWanCILbUrPVpjajBnk6p4jz2tpId6YXhFetdsC3UJC+xQvPwzxvjGiMjow==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290v5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:30:21 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e55665b05so1899855b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755858620; x=1756463420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCwy3dvuIrMdK1MGJRfo/KSQbLvNU+8cRJsdk8nhlss=;
        b=Ojlp1NelVtshuPwCt7gpg0g2bX29P22tVFU132DA2L1UvN9LZ7pFg9TZSZ9sGrHdzz
         g1MF/7sfBPikwVbut4JhsF52MhwzBnOLmDqm3DG08S7F0Lhqhog181OKESLwi2VKKU6x
         QLgYlJN9VdHTQuvZJRZks+FjF/PC/5tL5/m90e4TYqB1n4vI8a21bvx1nIiK9ThHjC+O
         QcdjUKI7fTLML9O1jAlgVnrySme1qRnWadBxnGdeZRX3NabIyRJVaLzzkM1GV5YtG1CK
         yPKiVN60ainQZ5XM1lGiLSV9AH81/63Xe+vM3r+qNEgHwJ3lAkmBk9NkA1nCGZMXm0UI
         HkiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjsEihOTagrcmV0sQuQBRbHE6luV5ORLfCokgFzvuE6VEuimW/kkl8IvvAIoChSfQp1GsF5gy9g4yHZ2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSUFm8BK8AIynRj8fDx5czAvqx6M1P8LrLrLiIVJeIbiQIi1N
	J7lR2iNGa+EQX0ayGelYbIPzvRzAiSBvPlzJxtdJe7lbO05RCxaSKjv0oJbaI8ctUcPcA879eJz
	3cOwJZhye9xZOyuy8QlpT9SsFhiSwRzcWZVhVEyqbKPI4rKN/ivsCaOHojXwnU8knzh0=
X-Gm-Gg: ASbGncv9xlJtMVe4KhdI+izjL4tuGj4yB9PEe3zKNjb3HuccqjSc1v14M/EKVDSpUCs
	wXC9PkycmxvO4jnp2wSVoOU0D2jDXaApBlac4nmI9Te7BfB/u+Y1FbpyiRAWuogy4SJr6rrizV1
	bMwVmxo+/6TMaxjHqbnMEzc2ArAH0beKIfbETKoIAPO9zeeLt2j2IYKi/eaR+jnic7kxZnf0na5
	rhxKn2TsK8oWcH2Fh/3DJce+FEpl+/ZBxw+C/sJamooYx9GC9VyJRWQ7fGMWfgCbenuzreIwJch
	9HVYOUnpezUV8sAhATni8n3i7WakjcRjzEWr2FGLwDgr2P4DP3Aw5YiFwu2DqymmqGfDBMT67S7
	zTrgGDjz6lA1fodUsimDw
X-Received: by 2002:a05:6a20:7d9e:b0:243:78a:82c2 with SMTP id adf61e73a8af0-24340dafb84mr3496891637.60.1755858620422;
        Fri, 22 Aug 2025 03:30:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9UES8ED+cVPXc5NWnC+wayYDGQg0OQaM2qTYYN4XoyrxVTdh+n1/tYchJ9/zAVN44IosS4w==
X-Received: by 2002:a05:6a20:7d9e:b0:243:78a:82c2 with SMTP id adf61e73a8af0-24340dafb84mr3496841637.60.1755858619984;
        Fri, 22 Aug 2025 03:30:19 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fec0e9sm6825196a12.24.2025.08.22.03.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:30:19 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlmao.mao@oss.qualcomm.com>,
        Tao Zhang <quic_taozha@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: arm: document the static TPDM compatible
Date: Fri, 22 Aug 2025 18:30:06 +0800
Message-Id: <20250822103008.1029-2-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822103008.1029-1-jie.gan@oss.qualcomm.com>
References: <20250822103008.1029-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fpOFpF4f c=1 sm=1 tr=0 ts=68a846bd cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=5Z_N_GBq0btHVWfAyk4A:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: T08xVZBzZf-p1IKQCSTZ9BBr8umTbwi6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX4IhxdLRhdKGA
 rD9DjiBqZGr0c9pAZYMxb5Tpgy4CLTFAonaFiZpZFc3dM4OPlIofPcu9AmDmOnrTsZeuiHX8No3
 5/YGZNnbFA3YdJJsjCqBWSVtkgtLFFMfz3i6l1LJKqaKB+Vd4RZOsHgJyjPJcxanT5JuQbBBSCQ
 PdB0ZzJj+ZGFly32ip5iWyYabQaL+EZFAvyBu9K3tkLGxNL4D1baKMvwUiyZTLLqQoHS0dGjxcP
 0/3qMRKygh/xu8HnBxXrKuHKv4ZPZucKr9KF9ec25lOGkiYfM6b7J3EC4pNa/kfelMKLMOqZQOv
 4/XhA5iPU4594uxdEbsbEXD0QOlCL6omGtG3JrY99bkQ5ViU0myDu78p1GzhAEhuHhsR/VpRTgt
 QmLXWJ+/Sw6JG1fOo+qxifZl0vqrhA==
X-Proofpoint-ORIG-GUID: T08xVZBzZf-p1IKQCSTZ9BBr8umTbwi6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

The static TPDM device is intended for sources that do not require MMIO
mapping. Its compatible string should be documented clearly, along with
an example illustrating how to define a static TPDM node in the DT.

Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../bindings/arm/qcom,coresight-tpdm.yaml     | 23 ++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 07d21a3617f5..7c0acc1f25c5 100644
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
@@ -143,4 +146,18 @@ examples:
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


