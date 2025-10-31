Return-Path: <linux-kernel+bounces-880410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71114C25B03
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8138E4F7C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4691529A312;
	Fri, 31 Oct 2025 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C1xIsFay";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="izBaJf7x"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15F228C5B8
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921961; cv=none; b=oycDBmQXtsxDlUFf7/Zlwp5wSTuCvvPOrm9+Kpp2n13OskCe5ZlML3036hMyGoOwGuaH2qyXNKUvzSXd/WDCTiCQ37eU8W0kDAu9ZAiTptLFeohXZVmKkvnK5vVRPqMy3MlBuVvurkg4qQMxdCsEzSHn6Y2QH8eJa5QK+1/5p84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921961; c=relaxed/simple;
	bh=g2LQE2frQRxkJb3tGVdeVAOu4CUe6ZQbflK4ewrE+3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aIQqO4JkMLw267hHmEzP6BkZWIE9bZQcBRk33MfnSHeS3lLWMGIz1Xix/ZPIMPnngaGCsSYtk8kKkCJHYlBCVIypoNSK8/zbU2EYAEfVho1cjr1xAGCcnPuEGTVGiJD2KbUXkAs2DoSl9RmfChlsm5XiVuEYeDGvg+PYfctv9dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C1xIsFay; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=izBaJf7x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59VAvGx9102634
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	idcL2HnaWjhQi3/nWWAzrMNuPdUYtb4jBA15fo06+xw=; b=C1xIsFayNMMLjBPW
	vfR6bC05l0KIrQJueqQyPz4h7+Qq/fOMXVFGIYQB8GNSMNCLXzJS/Uo7dAJ/vLIg
	PnV8Pt9cQokTqEPLQ8q47vmcaD2BwbXxjqTKV8F04R1Pn8kn9hjlzoq/vDSOKjXf
	7FAAM4qYGsPPStxcpyuzC+/gMkLfwF9ZM9ngP4WB/8zrZOIHKDYryvmJYfQHCGIP
	kythtcaL+Lw1VHoxSVLuS1BBAs72y5FQ7ECRzITWps6fldSGaNb5dqAskL026eZe
	QLc/FtixDYI6Wxvo6AI5Bn4noV7hZEzCGbJb56A2gdTRxp3qR6KZ3Gk8aCK0Rr3g
	QAtULQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ahdkg03-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 14:45:53 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5d7bca30380so3773116137.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 07:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761921952; x=1762526752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idcL2HnaWjhQi3/nWWAzrMNuPdUYtb4jBA15fo06+xw=;
        b=izBaJf7xybBMoCEvS2Vd/HJJItZ63qXhjs8D6krL60GtiNmqcqcywv1Iz8ERmautcB
         e2jmlGPo4fBPa2R1JhGM2/tJbheiI4YrPWAGq9SrITYeG3nrXZQTIbeoqGUiERSgY9Dy
         +5Nsia1GF8kgvqRxcceOj3gwW02rP4dRsvxDoSrujQxf+AzHCSgm/9kDf23wmdpC1MDh
         n2X9zSZ6aMV6Om0SqGjr6BIMdWdtXtxXy7O0wLqkI3p7FIhKpUnv92sfjILOT5AkTclh
         L1ci7pghiC19KJNNyHOuJSJyIr6A49hAKAwBleNe2MRb1SBZPFLzQA5xvlXVvlHSx+KO
         wKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921952; x=1762526752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idcL2HnaWjhQi3/nWWAzrMNuPdUYtb4jBA15fo06+xw=;
        b=YVE2a0+itaU0X3kslQPgvN9FE4qZh/A1bifPk0Y/kXm0xpM2vOw71jozWqlpINzyOa
         Lb5R3Gtg87gixmuwzTkKHem5ZFKIMkO/MmQMm/yg59UzYMIuiM8+4xnp5Bdo2g+q5uiD
         x0x91B/CSauLqHkDOX0P9T1H7/XYuMwLmp+5AE7heKw2ko+hC7g/Ms2cWDlvTcWMW2Uo
         eJVTodwsiDNFlpgd4VuK0wt3OpPY2uGP5NUx6QUrP2Bn/ctVloehr85ayt4/6q7pXXf6
         +VvE/oKFi842TUg/TygKsca7xF0uFPdGyDVpwVHLKC9V7wJ6ydTOEXv7DRD0DK6sJyLO
         lNqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfbovIm0SXpFH4aMfSxVHYXsrLNUEkxGZqPvGBiyhapbOXdnS/QQE2iz9yw9JKQMrNRJKCI3hjgbPRQ4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSswKHjZBqf62hA7pQIN7ysHU2n3o7Gb1JKZSzgrwcsQ7V/8tL
	jIhPuE+vLAcifRVOWEna6ZvjQwdpKZkKFFle/8O79IwZKjRmyrOsBv3O54fcJVMCYep+rzHxc9p
	l49htkU+oZUX/LETLjmFmeMssEbfSEBCUcZT6DhLs/ns8IAdZrH3Prl2RvNv5XngExyk=
