Return-Path: <linux-kernel+bounces-858153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D192BE9266
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8227D42899C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40163314BC;
	Fri, 17 Oct 2025 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EYynz5X3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CBA36999B
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760710641; cv=none; b=ncp10rtKl+WK7wt7mu2vjsp34wYbKx/Lo0a634i5iUR4SRBrGBA5pcnT1f6dIQW6WCZReiTPUl9Dk+VZxz+dL2TxgIMQuU/YakC1xDvM0ZiH9iRemRojhT1UvMv0FS859Zw0JSCQj5Iq3z8EkfOG7jZoLdIj+XgI26l08X9OgZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760710641; c=relaxed/simple;
	bh=WP9OBR6Y+0+UpuwyFmyJHcFpInOnfMsFjcVkN7vPJcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EKm3cjvzSevPRFvKhPYev3Dcd3lwEEr8BGm9BJj+hR2sAIe2OofJnp4f/L9h01T8JbWunYSRgrYvq8dSNrpBl2/uKUSJUOxRBt0xkZ8CaOP4Lg6hsQvbzKWwFrUKHizKCHQSpyPTcl9c+VuYjQBHDsNEw813Af/XniJiFgwSs0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EYynz5X3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8ATPg001691
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:17:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zhaJ8oV0RRnbTyCGCQikuU/kjIzXOpMayfs+Qj5W+hw=; b=EYynz5X3jrcJqVok
	48l9PRmdGITc2K77t26OxFXeOXgn0+jBgs7DJHvKm/4Rni3S3bL7RHlkxS2EM7cc
	mnjfoRb0shrv0rk4xLcdviEVgAlWVK+Ov6IntOCVZP7l8Ll4TdrxZ7Vbn5JuWs2y
	89Bwc/wbY4jGicNVAiobhoyTmLfJFoJ0rKFIpYfgAub1YJaUhnrRnBXleNm7pOUa
	Ao6EIjSoc6rQTEy0mYWO7RkOyNWChmx0C31OnNn8LBUNenE/JtUtt5UWbaeHReD+
	vKjTupEztBMQnkKpEPDQAMLpJWIr89wo71m1pwP4UVXaREHXEeWHBkFVZFqgPSxa
	jGQPmg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd9chs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:17:18 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78117fbda6eso1880203b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:17:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760710637; x=1761315437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhaJ8oV0RRnbTyCGCQikuU/kjIzXOpMayfs+Qj5W+hw=;
        b=RCU0hFOgwJLw/LSs5NdWo1ab6pDbFv1nFtcvjisQdwM88oYfaRFoOTofAB9QWtvH72
         RnXeQqBLZoxZqZF//0ti/Cdia6fUKsQCsbzfanv+cU/q1IFLWCQM3eH69aTAu78yXapD
         fYAIiFUYs2o25BH7Y/nFkYEMfTBzbqWR8vy0N2w4Rbj7izXYvuAPP8yk3+c3zfUihXfe
         jwsRYv9P1G23MhBX2aa1uD5wo1PFSSubV4s7Q/r2ACu7saOCzGZ3CbW9jJljJ90W2tSU
         wQvwGMdpWDFCe5j39RrFXKyK9QgdsC+bLgimQ2un3StCnt8ctfnFixVKI0F+QM3BiH8Z
         C//g==
X-Forwarded-Encrypted: i=1; AJvYcCUkOb2GwhSzz9CQ9VzKcceKWJsdg5tQPWeVV1WwtWanM4I5yk9hiNiwYfRTJ6CZzgVkuZUbxx85bmapeFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqr7xk4dndc8TN3S/OHfWuR+wJ5YzqP2NgnW1dO+F47Vf5HIX7
	HuEdt2tBG+X/IIKn2mjS38x/njY3vMWvLWvniBIqsomyq3bgydP7BV3dCcero+ATgX1qd9Neo0V
	W1qq2QZh7vqTIPqyry3H20V9q6s9X2ZwhXABSN4wJwpitdAqSBiqgINj0Epc93DKX11Y=
