Return-Path: <linux-kernel+bounces-824705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B939FB89F3E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CF55A6259
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68E331618F;
	Fri, 19 Sep 2025 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gw6fvg/i"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8B123958A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291986; cv=none; b=O01mnAnN0NCV3qvC9JmmfM4IB6oju1gUlMB+d1C86fY23s2sNVwgEVB7nJ5uZw6JXRDwrmZFA829jYAL1BZBIsYB2slDnb/kNrvJ/7igjoE4mlz3gVzo/Hr42d79GCqHkhZ7eMMwVz030f1zLhIFqQpTvppun7BvCSbvDLBUJRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291986; c=relaxed/simple;
	bh=9bAvRTe4pHKumDqBHXyGKjag3yt86IkWhB06kGaqpSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TY59XTAAEjBwDZA8L/73+x1kWWVNi9y8ApNEavtA8c8ov1C8Ra7YY53fszTpAOgE02a9DW7IZiV+eujTou2evn0j+6XilA5qYUZKeXN7D1beZ7EkT/khT6OEKqpAtHZrByYuHqSWC/ZfxsEqjqK/Ms1bpUHEgQeUxgUEkSdb7ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gw6fvg/i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JAL0HN007089
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DZ7PP8ibNkVQsZQzkQINteuZZCxERw7WGsRgFi9vg64=; b=gw6fvg/iWy7Ie7PM
	XQZ0ZPucGJXPdLWkmD29vQZZzm63ZQrxvOT5rTd/hfDCVJtRZ42HA1yE6t3oQyoa
	HvrkqfTuOhA+xGyuo1uu5Z58dAY9W909JlJAyj064MpNuhulKRVSirZGMXjctdkV
	d+LcoPH+QAdrsB7wKo6akpDAox3bpi9vzYgdAgRkLp+W1z+7hKsGXh0Xa1hhtHnu
	ZhgNqByAnRxL27TdrdPCuM4c6w0NO/rTDfb/NmpEsPRoA+7HHOsAgqZZ7qyQ/qyc
	bdje6Wt9eHTx8AeymZUmiVpf/eIQH/Drm4H2HFbs06Bh1NsJFn6uAZau/V5Wk0uM
	lP3Fsg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498ebew6wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:26:23 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-267f099ca68so4542905ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:26:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758291983; x=1758896783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZ7PP8ibNkVQsZQzkQINteuZZCxERw7WGsRgFi9vg64=;
        b=GaPFVzLKvm9I8quvf0UCbwHN1Hr9HqQ5mK1V50xL7AJ9oDSypOuBOQaB8bpA1RIQXY
         8zE/0eaIoxeBQ7ohUpxEIHXbZ2WNJZH/HL24nROwILNng/o6i5pnm6s+JOkOU9BMjo1y
         Xmg6wp+5pvOyQoDhB1rWsi2/eAZzwM1WW7HCXYEmTxFCs5zWqMybDDdqc52jXCxeDHrB
         SKNErLYtvNj5bobqIrCunujdtOnwGTn6XdGiJBn8uVHnrHijQ2RBuVkSwsCeQIUUg9y1
         m/AlMbYXEAUCd1y+B/HekcaiejbvVRX3VZ7KTgVPXIFAcbCGOKVi7aw4I4r/EKBdN15j
         r7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpDq222ijIQChJnKzjN6GE6rQtb76nSGKU0O14/f2O5kybW5vdIJdku9NQiTkXHl3sQuRxYZBkyXMvgUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEoh2xuwUazu4jds9wzB+tv9ckCxZ+CrsN3cSb6EhxR7rUzdel
	JCNidm0FpdNpek5OGI7qr9+dod0iMG8d4g+mrH2chkR2/rDpSNFlLLjBFbsUb6NEZnnqmuZ6HrR
	cIusHw2PfmTuOqwa+3Qg3umIOhreXFSQ8I+sfzv/p9fI4MyLGGXZf+GOXBkjJ699ENb8=
X-Gm-Gg: ASbGncsggl3BXxEcIvq32DOftly89gkXWN4j+Cqbl6ufU2Gi/0uJZPM1QTttQ+aoodr
	V6mbE4ts2pSjSj7ltFSLa1Uxj6jz392KtYn/BqPK1pw6Ak600Bi4FKe0xaP5Evy1fhSHcTIDE3b
	EZRRcvhIKN/8yu+TOtMQ7VBdFtJs6DwRvqoG346JtEERvWB42Wf8AcM45uoOACqDhzmfLcGuTMr
	Tx9n5jdSj/YKSZ1LuZRaQfR0+Rwi2M0wn2vjbQJ5Q1oDpNw86dG3pU9Mhd59JZR1eIOroDkuNgB
	0UYH5yXlvrQFa4563p46Coasxx/eYR7wuxXEkiZ/2xZFZmhcaInTVx60TJd5rbQJFAeCH+5MJRG
	kloOusLp2Tr7SaQ==
