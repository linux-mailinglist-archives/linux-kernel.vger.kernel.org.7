Return-Path: <linux-kernel+bounces-890116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A767C3F401
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C09188BC46
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A093E302748;
	Fri,  7 Nov 2025 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KVECZQ12";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SqLqOsLI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735F2F747B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509007; cv=none; b=B8ZfeM7UC5TxIsveEx+9WTXB4qc+t+oidekpMLBjUU18pC5L1Anmp2hWwZzFDsNor00X7nka3xI7nj6wbsbB6PMeGccfBXuJHArmRAg5TXcHhefN0Ck2XbL1XOKfvRZdLM7GYnRefTkEDKMJ+t5GNyUqD/+xxUYZTGTOaFIFQ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509007; c=relaxed/simple;
	bh=42G7QSnuvOzjF4T/9x+2IUQpLHCQq5G6D2LUof1Vzts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FjD1mgOfyyfx8gEf2yHokLhdeUBkScwBqGaRQcSng19+skO0zcDnR+su4K5KWWJypVuwb6//Fqdlj5g69cNXG8FAPgrdrSDRaZawzVJyhLENip9feKn0GoSt7g76ESRficxqcQApWTijEKDJtIN3uNaTj2XLWqxvtK2YnmMFGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KVECZQ12; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SqLqOsLI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A757lDR2273794
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 09:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PGuo0E2Lv8zHBBOf9G2nvoloKTdUlCfIFCUJP3LRSUE=; b=KVECZQ12So0AzrdN
	yvalKvrGpCrsagAYnE7Zhq8kCkvKIkJSHdTCpkplSnWYYvrlRdMfLQFHwxLgMVni
	Yza6MlLc2Rr+F1EH9X/dFlayK6dsRqgwpdwrODOz4VxvN0Q4eUI/EzJrA9BMJmT2
	1QKnRAeGWtdjJQzCBJAFKvsZFytQ+R3qqbvmZlLMF6GP77NmVjHHkJPhGT4eHC65
	xQt/cfqRh+Rct8LaPxoBkQYqKyIDR4+ajO2Cu/vSQ+qBAAarH81QgnXupQVyAwkl
	NpyzVwuZ7O5t7ptwevHG32D3LnUFRq/wJQdGvD4CsiGDP/35MdSepqRofE5r46oG
	gAntMg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9abmrsup-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 09:50:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29598910dd2so14146925ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762509002; x=1763113802; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGuo0E2Lv8zHBBOf9G2nvoloKTdUlCfIFCUJP3LRSUE=;
        b=SqLqOsLIRnmyrZNAZJjEZLJ6hrt8B7GO9WvJV/P5+Sw4h3Czw8nFJDJ9hPe3I8F28C
         0zdx74cPutKw++DtbEv0WrNulTpq1P4fpMPo7hMLqFQpRxpcWHYR6pVccgFwZq5+pMF6
         MT3TjG74bZmmR1AzWCvLfDlP313AVQl2nfgD6do085C2NSERnyZ8e/GUZlR56mjSMGtp
         mjO+uSCizXTbGzBmgCKFl9d6gqYqenMJR8nrvVT4KYMukuuzzfxEmp/fhvL0Ga3+mv1Y
         boJJhreThwJT2YBKE4TKM47v8dO4HHaK8TmuHVrtFx36FOt045CkWIj7T5kSbyM12dg0
         F8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762509002; x=1763113802;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PGuo0E2Lv8zHBBOf9G2nvoloKTdUlCfIFCUJP3LRSUE=;
        b=ejRJBiHgoDpxx7zSO93yQW+ZMVV++4F6Zw/2+pR5kPb8Qj6Iu5TqF+sK98F3d/KYGV
         4EUz80YfIYe5XvUpA0nudQ9WF2Tviv5j75qDoYsh3HKe52i+nXwGjlMw13I1M+70NgP0
         o4FTPU6Yp5KkZdtXH4ye77S/vII7dVzhe448X6m2ePoPlqLAxYS3GNpILJgUvyGaFebh
         mjzZCSlN0W5r6x1BxwrKyxdMJD2NNYH/UAHulmElfJP/HFna55k1Mty1dJ1oyJD5cPXo
         UF12vVVwBX4ArTtSqRBOBpYhFiAh4Zy/Ubo63DIAvQ5+rUwEyirsYMWhntXkBFFKkwsX
         6Bhw==
