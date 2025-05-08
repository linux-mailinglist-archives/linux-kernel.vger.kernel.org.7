Return-Path: <linux-kernel+bounces-640255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A731BAB0258
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 20:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653F19E63B9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 18:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221A42882C0;
	Thu,  8 May 2025 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLNmiOMb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899F2882B1;
	Thu,  8 May 2025 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728021; cv=none; b=XF347p/9LjB/HDJ1YapWlpCCEr4cwabfsPtrANWm523htNgR9svKKgTq2wQ/NRDfghfli3TqX4AeAQItcw6EZsH1mbxzB7yAZ6LjPIWfqb/+o0JHQqkD6cNsNkqOFMrYTbm5vALFoDzOOvVIgs9mnhRlTh+goVcAFcmTEC39s0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728021; c=relaxed/simple;
	bh=gKs+6I7HFNL4vgoYUREY/5NovhmbeB9QBo6jMB6yzdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oEv60JuZW+jzcUw/hijWclwlKAylKqS2oTU+9SZwceVJmn8lMEEmrtOiK3oQQMxehLaQXNB+k/22YK6EFwCC3JH9GQVkurzamMZEI49XTk2p4CBt4JliL05ZEmTYblYbUD9WTEmfMvI+MMK9tAMuKFtemvjsS2qZf+IwEgvcvRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLNmiOMb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892A4C4CEE7;
	Thu,  8 May 2025 18:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746728019;
	bh=gKs+6I7HFNL4vgoYUREY/5NovhmbeB9QBo6jMB6yzdY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MLNmiOMbK7gvEJ1JRWBqhM+vuG5q9xeOy2C9zuoA4TCEcLbKS6FCuTMdrxcz682EW
	 1WAha4yHFV3521TMQAZOTq5HNPS8+y+TeucZGauYOpZ3zOF0uNeiGqxCLsvmQNO/yQ
	 QrXTQeZDMvtuTwHH3IYdqne/cRhY619E0zIP9Hrq425MrbXLjYi0XIhKkaOMWIhidg
	 vTB4MojGWz6EK13yXXER7XWe1yjbphLQQByQlybiGwi6kUBl14seH41KbUYVj6hqDV
	 ySeCBJPtvpRE1OlqUZ4T8RuXzEiQjqk6g1jEe2Vn5Mk0onv2TwG8jaokBDjiKMUFUb
	 LXeLxsutU7bfw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Thu, 08 May 2025 20:12:35 +0200
Subject: [PATCH RFT 03/14] drm/msm/adreno: Offset the HBB value by 13
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-topic-ubwc_central-v1-3-035c4c5cbe50@oss.qualcomm.com>
References: <20250508-topic-ubwc_central-v1-0-035c4c5cbe50@oss.qualcomm.com>
In-Reply-To: <20250508-topic-ubwc_central-v1-0-035c4c5cbe50@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746728002; l=5290;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=7Ey6T75TSm0Twsi0E4oRdCq8mhoNTIt1V/RJgSqVTnA=;
 b=TfGpK+u8EjVv8YFnRQI/mm5Y3HNNfkPgJxRTKHKNDWSDXV44+Sgd5n+s0zc8/3+Q+M/0BzF7A
 uIfmEsR9wszApiq1TLbkDlCLvYZIxW8zC2DNGpD8VLulqEzVvnyAsHC
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The value the UBWC hardware expects is 13 less than the actual value.
To make it easier to migrate to a common UBWC configuration table,
defer that logic to the data source (which is currently a number of
if-else statements with assignments in case of this driver).

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c |  7 +++----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 30 ++++++++++++------------------
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 650e5bac225f372e819130b891f1d020b464f17f..67331a7ee750c0d9eeeead9440e5d08b1a09c878 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -833,8 +833,7 @@ static int a5xx_hw_init(struct msm_gpu *gpu)
 
 	gpu_write(gpu, REG_A5XX_RBBM_AHB_CNTL2, 0x0000003F);
 
-	BUG_ON(adreno_gpu->ubwc_config.highest_bank_bit < 13);
-	hbb = adreno_gpu->ubwc_config.highest_bank_bit - 13;
+	hbb = adreno_gpu->ubwc_config.highest_bank_bit;
 
 	gpu_write(gpu, REG_A5XX_TPL1_MODE_CNTL, hbb << 7);
 	gpu_write(gpu, REG_A5XX_RB_MODE_CNTL, hbb << 1);
@@ -1792,9 +1791,9 @@ struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 
 	/* Set the highest bank bit */
 	if (adreno_is_a540(adreno_gpu) || adreno_is_a530(adreno_gpu))
-		adreno_gpu->ubwc_config.highest_bank_bit = 15;
+		adreno_gpu->ubwc_config.highest_bank_bit = 2;
 	else