X-Gm-Gg: ASbGnctUgfbwSXQd4pBSWi4hxrISwk2nqdVnksCRc2PuSIQ0CrAzvQ7EqPWH1/7D2ri
	/KghJ8DnYlkHSbD3orOrQ75cZdm3x2UjbI8AzYnCIeaw7Ix7+ouEscGSRJCsQ9rjiuw4/guEo81
	xUvB3/DfmfYcufAhp49fd6NcQCSZCQP4vrHXsnR6D27M+9ivQfvm/cHifrLcNGJbYwT1KPrjjnA
	/NmFx8Pn/VwfOu2oebR7aGJz0k5xWZFyrSSXod6smWZ/VnWkoW517skBHtDkKYhJgdDOtD7AiNY
	KWosxmEHqDD9vswSZCN5zozE19zi0EW/G59A0KfDFIZhisgo9+nWjkO4zU1TIy5PCU14xwNOb+D
	PxnneawSmmzF3HO9RbCzRhr4lD8NVPWLQRQ==
X-Received: by 2002:a05:6a00:188c:b0:781:1f28:eadd with SMTP id d2e1a72fcca58-7a220a98d31mr4021644b3a.20.1760710637177;
        Fri, 17 Oct 2025 07:17:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzplU11+GApbuMSP2HrSj8pu6QcgJGFUkCxqgZCedcbE1dBZcyTBt2LNaHoDa21DgSL8EPpQ==
X-Received: by 2002:a05:6a00:188c:b0:781:1f28:eadd with SMTP id d2e1a72fcca58-7a220a98d31mr4021590b3a.20.1760710636493;
        Fri, 17 Oct 2025 07:17:16 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0966d7sm25895826b3a.40.2025.10.17.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:17:15 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 19:46:23 +0530
Subject: [PATCH v2 2/8] media: iris: Add support for multiple clock sources
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-knp_video-v2-2-f568ce1a4be3@oss.qualcomm.com>
References: <20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com>
In-Reply-To: <20251017-knp_video-v2-0-f568ce1a4be3@oss.qualcomm.com>
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
        Vishnu Reddy <quic_bvisredd@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760710621; l=10127;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=WP9OBR6Y+0+UpuwyFmyJHcFpInOnfMsFjcVkN7vPJcI=;
 b=D416JzZgIC/IMhtyLiYB90tnq4qzsYumYUICQYs5/sWiwwdCbYg64TqU+Rskvx3JU+Qal6RIb
 YccTHH+EJC9DvBrNFynWThtxDz1yV1nKG/cHUgn5OKpl7T7V/nrfSm+
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: CDFl5tgP-dnsY6xCniGzCtwaMgzZvwiB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX6ur4+b7Gkw1j
 UztvB6/4aLDJas+kpgvm2+xvAdkUWm/h+TiGm+lOJXFgg4swMvBbui31T4b3Nhzuv2xLHf9bDhq
 mOyeRR2zW3dYoTp0mXyNIUz59ymKWfJcGVYtTAUasKTIJhymBsI4zq2IHg+6VCmk204evPQAuj4
 6B78WJ0ZhYYjbrNYK/Gu51xe+4g1iNvqwwIJhdAQvmj2px7jhnArspDZ7yrZoXZxs1crAVRg5xN
 ilIsJBkxgzo7AIJ5OBmwH7zs9DIruoTlVz46q2p6dTYCL+pLFEtCE8ux+Jd8w0GGTzZkfBXL4Xc
 FD0CZIOEpttJQIftN+1La00maYYmtW3i6p0gJ3GGJ+V5IxGryDI8+GwBG2Z4Ppjass6SE0dyFpB
 S89QCDiO/KQX6EvLZQI/sv+74Tt7ZQ==
X-Proofpoint-GUID: CDFl5tgP-dnsY6xCniGzCtwaMgzZvwiB
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f24fee cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=yaBBUlST2TKB7NfxEUYA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

vpu4 depends on more than one clock source. Thus far hardware versions
up to vpu3x have been clocked by a single source.
This adds support for multiple clocks by,
- Adding a lookup table
- Configuring OPP table for video device with different video clocks
- Setting OPP for multiple clocks during dev_pm_opp_set_opp()

This patch extends the support for multiple clocks in driver, which
would be used in subsequent patch for kaanapali, when the platform data
is prepared.

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


