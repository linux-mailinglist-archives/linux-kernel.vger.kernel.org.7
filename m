Return-Path: <linux-kernel+bounces-738216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DD3B0B600
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A148B7AD7F5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314F421CFF6;
	Sun, 20 Jul 2025 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QniFaGDN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5E520E71C
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013842; cv=none; b=g6UpPnJZaHxj77jsYxqy9ECHsbhJ+K+USNB2MOVY1IsMg9pL4eufh69qkCux7E3Gha5Xv2khSRm8Zzu7d6pd5USolKU3T/QypbQ2p/snpGmIgx8AW7RxhFkwKt11D6g7Kx6tvT4sED1D9RwQ/S+ROcmQL9gviG+JfjgFwSn0sMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013842; c=relaxed/simple;
	bh=/vk/IY1MxYK7Q8PcqzCSsbH+EycuMXiRl4FMmAVgRoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1Qk0YFdHDUnFoR5OFADSOpKLIkKvrU5Nrch2woYfYYlzE3jSfDXTXPIIahw4orGY4848WyCqDaKzpNYeOS26deYHqckzzt2qU+nSNmvX7h4f97WBQLb/Tnx3qtRxwMedpMY/zrySl3ednJ2hWxJBQGYxFz5CxAUJ8cAwFRLSpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QniFaGDN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KAudUK025336
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JZJfA7Qabzy/jPdKR6dbafyKFe2qpCis68oXDiINUR8=; b=QniFaGDNP/do/+Bx
	IXKGDiPOma1/MEmHD4p1xVElDLJUA5NoxBC2yFy1FzH0FlQGiQUlWV5KRvh0LXgw
	yQ0QfofNGHf6rRgqq9nqk4Hcxw/66t//HVwLI2ukfsr5/G+AMNBPRCcSnzTbcg3H
	c+9U2QDg4ANoBJp7xzKwBw1ppNNmteGx2Hx52hUs0y2A5R3jdb+BAF4kwUqkNIHU
	YhW6Ko9mAS2Dy5564+QwwAPn+AipiWS+b2U8jilotcKvd3HOcOHnZC0ifYxy0wR0
	gPwVU5yTs+Kn4erpxtnoXM0blhd3DRQVoXM9O3Myo8P7MgheaBuhNYYqXYyQ+IbQ
	2xcL2w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480459j5tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:17:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-75494e5417bso3299038b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 05:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753013839; x=1753618639;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZJfA7Qabzy/jPdKR6dbafyKFe2qpCis68oXDiINUR8=;
        b=nMSsXnRFtEOn21vhjd0ps9Hej+qxMPftrJR9xwVsJs84Cd6rQgEMXK0bfax6ZSIMt1
         ka5MJ7iw9FgGvyWVweq0BtkWdpGRWAxJ2wk6hvnu91fRm5OdRnej4E/4mJrtZtVCwWV2
         donAqrcFIgdRN4U4MTK8MlifIB7j8m6k9pEOYnKCxXSSE+Nm++RuM1AMURAV+xrt6qYn
         nyVtXs87jDZowMxhT6cjBEytaHge701rD16M67JfX5RcxtoMiWKOftKsVNehDwITDzvG
         5G4nCsaD6n6pDQpe5BUZpas0te9uQbFCpkqyKFee48Lului1Ln9q5Vy3pgVtZNNVfgeh
         mXeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL5Q+frGgo312hsQbe0UWG9V6mdt1DiG1G6zUcr5wP1sUu/biA0tTvEJrSx2X5SDfriudJ5uGcFJqw8WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xm2J93xi6mjRRIOjCgPXp1dGi3oAWSZbJFCUqsC6D/rRWjdA
	XCDG7IU00BgTZWirPAVW8UhzJdTf5vMfjC2CdLJN9XJ9URkjdBFugKKh/wJWpbB7VkUSoY+j35R
	skskWb6CdRylUE9SzVyAqgS91d9rpp3dLkLjxydGgR6PG4Vv3YispLQQRFIvRkoHSHzw=
X-Gm-Gg: ASbGncsRSvJwcNMH1A7GshXEEjjE7JPDKOLF1cAT3JGF0k5RoaO5vSJNhZKXCxaCjXs
	TOemkQSqLU75+CEuHzJ4xmROnI26ssttrxIJ29xmSz8PVM7+fb0GP2c+ng+BYSVXu+Di8/uRd75
	cawAXwLTXxtsTlsY8xXxhtf2OfJ3AAT2G58rHm8Q1wNwJFHZTJCtfKEggA/NK4r6MvjDsBt5Lbq
	dpWTL1waACQq5TQfldDVKn/+Vg1GzsTZbR5zaP0V7XKgRgO5rg7bkq9vkjamNhhWUsXZhNmOcfw
	n4aw3DaXJVy4rJtFcSA+ynctR7QiLzNG+ozl3QXGw3h5njdwqFNQtuXuCpdk1xZ0