-		adreno_gpu->ubwc_config.highest_bank_bit = 14;
+		adreno_gpu->ubwc_config.highest_bank_bit = 1;
 
 	/* a5xx only supports UBWC 1.0, these are not configurable */
 	adreno_gpu->ubwc_config.macrotile_mode = 0;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index bf3758f010f4079aa86f9c658b52a70acf10b488..b161b5cd991fc645dfcd69754b82be9691775ffe 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -592,32 +592,32 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
 	gpu->ubwc_config.min_acc_len = 0;
 	gpu->ubwc_config.ubwc_swizzle = 0x6;
 	gpu->ubwc_config.macrotile_mode = 0;
-	gpu->ubwc_config.highest_bank_bit = 15;
+	gpu->ubwc_config.highest_bank_bit = 2;
 
 	if (adreno_is_a610(gpu)) {
-		gpu->ubwc_config.highest_bank_bit = 13;
+		gpu->ubwc_config.highest_bank_bit = 0;
 		gpu->ubwc_config.min_acc_len = 1;
 		gpu->ubwc_config.ubwc_swizzle = 0x7;
 	}
 
 	if (adreno_is_a618(gpu))
-		gpu->ubwc_config.highest_bank_bit = 14;
+		gpu->ubwc_config.highest_bank_bit = 1;
 
 	if (adreno_is_a619(gpu))
 		/* TODO: Should be 14 but causes corruption at e.g. 1920x1200 on DP */
-		gpu->ubwc_config.highest_bank_bit = 13;
+		gpu->ubwc_config.highest_bank_bit = 0;
 
 	if (adreno_is_a619_holi(gpu))
-		gpu->ubwc_config.highest_bank_bit = 13;
+		gpu->ubwc_config.highest_bank_bit = 0;
 
 	if (adreno_is_a621(gpu)) {
-		gpu->ubwc_config.highest_bank_bit = 13;
+		gpu->ubwc_config.highest_bank_bit = 0;
 		gpu->ubwc_config.amsbc = 1;
 		gpu->ubwc_config.uavflagprd_inv = 2;
 	}
 
 	if (adreno_is_a623(gpu)) {
-		gpu->ubwc_config.highest_bank_bit = 16;
+		gpu->ubwc_config.highest_bank_bit = 3;
 		gpu->ubwc_config.amsbc = 1;
 		gpu->ubwc_config.rgb565_predicator = 1;
 		gpu->ubwc_config.uavflagprd_inv = 2;
@@ -636,7 +636,7 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
 	    adreno_is_a730(gpu) ||
 	    adreno_is_a740_family(gpu)) {
 		/* TODO: get ddr type from bootloader and use 2 for LPDDR4 */
-		gpu->ubwc_config.highest_bank_bit = 16;
+		gpu->ubwc_config.highest_bank_bit = 3;
 		gpu->ubwc_config.amsbc = 1;
 		gpu->ubwc_config.rgb565_predicator = 1;
 		gpu->ubwc_config.uavflagprd_inv = 2;
@@ -644,7 +644,7 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
 	}
 
 	if (adreno_is_a663(gpu)) {
-		gpu->ubwc_config.highest_bank_bit = 13;
+		gpu->ubwc_config.highest_bank_bit = 0;
 		gpu->ubwc_config.amsbc = 1;
 		gpu->ubwc_config.rgb565_predicator = 1;
 		gpu->ubwc_config.uavflagprd_inv = 2;
@@ -653,14 +653,14 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
 	}
 
 	if (adreno_is_7c3(gpu)) {
-		gpu->ubwc_config.highest_bank_bit = 14;
+		gpu->ubwc_config.highest_bank_bit = 1;
 		gpu->ubwc_config.amsbc = 1;
 		gpu->ubwc_config.uavflagprd_inv = 2;
 		gpu->ubwc_config.macrotile_mode = 1;
 	}
 
 	if (adreno_is_a702(gpu)) {
-		gpu->ubwc_config.highest_bank_bit = 14;
+		gpu->ubwc_config.highest_bank_bit = 1;
 		gpu->ubwc_config.min_acc_len = 1;
 	}
 }
@@ -668,13 +668,7 @@ static void a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
 static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
-	/*
-	 * We subtract 13 from the highest bank bit (13 is the minimum value
-	 * allowed by hw) and write the lowest two bits of the remaining value
-	 * as hbb_lo and the one above it as hbb_hi to the hardware.
-	 */
-	BUG_ON(adreno_gpu->ubwc_config.highest_bank_bit < 13);
-	u32 hbb = adreno_gpu->ubwc_config.highest_bank_bit - 13;
+	u32 hbb = adreno_gpu->ubwc_config.highest_bank_bit;
 	u32 hbb_hi = hbb >> 2;
 	u32 hbb_lo = hbb & 3;
 	u32 ubwc_mode = adreno_gpu->ubwc_config.ubwc_swizzle & 1;

-- 
2.49.0


