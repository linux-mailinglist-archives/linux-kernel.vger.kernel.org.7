Return-Path: <linux-kernel+bounces-781278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF91B3105E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C950F3AEDBD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2E02EA741;
	Fri, 22 Aug 2025 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JZTLG8Ud"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F321B2E9EBE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755847637; cv=none; b=YITNOUA605dmg9EJ2DCUQpm+0ItUpa3nPGcHRZrZm1hZoFL6HXpzqbtSqxjqh6hx8j8FLYZSqu/qd3zYpszL3mwWyf2XkDAK+nasA3s+/BphFzicU1iC+Jj90ThHin+r5gyjTxJrmxRF25V5PjAyGln6Q0Ry4uazQW+xHKc4EzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755847637; c=relaxed/simple;
	bh=zRF/SWKg7J8zSJMhgoR7B0BpUTYTZqskWOwFGNr7t0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lgtSX9YYZLbHPV/hcDeF++W2SZcdiASWSAW4Hn0tUF9m0oliPGX9nukDUSvjBk+qcXMi+UblQRmOreH33Nm5OHX7X4qT8j7W6pS1iD0gpcTR898y7AAAdzW0qxdTuiSRgFGFwd12swZC4LT50I1ujzzJ14T3vDwTYH+m/OR+iIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JZTLG8Ud; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M6uShX018783
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sLkMtTr2Bn5
	K4bQdcvBu5RXJWEJPuqmisraPjRoHi84=; b=JZTLG8UdvEGhrXgafJghaE6AEqz
	KW55gyrCFst3Dkb30kMhwcH2RTRQBMGwO0Q0CrIdytViNa+cqappP4w8mfH/g4gz
	OYsIHDJKMKlLpthKIAkopTa17fT73C3AhTYieIIOsUTbocIzF0aFN9Ivl03r2KDS
	ofUNn/USOsRMASyUIfFkMPssqSyiD6EpEvHNHisce3+0WYn71xvR3lsx5kqCxVER
	kzanZv7iwaX+SC4iJJwSgJfHIIFwMNhDqpVesbZ7izj/VdwnrTkYQzJ2acB/1TNC
	J7bDrHlWCMr2BohPQm092sV+aP3P8ILA7x/g/MPWeNNDSu2jNvC7azY8EnQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52b03p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:27:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-324e349ef5fso2095734a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755847634; x=1756452434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sLkMtTr2Bn5K4bQdcvBu5RXJWEJPuqmisraPjRoHi84=;
        b=Sdz/iKmBRMJG+YfK5n4wK2PfK3UDZqCSMzgFIHL7w5JyUvHBmkvN1UZakphMcj55FX
         dl2JAmXQg1gWQ+YtCL5ao3CXFzZihzDxZ5cwRVxWDUlQV9caT8sFG7W5ga7cqnvPO0Jf
         uRt2aR+bQEOtBDMxAlxL8bTmVhCAMIWtBbrIXKtN2hZtdFG4cQLh7JD6DqFUzsJArgRi
         m2N0x9f2fKXr6ertATdZLzN7bdPD9a2Bx9CegAEDBJZ5G7RsP/8WWRKbausy1ddlKalw
         TXV2BouKcFVucusOr2G6GesgfVp+1j4fbvXe/ZW9Dc83L23VeGoM93hEQZGlijxlrIat
         gexQ==
X-Forwarded-Encrypted: i=1; AJvYcCU09YuZ3Mr7UIVI+Sh5fNlwlbv1aAhQFIpg/0Ye7lH+qU2P9PKiJcS7Pyi7tNrUKeNUvsIbElQhAHFUCGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAgdT9IWn1uFBaJMejrmVgJxJVRrvjttV14PC7PQTkcDirSp7i
	cpMiW4AFhtJfm3ZHKfcIEYvTmFinklotZRJb+tVynQWUrpgQboj27e1phYZG40w2jTl1PhbLDpF
	Ktls+LXqvqLoyrNyy5JJl0biRZDyP2M09a2Xsy5b5yYpJpOCkpt8ZYhHYr0G9kTeWdl4=
