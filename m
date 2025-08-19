Return-Path: <linux-kernel+bounces-775535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4708AB2C04E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33DA4163F96
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54D432BF26;
	Tue, 19 Aug 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GiCN2wLW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9A5326D5A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602702; cv=none; b=bNk8qlD7PqT62AXKmEWhXXwEie9ofimaoIs+lAGIy3vMU3lBQATbb68Qb11VYHA0kK1AO3LMM6nGYNvgGYIkm+P4ot9flxRJW3b3ud8iEYd9/lqJIJfoOKxWXVvb+CkF1bVvqX3Yicz9KBXE0DcQx5THAiIs1yXqOccey8BYgsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602702; c=relaxed/simple;
	bh=jfFVMew13aow9LdiRL7XgiGeNSFwWq+iSxzZgyk6PJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m2Ggiwhc7mYW6VCQFgxtA3CuNAesieR5tiwELKWvp4Vywrpjw3DzOsck+YIPGjYqm6oUdeJ7umMxV9e5dSO6jiY8erAWVKe2IM1iwu82BmvId8340BJfZwX10rysKWYDZicxGr5T7RH3nfExK43MM+LIPlPZX7KZ2De57oS2HCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GiCN2wLW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90arV021802
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ylwnfePZhDFnBtzP9R6qdkGXQk7pZlCHWwEtxVPDs/4=; b=GiCN2wLWXZoVgDfs
	stxoqHqyku4mAKBsijfyWxc5WVTIOoboBVDDr0PGY/tggKGqyPeqJpcqv4CSH81n
	0LDsiGFU//+iViRO+1dUk4J9igxdo0JK6iuEErpivW/zAX173KvQFagg9Pw7ahEZ
	bAwsC9epKHMRu1M3kXIbbhSyQQifZAioEFQpmRTnzmKm10EjJM4206Sp6r8Nheau
	eQL6dqJqkWdcfkhmgWPs/wTrIjSdK4xZOv6tNckGttSKk5X9mdYj6Q/ei3F4145v
	60N5hNd9hsNykmDrqcgfYdq6bUktvUOcRTzshhHxlMmEasH6lmna+UoFEui/NLJC
	aV3Jiw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m71ck1bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:24:59 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e1ff27cfaso5397539b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755602699; x=1756207499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylwnfePZhDFnBtzP9R6qdkGXQk7pZlCHWwEtxVPDs/4=;
        b=l2ZgXApYCHEGMF3bHG6ezdBEgPSn+ZHx0u5wYrq0CyNvh434DmbJRNktHnRiEzxU0r
         O4Pa4tpeJaEm8dAd9IAXYkLpZhv8l/58ckfx5bu5X5oYJegIMpesejgOI7gOJU6fe9Re
         JK73yFjw2spyO/dEqCvGQkPLbVplB/T3OElaqhCaWBmi/rVF2orKGskG6pUW+b/vX54f
         t8v70OyRHNYXTx0V3okYFSu7wFrncXnPeKyMs1yHWbcZWGx9hQtKrYuTS0pRyM/k46Rs
         7lmTJd8ycwc1mHeGE8uNHikB8k6A9qTMHkyEOw6jbb+by5cerOHLfWaVk0/pcxDFFA31
         MrZg==
X-Forwarded-Encrypted: i=1; AJvYcCXqM91H6EbLL6sdKoWj76wHZS55qERSXWoqMOjVoZ1c9F9ZkRBNB91kvI1mYWuXNi62pvB3paNikjZeTK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxePDY5y8KoPAi3mpSt7e5np5qBDnvRzWNeCMGk76T5Yi0kvAVt
	/Gzo5NIZ7IE5sOA3uUW+qz4hNCTPJ7nlv83MZnpC0bCGKFtyA2LSQYT1Lnc1A8CG6IM31lXZack
	oaVZeW9kFdEAIw5zCVUP1M2FxxPi0pu3ud8zmfkg0Zp7obSscB8hs1AqRnPhnXsDkXM0=