X-Forwarded-Encrypted: i=1; AJvYcCWTJ9xET2Qa4kSOPRO+rYMAAxsGVjZXHPjJJ+aldZUE1Blet6GuLF0giH18fmW8o5bR5VkRQyAweog9k7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDACBTKgrpmXshT+nAvYzYdvYxbMGtjHGUPZ2V1nVt+aCG3UyZ
	xlO3oZAQFM4kCsT0PbE+pIfjir26dKXpwiI9lCMJuHIANCsmJdhyIWTvydkO6beW6aNBwit6upa
	BagSijOKv9OVcXkAjdaurfnDGm3To4fy791bLjwHv+PSm0yeIug2NGRlPJHtUUjOG/cc=
X-Gm-Gg: ASbGncu7gxBkjnp6yj5++ZJJc+c3A8b+dF9lI2X5yR+SB+oJSbCq2rNAY1w6KVZWS63
	fezJ4ipITy02ghvYAuTli2px8Nf/LKklAVWlFqhWESROBLvF+MTOMOVT2Db/JdqFsipvcTiBOM2
	3w5YnpTU6drF2aslYSC2BzVr1s/shbeMF7S7ybMXyvcoEm6izW4v6UWAD65lHzqUl5Nt9IWdSGb
	bIFVfgIv3BrLF5zvmlNV1WmoouAnNPmGUEDJ7d0hazsv4BlnEDFPM6UFCBbBWbdWeLtovo90FlV
	bv3DzJxQ39ofecnzerzvcrFSWv9cL41ogfH+981g8uIigexyx2xahbnR2vGT6fZiHPGd/bpM4bT
	ytSir5WyR6sIJ/DM9w1W16PecC6QeY8nqLQ==
X-Received: by 2002:a17:903:2c5:b0:295:50cd:e759 with SMTP id d9443c01a7336-297c048e1c4mr36093095ad.58.1762509001847;
        Fri, 07 Nov 2025 01:50:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHquMQ7hRmJ1srwkBDAGe+PE2OPCTkZI3tKcCa7kY3Sj4EWqY23jrIYIWfzbH0/HB3pbRx4RA==
X-Received: by 2002:a17:903:2c5:b0:295:50cd:e759 with SMTP id d9443c01a7336-297c048e1c4mr36092795ad.58.1762509001294;
        Fri, 07 Nov 2025 01:50:01 -0800 (PST)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5f011sm54975895ad.25.2025.11.07.01.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:50:00 -0800 (PST)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 07 Nov 2025 15:19:36 +0530
Subject: [PATCH v3 1/6] media: iris: Add support for multiple clock sources
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-knp_video-v3-1-50c86cbb0eb8@oss.qualcomm.com>
References: <20251107-knp_video-v3-0-50c86cbb0eb8@oss.qualcomm.com>
In-Reply-To: <20251107-knp_video-v3-0-50c86cbb0eb8@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vishnu Reddy <quic_bvisredd@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762508991; l=10187;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=42G7QSnuvOzjF4T/9x+2IUQpLHCQq5G6D2LUof1Vzts=;
 b=7RF887daNtM1qNCi+46nr15jK5HRQGWzpsGzrCLsIvOtkzBmARBFYp2U+KYWmgE8nswITvnuP
 I3ifFnDRPmnBb5hepfIKKR1lCO/AtsPlDr65ca7Fbt2r4LLnPM696Jz
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-GUID: 1pxOhtpGvsMNEMKkrtvVPyvmBuEnKQ5r
X-Proofpoint-ORIG-GUID: 1pxOhtpGvsMNEMKkrtvVPyvmBuEnKQ5r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA3OCBTYWx0ZWRfXxznnEfWcM57Z
 1x1n23XgQlGFmTUaDvtSrdKlbOHSWPnzQXtUmUnwCY0AZwTQa8Ly8M0mvbza3XM7TgvwzIkhEVL
 78ErzF5yFmH573QC2PGD7Lsvi4RHaccWO0qo/IDu9BG5lKH+YW3vZzKNWmLB019I6Rk+8vslOjM
 +3c9f+PJ/axu1FwwsBnXyDYero7pKi6F4+cMo0mVdaz4T+tmgSs76Kik6LEaeN+uUzYAQqFdbZe
 fgCwEz1wzHyhZBC1bC/n5bEtM72n+6AGXSyXxIjNL/5JByYvdkvnLiUF2xqNkjx+fbnLtlByGiH
 1dBL2DIHMa6bLJCbgZjI6ytu+m+j4nitTsQILwOK5Hx3ZGFjiH2ZqP3XsR8NIIkWVhBLsqtWs7r
 1sx7nLSVS0TEN1ld7WJtAp6J5NYl1g==
