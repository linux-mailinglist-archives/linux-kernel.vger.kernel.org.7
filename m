Return-Path: <linux-kernel+bounces-831483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B72B9CCCD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197544A1013
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED6A221FBB;
	Thu, 25 Sep 2025 00:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LlJXksB2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DA81D63F0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758591; cv=none; b=Nrslah4oN8IF6KHgEfxm2PYwSUJriId0oAXBk3DC/zfyX+Pn3+Usv8XOWzuI5Z5TUy0SGb9LNvQ79zNrZhKYhwSYgd0nl5kUNz1t73rzi4xPXFPfF5w9KBeapMY3fKDqycsxEkJKCZdKaglg0duj/q5oICL9AFliFOkWRVZaFAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758591; c=relaxed/simple;
	bh=JS9uHtOoOGa8nRBwNAg0ISo/0rAu3+heineuvZf7kCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ezATYJCQVTGyNoonpbnt0ZjFP1Iq+HyPgvFmRsE1K3oLqL2770PU8+JeNikIe1M7l6cCbAQxlN7v6hOMVjrlLGitkcXFW9EzEkG15jeM5+AsbDBLwvNBhvmwKPI3fMec7z+SmnI0A/3Um6ihuyPDjBF22vdfTQuC3REspEcpA/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LlJXksB2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCO0Sq021670
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ehGl0kAqIC/jubrumhOw1Qof9MwcscPxikUNZlQngrE=; b=LlJXksB2i4FBb4vp
	fdQZ15Gu6to8bSQ07U6/b84vu0dnsRndWfXjRtuFOVmjgFFqHYNqf8WHBvSuiHet
	WHAY0co3z03OBBsu9s+7LxF/xeVuYeaX3KtH/2oiAI0l6jAzfNBe+1OaUlrzYxaH
	gruHGLdud69D3rjnvzgIkrCBKv5MrFPdBI/BpvB8CRDwhtVS2mXQ3xKF1ev28lM4
	icQIOTdXXvKIR3CtcPppfEzJUOi+gVOmrdRsqvZLPvrqHHBVqsUuYN1d7ZHE/BC7
	W7MXs1bX6ZUq/z3nBh7QyrbfpaYTcrPbhl/7Q14FHq2F0vaXgrp2JXhK2VOREzg9
	JYO80w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budadntr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:03:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-272b7bdf41fso3825095ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758585; x=1759363385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehGl0kAqIC/jubrumhOw1Qof9MwcscPxikUNZlQngrE=;
        b=Ddtrd9QgDO6X48ucxuMz2NZ4996KHaIQAnirpAnDZ+uDsHwwYn9bBfNcMAZDLxxRtU
         67n2IknKPis92v7UNhOiLjrp6zIvo8Ae/MsConcDEUcudSVOrJJsx5V+RBQIvU6cv5Da
         2+IIJmnr3ac4EhnLf4ECGhOjuarb2soMy08HDaV/cLQ/YX19XIvAP3f4y+8ti8xJecSx
         cTdhgyza4+kdDaQPAU4/gWrh0CnHKA2QV8jb8m1phx9BFLVGk4S3vB+J3I9UUxKlYvi0
         CS6TQv+PaeXQ1JNoAjgV8bo+p7xW67a0hBfOpOyVLrXEffFNOGNB11BRRUjw2sFlov/j
         djLA==
X-Forwarded-Encrypted: i=1; AJvYcCXsP005YFHOyMlT21AjJtzMkKWm/mo7rxPA4bwvcD1csOuaGhRjLxQQ0Xhfgz2vXfYoFnh3fydqZKpO7J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBOyO0sA75kJoX+i3Zp7vFvv3oPkMYeoFY/C092nR8sdoz//65
	Q68D3rySfCfNOOA/pgcKsuGMIh2dcpbpkFl15Ff3XoaCOT0nv5VWZlnzK9D04/EjVxNBB24Q45k
	6+NFcSURbyulX+3Qeel+A/20iDgdwjDxmU/1+AK74vgyN5evGULJaUBwDTE1HQTE5B9Y=
