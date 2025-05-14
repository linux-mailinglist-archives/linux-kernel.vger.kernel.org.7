Return-Path: <linux-kernel+bounces-647898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CC1AB6F37
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 17:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72854162CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 15:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1DE1DFD8B;
	Wed, 14 May 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/Mx0YfO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E441C84BB;
	Wed, 14 May 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235458; cv=none; b=ETnB0SEUOh8wAxw/R8uI07GefaHRSd8sZkxOj20JQKOik2iK1SPEQO8rcPpYHr9ubzoAjGTE/uPcOjrJjgHINO9QZ7ZM+/6gUgHlzip6j2EVYEfCaoZwN5l2siwtVS0kZaLcRsEEtixUk5jQNAsAHiYT20wZ+0LhwG7EjLB/zE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235458; c=relaxed/simple;
	bh=8IiJ7TfHpgwzHF1zZolA7SKhmyykwTNJSFjEHGPviYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NDhvcyVZRkDLsS3VGCgijqrHezcV5Mx680GExU5t6ydQGleLtCcwkXQoLlrHk7Fay07VYak2is5zxU4fFd8joepk8b4TH7jR/B18gzgAq/iO6RARwoS72lpCI0AZh4n4xlCKSZh3jpauKsob1xtlAtH8E4+keB5LZINGvOkC4B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/Mx0YfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7E0C4CEE9;
	Wed, 14 May 2025 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747235458;
	bh=8IiJ7TfHpgwzHF1zZolA7SKhmyykwTNJSFjEHGPviYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B/Mx0YfOLj4g/trTT4J2Yd0zRQPx6Qz/jtTt8CA0Ec6Cc5ntTcaZBdixYcQIAwcxF
	 q4qBQN4L4auY25Kfc9iMkFO5R88Ap5bvrb3iUzzoD+lKrTi/LEJDBTtZO+K62l+Jmy
	 32JyUfiX/4q0fqJwIw2YSMaEPtYJGVzIGQEWeRUNByTbVYCUSbksxXu38cQD0N4wB1
	 ETlcoHtfEUXZx4vyU2dDyRmN8kb6s2r0IermLLwpQ7dENYuV8at50O/V6JMbNGlp+f
	 NrRnSLdAGhV6+ZWADzwQSIuzR7jfVuqL0wKDtZm21kFrgtFraOiquDOEIbfppJvJlS
	 bUZhLxfLgnoCQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 14 May 2025 17:10:22 +0200
Subject: [PATCH RFT v2 02/15] drm/msm: Offset MDSS HBB value by 13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-topic-ubwc_central-v2-2-09ecbc0a05ce@oss.qualcomm.com>
References: <20250514-topic-ubwc_central-v2-0-09ecbc0a05ce@oss.qualcomm.com>
In-Reply-To: <20250514-topic-ubwc_central-v2-0-09ecbc0a05ce@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747235442; l=7276;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=hLzGR3olZDh/aHeaHc3gE9Za/o8UapiYfK6HVRGZaEU=;
 b=vUBNlIFrrxBQxln6zKxvENFcgHebEo8GC0524RMmJo7aQP2mN8+X8avSEZiycXe1G2shvAtZV
 PXSeUi3uJazDMDOxtH2g+j501vM7ZbpnzlyR0RGwURIXVJoiiLFdc47
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The Adreno part of the driver exposes this value to userspace, and the
SMEM data source also presents a x+13 value. Keep things coherent and
make the value uniform across them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 50 +++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 709979fcfab6062c0f316f7655823e888638bfea..2c9531217eca7ac2308c6d1fa78287363ca652f9 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -167,7 +167,7 @@ static void msm_mdss_setup_ubwc_dec_20(struct msm_mdss *msm_mdss)
 {
 	const struct msm_mdss_data *data = msm_mdss->mdss_data;
 	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
-		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit);
+		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 
 	if (data->ubwc_bank_spread)
 		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