X-Authority-Analysis: v=2.4 cv=HPjO14tv c=1 sm=1 tr=0 ts=690dc0ca cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=yaBBUlST2TKB7NfxEUYA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070078

vpu4 depends on more than one clock source. Thus far hardware versions
up to vpu3x have been clocked by a single source.
This adds support for multiple clocks by,
- Adding a lookup table
- Configuring OPP table for video device with different video clocks
- Setting OPP for multiple clocks during dev_pm_opp_set_opp()

This patch extends the support for multiple clocks in driver, which
would be used in subsequent patch for kaanapali, when the platform data
is prepared.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
 .../media/platform/qcom/iris/iris_platform_common.h  |  1 +
 .../media/platform/qcom/iris/iris_platform_gen2.c    |  9 +++++++++
 .../media/platform/qcom/iris/iris_platform_sm8250.c  |  6 ++++++
 drivers/media/platform/qcom/iris/iris_power.c        |  2 +-
 drivers/media/platform/qcom/iris/iris_probe.c        | 20 ++++++++------------
 drivers/media/platform/qcom/iris/iris_resources.c    | 16 ++++++++++++++--
 drivers/media/platform/qcom/iris/iris_resources.h    |  1 +
 drivers/media/platform/qcom/iris/iris_vpu_common.c   |  4 ++--
 8 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 58d05e0a112eed25faea027a34c719c89d6c3897..df03de08c44839c1b6c137874eb7273c638d5f2c 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -206,6 +206,7 @@ struct iris_platform_data {
 	const char * const *opp_pd_tbl;
 	unsigned int opp_pd_tbl_size;
 	const struct platform_clk_data *clk_tbl;
+	const char * const *opp_clk_tbl;
 	unsigned int clk_tbl_size;
 	const char * const *clk_rst_tbl;
 	unsigned int clk_rst_tbl_size;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 36d69cc73986b74534a2912524c8553970fd862e..fea800811a389a58388175c733ad31c4d9c636b0 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -633,6 +633,11 @@ static const struct platform_clk_data sm8550_clk_table[] = {
 	{IRIS_HW_CLK,   "vcodec0_core" },
 };
 
+static const char * const sm8550_opp_clk_table[] = {
+	"vcodec0_core",
+	NULL,
+};
+
 static struct ubwc_config_data ubwc_config_sm8550 = {
 	.max_channels = 8,
 	.mal_length = 32,
@@ -756,6 +761,7 @@ struct iris_platform_data sm8550_data = {
 	.opp_pd_tbl_size = ARRAY_SIZE(sm8550_opp_pd_table),
 	.clk_tbl = sm8550_clk_table,
 	.clk_tbl_size = ARRAY_SIZE(sm8550_clk_table),
+	.opp_clk_tbl = sm8550_opp_clk_table,
 	/* Upper bound of DMA address range */
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu/vpu30_p4.mbn",
@@ -848,6 +854,7 @@ struct iris_platform_data sm8650_data = {
 	.opp_pd_tbl_size = ARRAY_SIZE(sm8550_opp_pd_table),
 	.clk_tbl = sm8550_clk_table,
 	.clk_tbl_size = ARRAY_SIZE(sm8550_clk_table),
+	.opp_clk_tbl = sm8550_opp_clk_table,
 	/* Upper bound of DMA address range */
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu/vpu33_p4.mbn",
@@ -930,6 +937,7 @@ struct iris_platform_data sm8750_data = {
 	.opp_pd_tbl_size = ARRAY_SIZE(sm8550_opp_pd_table),
 	.clk_tbl = sm8750_clk_table,
 	.clk_tbl_size = ARRAY_SIZE(sm8750_clk_table),
+	.opp_clk_tbl = sm8550_opp_clk_table,
 	/* Upper bound of DMA address range */
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu/vpu35_p4.mbn",
@@ -1017,6 +1025,7 @@ struct iris_platform_data qcs8300_data = {
 	.opp_pd_tbl_size = ARRAY_SIZE(sm8550_opp_pd_table),
 	.clk_tbl = sm8550_clk_table,
 	.clk_tbl_size = ARRAY_SIZE(sm8550_clk_table),
+	.opp_clk_tbl = sm8550_opp_clk_table,
 	/* Upper bound of DMA address range */
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu/vpu30_p4_s6.mbn",
diff --git a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
index 16486284f8acccf6a95a27f6003e885226e28f4d..1b1b6aa751106ee0b0bc71bb0df2e78340190e66 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_sm8250.c
@@ -273,6 +273,11 @@ static const struct platform_clk_data sm8250_clk_table[] = {
 	{IRIS_HW_CLK,   "vcodec0_core" },
 };
 
+static const char * const sm8250_opp_clk_table[] = {
+	"vcodec0_core",
+	NULL,
+};
+
 static struct tz_cp_config tz_cp_config_sm8250 = {
 	.cp_start = 0,
 	.cp_size = 0x25800000,
@@ -333,6 +338,7 @@ struct iris_platform_data sm8250_data = {
 	.opp_pd_tbl_size = ARRAY_SIZE(sm8250_opp_pd_table),
 	.clk_tbl = sm8250_clk_table,
 	.clk_tbl_size = ARRAY_SIZE(sm8250_clk_table),
+	.opp_clk_tbl = sm8250_opp_clk_table,
 	/* Upper bound of DMA address range */
 	.dma_mask = 0xe0000000 - 1,
 	.fwname = "qcom/vpu-1.0/venus.mbn",
diff --git a/drivers/media/platform/qcom/iris/iris_power.c b/drivers/media/platform/qcom/iris/iris_power.c
index dbca42df0910fd3c0fb253dbfabf1afa2c3d32ad..91aa21d4070ebcebbe2ed127a03e5e49b9a2bd5c 100644
--- a/drivers/media/platform/qcom/iris/iris_power.c
+++ b/drivers/media/platform/qcom/iris/iris_power.c
@@ -91,7 +91,7 @@ static int iris_set_clocks(struct iris_inst *inst)
 	}
 
 	core->power.clk_freq = freq;
-	ret = dev_pm_opp_set_rate(core->dev, freq);
+	ret = iris_opp_set_rate(core->dev, freq);
 	mutex_unlock(&core->lock);
 
 	return ret;
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index 00e99be16e087c4098f930151fd76cd381d721ce..ad82a62f8b923d818ffe77c131d7eb6da8c34002 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -40,8 +40,6 @@ static int iris_init_icc(struct iris_core *core)
 
 static int iris_init_power_domains(struct iris_core *core)
 {
-	const struct platform_clk_data *clk_tbl;
-	u32 clk_cnt, i;
 	int ret;
 
 	struct dev_pm_domain_attach_data iris_pd_data = {
@@ -56,6 +54,11 @@ static int iris_init_power_domains(struct iris_core *core)
 		.pd_flags = PD_FLAG_DEV_LINK_ON | PD_FLAG_REQUIRED_OPP,
 	};
 
+	struct dev_pm_opp_config iris_opp_clk_data = {
+		.clk_names = core->iris_platform_data->opp_clk_tbl,
+		.config_clks = dev_pm_opp_config_clks_simple,
+	};
+
 	ret = devm_pm_domain_attach_list(core->dev, &iris_pd_data, &core->pmdomain_tbl);
 	if (ret < 0)
 		return ret;
@@ -64,16 +67,9 @@ static int iris_init_power_domains(struct iris_core *core)
 	if (ret < 0)
 		return ret;
 
-	clk_tbl = core->iris_platform_data->clk_tbl;
-	clk_cnt = core->iris_platform_data->clk_tbl_size;
-
-	for (i = 0; i < clk_cnt; i++) {
-		if (clk_tbl[i].clk_type == IRIS_HW_CLK) {
-			ret = devm_pm_opp_set_clkname(core->dev, clk_tbl[i].clk_name);
-			if (ret)
-				return ret;
-		}
-	}
+	ret = devm_pm_opp_set_config(core->dev, &iris_opp_clk_data);
+	if (ret)
+		return ret;
 
 	return devm_pm_opp_of_add_table(core->dev);
 }
diff --git a/drivers/media/platform/qcom/iris/iris_resources.c b/drivers/media/platform/qcom/iris/iris_resources.c
index cf32f268b703c1c042a9bcf146e444fff4f4990d..939f6617f2631503fa8cb3e874b9de6b2fbe7b76 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.c
+++ b/drivers/media/platform/qcom/iris/iris_resources.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/devfreq.h>
 #include <linux/interconnect.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
@@ -58,11 +59,22 @@ int iris_unset_icc_bw(struct iris_core *core)
 	return icc_bulk_set_bw(core->icc_count, core->icc_tbl);
 }
 
+int iris_opp_set_rate(struct device *dev, unsigned long freq)
+{
+	struct dev_pm_opp *opp __free(put_opp);
+
+	opp = devfreq_recommended_opp(dev, &freq, 0);
+	if (IS_ERR(opp))
+		return PTR_ERR(opp);
+
+	return dev_pm_opp_set_opp(dev, opp);
+}
+
 int iris_enable_power_domains(struct iris_core *core, struct device *pd_dev)
 {
 	int ret;
 
-	ret = dev_pm_opp_set_rate(core->dev, ULONG_MAX);
+	ret = iris_opp_set_rate(core->dev, ULONG_MAX);
 	if (ret)
 		return ret;
 
@@ -77,7 +89,7 @@ int iris_disable_power_domains(struct iris_core *core, struct device *pd_dev)
 {
 	int ret;
 
-	ret = dev_pm_opp_set_rate(core->dev, 0);
+	ret = iris_opp_set_rate(core->dev, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/media/platform/qcom/iris/iris_resources.h b/drivers/media/platform/qcom/iris/iris_resources.h
index f723dfe5bd81a9c9db22d53bde4e18743d771210..6bfbd2dc6db095ec05e53c894e048285f82446c6 100644
--- a/drivers/media/platform/qcom/iris/iris_resources.h
+++ b/drivers/media/platform/qcom/iris/iris_resources.h
@@ -8,6 +8,7 @@
 
 struct iris_core;
 
+int iris_opp_set_rate(struct device *dev, unsigned long freq);
 int iris_enable_power_domains(struct iris_core *core, struct device *pd_dev);
 int iris_disable_power_domains(struct iris_core *core, struct device *pd_dev);
 int iris_unset_icc_bw(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index bb98950e018fadf69ac4f41b3037f7fd6ac33c5b..bbd999a41236dca5cf5700e452a6fed69f4fc922 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -266,7 +266,7 @@ void iris_vpu_power_off_hw(struct iris_core *core)
 
 void iris_vpu_power_off(struct iris_core *core)
 {
-	dev_pm_opp_set_rate(core->dev, 0);
+	iris_opp_set_rate(core->dev, 0);
 	core->iris_platform_data->vpu_ops->power_off_hw(core);
 	core->iris_platform_data->vpu_ops->power_off_controller(core);
 	iris_unset_icc_bw(core);
@@ -352,7 +352,7 @@ int iris_vpu_power_on(struct iris_core *core)
 	freq = core->power.clk_freq ? core->power.clk_freq :
 				      (u32)ULONG_MAX;
 
-	dev_pm_opp_set_rate(core->dev, freq);
+	iris_opp_set_rate(core->dev, freq);
 
 	core->iris_platform_data->set_preset_registers(core);
 

-- 
2.34.1


