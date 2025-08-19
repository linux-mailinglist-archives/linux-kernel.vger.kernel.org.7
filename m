Return-Path: <linux-kernel+bounces-775342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA33CB2BE2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524A91B67A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3991B3218C3;
	Tue, 19 Aug 2025 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QuS7t/vX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7091320CCB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597173; cv=none; b=YABEhFKQm+oQA7/bSkYhNVzX5Odpms4OUJkDCFyM78i6aaXh+9PdSEzvq/YftlGaH4IurBPnu75HF1X6+f+YEquTzASwGhAKYz+kbW1wB9kyk+K9oiVYFxgyiv6BlAHyKFQkEeUqlJT6FuD4Kq8zpH/gpxc5Sw9cIVgvbB6f8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597173; c=relaxed/simple;
	bh=lBG66nnuOJFNmGnwQUg3oad4X8eRl166WJOjEf0Foug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o9UBiaW5AvypL+1pUWpOMxIhGTM2pgp1Rozwdb3089RSTY2yS9gdNQ0De22+a45rAFrq414rsBXCZ+byc4W6y08FqKv9qXXbZeUsHWWt1ZiydBa9QY29CDWnC6yQJtRbUFwcNZ/9Fk2Jan87Ch7181L78dTGKduHxFWoBfYnH0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QuS7t/vX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J90ZED032422
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a9i1vfAm82rgoZ9V2Oilt0uKHn0wjU3RD+NnjEoXSuk=; b=QuS7t/vXgtGLzNwE
	DC3D6MiYb8VKZiZ3wqQXlXM+AiOlFqovFF3hCZvtuuYI9z8vGisW9uKuz1kLSbrj
	uuIkHF8ux5xutPFwZ4u8z3W449QOCXXonIDM8sjvgZNHf4huUzGqjeRGV9pjrOro
	on3QJ/jrdNJAafgGPcaIkbkONhAwkxyueFqOsiw/HGCTmxUaS4bAHzYST24FAfa+
	9zdR1cEwDDfkCeEAW2Dngel2nmxx8hw9ETapMn1P6GnWejaHYiIK/taETIG4vvt7
	y3y+kUxtECy1UeghFJSKMWVYl+G7mORbmO1S3lRjINpWAwZJeRZLIFXsAs6foFbq
	mxJa7w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2ug48m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 09:52:50 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2eb6d2baso11631616b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 02:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597169; x=1756201969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9i1vfAm82rgoZ9V2Oilt0uKHn0wjU3RD+NnjEoXSuk=;
        b=VXvTULr0gN7gsm/qYV09q01KZnnb/Ndb10XijS4peSIB1KgXMuPZsiJgYN/ODjj4+e
         IlAMsBqhpvi+j2elInf/bi9wcKmk3p0QN1w1KDDHfuQc9b07ijxXXYt5I65wCs8Pe7NJ
         M/HGYkyoBwqtvO1SSoe8s0crJkHay12WhrECM/sjhF89yov3mnNo6t2eOpOIXVOmhXiw
         j79Lt18MR7auOo7Z8o+lPeTxvTPi3LD97SEyBbaMO8D7U4KfsyXmON0atgxKeBwVRVUX
         prMduYjDzYZdsq7ASvT8Yqu2IBDqlzM72k/rTcT2l777ch6kX/c6h+g8FQvNhH4gPyCi
         tS7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDmMh1BgmXzFBtpJ8N5xFl+pMc2J8nULlPsKeKlkN7m2GcsvGKiQWq4sh2r40E6RBwmCyR4JKPHbbtzRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1cpTHOBmUbZzMcpJRJ/Q2+Qc4HjqrylGlInNc3LSS+B1J6blp
	/+Q56Q6gYMribWtquHrN/t0wuoRnygsYI96g6g6DEeO48/PXixazUUs/c2H4+jfWmAmZkUYppo0
	Qf/yiyoCCK7pFTzms/p04FcCylKlIfzjV29+V/R/Zy0+cIwixAykTCSHXNPu7JigOwBE=
