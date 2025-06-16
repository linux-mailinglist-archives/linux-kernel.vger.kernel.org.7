Return-Path: <linux-kernel+bounces-687451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93060ADA525
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 02:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5848F7A5011
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 00:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A7D1D5CE8;
	Mon, 16 Jun 2025 00:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IB59xFO3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA36220F26
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750033781; cv=none; b=XINBdCm8GBoB7kmLwbTmtUhVE7Y9FbF6WscmYG826269Tx4Jh3OE8Ntz7yextZIMkc6OICkVdercWdQDR177mI3mqGhcAsxjR2boFNSAhwYQERWa5UqA4SbChaOnfFw1a059Xv19lm+d/akiGrjHL+ob6BNX5MiZZWdaaVyptew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750033781; c=relaxed/simple;
	bh=WOzhtUSXVbjbiSIeCl/AQHCPbnimjsBFVyo21kqdsSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5RPlMpYR56wOTJfq7/KBSIAzdBE1ThRHTpNzkK44AHZBKleNV0tlqJH2HT8MaD3yzNChNrdbdq8bNmPo0yKo4akpO8oUX6T4pEsoAdUuaUFOVBPdP2A+C822QTujnVgNyCaunPH8w/eQiwsDo0iwKalT6QrOoK4hm7afITvfXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IB59xFO3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55FNbxVt026711
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 00:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UM/lbnUs7erleOBaINJt0BTbObievRpeBPT2QzuJTZg=; b=IB59xFO3XsRDwNjj
	O0UEc14wFvVXI4FbuZylSeXpINwzf3GBnNompQRUg8jbbWKGAbJB/Wemt2KOeyr5
	LqbjYjTGyni7F04ZhYYGA24DyFzc6LaGUdlyzHr9XVC1iwIp3pWb5+ySNHjYntj4
	H+mQ61+hQ4HMeIznUmpVuyV+IffGzcQsPZZ02ZOY5nacX9mnut1aNAemE+ZKjX8o
	WgDv0GIBwcNgJmPjAln4juKaw3qJWxse93AnmVlaU3r7th8xcp3Pit5m5eQzkvby
	XimViXiRRyhVY2Y+XmsBiHRXaLnNIz5oWVfbFNE4vkOf1+gssUv+iiBBWHkTMgpO
	9mIi8w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47928mahn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 00:29:36 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6face45b58dso58145966d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jun 2025 17:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750033775; x=1750638575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UM/lbnUs7erleOBaINJt0BTbObievRpeBPT2QzuJTZg=;
        b=OdqZqIxGssyOwiOj9p+E2Legf4LScht3SkWvwIrvrTvp0PW7poaD7krocHpeouIU3N
         jlJ8QfAo5AldJPOCFlgXNkdvzheLcK/iEM8ZXQDctOhAvqMzqQcvrFOomVuES8CHunbH
         CJuWL9bDzRwx/P9FMPFED695NvMjD93Qx3JYJppyW/9zhjIguWx+ectMLa24pD7X3DFd
         Y7Gjasy7U6/bDlDH0WqkIPrMPVios8cZVS4J4MZFu7ZZhbMT3tF4UzvqO690aje6LDjR
         5Rbpc52PbAYaEmj86kNgopWux1T4YJXghH147kmSwmHbbV8QX0bk87JkANn/WqsSj8oM
         oLxQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8IOI0Qjq8srquSmy8BHdQs3yZ9RWP+vOe+zW3mY77MVpxbS2OPTl7SprB7XYxDwWOiD/HYDuchql06Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp0QuMaj6mDosLhL1wIRI8Mkkrg1ylQpV3duzHHKk2o1cUkgOr
	RExdIjN4huU08eMRc3rTPacuJPBXVvvt9TT1dpe9EtI5IBvrLkPVSwNdQwMlVHyzZ6cOl5qcWNj
	uDV+W1gH5F+G5TIoALn3Uz5th51ScIV3XG/9hot6Hw/2+5Pt4P3fnMdUqG42Lc7ZdI6E=
X-Gm-Gg: ASbGncs0EHr+XA9j6oIp6/Jh6R2FqPNu3UyOmilBfSkj/cYhd7xw5hCjy3saDc4Y1mS
	JAja0DVabJnSK0rVN0dHAU1Im0hbtGp5J7DeJAzvB0nmjoaOXGm2JI79usIvUbcVZoQZI4ntcQR
	gO+a5QpGhs1qi619eo46uUutMepWHXyU2/6UlP5FNF/yYFTW9iewYQsCOZnAWm9bxad25NIs/dF
	ciqe6OEhKi8u9Ez7RTFCHylpSPojVp0b3V4dgas8CsP5OrjnwOCw3UwZFjHj2ejA/lmtrqIkYWw
	CNkOP3/gMBNBXQfULyq00Zo5pK42IFCbBCihPPCCC3VMH9q9x2iIyDAc3G3BqBXr/fdANaBgeEQ
	YpbwTp35PCGoBvDqhQ37G7/LtoY0Ds7YD4jE=
