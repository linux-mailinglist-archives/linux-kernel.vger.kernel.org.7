Return-Path: <linux-kernel+bounces-849978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5D9BD185B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A05EC4ED0A5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91692DEA6F;
	Mon, 13 Oct 2025 05:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q3tKhg0Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2B72E2299
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760334610; cv=none; b=BFYuQ77WbqhceLDopwM0qyD4rl19OiatzRiApWMfsSTTp6X6SJq0JKyodhfG1GYWYt2EikjGDei4c1LgMyD/7yl52Yk7G9+0zepJ62CkiGlKzFyOT3LyTUD+zyYe4qQ19HNkb5c31t3PzWW2qXhdHCFLv2eQCvQS8xDL5AQakyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760334610; c=relaxed/simple;
	bh=CPQNjReZzEuthWP4R2lJNdjHauXO/hHJqKsK5LCwEHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hm1KTcMASd3pptZqm3nF8DiavUnUCfH3Vni1BfCey7gLiH1z4molEZr7N6BTsogmBvuaDqrKklSpBNdZnzr292sx0Dj7IfWOO6QaFW7Xi2evp8JPa7UgAMWw036C1H4GNOuI6CmlQqrp8NcNpOSPZ9wSld+pzSC4YUIY2tLhczo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q3tKhg0Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2n3H9032708
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RsycQsQDunAKAjG18m7RQFoGc863uQg22TnoWmsfuDs=; b=Q3tKhg0Qt6P5ntJF
	cOWwJnxBdef2kw45mKEa5vFAy6gxCnYYwjVnThfK8YxWpbq3bpxd6QwXhHhsetnX
	GzGldlya7rEkoFbxaKxpCuX0DvZzQ3jQPYTyg503j7kSscGFP85+WFuV4iCDUGzJ
	OJmDQ7xeu37aXwEct9Z62zxDy97je7SV+I95HsSkRm6iAaT2/UmaXqfsUEOsK5PM
	TpqOezjnFbusexdWPCAGiQNES+wwM+KYh78Kqut+FNRVmRjBsV/pw+iOFf/+bfM3
	uPQSDoZ6dD1MDxUHd1065x37Yu7zgk0sKDLu3JetBvSCLCeoXpGYR2GIpeloiZGg
	NVz73A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd8ud5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 05:50:07 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso6680213b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 22:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760334607; x=1760939407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsycQsQDunAKAjG18m7RQFoGc863uQg22TnoWmsfuDs=;
        b=HN5hMQMRZA3/lGbMy2zP3UxoiCN7Ilhnf4z4GoVTjnNOrPCrdQHTu8rd9yalR8qJLR
         Hz3pIDkLmDpcen9GlCS+zOFz7tAAVdqtmYQDxXTK3I9qcCf5PyJJ0/v1vsHd0JtGi0C/
         ClChNBEZ/303px6pVv/QDhFDD/vmK7yU1eGrRJCrkZEg3D67VDxLvFKa0PTC93k/U8Ty
         H7ekdTC+qcUFx63zQAdzQC3xwWJF+JWL4fj1cRWLXqHjObhpczFBfk41je5YHyyDHRq1
         yQuYr1eekE2/VGblZLtgyrtlGHHltLXDI1u24xbpVX/J3xEtkdMjKjlfSBNzPw570bjn
         Vptw==
X-Forwarded-Encrypted: i=1; AJvYcCW4vG12KH+pCEpGe5IIemABvBl+K3Uwt0ha3GNDUeo1xS/xD6bFE2W2kqkqd8x066/zFisudWBJGi1phhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyACnMP+rZA3iK3iaK+avi6SE7S+3Cn9CIwd2ASRe2+DtS2MGp5
	5UmaAvSFC8SEx7x8Y1/s5NqFdAI/1bDf+PRauaJ+lvNJsIQWICCcEgT1GLm/Cjf2x9cWkI5ynpF
	WkaEXCblIsKU7PSjQzCoXJASvVdRqsI3Axd9IkJQUY/WHu3tTJ8NOtOt0Hfx1gkXY68U=
X-Gm-Gg: ASbGnctqLOtxH1lzurrt5IoXNAKsIfTPs8Ape2gy91v3/cXmt6rbV2r4UVykrjmqTk0
	lJIFbIOfp/B4v764MEGerVMBS5AyND8kl0tIJlqOjoIN760wcCk0znkhoALzIgqyZgLQS62GIRR
	TMldlAdYRpC40ud3GslZrhUBdjX+6+A8PmIEHkHASyYr/3jq+Gc0VoGFYusxmP2TLoqK3NEvQCq
	WDkHli8Ukjhw8yoltTScIj7Spz+IKBkJMsBfRZ9u35wQi9jyqI/6lE6KJ5ABuW5xmQtQFV1WTCd
	eL6fAOZEggpW9GimIzfqqkD5sZMgkW17TPu9Q6O2X02i6b2THHPkm8iNbsg+apGpkG/jry4EcrP
	WeXfcJUV1bkWepu+jVYZruDugHr4=
