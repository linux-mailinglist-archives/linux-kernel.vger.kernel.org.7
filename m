Return-Path: <linux-kernel+bounces-850297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAC4BD26EF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 435E34EFFD9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837B12FE06C;
	Mon, 13 Oct 2025 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LpT0O9Cr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B02FE06F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349831; cv=none; b=r0RBUFIiW6Imcne1Ci7mI6hHJxjL0RAtszah+PAZAVzn9OgZf/+9dP77HVRiCmMcMg56Z0JnWfoLpzf7YQBeI75JZ6CP2yEy/lk/J/3cJ6gOPHwqsmgkdMk8MbgA9LYtmTnIi2FQl2/i9Wa/Ps93PtWPybRRuec54Nb/fSXDM7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349831; c=relaxed/simple;
	bh=5S7bewqa2P4aC46GNTPc3Wfn3h92qyoaFLzlTIsn9fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sPSxhO0acE1HtzYH0iO2G3+fCVkpZMov5jbhPRSsIpOoTJyOipeoGOpwzPq5RhjAiD/rTfD6DFt0iBqqkvDjsbPjkM2cjfZZxYJjTUcIhBDuHZYWcQFACtSAngCMR65o94ulMKmuD11gVMwePO/1lavVP8mawdl0PK3zIa6PGHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LpT0O9Cr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2n6CY000856
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PFM8hA0K00Qfpbxy4GnLDAkU4MBb9gQY5AMWZmJe2JE=; b=LpT0O9CrPnTcFYzj
	8MbWgTkgPBtL0IbGY4HUZOsmlSYkjD3PYjqbe7GlAF8E7SuRVg5EZi0U4etnqVRu
	EdS0nRYbMSeSP144N5YZQix+HAxYv4w7boXYndPT+gihSqhSQLdVrAEytnjh+i4v
	CELYvkaSly6H6NqnS0cCg2XITSL1oWiGR7qoAqMWHuKySmbnIb+8Ai/b69LftVj9
	hlBXnWsyLnAaBQaDOvxQbsewIaTF59d/+h0knD1kM5aJxaFvanzEsom+nDJaF9if
	ALdtlbWMX3YBAFf2/dackKeF/qOhj+Lh8K0s/7s2MJwwxSw+ZkczcI78hX6tycwb
	eqmZXg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd8v6dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:03:48 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-781171fe1c5so7238838b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349827; x=1760954627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFM8hA0K00Qfpbxy4GnLDAkU4MBb9gQY5AMWZmJe2JE=;
        b=WB2bvGcNwl9DeqEuEnbFpWjZHu1ZyGV0zdeiB6TDrRTYEIiONZQQ9M962+AZD76NHB
         0BjHtqSpcO4RpFgoxLtDIROK3nJB9+PcGHxCYcB0XJ1lGmwrQ4zInEV49uqaC64upAQ3
         X9QuuZiv55WSAbjZAzLc3azFLxxQr4hu5fWFsFS+pK4FI0YcQKJZMUgaVT0iojbwrn3S
         gShqkzxm0I0h97qVOp1t923zkb5ZOJX0giB7xrLMgyu1UkREUq27YIF6iKj4tf5jXqKu
         PfXFSPMxoBXGiJwMB8jPgqUzRxSXSIp6mzuJP7EsexsXvr18R4C++l+ZkNrsTEXbWcHg
         rqCw==
X-Forwarded-Encrypted: i=1; AJvYcCW6T/7sAiEItq8p6JbYfT/xqG1W5/9MKiNn6/k1gKWByjhT6Nt4KVQTiIW4o+po3z9XZEiifXrn88g84K4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz099723XaX7jpbBv4S0+t7LWOoAj9ThotjE7bWSMzmBgjbWFj5
	tA6DQkA31mtCkdp3nzIOYDYDcqqPa4AKh67PAYHvWkUQbgbmK91QUsYl2ekyk0/74r39dVKO5j1
	VtVMEjwnu4GiVWtIuZtD42h4gxy987pYIqKUf5d0n5ph88nYVlcrplP6bjcgf8GV/4lU=