X-Received: by 2002:a05:6214:5296:b0:6fa:fe02:8229 with SMTP id 6a1803df08f44-6fb477a60ffmr106767346d6.30.1750033774875;
        Sun, 15 Jun 2025 17:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGTQaqgRFHJf06C3C1jqulCs+xPuwrPd8TlT3wuRyn8ruUHS1sQZSMB42N2ev/9lD9pqp/SA==
X-Received: by 2002:a05:6214:5296:b0:6fa:fe02:8229 with SMTP id 6a1803df08f44-6fb477a60ffmr106767116d6.30.1750033774329;
        Sun, 15 Jun 2025 17:29:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac136104sm1334990e87.77.2025.06.15.17.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 17:29:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 16 Jun 2025 03:28:31 +0300
Subject: [PATCH 19/28] interconnect: qcom: sdx75: convert to dynamic IDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rework-icc-v1-19-bc1326294d71@oss.qualcomm.com>
References: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
In-Reply-To: <20250616-rework-icc-v1-0-bc1326294d71@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=32502;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=WOzhtUSXVbjbiSIeCl/AQHCPbnimjsBFVyo21kqdsSY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoT2UkSR+7nOrAxp/GkXX+HvgUQcDVC878M9BTm
 lOI3cloSmSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaE9lJAAKCRCLPIo+Aiko
 1SRQCACLNNjT8o9m0NeVfWNqnfhG0GXOjP5QvbzaqPrYX2SmyS4toGhHkXLdB4dRNgJg8VJHZ21
 q3yAIG1PWZOrjbWq/UU1ql7xwVHYABSdIseTBfEh0o5TDzsKpxMqOHnnnT/IpSaiqdP4d8xgv6R
 aw7jiIodGBRC9VaPzIdySqBOpvlgZ9ENJ3FfDML25BN3FuHWjWr5i+KCqG/wxibQObI8Yrjj7P1
 yDm/EhHg6O0CL8NIVhFGo0SFZTgoWK7F3ZNMQ4SxkjVUk1bfvpq2Hn+TApUxI0+5JMB+WnC+TWa
 bpmNH/8DncvSR3A9NFr5AFANjlr8yDyfmah3NutsEuLDHX2f
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDAwMSBTYWx0ZWRfX9hYY4O181qpx
 D0NsCoKXMdPLrJBdge/XkgXiXByAEVl2vCLgeRYVEWeuZ7ZjAH7fmD+ayCOOGGGRsrvVcJN57Z8
 ZS7b3T+R63V1hIorbj6Bje3PIY0jEBLhtdC03pcRjhU3MfctcDpL9Heuj1dFkQuqGmfBz4MNKXU
 tGna43wzU3G781YN5/hCwL1baLSKFW1JEnx34QghrbzLIXRzfjm2nRcWzIT/zHlH0hgPBvna+Ya
 DeTwSQkMHvwWHqk38uV9ToVCKnZM8YgYA1iGiqksvG4WpJfpIyeFYUxa2xHcudNExJ053yqr0Fg
 B6sglGvthNZOki2iGzAyo9C+C+HSSQSa223+C6+c0BolxLH0tXfOk1rmOhjkFr3S0r/WMMhFd5/
 TItwfH3YyOSWqjW96mCH/wepVt6mjHNEzeUPdxPQ272jc5cWzjVKDETwaXzBtgglG5zGX9C+
X-Authority-Analysis: v=2.4 cv=fvbcZE4f c=1 sm=1 tr=0 ts=684f6570 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=nFsRkWJfq7tcEly46b4A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: gQzUYFRCzQjXR5X1CZSL7MbL9JTwQ293
X-Proofpoint-ORIG-GUID: gQzUYFRCzQjXR5X1CZSL7MbL9JTwQ293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-15_10,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160001

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sdx75.c | 471 +++++++++++++++++---------------------
 drivers/interconnect/qcom/sdx75.h |  97 --------
 2 files changed, 216 insertions(+), 352 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx75.c b/drivers/interconnect/qcom/sdx75.c
index ea799f7ec0c5a7e87bf6243471120c917d100ff6..bfd0ec87f68020ea1e832c405237d29054117f70 100644
--- a/drivers/interconnect/qcom/sdx75.c
+++ b/drivers/interconnect/qcom/sdx75.c
@@ -14,782 +14,737 @@
 #include "bcm-voter.h"
 #include "icc-common.h"
 #include "icc-rpmh.h"