X-Gm-Gg: ASbGncuh2kTjvp+da5sXcw3vmunWv/NxkrmRH3X8l0JPETRtO3C05xEyWD6UN+7soDo
	XOHNYVG2PCUrJUayPvxlbH0u3ogVW7FTI6ZcO5XJXiNUX59MpCW7jDqX/2xhaxd3s7CviETnrWB
	qtc+fOwGslskA2KVnAUFC1MO5GWPplXRd+EBqKms8sqdnSZLaKt41gb+duB6mw3qvEq8wSFlE8q
	MFhdQ+l17TJI6qj8s5xZ/KQ8eXDZfH0eLOk0loPJd0IVGolLSfkH16/Unw3c+wpx1U8DvBTPLlV
	uSCYMYN7Z6RMJpBHKqikPPukLNrAhaFkGG8patAxsEkhwEAF8fd/j1/4GtZ26ykNCgk1YCWxCut
	K
X-Received: by 2002:a17:90b:55c7:b0:321:1680:e056 with SMTP id 98e67ed59e1d1-32515e36b50mr2995201a91.9.1755847633547;
        Fri, 22 Aug 2025 00:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsnvfjM+sJnS56KF2zpncH91f2aO5DeQUnn9KXd7VBs1w3xVslfyycQjtQYddBs5i+aAOL0g==
X-Received: by 2002:a17:90b:55c7:b0:321:1680:e056 with SMTP id 98e67ed59e1d1-32515e36b50mr2995158a91.9.1755847632922;
        Fri, 22 Aug 2025 00:27:12 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fe3047sm6416367a12.17.2025.08.22.00.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 00:27:12 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, broonie@kernel.org,
        johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v6 2/6] soc: qcom: geni-se: Cleanup register defines and update copyright
Date: Fri, 22 Aug 2025 12:56:47 +0530
Message-Id: <20250822072651.510027-3-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822072651.510027-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250822072651.510027-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX0SKoEHlsH/5v
 mOsOrpjGxO/SKuphd7yTvShxZZ8ZkVP0aBygRqWAv46Deh8mVwN0sZ+zEGzQqrejyd6cV00ax7W
 NB3UU6mmjt5Wf1WswsIH288CJojckxC7cPeaVUESFNX84KA9KmepuYxpon+JUXPxgxESdZKUXQe
 377oXEeC6Mb1O+b6W9d+zxbGeicfHsJvZpcnWibaJDCx6GBX7FRmfk0SiezIV4we0l0mZ09gg61
 JTkkl6Ku7czjkSwmZ82U9AqcFc5P3vkZXN8SANLbJhgRUqxEofhiJFaDyxz1BcRyUHpSOagWn6y
 v6cdytiFH29QoyaS+AA1V8CXXZApZizSTSsBK+4Ya4OVNwM6OGuoQlFQzJlFdYN10lIjR+dnHQ5
 w1VA7IzeB4g8CF5Fu2qbnF+iBpTFTg==
X-Authority-Analysis: v=2.4 cv=TIIci1la c=1 sm=1 tr=0 ts=68a81bd2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=cWaLTDLleWsxmrQceUoA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: A5qYhAd1JhDWFwDo7nhWaz3_MbAstMJv
X-Proofpoint-GUID: A5qYhAd1JhDWFwDo7nhWaz3_MbAstMJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Refactor register macros for consistency and clarity and remove redundant
definitions and update naming for better alignment.
Update copyright to include Qualcomm Technologies, Inc.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 3c3b796333a6..e8ab2833815e 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
+/*
+ *  Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
+ *  Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
 
 /* Disable MMIO tracing to prevent excessive logging of unwanted MMIO traces */
 #define __DISABLE_TRACE_MMIO__