X-Gm-Gg: ASbGncsWJLfM3o0ZO4Ex1+kJU54F4Ctv06F5fCN99SWg8VhYFTtP4KYPSKPzK8Gd5Q4
	LNvl4bxVp/cNxZwU8weffisHMbKUw74/jJG2at6hdVZbMf9ItegMAcDXLGb547/jyDFKFzWu/gU
	Zz0olCjGJ7RrT9mpzUmXbfiHyRgs5DlrONaKPwruRk3TGytxmh2TD0zW0V5HIatRFK+4UmXP6+l
	WOPAahdd+FxkxAoSPmrJMipXYzFFdtIfTYHDW1qOZ9gPYRQNcwv3Zry09wh6OTSinak3nb1sNZv
	YLvAUBSR6cXvh3aSi1IzMq0WRyo8MABzLZKeBF1IlnrEsEgaUvYMuTxKxBFm8reSWU9+9PgEQuw
	Q0QLRQky17jzqQPA=
X-Received: by 2002:a17:903:28f:b0:24c:f589:661 with SMTP id d9443c01a7336-27ed49b9de9mr17666955ad.11.1758758584391;
        Wed, 24 Sep 2025 17:03:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECJaFd7OeZX5rxO+Xawz9gdkUpytjQstEmFdJB2Bzkxry7J4LaCeVz1YXECkJn+NaYtL+S6A==
X-Received: by 2002:a17:903:28f:b0:24c:f589:661 with SMTP id d9443c01a7336-27ed49b9de9mr17666405ad.11.1758758583871;
        Wed, 24 Sep 2025 17:03:03 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6715f0esm4807215ad.52.2025.09.24.17.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:03:03 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 17:02:52 -0700
Subject: [PATCH 5/6] media: qcom: camss: csid: Add support for CSID 1080
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-cam-v1-5-b72d6deea054@oss.qualcomm.com>
References: <20250924-knp-cam-v1-0-b72d6deea054@oss.qualcomm.com>
In-Reply-To: <20250924-knp-cam-v1-0-b72d6deea054@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758758574; l=18651;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=U797SC/uDXqhbuqvid87XM7bIucT34PgKVhSf6U28Uk=;
 b=Edfv+ZtdwX/r2gfFf3X1ZaWxON+uI29uNrwffla0T02MU934smBzCyaFZPOPdeMX7egEOTHKI
 VnxeUSqQIhrDPaQ/zTMRhyfxvfk3sJ4pUoofGQomB8Zyqh3YVEmHMgB
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: JdtQmktpIhHGzxUOL4V1N4_GvFAtoo17
X-Proofpoint-ORIG-GUID: JdtQmktpIhHGzxUOL4V1N4_GvFAtoo17
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d486ba cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=LuqqMTSZzEZb0Svt8lwA:9
 a=4Q4zU7iZy6iiv8wZ:21 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfXw+3T8/r56Uhw
 wgE22tB/RcgVhtyCCp+gDsNgoCWvVWksQzhfn6mlN5abXxJ1O7XgwiV9ZZ1Z0+J77fS9G5LTezE
 wLZle1N1+eYz8/QWVX3IC5nxAVLARb69AK7lL4jIiQny5uvugRMKWkFbudwqNheNxa5IFpofS+G
 E9eNE244AVbAGdS+YDZ68Faja6Xb6+tas6nJ6c4k3GPdsYbD92V1yiffOfGW+kKvH5Lhsy7H0JG
 kx9QoNukBcktljxSxeFo40HXvAD/2kPHx8TTLLpLQ6UkiOcfv8/PdJEQxykBqxL08ReGAZb/EZ2
 8bFgxaEVgEk+Yjf04YlgstQ9UU5Isd7OUtv7RhyUA/EGYejn6kwqTZVgJkr4aEbFkOzrqkw6Ko0
 gRwcZm1P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Add more detailed resource information for CSID devices along with the
driver for CSID 1080 that is responsible for CSID register
configuration, module reset and IRQ handling for BUF_DONE events.