X-Gm-Gg: ASbGnctrhWzv4g5zp682Xt1r0l4iCAouFP71k4PNMMTjsg3jV7wOXM9yK4kyhu8nH/c
	JJiS9aQjZPrLgz6kWpADxLUlc+DkwX6ZL87ZF7B3EAIsfgODazwGptCmFM9O2hbEyk6FLp4yxb5
	9xeKPFRMoEnodnGVOPWkJwOjttFuNc+NoBeNc7lee1ByDywF+PX0MfWgt0CNiNVV1zOjjpuTFSV
	8ci0bMUkE11m7YHstQPVJY1RW08zBppnbK+iW2Hui/RkTcRPBUpaus6E+8d2uPGZhEcLNAdDxBt
	Tz0Uc0kM2QwIapksiraLPfK9oBmZEiGhglhbG4kPXIDcMrshnnqu80/djXeV9Qxr4ToZY3EehjA
	t+rugSNFrS0+HVflfGJVGo/+RvjXYxXJIGFl83aHK1ownHHZN/9H+98Kfg5cGVrInPQCTekj8zE
	Kw9TiKpf/oOCIP
X-Received: by 2002:a05:6102:508e:b0:5d7:dec6:389a with SMTP id ada2fe7eead31-5dbb11f7d36mr1272575137.9.1761921951851;
        Fri, 31 Oct 2025 07:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9QWS4BNY+CLDZ/ik9TtpgcLrWtWQpPZU23EPecoV0z0mZ3M6nJtQlJe9MVMvjlSAatpsHng==
X-Received: by 2002:a05:6102:508e:b0:5d7:dec6:389a with SMTP id ada2fe7eead31-5dbb11f7d36mr1272545137.9.1761921951291;
        Fri, 31 Oct 2025 07:45:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bc218sm541405e87.93.2025.10.31.07.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 07:45:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 16:45:30 +0200
Subject: [PATCH v3 14/25] interconnect: qcom: sdx55: convert to dynamic IDs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-rework-icc-v3-14-0575304c9624@oss.qualcomm.com>
References: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
In-Reply-To: <20251031-rework-icc-v3-0-0575304c9624@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=24886;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=g2LQE2frQRxkJb3tGVdeVAOu4CUe6ZQbflK4ewrE+3o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpBMuFgbckwOVSgfBbZhmWj77D8CqWOJw8PQLCa
 g8dw9Rd+uuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQTLhQAKCRCLPIo+Aiko
 1Q/qCACiBzcpiEtD5VzKw1Ap8Tm5F7BlJRPVXfMut/c70PG7HuAyqbtA1GBHbCb4uXilZb7N/cP
 gv7EumYE/WR55ZoOgKeRYGmjBL/pO4jtpirx7PYBkeH5USOUvPIdM/aKPORQXtptVpyrA4gdl4u
 BwXMwt8hnl4OCorp58qMuCsk6P0Cdz0c0kML7ctKwxMUVxDgFf95ohjrHlk+luvx3r3a9BE3PzC
 19ZyXF/ee7Kkn1U8O18jVM7T7QwHE4IMJ/Lb/AxCvmi0+YH24OuXA83V9fL+wRjECWdGy2jkR+U
 ehLAE6hQL7K00DsPSZU3kHAL2oeTnUqrMmXjYzyzaEW/GnQA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEzMyBTYWx0ZWRfXyt8dpeR02YCy
 XnfK3a0cu1rhOnI3LuWx9yGgGdToKb/8b6FlMKK59e0U5loIAMo8NuxM2ZrLKaqn/bOzXAB1g9X
 2fU4IJ/gAm5oKCGSxHWx1zm7feFk35Seqhvj4MurMVpfitl1vM2XEdalA2apc0yKUIQFZ4A9TYO
 dmU/2LEUOOgOUlgL6wBY7rbjFskRv/BjRngJv9EL4Lj8mCEFj48uZJJswud4nRXvdh7e8drtepM
 fPt64VdS2lZaAw4R4nt+B8kJUEbbYVyWZ5WQxISf4eolHR5RdARC7CpHgP5J8X+rbFwlVq87+qH
 EX/vc518a2V4nFRLpYOtHGyR2UgbNfCuSHa7h6hEM1FqXuFkoc3KU7+htPRbL7xpSKRkJT1JI5x
 0B3M97OCC8ezrzoRnu5LOoUy1+hzZw==
X-Proofpoint-GUID: sVamTPwRql4qclGjZBaiJ7jfHTSwiv_b
X-Authority-Analysis: v=2.4 cv=TsnrRTXh c=1 sm=1 tr=0 ts=6904cba1 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=SBZ_mQBx4u5IdJMTS58A:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: sVamTPwRql4qclGjZBaiJ7jfHTSwiv_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310133

Stop using fixed and IDs and covert the platform to use dynamic IDs for
the interconnect. This gives more flexibility and also allows us to drop
the .num_links member, saving from possible errors related to it being
not set or set incorrectly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/sdx55.c | 492 +++++++++++++++++++-------------------
 drivers/interconnect/qcom/sdx55.h |  70 ------
 2 files changed, 242 insertions(+), 320 deletions(-)

diff --git a/drivers/interconnect/qcom/sdx55.c b/drivers/interconnect/qcom/sdx55.c
index 4117db046fa00c634a43d9287711589315f60210..b1a69e430ef444784fdc31edbe1f80877fc63cec 100644
--- a/drivers/interconnect/qcom/sdx55.c
+++ b/drivers/interconnect/qcom/sdx55.c
@@ -17,628 +17,617 @@
 
 #include "bcm-voter.h"
 #include "icc-rpmh.h"
