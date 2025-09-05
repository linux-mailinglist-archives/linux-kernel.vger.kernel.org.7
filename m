Return-Path: <linux-kernel+bounces-801863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D5BB44AE5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83754189D0D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251351DE2C9;
	Fri,  5 Sep 2025 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D6+8D8YC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465581D86FF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 00:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757032738; cv=none; b=JCxzhiLcr4XhDrpecEAqO3PLVLFK62QEYOpkjMOisSL98BP4HvvulF34LPEhG6Vhvgub+DN1kt2dukmnoIEy1Qxg6UJvzZUl1BDDpIPzeIgjuyl0iYUKki9t3Ct1IHLz+Mcm83ovT4jRfAspaPFSn0hAFjHLFxgn2c7jltJE9Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757032738; c=relaxed/simple;
	bh=9Q5DBCw+1k2q8jQmkOcZzq3I92Gkam7S2gIJxMUuwQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VmrlgYQxTj8YDTxw2/ndOJwykdfWO1syUbpe4HAabh9KkduMm1Vj1av/dDtxWGXzg/kAd/QwaYS9/2OJMkKLpuGwL1UXGMMbXXSMf1dAxh5qcUB0CU7bCKkT6xjQL9mEgBL2x9Ykw0YejmwRK7kf5r/3zYTNr1CctXB/9zGSKBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D6+8D8YC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584IiOfN022986
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 00:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JIDrCu3rz5oiUxwp15VOp/6eIHgk9Q1mb18i7DMZfyQ=; b=D6+8D8YCEmhw1rw0
	3FTiz+fRA3CUHuOH521j+Tcfqpa1lQy7GyV/3ZWoWgPwnBhonkPXPJmBRymxjROB
	W2CPAY8RJq8whLAXL0++6RJZdqjjEpgQa9rw0SrjHJ5My+h8gjW7KnZdoI13S/4M
	fTcL8NBXVA41er0ML+XvtYGt2ElAnfdPmq52wRg3oit+2mU+QSD5XWaDqtUX7xKO
	KnFuvkO1qfWCWDax4Hi2QaA9iUHF5YgWPjcVJ3THFnCCtQp197Jubm9XXEoM98kT
	DnOV/a4vSBGNhSLwCs1jnZd9cczmGUF3uiKVyB89xBmjX+VzZhPhDDcJsZyMZ0i3
	Vb5s6Q==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0esech-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:38:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-71ff3e1256cso30370026d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 17:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757032734; x=1757637534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIDrCu3rz5oiUxwp15VOp/6eIHgk9Q1mb18i7DMZfyQ=;
        b=jQJm49ZzeXEEtewnw7PBeYXbQVbqbU4ettxYMhxGXYyWgRDYljEbdfmJyhX1K48SA9
         NENAcam6cghytlaw/Oi0UQas3e07N0QeYXnntjsks/ps5ZFSMmhGWyeBhwQLfs4g38AB
         E8uEn93PzJKWWbccFUqi/r0JU/aq3cjPN9Q8a8qo86z1XQuZkP9FIhlp+xQMxgdIDWKX
         JjVMp++ecwi0On6SiOBP4QOJvtrIsRWUVdXKpuzIuMfpAQvFOWA1igmQ//Etxf2p9T0T
         1ISm8UbCDL4whQkUfvgARVtzM9Ua8Emt3CLddcaS4yhRBEfTPd1BbROTW1Qg9oXG0TzN
         Jv1g==
X-Forwarded-Encrypted: i=1; AJvYcCWVSozrZQsFLNfnbJOE+0qvemxbMMCCx01vGO0VzZHNsicQzGEeg6Po6JLhmzKRJi4Z/3XoHWYxMkC5zus=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIf5dFUVRghr1UBp2OA5hTpyvWgej4JhhD+pflynKX3ykeSC6+
	U0PHilMOZT1d2d3fXV+eOHkWynEloLhtV9d1CvDPH43YPU6AX+Gdh5WzdR88saON0GaWe66J7cn
	e0luMhsZxm59QqKCgLXBP1BtAYoCjsJMY2jWlBzi1OHvvqM5JStqfzEPv3AwKIa4IGI4=
