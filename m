Return-Path: <linux-kernel+bounces-604059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90FCA89015
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 01:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF96E189B432
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 23:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9291204C2E;
	Mon, 14 Apr 2025 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iBFb89oQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C41FDE0E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672940; cv=none; b=hHCj1pwiw8JNCxLn8msGgfIc1xCu0o7NLPnjK9mPaK1N/yYbwna2rRRzBPJDBVIepzoWauhP+WoAm6gptSlZW1NBQ2GKb7plSa7ZizOQ00kiJ5EAoA+ZBd0K26lHgFSOkdJdT7IaO1ZX4b8mOiWmrCiPR3YK8J43y/eXPk+lPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672940; c=relaxed/simple;
	bh=xw9iTAYW3wAWgA6jz5SdeA8HGg3RiSjVSAOIj/JJ6IA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QuqzxFeSXDUprNJyIqwql7NPtTDaGk4A92g3Dx6neRYdZPa37vxBHwC7w0S5pr7rC02x3EVecgQecam6UZ+37pr8a/IlTGSlvBjWYEYkrpVRvPtuNjlhYOWqmhfNV56RfM8pGIE7WEHXAsiMSc3gBtUGSWxurcxuY8vRoiVHpdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iBFb89oQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EKfWah010722
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 23:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GTdAMQ7ag00m3H0U5PPWTLR6nTZ4ufRKT9L1Ylw3HD4=; b=iBFb89oQYCJJ9az2
	0bKM6nW6JWXF2vsoMDOr3dbTEvGBIEXGbVvmytlf6T5Z/P1xhBGZzBLtze8vQIYM
	POyJMwHgpDGE10DHFkBE/X4eyfjDotIHntQjo2ryj6F19RF9uRDXP2+bZj19Y3Uh
	SH5C9ya9r45QcRgFd/oVFoYMH7Kb8U45K0HzcutEsnsiCsX7s57HGd/ASdJN07zc
	WXWnZMTl0HPbgC5fcnTum8XdqUimj2Gnefw4Bn7gpgxBRBJXMcem2Ae4ae2cjKJe
	JLWE7cZ8AOGWFemYQfMZbSJeAlT6AECHExeD3tD99Dndk+2sq6GI4YDKjILFpLLO
	AW1SvA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygd6e23p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 23:22:17 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-736cb72efd5so4209110b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 16:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744672937; x=1745277737;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTdAMQ7ag00m3H0U5PPWTLR6nTZ4ufRKT9L1Ylw3HD4=;
        b=LdtkZIDg0Lao8HcraFyV8r3HF5aK48//2I0t9ySFC4Z1AylzuLbVdjh07IGU1Fwoit
         A3L7O5rd1p4boHDLGLBs+/1KtzNuEKNhEQUgefH8Z9JonMxwil/JxE/UY68pSYlcgBeQ
         XyxcO2CpmHrOCG6vqgRHgg8RhGvZ61qc1+L11wMqe8nAnjCOB26fa9cCl6QOy90i/3lh
         6UGgajEj7Nvr3qr5FPZdhh0Smx8NB8QhhXbqynia/Ro74ZrYG/Q50CPRV6pGN0GrKQ4w
         zGaIztJN3E4IMPU02ulZnUzOCw1lUOlOykPEVgbw6HSOqbTBVO85me3YsfYiPMMOx3Ep
         tt5g==
X-Forwarded-Encrypted: i=1; AJvYcCWMDy5ceN9CmzxO2migTpUNY3YHRNVvZr8BPXP2k2sxK7eneUY1XXehT4kkUJ2e8f5YJ5MmKEUvNx308JU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jX/k3FFBh8V1LbWqS9kWr/CtUfwXsHkVHXAEaA9Wus85J6gW
	SRCDejt035UYU5kM5dZUBIpRpfiG6/cPG8mpLSl3A1qzM8LbKyxt6WRNfVphf8VJGnPdI7xFacx
	XccRp6f+VfBpKbfBhdudVNvh4FnHIB9fiG788hI3TjxblgGjk4aiWtUCHZgFr2Go=
X-Gm-Gg: ASbGncvQVdn4G2hVH3eCCssaGk2YfLIihEfciygV+HdpFS2FhluZfoGwBpwi3yZs71Y
	EKvbYLrTX1xe5KO8gNM8g3DpFCu3k0XYVmm4kAEAtBAmZEW+69D89jppuqzXJXWRMjXOxVp2vL/
	Mzz9Rk/2UW3n6ueKVLAALjvITpGZoUszA+amDepkN3DWrOGMmJsprokwJnekUhAyPc+U1aaYOlQ
	P9kGDdU1YB600I18BDKrxDbC5L4iARSQAsXVvqDnZUET+AgGUaQCy2pjth3lfxyuRMIKiLiba/Z
	ShhDjKRlDhoje3xTZpoVwRNFY5GOxXpVtJgeXZ0wSUtPLu2zYGQSAmUc1hunkVhFXk4=