X-Received: by 2002:a17:902:d512:b0:269:7840:de09 with SMTP id d9443c01a7336-269ba57f179mr27329615ad.10.1758291982657;
        Fri, 19 Sep 2025 07:26:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFamCakWXgW1foNIY/ZCz4E5TCGvcrNLin2BnCydK9REGNvU/DXibWuS22Ml4NESyTA1+/5Ig==
X-Received: by 2002:a17:902:d512:b0:269:7840:de09 with SMTP id d9443c01a7336-269ba57f179mr27329305ad.10.1758291982129;
        Fri, 19 Sep 2025 07:26:22 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26e80409ee3sm2210035ad.80.2025.09.19.07.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:26:21 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Fri, 19 Sep 2025 22:24:28 +0800
Subject: [PATCH v5 11/14] phy: qcom: qmp: Add DP v2 PHY register
 definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-add-displayport-support-for-qcs615-platform-v5-11-eae6681f4002@oss.qualcomm.com>
References: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
In-Reply-To: <20250919-add-displayport-support-for-qcs615-platform-v5-0-eae6681f4002@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        li.liu@oss.qualcomm.com,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758291895; l=10494;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=9bAvRTe4pHKumDqBHXyGKjag3yt86IkWhB06kGaqpSE=;
 b=tync5LM7/BSSHy0HgEIBWHyrN6nflPXepHScAHV/jN/GU0be7lfkPtXdFTht0YW8rzApfsCJ/
 +4Z2DUc/3OhA72kKupe6uyer/qA7LukTOfYVsVNzN/bVxrvVVKyn70x
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-ORIG-GUID: k4DnzRW3KiaNEwwVEFm0uVvjRhi9ukJk
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cd680f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7JoLr56Aoq0vruZkpkIA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: k4DnzRW3KiaNEwwVEFm0uVvjRhi9ukJk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfX+PhDkfrNHw+T
 W4ES0d/wuDCr8d5XLY20mccxGw5ZuOeGuZe9DoCL7UvwBXOLlsoTUAG7eJO5rgihi1yYrqRzrK+
 JqVH6yDgUBuzu1j5qAvc4DLBv/ejVHl+XJ6hHvQY5Gk/kS828j4ZXCWwVBP3jAll8QZR3A4Ym05
 6fcYhBRfnz7+B1dygNN6Sp7B24kqSFr54i/vVkwvmIu/r7WpHkVfIPHGHSjRuT7KX6xSByXO17n
 /RqWDx1y1beNFg0DXFHtisv24qIbETgfUYjfp8626ONMMANXR4duQRbGme9He5mF9VGWkKRXboA
 eQ1LtVw7CADtd4+6ekd14ibkKImYPsWZIej58L1sZGsUE5Vd6E6Kt+e16pCQLNpJ3gyiY4kt2v0
 ocXNgRnu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074

Add dedicated headers for DP v2 PHY, including QSERDES COM and TX/RX
register definitions.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v2.h      |  21 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v2.h | 106 +++++++++++++++++++++
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v2.h    |  68 +++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   3 +
 4 files changed, 198 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v2.h b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v2.h
