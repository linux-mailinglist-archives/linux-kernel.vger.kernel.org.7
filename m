Return-Path: <linux-kernel+bounces-779463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2076B2F470
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C74AA4CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A542F5480;
	Thu, 21 Aug 2025 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LsUHAyw6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92EE2F49E8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769498; cv=none; b=Hwx1Lp01CbmwmDmUipaL80kcjszx06t7NRzcgZrF1W+7xzniwkKQG4m0EcolL2MCyMZpSMuxvBcEkTviS9A+4GkmiUY7YI5goA7LfdGK3gMrgLsQbrloL2yMasmP2HZsTPFQI0VAiAQWZ9jv5wPDppd3/pRrI1Yz/D5qCiKOfTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769498; c=relaxed/simple;
	bh=lBG66nnuOJFNmGnwQUg3oad4X8eRl166WJOjEf0Foug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f5Tjysf0p4LbmduTA7HMrY8OvK/F/4DKcOV9IP0cp2EWHQL4vOu7YgdrJAD+ptYZt17+dwLvPjP5DnthB8OSkwshKy26puhAO58i4QpELrWluf0dG+tTqGl90k89RufZxOGkg5vFlaQgXHkzHawkpwdtoqtCZgcUAonY7dRxM5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LsUHAyw6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9c2rP032661
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a9i1vfAm82rgoZ9V2Oilt0uKHn0wjU3RD+NnjEoXSuk=; b=LsUHAyw663VDyvgw
	6hU+Tfxa4w6s9fRIRKweCr4GiXH80eBBJ9Bf+tkcdcbZMNMuQw0ffT9zL/rg5oPc
	oPXlICfVkoH5gmWNI7g4AYE0ebqFiWW9yj29eXEiHObvkR/VCMQG2OmlZ69Odu+s
	KBOYOhs8FO0ek3yCQn/8Zp8//pT7O0/WcC4gi9Xf7mrTUMRU1S13SsaDfrXhX7on
	XyXj8nsJQGghhHtUWbzz1bSiwVYGJA6/JWMgo75dbLYNwUm3y/9P+bkW22VmD4J2
	j+xJo/GA28SpFZXvtNKn9XIAvLvu3XFoECmYeh1Us/CaXBWwhWLqN23mfs7qakX/
	giZ/ew==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52a51k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:44:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-324e349ef5fso960918a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769495; x=1756374295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a9i1vfAm82rgoZ9V2Oilt0uKHn0wjU3RD+NnjEoXSuk=;
        b=PQteIALbrMg/YV0ytz/qoWN/kAgvN170zT6YPJpxYbCUiNQxv84l2fh8bsCZ8gpPLb
         U24vUdpUdLTOHS4rT890yxwwS/eRWN5uujgfWgyKUaCwQhps7rxuI0cuqqMJ275GCQh+
         ozSLooVF4clmyh+JDvAAjVxBKroQx5DQyqQXTUDcOcrA5D96gVL20zZeXPTE7JWpG7xp
         99Kc5rvVeOdHeb4x3vu1v7NgF46664iUUjVo7S3UK6RbR2r9vwrcHldagDsaMrMfPv7I
         vVm72SbkuxX32rjEh5nA7rUj3+LO5FiCEXS35hoGU7trBcx8vrkrCpQFyTCuwloiwpNS
         94CA==
X-Forwarded-Encrypted: i=1; AJvYcCVgu0T0DfCvtobfEwTaQgnxWIqT+0JNMSTRtMR79qEu9NR28aXdfNaS1baxfzfqm5MxulDkdONJzmM4wus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWrzDW8o8Og0zw0u3lLHcSr4w9iX5NNiMG4nmigB0528eBhI0J
	Tw8HM0ej8srxAPeBgLU34diArKMAhU7hdES0ABCRCI13KmY2SdttxKkDfj9d7X2megLCAmgTnEN
	/J41YJyoX9ma/eO9g8DjOjUTC240Vii2Tx7kibvkuywy9mxgFV4IJXbUSRCFUyNI8VgI=
