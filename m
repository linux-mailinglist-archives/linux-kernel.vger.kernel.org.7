Return-Path: <linux-kernel+bounces-831373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C8BB9C7D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBB34A4420
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90EB2D7D2E;
	Wed, 24 Sep 2025 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pKVSJrz8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80A2D5408
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755784; cv=none; b=l+XipO+HKJPP900ZkVZ4Iy9V13hR28I0/aZ3pvGja9ZWeRkBtE5bnDssJOWskR+I3pp4Fngjop4/4cw1IZNszqtQBqb9L5Jmc5ZAJwGwdxL6KWTd6Shug7EK0rUHnvEr/9avXZ2Uc3ojEdF+Tt9763Z/1YuoEIiOaCF37rWwMi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755784; c=relaxed/simple;
	bh=GJyV6ZN3Gm+2y4yM4GyAAJ1xmf5U8usHqzJs/GBirU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFXhBRhw1xmNyt9gAE1f+FiITE3cUtaF2j9n0mRqt8TJd3CMSe2HH7DjkwJDn6IVNvTD97uJaSuuYMiFAGBUAX19YXGld0nYtjhiI4H7vycgdzBglMtM9N2AMnAGgzlDdseYCPV+PTape8OXfc5qYnfaJN1LgIdzHJlMxB/vwk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pKVSJrz8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OChZcU021646
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yXS7d477ZN57UElaZanclycWMqJ7XYwRcXIo+NnpZhM=; b=pKVSJrz8rGxH2bfi
	W6jLpwRl44G/yfjRg6JikpZfZt7aMWDMc+7u0LGQtI6+IFlWZwWcdSxdpnJt1/g9
	a4DQfP7mLmUBPDultl+PiLVcmdmkNlRNqs/McgM/O66/x9JPUJttbyUg+zjj41wv
	B/Pdg4yD+61Ni/8jkZeE3ragkRAm6S8WdOU+DIAwdh39Aw/C1dswO38pKidO/Nwo
	uF5Ujn8Qq3QC1gX/ltuQZGr4xRYp+VyJ0J+dS8p6hRVP/wvZYMxtzZKnak2oEoxi
	gDh1SmG0Moi8ZQAfs2Cl2PejP13TTWSlyF5gqoqWg3nXJf6pKJXYkEKfjC32o23k
	/2lVtw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budadjcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:16:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-26e4fcc744dso2256855ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758755780; x=1759360580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXS7d477ZN57UElaZanclycWMqJ7XYwRcXIo+NnpZhM=;
        b=I2ZAs2jOHk8dkSAv9khkwOYbZN9Jq/rHajMiRMrSsMXZfWGPb8KRR3S89IeIO36fV0
         5AqcgkcXmK0Ihyr4jgyR9mP5D0w65RSzARmBPm/xeUNg11f8JuIc3QPR2PP7Y5BCBAx9
         pp14TTQtRE/L8Pu+ugm/hAMZNDsl1Oc4pgLSy6wtE4sZfP3G+nxNtMYf9aKoFtb/PgTv
         6e7lw4dYE9fUf8VawVBK5A0DvZy0HL31BjCA77hmtQMs5O5vLfkzrcGJEsXvVj4wb5CC
         lLUqHjO+yKsPk6d6woMdMJ9+LT0PcDF6gpmxT1e+QcqOyNXHJpykPkI76Rl/RIl0pl8T
         TJeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVow8fK6X+Y8bELFRkYuskWk2a7wyuedDVxHEPSSB4fk3yXj67S/7goZhZAu4LKmpKPooLG9k9msRupOdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3kOk8igbkFaxrV0DbN7EWorxZH7vhT3/rBtnQM3KNZqR8ddZw
	eaIznTVdYksacTbKljXg6i5Kw4AxX9gKho+5Zq6KszxmHOHSIl1jAnf1WyIA+1cnvwxv41dh/UE
	wwUHtE52ivdV5j268XUR/6mCQTg6bzVaeedPsNEWcyoArpwGGerlpPjt6OBmYiI0e3PU=