X-Gm-Gg: ASbGncuABBcwhV0aFUa3tOxrKGiYAN1p5d+4t6zvpxwnH6fZA7EcRPHzW6Rqi2fY0Te
	ya89LzppOBj5B4V6dQ0TpMeUU6igJ+z9sZYuWzth99997rL1ThFFXCP6Ba1Z4nneXyGCwWCn1ok
	4hNohxgeoq9ft0FD4HMN9xxs8DJIQAIa26jK5BC8MOp+qmDReb5sn6pUQ5Qjw2NH5FpI2Pr8PxG
	fj43bORKHddjnHtDBGm9tLKsxcjlLs2MOihL4tdR7EXp4pqfiZo/WDKcnf9RRteMEuY5/xq/Pvj
	iZr/M16WuwvV1Bt/5ih/QwIoR9CqZduo50N4gW1tGQPZOuTn3KH6JapC9M3TXjpFwbs=
X-Received: by 2002:a05:6a00:194d:b0:76b:d869:43fd with SMTP id d2e1a72fcca58-7938743fc00mr27742303b3a.18.1760349827326;
        Mon, 13 Oct 2025 03:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYhj8mqzvfx+Gmm8tmdtXN1K43jbXhwEsbYRoGFXxfSqXL1HtAguoQA9+KufJW5UnX9e4VnA==
X-Received: by 2002:a05:6a00:194d:b0:76b:d869:43fd with SMTP id d2e1a72fcca58-7938743fc00mr27742259b3a.18.1760349826760;
        Mon, 13 Oct 2025 03:03:46 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm10981657b3a.69.2025.10.13.03.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:03:46 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 15:33:05 +0530
Subject: [PATCH v5 01/13] dt-bindings: remoteproc: qcom,pas: Add iommus
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-kvm_rprocv5-v5-1-d609ed766061@oss.qualcomm.com>
References: <20251013-kvm_rprocv5-v5-0-d609ed766061@oss.qualcomm.com>
In-Reply-To: <20251013-kvm_rprocv5-v5-0-d609ed766061@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760349819; l=1163;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=5S7bewqa2P4aC46GNTPc3Wfn3h92qyoaFLzlTIsn9fM=;
 b=fjwKLRv6UEHiLGsia3ENpOQwDD/Zvg1ps7kKLeEGJYX81++6k8WJg8nxjIF1Z9+vVUXDs3/qI
 fai2B1PgWs5CMbdbTLtJ7yGde6RfpDrovbb5w4N0tqOFiNerbKTmY3R
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-ORIG-GUID: oYeZ_S8zpxjcGE-dvRfbE_xOPL4hWOmQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX91mSfxOy2c/y
 oa3G5vVLIH/KQa4w/8wnvn9tIYy6mHOk5Ul3Js3xnhsEec8hXm7J8TVlkdQScQfa/i6Rjf8Vdxa
 ioPE4WvhRGyhOHbk5TBIXR75hJoIwatopzUtp9P5vo1rFuEFMJrBsQn+oTwyMPUwHOyHD+AhNuC
 r6U0kZO4le7b9UQGE3xlt1mqJIplYVw+GbkkWbkK2XryWMUzW/hEvafdJL8MYC8L76+Xz82djuJ
 qXiT7aGU0u9+VO2JNi5HrXdxT5Q34RakinxZ0d6R7vvsGmdFh7c5236T3aw3cMI7f6dRr9z9Ypn
 9DkD6ZY6Z2mzicZCANEOLOHs9ZLAXwEz7MrhXkX4uRN0LlVtyqeTe67WNYD3VVc8cQgDZgh7Lak
 CxgwW8W6VTXUxy/rpCsyPpxQT6gHlw==
X-Proofpoint-GUID: oYeZ_S8zpxjcGE-dvRfbE_xOPL4hWOmQ
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ecce84 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=vdhzk_XxDewY554Buq8A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Most Qualcomm platforms feature Gunyah hypervisor which handles IOMMU
configuration for remote processor and when it is not present, the
operating system must perform these configurations instead and for that
firmware stream should be presented to the operating system. Hence, add
iommus property as optional property for PAS supported devices.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
index 63a82e7a8bf8..68c17bf18987 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,pas-common.yaml
@@ -44,6 +44,9 @@ properties:
       - const: stop-ack
       - const: shutdown-ack
 
+  iommus:
+    maxItems: 1
+
   power-domains:
     minItems: 1
     maxItems: 3

-- 
2.50.1


