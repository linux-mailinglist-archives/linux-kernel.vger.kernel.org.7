Return-Path: <linux-kernel+bounces-824692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BBEB89E60
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0177A04E7E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0F7221F13;
	Fri, 19 Sep 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CUjREkX7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85011DEFE8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291828; cv=none; b=t/li/TIyjtl5NBa1Ww7Uf4wGEcRpbNqcD6yuUBJnsewqlySSs5v7kbxOzVlt6NB1VmOU9Z1NikslC4r2l0bDCwFGU7kwVswrtH8d/ZTHRxlObKGOlP8jAEpuC4eB64vY+4ktxD1Q/T3LthLIyBAc3UohjvknpYkcnl/9F/wJG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291828; c=relaxed/simple;
	bh=WrctqBG5yal8gLgqGrzL6aanaaRl0HBq6tsGt6dAVGE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fPKM7LQ2xEKxhYzc3TNnpUnerAidYbB5vf03PiM8w9gwyAiapgjoBHYZSgA/odhpJ5UVw4iUAPPkcqbgDNTs2mRJewt2w/hEoQfTIkerGdr45twbymkzZgJbxF7mndEKMJ/5GXYmVXF8SqKqX9t9uEq4ovBmTAnzy5rVvMDTr1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CUjREkX7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J9tF6Z007399
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=H0MOngd9nnOaMlhiVp3d7MqH4YoWgLyveqG
	b+3qi4Vc=; b=CUjREkX7e+91P4hZSHghPs8G3g49mWfx+bJA8NQAcxe5eKd0wmP
	G8dFbKIhCur0NciKhFAQMaPN5ry1OeyuvUZFqt6DqQxqACQjK5Oly2zW9LuHH2OD
	kJOIbySvNFsxAMol1MGiHnGoeA4PPk/vtGKQ1wqlOnQ4ySE2IFNtAejJzyYHdmtM
	+bu8HMH10Wv+JG2jux7sDsW53Sk/kKlXbTJUeNxUB3VxQTY1tmdbuxZmj5KTxwXV
	yrlrYvKmEXHwxak3PN8c4vtLa5LLisL7+W11gQowbqqIBsz66YT3i/U37/nXMUxW
	f5thC3XPz8Ugv+PE9VLq7p7BIWWLN3SAblQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498ebew6mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:23:45 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77619bb3871so4241556b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291825; x=1758896625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H0MOngd9nnOaMlhiVp3d7MqH4YoWgLyveqGb+3qi4Vc=;
        b=LaHAIHttJzPDs1Nakx09vB9WEjiFycbYXeqDYpTtm7rTkFoGeyezdM+HKtjN+Uab49
         yBI8iKlyCFnV7jTlmz6iRApMb1tLRYNfLEAvNMfuZJMJrdFaOsc1SxI0ACX6TKv5u8zz
         lyRqELL69epbBQrI7lRXNkd0Bzyu+A95UsJGtP12UUtjvSdXvx75iVJPrerYW/yYaQgs
         bEq4jEBCaazVcbwDHLD81xILSy0QyiPjadYCast8LrbmaqMk76Ft9Og0YEDKA+5gZoiz
         adIwsqpA6i4OWKtJCyF9Nq+XbTOgYbI8olbwDTvj/gIyLKyvnzZfG3AA3aGpTam43rO0
         F2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT/O9QSdKKpvBuzfIv0rfCToLNsMbLnVKvekWrhZqpPiB2jRT2yoJnfmjzxNJl7ieFLV3Y3i5Dc/d/llQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC7sawq0aIV9yLyHnH+QhAiTAV7dYs8eDTCEcoT3A3dqv9QHVX
	ZhlOG8M38/Se/Zyfq+n8Z2jdYI6Km5/YbjWJol6DA3/lVpTTiO7uuGZF8FrRy2YGrmw+mTMQQsi
	GCNMz5Uf6UBCfjOArJRmuQoUcdLj3dnkj+9WpqE50jufO+ZBkuWva0dIqIlSOLLAHjNU=
