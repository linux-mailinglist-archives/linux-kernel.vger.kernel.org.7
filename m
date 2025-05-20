Return-Path: <linux-kernel+bounces-655479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A64ABD656
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 13:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFB14A70F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002AE27C141;
	Tue, 20 May 2025 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLOgaec9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5D1283142;
	Tue, 20 May 2025 11:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739295; cv=none; b=lZjPymj7vJvE8Wsf8BQd1NuLZ9pzi/pzOMXqf3nlIuRtQtTU+5id2KXmvEnT6nBn4B/PN7LXfEJ1h6rEHGqZ+pdey5wrPnpNDqgBiiioPdXPhbKV1O/mLkK4vm5y46xxO7JC4VCxO3q3PtCl1e2cnynDe7z6vrfVL6zZwnEvAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739295; c=relaxed/simple;
	bh=QUVJh+TErPwoxKgp45pOCxpNGi5O+k8trYJey9dfGvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+kHyXCTwliKP3kL3qh1C15tz8e/GjZ8jfC7cAAaLckYEo7j4YyM3RPyy5A7ksgW+Y0H09EbIlOeTvIAjDTioxjeFeOQp0y1sg8Oc4upP4ODAzZ4S1AUox7nKcc3PiAX/R6S0KczNVqGL483Qeu+0eyId3HjQaArFDnaGxkwb94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLOgaec9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17C9C4CEEB;
	Tue, 20 May 2025 11:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747739294;
	bh=QUVJh+TErPwoxKgp45pOCxpNGi5O+k8trYJey9dfGvw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XLOgaec9pIuTNIjchdKX4BN5HiXtMUpz50NosIc6f1+jCsIAEE0wxU/0lNQKosxgB
	 T7qpTRaeAmkgW3b8ejSMTYMcG5lZzFVXHqLdipYJte+3bEKH4feVc5pg+GxUHt2xzX
	 woGzYPoZJcO1LIvozXMUhJe4Jtu0GM51LXtZSJHqDeNC68rWt2t+VvJSsB6jRtQZc/
	 /0cs50Vw/oQlU+5wFz0/cWdZsa1C310W+1fe2IEzNmR4lz6Zss0rkqttw19AjG1kk6
	 08aepj5EXPYKnksCux/MrilRBugRVgM8788qozIkEV6XAeE3YEHNtS2Q//YskXek/M
	 LqT1/GQ7Nm02Q==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 20 May 2025 13:07:17 +0200
Subject: [PATCH RFT v4 12/14] soc: qcom: ubwc: Add #defines for UBWC
 swizzle bits
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-topic-ubwc_central-v4-12-2a461d32234a@oss.qualcomm.com>
References: <20250520-topic-ubwc_central-v4-0-2a461d32234a@oss.qualcomm.com>
In-Reply-To: <20250520-topic-ubwc_central-v4-0-2a461d32234a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747739236; l=7400;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=8+CKeJcEpEzaLeW0Wi18CMfDsaBfs2XpIGC4RF7uSIE=;
 b=YeC+OAjQKI5UBvP1zDGOODUYxtlYE5xUBW5YQhJGJPiL0Ap+idcq6Mr0yrA322QgwNUcZEo7r
 iRB7POsRrdoAXn7/OLX34m0mh+QMocmP9pNKTfEu8PWG81457hyJ+dT
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Make the values a bit more meaningful.

This commit is intentionally cross-subsystem to ease review, as the
patchset is intended to be merged together, with a maintainer
consensus.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  2 +-
 drivers/soc/qcom/ubwc_config.c        | 37 +++++++++++++++++++++++------------
 include/linux/soc/qcom/ubwc.h         |  8 ++++----
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 6dd5281678a5f31be9c59e3b247cfd5a34341ec1..e24c67dbfa6e1f82b86a718b77d6d6867320d580 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -661,7 +661,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	BUG_ON(adreno_gpu->ubwc_config.highest_bank_bit < 13);
 	u32 hbb = adreno_gpu->ubwc_config.highest_bank_bit - 13;
 	bool rgb565_predicator = cfg->ubwc_enc_version >= UBWC_4_0;
-	u32 level2_swizzling_dis = !(cfg->ubwc_swizzle & BIT(1));
+	u32 level2_swizzling_dis = !(cfg->ubwc_swizzle & UBWC_SWIZZLE_ENABLE_LVL2);
 	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
 	bool amsbc = cfg->ubwc_enc_version >= UBWC_3_0;
 	bool min_acc_len_64b = false;
diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 7002744631341796d08fa197efa2202b3018cc3e..fe874ccd8df6acb4fac65f7d261afb05861117c2 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -32,7 +32,7 @@ static const struct qcom_ubwc_cfg_data qcm2290_data = {
 static const struct qcom_ubwc_cfg_data sa8775p_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_dec_version = UBWC_4_0,
-	.ubwc_swizzle = 4,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
 	.highest_bank_bit = 13,
 	.macrotile_mode = true,
@@ -41,7 +41,8 @@ static const struct qcom_ubwc_cfg_data sa8775p_data = {
 static const struct qcom_ubwc_cfg_data sar2130p_data = {
 	.ubwc_enc_version = UBWC_3_0, /* 4.0.2 in hw */
 	.ubwc_dec_version = UBWC_4_3,
-	.ubwc_swizzle = 6,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
 	.highest_bank_bit = 13,
 	.macrotile_mode = true,
@@ -50,7 +51,8 @@ static const struct qcom_ubwc_cfg_data sar2130p_data = {
 static const struct qcom_ubwc_cfg_data sc7180_data = {
 	.ubwc_enc_version = UBWC_2_0,
 	.ubwc_dec_version = UBWC_2_0,
-	.ubwc_swizzle = 6,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
 	.highest_bank_bit = 14,
 };
@@ -58,7 +60,8 @@ static const struct qcom_ubwc_cfg_data sc7180_data = {
 static const struct qcom_ubwc_cfg_data sc7280_data = {
 	.ubwc_enc_version = UBWC_3_0,
 	.ubwc_dec_version = UBWC_4_0,
-	.ubwc_swizzle = 6,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
 	.highest_bank_bit = 14,
 	.macrotile_mode = true,
@@ -74,7 +77,8 @@ static const struct qcom_ubwc_cfg_data sc8180x_data = {
 static const struct qcom_ubwc_cfg_data sc8280xp_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_dec_version = UBWC_4_0,
-	.ubwc_swizzle = 6,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
 	.highest_bank_bit = 16,
 	.macrotile_mode = true,
@@ -95,7 +99,9 @@ static const struct qcom_ubwc_cfg_data sdm845_data = {
 static const struct qcom_ubwc_cfg_data sm6115_data = {
 	.ubwc_enc_version = UBWC_1_0,
 	.ubwc_dec_version = UBWC_2_0,
-	.ubwc_swizzle = 7,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL1 |
+			UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
 	.highest_bank_bit = 14,
 };
@@ -103,7 +109,9 @@ static const struct qcom_ubwc_cfg_data sm6115_data = {
 static const struct qcom_ubwc_cfg_data sm6125_data = {
 	.ubwc_enc_version = UBWC_1_0,
 	.ubwc_dec_version = UBWC_3_0,
-	.ubwc_swizzle = 7,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL1 |
+			UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
 	.highest_bank_bit = 14,
 };
 
@@ -116,7 +124,8 @@ static const struct qcom_ubwc_cfg_data sm6150_data = {
 static const struct qcom_ubwc_cfg_data sm6350_data = {
 	.ubwc_enc_version = UBWC_2_0,
 	.ubwc_dec_version = UBWC_2_0,
-	.ubwc_swizzle = 6,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
 	.highest_bank_bit = 14,
 };
@@ -136,7 +145,8 @@ static const struct qcom_ubwc_cfg_data sm8150_data = {
 static const struct qcom_ubwc_cfg_data sm8250_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_dec_version = UBWC_4_0,
-	.ubwc_swizzle = 6,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
@@ -146,7 +156,8 @@ static const struct qcom_ubwc_cfg_data sm8250_data = {
 static const struct qcom_ubwc_cfg_data sm8350_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_dec_version = UBWC_4_0,
-	.ubwc_swizzle = 6,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
@@ -156,7 +167,8 @@ static const struct qcom_ubwc_cfg_data sm8350_data = {
 static const struct qcom_ubwc_cfg_data sm8550_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_dec_version = UBWC_4_3,
-	.ubwc_swizzle = 6,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
@@ -166,7 +178,8 @@ static const struct qcom_ubwc_cfg_data sm8550_data = {
 static const struct qcom_ubwc_cfg_data x1e80100_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_dec_version = UBWC_4_3,
-	.ubwc_swizzle = 6,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 15 for LP_DDR4 */
 	.highest_bank_bit = 16,
diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index 7f87a0981fe19eea3373ee2cc79cd11c84ddbc8c..7f9089a355940ec27fad9a6a7e750d51384fadf6 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -21,11 +21,11 @@ struct qcom_ubwc_cfg_data {
 	 * UBWC 1.0 always enables all three levels.
 	 * UBWC 2.0 removes level 1 bank swizzling, leaving levels 2 & 3.
 	 * UBWC 4.0 adds the optional ability to disable levels 2 & 3.
-	 *
-	 * This is a bitmask where BIT(0) enables level 1, BIT(1)
-	 * controls level 2, and BIT(2) enables level 3.
 	 */
 	u32 ubwc_swizzle;
+#define UBWC_SWIZZLE_ENABLE_LVL1	BIT(0)
+#define UBWC_SWIZZLE_ENABLE_LVL2	BIT(1)
+#define UBWC_SWIZZLE_ENABLE_LVL3	BIT(2)
 
 	/**
 	 * @highest_bank_bit: Highest Bank Bit
@@ -65,7 +65,7 @@ static inline bool qcom_ubwc_get_ubwc_mode(const struct qcom_ubwc_cfg_data *cfg)
 {
 	bool ret = cfg->ubwc_enc_version == UBWC_1_0;
 
-	if (ret && !(cfg->ubwc_swizzle & BIT(0)))
+	if (ret && !(cfg->ubwc_swizzle & UBWC_SWIZZLE_ENABLE_LVL1))
 		pr_err("UBWC config discrepancy - level 1 swizzling disabled on UBWC 1.0\n");
 
 	return ret;

-- 
2.49.0