X-Gm-Gg: ASbGncsk/QT36Zo06zPNOhv7N+0+8iAwGBNzxsAbfgI+i5WrzCTf9y/NKPfAKkY9/hl
	7U9Nm+LsFdDHow1091P5uHYQIc4SeKDrkVZGgxxYEdh8+bzc9NEps6P0wOChDKB8cIb4EmZQNeO
	mkz6HeW9BVtTc9fpgKgsQcrwPUZUYmzbO2c1qdN/XDMz7memM2CkfN4ScdMui5FTqN5vdcX3fah
	DDkwFOq3d9mgCeCZqPPwhABQvYZukp1oGXpODF5lazwvXgyDkOiAHA5CxVDQT2Shd3OEM2NqnYH
	ZOxDUY/sd0kkL0Pi47sYaoDHkYVM/XifrEGX2MD+KVD4Na1faHEItAwxWE9b/hBcmnAY9L2VJfX
	+lzhUdDh61GSafcS9Jzfv53D2LH9V2mQcThD5LXaLlyCO69H3Q9cn
X-Received: by 2002:a05:6214:5284:b0:721:7625:6774 with SMTP id 6a1803df08f44-72176256887mr135292486d6.43.1757032734152;
        Thu, 04 Sep 2025 17:38:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGd/mdUQO5LjKZ+0i7o36FLPM0QePyQdli/3eJe/UNzTN7MWLWoX13dNBKVLGie1h1y0MDqg==
X-Received: by 2002:a05:6214:5284:b0:721:7625:6774 with SMTP id 6a1803df08f44-72176256887mr135292086d6.43.1757032733634;
        Thu, 04 Sep 2025 17:38:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfd938sm1510059e87.109.2025.09.04.17.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 17:38:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 05 Sep 2025 03:38:34 +0300
Subject: [PATCH v2 05/12] drm/msm/disp: simplify tiled RGB{,A,X} formats
 definitions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-dpu-formats-v2-5-7a674028c048@oss.qualcomm.com>
References: <20250905-dpu-formats-v2-0-7a674028c048@oss.qualcomm.com>
In-Reply-To: <20250905-dpu-formats-v2-0-7a674028c048@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9223;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9Q5DBCw+1k2q8jQmkOcZzq3I92Gkam7S2gIJxMUuwQA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoujEJVK2wMShAjtYorSRjgTypvUqLRyv+c+ybr
 a6CUVljzBiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLoxCQAKCRCLPIo+Aiko
 1XKxB/9Rc+okPSHTJdQhhNaJOp2jdtSWTyt9th30Q4qhakFG6fKRJwYCu6663PtVE3xwGWhtez7
 IIoR4rSmkfUI1GdTnU/z1BwTlqmKgMqJ/SPNM7FVIzt7JkRyeSL8/x07dTxw98IeGKmhhtFHY0a
 kv+iRMEWGIQaylZAKyl83pUbznMRNQADI1m9FOf4lAS6xYau9fBAAV0rP/x0bHAdY0oM1ZvL44R
 1mZr0eY1E8ymOxqY5S5CB4mapeujvS0nsTrjQIXq2zGDljmxwvw8MR6W/mU5mE+gcTPPf+wEe/f
 cICytv/ZtR1SN72w/1gebwZqNiURQ3JtfZsHPlINz2WoC7KE
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: U5QRPEtTP5FjBkJwY3rSGOK8ceBnwnSg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX7z0Yt0FNlCW4
 +Unz1CoABr51XNtjIw0eZjAPlg+DeCmPKmcLjSqqAQ87Sc3ya82um8JkTqjtCPXehpQDppqzqcg
 6L3dY8XShdljd8Ju6kloTrf0ZIFZSo7+lXpBZPSOQLQOwWg+FfKBMcDjaAkNFN/aM4tXnL3aQ6K
 LPIp3A+kWCjTi1IJZmOwIwsxW1SKMKi9p58Fg0XrCaotra8Yn/5I0BtsOl2U8KWY8KLtr7mvowt
 QVFIyRi1Jx2G1MCne/svmwAAXm712tynsaFWbFCkq8HinqwmEk+3JediVHWGUbJpqtJxcw68WWV
 CQhSE+yq7x8PIQEOlav3mR3zudNQaSNwTvdYxBUDbZSUU1dPcYqBf8bMtUUs0hL6yUxeyQKdBe4
 YT0Khmm/
X-Proofpoint-ORIG-GUID: U5QRPEtTP5FjBkJwY3rSGOK8ceBnwnSg
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68ba311f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=bDeApkG1lX2_c04m800A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

Define several additional macros, capturing tiled RGB format classes, in
order to simplify defining particular RGB* format.

Reviewed-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp_format.c | 118 ++++++++++++++++++++++++----------
 1 file changed, 85 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
