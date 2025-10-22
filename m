Return-Path: <linux-kernel+bounces-864211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDDABFA2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71203BD462
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D682EA17D;
	Wed, 22 Oct 2025 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J1twn36E"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E6350A24
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113766; cv=none; b=sp5nVWdKbsfCEkbfujW4KgWufKIQJtUc9VPb2AJ218l/wjA1AOBNkBzirCz2jhGiDP6V145qz3maGgJYGRcsjU4OQ0kmV6BW3S0MxfUwVUjNsTCeExBJuErQjKvCHLOGtiao7yZ0zhNc/Sur+IJGk4sqIxpqJaZ5xoGxXTJmg48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113766; c=relaxed/simple;
	bh=Mdp/Hc2CfLvmDTYkA2DMn9LW5Eg9Clkn4+zwn1SGkTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=paWKhGgz43j1Zd9QEh7NynydiefaB1G1pqj6uWZRiHvc2+PyZ+a1a/l+e2BHkgNueruh0zJLCcJbao0pT+iUZesrAtRbQKv9qn3FgcaBb6MZ2mAShGr6xy0IAsnviIKorM54QnaowkIHA/z2j/P9OurSc3jqZJ4ktw4dA1gZzOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J1twn36E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LKfJ65012340
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Caa5vkwdw4xHZraI3/8RKS
	xtU2t5kpfmIZu41KBIZko=; b=J1twn36ENOg0CLYJn5k195VQx7r9PBIhcu/dTY
	g9MQjCHDDznAe3zmAXA0/5UjOLKhtoWYcuzaClRs3a9VPGZiX0UuW0ZszR4eb47J
	2C4220ZUQ/g5pHjdZr6x40CLvnYqo3Yz8OwKYNbYyJOJHIxJl7M10UqgVMlex3w0
	aE9pcyd2toLyOTjnBKL/NE/ZnISo/xd3/9C9ojzuSdbGwgNFObMrR7Mg/lRaLXwe
	HUlRifK864+q0qYJkWBX2kobxw/GsKALg6kPD8GJ7OkUrVM7PeYzjVYxxxqNStaT
	/2D81rMREznd7bprcurqpxiMhDfth0zgHsjZvV572ghISqtQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0ha8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:16:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290cd61855eso51570205ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761113762; x=1761718562;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Caa5vkwdw4xHZraI3/8RKSxtU2t5kpfmIZu41KBIZko=;
        b=IOgrgTflOszEHs6IVTDTvdqKKV6qxCX6G8KpbbJplKGWpssnGbnPyHmO58WM961meA
         Z2HMoOsRXMhuOslHw2UREnfVZLz6+2oBaiSy4EJd60x7p7dbBxYg7yXR8njt3PADlf/r
         ucLhyL9HR5KKvLWoZrdRbC3f0MrRzqvSKQrpFfEK2CKbYGezaj0p71EkTmLjiEb91dPw
         UEZuevWGflWbFf5AyL1OaZLdK+bLLNtPPu5o0MysRRrrH+ABegSOpWDVa2Jsl4XQTsPT
         Ay2ZRJoauWMXRqblgKIDbWd3MsXRNTJ5G0J2tEsg/zx3hgk6nRBeXC4ncUTjyRfWr1ZS
         TPFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzI4MZxJ5avPbBHGD7TmfECgYirBFyy85/W2gifjEUg+MVC2SVn3UulBL3x147f35UVYpemgb93BimArk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo7YATnDNDVdbSbxezjYGrWfnJiV/tz9ZjIs/xJC64JFKzazYJ
	hFDdCZJ6R0vU3QTFuRAIyIKJHITzj6d4P7DgH6WyhoR9VsivJVF2sh9h/Jc6NnX2Kg3cWtNmcaX
	UYnNF/uLpyExgGA9RFa57xW+KmpplX1c+0uTkUeURqd4rQeAz8Anm3qmD+01GmxK4mNI=
X-Gm-Gg: ASbGncsg2+2nBgr6Bwyi0Ln+YNlIlhsFRJwBNOsjraHrMrYu9S0n/2kf2DubEk9qwGy
	itqohHrJIkowr2i6aXRu016VWy+zmX1uyMxWP6QnJCL7URlU+XvlY6iI4r5xYlirFHURfjXAVLr
	PNcAem8fAYdKFyzK5FwTkILgw086IcauLyoEUvNmkeFfl8F6qjmtU15kj4Hd7x5F0Qw9BeNCwP6
	rgjDDwdownuKRDFv9jLzvEUI/Pn/SoZRscBQmTvjND04Ob6g6Ng3eThUfblUISqAEOPgxrgBkr3
	M9tPewDmMhxJHzVt9aYbZvH9ARlj7N7K+Fgi9MsyZdqmZipL7rszBZ3zcMM7CUgpJXh0KGcjfgw
	rcEX+ChCe0YIYoaVbEmO+QIYUy1m9ATz8UIg8XMmxOioTx6PARA==