X-Gm-Gg: ASbGncv4M87B1T4KHc/PnHsrGO9JrdN2ufX533IgTgdTCSKWLDDVp1jYg/UmHvqwYIl
	izTDkNM+XlHsNb62xj+PcwEzqJGn5w6XbWgRd+FY+R4wkcbsY3WRlnK9UOW9553mwyVf9Hl/lIc
	1pTdLOd6koQpJwrVspgN6zdfKqOWC6efV3cLlvbICmWSO3mBNkxRJou360V+8U/U49UgfN87lWd
	GNt08BKFae+sptdiVRyVJcviOzqtt4PvJlTYGAeU4SnJfzN0PcJGY4ZF365W9zuZxF6S1mz4//w
	b0gXHx3d1k1X5WyBc6iW4rsBalvlzYkv54SZOMDD38joMg7eTpQp7vFV6ZOYJa7LQV0DES+1pdn
	hGHum9//Uj3QX2Dhv0hv9oAjio8REu71Omnh5tqtJg1BNacfwkPkQGsbYcE26
X-Received: by 2002:a05:6a20:7485:b0:262:23dd:2e93 with SMTP id adf61e73a8af0-2923a323a25mr5577752637.0.1758291824890;
        Fri, 19 Sep 2025 07:23:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsFVhcjm0X3oNhORINQVqZ5ZFstDem6nqXS91CKPxgvJ43nQqgJn2edyW48rEB6IkCNBZ2ng==
X-Received: by 2002:a05:6a20:7485:b0:262:23dd:2e93 with SMTP id adf61e73a8af0-2923a323a25mr5577720637.0.1758291824430;
        Fri, 19 Sep 2025 07:23:44 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f097b60e7sm1335147b3a.1.2025.09.19.07.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:23:44 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: PCI: qcom,pcie-x1e80100: Set clocks minItems for the fifth Glymur PCIe Controller
Date: Fri, 19 Sep 2025 19:53:25 +0530
Message-Id: <20250919142325.1090059-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wMWTTz-sucL57Q7HkFKMSwD1GeCW2VGX
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cd6771 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=UB6fr0ZYtwJW8fNbdQgA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: wMWTTz-sucL57Q7HkFKMSwD1GeCW2VGX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfX0CF4e0N980Gd
 BQP44i7aSImdudrOEcrWfQEvRDxgzD2sXPDT/kM9CBnRDOWHV+QamJ2woM/WYk4b2xo8u3BIrAn
 MkQOd81JAXgpxsAUcpnWrxVYz2n1ezsX61zGHHmOqAv7TDRWHjPOtINVIY3jyjdnPOLKB9ojInv
 JMtm3h6f45kdE+D1UT7irpuPJpQXmocQVcH0JDyeWLuQBEe+6SoiwRybHP80mNI4nxEHZdupFsJ
 RDf2RegZldAlWNGFRhhyhB8dM6wMfLcalyYWvk98BWfU4z7wsoE6buptxG+rExZOG+7bsvy7mQ0
 uFrBWeunHrD78TgBrrM7+jXsPYBOAa+0MxURx4DduIpA4vCHppfoSrLugUVN1bmicHijdn5jdQ4
 6Js+ioQZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074

From: Qiang Yu <qiang.yu@oss.qualcomm.com>

On the Qualcomm Glymur platform, the fifth PCIe host is compatible with
the DWC controller present on the X1E80100 platform, but does not have
cnoc_sf_axi clock. Hence, set minItems of clocks and clock-names to six.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
index 257068a18264..61581ffbfb24 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
@@ -32,10 +32,11 @@ properties:
       - const: mhi # MHI registers
 
   clocks:
-    minItems: 7
+    minItems: 6
     maxItems: 7
 
   clock-names:
+    minItems: 6
     items:
       - const: aux # Auxiliary clock
       - const: cfg # Configuration clock
-- 
2.34.1