index 28cef986f2d662484afd47440a79393c48256ff5..d577b3d53fbebced63792b5c65f50dd45211c8ea 100644
--- a/drivers/gpu/drm/msm/disp/mdp_format.c
+++ b/drivers/gpu/drm/msm/disp/mdp_format.c
@@ -163,22 +163,83 @@ static struct csc_cfg csc_convert[CSC_MAX] = {
 	.tile_height = MDP_TILE_HEIGHT_DEFAULT                            \
 }
 
-#define INTERLEAVED_RGB_FMT_TILED(fmt, a, r, g, b, e0, e1, e2, e3, uc,    \
-alpha, bp, flg)                                               \
+#define INTERLEAVED_RGB_FMT_TILED(fmt, bp, r, g, b, e0, e1, e2)           \
 {                                                                         \
 	.pixel_format = DRM_FORMAT_ ## fmt,                               \
 	.fetch_type = MDP_PLANE_INTERLEAVED,                              \
-	.alpha_enable = alpha,                                            \
+	.alpha_enable = false,                                            \
+	.element = { (e0), (e1), (e2), 0 },                               \
+	.bpc_g_y = g,                                                     \
+	.bpc_b_cb = b,                                                    \
+	.bpc_r_cr = r,                                                    \
+	.bpc_a = 0,                                                       \
+	.chroma_sample = CHROMA_FULL,                                     \
+	.unpack_count = 3,                                                \
+	.bpp = bp,                                                        \
+	.fetch_mode = MDP_FETCH_UBWC,                                     \
+	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT |                           \
+		 MSM_FORMAT_FLAG_COMPRESSED,                              \
+	.num_planes = 2,                                                  \
+	.tile_height = MDP_TILE_HEIGHT_UBWC,                              \
+}
+
+#define INTERLEAVED_RGBA_FMT_TILED(fmt, bp, a, r, g, b, e0, e1, e2, e3)   \
+{                                                                         \
+	.pixel_format = DRM_FORMAT_ ## fmt,                               \
+	.fetch_type = MDP_PLANE_INTERLEAVED,                              \
+	.alpha_enable = true,                                             \
 	.element = { (e0), (e1), (e2), (e3) },                            \
 	.bpc_g_y = g,                                                     \
 	.bpc_b_cb = b,                                                    \
 	.bpc_r_cr = r,                                                    \
 	.bpc_a = a,                                                       \
 	.chroma_sample = CHROMA_FULL,                                     \
-	.unpack_count = uc,                                               \
+	.unpack_count = 4,                                                \
 	.bpp = bp,                                                        \
 	.fetch_mode = MDP_FETCH_UBWC,                                     \
-	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT | flg,                      \
+	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT |                           \
+		 MSM_FORMAT_FLAG_COMPRESSED,                              \
+	.num_planes = 2,                                                  \
+	.tile_height = MDP_TILE_HEIGHT_UBWC,                              \
+}
+
+#define INTERLEAVED_RGBX_FMT_TILED(fmt, bp, a, r, g, b, e0, e1, e2, e3)   \
+{                                                                         \
+	.pixel_format = DRM_FORMAT_ ## fmt,                               \
+	.fetch_type = MDP_PLANE_INTERLEAVED,                              \
+	.alpha_enable = false,                                            \
+	.element = { (e0), (e1), (e2), (e3) },                            \
+	.bpc_g_y = g,                                                     \
+	.bpc_b_cb = b,                                                    \
+	.bpc_r_cr = r,                                                    \
+	.bpc_a = a,                                                       \
+	.chroma_sample = CHROMA_FULL,                                     \
+	.unpack_count = 4,                                                \
+	.bpp = bp,                                                        \
+	.fetch_mode = MDP_FETCH_UBWC,                                     \
+	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT |                           \
+		 MSM_FORMAT_FLAG_COMPRESSED,                              \
+	.num_planes = 2,                                                  \
+	.tile_height = MDP_TILE_HEIGHT_UBWC,                              \
+}
+
+#define INTERLEAVED_RGBA_DX_FMT_TILED(fmt, bp, a, r, g, b, e0, e1, e2, e3) \
+{                                                                         \
+	.pixel_format = DRM_FORMAT_ ## fmt,                               \
+	.fetch_type = MDP_PLANE_INTERLEAVED,                              \
+	.alpha_enable = true,                                             \
+	.element = { (e0), (e1), (e2), (e3) },                            \
+	.bpc_g_y = g,                                                     \
+	.bpc_b_cb = b,                                                    \
+	.bpc_r_cr = r,                                                    \
+	.bpc_a = a,                                                       \
+	.chroma_sample = CHROMA_FULL,                                     \
+	.unpack_count = 4,                                                \
+	.bpp = bp,                                                        \
+	.fetch_mode = MDP_FETCH_UBWC,                                     \
+	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT |                           \
+		 MSM_FORMAT_FLAG_DX |                                     \
+		 MSM_FORMAT_FLAG_COMPRESSED,                              \
 	.num_planes = 2,                                                  \
 	.tile_height = MDP_TILE_HEIGHT_UBWC,                              \
 }
