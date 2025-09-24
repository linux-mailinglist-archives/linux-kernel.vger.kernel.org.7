Return-Path: <linux-kernel+bounces-830704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C77B9A559
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D12D172148
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CD8309F14;
	Wed, 24 Sep 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dqGiO3+R"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C7C305946
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725331; cv=none; b=Tq6hRW4tgYv+8JrA7lpZk0VWqchLaTGREriMahGO0ToTnroMLmMA0/P43lqKgGQXkxOcl+a6j6Rmgo85UTC8QRraPP9VKcZmw6pXVGfpbLxCuVLH2mK2NbdQn3nHmMxV8zCWdbj3gRFshrdykaYaFrSMzIcdpz9ok/yZHoh/KEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725331; c=relaxed/simple;
	bh=h/srBE3WtprL7mFhf76UFwoR5LDPsTSkmWauWPUtJrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IImRWnCSp20jW029LOKVsarH0c+LXtBM4R/kMtV8eQlSkW+eaZvtwyiLhNXsyM3Vf/hgT+i716rVeH7W+ZudyhqjcNnvfpwD08iID8jCl6rEOsgCVed2cs6TVtEF6Krv1oeimHEzp/Bhv7ApnA2MDZx/ni7d36r42QsUZeUywjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dqGiO3+R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCu83w024516
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XPG+9O8dDPmoroQEsDtHD7YgbTrYDM8HGg+
	bzuFokcU=; b=dqGiO3+RhQc0b6FLZI3QlciPHNr20AN/9ydO4sgK6X425s981wN
	SMTqdp3eqToi1AJWbqBw90PAQpRZf4e3vX1xy1v/RpRYhsSIpGeJDejU56YFis0e
	I3WKRlz3KyjGL53f1Lc/nRg4rhriw9kY4na7EjsqNUrZZF7+qg2IBq67WFtRNN0D
	6KJFKgyPypuQEnlJ1xLv8HAbXZdKuCyQmmsvJAbWo9o3itWjAejqxH4LESjVZ49O
	RgFR7xyUn+V58l0FKpxH5wlJDQ7UWOh8qjnoEDVnYDVvgnl22QlUuDIprk6MIJl1
	ipn10HEZaooWgQ3WAL+nkqS5pGP5PowmCxw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0bqdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:48:42 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b5509ed1854so4665687a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725321; x=1759330121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPG+9O8dDPmoroQEsDtHD7YgbTrYDM8HGg+bzuFokcU=;
        b=Sl4oGE8Vhz5DW9ppxtH399+fvNbNb9BIXjRXo4gjCKAoPZmv+D4Bzfq1SmIeVvuysC
         wXKPfZ7vFy7NxDN+E+GFz8VPDLPuc7B1qwY6RmqsIr/DmXwfKQyCjjwsTRTdoxPLUutR
         m1tivGmNVEoPSgW558pKDFofX37S3tp2aI9m4Bh54pOiqPn+XzHw55kPIITx19vwj8SI
         kd6/fZp5ELgldUfZ2BqEqRgY1I3PSJmg19QXnTN985Vn97ukKOQ0XLNdxNmWLVrTsbIs
         jPKY2YkburZlQuiHbO9XqbWIDInE/m4W+OpvjoySKwyqDAvSLxexMRUUtyoyuLCSGUXG
         x9QA==
X-Gm-Message-State: AOJu0YzhAU6+EjsPbqpqp7vMCsJ9WE6AzFChqGpsgpkZnD+t8nvDLS6Y
	YvG/gIvldqdsOFiZuO40ian0Pgpbk1d1y3F36FTlz/+jGC+hZemSrZmvouGyUlwBqISeS1WPXm2
	kAE7wIgdzZy0PajuNEXmlWTd0KM/eOrC8GRnaMlrJ/jOJmq8tRa8aqv+NYQsZQmF5c+U=