-#include "sdx55.h"
+
+static struct qcom_icc_node llcc_mc;
+static struct qcom_icc_node acm_tcu;
+static struct qcom_icc_node qnm_snoc_gc;
+static struct qcom_icc_node xm_apps_rdwr;
+static struct qcom_icc_node qhm_audio;
+static struct qcom_icc_node qhm_blsp1;
+static struct qcom_icc_node qhm_qdss_bam;
+static struct qcom_icc_node qhm_qpic;
+static struct qcom_icc_node qhm_snoc_cfg;
+static struct qcom_icc_node qhm_spmi_fetcher1;
+static struct qcom_icc_node qnm_aggre_noc;
+static struct qcom_icc_node qnm_ipa;
+static struct qcom_icc_node qnm_memnoc;
+static struct qcom_icc_node qnm_memnoc_pcie;
+static struct qcom_icc_node qxm_crypto;
+static struct qcom_icc_node xm_emac;
+static struct qcom_icc_node xm_ipa2pcie_slv;
+static struct qcom_icc_node xm_pcie;
+static struct qcom_icc_node xm_qdss_etr;
+static struct qcom_icc_node xm_sdc1;
+static struct qcom_icc_node xm_usb3;
+static struct qcom_icc_node ebi;
+static struct qcom_icc_node qns_llcc;
+static struct qcom_icc_node qns_memnoc_snoc;
+static struct qcom_icc_node qns_sys_pcie;
+static struct qcom_icc_node qhs_aop;
+static struct qcom_icc_node qhs_aoss;
+static struct qcom_icc_node qhs_apss;
+static struct qcom_icc_node qhs_audio;
+static struct qcom_icc_node qhs_blsp1;
+static struct qcom_icc_node qhs_clk_ctl;
+static struct qcom_icc_node qhs_crypto0_cfg;
+static struct qcom_icc_node qhs_ddrss_cfg;
+static struct qcom_icc_node qhs_ecc_cfg;
+static struct qcom_icc_node qhs_emac_cfg;
+static struct qcom_icc_node qhs_imem_cfg;
+static struct qcom_icc_node qhs_ipa;
+static struct qcom_icc_node qhs_mss_cfg;
+static struct qcom_icc_node qhs_pcie_parf;
+static struct qcom_icc_node qhs_pdm;
+static struct qcom_icc_node qhs_prng;
+static struct qcom_icc_node qhs_qdss_cfg;
+static struct qcom_icc_node qhs_qpic;
+static struct qcom_icc_node qhs_sdc1;
+static struct qcom_icc_node qhs_snoc_cfg;
+static struct qcom_icc_node qhs_spmi_fetcher;
+static struct qcom_icc_node qhs_spmi_vgi_coex;
+static struct qcom_icc_node qhs_tcsr;
+static struct qcom_icc_node qhs_tlmm;
+static struct qcom_icc_node qhs_usb3;
+static struct qcom_icc_node qhs_usb3_phy;
+static struct qcom_icc_node qns_aggre_noc;
+static struct qcom_icc_node qns_snoc_memnoc;
+static struct qcom_icc_node qxs_imem;
+static struct qcom_icc_node srvc_snoc;
+static struct qcom_icc_node xs_pcie;
+static struct qcom_icc_node xs_qdss_stm;
+static struct qcom_icc_node xs_sys_tcu_cfg;
 
 static struct qcom_icc_node llcc_mc = {
 	.name = "llcc_mc",
-	.id = SDX55_MASTER_LLCC,
 	.channels = 4,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_EBI_CH0 },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_node acm_tcu = {
 	.name = "acm_tcu",
-	.id = SDX55_MASTER_TCU_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 3,
-	.links = { SDX55_SLAVE_LLCC,
-		   SDX55_SLAVE_MEM_NOC_SNOC,
-		   SDX55_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_memnoc_snoc,
+			&qns_sys_pcie },
 };
 
 static struct qcom_icc_node qnm_snoc_gc = {
 	.name = "qnm_snoc_gc",
-	.id = SDX55_MASTER_SNOC_GC_MEM_NOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_LLCC },
+	.link_nodes = { &qns_llcc },
 };
 
 static struct qcom_icc_node xm_apps_rdwr = {
 	.name = "xm_apps_rdwr",
-	.id = SDX55_MASTER_AMPSS_M0,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 3,
-	.links = { SDX55_SLAVE_LLCC,
-		   SDX55_SLAVE_MEM_NOC_SNOC,
-		   SDX55_SLAVE_MEM_NOC_PCIE_SNOC
-	},
+	.link_nodes = { &qns_llcc,
+			&qns_memnoc_snoc,
+			&qns_sys_pcie },
 };
 
 static struct qcom_icc_node qhm_audio = {
 	.name = "qhm_audio",
-	.id = SDX55_MASTER_AUDIO,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc },
 };
 
 static struct qcom_icc_node qhm_blsp1 = {
 	.name = "qhm_blsp1",
-	.id = SDX55_MASTER_BLSP_1,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc },
 };
 
 static struct qcom_icc_node qhm_qdss_bam = {
 	.name = "qhm_qdss_bam",
-	.id = SDX55_MASTER_QDSS_BAM,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 28,
-	.links = { SDX55_SLAVE_SNOC_CFG,
-		   SDX55_SLAVE_EMAC_CFG,
-		   SDX55_SLAVE_USB3,
-		   SDX55_SLAVE_TLMM,
-		   SDX55_SLAVE_SPMI_FETCHER,
-		   SDX55_SLAVE_QDSS_CFG,
-		   SDX55_SLAVE_PDM,
-		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
-		   SDX55_SLAVE_TCSR,
-		   SDX55_SLAVE_CNOC_DDRSS,
-		   SDX55_SLAVE_SPMI_VGI_COEX,
-		   SDX55_SLAVE_QPIC,
-		   SDX55_SLAVE_OCIMEM,
-		   SDX55_SLAVE_IPA_CFG,
-		   SDX55_SLAVE_USB3_PHY_CFG,
-		   SDX55_SLAVE_AOP,
-		   SDX55_SLAVE_BLSP_1,
-		   SDX55_SLAVE_SDCC_1,
-		   SDX55_SLAVE_CNOC_MSS,
-		   SDX55_SLAVE_PCIE_PARF,
-		   SDX55_SLAVE_ECC_CFG,
-		   SDX55_SLAVE_AUDIO,
-		   SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_PRNG,
-		   SDX55_SLAVE_CRYPTO_0_CFG,
-		   SDX55_SLAVE_TCU,
-		   SDX55_SLAVE_CLK_CTL,
-		   SDX55_SLAVE_IMEM_CFG
-	},
+	.link_nodes = { &qhs_snoc_cfg,
+			&qhs_emac_cfg,
+			&qhs_usb3,
+			&qhs_tlmm,
+			&qhs_spmi_fetcher,
+			&qhs_qdss_cfg,
+			&qhs_pdm,
+			&qns_snoc_memnoc,
+			&qhs_tcsr,
+			&qhs_ddrss_cfg,
+			&qhs_spmi_vgi_coex,
+			&qhs_qpic,
+			&qxs_imem,
+			&qhs_ipa,
+			&qhs_usb3_phy,
+			&qhs_aop,
+			&qhs_blsp1,
+			&qhs_sdc1,
+			&qhs_mss_cfg,
+			&qhs_pcie_parf,
+			&qhs_ecc_cfg,
+			&qhs_audio,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_crypto0_cfg,
+			&xs_sys_tcu_cfg,
+			&qhs_clk_ctl,
+			&qhs_imem_cfg },
 };
 
 static struct qcom_icc_node qhm_qpic = {
 	.name = "qhm_qpic",
-	.id = SDX55_MASTER_QPIC,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 5,
-	.links = { SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_IPA_CFG,
-		   SDX55_SLAVE_ANOC_SNOC,
-		   SDX55_SLAVE_AOP,
-		   SDX55_SLAVE_AUDIO
-	},
+	.link_nodes = { &qhs_aoss,
+			&qhs_ipa,
+			&qns_aggre_noc,
+			&qhs_aop,
+			&qhs_audio },
 };
 
 static struct qcom_icc_node qhm_snoc_cfg = {
 	.name = "qhm_snoc_cfg",
-	.id = SDX55_MASTER_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_SERVICE_SNOC },
+	.link_nodes = { &srvc_snoc },
 };
 
 static struct qcom_icc_node qhm_spmi_fetcher1 = {
 	.name = "qhm_spmi_fetcher1",
-	.id = SDX55_MASTER_SPMI_FETCHER,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 3,
-	.links = { SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_ANOC_SNOC,
-		   SDX55_SLAVE_AOP
-	},
+	.link_nodes = { &qhs_aoss,
+			&qns_aggre_noc,
+			&qhs_aop },
 };
 
 static struct qcom_icc_node qnm_aggre_noc = {
 	.name = "qnm_aggre_noc",
-	.id = SDX55_MASTER_ANOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 30,
-	.links = { SDX55_SLAVE_PCIE_0,
-		   SDX55_SLAVE_SNOC_CFG,
-		   SDX55_SLAVE_SDCC_1,
-		   SDX55_SLAVE_TLMM,
-		   SDX55_SLAVE_SPMI_FETCHER,
-		   SDX55_SLAVE_QDSS_CFG,
-		   SDX55_SLAVE_PDM,
-		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
-		   SDX55_SLAVE_TCSR,
-		   SDX55_SLAVE_CNOC_DDRSS,
-		   SDX55_SLAVE_SPMI_VGI_COEX,
-		   SDX55_SLAVE_QDSS_STM,
-		   SDX55_SLAVE_QPIC,
-		   SDX55_SLAVE_OCIMEM,
-		   SDX55_SLAVE_IPA_CFG,
-		   SDX55_SLAVE_USB3_PHY_CFG,
-		   SDX55_SLAVE_AOP,
-		   SDX55_SLAVE_BLSP_1,
-		   SDX55_SLAVE_USB3,
-		   SDX55_SLAVE_CNOC_MSS,
-		   SDX55_SLAVE_PCIE_PARF,
-		   SDX55_SLAVE_ECC_CFG,
-		   SDX55_SLAVE_APPSS,
-		   SDX55_SLAVE_AUDIO,
-		   SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_PRNG,
-		   SDX55_SLAVE_CRYPTO_0_CFG,
-		   SDX55_SLAVE_TCU,
-		   SDX55_SLAVE_CLK_CTL,
-		   SDX55_SLAVE_IMEM_CFG
-	},
+	.link_nodes = { &xs_pcie,
+			&qhs_snoc_cfg,
+			&qhs_sdc1,
+			&qhs_tlmm,
+			&qhs_spmi_fetcher,
+			&qhs_qdss_cfg,
+			&qhs_pdm,
+			&qns_snoc_memnoc,
+			&qhs_tcsr,
+			&qhs_ddrss_cfg,
+			&qhs_spmi_vgi_coex,
+			&xs_qdss_stm,
+			&qhs_qpic,
+			&qxs_imem,
+			&qhs_ipa,
+			&qhs_usb3_phy,
+			&qhs_aop,
+			&qhs_blsp1,
+			&qhs_usb3,
+			&qhs_mss_cfg,
+			&qhs_pcie_parf,
+			&qhs_ecc_cfg,
+			&qhs_apss,
+			&qhs_audio,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_crypto0_cfg,
+			&xs_sys_tcu_cfg,
+			&qhs_clk_ctl,
+			&qhs_imem_cfg },
 };
 
 static struct qcom_icc_node qnm_ipa = {
 	.name = "qnm_ipa",
-	.id = SDX55_MASTER_IPA,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 27,
-	.links = { SDX55_SLAVE_SNOC_CFG,
-		   SDX55_SLAVE_EMAC_CFG,
-		   SDX55_SLAVE_USB3,
-		   SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_SPMI_FETCHER,
-		   SDX55_SLAVE_QDSS_CFG,
-		   SDX55_SLAVE_PDM,
-		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
-		   SDX55_SLAVE_TCSR,
-		   SDX55_SLAVE_CNOC_DDRSS,
-		   SDX55_SLAVE_QDSS_STM,
-		   SDX55_SLAVE_QPIC,
-		   SDX55_SLAVE_OCIMEM,
-		   SDX55_SLAVE_IPA_CFG,
-		   SDX55_SLAVE_USB3_PHY_CFG,
-		   SDX55_SLAVE_AOP,
-		   SDX55_SLAVE_BLSP_1,
-		   SDX55_SLAVE_SDCC_1,
-		   SDX55_SLAVE_CNOC_MSS,
-		   SDX55_SLAVE_PCIE_PARF,
-		   SDX55_SLAVE_ECC_CFG,
-		   SDX55_SLAVE_AUDIO,
-		   SDX55_SLAVE_TLMM,
-		   SDX55_SLAVE_PRNG,
-		   SDX55_SLAVE_CRYPTO_0_CFG,
-		   SDX55_SLAVE_CLK_CTL,
-		   SDX55_SLAVE_IMEM_CFG
-	},
+	.link_nodes = { &qhs_snoc_cfg,
+			&qhs_emac_cfg,
+			&qhs_usb3,
+			&qhs_aoss,
+			&qhs_spmi_fetcher,
+			&qhs_qdss_cfg,
+			&qhs_pdm,
+			&qns_snoc_memnoc,
+			&qhs_tcsr,
+			&qhs_ddrss_cfg,
+			&xs_qdss_stm,
+			&qhs_qpic,
+			&qxs_imem,
+			&qhs_ipa,
+			&qhs_usb3_phy,
+			&qhs_aop,
+			&qhs_blsp1,
+			&qhs_sdc1,
+			&qhs_mss_cfg,
+			&qhs_pcie_parf,
+			&qhs_ecc_cfg,
+			&qhs_audio,
+			&qhs_tlmm,
+			&qhs_prng,
+			&qhs_crypto0_cfg,
+			&qhs_clk_ctl,
+			&qhs_imem_cfg },
 };
 
 static struct qcom_icc_node qnm_memnoc = {
 	.name = "qnm_memnoc",
-	.id = SDX55_MASTER_MEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 29,
-	.links = { SDX55_SLAVE_SNOC_CFG,
-		   SDX55_SLAVE_EMAC_CFG,
-		   SDX55_SLAVE_USB3,
-		   SDX55_SLAVE_TLMM,
-		   SDX55_SLAVE_SPMI_FETCHER,
-		   SDX55_SLAVE_QDSS_CFG,
-		   SDX55_SLAVE_PDM,
-		   SDX55_SLAVE_TCSR,
-		   SDX55_SLAVE_CNOC_DDRSS,
-		   SDX55_SLAVE_SPMI_VGI_COEX,
-		   SDX55_SLAVE_QDSS_STM,
-		   SDX55_SLAVE_QPIC,
-		   SDX55_SLAVE_OCIMEM,
-		   SDX55_SLAVE_IPA_CFG,
-		   SDX55_SLAVE_USB3_PHY_CFG,
-		   SDX55_SLAVE_AOP,
-		   SDX55_SLAVE_BLSP_1,
-		   SDX55_SLAVE_SDCC_1,
-		   SDX55_SLAVE_CNOC_MSS,
-		   SDX55_SLAVE_PCIE_PARF,
-		   SDX55_SLAVE_ECC_CFG,
-		   SDX55_SLAVE_APPSS,
-		   SDX55_SLAVE_AUDIO,
-		   SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_PRNG,
-		   SDX55_SLAVE_CRYPTO_0_CFG,
-		   SDX55_SLAVE_TCU,
-		   SDX55_SLAVE_CLK_CTL,
-		   SDX55_SLAVE_IMEM_CFG
-	},
+	.link_nodes = { &qhs_snoc_cfg,
+			&qhs_emac_cfg,
+			&qhs_usb3,
+			&qhs_tlmm,
+			&qhs_spmi_fetcher,
+			&qhs_qdss_cfg,
+			&qhs_pdm,
+			&qhs_tcsr,
+			&qhs_ddrss_cfg,
+			&qhs_spmi_vgi_coex,
+			&xs_qdss_stm,
+			&qhs_qpic,
+			&qxs_imem,
+			&qhs_ipa,
+			&qhs_usb3_phy,
+			&qhs_aop,
+			&qhs_blsp1,
+			&qhs_sdc1,
+			&qhs_mss_cfg,
+			&qhs_pcie_parf,
+			&qhs_ecc_cfg,
+			&qhs_apss,
+			&qhs_audio,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_crypto0_cfg,
+			&xs_sys_tcu_cfg,
+			&qhs_clk_ctl,
+			&qhs_imem_cfg },
 };
 
 static struct qcom_icc_node qnm_memnoc_pcie = {
 	.name = "qnm_memnoc_pcie",
-	.id = SDX55_MASTER_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_PCIE_0 },
+	.link_nodes = { &xs_pcie },
 };
 
 static struct qcom_icc_node qxm_crypto = {
 	.name = "qxm_crypto",
-	.id = SDX55_MASTER_CRYPTO_CORE_0,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 3,
-	.links = { SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_ANOC_SNOC,
-		   SDX55_SLAVE_AOP
-	},
+	.link_nodes = { &qhs_aoss,
+			&qns_aggre_noc,
+			&qhs_aop },
 };
 
 static struct qcom_icc_node xm_emac = {
 	.name = "xm_emac",
-	.id = SDX55_MASTER_EMAC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc },
 };
 
 static struct qcom_icc_node xm_ipa2pcie_slv = {
 	.name = "xm_ipa2pcie_slv",
-	.id = SDX55_MASTER_IPA_PCIE,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_PCIE_0 },
+	.link_nodes = { &xs_pcie },
 };
 
 static struct qcom_icc_node xm_pcie = {
 	.name = "xm_pcie",
-	.id = SDX55_MASTER_PCIE,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc },
 };
 
 static struct qcom_icc_node xm_qdss_etr = {
 	.name = "xm_qdss_etr",
-	.id = SDX55_MASTER_QDSS_ETR,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 28,
-	.links = { SDX55_SLAVE_SNOC_CFG,
-		   SDX55_SLAVE_EMAC_CFG,
-		   SDX55_SLAVE_USB3,
-		   SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_SPMI_FETCHER,
-		   SDX55_SLAVE_QDSS_CFG,
-		   SDX55_SLAVE_PDM,
-		   SDX55_SLAVE_SNOC_MEM_NOC_GC,
-		   SDX55_SLAVE_TCSR,
-		   SDX55_SLAVE_CNOC_DDRSS,
-		   SDX55_SLAVE_SPMI_VGI_COEX,
-		   SDX55_SLAVE_QPIC,
-		   SDX55_SLAVE_OCIMEM,
-		   SDX55_SLAVE_IPA_CFG,
-		   SDX55_SLAVE_USB3_PHY_CFG,
-		   SDX55_SLAVE_AOP,
-		   SDX55_SLAVE_BLSP_1,
-		   SDX55_SLAVE_SDCC_1,
-		   SDX55_SLAVE_CNOC_MSS,
-		   SDX55_SLAVE_PCIE_PARF,
-		   SDX55_SLAVE_ECC_CFG,
-		   SDX55_SLAVE_AUDIO,
-		   SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_PRNG,
-		   SDX55_SLAVE_CRYPTO_0_CFG,
-		   SDX55_SLAVE_TCU,
-		   SDX55_SLAVE_CLK_CTL,
-		   SDX55_SLAVE_IMEM_CFG
-	},
+	.link_nodes = { &qhs_snoc_cfg,
+			&qhs_emac_cfg,
+			&qhs_usb3,
+			&qhs_aoss,
+			&qhs_spmi_fetcher,
+			&qhs_qdss_cfg,
+			&qhs_pdm,
+			&qns_snoc_memnoc,
+			&qhs_tcsr,
+			&qhs_ddrss_cfg,
+			&qhs_spmi_vgi_coex,
+			&qhs_qpic,
+			&qxs_imem,
+			&qhs_ipa,
+			&qhs_usb3_phy,
+			&qhs_aop,
+			&qhs_blsp1,
+			&qhs_sdc1,
+			&qhs_mss_cfg,
+			&qhs_pcie_parf,
+			&qhs_ecc_cfg,
+			&qhs_audio,
+			&qhs_aoss,
+			&qhs_prng,
+			&qhs_crypto0_cfg,
+			&xs_sys_tcu_cfg,
+			&qhs_clk_ctl,
+			&qhs_imem_cfg },
 };
 
 static struct qcom_icc_node xm_sdc1 = {
 	.name = "xm_sdc1",
-	.id = SDX55_MASTER_SDCC_1,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 5,
-	.links = { SDX55_SLAVE_AOSS,
-		   SDX55_SLAVE_IPA_CFG,
-		   SDX55_SLAVE_ANOC_SNOC,
-		   SDX55_SLAVE_AOP,
-		   SDX55_SLAVE_AUDIO
-	},
+	.link_nodes = { &qhs_aoss,
+			&qhs_ipa,
+			&qns_aggre_noc,
+			&qhs_aop,
+			&qhs_audio },
 };
 
 static struct qcom_icc_node xm_usb3 = {
 	.name = "xm_usb3",
-	.id = SDX55_MASTER_USB3,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_ANOC_SNOC },
+	.link_nodes = { &qns_aggre_noc },
 };
 
 static struct qcom_icc_node ebi = {
 	.name = "ebi",
-	.id = SDX55_SLAVE_EBI_CH0,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_llcc = {
 	.name = "qns_llcc",
-	.id = SDX55_SLAVE_LLCC,
 	.channels = 1,
 	.buswidth = 16,
 	.num_links = 1,
-	.links = { SDX55_SLAVE_EBI_CH0 },
+	.link_nodes = { &ebi },
 };
 
 static struct qcom_icc_node qns_memnoc_snoc = {
 	.name = "qns_memnoc_snoc",
-	.id = SDX55_SLAVE_MEM_NOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_MASTER_MEM_NOC_SNOC },
+	.link_nodes = { &qnm_memnoc },
 };
 
 static struct qcom_icc_node qns_sys_pcie = {
 	.name = "qns_sys_pcie",
-	.id = SDX55_SLAVE_MEM_NOC_PCIE_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_MASTER_MEM_NOC_PCIE_SNOC },
+	.link_nodes = { &qnm_memnoc_pcie },
 };
 
 static struct qcom_icc_node qhs_aop = {
 	.name = "qhs_aop",
-	.id = SDX55_SLAVE_AOP,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_aoss = {
 	.name = "qhs_aoss",
-	.id = SDX55_SLAVE_AOSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_apss = {
 	.name = "qhs_apss",
-	.id = SDX55_SLAVE_APPSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_audio = {
 	.name = "qhs_audio",
-	.id = SDX55_SLAVE_AUDIO,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_blsp1 = {
 	.name = "qhs_blsp1",
-	.id = SDX55_SLAVE_BLSP_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_clk_ctl = {
 	.name = "qhs_clk_ctl",
-	.id = SDX55_SLAVE_CLK_CTL,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_crypto0_cfg = {
 	.name = "qhs_crypto0_cfg",
-	.id = SDX55_SLAVE_CRYPTO_0_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ddrss_cfg = {
 	.name = "qhs_ddrss_cfg",
-	.id = SDX55_SLAVE_CNOC_DDRSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ecc_cfg = {
 	.name = "qhs_ecc_cfg",
-	.id = SDX55_SLAVE_ECC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_emac_cfg = {
 	.name = "qhs_emac_cfg",
-	.id = SDX55_SLAVE_EMAC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_imem_cfg = {
 	.name = "qhs_imem_cfg",
-	.id = SDX55_SLAVE_IMEM_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_ipa = {
 	.name = "qhs_ipa",
-	.id = SDX55_SLAVE_IPA_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_mss_cfg = {
 	.name = "qhs_mss_cfg",
-	.id = SDX55_SLAVE_CNOC_MSS,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pcie_parf = {
 	.name = "qhs_pcie_parf",
-	.id = SDX55_SLAVE_PCIE_PARF,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_pdm = {
 	.name = "qhs_pdm",
-	.id = SDX55_SLAVE_PDM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_prng = {
 	.name = "qhs_prng",
-	.id = SDX55_SLAVE_PRNG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qdss_cfg = {
 	.name = "qhs_qdss_cfg",
-	.id = SDX55_SLAVE_QDSS_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_qpic = {
 	.name = "qhs_qpic",
-	.id = SDX55_SLAVE_QPIC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_sdc1 = {
 	.name = "qhs_sdc1",
-	.id = SDX55_SLAVE_SDCC_1,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_snoc_cfg = {
 	.name = "qhs_snoc_cfg",
-	.id = SDX55_SLAVE_SNOC_CFG,
 	.channels = 1,
 	.buswidth = 4,
 	.num_links = 1,
-	.links = { SDX55_MASTER_SNOC_CFG },
+	.link_nodes = { &qhm_snoc_cfg },
 };
 
 static struct qcom_icc_node qhs_spmi_fetcher = {
 	.name = "qhs_spmi_fetcher",
-	.id = SDX55_SLAVE_SPMI_FETCHER,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_spmi_vgi_coex = {
 	.name = "qhs_spmi_vgi_coex",
-	.id = SDX55_SLAVE_SPMI_VGI_COEX,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tcsr = {
 	.name = "qhs_tcsr",
-	.id = SDX55_SLAVE_TCSR,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_tlmm = {
 	.name = "qhs_tlmm",
-	.id = SDX55_SLAVE_TLMM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_usb3 = {
 	.name = "qhs_usb3",
-	.id = SDX55_SLAVE_USB3,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qhs_usb3_phy = {
 	.name = "qhs_usb3_phy",
-	.id = SDX55_SLAVE_USB3_PHY_CFG,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node qns_aggre_noc = {
 	.name = "qns_aggre_noc",
-	.id = SDX55_SLAVE_ANOC_SNOC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_MASTER_ANOC_SNOC },
+	.link_nodes = { &qnm_aggre_noc },
 };
 
 static struct qcom_icc_node qns_snoc_memnoc = {
 	.name = "qns_snoc_memnoc",
-	.id = SDX55_SLAVE_SNOC_MEM_NOC_GC,
 	.channels = 1,
 	.buswidth = 8,
 	.num_links = 1,
-	.links = { SDX55_MASTER_SNOC_GC_MEM_NOC },
+	.link_nodes = { &qnm_snoc_gc },
 };
 
 static struct qcom_icc_node qxs_imem = {
 	.name = "qxs_imem",
-	.id = SDX55_SLAVE_OCIMEM,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node srvc_snoc = {
 	.name = "srvc_snoc",
-	.id = SDX55_SLAVE_SERVICE_SNOC,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node xs_pcie = {
 	.name = "xs_pcie",
-	.id = SDX55_SLAVE_PCIE_0,
 	.channels = 1,
 	.buswidth = 8,
 };
 
 static struct qcom_icc_node xs_qdss_stm = {
 	.name = "xs_qdss_stm",
-	.id = SDX55_SLAVE_QDSS_STM,
 	.channels = 1,
 	.buswidth = 4,
 };
 
 static struct qcom_icc_node xs_sys_tcu_cfg = {
 	.name = "xs_sys_tcu_cfg",
-	.id = SDX55_SLAVE_TCU,
 	.channels = 1,
 	.buswidth = 8,
 };
@@ -793,6 +782,7 @@ static struct qcom_icc_node * const mc_virt_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx55_mc_virt = {
+	.alloc_dyn_id = true,
 	.nodes = mc_virt_nodes,
 	.num_nodes = ARRAY_SIZE(mc_virt_nodes),
 	.bcms = mc_virt_bcms,
@@ -815,6 +805,7 @@ static struct qcom_icc_node * const mem_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx55_mem_noc = {
+	.alloc_dyn_id = true,
 	.nodes = mem_noc_nodes,
 	.num_nodes = ARRAY_SIZE(mem_noc_nodes),
 	.bcms = mem_noc_bcms,
@@ -894,6 +885,7 @@ static struct qcom_icc_node * const system_noc_nodes[] = {
 };
 
 static const struct qcom_icc_desc sdx55_system_noc = {
+	.alloc_dyn_id = true,
 	.nodes = system_noc_nodes,
 	.num_nodes = ARRAY_SIZE(system_noc_nodes),
 	.bcms = system_noc_bcms,
diff --git a/drivers/interconnect/qcom/sdx55.h b/drivers/interconnect/qcom/sdx55.h
deleted file mode 100644
index 46cbabec8aa1f95be840e50618efd04bcbf89f10..0000000000000000000000000000000000000000
--- a/drivers/interconnect/qcom/sdx55.h
+++ /dev/null
@@ -1,70 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2021, Linaro Ltd.
- */
-
-#ifndef __DRIVERS_INTERCONNECT_QCOM_SDX55_H
-#define __DRIVERS_INTERCONNECT_QCOM_SDX55_H
-
-/* 0 was used by MASTER_IPA_CORE, now represented as RPMh clock */
-#define SDX55_MASTER_LLCC			1
-#define SDX55_MASTER_TCU_0			2
-#define SDX55_MASTER_SNOC_GC_MEM_NOC		3
-#define SDX55_MASTER_AMPSS_M0			4
-#define SDX55_MASTER_AUDIO			5
-#define SDX55_MASTER_BLSP_1			6
-#define SDX55_MASTER_QDSS_BAM			7
-#define SDX55_MASTER_QPIC			8
-#define SDX55_MASTER_SNOC_CFG			9
-#define SDX55_MASTER_SPMI_FETCHER		10
-#define SDX55_MASTER_ANOC_SNOC			11
-#define SDX55_MASTER_IPA			12
-#define SDX55_MASTER_MEM_NOC_SNOC		13
-#define SDX55_MASTER_MEM_NOC_PCIE_SNOC		14
-#define SDX55_MASTER_CRYPTO_CORE_0		15
-#define SDX55_MASTER_EMAC			16
-#define SDX55_MASTER_IPA_PCIE			17
-#define SDX55_MASTER_PCIE			18
-#define SDX55_MASTER_QDSS_ETR			19
-#define SDX55_MASTER_SDCC_1			20
-#define SDX55_MASTER_USB3			21
-/* 22 was used by SLAVE_IPA_CORE, now represented as RPMh clock */
-#define SDX55_SLAVE_EBI_CH0			23
-#define SDX55_SLAVE_LLCC			24
-#define SDX55_SLAVE_MEM_NOC_SNOC		25
-#define SDX55_SLAVE_MEM_NOC_PCIE_SNOC		26
-#define SDX55_SLAVE_ANOC_SNOC			27
-#define SDX55_SLAVE_SNOC_CFG			28
-#define SDX55_SLAVE_EMAC_CFG			29
-#define SDX55_SLAVE_USB3			30
-#define SDX55_SLAVE_TLMM			31
-#define SDX55_SLAVE_SPMI_FETCHER		32
-#define SDX55_SLAVE_QDSS_CFG			33
-#define SDX55_SLAVE_PDM				34
-#define SDX55_SLAVE_SNOC_MEM_NOC_GC		35
-#define SDX55_SLAVE_TCSR			36
-#define SDX55_SLAVE_CNOC_DDRSS			37
-#define SDX55_SLAVE_SPMI_VGI_COEX		38
-#define SDX55_SLAVE_QPIC			39
-#define SDX55_SLAVE_OCIMEM			40
-#define SDX55_SLAVE_IPA_CFG			41
-#define SDX55_SLAVE_USB3_PHY_CFG		42
-#define SDX55_SLAVE_AOP				43
-#define SDX55_SLAVE_BLSP_1			44
-#define SDX55_SLAVE_SDCC_1			45
-#define SDX55_SLAVE_CNOC_MSS			46
-#define SDX55_SLAVE_PCIE_PARF			47
-#define SDX55_SLAVE_ECC_CFG			48
-#define SDX55_SLAVE_AUDIO			49
-#define SDX55_SLAVE_AOSS			51
-#define SDX55_SLAVE_PRNG			52
-#define SDX55_SLAVE_CRYPTO_0_CFG		53
-#define SDX55_SLAVE_TCU				54
-#define SDX55_SLAVE_CLK_CTL			55
-#define SDX55_SLAVE_IMEM_CFG			56
-#define SDX55_SLAVE_SERVICE_SNOC		57
-#define SDX55_SLAVE_PCIE_0			58
-#define SDX55_SLAVE_QDSS_STM			59
-#define SDX55_SLAVE_APPSS			60
-
-#endif

-- 
2.47.3