In this CSID version, RUP and AUP update values are split into two
registers along with a SET register. Accordingly , enhance the CSID
interface to accommodate both the legacy combined reg_update and the
split RUP and AUP updates.

Co-developed-by: Atiya Kailany <atiya.kailany@oss.qualcomm.com>
Signed-off-by: Atiya Kailany <atiya.kailany@oss.qualcomm.com>
Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/media/platform/qcom/camss/Makefile         |   1 +
 .../media/platform/qcom/camss/camss-csid-1080.c    | 379 +++++++++++++++++++++
 .../media/platform/qcom/camss/camss-csid-1080.h    |  25 ++
 drivers/media/platform/qcom/camss/camss-csid.h     |   9 +-
 drivers/media/platform/qcom/camss/camss.c          |  80 +++++
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 6 files changed, 494 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
index 23960d02877d..3a7ed4f5a004 100644
--- a/drivers/media/platform/qcom/camss/Makefile
+++ b/drivers/media/platform/qcom/camss/Makefile
@@ -8,6 +8,7 @@ qcom-camss-objs += \
 		camss-csid-4-7.o \
 		camss-csid-340.o \
 		camss-csid-680.o \
+		camss-csid-1080.o \
 		camss-csid-gen2.o \
 		camss-csid-gen3.o \
 		camss-csiphy-2ph-1-0.o \