X-Gm-Gg: ASbGncvGm0yglcBHuBOxhpJ/SIznQCso5jCobcX0zuOhHGO2h+4aLIFAB+aXrQKyWVk
	yzjcGkzOaQori01y5OMTRgdclzUV1/K+TKYgOVxtOd9hF/6VpJuos/5zesL8GCsq6UOZbf/b+Xt
	k3GD6CwY1QXk2z58UUy5GzFOevVeCn19o7otmrO5Z4RhVnvAKQYeNjL0qTGRk+LkYsCQVBYS64J
	PFa3ZR3TGkRQyaTIKVAvX7U/XPIPZoM+Vqik71fJKlrA9T2f2DzGwgcVNcMnagnlC+QIqyauAS0
	AkYtzQ3wkCuLSgFl1oz3gCoNbL1877pKJLrjThbHmqTEHRQ/u73FRcDHbHvPRKU=
X-Received: by 2002:a05:6a00:4b46:b0:76e:7aba:cb41 with SMTP id d2e1a72fcca58-76e81a1848cmr2455152b3a.13.1755602698953;
        Tue, 19 Aug 2025 04:24:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMOHVGcTe73LweODTfsXqIUxD7/Iwwz6sW8zqb7EGuvXAkkHJ30P27NxGICxJsbheDjqrKJQ==
X-Received: by 2002:a05:6a00:4b46:b0:76e:7aba:cb41 with SMTP id d2e1a72fcca58-76e81a1848cmr2455114b3a.13.1755602698489;
        Tue, 19 Aug 2025 04:24:58 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f7cdfsm2202258b3a.63.2025.08.19.04.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:24:58 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 11:24:46 +0000
Subject: [PATCH v3 1/2] dt-bindings: interconnect: Add OSM L3 compatible
 for QCS615 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-talos-l3-icc-v3-1-04529e85dac7@oss.qualcomm.com>
References: <20250819-talos-l3-icc-v3-0-04529e85dac7@oss.qualcomm.com>
In-Reply-To: <20250819-talos-l3-icc-v3-0-04529e85dac7@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: dC1oMhbsAopxZIvy4G2iBftciZKJhCpk
X-Proofpoint-GUID: dC1oMhbsAopxZIvy4G2iBftciZKJhCpk
X-Authority-Analysis: v=2.4 cv=IvQecK/g c=1 sm=1 tr=0 ts=68a45f0b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=bpSexm00WYn9fMQEYZEA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0NyBTYWx0ZWRfX/IC8YmdsdnSm
 Rug2HAvo2S+reedZhxiKPEBVmhcCHNfczu1O51thVx7IBfwQpGD9thaiWgX+ACysLAdp483o4oF
 8Z2qt+odhA1tvCtNaFQxvldiRICt3uURgkMcNPgPjBXzCOd0SPgxfq+pSDIclakkNOSzhsyth2J
 0ojGMXMog6Xl3dEKhhYa2xV3ts139C1KNbZZwq+HLsYE6HyJGvdtIuqyMpSU2xSujLBQVMAyfLR
 36ycETtfTEBoO8KnOCxKnl3LaGJf13ol4zSdI6gNke4Q6FkVEIeoI5gy4SMSUHp7KWleO6+4YBQ
 XKcCJx3MVAnLLqYkO3qgtqNW09rjDfOms+LfClOfOPIhd5GNm/7wYhhBufA/I1jaeqEOl7MpiqR
 RjJO8TrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180147

Add Operation State Manager (OSM) L3 interconnect provider binding for
QCS615 SoC. As the OSM hardware in QCS615 and SM8150 are same,
added a family-level compatible for SM8150 SoC.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index ab5a921c3495298546e4bd34ed3b9e4e85d3c747..4b9b98fbe8f22258c209e8337bb4517e5f5888e8 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -41,6 +41,11 @@ properties:
               - qcom,qcs8300-epss-l3
           - const: qcom,sa8775p-epss-l3
           - const: qcom,epss-l3
+      - items:
+          - enum:
+              - qcom,qcs615-osm-l3
+          - const: qcom,sm8150-osm-l3
+          - const: qcom,osm-l3
 
   reg:
     maxItems: 1

-- 
2.43.0