@@ -525,58 +586,49 @@ static const struct msm_format mdp_formats[] = {
  * the data will be passed by user-space.
  */
 static const struct msm_format mdp_formats_ubwc[] = {
-	INTERLEAVED_RGB_FMT_TILED(BGR565,
-		0, BPC5, BPC6, BPC5,
-		C2_R_Cr, C0_G_Y, C1_B_Cb, 0, 3,
-		false, 2, MSM_FORMAT_FLAG_COMPRESSED),
+	INTERLEAVED_RGB_FMT_TILED(BGR565, 2,
+		BPC5, BPC6, BPC5,
+		C2_R_Cr, C0_G_Y, C1_B_Cb),
 
-	INTERLEAVED_RGB_FMT_TILED(ABGR8888,
+	INTERLEAVED_RGBA_FMT_TILED(ABGR8888, 4,
 		BPC8A, BPC8, BPC8, BPC8,
-		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		true, 4, MSM_FORMAT_FLAG_COMPRESSED),
+		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
 
 	/* ARGB8888 and ABGR8888 purposely have the same color
 	 * ordering.  The hardware only supports ABGR8888 UBWC
 	 * natively.
 	 */
-	INTERLEAVED_RGB_FMT_TILED(ARGB8888,
+	INTERLEAVED_RGBA_FMT_TILED(ARGB8888, 4,
 		BPC8A, BPC8, BPC8, BPC8,
-		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		true, 4, MSM_FORMAT_FLAG_COMPRESSED),
+		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
 
-	INTERLEAVED_RGB_FMT_TILED(XBGR8888,
+	INTERLEAVED_RGBX_FMT_TILED(XBGR8888, 4,
 		BPC8A, BPC8, BPC8, BPC8,
-		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		false, 4, MSM_FORMAT_FLAG_COMPRESSED),
+		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
 
-	INTERLEAVED_RGB_FMT_TILED(XRGB8888,
+	INTERLEAVED_RGBX_FMT_TILED(XRGB8888, 4,
 		BPC8A, BPC8, BPC8, BPC8,
-		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		false, 4, MSM_FORMAT_FLAG_COMPRESSED),
+		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
 
-	INTERLEAVED_RGB_FMT_TILED(ABGR2101010,
+	INTERLEAVED_RGBA_DX_FMT_TILED(ABGR2101010, 4,
 		BPC8A, BPC8, BPC8, BPC8,
-		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		true, 4, MSM_FORMAT_FLAG_DX | MSM_FORMAT_FLAG_COMPRESSED),
+		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
 
-	INTERLEAVED_RGB_FMT_TILED(XBGR2101010,
+	INTERLEAVED_RGBA_DX_FMT_TILED(XBGR2101010, 4,
 		BPC8A, BPC8, BPC8, BPC8,
-		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		true, 4, MSM_FORMAT_FLAG_DX | MSM_FORMAT_FLAG_COMPRESSED),
+		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
 
-	INTERLEAVED_RGB_FMT_TILED(XRGB2101010,
+	INTERLEAVED_RGBA_DX_FMT_TILED(XRGB2101010, 4,
 		BPC8A, BPC8, BPC8, BPC8,
-		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		true, 4, MSM_FORMAT_FLAG_DX | MSM_FORMAT_FLAG_COMPRESSED),
+		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
 
 	/* XRGB2101010 and ARGB2101010 purposely have the same color
 	* ordering.  The hardware only supports ARGB2101010 UBWC
 	* natively.
 	*/
-	INTERLEAVED_RGB_FMT_TILED(ARGB2101010,
+	INTERLEAVED_RGBA_DX_FMT_TILED(ARGB2101010, 4,
 		BPC8A, BPC8, BPC8, BPC8,
-		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		true, 4, MSM_FORMAT_FLAG_DX | MSM_FORMAT_FLAG_COMPRESSED),
+		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA),
 
 	PSEUDO_YUV_FMT_TILED(NV12,
 		0, BPC8, BPC8, BPC8,

-- 
2.47.2