X-Received: by 2002:a05:6a00:420a:b0:748:e289:6bc with SMTP id d2e1a72fcca58-75836fac119mr17123873b3a.1.1753013838815;
        Sun, 20 Jul 2025 05:17:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENusTlFJiMacijONMXXzlEhWQ1XUh20Qf6EGIIO9giZDiOveTZLnhER6oVE7SDZtpmrfWuOw==
X-Received: by 2002:a05:6a00:420a:b0:748:e289:6bc with SMTP id d2e1a72fcca58-75836fac119mr17123843b3a.1.1753013838259;
        Sun, 20 Jul 2025 05:17:18 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb154755sm4097933b3a.69.2025.07.20.05.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 05:17:17 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 17:46:08 +0530
Subject: [PATCH 07/17] drm/msm/adreno: Add fenced regwrite support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-ifpc-support-v1-7-9347aa5bcbd6@oss.qualcomm.com>
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
In-Reply-To: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753013805; l=6397;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=/vk/IY1MxYK7Q8PcqzCSsbH+EycuMXiRl4FMmAVgRoQ=;
 b=Mu9aI8+DlG6130/5EfeEicUbbv/YtgJy+WV1EGcF5mRD6lC331N7JjIliGVOQC20WGkOs6Kb6
 xJB0tuu1I+qB1J0HqAMZTwOqHLkPaGBrjvEfDyAjcD1MaFVKjQJd2+K
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: b5P93fy6KIpYD_alRkPAJDA-L8ermWEZ
X-Authority-Analysis: v=2.4 cv=fdyty1QF c=1 sm=1 tr=0 ts=687cde4f cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=YYoBuv6U7x1zitwOiNcA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: b5P93fy6KIpYD_alRkPAJDA-L8ermWEZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDExNyBTYWx0ZWRfX0nAgMF1HcV/U
 Dv8tC/ST94XJsBROz052VOLalBMUHJNLNb5WiFNJkUIBGG/Ghz/0rm9gAf/LvnF4s10k+b3o/FR
 pL2jyyKcCBcMGI1FXIeE2rqMRohrRi54TSyPVEUAYOH1Btcj3eecRbgDzJzv/FMDVhuFQryVqTm
 /eBa0Tx2kL1NGJAWYo+/r6iXVIoPqcuCta4/2PpahlHWOFZ04XGAUp7YomdojTf0+xGC0jbXUhq
 gp//ClhX5esFDxVskB6S5YHF0OiCgv/rml2s3X4vWkBVxCPPIOIqUQwcdIdi/Wg4nDjEVt8taxt
 nHcl8rb1CP+oEUpQKFndx1NJi1a8NQO16gpHK/m80V/2U0zXxx4N9OKnD31NP9iihAPfVMTKZQP
 VfGiaCFQFNHG48fXUC9oBUK/LDfsMtDm7taZweG32z8dqkyGZmcyNUVljcuFGg0f9IDjvC60
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200117

There are some special registers which are accessible even when GX power
domain is collapsed during an IFPC sleep. Accessing these registers
wakes up GPU from power collapse and allow programming these registers
without additional handshake with GMU. This patch adds support for this
special register write sequence.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 63 ++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 20 +++++-----
 3 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 491fde0083a202bec7c6b3bca88d0e5a717a6560..8c004fc3abd2896d467a9728b34e99e4ed944dc4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -16,6 +16,67 @@
 
 #define GPU_PAS_ID 13
 