X-Gm-Gg: ASbGncsdUQfe+/PxTSZxkKU2s8aTcaMXntrYIbO76TL+WQ7EkMFELuWTa3VjPhYv2y5
	Ez15qZBbGmQostZ/dKKDFC3ZaDNl12Vk9GBm77oN3qdPPBRVPm8gVp7Ax46vByu59aAtZ5TUbNO
	MsRQk5cpQ+pYC4YkmqUiaNU8sAvks9MtUS5hCK7T+2WmBm+/guOaE47a1KFE6dQaq+hLQYk1J5j
	/RVw3431WCXrSKGm+Y3jXGJn4Pz0ZDEZU+9uH1S24agTrRJtmPkNuZYUZEb/hzx6PW3ITuF5/8H
	SVzHRp5KPdwMiKe6cdb9bMnPbbUzgBGyqsJLKyJCmOnbkIuaDZMhpCJY3JN3Szn9zs2bgHClrqE
	=
X-Received: by 2002:a17:903:fb0:b0:248:79d4:93bb with SMTP id d9443c01a7336-27ed4a315aamr15462675ad.31.1758755779465;
        Wed, 24 Sep 2025 16:16:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF40TVYJksRQ4FrvD706NLyeAme35UAOfegEcyPx85JnmrRPMTXY6qkkGrP5Ywap87OPmm9jA==
X-Received: by 2002:a17:903:fb0:b0:248:79d4:93bb with SMTP id d9443c01a7336-27ed4a315aamr15462325ad.31.1758755778872;
        Wed, 24 Sep 2025 16:16:18 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671c156sm3964175ad.50.2025.09.24.16.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:16:18 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 04:44:45 +0530
Subject: [PATCH 7/8] media: iris: Introduce vpu ops for vpu4 with necessary
 hooks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-knp_video-v1-7-e323c0b3c0cd@oss.qualcomm.com>
References: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
In-Reply-To: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758755747; l=14960;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=GJyV6ZN3Gm+2y4yM4GyAAJ1xmf5U8usHqzJs/GBirU0=;
 b=6QbS4hCxKe2/f0y4rrmAwr1i1t+iFuG0rAKZhdKqIxr2G0A02h2DqaUMMBlsmdEgOf+1R9MK6
 QrIjG6Eb9saAkYJwxEk9bNAy1fPAfW5WPIQ8cVrOXB8G95iJiIsyAfU
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-GUID: R3J3SXgZx3tHt-8qJiEvXWebS0WURu91
X-Proofpoint-ORIG-GUID: R3J3SXgZx3tHt-8qJiEvXWebS0WURu91
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d47bc5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=fRD2SM0RS-lxgAn4z9kA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfXxNQu8oI/wkkH
 JV0f4BaOSHFMIpx3eHUGik8LZ57q9MoYNs+A8um7HbReYJHxsKPo9ukmcFjg0IwQcvbWm3oazyr
 qLtzLUjWYr7RqBkQGgRfEvE17+NJJ9TAtJRss+VWczr7DaYSI4TuOq19EIpihpoYqN5LCIJkUTG
 5ENvlNGpYD74Tbaho3FE/kZuQbsdnA47VTYsW4JuCibAUiXhA6suMvIokfRD+O7kip5GdozjXU1
 ccjGzK9pTxZzgkf/Z/vjwK5MIZVx2sxiYBIhJu7fJRd9S5swWb0vETzdBVtAgupDN3igAuTbpLB
 4v+QNJn5BE4qIZzEiPNqh2yVFwm66esPcyhIniNLBW3epYp9E58DpbX/ORjVi6kFiKFUSoUZ9Ly
 m/FHctJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

Add power sequence for vpu4 by reusing from previous generation wherever
possible. Hook up vpu4 op with vpu4 specific implemtation or resue from
earlier generation wherever feasible, like clock calculation in this
case.

Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/Makefile          |   1 +
 .../platform/qcom/iris/iris_platform_common.h      |   7 +
 drivers/media/platform/qcom/iris/iris_vpu4x.c      | 367 +++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
 4 files changed, 376 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/Makefile b/drivers/media/platform/qcom/iris/Makefile