X-Received: by 2002:a17:902:ce0e:b0:264:befb:829c with SMTP id d9443c01a7336-290c9c8a738mr228745505ad.9.1761113762286;
        Tue, 21 Oct 2025 23:16:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK2AgOSc86y2gtANDpKitSqnm917eqTcvN+6mopis8vmZnFgELd8pw/IBae457LATXi4NWmw==
X-Received: by 2002:a17:902:ce0e:b0:264:befb:829c with SMTP id d9443c01a7336-290c9c8a738mr228745345ad.9.1761113761848;
        Tue, 21 Oct 2025 23:16:01 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe2cdsm127890045ad.95.2025.10.21.23.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:16:01 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 23:15:54 -0700
Subject: [PATCH v2] dt-bindings: arm-smmu: Add compatible for Kaanapali and
 Glymur SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-knp-smmu-v2-1-88774e6d2def@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJl2+GgC/02Nyw7CIBREf6Vh7W2A4gNX/ofpgl7QEgUq1zaap
 v8u7crNJCeZOTMzctk7YudqZtlNnnyKBeSuYtibeHfgbWEmudwLLgV0Ch5xAAphBDxqcxAWlWo
 UK4shu5v/bLZrW7gz5KDLJmK/OsperrXe0zvl7/Y5ibW86bmWf+5JgADUDWp9spYrvCSi+jWaJ
 6YQ6hKsXZblBzREBLHBAAAA
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761113760; l=1520;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=Mdp/Hc2CfLvmDTYkA2DMn9LW5Eg9Clkn4+zwn1SGkTM=;
 b=xSrVO81Lo4lXRQpoQOgaTHn443ZBp7YKlNGDYCQt2R9bVirX0XZP4W8nz4Z3dr7Y6jmiGfP3x
 wucPu3qrWm6A4Qlc9956K7d9DiQvi5x1mODNtuPFMrg2CVgr9ECtyBP
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfXwF3OcuOWN82u
 kE67h5uIymsmJDOyF5wjdy7jcv4fz2X3+ASn/QOItBRhXc8pzY5pvRuUYD2uwl9U3P8RTCe9H+v
 HDlpIYcjsU0sDqkl8QsGesa4DzJKqGiszeepghr608YVpB33aOgJi5ZmDhqDGRnonsbLWUe/kTb
 7yvR1o6EBNHqoHk79R6DvaXxvycO3OnfPZgN2SRZcdcS2WzHJzYSA2blEWVK18Fg8GST05avBg1
 66tk0YbNLOukJCjP4CRgKa2DIuQTc9D5/qyAIeOYgs/IgfzutOxGM471gt6MeihvZBDxC3ST9Cb
 vjsv1kKg34iu+Tff9CqBcb3y9f1kywz97o0S2QoWuaoC4hqgH6uzZU8zDSEkeXTeTcoEkQu7UYc
 nQGzzm8E7LRmeJJPg0rIeFZDtx5H8Q==
X-Proofpoint-ORIG-GUID: GfYx0bPPDJbdPGR1wAuyPC1Q1L0uwZFF
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68f876a3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=iEDX-NX4Me02MYkbRrQA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: GfYx0bPPDJbdPGR1wAuyPC1Q1L0uwZFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

Qualcomm Kaanapali and Glymur SoCs include apps smmu that implements
arm,mmu-500, which is used to translate device-visible virtual addresses
to physical addresses. Add compatible for these items.

Co-developed-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v2:
- squash glymur binding: https://lore.kernel.org/all/20250919133439.965595-1-pankaj.patil@oss.qualcomm.com/
- Link to v1: https://lore.kernel.org/r/20250924-knp-smmu-v1-1-c93c998dd04c@oss.qualcomm.com
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 89495f094d52..2ffc48a276df 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -35,6 +35,8 @@ properties:
       - description: Qcom SoCs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,glymur-smmu-500
+              - qcom,kaanapali-smmu-500
               - qcom,milos-smmu-500
               - qcom,qcm2290-smmu-500
               - qcom,qcs615-smmu-500

---
base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
change-id: 20251021-b4-knp-smmu-c79a61dc4434

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