+static bool fence_status_check(struct msm_gpu *gpu, u32 offset, u32 value, u32 status, u32 mask)
+{
+	/* Success if !writedropped0/1 */
+	if (!(status & mask))
+		return true;
+
+	udelay(10);
+
+	/* Try to update fenced register again */
+	gpu_write(gpu, offset, value);
+	return false;
+}
+
+static int fenced_write(struct a6xx_gpu *a6xx_gpu, u32 offset, u32 value, u32 mask)
+{
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct msm_gpu *gpu = &adreno_gpu->base;
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+	u32 status;
+
+	gpu_write(gpu, offset, value);
+
+	/* Nothing else to be done in the case of no-GMU */
+	if (adreno_has_gmu_wrapper(adreno_gpu))
+		return 0;
+
+	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
+			fence_status_check(gpu, offset, value, status, mask), 0, 1000))
+		return 0;
+
+	dev_err_ratelimited(gmu->dev, "delay in fenced register write (0x%x)\n",
+			offset);
+
+	/* Try again for another 1ms before failing */
+	gpu_write(gpu, offset, value);
+	if (!gmu_poll_timeout(gmu, REG_A6XX_GMU_AHB_FENCE_STATUS, status,
+			fence_status_check(gpu, offset, value, status, mask), 0, 1000))
+		return 0;
+
+	dev_err_ratelimited(gmu->dev, "fenced register write (0x%x) fail\n",
+			offset);
+
+	return -ETIMEDOUT;
+}
+
+int a6xx_fenced_write(struct a6xx_gpu *a6xx_gpu, u32 offset, u64 value, u32 mask, bool is_64b)
+{
+	int ret;
+
+	ret = fenced_write(a6xx_gpu, offset, lower_32_bits(value), mask);
+	if (ret)
+		return ret;
+
+	if (!is_64b)
+		return 0;
+
+	ret = fenced_write(a6xx_gpu, offset + 1, upper_32_bits(value), mask);
+
+	return ret;
+}
+
 static inline bool _a6xx_check_idle(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -86,7 +147,7 @@ static void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	/* Update HW if this is the current ring and we are not in preempt*/
 	if (!a6xx_in_preempt(a6xx_gpu)) {
 		if (a6xx_gpu->cur_ring == ring)
-			gpu_write(gpu, REG_A6XX_CP_RB_WPTR, wptr);
+			a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_RB_WPTR, wptr, BIT(0), false);
 		else
 			ring->restore_wptr = true;
 	} else {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 9201a53dd341bf432923ffb44947e015208a3d02..2be036a3faca58b4b559c30881e4b31d5929592a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -291,5 +291,6 @@ int a6xx_gpu_state_put(struct msm_gpu_state *state);
 
 void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
 void a6xx_gpu_sw_reset(struct msm_gpu *gpu, bool assert);
+int a6xx_fenced_write(struct a6xx_gpu *gpu, u32 offset, u64 value, u32 mask, bool is_64b);
 
 #endif /* __A6XX_GPU_H__ */
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
index 3b17fd2dba89115a8e48ba9469e52e4305b0cdbb..5b0fd510ff58d989ab285f1a2497f6f522a6b187 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
@@ -41,7 +41,7 @@ static inline void set_preempt_state(struct a6xx_gpu *gpu,
 }
 
 /* Write the most recent wptr for the given ring into the hardware */
-static inline void update_wptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
+static inline void update_wptr(struct a6xx_gpu *a6xx_gpu, struct msm_ringbuffer *ring)
 {
 	unsigned long flags;
 	uint32_t wptr;
@@ -51,7 +51,7 @@ static inline void update_wptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	if (ring->restore_wptr) {
 		wptr = get_wptr(ring);
 
-		gpu_write(gpu, REG_A6XX_CP_RB_WPTR, wptr);
+		a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_RB_WPTR, wptr, BIT(0), false);
 
 		ring->restore_wptr = false;
 	}
@@ -172,7 +172,7 @@ void a6xx_preempt_irq(struct msm_gpu *gpu)
 
 	set_preempt_state(a6xx_gpu, PREEMPT_FINISH);
 
-	update_wptr(gpu, a6xx_gpu->cur_ring);
+	update_wptr(a6xx_gpu, a6xx_gpu->cur_ring);
 
 	set_preempt_state(a6xx_gpu, PREEMPT_NONE);
 
@@ -268,7 +268,7 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
 	 */
 	if (!ring || (a6xx_gpu->cur_ring == ring)) {
 		set_preempt_state(a6xx_gpu, PREEMPT_FINISH);
-		update_wptr(gpu, a6xx_gpu->cur_ring);
+		update_wptr(a6xx_gpu, a6xx_gpu->cur_ring);
 		set_preempt_state(a6xx_gpu, PREEMPT_NONE);
 		spin_unlock_irqrestore(&a6xx_gpu->eval_lock, flags);
 		return;
@@ -302,13 +302,13 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
 
 	spin_unlock_irqrestore(&ring->preempt_lock, flags);
 
-	gpu_write64(gpu,
-		REG_A6XX_CP_CONTEXT_SWITCH_SMMU_INFO,
-		a6xx_gpu->preempt_smmu_iova[ring->id]);
+	a6xx_fenced_write(a6xx_gpu,
+		REG_A6XX_CP_CONTEXT_SWITCH_SMMU_INFO, a6xx_gpu->preempt_smmu_iova[ring->id],
+		BIT(1), true);
 
-	gpu_write64(gpu,
+	a6xx_fenced_write(a6xx_gpu,
 		REG_A6XX_CP_CONTEXT_SWITCH_PRIV_NON_SECURE_RESTORE_ADDR,
-		a6xx_gpu->preempt_iova[ring->id]);
+		a6xx_gpu->preempt_iova[ring->id], BIT(1), true);
 
 	a6xx_gpu->next_ring = ring;
 
@@ -328,7 +328,7 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
 	set_preempt_state(a6xx_gpu, PREEMPT_TRIGGERED);
 
 	/* Trigger the preemption */
-	gpu_write(gpu, REG_A6XX_CP_CONTEXT_SWITCH_CNTL, cntl);
+	a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_CONTEXT_SWITCH_CNTL, cntl, BIT(1), false);
 }
 
 static int preempt_init_ring(struct a6xx_gpu *a6xx_gpu,

-- 
2.50.1