-#include "sdx75.h"
+
+static struct qcom_icc_node qpic_core_master;
+static struct qcom_icc_node qup0_core_master;
+static struct qcom_icc_node qnm_cnoc;
+static struct qcom_icc_node alm_sys_tcu;
+static struct qcom_icc_node chm_apps;
+static struct qcom_icc_node qnm_gemnoc_cfg;
+static struct qcom_icc_node qnm_mdsp;
+static struct qcom_icc_node qnm_pcie;
+static struct qcom_icc_node qnm_snoc_sf;
+static struct qcom_icc_node xm_gic;
+static struct qcom_icc_node xm_ipa2pcie;
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node xm_pcie3_0;
+static struct qcom_icc_node xm_pcie3_1;
+static struct qcom_icc_node xm_pcie3_2;
+static struct qcom_icc_node qhm_audio;
+static struct qcom_icc_node qhm_gic;
+static struct qcom_icc_node qhm_pcie_rscc;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qpic;
+static struct qcom_icc_node qhm_qup0;
+static struct qcom_icc_node qnm_aggre_noc;
+static struct qcom_icc_node qnm_gemnoc_cnoc;
+static struct qcom_icc_node qnm_gemnoc_pcie;
+static struct qcom_icc_node qnm_system_noc_cfg;
+static struct qcom_icc_node qnm_system_noc_pcie_cfg;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node qxm_ipa;
+static struct qcom_icc_node qxm_mvmss;
+static struct qcom_icc_node xm_emac_0;
+static struct qcom_icc_node xm_emac_1;
+static struct qcom_icc_node xm_qdss_etr0;
+static struct qcom_icc_node xm_qdss_etr1;
+static struct qcom_icc_node xm_sdc1;
+static struct qcom_icc_node xm_sdc4;
+static struct qcom_icc_node xm_usb3;
+static struct qcom_icc_node qpic_core_slave;
+static struct qcom_icc_node qup0_core_slave;
+static struct qcom_icc_node qhs_lagg;
+static struct qcom_icc_node qhs_mccc_master;
+static struct qcom_icc_node qns_gemnoc;
+static struct qcom_icc_node qss_snoop_bwmon;
+static struct qcom_icc_node qns_gemnoc_cnoc;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_pcie;
+static struct qcom_icc_node srvc_gemnoc;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_pcie_gemnoc;
+static struct qcom_icc_node ps_eth0_cfg;
+static struct qcom_icc_node ps_eth1_cfg;
+static struct qcom_icc_node qhs_audio;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_crypto_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_ipc_router;
+static struct qcom_icc_node qhs_mss_cfg;
+static struct qcom_icc_node qhs_mvmss_cfg;
+static struct qcom_icc_node qhs_pcie0_cfg;
+static struct qcom_icc_node qhs_pcie1_cfg;
+static struct qcom_icc_node qhs_pcie2_cfg;
+static struct qcom_icc_node qhs_pcie_rscc;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qpic;
+static struct qcom_icc_node qhs_qup0;
+static struct qcom_icc_node qhs_sdc1;
+static struct qcom_icc_node qhs_sdc4;
+static struct qcom_icc_node qhs_spmi_vgi_coex;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_usb3;
+static struct qcom_icc_node qhs_usb3_phy;
+static struct qcom_icc_node qns_a1noc;
+static struct qcom_icc_node qns_ddrss_cfg;
+static struct qcom_icc_node qns_gemnoc_sf;
+static struct qcom_icc_node qns_system_noc_cfg;
+static struct qcom_icc_node qns_system_noc_pcie_cfg;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node srvc_pcie_system_noc;
+static struct qcom_icc_node srvc_system_noc;
+static struct qcom_icc_node xs_pcie_0;
+static struct qcom_icc_node xs_pcie_1;
+static struct qcom_icc_node xs_pcie_2;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
 
 static struct qcom_icc_node qpic_core_master = {
 	.name = "qpic_core_master",
-	.id = SDX75_MASTER_QPIC_CORE,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_QPIC_CORE },
+	.link_nodes = { &qpic_core_slave, NULL },
 };
 
 static struct qcom_icc_node qup0_core_master = {
 	.name = "qup0_core_master",
-	.id = SDX75_MASTER_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_QUP_CORE_0 },
+	.link_nodes = { &qup0_core_slave, NULL },
 };
 
 static struct qcom_icc_node qnm_cnoc = {
 	.name = "qnm_cnoc",
-	.id = SDX75_MASTER_CNOC_DC_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 4,
-	.links = { SDX75_SLAVE_LAGG_CFG, SDX75_SLAVE_MCCC_MASTER,
-		   SDX75_SLAVE_GEM_NOC_CFG, SDX75_SLAVE_SNOOP_BWMON },
+	.link_nodes = { &qhs_lagg, &qhs_mccc_master,
+			&qns_gemnoc, &qss_snoop_bwmon, NULL },
 };
 
 static struct qcom_icc_node alm_sys_tcu = {
 	.name = "alm_sys_tcu",
-	.id = SDX75_MASTER_SYS_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 2,
-	.links = { SDX75_SLAVE_GEM_NOC_CNOC, SDX75_SLAVE_LLCC },
+	.link_nodes = { &qns_gemnoc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node chm_apps = {
 	.name = "chm_apps",
-	.id = SDX75_MASTER_APPSS_PROC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { SDX75_SLAVE_GEM_NOC_CNOC, SDX75_SLAVE_LLCC,
-		   SDX75_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gemnoc_cnoc, &qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cfg = {
 	.name = "qnm_gemnoc_cfg",
-	.id = SDX75_MASTER_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_SERVICE_GEM_NOC },
+	.link_nodes = { &srvc_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qnm_mdsp = {
 	.name = "qnm_mdsp",
-	.id = SDX75_MASTER_MSS_PROC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { SDX75_SLAVE_GEM_NOC_CNOC, SDX75_SLAVE_LLCC,
-		   SDX75_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gemnoc_cnoc, &qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node qnm_pcie = {
 	.name = "qnm_pcie",
-	.id = SDX75_MASTER_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 2,
-	.links = { SDX75_SLAVE_GEM_NOC_CNOC, SDX75_SLAVE_LLCC },
+	.link_nodes = { &qns_gemnoc_cnoc, &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node qnm_snoc_sf = {
 	.name = "qnm_snoc_sf",
-	.id = SDX75_MASTER_SNOC_SF_MEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { SDX75_SLAVE_GEM_NOC_CNOC, SDX75_SLAVE_LLCC,
-		   SDX75_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_gemnoc_cnoc, &qns_llcc,
+			&qns_pcie, NULL },
 };
 
 static struct qcom_icc_node xm_gic = {
 	.name = "xm_gic",
-	.id = SDX75_MASTER_GIC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc, NULL },
 };
 
 static struct qcom_icc_node xm_ipa2pcie = {
 	.name = "xm_ipa2pcie",
-	.id = SDX75_MASTER_IPA_PCIE,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qns_pcie, NULL },
 };
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SDX75_MASTER_LLCC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_EBI1 },
+	.link_nodes = { &ebi, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_0 = {
 	.name = "xm_pcie3_0",
-	.id = SDX75_MASTER_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_gemnoc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_1 = {
 	.name = "xm_pcie3_1",
-	.id = SDX75_MASTER_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_gemnoc, NULL },
 };
 
 static struct qcom_icc_node xm_pcie3_2 = {
 	.name = "xm_pcie3_2",
-	.id = SDX75_MASTER_PCIE_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qns_pcie_gemnoc, NULL },
 };
 
 static struct qcom_icc_node qhm_audio = {
 	.name = "qhm_audio",
-	.id = SDX75_MASTER_AUDIO,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qhm_gic = {
 	.name = "qhm_gic",
-	.id = SDX75_MASTER_GIC_AHB,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qhm_pcie_rscc = {
 	.name = "qhm_pcie_rscc",
-	.id = SDX75_MASTER_PCIE_RSCC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 31,
-	.links = { SDX75_SLAVE_ETH0_CFG, SDX75_SLAVE_ETH1_CFG,
-		   SDX75_SLAVE_AUDIO, SDX75_SLAVE_CLK_CTL,
-		   SDX75_SLAVE_CRYPTO_0_CFG, SDX75_SLAVE_IMEM_CFG,
-		   SDX75_SLAVE_IPA_CFG, SDX75_SLAVE_IPC_ROUTER_CFG,
-		   SDX75_SLAVE_CNOC_MSS, SDX75_SLAVE_ICBDI_MVMSS_CFG,
-		   SDX75_SLAVE_PCIE_0_CFG, SDX75_SLAVE_PCIE_1_CFG,
-		   SDX75_SLAVE_PCIE_2_CFG, SDX75_SLAVE_PDM,
-		   SDX75_SLAVE_PRNG, SDX75_SLAVE_QDSS_CFG,
-		   SDX75_SLAVE_QPIC, SDX75_SLAVE_QUP_0,
-		   SDX75_SLAVE_SDCC_1, SDX75_SLAVE_SDCC_4,
-		   SDX75_SLAVE_SPMI_VGI_COEX, SDX75_SLAVE_TCSR,
-		   SDX75_SLAVE_TLMM, SDX75_SLAVE_USB3,
-		   SDX75_SLAVE_USB3_PHY_CFG, SDX75_SLAVE_DDRSS_CFG,
-		   SDX75_SLAVE_SNOC_CFG, SDX75_SLAVE_PCIE_ANOC_CFG,
-		   SDX75_SLAVE_IMEM, SDX75_SLAVE_QDSS_STM,
-		   SDX75_SLAVE_TCU },
+	.link_nodes = { &ps_eth0_cfg, &ps_eth1_cfg,
+			&qhs_audio, &qhs_clk_ctl,
+			&qhs_crypto_cfg, &qhs_imem_cfg,
+			&qhs_ipa, &qhs_ipc_router,
+			&qhs_mss_cfg, &qhs_mvmss_cfg,
+			&qhs_pcie0_cfg, &qhs_pcie1_cfg,
+			&qhs_pcie2_cfg, &qhs_pdm,
+			&qhs_prng, &qhs_qdss_cfg,
+			&qhs_qpic, &qhs_qup0,
+			&qhs_sdc1, &qhs_sdc4,
+			&qhs_spmi_vgi_coex, &qhs_tcsr,
+			&qhs_tlmm, &qhs_usb3,
+			&qhs_usb3_phy, &qns_ddrss_cfg,
+			&qns_system_noc_cfg, &qns_system_noc_pcie_cfg,
+			&qxs_imem, &xs_qdss_stm,
+			&xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SDX75_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc, NULL },
 };
 
 static struct qcom_icc_node qhm_qpic = {
 	.name = "qhm_qpic",
-	.id = SDX75_MASTER_QPIC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc, NULL },
 };
 
 static struct qcom_icc_node qhm_qup0 = {
 	.name = "qhm_qup0",
-	.id = SDX75_MASTER_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc, NULL },
 };
 
 static struct qcom_icc_node qnm_aggre_noc = {
 	.name = "qnm_aggre_noc",
-	.id = SDX75_MASTER_ANOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_cnoc = {
 	.name = "qnm_gemnoc_cnoc",
-	.id = SDX75_MASTER_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 32,
-	.links = { SDX75_SLAVE_ETH0_CFG, SDX75_SLAVE_ETH1_CFG,
-		   SDX75_SLAVE_AUDIO, SDX75_SLAVE_CLK_CTL,
-		   SDX75_SLAVE_CRYPTO_0_CFG, SDX75_SLAVE_IMEM_CFG,
-		   SDX75_SLAVE_IPA_CFG, SDX75_SLAVE_IPC_ROUTER_CFG,
-		   SDX75_SLAVE_CNOC_MSS, SDX75_SLAVE_ICBDI_MVMSS_CFG,
-		   SDX75_SLAVE_PCIE_0_CFG, SDX75_SLAVE_PCIE_1_CFG,
-		   SDX75_SLAVE_PCIE_2_CFG, SDX75_SLAVE_PCIE_RSC_CFG,
-		   SDX75_SLAVE_PDM, SDX75_SLAVE_PRNG,
-		   SDX75_SLAVE_QDSS_CFG, SDX75_SLAVE_QPIC,
-		   SDX75_SLAVE_QUP_0, SDX75_SLAVE_SDCC_1,
-		   SDX75_SLAVE_SDCC_4, SDX75_SLAVE_SPMI_VGI_COEX,
-		   SDX75_SLAVE_TCSR, SDX75_SLAVE_TLMM,
-		   SDX75_SLAVE_USB3, SDX75_SLAVE_USB3_PHY_CFG,
-		   SDX75_SLAVE_DDRSS_CFG, SDX75_SLAVE_SNOC_CFG,
-		   SDX75_SLAVE_PCIE_ANOC_CFG, SDX75_SLAVE_IMEM,
-		   SDX75_SLAVE_QDSS_STM, SDX75_SLAVE_TCU },
+	.link_nodes = { &ps_eth0_cfg, &ps_eth1_cfg,
+			&qhs_audio, &qhs_clk_ctl,
+			&qhs_crypto_cfg, &qhs_imem_cfg,
+			&qhs_ipa, &qhs_ipc_router,
+			&qhs_mss_cfg, &qhs_mvmss_cfg,
+			&qhs_pcie0_cfg, &qhs_pcie1_cfg,
+			&qhs_pcie2_cfg, &qhs_pcie_rscc,
+			&qhs_pdm, &qhs_prng,
+			&qhs_qdss_cfg, &qhs_qpic,
+			&qhs_qup0, &qhs_sdc1,
+			&qhs_sdc4, &qhs_spmi_vgi_coex,
+			&qhs_tcsr, &qhs_tlmm,
+			&qhs_usb3, &qhs_usb3_phy,
+			&qns_ddrss_cfg, &qns_system_noc_cfg,
+			&qns_system_noc_pcie_cfg, &qxs_imem,
+			&xs_qdss_stm, &xs_sys_tcu_cfg, NULL },
 };
 
 static struct qcom_icc_node qnm_gemnoc_pcie = {
 	.name = "qnm_gemnoc_pcie",
-	.id = SDX75_MASTER_GEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 3,
-	.links = { SDX75_SLAVE_PCIE_0, SDX75_SLAVE_PCIE_1,
-		   SDX75_SLAVE_PCIE_2 },
+	.link_nodes = { &xs_pcie_0, &xs_pcie_1,
+			&xs_pcie_2, NULL },
 };
 
 static struct qcom_icc_node qnm_system_noc_cfg = {
 	.name = "qnm_system_noc_cfg",
-	.id = SDX75_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_system_noc, NULL },
 };
 
 static struct qcom_icc_node qnm_system_noc_pcie_cfg = {
 	.name = "qnm_system_noc_pcie_cfg",
-	.id = SDX75_MASTER_PCIE_ANOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_SERVICE_PCIE_ANOC },
+	.link_nodes = { &srvc_pcie_system_noc, NULL },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SDX75_MASTER_CRYPTO,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc, NULL },
 };
 
 static struct qcom_icc_node qxm_ipa = {
 	.name = "qxm_ipa",
-	.id = SDX75_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_SNOC_GEM_NOC_SF },
+	.link_nodes = { &qns_gemnoc_sf, NULL },
 };
 
 static struct qcom_icc_node qxm_mvmss = {
 	.name = "qxm_mvmss",
-	.id = SDX75_MASTER_MVMSS,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc, NULL },
 };
 
 static struct qcom_icc_node xm_emac_0 = {
 	.name = "xm_emac_0",
-	.id = SDX75_MASTER_EMAC_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc, NULL },
 };
 
 static struct qcom_icc_node xm_emac_1 = {
 	.name = "xm_emac_1",
-	.id = SDX75_MASTER_EMAC_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr0 = {
 	.name = "xm_qdss_etr0",
-	.id = SDX75_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc, NULL },
 };
 
 static struct qcom_icc_node xm_qdss_etr1 = {
 	.name = "xm_qdss_etr1",
-	.id = SDX75_MASTER_QDSS_ETR_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
-	.id = SDX75_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc, NULL },
 };
 
 static struct qcom_icc_node xm_sdc4 = {
 	.name = "xm_sdc4",
-	.id = SDX75_MASTER_SDCC_4,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc, NULL },
 };
 
 static struct qcom_icc_node xm_usb3 = {
 	.name = "xm_usb3",
-	.id = SDX75_MASTER_USB3_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_SLAVE_A1NOC_CFG },
+	.link_nodes = { &qns_a1noc, NULL },
 };
 
 static struct qcom_icc_node qpic_core_slave = {
 	.name = "qpic_core_slave",
-	.id = SDX75_SLAVE_QPIC_CORE,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qup0_core_slave = {
 	.name = "qup0_core_slave",
-	.id = SDX75_SLAVE_QUP_CORE_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_lagg = {
 	.name = "qhs_lagg",
-	.id = SDX75_SLAVE_LAGG_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mccc_master = {
 	.name = "qhs_mccc_master",
-	.id = SDX75_SLAVE_MCCC_MASTER,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc = {
 	.name = "qns_gemnoc",
-	.id = SDX75_SLAVE_GEM_NOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qss_snoop_bwmon = {
 	.name = "qss_snoop_bwmon",
-	.id = SDX75_SLAVE_SNOOP_BWMON,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_cnoc = {
 	.name = "qns_gemnoc_cnoc",
-	.id = SDX75_SLAVE_GEM_NOC_CNOC,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_MASTER_GEM_NOC_CNOC },
+	.link_nodes = { &qnm_gemnoc_cnoc, NULL },
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SDX75_SLAVE_LLCC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SDX75_MASTER_LLCC },
+	.link_nodes = { &llcc_mc, NULL },
 };
 
 static struct qcom_icc_node qns_pcie = {
 	.name = "qns_pcie",
-	.id = SDX75_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SDX75_MASTER_GEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_gemnoc_pcie, NULL },
 };
 
 static struct qcom_icc_node srvc_gemnoc = {
 	.name = "srvc_gemnoc",
-	.id = SDX75_SLAVE_SERVICE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SDX75_SLAVE_EBI1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_pcie_gemnoc = {
 	.name = "qns_pcie_gemnoc",
-	.id = SDX75_SLAVE_ANOC_PCIE_GEM_NOC,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SDX75_MASTER_ANOC_PCIE_GEM_NOC },
+	.link_nodes = { &qnm_pcie, NULL },
 };
 
 static struct qcom_icc_node ps_eth0_cfg = {
 	.name = "ps_eth0_cfg",
-	.id = SDX75_SLAVE_ETH0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node ps_eth1_cfg = {
 	.name = "ps_eth1_cfg",
-	.id = SDX75_SLAVE_ETH1_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_audio = {
 	.name = "qhs_audio",
-	.id = SDX75_SLAVE_AUDIO,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SDX75_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_crypto_cfg = {
 	.name = "qhs_crypto_cfg",
-	.id = SDX75_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SDX75_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SDX75_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_ipc_router = {
 	.name = "qhs_ipc_router",
-	.id = SDX75_SLAVE_IPC_ROUTER_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = SDX75_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_mvmss_cfg = {
 	.name = "qhs_mvmss_cfg",
-	.id = SDX75_SLAVE_ICBDI_MVMSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie0_cfg = {
 	.name = "qhs_pcie0_cfg",
-	.id = SDX75_SLAVE_PCIE_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie1_cfg = {
 	.name = "qhs_pcie1_cfg",
-	.id = SDX75_SLAVE_PCIE_1_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie2_cfg = {
 	.name = "qhs_pcie2_cfg",
-	.id = SDX75_SLAVE_PCIE_2_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pcie_rscc = {
 	.name = "qhs_pcie_rscc",
-	.id = SDX75_SLAVE_PCIE_RSC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SDX75_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SDX75_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SDX75_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qpic = {
 	.name = "qhs_qpic",
-	.id = SDX75_SLAVE_QPIC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_qup0 = {
 	.name = "qhs_qup0",
-	.id = SDX75_SLAVE_QUP_0,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc1 = {
 	.name = "qhs_sdc1",
-	.id = SDX75_SLAVE_SDCC_1,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_sdc4 = {
 	.name = "qhs_sdc4",
-	.id = SDX75_SLAVE_SDCC_4,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_spmi_vgi_coex = {
 	.name = "qhs_spmi_vgi_coex",
-	.id = SDX75_SLAVE_SPMI_VGI_COEX,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SDX75_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = SDX75_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3 = {
 	.name = "qhs_usb3",
-	.id = SDX75_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qhs_usb3_phy = {
 	.name = "qhs_usb3_phy",
-	.id = SDX75_SLAVE_USB3_PHY_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node qns_a1noc = {
 	.name = "qns_a1noc",
-	.id = SDX75_SLAVE_A1NOC_CFG,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 1,
-	.links = { SDX75_MASTER_ANOC_SNOC },
+	.link_nodes = { &qnm_aggre_noc, NULL },
 };
 
 static struct qcom_icc_node qns_ddrss_cfg = {
 	.name = "qns_ddrss_cfg",
-	.id = SDX75_SLAVE_DDRSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_MASTER_CNOC_DC_NOC },
+	.link_nodes = { &qnm_cnoc, NULL },
 };
 
 static struct qcom_icc_node qns_gemnoc_sf = {
 	.name = "qns_gemnoc_sf",
-	.id = SDX75_SLAVE_SNOC_GEM_NOC_SF,
 	.channels = 1,
 	.buswidth = 16,
-	.num_links = 1,
-	.links = { SDX75_MASTER_SNOC_SF_MEM_NOC },
+	.link_nodes = { &qnm_snoc_sf, NULL },
 };
 
 static struct qcom_icc_node qns_system_noc_cfg = {
 	.name = "qns_system_noc_cfg",
-	.id = SDX75_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_MASTER_SNOC_CFG },
+	.link_nodes = { &qnm_system_noc_cfg, NULL },
 };
 
 static struct qcom_icc_node qns_system_noc_pcie_cfg = {
 	.name = "qns_system_noc_pcie_cfg",
-	.id = SDX75_SLAVE_PCIE_ANOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 1,
-	.links = { SDX75_MASTER_PCIE_ANOC_CFG },
+	.link_nodes = { &qnm_system_noc_pcie_cfg, NULL },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SDX75_SLAVE_IMEM,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_pcie_system_noc = {
 	.name = "srvc_pcie_system_noc",
-	.id = SDX75_SLAVE_SERVICE_PCIE_ANOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node srvc_system_noc = {
 	.name = "srvc_system_noc",
-	.id = SDX75_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_0 = {
 	.name = "xs_pcie_0",
-	.id = SDX75_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_1 = {
 	.name = "xs_pcie_1",
-	.id = SDX75_SLAVE_PCIE_1,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_pcie_2 = {
 	.name = "xs_pcie_2",
-	.id = SDX75_SLAVE_PCIE_2,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SDX75_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SDX75_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
-	.num_links = 0,
+	.link_nodes = { NULL },
 };
 
 static struct qcom_icc_bcm bcm_ce0 = {
@@ -899,6 +854,7 @@ static struct qcom_icc_node * const clk_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_clk_virt = {
+	.alloc_dyn_id = true,
 	.nodes = clk_virt_nodes,
 	.num_nodes = ARRAY_SIZE(clk_virt_nodes),
 	.bcms = clk_virt_bcms,
@@ -914,6 +870,7 @@ static struct qcom_icc_node * const dc_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_dc_noc = {
+	.alloc_dyn_id = true,
 	.nodes = dc_noc_nodes,
 	.num_nodes = ARRAY_SIZE(dc_noc_nodes),
 };
@@ -940,6 +897,7 @@ static struct qcom_icc_node * const gem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_gem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = gem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(gem_noc_nodes),
 	.bcms = gem_noc_bcms,
@@ -956,6 +914,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -975,6 +934,7 @@ static struct qcom_icc_node * const pcie_anoc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_pcie_anoc = {
+	.alloc_dyn_id = true,
 	.nodes = pcie_anoc_nodes,
 	.num_nodes = ARRAY_SIZE(pcie_anoc_nodes),
 	.bcms = pcie_anoc_bcms,
@@ -1053,6 +1013,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx75_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sdx75.h b/drivers/interconnect/qcom/sdx75.h
deleted file mode 100644
index 24e88715992010d934a1a630979f864af3a8426c..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sdx75.h
+++ /dev/null
@@ -1,97 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SDX75_H
-#define __DRIVERS_INTERCONNECT_QCOM_SDX75_H
-
-#define SDX75_MASTER_ANOC_PCIE_GEM_NOC		0
-#define SDX75_MASTER_ANOC_SNOC			1
-#define SDX75_MASTER_APPSS_PROC			2
-#define SDX75_MASTER_AUDIO			3
-#define SDX75_MASTER_CNOC_DC_NOC		4
-#define SDX75_MASTER_CRYPTO			5
-#define SDX75_MASTER_EMAC_0			6
-#define SDX75_MASTER_EMAC_1			7
-#define SDX75_MASTER_GEM_NOC_CFG		8
-#define SDX75_MASTER_GEM_NOC_CNOC		9
-#define SDX75_MASTER_GEM_NOC_PCIE_SNOC		10
-#define SDX75_MASTER_GIC			11
-#define SDX75_MASTER_GIC_AHB			12
-#define SDX75_MASTER_IPA			13
-#define SDX75_MASTER_IPA_PCIE			14
-#define SDX75_MASTER_LLCC			15
-#define SDX75_MASTER_MSS_PROC			16
-#define SDX75_MASTER_MVMSS			17
-#define SDX75_MASTER_PCIE_0			18
-#define SDX75_MASTER_PCIE_1			19
-#define SDX75_MASTER_PCIE_2			20
-#define SDX75_MASTER_PCIE_ANOC_CFG		21
-#define SDX75_MASTER_PCIE_RSCC			22
-#define SDX75_MASTER_QDSS_BAM			23
-#define SDX75_MASTER_QDSS_ETR			24
-#define SDX75_MASTER_QDSS_ETR_1			25
-#define SDX75_MASTER_QPIC			26
-#define SDX75_MASTER_QPIC_CORE			27
-#define SDX75_MASTER_QUP_0			28
-#define SDX75_MASTER_QUP_CORE_0			29
-#define SDX75_MASTER_SDCC_1			30
-#define SDX75_MASTER_SDCC_4			31
-#define SDX75_MASTER_SNOC_CFG			32
-#define SDX75_MASTER_SNOC_SF_MEM_NOC		33
-#define SDX75_MASTER_SYS_TCU			34
-#define SDX75_MASTER_USB3_0			35
-#define SDX75_SLAVE_A1NOC_CFG			36
-#define SDX75_SLAVE_ANOC_PCIE_GEM_NOC		37
-#define SDX75_SLAVE_AUDIO			38
-#define SDX75_SLAVE_CLK_CTL			39
-#define SDX75_SLAVE_CRYPTO_0_CFG		40
-#define SDX75_SLAVE_CNOC_MSS			41
-#define SDX75_SLAVE_DDRSS_CFG			42
-#define SDX75_SLAVE_EBI1			43
-#define SDX75_SLAVE_ETH0_CFG			44
-#define SDX75_SLAVE_ETH1_CFG			45
-#define SDX75_SLAVE_GEM_NOC_CFG			46
-#define SDX75_SLAVE_GEM_NOC_CNOC		47
-#define SDX75_SLAVE_ICBDI_MVMSS_CFG		48
-#define SDX75_SLAVE_IMEM			49
-#define SDX75_SLAVE_IMEM_CFG			50
-#define SDX75_SLAVE_IPA_CFG			51
-#define SDX75_SLAVE_IPC_ROUTER_CFG		52
-#define SDX75_SLAVE_LAGG_CFG			53
-#define SDX75_SLAVE_LLCC			54
-#define SDX75_SLAVE_MCCC_MASTER			55
-#define SDX75_SLAVE_MEM_NOC_PCIE_SNOC		56
-#define SDX75_SLAVE_PCIE_0			57
-#define SDX75_SLAVE_PCIE_1			58
-#define SDX75_SLAVE_PCIE_2			59
-#define SDX75_SLAVE_PCIE_0_CFG			60
-#define SDX75_SLAVE_PCIE_1_CFG			61
-#define SDX75_SLAVE_PCIE_2_CFG			62
-#define SDX75_SLAVE_PCIE_ANOC_CFG		63
-#define SDX75_SLAVE_PCIE_RSC_CFG		64
-#define SDX75_SLAVE_PDM				65
-#define SDX75_SLAVE_PRNG			66
-#define SDX75_SLAVE_QDSS_CFG			67
-#define SDX75_SLAVE_QDSS_STM			68
-#define SDX75_SLAVE_QPIC			69
-#define SDX75_SLAVE_QPIC_CORE			70
-#define SDX75_SLAVE_QUP_0			71
-#define SDX75_SLAVE_QUP_CORE_0			72
-#define SDX75_SLAVE_SDCC_1			73
-#define SDX75_SLAVE_SDCC_4			74
-#define SDX75_SLAVE_SERVICE_GEM_NOC		75
-#define SDX75_SLAVE_SERVICE_PCIE_ANOC		76
-#define SDX75_SLAVE_SERVICE_SNOC		77
-#define SDX75_SLAVE_SNOC_CFG			78
-#define SDX75_SLAVE_SNOC_GEM_NOC_SF		79
-#define SDX75_SLAVE_SNOOP_BWMON			80
-#define SDX75_SLAVE_SPMI_VGI_COEX		81
-#define SDX75_SLAVE_TCSR			82
-#define SDX75_SLAVE_TCU				83
-#define SDX75_SLAVE_TLMM			84
-#define SDX75_SLAVE_USB3			85
-#define SDX75_SLAVE_USB3_PHY_CFG		86
-
-#endif

-- 
2.39.5