@@ -182,7 +182,7 @@ static void msm_mdss_setup_ubwc_dec_30(struct msm_mdss *msm_mdss)
 {
 	const struct msm_mdss_data *data = msm_mdss->mdss_data;
 	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle & 0x1) |
-		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit);
+		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 
 	if (data->macrotile_mode)
 		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
@@ -200,7 +200,7 @@ static void msm_mdss_setup_ubwc_dec_40(struct msm_mdss *msm_mdss)
 {
 	const struct msm_mdss_data *data = msm_mdss->mdss_data;
 	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
-		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit);
+		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 
 	if (data->ubwc_bank_spread)
 		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
@@ -259,9 +259,9 @@ static const struct msm_mdss_data *msm_mdss_generate_mdp5_mdss_data(struct msm_m
 
 	if (hw_rev == MDSS_HW_MSM8996 ||
 	    hw_rev == MDSS_HW_MSM8998)
-		data->highest_bank_bit = 2;
+		data->highest_bank_bit = 15;
 	else
-		data->highest_bank_bit = 1;
+		data->highest_bank_bit = 14;
 
 	return data;
 }
@@ -572,13 +572,13 @@ static void mdss_remove(struct platform_device *pdev)
 static const struct msm_mdss_data msm8998_data = {
 	.ubwc_enc_version = UBWC_1_0,
 	.ubwc_dec_version = UBWC_1_0,
-	.highest_bank_bit = 2,
+	.highest_bank_bit = 15,
 	.reg_bus_bw = 76800,
 };
 
 static const struct msm_mdss_data qcm2290_data = {
 	/* no UBWC */
-	.highest_bank_bit = 0x2,
+	.highest_bank_bit = 15,
 	.reg_bus_bw = 76800,
 };
 
@@ -587,7 +587,7 @@ static const struct msm_mdss_data sa8775p_data = {
 	.ubwc_dec_version = UBWC_4_0,
 	.ubwc_swizzle = 4,
 	.ubwc_bank_spread = true,
-	.highest_bank_bit = 0,
+	.highest_bank_bit = 13,
 	.macrotile_mode = true,
 	.reg_bus_bw = 74000,
 };
@@ -597,7 +597,7 @@ static const struct msm_mdss_data sar2130p_data = {
 	.ubwc_dec_version = UBWC_4_3,
 	.ubwc_swizzle = 6,
 	.ubwc_bank_spread = true,
-	.highest_bank_bit = 0,
+	.highest_bank_bit = 13,
 	.macrotile_mode = 1,
 	.reg_bus_bw = 74000,
 };
@@ -607,7 +607,7 @@ static const struct msm_mdss_data sc7180_data = {
 	.ubwc_dec_version = UBWC_2_0,
 	.ubwc_swizzle = 6,
 	.ubwc_bank_spread = true,
-	.highest_bank_bit = 0x1,
+	.highest_bank_bit = 14,
 	.reg_bus_bw = 76800,
 };
 
@@ -616,7 +616,7 @@ static const struct msm_mdss_data sc7280_data = {
 	.ubwc_dec_version = UBWC_4_0,
 	.ubwc_swizzle = 6,
 	.ubwc_bank_spread = true,
-	.highest_bank_bit = 1,
+	.highest_bank_bit = 14,
 	.macrotile_mode = true,
 	.reg_bus_bw = 74000,
 };