index 13270cd6d899852dded675b33d37f5919b81ccba..1446f5732ab51db85ea4f52636d29e36d82b7a8f 100644
--- a/drivers/media/platform/qcom/iris/Makefile
+++ b/drivers/media/platform/qcom/iris/Makefile
@@ -22,6 +22,7 @@ qcom-iris-objs += iris_buffer.o \
              iris_venc.o \
              iris_vpu2.o \
              iris_vpu3x.o \
+             iris_vpu4x.o \
              iris_vpu_buffer.o \
              iris_vpu_common.o \
 
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index ae49e95ba2252fc1442f7c81d8010dbfd86da0da..d6d4a9fdfc189797f903dfeb56d931741b405ee2 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -54,6 +54,10 @@ enum platform_clk_type {
 	IRIS_AXI1_CLK,
 	IRIS_CTRL_FREERUN_CLK,
 	IRIS_HW_FREERUN_CLK,
+	IRIS_BSE_HW_CLK,
+	IRIS_VPP0_HW_CLK,
+	IRIS_VPP1_HW_CLK,
+	IRIS_APV_HW_CLK,
 };
 
 struct platform_clk_data {
@@ -188,6 +192,9 @@ struct icc_vote_data {
 enum platform_pm_domain_type {
 	IRIS_CTRL_POWER_DOMAIN,
 	IRIS_HW_POWER_DOMAIN,
+	IRIS_VPP0_HW_POWER_DOMAIN,
+	IRIS_VPP1_HW_POWER_DOMAIN,
+	IRIS_APV_HW_POWER_DOMAIN,
 };
 
 struct iris_platform_data {
diff --git a/drivers/media/platform/qcom/iris/iris_vpu4x.c b/drivers/media/platform/qcom/iris/iris_vpu4x.c
new file mode 100644
index 0000000000000000000000000000000000000000..5585ed84d498be057c20927725b02a5409d18867
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/iris_vpu4x.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/iopoll.h>
+#include <linux/reset.h>
+#include "iris_instance.h"
+#include "iris_vpu_common.h"
+#include "iris_vpu_register_defines.h"
+
+#define WRAPPER_EFUSE_MONITOR			(WRAPPER_BASE_OFFS + 0x08)
+#define AON_WRAPPER_MVP_NOC_RESET_SYNCRST	(AON_MVP_NOC_RESET + 0x08)
+#define CPU_CS_APV_BRIDGE_SYNC_RESET		(CPU_BASE_OFFS + 0x174)
+#define DISABLE_VIDEO_APV_BIT			BIT(27)
+#define DISABLE_VIDEO_VPP1_BIT			BIT(28)
+#define DISABLE_VIDEO_VPP0_BIT			BIT(29)
+#define CORE_CLK_HALT				BIT(0)
+#define APV_CLK_HALT				BIT(1)
+#define CORE_PWR_ON				BIT(1)
+
+static int iris_vpu4x_genpd_set_hwmode(struct iris_core *core, bool hw_mode)
+{
+	u32 value = readl(core->reg_base + WRAPPER_EFUSE_MONITOR);
+	int ret;
+
+	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], hw_mode);
+	if (ret)
+		return ret;
+
+	if (!(value & DISABLE_VIDEO_VPP0_BIT)) {
+		ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs
+					      [IRIS_VPP0_HW_POWER_DOMAIN], hw_mode);
+		if (ret)
+			goto restore_hw_domain_mode;
+	}
+
+	if (!(value & DISABLE_VIDEO_VPP1_BIT)) {
+		ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs
+					      [IRIS_VPP1_HW_POWER_DOMAIN], hw_mode);
+		if (ret)
+			goto restore_vpp0_domain_mode;
+	}
+
+	if (!(value & DISABLE_VIDEO_APV_BIT)) {
+		ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs
+					      [IRIS_APV_HW_POWER_DOMAIN], hw_mode);
+		if (ret)
+			goto restore_vpp1_domain_mode;
+	}
+
+	return 0;
+
+restore_vpp1_domain_mode:
+	if (!(value & DISABLE_VIDEO_VPP1_BIT))
+		dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VPP1_HW_POWER_DOMAIN],
+					!hw_mode);
+restore_vpp0_domain_mode:
+	if (!(value & DISABLE_VIDEO_VPP0_BIT))
+		dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_VPP0_HW_POWER_DOMAIN],
+					!hw_mode);
+restore_hw_domain_mode:
+	dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], !hw_mode);
+
+	return ret;
+}
+
+static int iris_vpu4x_power_on_apv(struct iris_core *core)
+{
+	u32 value = readl(core->reg_base + WRAPPER_EFUSE_MONITOR);
+	int ret;
+
+	if (value & DISABLE_VIDEO_APV_BIT)
+		return 0;
+
+	ret = iris_enable_power_domains(core,
+					core->pmdomain_tbl->pd_devs[IRIS_APV_HW_POWER_DOMAIN]);
+	if (ret)
+		return ret;
+
+	ret = iris_prepare_enable_clock(core, IRIS_APV_HW_CLK);
+	if (ret)
+		goto disable_apv_hw_power_domain;
+
+	return 0;
+
+disable_apv_hw_power_domain:
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_APV_HW_POWER_DOMAIN]);
+
+	return ret;
+}
+
+static void iris_vpu4x_power_off_apv(struct iris_core *core)
+{
+	bool handshake_done, handshake_busy;
+	u32 value, count = 0;
+
+	value = readl(core->reg_base + WRAPPER_EFUSE_MONITOR);
+
+	if (value & DISABLE_VIDEO_APV_BIT)
+		return;
+
+	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+
+	if (value & APV_CLK_HALT)
+		writel(0x0, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+
+	do {
+		writel(REQ_POWER_DOWN_PREP, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+		usleep_range(10, 20);
+		value = readl(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS);
+
+		handshake_done = value & NOC_LPI_STATUS_DONE;
+		handshake_busy = value & (NOC_LPI_STATUS_DENY | NOC_LPI_STATUS_ACTIVE);
+
+		if (handshake_done || !handshake_busy)
+			break;
+
+		writel(0x0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+		usleep_range(10, 20);
+
+	} while (++count < 1000);
+
+	if (!handshake_done && handshake_busy)
+		dev_err(core->dev, "LPI handshake timeout\n");
+
+	writel(0x080200, core->reg_base + AON_WRAPPER_MVP_NOC_RESET_REQ);
+	readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_RESET_ACK,
+			   value, value & 0x080200, 200, 2000);
+
+	writel(0x0, core->reg_base + AON_WRAPPER_MVP_NOC_RESET_SYNCRST);
+	writel(0x0, core->reg_base + AON_WRAPPER_MVP_NOC_RESET_REQ);
+	readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_RESET_ACK,
+			   value, value == 0x0, 200, 2000);
+
+	writel(CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base +
+	       CPU_CS_APV_BRIDGE_SYNC_RESET);
+	writel(CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_APV_BRIDGE_SYNC_RESET);
+	writel(0x0, core->reg_base + CPU_CS_APV_BRIDGE_SYNC_RESET);
+
+	iris_disable_unprepare_clock(core, IRIS_APV_HW_CLK);
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_APV_HW_POWER_DOMAIN]);
+}
+
+static void iris_vpu4x_ahb_sync_reset_apv(struct iris_core *core)
+{
+	u32 value = readl(core->reg_base + WRAPPER_EFUSE_MONITOR);
+
+	if (value & DISABLE_VIDEO_APV_BIT)
+		return;
+
+	writel(CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base +
+	       CPU_CS_APV_BRIDGE_SYNC_RESET);
+	writel(CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_APV_BRIDGE_SYNC_RESET);
+	writel(0x0, core->reg_base + CPU_CS_APV_BRIDGE_SYNC_RESET);
+}
+
+static void iris_vpu4x_ahb_sync_reset_hardware(struct iris_core *core)
+{
+	writel(CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base +
+	       CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+}
+
+static int iris_vpu4x_enable_hardware_clocks(struct iris_core *core)
+{
+	u32 value = readl(core->reg_base + WRAPPER_EFUSE_MONITOR);
+	int ret;
+
+	ret = iris_prepare_enable_clock(core, IRIS_AXI_CLK);
+	if (ret)
+		return ret;
+
+	ret = iris_prepare_enable_clock(core, IRIS_HW_FREERUN_CLK);
+	if (ret)
+		goto disable_axi_clock;
+
+	ret = iris_prepare_enable_clock(core, IRIS_HW_CLK);
+	if (ret)
+		goto disable_hw_free_run_clock;
+
+	ret = iris_prepare_enable_clock(core, IRIS_BSE_HW_CLK);
+	if (ret)
+		goto disable_hw_clock;
+
+	if (!(value & DISABLE_VIDEO_VPP0_BIT)) {
+		ret = iris_prepare_enable_clock(core, IRIS_VPP0_HW_CLK);
+		if (ret)
+			goto disable_bse_hw_clock;
+	}
+
+	if (!(value & DISABLE_VIDEO_VPP1_BIT)) {
+		ret = iris_prepare_enable_clock(core, IRIS_VPP1_HW_CLK);
+		if (ret)
+			goto disable_vpp0_hw_clock;
+	}
+
+	return 0;
+
+disable_vpp0_hw_clock:
+	iris_disable_unprepare_clock(core, IRIS_VPP0_HW_CLK);
+disable_bse_hw_clock:
+	iris_disable_unprepare_clock(core, IRIS_BSE_HW_CLK);
+disable_hw_clock:
+	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
+disable_hw_free_run_clock:
+	iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
+disable_axi_clock:
+	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+
+	return ret;
+}
+
+static void iris_vpu4x_disable_hardware_clocks(struct iris_core *core)
+{
+	u32 value = readl(core->reg_base + WRAPPER_EFUSE_MONITOR);
+
+	if (!(value & DISABLE_VIDEO_VPP1_BIT))
+		iris_disable_unprepare_clock(core, IRIS_VPP1_HW_CLK);
+
+	if (!(value & DISABLE_VIDEO_VPP0_BIT))
+		iris_disable_unprepare_clock(core, IRIS_VPP0_HW_CLK);
+
+	iris_disable_unprepare_clock(core, IRIS_BSE_HW_CLK);
+	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
+	iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_CLK);
+}
+
+static int iris_vpu4x_power_on_hardware(struct iris_core *core)
+{
+	u32 value = readl(core->reg_base + WRAPPER_EFUSE_MONITOR);
+	int ret;
+
+	ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+	if (ret)
+		return ret;
+
+	if (!(value & DISABLE_VIDEO_VPP0_BIT)) {
+		ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs
+						[IRIS_VPP0_HW_POWER_DOMAIN]);
+		if (ret)
+			goto disable_hw_power_domain;
+	}
+
+	if (!(value & DISABLE_VIDEO_VPP1_BIT)) {
+		ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs
+						[IRIS_VPP1_HW_POWER_DOMAIN]);
+		if (ret)
+			goto disable_vpp0_power_domain;
+	}
+
+	ret = iris_vpu4x_enable_hardware_clocks(core);
+	if (ret)
+		goto disable_vpp1_power_domain;
+
+	ret = iris_vpu4x_power_on_apv(core);
+	if (ret)
+		goto disable_hw_clocks;
+
+	iris_vpu4x_ahb_sync_reset_apv(core);
+	iris_vpu4x_ahb_sync_reset_hardware(core);
+
+	ret = iris_vpu4x_genpd_set_hwmode(core, true);
+	if (ret)
+		goto disable_apv_power_domain;
+
+	return 0;
+
+disable_apv_power_domain:
+	iris_vpu4x_power_off_apv(core);
+disable_hw_clocks:
+	iris_vpu4x_disable_hardware_clocks(core);
+disable_vpp1_power_domain:
+	if (!(value & DISABLE_VIDEO_VPP1_BIT))
+		iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs
+						[IRIS_VPP1_HW_POWER_DOMAIN]);
+disable_vpp0_power_domain:
+	if (!(value & DISABLE_VIDEO_VPP0_BIT))
+		iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs
+						[IRIS_VPP0_HW_POWER_DOMAIN]);
+disable_hw_power_domain:
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+
+	return ret;
+}
+
+static void iris_vpu4x_power_off_hardware(struct iris_core *core)
+{
+	bool handshake_done, handshake_busy;
+	u32 value, count = 0;
+
+	iris_vpu4x_genpd_set_hwmode(core, false);
+
+	iris_vpu4x_power_off_apv(core);
+
+	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
+
+	if (!(value & CORE_PWR_ON))
+		goto disable_clocks_and_power;
+
+	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+
+	if (value & CORE_CLK_HALT)
+		writel(0x0, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+
+	readl_poll_timeout(core->reg_base + VCODEC_SS_IDLE_STATUSN, value,
+			   value & 0x7103, 2000, 20000);
+
+	do {
+		writel(REQ_POWER_DOWN_PREP, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+		usleep_range(10, 20);
+		value = readl(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS);
+
+		handshake_done = value & NOC_LPI_STATUS_DONE;
+		handshake_busy = value & (NOC_LPI_STATUS_DENY | NOC_LPI_STATUS_ACTIVE);
+
+		if (handshake_done || !handshake_busy)
+			break;
+
+		writel(0x0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+		usleep_range(10, 20);
+
+	} while (++count < 1000);
+
+	if (!handshake_done && handshake_busy)
+		dev_err(core->dev, "LPI handshake timeout\n");
+
+	writel(0x070103, core->reg_base + AON_WRAPPER_MVP_NOC_RESET_REQ);
+	readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_RESET_ACK,
+			   value, value == 0x070103, 200, 2000);
+
+	writel(0x0, core->reg_base + AON_WRAPPER_MVP_NOC_RESET_SYNCRST);
+	writel(0x0, core->reg_base + AON_WRAPPER_MVP_NOC_RESET_REQ);
+	readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_RESET_ACK,
+			   value, value == 0x0, 200, 2000);
+
+	writel(CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base +
+	       CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+
+disable_clocks_and_power:
+	iris_vpu4x_disable_hardware_clocks(core);
+
+	value = readl(core->reg_base + WRAPPER_EFUSE_MONITOR);
+
+	if (!(value & DISABLE_VIDEO_VPP1_BIT))
+		iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs
+					   [IRIS_VPP1_HW_POWER_DOMAIN]);
+
+	if (!(value & DISABLE_VIDEO_VPP0_BIT))
+		iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs
+					   [IRIS_VPP0_HW_POWER_DOMAIN]);
+
+	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
+}
+
+const struct vpu_ops iris_vpu4x_ops = {
+	.power_off_hw = iris_vpu4x_power_off_hardware,
+	.power_on_hw = iris_vpu4x_power_on_hardware,
+	.power_off_controller = iris_vpu35_vpu4x_power_off_controller,
+	.power_on_controller = iris_vpu35_vpu4x_power_on_controller,
+	.program_bootup_registers = iris_vpu35_vpu4x_program_bootup_registers,
+	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
+};
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index 7cf4304604cca590544a938c7e811c202cea3d93..f6dffc613b822341fb21e12de6b1395202f62cde 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -12,6 +12,7 @@ extern const struct vpu_ops iris_vpu2_ops;
 extern const struct vpu_ops iris_vpu3_ops;
 extern const struct vpu_ops iris_vpu33_ops;
 extern const struct vpu_ops iris_vpu35_ops;
+extern const struct vpu_ops iris_vpu4x_ops;
 
 struct vpu_ops {
 	void (*power_off_hw)(struct iris_core *core);

-- 
2.34.1