X-Gm-Gg: ASbGnctoQAQR8Dtk5MSy6QMUUyU9j+FiK15tPUAbPjfokWl9E6zqn03j8fgvFuSGVV3
	n0x+on6PWHRKfMZ+E7qlqUiDKgu79hIhOJ7kUYMAEpg5yCooqPFO3oeXhj6RgwKrRHm6klvvIDa
	4G35APIt88vIPTxiEg9EVhfbM7804Xhrht3Ixo9TRgpocB/gZUWQo875uzRpjdv4/a/DBntSu75
	Z45SPNy0vv+gK20fQyIQLFf2U6Mz2k7NXvMLlno7p5qWu5LLmgDt6NJY0s2HfRPuJ+1ev/NtLKo
	BRGN31sE8DVINeYJH5b5fAJG9V02BtpwHxgDA6bKkacxY1k7K/l8g4S4Bsk4fpvUU66g7BQkJ02
	v8QN832o49lkRjGo=
X-Received: by 2002:a17:90b:3d0b:b0:31f:150:e045 with SMTP id 98e67ed59e1d1-324ed14d319mr2542958a91.32.1755769495239;
        Thu, 21 Aug 2025 02:44:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRoJdDy4f53/5MRAxjQmWCtc8r3H6iQcImfkai5Qm5nFjXBy+NCdaiygW2u5ZN218HxKSEuA==
X-Received: by 2002:a17:90b:3d0b:b0:31f:150:e045 with SMTP id 98e67ed59e1d1-324ed14d319mr2542919a91.32.1755769494740;
        Thu, 21 Aug 2025 02:44:54 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f23d853esm1426078a91.6.2025.08.21.02.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:44:54 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 02:44:30 -0700
Subject: [PATCH v2 3/4] phy: qcom-qmp: pcs: Add v8.50 register offsets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-glymur_pcie5-v2-3-cd516784ef20@oss.qualcomm.com>
References: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
In-Reply-To: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755769489; l=1553;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=CEsoc9Uw7D+NpayVYJqV9+VSyLeR0jKm+hdfLxCWqno=;
 b=lso13Snwiz7sIs/lgG1JBsAqGdMPm1uxTQ11YbFaIz1M2jjvuN3ug9TxxYUmyJv+ppEAylVzI
 qGK9YQgB4TYAcZlnXvdVLQYefqGYL4BKPwypMegWWuRYwoCYkBoHeIh
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Authority-Analysis: v=2.4 cv=feD0C0QF c=1 sm=1 tr=0 ts=68a6ea98 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=MyfKwbsdfMS_-thd9JUA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: E0n-l_G5gX7tI_8nRdOCaVVp51pFfJu0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXyC4VSohNtwIM
 orr8n3YdtIRJF0DL61bnlRL86/sR9L/3aCAq3yo/WduJiRDVlwQozC+Kr78i4Xhu4dDsyTiDcpj
 uI4WzSE6p/XeOP7LlxxKA+yhfyi/0Ifo89J9WfD1zDuGtgyQi8kcncp6BNX3VebBgQTEFZFdEKz
 NF7b/BlEvcLsJS3EuIeYIXF70CMeEOml6xk2D7IVHbIwE5BYuxjnA7mdsINDnnn4Nn9F/Q3r/ja
 U/nYrx0RmPhr6FZHiXUj+pQ8QJpZyWYhDmCsDSBIj9cVdiIJqKaBje7IGfZXwR7aIJOTxGg8fg1
 Vjqr/vHFxpuLr2uH6YxsQoPijhmbGWBrB6RPRODnB0QgQEeow9+PreF90k21S51X/FBAB76DCpL
 XlBQ9K0Jjo5mgZdSYqA5bV+aKmRtuA==
X-Proofpoint-GUID: E0n-l_G5gX7tI_8nRdOCaVVp51pFfJu0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

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