@@ -624,7 +624,7 @@ static const struct msm_mdss_data sc7280_data = {
 static const struct msm_mdss_data sc8180x_data = {
 	.ubwc_enc_version = UBWC_3_0,
 	.ubwc_dec_version = UBWC_3_0,
-	.highest_bank_bit = 3,
+	.highest_bank_bit = 16,
 	.macrotile_mode = true,
 	.reg_bus_bw = 76800,
 };
@@ -634,7 +634,7 @@ static const struct msm_mdss_data sc8280xp_data = {
 	.ubwc_dec_version = UBWC_4_0,
 	.ubwc_swizzle = 6,
 	.ubwc_bank_spread = true,
-	.highest_bank_bit = 3,
+	.highest_bank_bit = 16,
 	.macrotile_mode = true,
 	.reg_bus_bw = 76800,
 };
@@ -642,14 +642,14 @@ static const struct msm_mdss_data sc8280xp_data = {
 static const struct msm_mdss_data sdm670_data = {
 	.ubwc_enc_version = UBWC_2_0,
 	.ubwc_dec_version = UBWC_2_0,
-	.highest_bank_bit = 1,
+	.highest_bank_bit = 14,
 	.reg_bus_bw = 76800,
 };
 
 static const struct msm_mdss_data sdm845_data = {
 	.ubwc_enc_version = UBWC_2_0,
 	.ubwc_dec_version = UBWC_2_0,
-	.highest_bank_bit = 2,
+	.highest_bank_bit = 15,
 	.reg_bus_bw = 76800,
 };
 
@@ -658,21 +658,21 @@ static const struct msm_mdss_data sm6350_data = {
 	.ubwc_dec_version = UBWC_2_0,
 	.ubwc_swizzle = 6,
 	.ubwc_bank_spread = true,
-	.highest_bank_bit = 1,
+	.highest_bank_bit = 14,
 	.reg_bus_bw = 76800,
 };
 
 static const struct msm_mdss_data sm7150_data = {
 	.ubwc_enc_version = UBWC_2_0,
 	.ubwc_dec_version = UBWC_2_0,
-	.highest_bank_bit = 1,
+	.highest_bank_bit = 14,
 	.reg_bus_bw = 76800,
 };
 
 static const struct msm_mdss_data sm8150_data = {
 	.ubwc_enc_version = UBWC_3_0,
 	.ubwc_dec_version = UBWC_3_0,
-	.highest_bank_bit = 2,
+	.highest_bank_bit = 15,
 	.reg_bus_bw = 76800,
 };
 
@@ -681,7 +681,7 @@ static const struct msm_mdss_data sm6115_data = {
 	.ubwc_dec_version = UBWC_2_0,
 	.ubwc_swizzle = 7,
 	.ubwc_bank_spread = true,
-	.highest_bank_bit = 0x1,
+	.highest_bank_bit = 14,
 	.reg_bus_bw = 76800,
 };
 
@@ -689,13 +689,13 @@ static const struct msm_mdss_data sm6125_data = {
 	.ubwc_enc_version = UBWC_1_0,
 	.ubwc_dec_version = UBWC_3_0,
 	.ubwc_swizzle = 1,
-	.highest_bank_bit = 1,
+	.highest_bank_bit = 14,
 };
 
 static const struct msm_mdss_data sm6150_data = {
 	.ubwc_enc_version = UBWC_2_0,
 	.ubwc_dec_version = UBWC_2_0,
-	.highest_bank_bit = 1,
+	.highest_bank_bit = 14,
 	.reg_bus_bw = 76800,
 };
 
@@ -705,7 +705,7 @@ static const struct msm_mdss_data sm8250_data = {
 	.ubwc_swizzle = 6,
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
-	.highest_bank_bit = 3,
+	.highest_bank_bit = 16,
 	.macrotile_mode = true,
 	.reg_bus_bw = 76800,
 };
@@ -716,7 +716,7 @@ static const struct msm_mdss_data sm8350_data = {
 	.ubwc_swizzle = 6,
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
-	.highest_bank_bit = 3,
+	.highest_bank_bit = 16,
 	.macrotile_mode = true,
 	.reg_bus_bw = 74000,
 };
@@ -727,7 +727,7 @@ static const struct msm_mdss_data sm8550_data = {
 	.ubwc_swizzle = 6,
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
-	.highest_bank_bit = 3,
+	.highest_bank_bit = 16,
 	.macrotile_mode = true,
 	.reg_bus_bw = 57000,
 };
@@ -738,7 +738,7 @@ static const struct msm_mdss_data x1e80100_data = {
 	.ubwc_swizzle = 6,
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
-	.highest_bank_bit = 3,
+	.highest_bank_bit = 16,
 	.macrotile_mode = true,
 	/* TODO: Add reg_bus_bw with real value */
 };

-- 
2.49.0