new file mode 100644
index 0000000000000000000000000000000000000000..8b9572d3cdebb70a0f3811f129a40aa78e184638
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-dp-phy-v2.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_DP_PHY_V2_H_
+#define QCOM_PHY_QMP_DP_PHY_V2_H_
+
+// /* Only for QMP V2 PHY - DP PHY registers */
+#define QSERDES_V2_DP_PHY_AUX_INTERRUPT_MASK		0x048
+#define QSERDES_V2_DP_PHY_AUX_INTERRUPT_CLEAR		0x04c
+#define QSERDES_V2_DP_PHY_AUX_BIST_CFG			0x050
+
+#define QSERDES_V2_DP_PHY_VCO_DIV			0x068
+#define QSERDES_V2_DP_PHY_TX0_TX1_LANE_CTL		0x06c
+#define QSERDES_V2_DP_PHY_TX2_TX3_LANE_CTL		0x088
+
+#define QSERDES_V2_DP_PHY_SPARE0			0x0ac
+#define QSERDES_V2_DP_PHY_STATUS			0x0c0
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v2.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v2.h
new file mode 100644
index 0000000000000000000000000000000000000000..3ea1884f35dd50a0bde9b213f193ac8ac6b77612
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v2.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_COM_V2_H_
+#define QCOM_PHY_QMP_QSERDES_COM_V2_H_
+
+/* Only for QMP V2 PHY - QSERDES COM registers */
+#define QSERDES_V2_COM_ATB_SEL1				0x000
+#define QSERDES_V2_COM_ATB_SEL2				0x004
+#define QSERDES_V2_COM_FREQ_UPDATE			0x008
+#define QSERDES_V2_COM_BG_TIMER				0x00c
+#define QSERDES_V2_COM_SSC_EN_CENTER			0x010
+#define QSERDES_V2_COM_SSC_ADJ_PER1			0x014
+#define QSERDES_V2_COM_SSC_ADJ_PER2			0x018
+#define QSERDES_V2_COM_SSC_PER1				0x01c
+#define QSERDES_V2_COM_SSC_PER2				0x020
+#define QSERDES_V2_COM_SSC_STEP_SIZE1			0x024
+#define QSERDES_V2_COM_SSC_STEP_SIZE2			0x028
+#define QSERDES_V2_COM_POST_DIV				0x02c
+#define QSERDES_V2_COM_POST_DIV_MUX			0x030
+#define QSERDES_V2_COM_BIAS_EN_CLKBUFLR_EN		0x034
+#define QSERDES_V2_COM_CLK_ENABLE1			0x038
+#define QSERDES_V2_COM_SYS_CLK_CTRL			0x03c
+#define QSERDES_V2_COM_SYSCLK_BUF_ENABLE		0x040
+#define QSERDES_V2_COM_PLL_EN				0x044
+#define QSERDES_V2_COM_PLL_IVCO				0x048
+#define QSERDES_V2_COM_LOCK_CMP1_MODE0			0x04c
+#define QSERDES_V2_COM_LOCK_CMP2_MODE0			0x050
+#define QSERDES_V2_COM_LOCK_CMP3_MODE0			0x054
+#define QSERDES_V2_COM_LOCK_CMP1_MODE1			0x058
+#define QSERDES_V2_COM_LOCK_CMP2_MODE1			0x05c
+#define QSERDES_V2_COM_LOCK_CMP3_MODE1			0x060
+#define QSERDES_V2_COM_EP_CLOCK_DETECT_CTR		0x068
+#define QSERDES_V2_COM_SYSCLK_DET_COMP_STATUS		0x06c
+#define QSERDES_V2_COM_CLK_EP_DIV			0x074
+#define QSERDES_V2_COM_CP_CTRL_MODE0			0x078
+#define QSERDES_V2_COM_CP_CTRL_MODE1			0x07c
+#define QSERDES_V2_COM_PLL_RCTRL_MODE0			0x084
+#define QSERDES_V2_COM_PLL_RCTRL_MODE1			0x088
+#define QSERDES_V2_COM_PLL_CCTRL_MODE0			0x090
+#define QSERDES_V2_COM_PLL_CCTRL_MODE1			0x094
+#define QSERDES_V2_COM_PLL_CNTRL			0x09c
+#define QSERDES_V2_COM_BIAS_EN_CTRL_BY_PSM		0x0a8
+#define QSERDES_V2_COM_SYSCLK_EN_SEL			0x0ac
+#define QSERDES_V2_COM_CML_SYSCLK_SEL			0x0b0
+#define QSERDES_V2_COM_RESETSM_CNTRL			0x0b4
+#define QSERDES_V2_COM_RESETSM_CNTRL2			0x0b8
+#define QSERDES_V2_COM_LOCK_CMP_EN			0x0c8
+#define QSERDES_V2_COM_LOCK_CMP_CFG			0x0cc
+#define QSERDES_V2_COM_DEC_START_MODE0			0x0d0
+#define QSERDES_V2_COM_DEC_START_MODE1			0x0d4
+#define QSERDES_V2_COM_VCOCAL_DEADMAN_CTRL		0x0d8
+#define QSERDES_V2_COM_DIV_FRAC_START1_MODE0		0x0dc
+#define QSERDES_V2_COM_DIV_FRAC_START2_MODE0		0x0e0
+#define QSERDES_V2_COM_DIV_FRAC_START3_MODE0		0x0e4
+#define QSERDES_V2_COM_DIV_FRAC_START1_MODE1		0x0e8
+#define QSERDES_V2_COM_DIV_FRAC_START2_MODE1		0x0ec
+#define QSERDES_V2_COM_DIV_FRAC_START3_MODE1		0x0f0
+#define QSERDES_V2_COM_VCO_TUNE_MINVAL1			0x0f4
+#define QSERDES_V2_COM_VCO_TUNE_MINVAL2			0x0f8
+#define QSERDES_V2_COM_INTEGLOOP_INITVAL		0x100
+#define QSERDES_V2_COM_INTEGLOOP_EN			0x104
+#define QSERDES_V2_COM_INTEGLOOP_GAIN0_MODE0		0x108
+#define QSERDES_V2_COM_INTEGLOOP_GAIN1_MODE0		0x10c
+#define QSERDES_V2_COM_INTEGLOOP_GAIN0_MODE1		0x110
+#define QSERDES_V2_COM_INTEGLOOP_GAIN1_MODE1		0x114
+#define QSERDES_V2_COM_VCO_TUNE_MAXVAL1			0x118
+#define QSERDES_V2_COM_VCO_TUNE_MAXVAL2			0x11c
+#define QSERDES_V2_COM_VCO_TUNE_CTRL			0x124
+#define QSERDES_V2_COM_VCO_TUNE_MAP			0x128
+#define QSERDES_V2_COM_VCO_TUNE1_MODE0			0x12c
+#define QSERDES_V2_COM_VCO_TUNE2_MODE0			0x130
+#define QSERDES_V2_COM_VCO_TUNE1_MODE1			0x134
+#define QSERDES_V2_COM_VCO_TUNE2_MODE1			0x138
+#define QSERDES_V2_COM_VCO_TUNE_INITVAL1		0x13c
+#define QSERDES_V2_COM_VCO_TUNE_INITVAL2		0x140
+#define QSERDES_V2_COM_VCO_TUNE_TIMER1			0x144
+#define QSERDES_V2_COM_VCO_TUNE_TIMER2			0x148
+#define QSERDES_V2_COM_CMN_STATUS			0x15c
+#define QSERDES_V2_COM_RESET_SM_STATUS			0x160
+#define QSERDES_V2_COM_RESTRIM_CODE_STATUS		0x164
+#define QSERDES_V2_COM_PLLCAL_CODE1_STATUS		0x168
+#define QSERDES_V2_COM_PLLCAL_CODE2_STATUS		0x16c
+#define QSERDES_V2_COM_CLK_SELECT			0x174
+#define QSERDES_V2_COM_HSCLK_SEL			0x178
+#define QSERDES_V2_COM_INTEGLOOP_BINCODE_STATUS		0x17c
+#define QSERDES_V2_COM_PLL_ANALOG			0x180
+#define QSERDES_V2_COM_CORECLK_DIV			0x184
+#define QSERDES_V2_COM_SW_RESET				0x188
+#define QSERDES_V2_COM_CORE_CLK_EN			0x18c
+#define QSERDES_V2_COM_C_READY_STATUS			0x190
+#define QSERDES_V2_COM_CMN_CONFIG			0x194
+#define QSERDES_V2_COM_CMN_RATE_OVERRIDE		0x198
+#define QSERDES_V2_COM_SVS_MODE_CLK_SEL			0x19c
+#define QSERDES_V2_COM_DEBUG_BUS0			0x1a0
+#define QSERDES_V2_COM_DEBUG_BUS1			0x1a4
+#define QSERDES_V2_COM_DEBUG_BUS2			0x1a8
+#define QSERDES_V2_COM_DEBUG_BUS3			0x1ac
+#define QSERDES_V2_COM_DEBUG_BUS_SEL			0x1b0
+#define QSERDES_V2_COM_CMN_MISC1			0x1b4
+#define QSERDES_V2_COM_CMN_MISC2			0x1b8
+#define QSERDES_V2_COM_CORECLK_DIV_MODE1		0x1bc
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v2.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v2.h
new file mode 100644
index 0000000000000000000000000000000000000000..34919720b7bc457ae9549e7c53864be01a27a9b3
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v2.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_V2_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_V2_H_
+
+/* Only for QMP V2 PHY - TX registers */
+#define QSERDES_V2_TX_BIST_MODE_LANENO			0x000
+#define QSERDES_V2_TX_CLKBUF_ENABLE			0x008
+#define QSERDES_V2_TX_TX_EMP_POST1_LVL			0x00c
+#define QSERDES_V2_TX_TX_DRV_LVL			0x01c
+#define QSERDES_V2_TX_RESET_TSYNC_EN			0x024
+#define QSERDES_V2_TX_PRE_STALL_LDO_BOOST_EN		0x028
+#define QSERDES_V2_TX_TX_BAND				0x02c
+#define QSERDES_V2_TX_SLEW_CNTL				0x030
+#define QSERDES_V2_TX_INTERFACE_SELECT			0x034
+#define QSERDES_V2_TX_RES_CODE_LANE_TX			0x03c
+#define QSERDES_V2_TX_RES_CODE_LANE_RX			0x040
+#define QSERDES_V2_TX_RES_CODE_LANE_OFFSET_TX		0x044
+#define QSERDES_V2_TX_RES_CODE_LANE_OFFSET_RX		0x048
+#define QSERDES_V2_TX_DEBUG_BUS_SEL			0x058
+#define QSERDES_V2_TX_TRANSCEIVER_BIAS_EN		0x05c
+#define QSERDES_V2_TX_HIGHZ_DRVR_EN			0x060
+#define QSERDES_V2_TX_TX_POL_INV			0x064
+#define QSERDES_V2_TX_PARRATE_REC_DETECT_IDLE_EN	0x068
+#define QSERDES_V2_TX_LANE_MODE_1			0x08c
+#define QSERDES_V2_TX_LANE_MODE_2			0x090
+#define QSERDES_V2_TX_LANE_MODE_3			0x094
+#define QSERDES_V2_TX_RCV_DETECT_LVL_2			0x0a4
+#define QSERDES_V2_TX_TRAN_DRVR_EMP_EN			0x0c0
+#define QSERDES_V2_TX_TX_INTERFACE_MODE			0x0c4
+#define QSERDES_V2_TX_VMODE_CTRL1			0x0f0
+
+/* Only for QMP V2 PHY - RX registers */
+#define QSERDES_V2_RX_UCDR_FO_GAIN			0x008
+#define QSERDES_V2_RX_UCDR_SO_GAIN_HALF			0x00c
+#define QSERDES_V2_RX_UCDR_SO_GAIN			0x014
+#define QSERDES_V2_RX_UCDR_SVS_SO_GAIN_HALF		0x024
+#define QSERDES_V2_RX_UCDR_SVS_SO_GAIN_QUARTER		0x028
+#define QSERDES_V2_RX_UCDR_SVS_SO_GAIN			0x02c
+#define QSERDES_V2_RX_UCDR_FASTLOCK_FO_GAIN		0x030
+#define QSERDES_V2_RX_UCDR_SO_SATURATION_AND_ENABLE	0x034
+#define QSERDES_V2_RX_UCDR_FASTLOCK_COUNT_LOW		0x03c
+#define QSERDES_V2_RX_UCDR_FASTLOCK_COUNT_HIGH		0x040
+#define QSERDES_V2_RX_UCDR_PI_CONTROLS			0x044
+#define QSERDES_V2_RX_RX_TERM_BW			0x07c
+#define QSERDES_V2_RX_VGA_CAL_CNTRL1			0x0bc
+#define QSERDES_V2_RX_VGA_CAL_CNTRL2			0x0c0
+#define QSERDES_V2_RX_RX_EQ_GAIN2_LSB			0x0c8
+#define QSERDES_V2_RX_RX_EQ_GAIN2_MSB			0x0cc
+#define QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL1		0x0d0
+#define QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL2		0x0d4
+#define QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL3		0x0d8
+#define QSERDES_V2_RX_RX_EQU_ADAPTOR_CNTRL4		0x0dc
+#define QSERDES_V2_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1	0x0f8
+#define QSERDES_V2_RX_RX_OFFSET_ADAPTOR_CNTRL2		0x0fc
+#define QSERDES_V2_RX_SIGDET_ENABLES			0x100
+#define QSERDES_V2_RX_SIGDET_CNTRL			0x104
+#define QSERDES_V2_RX_SIGDET_LVL			0x108
+#define QSERDES_V2_RX_SIGDET_DEGLITCH_CNTRL		0x10c
+#define QSERDES_V2_RX_RX_BAND				0x110
+#define QSERDES_V2_RX_RX_INTERFACE_MODE			0x11c
+#define QSERDES_V2_RX_RX_MODE_00			0x164
+#define QSERDES_V2_RX_RX_MODE_01			0x168
+
+#endif
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
index f58c82b2dd23e1bda616d67ab7993794b997063b..1a9e4cc5aa11d6e18d97ce93d0e44c9a5afa3fbf 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.h
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
@@ -9,6 +9,9 @@
 #include "phy-qcom-qmp-qserdes-com.h"
 #include "phy-qcom-qmp-qserdes-txrx.h"
 
+#include "phy-qcom-qmp-qserdes-com-v2.h"
+#include "phy-qcom-qmp-qserdes-txrx-v2.h"
+
 #include "phy-qcom-qmp-qserdes-com-v3.h"
 #include "phy-qcom-qmp-qserdes-txrx-v3.h"
 

-- 
2.34.1