X-Received: by 2002:a05:6a20:d48e:b0:1f5:75a9:526c with SMTP id adf61e73a8af0-2017979ae17mr21456283637.13.1744672936546;
        Mon, 14 Apr 2025 16:22:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGembd/kNZwSo4Cj0hssIBBDS+r741hbe8C6Ut16g8FXkuAQzapx832X3btapP/sd0pOgKppg==
X-Received: by 2002:a05:6a20:d48e:b0:1f5:75a9:526c with SMTP id adf61e73a8af0-2017979ae17mr21456245637.13.1744672936020;
        Mon, 14 Apr 2025 16:22:16 -0700 (PDT)
Received: from hu-molvera-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a3221c7bsm9746298a12.71.2025.04.14.16.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 16:22:15 -0700 (PDT)
From: Melody Olvera <melody.olvera@oss.qualcomm.com>
Date: Mon, 14 Apr 2025 16:21:51 -0700
Subject: [PATCH v4 2/4] soc: qcom: llcc-qcom: Add support for LLCC V6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-sm8750_llcc_master-v4-2-e007f035380c@oss.qualcomm.com>
References: <20250414-sm8750_llcc_master-v4-0-e007f035380c@oss.qualcomm.com>
In-Reply-To: <20250414-sm8750_llcc_master-v4-0-e007f035380c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Melody Olvera <melody.olvera@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744672932; l=10510;
 i=melody.olvera@oss.qualcomm.com; s=20241204; h=from:subject:message-id;
 bh=xw9iTAYW3wAWgA6jz5SdeA8HGg3RiSjVSAOIj/JJ6IA=;
 b=KTsnT/65d7GETxZPC3aZ+QwA8hI3dQ3hFSXoTm+xOd5h7zWLAcgYKlSuBidRNBNNetKl/NQez
 bFWlotYr/fHAVVrHKLD4iXS6jq71Mnf7Ux0iWBc/iRiJBM3afW5YgW/
X-Developer-Key: i=melody.olvera@oss.qualcomm.com; a=ed25519;
 pk=1DGLp3zVYsHAWipMaNZZTHR321e8xK52C9vuAoeca5c=
X-Proofpoint-ORIG-GUID: d_5ycgY62s0ZRsQvvz9gpI9ULsERBAtv
X-Proofpoint-GUID: d_5ycgY62s0ZRsQvvz9gpI9ULsERBAtv
X-Authority-Analysis: v=2.4 cv=ANaQCy7k c=1 sm=1 tr=0 ts=67fd98a9 cx=c_pps a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=kuZnfz22bkT2hUSTrGIA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140168

Add support for LLCC V6. V6 adds several additional usecase IDs,
rearrages several registers and offsets, and supports slice IDs
over 31, so add a new function for programming LLCC V6.

Signed-off-by: Melody Olvera <melody.olvera@oss.qualcomm.com>
---
 drivers/soc/qcom/llcc-qcom.c | 224 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 220 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 56823b6a2facc4345265e29b60da24a391e3707d..cadf7e70ee03cd65d125276eccde5c9f0851e111 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -35,6 +35,11 @@
 #define ATTR0_RES_WAYS_MASK           GENMASK(15, 0)
 #define ATTR0_BONUS_WAYS_MASK         GENMASK(31, 16)
 #define ATTR0_BONUS_WAYS_SHIFT        16
+#define ATTR2_PROBE_TARGET_WAYS_MASK  BIT(4)
+#define ATTR2_FIXED_SIZE_MASK         BIT(8)
+#define ATTR2_PRIORITY_MASK           GENMASK(14, 12)
+#define ATTR2_PARENT_SCID_MASK        GENMASK(21, 16)
+#define ATTR2_IN_A_GROUP_MASK         BIT(24)
 #define LLCC_STATUS_READ_DELAY        100
 
 #define CACHE_LINE_SIZE_SHIFT         6
@@ -49,6 +54,10 @@
 #define LLCC_TRP_ATTR0_CFGn(n)        (0x21000 + SZ_8 * n)
 #define LLCC_TRP_ATTR1_CFGn(n)        (0x21004 + SZ_8 * n)
 #define LLCC_TRP_ATTR2_CFGn(n)        (0x21100 + SZ_4 * n)
