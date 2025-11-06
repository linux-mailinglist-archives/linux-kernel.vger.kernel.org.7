Return-Path: <linux-kernel+bounces-888385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD803C3AA63
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78520502F80
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29DE30F7E9;
	Thu,  6 Nov 2025 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cWTKpl7u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NXNvkOsV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEAF30F938
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762429212; cv=none; b=MSDmn7/cc4k0RjR0CHOpYhkK110+OqDRoQd2z8xpdDtBnfFo6CguR/yOA0Oz6P1Fgz4I6r/h+OQ62HLsjOMLvEs+3z8IBMy5gketEu1VobrlKBE8bTVCtQwHKJPyRWX4U+bLZkxxA9XqaC793U9aIfxO2leil0DvittZiOJ5qoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762429212; c=relaxed/simple;
	bh=IATc/BWe25FDjleFlTjelCzWKgHVZ0FKWD/Y6NACOW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n3GrKEwUAM//Idrk43VnjqDnIX6wJpCVaARJ4U4hWUQXJ4Vdu2gVXpSs0x/3PDb8lBBdWB/pYWvlJXGRb+Fgg2PyCUwf7uRpQZrVtCnxv5tod9rRLE3/K6OJe5+0hANz8W0u+r0HkGeN8vQJE48NUB1d87ruJtOJtDuUZ1O7q+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cWTKpl7u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NXNvkOsV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A66rDhI3361979
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 11:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tplQaWj0LuJZs5gP92aThpV6BCVGBwjEo2F
	RoetI/a8=; b=cWTKpl7uylAE8ZSH5FJ6mBudAt0nW7lIfwlu+/eq9Jl3Kx70dXK
	5eQ73Ft+MOj029II1odW+3dgDdvD4MNQoLUK3vIbGNKutb/OuR8qY5e42ZUWXVq9
	QbCNJrKY/DfXLgN9jhAgqW1TOPQYaOQZvK46KOLFjMqKms1QGTUspJCXPyKxSD81
	hZ2NpHmiIg/zNshlr5VsCSQ0A1LghJCSL6McpT28ec4bTraP60Ixx2XkelArVOB7
	O3ujdxHZ+Tm6FoSceP/5PnvxMykV5aMP793EyCRTFm+MqqaC1RkgMBGOQSzDYMva
	zM86jigHaLh4DCDG7nRUWDPsq1HIqA+Dpgw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8pt58sd3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:40:09 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7ae9be0d8d5so641714b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762429209; x=1763034009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tplQaWj0LuJZs5gP92aThpV6BCVGBwjEo2FRoetI/a8=;
        b=NXNvkOsVcdaob3HO5ImMNb9zm1poy4IUR2dcQBvh13pH3AqHyEwSPkOCNDX8gyLqDv
         QSEEq5+bDbkoA+O3QSiWzKKfdEg0v3eCqhYXzJQRoQLCIqm+b6FNj69VTtIyiT5jYWgy
         6AnEamsWrPFPCuRo1wwe+d4S8XNTGHmBdihVcUf1fgSMLLuWL5Q0BeQ0n50NaRHkUE68
         eAr13vMRJMxaOkxa8NkX3qJA1lfiFi4VtzbPeiEsdA+VWJAdUQ3EAUveiBxF63UXxYPD
         7rrv9pyt3RFSsrZDNzwAKIup5ednd5MenWQ69n5VPRbZP0KkxQeOUQDSemNmbYk92oP1
         N2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762429209; x=1763034009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tplQaWj0LuJZs5gP92aThpV6BCVGBwjEo2FRoetI/a8=;
        b=UyUxl1fJyIgkTjpoUv4cMJdk+WQQkZ8T0EgtGVYCwO3tUCy0RktY3RrDEa/LYAv42p
         TiGtlMSudL1Iu2kSZgA0K9mC3cS5PuKWbNTF0GuM7d2LzCMZrBPMfTM7BYjZPVbjCMYW
         Da538D6cKYEHDk8TUlT5qHk7U9FZWCalkDiB3J5Mf9orj9ENPO+avMnmdSPc4Omx8xgO
         XdHTnaZ+DIDn0GIpvn4FH1jS+ew983sk1RiP7k/M7R1v62zDM03fjO/TW3ZgPSbXao9V
         qoEPztNQj8lgEK2ggMMLMu2zqabUVc5Ap29VWzy0L8+vfBluqq+xmX0lwECtQaapmnaD
         KMUg==
X-Forwarded-Encrypted: i=1; AJvYcCUu/9qiyxpZKMOHaaFa1PMxxS0FiHLm35kth51Oq82oExS/1lDHRnUgphsI+5LnF8ZJ8y3x6q1I94L3Vi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXI+biKdyF0xXANC4ojSo661AEshvfV4/z/MqhZz5UQ4Ms3ivr
	R9HYeHFETlV0bP/uI9FtrpWkHp+J+y5PZAVczUV4yDozSSIB7k9V+yxOykwaQJcjXKMr1HlOdlY
	LWm8af76gBeDuC3nhskxgoX1ewdaI0lIQjJumACLnFfz7dxOVuhy18A8s7dMWyxplsv0=