diff --git a/drivers/media/platform/qcom/camss/camss-csid-1080.c b/drivers/media/platform/qcom/camss/camss-csid-1080.c
new file mode 100644
index 000000000000..ab5944d4ff34
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-csid-1080.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * camss-csid-1080.c
+ *
+ * Qualcomm MSM Camera Subsystem - CSID (CSI Decoder) Module
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/types.h>
+#include <linux/v4l2-controls.h>
+#include "camss.h"
+#include "camss-csid.h"
+#include "camss-csid-1080.h"
+
+/* Reset and Command Registers */
+#define CSID_RST_CFG				0x108
+#define		RST_MODE				BIT(0)
+#define		RST_LOCATION				BIT(4)
+
+/* Reset and Command Registers */
+#define CSID_RST_CMD				0x10C
+#define		SELECT_HW_RST				BIT(0)
+#define		SELECT_IRQ_RST				BIT(2)
+#define CSID_IRQ_CMD				0x110
+#define		IRQ_CMD_CLEAR				BIT(0)
+
+/* Register Update Commands, RUP/AUP */
+#define CSID_RUP_CMD				0x114
+#define		RUP_RDIN				BIT(8)
+#define CSID_AUP_CMD				0x118
+#define		AUP_RDIN				BIT(8)
+#define CSID_RUP_AUP_CMD			0x11C
+#define		RUP_SET					BIT(0)
+#define		MUP					BIT(4)
+
+/* Top level interrupt registers */
+#define CSID_TOP_IRQ_STATUS			0x180
+#define CSID_TOP_IRQ_MASK			0x184
+#define CSID_TOP_IRQ_CLEAR			0x188
+#define CSID_TOP_IRQ_SET			0x18C
+#define		INFO_RST_DONE				BIT(0)
+#define		CSI2_RX_IRQ_STATUS			BIT(2)
+#define		BUF_DONE_IRQ_STATUS			BIT(3)
+#define		RDIn_IRQ_STATUS_OFFSET			16
+#define		TOP_IRQ_STATUS_2			BIT(31)
+
+/* Buffer done interrupt registers */
+#define CSID_BUF_DONE_IRQ_STATUS		0x1A0
+#define		BUF_DONE_IRQ_STATUS_RDI_OFFSET		16
+#define CSID_BUF_DONE_IRQ_MASK			0x1A4
+#define CSID_BUF_DONE_IRQ_CLEAR			0x1A8
+#define CSID_BUF_DONE_IRQ_SET			0x1AC
+
+/* CSI2 RX interrupt registers */
+#define CSID_CSI2_RX_IRQ_STATUS			0x1B0
+#define CSID_CSI2_RX_IRQ_MASK			0x1B4
+#define CSID_CSI2_RX_IRQ_CLEAR			0x1B8
+#define CSID_CSI2_RX_IRQ_SET			0x1BC
+
+/* CSI2 RX Configuration */
+#define CSID_CSI2_RX_CFG0			0x880
+#define		CSI2_RX_CFG0_NUM_ACTIVE_LANES		0
+#define		CSI2_RX_CFG0_DL0_INPUT_SEL		4
+#define		CSI2_RX_CFG0_PHY_NUM_SEL		20
+#define CSID_CSI2_RX_CFG1			0x884
+#define		CSI2_RX_CFG1_ECC_CORRECTION_EN		BIT(0)
+#define		CSI2_RX_CFG1_VC_MODE			BIT(2)
+
+/* CSIPHY to hardware PHY selector mapping */
+#define CSID_CSIPHY_ID_BASE_OFFSET		1
+
+#define MSM_CSID_MAX_SRC_STREAMS_1080		(csid_is_lite(csid) ? 4 : 5)
+
+/* RDI Configuration */
+#define CSID_RDI_CFG0(rdi) \
+	((csid_is_lite(csid) ? 0x3080 : 0x5480) + 0x200 * (rdi))
+#define		RDI_CFG0_RETIME_BS			BIT(5)
+#define		RDI_CFG0_TIMESTAMP_EN			BIT(6)
+#define		RDI_CFG0_TIMESTAMP_STB_SEL		BIT(8)
+#define		RDI_CFG0_DECODE_FORMAT			12
+#define		RDI_CFG0_DT				16
+#define		RDI_CFG0_VC				22
+#define		RDI_CFG0_EN				BIT(31)
+
+/* RDI Control and Configuration */
+#define CSID_RDI_CTRL(rdi) \
+	((csid_is_lite(csid) ? 0x3088 : 0x5488) + 0x200 * (rdi))
+#define		RDI_CTRL_START_CMD			BIT(0)
+
+#define CSID_RDI_CFG1(rdi) \
+	((csid_is_lite(csid) ? 0x3094 : 0x5494) + 0x200 * (rdi))
+#define		RDI_CFG1_DROP_H_EN			BIT(5)
+#define		RDI_CFG1_DROP_V_EN			BIT(6)
+#define		RDI_CFG1_CROP_H_EN			BIT(7)
+#define		RDI_CFG1_CROP_V_EN			BIT(8)
+#define		RDI_CFG1_PACKING_FORMAT_MIPI		BIT(15)
+
+/* RDI Pixel Store Configuration */
+#define CSID_RDI_PIX_STORE_CFG0(rdi)		(0x5498 + 0x200 * (rdi))
+#define		RDI_PIX_STORE_CFG0_EN			BIT(0)
+#define		RDI_PIX_STORE_CFG0_MIN_HBI		1
+
+/* RDI IRQ Status in wrapper */
+#define CSID_RDIN_IRQ_STATUS(rdi)		(0x224 + (0x10 * (rdi)))
+#define CSID_RDIN_IRQ_MASK(rdi)			(0x228 + (0x10 * (rdi)))
+#define CSID_RDIN_IRQ_CLEAR(rdi)		(0x22C + (0x10 * (rdi)))
+#define		INFO_RUP_DONE				BIT(23)
+
+static void __csid_aup_rup_trigger(struct csid_device *csid)
+{
+	/* trigger SET in combined register */
+	writel(RUP_SET, csid->base + CSID_RUP_AUP_CMD);
+}
+
+static void __csid_aup_update(struct csid_device *csid, int port_id)
+{
+	csid->aup_update |= AUP_RDIN << port_id;
+	writel(csid->aup_update, csid->base + CSID_AUP_CMD);
+
+	__csid_aup_rup_trigger(csid);
+}
+
+static void __csid_reg_update(struct csid_device *csid, int port_id)
+{
+	csid->rup_update |= RUP_RDIN << port_id;
+	writel(csid->rup_update, csid->base + CSID_RUP_CMD);
+
+	__csid_aup_rup_trigger(csid);
+}
+
+static void __csid_configure_rx(struct csid_device *csid,
+				struct csid_phy_config *phy)
+{
+	int val;
+
+	val = (phy->lane_cnt - 1) << CSI2_RX_CFG0_NUM_ACTIVE_LANES;
+	val |= phy->lane_assign << CSI2_RX_CFG0_DL0_INPUT_SEL;
+	val |= (phy->csiphy_id + CSID_CSIPHY_ID_BASE_OFFSET)
+	       << CSI2_RX_CFG0_PHY_NUM_SEL;
+	writel(val, csid->base + CSID_CSI2_RX_CFG0);
+
+	val = CSI2_RX_CFG1_ECC_CORRECTION_EN;
+	writel(val, csid->base + CSID_CSI2_RX_CFG1);
+}
+
+static void __csid_configure_rx_vc(struct csid_device *csid,
+				   struct csid_phy_config *phy, int vc)
+{
+	int val;
+
+	if (vc > 3) {
+		val = readl(csid->base + CSID_CSI2_RX_CFG1);
+		val |= CSI2_RX_CFG1_VC_MODE;
+		writel(val, csid->base + CSID_CSI2_RX_CFG1);
+	}
+}
+
+static void __csid_ctrl_rdi(struct csid_device *csid, int enable, u8 rdi)
+{
+	int val = 0;
+
+	if (enable)
+		val = RDI_CTRL_START_CMD;
+
+	writel(val, csid->base + CSID_RDI_CTRL(rdi));
+}
+
+static void __csid_configure_rdi_pix_store(struct csid_device *csid, u8 rdi)
+{
+	u32 val;
+
+	/* Configure pixel store to allow absorption of hblanking or idle time.
+	 * This helps with horizontal crop and prevents line buffer conflicts.
+	 * Reset state is 0x8 which has MIN_HBI=4, we keep the default MIN_HBI
+	 * and just enable the pixel store functionality.
+	 */
+	val = (4 << RDI_PIX_STORE_CFG0_MIN_HBI) | RDI_PIX_STORE_CFG0_EN;
+	writel(val, csid->base + CSID_RDI_PIX_STORE_CFG0(rdi));
+}
+
+static void __csid_configure_rdi_stream(struct csid_device *csid, u8 enable, u8 vc)
+{
+	u32 val;
+	u8 lane_cnt = csid->phy.lane_cnt;
+
+	/* Source pads matching RDI channels on hardware.
+	 * E.g. Pad 1 -> RDI0, Pad 2 -> RDI1, etc.
+	 */
+	struct v4l2_mbus_framefmt *input_format = &csid->fmt[MSM_CSID_PAD_FIRST_SRC + vc];
+	const struct csid_format_info *format = csid_get_fmt_entry(csid->res->formats->formats,
+								   csid->res->formats->nformats,
+								   input_format->code);
+
+	if (!lane_cnt)
+		lane_cnt = 4;
+
+	val = RDI_CFG0_TIMESTAMP_EN;
+	val |= RDI_CFG0_TIMESTAMP_STB_SEL;
+	val |= RDI_CFG0_RETIME_BS;
+
+	/* note: for non-RDI path, this should be format->decode_format */
+	val |= DECODE_FORMAT_PAYLOAD_ONLY << RDI_CFG0_DECODE_FORMAT;
+	val |= vc << RDI_CFG0_VC;
+	val |= format->data_type << RDI_CFG0_DT;
+	writel(val, csid->base + CSID_RDI_CFG0(vc));
+
+	val = RDI_CFG1_PACKING_FORMAT_MIPI;
+	writel(val, csid->base + CSID_RDI_CFG1(vc));
+
+	/* Configure pixel store using dedicated register in 1080 */
+	if (!csid_is_lite(csid))
+		__csid_configure_rdi_pix_store(csid, vc);
+
+	val = 0;
+	writel(val, csid->base + CSID_RDI_CTRL(vc));
+
+	val = readl(csid->base + CSID_RDI_CFG0(vc));
+
+	if (enable)
+		val |= RDI_CFG0_EN;
+
+	writel(val, csid->base + CSID_RDI_CFG0(vc));
+}
+
+static void csid_configure_stream_1080(struct csid_device *csid, u8 enable)
+{
+	u8 i;
+	u8 vc;
+
+	__csid_configure_rx(csid, &csid->phy);
+
+	for (vc = 0; vc < MSM_CSID_MAX_SRC_STREAMS_1080; vc++) {
+		if (csid->phy.en_vc & BIT(vc)) {
+			__csid_configure_rdi_stream(csid, enable, vc);
+			__csid_configure_rx_vc(csid, &csid->phy, vc);
+
+			for (i = 0; i < CAMSS_INIT_BUF_COUNT; i++)
+				__csid_aup_update(csid, vc);
+
+			__csid_reg_update(csid, vc);
+
+			__csid_ctrl_rdi(csid, enable, vc);
+		}
+	}
+}
+
+static int csid_configure_testgen_pattern_1080(struct csid_device *csid,
+					       s32 val)
+{
+	return 0;
+}
+
+static void csid_subdev_reg_update_1080(struct csid_device *csid, int port_id,
+					bool clear)
+{
+	/* No explicit clear required */
+	if (!clear)
+		__csid_aup_update(csid, port_id);
+}
+
+/**
+ * csid_isr - CSID module interrupt service routine
+ * @irq: Interrupt line
+ * @dev: CSID device
+ *
+ * Return IRQ_HANDLED on success
+ */
+static irqreturn_t csid_isr_1080(int irq, void *dev)
+{
+	struct csid_device *csid = dev;
+	u32 val, buf_done_val;
+	u8 reset_done;
+	int i;
+
+	val = readl(csid->base + CSID_TOP_IRQ_STATUS);
+	writel(val, csid->base + CSID_TOP_IRQ_CLEAR);
+
+	reset_done = val & INFO_RST_DONE;
+
+	buf_done_val = readl(csid->base + CSID_BUF_DONE_IRQ_STATUS);
+	writel(buf_done_val, csid->base + CSID_BUF_DONE_IRQ_CLEAR);
+
+	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS_1080; i++)
+		if (csid->phy.en_vc & BIT(i)) {
+			val = readl(csid->base + CSID_RDIN_IRQ_STATUS(i));
+			writel(val, csid->base + CSID_RDIN_IRQ_CLEAR(i));
+
+			if (buf_done_val & BIT(BUF_DONE_IRQ_STATUS_RDI_OFFSET + i)) {
+				/*
+				 * buf done and RUP IRQ have been moved to CSID from VFE.
+				 * Once CSID received buf done, need notify VFE of this
+				 * event and trigger VFE to handle buf done process.
+				 */
+				camss_buf_done(csid->camss, csid->id, i);
+			}
+		}
+
+	val = IRQ_CMD_CLEAR;
+	writel(val, csid->base + CSID_IRQ_CMD);
+
+	if (reset_done)
+		complete(&csid->reset_complete);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * csid_reset - Trigger reset on CSID module and wait to complete
+ * @csid: CSID device
+ *
+ * Return 0 on success or a negative error code otherwise
+ */
+static int csid_reset_1080(struct csid_device *csid)
+{
+	unsigned long time;
+	u32 val;
+	int i;
+
+	reinit_completion(&csid->reset_complete);
+
+	val = INFO_RST_DONE | BUF_DONE_IRQ_STATUS;
+	writel(val, csid->base + CSID_TOP_IRQ_CLEAR);
+	writel(val, csid->base + CSID_TOP_IRQ_MASK);
+
+	val = 0;
+	for (i = 0; i < MSM_CSID_MAX_SRC_STREAMS_1080; i++) {
+		if (csid->phy.en_vc & BIT(i)) {
+			/* only need to clear Buffer Done IRQ Status here,
+			 * RUP Done IRQ Status will be cleared once isr
+			 * strobe generated by CSID_RST_CMD
+			 */
+			val |= BIT(BUF_DONE_IRQ_STATUS_RDI_OFFSET + i);
+		}
+	}
+	writel(val, csid->base + CSID_BUF_DONE_IRQ_CLEAR);
+	writel(val, csid->base + CSID_BUF_DONE_IRQ_MASK);
+
+	/* Clear all IRQ status with CLEAR bits set */
+	val = IRQ_CMD_CLEAR;
+	writel(val, csid->base + CSID_IRQ_CMD);
+
+	val = RST_LOCATION | RST_MODE;
+	writel(val, csid->base + CSID_RST_CFG);
+
+	val = SELECT_HW_RST | SELECT_IRQ_RST;
+	writel(val, csid->base + CSID_RST_CMD);
+
+	time = wait_for_completion_timeout(&csid->reset_complete,
+					   msecs_to_jiffies(CSID_RESET_TIMEOUT_MS));
+
+	if (!time) {
+		dev_err(csid->camss->dev, "CSID reset timeout\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void csid_subdev_init_1080(struct csid_device *csid)
+{
+	csid->testgen.nmodes = CSID_PAYLOAD_MODE_DISABLED;
+}
+
+const struct csid_hw_ops csid_ops_1080 = {
+	.configure_stream = csid_configure_stream_1080,
+	.configure_testgen_pattern = csid_configure_testgen_pattern_1080,
+	.hw_version = csid_hw_version,
+	.isr = csid_isr_1080,
+	.reset = csid_reset_1080,
+	.src_pad_code = csid_src_pad_code,
+	.subdev_init = csid_subdev_init_1080,
+	.reg_update = csid_subdev_reg_update_1080,
+};
diff --git a/drivers/media/platform/qcom/camss/camss-csid-1080.h b/drivers/media/platform/qcom/camss/camss-csid-1080.h
new file mode 100644
index 000000000000..f526f3168e33
--- /dev/null
+++ b/drivers/media/platform/qcom/camss/camss-csid-1080.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * camss-csid-1080.h
+ *
+ * Qualcomm MSM Camera Subsystem - CSID (CSI Decoder) Module Generation 3
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef __QC_MSM_CAMSS_CSID_1080_H__
+#define __QC_MSM_CAMSS_CSID_1080_H__
+
+#define DECODE_FORMAT_UNCOMPRESSED_8_BIT	0x1
+#define DECODE_FORMAT_UNCOMPRESSED_10_BIT	0x2
+#define DECODE_FORMAT_UNCOMPRESSED_12_BIT	0x3
+#define DECODE_FORMAT_UNCOMPRESSED_14_BIT	0x4
+#define DECODE_FORMAT_UNCOMPRESSED_16_BIT	0x5
+#define DECODE_FORMAT_UNCOMPRESSED_20_BIT	0x6
+#define DECODE_FORMAT_UNCOMPRESSED_24_BIT	0x7
+#define DECODE_FORMAT_PAYLOAD_ONLY		0xf
+
+#define PLAIN_FORMAT_PLAIN8	0x0 /* supports DPCM, UNCOMPRESSED_6/8_BIT */
+#define PLAIN_FORMAT_PLAIN16	0x1 /* supports DPCM, UNCOMPRESSED_10/16_BIT */
+#define PLAIN_FORMAT_PLAIN32	0x2 /* supports UNCOMPRESSED_20_BIT */
+
+#endif /* __QC_MSM_CAMSS_CSID_1080_H__ */
diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
index aedc96ed84b2..465f05590679 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.h
+++ b/drivers/media/platform/qcom/camss/camss-csid.h
@@ -154,7 +154,13 @@ struct csid_device {
 	void __iomem *base;
 	u32 irq;
 	char irq_name[30];
-	u32 reg_update;
+	union {
+		u32 reg_update;
+		struct {
+			u32 rup_update;
+			u32 aup_update;
+		};
+	};
 	struct camss_clock *clock;
 	int nclocks;
 	struct regulator_bulk_data *supplies;
@@ -215,6 +221,7 @@ extern const struct csid_hw_ops csid_ops_4_1;
 extern const struct csid_hw_ops csid_ops_4_7;
 extern const struct csid_hw_ops csid_ops_340;
 extern const struct csid_hw_ops csid_ops_680;
+extern const struct csid_hw_ops csid_ops_1080;
 extern const struct csid_hw_ops csid_ops_gen2;
 extern const struct csid_hw_ops csid_ops_gen3;
 
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 542122fba825..74a8ad3cb728 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -139,6 +139,84 @@ static const struct camss_subdev_resources csiphy_res_kaanapali[] = {
 	},
 };
 
+static const struct camss_subdev_resources csid_res_kaanapali[] = {
+	/* CSID0 */
+	{
+		.regulators = {},
+		.clock = { "csid", "csid_csiphy_rx" },
+		.clock_rate = { { 400000000, 480000000 },
+				{ 400000000, 480000000 } },
+		.reg = { "csid0" },
+		.interrupt = { "csid0" },
+		.csid = {
+			.is_lite = false,
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.hw_ops = &csid_ops_1080,
+			.formats = &csid_formats_gen2
+		}
+	},
+	/* CSID1 */
+	{
+		.regulators = {},
+		.clock = { "csid", "csid_csiphy_rx" },
+		.clock_rate = { { 400000000, 480000000 },
+				{ 400000000, 480000000 } },
+		.reg = { "csid1" },
+		.interrupt = { "csid1" },
+		.csid = {
+			.is_lite = false,
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.hw_ops = &csid_ops_1080,
+			.formats = &csid_formats_gen2
+		}
+	},
+	/* CSID2 */
+	{
+		.regulators = {},
+		.clock = { "csid", "csid_csiphy_rx" },
+		.clock_rate = { { 400000000, 480000000 },
+				{ 400000000, 480000000 } },
+		.reg = { "csid2" },
+		.interrupt = { "csid2" },
+		.csid = {
+			.is_lite = false,
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.hw_ops = &csid_ops_1080,
+			.formats = &csid_formats_gen2
+		}
+	},
+	/* CSID_LITE0 */
+	{
+		.regulators = {},
+		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx" },
+		.clock_rate = { { 400000000, 480000000 },
+				{ 400000000, 480000000 } },
+		.reg = { "csid_lite0" },
+		.interrupt = { "csid_lite0" },
+		.csid = {
+			.is_lite = true,
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.hw_ops = &csid_ops_1080,
+			.formats = &csid_formats_gen2
+		}
+	},
+	/* CSID_LITE1 */
+	{
+		.regulators = {},
+		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx" },
+		.clock_rate = { { 400000000, 480000000 },
+				{ 400000000, 480000000 } },
+		.reg = { "csid_lite1" },
+		.interrupt = { "csid_lite1" },
+		.csid = {
+			.is_lite = true,
+			.parent_dev_ops = &vfe_parent_dev_ops,
+			.hw_ops = &csid_ops_1080,
+			.formats = &csid_formats_gen2
+		}
+	}
+};
+
 static const struct resources_icc icc_res_kaanapali[] = {
 	/* Based on 4096 x 3072 30 FPS 2496 Mbps mode */
 	{
@@ -4414,9 +4492,11 @@ static const struct camss_resources kaanapali_resources = {
 	.version = CAMSS_KAANAPALI,
 	.pd_name = "top",
 	.csiphy_res = csiphy_res_kaanapali,
+	.csid_res = csid_res_kaanapali,
 	.icc_res = icc_res_kaanapali,
 	.icc_path_num = ARRAY_SIZE(icc_res_kaanapali),
 	.csiphy_num = ARRAY_SIZE(csiphy_res_kaanapali),
+	.csid_num = ARRAY_SIZE(csid_res_kaanapali),
 };
 
 static const struct camss_resources msm8916_resources = {
diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index 9fc9e04b9dab..876cd2a64cbe 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -41,6 +41,7 @@
 	(to_camss_index(ptr_module, index)->dev)
 
 #define CAMSS_RES_MAX 17
+#define CAMSS_INIT_BUF_COUNT 2
 
 struct camss_subdev_resources {
 	char *regulators[CAMSS_RES_MAX];

-- 
2.25.1