+#define LLCC_V6_TRP_ATTR0_CFGn(n)     (cfg->reg_offset[LLCC_TRP_ATTR0_CFG] + SZ_64 * n)
+#define LLCC_V6_TRP_ATTR1_CFGn(n)     (cfg->reg_offset[LLCC_TRP_ATTR1_CFG] + SZ_64 * n)
+#define LLCC_V6_TRP_ATTR2_CFGn(n)     (cfg->reg_offset[LLCC_TRP_ATTR2_CFG] + SZ_64 * n)
+#define LLCC_V6_TRP_ATTR3_CFGn(n)     (cfg->reg_offset[LLCC_TRP_ATTR3_CFG] + SZ_64 * n)
 
 #define LLCC_TRP_SCID_DIS_CAP_ALLOC   0x21f00
 #define LLCC_TRP_PCB_ACT              0x21f04
@@ -66,6 +75,7 @@
 #define LLCC_VERSION_2_0_0_0          0x02000000
 #define LLCC_VERSION_2_1_0_0          0x02010000
 #define LLCC_VERSION_4_1_0_0          0x04010000
+#define LLCC_VERSION_6_0_0_0          0X06000000
 
 /**
  * struct llcc_slice_config - Data associated with the llcc slice
@@ -106,6 +116,7 @@
  *              ovcap_en.
  * @vict_prio: When current scid is under-capacity, allocate over other
  *             lower-than victim priority-line threshold scid.
+ * @parent_slice_id: For grouped slices, specifies the slice id of the parent.
  */
 struct llcc_slice_config {
 	u32 usecase_id;
@@ -130,6 +141,7 @@ struct llcc_slice_config {
 	bool ovcap_en;
 	bool ovcap_prio;
 	bool vict_prio;
+	u32 parent_slice_id;
 };
 
 struct qcom_llcc_config {
@@ -153,6 +165,21 @@ struct qcom_sct_config {
 enum llcc_reg_offset {
 	LLCC_COMMON_HW_INFO,
 	LLCC_COMMON_STATUS0,
+	LLCC_TRP_ATTR0_CFG,
+	LLCC_TRP_ATTR1_CFG,
+	LLCC_TRP_ATTR2_CFG,
+	LLCC_TRP_ATTR3_CFG,
+	LLCC_TRP_SID_DIS_CAP_ALLOC,
+	LLCC_TRP_ALGO_STALE_EN,
+	LLCC_TRP_ALGO_STALE_CAP_EN,
+	LLCC_TRP_ALGO_MRU0,
+	LLCC_TRP_ALGO_MRU1,
+	LLCC_TRP_ALGO_ALLOC0,
+	LLCC_TRP_ALGO_ALLOC1,
+	LLCC_TRP_ALGO_ALLOC2,
+	LLCC_TRP_ALGO_ALLOC3,
+	LLCC_TRP_WRS_EN,
+	LLCC_TRP_WRS_CACHEABLE_EN,
 };
 
 static const struct llcc_slice_config ipq5424_data[] =  {
@@ -3161,6 +3188,33 @@ static const struct llcc_edac_reg_offset llcc_v2_1_edac_reg_offset = {
 	.drp_ecc_db_err_syn0 = 0x52120,
 };
 
+static const struct llcc_edac_reg_offset llcc_v6_edac_reg_offset = {
+	.trp_ecc_error_status0 = 0x47448,
+	.trp_ecc_error_status1 = 0x47450,
+	.trp_ecc_sb_err_syn0 = 0x47490,
+	.trp_ecc_db_err_syn0 = 0x474d0,
+	.trp_ecc_error_cntr_clear = 0x47444,
+	.trp_interrupt_0_status = 0x47600,
+	.trp_interrupt_0_clear = 0x47604,
+	.trp_interrupt_0_enable = 0x47608,
+
+	/* LLCC Common registers */
+	.cmn_status0 = 0x6400c,
+	.cmn_interrupt_0_enable = 0x6401c,
+	.cmn_interrupt_2_enable = 0x6403c,
+
+	/* LLCC DRP registers */
+	.drp_ecc_error_cfg = 0x80000,
+	.drp_ecc_error_cntr_clear = 0x80004,
+	.drp_interrupt_status = 0x80020,
+	.drp_interrupt_clear = 0x80028,
+	.drp_interrupt_enable = 0x8002c,
+	.drp_ecc_error_status0 = 0x820f4,
+	.drp_ecc_error_status1 = 0x820f8,
+	.drp_ecc_sb_err_syn0 = 0x820fc,
+	.drp_ecc_db_err_syn0 = 0x82120,
+};
+
 /* LLCC register offset starting from v1.0.0 */
 static const u32 llcc_v1_reg_offset[] = {
 	[LLCC_COMMON_HW_INFO]	= 0x00030000,
@@ -3173,6 +3227,27 @@ static const u32 llcc_v2_1_reg_offset[] = {
 	[LLCC_COMMON_STATUS0]	= 0x0003400c,
 };
 
+/* LLCC register offset starting from v6.0.0 */
+static const u32 llcc_v6_reg_offset[] = {
+	[LLCC_COMMON_HW_INFO]	        = 0x00064000,
+	[LLCC_COMMON_STATUS0]	        = 0x0006400c,
+	[LLCC_TRP_ATTR0_CFG]		= 0x00041000,
+	[LLCC_TRP_ATTR1_CFG]		= 0x00041008,
+	[LLCC_TRP_ATTR2_CFG]		= 0x00041010,
+	[LLCC_TRP_ATTR3_CFG]		= 0x00041014,
+	[LLCC_TRP_SID_DIS_CAP_ALLOC]	= 0x00042000,
+	[LLCC_TRP_ALGO_STALE_EN]	= 0x00042008,
+	[LLCC_TRP_ALGO_STALE_CAP_EN]	= 0x00042010,
+	[LLCC_TRP_ALGO_MRU0]		= 0x00042018,
+	[LLCC_TRP_ALGO_MRU1]		= 0x00042020,
+	[LLCC_TRP_ALGO_ALLOC0]		= 0x00042028,
+	[LLCC_TRP_ALGO_ALLOC1]		= 0x00042030,
+	[LLCC_TRP_ALGO_ALLOC2]		= 0x00042038,
+	[LLCC_TRP_ALGO_ALLOC3]		= 0x00042040,
+	[LLCC_TRP_WRS_EN]		= 0x00042080,
+	[LLCC_TRP_WRS_CACHEABLE_EN]	= 0x00042088,
+};
+
 static const struct qcom_llcc_config qcs615_cfg[] = {
 	{
 		.sct_data	= qcs615_data,
@@ -3869,6 +3944,139 @@ static int _qcom_llcc_cfg_program(const struct llcc_slice_config *config,
 	return ret;
 }
 
+static int _qcom_llcc_cfg_program_v6(const struct llcc_slice_config *config,
+				  const struct qcom_llcc_config *cfg)
+{
+	u32 stale_en, stale_cap_en, mru_uncap_en, mru_rollover;
+	u32 alloc_oneway_en, ovcap_en, ovcap_prio, vict_prio;
+	u32 attr0_cfg, attr1_cfg, attr2_cfg, attr3_cfg;
+	u32 attr0_val, attr1_val, attr2_val, attr3_val;
+	u32 slice_offset, reg_offset;
+	struct llcc_slice_desc *desc;
+	u32 wren, wr_cache_en;
+	int ret;
+
+	attr0_cfg = LLCC_V6_TRP_ATTR0_CFGn(config->slice_id);
+	attr1_cfg = LLCC_V6_TRP_ATTR1_CFGn(config->slice_id);
+	attr2_cfg = LLCC_V6_TRP_ATTR2_CFGn(config->slice_id);
+	attr3_cfg = LLCC_V6_TRP_ATTR3_CFGn(config->slice_id);
+
+	attr0_val = config->res_ways;
+	attr1_val = config->bonus_ways;
+	attr2_val = config->cache_mode;
+	attr2_val |= FIELD_PREP(ATTR2_PROBE_TARGET_WAYS_MASK, config->probe_target_ways);
+	attr2_val |= FIELD_PREP(ATTR2_FIXED_SIZE_MASK, config->fixed_size);
+	attr2_val |= FIELD_PREP(ATTR2_PRIORITY_MASK, config->priority);
+
+	if (config->parent_slice_id && config->fixed_size) {
+		attr2_val |= FIELD_PREP(ATTR2_PARENT_SCID_MASK, config->parent_slice_id);
+		attr2_val |= ATTR2_IN_A_GROUP_MASK;
+	}
+
+	attr3_val = MAX_CAP_TO_BYTES(config->max_cap);
+	attr3_val /= drv_data->num_banks;
+	attr3_val >>= CACHE_LINE_SIZE_SHIFT;
+
+	ret = regmap_write(drv_data->bcast_regmap, attr0_cfg, attr0_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(drv_data->bcast_regmap, attr1_cfg, attr1_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(drv_data->bcast_regmap, attr2_cfg, attr2_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(drv_data->bcast_regmap, attr3_cfg, attr3_val);
+	if (ret)
+		return ret;
+
+	slice_offset = config->slice_id % 32;
+	reg_offset = (config->slice_id / 32) * 4;
+
+	wren = config->write_scid_en << slice_offset;
+	ret = regmap_update_bits(drv_data->bcast_regmap,
+			cfg->reg_offset[LLCC_TRP_WRS_EN] + reg_offset,
+			BIT(slice_offset), wren);
+	if (ret)
+		return ret;
+
+	wr_cache_en = config->write_scid_cacheable_en << slice_offset;
+	ret = regmap_update_bits(drv_data->bcast_regmap,
+			cfg->reg_offset[LLCC_TRP_WRS_CACHEABLE_EN] + reg_offset,
+			BIT(slice_offset), wr_cache_en);
+	if (ret)
+		return ret;
+
+	stale_en = config->stale_en << slice_offset;
+	ret = regmap_update_bits(drv_data->bcast_regmap,
+			cfg->reg_offset[LLCC_TRP_ALGO_STALE_EN] + reg_offset,
+			BIT(slice_offset), stale_en);
+	if (ret)
+		return ret;
+
+	stale_cap_en = config->stale_cap_en << slice_offset;
+	ret = regmap_update_bits(drv_data->bcast_regmap,
+			cfg->reg_offset[LLCC_TRP_ALGO_STALE_CAP_EN] + reg_offset,
+			BIT(slice_offset), stale_cap_en);
+	if (ret)
+		return ret;
+
+	mru_uncap_en = config->mru_uncap_en << slice_offset;
+	ret = regmap_update_bits(drv_data->bcast_regmap,
+			cfg->reg_offset[LLCC_TRP_ALGO_MRU0] + reg_offset,
+			BIT(slice_offset), mru_uncap_en);
+	if (ret)
+		return ret;
+
+	mru_rollover = config->mru_rollover << slice_offset;
+	ret = regmap_update_bits(drv_data->bcast_regmap,
+			cfg->reg_offset[LLCC_TRP_ALGO_MRU1] + reg_offset,
+			BIT(slice_offset), mru_rollover);
+	if (ret)
+		return ret;
+
+	alloc_oneway_en = config->alloc_oneway_en << slice_offset;
+	ret = regmap_update_bits(drv_data->bcast_regmap,
+			cfg->reg_offset[LLCC_TRP_ALGO_ALLOC0] + reg_offset,
+			BIT(slice_offset), alloc_oneway_en);
+	if (ret)
+		return ret;
+
+	ovcap_en = config->ovcap_en << slice_offset;
+	ret = regmap_update_bits(drv_data->bcast_regmap,
+			cfg->reg_offset[LLCC_TRP_ALGO_ALLOC1] + reg_offset,
+			BIT(slice_offset), ovcap_en);
+	if (ret)
+		return ret;
+
+	ovcap_prio = config->ovcap_prio << slice_offset;
+	ret = regmap_update_bits(drv_data->bcast_regmap,
+			cfg->reg_offset[LLCC_TRP_ALGO_ALLOC2] + reg_offset,
+			BIT(slice_offset), ovcap_prio);
+	if (ret)
+		return ret;
+
+	vict_prio = config->vict_prio << slice_offset;
+	ret = regmap_update_bits(drv_data->bcast_regmap,
+			cfg->reg_offset[LLCC_TRP_ALGO_ALLOC3] + reg_offset,
+			BIT(slice_offset), vict_prio);
+	if (ret)
+		return ret;
+
+	if (config->activate_on_init) {
+		desc = llcc_slice_getd(config->usecase_id);
+		if (PTR_ERR_OR_ZERO(desc))
+			return -EINVAL;
+
+		ret = llcc_slice_activate(desc);
+	}
+
+	return ret;
+}
+
 static int qcom_llcc_cfg_program(struct platform_device *pdev,
 				 const struct qcom_llcc_config *cfg)
 {
@@ -3880,10 +4088,18 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
 	sz = drv_data->cfg_size;
 	llcc_table = drv_data->cfg;
 
-	for (i = 0; i < sz; i++) {
-		ret = _qcom_llcc_cfg_program(&llcc_table[i], cfg);
-		if (ret)
-			return ret;
+	if (drv_data->version >= LLCC_VERSION_6_0_0_0) {
+		for (i = 0; i < sz; i++) {
+			ret = _qcom_llcc_cfg_program_v6(&llcc_table[i], cfg);
+			if (ret)
+				return ret;
+		}
+	} else {
+		for (i = 0; i < sz; i++) {
+			ret = _qcom_llcc_cfg_program(&llcc_table[i], cfg);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return ret;

-- 
2.48.1