X-Gm-Gg: ASbGncvPYDJN4MAxVqh0Py1gCgK0nOlQ+7UqUhIjFjH/iwSxxdKIXQ8EytQYRIBHiCd
	avYUiwq8hQLA1JFuEH/+k2p5lovSKqUiOPPPqF2v2HmuEuqiDPoymDtCsPTy+yiD+u6zaBXX0Ep
	Lqt4CqXsooNa9/Eu1XbXPrOq+juJQy8xjCdwg8ZqVllHHQDyHqDK/JKKBF/sUdqq+QX2LG3hZAs
	0Y0SM1In45hvdtD52jGTYOs/vOKIU5+4RoZidwn0w1G3/eaoJG/s5/2RExLQwlw0iMCeVRUUfAI
	kIYxs8n7ilR7LexjaJTdxNwsfqASmJHdAUI88eF8VJipATRqxkYolZRe8xtrZ0azN2m22vp6Vqj
	FkBfXCGA1gnaoJJA=
X-Received: by 2002:a05:6a00:2d92:b0:749:464a:a77b with SMTP id d2e1a72fcca58-76e8110b9a7mr2657190b3a.18.1755597169328;
        Tue, 19 Aug 2025 02:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC4tqs7L+4L2W8YZBIEHDFL+2B641+2LTpEDdlxuZ6UcLQFj7EEmT07mPHXGjmZaa2PlaE2Q==
X-Received: by 2002:a05:6a00:2d92:b0:749:464a:a77b with SMTP id d2e1a72fcca58-76e8110b9a7mr2657160b3a.18.1755597168884;
        Tue, 19 Aug 2025 02:52:48 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f7cf7sm1998291b3a.69.2025.08.19.02.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:52:48 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 02:52:07 -0700
Subject: [PATCH 3/4] phy: qcom-qmp: pcs: Add v8.50 register offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-glymur_pcie5-v1-3-2ea09f83cbb0@oss.qualcomm.com>
References: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
In-Reply-To: <20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755597163; l=1553;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=CEsoc9Uw7D+NpayVYJqV9+VSyLeR0jKm+hdfLxCWqno=;
 b=cCP3EM2K81GKxTUoliZ2LwnKerOSxnF87MByEs1GnCJZiu7AxmbgjaEIbem8nmuYLGzSaArOY
 cQ8AvnwDpmNBgHxgLQRNSvm9/K1VegVkkJVvVVeDJfraMzIcpS0nFam
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a44972 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=MyfKwbsdfMS_-thd9JUA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -DeVPVFvxKRQ6zX2wZzi9dMSz_pfXO9B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX+xOkNvyMNbsi
 486A4UqemCHBA6sW2gyJl/0RE+cg9lXl9+R+hAVrONsxkeHkhUJVfRoFtoezAsUwwulk6FQaYf1
 TfM6v+dltlkeLzVzntUlsz2TKwvsTuqFzkrXOfwjdExX82m3QDYf8CEiRnxWoURfCtpMjsG1rfX
 90fQ6/7NI7RWOUtfiAJ91x6dhnSbj6IQXa4k1BVCBR5XkWntcTDMvz6LRhul6hl5hSE16ib1Yha
 Y5YFduSI10MAeS2S0ifnQHtzV8QUruCJdRmkeymSU4w1gEKNQrd5xiG9IWq3JpcdUsQPSSP/a0G
 1YLy7HpMqneMt82IXoFUhynBCEYBekV4+yi91296zH8sSTVuSiCp1j1cwZ0j3s9XOD4DYEz2rkJ
 L5uNxv3h
X-Proofpoint-GUID: -DeVPVFvxKRQ6zX2wZzi9dMSz_pfXO9B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

The new Glymur SoC bumps up the HW version of QMP phy to v8.50 for PCIE
g5x4. Add the new PCS offsets in a dedicated header file.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h | 13 +++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h
new file mode 100644
index 0000000000000000000000000000000000000000..325c127e8eb7ad842018dce51d09a6ee54ed86ff
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V8_50_H_
+#define QCOM_PHY_QMP_PCS_V8_50_H_
+
+#define QPHY_V8_50_PCS_STATUS1			0x010
+#define QPHY_V8_50_PCS_START_CONTROL			0x05c
+#define QPHY_V8_50_PCS_POWER_DOWN_CONTROL			0x64
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index f58c82b2dd23e1bda616d67ab7993794b997063b..da2a7ad2cdccef1308a2b7aa71a2e5cf8bd7c1d7 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -58,6 +58,8 @@
 
 #include "phy-qcom-qmp-pcs-v8.h"
 
+#include "phy-qcom-qmp-pcs-v8_50.h"
+
 /* QPHY_SW_RESET bit */
 #define SW_RESET				BIT(0)
 /* QPHY_POWER_DOWN_CONTROL */

-- 
2.34.1