X-Gm-Gg: ASbGncuHfAXtBBe0Eu96HW6VgRuTG725OHH7SXviqIbxNRH+6JlDxDykGIlWW6t4d8E
	9ezx2BXcl2odmlSEWjFK42fT1Q+8ZKBEWbardhXsRB0w/dj4QMvEdPEp4sGP9K5M3UZ/SNFqMRH
	KQyQHEYt9kXPhd3ICqve022QUqus4i455ICGfLO+Ajd4wuuoaz7bRBxV+9Y9dQsa67U/m0M8KxZ
	HvYA4IloFN7AkCDhuOsBb9M2wqhEmqaPOFxfjAj0JaSsW/PCNFnhHA9uoTZI5HgyizG2tnu/Ghc
	sEX8HkrEjWYLm+tSYLdJDwJGA83P/RMY5qMqBre/py1Pg9/UnwBQsTNl5f0WGh+MHobWAJKTQ4L
	0LU9PzkLvOihl3m0lJJS2/UaW2O6Ka2gIoWeHidDhi/bJ+fg5Jghfwpg=
X-Received: by 2002:a17:903:2450:b0:24c:d0b3:3b20 with SMTP id d9443c01a7336-27cc7bb3d6cmr81106555ad.37.1758725321481;
        Wed, 24 Sep 2025 07:48:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuRoilg2iyqRWH5zKfaKKeY1QWhKYWC2phGHEAbOmFsU4CdT2HU6aysnxHeuV/PIGhylHnbQ==
X-Received: by 2002:a17:903:2450:b0:24c:d0b3:3b20 with SMTP id d9443c01a7336-27cc7bb3d6cmr81106245ad.37.1758725320890;
        Wed, 24 Sep 2025 07:48:40 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800530c2sm195106345ad.3.2025.09.24.07.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:48:40 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: mailbox: qcom: Document Glymur CPUCP mailbox controller binding
Date: Wed, 24 Sep 2025 20:18:31 +0530
Message-Id: <20250924144831.336367-1-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d404ca cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=FaBG7U5ITfglTqoGHWwA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: qv_yQk5fNZS1ctd4ZxCknG6CgEcoGnj2
X-Proofpoint-ORIG-GUID: qv_yQk5fNZS1ctd4ZxCknG6CgEcoGnj2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX8iarLj9StYnS
 si3ZbRhEeUzeXz8s4Av/zvblGcGoYZOgMHTHrGhRBm1SJNObpY/Bdf/Fri+UX7cdeFE3E8N7v3b
 S3UenyKIOI4pOc0L5OYiwql6U6Sq+7S4g39eoKxEmbjpqC1ajj5tiMIyNHe390eL8gTljLNq2By
 vGC1S7/CyrMjbA/3gAcMCvHZQqh9IEkHl1O84ZvX6QtBr8Q4kyDwutC3S+7JUrUP0tPhZpnqSKO
 7VEKV5YpxzlcYzb0vbrYOz+e7E7up+vbDP/vSROTalk4JYU4ANrLI7z9ruzXzLJNtoEw+gOS10V
 QFxPlSfBkVHuUaWdcjQpvVhml3K1cxBnwgtsW8x5BOH7eoFkyeA8nWDmkz4gugCSrVqOneL6CKK
 QGOhwBAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1011 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

Document CPU Control Processor (CPUCP) mailbox controller for Qualcomm
Glymur SoCs. It is software compatible with X1E80100 CPUCP mailbox
controller hence fallback to it.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 .../devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml     | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
index f7342d04beec..9122c3d2dc30 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
@@ -15,8 +15,13 @@ description:
 
 properties:
   compatible:
-    items:
-      - const: qcom,x1e80100-cpucp-mbox
+    oneOf:
+      - items:
+          - enum:
+              - qcom,glymur-cpucp-mbox
+          - const: qcom,x1e80100-cpucp-mbox
+      - enum:
+          - qcom,x1e80100-cpucp-mbox
 
   reg:
     items:
-- 
2.34.1