X-Gm-Gg: ASbGncswAHczh87hZTGvu4DIZVKAru85Htj4Xn8Tjq1pzdV+qLVhnp7kaKozAhYErF7
	brS6MqN63mk5hun3lCwJECtg4A6oN6NX5LlN/QU7pUwiK8es2QuOR9thuKMbHsKS13sBogyC0r+
	8UQfA2xL9fS2ClT/FqjfFqsi2A+QdRAkqzpNh5kvQFejEHNmVSv+BLqJV/TuBzDvrXSelnrwl1p
	L4l0C5YrEFJXVCVXq4PwEMt7vtsc1XS43+fcVAGmvUqTHqlABtRROOYp9fbyUcBckdumplMzaMR
	+DcUjCEF8xa87PjTU1A/Q3VJJ4otcxEqvdUB8ENjch4zfIDctOdwLazntjpfUHWb/sZDiaMR/bf
	7LaEGfYfPPhXcV9wCG+57nfryjoWxkca/7Q==
X-Received: by 2002:a05:6a00:2d16:b0:7aa:4f1d:c458 with SMTP id d2e1a72fcca58-7ae1eda0230mr8572493b3a.19.1762429208695;
        Thu, 06 Nov 2025 03:40:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVUotlLDMkntNYYi4mBj3e7/x6lXZl4DxAaQeDTqWGqpoOiGkfaB2MP1zjb/rE3tBpq3DVJA==
X-Received: by 2002:a05:6a00:2d16:b0:7aa:4f1d:c458 with SMTP id d2e1a72fcca58-7ae1eda0230mr8572448b3a.19.1762429208107;
        Thu, 06 Nov 2025 03:40:08 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af822041d1sm2480040b3a.37.2025.11.06.03.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:40:07 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: andersson@kernel.org, robh@kernel.org, manivannan.sadhasivam@linaro.org,
        krzk@kernel.org, helgaas@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com,
        krishna.chundru@oss.qualcomm.com
Subject: [PATCH] schemas: pci: Document PCIe T_POWER_ON
Date: Thu,  6 Nov 2025 17:09:51 +0530
Message-Id: <20251106113951.844312-1-krishna.chundru@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gxfktsXrugkhJJDfSK1Uw1ipk1g94j-5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA5MSBTYWx0ZWRfXzmC/xkS1Dj17
 fgvFNaoJtwfP0OzIcNo7oE+MVm3sxU+lsw6ocKmVm5r40yH1Nk0h98NgVN8xiLsg+6nbd5tDk0l
 QHPIOhjqQ2wFQ52B1jFEwCyLhOreB8Ax3tSS/4FAkaK/iiafhWi/v2Dan9WZ8JTp4TfmsLhAMG8
 TmXCGRHdeFV24Q3bTa07gGGBk9muyLp5a4/+0oJYE+PaFLhRqaBefyii/ScjmkzcAkw3ufniCtN
 pL24mjOPBO+bjjBpKXRLm9jHQOwBHGB086Yyq2p4EcHqYbvlWj0SobJHdnmDUXq0Gp0GAQ4uZHh
 CpCbUKFSkxnkwuVP9oGEDiHEQIv6vMGBq46XHz1AoaE9AyXRtnm+rs+H859CCfEo6YUTHkoeVQ6
 stlf3YdiOccFFuCURvyYFN5nE0xVjQ==
X-Authority-Analysis: v=2.4 cv=XNI9iAhE c=1 sm=1 tr=0 ts=690c8919 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=fqsP0TYi9zmme8frg18A:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: gxfktsXrugkhJJDfSK1Uw1ipk1g94j-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060091

From PCIe r6, sec 5.5.4 & sec 5.5.5 T POWER_ON is the minimum amount
of time that each component must wait in L1.2.Exit after sampling CLKREQ#
asserted before actively driving the interface to ensure no device is ever
actively driving into an unpowered component and these values are based on
the components and AC coupling capacitors used in the connection linking
the two components.

Certain controllers may need to program this before enumeration, such
controllers can use this property to program it.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 dtschema/schemas/pci/pci-bus-common.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
index 5257339..bbe5510 100644
--- a/dtschema/schemas/pci/pci-bus-common.yaml
+++ b/dtschema/schemas/pci/pci-bus-common.yaml
@@ -152,6 +152,15 @@ properties:
       This property is invalid in host bridge nodes.
     maxItems: 1
 
+  t-power-on-us:
+    description:
+      The minimum amount of time that each component must wait in
+      L1.2.Exit after sampling CLKREQ# asserted before actively driving
+      the interface to ensure no device is ever actively driving into an
+      unpowered component. This value is based on the components and AC
+      coupling capacitors used in the connection linking the two
+      components(PCIe r6.0, sec 5.5.4).
+
   supports-clkreq:
     description:
       If present this property specifies that CLKREQ signal routing exists from
-- 
2.34.1