@@ -110,22 +113,20 @@ struct geni_se_desc {
 static const char * const icc_path_names[] = {"qup-core", "qup-config",
 						"qup-memory"};
 
-#define QUP_HW_VER_REG			0x4
+/* Common QUPV3 registers */
+#define QUPV3_HW_VER_REG		0x4
 
 /* Common SE registers */
-#define GENI_INIT_CFG_REVISION		0x0
-#define GENI_S_INIT_CFG_REVISION	0x4
-#define GENI_OUTPUT_CTRL		0x24
-#define GENI_CGC_CTRL			0x28
-#define GENI_CLK_CTRL_RO		0x60
-#define GENI_FW_S_REVISION_RO		0x6c
+#define SE_GENI_INIT_CFG_REVISION	0x0
+#define SE_GENI_S_INIT_CFG_REVISION	0x4
+#define SE_GENI_CGC_CTRL		0x28
+#define SE_GENI_CLK_CTRL_RO		0x60
+#define SE_GENI_FW_S_REVISION_RO	0x6c
 #define SE_GENI_BYTE_GRAN		0x254
 #define SE_GENI_TX_PACKING_CFG0		0x260
 #define SE_GENI_TX_PACKING_CFG1		0x264
 #define SE_GENI_RX_PACKING_CFG0		0x284
 #define SE_GENI_RX_PACKING_CFG1		0x288
-#define SE_GENI_M_GP_LENGTH		0x910
-#define SE_GENI_S_GP_LENGTH		0x914
 #define SE_DMA_TX_PTR_L			0xc30
 #define SE_DMA_TX_PTR_H			0xc34
 #define SE_DMA_TX_ATTR			0xc38
@@ -142,7 +143,6 @@ static const char * const icc_path_names[] = {"qup-core", "qup-config",
 #define SE_DMA_RX_IRQ_EN		0xd48
 #define SE_DMA_RX_IRQ_EN_SET		0xd4c
 #define SE_DMA_RX_IRQ_EN_CLR		0xd50
-#define SE_DMA_RX_LEN_IN		0xd54
 #define SE_DMA_RX_MAX_BURST		0xd5c
 #define SE_DMA_RX_FLUSH			0xd60
 #define SE_GSI_EVENT_EN			0xe18
@@ -179,7 +179,7 @@ static const char * const icc_path_names[] = {"qup-core", "qup-config",
 /* SE_DMA_GENERAL_CFG */
 #define DMA_RX_CLK_CGC_ON		BIT(0)
 #define DMA_TX_CLK_CGC_ON		BIT(1)
-#define DMA_AHB_SLV_CFG_ON		BIT(2)
+#define DMA_AHB_SLV_CLK_CGC_ON		BIT(2)
 #define AHB_SEC_SLV_CLK_CGC_ON		BIT(3)
 #define DUMMY_RX_NON_BUFFERABLE		BIT(4)
 #define RX_DMA_ZERO_PADDING_EN		BIT(5)
@@ -196,7 +196,7 @@ u32 geni_se_get_qup_hw_version(struct geni_se *se)
 {
 	struct geni_wrapper *wrapper = se->wrapper;
 
-	return readl_relaxed(wrapper->base + QUP_HW_VER_REG);
+	return readl_relaxed(wrapper->base + QUPV3_HW_VER_REG);
 }
 EXPORT_SYMBOL_GPL(geni_se_get_qup_hw_version);
 
@@ -220,12 +220,12 @@ static void geni_se_io_init(void __iomem *base)
 {
 	u32 val;
 
-	val = readl_relaxed(base + GENI_CGC_CTRL);
+	val = readl_relaxed(base + SE_GENI_CGC_CTRL);
 	val |= DEFAULT_CGC_EN;
-	writel_relaxed(val, base + GENI_CGC_CTRL);
+	writel_relaxed(val, base + SE_GENI_CGC_CTRL);
 
 	val = readl_relaxed(base + SE_DMA_GENERAL_CFG);
-	val |= AHB_SEC_SLV_CLK_CGC_ON | DMA_AHB_SLV_CFG_ON;
+	val |= AHB_SEC_SLV_CLK_CGC_ON | DMA_AHB_SLV_CLK_CGC_ON;
 	val |= DMA_TX_CLK_CGC_ON | DMA_RX_CLK_CGC_ON;
 	writel_relaxed(val, base + SE_DMA_GENERAL_CFG);
 
-- 
2.34.1