X-Received: by 2002:a05:6a00:886:b0:77f:449f:66b0 with SMTP id d2e1a72fcca58-793883dad54mr24936558b3a.32.1760334606575;
        Sun, 12 Oct 2025 22:50:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAWCgGwUZgm58CiKTOQW8YpRQefy9Oj0tMsYK5hjcqfo9P/GDSHFU6aimLp46L1AlwnBdA4Q==
X-Received: by 2002:a05:6a00:886:b0:77f:449f:66b0 with SMTP id d2e1a72fcca58-793883dad54mr24936514b3a.32.1760334606099;
        Sun, 12 Oct 2025 22:50:06 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e1336sm10129898b3a.59.2025.10.12.22.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:50:05 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 13:49:15 +0800
Subject: [PATCH v7 6/9] dt-bindings: arm: add an interrupt property for
 Coresight CTCU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-enable-byte-cntr-for-ctcu-v7-6-e1e8f41e15dd@oss.qualcomm.com>
References: <20251013-enable-byte-cntr-for-ctcu-v7-0-e1e8f41e15dd@oss.qualcomm.com>
In-Reply-To: <20251013-enable-byte-cntr-for-ctcu-v7-0-e1e8f41e15dd@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Jie Gan <quic_jiegan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760334568; l=1810;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=CPQNjReZzEuthWP4R2lJNdjHauXO/hHJqKsK5LCwEHw=;
 b=E7D4erC9cNnqmN3+hV4stIfeW2COgvL6aUFQ3zZqFMBAx/RfATnpgwV3/QmCnzco2wauJocyy
 CRu6J+UQWwXD/eqErWvs55GM6UbPa9O498wfkhVWGT4UGRBOMuVkKRC
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-ORIG-GUID: 1BLng6loM_Eo9l_oXXaRxG2SEIkWGA2l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX28DxepB88qiP
 +k6tMMc/k48EkMY/L98CrWFK4DXvLe7axJvtxyw6BuaUslajWiZj1Wr9OvlpTu/2WkXxvaIrGnM
 IO6DfEPg/8dmmqSxIM3CMed5GBIQ5DcQe0oN2RjW+IsK5b4AFSEPIF3wJBZNJlwDzCCGsPpiu8b
 t42F9xZ1bnf0stABVWVy9ApStXEWfDofyM7j2/ScL/YHcVnw5KiVgZPi69flg8IRmmC6ngCfuk7
 q2PNPqq7bRAH7vtlXyG+nOZN1shj7SfAftlRkKnNFGBkE5ZG01HeMUgXNM6F05Vcn/pDFdn+kvW
 VlM7hBCsdn/X6JDB8+/9WhmKmm4ujgUVaFHdBk8mA6Su8qbHUru51C7ioWiovo2H+m6adELR403
 oqkIGha1BZJHQ12Vo7UxHHtDZYNSkw==
X-Proofpoint-GUID: 1BLng6loM_Eo9l_oXXaRxG2SEIkWGA2l
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ec930f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=gSyxy6DGYGa4b6s9XCEA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Add an interrupt property to CTCU device. The interrupt will be triggered
when the data size in the ETR buffer exceeds the threshold of the
BYTECNTRVAL register. Programming a threshold in the BYTECNTRVAL register
of CTCU device will enable the interrupt.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../devicetree/bindings/arm/qcom,coresight-ctcu.yaml    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
index c969c16c21ef..02797e5f3b58 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
@@ -39,6 +39,16 @@ properties:
     items:
       - const: apb
 
+  interrupts:
+    items:
+      - description: Byte cntr interrupt for etr0
+      - description: Byte cntr interrupt for etr1
+
+  interrupt-names:
+    items:
+      - const: etr0
+      - const: etr1
+
   label:
     description:
       Description of a coresight device.
@@ -60,6 +70,8 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
     ctcu@1001000 {
         compatible = "qcom,sa8775p-ctcu";
         reg = <0x1001000 0x1000>;
@@ -67,6 +79,11 @@ examples:
         clocks = <&aoss_qmp>;
         clock-names = "apb";
 
+        interrupts = <GIC_SPI 270 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 262 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "etr0",
+                          "etr1";
+
         in-ports {
             #address-cells = <1>;
             #size-cells = <0>;

-- 
2.34.1


